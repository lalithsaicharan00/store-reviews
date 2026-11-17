import XCTest

final class AnalyticsUITests: XCTestCase {
    func testDurableContentFreeTracking() {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest", "-analyticscheck"]
        app.launch()
        XCTAssertTrue(app.staticTexts["Analytics: all checks passed"].waitForExistence(timeout: 30), app.debugDescription)
    }
    func testFailedPersistenceNeverCounts() {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest", "-analyticscheck", "-fail-entry-writes"]
        app.launch()
        XCTAssertTrue(app.staticTexts["Analytics: all checks passed"].waitForExistence(timeout: 30), app.debugDescription)
    }
    /// The first launch asks nothing (no welcome since 17 Nov 2026): usage sharing stays off until the person turns it on.
    func testFirstLaunchAsksNothing() {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest", "-empty", "-onboarding", "-test-cloud", "synced"]
        app.launch()
        XCTAssertTrue(app.staticTexts["No Habits Yet"].waitForExistence(timeout: 15))
        XCTAssertEqual(app.alerts.count, 0, "No question on the first launch")
        XCTAssertFalse(app.switches["privacy-usage"].exists)
    }
    func testUsageConsentIsOptionalAndSeparate() {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest", "-empty"]
        app.launch()
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 10))
        app.buttons["menu-button"].tap()
        XCTAssertTrue(app.menuRow("privacy").waitForExistence(timeout: 5))
        app.menuRow("privacy").tap()
        let usage = app.switches["privacy-usage"]
        XCTAssertTrue(usage.waitForExistence(timeout: 5))
        XCTAssertEqual(usage.value as? String, "0")
        XCTAssertFalse(app.switches["privacy-crashes"].isEnabled)
    }
}
