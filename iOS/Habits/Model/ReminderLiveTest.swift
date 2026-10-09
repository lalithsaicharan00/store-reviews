#if DEBUG
import AlarmKit
import Core
import Foundation
import UserNotifications

/// Debug builds only (Current Work 70): real reminders and alarms on the iPhone, end to end. Launch arguments:
/// - `-reminder-live <name> <check|amount> <notification|alarm> <minutes ahead> <remind-again minutes or 0>` adds (or
///   resets) a habit called `<name>` with one time at the start of the minute `<minutes ahead>` from now, so the real
///   planner, notifications, alarms and their Done / +1 buttons run as they do for the person's own habits.
/// - `-reminder-live-status` writes what's pending, delivered and logged for those habits.
/// - `-reminder-live-cleanup` deletes them (and so their reminders and logs).
/// Everything goes to `Documents/reminder-live.txt` (read it with `devicectl`). Test habits' names start with "Test ".
@MainActor
enum ReminderLiveTest {
    private static let iso: ISO8601DateFormatter = {
        let f = ISO8601DateFormatter(); f.timeZone = .current; f.formatOptions = [.withFullTime, .withColonSeparatorInTime]; return f
    }()

    static func runIfAsked(store: HabitStore, scheduler: ReminderScheduler) {
        let args = ProcessInfo.processInfo.arguments
        guard args.contains(where: { $0.hasPrefix("-reminder-live") }) else { return }
        Task { @MainActor in
            var lines: [String] = []
            if let i = args.firstIndex(of: "-reminder-live"), i + 5 < args.count {
                lines += await add(store: store, scheduler: scheduler, name: args[i + 1], kind: args[i + 2], alert: args[i + 3],
                                   minutesAhead: Int(args[i + 4]) ?? 2, followUp: Int(args[i + 5]) ?? 0)
            }
            if args.contains("-reminder-live-cleanup") {
                let tests = store.habits.filter { $0.name.hasPrefix("Test ") && $0.name != "Test" }
                store.delete(tests)
                await store.flush()
                await scheduler.reconcile(store)
                lines.append("deleted \(tests.count) test habit(s)")
            }
            lines += await status(store: store, scheduler: scheduler)
            write(lines)
        }
    }

    private static func add(store: HabitStore, scheduler: ReminderScheduler, name: String, kind: String, alert: String,
                            minutesAhead: Int, followUp: Int) async -> [String] {
        let fire = Calendar.current.date(byAdding: .minute, value: minutesAhead, to: .now)!
        let parts = Calendar.current.dateComponents([.hour, .minute], from: fire)
        let time = ReminderTime(hour: parts.hour!, minute: parts.minute!)
        if alert == "alarm" { _ = await scheduler.requestAlarmPermission() } else { _ = await scheduler.requestPermission() }
        var habit = store.habits.first { $0.name == name } ?? Habit(name: name, symbol: "bell", color: .purple, kind: .check)
        habit.kind = kind == "amount" ? .amount(unit: "glasses", increment: 1) : .check
        habit.goal = kind == "amount" ? 3 : 1
        habit.reminders = [time]
        habit.remind = true
        habit.alert = alert == "alarm" ? .alarm : .notification
        habit.followUpMinutes = followUp > 0 ? followUp : nil
        if store.habits.contains(where: { $0.id == habit.id }) { store.update(habit) } else { store.add(habit) }
        await store.flush()
        await scheduler.reconcile(store)
        return ["added \(name): \(kind), \(alert), at \(String(format: "%02d:%02d", time.hour, time.minute)), remind again every \(followUp) min",
                "scheduler problem: \(scheduler.problem ?? "none")"]
    }

    private static func status(store: HabitStore, scheduler: ReminderScheduler) async -> [String] {
        let tests = store.habits.filter { $0.name.hasPrefix("Test ") && $0.name != "Test" }
        var lines = ["status at \(iso.string(from: .now)); notifications \(await scheduler.notificationStatus().rawValue) (2 = allowed), alarms allowed \(scheduler.alarmsAuthorized)"]
        let center = UNUserNotificationCenter.current()
        let pending = await center.pendingNotificationRequests()
        let delivered = await center.deliveredNotifications()
        let ownedAlarms = AlarmReminderRecord.load()
        for habit in tests {
            let id = habit.id.uuidString
            let mine = pending.filter { $0.identifier.contains(id) }.sorted { $0.identifier < $1.identifier }
            let fires = mine.compactMap { ($0.trigger as? UNCalendarNotificationTrigger)?.nextTriggerDate() }.map { iso.string(from: $0) }
            let shown = delivered.filter { $0.request.identifier.contains(id) }.map { iso.string(from: $0.date) }
            let owned = Set(ownedAlarms.filter { $0.value.target.habit == habit.id }.keys)
            let alarmTimes = alarmDescriptions(owned)
            let logs = store.entries(of: habit.id, on: store.today()).map { "\(iso.string(from: $0.createdAt)) +\($0.value) \($0.source?.rawValue ?? "?")" }
            lines.append("\(habit.name): pending \(fires), delivered \(shown), alarms \(alarmTimes), logged today \(logs)")
        }
        if tests.isEmpty { lines.append("no test habits") }
        if let sync = AppModel.shared.sync, let s = await sync.status() { lines.append("sync: waiting \(s.waiting), kept aside \(s.keptAside)") }
        return lines
    }

    private static func alarmDescriptions(_ ids: Set<UUID>) -> [String] {
        guard #available(iOS 26, *), let alarms = try? AlarmManager.shared.alarms else { return [] }
        return alarms.filter { ids.contains($0.id) }.map { alarm in
            if case .fixed(let date) = alarm.schedule { return "\(iso.string(from: date)) \(alarm.state)" }
            return "\(alarm.state)"
        }
    }

    private static func write(_ lines: [String]) {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?
            .appendingPathComponent("reminder-live.txt") else { return }
        try? Data((lines.joined(separator: "\n") + "\n").utf8).write(to: url, options: .atomic)
    }
}
#endif
