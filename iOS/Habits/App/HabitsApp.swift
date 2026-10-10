import SwiftUI

@main
struct HabitsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    private let model = AppModel.shared
    @Environment(\.scenePhase) private var scenePhase
    /// The welcome, on a fresh install only (`Onboarding.shouldShow`).
    @State private var showOnboarding = false

    init() {
        Preferences.register()
        ArrangeTip.configure()
        KeyboardArrival.watch()
    }

    var body: some Scene {
        WindowGroup {
            root
                // Switches in the iPhone's own green: the app's ink tint is near-white in dark mode, where an "on"
                // switch couldn't be told from "off" (the user, on the iPhone, 2 Oct 2026). A Toggle inside a Menu
                // sets `.toggleStyle(.automatic)` so it stays a menu item with a check (ProgressScreen).
                .toggleStyle(.appSwitch)
                // While locked, or whenever the app isn't in front (so the app switcher never shows the habits): the
                // cover in its own window, over sheets and alerts too (`LockWindow`).
                .onChange(of: model.lock.isLocked || (AppLock.isEnabled && scenePhase != .active), initial: true) { _, covered in
                    LockWindow.show(covered, lock: model.lock)
                }
                .task {
                    #if DEBUG
                    FakeAuthWindow.install()
                    #endif
                    await model.lock.appeared()
                    Analytics.shared.lifecycle(active: scenePhase == .active, locked: model.lock.isLocked)
                    AnalyticsInteractionObserver.install()
                    WidgetAnalyticsAdapter.foreground()
                }
                .onChange(of: model.lock.isLocked) {
                    Analytics.shared.lifecycle(active: scenePhase == .active, locked: model.lock.isLocked)
                }
                .onOpenURL { url in
                    // A backup file opened from AirDrop, Files or Mail (Backup, Sync and Accounts §4.8).
                    if url.isFileURL, let backup = model.backup { Task { await backup.open(url) }; return }
                    guard url.scheme == "oftenenough" else { return }
                    Self.route(url, model: model)
                }
        }
        .onChange(of: scenePhase) {
            // LOCKED (widget taps, 8 Oct 2026): publish at once when the app starts to leave (W11). Read iOS/Docs/Widgets — Taps and Updates (Locked).md before changing; changes need the user's say-so.
            // Leaving: the widgets get the latest at once, while the app still counts as in front, so iOS redraws them
            // straight away rather than when it next gets round to it (the user, 8 Oct 2026, Current Work 66).
            if scenePhase == .inactive && model.store.isLoaded { Task { await model.widgets.publish(model.store, immediate: true) } }
            Analytics.shared.lifecycle(active: scenePhase == .active, locked: model.lock.isLocked)
            if scenePhase == .active {
                model.store.analyticsConfiguration()
                WidgetAnalyticsAdapter.foreground()
                AnalyticsInteractionObserver.install()
            }
            // Re-plan on every return to the app: a new day, a changed time zone, or a changed permission.
            if scenePhase == .active && model.store.isLoaded {
                // Any widget tap still waiting in the shared file (Current Work 66).
                Task { await model.saveWidgetTaps() }
                model.scheduler.scheduleReconcile(model.store)
                model.widgets.schedule(model.store)
                // Pull on every return to the app (another device may have changed something).
                model.sync?.appBecameActive()
                // Every open re-checks the backup, so a problem is told as soon as we know (§4.4).
                Task { await model.backup?.runIfDue() }
            }
            // Stop polling for other devices' changes while away.
            if scenePhase == .background { model.sync?.appWentToBackground() }
            // Taps are shown before they're written. Leaving the app, ask iOS for the time to finish every queued
            // write, so a tap made just before switching away is never lost (30 Sep).
            if scenePhase == .background { finishWrites() }
            // Backed up as you go (Current Work 75): leaving with something changed, 10 minutes after the last upload.
            if scenePhase == .background { model.backup?.appLeaving() }
            // Leaving locks the app (when the lock is on, after Ask Again's time); coming back asks once.
            if scenePhase == .background { model.lock.lock() }
            if scenePhase == .active { Task { await model.lock.appeared() } }
        }
    }

    /// The app's links, from widgets and the Live Activity (Implementation Spec §3): each opens exactly the screen its
    /// button names, so logging takes one tap after the app opens.
    ///   today · section/<id> · item/<id> (Day details) · log/<id> (amount entry) · slip/<id> (Record a slip)
    ///   timer/<id> (its screen; ?start=1 starts it first) · widgets (Help → Widgets → "Choose a habit for a widget")
    static func route(_ url: URL, model: AppModel) {
        let id = UUID(uuidString: url.lastPathComponent)
        let router = model.router
        switch url.host {
        case "today":
            Analytics.shared.count(.widgetOpen, ticket: Analytics.shared.ticket); router.widgetToday = true
        case "section":
            Analytics.shared.count(.widgetOpen, ticket: Analytics.shared.ticket)
            router.widgetToday = true
            router.focusSection = url.lastPathComponent
        case "item":
            guard let id else { return }
            Analytics.shared.count(.widgetOpen, ticket: Analytics.shared.ticket); router.widgetItem = id
        case "log", "slip":
            guard let id else { return }
            Analytics.shared.count(.widgetOpen, ticket: Analytics.shared.ticket)
            router.widgetSheet = WidgetSheet(kind: url.host == "log" ? .log : .slip, habit: id)
        case "timer":
            guard let id else { return }
            router.startTimer = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems?.contains { $0.name == "start" } == true
            router.timerHabit = id
        case "widgets":
            router.widgetSetup = true
        default: break
        }
    }

    @ViewBuilder private var root: some View {
            #if DEBUG
            if ["-analyticscheck", "-placementcheck", "-schedulecheck", "-copycheck", "-focuscheck", "-feedbackcheck", "-progresscheck", "-settingscheck", "-backupcheck", "-taskcheck", "-remindercheck", "-undocheck", "-arrangecheck", "-widgetcheck", "-widgetreliability", "-appreliability", "-applockcheck", "-widget-system-verify"].contains(where: { ProcessInfo.processInfo.arguments.contains($0) }) {
                PlacementCheckView()
            } else if ProcessInfo.processInfo.arguments.contains("-widget-render") {
                WidgetRenderCheck()
            } else if ProcessInfo.processInfo.arguments.contains("-testlaunch-report") {
                // TestLaunchIsolationUITests: what this ordinary launch found before it published anything.
                Text(TestLaunchIsolation.report).accessibilityIdentifier("testlaunch-report")
            } else {
                today
            }
            #else
            today
            #endif
    }

    private func finishWrites() {
        let save = BackgroundSave()
        save.id = UIApplication.shared.beginBackgroundTask(withName: "Save changes") { save.end() }
        Task {
            await model.store.flush()
            await model.widgets.publish(model.store, immediate: true)
            save.end()
        }
    }

    @ViewBuilder private var today: some View {
        if let backup = model.backup {
            todayView
                .environment(backup)
                .modifier(IncomingBackupSheet(backup: backup))
                .modifier(KeepYourAccount(backup: backup))
                .modifier(SignedOutElsewhere(backup: backup))
                #if DEBUG
                // Two simulators checked against each other: `-transfer-send` opens the old iPhone's code screen.
                // Only once the demo habits are saved (S7), so the file isn't made from an empty database.
                .sheet(isPresented: .constant(ProcessInfo.processInfo.arguments.contains("-transfer-send") && !model.store.habits.isEmpty)) {
                    NavigationStack { TransferSendView() }.environment(backup)
                }
                #endif
        } else {
            todayView
        }
    }

    private var todayView: some View {
        MenuShell(menu: model.menu) { TodayView() }
            .environment(model.menu)
            .environment(model.store)
            .environment(model.scheduler)
            .environment(model.router)
            .tint(.ink)
            .onChange(of: model.store.problem) {
                if model.store.problem == nil && model.store.isStorageReady { model.scheduler.scheduleReconcile(model.store) }
            }
            .fullScreenCover(isPresented: $showOnboarding) {
                // Every way back (sign in, restore, move from another device) finishes inside the welcome, so it
                // always ends on Today (Current Work 73.1).
                OnboardingView { showOnboarding = false }
                .environment(model.store)
                .environment(model.scheduler)
                .environment(model.menu)
                .environment(model.router)
                .modifier(OptionalBackup(backup: model.backup))
                .tint(.ink)
            }
            #if DEBUG
            // Speed runs (`PerfDriver` "onboarding", Rulebook T4): the welcome over Today, as on a fresh install.
            .onPerfCommand { action in if action == .openOnboarding { showOnboarding = true } }
            #endif
            .task {
                // The theme is set on the window itself, so it reaches sheets and alerts too (≡ → Appearance).
                Theme.apply(UserDefaults.standard.string(forKey: Preferences.theme) ?? Theme.automatic.rawValue)
                await model.ensureLoaded()
                guard model.store.isLoaded, model.store.isStorageReady else { return }
                if Onboarding.shouldShow(model.store) {
                    // Already there when the app opens, not sliding up over an empty Today.
                    var instant = Transaction()
                    instant.disablesAnimations = true
                    withTransaction(instant) { showOnboarding = true }
                }
                #if DEBUG
                PerfDriver.startIfAsked(store: model.store)
                #endif
                model.scheduleRefresh()
                await model.dailySnapshot()
            }
    }
}

