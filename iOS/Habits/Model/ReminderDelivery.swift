import Foundation
import UserNotifications

/// System delivery is separated from planning so races, denial and failures are reproducible in CI.
@MainActor protocol ReminderNotifications: AnyObject {
    func authorizationStatus() async -> UNAuthorizationStatus
    func requestPermission() async -> Bool
    func pending() async -> [UNNotificationRequest]
    func delivered() async -> [UNNotificationRequest]
    func categories(_ categories: Set<UNNotificationCategory>)
    func removePending(_ ids: [String])
    func removeDelivered(_ ids: [String])
    func add(_ request: UNNotificationRequest) async throws
}

final class SystemReminderNotifications: ReminderNotifications {
    private let center = UNUserNotificationCenter.current()
    func authorizationStatus() async -> UNAuthorizationStatus { await center.notificationSettings().authorizationStatus }
    func requestPermission() async -> Bool { (try? await center.requestAuthorization(options: [.alert, .sound, .badge])) ?? false }
    func pending() async -> [UNNotificationRequest] { await center.pendingNotificationRequests() }
    func delivered() async -> [UNNotificationRequest] { await center.deliveredNotifications().map(\.request) }
    func categories(_ categories: Set<UNNotificationCategory>) { center.setNotificationCategories(categories) }
    func removePending(_ ids: [String]) { center.removePendingNotificationRequests(withIdentifiers: ids) }
    func removeDelivered(_ ids: [String]) { center.removeDeliveredNotifications(withIdentifiers: ids) }
    func add(_ request: UNNotificationRequest) async throws { try await center.add(request) }
}

@MainActor protocol ReminderAlarms: AnyObject {
    var isAuthorized: Bool { get }
    var isDenied: Bool { get }
    var problem: String? { get }
    func requestPermission() async -> Bool
    func reconcile(_ alerts: [ReminderScheduler.Alert], keepRinging: Set<String>, store: HabitStore) async -> Set<String>
}

final class SystemReminderAlarms: ReminderAlarms {
    var isAuthorized: Bool { if #available(iOS 26, *) { AlarmScheduler.shared.isAuthorized } else { false } }
    var problem: String? { if #available(iOS 26, *) { AlarmScheduler.shared.problem } else { nil } }
    var isDenied: Bool { if #available(iOS 26, *) { AlarmScheduler.shared.isDenied } else { false } }
    func requestPermission() async -> Bool {
        if #available(iOS 26, *) { return await AlarmScheduler.shared.requestAuthorization() }
        return false
    }
    func reconcile(_ alerts: [ReminderScheduler.Alert], keepRinging: Set<String>, store: HabitStore) async -> Set<String> {
        if #available(iOS 26, *) { return await AlarmScheduler.shared.reconcile(alerts, keepRinging: keepRinging, store: store) }
        return []
    }
}
