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
    var usesCoreRules: Bool { HabitStore.sharedRules && calendar.identifier == .gregorian }

    /// Off only to measure the store's own Swift rules side by side (`PerfSwitches`, the before/after speed runs).
    nonisolated(unsafe) static var sharedRules = !ProcessInfo.processInfo.arguments.contains("-swift-rules")

    /// The shared rules, up to date with the store's data; nil where the store's own rules answer.
    var core: LiveRules? {
        guard usesCoreRules else { return nil }
        if let coreState {
            if coreDirty { refreshCore(coreState) }
            return coreState
        }
        let rows = coreRows ?? Snapshot(habits: [], steps: [], reminders: [], entries: entries.map(\.record), settings: [])
        let made = LiveRules(snapshot: rows, settings: coreSettings(), timeZone: calendar.timeZone.identifier,
                             clock: { [weak self] in KotlinLong(value: (self?.clock() ?? .now).millis) })
        coreState = made
        refreshCore(made)
        return made
    }

    private func refreshCore(_ core: LiveRules) {
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
    /// rule) one made from it and kept until the data changes.
    func ruleHabit(_ habit: Habit, _ core: LiveRules) -> RuleHabit? {
        if isSaved(habit) {
            if let known = coreHandles[habit.id] { return known }
            let made = core.habit(id: habit.id.uuidString)
            coreHandles[habit.id] = made
            return made
        }
        if let known = coreDrafts[habit] { return known }
        let made = core.draft(record: habit.record(position: 0), steps: habit.stepRecords(), reminders: habit.reminderRecords())
        if coreDrafts.count > 500 { coreDrafts = [:] }
        coreDrafts[habit] = made
        return made
    }

    /// The core and the rules' habit, when the shared rules answer.
    func shared(_ habit: Habit) -> (LiveRules, RuleHabit)? {
        guard let core, let h = ruleHabit(habit, core) else { return nil }
        return (core, h)
    }
}

extension KotlinIntArray {
    /// Two numbers as days (`LiveRules.period`, `periodRange`).
    var dayRange: ClosedRange<LocalDay> { LocalDay(dayNumber: Int(get(index: 0)))...LocalDay(dayNumber: Int(get(index: 1))) }
}
