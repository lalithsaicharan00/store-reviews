import XCTest

final class FocusPlayerUITests: XCTestCase {
    private var app: XCUIApplication!

    override func record(_ issue: XCTIssue) {
        let image = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        image.name = "FAIL-\(name)"; image.lifetime = .keepAlways
        var issue = issue; issue.add(image); super.record(issue)
    }

    private func launch(_ extra: [String] = [], disk: Bool = false) {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-empty", "-focus-fixture"] + (disk ? ["-dbname", "uitest-focus-player"] : ["-uitest"]) + extra
        app.launch()
        let start = app.buttons["Start Anytime routine"]
        XCTAssertTrue(start.waitForExistence(timeout: 10))
        start.tap()
        XCTAssertTrue(app.staticTexts["focus-name"].waitForExistence(timeout: 5))
    }

    private func shot(_ name: String) {
        Thread.sleep(forTimeInterval: 0.4) // Capture the settled layout, after native transitions.
        let image = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        image.name = name; image.lifetime = .keepAlways; add(image)
    }

    private func jump(_ name: String) {
        app.buttons["routine-queue"].tap()
        let row = app.buttons["queue-" + name]
        XCTAssertTrue(row.waitForExistence(timeout: 3))
        app.reveal(row)
        row.tap()
        XCTAssertTrue(app.staticTexts["focus-name"].waitForExistence(timeout: 3))
        XCTAssertEqual(app.staticTexts["focus-name"].label, name)
    }

    func testCountCheckAndUndoStayOnTheCurrentHabit() {
        launch()
        XCTAssertEqual(app.staticTexts["focus-quantity"].label, "1 / 2 glasses")
        shot("focus-01-amount")
        app.buttons["focus-primary"].tap()
        XCTAssertTrue(app.buttons["focus-up-next"].waitForExistence(timeout: 3))
        XCTAssertEqual(app.staticTexts["focus-name"].label, "Drink water", "Completion must not move the screen under the finger")
        app.buttons["focus-undo"].tap()
        XCTAssertEqual(app.staticTexts["focus-quantity"].label, "1 / 2 glasses")
        app.buttons["focus-primary"].tap()
        app.buttons["focus-up-next"].tap()
        XCTAssertEqual(app.staticTexts["focus-name"].label, "Stretch")
        for _ in 0..<3 { app.buttons["focus-primary"].tap() }
        XCTAssertTrue(app.buttons["focus-up-next"].waitForExistence(timeout: 3))
        XCTAssertEqual(app.staticTexts["focus-quantity"].label, "3 / 3")
        XCTAssertEqual(app.staticTexts["focus-name"].label, "Stretch")
        shot("focus-02-check-complete")
        app.buttons["focus-undo"].tap()
        XCTAssertEqual(app.staticTexts["focus-quantity"].label, "2 / 3")
        XCTAssertTrue(app.buttons["focus-primary"].exists)
    }

    func testChecklistPreservesPriorStepsAndQueueCanRevisit() {
        launch()
        jump("Clean kitchen")
        XCTAssertTrue(app.buttons["Undo Wash dishes"].exists)
        XCTAssertEqual(app.staticTexts["focus-checklist-progress"].label, "1 / 3 steps")
        shot("focus-03-checklist")
        app.buttons["Mark Wipe the counter done"].tap()
        app.buttons["Mark Sweep the floor done"].tap()
        XCTAssertTrue(app.buttons["focus-up-next"].waitForExistence(timeout: 3))
        app.buttons["Previous habit"].tap()
        XCTAssertEqual(app.staticTexts["focus-name"].label, "Stretch")
        jump("Clean kitchen")
        XCTAssertTrue(app.buttons["Undo Sweep the floor"].exists)
        XCTAssertEqual(app.staticTexts["focus-checklist-progress"].label, "3 / 3 steps")
    }

    func testLimitCheckInNeverLogsConsumptionOrCompletesTheDay() {
        launch()
        jump("Less coffee")
        XCTAssertEqual(app.staticTexts["focus-quantity"].label, "0 / 2 cups max")
        XCTAssertTrue(app.buttons["focus-up-next"].exists)
        shot("focus-04-limit")
        app.buttons["focus-up-next"].tap()
        XCTAssertEqual(app.staticTexts["focus-name"].label, "Water the plants")
        app.buttons["focus-primary"].tap()
        app.buttons["focus-primary"].tap()
        XCTAssertTrue(app.staticTexts["4 left for later. Your progress is saved."].waitForExistence(timeout: 3))
        XCTAssertTrue(app.staticTexts["1 limit check-in. Your limits keep tracking through the day."].exists)
        shot("focus-05-summary")
        app.buttons["Review routine"].tap()
        app.buttons["queue-Less coffee"].tap()
        XCTAssertEqual(app.staticTexts["focus-quantity"].label, "0 / 2 cups max")
    }

