import XCTest

final class AnalyticsUITests: XCTestCase {
    func testDurableContentFreeTracking() {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest", "-analyticscheck"]
        app.launch()
        XCTAssertTrue(app.staticTexts["Analytics: all checks passed"].waitForExistence(timeout: 30))
    }
    func testFailedPersistenceNeverCounts() {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest", "-analyticscheck", "-fail-entry-writes"]
        app.launch()
        XCTAssertTrue(app.staticTexts["Analytics: all checks passed"].waitForExistence(timeout: 30))
    }
    func testUsageConsentIsOptionalAndSeparate() {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest", "-empty"]
        app.launch()
        app.buttons["menu-button"].tap()
        app.buttons["Privacy"].tap()
        let usage = app.switches["privacy-usage"]
        XCTAssertTrue(usage.waitForExistence(timeout: 5))
        XCTAssertEqual(usage.value as? String, "0")
        XCTAssertFalse(app.switches["privacy-crashes"].isEnabled)
    }
}
