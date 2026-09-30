import Core
import Foundation
import Observation
import SwiftUI

/// User settings that change how days and weeks are counted (Architecture 05 §4.2–4.3).
struct DaySettings: Codable, Hashable, Sendable {
    /// The hour the user's day ends, 0...12. Taps before this hour count for the previous day.
    var dayEndHour: Int = 0
    /// 1 = Sunday … 7 = Saturday, as in `Calendar.firstWeekday`.
    var weekStart: Int = Calendar.current.firstWeekday
}

/// Holds habits and entries and applies every change. Everything shown is calculated from
/// these records, never stored (Architecture 05 §3.3).
///
/// Every change is written to the database first and shown second, one at a time and in order,
/// so the screen never shows something that isn't saved. If a write ever fails, the store
/// reloads from the database and says so.
@Observable
final class HabitStore {
    @ObservationIgnored private let repository: HabitRepository
    @ObservationIgnored private var writeQueue: Task<Void, Never>?
    /// Tried once per launch, so a failing write can't loop through reloads.
    @ObservationIgnored private var triedPlacementUpgrade = false
    /// False until the first load finishes; the UI waits rather than flashing an empty screen.
    private(set) var isLoaded = false
    /// A failed open/read must never look like an empty installation to system delivery.
    private(set) var isStorageReady = false
    @ObservationIgnored private let databaseOpened: Bool
    /// Shown to the user when a write fails or the data can't be read.
    var problem: String?

    @ObservationIgnored private let suppliedCalendar: Calendar?
    init(repository: HabitRepository, calendar: Calendar? = nil, databaseOpened: Bool = true) {
        self.repository = repository
        suppliedCalendar = calendar
        self.databaseOpened = databaseOpened
    }

    private(set) var habits: [Habit] = []
    private(set) var entries: [Entry] = [] { didSet { entriesByHabit = nil; entriesByDay = nil } }
    /// `entries` grouped by habit, built on first use after a change. Every count, streak and "done" reads one
    /// habit's entries; scanning all of them for each day of a streak made scrolling Today stutter (30 Sep).
    @ObservationIgnored private var entriesByHabit: [UUID: [Entry]]?
    /// The same, by habit and day: the calendar asks about ~30 days × every habit on each month (30 Sep).
    @ObservationIgnored private var entriesByDay: [UUID: [LocalDay: [Entry]]]?
    var settings = DaySettings()
    /// Running timers for duration habits: habit ID → start time.
    private(set) var timers: [UUID: Date] = [:]
    /// For a timed habit spread over times of day: the part a running timer is for.
    private(set) var timerSlots: [UUID: String] = [:]
    /// Days a habit was skipped ("Skip today"). A skipped day is simply not one of its days: hidden on Today and
    /// neutral in the streak, the ring and every percentage (Feature Ledger C016: "a skipped day is not a missed day").
    private(set) var skips: [UUID: Set<LocalDay>] = [:]
    /// Pauses per habit, oldest first. A paused day is a skipped day, for a whole stretch (pause report, 29 Sep).
    private(set) var pauses: [UUID: [HabitPause]] = [:]
    /// Goal history: the rules a habit had before it was edited, oldest first. Each applies up to and including
    /// its `until` day, so past days keep the result they had (spec §8.2).
    private(set) var rules: [UUID: [HabitRule]] = [:]
    /// Notes (report "Habit Notes and Day Notes", 29 Sep): one per habit per day, one per day, and a standing
    /// description per habit. Optional, never prompted, and they never change progress.
    private(set) var habitNotes: [UUID: [LocalDay: String]] = [:]
    private(set) var dayNotes: [LocalDay: String] = [:]
    private(set) var descriptions: [UUID: String] = [:]
    /// The row just logged on Today: it offers "Add note" in place (Way of Life's inline note, notes UX report).
    /// Only one row at a time; nothing pops up by itself.
    var noteOffer: NoteOffer?
    struct NoteOffer: Equatable { let habit: UUID; let day: LocalDay }
    /// The note being written in the note bar: a habit's note (`habit` set) or the day's note (`habit` nil).
    var noteTarget: NoteTarget?
    struct NoteTarget: Equatable { let habit: UUID?; let day: LocalDay }
    /// Plus unlocks unlimited habits. Set from the store purchase (build-plan: billing, later).
    var isPlus = false
    static let freeHabitLimit = 5

    /// Tasks are always free; only active build and quit habits use a habit slot.
    var activeHabitCount: Int { habits.filter { !$0.archived && $0.kind != .task }.count }
    var canAddHabit: Bool { isPlus || activeHabitCount < Self.freeHabitLimit }

    /// A colour for a new habit: the first one no habit uses yet, so habits stay easy to tell apart.
    func suggestedColor() -> HabitColor {
        let used = Set(habits.filter { !$0.archived }.map(\.color))
        return [HabitColor.blue, .orange, .green, .purple, .red, .teal, .pink, .indigo, .yellow, .mint, .cyan, .brown]
            .first { !used.contains($0) } ?? .blue
    }

    /// Units already used, so a unit typed once is offered again.
    var usedUnits: [String] {
        var seen = Set<String>()
        return habits.compactMap { habit -> String? in
            if case .amount(let unit, _) = habit.kind { return unit }
            return habit.checkUnit
        }
            .filter { !$0.isEmpty && seen.insert($0).inserted }
    }

    var calendar: Calendar {
        var c = suppliedCalendar ?? Calendar.current
        c.firstWeekday = settings.weekStart
        return c
    }

    // MARK: Days

    /// The user's current day, honouring their day end.
    func today(now: Date = .now) -> LocalDay {
        let calendar = calendar
        let day = LocalDay(now, calendar: calendar)
        if settings.dayEndHour == 0 { return day }
        let boundary = ReminderClock.date(on: day, hour: settings.dayEndHour, minute: 0, calendar: calendar)!
        return now < boundary ? day.adding(days: -1, calendar: calendar) : day
    }

    /// One definition for the day bar and calendar. Count a multi-section habit only once.
    func daySummary(on day: LocalDay) -> (done: Int, total: Int) {
        let due = habits.filter {
            !$0.archived && $0.kind != .quit && startDay(of: $0) <= day && isDue($0, on: day)
                && (!$0.frequency.isFlexible || isDayMet($0, on: day))
        }
        return (due.filter { isDone($0, on: day) }.count, due.count)
    }

    // MARK: Day sections

    /// The user's day sections: Anytime first, then by start time.
    private(set) var sections: [DaySection] = DaySection.defaults

    func section(_ id: String) -> DaySection {
        sections.first { $0.id == id } ?? sections[0]
    }

    /// Timed sections in order, each with the minute it ends (the next one's start, or its own end).
    var timedSections: [(section: DaySection, end: Int)] {
        let timed = sections.filter { !$0.isAnytime }
        return timed.enumerated().map { i, s in
            (s, i + 1 < timed.count ? timed[i + 1].start! : (s.end ?? 24 * 60 + settings.dayEndHour * 60))
        }
    }

    /// The section that is "Now", if any.
    func nowSection(now: Date = .now) -> DaySection? {
        let c = calendar.dateComponents([.hour, .minute], from: now)
        let minute = dayMinute((c.hour ?? 0) * 60 + (c.minute ?? 0))
        return timedSections.first { ($0.section.start ?? 0) <= minute && minute < $0.end }?.section
    }

    /// A clock minute on the user's day: times before the day's end belong to the night before, so they
    /// come after midnight (1:00 AM with the day ending at 3 is 25:00).
    func dayMinute(_ minute: Int) -> Int {
        minute < settings.dayEndHour * 60 ? minute + 24 * 60 : minute
    }

    /// The section a time falls in: the timed section that contains it. Before the first section it
    /// counts as the first; after the last one's end, as the last. With no timed sections, Anytime.
    func section(forMinute minute: Int) -> DaySection {
        let timed = timedSections
        guard let first = timed.first, let last = timed.last else { return section(.anytime) }
        let m = dayMinute(minute)
        if m < first.section.start! { return first.section }
        return timed.first { $0.section.start! <= m && m < $0.end }?.section ?? last.section
    }

    /// Where a habit shows on Today: one entry per row. Its time of day decides (`parts`); reminders
    /// never move it ("Time of Day and Reminders — What Users Want"). `slot` is the section ID for a
    /// habit ticked once per time of day (Check it off on a set schedule, in two or more), else nil.
    struct Placement: Hashable {
        let section: String
        let slot: String?
        /// The reminder times that belong to this row, earliest first on the user's day.
        let times: [ReminderTime]
    }

