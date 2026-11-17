import SwiftUI

/// The first launch (Figma's onboarding page, 17 Nov 2026): no welcome pages. The launch screen, a moment while iCloud is
/// looked in (`FirstLook`), then Today, where an empty Today offers New Habit and Restore from a Backup (`EmptyToday`).
/// Nothing asks for a permission or a purchase, and there's no account to make.
enum Onboarding {
    /// Set once the first look at iCloud is over (or the person chose Not Now, or restored a file). Kept in UserDefaults:
    /// it's about this phone. Until then nothing is sent to iCloud or backed up (D14, `BackupCenter.backupAllowed`).
    static let doneKey = "onboarding.done"
    static let outcomeKey = "onboarding.outcome"

    /// The app's name as people see it in help and on the iCloud page.
    static let appName = "Often Enough"

    /// Today waits for iCloud's first look: on a fresh install from the very first frame (its habits may be on their
    /// way), and on any launch with no habits once iCloud is on (flow 5: iCloud turned on in the Settings app). Never
    /// over a storage problem (the error stays visible, C235), and never in UI or speed tests unless asked for with
    /// `-onboarding`.
    static func waitsForICloud(_ store: HabitStore) -> Bool {
        let arguments = ProcessInfo.processInfo.arguments
        if !arguments.contains("-onboarding") && (arguments.contains("-uitest") || arguments.contains("-dbname")) { return false }
        _ = testLaunchStartsFresh
        guard store.isLoaded else { return !UserDefaults.standard.bool(forKey: doneKey) }
        guard store.isStorageReady, store.problem == nil else { return false }
        return store.habits.isEmpty
    }

    /// A test launch with `-onboarding` is always a first launch (Rulebook T8): `onboarding.done` outlives a launch, so
    /// without this a test after one that finished the first look never sees No Internet Connection (flow 4).
    private static let testLaunchStartsFresh: Void = {
        let arguments = ProcessInfo.processInfo.arguments
        guard arguments.contains("-onboarding"), arguments.contains("-uitest") || arguments.contains("-dbname") else { return }
        UserDefaults.standard.removeObject(forKey: doneKey)
        UserDefaults.standard.removeObject(forKey: outcomeKey)
    }()

    static func markDone() {
        guard !UserDefaults.standard.bool(forKey: doneKey) else { return }
        UserDefaults.standard.set(true, forKey: doneKey)
        UserDefaults.standard.set("completed", forKey: outcomeKey)
    }
}
