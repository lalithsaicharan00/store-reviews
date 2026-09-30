import BackgroundTasks
import Core
import SwiftUI
import UserNotifications

/// Where a tapped notification sends Today.
@Observable
final class AppRouter {
    /// A section to open and scroll to on today.
    var focusSection: String?
}

/// The app's one store, scheduler and database. Shared, because a notification action, an alarm's
/// Done button or a background refresh can start the app without showing any screen.
final class AppModel {
    static let shared = AppModel()

    let store: HabitStore
    let scheduler = ReminderScheduler()
    /// A running timer on the Lock Screen, and its one "goal reached" notification.
    let timerPresence = TimerPresence()
    let router = AppRouter()
    private let persistence: Persistence?
    private var loading: Task<Void, Never>?

    static let refreshTaskID = "com.lalithsaicharan.habits.refresh"

    private init() {
        let arguments = ProcessInfo.processInfo.arguments
        var opened: Persistence?
        if arguments.contains("-uitest") {
            opened = Persistence.inMemory()
        } else if let i = arguments.firstIndex(of: "-dbname"), i + 1 < arguments.count {
            opened = try? Persistence.onDisk(name: arguments[i + 1], reset: arguments.contains("-reset-db"))
        } else {
            opened = try? Persistence.onDisk()
        }
        persistence = opened
        store = HabitStore(repository: (opened ?? Persistence.inMemory()).repository)
        if opened == nil {
            store.problem = "Your habits couldn't be opened. Nothing has been changed; please restart the app."
        }
        #if DEBUG
        // Debug builds behave like Plus, so the design's 14 habits fit. Launch with -free to test the free limit.
        store.isPlus = !arguments.contains("-free")
        #endif
    }

    /// Loads once, however many callers ask; later callers wait for the first load.
    func ensureLoaded() async {
        if let loading { return await loading.value }
        let task = Task { [self] in
            await store.load()
            guard store.isLoaded else { return }
            persistence?.markSchemaCurrent()
            #if DEBUG
            if ProcessInfo.processInfo.arguments.contains("-focus-fixture") {
                await FocusPlayerFixture.install(in: store, shortTimer: ProcessInfo.processInfo.arguments.contains("-focus-short-timer"))
            }
            if !ProcessInfo.processInfo.arguments.contains("-empty") { await store.seedDemo() }
            if !ProcessInfo.processInfo.arguments.contains("-uitest") && !ProcessInfo.processInfo.arguments.contains("-empty") {
                await store.addEveryTypeToAnytime()
            }
            #endif
            store.onChange = { [store, scheduler, timerPresence] in
                scheduler.scheduleReconcile(store)
                Task { await timerPresence.sync(store) }
            }
            scheduler.scheduleReconcile(store)
            // A timer left running (the app was closed, or the phone restarted) gets its Live Activity back.
            await timerPresence.sync(store)
        }
        loading = task
        await task.value
    }

    func dailySnapshot() async { await persistence?.dailySnapshotIfNeeded() }

    // MARK: Reminders acted on outside the app

    /// A notification's Done or +1, or an alarm's Done: the same store method a tap on Today uses,
    /// but only ever adding. Then reminders are re-planned, which clears the row's follow-ups.
    func logFromReminder(_ target: ReminderTarget) async {
        await ensureLoaded()
        guard let habit = store.habits.first(where: { $0.id == target.habit }) else { return }
        store.logFromReminder(habit, slot: target.slot, on: target.day)
        await store.flush()
        await scheduler.reconcile(store)
    }

    /// A tapped notification opens today's section.
    func open(_ target: ReminderTarget?, section: String?) {
        router.focusSection = section ?? target?.section
    }

    // MARK: Background refresh

    /// Keeps the next days' reminders planned even when the app isn't opened for a while.
    func scheduleRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: Self.refreshTaskID)
        request.earliestBeginDate = .now.addingTimeInterval(12 * 3600)
        try? BGTaskScheduler.shared.submit(request)
    }

    func handleRefresh(_ task: BGAppRefreshTask) {
        scheduleRefresh()
        let work = Task { [self] in
            await ensureLoaded()
            await scheduler.reconcile(store)
            task.setTaskCompleted(success: !Task.isCancelled)
        }
        task.expirationHandler = { work.cancel() }
    }
}

/// What a notification or alarm is about, carried in its user info (or an intent's parameters).
nonisolated struct ReminderTarget: Hashable, Sendable {
    var habit: UUID
    var time: UUID?
    var day: LocalDay
    /// The section tick it is for, for a habit ticked once per section.
    var slot: String?
    /// The section the time falls in, opened when the notification is tapped.
    var section: String?

    var userInfo: [String: String] {
        var info = ["habit": habit.uuidString, "day": day.key]
        if let time { info["time"] = time.uuidString }
        if let slot { info["slot"] = slot }
        if let section { info["section"] = section }
        return info
    }

    init(habit: UUID, time: UUID?, day: LocalDay, slot: String?, section: String?) {
        self.habit = habit; self.time = time; self.day = day; self.slot = slot; self.section = section
    }

    init?(userInfo: [AnyHashable: Any]) {
        guard let habit = (userInfo["habit"] as? String).flatMap(UUID.init(uuidString:)),
              let day = (userInfo["day"] as? String).flatMap(LocalDay.init(key:)) else { return nil }
        self.init(habit: habit, time: (userInfo["time"] as? String).flatMap(UUID.init(uuidString:)), day: day,
                  slot: userInfo["slot"] as? String, section: userInfo["section"] as? String)
    }
}

/// Sets up what must exist before launch finishes: the notification delegate and the refresh task.
final class AppDelegate: NSObject, UIApplicationDelegate {
    private let notifications = NotificationHandler()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        #if DEBUG
        MainThreadMeter.startIfAsked()
        #endif
        UNUserNotificationCenter.current().delegate = notifications
        ReminderScheduler.registerCategories()
        BGTaskScheduler.shared.register(forTaskWithIdentifier: AppModel.refreshTaskID, using: .main) { task in
            MainActor.assumeIsolated {
                guard let task = task as? BGAppRefreshTask else { return task.setTaskCompleted(success: false) }
                AppModel.shared.handleRefresh(task)
            }
        }
        return true
    }
}

/// Handles taps and actions on the app's notifications.
final class NotificationHandler: NSObject, UNUserNotificationCenterDelegate {
    nonisolated func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        let action = response.actionIdentifier
        let info = response.notification.request.content.userInfo
        let target = ReminderTarget(userInfo: info)
        let section = info["section"] as? String
        if action == ReminderScheduler.doneAction || action == ReminderScheduler.addAction {
            // Finish the write before returning, so iOS keeps the app awake until it's saved.
            if let target { await AppModel.shared.logFromReminder(target) }
        } else if action == UNNotificationDefaultActionIdentifier {
            await AppModel.shared.open(target, section: section)
        }
    }

    /// While the app is open, reminders still show as banners.
    nonisolated func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        [.banner, .list, .sound]
    }
}
