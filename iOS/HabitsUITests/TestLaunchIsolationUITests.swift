import XCTest

/// A test launch never touches the person's data (Rulebook D8; Current Work 74, 8 Oct 2026). On a real iPhone a `-uitest`
/// launch used to publish its demo habits into the widgets' shared file (the person's Home Screen showed them) and reset
/// some of the person's own settings (Hide Completed, done order). Here "the person" is an ordinary launch with no test
/// arguments; `-testlaunch-report` is an ordinary launch that reports, before it publishes anything, which habits the
/// person's widget file holds (their IDs, which a test launch's demo habits never share) and two of the settings.
final class TestLaunchIsolationUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
    }

    private func report() -> String {
        app.launchArguments = ["-testlaunch-report"]
        app.launch()
        let label = app.staticTexts["testlaunch-report"]
        XCTAssertTrue(label.waitForExistence(timeout: 20), "The report shows")
        let text = label.label
        app.terminate()
        return text
    }

    private func hideSwitch() -> XCUIElement {
        app.buttons["filter-button"].tap()
        XCTAssertTrue(app.navigationBars["Filter"].waitForExistence(timeout: 5))
        let hide = app.switches["hide-done-habits"]
        XCTAssertTrue(hide.waitForExistence(timeout: 3))
        return hide
    }

    func testATestLaunchLeavesThePersonsWidgetsAndSettings() {
        // The person: Hide Completed Habits on, and their own habits on their widgets.
        app.launchArguments = []
        app.launch()
        XCTAssertTrue(app.buttons["filter-button"].waitForExistence(timeout: 30), "Today, as the person has it")
        let hide = hideSwitch()
        if (hide.value as? String) != "1" { hide.coordinate(withNormalizedOffset: CGVector(dx: 0.9, dy: 0.5)).tap() }
        XCTAssertEqual(hide.value as? String, "1", "The person turns Hide Completed Habits on")
        app.navigationBars["Filter"].buttons["Done"].tap()
        Thread.sleep(forTimeInterval: 2) // the setting is saved; the launch's own widget publication has finished
        app.terminate()
        let before = report()
        XCTAssertTrue(before.contains("hide true"), "The person's setting is kept: " + before)
        XCTAssertFalse(before.hasPrefix("widgets 0 "), "The person's widgets show their habits: " + before)

        // A UI test's launch: its own demo habits and its own settings, Hide Completed off as every test starts (T8).
        app.launchArguments = ["-uitest"]
        app.launch()
        XCTAssertTrue(app.buttons["filter-button"].waitForExistence(timeout: 20))
        XCTAssertEqual(hideSwitch().value as? String, "0", "A test launch starts with Hide Completed off (T8)")
        app.navigationBars["Filter"].buttons["Done"].tap()
        // Something logged, so the test launch publishes its widgets again (0.5 s after a change).
        let add = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Add ' AND label ENDSWITH ' to Water'")).firstMatch
        if add.waitForExistence(timeout: 5) { add.tap() }
        Thread.sleep(forTimeInterval: 2)
        app.terminate()

        // The person's next launch finds everything as they left it.
        let after = report()
        XCTAssertEqual(after, before, "The person's widgets and settings are untouched by a test launch")
    }
}
