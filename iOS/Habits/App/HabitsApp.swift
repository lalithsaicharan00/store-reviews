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
    }

    var body: some Scene {
        WindowGroup {
            root
                // Switches in the iPhone's own green: the app's ink tint is near-white in dark mode, where an "on"
                // switch couldn't be told from "off" (the user, on the iPhone, 2 Oct 2026). A Toggle inside a Menu
                // sets `.toggleStyle(.automatic)` so it stays a menu item with a check (ProgressScreen).
                .toggleStyle(.appSwitch)
                // While locked, or whenever the app isn't in front (so the app switcher never shows the habits).
                .overlay {
                    if model.lock.isLocked || (AppLock.isEnabled && scenePhase != .active) {
                        LockCover(locked: model.lock.isLocked) { Task { await model.lock.unlock() } }
                    }
                }
                .task {
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
            // Leaving locks the app (when the lock is on); coming back asks once.
            if scenePhase == .background { model.lock.lock() }
            if scenePhase == .active { Task { await model.lock.appeared() } }
        }
    }

    /// The app's links, from widgets and the Live Activity (Implementation Spec §3): each opens exactly the screen its
    /// button names, so logging takes one tap after the app opens.
    ///   today · section/<id> · item/<id> (Day details) · log/<id> (amount entry) · slip/<id> (Record a slip)
    ///   timer/<id> (its screen; ?start=1 starts it first) · widgets (the Widgets guide: how to choose a habit)
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
            if ["-analyticscheck", "-placementcheck", "-schedulecheck", "-copycheck", "-focuscheck", "-feedbackcheck", "-progresscheck", "-settingscheck", "-backupcheck", "-taskcheck", "-remindercheck", "-undocheck", "-arrangecheck", "-widgetcheck", "-widgetreliability", "-appreliability", "-widget-system-verify"].contains(where: { ProcessInfo.processInfo.arguments.contains($0) }) {
                PlacementCheckView()
            } else if ProcessInfo.processInfo.arguments.contains("-widget-render") {
                WidgetRenderCheck()
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
                OnboardingView { restore in
                    showOnboarding = false
                    // Coming back from another phone: straight to the restore, on Today's stack so Back is Today.
                    if restore { model.menu.path.append(MenuPlace.backup) }
                }
                .environment(model.store)
                .environment(model.scheduler)
                .environment(model.menu)
                .environment(model.router)
                .tint(.ink)
            }
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
                } else { result = "Widget system: no durable widget log · " + WidgetDisk.diagnostic }
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
