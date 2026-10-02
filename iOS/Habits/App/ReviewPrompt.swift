import Foundation

/// When the app may ask for a store review (report "Asking for a Review — When, How Often, Never How", 30 Sep; Feature
/// Ledger C094). Users show the prompts that cost stars: in the first minutes, during setup, on a check-off in the
/// middle of logging, over and over, forced before the app can be used, or traded for a reward.
///
/// So: only Apple's own request (it respects the person's "no" in iOS Settings and shows at most three times a year),
/// never a question of our own first, never a reward. Only after a week of real use, only at a natural pause — the tap
/// that finishes today — at most once per version and 120 days apart. (A Rate Habits row belongs in Help & Feedback
/// once the app has an App Store ID.) Ported from the 30 Sep feature branch on 1 Oct 2026.
enum ReviewPrompt {
    /// Days with something logged, and things logged, before the first ask.
    static let minimumDays = 7
    static let minimumLogs = 10
    static let spacing: TimeInterval = 120 * 86400

    private static let askedKey = "review.lastAsked"
    private static let versionKey = "review.lastVersion"

    private static var version: String {
        (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""
    }

    static func shouldAsk(_ store: HabitStore, now: Date = .now, defaults: UserDefaults = .standard) -> Bool {
        guard !ProcessInfo.processInfo.arguments.contains("-uitest"), store.problem == nil else { return false }
        if defaults.string(forKey: versionKey) == version { return false }
        if let last = defaults.object(forKey: askedKey) as? Date, now.timeIntervalSince(last) < spacing { return false }
        guard let first = store.habits.map(\.createdAt).min(), now.timeIntervalSince(first) >= 7 * 86400 else { return false }
        // Only at the moment a day is finished, so reading every entry here is once a day at most.
        return store.entries.count >= minimumLogs && Set(store.entries.map(\.day)).count >= minimumDays
    }

    static func markAsked(now: Date = .now, defaults: UserDefaults = .standard) {
        defaults.set(now, forKey: askedKey)
        defaults.set(version, forKey: versionKey)
        Analytics.shared.count(.reviewRequested, ticket: Analytics.shared.ticket)
    }

}
