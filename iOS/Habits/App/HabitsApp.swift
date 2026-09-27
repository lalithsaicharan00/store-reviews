import Core
import SwiftUI

@main
struct HabitsApp: App {
    @State private var store: HabitStore
    @State private var scheduler = ReminderScheduler()
    private let persistence: Persistence?
    @Environment(\.scenePhase) private var scenePhase

    init() {
        let arguments = ProcessInfo.processInfo.arguments
        var opened: Persistence?
        if arguments.contains("-uitest") {
            opened = Persistence.inMemory()
        } else if let i = arguments.firstIndex(of: "-dbname"), i + 1 < arguments.count {
            opened = try? Persistence.onDisk(name: arguments[i + 1], reset: arguments.contains("-reset-db"))
        } else {
            opened = try? Persistence.onDisk()
        }
        persistence = opened
        let store = HabitStore(repository: (opened ?? Persistence.inMemory()).repository)
        if opened == nil {
            store.problem = "Your habits couldn't be opened. Nothing has been changed; please restart the app."
        }
        #if DEBUG
        // Debug builds behave like Plus, so the design's 14 habits fit. Launch with -free to test the free limit.
        store.isPlus = !arguments.contains("-free")
        #endif
        _store = State(initialValue: store)
    }

    var body: some Scene {
        WindowGroup {
            TodayView()
                .environment(store)
                .environment(scheduler)
                .tint(.ink)
                .task {
                    await store.load()
                    guard store.isLoaded else { return }
                    persistence?.markSchemaCurrent()
                    #if DEBUG
                    if !ProcessInfo.processInfo.arguments.contains("-empty") { await store.seedDemo() }
                    #endif
                    store.onChange = { [store, scheduler] in scheduler.scheduleReconcile(store) }
                    scheduler.scheduleReconcile(store)
                    await persistence?.dailySnapshotIfNeeded()
                }
        }
        .onChange(of: scenePhase) {
            // Re-plan on every return to the app: a new day, a changed time zone, or a changed permission.
            if scenePhase == .active && store.isLoaded { scheduler.scheduleReconcile(store) }
        }
    }
}
