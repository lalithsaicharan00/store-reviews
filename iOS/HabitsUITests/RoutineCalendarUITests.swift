import XCTest

final class RoutineCalendarUITests: XCTestCase {
    override func record(_ issue: XCTIssue) {
        let shot = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        shot.name = "FAIL-\(name)"
        shot.lifetime = .keepAlways
        var issue = issue
        issue.add(shot)
        super.record(issue)
    }

    private var app: XCUIApplication!
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-uitest"]
        app.launch()
        XCTAssertTrue(app.buttons["Start Anytime routine"].waitForExistence(timeout: 8))
    }

    private func shot(_ name: String) {
        let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    private func reveal(_ element: XCUIElement) {
        let window = app.windows.firstMatch
        for _ in 0..<12 {
            if element.exists && element.isHittable && element.frame.minY > 100 && element.frame.maxY < window.frame.maxY - 90 { return }
            let upward = !element.exists || element.frame.minY > window.frame.midY
            window.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: upward ? 0.65 : 0.35))
                .press(forDuration: 0.05, thenDragTo: window.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: upward ? 0.42 : 0.58)))
        }
        XCTAssertTrue(element.isHittable)
    }

    private func openCalendar() {
        let label = app.buttons.matching(NSPredicate(format: "label CONTAINS 'Open calendar'")).firstMatch
        XCTAssertTrue(label.waitForExistence(timeout: 3))
        label.tap()
        XCTAssertTrue(app.navigationBars["Go to a day"].waitForExistence(timeout: 3))
    }

    private func dayID(_ date: Date) -> String {
        let c = Calendar.current.dateComponents([.year, .month, .day], from: date)
        return "calendar-day-\(c.year!)-\(c.month!)-\(c.day!)"
    }

    /// Start follows the section-header rules (28 Sep): "▶ Start" in open sections; folded, only the Now
    /// section keeps ▶; never on Quitting or a finished section. Play never changes disclosure.
    func testPlayFollowsHeaderRules() {
        let play = app.buttons["Start Anytime routine"]
        XCTAssertTrue(play.isHittable, "An open section has Start")
        XCTAssertGreaterThanOrEqual(play.frame.height, 44)
        play.tap()
        XCTAssertTrue(app.navigationBars["Anytime routine"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.buttons["Stop Read timer"].waitForExistence(timeout: 3))
        shot("routine-timer")
        app.buttons["Close"].tap()
        XCTAssertTrue(app.buttons["Fold Anytime"].waitForExistence(timeout: 3), "Play does not change disclosure")
        XCTAssertTrue(app.buttons["Start Read timer"].waitForExistence(timeout: 3), "Closing pauses the timer")
        app.buttons["Fold Anytime"].tap()
        XCTAssertFalse(play.waitForExistence(timeout: 1), "A folded section that isn't Now has no ▶")
        XCTAssertTrue(app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Anytime' AND label CONTAINS 'left'")).firstMatch.exists, "Folded, it still says how many are left")
        app.buttons["Open Anytime"].tap()
        XCTAssertTrue(play.waitForExistence(timeout: 2), "Opening shows Start again")
        XCTAssertFalse(app.buttons["Start Quitting routine"].exists)
        XCTAssertFalse(app.buttons["Start Morning routine"].exists, "Completed sections have no play")
        shot("routine-headers")
    }

    func testNonTimedRoutineAndSkipDoNotFalselyComplete() {
        let play = app.buttons["Start Afternoon routine"]
        reveal(play)
        play.tap()
        XCTAssertTrue(app.navigationBars["Afternoon routine"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.buttons["Add 1,000 steps to Walk"].exists, "+ says its step")
        XCTAssertFalse(app.buttons["Next habit"].isEnabled)
        app.buttons["Skip for now"].tap()
        XCTAssertTrue(app.buttons["Mark Lunch, no phone done"].waitForExistence(timeout: 3))
        app.collectionViews["routine-list"].buttons["Mark Lunch, no phone done"].tap()
        XCTAssertTrue(app.buttons["Undo Lunch, no phone"].waitForExistence(timeout: 3))
        app.buttons["Finish routine"].tap()
        XCTAssertTrue(app.staticTexts["1 left for later. Your progress is saved."].waitForExistence(timeout: 3))
        shot("routine-skipped")
        app.buttons["Done"].tap()
        reveal(play)
        play.tap()
        // + adds its step (1,000 steps); tapping the row types any other amount, inside the routine too.
        let walk = app.collectionViews["routine-list"].staticTexts["Walk"].firstMatch
        XCTAssertTrue(walk.waitForExistence(timeout: 3))
        XCTAssertTrue(app.staticTexts["Habit 1 of 1"].exists, "Resume includes only unfinished habits")
        walk.tap()
        let amount = app.textFields["log-amount"]
        XCTAssertTrue(amount.waitForExistence(timeout: 3), "The row opens Add Amount")
        sleep(1); amount.typeText("3000")
        app.navigationBars["Add Amount"].buttons["Add"].tap()
        sleep(2)
        shot("routine-walk-added")
        app.buttons["Finish routine"].tap()
        XCTAssertTrue(app.staticTexts["All habits in this routine are done."].waitForExistence(timeout: 3))
        app.buttons["Done"].tap()
        XCTAssertFalse(play.exists)
    }

    func testChecklistRoutineUsesExistingEntries() {
        app.buttons["Fold Quitting"].tap()
        app.buttons["Fold Anytime"].tap()
        let morning = app.buttons["Open Morning"]
        reveal(morning)
        morning.tap()
        let checklist = app.buttons["Show Skincare steps"]
        reveal(checklist)
        checklist.tap()
        let undo = app.buttons["Undo Cleanser"]
        reveal(undo)
        undo.tap()
        let play = app.buttons["Start Morning routine"]
        for _ in 0..<4 where !play.isHittable { app.swipeDown() }
        play.tap()
        XCTAssertTrue(app.buttons["Mark Cleanser done"].waitForExistence(timeout: 3))
        XCTAssertFalse(app.buttons["Finish routine"].isEnabled)
        app.collectionViews["routine-list"].buttons["Mark Cleanser done"].tap()
        XCTAssertTrue(app.buttons["Undo Cleanser"].waitForExistence(timeout: 3))
        shot("routine-checklist")
        app.buttons["Finish routine"].tap()
        XCTAssertTrue(app.staticTexts["All habits in this routine are done."].waitForExistence(timeout: 3))
    }

    func testCalendarTotalsAndDaysWithoutHabits() {
        let bar = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Today,'")).firstMatch.label
        let count = bar.components(separatedBy: ", ")[1].components(separatedBy: ".")[0]
        openCalendar()
        let today = app.buttons[dayID(Date())]
        XCTAssertTrue(today.isSelected)
        XCTAssertEqual(today.value as? String, "Today. " + count)
        shot("calendar-progress")
        app.buttons["Next month"].tap()
        let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: Date())!
        let future = app.buttons[dayID(nextMonth)]
        XCTAssertTrue((future.value as? String ?? "").contains("Preview"))
        future.tap()
        XCTAssertFalse(app.buttons.matching(NSPredicate(format: "label ENDSWITH ' routine'")).firstMatch.exists)
        let check = app.buttons["Mark Call family done"]
        XCTAssertTrue(check.exists)
        XCTAssertFalse(check.isEnabled, "Future days are previews")
        openCalendar()
        for _ in 0..<6 { app.buttons["Previous month"].tap() }
        let old = Calendar.current.date(byAdding: .month, value: -5, to: Date())!
        let oldDay = app.buttons[dayID(old)]
        XCTAssertEqual(oldDay.value as? String, "No habits scheduled")
        shot("calendar-no-habits")
        oldDay.tap()
        XCTAssertTrue(app.buttons.matching(NSPredicate(format: "label CONTAINS '0 of 0 done'")).firstMatch.waitForExistence(timeout: 3))
        openCalendar()
        app.buttons["calendar-back-to-today"].tap()
        XCTAssertTrue(app.buttons["Start Anytime routine"].waitForExistence(timeout: 3))
    }

    func testCalendarUpdatesAfterLoggingAndPastNavigation() {
        openCalendar()
        let today = app.buttons[dayID(Date())]
        let before = today.value as! String
        today.tap()
        app.buttons["Mark Call family done"].tap()
        XCTAssertTrue(app.buttons["Undo Call family"].waitForExistence(timeout: 3))
        openCalendar()
        XCTAssertNotEqual(app.buttons[dayID(Date())].value as? String, before)
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        if Calendar.current.component(.month, from: yesterday) != Calendar.current.component(.month, from: Date()) { app.buttons["Previous month"].tap() }
        app.buttons[dayID(yesterday)].tap()
        XCTAssertTrue(app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Yesterday,'")).firstMatch.waitForExistence(timeout: 3))
        XCTAssertFalse(app.buttons["Start Anytime routine"].exists)
        app.buttons["Next day"].tap()
        XCTAssertTrue(app.buttons["Undo Call family"].waitForExistence(timeout: 3))
    }
    func testSingleHabitFullCompletionAndUndo() {
        app.terminate()
        app.launchArguments = ["-uitest", "-empty"]
        app.launch()
        app.buttons["New Habit"].firstMatch.tap()
        app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Build or maintain'")).firstMatch.tap()
        let name = app.descendants(matching: .any)["name-field"]
        XCTAssertTrue(name.waitForExistence(timeout: 3))
        name.tap()
        name.typeText("Practice")
        app.navigationBars["New Habit"].buttons["Add"].tap()
        XCTAssertTrue(app.buttons["Start Anytime routine"].waitForExistence(timeout: 3))
        app.buttons["Start Anytime routine"].tap()
        app.collectionViews["routine-list"].buttons["Mark Practice done"].tap()
        XCTAssertTrue(app.buttons["Undo Practice"].waitForExistence(timeout: 3))
        app.buttons["Finish routine"].tap()
        app.buttons["Done"].tap()
        XCTAssertFalse(app.buttons["Start Anytime routine"].exists)
        openCalendar()
        XCTAssertEqual(app.buttons[dayID(Date())].value as? String, "Today. 1 of 1 done")
        shot("calendar-complete")
        app.navigationBars["Go to a day"].buttons["Done"].tap()
        // Just added, Anytime stays open after it's finished; open it if it folded.
        let open = app.buttons["Open Anytime"]
        if open.waitForExistence(timeout: 1) { open.tap() }
        app.buttons["Undo Practice"].tap()
        XCTAssertTrue(app.buttons["Start Anytime routine"].waitForExistence(timeout: 3))
        openCalendar()
        XCTAssertEqual(app.buttons[dayID(Date())].value as? String, "Today. 0 of 1 done")
    }

    func testCalendarSixWeekMonthAtLargeTextSize() {
        app.terminate()
        app.launchArguments = ["-uitest", "-UIPreferredContentSizeCategoryName", "UICTContentSizeCategoryAccessibilityM"]
        app.launch()
        openCalendar()
        // Move to a six-row month and confirm its final day remains reachable.
        var date = Date()
        let calendar = Calendar.current
        for _ in 0..<12 {
            let first = calendar.date(from: calendar.dateComponents([.year, .month], from: date))!
            let leading = (calendar.component(.weekday, from: first) - calendar.firstWeekday + 7) % 7
            let days = calendar.range(of: .day, in: .month, for: first)!.count
            if leading + days > 35 {
                let last = calendar.date(byAdding: .day, value: days - 1, to: first)!
                let button = app.buttons[dayID(last)]
                for _ in 0..<3 where !button.isHittable { app.swipeUp() }
                XCTAssertTrue(button.isHittable)
                shot("calendar-six-weeks-large-text")
                button.tap()
                XCTAssertFalse(app.navigationBars["Go to a day"].exists)
                return
            }
            app.buttons["Next month"].tap()
            date = calendar.date(byAdding: .month, value: 1, to: date)!
        }
        XCTFail("Expected a six-week month within one year")
    }

}
