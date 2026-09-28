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
    /// Shown to the user when a write fails or the data can't be read.
    var problem: String?

    init(repository: HabitRepository) {
        self.repository = repository
    }

    private(set) var habits: [Habit] = []
    private(set) var entries: [Entry] = []
    var settings = DaySettings()
    /// Running timers for duration habits: habit ID → start time.
    private(set) var timers: [UUID: Date] = [:]
    /// For a timed habit spread over times of day: the part a running timer is for.
    private(set) var timerSlots: [UUID: String] = [:]
    /// Plus unlocks unlimited habits. Set from the store purchase (build-plan: billing, later).
    var isPlus = false
    static let freeHabitLimit = 5

    /// Habits that count toward the free limit: everything not archived, quit habits included.
    var activeHabitCount: Int { habits.filter { !$0.archived }.count }
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
        var c = Calendar.current
        c.firstWeekday = settings.weekStart
        return c
    }

    // MARK: Days

    /// The user's current day, honouring their day end.
    func today(now: Date = .now) -> LocalDay {
        LocalDay(now.addingTimeInterval(-Double(settings.dayEndHour) * 3600), calendar: calendar)
    }

    /// One definition for the day bar and calendar. Count a multi-section habit only once.
    func daySummary(on day: LocalDay) -> (done: Int, total: Int) {
        let due = habits.filter {
            !$0.archived && $0.kind != .quit && startDay(of: $0) <= day && isDue($0, on: day)
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
        var total = entries.lazy.filter { $0.habitID == habit.id && $0.stepID == nil && range.contains($0.day) }.reduce(0) { $0 + $1.value }
        if let start = timers[habit.id], range.contains(today(now: now)) {
            total += max(0, now.timeIntervalSince(start)) / 60
        }
        return total
    }

    /// The first day a habit counts: its start date (past or future), or the day it was made.
    func startDay(of habit: Habit) -> LocalDay {
        habit.startsOn ?? LocalDay(habit.createdAt, calendar: calendar)
    }

    /// Whether the habit belongs on `day`. Days that aren't due are hidden on Today and never break a streak.
    /// Unfinished one-time tasks move forward to today. Nothing is due before the start or after the end date.
    func isDue(_ habit: Habit, on day: LocalDay, now: Date = .now) -> Bool {
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
        case .daily, .perWeek, .perMonth, .perYear:
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
        if habit.kind == .checklist {
            let ticked = Set(entries.lazy.filter { $0.habitID == habit.id && $0.day == day }.compactMap(\.stepID))
            return Double(habit.steps.filter { ticked.contains($0.id) }.count)
        }
        if habit.kind == .task {
            // A one-time task is done once; a repeating one each day it's due.
            if habit.dueDay == nil { return entries.contains { $0.habitID == habit.id && $0.day == day } ? 1 : 0 }
            return entries.contains { $0.habitID == habit.id } ? 1 : 0
        }
        let slots = slots(of: habit)
        if habit.kind == .check && !slots.isEmpty {
            // One per section ticked, plus older ticks without a section, capped at the number of rows.
            // Ticks aren't matched to today's sections, so a section edit that re-files a time can
            // never turn a finished day unfinished.
            let today = entries.filter { $0.habitID == habit.id && $0.stepID == nil && $0.day == day }
            let ticked = Set(today.compactMap(\.slot)).count
            let loose = today.filter { $0.slot == nil }.reduce(0) { $0 + $1.value }
            return min(Double(slots.count), Double(ticked) + loose)
        }
        var total = entries.lazy.filter { $0.habitID == habit.id && $0.stepID == nil && $0.day == day }.reduce(0) { $0 + $1.value }
        if let start = timers[habit.id], day == today(now: now) {
            total += max(0, now.timeIntervalSince(start)) / 60
        }
        return total
    }

    func isDayMet(_ habit: Habit, on day: LocalDay) -> Bool {
        let p = dayProgress(of: habit, on: day)
        return habit.atMost ? p <= dayGoal(of: habit) : p >= dayGoal(of: habit)
    }

    /// Completions in the week or month: ticks for "Do it", met days for everything else.
    private func periodCount(_ habit: Habit, in range: ClosedRange<LocalDay>) -> Double {
        if habit.kind == .check {
            return entries.lazy.filter { $0.habitID == habit.id && $0.stepID == nil && range.contains($0.day) }.reduce(0) { $0 + $1.value }
        }
        var count = 0.0
        var day = range.lowerBound
        while day <= range.upperBound {
            if isDayMet(habit, on: day) { count += 1 }
            day = day.adding(days: 1, calendar: calendar)
        }
        return count
    }

    /// Shown on the card: today's amount for day rules, completions so far for week and month rules.
    func progress(of habit: Habit, on day: LocalDay, now: Date = .now) -> Double {
        if let range = periodRange(habit, containing: day) {
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
        switch habit.kind {
        case .quit: return false
        case .task: return dayProgress(of: habit, on: day) >= 1
        default: break
        }
        if let range = periodRange(habit, containing: day) {
            guard isTotal(habit) else { return periodCount(habit, in: range) >= goal(of: habit) }
            let total = periodTotal(habit, in: range)
            return habit.atMost ? total <= habit.goal : total >= habit.goal
        }
        return isDayMet(habit, on: day)
    }

    /// A habit ticked per section (round 4 data): whether this section's tick is done.
    func isSlotDone(_ habit: Habit, slot: String, on day: LocalDay) -> Bool {
        entries.contains { $0.habitID == habit.id && $0.slot == slot && $0.day == day }
    }

    func isStepDone(_ step: Step, of habit: Habit, on day: LocalDay) -> Bool {
        entries.contains { $0.habitID == habit.id && $0.stepID == step.id && $0.day == day }
    }

    /// Consecutive due days (or weeks, or months) with the goal met, up to `day`. The current one
    /// only counts once met, so an unfinished today never breaks the streak.
    func streak(of habit: Habit, asOf day: LocalDay) -> Int {
        guard habit.kind != .quit, habit.kind != .task else { return 0 }
        let created = startDay(of: habit)
        if let current = periodRange(habit, containing: day) {
            var count = isDone(habit, on: day) ? 1 : 0
            var cursor = current.lowerBound.adding(days: -1, calendar: calendar)
            while cursor >= created, let range = periodRange(habit, containing: cursor), isDone(habit, on: cursor) {
                count += 1
                cursor = range.lowerBound.adding(days: -1, calendar: calendar)
            }
            return count
        }
        var count = isDone(habit, on: day) ? 1 : 0
        var cursor = day.adding(days: -1, calendar: calendar)
        while cursor >= created {
            if isDue(habit, on: cursor) {
                guard isDayMet(habit, on: cursor) else { break }
                count += 1
            }
            cursor = cursor.adding(days: -1, calendar: calendar)
        }
        return count
    }

    /// Quit habits: the current run and the best run, from the slip history.
    func quitRuns(of habit: Habit, now: Date = .now) -> (current: TimeInterval, best: TimeInterval) {
        let start = habit.quitSince ?? habit.createdAt
        let slips = entries.filter { $0.habitID == habit.id }.map(\.createdAt).sorted()
        var marks = [habit.createdAt] + slips.filter { $0 > habit.createdAt }
        if start > marks.last! { marks.append(start) }
        var best: TimeInterval = 0
        for (a, b) in zip(marks, marks.dropFirst()) { best = max(best, b.timeIntervalSince(a)) }
        let current = max(0, now.timeIntervalSince(start))
        return (current, max(best, current))
    }

    // MARK: Loading

    /// Reads everything from the database. Rows this version can't read are skipped, never deleted.
    func load() async {
        do {
            let snapshot = try await repository.load()
            habits = snapshot.habits.compactMap { Habit(record: $0, steps: snapshot.steps, reminders: snapshot.reminders) }
            entries = snapshot.entries.compactMap(Entry.init(record:))
            var loaded = DaySettings()
            var running: [UUID: Date] = [:]
            var runningSlots: [UUID: String] = [:]
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
            timers = running
            timerSlots = runningSlots
            isLoaded = true
            if upgradedV1 && !repaired && !triedPlacementUpgrade { triedPlacementUpgrade = true; repairPlacement() }
            onChange?()
        } catch {
            problem = "Your habits couldn't be read. Nothing has been changed; please restart the app."
        }
    }

    private enum Keys {
        static let dayEndHour = "day_end_hour"
        static let weekStart = "week_start"
        static let timerPrefix = "timer."
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

    /// Called after every change, so reminders stay in step with the data.
    var onChange: (() -> Void)?

    /// Runs changes one at a time, in the order they were made. Each one decides what to do
    /// from the state left by the previous one, writes to the database, and only then updates memory.
    private func perform(_ change: @escaping @MainActor () async throws -> Void) {
        let previous = writeQueue
        writeQueue = Task { @MainActor in
            await previous?.value
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

    /// From a notification or an alarm: only ever adds, never undoes. A row already done is left alone;
    /// an amount adds one increment.
    func logFromReminder(_ habit: Habit, slot: String?, on day: LocalDay) {
        perform { [self] in
            guard let habit = habits.first(where: { $0.id == habit.id }) else { return }
            switch habit.kind {
            case .amount:
                guard let increment = habit.quickIncrement else { return }
                let entry = Entry(habitID: habit.id, day: day, value: increment, slot: slot.flatMap { slots(of: habit).contains($0) ? $0 : nil })
                try await repository.addEntry(entry: entry.record)
                withAnimation { entries.append(entry) }
            case .check, .task:
                if let slot, slots(of: habit).contains(slot) {
                    guard !isSlotDone(habit, slot: slot, on: day) else { return }
                    let entry = Entry(habitID: habit.id, day: day, value: 1, slot: slot)
                    try await repository.addEntry(entry: entry.record)
                    withAnimation { entries.append(entry) }
                } else {
                    guard !isDone(habit, on: day) else { return }
                    try await log(habit, value: 1, on: day)
                }
            default:
                return
            }
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
        perform { [self] in
            let now = Date.now
            let key = Keys.timerPrefix + habit.id.uuidString
            if let start = timers[habit.id] {
                let minutes = now.timeIntervalSince(start) / 60
                if minutes >= 1 / 60 {
                    let entry = Entry(habitID: habit.id, day: today(now: now), value: minutes, slot: timerSlots[habit.id])
                    try await repository.addEntry(entry: entry.record)
                    withAnimation { entries.append(entry) }
                }
                try await repository.removeSetting(key: key)
                withAnimation { _ = timers.removeValue(forKey: habit.id); _ = timerSlots.removeValue(forKey: habit.id) }
            } else {
                try await repository.saveSetting(key: key, value: String(now.millis) + (slot.map { "|" + $0 } ?? ""))
                withAnimation { timers[habit.id] = now; timerSlots[habit.id] = slot }
            }
        }
    }

    private func log(_ habit: Habit, value: Double, on day: LocalDay) async throws {
        let entry = Entry(habitID: habit.id, day: day, value: value)
        try await repository.addEntry(entry: entry.record)
        withAnimation { entries.append(entry) }
    }

    private func undoLast(_ habit: Habit, on day: LocalDay) async throws {
        // Undo the latest log on this day; for week and month rules, the latest one in the period.
        let range = periodRange(habit, containing: day) ?? (day...day)
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
            let long = ["Early morning before breakfast", "Lunch break and the walk after", "Evening once kids are in bed"]
            saveSections(sections.map { section in
                var section = section
                if let i = [String.morning, .afternoon, .evening].firstIndex(of: section.id) { section.name = TextLimit.clean(long[i], TextLimit.section) }
                return section
            })
        }
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
        if ProcessInfo.processInfo.arguments.contains("-longtext") {
            // Names, units and parts at their limits, to test layouts.
            for i in habits.indices {
                switch habits[i].id {
                case water.id:
                    habits[i].name = "Drink a big glass of warm water with lemon first thing after waking up, before coffee or my phone"
                    habits[i].kind = .amount(unit: "teaspoons of chia seeds", increment: 1)
                case skincare.id:
                    habits[i].name = "Morning skincare: the full routine the dermatologist gave me, including SPF"
                    habits[i].steps[0].name = "Double cleanse: the oil cleanser first, then the gel one"
                case smoking.id: habits[i].name = "Smoking, including the social cigarettes at weekends"
                case lunch.id: habits[i].name = "Lunch away from the desk, with no phone, no laptop and no work chat"
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
    }
    #endif
}
