import BackgroundTasks
import Core
import SwiftUI
import UserNotifications

/// Where a tapped notification sends Today.
@Observable
final class AppRouter {
    /// A section to open and scroll to on today.
    var focusSection: String?
    /// A day to open on Today, from Progress's Day sheet ("Show on Today").
    var showDay: LocalDay?
    /// A habit page to open (Siri or Shortcuts "Open a Habit").
    var openHabit: UUID?
    var widgetItem: UUID?
    var widgetToday = false
    /// A running timer's Live Activity was tapped: open that habit's timer screen.
    var timerHabit: UUID?
}

/// The app's one store, scheduler and database. Shared, because a notification action, an alarm's
/// Done button or a background refresh can start the app without showing any screen.
final class AppModel {
    static let shared = AppModel()

    let store: HabitStore
    let scheduler: ReminderScheduler
    /// A running timer on the Lock Screen, and its one "goal reached" notification.
    let timerPresence = TimerPresence()
    let router = AppRouter()
    /// Keeps this device in step with the account's other devices once someone signs in (Plus). Nil without a database.
    let sync: SyncService?
    /// Where the backup goes, whether it works, moving and restoring (Backup, Sync and Accounts). Nil without a database.
    let backup: BackupCenter?
    let widgets = WidgetPublisher()
    /// The ≡ menu and Today's navigation path.
    let menu = MenuModel()
    /// Lock with Face ID (≡ → Privacy). Off unless turned on.
    let lock = AppLock()
    private let persistence: Persistence?
    private var loading: Task<Void, Never>?

    /// Debug builds (Xcode, GitHub's UI tests) use dev; release builds (TestFlight, the App Store) use production, which
    /// has no test sign-ins. Launch a debug build with `-api <url>` to point it elsewhere.
    #if DEBUG
    private static let apiBase = URL(string: "https://api-dev.oftenenough.com")!
    #else
    private static let apiBase = URL(string: "https://api.oftenenough.com")!
    #endif

    static let refreshTaskID = "com.oftenenough.app.refresh"

