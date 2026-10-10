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
