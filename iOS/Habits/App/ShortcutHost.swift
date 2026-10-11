import Foundation

/// The iPhone app's store for Siri and Shortcuts (`HabitIntents`, shared with the Apple Watch, which has its own host).
@MainActor
enum ShortcutHost {
    static func loadedStore() async -> HabitStore {
        await AppModel.shared.ensureLoaded()
        return AppModel.shared.store
    }

    /// After a log: the row's reminders stop straight away, in case iOS suspends the app.
    static func logged(_ store: HabitStore) async {
        await AppModel.shared.scheduler.reconcile(store)
    }

    static func open(_ habit: UUID) {
        AppModel.shared.router.openHabit = habit
    }
}