    func placements(of habit: Habit) -> [Placement] {
        guard habit.kind != .quit else { return [] }
        let times = habit.reminders.sorted { dayMinute($0.minuteOfDay) < dayMinute($1.minuteOfDay) }
        var seen = Set<String>()
        let chosen = habit.parts.map { section($0).id }.filter { seen.insert($0).inserted }
        let order = sections.map(\.id)
        let parts = chosen.sorted { (order.firstIndex(of: $0) ?? 99) < (order.firstIndex(of: $1) ?? 99) }
        guard parts.count >= 2 else {
            return [Placement(section: chosen.first ?? .anytime, slot: nil, times: times)]
        }
        // Each reminder belongs to the tick of its own time of day; one outside them all, to the tick
        // before it (or the first), so it still stops once that tick is done.
        var byPart: [String: [ReminderTime]] = [:]
        let starts = parts.map { section($0).start.map(dayMinute) ?? 0 }
        for time in times {
            let own = section(forMinute: time.minuteOfDay).id
            let m = dayMinute(time.minuteOfDay)
            let home = parts.contains(own) ? own : (Array(zip(parts, starts)).last { $0.1 <= m }?.0 ?? parts[0])
            byPart[home, default: []].append(time)
        }
        // The time of day only says where it's displayed: the same row, with one shared progress, in each
        // chosen part. The goal is never split (the user's decision, 28 Sep).
        return parts.map { Placement(section: $0, slot: nil, times: byPart[$0] ?? []) }
    }

    /// Saves the whole list; habits in a removed time of day move to Anytime.
    func saveSections(_ list: [DaySection]) {
        let sorted = [list.first { $0.isAnytime } ?? DaySection.defaults[0]]
            + list.filter { !$0.isAnytime }.sorted { $0.start! < $1.start! }
        // Only the latest timed section keeps an end.
        var cleaned = sorted.enumerated().map { i, s -> DaySection in
            var s = s
            if i < sorted.count - 1 { s.end = nil }
            return s
        }
        if let last = cleaned.indices.last, !cleaned[last].isAnytime, cleaned[last].end == nil { cleaned[last].end = 24 * 60 }
        let removed = Set(sections.map(\.id)).subtracting(cleaned.map(\.id))
        perform { [self] in
            let json = String(decoding: try JSONEncoder().encode(cleaned), as: UTF8.self)
            try await repository.saveSetting(key: Keys.sections, value: json)
            for i in habits.indices where !removed.isDisjoint(with: habits[i].parts) {
                let kept = habits[i].parts.filter { !removed.contains($0) }
                habits[i].parts = kept.isEmpty ? [.anytime] : kept
                try await repository.saveHabit(habit: habits[i].record(position: i), steps: habits[i].stepRecords(),
                                               reminders: habits[i].reminderRecords(), at: Date.now.millis)
            }
            withAnimation { sections = cleaned }
        }
    }

    enum PeriodKind { case week, month, year }

    /// The week, month or year that contains `day`, honouring the user's week start.
    func period(_ kind: PeriodKind, containing day: LocalDay) -> ClosedRange<LocalDay> {
        let component: Calendar.Component = switch kind {
        case .week: .weekOfYear
        case .month: .month
        case .year: .year
        }
        let interval = calendar.dateInterval(of: component, for: day.date(calendar: calendar))!
        let first = LocalDay(interval.start, calendar: calendar)
        let last = LocalDay(interval.end.addingTimeInterval(-1), calendar: calendar)
        return first...last
    }

    private func periodRange(_ habit: Habit, containing day: LocalDay) -> ClosedRange<LocalDay>? {
        switch habit.frequency {
        case .flexible(let kind, _):
            switch kind { case .week: period(.week, containing: day); case .month: period(.month, containing: day); case .year: period(.year, containing: day); case .day: day...day }
        case .perWeek: period(.week, containing: day)
        case .perMonth: period(.month, containing: day)
        case .perYear: period(.year, containing: day)
        default: nil
        }
    }

    // MARK: Calculations

    /// The times of day a habit is ticked in separately: two or more, for Check it off on a set
    /// schedule. Empty for everything else (one row, one progress).
    func slots(of habit: Habit) -> [String] {
        placements(of: habit).compactMap(\.slot)
    }

    /// Amounts, minutes and limits on a week or month rule: a total for the whole period.
    private func isTotal(_ habit: Habit) -> Bool {
        switch habit.kind {
        case .amount, .duration: !habit.frequency.isDayBased
        default: false
        }
    }

    private func periodTotal(_ habit: Habit, in range: ClosedRange<LocalDay>, now: Date = .now) -> Double {
        var total = entries(of: habit.id).lazy.filter { $0.stepID == nil && range.contains($0.day) }.reduce(0) { $0 + $1.value }
        if let start = timers[habit.id], range.contains(today(now: now)) {
            total += max(0, now.timeIntervalSince(start)) / 60
        }
        return total
    }

    /// One habit's entries, in the order they were logged. Still reads `entries`, so views redraw when it changes.
    private func entries(of id: UUID) -> [Entry] {
        guard let index = entriesByHabit else {
            let index = Dictionary(grouping: entries, by: \.habitID)
            entriesByHabit = index
            return index[id] ?? []
        }
        access(keyPath: \.entries)
        return index[id] ?? []
    }

    /// One habit's entries on one day, in the order they were logged.
    private func entries(of id: UUID, on day: LocalDay) -> [Entry] {
        guard let index = entriesByDay else {
            let index = Dictionary(grouping: entries, by: \.habitID).mapValues { Dictionary(grouping: $0, by: \.day) }
            entriesByDay = index
            return index[id]?[day] ?? []
        }
        access(keyPath: \.entries)
        return index[id]?[day] ?? []
    }

    func isSkipped(_ habit: Habit, on day: LocalDay) -> Bool { skips[habit.id]?.contains(day) == true }

    /// Skip today can be offered for habits whose days are counted one by one; a weekly or monthly total, or a
    /// limit, has no "day" to set aside.
    func canSkip(_ habit: Habit) -> Bool {
        guard !habit.atMost, habit.kind != .quit else { return false }
        switch habit.frequency {
        case .perWeek, .perMonth, .perYear: return false
        default: return true
        }
    }

    /// Skips (or un-skips) the habit on `day`. Saved like any other change.
    func setSkipped(_ habit: Habit, on day: LocalDay, _ skipped: Bool) {
        perform { [self] in
            var days = skips[habit.id] ?? []
            if skipped { days.insert(day) } else { days.remove(day) }
            try await repository.saveSetting(key: Keys.skipPrefix + habit.id.uuidString,
                                             value: days.map(\.key).sorted().joined(separator: ","))
            withAnimation { skips[habit.id] = days.isEmpty ? nil : days }
        }
    }

    // MARK: Pause

    /// Whether the habit is paused on `day`. Paused days aren't its days: off Today, no reminders, neutral in the
    /// streak and every count.
    func isPaused(_ habit: Habit, on day: LocalDay) -> Bool {
        pauses[habit.id]?.contains { $0.contains(day) } == true
    }

    /// The pause covering `day`, or the next one still to come after it (a trip booked ahead).
    func pause(of habit: Habit, on day: LocalDay) -> HabitPause? {
        let list = pauses[habit.id] ?? []
        return list.first { $0.contains(day) } ?? list.filter { $0.from > day }.min { $0.from < $1.from }
    }

    /// One-time tasks are rescheduled instead; everything else can be paused.
    func canPause(_ habit: Habit) -> Bool { !(habit.kind == .task && habit.dueDay != nil) && !habit.archived }

    /// Pauses the habit from `from` through `through` (nil: until turned back on). A quit habit pauses now: its
    /// current run ends and is kept. Any pause still to come is replaced.
    func pause(_ habit: Habit, from: LocalDay, through: LocalDay?, now: Date = .now) {
        let today = today(now: now)
        let from = habit.kind == .quit ? today : from
        var list = (pauses[habit.id] ?? []).filter { $0.from <= today }
        // A pause already running is closed the day before the new one starts.
        for i in list.indices where list[i].through.map({ $0 >= from }) ?? true {
            list[i].through = from.adding(days: -1, calendar: calendar)
        }
        list.removeAll { p in habit.kind != .quit && p.through.map { $0 < p.from } == true }
        list.append(HabitPause(from: from, through: through, pausedAt: now))
        savePauses(list, of: habit)
    }

    /// Turns the habit back on today: a pause running now ends yesterday, one still to come is dropped. Nothing is
    /// asked about the paused days. A quit habit starts a new run now.
    func resume(_ habit: Habit, now: Date = .now) {
        let today = today(now: now)
        var list = pauses[habit.id] ?? []
        list.removeAll { $0.from > today }
        for i in list.indices where list[i].contains(today) {
            list[i].through = today.adding(days: -1, calendar: calendar)
            list[i].resumedAt = now
        }
        // A pause that began and ended today leaves nothing behind, except a quit habit's run boundary.
        list.removeAll { p in habit.kind != .quit && p.through.map { $0 < p.from } == true }
        savePauses(list, of: habit)
    }

    private func savePauses(_ list: [HabitPause], of habit: Habit) {
        perform { [self] in
            let json = String(decoding: try JSONEncoder().encode(list), as: UTF8.self)
            try await repository.saveSetting(key: Keys.pausePrefix + habit.id.uuidString, value: json)
            withAnimation { pauses[habit.id] = list.isEmpty ? nil : list }
        }
    }

