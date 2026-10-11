import Foundation

/// The Watch's store for Siri (H16): the iPhone's own App Intents (Log a Habit, What's Left Today, Get Habit Progress,
/// Open a Habit), compiled into the Watch app, run on the Watch's own copy of the data.
@MainActor
enum ShortcutHost {
    static func loadedStore() async -> HabitStore {
        await WatchModel.shared.ensureLoaded()
        return WatchModel.shared.store
    }

    /// After a log: the iPhone hears of it at once.
    static func logged(_ store: HabitStore) async {
        WatchModel.shared.link.sendNow()
    }

    /// Open a Habit: that habit's Day details, the Watch's page for it.
    static func open(_ habit: UUID) {
        WatchNavigation.shared.routine = nil
        WatchNavigation.shared.path = [.day(habit)]
    }
}