    func testTimerPauseBackgroundAndSkipPreserveTime() {
        launch()
        jump("Read a little")
        XCTAssertTrue(app.buttons["Stop Read a little timer"].waitForExistence(timeout: 3))
        sleep(2)
        let first = app.staticTexts["focus-clock-value"].label
        XCUIDevice.shared.press(.home)
        sleep(3)
        app.activate()
        XCTAssertNotEqual(app.staticTexts["focus-clock-value"].label, first)
        app.buttons["focus-primary"].tap()
        let paused = app.staticTexts["focus-clock-value"].label
        sleep(2)
        XCTAssertEqual(app.staticTexts["focus-clock-value"].label, paused)
        shot("focus-06-timer-paused")
        app.buttons["focus-primary"].tap()
        app.buttons["focus-up-next"].tap()
        app.buttons["Previous habit"].tap()
        XCTAssertTrue(app.buttons["Stop Read a little timer"].waitForExistence(timeout: 3))
        XCTAssertNotEqual(app.staticTexts["focus-clock-value"].label, "0:00")
        shot("focus-07-timer-running")
        app.buttons["Close"].tap()
        XCTAssertTrue(app.buttons["Start Read a little timer"].waitForExistence(timeout: 3))
    }

    func testTimerGoalDoesNotAutoAdvanceAndManualLogIsReachable() {
        launch(["-focus-short-timer"])
        jump("Read a little")
        XCTAssertTrue(app.buttons["focus-up-next"].waitForExistence(timeout: 8))
        XCTAssertEqual(app.staticTexts["focus-name"].label, "Read a little")
        app.buttons["focus-habit-options"].tap()
        XCTAssertTrue(app.buttons["Pause timer"].exists, "Goal reached keeps timing until the user leaves or pauses")
        app.buttons["Pause timer"].tap()
        app.buttons["focus-up-next"].tap()
        app.buttons["focus-habit-options"].tap()
        app.buttons["focus-log-manually"].tap()
        let amount = app.textFields["log-amount"]
        XCTAssertTrue(amount.waitForExistence(timeout: 3))
        amount.tap(); amount.typeText("1")
        shot("focus-08-keyboard")
        app.navigationBars["Log Amount"].buttons["Add"].tap()
        XCTAssertEqual(app.staticTexts["focus-quantity"].label, "1 / 2 cups max")
        app.buttons["focus-undo"].tap()
        XCTAssertEqual(app.staticTexts["focus-quantity"].label, "0 / 2 cups max")
    }

    func testSavedFocusProgressSurvivesTermination() {
        launch(["-reset-db"], disk: true)
        app.buttons["focus-primary"].tap()
        app.buttons["focus-up-next"].tap()
        app.buttons["focus-primary"].tap()
        app.buttons["Close"].tap()
        app.terminate()
        launch(disk: true)
        XCTAssertEqual(app.staticTexts["focus-name"].label, "Stretch", "Completed water is not logged again")
        XCTAssertEqual(app.staticTexts["focus-quantity"].label, "1 / 3")
    }

    func testLargeTextKeepsActionsAndChecklistReachable() {
        launch(["-UIPreferredContentSizeCategoryName", "UICTContentSizeCategoryAccessibilityM"])
        XCTAssertTrue(app.buttons["focus-primary"].isHittable)
        shot("focus-09-large-text")
        jump("Clean kitchen")
        let last = app.buttons["Mark Sweep the floor done"]
        for _ in 0..<8 {
            if last.isHittable { break }
            app.scrollViews["routine-content"].swipeUp()
        }
        XCTAssertTrue(last.isHittable)
        last.tap()
        shot("focus-10-large-checklist")
        XCTAssertTrue(app.buttons["focus-up-next"].isHittable)
    }

