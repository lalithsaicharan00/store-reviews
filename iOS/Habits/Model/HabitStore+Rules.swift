import Core
import Foundation

// The shared habit rules (Core/spec/, Current Work 92): the store's rules ask the shared Kotlin core, so iPhone, iPad,
// Apple Watch and Android work out the same numbers from one copy. The store keeps its shape: it asks once and remembers
// (S5); the core holds a live copy of the data, given each log as it's added or removed and habits and settings again
// when they change. Every call crosses as plain values (IDs, day numbers, epoch ms).
//
// A phone set to a calendar that isn't Gregorian keeps the store's own Swift rules: its saved days are in that calendar,
// and the shared rules count Gregorian days (Core/spec/differences.md #5, until the user decides).

extension LocalDay {
    /// The day as the shared rules number it: days since 1 January 1970.
    nonisolated var n: Int32 { Int32(dayNumber) }
}

extension HabitStore {
    /// Whether the shared rules answer for this store (`HabitStore.sharedRules`, and a Gregorian calendar).
    var usesCoreRules: Bool {
        guard HabitStore.sharedRules else { return false }
        if let coreGregorian { return coreGregorian }
        let gregorian = calendar.identifier == .gregorian
        coreGregorian = gregorian
        return gregorian
    }

    /// Off only to measure the store's own Swift rules side by side (`PerfSwitches`, the before/after speed runs).
    nonisolated(unsafe) static var sharedRules = !ProcessInfo.processInfo.arguments.contains("-swift-rules")

    /// The shared rules, up to date with the store's data; nil where the store's own rules answer.
    ///
    /// The core reads the store's data without SwiftUI seeing it, so each rule reads what it depends on, as the Swift
    /// rules did, and no more: a view showing a rule's answer still redraws when that changes (Arrange's card moves
    /// didn't, run 38216853635), and only then (reading every habit's logs for "is it due" redrew Today's list on every
    /// log: 69 draws became 287, run 38247029430). Every rule reads the settings here; one habit's data in `ruleHabit`;
    /// the times of day and Today's cards where they're used.
    var core: LiveRules? {
        guard usesCoreRules else { return nil }
        access(keyPath: \.settings)
        if let coreState {
            if coreDirty { refreshCore(coreState) }
            return coreState
        }
        return perfTimed("Shared rules: built from every log") {
            let rows = coreRows ?? Snapshot(habits: [], steps: [], reminders: [], entries: entries.map(\.record), settings: [])
            let made = LiveRules(snapshot: rows, settings: coreSettings(), timeZone: calendar.timeZone.identifier, clock: coreClock())
            coreState = made
            refreshCore(made)
            return made
        }
    }

    private func refreshCore(_ core: LiveRules) {
        perfTimed("Shared rules: habits and settings again") { refreshCoreNow(core) }
    }

    private func refreshCoreNow(_ core: LiveRules) {
        var steps: [StepRecord] = []
        var reminders: [ReminderRecord] = []
        let records = habits.enumerated().map { i, habit -> HabitRecord in
            steps += habit.stepRecords()
            reminders += habit.reminderRecords()
            return habit.record(position: i)
        }
        core.update(habits: records, steps: steps, reminders: reminders, settings: coreSettings(), timeZone: calendar.timeZone.identifier)
        coreDirty = false
        coreHandles = [:]
        coreDrafts = [:]
    }

    /// The settings the rules read, exactly as the store saves them (Core/spec/README.md "Reading saved data"), with the
    /// day start and week start as the store counts them and every archived habit's archive day.
    private func coreSettings() -> [String: String] {
        var out: [String: String] = ["day_end_hour": String(settings.dayEndHour), "week_start": String(settings.weekStart)]
        let encoder = JSONEncoder()
        func json<T: Encodable>(_ value: T) -> String? { (try? encoder.encode(value)).map { String(decoding: $0, as: UTF8.self) } }
        for (id, days) in skips { out["skip." + id.uuidString] = days.map(\.key).sorted().joined(separator: ",") }
        for (id, moves) in taskMoves { out["move." + id.uuidString] = moves.map { $0.key.key + ">" + $0.value.key }.sorted().joined(separator: ",") }
        for (id, list) in pauses { out["pause." + id.uuidString] = json(list) }
        for (id, list) in rules { out["rules." + id.uuidString] = json(list) }
        for (id, day) in archivedOn { out["archived." + id.uuidString] = day.key }
        for (id, start) in timers { out["timer." + id.uuidString] = String(start.millis) }
        out["day_sections"] = json(sections)
        out["today_order"] = json(cardOrder)
        return out
    }

