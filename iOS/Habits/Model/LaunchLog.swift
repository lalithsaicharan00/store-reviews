import Foundation
import os

/// How long each step of a launch takes, in the system log (subsystem com.oftenenough.app, category "launch"). CI saves
/// it with the test logs (`app.log`), so if the app stops answering after launch again, the log names the step
/// (Current Work 11, 4 Oct 2026: a ~74 s freeze after a signed-in launch that the test logs couldn't place).
nonisolated enum LaunchLog {
    private static let log = Logger(subsystem: "com.oftenenough.app", category: "launch")

    /// A step that took `since` → now; anything over half a second is marked SLOW.
    static func took(_ step: String, since start: Date) {
        let seconds = Date.now.timeIntervalSince(start)
        if seconds >= 0.5 {
            log.notice("SLOW \(step, privacy: .public): \(seconds, format: .fixed(precision: 2), privacy: .public) s")
        } else {
            log.notice("\(step, privacy: .public): \(seconds, format: .fixed(precision: 3), privacy: .public) s")
        }
    }
}
