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
