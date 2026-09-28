import ActivityKit
import Foundation

/// A running habit timer, shown as a Live Activity on the Lock Screen and in the Dynamic Island.
/// Built into both the app (which starts, updates and ends it) and the widget extension (which draws it).
/// Research: "Timing a Habit — Start, See and Stop" (28 Sep).
nonisolated struct HabitTimerAttributes: ActivityAttributes {
    nonisolated struct ContentState: Codable, Hashable, Sendable {
        /// When the clock read 0:00: the session's start minus what was already logged, so a clock
        /// counting up from here shows the whole total ("1:07:42"), not just this session.
        var clockStart: Date
        /// When the total reaches the goal. The bar fills up to here, then stays full.
        var goalAt: Date
    }

    var habitID: String
    var name: String
    var symbol: String
    /// `HabitColor` raw value ("blue").
    var color: String
    /// "20 min", "3 h this week", "1 h max".
    var goalLabel: String
}