/// The restore preview for a file opened from another app. Only this modifier reads `incoming`, so Today never
/// redraws for it.
private struct IncomingBackupSheet: ViewModifier {
    @Bindable var backup: BackupCenter

    func body(content: Content) -> some View {
        content.sheet(item: $backup.incoming) { pending in
            NavigationStack { RestorePreviewView(pending: pending) }
                .environment(backup)
        }
    }
}

/// After moving habits from a device that was signed in: "Sign in to keep your account", once, with Sign In (its own
/// sheet) or Not Now (Account and Backup Redesign §7 item 3; decided 10 Oct 2026). Plus syncs once signed in; a free
/// account backs this device up to it.
private struct KeepYourAccount: ViewModifier {
    @Bindable var backup: BackupCenter
    @State private var signingIn = false

    func body(content: Content) -> some View {
        content
            .alert("Sign in to keep your account", isPresented: Binding(get: { backup.suggestSignIn != nil }, set: { if !$0 { backup.suggestSignIn = nil } })) {
                Button("Sign In") { backup.suggestSignIn = nil; signingIn = true }
                Button("Not Now", role: .cancel) { backup.suggestSignIn = nil }
            } message: {
                Text(backup.suggestSignIn == .plus
                     ? "Your other device used an account with Plus. Sign in the same way here to keep your devices in sync."
                     : "Your other device used an account. Sign in the same way here to keep backing up to it.")
            }
            .sheet(isPresented: $signingIn) { SignInSheet(title: "Sign In").environment(backup) }
    }
}

