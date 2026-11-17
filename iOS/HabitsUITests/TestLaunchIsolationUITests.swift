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

    /// ≡ › Appearance › Done Habits (a setting test launches reset, T8), read off the page.
    private func openDoneOrder() -> XCUIElement {
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 30))
        app.buttons["menu-button"].tap()
        app.menuRow("appearance").tap()
        let order = app.buttons["appearance-done-order"]
        XCTAssertTrue(order.waitForExistence(timeout: 5))
        return order
    }

    /// Today has no Filter since 17 Nov 2026, so the person's setting here is Appearance's Done Habits, which a test
    /// launch also resets; it was Hide Completed Habits, which lived in the Filter.
    func testATestLaunchLeavesThePersonsWidgetsAndSettings() {
        // The person: done habits kept in place, and their own habits on their widgets.
        app.launchArguments = []
        app.launch()
        let order = openDoneOrder()
        if !order.label.contains("Stay in Place") {
            order.tap()
            let choice = app.buttons["Stay in Place"].firstMatch
            XCTAssertTrue(choice.waitForExistence(timeout: 3))
            choice.tap()
        }
        XCTAssertTrue(order.label.contains("Stay in Place"), "The person chooses Stay in Place: " + order.label)
        Thread.sleep(forTimeInterval: 2) // the setting is saved; the launch's own widget publication has finished
        app.terminate()
        let before = report()
        XCTAssertTrue(before.contains("order inPlace"), "The person's setting is kept: " + before)
        XCTAssertFalse(before.hasPrefix("widgets 0 "), "The person's widgets show their habits: " + before)

        // A UI test's launch: its own demo habits and its own settings, done habits at the bottom as every test starts (T8).
        app.launchArguments = ["-uitest"]
        app.launch()
        XCTAssertTrue(openDoneOrder().label.contains("Move to Bottom"), "A test launch starts with the default order (T8)")
        app.navigationBars.buttons.element(boundBy: 0).tap()
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
