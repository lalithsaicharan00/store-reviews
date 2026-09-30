import SwiftUI

@main
struct HabitsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    private let model = AppModel.shared
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            root
                // While locked, or whenever the app isn't in front (so the app switcher never shows the habits).
                .overlay {
                    if model.lock.isLocked || (AppLock.isEnabled && scenePhase != .active) {
                        LockCover(locked: model.lock.isLocked) { Task { await model.lock.unlock() } }
                    }
                }
                .task { await model.lock.appeared() }
        }
        .onChange(of: scenePhase) {
            // Leaving locks the app (when the lock is on); coming back asks once.
            if scenePhase == .background { model.lock.lock() }
            if scenePhase == .active { Task { await model.lock.appeared() } }
            // Re-plan on every return to the app: a new day, a changed time zone, or a changed permission.
            // Widget taps made while away come in first, then the widget and reminders are brought up to date.
            guard scenePhase == .active && model.store.isLoaded else { return }
            Task { @MainActor in
                await WidgetBridge.applyPendingTaps(model.store)
                WidgetBridge.publish(model.store)
                model.scheduler.scheduleReconcile(model.store)
            }
        }
    }

    @ViewBuilder private var root: some View {
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

    private var today: some View {
        TodayView()
            .environment(model.store)
            .environment(model.scheduler)
            .environment(model.router)
            .environment(\.checkFeedback, CheckFeedback(haptics: model.store.settings.haptics, sounds: model.store.settings.sounds))
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
