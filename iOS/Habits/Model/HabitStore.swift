import Core
import Foundation
import Observation
import SwiftUI
import UIKit

/// User settings that change how days and weeks are counted (Architecture 05 §4.2–4.3).
struct DaySettings: Codable, Hashable, Sendable {
    /// The hour the user's day ends, 0...12. Taps before this hour count for the previous day.
    var dayEndHour: Int = 0
    /// 1 = Sunday … 7 = Saturday, as in `Calendar.firstWeekday`.
    var weekStart: Int = Calendar.current.firstWeekday
    /// False: the week follows the iPhone's region (Automatic, the default); true: the person picked a day.
    var weekStartChosen = false
}

/// Holds habits and entries and applies every change. Everything shown is calculated from
/// these records, never stored (Architecture 05 §3.3).
///
/// Changes are written to the database one at a time and in order. Settings, habits and notes are written
/// first and shown second. Taps that log (check, amount, step, task, timer) are shown at once and written
/// right after: waiting for a durable write before the checkmark appeared made every tap lag, and quick taps
/// landed on the old state (29–30 Sep). If a write ever fails, the store reloads from the database once the
/// queued writes are done, and says so.
@Observable
final class HabitStore {
    @ObservationIgnored private let repository: HabitRepository
    @ObservationIgnored let analytics: Analytics
    @ObservationIgnored private var writeQueue: Task<Void, Never>?
    /// Tried once per launch, so a failing write can't loop through reloads.
    @ObservationIgnored private var triedPlacementUpgrade = false
    @ObservationIgnored private var triedOrderUpgrade = false
    /// False until the first load finishes; the UI waits rather than flashing an empty screen.
    private(set) var isLoaded = false
    /// A failed open/read must never look like an empty installation to system delivery.
    private(set) var isStorageReady = false
    @ObservationIgnored private let databaseOpened: Bool
    /// Shown to the user when a write fails or the data can't be read.
    var problem: String?
    /// A person's own log: `true` when it makes the habit complete (a success tap and the chime), `false` on the way (a
    /// light tap). Set by `AppModel` to `TickFeedback`; nil where nothing listens. One rule for every place a log comes
    /// from (Current Work 18, 5 Oct 2026; `HabitStore+Feedback.swift`).
    @ObservationIgnored var onLog: (@MainActor (Bool) -> Void)? { didSet { watchTimerGoals() } }
    /// Running timers whose goal moment already played the completion, so stopping them doesn't play it again.
    @ObservationIgnored var timerGoalCelebrated: Set<UUID> = []
    @ObservationIgnored var timerGoalWatch: Task<Void, Never>?

    @ObservationIgnored private let suppliedCalendar: Calendar?
    init(repository: HabitRepository, calendar: Calendar? = nil, databaseOpened: Bool = true, analytics: Analytics = .shared) {
        self.repository = repository
        self.analytics = analytics
        suppliedCalendar = calendar
        self.databaseOpened = databaseOpened
        // A new time zone or region can change the calendar, and with it every day and week.
        for name in [NSNotification.Name.NSSystemTimeZoneDidChange, NSLocale.currentLocaleDidChangeNotification] {
            NotificationCenter.default.addObserver(forName: name, object: nil, queue: .main) { [weak self] _ in
                MainActor.assumeIsolated { self?.calendarChanged() }
            }
        }
    }

    private(set) var habits: [Habit] = [] { didSet { forgetAll() } }
    /// Changed only through `insertEntry`, `removeEntry(at:)` and `replaceEntry` (or a full load), which keep the indexes below in
    /// step. Rebuilding them from every entry after each tap cost a full pass over a year of history (30 Sep).
    @ObservationIgnored private var storedEntries: [Entry] = []
    @ObservationIgnored private var entryChangePending = false
    private(set) var entries: [Entry] {
        get { access(keyPath: \.entries); return storedEntries }
        set { storedEntries = newValue; queueEntryChange() }
        // Keep Array's in-place mutation: a get/copy/set would copy all history on each tap.
        _modify {
            access(keyPath: \.entries)
            defer { queueEntryChange() }
            yield &storedEntries
        }
    }

    /// Data and indexes change synchronously; SwiftUI observes one update on the next actor turn.
    /// Publishing each add/edit/delete inside a tap made Observation.willSet flush native list
    /// updates between the mutations, even when the final membership was unchanged (30 Sep).
    private func queueEntryChange() {
        guard !entryChangePending else { return }
        entryChangePending = true
        Task { @MainActor [weak self] in
            guard let self else { return }
            entryChangePending = false
            withMutation(keyPath: \.entries) {}
            // Then each changed habit's own mark. A change that didn't say which habit (a reload, the demo data) marks
            // every habit, so no view can miss one.
            let changed = changedHabits
            changedHabits = []
            let all = replacedAllEntries
            replacedAllEntries = false
            if all || changed.isEmpty {
                for revision in entryRevisions.values { revision.count &+= 1 }
            } else {
                for id in changed { entryRevisions[id]?.count &+= 1 }
            }
        }
    }

    /// One habit's entries changed: a mark per habit, so a view showing one habit (a Today row) redraws for its own
    /// habit's taps, not for every tap on Today (PERFORMANCE.md rule 6; the +1 speed run, 2 Oct 2026). Whole-history
    /// readers still observe `entries`.
    @Observable final class EntryRevision { var count = 0 }
    @ObservationIgnored private var entryRevisions: [UUID: EntryRevision] = [:]
    @ObservationIgnored private var changedHabits: Set<UUID> = []

    /// Reads one habit's mark, so the calling view redraws when that habit's entries change.
    private func observeEntries(of id: UUID) {
        if let revision = entryRevisions[id] { _ = revision.count; return }
        let revision = EntryRevision()
        entryRevisions[id] = revision
        _ = revision.count
    }
    /// `entries` grouped by habit, built on first use. Every count, streak and "done" reads one
    /// habit's entries; scanning all of them for each day of a streak made scrolling Today stutter (30 Sep).
    @ObservationIgnored private var entriesByHabit: [UUID: [Entry]]?
    /// The same, by habit and day: the calendar asks about ~30 days × every habit on each month (30 Sep).
    @ObservationIgnored private var entriesByDay: [UUID: [LocalDay: [Entry]]]?
    var settings = DaySettings() { didSet { cachedCalendar = nil; placementCache = [:]; startDays = [:]; forgetAll() } }
    /// Running timers for duration habits: habit ID → start time.
    private(set) var timers: [UUID: Date] = [:] {
        didSet {
            for id in Set(oldValue.keys).union(timers.keys) where oldValue[id] != timers[id] {
                widgetProjectionCache[id] = nil
            }
        }
    }
    /// For a timed habit spread over times of day: the part a running timer is for.
    private(set) var timerSlots: [UUID: String] = [:]
    /// Days a habit was skipped ("Skip today"). A skipped day is simply not one of its days: hidden on Today and
    /// neutral in the streak, the ring and every percentage (Feature Ledger C016: "a skipped day is not a missed day").
    private(set) var skips: [UUID: Set<LocalDay>] = [:] { didSet { forgetAll() } }
    /// A repeating task's occurrences moved to another day, original day → new day (Day details' Reschedule, 4 Oct
    /// 2026). Saved like skips, one setting per task, so it syncs and is backed up with them.
    private(set) var taskMoves: [UUID: [LocalDay: LocalDay]] = [:] { didSet { forgetAll() } }
    /// Pauses per habit, oldest first. A paused day is a skipped day, for a whole stretch (pause report, 29 Sep).
    private(set) var pauses: [UUID: [HabitPause]] = [:] { didSet { forgetAll() } }
    /// Goal history: the rules a habit had before it was edited, oldest first. Each applies up to and including
    /// its `until` day, so past days keep the result they had (spec §8.2).
    private(set) var rules: [UUID: [HabitRule]] = [:] { didSet { forgetAll() } }
    /// Notes (report "Habit Notes and Day Notes", 29 Sep): one per habit per day, one per day, and a standing
    /// description per habit. Optional, never prompted, and they never change progress.
    private(set) var habitNotes: [UUID: [LocalDay: String]] = [:]
    private(set) var dayNotes: [LocalDay: String] = [:]
    private(set) var descriptions: [UUID: String] = [:]
    /// The day each archived habit was archived: from that day on it has no days (Build Plan #60c). Kept only while
    /// it's archived; Restore turns the archived stretch into a pause, so those days are never "not done".
    private(set) var archivedOn: [UUID: LocalDay] = [:] { didSet { forgetAll() } }
    /// Goes up by one after every change and every load. Progress keys its numbers on it, so they're worked out once
    /// per change, never while drawing (report §20). Only screens that cache numbers read it.
    private(set) var dataVersion = 0
    /// Progress's day scores, kept until the data or the day changes, so going back and forth between periods and
    /// the last-period line reuse days already worked out (speed run, 30 Sep 2026).
    /// Kept per group too (nil is All), so switching Progress's group chips reuses days already worked out.
    @ObservationIgnored var progressScores: [ProgressScoreKey: DayScore] = [:]
    @ObservationIgnored var progressScoresKey = ""
    /// Quit habits: what the habit cost a day, for "Saved so far" (report §10.5, Phase 3). Optional.
    private(set) var costs: [UUID: HabitCost] = [:]
    /// Groups (Build Plan #68; `Docs/Specs/Groups — What to Build.md`): optional, none until the person makes one, in
    /// the order they're shown everywhere (A to Z until the person drags one).
    private(set) var groups: [HabitGroup] = []
    /// The person dragged the groups into their own order; false means A to Z.
    private(set) var groupsManual = false
    /// Each habit's group, rebuilt only when groups change, so filtering is one lookup per habit. One group per habit.
    private(set) var groupOf: [UUID: UUID] = [:]
    /// The row just logged on Today: it offers "Add note" in place (Way of Life's inline note, notes UX report).
    /// Only one row at a time; nothing pops up by itself.
    var noteOffer: NoteOffer?
    /// Exact entry offered for undo on Today. No timeout, and no search through history per row.
    var undoOffer: Entry?
    /// The moment a tap finished everything planned for today (the review prompt waits for this pause).
    private(set) var dayFinishedAt: Date?
    /// What the last tap reached: "30 days in a row", "All 5 done today". Shown beside that row's Undo while it lasts.
    private(set) var milestoneOffer: MilestoneOffer?
    struct MilestoneOffer: Equatable { let entry: UUID; let habit: UUID; let day: LocalDay; let text: String }
    /// Only writes what changes: every row reads these, and an observed write redraws them even when it's nil to nil.
    func clearLogOffer() {
        if undoOffer != nil { undoOffer = nil }
        if noteOffer != nil { noteOffer = nil }
    }
    struct NoteOffer: Equatable { let habit: UUID; let day: LocalDay }
    /// The note being written in Today's note sheet: a habit's note (`habit` set) or the day's note (`habit` nil).
    var noteTarget: NoteTarget?
    /// History is hosted by Today, so skipping a day cannot remove the row that owns its sheet.
    var dayTarget: DayTarget?
    /// The habit whose full-screen timer is open (`TimerScreen`), from ▶, the timer bar or the Live Activity.
    var timerScreen: UUID?
    struct DayTarget: Identifiable {
        let habitID: UUID
        let day: LocalDay
        var id: String { habitID.uuidString + day.key }
    }
    struct NoteTarget: Equatable, Identifiable {
        let habit: UUID?
        let day: LocalDay
        var id: String { (habit?.uuidString ?? "day") + day.key }
    }
    /// Plus unlocks unlimited habits. Set from the store purchase (build-plan: billing, later).
    var isPlus = false { didSet { if oldValue != isPlus { onChange?() } } }
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

    /// Made once, not on every call: streaks ask for it on every day they step through (30 Sep).
    var calendar: Calendar {
        access(keyPath: \.settings)
        if let cachedCalendar { return cachedCalendar }
        var c = suppliedCalendar ?? Calendar.current
        c.firstWeekday = settings.weekStart
        if let fixedTimeZone { c.timeZone = fixedTimeZone }
        cachedCalendar = c
        return c
    }
    @ObservationIgnored private var cachedCalendar: Calendar?

    /// The weekday names, Sunday first (index `LocalDay.weekday - 1`): the calendar builds a new array on each ask,
    /// and Progress asked once per day cell and per VoiceOver line (PERFORMANCE.md rule 8).
    var weekdayNames: (full: [String], veryShort: [String]) {
        let calendar = calendar
        if let cachedWeekdayNames { return cachedWeekdayNames }
        let names = (calendar.weekdaySymbols, calendar.veryShortStandaloneWeekdaySymbols)
        cachedWeekdayNames = names
        return names
    }
    @ObservationIgnored private var cachedWeekdayNames: (full: [String], veryShort: [String])?

    private func calendarChanged() {
        cachedCalendar = nil
        cachedWeekdayNames = nil
        startDays = [:]
        forgetAll()
        withMutation(keyPath: \.settings) {} // every screen showing days draws them again
    }

