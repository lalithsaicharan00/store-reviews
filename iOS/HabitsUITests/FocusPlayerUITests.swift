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
        expectPage(name)
    }

    /// Polls without XCTest's waiters, which wait about a second before their first check (2 Oct 2026 log).
    private func waitUntil(_ timeout: TimeInterval = 5, _ condition: () -> Bool) -> Bool {
        let deadline = Date().addingTimeInterval(timeout)
        repeat {
            if condition() { return true }
            Thread.sleep(forTimeInterval: 0.05)
        } while Date() < deadline
        return false
    }

    /// The player is a native pager: while a page slides in, the page leaving is still in the accessibility
    /// tree, so `focus-name` (and every other id on a page) matches twice until the slide ends. Waits for the
    /// page to settle on `name` alone (found on GitHub's simulator, 2 Oct 2026).
    private func expectPage(_ name: String, timeout: TimeInterval = 5, file: StaticString = #filePath, line: UInt = #line) {
        let names = app.staticTexts.matching(identifier: "focus-name")
        if !waitUntil(timeout, { names.count == 1 && names.firstMatch.label == name }) {
            XCTFail("Expected the page for \(name) alone; found \(names.allElementsBoundByIndex.map(\.label))", file: file, line: line)
        }
    }

    /// A timed habit's clock is a button (tapping it logs time manually), so its text is read from the button:
    /// "0:06 / 20 min", with the period ("Today") as its value.
    private var clock: XCUIElement { app.buttons["focus-clock"] }

    /// The seconds on the clock: "1:05 / 20 min" is 65.
    private func clockSeconds() -> Int {
        let time = clock.label.components(separatedBy: " ").first ?? ""
        return time.split(separator: ":").reduce(0) { $0 * 60 + (Int($1) ?? 0) }
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
        expectPage("Stretch")
        let quantity = app.staticTexts["focus-quantity"]
        for count in 1...3 {
            app.buttons["focus-primary"].tap()
            XCTAssertTrue(waitUntil { quantity.label == "\(count) / 3" }, "Each tap logs one: \(quantity.label)")
        }
        // Done: the main button moves on (it said "Log one" until now).
        XCTAssertTrue(waitUntil { self.app.buttons["focus-primary"].label == "Next" }, app.buttons["focus-primary"].label)
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
        // A checklist has no main button until every step is done; then it offers Next.
        XCTAssertTrue(app.buttons["focus-primary"].waitForExistence(timeout: 3))
        app.buttons["Previous habit"].tap()
        expectPage("Stretch")
        jump("Clean kitchen")
        XCTAssertTrue(app.buttons["Undo Sweep the floor"].exists)
        XCTAssertEqual(app.staticTexts["focus-checklist-progress"].label, "3 / 3 steps")
    }

    /// A limit is logged only when it happens, so it's never in a routine of things to do: it waits on Today under
    /// Quit or Cut Down (report "Limit Habits on Today — Apart From What You Must Do", 5 Oct 2026). Replaces the limit
    /// check-in test of 2 Oct.
    func testLimitIsNotInTheRoutineAndWaitsUnderQuitOrCutDown() {
        launch()
        app.buttons["routine-queue"].tap()
        XCTAssertTrue(app.buttons["queue-Water the plants"].waitForExistence(timeout: 3))
        XCTAssertFalse(app.buttons["queue-Less coffee"].exists, "No limit in the routine")
        app.buttons["queue-Water the plants"].tap()
        expectPage("Water the plants")
        app.buttons["focus-primary"].tap()
        app.buttons["focus-primary"].tap()
        XCTAssertTrue(app.staticTexts["4 left for later. Your progress is saved."].waitForExistence(timeout: 3))
        XCTAssertFalse(app.staticTexts.matching(NSPredicate(format: "label CONTAINS 'check-in'")).firstMatch.exists)
        shot("focus-05-summary")
        app.buttons["Done"].tap()
        let card = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Quit or Cut Down'")).firstMatch
        app.reveal(card, clear: true)
        XCTAssertTrue(card.waitForExistence(timeout: 5))
        let coffee = app.descendants(matching: .any).matching(NSPredicate(format: "label BEGINSWITH 'Less coffee'")).firstMatch
        XCTAssertTrue(coffee.waitForExistence(timeout: 3), "The limit is on Today")
        shot("focus-04-limit-on-today")
        card.tap()
        XCTAssertFalse(coffee.waitForExistence(timeout: 1), "Folding Quit or Cut Down hides the limit: it's in that card")
    }

    func testTimerPauseBackgroundAndSkipPreserveTime() {
        launch()
        jump("Read a little")
        XCTAssertTrue(app.buttons["Stop Read a little timer"].waitForExistence(timeout: 3))
        sleep(2)
        let first = clock.label
        XCUIDevice.shared.press(.home)
        sleep(3)
        app.activate()
        XCTAssertNotEqual(clock.label, first)
        app.buttons["focus-primary"].tap()
        let paused = clock.label
        sleep(2)
        XCTAssertEqual(clock.label, paused)
        shot("focus-06-timer-paused")
        app.buttons["focus-primary"].tap()
        app.buttons["focus-up-next"].tap()
        expectPage("Water the plants")
        app.buttons["Previous habit"].tap()
        expectPage("Read a little")
        XCTAssertTrue(app.buttons["Stop Read a little timer"].waitForExistence(timeout: 3))
        XCTAssertFalse(clock.label.hasPrefix("0:00 "), "Time kept: \(clock.label)")
        shot("focus-07-timer-running")
        app.buttons["Close"].tap()
        XCTAssertTrue(app.buttons["Start Read a little timer"].waitForExistence(timeout: 5))
    }

    func testTimerGoalDoesNotAutoAdvanceAndManualLogIsReachable() {
        launch(["-focus-short-timer"])
        jump("Read a little")
        // The goal is 3 seconds: wait until the clock has passed it, then the page must still be this habit.
        XCTAssertTrue(waitUntil(10) { self.clockSeconds() >= 4 }, "The clock passes the 3-second goal: \(clock.label)")
        expectPage("Read a little")
        app.buttons["focus-habit-options"].tap()
        XCTAssertTrue(app.buttons["Pause timer"].waitForExistence(timeout: 3), "Goal reached keeps timing until the user leaves or pauses")
        app.buttons["Pause timer"].tap()
        app.buttons["focus-up-next"].tap()
        expectPage("Water the plants")
        // An amount's manual log (the limit used to be the amount here; limits left routines on 5 Oct 2026).
        jump("Drink water")
        app.buttons["focus-habit-options"].tap()
        app.buttons["focus-log-manually"].tap()
        let amount = app.textFields["log-amount"]
        XCTAssertTrue(amount.waitForExistence(timeout: 3))
        amount.tap(); amount.typeText("1")
        shot("focus-08-keyboard")
        app.navigationBars["Log Amount"].buttons["Log"].tap()
        let quantity = app.staticTexts["focus-quantity"]
        XCTAssertTrue(waitUntil { quantity.label == "2 / 2 glasses" }, quantity.label)
        XCTAssertTrue(app.buttons["focus-undo"].waitForExistence(timeout: 3))
        app.buttons["focus-undo"].tap()
        XCTAssertTrue(waitUntil { quantity.label == "1 / 2 glasses" }, quantity.label)
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

    /// Only a limit: no time of day, no Start and no "left", only Quit or Cut Down with the limit's own + (replaces
    /// "a section with only a limit still has Start", 2 Oct; limits left the times of day on 5 Oct 2026).
    func testOnlyALimitShowsUnderQuitOrCutDownWithoutStart() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-uitest", "-empty", "-focus-fixture", "-focus-limit-only"]
        app.launch()
        let card = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Quit or Cut Down'")).firstMatch
        XCTAssertTrue(card.waitForExistence(timeout: 10))
        XCTAssertFalse(card.label.contains("left"), "Nothing in it is to do: \(card.label)")
        XCTAssertFalse(app.buttons["Open Anytime"].exists, "No time of day holds the limit")
        XCTAssertFalse(app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Start'")).firstMatch.exists, "No routine")
        let add = app.buttons["Add 1 cup to Less coffee"]
        XCTAssertTrue(add.waitForExistence(timeout: 3), "Logged with + when it happens")
        add.tap()
        XCTAssertTrue(app.descendants(matching: .any).matching(NSPredicate(format: "label BEGINSWITH 'Less coffee'")).firstMatch.waitForExistence(timeout: 3))
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
        XCTAssertTrue(clock.exists)
        app.buttons["focus-habit-options"].tap()
        let showClock = app.switches["Show clock"].firstMatch
        XCTAssertTrue(showClock.waitForExistence(timeout: 3))
        showClock.switches.firstMatch.tap() // the switch itself, not the row's label
        XCTAssertEqual(showClock.value as? String, "0")
        app.navigationBars["Read a little"].buttons["Done"].tap()
        XCTAssertTrue(clock.waitForNonExistence(timeout: 3), "The clock can be hidden")
        app.buttons["focus-habit-options"].tap()
        app.buttons["focus-log-manually"].tap()
        XCTAssertTrue(app.navigationBars["Log Time"].waitForExistence(timeout: 3))
        app.navigationBars["Log Time"].buttons["Cancel"].tap()
        // Cancel runs the timer again. ("Paused" under the clock can't be checked here: it is always laid out,
        // invisible and hidden from VoiceOver while the timer runs, and XCUITest on iOS 26 still lists
        // VoiceOver-hidden text; the main button is what the timer's state drives.)
        XCTAssertTrue(waitUntil { self.app.buttons["focus-primary"].label == "Stop Read a little timer" },
                      app.buttons["focus-primary"].label)
        XCTAssertFalse(clock.exists, "The clock stays hidden after manual entry")
    }

    /// The bottom row is the native bottom bar, as on Today (the user, 5 Oct 2026, superseding 4 Oct's custom row 40
    /// points up): it sits at the bottom with no band of space under it, the main button floats a gap above it, and
    /// neither moves whatever the habit's state (logged with its Undo, an unfinished checklist with no main button, a
    /// running timer). An unfinished checklist's steps all show without scrolling (Current Work 51: they were cut off
    /// by the empty button slot). Habit options shows every option without scrolling.
    func testBottomRowStaysPutAndOptionsShowEverything() {
        launch()
        let screen = app.windows.firstMatch.frame
        let options = app.buttons["focus-habit-options"]
        let primary = app.buttons["focus-primary"]
        let row = options.frame
        let button = primary.frame
        XCTAssertLessThanOrEqual(screen.maxY - row.maxY, 60, "The bottom bar sits at the bottom, no band of space under it")
        XCTAssertGreaterThanOrEqual(row.minY - button.maxY, 16, "Room between the main button and the bottom bar")
        XCTAssertEqual(app.buttons["Previous habit"].frame.midY, row.midY, accuracy: 4, "‹ is in the bar")
        XCTAssertEqual(app.buttons["focus-up-next"].frame.midY, row.midY, accuracy: 4, "› is in the bar")
        shot("player-01-bottom-row")
        func expectStill(_ when: String, file: StaticString = #filePath, line: UInt = #line) {
            XCTAssertEqual(options.frame.midY, row.midY, accuracy: 0.5, "The bottom bar moved: \(when)", file: file, line: line)
            if primary.exists {
                XCTAssertEqual(primary.frame.midY, button.midY, accuracy: 0.5, "The main button moved: \(when)", file: file, line: line)
            }
        }
        primary.tap()
        XCTAssertTrue(app.buttons["focus-persistent-undo"].waitForExistence(timeout: 3))
        expectStill("after a log, with Undo under the circle")
        jump("Clean kitchen")
        XCTAssertFalse(primary.exists, "An unfinished checklist has no main button")
        expectStill("an unfinished checklist")
        let lastStep = app.buttons["Mark Sweep the floor done"]
        XCTAssertTrue(lastStep.isHittable && lastStep.frame.maxY <= row.minY,
                      "Every step shows above the bottom bar without scrolling: \(lastStep.frame), bar \(row)")
        shot("player-03-checklist-steps")
        app.buttons["Mark Wipe the counter done"].tap()
        app.buttons["Mark Sweep the floor done"].tap()
        XCTAssertTrue(primary.waitForExistence(timeout: 3))
        expectStill("a finished checklist")
        jump("Read a little")
        XCTAssertTrue(app.buttons["Stop Read a little timer"].waitForExistence(timeout: 3))
        expectStill("a running timer")
        sleep(2)
        primary.tap() // Pause: the time so far is an entry, so Undo joins the options
        expectStill("a paused timer")
        options.tap()
        let edit = app.buttons["focus-edit-habit"]
        XCTAssertTrue(edit.waitForExistence(timeout: 3))
        Thread.sleep(forTimeInterval: 0.6) // the sheet settles at its fitted height
        // Waits like Edit Habit above: on main (run 37298794001) the switch was on screen a moment after a bare
        // `exists` checked for it, while the sheet was still settling.
        XCTAssertTrue(app.switches["Show clock"].firstMatch.waitForExistence(timeout: 3))
        XCTAssertTrue(edit.isHittable && edit.frame.maxY <= screen.maxY, "Edit Habit shows without scrolling: \(edit.frame)")
        shot("player-02-options-fitted")
        app.navigationBars["Read a little"].buttons["Done"].tap()
        XCTAssertTrue(edit.waitForNonExistence(timeout: 3))
        expectStill("after the options sheet")
    }

    func testCompactProgressAcrossPeriodsAndTypes() {
        launch(["-focus-period-fixture"])
        XCTAssertEqual(app.staticTexts["focus-quantity"].label, "1 / 2 glasses")
        XCTAssertEqual(app.staticTexts["focus-progress-period"].label, "Today")
        XCTAssertFalse(app.staticTexts["focus-goal"].exists)
        shot("compact-01-amount")
        jump("Stretch")
        let quantity = app.staticTexts["focus-quantity"]
        app.buttons["focus-primary"].tap()
        XCTAssertTrue(waitUntil { quantity.label == "1 / 3" }, quantity.label)
        app.buttons["focus-primary"].tap()
        XCTAssertTrue(waitUntil { quantity.label == "2 / 3" }, quantity.label)
        shot("compact-02-daily-check")
        jump("Call family")
        // 2 / 3 from earlier in the week, or 0 / 3 when the week starts today.
        XCTAssertTrue(["2 / 3", "0 / 3"].contains(app.staticTexts["focus-quantity"].label))
        XCTAssertEqual(app.staticTexts["focus-progress-period"].label, "This week")
        shot("compact-03-weekly-check")
        jump("Read a little")
        XCTAssertTrue(clock.label.contains(" / 20 min"), clock.label)
        XCTAssertEqual(app.staticTexts["focus-progress-period"].label, "Today")
        shot("compact-04-timer")
        jump("Monthly reading")
        XCTAssertTrue(clock.label.contains(" / 1 h"), clock.label)
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
        let quota = app.staticTexts["focus-period-progress"]
        XCTAssertTrue(quota.waitForExistence(timeout: 3))
        XCTAssertEqual(quota.label, "0/3 days · This week")
        app.navigationBars["Flexible reading"].buttons["Done"].tap()
        jump("Water the plants")
        XCTAssertEqual(app.staticTexts["focus-quantity"].label, "0 / 1")
        shot("compact-07-task")
    }

    /// Current Work 50 (the user, 5 Oct 2026): › tapped fast through the routine, then ‹ fast back to the start, made the
    /// pages slide back and forth while the segments above were right. In a 13-habit routine like the user's, the app
    /// taps itself every 0.15, 0.1 and 0.05 s (XCUITest waits for each slide to end, so it can't tap that fast) and
    /// `PagerProbe` reads where the pages are on screen every frame.
    func testFastNavigationNeverSlidesBack() {
        launch(["-focus-fast-nav-check", "-focus-many"])
        let result = app.staticTexts["focus-pager-check"]
        XCTAssertTrue(result.waitForExistence(timeout: 90), "The check didn't finish")
        let evidence = XCTAttachment(string: result.label)
        evidence.name = "fast-navigation"; evidence.lifetime = .keepAlways; add(evidence)
        XCTAssertTrue(result.label.hasPrefix("Fast navigation: passed"), result.label)
        shot("focus-11-after-fast-navigation")
    }

    /// A swipe still moves one habit at a time, and the player follows it (the toolbar's position, the main button).
    /// The pager is the player's own paging scroll view since Current Work 50 (5 Oct 2026), so a swipe is read when it
    /// comes to rest.
    func testSwipeMovesOneHabitAtATime() {
        launch()
        let names = app.staticTexts.matching(identifier: "focus-name")
        let first = names.firstMatch.label
        names.firstMatch.swipeLeft()
        XCTAssertTrue(waitUntil { names.count == 1 && names.firstMatch.label != first }, "The swipe moved on")
        XCTAssertTrue(app.buttons["routine-queue"].label.contains("habit 2 of"), app.buttons["routine-queue"].label)
        names.firstMatch.swipeRight()
        expectPage(first)
        XCTAssertTrue(app.buttons["routine-queue"].label.contains("habit 1 of"), app.buttons["routine-queue"].label)
        XCTAssertFalse(app.buttons["Previous habit"].isEnabled, "Back at the first habit")
    }

    func testNavigationDoesNotWaitForSlowTimerWrites() {
        launch(["-focus-slow-writes"])
        jump("Read a little")
        let start = Date()
        app.buttons["focus-up-next"].tap()
        // Polled, not waitForExistence: that waits about a second before its first look. (Limits left routines on
        // 5 Oct 2026, so the task is next.)
        expectPage("Water the plants", timeout: 3)
        let elapsed = Date().timeIntervalSince(start)
        XCTAssertLessThan(elapsed, 1.8, "Navigation must not wait for the injected 2-second database write")
        let timing = XCTAttachment(string: "Next tap to verified page: \(elapsed) seconds, with 2-second queued writes")
        timing.name = "navigation-latency"; timing.lifetime = .keepAlways; add(timing)
        app.buttons["Previous habit"].tap()
        expectPage("Read a little")
        XCTAssertTrue(app.buttons["Stop Read a little timer"].exists)
        app.buttons["focus-up-next"].tap()
        expectPage("Water the plants")
        shot("compact-08-fast-navigation")
    }

}