    /// When a pause gave the habit back: by hand, or at the start of the day after its last day.
    private func resumeMoment(_ p: HabitPause) -> Date? {
        if let at = p.resumedAt { return at }
        guard let last = p.through else { return nil }
        return dayStart(last.adding(days: 1, calendar: calendar))
    }

    /// The moment a day begins, honouring the user's day end.
    private func dayStart(_ day: LocalDay) -> Date {
        ReminderClock.date(on: day, hour: settings.dayEndHour, minute: 0, calendar: calendar)!
    }

    /// The first day a habit counts: its start date (past or future), or the day it was made.
    func startDay(of habit: Habit) -> LocalDay {
        habit.startsOn ?? LocalDay(habit.createdAt, calendar: calendar)
    }

    /// Whether the habit belongs on `day`. Days that aren't due are hidden on Today and never break a streak.
    /// Unfinished one-time tasks move forward to today. Nothing is due before the start or after the end date.
    func isDue(_ habit: Habit, on day: LocalDay, now: Date = .now) -> Bool {
        if isSkipped(habit, on: day) || isPaused(habit, on: day) { return false }
        let habit = rule(habit, on: day)
        let created = startDay(of: habit)
        if let end = habit.endsOn, day > end, habit.kind != .quit { return false }
        switch habit.kind {
        case .quit: return false
        case .task:
            // A task with no date repeats on its schedule, like a habit.
            guard let due = habit.dueDay else { break }
            if day == due { return true }
            return due < day && day == today(now: now) && !isDone(habit, on: day)
        default: break
        }
        guard day >= created else { return false }
        switch habit.frequency {
        case .calendar(let rule):
            return rule.matches(day, start: created, calendar: calendar)
        case .afterCompletion(let n, let unit):
            // Read actual completion dates, including late completions; no fabricated history.
            let completions = entries(of: habit.id).filter { $0.day <= day }.map(\.day)
            if completions.contains(day) { return true }
            let next: LocalDay
            if let last = completions.max() {
                next = LocalDay(calendar.date(byAdding: unit.component, value: n, to: last.date(calendar: calendar))!, calendar: calendar)
            } else { next = created }
            return day >= next
        case .daily, .perWeek, .perMonth, .perYear, .flexible:
            return true
        case .weekdays(let days):
            return days.contains(calendar.component(.weekday, from: day.date(calendar: calendar)))
        case .everyNDays(let n):
            let gap = calendar.dateComponents([.day], from: created.date(calendar: calendar), to: day.date(calendar: calendar)).day ?? 0
            return n <= 1 || gap % n == 0
        case .everyNWeeks(let n):
            let gap = calendar.dateComponents([.day], from: created.date(calendar: calendar), to: day.date(calendar: calendar)).day ?? 0
            return gap % (7 * max(n, 1)) == 0
        case .monthDates(let dates):
            let date = day.date(calendar: calendar)
            let last = calendar.range(of: .day, in: .month, for: date)?.count ?? 31
            return dates.contains(day.day) || (day.day == last && dates.contains { $0 > last })
        }
    }

    /// The day's goal: times, amount, minutes, or the number of checklist items.
    func dayGoal(of habit: Habit) -> Double {
        switch habit.kind {
        case .checklist: Double(max(habit.steps.count, 1))
        case .task: 1
        case .check where !slots(of: habit).isEmpty: Double(slots(of: habit).count)
        default: habit.goal
        }
    }

    /// What was logged on one day (a checklist counts its ticked items).
    func dayProgress(of habit: Habit, on day: LocalDay, now: Date = .now) -> Double {
        let habit = rule(habit, on: day)
        if habit.kind == .checklist {
            let ticked = Set(entries(of: habit.id, on: day).compactMap(\.stepID))
            return Double(habit.steps.filter { ticked.contains($0.id) }.count)
        }
        if habit.kind == .task {
            // A one-time task is done once; a repeating one each day it's due.
            if habit.dueDay == nil { return !entries(of: habit.id, on: day).isEmpty ? 1 : 0 }
            return !entries(of: habit.id).isEmpty ? 1 : 0
        }
        let slots = slots(of: habit)
        if habit.kind == .check && !slots.isEmpty {
            // One per section ticked, plus older ticks without a section, capped at the number of rows.
            // Ticks aren't matched to today's sections, so a section edit that re-files a time can
            // never turn a finished day unfinished.
            let today = entries(of: habit.id, on: day).filter { $0.stepID == nil }
            let ticked = Set(today.compactMap(\.slot)).count
            let loose = today.filter { $0.slot == nil }.reduce(0) { $0 + $1.value }
            return min(Double(slots.count), Double(ticked) + loose)
        }
        var total = entries(of: habit.id, on: day).lazy.filter { $0.stepID == nil }.reduce(0) { $0 + $1.value }
        if let start = timers[habit.id], day == today(now: now) {
            total += max(0, now.timeIntervalSince(start)) / 60
        }
        return total
    }

    func isDayMet(_ habit: Habit, on day: LocalDay) -> Bool {
        let habit = rule(habit, on: day)
        let p = dayProgress(of: habit, on: day)
        return habit.atMost ? p <= dayGoal(of: habit) : p >= dayGoal(of: habit)
    }

    /// Completions in the week or month: ticks for "Do it", met days for everything else.
    private func periodCount(_ habit: Habit, in range: ClosedRange<LocalDay>) -> Double {
        if habit.kind == .check, !habit.frequency.isFlexible {
            return entries(of: habit.id).lazy.filter { $0.stepID == nil && range.contains($0.day) }.reduce(0) { $0 + $1.value }
        }
        var count = 0.0
        var day = range.lowerBound
        while day <= range.upperBound {
            if day >= startDay(of: habit), day <= (habit.endsOn ?? range.upperBound), isDayMet(habit, on: day) { count += 1 }
            day = day.adding(days: 1, calendar: calendar)
        }
        return count
    }

    /// Shown on the card: daily quantities (including flexible schedules) or aggregate quantities.
    /// Flexible quota progress is shown separately so 15/30 min and 2/4 days cannot be confused.
    func progress(of habit: Habit, on day: LocalDay, now: Date = .now) -> Double {
        let habit = rule(habit, on: day)
        if !habit.frequency.isFlexible, let range = periodRange(habit, containing: day) {
            return isTotal(habit) ? periodTotal(habit, in: range, now: now) : periodCount(habit, in: range)
        }
        return dayProgress(of: habit, on: day, now: now)
    }

    func goal(of habit: Habit) -> Double {
        if isTotal(habit) { return habit.goal }
        return switch habit.frequency {
        case .perWeek(let n), .perMonth(let n), .perYear(let n): Double(n)
        default: dayGoal(of: habit)
        }
    }

    func isDone(_ habit: Habit, on day: LocalDay) -> Bool {
        let habit = rule(habit, on: day)
        switch habit.kind {
        case .quit: return false
        case .task: return dayProgress(of: habit, on: day) >= 1
        default: break
        }
        if !habit.frequency.isFlexible, let range = periodRange(habit, containing: day) {
            guard isTotal(habit) else { return periodCount(habit, in: range) >= goal(of: habit) }
            let total = periodTotal(habit, in: range)
            return habit.atMost ? total <= habit.goal : total >= habit.goal
        }
        return isDayMet(habit, on: day)
    }

    func flexibleProgress(_ habit: Habit, on day: LocalDay) -> Int? {
        let habit = rule(habit, on: day)
        guard habit.frequency.isFlexible, let range = periodRange(habit, containing: day) else { return nil }
        return Int(periodCount(habit, in: range))
    }

    /// The daily action can remain available after a flexible quota is met; reminders and the
    /// section's remaining count must not imply that extra days are required.
    func isSatisfied(_ habit: Habit, on day: LocalDay) -> Bool {
        isDone(habit, on: day) || (habit.frequency.isFlexible && isPeriodMet(habit, on: day))
    }

    func isPeriodMet(_ habit: Habit, on day: LocalDay) -> Bool {
        let habit = rule(habit, on: day)
        if case .flexible(_, let needed) = habit.frequency {
            return (flexibleProgress(habit, on: day) ?? 0) >= needed
        }
        return isDone(habit, on: day)
    }

    /// A habit ticked per section (round 4 data): whether this section's tick is done.
    func isSlotDone(_ habit: Habit, slot: String, on day: LocalDay) -> Bool {
        entries(of: habit.id, on: day).contains { $0.slot == slot }
    }

    func isStepDone(_ step: Step, of habit: Habit, on day: LocalDay) -> Bool {
        entries(of: habit.id, on: day).contains { $0.stepID == step.id }
    }

