import Foundation

/// Speed runs on the Watch (S2): the app drives itself, launched with `-perf-drive <scenario>`, and records its own
/// main-thread stalls (`MainThreadMeter`, `-perf-meter`). Never measured through XCUITest.
@MainActor
enum WatchPerf {
    static func startIfAsked(model: WatchModel, navigation: WatchNavigation) {}
}
