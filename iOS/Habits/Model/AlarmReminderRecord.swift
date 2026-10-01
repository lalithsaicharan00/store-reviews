import Foundation

/// Local ownership survives cold launches; it is disposable scheduling metadata, not user data.
struct AlarmReminderRecord: Codable {
    let target: ReminderTarget
    let title: String
    let minute: Int
    let color: HabitColor
    init(_ alert: ReminderScheduler.Alert) {
        target = alert.target; title = alert.habit.name; minute = alert.time.minuteOfDay; color = alert.habit.color
    }
    func matches(_ alert: ReminderScheduler.Alert) -> Bool {
        target == alert.target && title == alert.habit.name && minute == alert.time.minuteOfDay && color == alert.habit.color
    }
    func isCurrent(in store: HabitStore, now: Date = .now) -> Bool {
        guard store.canActOnReminder(target, now: now),
              let habit = store.habits.first(where: { $0.id == target.habit }), habit.alert == .alarm,
              let time = habit.reminders.first(where: { $0.id == target.time }) else { return false }
        return time.minuteOfDay == minute
    }
    private static let key = "reminders.alarmOwnership.v1"
    static func load() -> [UUID: AlarmReminderRecord] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [:] }
        return (try? JSONDecoder().decode([UUID: AlarmReminderRecord].self, from: data)) ?? [:]
    }
    static func save(_ records: [UUID: AlarmReminderRecord]) {
        if let data = try? JSONEncoder().encode(records) { UserDefaults.standard.set(data, forKey: key) }
    }
}