    /// Consecutive due days (or weeks, or months) with the goal met, up to `day`. The current one
    /// only counts once met, so an unfinished today never breaks the streak.
    func streak(of habit: Habit, asOf day: LocalDay) -> Int {
        guard habit.kind != .quit, habit.kind != .task else { return 0 }
        let habit = rule(habit, on: day)
        let created = startDay(of: habit)
        // A change to the kind of period (day, week, month, year) starts the streak again (spec §8.3).
        let kind = periodKind(habit)
        func samePeriodKind(_ cursor: LocalDay) -> Bool { periodKind(rule(habit, on: cursor)) == kind }
        if let current = periodRange(habit, containing: day) {
            var count = isPeriodMet(habit, on: day) ? 1 : 0
            var cursor = current.lowerBound.adding(days: -1, calendar: calendar)
            // A week or month with a paused day can't break the streak; it still counts if it was met.
            while cursor >= created, samePeriodKind(cursor), let range = periodRange(habit, containing: cursor) {
                if isPeriodMet(habit, on: cursor) { count += 1 } else if !hasPause(habit, in: range) { break }
                cursor = range.lowerBound.adding(days: -1, calendar: calendar)
            }
            return count
        }
        var count = isDone(habit, on: day) ? 1 : 0
        var cursor = day.adding(days: -1, calendar: calendar)
        while cursor >= created, samePeriodKind(cursor) {
            if isDue(habit, on: cursor) {
                guard isDayMet(habit, on: cursor) else { break }
                count += 1
            }
            cursor = cursor.adding(days: -1, calendar: calendar)
        }
        return count
    }

    private func hasPause(_ habit: Habit, in range: ClosedRange<LocalDay>) -> Bool {
        pauses[habit.id]?.contains { p in p.from <= range.upperBound && (p.through.map { $0 >= range.lowerBound } ?? true) && (p.through.map { $0 >= p.from } ?? true) } == true
    }

    /// Quit habits: the current run and the best run, from the slip history. A pause ends the run it interrupts
    /// (kept as a run, not a slip), and turning it back on starts a new one. While paused, there's no current run.
    func quitRuns(of habit: Habit, now: Date = .now) -> (current: TimeInterval, best: TimeInterval) {
        let start = habit.quitSince ?? habit.createdAt
        var slips = entries(of: habit.id).map(\.createdAt)
        if start > habit.createdAt && !slips.contains(start) { slips.append(start) }
        // Each boundary ends the run going on (if any) and may start the next.
        var edges: [(at: Date, starts: Bool)] = slips.map { ($0, true) }
        var pausedNow = false
        for p in pauses[habit.id] ?? [] where p.pausedAt <= now {
            edges.append((p.pausedAt, false))
            if let back = resumeMoment(p), back <= now { edges.append((back, true)) } else { pausedNow = true }
        }
        edges.sort { $0.at < $1.at }
        let origin = min(habit.createdAt, start)
        var runStart: Date? = origin
        var best: TimeInterval = 0
        for edge in edges where edge.at > origin {
            if let s = runStart { best = max(best, edge.at.timeIntervalSince(s)) }
            runStart = edge.starts ? edge.at : nil
        }
        guard !pausedNow, let runStart else { return (0, best) }
        let current = max(0, now.timeIntervalSince(max(start, runStart)))
        return (current, max(best, current))
    }

    // MARK: Loading

    /// Reads everything from the database. Rows this version can't read are skipped, never deleted.
    func load() async {
        do {
            let snapshot = try await repository.load()
            let steps = Dictionary(grouping: snapshot.steps, by: \.habitId)
            let reminders = Dictionary(grouping: snapshot.reminders, by: \.habitId)
            habits = snapshot.habits.compactMap { Habit(record: $0, steps: steps[$0.id] ?? [], reminders: reminders[$0.id] ?? []) }
            entries = snapshot.entries.compactMap(Entry.init(record:))
            var loaded = DaySettings()
            var running: [UUID: Date] = [:]
            var runningSlots: [UUID: String] = [:]
            var loadedSkips: [UUID: Set<LocalDay>] = [:]
            var loadedPauses: [UUID: [HabitPause]] = [:]
            var loadedRules: [UUID: [HabitRule]] = [:]
            var loadedHabitNotes: [UUID: [LocalDay: String]] = [:]
            var loadedDayNotes: [LocalDay: String] = [:]
            var loadedDescriptions: [UUID: String] = [:]
            sections = DaySection.defaults
            var upgradedV1 = false, repaired = false
            for setting in snapshot.settings {
                switch setting.key {
                case Keys.placementV1: upgradedV1 = true
                case Keys.placementV2: repaired = true
                case Keys.dayEndHour: loaded.dayEndHour = Int(setting.value) ?? 0
                case Keys.weekStart: loaded.weekStart = Int(setting.value) ?? loaded.weekStart
                case Keys.sections:
                    if let list = try? JSONDecoder().decode([DaySection].self, from: Data(setting.value.utf8)), !list.isEmpty {
                        sections = list
                    }
                default:
                    if setting.key.hasPrefix(Keys.notePrefix) {
                        let parts = setting.key.dropFirst(Keys.notePrefix.count).split(separator: "|")
                        if parts.count == 2, let id = UUID(uuidString: String(parts[0])), let day = LocalDay(key: String(parts[1])) {
                            if !setting.value.isEmpty { loadedHabitNotes[id, default: [:]][day] = setting.value }
                        }
                        continue
                    }
                    if setting.key.hasPrefix(Keys.dayNotePrefix), let day = LocalDay(key: String(setting.key.dropFirst(Keys.dayNotePrefix.count))) {
                        if !setting.value.isEmpty { loadedDayNotes[day] = setting.value }
                        continue
                    }
                    if setting.key.hasPrefix(Keys.descriptionPrefix), let id = UUID(uuidString: String(setting.key.dropFirst(Keys.descriptionPrefix.count))) {
                        loadedDescriptions[id] = setting.value
                        continue
                    }
                    if setting.key.hasPrefix(Keys.rulesPrefix),
                       let id = UUID(uuidString: String(setting.key.dropFirst(Keys.rulesPrefix.count))),
                       let list = try? JSONDecoder().decode([HabitRule].self, from: Data(setting.value.utf8)) {
                        loadedRules[id] = list.sorted { $0.until < $1.until }
                        continue
                    }
                    if setting.key.hasPrefix(Keys.pausePrefix),
                       let id = UUID(uuidString: String(setting.key.dropFirst(Keys.pausePrefix.count))),
                       let list = try? JSONDecoder().decode([HabitPause].self, from: Data(setting.value.utf8)) {
                        if !list.isEmpty { loadedPauses[id] = list }
                        continue
                    }
                    if setting.key.hasPrefix(Keys.skipPrefix),
                       let id = UUID(uuidString: String(setting.key.dropFirst(Keys.skipPrefix.count))) {
                        let days = Set(setting.value.split(separator: ",").compactMap { LocalDay(key: String($0)) })
                        if !days.isEmpty { loadedSkips[id] = days }
                        continue
                    }
                    let value = setting.value.split(separator: "|", maxSplits: 1).map(String.init)
                    if setting.key.hasPrefix(Keys.timerPrefix),
                       let id = UUID(uuidString: String(setting.key.dropFirst(Keys.timerPrefix.count))),
                       let ms = Int64(value.first ?? "") {
                        running[id] = Date(millis: ms)
                        if value.count > 1 { runningSlots[id] = value[1] }
                    }
                }
            }
            settings = loaded
            settings.dayEndHour = min(max(settings.dayEndHour, 0), 12)
            settings.weekStart = min(max(settings.weekStart, 1), 7)
            timers = running
            timerSlots = runningSlots
            skips = loadedSkips
            pauses = loadedPauses
            rules = loadedRules
            habitNotes = loadedHabitNotes
            dayNotes = loadedDayNotes
            descriptions = loadedDescriptions
            isStorageReady = databaseOpened
            isLoaded = true
            if upgradedV1 && !repaired && !triedPlacementUpgrade { triedPlacementUpgrade = true; repairPlacement() }
            onChange?()
        } catch {
            isStorageReady = false
            problem = "Your habits couldn't be read. Nothing has been changed; please restart the app."
        }
    }

    private enum Keys {
        static let dayEndHour = "day_end_hour"
        static let weekStart = "week_start"
        static let timerPrefix = "timer."
        static let skipPrefix = "skip."
        static let pausePrefix = "pause."
        static let rulesPrefix = "rules."
        static let notePrefix = "note."
        static let dayNotePrefix = "daynote."
        static let descriptionPrefix = "desc."
        static let sections = "day_sections"
        static let placementV1 = "placement_v1"
        static let placementV2 = "placement_v2"
    }

    /// Once: development builds briefly let times place habits, and turned a habit in several times
    /// of day into one with a silent time in each. Put those back in their times of day.
    private func repairPlacement() {
        perform { [self] in
            for i in habits.indices where !habits[i].remind && habits[i].reminders.count >= 2 && habits[i].parts.count == 1 {
                var seen = Set<String>()
                let parts = habits[i].reminders.map { section(forMinute: $0.minuteOfDay).id }.filter { seen.insert($0).inserted }
                guard parts.count >= 2 else { continue }
                var habit = habits[i]
                habit.parts = parts
                habit.reminders = []
                habit.remind = true
                try await repository.saveHabit(habit: habit.record(position: i), steps: habit.stepRecords(),
                                               reminders: habit.reminderRecords(), at: Date.now.millis)
                habits[i] = habit
            }
            try await repository.saveSetting(key: Keys.placementV2, value: "1")
        }
    }

