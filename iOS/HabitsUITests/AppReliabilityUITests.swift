import XCTest

/// The app under stress (the user, 6 Oct 2026: "check app as well"): bursts of taps, retried and out-of-order
/// notification callbacks, ✓ and ▶/⏸ storms, save and backup storms, midnight and the day start, daylight saving,
/// time-zone travel and a year of history (`AppReliabilityCheck`).
final class AppReliabilityUITests: XCTestCase {
    override func setUp() { continueAfterFailure = false }

    func testBurstsRetriesStormsMidnightTravelAndAYear() {
        let app = XCUIApplication(); app.launchArguments = ["-uitest", "-appreliability"]
        app.launch()
        let passed = app.staticTexts["App reliability: all checks passed"]
        if !passed.waitForExistence(timeout: 300) {
            let failed = app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH %@", "App reliability failed")).firstMatch
            XCTFail(failed.exists ? failed.label : "App reliability did not finish")
        }
    }
}