    private init() {
        let arguments = ProcessInfo.processInfo.arguments
        #if DEBUG
        if arguments.contains("-reminder-fake") || arguments.contains("-reminder-denied") {
            let notifications = FakeReminderNotifications()
            notifications.status = arguments.contains("-reminder-denied") ? .denied : arguments.contains("-perf-reminders") ? .authorized : .notDetermined
            scheduler = ReminderScheduler(notifications: notifications, alarms: FakeReminderAlarms())
        } else { scheduler = ReminderScheduler() }
        #else
        scheduler = ReminderScheduler()
        #endif
        var opened: Persistence?
        if arguments.contains("-uitest") || arguments.contains("-dbname") {
            // Every UI test starts with Today showing completed habits and tasks: a test that turned "Hide Completed"
            // on and failed before turning it off hid the habits the next tests tap (3 Oct 2026, merge check).
            UserDefaults.standard.removeObject(forKey: Preferences.hideDoneHabits)
            UserDefaults.standard.removeObject(forKey: Preferences.hideDoneTasks)
            UserDefaults.standard.removeObject(forKey: Preferences.doneOrder)
            UserDefaults.standard.removeObject(forKey: Preferences.timerScreen)
            UserDefaults.standard.removeObject(forKey: Preferences.timerLiveActivity)
        }
        if arguments.contains("-uitest") {
            opened = Persistence.inMemory()
            // Each UI test starts with Progress's view options and the group filters as a new person has them.
            for key in [ProgressOptions.showPercentages, ProgressOptions.showStreaks, ProgressOptions.range, ProgressOptions.fullDay,
                        GroupFilter.today, GroupFilter.progress] {
                UserDefaults.standard.removeObject(forKey: key)
            }
        } else if let i = arguments.firstIndex(of: "-dbname"), i + 1 < arguments.count {
            opened = try? Persistence.onDisk(name: arguments[i + 1], reset: arguments.contains("-reset-db"))
        } else {
            opened = try? Persistence.onDisk()
        }
        #if DEBUG
        if arguments.contains("-simulate-open-failure") { opened = nil } // PersistenceUITests
        #endif
        persistence = opened
        store = HabitStore(repository: (opened ?? Persistence.inMemory()).repository, databaseOpened: opened != nil)
        var api = Self.apiBase
        #if DEBUG
        if let i = arguments.firstIndex(of: "-api"), i + 1 < arguments.count, let url = URL(string: arguments[i + 1]) { api = url }
        #endif
        // A test launch on its in-memory database never uses the app's own sign-in (its keychain and account keys are
        // named after the store): on a real iPhone it could otherwise sync its demo habits into the person's account.
        let testLaunch = arguments.contains("-uitest")
        let storeName = arguments.firstIndex(of: "-dbname").flatMap { $0 + 1 < arguments.count ? arguments[$0 + 1] : nil }
            ?? (testLaunch ? "uitest" : "habits")
        sync = opened.map { SyncService(repository: $0.repository, storeName: storeName, api: api, reset: arguments.contains("-reset-db")) }
        if let opened, let sync {
            backup = BackupCenter(repository: opened.repository, sync: sync, store: store, sandboxed: testLaunch)
        } else {
            backup = nil
        }
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
            // The database couldn't be opened, so the store stands on an empty in-memory one. Loading that would
            // show "No habits yet" and take changes that vanish on quit; staying unloaded keeps everything read-only.
            guard persistence != nil else { return }
            let loadStarted = Date.now
            await store.load()
            LaunchLog.took("Store: load", since: loadStarted)
            guard store.isLoaded, store.isStorageReady else { return }
            persistence?.markSchemaCurrent()
            #if DEBUG
            if ProcessInfo.processInfo.arguments.contains("-widget-fixture") { await WidgetFixture.install(in: store) }
            if ProcessInfo.processInfo.arguments.contains("-reminder-fixture") { await ReminderFixture.install(in: store) }
            if ProcessInfo.processInfo.arguments.contains("-task-fixture") { await TaskFixture.install(in: store) }
            if ProcessInfo.processInfo.arguments.contains("-focus-fixture") {
                await FocusPlayerFixture.install(in: store, shortTimer: ProcessInfo.processInfo.arguments.contains("-focus-short-timer"))
            }
            if !ProcessInfo.processInfo.arguments.contains("-empty") { await store.seedDemo() }
            if !ProcessInfo.processInfo.arguments.contains("-uitest") && !ProcessInfo.processInfo.arguments.contains("-empty") {
                await store.addEveryTypeToAnytime()
            }
            #endif
            store.onChange = { [store, scheduler, timerPresence, widgets, sync, backup] in
                scheduler.scheduleReconcile(store)
                widgets.schedule(store)
                // Siri's phrases name each habit: refreshed when one is added, renamed or archived (cheap otherwise).
                perfTimed("Change: Siri's habit names") { HabitShortcuts.habitsChanged(store) }
                Task { await timerPresence.sync(store) }
                sync?.scheduleSoon()
                backup?.dataChanged()
            }
            sync?.onRemoteChanges = { [store] in store.reloadAfterSync() }
            sync?.onAccountChange = { [backup] in backup?.refresh() }
            #if DEBUG
            // End-to-end tests on GitHub Actions sign in with the run's identity token (server: POST /v1/auth/ci).
            let arguments = ProcessInfo.processInfo.arguments
            if let i = arguments.firstIndex(of: "-ci-sign-in"), i + 2 < arguments.count {
                let started = Date.now
                try? await sync?.signIn(path: "/v1/auth/ci", body: ["idToken": arguments[i + 1], "subject": arguments[i + 2], "create": true])
                LaunchLog.took("CI sign-in", since: started)
            }
            // The same, as a free account (BackupUITests): backups go to the server, nothing syncs.
            if let i = arguments.firstIndex(of: "-ci-sign-in-free"), i + 2 < arguments.count {
                let started = Date.now
                try? await sync?.signIn(path: "/v1/auth/ci", body: ["idToken": arguments[i + 1], "subject": arguments[i + 2], "create": true, "plus": false])
                LaunchLog.took("CI sign-in (free)", since: started)
            }
            #endif
            // Each step's time goes to the system log (`LaunchLog`), which CI saves as app.log (Current Work 11).
            var started = Date.now
            sync?.appBecameActive()
            LaunchLog.took("Sync: app became active", since: started)
            Task { [backup] in
                let started = Date.now
                await backup?.runIfDue()
                LaunchLog.took("Backup: run if due", since: started)
            }
            started = .now
            scheduler.scheduleReconcile(store)
            HabitShortcuts.habitsChanged(store)
            LaunchLog.took("Reminders and Siri names", since: started)
            // A timer left running (the app was closed, or the phone restarted) gets its Live Activity back.
            started = .now
            await timerPresence.sync(store)
            LaunchLog.took("Timers: Live Activities", since: started)
            started = .now
            await widgets.publish(store)
            LaunchLog.took("Widgets: publish", since: started)
        }
        loading = task
        await task.value
        // A read blocked by file protection can succeed after the first unlock.
        if !store.isStorageReady { loading = nil }
    }

    func dailySnapshot() async { await persistence?.dailySnapshotIfNeeded() }

    // MARK: Reminders acted on outside the app

    /// A notification's Done or +1, or an alarm's Done: the same store method a tap on Today uses,
    /// but only ever adding. Then reminders are re-planned, which clears the row's follow-ups.
    func logFromReminder(_ target: ReminderTarget, event: String? = nil) async {
        await ensureLoaded()
        guard let habit = store.habits.first(where: { $0.id == target.habit }) else { return }
        let token = event ?? target.event ?? "reminder.\(target.habit).\(target.time?.uuidString ?? "legacy").\(target.day.key)"
        store.logFromReminder(habit, slot: target.slot, on: target.day, time: target.time, signature: target.signature,
                              eventID: ReminderIdentity.actionID("action:" + token))
        await store.flush()
        await scheduler.reconcile(store)
    }

    /// The Live Activity's Pause: stops the timer and saves its time, as ⏸ in the app does. It only stops; it never starts.
    func stopTimerFromLiveActivity(_ habitID: UUID) async {
        await ensureLoaded()
        guard let habit = store.habits.first(where: { $0.id == habitID }), store.timers[habitID] != nil else {
            await timerPresence.sync(store)
            return
        }
        store.toggleTimer(habit)
        await store.flush()
        await timerPresence.sync(store)
    }

    /// A tapped notification opens today's section.
    func open(_ target: ReminderTarget?, section: String?) {
        router.focusSection = section ?? target?.section
    }

    func logFromWidget(item: String, day: String, event: String, signature: String) async throws {
        await ensureLoaded()
        guard store.isLoaded, store.isStorageReady, store.problem == nil,
              let id = UUID(uuidString: item), let day = LocalDay(key: day), let event = UUID(uuidString: event) else {
            throw WidgetActionError.openApp
        }
        store.logFromWidget(id: id, day: day, event: event, signature: signature)
        await store.flush()
        guard store.problem == nil else { throw WidgetActionError.save }
        await widgets.publish(store)
        guard widgets.problem == nil else { throw WidgetActionError.save }
        await scheduler.reconcile(store)
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
            // The nightly backup, when the app wasn't opened (Backup, Sync and Accounts §4.2).
            await backup?.runIfDue()
            await backup?.notifyIfClosed()
            await widgets.publish(store)
            task.setTaskCompleted(success: !Task.isCancelled && store.isStorageReady && scheduler.problem == nil)
        }
        task.expirationHandler = { work.cancel() }
    }
}

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

