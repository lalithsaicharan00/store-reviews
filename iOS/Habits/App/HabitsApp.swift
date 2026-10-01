import SwiftUI

@main
struct HabitsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    private let model = AppModel.shared
    @Environment(\.scenePhase) private var scenePhase

    init() {
        Preferences.register()
    }

    var body: some Scene {
        WindowGroup {
            #if DEBUG
            if ["-placementcheck", "-schedulecheck", "-copycheck", "-focuscheck", "-progresscheck", "-settingscheck", "-backupcheck", "-taskcheck", "-remindercheck", "-undocheck"].contains(where: { ProcessInfo.processInfo.arguments.contains($0) }) {
                PlacementCheckView()
            } else {
                today
            }
            #else
            today
            #endif
        }
        .onChange(of: scenePhase) {
            // Re-plan on every return to the app: a new day, a changed time zone, or a changed permission.
            if scenePhase == .active && model.store.isLoaded { model.scheduler.scheduleReconcile(model.store) }
            // Taps are shown before they're written. Leaving the app, ask iOS for the time to finish every queued
            // write, so a tap made just before switching away is never lost (30 Sep).
            if scenePhase == .background { finishWrites() }
        }
    }

    private func finishWrites() {
        let save = BackgroundSave()
        save.id = UIApplication.shared.beginBackgroundTask(withName: "Save changes") { save.end() }
        Task {
            await model.store.flush()
            save.end()
        }
    }

    private var today: some View {
        MenuShell(menu: model.menu) { TodayView() }
            .environment(model.menu)
            .environment(model.store)
            .environment(model.scheduler)
            .environment(model.router)
            .tint(.ink)
            .onChange(of: model.store.problem) {
                if model.store.problem == nil && model.store.isStorageReady { model.scheduler.scheduleReconcile(model.store) }
            }
            .task {
                // The theme is set on the window itself, so it reaches sheets and alerts too (≡ → Appearance).
                Theme.apply(UserDefaults.standard.string(forKey: Preferences.theme) ?? Theme.automatic.rawValue)
                await model.ensureLoaded()
                guard model.store.isLoaded, model.store.isStorageReady else { return }
                #if DEBUG
                PerfDriver.startIfAsked(store: model.store)
                #endif
                model.scheduleRefresh()
                await model.dailySnapshot()
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
            if arguments.contains("-remindercheck") {
                let failures = await ReminderCheck.run()
                reminderMetric = ReminderCheck.planningSummary
                result = failures.isEmpty ? "Reminders: all checks passed" : "Reminders failed: " + failures.joined(separator: "; ")
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