    // MARK: Changes

    // MARK: Backup and restore

    struct RestoreSummary: Sendable {
        var habits: Int
        var entries: Int
        var settings: Int
        var changed: Bool { habits + entries + settings > 0 }
    }

    enum BackupError: LocalizedError, Equatable {
        case invalid, newerVersion, pendingSave, unreadable, reloadFailed
        var errorDescription: String? {
            switch self {
            case .invalid: "Choose a Habits backup file. Your current data has not been changed."
            case .newerVersion: "This backup was made by a newer version of Habits. Update the app before restoring it."
            case .pendingSave: "Some changes could not be saved. Resolve the save error before making or restoring a backup."
            case .unreadable: "The backup could not be read. Your current data has not been changed."
            case .reloadFailed: "The backup was added, but the app couldn’t reload your data. Restart the app before continuing."
            }
        }
    }

    func backupFile(now: Date = .now) async throws -> URL {
        await flush()
        guard problem == nil, isStorageReady else { throw BackupError.pendingSave }
        let directory = FileManager.default.temporaryDirectory.appendingPathComponent("Habits-\(UUID().uuidString)")
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        let url = directory.appendingPathComponent("Habits Backup \(today(now: now).key).db")
        do {
            try await dataOperation { [self] in try await repository.snapshot(path: url.path) }
        } catch {
            try? FileManager.default.removeItem(at: directory)
            throw error
        }
        return url
    }

    func restore(from file: URL) async throws -> RestoreSummary {
        await flush()
        guard problem == nil, isStorageReady else { throw BackupError.pendingSave }
        let scoped = file.startAccessingSecurityScopedResource()
        defer { if scoped { file.stopAccessingSecurityScopedResource() } }
        let copy = FileManager.default.temporaryDirectory.appendingPathComponent("habits-restore-\(UUID().uuidString).db")
        try FileManager.default.copyItem(at: file, to: copy)
        defer {
            for suffix in ["", "-wal", "-shm"] { try? FileManager.default.removeItem(atPath: copy.path + suffix) }
        }
        // Inspect the original SQLite header before Room can create or migrate anything.
        let handle = try FileHandle(forReadingFrom: copy)
        let bytes = try handle.read(upToCount: 100) ?? Data()
        try handle.close()
        guard bytes.count == 100, bytes.prefix(16) == Data("SQLite format 3\0".utf8) else { throw BackupError.invalid }
        let version = bytes[60..<64].reduce(UInt32(0)) { ($0 << 8) | UInt32($1) }
        guard version > 0 else { throw BackupError.invalid }
        guard version <= UInt32(HabitRepository.companion.SCHEMA_VERSION) else { throw BackupError.newerVersion }
        let source = try HabitRepository.companion.open(path: copy.path)
        let snapshot: Snapshot
        do {
            snapshot = try await source.loadForRestore()
            guard try await source.pragma(name: "quick_check") == "ok" else { throw BackupError.unreadable }
            try Self.validateBackup(snapshot)
        } catch {
            try? source.close()
            throw BackupError.unreadable
        }
        try? source.close()
        return try await dataOperation { [self] in
            let before = try await repository.load()
            try await repository.mergeAll(snapshot: snapshot)
            let after = try await repository.load()
            await load()
            guard problem == nil else { throw BackupError.reloadFailed }
            let habitIDs = Set(before.habits.map(\.id)), entryIDs = Set(before.entries.map(\.id))
            let keys = Set(before.settings.map(\.key))
            return RestoreSummary(habits: after.habits.filter { !habitIDs.contains($0.id) }.count,
                                  entries: after.entries.filter { !entryIDs.contains($0.id) }.count,
                                  settings: after.settings.filter { !keys.contains($0.key) }.count)
        }
    }

    /// Backups and restores share the same queue as taps and notification actions.
    private func dataOperation<Value: Sendable>(_ operation: @escaping @MainActor () async throws -> Value) async throws -> Value {
        let previous = writeQueue
        let task = Task { @MainActor in
            await previous?.value
            guard self.problem == nil, self.isStorageReady else { throw BackupError.pendingSave }
            return try await operation()
        }
        writeQueue = Task { @MainActor in _ = try? await task.value }
        return try await task.value
    }

    private static func validateBackup(_ snapshot: Snapshot) throws {
        func validDay(_ key: String?) -> Bool { key.map { LocalDay(key: $0) != nil } ?? true }
        let ids = Set(snapshot.habits.map(\.id))
        guard snapshot.habits.allSatisfy({ r in
            UUID(uuidString: r.id) != nil && r.goal.isFinite && (0...GoalNumber.maximum).contains(r.goal) && r.increment.isFinite && (0...GoalNumber.maximum).contains(r.increment)
                && validDay(r.startsOn) && validDay(r.endsOn) && validDay(r.dueDay)
                && (r.deletedAt != nil || Habit(record: r, steps: [], reminders: []) != nil)
        }), snapshot.entries.allSatisfy({ r in
            UUID(uuidString: r.id) != nil && ids.contains(r.habitId) && validDay(r.day) && r.value.isFinite && (0...GoalNumber.maximum).contains(r.value)
        }), snapshot.steps.allSatisfy({ UUID(uuidString: $0.id) != nil && ids.contains($0.habitId) }),
        snapshot.reminders.allSatisfy({ UUID(uuidString: $0.id) != nil && ids.contains($0.habitId) && (0...23).contains(Int($0.hour)) && (0...59).contains(Int($0.minute)) })
        else { throw BackupError.invalid }
    }

    /// Called after every change, so reminders stay in step with the data.
    var onChange: (() -> Void)?

    /// Runs changes one at a time, in the order they were made. Each one decides what to do
    /// from the state left by the previous one, writes to the database, and only then updates memory.
    private func perform(_ change: @escaping @MainActor () async throws -> Void) {
        let previous = writeQueue
        writeQueue = Task { @MainActor in
            await previous?.value
            #if DEBUG
            // Exercise navigation against deliberately slow storage without touching the user's database.
            if ProcessInfo.processInfo.arguments.contains("-uitest"),
               ProcessInfo.processInfo.arguments.contains("-focus-slow-writes"), TimerPresence.playerOpen {
                try? await Task.sleep(for: .seconds(2))
            }
            #endif
            guard self.isStorageReady else {
                self.problem = "Your data couldn't be opened. Nothing has been changed; please restart the app."
                return
            }
            do {
                try await change()
                onChange?()
            } catch {
                problem = "That change couldn't be saved, so it was undone. Please try again."
                await load()
            }
        }
    }

    /// Waits for every pending change to reach the database.
    func flush() async { await writeQueue?.value }

    func add(_ habit: Habit) {
        perform { [self] in
            try await repository.saveHabit(habit: habit.record(position: habits.count), steps: habit.stepRecords(),
                                           reminders: habit.reminderRecords(), at: Date.now.millis)
            withAnimation { habits.append(habit) }
        }
    }

    // MARK: All Habits: archive, restore, delete, reorder

    /// Stops habits for good but keeps all their history (Feature Ledger C016: people delete only because there's no
    /// archive, and lose everything). An archived habit frees its free slot (C219). A running timer is saved first.
    func archive(_ list: [Habit]) {
        for habit in list where timers[habit.id] != nil { stopTimer(habit, on: today()) }
        perform { [self] in
            for habit in list {
                guard let i = habits.firstIndex(where: { $0.id == habit.id }) else { continue }
                var h = habits[i]
                h.archived = true
                try await repository.saveHabit(habit: h.record(position: i), steps: h.stepRecords(),
                                               reminders: h.reminderRecords(), at: Date.now.millis)
                withAnimation { habits[i] = h }
            }
        }
    }

    /// Brings an archived habit back, if there's a free slot (or Plus). False when the free limit is reached.
    @discardableResult
    func restore(_ habit: Habit) -> Bool {
        guard habit.kind == .task || canAddHabit else { return false }
        perform { [self] in
            guard let i = habits.firstIndex(where: { $0.id == habit.id }) else { return }
            var h = habits[i]
            h.archived = false
            try await repository.saveHabit(habit: h.record(position: i), steps: h.stepRecords(),
                                           reminders: h.reminderRecords(), at: Date.now.millis)
            withAnimation { habits[i] = h }
        }
        return true
    }

    /// Deletes habits and their history. The row is kept as a tombstone (never hard-deleted, so a later sync can't
    /// bring it back); nothing of it shows again.
    func delete(_ list: [Habit]) {
        for habit in list where timers[habit.id] != nil { stopTimer(habit, on: today()) }
        perform { [self] in
            for habit in list {
                guard let i = habits.firstIndex(where: { $0.id == habit.id }) else { continue }
                try await repository.saveHabit(habit: habits[i].record(position: i, deleted: true), steps: [],
                                               reminders: [], at: Date.now.millis)
                withAnimation {
                    habits.remove(at: i)
                    if noteOffer?.habit == habit.id { noteOffer = nil }
                    if noteTarget?.habit == habit.id { noteTarget = nil }
                }
            }
        }
    }