/// Sets up what must exist before launch finishes: the notification delegate and the refresh task.
final class AppDelegate: NSObject, UIApplicationDelegate {
    private let notifications = NotificationHandler()

    func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication) {
        applicationSignificantTimeChange(application)
    }

    func applicationSignificantTimeChange(_ application: UIApplication) {
        Task {
            let model = AppModel.shared
            await model.ensureLoaded()
            await model.scheduler.reconcile(model.store)
            await model.widgets.publish(model.store)
        }
    }

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
            if let target { await AppModel.shared.logFromReminder(target, event: response.notification.request.identifier) }
        } else if action == UNNotificationDefaultActionIdentifier, info[BackupCenter.notificationKey] != nil {
            // Straight to ≡ → Backup & Export, on Today's stack so Back is Today.
            await MainActor.run {
                let menu = AppModel.shared.menu
                menu.reset()
                menu.path.append(MenuPlace.backup)
            }
        } else if action == UNNotificationDefaultActionIdentifier {
            await AppModel.shared.open(target, section: section)
        }
    }

    /// While the app is open, reminders still show as banners.
    nonisolated func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        let request = notification.request
        guard request.identifier.hasPrefix("reminder.") else { return [.banner, .list, .sound] }
        let model = await AppModel.shared
        await model.ensureLoaded()
        if let target = ReminderTarget(userInfo: request.content.userInfo) {
            guard await model.store.canActOnReminder(target) else { return [] }
        } else if let list = request.content.userInfo["habits"] as? String {
            let ids = Set(list.split(separator: ",").compactMap { UUID(uuidString: String($0)) })
            let valid = await MainActor.run { model.store.habits.contains { ids.contains($0.id) && !$0.archived && $0.remind && ($0.atMost || !model.store.isSatisfied($0, on: model.store.today())) && model.store.isDue($0, on: model.store.today()) } }
            guard valid else { return [] }
        }
        return [.banner, .list, .sound]
    }
}
