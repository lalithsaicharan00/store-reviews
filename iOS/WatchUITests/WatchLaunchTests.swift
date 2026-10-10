import XCTest

/// The Watch app opens to Today from its own database (WA1).
final class WatchLaunchTests: XCTestCase {
    func testOpensToToday() {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest", "-watch-fixture", "design", "-clock-hour", "10"]
        app.launch()
        XCTAssertTrue(app.staticTexts["Vitamins"].waitForExistence(timeout: 20), "Today shows the habits")
    }
}
