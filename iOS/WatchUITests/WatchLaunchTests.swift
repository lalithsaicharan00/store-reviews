import XCTest

/// The Watch app opens to Today from its own database (WA1).
final class WatchLaunchTests: XCTestCase {
    func testOpensToToday() {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest", "-watch-fixture", "design", "-clock-hour", "10"]
        app.launch()
        // The first section in the iPhone's default order is Quitting; the day bar counts the rest.
        XCTAssertTrue(app.staticTexts["No smoking"].waitForExistence(timeout: 20), "Today shows the habits")
        XCTAssertTrue(app.staticTexts["1 of 7 done"].exists, "Today's day bar")
    }
}
