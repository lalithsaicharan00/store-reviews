import SwiftUI
import UserNotifications
import WatchKit

/// The Apple Watch app (Current Work 82): a single-target watchOS app, embedded in the iPhone app.
@main
struct OftenEnoughWatchApp: App {
    @WKApplicationDelegateAdaptor(WatchDelegate.self) private var delegate
    private let model = WatchModel.shared
    @State private var navigation = WatchNavigation.shared
    @Environment(\.scenePhase) private var phase

    var body: some Scene {
        WindowGroup {
            WatchRoot()
                .environment(model)
                .environment(model.store)
                .environment(model.plus)
                .environment(navigation)
                .task {
                    #if DEBUG
                    MainThreadMeter.startIfAsked()
                    #endif
                    let started = Date.now
                    await model.ensureLoaded()
                    LaunchLog.took("watch: Today usable", since: started)
                    WatchPerf.startIfAsked(model: model, navigation: navigation)
                }
                .onOpenURL { navigation.open($0, model: model) }
                .onChange(of: phase) { _, now in
                    if now == .background {
                        // Leaving: the face and the iPhone get the latest at once (S16).
                        Task { await model.widgets.publish(model.store, immediate: true) }
                        model.link.sendNow()
                    }
                }
        }
    }
}

/// The screen the app opens to: Today for Plus (WA1), the Plus screen otherwise (G1).
struct WatchRoot: View {
    @Environment(PlusState.self) private var plus
    @Environment(WatchModel.self) private var model

    var body: some View {
        switch plus.access {
        case .plus: TodayScreen()
        case .checking: TodayScreen() // never wait on the App Store to show Today (WA1); a Watch without Plus switches to G1
        case .none: PlusScreen()
        }
    }
}

/// Where Today's stack is, and the routine that covers it.
@Observable
final class WatchNavigation {
    static let shared = WatchNavigation()
    var path: [WatchRoute] = []
    var routine: RoutineSession?

    /// `oftenenough://watch/habit/<id>` (a complication, a notification) and `…/routine/<id>` (the iPhone's timer in the
    /// Smart Stack, R8; a complication while a routine runs, E3).
    func open(_ url: URL, model: WatchModel) {
        guard url.scheme == "oftenenough" else { return }
        let parts = url.pathComponents.filter { $0 != "/" }
        Task { @MainActor in
            await model.ensureLoaded()
            let store = model.store
            switch (url.host, parts.first, parts.dropFirst().first.flatMap(UUID.init(uuidString:))) {
            case ("watch", "habit", let id?):
                routine = nil
                path = [.day(id)]
            case ("watch", "routine", let id?):
                guard let habit = store.habits.first(where: { $0.id == id }) else { return }
                let day = store.today()
                let section = store.placements(of: habit).first?.section ?? .anytime
                let plan = TodayPlan.make(store)
                let rows = plan.sections.first { $0.id == section }?.rows.map(\.habit) ?? [habit]
                path = []
                routine = RoutineSession(part: section, title: store.section(section).name, day: day, habits: rows, startAt: id)
            default:
                path = []
            }
        }
    }
}

/// Notifications and background tasks reach the app here, before any screen (D13: never a crash behind them).
final class WatchDelegate: NSObject, WKApplicationDelegate {
    private let notifications = WatchNotifications()

    func applicationDidFinishLaunching() {
        UNUserNotificationCenter.current().delegate = notifications
        WatchNotifications.registerCategories()
        WKApplication.shared().registerForRemoteNotifications()
    }

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        for task in backgroundTasks {
            switch task {
            case let connectivity as WKWatchConnectivityRefreshBackgroundTask:
                // Batches from the iPhone wake the app: keep it until they're merged.
                WatchModel.shared.link.hold(connectivity)
            case let refresh as WKApplicationRefreshBackgroundTask:
                Task { @MainActor in
                    await WatchModel.shared.ensureLoaded()
                    await WatchModel.shared.widgets.publish(WatchModel.shared.store)
                    refresh.setTaskCompletedWithSnapshot(false)
                }
            default:
                task.setTaskCompletedWithSnapshot(false)
            }
        }
    }
}
