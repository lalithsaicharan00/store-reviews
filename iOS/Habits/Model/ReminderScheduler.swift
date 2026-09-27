import Foundation
import Observation
import UserNotifications

/// Keeps the system's pending notifications exactly in step with the habits.
///
/// Reminders are not written once and forgotten: every change re-plans the next few days
/// and reconciles against what is pending. So a reminder never fires for a habit that is
/// done, deleted or not due, and a changed time always takes (Feature Ledger C039).
@MainActor @Observable
final class ReminderScheduler {
    @ObservationIgnored private let center = UNUserNotificationCenter.current()
    private static let prefix = "reminder."
    /// iOS keeps at most 64 pending notifications per app; stay under it.
    private static let limit = 60
    private static let horizonDays = 7
    @ObservationIgnored private var pendingWork: Task<Void, Never>?

    /// Asks once, at the moment the user adds their first reminder (Architecture 09 §4).
    func requestPermission() async -> Bool {
        let settings = await center.notificationSettings()
        switch settings.authorizationStatus {
        case .authorized, .provisional, .ephemeral: return true
        case .notDetermined: return (try? await center.requestAuthorization(options: [.alert, .sound, .badge])) ?? false
        default: return false
        }
    }

    func isDenied() async -> Bool {
        await center.notificationSettings().authorizationStatus == .denied
    }

    /// Coalesces bursts of changes into one reconcile.
    func scheduleReconcile(_ store: HabitStore) {
        pendingWork?.cancel()
        pendingWork = Task {
            try? await Task.sleep(for: .milliseconds(300))
            guard !Task.isCancelled else { return }
            await reconcile(store)
        }
    }

    func reconcile(_ store: HabitStore, now: Date = .now) async {
        guard await center.notificationSettings().authorizationStatus == .authorized else { return }
        let wanted = plan(store, now: now)
        let pending = await center.pendingNotificationRequests().filter { $0.identifier.hasPrefix(Self.prefix) }
        let pendingIDs = Set(pending.map(\.identifier))
        let wantedIDs = Set(wanted.map(\.identifier))

        center.removePendingNotificationRequests(withIdentifiers: Array(pendingIDs.subtracting(wantedIDs)))
        for request in wanted where !pendingIDs.contains(request.identifier) {
            try? await center.add(request)
        }
        // A habit finished today: clear its reminders already on screen.
        let today = store.today(now: now)
        let doneToday = store.habits.filter { store.isDone($0, on: today) && !$0.atMost }.map { Self.prefix + $0.id.uuidString }
        let delivered = await center.deliveredNotifications().map(\.request.identifier)
        center.removeDeliveredNotifications(withIdentifiers: delivered.filter { id in doneToday.contains { id.hasPrefix($0) } })
    }

    private func plan(_ store: HabitStore, now: Date) -> [UNNotificationRequest] {
        let calendar = store.calendar
        let today = store.today(now: now)
        var requests: [(Date, UNNotificationRequest)] = []
        for habit in store.habits where !habit.archived && habit.kind != .quit && !habit.reminders.isEmpty {
            for offset in 0..<Self.horizonDays {
                let day = today.adding(days: offset, calendar: calendar)
                guard store.isDue(habit, on: day), !(offset == 0 && store.isDone(habit, on: day) && !habit.atMost) else { continue }
                for time in habit.reminders {
                    var fire = calendar.date(bySettingHour: time.hour, minute: time.minute, second: 0, of: day.date(calendar: calendar))!
                    // Times before the day's end belong to the night after this day.
                    if time.hour < store.settings.dayEndHour { fire = calendar.date(byAdding: .day, value: 1, to: fire)! }
                    guard fire > now else { continue }
                    let content = UNMutableNotificationContent()
                    content.title = habit.name
                    content.body = reminderBody(habit, store: store)
                    content.sound = .default
                    content.threadIdentifier = habit.id.uuidString
                    let parts = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: fire)
                    let id = "\(Self.prefix)\(habit.id.uuidString).\(time.id.uuidString).\(day.year)-\(day.month)-\(day.day)"
                    let request = UNNotificationRequest(identifier: id, content: content,
                                                        trigger: UNCalendarNotificationTrigger(dateMatching: parts, repeats: false))
                    requests.append((fire, request))
                }
            }
        }
        return requests.sorted { $0.0 < $1.0 }.prefix(Self.limit).map(\.1)
    }

    private func reminderBody(_ habit: Habit, store: HabitStore) -> String {
        let goal = store.goal(of: habit)
        switch habit.kind {
        case .amount(let unit, _): return habit.atMost ? "No more than \(Format.amount(goal)) \(unit) today" : "Goal: \(Format.amount(goal)) \(unit)"
        case .duration: return "Goal: \(Format.amount(goal)) min"
        case .checklist: return "\(habit.steps.count) items"
        case .task: return "Task"
        default: return "Time for \(habit.name.lowercased())"
        }
    }
}
