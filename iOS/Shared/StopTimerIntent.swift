import AppIntents

/// The Pause button on a running timer's Live Activity (Lock Screen and Dynamic Island). Users show they want to stop a
/// timer without opening the app, as the iPhone's own Clock timer allows (report "Timers — What People Expect When They
/// Tap ▶", 4 Oct 2026). It only stops a running timer and saves its time; it never starts one.
/// Implemented in BOTH app and extension: a LiveActivityIntent runs in the app's process, where the data is.
struct StopTimerIntent: LiveActivityIntent {
    static let title: LocalizedStringResource = "Pause Timer"
    static var isDiscoverable: Bool { false }
    @Parameter(title: "Habit") var habit: String
    init() {}
    init(habitID: String) { habit = habitID }

    @MainActor func perform() async throws -> some IntentResult {
        #if HABITS_APP
        if let id = UUID(uuidString: habit) { await AppModel.shared.stopTimerFromLiveActivity(id) }
        #endif
        return .result()
    }
}
