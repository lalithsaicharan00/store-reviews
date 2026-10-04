import XCTest

/// A timed habit's ▶ (research: "Timing a Habit — Start, See and Stop", 28 Sep; "Timers — What People Expect When They
/// Tap ▶", 4 Oct). It starts at once and opens the timer full screen, which closes without stopping; the row shows a
/// live clock, a timer bar keeps it in sight when the row isn't and opens the timer, and stopping keeps the time. Uses
/// the demo habit Read (20 min a day, in Anytime).
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

    /// The timer screen's clock: "0:03 / 20 min" (the circle's value, as the routine player shows it).
    private var screenClock: XCUIElement { app.buttons["focus-clock"] }

    /// ▶ starts the timer and opens it full screen (4 Oct 2026, report "Timers — What People Expect When They Tap ▶");
    /// closing it never stops it: the row keeps ticking and ⏸ is there.
    func testPlayOpensTimerScreenThatClosesWithoutStopping() {
        launch()
        let start = app.buttons["Start Read timer"]
        XCTAssertTrue(start.waitForExistence(timeout: 5))
        start.tap()
        XCTAssertTrue(app.staticTexts["timer-screen-name"].waitForExistence(timeout: 3), "▶ opens the timer full screen")
        XCTAssertEqual(app.staticTexts["timer-screen-name"].label, "Read")
        XCTAssertTrue(screenClock.waitForExistence(timeout: 3))
        sleep(2)
        let first = screenClock.label
        sleep(2)
        XCTAssertNotEqual(screenClock.label, first, "Its clock ticks")
        XCTAssertEqual(app.buttons["timer-screen-primary"].label, "Stop Read timer", "Pause is the main button")
        XCTAssertTrue(app.buttons["timer-screen-log"].exists, "Log Time Manually is one tap away")
        shot("t00-timer-screen")
        app.buttons["timer-screen-close"].tap()
        XCTAssertTrue(app.staticTexts["timer-screen-name"].waitForNonExistence(timeout: 3), "⌄ puts it away")
        XCTAssertTrue(app.buttons["Stop Read timer"].waitForExistence(timeout: 3), "Still running: the row shows ⏸")
        XCTAssertTrue(clock.waitForExistence(timeout: 3), "The row keeps the live clock")
        // Folded, the bar opens the timer; a swipe down puts it away again, as any iPhone sheet.
        app.buttons["Fold Anytime"].tap()
        let bar = app.descendants(matching: .any)["timer-bar"]
        XCTAssertTrue(bar.waitForExistence(timeout: 3))
        bar.tap()
        XCTAssertTrue(app.staticTexts["timer-screen-name"].waitForExistence(timeout: 3), "The bar opens the timer")
        app.staticTexts["timer-screen-name"].swipeDown(velocity: .fast)
        XCTAssertTrue(app.staticTexts["timer-screen-name"].waitForNonExistence(timeout: 3), "A swipe down puts it away")
        XCTAssertTrue(bar.waitForExistence(timeout: 3), "…and it keeps running")
        app.descendants(matching: .any)["timer-bar-stop"].tap()
    }

    /// Pause on the timer screen saves the time and offers Resume; Resume adds a new session to the same day.
    func testTimerScreenPauseKeepsTimeAndResumes() {
        launch()
        app.buttons["Start Read timer"].tap()
        let primary = app.buttons["timer-screen-primary"]
        XCTAssertTrue(primary.waitForExistence(timeout: 3))
        sleep(2)
        primary.tap()
        XCTAssertTrue(waitFor { primary.label == "Start Read timer" }, "Paused: the main button starts it again")
        let paused = screenClock.label
        sleep(2)
        XCTAssertEqual(screenClock.label, paused, "Paused: the clock stands still")
        shot("t00b-timer-paused")
        primary.tap()
        XCTAssertTrue(waitFor { primary.label == "Stop Read timer" }, "Resumed")
        app.buttons["timer-screen-close"].tap()
        XCTAssertTrue(app.buttons["Stop Read timer"].waitForExistence(timeout: 3))
        app.buttons["Stop Read timer"].tap()
        XCTAssertTrue(app.buttons["Start Read timer"].waitForExistence(timeout: 3))
    }

    /// ≡ → Appearance → Timers → Open Timer Full Screen, off: ▶ starts the timer in the row only.
    func testScreenCanBeTurnedOff() {
        launch(["-timers.openScreen", "NO"])
        app.buttons["Start Read timer"].tap()
        XCTAssertTrue(app.buttons["Stop Read timer"].waitForExistence(timeout: 3))
        XCTAssertFalse(app.staticTexts["timer-screen-name"].waitForExistence(timeout: 2), "No timer screen")
        app.buttons["Stop Read timer"].tap()
    }

    private func waitFor(_ timeout: TimeInterval = 4, _ condition: () -> Bool) -> Bool {
        let deadline = Date().addingTimeInterval(timeout)
        repeat {
            if condition() { return true }
            Thread.sleep(forTimeInterval: 0.1)
        } while Date() < deadline
        return false
    }

    func testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime() {
        launch()
        let start = app.buttons["Start Read timer"]
        XCTAssertTrue(start.waitForExistence(timeout: 5))
        start.tap()
        // ▶ opens the timer screen (4 Oct 2026); put it away to see the row.
        XCTAssertTrue(app.buttons["timer-screen-close"].waitForExistence(timeout: 3))
        app.buttons["timer-screen-close"].tap()
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

        // Stopping from the bar keeps the time and ends the timer.
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
        if app.buttons["timer-screen-close"].waitForExistence(timeout: 3) { app.buttons["timer-screen-close"].tap() }
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
