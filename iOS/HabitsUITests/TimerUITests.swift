import XCTest

/// A timed habit's ▶ (research: "Timing a Habit — Start, See and Stop", 28 Sep). It starts in place,
/// the row shows a live clock, a timer bar keeps it in sight when the row isn't, and stopping keeps
/// the time. Uses the demo habit Read (20 min a day, in Anytime).
final class TimerUITests: XCTestCase {
    override func record(_ issue: XCTIssue) {
        let shot = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        shot.name = "FAIL-\(name)"
        shot.lifetime = .keepAlways
        var issue = issue
        issue.add(shot)
        super.record(issue)
    }

    private var app: XCUIApplication!

    private func launch(_ arguments: [String] = []) {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-uitest"] + arguments
        app.launch()
    }

    private func shot(_ name: String) {
        let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    /// Read's second line while it runs: "0:03/20 min".
    private var clock: XCUIElement {
        app.staticTexts.matching(NSPredicate(format: "label MATCHES '^[0-9]+:[0-9]{2}/20 min.*'")).firstMatch
    }

    /// The system asks once for notifications when the first timer starts (for the goal alert).
    private func allowNotificationsIfAsked() {
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        let allow = springboard.alerts.buttons["Allow"]
        if allow.waitForExistence(timeout: 3) { allow.tap() }
    }

    func testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime() {
        launch()
        let start = app.buttons["Start Read timer"]
        XCTAssertTrue(start.waitForExistence(timeout: 5))
        start.tap()
        XCTAssertTrue(app.buttons["Stop Read timer"].waitForExistence(timeout: 3), "▶ becomes ⏸")
        XCTAssertTrue(clock.waitForExistence(timeout: 3), "The row shows a live clock, not just the button")
        sleep(2)
        let first = clock.label
        sleep(2)
        XCTAssertNotEqual(clock.label, first, "The clock ticks every second")
        XCTAssertFalse(app.descendants(matching: .any)["timer-bar"].exists, "No bar while the row itself is on screen")
        shot("t01-row-clock")

        // Folded away, the timer stays in sight at the bottom.
        app.buttons["Fold Anytime"].tap()
        let bar = app.descendants(matching: .any)["timer-bar"]
        XCTAssertTrue(bar.waitForExistence(timeout: 3), "A timer out of sight gets the bar")
        XCTAssertTrue(bar.label.hasPrefix("Read timer, "), bar.label)
        shot("t02-bar-when-folded")

        // Tapping the bar brings the row back, and the bar goes.
        bar.tap()
        XCTAssertTrue(app.buttons["Stop Read timer"].waitForExistence(timeout: 3), "The bar opens the section")
        XCTAssertFalse(bar.waitForExistence(timeout: 2), "No bar once the row is back")

        // Stopping from the bar keeps the time and ends the timer.
        app.buttons["Fold Anytime"].tap()
        XCTAssertTrue(bar.waitForExistence(timeout: 3))
        app.descendants(matching: .any)["timer-bar-stop"].tap()
        XCTAssertFalse(bar.waitForExistence(timeout: 2), "Stopped: the bar goes")
        app.buttons["Open Anytime"].tap()
        XCTAssertTrue(app.buttons["Start Read timer"].waitForExistence(timeout: 3), "⏸ becomes ▶ again")
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label MATCHES '^[0-9]+ min/20 min.*'")).firstMatch.exists,
                      "Stopped, the row goes back to minutes")
        shot("t03-stopped")
    }

    /// Outside the app: the Live Activity shows in the Dynamic Island while it runs, and goes when it stops.
    func testLiveActivityWhileRunning() {
        launch(["-timer-presence"])
        let start = app.buttons["Start Read timer"]
        XCTAssertTrue(start.waitForExistence(timeout: 5))
        start.tap()
        allowNotificationsIfAsked()
        XCTAssertTrue(app.buttons["Stop Read timer"].waitForExistence(timeout: 3))
        XCUIDevice.shared.press(.home)
        sleep(3)
        shot("t04-home-screen-island")
        app.activate()
        XCTAssertTrue(app.buttons["Stop Read timer"].waitForExistence(timeout: 5), "Still running after leaving the app")
        app.buttons["Stop Read timer"].tap()
        XCTAssertTrue(app.buttons["Start Read timer"].waitForExistence(timeout: 3))
        XCUIDevice.shared.press(.home)
        sleep(3)
        shot("t05-home-screen-after-stop")
        app.activate()
    }
}
