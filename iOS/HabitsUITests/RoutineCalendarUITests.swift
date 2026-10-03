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
        XCTAssertTrue(app.reveal(element, clear: true))
    }

    /// The player names its routine on its title button ("Afternoon routine, habit 1 of 2"); it has no
    /// navigation title of its own.
    private func playerShows(_ part: String) -> Bool {
        let title = app.buttons["routine-queue"]
        return title.waitForExistence(timeout: 3) && title.label.hasPrefix("\(part) routine")
    }

    /// Only the Now part and Anytime start open; another part is folded, with no ▶, until it's opened.
    private func openSection(_ title: String) {
        let chevron = app.buttons.matching(NSPredicate(format: "label == %@ OR label == %@", "Open \(title)", "Fold \(title)")).firstMatch
        reveal(chevron)
        if chevron.label == "Open \(title)" { chevron.tap() }
    }

    /// The player's main button once its habit is done; on the last habit it finishes the routine.
    private func tapFinish() {
        let finish = app.buttons["focus-primary"]
        let ready = XCTNSPredicateExpectation(predicate: NSPredicate(format: "label == 'Finish routine'"), object: finish)
        XCTAssertEqual(XCTWaiter.wait(for: [ready], timeout: 3), .completed, "The main button finishes the routine")
        finish.tap()
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
        XCTAssertTrue(playerShows("Anytime"))
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
        openSection("Afternoon")
        reveal(play)
        play.tap()
        XCTAssertTrue(playerShows("Afternoon"))
        XCTAssertTrue(app.buttons["Add 1,000 steps to Walk"].waitForExistence(timeout: 3), "+ says its step")
        // Moving on is the › chevron, which names the next habit and logs nothing ("Skip today" is another thing:
        // it sets the habit aside for the day).
        let upNext = app.buttons["focus-up-next"]
        XCTAssertEqual(upNext.label, "Next habit: Lunch, no phone")
        upNext.tap()
        XCTAssertTrue(app.buttons["Mark Lunch, no phone done"].waitForExistence(timeout: 3))
        app.buttons["focus-primary"].tap()
        XCTAssertTrue(app.buttons["focus-undo"].waitForExistence(timeout: 3))
        tapFinish()
        XCTAssertTrue(app.staticTexts["1 left for later. Your progress is saved."].waitForExistence(timeout: 3))
        shot("routine-skipped")
        app.buttons["Done"].tap()
        reveal(play)
        play.tap()
        XCTAssertTrue(playerShows("Afternoon"))
        XCTAssertTrue(app.buttons["routine-queue"].label.hasSuffix("habit 1 of 1"), "Resume includes only unfinished habits")
        // + adds its step (1,000 steps); any other amount is typed from Habit options, inside the routine too.
        XCTAssertTrue(app.buttons["Add 1,000 steps to Walk"].waitForExistence(timeout: 3))
        app.buttons["focus-habit-options"].tap()
        let manual = app.buttons["focus-log-manually"]
        XCTAssertTrue(manual.waitForExistence(timeout: 3))
        manual.tap()
        let amount = app.textFields["log-amount"]
        XCTAssertTrue(amount.waitForExistence(timeout: 3), "Habit options open Log Amount")
        sleep(1); amount.typeText("3000")
        app.navigationBars["Log Amount"].buttons["Log"].tap()
        sleep(2)
        shot("routine-walk-added")
        tapFinish() // 5,200 + 3,000 of 8,000 steps: done
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
        app.reveal(play)
        play.tap()
        XCTAssertTrue(app.buttons["Mark Cleanser done"].waitForExistence(timeout: 3))
        // Moving on (›) never marks anything done; the main button, the one that finishes, only appears once
        // every step is done.
        XCTAssertFalse(app.buttons["focus-primary"].exists, "An unfinished checklist can't be finished")
        app.buttons["focus-step-Cleanser"].tap()
        XCTAssertTrue(app.buttons["Undo Cleanser"].waitForExistence(timeout: 3))
        shot("routine-checklist")
        tapFinish()
        XCTAssertTrue(app.staticTexts["All habits in this routine are done."].waitForExistence(timeout: 3))
    }

    func testCalendarTotalsAndDaysWithoutHabits() {
        let bar = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Today,'")).firstMatch.label
        let count = bar.components(separatedBy: ", ")[1].components(separatedBy: ".")[0]
        openCalendar()
        let today = app.buttons[dayID(Date())]
        XCTAssertTrue(today.isSelected)
        // The calendar's dates are plain since 2 Oct 2026 (the user: no done-of-planned ring); the day's count is the
        // bottom bar's.
        XCTAssertEqual(today.value as? String, "Today")
        XCTAssertTrue(count.hasSuffix(" done"), "The day bar still counts the day: \(count)")
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
        XCTAssertEqual(oldDay.value as? String ?? "", "", "A past date is a plain date")
        shot("calendar-no-habits")
        oldDay.tap()
        XCTAssertTrue(app.buttons.matching(NSPredicate(format: "label CONTAINS '0 of 0 done'")).firstMatch.waitForExistence(timeout: 3))
        openCalendar()
        app.buttons["calendar-back-to-today"].tap()
        XCTAssertTrue(app.buttons["Start Anytime routine"].waitForExistence(timeout: 3))
    }

    func testCalendarUpdatesAfterLoggingAndPastNavigation() {
        // The day's count moved from the calendar's rings to the bottom bar (2 Oct 2026): logging updates the bar.
        let bar = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Today,'")).firstMatch
        let before = bar.label
        openCalendar()
        let today = app.buttons[dayID(Date())]
        XCTAssertEqual(today.value as? String, "Today")
        today.tap()
        app.buttons["Mark Call family done"].tap()
        XCTAssertTrue(app.buttons["Undo Call family"].waitForExistence(timeout: 3))
        XCTAssertNotEqual(bar.label, before, "The day bar counts the new tick")
        openCalendar()
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        if Calendar.current.component(.month, from: yesterday) != Calendar.current.component(.month, from: Date()) { app.buttons["Previous month"].tap() }
        // A tap where the day is drawn: XCUITest calls the calendar's last row "not hittable" (1 Oct 2026, nothing
        // covers it on screen), and the next line fails if anything really took the tap.
        let day = app.buttons[dayID(yesterday)]
        XCTAssertTrue(day.waitForExistence(timeout: 3))
        day.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
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
        app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Check it off'")).firstMatch.tap()
        let name = app.descendants(matching: .any)["name-field"]
        XCTAssertTrue(name.waitForExistence(timeout: 3))
        name.tap()
        name.typeText("Practice")
        app.navigationBars["New Habit"].buttons["Add"].tap()
        XCTAssertTrue(app.buttons["Start Anytime routine"].waitForExistence(timeout: 3))
        app.buttons["Start Anytime routine"].tap()
        app.buttons["focus-primary"].tap()
        XCTAssertTrue(app.buttons["focus-undo"].waitForExistence(timeout: 3))
        // The up-next pill and the main button both say "Finish routine": tap the main one.
        app.buttons["focus-primary"].tap()
        app.buttons["Done"].tap()
        XCTAssertFalse(app.buttons["Start Anytime routine"].exists)
        XCTAssertTrue(app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Today, 1 of 1 done'")).firstMatch.exists,
                      "The day bar counts the finished day")
        openCalendar()
        XCTAssertEqual(app.buttons[dayID(Date())].value as? String, "Today")
        shot("calendar-complete")
        app.navigationBars["Go to a day"].buttons["Done"].tap()
        // Just added, Anytime stays open after it's finished; open it if it folded.
        let open = app.buttons["Open Anytime"]
        if open.waitForExistence(timeout: 1) { open.tap() }
        app.buttons["Undo Practice"].tap()
        XCTAssertTrue(app.buttons["Start Anytime routine"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Today, 0 of 1 done'")).firstMatch.exists,
                      "The day bar takes the undo back")
        openCalendar()
        XCTAssertEqual(app.buttons[dayID(Date())].value as? String, "Today")
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
                app.reveal(button)
                XCTAssertTrue(button.isHittable)
                shot("calendar-six-weeks-large-text")
                button.tap()
                // The sheet closes with an animation: wait for it, rather than reading the screen mid-slide.
                XCTAssertTrue(app.navigationBars["Go to a day"].waitForNonExistence(timeout: 3), "Choosing a day closes the calendar")
                return
            }
            app.buttons["Next month"].tap()
            date = calendar.date(byAdding: .month, value: 1, to: date)!
        }
        XCTFail("Expected a six-week month within one year")
    }

}
