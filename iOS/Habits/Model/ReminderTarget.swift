import Foundation

// Moved unchanged from AppModel.swift (10 Oct 2026), so the Apple Watch reads the same notification targets.

/// What a notification or alarm is about, carried in its user info (or an intent's parameters).
nonisolated struct ReminderTarget: Codable, Hashable, Sendable {
    var habit: UUID
    var time: UUID?
    var day: LocalDay
    /// The section tick it is for, for a habit ticked once per section.
    var slot: String?
    /// The section the time falls in, opened when the notification is tapped.
    var section: String?
    var signature: String?
    var event: String?

    var userInfo: [String: String] {
        var info = ["habit": habit.uuidString, "day": day.key]
        if let time { info["time"] = time.uuidString }
        if let slot { info["slot"] = slot }
        if let section { info["section"] = section }
        if let signature { info["signature"] = signature }
        if let event { info["event"] = event }
        return info
    }

    init(habit: UUID, time: UUID?, day: LocalDay, slot: String?, section: String?, signature: String? = nil, event: String? = nil) {
        self.habit = habit; self.time = time; self.day = day; self.slot = slot; self.section = section
        self.signature = signature; self.event = event
    }

    init?(userInfo: [AnyHashable: Any]) {
        guard let habit = (userInfo["habit"] as? String).flatMap(UUID.init(uuidString:)),
              let day = (userInfo["day"] as? String).flatMap(LocalDay.init(key:)) else { return nil }
        self.init(habit: habit, time: (userInfo["time"] as? String).flatMap(UUID.init(uuidString:)), day: day,
                  slot: userInfo["slot"] as? String, section: userInfo["section"] as? String,
                  signature: userInfo["signature"] as? String, event: userInfo["event"] as? String)
    }
}
