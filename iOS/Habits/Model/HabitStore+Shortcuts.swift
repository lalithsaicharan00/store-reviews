import Foundation

/// Siri, Shortcuts and automations (report "Siri and Shortcuts — Log by Voice and Automation", 30 Sep; Feature Ledger
/// C046). Ported from the 30 Sep feature branch on 1 Oct 2026 onto the store's own logging calls, so a shortcut logs
/// exactly the way a tap does.
extension HabitStore {
    /// What "Log a Habit" did.
    enum ShortcutLog: Equatable {
        case logged
        case alreadyDone
        /// An amount or time with no quick step: Siri asks how much.
        case needsAmount
        /// A checklist or a quit habit: logged in the app.
        case openApp
        case paused
    }

    /// One step, like a notification's Done. Only ever adds: a tick already done is left alone; an amount adds what was
    /// said, or one quick step; time adds the minutes said. A habit ticked per section fills its first unticked one.
    func logFromShortcut(_ habit: Habit, amount: Double?, on day: LocalDay) -> ShortcutLog {
        let rule = rule(habit, on: day)
        if isPaused(habit, on: day) { return .paused }
        switch rule.kind {
        case .checklist, .quit:
            return .openApp
        case .amount, .duration:
            guard let value = amount ?? (rule.kind == .duration ? nil : rule.quickIncrement),
                  value.isFinite, value > 0, value <= GoalNumber.maximum else { return .needsAmount }
            addProgress(habit, value: value, on: day, source: .shortcut)
            return .logged
        case .check, .task:
            if let slot = slots(of: habit).first(where: { !isSlotDone(habit, slot: $0, on: day) }) {
                toggleSlot(habit, slot: slot, on: day, source: .shortcut)
                return .logged
            }
            guard slots(of: habit).isEmpty, !isDone(habit, on: day) else { return .alreadyDone }
            toggleCheck(habit, on: day, source: .shortcut)
            return .logged
        }
    }

    /// Today's habits in Today's order (time of day, then the habits' own order), with whether each is done.
    func shortcutDay(_ day: LocalDay) -> [(habit: Habit, done: Bool)] {
        let order = Dictionary(uniqueKeysWithValues: sections.enumerated().map { ($1.id, $0) })
        return habits.enumerated()
            .filter { !$1.archived && $1.kind != .quit && startDay(of: $1) <= day && isDue($1, on: day) }
            .sorted { a, b in
                let sa = placements(of: a.element).first.flatMap { order[$0.section] } ?? 0
                let sb = placements(of: b.element).first.flatMap { order[$0.section] } ?? 0
                return sa != sb ? sa < sb : a.offset < b.offset
            }
            .map { ($0.element, isSatisfied($0.element, on: day)) }
    }

    /// "Water: 3 of 8 glasses today. 5 in a row." / "Stretch is done today." Streaks only while they're shown.
    func shortcutStatus(_ habit: Habit, on day: LocalDay) -> String {
        if habit.kind == .quit { return "\(habit.name): log slips in Habits." }
        let rule = rule(habit, on: day)
        let done = isSatisfied(habit, on: day)
        var text: String
        let goal = dayGoal(of: rule)
        let measured: Bool = switch rule.kind { case .amount, .duration: true; default: false }
        if measured || goal > 1 {
            let when = rule.frequency.isDayBased ? " today" : ""
            text = "\(habit.name): \(progressValue(progress(of: habit, on: day), rule)) of \(progressValue(goal, rule))\(when)."
            if done { text += " Done." }
        } else {
            text = done ? "\(habit.name) is done today." : "\(habit.name) isn't done yet today."
        }
        if isPaused(habit, on: day) { text += " It's paused." }
        let streak = streak(of: habit, asOf: day)
        let showStreaks = (UserDefaults.standard.object(forKey: ProgressOptions.showStreaks) as? Bool) ?? true
        if showStreaks && streak > 1 { text += " \(streak) in a row." }
        return text
    }
}
