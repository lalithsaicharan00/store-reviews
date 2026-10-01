import SwiftUI

@main
struct HabitsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    private let model = AppModel.shared
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            #if DEBUG
            if ["-placementcheck", "-schedulecheck", "-copycheck", "-focuscheck"].contains(where: { ProcessInfo.processInfo.arguments.contains($0) }) {
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
            // Pull on every return to the app (another device may have changed something), and stop polling when away.
            if scenePhase == .active && model.store.isLoaded { model.sync?.appBecameActive() }
            // Every open re-checks the backup, so a problem is told as soon as we know (§4.4).
            if scenePhase == .active && model.store.isLoaded { Task { await model.backup?.runIfDue() } }
            if scenePhase == .background { model.sync?.appWentToBackground() }
        }
    }

    @ViewBuilder private var today: some View {
        if let backup = model.backup {
            todayView
                .environment(backup)
                .modifier(IncomingBackupSheet(backup: backup))
                // A backup file opened from AirDrop, Files or Mail (Backup, Sync and Accounts §4.8).
                .onOpenURL { url in
                    guard url.isFileURL else { return }
                    Task { await backup.open(url) }
                }
        } else {
            todayView
        }
    }

    private var todayView: some View {
        TodayView()
            .environment(model.store)
            .environment(model.scheduler)
            .environment(model.router)
            .tint(.ink)
            .task {
                await model.ensureLoaded()
                guard model.store.isLoaded else { return }
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

#if DEBUG
/// Shows the placement checks' result for `PlacementUITests`.
private struct PlacementCheckView: View {
    @State private var result = "Running"
    var body: some View {
        Text(result).padding().task {
            let arguments = ProcessInfo.processInfo.arguments
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
