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
    /// A widget's ▶ with Open Timer Full Screen on: start that habit's timer, then open its screen.
    var startTimer = false
    /// A widget's button for something that needs a screen (an amount with no saved step, Record a slip): that sheet,
    /// straight away, with no navigating (the user, 6 Oct 2026). iOS can't show it over the Home Screen.
    var widgetSheet: WidgetSheet?
    /// A widget's "Choose a habit": the Widgets guide, which says how to pick one (Edit Widget).
    var widgetSetup = false
}

/// The sheet a widget opens in the app.
struct WidgetSheet: Identifiable, Equatable {
    enum Kind: String { case log, slip }
    let kind: Kind
    let habit: UUID
    var id: String { kind.rawValue + habit.uuidString }
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
    /// Sync with the person's own iCloud (Architecture 11; Rulebook D16). Nil without a database.
    let cloud: CloudSync?
    /// This device's ID (kept in its Keychain): its iCloud backup folder, and the free plan's syncing device.
    let identity: DeviceIdentity
    /// The backup files, restoring and exporting (Architecture 03, 11 §13.3). Nil without a database.
    let backup: BackupCenter?
    let widgets = WidgetPublisher()
    /// The ≡ menu and Today's navigation path.
    let menu = MenuModel()
    /// App Lock (≡ → Privacy & Security). Off unless turned on.
    let lock: AppLock
    /// Plus from the App Store (StoreKit 2, Current Work 80): listening from launch.
    let plus: PlusStore
    private let persistence: Persistence?
    private var loading: Task<Void, Never>?

    static let refreshTaskID = "com.oftenenough.app.refresh"