    /// Puts `ids` (one group in All Habits) in this order, keeping every other habit where it is. Today follows it.
    func reorder(_ ids: [UUID]) {
        perform { [self] in
            let slots = habits.indices.filter { ids.contains(habits[$0].id) }
            var next = habits
            for (slot, id) in zip(slots, ids) { if let h = habits.first(where: { $0.id == id }) { next[slot] = h } }
            for i in next.indices where next[i].id != habits[i].id {
                try await repository.saveHabit(habit: next[i].record(position: i), steps: next[i].stepRecords(),
                                               reminders: next[i].reminderRecords(), at: Date.now.millis)
            }
            withAnimation { habits = next }
        }
    }

    // MARK: A habit's own page

    /// How one day reads in a habit's calendar. Never a harsh mark for a miss (C095): a missed day is just the number.
    enum DayMark { case done, some, missed, open, skipped, paused, notItsDay, upcoming, before }

    func dayMark(_ habit: Habit, on day: LocalDay) -> DayMark {
        let today = today()
        if day < startDay(of: habit) { return .before }
        if isPaused(habit, on: day) { return .paused }
        if isSkipped(habit, on: day) { return .skipped }
        if day > today { return isDue(habit, on: day) ? .upcoming : .notItsDay }
        let rule = rule(habit, on: day)
        // A week or month goal has no failed day: a day with something logged shows it, others are neutral.
        if !rule.frequency.isDayBased || rule.frequency.isFlexible {
            if dayProgress(of: rule, on: day) > 0 { return isDayMet(rule, on: day) || !rule.frequency.isFlexible ? .done : .some }
            return isDue(habit, on: day) ? .open : .notItsDay
        }
        guard isDue(habit, on: day) else { return .notItsDay }
        if isDayMet(rule, on: day) { return .done }
        if dayProgress(of: rule, on: day) > 0 { return .some }
        return day == today ? .open : .missed
    }

    /// The longest streak so far, counted the same way as `streak`: paused, skipped and other days are neutral.
    func bestStreak(of habit: Habit) -> Int {
        guard habit.kind != .quit, habit.kind != .task else { return 0 }
        let today = today()
        var best = 0, run = 0
        var day = startDay(of: habit)
        if periodRange(habit, containing: today) != nil {
            while day <= today {
                // Days from before an edit to a weekly goal are stepped over one by one.
                guard let range = periodRange(rule(habit, on: day), containing: day) else {
                    day = day.adding(days: 1, calendar: calendar); continue
                }
                if isPeriodMet(habit, on: day) { run += 1; best = max(best, run) }
                else if range.upperBound < today && !hasPause(habit, in: range) { run = 0 }
                day = range.upperBound.adding(days: 1, calendar: calendar)
            }
            return best
        }
        while day <= today {
            if isDue(habit, on: day) {
                if isDayMet(habit, on: day) { run += 1; best = max(best, run) } else if day < today { run = 0 }
            }
            day = day.adding(days: 1, calendar: calendar)
        }
        return best
    }

    // MARK: Notes

    func note(of habit: Habit, on day: LocalDay) -> String? { habitNotes[habit.id]?[day] }
    /// Every note on a habit, newest first.
    func notes(of habit: Habit) -> [(day: LocalDay, text: String)] {
        (habitNotes[habit.id] ?? [:]).map { (day: $0.key, text: $0.value) }.sorted { $0.day > $1.day }
    }
    func dayNote(on day: LocalDay) -> String? { dayNotes[day] }
    /// Any note on that day, a habit's or the day's own: the calendar marks it.
    func hasNotes(on day: LocalDay) -> Bool {
        dayNotes[day] != nil || habitNotes.values.contains { $0[day] != nil }
    }
    func description(of habit: Habit) -> String? { descriptions[habit.id] }

    /// Empty text removes the note.
    func setNote(_ text: String, of habit: Habit, on day: LocalDay) {
        let text = TextLimit.clean(text, TextLimit.noteText)
        let key = Keys.notePrefix + habit.id.uuidString + "|" + day.key
        perform { [self] in
            // Keep an empty value so restoring an older backup cannot resurrect this removed note.
            try await repository.saveSetting(key: key, value: text)
            habitNotes[habit.id, default: [:]][day] = text.isEmpty ? nil : text
        }
    }

    func setDayNote(_ text: String, on day: LocalDay) {
        let text = TextLimit.clean(text, TextLimit.noteText)
        let key = Keys.dayNotePrefix + day.key
        perform { [self] in
            try await repository.saveSetting(key: key, value: text)
            dayNotes[day] = text.isEmpty ? nil : text
        }
    }

    func setDescription(_ text: String, of id: UUID) {
        let text = TextLimit.clean(text, TextLimit.descriptionText)
        guard text != (descriptions[id] ?? "") else { return }
        let key = Keys.descriptionPrefix + id.uuidString
        perform { [self] in
            try await repository.saveSetting(key: key, value: text)
            descriptions[id] = text.isEmpty ? nil : text
        }
    }

    // MARK: Editing (spec §8)

    /// Saves an edited habit. Changes apply from today: if what judges a day changed (goal, how often, unit,
    /// checklist steps), the rule it had is kept for every day before today, so past days keep their result.
    /// Editing twice in a day keeps the rule from before today.
    func update(_ habit: Habit) {
        perform { [self] in
            guard let i = habits.firstIndex(where: { $0.id == habit.id }) else { return }
            let old = habits[i]
            let yesterday = today().adding(days: -1, calendar: calendar)
            var list = rules[habit.id] ?? []
            if HabitRule(old, until: yesterday).judgesDifferently(from: habit), startDay(of: old) <= yesterday,
               list.last.map({ $0.until < yesterday }) ?? true {
                list.append(HabitRule(old, until: yesterday))
            }
            try await repository.saveHabit(habit: habit.record(position: i), steps: habit.stepRecords(),
                                           reminders: habit.reminderRecords(), at: Date.now.millis)
            if list != (rules[habit.id] ?? []) {
                let json = String(decoding: try JSONEncoder().encode(list), as: UTF8.self)
                try await repository.saveSetting(key: Keys.rulesPrefix + habit.id.uuidString, value: json)
                rules[habit.id] = list
            }
            habits[i] = habit
        }
    }

    /// What editing would do to the streak, for the line under the edit form (spec §8.4).
    func editRestartsStreak(_ old: Habit, _ new: Habit) -> Bool {
        periodKind(old) != periodKind(new) && streak(of: old, asOf: today()) > 0
    }

    /// The habit as it was on `day`: the goal, how often, unit and steps in force then.
    func rule(_ habit: Habit, on day: LocalDay) -> Habit {
        guard let list = rules[habit.id], let rule = list.first(where: { day <= $0.until }) else { return habit }
        var habit = habit
        rule.apply(to: &habit)
        return habit
    }

    /// The kind of period a habit is judged in: each day, or a week, month or year.
    func periodKind(_ habit: Habit) -> GoalPeriod {
        switch habit.frequency {
        case .perWeek: .week
        case .perMonth: .month
        case .perYear: .year
        case .flexible(let period, _): period
        default: .day
        }
    }

    /// Yes/no habits: log once, or undo the last log for this period.
    func toggleCheck(_ habit: Habit, on day: LocalDay) {
        if habit.kind == .task { return toggleTask(habit, on: day) }
        perform { [self] in
            if isDone(habit, on: day) { try await undoLast(habit, on: day) } else { try await log(habit, value: 1, on: day) }
        }
    }

    /// Tasks: done or not. A one-time task wherever it's shown; a repeating one on that day.
    private func toggleTask(_ habit: Habit, on day: LocalDay) {
        perform { [self] in
            if let i = entries.lastIndex(where: { $0.habitID == habit.id && (habit.dueDay != nil || $0.day == day) }) {
                try await repository.removeEntry(id: entries[i].id.uuidString, at: Date.now.millis)
                withAnimation { _ = entries.remove(at: i) }
            } else {
                try await log(habit, value: 1, on: day)
            }
        }
    }

    /// Quick counts always add; undo is a separate, explicit action.
    func increment(_ habit: Habit, on day: LocalDay) {
        guard let value = habit.quickIncrement else { return }
        addProgress(habit, value: value, on: day)
    }

    func addProgress(_ habit: Habit, value: Double, on day: LocalDay) {
        guard value.isFinite, value > 0, value <= GoalNumber.maximum, day <= today() else { return }
        perform { [self] in
            try await log(habit, value: value, on: day)
        }
    }

    func undoProgress(_ habit: Habit, on day: LocalDay) {
        perform { [self] in try await undoLast(habit, on: day) }
    }

    /// Player feedback undoes the exact tap, even if another surface logged since then.
    func undoEntry(_ id: UUID) {
        perform { [self] in
            guard let i = entries.firstIndex(where: { $0.id == id }) else { return }
            try await repository.removeEntry(id: id.uuidString, at: Date.now.millis)
            withAnimation { _ = entries.remove(at: i) }
        }
    }

