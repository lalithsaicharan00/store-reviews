import Foundation
import UserNotifications
import WatchKit

/// Notifications on the Watch (D, H13–H15).
///
/// - **The iPhone's reminders** reach the wrist by themselves (watchOS mirrors them). With the same categories registered
///   here, a Done or "+1 glass" pressed on the Watch comes to this app, which saves the same change with the same ID the
///   iPhone would (`ReminderIdentity.actionID` of the notification's own identifier), so it counts once wherever it's
///   pressed and however many devices handle it (WA13, D13). Dismiss never logs.
/// - **A timer started on the Watch** schedules its own goal alert with the iPhone's words (`TimerWords.goalMessage`),
///   cancelled when the timer stops on either device (R3).
final class WatchNotifications: NSObject, @preconcurrency UNUserNotificationCenterDelegate {
    // The iPhone's identifiers (ReminderScheduler): the categories must match for its actions to reach this app.
    static let doneAction = "habit.done"
    static let addAction = "habit.add"
    static let singleCategory = "habit.single"
    static let groupCategory = "habit.group"
    static let addCategoryPrefix = "habit.add."
    static let timerPrefix = "watch.timer."
    /// Timers started on this Watch, by habit: only the device that started a timer schedules its alert (R3: never twice).
    private static let startedHereKey = "watch.timersStartedHere"

    static func registerCategories(habits: [Habit] = []) {
        let hidden = HideNames.isOn
        var set: Set<UNNotificationCategory> = [
            UNNotificationCategory(identifier: singleCategory, actions: [UNNotificationAction(identifier: doneAction, title: "Done", options: [])],
                                   intentIdentifiers: [], options: []),
            UNNotificationCategory(identifier: groupCategory, actions: [], intentIdentifiers: [], options: []),
        ]
        for habit in habits where !habit.archived {
            guard case .amount(let unit, _) = habit.kind, let increment = habit.quickIncrement else { continue }
            let title = "+" + (hidden ? Format.amount(increment) : HabitCopy.amount(increment, unit))
            set.insert(UNNotificationCategory(identifier: addCategoryPrefix + habit.id.uuidString,
                                              actions: [UNNotificationAction(identifier: addAction, title: title, options: [])],
                                              intentIdentifiers: [], options: []))
        }
        UNUserNotificationCenter.current().setNotificationCategories(set)
    }

    // MARK: Actions pressed on the Watch

    @MainActor
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        let model = WatchModel.shared
        let info = response.notification.request.content.userInfo
        let target = ReminderTarget(userInfo: info)
        switch response.actionIdentifier {
        case Self.doneAction, Self.addAction:
            guard let target else { return }
            await model.ensureLoaded()
            guard let habit = model.store.habits.first(where: { $0.id == target.habit }) else { return }
            let token = response.notification.request.identifier
            model.store.logFromReminder(habit, slot: target.slot, on: target.day, time: target.time, signature: target.signature,
                                        eventID: ReminderIdentity.actionID("action:" + token))
            // Finished before returning, so the Watch stays awake until it's saved (D13); then the iPhone hears of it.
            await model.store.flush()
            model.link.sendNow()
        case UNNotificationDefaultActionIdentifier:
            // Tapping a reminder or a timer's alert opens that habit's Day details (F: "Its Day details").
            if let target, let url = URL(string: "oftenenough://watch/habit/\(target.habit.uuidString)") {
                WatchNavigation.shared.open(url, model: model)
            }
        default:
            break // Dismiss never logs
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        [.banner, .list, .sound]
    }

    // MARK: Timer goal alerts

    /// Re-plans this Watch's timer alerts after every change: one per timer started here and still running, at the moment
    /// it reaches its goal; none for a timer stopped anywhere.
    @MainActor
    static func syncTimerAlerts(_ store: HabitStore, now: Date = .now) async {
        let center = UNUserNotificationCenter.current()
        var started = UserDefaults.standard.dictionary(forKey: startedHereKey) as? [String: Double] ?? [:]
        // A timer this Watch started is recognised by its start: one started elsewhere has a different start.
        started = started.filter { id, start in
            guard let uuid = UUID(uuidString: id), let running = store.timers[uuid] else { return false }
            return abs(running.timeIntervalSince1970 - start) < 1
        }
        UserDefaults.standard.set(started, forKey: startedHereKey)
        let pending = await center.pendingNotificationRequests().map(\.identifier).filter { $0.hasPrefix(timerPrefix) }
        center.removePendingNotificationRequests(withIdentifiers: pending)
        let day = store.today(now: now)
        for (id, _) in started {
            guard let uuid = UUID(uuidString: id), let habit = store.habits.first(where: { $0.id == uuid }), !store.isComplete(habit, on: day) else { continue }
            let left = store.goal(of: habit) - store.progress(of: habit, on: day, now: now)
            guard left > 0 else { continue }
            let content = UNMutableNotificationContent()
            content.title = HideNames.isOn ? (habit.reminderText ?? "Timer") : habit.name
            content.body = TimerWords.goalMessage(habit, goal: store.goal(of: habit))
            content.sound = .default
            content.userInfo = ReminderTarget(habit: habit.id, time: nil, day: day, slot: nil, section: nil).userInfo
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: max(1, left * 60), repeats: false)
            try? await center.add(UNNotificationRequest(identifier: timerPrefix + id, content: content, trigger: trigger))
        }
    }

    /// A timer was just started on this Watch.
    static func startedHere(_ habit: UUID, at start: Date) {
        var started = UserDefaults.standard.dictionary(forKey: startedHereKey) as? [String: Double] ?? [:]
        started[habit.uuidString] = start.timeIntervalSince1970
        UserDefaults.standard.set(started, forKey: startedHereKey)
        Task { _ = try? await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) }
    }
}