    private init() {
        // Before anything reads a setting: a test launch holds the person's settings aside; an ordinary one puts them
        // back (Current Work 74, D8).
        TestLaunchIsolation.begin()
        // "Hide widget content" becomes Hide Names Outside the App, keeping the person's choice (Current Work 58), before
        // anything reads it.
        HideNames.migrate()
        lock = AppLock()
        #if DEBUG
        if ProcessInfo.processInfo.arguments.contains("-testlaunch-report") { TestLaunchIsolation.makeReport() }
        if let flag = ProcessInfo.processInfo.arguments.firstIndex(of: "-widget-timing"), flag + 1 < ProcessInfo.processInfo.arguments.count {
            UserDefaults(suiteName: WidgetDisk.group)?.set(ProcessInfo.processInfo.arguments[flag + 1] == "on", forKey: "debug.widgetTiming")
        }
        WidgetTiming.mark("app: model init")
        // WidgetLatencyDeviceTests: the old week-long widget timelines or the new short ones, side by side (S2).
        if ProcessInfo.processInfo.arguments.contains("-widget-week-timeline") {
            UserDefaults(suiteName: WidgetDisk.group)?.set(true, forKey: "debug.weekTimeline")
        } else if ProcessInfo.processInfo.arguments.contains("-widget-short-timeline") {
            UserDefaults(suiteName: WidgetDisk.group)?.removeObject(forKey: "debug.weekTimeline")
        }
        // WidgetLatencyDeviceTests: the log buttons run a stand-in that changes no data ("live", "extension", "off").
        let launchArguments = ProcessInfo.processInfo.arguments
        if let flag = launchArguments.firstIndex(of: "-widget-probe"), flag + 1 < launchArguments.count {
            let mode = launchArguments[flag + 1]
            UserDefaults(suiteName: WidgetDisk.group)?.set(mode == "off" ? nil : mode, forKey: "debug.probeIntent")
        }
        if let flag = launchArguments.firstIndex(of: "-widget-page-probe"), flag + 1 < launchArguments.count {
            let mode = launchArguments[flag + 1]
            UserDefaults(suiteName: WidgetDisk.group)?.set(mode == "off" ? nil : mode, forKey: "debug.pageProbe")
        }
        #endif
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
            HeatKeyVisit.forgetAll()
        }
        if arguments.contains("-uitest") {
            opened = Persistence.inMemory()
            // Each UI test starts with Progress's view options and the group filters as a new person has them.
            for key in [ProgressOptions.showPercentages, ProgressOptions.showStreaks, ProgressOptions.range, ProgressOptions.fullDay,
                        GroupFilter.today, GroupFilter.progress] {
                UserDefaults.standard.removeObject(forKey: key)
            }
        } else if let i = arguments.firstIndex(of: "-dbname"), i + 1 < arguments.count {
            opened = try? Persistence.onDisk(name: arguments[i + 1], reset: Self.resetsDatabase(arguments))
        } else {
            opened = try? Persistence.onDisk()
        }
        #if DEBUG
        if arguments.contains("-simulate-open-failure") { opened = nil } // PersistenceUITests
        #endif
        persistence = opened
        store = HabitStore(repository: (opened ?? Persistence.inMemory()).repository, databaseOpened: opened != nil)
        // A test launch never uses the person's iCloud (D8): its device ID is named after its own store, and its iCloud is
        // `FakeCloud`, signed out unless the test asks (`-test-cloud`), so demo habits can never reach the person's iCloud.
        let testLaunch = arguments.contains("-uitest")
        let storeName = arguments.firstIndex(of: "-dbname").flatMap { $0 + 1 < arguments.count ? arguments[$0 + 1] : nil }
            ?? (testLaunch ? "uitest" : "habits")
        let identity = DeviceIdentity(storeName: storeName, reset: Self.resetsDatabase(arguments))
        self.identity = identity
        let cloud = opened.map { CloudSync(repository: $0.repository, transport: Self.cloudTransport(arguments), identity: identity) }
        self.cloud = cloud
        if let opened {
            backup = BackupCenter(repository: opened.repository, identity: identity, cloud: cloud, store: store, sandboxed: testLaunch)
        } else {
            backup = nil
        }
        if opened == nil {
            store.problem = "Your habits couldn't be opened. Nothing has been changed; please restart the app."
        }
        // A log's tap and the completion sound, only while the app is on screen: a Siri or Lock Screen log made in the
        // background stays silent (Current Work 18).
        store.onLog = { completed in
            guard UIApplication.shared.applicationState == .active else { return }
            TickFeedback.logged(finished: completed)
        }
        // Plus from the App Store, beside the account's: either unlocks unlimited habits. A test launch uses a stand-in
        // App Store and never sees the person's own purchases (D8), unless `-real-storekit` asks for the real one.
        var storeBackend: PlusBackend = AppStoreBackend()
        #if DEBUG
        if testLaunch && !arguments.contains("-real-storekit") { storeBackend = PlusTestBackend() }
        #endif
        plus = PlusStore(backend: storeBackend, remembers: !testLaunch && !arguments.contains("-dbname"))
        plus.onChange = { [store] has in store.storePlus = has }
        plus.start()
        #if DEBUG
        // Debug builds behave like Plus, so the design's 14 habits fit. Launch with -free to test the free limit.
        store.isPlus = !arguments.contains("-free")
        // `-clock-hour N`: the store's clock runs as if it were N:30 today, so a test can be "after midnight, before a
        // 3 AM day start" whenever CI runs (Current Work 52). Test launches only; the time keeps moving from there.
        if testLaunch, let flag = arguments.firstIndex(of: "-clock-hour"), flag + 1 < arguments.count,
           let hour = Int(arguments[flag + 1]),
           let target = Calendar.current.date(bySettingHour: hour, minute: 30, second: 0, of: .now) {
            let offset = target.timeIntervalSinceNow
            store.clock = { Date.now.addingTimeInterval(offset) }
        }
        #endif
    }

    /// Hide Names Outside the App or App Lock changed (Current Work 58; spec §2.3): the widgets are published at once,
    /// reminders and alarms re-planned, a running timer's Live Activity updated and Siri's habit phrases refreshed, so the
    /// next of each already follows it.
    func privacyChanged() async {
        guard store.isLoaded else { return }
        HabitShortcuts.habitsChanged(store)
        await widgets.publish(store, immediate: true)
        await scheduler.reconcile(store)
        await timerPresence.sync(store)
    }

    /// The person's iCloud through `CKSyncEngine`; for any test launch (`-uitest`, `-dbname`), `FakeCloud` instead (D8).
    private static func cloudTransport(_ arguments: [String]) -> CloudTransport {
        #if DEBUG
        if arguments.contains("-uitest") || arguments.contains("-dbname") { return CloudTestStates.transport(arguments) }
        #endif
        return CloudKitTransport()
    }

    /// `-reset-db` (system tests: `-dbname habits -reset-db`). On a real iPhone it never deletes the person's own
    /// database, "habits", or its sign-in: those tests are for the simulator (D8; found 8 Oct 2026, Current Work 74).
    private static func resetsDatabase(_ arguments: [String]) -> Bool {
        guard arguments.contains("-reset-db") else { return false }
        #if targetEnvironment(simulator)
        return true
        #else
        let name = arguments.firstIndex(of: "-dbname").flatMap { $0 + 1 < arguments.count ? arguments[$0 + 1] : nil } ?? "habits"
        return name != "habits"
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
            if ProcessInfo.processInfo.arguments.contains("-plus-fixture") { await PlusFixture.install(in: store) }
            if ProcessInfo.processInfo.arguments.contains("-day-details-fixture") { await DayDetailsFixture.install(in: store) }
            if ProcessInfo.processInfo.arguments.contains("-focus-fixture") {
                await FocusPlayerFixture.install(in: store, shortTimer: ProcessInfo.processInfo.arguments.contains("-focus-short-timer"))
            }
            // Demo data never goes to iCloud (D14, Architecture 11 §13.1): a Debug build on a phone with iCloud adds none,
            // so demo habits can't merge into the person's habits there (8 Oct 2026, Current Work 72: 28 demo habits
            // reached the user's account and had to be removed by ID). Test launches have their own database and iCloud (D8).
            let testLaunch = ProcessInfo.processInfo.arguments.contains("-uitest") || ProcessInfo.processInfo.arguments.contains("-dbname")
            let signedIn = !testLaunch && FileManager.default.ubiquityIdentityToken != nil
            if !ProcessInfo.processInfo.arguments.contains("-empty") && !signedIn { await store.seedDemo() }
            // WidgetLatencyDeviceTests: take back exactly the widget logs its real taps made (source widget, made
            // after the test began), so measuring on the person's iPhone leaves their day as it was.
            if let flag = ProcessInfo.processInfo.arguments.firstIndex(of: "-undo-widget-logs-since"),
               flag + 1 < ProcessInfo.processInfo.arguments.count,
               let since = Double(ProcessInfo.processInfo.arguments[flag + 1]) {
                let start = Date(timeIntervalSince1970: since)
                let anySource = ProcessInfo.processInfo.arguments.contains("-undo-any-source")
                for entry in store.entries where (anySource || entry.source == .widget || entry.source == .timer) && entry.createdAt >= start {
                    store.undoEntry(entry.id)
                }
                await store.flush()
            }
            if !ProcessInfo.processInfo.arguments.contains("-uitest") && !ProcessInfo.processInfo.arguments.contains("-empty") && !signedIn {
                await store.addEveryTypeToAnytime()
            }
            #endif
            // Widget taps made while the app wasn't running, saved before anything is shown (Current Work 66).
            Task { await self.saveWidgetTaps() }
            var plus = store.isPlus
            store.onChange = { [store, scheduler, timerPresence, widgets, cloud, backup] in
                scheduler.scheduleReconcile(store)
                // Speed runs only (Current Work 49): `-perf-no-widget-publish` leaves the publication out, to see its cost.
                if PerfSwitches.widgetPublication { widgets.schedule(store) }
                // Siri's phrases name each habit: refreshed when one is added, renamed or archived (cheap otherwise).
                perfTimed("Change: Siri's habit names") { HabitShortcuts.habitsChanged(store) }
                Task { await timerPresence.sync(store) }
                cloud?.scheduleSoon()
                // Plus arrived or ended: every device syncs, or one (Architecture 11 §12).
                if store.isPlus != plus { plus = store.isPlus; cloud?.planChanged() }
                backup?.dataChanged()
                // A log made outside the app (a widget, a notification, the Live Activity): backed up as you go (D12).
                if UIApplication.shared.applicationState != .active { backup?.changedOutside() }
            }
            backup?.onRetryLater = { [weak self] seconds in self?.scheduleRefresh(after: seconds) }
            cloud?.onRemoteChanges = { [store] in store.reloadAfterSync() }
            // Changes left waiting after a failure (offline, iCloud busy): iOS retries in the background in about 15
            // minutes, as well as the next time the app opens (Current Work 67).
            cloud?.onWaitingAfterFailure = { [weak self] in self?.scheduleRefresh(after: 15 * 60) }
            cloud?.isPlus = { [store] in store.isPlus }
            cloud?.habitCount = { [store] in store.habits.filter { $0.kind != .task && !$0.archived }.count }
            // A fresh install sends nothing until its welcome is finished, so an empty phone is never the truth (§13.1).
            cloud?.sendingAllowed = { [store] in BackupCenter.backupAllowed(welcomeFinished: UserDefaults.standard.bool(forKey: Onboarding.doneKey), hasHabits: !store.habits.isEmpty) }
            #if DEBUG
            // BackupUITests (Current Work 76): a backup file with one habit, opened as if from Files, so the restore
            // preview's words (this iPhone, or with Plus every device) can be checked without the file picker.
            if ProcessInfo.processInfo.arguments.contains("-test-restore-preview"), let backup {
                Task { @MainActor in
                    let repository = Persistence.inMemory().repository
                    let sample = HabitStore(repository: repository)
                    await sample.load()
                    sample.isPlus = true
                    sample.add(Habit(name: "Restored habit", symbol: "star", color: .orange, kind: .check, goal: 1))
                    await sample.flush()
                    if let file = try? await repository.backupFile(info: BackupCenter.info), let data = Data(base64Encoded: file.base64) {
                        backup.incoming = await backup.check(data)
                    }
                }
            }
            await CloudTestStates.prepareIfAsked(cloud: cloud, repository: persistence?.repository)
            #endif
            // Each step's time goes to the system log (`LaunchLog`), which CI saves as app.log (Current Work 11).
            var started = Date.now
            // iCloud: the account and the plan decide whether the engine runs; then fetch and send. Started in the
            // background for a widget, a notification or the Live Activity, the change is sent by itself (`scheduleSoon`).
            if let cloud {
                Task { await cloud.start(); if UIApplication.shared.applicationState != .background { cloud.appBecameActive() } }
            }
            LaunchLog.took("iCloud: started", since: started)
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
            #if DEBUG
            ReminderLiveTest.runIfAsked(store: store, scheduler: scheduler)
            #endif
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
        #if DEBUG
        WidgetTiming.mark("reminder action: logging, app \(UIApplication.shared.applicationState == .active ? "in front" : "in the background")")
        #endif
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
            #if DEBUG
            WidgetTiming.mark("live activity pause: no running timer for that habit (\(store.habits.contains { $0.id == habitID } ? "habit found" : "no habit"), \(store.timers.count) running)")
            #endif
            await timerPresence.sync(store)
            return
        }
        #if DEBUG
        WidgetTiming.mark("live activity pause: stopping the timer")
        #endif
        store.toggleTimer(habit)
        await store.flush()
        await timerPresence.sync(store)
    }

    /// A tapped notification opens today's section.
    func open(_ target: ReminderTarget?, section: String?) {
        router.focusSection = section ?? target?.section
    }

    /// A widget's ✓ or + (`WidgetLogIntent`), run in the app's process: written first, then the widgets show it, with
    /// today's lists held in place for the next tap in a run (U4).
    // LOCKED (widget taps, 8 Oct 2026): saved in order, removed only after saving, run on hand-over, launch and return (W4, W5). Read iOS/Docs/Widgets — Taps and Updates (Locked).md before changing; changes need the user's say-so.
    /// Every widget tap waiting in the shared file (`WidgetTaps`), saved in the order it was made, then removed from the
    /// file only once it's in the database (Current Work 66). Run when a widget hands over (`WidgetSaveIntent`), and
    /// whenever the app starts or comes back, so no tap stays only in the file. One run at a time, after any earlier.
    func saveWidgetTaps() async {
        let previous = widgetTaps
        let run = Task { @MainActor [self] in
            _ = await previous?.result
            await ensureLoaded()
            guard store.isLoaded, store.isStorageReady, store.problem == nil else { return }
            let taps = WidgetTaps.read()
            guard !taps.isEmpty else { return }
            for tap in taps {
                guard let id = UUID(uuidString: tap.item), let day = LocalDay(key: tap.day), let event = UUID(uuidString: tap.event) else { continue }
                store.logFromWidget(id: id, day: day, event: event, signature: tap.signature, mode: tap.mode, now: tap.at)
            }
            await store.flush()
            // A tap the store refused (another day, a changed or paused habit) is dropped with the rest: it can never
            // be saved, and the widget redraws from the database below. A storage failure keeps them all for later.
            if store.problem != nil, !store.isStorageReady { return }
            store.problem = nil
            WidgetTaps.remove(Set(taps.map(\.event)))
            await widgets.publish(store, hold: true)
            await scheduler.reconcile(store)
        }
        widgetTaps = Task { try await run.value }
        await run.value
    }

    /// Widget taps, one after another (Current Work 66): a quick run of taps, on one habit or several, is saved in the
    /// order it was made, each completely, so none can overtake or overwrite another.
    private var widgetTaps: Task<Void, Error>?

    func logFromWidget(item: String, day: String, event: String, signature: String, mode: String = "add") async throws {
        let previous = widgetTaps
        let tap = Task { @MainActor [self] in
            _ = await previous?.result
            try await saveWidgetTap(item: item, day: day, event: event, signature: signature, mode: mode)
        }
        widgetTaps = tap
        try await tap.value
    }

    private func saveWidgetTap(item: String, day: String, event: String, signature: String, mode: String) async throws {
        await ensureLoaded()
        #if DEBUG
        WidgetTiming.mark("tap: store loaded")
        #endif
        guard store.isLoaded, store.isStorageReady, store.problem == nil,
              let id = UUID(uuidString: item), let day = LocalDay(key: day), let event = UUID(uuidString: event) else {
            throw WidgetActionError.openApp
        }
        store.logFromWidget(id: id, day: day, event: event, signature: signature, mode: mode)
        await store.flush()
        #if DEBUG
        WidgetTiming.mark("tap: log saved")
        #endif
        guard store.problem == nil else { throw WidgetActionError.save }
        await widgets.publish(store, hold: true)
        #if DEBUG
        WidgetTiming.mark("tap: widgets published")
        #endif
        guard widgets.problem == nil else { throw WidgetActionError.save }
        await scheduler.reconcile(store)
        #if DEBUG
        WidgetTiming.mark("tap: reminders planned")
        #endif
    }

    /// A widget's ▶ or ⏸ (`WidgetTimerIntent`): the same timer as Today's row, so the Live Activity and the Dynamic
    /// Island show it at once, and ⏸ saves the session once.
    func timerFromWidget(item: String, day: String, start: Bool, signature: String) async throws {
        let previous = widgetTaps
        let tap = Task { @MainActor [self] in
            _ = await previous?.result
            try await saveTimerTap(item: item, day: day, signature: signature)
        }
        widgetTaps = tap
        try await tap.value
    }

    /// A widget's timer switch: each tap starts it if it isn't running and stops it if it is, in the order the taps
    /// came (Current Work 66), so a quick second tap stops what the first started, as the switch shows.
    private func saveTimerTap(item: String, day: String, signature: String) async throws {
        await ensureLoaded()
        guard store.isLoaded, store.isStorageReady, store.problem == nil,
              let id = UUID(uuidString: item), let day = LocalDay(key: day) else { throw WidgetActionError.openApp }
        let start = store.timers[id] == nil
        let accepted = store.timerFromWidget(id: id, day: day, start: start, signature: signature)
        await store.flush()
        await timerPresence.sync(store)
        guard store.problem == nil else { throw WidgetActionError.save }
        await widgets.publish(store, hold: true)
        guard accepted else { throw WidgetActionError.stale }
        await scheduler.reconcile(store)
    }

    // MARK: Background refresh

    /// Keeps the next days' reminders planned even when the app isn't opened for a while. `after` is sooner when a
    /// sync failed with changes still waiting (Current Work 67): iOS decides the actual time.
    func scheduleRefresh(after: TimeInterval = 12 * 3600) {
        let request = BGAppRefreshTaskRequest(identifier: Self.refreshTaskID)
        request.earliestBeginDate = .now.addingTimeInterval(after)
        try? BGTaskScheduler.shared.submit(request)
    }

    func handleRefresh(_ task: BGAppRefreshTask) {
        scheduleRefresh()
        let work = Task { [self] in
            await ensureLoaded()
            // Anything still waiting to reach iCloud (a send that failed offline) goes now (Current Work 67).
            await cloud?.backgroundRefresh()
            await scheduler.reconcile(store)
            // A log made outside the app within 10 minutes of the last upload, then the daily backup when the app wasn't
            // opened (Current Work 75).
            await backup?.runIfDue(.outside)
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
        // iCloud's silent pushes tell this device another one changed something (`CKSyncEngine` listens for them).
        // Never for a test launch, which has no iCloud of the person's (D8).
        let arguments = ProcessInfo.processInfo.arguments
        if !arguments.contains("-uitest") && !arguments.contains("-dbname") { application.registerForRemoteNotifications() }
        return true
    }

    /// A silent push from iCloud: changes are waiting there. Fetched now, while iOS gives the app the time.
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) async -> UIBackgroundFetchResult {
        await AppModel.shared.ensureLoaded()
        await AppModel.shared.cloud?.backgroundRefresh()
        return .newData
    }
}

/// Handles taps and actions on the app's notifications.
///
/// On the main actor (8 Oct 2026, Current Work 70): with `nonisolated` async methods, iOS was told "finished" from a
/// background thread and UIKit stopped the app (`NSInternalInconsistencyException` in
/// `_performBlockAfterCATransactionCommitSynchronizes`) a moment after every reminder Done or +1, after the log was
/// saved but before it was synced. Crash report `Habits-2026-10-08-150605.ips`.
final class NotificationHandler: NSObject, @preconcurrency UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        let action = response.actionIdentifier
        let info = response.notification.request.content.userInfo
        let target = ReminderTarget(userInfo: info)
        let section = info["section"] as? String
        if action == ReminderScheduler.doneAction || action == ReminderScheduler.addAction {
            // Finish the write before returning, so iOS keeps the app awake until it's saved.
            if let target { await AppModel.shared.logFromReminder(target, event: response.notification.request.identifier) }
        } else if action == UNNotificationDefaultActionIdentifier, info[BackupCenter.notificationKey] != nil {
            // Straight to ≡ → iCloud & Backup, on Today's stack so Back is Today.
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
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
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