/// "Signed out on this iPhone" (Account and Backup Redesign, screen 8; Current Work 78): once, after another device's
/// sign-in moved the free account there. An alert: it's unexpected and needs acknowledging. Also asks "Use on This
/// iPhone?" (screen 7) for a sign-in that has no sheet of its own to ask in (a test launch's).
private struct SignedOutElsewhere: ViewModifier {
    @Bindable var backup: BackupCenter

    func body(content: Content) -> some View {
        content
            .alert("Signed out on this \(UIDevice.current.model)",
                   isPresented: Binding(get: { backup.signedOutBy != nil && backup.askReplace == nil },
                                        set: { if !$0 { backup.acknowledgeSignedOutElsewhere() } })) {
                Button("OK") { backup.acknowledgeSignedOutElsewhere() }
            } message: {
                Text(backup.signedOutLine)
            }
            .sheet(item: $backup.askReplace) { ask in
                UseHereQuestion(otherDevice: ask.otherDevice) {
                    Task {
                        await ask.proceed()
                        backup.askReplace = nil
                    }
                } onCancel: {
                    backup.askReplace = nil
                }
                .presentationDetents([.height(300)])
                .presentationDragIndicator(.visible)
            }
    }
}

/// The backup centre for a screen shown over Today in its own presentation, when there is one (none without a database).
private struct OptionalBackup: ViewModifier {
    let backup: BackupCenter?
    func body(content: Content) -> some View {
        if let backup { content.environment(backup) } else { content }
    }
}

/// The background time asked for while queued writes finish; ended once, whichever comes first.
private final class BackgroundSave {
    var id = UIBackgroundTaskIdentifier.invalid
    func end() {
        guard id != .invalid else { return }
        UIApplication.shared.endBackgroundTask(id)
        id = .invalid
    }
}