    func testSectionWithOnlyALimitStillHasStart() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-uitest", "-empty", "-focus-fixture", "-focus-limit-only"]
        app.launch()
        XCTAssertTrue(app.buttons["Open Anytime"].waitForExistence(timeout: 5))
        app.buttons["Open Anytime"].tap()
        XCTAssertTrue(app.buttons["Start Anytime routine"].exists)
        app.buttons["Start Anytime routine"].tap()
        XCTAssertEqual(app.staticTexts["focus-name"].label, "Less coffee")
        app.buttons["focus-up-next"].tap()
        XCTAssertTrue(app.staticTexts["1 limit check-in. Your limits keep tracking through the day."].waitForExistence(timeout: 3))
        XCTAssertFalse(app.staticTexts["All habits in this routine are done."].exists)
    }

    func testTimerDayBoundaryAndExactUndoPersistence() {
        app = XCUIApplication()
        app.launchArguments = ["-uitest", "-focuscheck"]
        app.launch()
        XCTAssertTrue(app.staticTexts["Focus: all checks passed"].waitForExistence(timeout: 10))
    }

    func testManualTimePausesAndClockCanBeHidden() {
        launch()
        jump("Read a little")
        app.buttons["focus-habit-options"].tap()
        app.switches["Show clock"].tap()
        app.navigationBars["Read a little"].buttons["Done"].tap()
        XCTAssertFalse(app.staticTexts["focus-clock-value"].exists)
        app.buttons["focus-habit-options"].tap()
        app.buttons["focus-log-manually"].tap()
        XCTAssertTrue(app.navigationBars["Log Time"].waitForExistence(timeout: 3))
        app.navigationBars["Log Time"].buttons["Cancel"].tap()
        XCTAssertEqual(app.buttons["focus-primary"].label, "Stop Read a little timer")
        XCTAssertFalse(app.staticTexts["Paused"].exists)
    }

    func testCompactProgressAcrossPeriodsAndTypes() {
        launch(["-focus-period-fixture"])
        XCTAssertEqual(app.staticTexts["focus-quantity"].label, "1 / 2 glasses")
        XCTAssertEqual(app.staticTexts["focus-progress-period"].label, "Today")
        XCTAssertFalse(app.staticTexts["focus-goal"].exists)
        shot("compact-01-amount")
        jump("Stretch")
        app.buttons["focus-primary"].tap()
        app.buttons["focus-primary"].tap()
        XCTAssertEqual(app.staticTexts["focus-quantity"].label, "2 / 3")
        shot("compact-02-daily-check")
        jump("Call family")
        XCTAssertEqual(app.staticTexts["focus-quantity"].label, "2 / 3")
        XCTAssertEqual(app.staticTexts["focus-progress-period"].label, "This week")
        shot("compact-03-weekly-check")
        jump("Read a little")
        XCTAssertTrue(app.staticTexts["focus-clock-value"].label.contains(" / 20 min"))
        XCTAssertEqual(app.staticTexts["focus-progress-period"].label, "Today")
        shot("compact-04-timer")
        jump("Monthly reading")
        XCTAssertTrue(app.staticTexts["focus-clock-value"].label.contains(" / 1 h"))
        XCTAssertEqual(app.staticTexts["focus-progress-period"].label, "This month")
        shot("compact-05-monthly-timer")
        jump("Yearly distance")
        XCTAssertEqual(app.staticTexts["focus-quantity"].label, "0 / 100 km")
        XCTAssertEqual(app.staticTexts["focus-progress-period"].label, "This year")
        jump("Flexible reading")
        XCTAssertEqual(app.staticTexts["focus-progress-period"].label, "20 min on 3 days a week")
        XCTAssertFalse(app.staticTexts["focus-period-progress"].exists)
        shot("compact-06-flexible")
        app.buttons["focus-habit-options"].tap()
        XCTAssertEqual(app.staticTexts["focus-period-progress"].label, "0/3 days · This week")
        app.navigationBars["Flexible reading"].buttons["Done"].tap()
        jump("Water the plants")
        XCTAssertEqual(app.staticTexts["focus-quantity"].label, "0 / 1")
        shot("compact-07-task")
    }

    func testNavigationDoesNotWaitForSlowTimerWrites() {
        launch(["-focus-slow-writes"])
        jump("Read a little")
        let start = Date()
        app.buttons["focus-up-next"].tap()
        XCTAssertTrue(app.staticTexts["focus-name"].waitForExistence(timeout: 1))
        XCTAssertEqual(app.staticTexts["focus-name"].label, "Less coffee")
        let elapsed = Date().timeIntervalSince(start)
        XCTAssertLessThan(elapsed, 1.8, "Navigation must not wait for the injected 2-second database write")
        let timing = XCTAttachment(string: "Next tap to verified page: \(elapsed) seconds, with 2-second queued writes")
        timing.name = "navigation-latency"; timing.lifetime = .keepAlways; add(timing)
        app.buttons["Previous habit"].tap()
        XCTAssertEqual(app.staticTexts["focus-name"].label, "Read a little")
        XCTAssertTrue(app.buttons["Stop Read a little timer"].exists)
        app.buttons["focus-up-next"].tap()
        app.buttons["focus-up-next"].tap()
        XCTAssertEqual(app.staticTexts["focus-name"].label, "Water the plants")
        shot("compact-08-fast-navigation")
    }

}
