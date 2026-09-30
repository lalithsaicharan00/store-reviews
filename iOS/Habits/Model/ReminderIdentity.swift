import CryptoKit
import Foundation

/// Stable event IDs make system retries harmless, including after relaunch or undo.
enum ReminderIdentity {
    nonisolated static func actionID(_ identifier: String) -> UUID {
        var bytes = Array(SHA256.hash(data: Data(identifier.utf8)).prefix(16))
        bytes[6] = (bytes[6] & 0x0F) | 0x50
        bytes[8] = (bytes[8] & 0x3F) | 0x80
        return UUID(uuid: (bytes[0], bytes[1], bytes[2], bytes[3], bytes[4], bytes[5], bytes[6], bytes[7],
                           bytes[8], bytes[9], bytes[10], bytes[11], bytes[12], bytes[13], bytes[14], bytes[15]))
    }
    static func signature(_ habit: Habit) -> String {
        let encoder = JSONEncoder(); encoder.outputFormatting = .sortedKeys
        var normalized = habit
        normalized.createdAt = Date(millis: habit.createdAt.millis)
        normalized.quitSince = habit.quitSince.map { Date(millis: $0.millis) }
        normalized.reminders.sort { ($0.hour, $0.minute, $0.id.uuidString) < ($1.hour, $1.minute, $1.id.uuidString) }
        let data = (try? encoder.encode(normalized)) ?? Data()
        return SHA256.hash(data: data).map { String(format: "%02x", $0) }.joined()
    }
}

/// Use wall-clock times on their actual calendar day. Never add 24-hour durations across DST.
enum ReminderClock {
    nonisolated static func date(on day: LocalDay, hour: Int, minute: Int, calendar: Calendar) -> Date? {
        guard (0...23).contains(hour), (0...59).contains(minute) else { return nil }
        return calendar.date(bySettingHour: hour, minute: minute, second: 0, of: day.date(calendar: calendar),
                             matchingPolicy: .nextTime, repeatedTimePolicy: .first, direction: .forward)
    }
}