#if DEBUG
/// Shows the placement checks' result for `PlacementUITests`.
private struct PlacementCheckView: View {
    @State private var result = "Running"
    @State private var reminderMetric = ""
    var body: some View {
        VStack {
            Text(result)
            if !reminderMetric.isEmpty { Text(reminderMetric).accessibilityIdentifier("reminder-planning-metric") }
        }.padding().task {
            let arguments = ProcessInfo.processInfo.arguments
            if arguments.contains("-analyticscheck") {
                let failures = await AnalyticsCheck.run()
                result = failures.isEmpty ? "Analytics: all checks passed" : "Analytics failed: " + failures.joined(separator: "; ")
                return
            }
            if arguments.contains("-widget-system-verify") {
                await AppModel.shared.ensureLoaded()
                let store = AppModel.shared.store
                if let habit = store.habits.first(where: { $0.name == "Widget cut down" }),
                   store.entries(of: habit.id).filter({ $0.source == .widget }).count == 1 {
                    result = "Widget system: persisted log"
                } else {
                    // Where a widget tap stopped (Current Work 66): still waiting in the shared file means the app never
                    // saved it; nothing there and no log means the widget's intent never ran.
                    result = "Widget system: no durable widget log · \(WidgetTaps.read().count) taps waiting in the shared file"
                }
                return
            }
            if arguments.contains("-applockcheck") {
                let failures = await AppLockCheck.run()
                result = failures.isEmpty ? "App lock: all checks passed" : "App lock failed (\(failures.count)): " + failures.joined(separator: "; ")
                return
            }
            if arguments.contains("-appreliability") {
                let failures = await AppReliabilityCheck.run()
                result = failures.isEmpty ? "App reliability: all checks passed" : "App reliability failed: " + failures.joined(separator: "; ")
                return
            }
            if arguments.contains("-widgetreliability") {
                let failures = await WidgetReliabilityCheck.run()
                result = failures.isEmpty ? "Widget reliability: all checks passed" : "Widget reliability failed: " + failures.joined(separator: "; ")
                return
            }
            if arguments.contains("-widgetcheck") {
                let failures = await WidgetCheck.run()
                result = failures.isEmpty ? "Widgets: all checks passed" : "Widgets failed: " + failures.joined(separator: "; ")
                return
            }
            if arguments.contains("-remindercheck") {
                let failures = await ReminderCheck.run()
                reminderMetric = ReminderCheck.planningSummary
                result = failures.isEmpty ? "Reminders: all checks passed" : "Reminders failed: " + failures.joined(separator: "; ")
                return
            }
            if arguments.contains("-arrangecheck") {
                let failures = await ArrangeCheck.run()
                result = failures.isEmpty ? "Arrange: all checks passed" : "Arrange failed (\(failures.count)): " + failures.joined(separator: "; ")
                return
            }
            if arguments.contains("-taskcheck") {
                let failures = await TaskCheck.run()
                result = failures.isEmpty ? "Tasks: all checks passed" : "Tasks failed: " + failures.joined(separator: "; ")
                return
            }
            if arguments.contains("-backupcheck") {
                let failures = await BackupCheck.run()
                result = failures.isEmpty ? "Backup: all checks passed" : "Backup failed: " + failures.joined(separator: "; ")
                return
            }
            if arguments.contains("-undocheck") {
                let failures = await UndoCheck.run()
                result = failures.isEmpty ? "Undo: all checks passed" : "Undo failed: " + failures.joined(separator: "; ")
                return
            }
            if arguments.contains("-feedbackcheck") {
                let failures = await FeedbackCheck.run()
                result = failures.isEmpty ? "Feedback: all checks passed" : "Feedback failed: " + failures.joined(separator: "; ")
                return
            }
            if arguments.contains("-focuscheck") {
                let failures = await FocusPlayerCheck.run()
                result = failures.isEmpty ? "Focus: all checks passed" : "Focus failed: " + failures.joined(separator: "; ")
                return
            }
            if arguments.contains("-progresscheck") {
                let failures = await ProgressCheck.run()
                result = failures.isEmpty ? "Progress: all checks passed" : "Progress failed (\(failures.count)): " + failures.prefix(20).joined(separator: "; ")
                return
            }
            if arguments.contains("-settingscheck") {
                let failures = await SettingsCheck.run()
                result = failures.isEmpty ? "Settings: all checks passed" : "Settings failed (\(failures.count)): " + failures.joined(separator: "; ")
                return
            }
            if arguments.contains("-copycheck") {
                // The copy checks name each wrong phrase, so a failure says exactly which words to fix.
                let failures = CopyCheck.run()
                result = failures.isEmpty ? "Copy: all checks passed" : "Copy failed (\(failures.count)): " + failures.prefix(20).joined(separator: "; ")
                return
            }
            let failures = arguments.contains("-schedulecheck") ? await ScheduleCheck.run() : await PlacementCheck.run()
            result = failures.isEmpty ? "Placement: all checks passed" : "Placement failed: " + failures.joined(separator: "; ")
        }
    }
}
#endif
