import SwiftUI

extension HabitColor {
    /// The habit's colour on the Watch (`WatchPalette`).
    var watchColor: Color { WatchPalette.color(rawValue) }
    var watchFill: Color { WatchPalette.fill(rawValue) }
}

extension HabitStore {
    /// ▶ on the Watch: the same timer as the iPhone's (a start time in the database, WA10), and its goal alert scheduled
    /// here, since this Watch started it (R3).
    func startTimerOnWatch(_ habit: Habit, slot: String? = nil) {
        guard timers[habit.id] == nil else { return }
        toggleTimer(habit, slot: slot)
        if let start = timers[habit.id] { WatchNotifications.startedHere(habit.id, at: start) }
    }
}

extension HabitStore {
    /// With the Watch's window of history (`historyWindowDays`), a habit that has older logs may have a longer run than
    /// counted here. A streak shows only when it certainly falls inside the window; otherwise nothing, never a smaller
    /// number than the iPhone's (WA11: not sure, no count).
    func streakIsSure(_ habit: Habit, current: Int, on day: LocalDay) -> Bool {
        guard historyBeforeWindow.contains(habit.id) else { return true }
        let room = historyWindowDays - 35
        let fits: Int = switch rule(habit, on: day).frequency.streakUnit {
        case .days: room
        case .weeks: room / 7
        case .months: room / 31
        case .times, .years: 0
        }
        return current < fits
    }

    /// A best run counts every past log: sure only for a habit with nothing before the window.
    func bestIsSure(_ habit: Habit) -> Bool { !historyBeforeWindow.contains(habit.id) }
}
