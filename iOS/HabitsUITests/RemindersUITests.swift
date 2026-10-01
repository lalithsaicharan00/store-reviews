import XCTest

final class RemindersUITests: XCTestCase {
    override func setUp() { continueAfterFailure = false }
    private func open(_ app: XCUIApplication) {
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 10))
        app.buttons["menu-button"].tap(); app.buttons["menu-reminders"].tap()
        XCTAssertTrue(app.navigationBars["Reminders"].waitForExistence(timeout: 5))
    }
    func testPlanningActionsPermissionsFailuresAndClockChanges() {
        let app = XCUIApplication(); app.launchArguments = ["-uitest", "-remindercheck", "-perf-reminders", "-perf-history"]
        app.launch()
        XCTAssertTrue(app.staticTexts["Reminders: all checks passed"].waitForExistence(timeout: 90), app.debugDescription)
        print("REMINDER-PLANNING " + app.staticTexts["reminder-planning-metric"].label)
    }
    func testSavedRemindersOpenEditableTaskWithoutPermissionPrompt() {
        let app = XCUIApplication(); app.launchArguments = ["-uitest", "-reminder-fixture", "-reminder-fake"]
        app.launch(); open(app)
        XCTAssertTrue(app.staticTexts["Task reminder"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons["reminders-allow"].exists)
        XCTAssertFalse(XCUIApplication(bundleIdentifier: "com.apple.springboard").alerts.firstMatch.exists)
        app.revealAndTap(app.buttons.matching(NSPredicate(format: "label CONTAINS %@", "Task reminder")).firstMatch)
        XCTAssertTrue(app.navigationBars["Edit Task"].waitForExistence(timeout: 5))
        XCTAssertFalse(app.buttons["add-habit"].isEnabled)
        app.buttons["Cancel"].firstMatch.tap()
        XCTAssertTrue(app.navigationBars["Reminders"].waitForExistence(timeout: 5))
        let shot = XCTAttachment(screenshot: app.screenshot()); shot.name = "reminders-saved-and-permissions"; shot.lifetime = .keepAlways; add(shot)
    }
    func testRealEmptyPageHasNoUnexpectedAlarmErrorOrPermissionPrompt() {
        let app = XCUIApplication(); app.launchArguments = ["-uitest", "-empty"]
        app.launch(); open(app)
        XCTAssertTrue(app.staticTexts["No reminders yet"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.progressIndicators.firstMatch.waitForNonExistence(timeout: 15))
        XCTAssertFalse(app.staticTexts["Alarms couldn’t be checked. Open Reminders and try scheduling again."].exists)
        XCTAssertFalse(XCUIApplication(bundleIdentifier: "com.apple.springboard").alerts.firstMatch.exists)
        let shot = XCTAttachment(screenshot: app.screenshot()); shot.name = "reminders-real-empty-permissions"; shot.lifetime = .keepAlways; add(shot)
    }
    func testDeniedPermissionOffersSettingsAndEmptyState() {
        let app = XCUIApplication(); app.launchArguments = ["-uitest", "-empty", "-reminder-denied"]
        app.launch(); open(app)
        let permission = app.staticTexts["reminders-permission"]
        let denied = XCTNSPredicateExpectation(predicate: NSPredicate(format: "label CONTAINS %@", "Off in iPhone Settings"), object: permission)
        XCTAssertEqual(XCTWaiter.wait(for: [denied], timeout: 5), .completed, app.debugDescription)
        XCTAssertTrue(app.buttons["Open iPhone Settings"].firstMatch.exists)
        XCTAssertFalse(app.buttons["reminders-allow"].exists)
        XCTAssertTrue(app.staticTexts["No reminders yet"].exists)
        XCTAssertFalse(XCUIApplication(bundleIdentifier: "com.apple.springboard").alerts.firstMatch.exists)
    }
}
