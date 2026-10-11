import Foundation

// The Apple Watch compiles the iPhone's own model files (Habits/Model, listed in the project as shared with this target),
// so "today", goals, streaks and words are the same code on both (Architecture 12 §5). Those files name a few iPhone
// things that don't exist on the Watch; these are their Watch versions, with the same names, so the shared files compile
// unchanged. Each says what it stands for and why the Watch's version is enough.

// MARK: - Analytics

/// The Watch records and sends no analytics (D16: nothing about the person's habits leaves their devices from the Watch,
/// and there is no consent screen on the Watch). The iPhone's calls become nothing here.
nonisolated struct AnalyticsTicket: Sendable {}

nonisolated final class Analytics: @unchecked Sendable {
    static let shared = Analytics()
    var ticket: AnalyticsTicket? { nil }
    var consented: Bool { false }
    func created(_ type: AnalyticsHabitType, suggestion: Bool = false, ticket: AnalyticsTicket?) {}
    func tracking(_ type: AnalyticsHabitType, origin: AnalyticsOrigin, ticket: AnalyticsTicket?) {}
    func count(_ counter: AnalyticsCounter, ticket: AnalyticsTicket?) {}
    func reliability(_ subsystem: String, succeeded: Bool, ticket: AnalyticsTicket?) {}
}

extension Habit {
    var analyticsType: AnalyticsHabitType { .notApplicable }
}

extension HabitStore {
    func analyticsTracked(_ entry: Entry, ticket: AnalyticsTicket?) {}
}

// MARK: - Timers and the routine player

/// On the iPhone this runs the timer's Live Activity; a watchOS app can't start one (Running a Routine §4). The store reads
/// only whether the routine player is open (no after-tap Undo line there), which the Watch's player sets.
enum TimerPresence {
    static var playerOpen = false
}

// MARK: - Widgets

/// The iPhone's widget errors (Shared/WidgetIntents.swift), which the shared store throws from its widget taps.
nonisolated enum WidgetActionError: Error {
    case openApp, stale, save
}

/// The iPhone's widget calendar colours. The Watch's complications draw no calendar, so a Watch item carries none.
enum HeatPalette {
    static func widgetSteps(_ habit: HabitColor) -> [Int] { [] }
}

// MARK: - Settings that follow the iPhone

/// The iPhone's Appearance → Done Habits, copied to the Watch by `WatchLink` (Design Notes: "follows the iPhone by
/// itself"). Default: done habits sink, as on the iPhone.
enum Preferences {
    static let doneOrder = "today.doneOrder"
    /// The iPhone's "Open Timer Full Screen". The Watch has no separate timer screen: a complication's ▶ starts the
    /// timer and opens its Day details, so this stays off here.
    static let timerScreen = "timers.openScreen"
}

enum DoneOrder: String {
    case bottom, inPlace
}

/// Hide Names Outside the App, copied from the iPhone by `WatchLink` (App Lock on counts as on, as there). Complications
/// and notifications then show counts and the person's own words, never a name (D4, E5).
nonisolated enum HideNames {
    /// A test launch keeps its own (D8), as on the iPhone.
    static var key: String { ProcessInfo.processInfo.arguments.contains("-uitest") ? "uitest.privacy.hideNames" : "privacy.hideNames" }
    static var isOn: Bool { UserDefaults.standard.bool(forKey: key) }
}

// MARK: - Words from iPhone screens

/// The iPhone's screens own these short words; the shared model asks them by the screen's name. Each forwards to the
/// one shared function the iPhone's screen forwards to too (Model/Words.swift).
enum PauseSheet {
    static func short(_ day: LocalDay, calendar: Calendar) -> String { DayWords.short(day, calendar: calendar) }
}

enum HabitPageView {
    static func pausedText(_ pause: HabitPause, store: HabitStore) -> String { DayWords.paused(pause, calendar: store.calendar) }
}

enum ProgressQuitRowView {
    static func short(_ t: TimeInterval) -> String { RunWords.short(t) }
}