    /// The rules' habit for one of the store's: the saved one, or (for a form's draft, or a habit judged by an earlier
    /// rule) one made from it and kept until the data changes. `logs`: whether the rule reads the habit's logs (only
    /// then does a view showing it redraw when one is added); a task's moved days and a time habit's running timer
    /// likewise only for those.
    func ruleHabit(_ habit: Habit, _ core: LiveRules, logs: Bool = true) -> RuleHabit? {
        if logs { observeEntries(of: habit.id) }
        // Skips, moved task days, pauses, goal history and archive days, in one read (`ruleInputs`).
        access(keyPath: \.ruleInputs)
        if logs, habit.kind == .duration { access(keyPath: \.timers) }
        if let known = coreHandles[habit.id], known.habit == habit { return known.rule }
        if isSaved(habit), let made = core.habit(id: habit.id.uuidString) {
            coreHandles[habit.id] = (habit, made)
            return made
        }
        if let known = coreDrafts[habit.id]?.first(where: { $0.habit == habit }) { return known.rule }
        guard let made = core.draft(record: habit.record(position: 0), steps: habit.stepRecords(), reminders: habit.reminderRecords()) else { return nil }
        var list = coreDrafts[habit.id] ?? []
        if list.count >= 8 { list.removeFirst() }
        list.append((habit, made))
        coreDrafts[habit.id] = list
        return made
    }

    /// The clock the shared rules read: the store's own, as it is when asked (checks set it as they go).
    func coreClock() -> () -> KotlinLong {
        { [weak self] in MainActor.assumeIsolated { KotlinLong(value: (self?.clock() ?? .now).millis) } }
    }

    /// The shared rules over `rows`' logs, made on a background thread (`load`): converting every log is the costly
    /// part, and the habits and settings are given on first use (`coreDirty`). Nil where the store's own rules answer.
    func buildCoreOffMain(_ rows: Snapshot) async -> LiveRules? {
        guard usesCoreRules else { return nil }
        let input = CoreInput(rows: rows, zone: calendar.timeZone.identifier, clock: coreClock())
        let built = await Task.detached(priority: .userInitiated) {
            let started = CFAbsoluteTimeGetCurrent()
            let rules = LiveRules(snapshot: input.rows, settings: [:], timeZone: input.zone, clock: input.clock)
            return CoreBuilt(rules: rules, seconds: CFAbsoluteTimeGetCurrent() - started)
        }.value
        perfNote("Shared rules: built from every log, off the main thread", since: CFAbsoluteTimeGetCurrent() - built.seconds)
        return built.rules
    }

    /// The core and the rules' habit, when the shared rules answer. `logs: false` for a rule that never reads the
    /// habit's logs (its goal, its first day, whether a day is one of its days).
    func shared(_ habit: Habit, logs: Bool = true) -> (LiveRules, RuleHabit)? {
        guard let core, let h = ruleHabit(habit, core, logs: logs) else { return nil }
        return (core, h)
    }

    /// Whether "is it one of its days" reads the habit's logs: a task (done or still to do) and a schedule counted
    /// from the last time it was done, now or in its goal history (as the Swift `isDue`).
    func scheduleReadsLogs(_ habit: Habit) -> Bool {
        func fromLastDone(_ f: Frequency) -> Bool { if case .afterCompletion = f { true } else { false } }
        return habit.kind == .task || fromLastDone(habit.frequency)
            || (rules[habit.id]?.contains { $0.kind == .task || fromLastDone($0.frequency) } ?? false)
    }
}