    // MARK: Remembered numbers

    // Streaks, best streaks and the calendar's day totals step through up to a year of days. Worked out on every
    // redraw, one tap on Today recalculated every row's streak (30 Sep). They're remembered until something they
    // depend on changes: an entry of that habit, or any habit, skip, pause, goal history or setting.
    @ObservationIgnored private var pastRuns: [UUID: [LocalDay: Int]] = [:]
    /// Every run of a habit (`runs(of:)`), for today: the best streak, the habit page's run list and Over Time all read
    /// it, and walking it again after each saved entry stalled the habit page under the Day sheet (1 Oct).
    @ObservationIgnored private var runLists: [UUID: (today: LocalDay, runs: [Run])] = [:]
    @ObservationIgnored private var totalLines: [UUID: (today: LocalDay, line: String?)] = [:]
    @ObservationIgnored private var summaries: [LocalDay: (done: Int, total: Int)] = [:]
    @ObservationIgnored private var savedHabits: [UUID: Habit]?
    @ObservationIgnored private var startDays: [UUID: (createdAt: Date, day: LocalDay)] = [:]
    /// Widget projections reuse the same per-item invalidation as the app's remembered numbers.
    @ObservationIgnored var widgetProjectionContext: String?
    @ObservationIgnored var widgetProjectionCache: [UUID: [WidgetItem]] = [:]

    private func forget(_ habit: UUID) {
        pastRuns[habit] = nil
        runLists[habit] = nil
        totalLines[habit] = nil
        monthCounts[habit] = nil
        widgetProjectionCache[habit] = nil
        summaries = [:]
    }

    private func forgetAll() {
        pastRuns = [:]
        runLists = [:]
        totalLines = [:]
        monthCounts = [:]
        summaries = [:]
        savedHabits = nil
        widgetProjectionCache = [:]
        widgetProjectionContext = nil
    }

    /// Only a saved habit's numbers are remembered, never a form's draft (which shares its ID while being edited).
    private func isSaved(_ habit: Habit) -> Bool {
        if savedHabits == nil { savedHabits = Dictionary(habits.map { ($0.id, $0) }, uniquingKeysWith: { first, _ in first }) }
        return savedHabits?[habit.id] == habit
    }

    /// A remembered number is read without working it out, so this reads what it depends on: a view showing it
    /// still redraws when any of that changes.
    private func readInputs(of habit: UUID) {
        observeEntries(of: habit)
        access(keyPath: \.habits)
        access(keyPath: \.skips)
        access(keyPath: \.pauses)
        access(keyPath: \.rules)
        access(keyPath: \.settings)
    }

    private func readInputs() {
        access(keyPath: \.entries)
        access(keyPath: \.habits)
        access(keyPath: \.skips)
        access(keyPath: \.pauses)
        access(keyPath: \.rules)
        access(keyPath: \.settings)
    }

    /// Adds an entry, keeping the indexes in step; only that habit's remembered numbers are forgotten.
    private func insertEntry(_ entry: Entry, at index: Int? = nil, habitIndex: Int? = nil, dayIndex: Int? = nil) {
        if let index {
            entries.insert(entry, at: index)
            if let habitIndex { entriesByHabit?[entry.habitID, default: []].insert(entry, at: habitIndex) }
            if let dayIndex { entriesByDay?[entry.habitID, default: [:]][entry.day, default: []].insert(entry, at: dayIndex) }
        } else {
            entries.append(entry)
            entriesByHabit?[entry.habitID, default: []].append(entry)
            entriesByDay?[entry.habitID, default: [:]][entry.day, default: []].append(entry)
        }
        changedHabits.insert(entry.habitID)
        forget(entry.habitID)
    }

    private func removeEntry(at index: Int) {
        let entry = entries.remove(at: index)
        entriesByHabit?[entry.habitID]?.removeAll { $0.id == entry.id }
        entriesByDay?[entry.habitID]?[entry.day]?.removeAll { $0.id == entry.id }
        changedHabits.insert(entry.habitID)
        forget(entry.habitID)
        if undoOffer?.id == entry.id { undoOffer = nil }
    }

    /// An edit keeps the same row, indexes and position, with one value replacement.
    private func replaceEntry(_ entry: Entry, at index: Int) {
        entries[index] = entry
        if let i = entriesByHabit?[entry.habitID]?.firstIndex(where: { $0.id == entry.id }) {
            entriesByHabit?[entry.habitID]?[i] = entry
        }
        if let i = entriesByDay?[entry.habitID]?[entry.day]?.firstIndex(where: { $0.id == entry.id }) {
            entriesByDay?[entry.habitID]?[entry.day]?[i] = entry
        }
        changedHabits.insert(entry.habitID)
        forget(entry.habitID)
        if undoOffer?.id == entry.id { undoOffer = nil }
    }

    /// After `entries` is replaced as a whole.
    private func entriesReplaced() {
        entriesByHabit = nil
        entriesByDay = nil
        // Every habit may have changed: an empty set marks them all when the change is published.
        changedHabits = []
        replacedAllEntries = true
        forgetAll()
    }
    @ObservationIgnored private var replacedAllEntries = false

    /// Only the in-app checks set it (`SettingsCheck`: a fixed place for the daylight-saving cases). The app always
    /// follows the phone's own time zone, so travelling needs no setting.
    @ObservationIgnored var fixedTimeZone: TimeZone? { didSet { calendarChanged() } }

    // MARK: Days

    /// "Now" for every calculation that doesn't pass its own moment. Only the in-app checks set a fixed moment
    /// (`ProgressCheck`); the app never changes it.
    @ObservationIgnored var clock: () -> Date = { .now }

    /// The user's current day, honouring their day end.
    ///
    /// Worked out on the wall clock, not by subtracting hours from the moment: on the nights the clocks change, "3 AM"
    /// is three hours after midnight on the clock but two or four in real time, and the new day must still start
    /// when the clock says 3:00 (Build Plan #61; the old subtraction was an hour off twice a year).
    func today(now: Date? = nil) -> LocalDay {
        let now = now ?? clock()
        let cal = calendar
        let day = LocalDay(now, calendar: cal)
        guard settings.dayEndHour > 0 else { return day }
        return cal.component(.hour, from: now) < settings.dayEndHour ? day.adding(days: -1, calendar: cal) : day
    }

    /// Calendar-time bounds are computed from both midnights, then shifted by the day end.
    /// Adding one calendar day to a shifted start is wrong when daylight saving changes overnight.
    func dayBounds(_ day: LocalDay, calendar recordingCalendar: Calendar? = nil) -> ClosedRange<Date> {
        let c = recordingCalendar ?? calendar
        // Wall-clock boundaries: a 04:00 day starts at 04:00 even on a DST transition.
        let start = c.date(bySettingHour: settings.dayEndHour, minute: 0, second: 0, of: day.date(calendar: c))!
        let end = c.date(bySettingHour: settings.dayEndHour, minute: 0, second: 0,
                         of: day.adding(days: 1, calendar: c).date(calendar: c))!.addingTimeInterval(-1)
        return start...end
    }

    /// A saved entry keeps its original tracking day and time zone even after the person travels.
    func recordingCalendar(for entry: Entry) -> Calendar {
        var c = calendar
        c.timeZone = TimeZone(identifier: entry.timeZone) ?? c.timeZone
        return c
    }

    func recordingDay(at date: Date, for entry: Entry) -> LocalDay {
        LocalDay(date.addingTimeInterval(-Double(settings.dayEndHour) * 3600), calendar: recordingCalendar(for: entry))
    }

    /// The day bar's "done of planned": what's on Today, so archived habits aren't in it. Built on `dayScore`, the one
    /// definition shared with the calendar sheet and Progress. A multi-section habit counts once.
    func daySummary(on day: LocalDay) -> (done: Int, total: Int) {
        // Past days are remembered; today and later can change with a running timer or the time of day.
        let past = day < today()
        if past, let known = summaries[day] { readInputs(); return known }
        let score = todayScore(on: day)
        let summary = (done: score.done, total: score.planned)
        if past { summaries[day] = summary }
        return summary
    }

    /// The day as Today and its calendar sheet count it: the habits on Today (not archived), tasks included.
    func todayScore(on day: LocalDay) -> DayScore {
        dayScore(on: day, habits: habits.filter { !$0.archived })
    }

    /// One day across a list of habits (report §16.4). Every calculation takes a list, so groups can use it later.
    struct DayScore: Hashable, Sendable {
        var done = 0
        /// The share reached of habits begun but not finished: the ring fills part of the way; never counted as done.
        var part = 0.0
        /// How many habits have part credit.
        var partCount = 0
        var planned = 0
        var fraction: Double { planned == 0 ? 0 : min(1, (Double(done) + part) / Double(planned)) }
        var isFull: Bool { planned > 0 && done == planned }
        /// A full day at a share of what was planned: 1 (all), 0.8 or 0.6 (Progress's "Full Day" option, report §25.1
        /// Phase 3). Only what's done counts, never part credit.
        func isFull(at share: Double) -> Bool {
            share >= 1 ? isFull : planned > 0 && Double(done) / Double(planned) >= share - 0.000_001
        }
    }

    /// How one habit's day counts in the rings and Progress's numbers (report §16.2–16.4).
    enum DayOutcome: Hashable {
        case done
        case part(Double)
        case notDone
        /// Today, or a later day: planned, not finished yet. Never counted against anyone.
        case open
        /// Not one of its days, or a day that doesn't count (skipped, paused, before it started, archived, a week
        /// goal's day with nothing logged, a limit's day that isn't over).
        case neutral
    }

    func dayScore(on day: LocalDay, habits list: [Habit], today: LocalDay? = nil) -> DayScore {
        let today = today ?? self.today()
        var score = DayScore()
        for habit in list {
            switch outcome(habit, on: day, today: today) {
            case .done: score.planned += 1; score.done += 1
            case .part(let share): score.planned += 1; score.part += share; score.partCount += 1
            case .notDone, .open: score.planned += 1
            case .neutral: break
            }
        }
        return score
    }

    func outcome(_ habit: Habit, on day: LocalDay, today: LocalDay? = nil) -> DayOutcome {
        guard habit.kind != .quit, day >= startDay(of: habit), isDue(habit, on: day) else { return .neutral }
        let today = today ?? self.today()
        let rule = rule(habit, on: day)
        if rule.kind == .task { return isDone(rule, on: day) ? .done : day < today ? .notDone : .open }
        // A week, month or year goal: a day counts only once something is logged on it, and then it's done, since
        // every ✓ counts toward the goal. Today it's open until then; it's never "not done" (Build Plan #60a).
        // A week or month limit has no day to fill.
        if !rule.frequency.isDayBased {
            if rule.atMost { return .neutral }
            if dayProgress(of: rule, on: day) > 0 { return .done }
            return day == today && !isPeriodMet(habit, on: day) ? .open : .neutral
        }
        // "5 km on 3 days a week": a day with something logged counts, a short one in part; an empty one doesn't.
        if rule.frequency.isFlexible {
            if dayProgress(of: rule, on: day) > 0 { return isDayMet(rule, on: day) ? .done : .part(dayFraction(rule, on: day)) }
            return day == today && !isPeriodMet(habit, on: day) ? .open : .neutral
        }
        // A daily limit is judged once the day is over: within it is done, over it isn't (Build Plan #60b).
        if rule.atMost { return day < today ? (isDayMet(rule, on: day) ? .done : .notDone) : .neutral }
        if isDayMet(rule, on: day) { return .done }
        if day > today { return .open }
        if dayProgress(of: rule, on: day) > 0 { return .part(dayFraction(rule, on: day)) }
        return day == today ? .open : .notDone
    }

    /// The share of the day's goal reached, 0...1.
    func dayFraction(_ habit: Habit, on day: LocalDay) -> Double {
        let rule = rule(habit, on: day)
        let goal = dayGoal(of: rule)
        return goal > 0 ? min(1, max(0, dayProgress(of: rule, on: day) / goal)) : 0
    }

    // MARK: Day sections

    /// The user's day sections: Anytime first, then by start time.
    private(set) var sections: [DaySection] = DaySection.defaults { didSet { placementCache = [:]; forgetAll() } }

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

    /// Remembered per habit: every "done", goal and count asks for it, many times per row (30 Sep).
    func placements(of habit: Habit) -> [Placement] {
        let inputs = PlacementInputs(parts: habit.parts, reminders: habit.reminders, isQuit: habit.kind == .quit)
        if let known = placementCache[habit.id], known.inputs == inputs {
            access(keyPath: \.sections)
            access(keyPath: \.settings)
            return known.placements
        }
        let placements = workOutPlacements(of: habit)
        placementCache[habit.id] = (inputs, placements)
        return placements
    }

    private struct PlacementInputs: Equatable {
        let parts: [String]
        let reminders: [ReminderTime]
        let isQuit: Bool
    }
    @ObservationIgnored private var placementCache: [UUID: (inputs: PlacementInputs, placements: [Placement])] = [:]

