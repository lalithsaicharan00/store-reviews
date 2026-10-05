import XCTest

/// The completion sound and haptic (Current Work 18, 5 Oct 2026): `FeedbackCheck` logs every kind of habit on an
/// in-memory store and records what each log would play. A sound can't be heard by a test; the rule behind it can.
final class CompletionFeedbackUITests: XCTestCase {
    func testCompletionPlaysOnceWhenAHabitBecomesCompleteAndNeverForQuitOrLimits() {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest", "-feedbackcheck"]
        app.launch()
        let result = app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH 'Feedback'")).firstMatch
        XCTAssertTrue(result.waitForExistence(timeout: 20))
        XCTAssertEqual(result.label, "Feedback: all checks passed")
    }
}