/// What `buildCoreOffMain` hands to its background thread and back: Kotlin objects, used on one thread at a time.
nonisolated struct CoreInput: @unchecked Sendable {
    let rows: Snapshot
    let zone: String
    let clock: () -> KotlinLong
}
nonisolated struct CoreBuilt: @unchecked Sendable {
    let rules: LiveRules
    let seconds: Double
}

extension KotlinIntArray {
    /// Two numbers as days (`LiveRules.period`, `periodRange`).
    var dayRange: ClosedRange<LocalDay> { LocalDay(dayNumber: Int(get(index: 0)))...LocalDay(dayNumber: Int(get(index: 1))) }
}

/// One habit's run of days from the shared rules, asked in one call (`LiveRules.days`): a strip of days (Progress's cards,
/// the habit page's history) crossed into the core once per day and rule, and the crossings cost more than the rules
/// (Current Work 92, checkpoint 2: Progress's year cards took 441 ms against the Swift rules' 160, run 38261431401).
struct CoreDays {
    /// `LiveRules.dayMark`'s order.
    static let marks: [HabitStore.DayMark] = [.done, .some, .missed, .open, .skipped, .paused, .notItsDay, .upcoming, .before]
    /// Numbers per day (read once: each read of a Kotlin constant crosses into the core).
    static let fields = Int(LiveRules.companion.DAY_FIELDS)
    let first: Int
    let values: [Double]

    /// A day's number; nil for a day outside the strip asked for (the caller asks the store's rules instead).
    private func at(_ day: LocalDay, _ field: Int) -> Double? {
        let i = (day.dayNumber - first) * Self.fields + field
        return day.dayNumber >= first && i < values.count ? values[i] : nil
    }
    /// As `dayMark(_:on:relativeTo:)`.
    func mark(_ day: LocalDay) -> HabitStore.DayMark? { at(day, 0).map { Self.marks[Int($0)] } }
    /// As `dayProgress(of: rule(habit, on: day), on: day)`.
    func progress(_ day: LocalDay) -> Double? { at(day, 1) }
    /// As `isDayMet(rule(habit, on: day), on: day)`.
    func isMet(_ day: LocalDay) -> Bool? { at(day, 2).map { $0 == 1 } }
    /// As `dayGoal(of: rule(habit, on: day))`.
    func goal(_ day: LocalDay) -> Double? { at(day, 3) }
    /// As `dayFraction(habit, on: day)`: the share of the day's goal logged.
    func fraction(_ day: LocalDay) -> Double? {
        guard let goal = goal(day), let progress = progress(day) else { return nil }
        return goal > 0 ? min(1, max(0, progress / goal)) : 0
    }
    /// As `isDue(habit, on: day)`.
    func isDue(_ day: LocalDay) -> Bool? { at(day, 4).map { $0 == 1 } }
    /// As `periodKind(rule(habit, on: day))`.
    func periodKind(_ day: LocalDay) -> GoalPeriod? { at(day, 5).map { [GoalPeriod.day, .week, .month, .year][Int($0)] } }
}

extension HabitStore {
    /// The habit's days in `span` from the shared rules, in one call; nil where the store's own rules answer.
    func coreDays(_ habit: Habit, in span: ClosedRange<LocalDay>, relativeTo reference: LocalDay) -> CoreDays? {
        guard case let (core, h)? = shared(habit) else { return nil }
        // One block of bytes: reading the Kotlin array back crossed into the core once per number.
        let data = core.daysData(h: h, first: span.lowerBound.n, last: span.upperBound.n, reference: reference.n, now: clock().millis)
        var values = [Double](repeating: 0, count: data.count / MemoryLayout<Double>.size)
        _ = values.withUnsafeMutableBytes { data.copyBytes(to: $0) }
        return CoreDays(first: span.lowerBound.dayNumber, values: values)
    }
}