    private func workOutPlacements(of habit: Habit) -> [Placement] {
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
        perform { [self] telemetry in
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

    // MARK: Arranging Today (Arrange Your Day, 3 Oct 2026)

    /// Where Anytime and Quitting sit among the times of day, as last saved (empty: the default, both at the top).
    /// Read through `todayCards`, which puts the timed sections in time order around them.
    private(set) var cardOrder: [String] = []

    /// Today's cards from top to bottom: section IDs and `.quittingCard`. Timed sections always follow their times;
    /// only Anytime and Quitting are placed by the person (the user, 3 Oct 2026). A handful of strings, so it's simply
    /// worked out when asked.
    var todayCards: [String] {
        let timed = sections.filter { !$0.isAnytime }.map(\.id)
        let known = Set(timed)
        var slots = cardOrder.filter { $0 == .anytime || $0 == .quittingCard || known.contains($0) }
        for card in [String.quittingCard, .anytime].reversed() where !slots.contains(card) { slots.insert(card, at: 0) }
        // A time of day added since: its place goes just after the one before it in time (or before the first).
        for (i, id) in timed.enumerated() where !slots.contains(id) {
            if i > 0, let after = slots.firstIndex(of: timed[i - 1]) { slots.insert(id, at: after + 1) }
            else if let first = slots.firstIndex(where: { known.contains($0) }) { slots.insert(id, at: first) }
            else { slots.append(id) }
        }
        var next = timed.makeIterator()
        return slots.map { known.contains($0) ? next.next()! : $0 }
    }

    enum CardMove { case up, down, top, bottom }

    /// Moves Anytime or Quitting among the cards. The timed sections keep their time order around it.
    func moveCard(_ id: String, _ move: CardMove) {
        guard id == .anytime || id == .quittingCard else { return }
        var cards = todayCards
        guard let from = cards.firstIndex(of: id) else { return }
        let to: Int = switch move {
        case .up: max(0, from - 1)
        case .down: min(cards.count - 1, from + 1)
        case .top: 0
        case .bottom: cards.count - 1
        }
        guard to != from else { return }
        cards.remove(at: from)
        cards.insert(id, at: to)
        perform { [self] _ in
            let json = String(decoding: try JSONEncoder().encode(cards), as: UTF8.self)
            try await repository.saveSetting(key: Keys.cardOrder, value: json)
            withAnimation(.snappy) { cardOrder = cards }
        }
    }

    /// Every habit and task each card holds, whatever the day: Arrange Your Day shows them all (the user, 3 Oct 2026).
    /// Not archived, and not one-time tasks already done. In the person's own order, habits and tasks together (tasks
    /// research, 3 Oct 2026: people want one order for the day and to drag one-time tasks too; nobody asked for habits
    /// or tasks first). One pass over the habits for every card.
    func cardMembers() -> [String: [Habit]] {
        var cards: [String: [Habit]] = [:]
        for habit in habits where !habit.archived {
            if habit.isQuitOrLimit { cards[.quittingCard, default: []].append(habit); continue }
            if habit.kind == .task, let due = habit.dueDay, isDone(habit, on: due) { continue }
            var seen = Set<String>()
            for placement in placements(of: habit) where seen.insert(placement.section).inserted {
                cards[placement.section, default: []].append(habit)
            }
        }
        return cards
    }

    func members(ofCard card: String) -> [Habit] { cardMembers()[card] ?? [] }

    enum SectionSort { case reminderTime, name }

    /// "Sort by Reminder Time" or "Sort A to Z" for one card, once: it rewrites that card's order, and dragging carries
    /// on from there. Habits without a reminder keep their order, after the timed ones.
    func sortCard(_ card: String, by sort: SectionSort) {
        let list = members(ofCard: card)
        let sorted: [Habit]
        switch sort {
        case .name:
            sorted = list.sorted { $0.name.localizedStandardCompare($1.name) == .orderedAscending }
        case .reminderTime:
            func first(_ habit: Habit) -> Int {
                let times = placements(of: habit).first { $0.section == card }?.times ?? []
                return times.first.map { dayMinute($0.minuteOfDay) } ?? .max
            }
            sorted = list.enumerated().sorted { a, b in
                let (ta, tb) = (first(a.element), first(b.element))
                return ta != tb ? ta < tb : a.offset < b.offset
            }.map(\.element)
        }
        reorder(sorted.map(\.id))
    }

    /// Whether any habit in this card has a reminder time there, so "Sort by Reminder Time" means something.
    func hasReminderTimes(inCard card: String) -> Bool {
        members(ofCard: card).contains { habit in placements(of: habit).contains { $0.section == card && !$0.times.isEmpty } }
    }

    /// Once, on the first launch with the new rules: the order Today showed (timed rows by reminder time, then the
    /// rest) becomes the saved order, so moving to "your own order" changes nothing on screen (report 27, D6).
    private func keepShownOrder() {
        perform { [self] _ in
            let time: [UUID: Int] = Dictionary(uniqueKeysWithValues: habits.map { habit in
                (habit.id, placements(of: habit).first?.times.first.map { dayMinute($0.minuteOfDay) } ?? .max)
            })
            let next = habits.enumerated().sorted { a, b in
                let (ta, tb) = (time[a.element.id]!, time[b.element.id]!)
                return ta != tb ? ta < tb : a.offset < b.offset
            }.map(\.element)
            for i in next.indices where next[i].id != habits[i].id {
                try await repository.saveHabit(habit: next[i].record(position: i), steps: next[i].stepRecords(),
                                               reminders: next[i].reminderRecords(), at: Date.now.millis)
            }
            try await repository.saveSetting(key: Keys.orderV1, value: "1")
            if next.map(\.id) != habits.map(\.id) { habits = next }
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

    func periodRange(_ habit: Habit, containing day: LocalDay) -> ClosedRange<LocalDay>? {
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
    func isTotal(_ habit: Habit) -> Bool {
        switch habit.kind {
        case .amount, .duration: !habit.frequency.isDayBased
        default: false
        }
    }

    func periodTotal(_ habit: Habit, in range: ClosedRange<LocalDay>, now: Date = .now) -> Double {
        var total = entries(of: habit.id).lazy.filter { $0.stepID == nil && range.contains($0.day) }.reduce(0) { $0 + $1.value }
        if let start = timers[habit.id], range.contains(today(now: now)) {
            total += max(0, now.timeIntervalSince(start)) / 60
        }
        return total
    }

    /// One habit's entries, in the order they were logged. Still reads `entries`, so views redraw when it changes.
    func entries(of id: UUID) -> [Entry] {
        observeEntries(of: id)
        guard let index = entriesByHabit else {
            let index = Dictionary(grouping: storedEntries, by: \.habitID)
            entriesByHabit = index
            return index[id] ?? []
        }
        return index[id] ?? []
    }

    /// One habit's entries on one day, in the order they were logged.
    func entries(of id: UUID, on day: LocalDay) -> [Entry] {
        observeEntries(of: id)
        guard let index = entriesByDay else {
            let index = Dictionary(grouping: storedEntries, by: \.habitID).mapValues { Dictionary(grouping: $0, by: \.day) }
            entriesByDay = index
            return index[id]?[day] ?? []
        }
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
        guard day <= today(), !skipped || canSkip(rule(habit, on: day)) else { return }
        var days = skips[habit.id] ?? []
        if skipped { days.insert(day) } else { days.remove(day) }
        withAnimation { skips[habit.id] = days.isEmpty ? nil : days }
        let value = days.map(\.key).sorted().joined(separator: ",")
        perform { [self] telemetry in
            try await repository.saveSetting(key: Keys.skipPrefix + habit.id.uuidString, value: value)
        }
    }

    // MARK: Rescheduling a repeating task

    /// The repeating task's next scheduled day after `day`, by its own schedule (moves ignored). Walks at most a year,
    /// day by day, so it's called on a tap, never while drawing (Rulebook S5).
    func nextOccurrence(of habit: Habit, after day: LocalDay) -> LocalDay? {
        var next = day
        for _ in 0..<366 {
            next = next.adding(days: 1, calendar: calendar)
            if isDue(habit, on: next, countingSkips: false, followingMoves: false) { return next }
        }
        return nil
    }

    /// Whether the task shown on `day` can be rescheduled, and so whether Day details offers it (the user, 4 Oct 2026):
    /// a one-time task that isn't done; a repeating task only for today's occurrence, and only when tomorrow isn't its
    /// next occurrence already (a daily task never moves). One day's check, cheap enough to draw with.
    func canReschedule(_ habit: Habit, shownOn day: LocalDay) -> Bool {
        guard habit.kind == .task, !habit.archived, !isDone(habit, on: day) else { return false }
        if habit.dueDay != nil { return true }
        let today = today()
        return day == today && !isDue(habit, on: today.adding(days: 1, calendar: calendar), countingSkips: false, followingMoves: false)
    }

    /// The days the task can move to: a one-time task, any day from today on; a repeating task's occurrence, from
    /// tomorrow up to the day before its next occurrence, which it would otherwise run into. Worked out on a tap.
    func rescheduleRange(of habit: Habit, shownOn day: LocalDay) -> ClosedRange<LocalDay>? {
        guard canReschedule(habit, shownOn: day) else { return nil }
        let today = today()
        if habit.dueDay != nil { return today...today.adding(days: 3650, calendar: calendar) }
        let tomorrow = today.adding(days: 1, calendar: calendar)
        let last = nextOccurrence(of: habit, after: today).map { $0.adding(days: -1, calendar: calendar) }
            ?? habit.endsOn ?? today.adding(days: 365, calendar: calendar)
        return tomorrow <= last ? tomorrow...last : nil
    }

    /// Moves one occurrence of a repeating task from `day` to `target` (an occurrence already moved moves again from
    /// where it is). Only the task's schedule for those two days changes; its logs and day notes stay where they are.
    func moveOccurrence(_ habit: Habit, from day: LocalDay, to target: LocalDay) {
        guard habit.kind == .task, habit.dueDay == nil, let range = rescheduleRange(of: habit, shownOn: day), range.contains(target) else { return }
        var moves = taskMoves[habit.id] ?? [:]
        let original = moves.first { $0.value == day }?.key ?? day
        if original == target { moves.removeValue(forKey: original) } else { moves[original] = target }
        withAnimation { taskMoves[habit.id] = moves.isEmpty ? nil : moves }
        let value = moves.map { $0.key.key + ">" + $0.value.key }.sorted().joined(separator: ",")
        perform { [self] telemetry in
            try await repository.saveSetting(key: Keys.movePrefix + habit.id.uuidString, value: value)
        }
    }

    // MARK: Pause

    /// Whether the habit is paused on `day`. Paused days aren't its days: off Today, no reminders, neutral in the
    /// streak and every count.
    /// Whether an archived habit had stopped by `day` (Build Plan #60c). Days before its archive day count as usual.
    func isArchived(_ habit: Habit, on day: LocalDay) -> Bool {
        guard habit.archived, let from = archivedOn[habit.id] else { return false }
        return day >= from
    }

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
        savePauses(list, of: habit, counter: .paused)
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
        savePauses(list, of: habit, counter: .resumed)
    }

    private func savePauses(_ list: [HabitPause], of habit: Habit, counter: AnalyticsCounter) {
        perform { [self] telemetry in
            let json = String(decoding: try JSONEncoder().encode(list), as: UTF8.self)
            try await repository.saveSetting(key: Keys.pausePrefix + habit.id.uuidString, value: json)
            withAnimation { pauses[habit.id] = list.isEmpty ? nil : list }
            analytics.count(counter, ticket: telemetry)
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
        // On the clock, like `today`: a skipped hour (spring forward) gives the next moment that exists.
        let cal = calendar
        let midnight = cal.startOfDay(for: day.date(calendar: cal))
        guard settings.dayEndHour > 0 else { return midnight }
        return cal.date(bySettingHour: settings.dayEndHour, minute: 0, second: 0, of: midnight)
            ?? midnight.addingTimeInterval(Double(settings.dayEndHour) * 3600)
    }

    // MARK: Day and week (Build Plan #61; research "Ticking Off, Folding and Small Settings", §4)

    /// The hour a new day starts: 0 (midnight) to 12 (noon). Logs before it count for the day before. Logs already
    /// saved keep their day; Today, streaks, Progress, the player and reminders follow at once (reviews: a day-start
    /// setting that doesn't apply everywhere is the worst complaint).
    func setDayEnd(_ hour: Int) {
        let hour = min(12, max(0, hour))
        guard hour != settings.dayEndHour else { return }
        settings.dayEndHour = hour
        progressScores = [:]
        perform { [repository] _ in
            if hour == 0 { try await repository.removeSetting(key: Keys.dayEndHour) }
            else { try await repository.saveSetting(key: Keys.dayEndHour, value: String(hour)) }
        }
    }

    /// The first day of the week, 1 = Sunday … 7 = Saturday, or nil to follow the iPhone's region (Automatic).
    /// Weekly goals, week streaks, the calendar and Progress all count in the new weeks, past weeks too.
    func setWeekStart(_ day: Int?) {
        let chosen = day.map { min(7, max(1, $0)) }
        let resolved = chosen ?? Calendar.autoupdatingCurrent.firstWeekday
        guard resolved != settings.weekStart || (chosen != nil) != settings.weekStartChosen else { return }
        settings.weekStart = resolved
        settings.weekStartChosen = chosen != nil
        progressScores = [:]
        perform { [repository] _ in
            if let chosen { try await repository.saveSetting(key: Keys.weekStart, value: String(chosen)) }
            else { try await repository.removeSetting(key: Keys.weekStart) }
        }
    }

    /// The first day a habit counts: its start date (past or future), or the day it was made.
    func startDay(of habit: Habit) -> LocalDay {
        if let start = habit.startsOn { return start }
        if let known = startDays[habit.id], known.createdAt == habit.createdAt { return known.day }
        let day = LocalDay(habit.createdAt, calendar: calendar)
        startDays[habit.id] = (habit.createdAt, day)
        return day
    }

    /// Whether the habit belongs on `day`. Days that aren't due are hidden on Today and never break a streak.
    /// Unfinished one-time tasks move forward to today. Nothing is due before the start or after the end date.
    /// `countingSkips: false` asks whether the day was planned at all, skip or not: Today keeps a skipped habit as a
    /// neutral row saying so, with Undo Skip one swipe away (3 Oct 2026), instead of making it vanish.
    /// `followingMoves: false` asks the task's own schedule, ignoring occurrences moved to other days.
    func isDue(_ habit: Habit, on day: LocalDay, now: Date = .now, countingSkips: Bool = true, followingMoves: Bool = true) -> Bool {
        if (countingSkips && isSkipped(habit, on: day)) || isPaused(habit, on: day) || isArchived(habit, on: day) { return false }
        let habit = rule(habit, on: day)
        let created = startDay(of: habit)
        if let end = habit.endsOn, day > end, habit.kind != .quit { return false }
        switch habit.kind {
        case .quit: return false
        case .task:
            // A task with no date repeats on its schedule, like a habit; one occurrence can be moved to a day before the
            // next one (`moveOccurrence`).
            guard let due = habit.dueDay else {
                if followingMoves, let moves = taskMoves[habit.id] {
                    if moves.values.contains(day) { return true }
                    if moves[day] != nil { return false }
                }
                break
            }
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
            return days.contains(day.weekday(calendar: calendar))
        case .everyNDays(let n):
            let gap = created.days(to: day, calendar: calendar)
            return n <= 1 || gap % n == 0
        case .everyNWeeks(let n):
            let gap = created.days(to: day, calendar: calendar)
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
    func periodCount(_ habit: Habit, in range: ClosedRange<LocalDay>) -> Double {
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

    /// Nothing more is asked for the goal: it's met, or a flexible quota is. The daily action can remain available
    /// after a flexible quota is met; the routine player's main button moves on.
    func isComplete(_ habit: Habit, on day: LocalDay) -> Bool {
        isDone(habit, on: day) || (habit.frequency.isFlexible && isPeriodMet(habit, on: day))
    }

    /// Done for the day: Today's "N left" and ✓, reminders, and the player's segments. A week, month or year goal
    /// ("Gym 3 times a week") is done for the day once something is logged that day, or once the goal is met; the ✓
    /// still adds one more each tap (Build Plan #60a). Reminders and the section's remaining count must not imply
    /// that extra days are required.
    func isSatisfied(_ habit: Habit, on day: LocalDay) -> Bool {
        if isComplete(habit, on: day) { return true }
        let rule = rule(habit, on: day)
        return !rule.frequency.isDayBased && !rule.atMost && dayProgress(of: rule, on: day) > 0
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
        let ruled = rule(habit, on: day)
        // The current day (or week, month) is worked out each time: a running timer can finish it. The run before
        // it only changes with the data, so it's remembered (up to today: later days would count today's timer).
        // A limit's current day, week or month counts only once it's over (Build Plan #60b).
        let today = today()
        let current = periodRange(ruled, containing: day).map { isPeriodMet(ruled, on: day) && !(ruled.atMost && $0.contains(today)) }
            ?? (isDone(ruled, on: day) && !(ruled.atMost && day >= today))
        let remember = isSaved(habit) && day <= today
        if remember, let run = pastRuns[habit.id]?[day] {
            readInputs(of: habit.id)
            return (current ? 1 : 0) + run
        }
        let run = runBefore(day, of: ruled)
        if remember { pastRuns[habit.id, default: [:]][day] = run }
        return (current ? 1 : 0) + run
    }

    /// The days (or weeks, months) met in a row before the one containing `day`, as `streak` counts them.
    private func runBefore(_ day: LocalDay, of habit: Habit) -> Int {
        let created = startDay(of: habit)
        // A change to the kind of period (day, week, month, year) starts the streak again (spec §8.3).
        let kind = periodKind(habit)
        func samePeriodKind(_ cursor: LocalDay) -> Bool { periodKind(rule(habit, on: cursor)) == kind }
        let today = today()
        if let current = periodRange(habit, containing: day) {
            var count = 0
            var cursor = current.lowerBound.adding(days: -1, calendar: calendar)
            // A week or month with a paused day can't break the streak; it still counts if it was met.
            while cursor >= created, samePeriodKind(cursor), let range = periodRange(habit, containing: cursor) {
                if isPeriodMet(habit, on: cursor) { count += 1 } else if !hasPause(habit, in: range) { break }
                cursor = range.lowerBound.adding(days: -1, calendar: calendar)
            }
            return count
        }
        var count = 0
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

    func hasPause(_ habit: Habit, in range: ClosedRange<LocalDay>) -> Bool {
        pauses[habit.id]?.contains { p in p.from <= range.upperBound && (p.through.map { $0 >= range.lowerBound } ?? true) && (p.through.map { $0 >= p.from } ?? true) } == true
    }

    /// One run of a quit habit: from a start (its first day, a slip, or turning it back on) to the slip or pause that
    /// ended it; `end` is nil for the run going on now.
    struct QuitRun: Hashable, Sendable {
        enum Ending: Hashable, Sendable { case slip, pause, ongoing }
        let start: Date
        let end: Date?
        let endedBy: Ending
        func length(now: Date) -> TimeInterval { max(0, (end ?? now).timeIntervalSince(start)) }
    }

    /// The slips of a quit habit, oldest first: each logged slip's own moment (Build Plan #60d), and a later "Started"
    /// date counted as one more, as before.
    func slips(of habit: Habit, now: Date? = nil) -> [Date] {
        let now = now ?? clock()
        let start = habit.quitSince ?? habit.createdAt
        var slips = entries(of: habit.id).map(\.createdAt).filter { $0 <= now }
        if start > habit.createdAt && !slips.contains(start) { slips.append(start) }
        return slips.sorted()
    }

    /// Every run of a quit habit, oldest first (report §16.8). A pause ends the run it interrupts (kept as a run, not
    /// a slip), and turning it back on starts a new one. While paused, there's no current run.
    func quitHistory(of habit: Habit, now: Date? = nil) -> [QuitRun] {
        let now = now ?? clock()
        let start = habit.quitSince ?? habit.createdAt
        // Each boundary ends the run going on (if any) and may start the next.
        var edges: [(at: Date, starts: Bool, ending: QuitRun.Ending)] = slips(of: habit, now: now).map { ($0, true, .slip) }
        var pausedNow = false
        for p in pauses[habit.id] ?? [] where p.pausedAt <= now {
            edges.append((p.pausedAt, false, .pause))
            if let back = resumeMoment(p), back <= now { edges.append((back, true, .pause)) } else { pausedNow = true }
        }
        edges.sort { $0.at < $1.at }
        let origin = min(habit.createdAt, start)
        var runStart: Date? = origin
        var runs: [QuitRun] = []
        for edge in edges where edge.at > origin {
            if let s = runStart, edge.at > s { runs.append(QuitRun(start: s, end: edge.at, endedBy: edge.ending)) }
            runStart = edge.starts ? edge.at : nil
        }
        if !pausedNow, let runStart { runs.append(QuitRun(start: max(start, runStart), end: nil, endedBy: .ongoing)) }
        return runs
    }

    /// Quit habits: the current run and the best run, from `quitHistory`.
    func quitRuns(of habit: Habit, now: Date = .now) -> (current: TimeInterval, best: TimeInterval) {
        let history = quitHistory(of: habit, now: now)
        let current = history.last.map { $0.endedBy == .ongoing ? $0.length(now: now) : 0 } ?? 0
        return (current, history.map { $0.length(now: now) }.max() ?? 0)
    }

    /// Records a slip at the moment it happened (Build Plan #60d; report §10.4): an event with its own time, so runs,
    /// slip counts and the slip list have a history. Editing "Started" stays only for fixing a wrong start. A note, if
    /// written, is added to that day's note. Returns the entry, for Undo.
    @discardableResult
    func logSlip(_ habit: Habit, at moment: Date, note: String = "") -> UUID {
        let moment = min(moment, clock())
        let day = today(now: moment)
        let entry = Entry(habitID: habit.id, day: day, value: 1, createdAt: moment)
        perform { [self] telemetry in
            try await repository.addEntry(entry: entry.record)
            analyticsTracked(entry, ticket: telemetry)
            withAnimation { insertEntry(entry) }
        }
        let note = TextLimit.clean(note, TextLimit.noteText)
        if !note.isEmpty {
            let existing = self.note(of: habit, on: day)
            setNote(existing.map { $0 + "\n" + note } ?? note, of: habit, on: day)
        }
        return entry.id
    }

    /// Sets (or, with nil, clears) what a quit habit cost a day.
    func setCost(_ cost: HabitCost?, of habit: Habit) {
        let key = Keys.costPrefix + habit.id.uuidString
        perform { [self] telemetry in
            if let cost, cost.amount > 0 {
                let json = String(decoding: try JSONEncoder().encode(cost), as: UTF8.self)
                try await repository.saveSetting(key: key, value: json)
                costs[habit.id] = cost
            } else {
                try await repository.removeSetting(key: key)
                costs[habit.id] = nil
            }
        }
    }

    // MARK: Groups

    /// Adds a group or saves an edited one. Its habits leave any other group: a habit is in one group at a time.
    func saveGroup(_ group: HabitGroup) {
        var group = group
        group.name = TextLimit.clean(group.name, TextLimit.group)
        guard !group.name.isEmpty else { return }
        perform { [self] telemetry in
            let newGroup = !groups.contains { $0.id == group.id }
            let members = Set(group.habits)
            var list = groups
            for i in list.indices where list[i].id != group.id { list[i].habits.removeAll { members.contains($0) } }
            if let i = list.firstIndex(where: { $0.id == group.id }) { list[i] = group } else { list.append(group) }
            try await storeGroups(list, manual: groupsManual)
            if newGroup { analytics.count(.groupCreated, ticket: telemetry) }
        }
    }

    /// Deletes a group. Its habits stay, with no group, and keep all their history.
    func deleteGroup(_ id: UUID) {
        perform { [self] telemetry in
            try await storeGroups(groups.filter { $0.id != id }, manual: groupsManual)
        }
    }

    /// Puts a habit in a group, or in none; it leaves the group it was in.
    func setGroup(_ groupID: UUID?, of habitID: UUID) {
        perform { [self] telemetry in
            guard groupOf[habitID] != groupID else { return }
            var list = groups
            for i in list.indices {
                list[i].habits.removeAll { $0 == habitID }
                if list[i].id == groupID { list[i].habits.append(habitID) }
            }
            try await storeGroups(list, manual: groupsManual)
            analytics.count(.groupAssigned, ticket: telemetry)
        }
    }

    /// Dragging a group sets the person's own order ("Your order"), used everywhere groups are listed (report 24).
    func moveGroups(from: IndexSet, to: Int) {
        var list = groups
        list.move(fromOffsets: from, toOffset: to)
        perform { [self] telemetry in try await storeGroups(list, manual: true) }
    }

    /// Back to A to Z.
    func sortGroupsAZ() {
        perform { [self] telemetry in try await storeGroups(groups, manual: false) }
    }

    /// Writes the groups and shows them: A to Z unless the order is the person's own, each habit in one group only.
    private func storeGroups(_ list: [HabitGroup], manual: Bool) async throws {
        var seen = Set<UUID>()
        var cleaned = list.map { group -> HabitGroup in
            var group = group
            group.habits = group.habits.filter { seen.insert($0).inserted }
            return group
        }
        if !manual { cleaned = HabitGroup.sortedAZ(cleaned) }
        if cleaned.isEmpty {
            try await repository.removeSetting(key: Keys.groups)
        } else {
            let json = String(decoding: try JSONEncoder().encode(cleaned), as: UTF8.self)
            try await repository.saveSetting(key: Keys.groups, value: json)
        }
        if manual { try await repository.saveSetting(key: Keys.groupsOrder, value: "manual") }
        else { try await repository.removeSetting(key: Keys.groupsOrder) }
        withAnimation { applyGroups(cleaned, manual: manual) }
    }

    private func applyGroups(_ list: [HabitGroup], manual: Bool) {
        groups = list
        groupsManual = manual
        var map: [UUID: UUID] = [:]
        for group in list { for id in group.habits where map[id] == nil { map[id] = group.id } }
        groupOf = map
    }

    // MARK: Loading

    /// Reads everything from the database. Rows this version can't read are skipped, never deleted.
    func load() async {
        do {
            let snapshot = try await repository.load()
            let steps = Dictionary(grouping: snapshot.steps, by: \.habitId)
            let reminders = Dictionary(grouping: snapshot.reminders, by: \.habitId)
            habits = snapshot.habits.compactMap { Habit(record: $0, steps: steps[$0.id] ?? [], reminders: reminders[$0.id] ?? []) }
            let liveHabitIDs = Set(habits.map(\.id))
            entries = snapshot.entries.compactMap { record in
                guard let entry = Entry(record: record), liveHabitIDs.contains(entry.habitID) else { return nil }
                return entry
            }
            entriesReplaced()
            clearLogOffer()
            var loaded = DaySettings()
            var running: [UUID: Date] = [:]
            var runningSlots: [UUID: String] = [:]
            var loadedSkips: [UUID: Set<LocalDay>] = [:]
            var loadedMoves: [UUID: [LocalDay: LocalDay]] = [:]
            var loadedPauses: [UUID: [HabitPause]] = [:]
            var loadedRules: [UUID: [HabitRule]] = [:]
            var loadedHabitNotes: [UUID: [LocalDay: String]] = [:]
            var loadedDayNotes: [LocalDay: String] = [:]
            var loadedDescriptions: [UUID: String] = [:]
            var loadedArchived: [UUID: LocalDay] = [:]
            var loadedCosts: [UUID: HabitCost] = [:]
            var loadedGroups: [HabitGroup] = []
            var manualGroups = false
            var loadedCards: [String] = []
            sections = DaySection.defaults
            var upgradedV1 = false, repaired = false
            settingKeys = Set(snapshot.settings.map(\.key))
            for setting in snapshot.settings {
                switch setting.key {
                case Keys.placementV1: upgradedV1 = true
                case Keys.placementV2: repaired = true
                case Keys.dayEndHour: loaded.dayEndHour = min(12, max(0, Int(setting.value) ?? 0))
                case Keys.weekStart:
                    if let day = Int(setting.value), (1...7).contains(day) { loaded.weekStart = day; loaded.weekStartChosen = true }
                case Keys.groups:
                    loadedGroups = (try? JSONDecoder().decode([HabitGroup].self, from: Data(setting.value.utf8))) ?? []
                case Keys.groupsOrder: manualGroups = setting.value == "manual"
                case Keys.cardOrder:
                    loadedCards = (try? JSONDecoder().decode([String].self, from: Data(setting.value.utf8))) ?? []
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
                    if setting.key.hasPrefix(Keys.costPrefix), let id = UUID(uuidString: String(setting.key.dropFirst(Keys.costPrefix.count))),
                       let cost = try? JSONDecoder().decode(HabitCost.self, from: Data(setting.value.utf8)) {
                        loadedCosts[id] = cost
                        continue
                    }
                    if setting.key.hasPrefix(Keys.archivedPrefix), let id = UUID(uuidString: String(setting.key.dropFirst(Keys.archivedPrefix.count))),
                       let day = LocalDay(key: setting.value) {
                        loadedArchived[id] = day
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
                    if setting.key.hasPrefix(Keys.movePrefix),
                       let id = UUID(uuidString: String(setting.key.dropFirst(Keys.movePrefix.count))) {
                        var moves: [LocalDay: LocalDay] = [:]
                        for pair in setting.value.split(separator: ",") {
                            let days = pair.split(separator: ">").compactMap { LocalDay(key: String($0)) }
                            if days.count == 2 { moves[days[0]] = days[1] }
                        }
                        if !moves.isEmpty { loadedMoves[id] = moves }
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
            watchTimerGoals()
            skips = loadedSkips
            taskMoves = loadedMoves
            pauses = loadedPauses
            rules = loadedRules
            habitNotes = loadedHabitNotes
            dayNotes = loadedDayNotes
            descriptions = loadedDescriptions
            costs = loadedCosts
            cardOrder = loadedCards
            applyGroups(manualGroups ? loadedGroups : HabitGroup.sortedAZ(loadedGroups), manual: manualGroups)
            // Habits archived before archive dates were kept: the day after their last log (or their first day), so
            // their history stays and nothing after it counts.
            let archivedHabits = habits.filter(\.archived)
            let archivedIDs = Set(archivedHabits.map(\.id))
            let lastLogged = Dictionary(entries.filter { archivedIDs.contains($0.habitID) }.map { ($0.habitID, $0.day) },
                                        uniquingKeysWith: { max($0, $1) })
            for habit in archivedHabits where loadedArchived[habit.id] == nil {
                loadedArchived[habit.id] = lastLogged[habit.id].map { $0.adding(days: 1, calendar: calendar) } ?? startDay(of: habit)
            }
            archivedOn = loadedArchived.filter { archivedIDs.contains($0.key) }
            isStorageReady = databaseOpened
            isLoaded = true
            dataVersion &+= 1
            if upgradedV1 && !repaired && !triedPlacementUpgrade { triedPlacementUpgrade = true; repairPlacement() }
            if !settingKeys.contains(Keys.orderV1) && !triedOrderUpgrade { triedOrderUpgrade = true; keepShownOrder() }
            onChange?()
        } catch {
            isStorageReady = false
            problem = "Your habits couldn't be read. Nothing has been changed; please restart the app."
        }
    }

    /// The settings saved when last loaded, so a one-time step can check its marker without reading the database again.
    @ObservationIgnored private var settingKeys: Set<String> = []

    private enum Keys {
        static let dayEndHour = "day_end_hour"
        static let weekStart = "week_start"
        static let timerPrefix = "timer."
        static let skipPrefix = "skip."
        static let movePrefix = "move."
        static let pausePrefix = "pause."
        static let rulesPrefix = "rules."
        static let notePrefix = "note."
        static let dayNotePrefix = "daynote."
        static let descriptionPrefix = "desc."
        static let archivedPrefix = "archived."
        static let costPrefix = "cost."
        static let groups = "groups"
        static let groupsOrder = "groups_order"
        static let sections = "day_sections"
        static let placementV1 = "placement_v1"
        static let placementV2 = "placement_v2"
        /// Where Anytime and Quitting sit among the times of day on Today (`todayCards`).
        static let cardOrder = "today_order"
        /// Once: the order Today showed (timed rows by reminder time) became the saved order (`keepShownOrder`).
        static let orderV1 = "order_v1"
    }

    /// Once: development builds briefly let times place habits, and turned a habit in several times
    /// of day into one with a silent time in each. Put those back in their times of day.
    private func repairPlacement() {
        perform { [self] telemetry in
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
            case .invalid: "Choose an Often Enough backup file. Your current data has not been changed."
            case .newerVersion: "This backup was made by a newer version of Often Enough. Update the app before restoring it."
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
        let url = directory.appendingPathComponent("Often Enough Backup \(today(now: now).key).db")
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

    /// Runs database writes one at a time, in the order they were made. A logging tap has already changed memory
    /// (`addLogged`, `removeLogged`); other changes write first and update memory after.
    private func perform(_ change: @escaping @MainActor (AnalyticsTicket?) async throws -> Void) {
        // Writing before the data has been read could save beside, or over, what's really there.
        guard isLoaded else {
            problem = "Your habits haven't loaded, so that change wasn't saved. Please restart the app."
            return
        }
        let telemetryTicket = analytics.ticket
        let previous = writeQueue
        pendingWrites += 1
        writeQueue = Task { @MainActor in
            defer { pendingWrites -= 1 }
            await previous?.value
            #if DEBUG
            // Exercise navigation against deliberately slow storage without touching the user's database.
            if ProcessInfo.processInfo.arguments.contains("-uitest"),
               ProcessInfo.processInfo.arguments.contains("-focus-slow-writes"), TimerPresence.playerOpen {
                try? await Task.sleep(for: .seconds(4))
            }
            #endif
            guard self.isStorageReady else {
                self.problem = "Your data couldn't be opened. Nothing has been changed; please restart the app."
                return
            }
            do {
                try await change(telemetryTicket)
                analytics.reliability("storage", succeeded: true, ticket: telemetryTicket)
                dataVersion &+= 1
                onChange?()
            } catch {
                analytics.reliability("storage", succeeded: false, ticket: telemetryTicket)
                problem = "That change couldn't be saved, so it was undone. Please try again."
                reloadWhenWritten = true
            }
            // Taps shown before they're written: reload only after the last queued write, so what's shown is
            // exactly what's stored.
            if reloadWhenWritten && pendingWrites == 1 {
                reloadWhenWritten = false
                await load()
                // A tap made while reloading is on screen but not yet written; the reload may have hidden it. Reload
                // again after its write, so the screen ends up showing exactly what's stored.
                if pendingWrites > 1 { reloadWhenWritten = true }
            }
        }
    }
    @ObservationIgnored private var pendingWrites = 0
    @ObservationIgnored private var reloadWhenWritten = false

    /// Waits for every pending change to reach the database.
    func flush() async {
        repeat { await writeQueue?.value } while pendingWrites > 0
    }

    /// Re-reads everything after sync merged in other devices' changes. It waits its turn behind local changes,
    /// so a change being saved right now is neither lost nor shown twice.
    func reloadAfterSync() {
        perform { [self] _ in await load() }
    }

    func add(_ habit: Habit, suggestion: Bool = false) {
        perform { [self] telemetry in
            guard !habits.contains(where: { $0.id == habit.id }) else { return }
            try await repository.saveHabit(habit: habit.record(position: habits.count), steps: habit.stepRecords(),
                                           reminders: habit.reminderRecords(), at: Date.now.millis)
            withAnimation { habits.append(habit) }
            analytics.created(habit.analyticsType, suggestion: suggestion, ticket: telemetry)
        }
    }

    // MARK: All Habits: archive, restore, delete, reorder

    /// Stops habits for good but keeps all their history (Feature Ledger C016: people delete only because there's no
    /// archive, and lose everything). An archived habit frees its free slot (C219). A running timer is saved first.
    func archive(_ list: [Habit]) {
        for habit in list where timers[habit.id] != nil { stopTimer(habit, on: today()) }
        perform { [self] telemetry in
            let day = today()
            for habit in list {
                guard let i = habits.firstIndex(where: { $0.id == habit.id }), !habits[i].archived else { continue }
                var h = habits[i]
                h.archived = true
                // The day it stops counting: its history before today stays as it was (Build Plan #60c).
                try await repository.saveSetting(key: Keys.archivedPrefix + h.id.uuidString, value: day.key)
                try await repository.saveHabit(habit: h.record(position: i), steps: h.stepRecords(),
                                               reminders: h.reminderRecords(), at: Date.now.millis)
                withAnimation {
                    archivedOn[h.id] = day
                    habits[i] = h
                }
                analytics.count(.archived, ticket: telemetry)
            }
        }
    }

    /// Brings an archived habit back, if there's a free slot (or Plus). False when the free limit is reached.
    @discardableResult
    func restore(_ habit: Habit) -> Bool {
        guard habit.kind == .task || canAddHabit else { return false }
        perform { [self] telemetry in
            guard let i = habits.firstIndex(where: { $0.id == habit.id }) else { return }
            var h = habits[i]
            h.archived = false
            // The archived stretch becomes a pause, so those days stay neutral: never "not done" (Build Plan #60c).
            let now = Date.now
            let yesterday = today(now: now).adding(days: -1, calendar: calendar)
            var list = pauses[h.id] ?? []
            if let from = archivedOn[h.id], from <= yesterday {
                list.append(HabitPause(from: from, through: yesterday, pausedAt: dayStart(from), resumedAt: now))
                list.sort { $0.from < $1.from }
                let json = String(decoding: try JSONEncoder().encode(list), as: UTF8.self)
                try await repository.saveSetting(key: Keys.pausePrefix + h.id.uuidString, value: json)
            }
            try await repository.removeSetting(key: Keys.archivedPrefix + h.id.uuidString)
            try await repository.saveHabit(habit: h.record(position: i), steps: h.stepRecords(),
                                           reminders: h.reminderRecords(), at: Date.now.millis)
            withAnimation {
                archivedOn[h.id] = nil
                pauses[h.id] = list.isEmpty ? nil : list
                habits[i] = h
            }
        }
        return true
    }

    /// Deletes habits and their history. The row is kept as a tombstone (never hard-deleted, so a later sync can't
    /// bring it back); nothing of it shows again.
    func delete(_ list: [Habit]) {
        for habit in list where timers[habit.id] != nil { stopTimer(habit, on: today()) }
        perform { [self] telemetry in
            for habit in list {
                guard let i = habits.firstIndex(where: { $0.id == habit.id }) else { continue }
                try await repository.saveHabit(habit: habits[i].record(position: i, deleted: true), steps: [],
                                               reminders: [], at: Date.now.millis)
                withAnimation {
                    analytics.count(habit.kind == .task ? .taskDeleted : .deleted, ticket: telemetry)
                    habits.remove(at: i)
                    for i in entries.indices.reversed() where entries[i].habitID == habit.id { removeEntry(at: i) }
                    habitNotes.removeValue(forKey: habit.id)
                    descriptions.removeValue(forKey: habit.id)
                    rules.removeValue(forKey: habit.id)
                    pauses.removeValue(forKey: habit.id)
                    skips.removeValue(forKey: habit.id)
                    if noteOffer?.habit == habit.id { noteOffer = nil }
                    if noteTarget?.habit == habit.id { noteTarget = nil }
                }
            }
        }
    }

    /// Puts `ids` (one group in All Habits, or one card on Today) in this order, keeping every other habit where it is.
    /// Today follows it. The list changes at once, so a dragged row stays where it was dropped; the write follows
    /// (Rulebook S7), saving each moved habit as it is when the write runs.
    func reorder(_ ids: [UUID]) {
        let wanted = Set(ids)
        let slots = habits.indices.filter { wanted.contains(habits[$0].id) }
        var next = habits
        for (slot, id) in zip(slots, ids) { if let h = habits.first(where: { $0.id == id }) { next[slot] = h } }
        let moved = Set(next.indices.filter { next[$0].id != habits[$0].id }.map { next[$0].id })
        guard !moved.isEmpty else { return }
        habits = next
        perform { [self] telemetry in
            for i in habits.indices where moved.contains(habits[i].id) {
                try await repository.saveHabit(habit: habits[i].record(position: i), steps: habits[i].stepRecords(),
                                               reminders: habits[i].reminderRecords(), at: Date.now.millis)
            }
            analytics.count(.reorder, ticket: telemetry)
        }
    }

    // MARK: A habit's own page

    /// How one day reads in a habit's calendar. Never a harsh mark for a miss (C095): a missed day is just the number.
    enum DayMark { case done, some, missed, open, skipped, paused, notItsDay, upcoming, before }

    func dayMark(_ habit: Habit, on day: LocalDay, relativeTo reference: LocalDay? = nil) -> DayMark {
        let today = reference ?? self.today()
        if day < startDay(of: habit) { return .before }
        if isPaused(habit, on: day) { return .paused }
        if isSkipped(habit, on: day) { return .skipped }
        if day > today { return isDue(habit, on: day) ? .upcoming : .notItsDay }
        let rule = rule(habit, on: day)
        // A week or month goal has no failed day: a day with something logged shows it, others are neutral. A
        // week or month limit's logged day is "some", never "done": a limit is never celebrated.
        if !rule.frequency.isDayBased || rule.frequency.isFlexible {
            if dayProgress(of: rule, on: day) > 0 {
                if rule.atMost { return .some }
                return isDayMet(rule, on: day) || !rule.frequency.isFlexible ? .done : .some
            }
            return day == today && isDue(habit, on: day) ? .open : .notItsDay
        }
        guard isDue(habit, on: day) else { return .notItsDay }
        // A daily limit is judged when the day is over (Build Plan #60b): today it's open, or "some" once something
        // is logged; afterwards within the limit is done, and over it is an empty mark, never a harsh one.
        if rule.atMost {
            if day == today { return dayProgress(of: rule, on: day) > 0 ? .some : .open }
            return isDayMet(rule, on: day) ? .done : .missed
        }
        if isDayMet(rule, on: day) { return .done }
        if dayProgress(of: rule, on: day) > 0 { return .some }
        return day == today ? .open : .missed
    }

    /// A run of met days (or weeks, months or years) in a row. `end` is the last day of its last met period, up to
    /// today.
    struct Run: Hashable, Sendable {
        let start: LocalDay
        let end: LocalDay
        let length: Int
        let isCurrent: Bool
    }

    /// Every run, oldest first, walked the same way as `streak`: paused, skipped and other days are neutral, a week
    /// or month with a pause can't end a run, and a change to the kind of period ends it (report §16.5). The last one
    /// is current when nothing has ended it, and then its length is `streak(of:asOf: today)`.
    func runs(of habit: Habit, today: LocalDay? = nil) -> [Run] {
        guard habit.kind != .quit, habit.kind != .task else { return [] }
        let now = self.today()
        let today = today ?? now
        // Remembered for today, unless a running timer can still finish today (as the best streak always was).
        let remember = today == now && isSaved(habit) && timers[habit.id] == nil
        if remember, let known = runLists[habit.id], known.today == today { readInputs(of: habit.id); return known.runs }
        let runs = walkRuns(of: habit, today: today)
        if remember { runLists[habit.id] = (today, runs) }
        return runs
    }

    private func walkRuns(of habit: Habit, today: LocalDay) -> [Run] {
        let kind = periodKind(rule(habit, on: today))
        var runs: [Run] = []
        var start: LocalDay?, end: LocalDay?, length = 0
        func close() {
            if let start, let end, length > 0 { runs.append(Run(start: start, end: end, length: length, isCurrent: false)) }
            start = nil; end = nil; length = 0
        }
        func extend(_ from: LocalDay, _ to: LocalDay) {
            if start == nil { start = from }
            end = to
            length += 1
        }
        var day = startDay(of: habit)
        if kind != .day {
            while day <= today {
                let rule = rule(habit, on: day)
                guard periodKind(rule) == kind, let range = periodRange(rule, containing: day) else {
                    close()
                    day = day.adding(days: 1, calendar: calendar)
                    continue
                }
                let running = range.upperBound >= today
                // A limit's week or month counts once it's over; the one running now never ends a run.
                if !(rule.atMost && running) && isPeriodMet(habit, on: day) {
                    extend(max(range.lowerBound, startDay(of: habit)), min(range.upperBound, today))
                } else if !running && !hasPause(habit, in: range) {
                    close()
                }
                day = range.upperBound.adding(days: 1, calendar: calendar)
            }
        } else {
            while day <= today {
                let rule = rule(habit, on: day)
                if periodKind(rule) != .day {
                    close()
                } else if day == today {
                    // Today adds once it's done (even on an extra day), and never ends a run; a limit waits for the
                    // day to end. The same as `streak`.
                    if !rule.atMost && isDayMet(habit, on: day) { extend(day, day) }
                } else if isDue(habit, on: day) {
                    if isDayMet(habit, on: day) { extend(day, day) } else { close() }
                }
                day = day.adding(days: 1, calendar: calendar)
            }
        }
        if let start, let end, length > 0 { runs.append(Run(start: start, end: end, length: length, isCurrent: true)) }
        return runs
    }

    /// The longest streak so far, from `runs`, so the best, the run list and the current streak always agree.
    /// Remembered for today, unless a running timer can still finish today.
    func bestStreak(of habit: Habit) -> Int {
        guard habit.kind != .quit, habit.kind != .task else { return 0 }
        return runs(of: habit).map(\.length).max() ?? 0
    }

    /// "Goal met 12 weeks since 3 Mar 2026", "1,240 glasses in all since …": the habit page's total, which walks the
    /// habit's whole history, so it's remembered like the best streak (PERFORMANCE.md rule 5). The page asked for it
    /// in `body`, so every redraw (a month changed in its calendar) walked the history again (1 Oct 2026).
    func totalLine(of habit: Habit, today: LocalDay? = nil) -> String? {
        let today = today ?? self.today()
        let remember = isSaved(habit) && timers[habit.id] == nil
        if remember, let known = totalLines[habit.id], known.today == today { readInputs(of: habit.id); return known.line }
        let line = workOutTotalLine(of: habit, today: today)
        if remember { totalLines[habit.id] = (today, line) }
        return line
    }

    // MARK: Notes

    func note(of habit: Habit, on day: LocalDay) -> String? { habitNotes[habit.id]?[day] }
    /// Whether the habit has any note, without sorting them (every row's menu asks).
    func hasNotes(_ habit: Habit) -> Bool { habitNotes[habit.id]?.isEmpty == false }
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
        perform { [self] telemetry in
            // Keep an empty value so restoring an older backup cannot resurrect this removed note.
            try await repository.saveSetting(key: key, value: text)
            habitNotes[habit.id, default: [:]][day] = text.isEmpty ? nil : text
            analytics.count(.noteSaved, ticket: telemetry)
        }
    }

    func setDayNote(_ text: String, on day: LocalDay) {
        let text = TextLimit.clean(text, TextLimit.noteText)
        let key = Keys.dayNotePrefix + day.key
        perform { [self] telemetry in
            try await repository.saveSetting(key: key, value: text)
            dayNotes[day] = text.isEmpty ? nil : text
            analytics.count(.noteSaved, ticket: telemetry)
        }
    }

    func setDescription(_ text: String, of id: UUID) {
        let text = TextLimit.clean(text, TextLimit.descriptionText)
        guard text != (descriptions[id] ?? "") else { return }
        let key = Keys.descriptionPrefix + id.uuidString
        perform { [self] telemetry in
            try await repository.saveSetting(key: key, value: text)
            descriptions[id] = text.isEmpty ? nil : text
            analytics.count(.noteSaved, ticket: telemetry)
        }
    }

    // MARK: Editing (spec §8)

    /// Saves an edited habit. Changes apply from today: if what judges a day changed (goal, how often, unit,
    /// checklist steps), the rule it had is kept for every day before today, so past days keep their result.
    /// Editing twice in a day keeps the rule from before today.
    func update(_ habit: Habit) {
        perform { [self] telemetry in
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
            if old.frequency != habit.frequency { analytics.count(.scheduleEdited, ticket: telemetry) }
            if old.goal != habit.goal || old.atMost != habit.atMost { analytics.count(.goalEdited, ticket: telemetry) }
            if old.reminders != habit.reminders || old.remind != habit.remind { analytics.count(.reminderEdited, ticket: telemetry) }
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

    /// Yes/no habits: log once, or undo the last log for this day. A week, month or year count only ever adds one:
    /// every ✓ counts, even two on one day (Current Work 54).
    func toggleCheck(_ habit: Habit, on day: LocalDay, source: EntrySource = .today) {
        if habit.kind == .task { return toggleTask(habit, on: day, source: source) }
        if !rule(habit, on: day).frequency.isDayBased { return addProgress(habit, value: 1, on: day, source: source) }
        if isTicked(habit, on: day) { undoLast(habit, on: day) } else { log(habit, value: 1, on: day, source: source) }
    }

    /// A once-a-day check's ✓ for one day (the user, 3 Oct 2026: one mental model on every row): ticked when that day
    /// is done. Report "Today's Rows".
    func isTicked(_ habit: Habit, on day: LocalDay) -> Bool {
        isDone(habit, on: day)
    }

    /// A check habit that counts up, like an amount: its button adds one each tap and never takes one back (Undo,
    /// named, does that). Report "Today's Rows — Tap, Swipe, the Day Sheet and Delete". Ticked several times a day, or
    /// N times a week, month or year (the user, 6 Oct 2026: "they might call two times this day"; the form already
    /// says every ✓ counts, even two on one day), so its button fills only when the goal is met (Current Work 54).
    func countsUp(_ habit: Habit, on day: LocalDay) -> Bool {
        let rule = rule(habit, on: day)
        guard rule.kind == .check else { return false }
        return !rule.frequency.isDayBased || dayGoal(of: rule) > 1
    }

    /// Tasks: done or not. A one-time task wherever it's shown; a repeating one on that day.
    private func toggleTask(_ habit: Habit, on day: LocalDay, source: EntrySource) {
        if let i = entries.lastIndex(where: { $0.habitID == habit.id && (habit.dueDay != nil || $0.day == day) }) {
            removeLogged(at: i)
        } else {
            log(habit, value: 1, on: day, source: source)
        }
    }

    /// Quick counts always add; undo is a separate, explicit action.
    func increment(_ habit: Habit, on day: LocalDay, source: EntrySource = .today) {
        guard let value = habit.quickIncrement else { return }
        addProgress(habit, value: value, on: day, source: source)
    }

    /// `time` is when it happened, for a log added by hand (Add log, Add a check): kept inside `day` as the app counts
    /// it and never later than now (`logTime`). Without one, the log is stamped now, or at the same clock time on an
    /// earlier day (7 Oct 2026: a past day's log carried today's clock time). The day is always `day` (D7).
    func addProgress(_ habit: Habit, value: Double, on day: LocalDay, at time: Date? = nil, source: EntrySource = .today) {
        guard value.isFinite, value > 0, value <= GoalNumber.maximum, day <= today() else { return }
        log(habit, value: value, on: day, at: time, source: source)
    }

    /// The moment a log of `day` is stamped with: `time` kept inside that day's bounds as the app counts them
    /// (`dayBounds`, so a 3 AM day start allows 1:30 AM the next morning) and never later than now. The day itself
    /// never changes; a time outside it is pulled to its nearest edge, never moved to another day (D7, U19).
    func logTime(_ time: Date, on day: LocalDay, calendar recordingCalendar: Calendar? = nil) -> Date {
        let bounds = dayBounds(day, calendar: recordingCalendar)
        let upper = max(bounds.lowerBound, min(bounds.upperBound, clock()))
        return min(max(time, bounds.lowerBound), upper)
    }

    /// `time`'s clock time (hours, minutes, seconds) on `day`, inside that day: what a picker shows when another day is
    /// chosen ("choosing another day keeps the same clock time"). Worked out on the wall clock, never by adding hours
    /// (D7): a time before the day's start belongs to the next calendar date of the same tracking day.
    func sameClockTime(as time: Date, on day: LocalDay) -> Date {
        let c = calendar
        let parts = c.dateComponents([.hour, .minute, .second], from: time)
        let date = day.date(calendar: c)
        var moment = c.date(bySettingHour: parts.hour ?? 0, minute: parts.minute ?? 0, second: parts.second ?? 0, of: date) ?? date
        if moment < dayBounds(day).lowerBound, let next = c.date(byAdding: .day, value: 1, to: date),
           let later = c.date(bySettingHour: parts.hour ?? 0, minute: parts.minute ?? 0, second: parts.second ?? 0, of: next) {
            moment = later
        }
        return logTime(moment, on: day)
    }

    func undoProgress(_ habit: Habit, on day: LocalDay) {
        undoLast(habit, on: day)
    }

    /// Player feedback undoes the exact tap, even if another surface logged since then.
    func undoEntry(_ id: UUID) {
        guard let i = entries.firstIndex(where: { $0.id == id }) else { return }
        removeLogged(at: i)
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
        perform { [self] telemetry in
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
            let entry = Entry(id: id, habitID: habit.id, day: day, value: value, createdAt: now, slot: slot, source: .reminder)
            try await repository.addEntry(entry: entry.record)
            analyticsTracked(entry, ticket: telemetry)
            withAnimation { insertEntry(entry) }
        }
    }

    /// A widget's button (Accepted Widget Contract): one deliberate tap is one change, committed before any widget shows
    /// it. `mode` is what the drawn button said: "check" ticks, "uncheck" takes that day's tick back (U14), "add" adds
    /// one saved step (+1 stays +1 above the goal). The event is the tap's identity: a retried callback never logs twice,
    /// and an uncheck only removes a tick that is still there. A tap from an old day, an edited habit, a paused, skipped
    /// or archived one, or with widget privacy on, changes nothing (D7).
    func logFromWidget(id: UUID, day: LocalDay, event: UUID, signature: String, mode: String = "add", now: Date = .now) {
        perform { [self] telemetry in
            guard problem == nil, !AppLock.isEnabled, !UserDefaults.standard.bool(forKey: WidgetDisk.privacyKey),
                  day == today(now: now), let habit = habits.first(where: { $0.id == id }),
                  !habit.archived, !isPaused(habit, on: day), !isSkipped(habit, on: day),
                  startDay(of: habit) <= day, isDue(habit, on: day, now: now),
                  signature == Self.widgetSignature(habit) else { throw WidgetActionError.stale }
            guard !(try await repository.hasEntry(id: event.uuidString)).boolValue else { return }
            let rule = rule(habit, on: day)
            let single = (rule.kind == .check && slots(of: habit).isEmpty && !countsUp(habit, on: day)) || rule.kind == .task
            // LOCKED (widget taps, 8 Oct 2026): taps are saved as "add" (own ID) or "check"/"uncheck" (absolute), never re-flipped twice (W4). Read iOS/Docs/Widgets — Taps and Updates (Locked).md before changing; changes need the user's say-so.
            // "flip": a widget ✓ switch (Current Work 66). Each tap changes the day from what's saved now, in the order
            // the taps came (they're saved one after another), so two quick taps end unticked, as the switch shows.
            // iOS doesn't reliably hand a switch's new state to the intent on a second quick tap.
            var mode = mode
            if mode == "flip" { mode = (rule.kind == .task ? isDone(habit, on: day) : isTicked(habit, on: day)) ? "uncheck" : "check" }
            switch mode {
            case "uncheck":
                guard single, rule.kind == .task ? isDone(habit, on: day) : isTicked(habit, on: day) else { return }
                guard let entry = entries.last(where: { $0.habitID == id && $0.stepID == nil
                    && (rule.kind == .task && habit.dueDay != nil ? true : $0.day == day) }) else { return }
                try await repository.removeEntry(id: entry.id.uuidString, at: now.millis)
                analytics.count(.undo, ticket: telemetry)
                if let index = entries.firstIndex(where: { $0.id == entry.id }) { removeEntry(at: index) }
                return
            case "check":
                // Already ticked (a second tap that raced the first): nothing to add.
                guard single, !(rule.kind == .task ? isDone(habit, on: day) : isTicked(habit, on: day)) else { return }
            default:
                guard !single else { throw WidgetActionError.stale }
            }
            let value: Double
            switch rule.kind {
            case .check, .task: value = 1
            case .amount:
                guard let step = rule.quickIncrement, step.isFinite, step > 0, step <= GoalNumber.maximum else {
                    throw WidgetActionError.openApp
                }
                value = step
            default: throw WidgetActionError.openApp
            }
            let slot = slots(of: habit).first { !isSlotDone(habit, slot: $0, on: day) }
            let entry = Entry(id: event, habitID: id, day: day, value: value, createdAt: now, slot: slot, source: .widget)
            try await repository.addEntry(entry: entry.record)
            analyticsTracked(entry, ticket: telemetry)
            insertEntry(entry)
        }
    }

    /// A widget's ▶ or ⏸ for a timed habit (the same timer as Today's row and the Live Activity). ▶ only starts and ⏸
    /// only stops, so a retried callback never undoes itself. Returns false when the tap is stale.
    @discardableResult
    func timerFromWidget(id: UUID, day: LocalDay, start: Bool, signature: String, now: Date = .now) -> Bool {
        guard problem == nil, isStorageReady, !AppLock.isEnabled, !UserDefaults.standard.bool(forKey: WidgetDisk.privacyKey),
              day == today(now: now), let habit = habits.first(where: { $0.id == id }), !habit.archived,
              rule(habit, on: day).kind == .duration, !isPaused(habit, on: day), !isSkipped(habit, on: day),
              isDue(habit, on: day, now: now), signature == Self.widgetSignature(habit) else {
            // A ⏸ always saves a running timer, even after an edit: stopping never loses time.
            if !start, let habit = habits.first(where: { $0.id == id }), timers[id] != nil { toggleTimer(habit); return true }
            return false
        }
        if start == (timers[id] == nil) { toggleTimer(habit) }
        return true
    }

    /// A habit in several sections: tick or untick only this section's row.
    func toggleSlot(_ habit: Habit, slot: String, on day: LocalDay, source: EntrySource = .today) {
        if let i = entries.lastIndex(where: { $0.habitID == habit.id && $0.slot == slot && $0.day == day }) {
            removeLogged(at: i)
        } else {
            addLogged(Entry(habitID: habit.id, day: day, value: 1, slot: slot, source: source))
        }
    }

    func toggleStep(_ step: Step, of habit: Habit, on day: LocalDay, at time: Date? = nil, source: EntrySource = .today) {
        if let i = entries.lastIndex(where: { $0.habitID == habit.id && $0.stepID == step.id && $0.day == day }) {
            removeLogged(at: i)
        } else {
            addLogged(Entry(habitID: habit.id, stepID: step.id, day: day, value: 1, createdAt: stamp(time, on: day), source: source))
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
        watchTimerGoals()
        let key = Keys.timerPrefix + habit.id.uuidString
        let value = String(now.millis) + (slot.map { "|" + $0 } ?? "")
        perform { [self] telemetry in
            try await repository.saveSetting(key: key, value: value)
            analytics.count(.timerStarted, ticket: telemetry)
        }
    }

    /// An explicit stop is idempotent: navigating/closing cannot accidentally start a timer.
    /// A focus session supplies its tracking day, including when the day rolls over.
    func stopTimer(_ habit: Habit, on day: LocalDay, through end: Date = .now, source: EntrySource = .timer) {
        guard let start = timers[habit.id] else { return }
        let minutes = max(0, end.timeIntervalSince(start)) / 60
        let entry = minutes >= 1 / 60
            ? Entry(habitID: habit.id, day: day, value: minutes, slot: timerSlots[habit.id], source: source) : nil
        // Same as starting: the time shows as saved at once; the database write follows in order. The timer goes first,
        // so "complete before" counts only what was saved before this session.
        timers.removeValue(forKey: habit.id)
        timerSlots.removeValue(forKey: habit.id)
        let celebrated = timerGoalCelebrated.remove(habit.id) != nil
        let wasComplete = isComplete(habit, on: day)
        if let entry { insertEntry(entry); offerUndo(entry) }
        logFeedback(habit, on: day, wasComplete: wasComplete, celebrated: celebrated)
        let key = Keys.timerPrefix + habit.id.uuidString
        perform { [self] telemetry in
            try await repository.finishTimer(entry: entry?.record, key: key)
            analytics.count(.timerStopped, ticket: telemetry)
            if let entry { analyticsTracked(entry, ticket: telemetry) }
        }
    }

    /// Written-first logging, for changes made away from the screen (a notification's Done).
    private func logWritten(_ habit: Habit, value: Double, on day: LocalDay) async throws {
        let telemetry = analytics.ticket
        let entry = Entry(habitID: habit.id, day: day, value: value, source: .reminder)
        try await repository.addEntry(entry: entry.record)
            analyticsTracked(entry, ticket: telemetry)
        withAnimation { insertEntry(entry) }
    }

    private func log(_ habit: Habit, value: Double, on day: LocalDay, at time: Date? = nil, source: EntrySource) {
        addLogged(Entry(habitID: habit.id, day: day, value: value, createdAt: stamp(time, on: day), source: source))
    }

    /// When a new log of `day` happened: the chosen time inside that day; with none, now for today, and the same clock
    /// time on an earlier day.
    private func stamp(_ time: Date?, on day: LocalDay) -> Date {
        if let time { return logTime(time, on: day) }
        return day == today() ? .now : sameClockTime(as: clock(), on: day)
    }

    private func undoLast(_ habit: Habit, on day: LocalDay) {
        // Undo the latest log on this day; for week and month rules, the latest one in the period.
        let range = habit.frequency.isFlexible ? (day...day) : (periodRange(habit, containing: day) ?? (day...day))
        guard let i = entries.lastIndex(where: { $0.habitID == habit.id && $0.stepID == nil && range.contains($0.day) }) else { return }
        removeLogged(at: i)
    }

    /// A tap's entry: shown now, written next in the queue.
    private func addLogged(_ entry: Entry) {
        // Whether this tap finishes today: a natural pause, where the app may ask for a review (`ReviewPrompt`).
        // Worked out once per tap, never while drawing.
        let isToday = entry.day == today()
        let wasFull = isToday && todayScore(on: entry.day).isFull
        // Milestones (report "Milestones — Marking Progress Without Noise"): a streak's, while streaks are shown.
        let showStreaks = (UserDefaults.standard.object(forKey: ProgressOptions.showStreaks) as? Bool) ?? true
        let habit = habits.first { $0.id == entry.habitID }
        let streakBefore = showStreaks ? habit.map { streak(of: $0, asOf: today()) } : nil
        let wasComplete = habit.map { isComplete($0, on: entry.day) } ?? false
        withAnimation { insertEntry(entry); offerUndo(entry) }
        if let habit { logFeedback(habit, on: entry.day, wasComplete: wasComplete) }
        let score = isToday ? todayScore(on: entry.day) : nil
        if let score, !wasFull, score.isFull { dayFinishedAt = .now }
        milestoneOffer = nil
        if let habit, let before = streakBefore, habit.kind != .quit, habit.kind != .task {
            let unit = rule(habit, on: today()).frequency.streakUnit
            let now = streak(of: habit, asOf: today())
            if now > before, unit.isMilestone(now) {
                milestoneOffer = MilestoneOffer(entry: entry.id, habit: habit.id, day: entry.day, text: unit.inARow(now))
            }
        }
        if milestoneOffer == nil, let score, !wasFull, score.isFull, score.planned > 1 {
            milestoneOffer = MilestoneOffer(entry: entry.id, habit: entry.habitID, day: entry.day, text: "All \(score.planned) done today")
        }
        if let mark = milestoneOffer, UIAccessibility.isVoiceOverRunning {
            AccessibilityNotification.Announcement(mark.text).post()
        }
        perform { [self] telemetry in
            #if DEBUG
            // PersistenceUITests: a write that fails must take the tap back off the screen.
            if ProcessInfo.processInfo.arguments.contains("-fail-entry-writes") { throw CancellationError() }
            #endif
            try await repository.addEntry(entry: entry.record)
            analyticsTracked(entry, ticket: telemetry)
        }
    }

    /// Undoing a tap: gone from the screen now, the removal written next in the queue.
    private func removeLogged(at index: Int) {
        let id = entries[index].id
        let task = habits.first { $0.id == entries[index].habitID }?.kind == .task
        withAnimation { removeEntry(at: index) }
        if !timers.isEmpty { watchTimerGoals() }
        perform { [self] telemetry in
            try await repository.removeEntry(id: id.uuidString, at: Date.now.millis)
            analytics.count(.undo, ticket: telemetry)
            if task { analytics.count(.taskReopened, ticket: telemetry) }
        }
    }

    private func offerUndo(_ entry: Entry) {
        guard !TimerPresence.playerOpen, entry.source == .today || entry.source == .manual || entry.source == .timer else { return }
        undoOffer = entry
        noteOffer = .init(habit: entry.habitID, day: entry.day)
        if UIAccessibility.isVoiceOverRunning { AccessibilityNotification.Announcement("Logged. Undo is available.").post() }
    }

    /// Editing preserves identity, the tracking day, step, slot, time zone and source.
    /// The UI changes now; the guarded database update follows in the same write queue as add/delete.
    /// A log's time may change within its own tracking day (U19, 7 Oct 2026): every kind, not only slips. Never to
    /// another day (that needs the same record moved between days atomically, which doesn't exist yet), never later than
    /// now; a slip never before its quit run began. A time that breaks a rule changes nothing.
    func editEntry(_ id: UUID, value: Double, at date: Date? = nil) {
        guard value.isFinite, value > 0, value <= GoalNumber.maximum,
              let index = entries.firstIndex(where: { $0.id == id }),
              let habit = habits.first(where: { $0.id == entries[index].habitID }) else { return }
        var entry = entries[index]
        let kind = rule(habit, on: entry.day).kind
        guard entry.day <= today(), entry.stepID == nil, kind != .task else { return }
        if kind == .check, value.rounded() != value { return }
        let wasComplete = isComplete(habit, on: entry.day)
        entry.value = value
        if let date, date != entry.createdAt {
            guard dayBounds(entry.day, calendar: recordingCalendar(for: entry)).contains(date), date <= max(clock(), entry.createdAt) else { return }
            if kind == .quit, date < min(habit.quitSince ?? habit.createdAt, habit.createdAt) { return }
            entry.createdAt = date
        }
        replaceEntry(entry, at: index)
        logFeedback(habit, on: entry.day, wasComplete: wasComplete)
        let updated = entry
        perform { [self] telemetry in
            try await repository.editEntry(id: updated.id.uuidString, value: updated.value, createdAt: updated.createdAt.millis)
            analytics.count(.editEntry, ticket: telemetry)
        }
    }

    /// Explicit Done / Not done for a day's checks. Never touches another day's entries.
    func setDayDone(_ done: Bool, of habit: Habit, on day: LocalDay, at time: Date? = nil, source: EntrySource = .daySheet) {
        guard day <= today() else { return }
        let rule = rule(habit, on: day)
        if !done {
            let ids = rule.kind == .task && rule.dueDay != nil ? entries(of: habit.id).map(\.id) : entries(of: habit.id, on: day).map(\.id)
            for id in ids { undoEntry(id) }
        } else if rule.kind == .check {
            let missing = max(0, dayGoal(of: rule) - dayProgress(of: rule, on: day))
            if missing > 0 { log(habit, value: missing, on: day, at: time, source: source) }
        } else if rule.kind == .task, !isDone(rule, on: day) {
            log(habit, value: 1, on: day, at: time, source: source)
        }
    }

    func slip(_ habit: Habit, on day: LocalDay, at date: Date, source: EntrySource = .today) {
        guard habit.kind == .quit, day <= today(), dayBounds(day).contains(date),
              date <= clock(), date >= min(habit.quitSince ?? habit.createdAt, habit.createdAt) else { return }
        addLogged(Entry(habitID: habit.id, day: day, value: 1, createdAt: date, source: source))
    }

    /// Kept in the store and remembered, rather than walking the month's days in the page's body.
    func doneThisMonth(_ habit: Habit, through today: LocalDay) -> Int {
        readInputs(of: habit.id)
        if let known = monthCounts[habit.id], known.day == today, timers[habit.id] == nil { return known.value }
        let first = LocalDay(year: today.year, month: today.month, day: 1)
        var count = 0
        for offset in 0..<today.day {
            if dayMark(habit, on: first.adding(days: offset, calendar: calendar)) == .done { count += 1 }
        }
        if timers[habit.id] == nil { monthCounts[habit.id] = (today, count) }
        return count
    }
    @ObservationIgnored private var monthCounts: [UUID: (day: LocalDay, value: Int)] = [:]

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
        let arguments = ProcessInfo.processInfo.arguments
        if arguments.contains("-groups-demo") {
            // Groups to test and measure with (groups spec §5): three areas, one empty group, and habits with none.
            // The speed tests' copies ("Water 2") join their original's group.
            func members(_ names: [String]) -> [UUID] {
                habits.filter { habit in names.contains { habit.name == $0 || habit.name.hasPrefix($0 + " ") } }.map(\.id)
            }
            saveGroup(HabitGroup(name: "Health", color: .green,
                                 habits: members(["Water", "Stretch", "Brush teeth", "Meds", "Walk", "Floss", "Skincare"])))
            saveGroup(HabitGroup(name: "Mind", color: .purple, habits: members(["Read", "Meditate", "No screens", "Plan tomorrow"])))
            saveGroup(HabitGroup(name: "Home", color: .orange, habits: members(["Call family", "Bed by 23:00", "Smoking"])))
            saveGroup(HabitGroup(name: "Reading", color: .indigo))
            await flush()
        }
        if arguments.contains("-year-demo"), let swim = habits.first(where: { $0.name == "Swim" }) {
            // Year's pictures (2 Oct 2026): a few skipped days and a week's pause in Swim's year, both in the latest
            // weeks, so the card's first view (which opens on them) shows every kind of square.
            let today = today()
            for d in [10, 46, 88, 150, 230, 300] {
                let day = today.adding(days: -d, calendar: calendar)
                if isDue(swim, on: day) { setSkipped(swim, on: day, true) }
            }
            pause(swim, from: today.adding(days: -30, calendar: calendar), through: today.adding(days: -24, calendar: calendar))
            await flush()
        }
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
        // Checked against the settings already loaded: reading the whole database again cost every debug launch (30 Sep).
        guard isLoaded, !settingKeys.contains(key) else { return }
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
        perform { [self] telemetry in try await repository.saveSetting(key: key, value: "1") }
        await flush()
    }

    /// A fixture's database stays exactly as built: a later launch with no arguments (a widget's or a notification's
    /// cold background launch) must not add the set of every type above (found by the Home Screen widget test, 6 Oct 2026).
    func skipEveryTypeToAnytime() async {
        let key = "test_types_anytime_v1"
        perform { [self] _ in
            try await repository.saveSetting(key: key, value: "1")
            settingKeys.insert(key)
        }
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
        // Call family: each of the 4 weeks before this one met (3 calls); this week, up to 2 calls on days before today,
        // so on any weekday it's still to do today. Counting from today instead put a call inside this week on some
        // weekdays: 3 of 3 by Friday, and Today's tests found the row already ticked (2 Oct 2026).
        let callWeek = period(.week, containing: today).lowerBound
        for w in 1...4 {
            for i in 0..<3 { entries.append(Entry(habitID: call.id, day: callWeek.adding(days: -7 * w + i, calendar: cal), value: 1)) }
        }
        var callDay = today.adding(days: -1, calendar: cal)
        for _ in 0..<2 where callDay >= callWeek {
            entries.append(Entry(habitID: call.id, day: callDay, value: 1))
            callDay = callDay.adding(days: -1, calendar: cal)
        }
        // Smoking: a 45-day best run, a slip 15 days ago, and the current run since 12 days ago.
        // Slips are events on the day they happened (Build Plan #60d).
        entries.append(Entry(habitID: smoking.id, day: self.today(now: ago(days: 15)), value: 1, createdAt: ago(days: 15)))
        entries.append(Entry(habitID: alcohol.id, day: self.today(now: ago(days: 60 - 13)), value: 1, createdAt: ago(days: 60 - 13)))

        // Today, as in the afternoon design.
        entries.append(Entry(habitID: read.id, day: today, value: 12))
        for _ in 0..<8 { entries.append(Entry(habitID: water.id, day: today, value: 1)) }
        entries.append(Entry(habitID: stretch.id, day: today, value: 10))
        entries.append(Entry(habitID: teeth.id, day: today, value: 2))
        for s in skincare.steps { entries.append(Entry(habitID: skincare.id, stepID: s.id, day: today, value: 1)) }
        entries.append(Entry(habitID: meds.id, day: today, value: 1))
        entries.append(Entry(habitID: walk.id, day: today, value: 5200))
        entries.append(Entry(habitID: meds2.id, day: today, value: 1))

        if ProcessInfo.processInfo.arguments.contains("-year-demo") {
            // Year's pictures (the user, 2 Oct 2026: every kind of square in one habit). Swim, 20 laps Monday to
            // Saturday, for 400 days: done, part done at each of the three steps, not done, more than the goal, an
            // extra Sunday now and then (Sundays otherwise not scheduled); skipped days and a week's pause are added once
            // saved (`seedDemo`); today is still open. Coffee, at most 2 cups a day, goes over on some days.
            let swim = Habit(name: "Swim", symbol: "figure.pool.swim", color: .blue, kind: .amount(unit: "laps", increment: 0),
                             goal: 20, frequency: .weekdays([2, 3, 4, 5, 6, 7]), remind: false, createdAt: ago(days: 400))
            let coffee = Habit(name: "Coffee", symbol: "mug.fill", color: .brown, kind: .amount(unit: "cups", increment: 1),
                               goal: 2, atMost: true, remind: false, createdAt: ago(days: 400))
            // Running, three times a week on any days; Cycle, 70 km a week in all: the two week goals.
            let running = Habit(name: "Running", symbol: "figure.run", color: .orange, kind: .check, frequency: .perWeek(3),
                                remind: false, createdAt: ago(days: 400))
            let cycle = Habit(name: "Cycle", symbol: "bicycle", color: .teal, kind: .amount(unit: "km", increment: 0), goal: 70,
                              frequency: .perWeek(1), remind: false, createdAt: ago(days: 400))
            habits.insert(contentsOf: [swim, running, cycle, coffee], at: 0)
            for d in 1...400 {
                let day = today.adding(days: -d, calendar: cal)
                let laps: Double
                if day.weekday(calendar: cal) == 1 { laps = d % 3 == 0 ? 20 : 0 }
                else if d % 13 == 0 { laps = 0 }
                else if d % 11 == 0 { laps = 5 }
                else if d % 7 == 3 { laps = 10 }
                else if d % 9 == 4 { laps = 16 }
                else if d % 5 == 0 { laps = 26 }
                else { laps = 20 }
                if laps > 0 { entries.append(Entry(habitID: swim.id, day: day, value: laps)) }
                entries.append(Entry(habitID: coffee.id, day: day, value: d % 6 == 0 ? 3 : d % 4 == 0 ? 2 : 1))
                let weekday = day.weekday(calendar: cal)
                if [3, 5, 7].contains(weekday) && d % 10 != 0 || weekday == 1 && d % 4 == 0 {
                    entries.append(Entry(habitID: running.id, day: day, value: 1))
                }
                if d % 3 != 1 { entries.append(Entry(habitID: cycle.id, day: day, value: Double([8, 11, 14, 16, 18, 21, 26][d % 7]))) }
            }
        }
        if ProcessInfo.processInfo.arguments.contains("-perf-history") {
            // Speed tests: a year of history on every daily habit, missed about one day in nine, so streaks and
            // counts are measured on the data of someone who has used the app for a year (30 Sep).
            // With -perf-many (Progress, report §20): 30 habits and two years.
            let many = ProcessInfo.processInfo.arguments.contains("-perf-many")
            if many {
                let daily = habits.filter { $0.kind != .quit && $0.frequency.isDayBased }
                var n = 0
                while habits.count < 30 {
                    var copy = daily[n % daily.count]
                    copy.id = UUID()
                    copy.name = String((copy.name + " \(n / daily.count + 2)").prefix(TextLimit.name))
                    copy.steps = copy.steps.map { Step(name: $0.name) }
                    habits.append(copy)
                    n += 1
                }
            }
            let days = many ? 730 : 365
            let logged = Set(entries.map { $0.habitID.uuidString + $0.day.key })
            for i in habits.indices where habits[i].kind != .quit && habits[i].frequency.isDayBased {
                habits[i].createdAt = ago(days: days + 35)
                let h = habits[i]
                for d in 1...days where d % 9 != 0 {
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
        entriesReplaced()
    }
    #endif
}
