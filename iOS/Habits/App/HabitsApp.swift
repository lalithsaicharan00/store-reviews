import SwiftUI

@main
struct HabitsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    private let model = AppModel.shared
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            #if DEBUG
            if ["-placementcheck", "-schedulecheck", "-copycheck", "-focuscheck", "-backupcheck", "-taskcheck", "-remindercheck"].contains(where: { ProcessInfo.processInfo.arguments.contains($0) }) {
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
                await model.ensureLoaded()
                guard model.store.isLoaded, model.store.isStorageReady else { return }
                model.scheduleRefresh()
                await model.dailySnapshot()
            }
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
            if arguments.contains("-focuscheck") {
                let failures = await FocusPlayerCheck.run()
                result = failures.isEmpty ? "Focus: all checks passed" : "Focus failed: " + failures.joined(separator: "; ")
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