    /// Delivered alerts are usable only for their current configuration and today or the previous logical day.
    /// An old alert must not reschedule a task, log a paused item or revive anything deleted.
    func canActOnReminder(_ target: ReminderTarget, now: Date = .now) -> Bool {
        guard problem == nil, isStorageReady, isLoaded, let habit = habits.first(where: { $0.id == target.habit }),
              !habit.archived, habit.remind, habit.kind != .quit,
              target.day <= today(now: now), target.day >= today(now: now).adding(days: -1, calendar: calendar),
              isDue(habit, on: target.day, now: now),
              let time = target.time, habit.reminders.contains(where: { $0.id == time }),
              placements(of: habit).contains(where: { $0.slot == target.slot && $0.times.contains { $0.id == time } }),
              target.signature.map({ $0 == ReminderIdentity.signature(habit) }) ?? true else { return false }
        if habit.atMost { return true }
        return target.slot.map { !isSlotDone(habit, slot: $0, on: target.day) } ?? !isSatisfied(habit, on: target.day)
    }

    /// A system action is an event. Its ID is saved before it appears in memory; replay checks
    /// include tombstones, so duplicate callbacks and retrying after undo are both harmless.
    func logFromReminder(_ habit: Habit, slot: String?, on day: LocalDay, time: UUID? = nil,
                         signature: String? = nil, eventID: UUID? = nil, now: Date = .now) {
        perform { [self] in
            let target = ReminderTarget(habit: habit.id, time: time, day: day, slot: slot, section: nil, signature: signature)
            guard canActOnReminder(target, now: now), let habit = habits.first(where: { $0.id == habit.id }) else { return }
            let id = eventID ?? UUID()
            let exists = try await repository.hasEntry(id: id.uuidString)
            guard !exists.boolValue else { return }
            let value: Double
            switch habit.kind {
            case .amount:
                guard let increment = habit.quickIncrement, increment.isFinite, increment > 0, increment <= GoalNumber.maximum else { return }
                value = increment
            case .check, .task: value = 1
            default: return
            }
            let entry = Entry(id: id, habitID: habit.id, day: day, value: value, createdAt: now, slot: slot)
            try await repository.addEntry(entry: entry.record)
            withAnimation { entries.append(entry) }
        }
    }

    /// A habit in several sections: tick or untick only this section's row.
    func toggleSlot(_ habit: Habit, slot: String, on day: LocalDay) {
        perform { [self] in
            if let i = entries.lastIndex(where: { $0.habitID == habit.id && $0.slot == slot && $0.day == day }) {
                try await repository.removeEntry(id: entries[i].id.uuidString, at: Date.now.millis)
                withAnimation { _ = entries.remove(at: i) }
            } else {
                let entry = Entry(habitID: habit.id, day: day, value: 1, slot: slot)
                try await repository.addEntry(entry: entry.record)
                withAnimation { entries.append(entry) }
            }
        }
    }

    func toggleStep(_ step: Step, of habit: Habit, on day: LocalDay) {
        perform { [self] in
            if let i = entries.lastIndex(where: { $0.habitID == habit.id && $0.stepID == step.id && $0.day == day }) {
                try await repository.removeEntry(id: entries[i].id.uuidString, at: Date.now.millis)
                withAnimation { _ = entries.remove(at: i) }
            } else {
                let entry = Entry(habitID: habit.id, stepID: step.id, day: day, value: 1)
                try await repository.addEntry(entry: entry.record)
                withAnimation { entries.append(entry) }
            }
        }
    }

    /// Duration habits: start the timer, or stop it and log the minutes. A running timer is saved
    /// (with the part of the day it's for), so it survives the app being closed.
    func toggleTimer(_ habit: Habit, slot: String? = nil) {
        let now = Date.now
        if timers[habit.id] != nil {
            stopTimer(habit, on: today(now: now), through: now)
            return
        }
        // The screen changes at once and the save follows in order (writes are queued). Waiting for the save
        // first made quick Pause/Resume taps land on the old state and get lost (found by hand 29 Sep). If the
        // save fails, `perform` reloads what's really stored.
        timers[habit.id] = now
        timerSlots[habit.id] = slot
        let key = Keys.timerPrefix + habit.id.uuidString
        let value = String(now.millis) + (slot.map { "|" + $0 } ?? "")
        perform { [self] in try await repository.saveSetting(key: key, value: value) }
    }

    /// An explicit stop is idempotent: navigating/closing cannot accidentally start a timer.
    /// A focus session supplies its tracking day, including when the day rolls over.
    func stopTimer(_ habit: Habit, on day: LocalDay, through end: Date = .now) {
        guard let start = timers[habit.id] else { return }
        let minutes = max(0, end.timeIntervalSince(start)) / 60
        let entry = minutes >= 1 / 60
            ? Entry(habitID: habit.id, day: day, value: minutes, slot: timerSlots[habit.id]) : nil
        // Same as starting: the time shows as saved at once; the database write follows in order.
        if let entry { entries.append(entry) }
        timers.removeValue(forKey: habit.id)
        timerSlots.removeValue(forKey: habit.id)
        let key = Keys.timerPrefix + habit.id.uuidString
        perform { [self] in try await repository.finishTimer(entry: entry?.record, key: key) }
    }

    private func log(_ habit: Habit, value: Double, on day: LocalDay) async throws {
        let entry = Entry(habitID: habit.id, day: day, value: value)
        try await repository.addEntry(entry: entry.record)
        withAnimation { entries.append(entry) }
    }

    private func undoLast(_ habit: Habit, on day: LocalDay) async throws {
        // Undo the latest log on this day; for week and month rules, the latest one in the period.
        let range = habit.frequency.isFlexible ? (day...day) : (periodRange(habit, containing: day) ?? (day...day))
        guard let i = entries.lastIndex(where: { $0.habitID == habit.id && $0.stepID == nil && range.contains($0.day) }) else { return }
        try await repository.removeEntry(id: entries[i].id.uuidString, at: Date.now.millis)
        withAnimation { _ = entries.remove(at: i) }
    }

    // MARK: Demo data

    #if DEBUG
    /// Debug builds only: saves the habits from the design, with some history for streaks,
    /// into an empty database.
    func seedDemo(now: Date = .now) async {
        guard habits.isEmpty else { return }
        buildDemo(now: now)
        let snapshot = Snapshot(
            habits: habits.enumerated().map { $1.record(position: $0) },
            steps: habits.flatMap { $0.stepRecords() },
            reminders: habits.flatMap { $0.reminderRecords() },
            entries: entries.map(\.record),
            settings: [])
        do { try await repository.importAll(snapshot: snapshot) } catch { problem = "Demo data couldn't be saved." }
        await load()
        if ProcessInfo.processInfo.arguments.contains("-longtext") {
            // Every section name at its limit, to test layouts.
            let long = ["Before breakfast", "Lunch break walk", "Once kids sleep"] // 16, 16, 15: at the limit
            saveSections(sections.map { section in
                var section = section
                if let i = [String.morning, .afternoon, .evening].firstIndex(of: section.id) { section.name = TextLimit.clean(long[i], TextLimit.section) }
                return section
            })
        }
    }

    /// Debug builds only, once per database: one habit of every kind in Anytime, so the routine player can be
    /// tried with each (the user, 29 Sep). Anytime already has a weekly check (Call family), a count with +1
    /// (Water) and a timer (Read).
    func addEveryTypeToAnytime() async {
        let key = "test_types_anytime_v1"
        guard isLoaded, let snapshot = try? await repository.load(),
              !snapshot.settings.contains(where: { $0.key == key }) else { return }
        let types = [
            Habit(name: "Take vitamins", symbol: "pills.fill", color: .yellow, kind: .check, remind: false),
            Habit(name: "Drink tea", symbol: "cup.and.saucer.fill", color: .brown, kind: .check, goal: 3, checkUnit: "cups", remind: false),
            Habit(name: "Read pages", symbol: "book.pages.fill", color: .indigo, kind: .amount(unit: "pages", increment: 0), goal: 20, remind: false),
            Habit(name: "Push-ups", symbol: "figure.strengthtraining.traditional", color: .red, kind: .amount(unit: "push-ups", increment: 10), goal: 50, remind: false),
            Habit(name: "Practice guitar", symbol: "guitars.fill", color: .orange, kind: .duration, goal: 15, remind: false),
            Habit(name: "Tidy desk", symbol: "sparkles", color: .teal, kind: .checklist,
                  steps: [Step(name: "Clear papers"), Step(name: "Wipe the surface"), Step(name: "Put pens away")], remind: false),
            Habit(name: "Coffee", symbol: "mug.fill", color: .brown, kind: .amount(unit: "cups", increment: 1), goal: 2, atMost: true, remind: false),
            Habit(name: "Social media", symbol: "iphone", color: .pink, kind: .duration, goal: 30, atMost: true, remind: false),
            Habit(name: "Pay the phone bill", symbol: "creditcard.fill", color: .green, kind: .task, dueDay: today(), remind: false),
            Habit(name: "Run", symbol: "figure.run", color: .blue, kind: .amount(unit: "km", increment: 0), goal: 15, frequency: .perWeek(1), remind: false),
            Habit(name: "Yoga", symbol: "figure.yoga", color: .purple, kind: .duration, goal: 20, frequency: .flexible(.week, 3), remind: false),
        ]
        for habit in types { add(habit) }
        perform { [self] in try await repository.saveSetting(key: key, value: "1") }
        await flush()
    }

