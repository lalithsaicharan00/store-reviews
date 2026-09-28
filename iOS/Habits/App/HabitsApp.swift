import SwiftUI

@main
struct HabitsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    private let model = AppModel.shared
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            #if DEBUG
            if ProcessInfo.processInfo.arguments.contains("-placementcheck") {
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

#if DEBUG
/// Shows the placement checks' result for `PlacementUITests`.
private struct PlacementCheckView: View {
    @State private var result = "Running"
    var body: some View {
        Text(result).padding().task {
            let failures = await PlacementCheck.run()
            result = failures.isEmpty ? "Placement: all checks passed" : "Placement failed: " + failures.joined(separator: "; ")
        }
    }
}
#endif