    private func buildDemo(now: Date) {
        let today = today(now: now)
        let cal = calendar
        func ago(days: Int) -> Date { cal.date(byAdding: .day, value: -days, to: now)! }

        let smoking = Habit(name: "Smoking", symbol: "nosign", color: .gray, kind: .quit,
                            quitSince: now.addingTimeInterval(-(12 * 86400 + 11 * 3600 + 23 * 60)), createdAt: ago(days: 60))
        let alcohol = Habit(name: "Alcohol", symbol: "wineglass", color: .gray, kind: .quit,
                            quitSince: now.addingTimeInterval(-(47 * 86400 + 2 * 3600 + 2 * 60)), createdAt: ago(days: 60))
        let read = Habit(name: "Read", symbol: "book.fill", color: .orange, kind: .duration, goal: 20, createdAt: ago(days: 30))
        let call = Habit(name: "Call family", symbol: "phone.fill", color: .green, kind: .check, frequency: .perWeek(3), createdAt: ago(days: 40))
        let water = Habit(name: "Water", symbol: "drop.fill", color: .blue, kind: .amount(unit: "glasses", increment: 1), goal: 8, createdAt: ago(days: 40))
        let stretch = Habit(name: "Stretch", symbol: "figure.flexibility", color: .teal, kind: .duration, parts: [.morning], goal: 10, createdAt: ago(days: 20))
        let skincare = Habit(name: "Skincare", symbol: "sparkles", color: .purple, kind: .checklist, parts: [.morning],
                             steps: [Step(name: "Cleanser"), Step(name: "Serum"), Step(name: "Moisturiser"), Step(name: "Sunscreen")], createdAt: ago(days: 20))
        let teeth = Habit(name: "Brush teeth", symbol: "mouth.fill", color: .mint, kind: .duration, parts: [.morning], goal: 2, createdAt: ago(days: 100))
        let meds = Habit(name: "Meds", symbol: "pills.fill", color: .red, kind: .check, parts: [.morning], createdAt: ago(days: 70))
        let walk = Habit(name: "Walk", symbol: "figure.walk", color: .green, kind: .amount(unit: "steps", increment: 1000), parts: [.afternoon], goal: 8000, createdAt: ago(days: 20))
        let lunch = Habit(name: "Lunch, no phone", symbol: "fork.knife", color: .orange, kind: .check, parts: [.afternoon], createdAt: ago(days: 5))
        let floss = Habit(name: "Floss", symbol: "mouth", color: .cyan, kind: .check, parts: [.evening], createdAt: ago(days: 40))
        let plan = Habit(name: "Plan tomorrow", symbol: "checklist", color: .indigo, kind: .check, parts: [.evening], createdAt: ago(days: 20))
        let meds2 = Habit(name: "Meds 14:00", symbol: "pills.fill", color: .red, kind: .check, parts: [.afternoon], createdAt: ago(days: 70))
        let noScreens = Habit(name: "No screens", symbol: "iphone.slash", color: .pink, kind: .check, parts: [.evening], createdAt: ago(days: 10))
        let meditate = Habit(name: "Meditate", symbol: "figure.mind.and.body", color: .purple, kind: .duration, parts: [.evening], goal: 10, createdAt: ago(days: 30))
        let bed = Habit(name: "Bed by 23:00", symbol: "bed.double.fill", color: .indigo, kind: .check, parts: [.evening], createdAt: ago(days: 10))
        habits = [smoking, alcohol, read, call, water, stretch, skincare, teeth, meds, walk, lunch, meds2, floss, plan, noScreens, meditate, bed]
        if ProcessInfo.processInfo.arguments.contains("-perf-tasks") {
            for i in 0..<200 {
                habits.append(Habit(name: i == 0 ? "Pay the phone bill" : "Task \(i)", symbol: "checkmark", color: .blue, kind: .task, dueDay: today.adding(days: 14), remind: false, createdAt: ago(days: 365)))
            }
        }
        if ProcessInfo.processInfo.arguments.contains("-perf-reminders") {
            for i in 0..<100 {
                habits.append(Habit(name: "Reminder \(i)", symbol: "bell", color: .blue, kind: .task, frequency: .daily,
                                    reminders: [ReminderTime(hour: 8 + i / 60, minute: i % 60)], remind: true, createdAt: ago(days: 365)))
            }
        }
        if ProcessInfo.processInfo.arguments.contains("-longtext") {
            // Names, units and parts at their limits, to test layouts.
            for i in habits.indices {
                switch habits[i].id {
                case water.id:
                    habits[i].name = TextLimit.clean("Drink a big glass of warm water with lemon", TextLimit.name)
                    habits[i].kind = .amount(unit: TextLimit.clean("tablespoons", TextLimit.unit), increment: 1)
                case skincare.id:
                    habits[i].name = TextLimit.clean("Morning skincare routine with SPF", TextLimit.name)
                    habits[i].steps[0].name = TextLimit.clean("Double cleanse, oil then gel", TextLimit.checklistPart)
                case smoking.id: habits[i].name = TextLimit.clean("Smoking, social ones too", TextLimit.name)
                case lunch.id: habits[i].name = TextLimit.clean("Lunch away from the desk", TextLimit.name)
                case floss.id: habits[i].name = "Floss"
                default: break
                }
            }
        }

        // History: each daily habit met on the previous `streak` days.
        let history: [(Habit, Int)] = [(read, 6), (water, 22), (stretch, 4), (teeth, 90), (meds, 58), (walk, 13), (lunch, 2), (floss, 30), (plan, 11), (bed, 5), (meds2, 58), (noScreens, 3), (meditate, 21)]
        for (h, streak) in history {
            for d in 1...min(streak, 120) {
                entries.append(Entry(habitID: h.id, day: today.adding(days: -d, calendar: cal), value: h.goal))
            }
        }
        for d in 1...12 {
            for s in skincare.steps { entries.append(Entry(habitID: skincare.id, stepID: s.id, day: today.adding(days: -d, calendar: cal), value: 1)) }
        }
        for w in 1...4 {
            for i in 0..<3 { entries.append(Entry(habitID: call.id, day: today.adding(days: -7 * w + i, calendar: cal), value: 1)) }
        }
        // Smoking: a 45-day best run, a slip 15 days ago, and the current run since 12 days ago.
        entries.append(Entry(habitID: smoking.id, day: today, value: 1, createdAt: ago(days: 15)))
        entries.append(Entry(habitID: alcohol.id, day: today, value: 1, createdAt: ago(days: 60 - 13)))

        // Today, as in the afternoon design.
        entries.append(Entry(habitID: read.id, day: today, value: 12))
        for _ in 0..<8 { entries.append(Entry(habitID: water.id, day: today, value: 1)) }
        entries.append(Entry(habitID: stretch.id, day: today, value: 10))
        entries.append(Entry(habitID: teeth.id, day: today, value: 2))
        for s in skincare.steps { entries.append(Entry(habitID: skincare.id, stepID: s.id, day: today, value: 1)) }
        entries.append(Entry(habitID: meds.id, day: today, value: 1))
        entries.append(Entry(habitID: walk.id, day: today, value: 5200))
        entries.append(Entry(habitID: meds2.id, day: today, value: 1))
        let weekStart = period(.week, containing: today).lowerBound
        // Call family: 2 of 3 this week.
        let second = weekStart.adding(days: 1, calendar: cal)
        entries.append(Entry(habitID: call.id, day: weekStart, value: 1))
        entries.append(Entry(habitID: call.id, day: second <= today ? second : weekStart, value: 1))

        if ProcessInfo.processInfo.arguments.contains("-perf-history") {
            // Speed tests: a year of history on every daily habit, missed about one day in nine, so streaks and
            // counts are measured on the data of someone who has used the app for a year (30 Sep).
            let logged = Set(entries.map { $0.habitID.uuidString + $0.day.key })
            for i in habits.indices where habits[i].kind != .quit && habits[i].frequency.isDayBased {
                habits[i].createdAt = ago(days: 400)
                let h = habits[i]
                for d in 1...365 where d % 9 != 0 {
                    let day = today.adding(days: -d, calendar: cal)
                    if logged.contains(h.id.uuidString + day.key) { continue }
                    if h.kind == .checklist {
                        for s in h.steps { entries.append(Entry(habitID: h.id, stepID: s.id, day: day, value: 1)) }
                    } else {
                        entries.append(Entry(habitID: h.id, day: day, value: h.goal))
                    }
                }
            }
        }
    }
    #endif
}
