import XCTest

/// Drives the Today screen on a real device or simulator and keeps screenshots of each state.
final class TodayUITests: XCTestCase {
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
    }

    private func shot(_ name: String) {
        let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    func testTodayScreen() {
        XCTAssertTrue(app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Quitting'")).firstMatch.waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["Anytime"].exists)
        shot("01-today")

        // Tick a yes/no habit, then undo it.
        let call = app.buttons["Mark Call family done"]
        XCTAssertTrue(call.waitForExistence(timeout: 2))
        call.tap()
        shot("02-call-ticked")
        let undo = app.buttons["Undo Call family"]
        if undo.waitForExistence(timeout: 2) { undo.tap() }

        // Fold and open the Anytime part.
        app.staticTexts["Anytime"].tap()
        shot("03-anytime-folded")
        app.staticTexts["Anytime"].tap()

        // The day bar is the system bottom toolbar (Figma 193:6): ‹, the day label, ›.
        for name in ["Previous day", "Next day"] {
            XCTAssertTrue(app.buttons[name].isHittable, name)
        }

        // Previous day, then back to today through the calendar. The bar's buttons stay put.
        let before = (app.buttons["Previous day"].frame, app.buttons["Next day"].frame)
        app.buttons["Previous day"].tap()
        XCTAssertTrue(app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Yesterday,'")).firstMatch.waitForExistence(timeout: 2))
        shot("04-yesterday")
        XCTAssertEqual(app.buttons["Previous day"].frame, before.0, "‹ doesn't move")
        XCTAssertEqual(app.buttons["Next day"].frame, before.1, "› doesn't move")
        app.buttons["Previous day"].tap()
        XCTAssertEqual(app.buttons["Next day"].frame, before.1, "› doesn't move for a dated label")
        // Step forward one day at a time, waiting for each change.
        let yesterday = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Yesterday,'")).firstMatch
        app.buttons["Next day"].tap()
        XCTAssertTrue(yesterday.waitForExistence(timeout: 3))
        app.buttons["Next day"].tap()
        let label = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Today,'")).firstMatch
        XCTAssertTrue(label.waitForExistence(timeout: 3))
        label.tap()
        XCTAssertTrue(app.navigationBars["Go to a day"].waitForExistence(timeout: 2))
        shot("05-calendar")
        XCTAssertFalse(app.buttons["calendar-back-to-today"].exists, "No Back to Today while on today")
        app.navigationBars["Go to a day"].buttons["Done"].tap()

        // + opens New Habit.
        app.buttons["New Habit"].tap()
        XCTAssertTrue(app.navigationBars["New"].waitForExistence(timeout: 3))
        shot("06-new-habit")
    }

    /// The ≡ menu (the user's final decision, 30 Sep 2026; `Docs/Checklists/Sidebar Menu.md`): every row is there,
    /// most used first; the wired pages open on Today's stack and Back returns to Today; tapping the dimmed Today
    /// closes it; a swipe from Today's left edge opens it.
    func testMenu() {
        let menu = app.buttons["menu-button"]
        XCTAssertTrue(menu.waitForExistence(timeout: 5))
        XCTAssertFalse(app.buttons["All habits"].exists, "All Habits moved into the menu")
        XCTAssertFalse(app.buttons["Settings"].exists, "The avatar became the menu")
        XCTAssertTrue(app.buttons["filter-button"].exists, "Filter, beside +")
        XCTAssertTrue(app.buttons["New Habit"].exists)

        menu.tap()
        let rows = ["today", "progress", "habits", "tasks", "timesOfDay", "dayAndWeek", "reminders", "appearance",
                    "backup", "privacy", "plus", "help", "about"]
        for row in rows {
            // The last rows can sit below a small screen's edge: scroll the menu (not Today) to reach them.
            if !app.buttons["menu-" + row].waitForExistence(timeout: 3) { app.buttons["menu-appearance"].swipeUp() }
            XCTAssertTrue(app.buttons["menu-" + row].waitForExistence(timeout: 3), row)
        }
        if !app.buttons["menu-today"].isHittable { app.buttons["menu-appearance"].swipeDown() }
        // Most used first: Today, Progress, Habits, Tasks at the top.
        let tops = rows.prefix(4).map { app.buttons["menu-" + $0].frame.minY }
        XCTAssertEqual(tops, tops.sorted(), "Today, Progress, Habits, Tasks in that order")
        shot("m01-menu")

        // Today closes the menu: the rows are gone and Today's buttons work again.
        app.buttons["menu-today"].tap()
        XCTAssertTrue(app.buttons["menu-today"].waitForNonExistence(timeout: 3))
        XCTAssertTrue(menu.isHittable)

        // Habits: its page, then a habit's own page, then back to Today.
        openFromMenu("habits", title: "Habits")
        let call = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Call family'")).firstMatch
        XCTAssertTrue(call.waitForExistence(timeout: 3))
        shot("m02-habits")
        call.tap()
        // The page's own title bar: the Habits row also shows the name, so text alone can't prove the page opened.
        XCTAssertTrue(app.navigationBars["Call family"].waitForExistence(timeout: 5), "The habit page opens")
        back(to: "Habits")
        XCTAssertTrue(app.navigationBars["Habits"].waitForExistence(timeout: 3), "Back on Habits")
        back()
        XCTAssertTrue(menu.waitForExistence(timeout: 3), "Back on Today")

        // The other wired pages, Progress among them.
        for (row, title) in [("tasks", "Tasks"), ("timesOfDay", "Times of Day"), ("plus", "Plus"), ("progress", "Progress")] {
            openFromMenu(row, title: title)
            shot("m03-" + row)
            back()
            XCTAssertTrue(menu.waitForExistence(timeout: 3), "Back on Today from \(title)")
        }

        // Tapping the dimmed Today closes the menu.
        menu.tap()
        XCTAssertTrue(app.buttons["menu-today"].waitForExistence(timeout: 3))
        app.coordinate(withNormalizedOffset: CGVector(dx: 0.95, dy: 0.5)).tap()
        XCTAssertTrue(app.buttons["menu-today"].waitForNonExistence(timeout: 3))

        // A swipe from Today's left edge opens it.
        let edge = app.coordinate(withNormalizedOffset: CGVector(dx: 0.005, dy: 0.5))
        edge.press(forDuration: 0.05, thenDragTo: app.coordinate(withNormalizedOffset: CGVector(dx: 0.75, dy: 0.5)))
        XCTAssertTrue(app.buttons["menu-today"].waitForExistence(timeout: 3), "Edge swipe opens the menu")
        shot("m04-edge-swipe")
        app.buttons["menu-today"].tap()
        XCTAssertTrue(app.buttons["menu-today"].waitForNonExistence(timeout: 3))
    }

    private func openFromMenu(_ row: String, title: String) {
        app.buttons["menu-button"].tap()
        let button = app.buttons["menu-" + row]
        XCTAssertTrue(button.waitForExistence(timeout: 3), row)
        button.tap()
        XCTAssertTrue(app.navigationBars[title].waitForExistence(timeout: 5), "\(title) opens")
    }

    /// The system Back button: found by its identifier or its label (the page before, or "Back"), since a page's own
    /// toolbar buttons can come first in the bar; otherwise the system's swipe from the left edge.
    private func back(to previous: String = "Back") {
        let bar = app.navigationBars.firstMatch
        for name in ["BackButton", previous, "Back"] where bar.buttons[name].exists {
            bar.buttons[name].tap()
            return
        }
        app.coordinate(withNormalizedOffset: CGVector(dx: 0.01, dy: 0.5))
            .press(forDuration: 0.05, thenDragTo: app.coordinate(withNormalizedOffset: CGVector(dx: 0.9, dy: 0.5)))
    }

    /// Back to Today appears only on another day: above the day bar on Today, and at the bottom of the
    /// calendar. The calendar marks the open day with a circle, like its rings.
    func testBackToToday() {
        XCTAssertTrue(app.buttons["Previous day"].waitForExistence(timeout: 5))
        XCTAssertFalse(app.buttons["back-to-today"].exists, "Hidden on today")
        app.buttons["Previous day"].tap()
        let back = app.buttons["back-to-today"]
        XCTAssertTrue(back.waitForExistence(timeout: 3), "Shown on another day")
        shot("b01-yesterday-back-to-today")
        // The calendar offers it too, at the bottom, while another day is open.
        app.buttons.matching(NSPredicate(format: "label CONTAINS 'Open calendar'")).firstMatch.tap()
        XCTAssertTrue(app.navigationBars["Go to a day"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.buttons["calendar-back-to-today"].waitForExistence(timeout: 2))
        XCTAssertFalse(app.navigationBars["Go to a day"].buttons["Today"].exists, "No Today button at the top")
        shot("b02-calendar-selected-circle")
        app.navigationBars["Go to a day"].buttons["Done"].tap()
        back.tap()
        XCTAssertTrue(app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Today,'")).firstMatch.waitForExistence(timeout: 3))
        XCTAssertFalse(app.buttons["back-to-today"].waitForExistence(timeout: 1), "Gone once back on today")
    }
    // MARK: Build Plan #58, #59, #61 (`Docs/Checklists/Animations and Settings.md`)

    /// Ticking off (#58): a done row finishes in place and sinks below the rest only once the person pauses, never in
    /// the middle of a run of taps. Call family, then Water: before the pause Call family is still above Water; after it,
    /// below. (Ticking Water moves "Add note" off Call family, which would otherwise hold it in place.)
    func testDoneRowWaitsForThePause() {
        // An 8 s pause: GitHub's simulator takes more than 1.5 s between two taps (run 78). Move to Bottom is the
        // Appearance option since 3 Oct 2026 (done rows stay in place by default).
        app.terminate()
        app.launchArguments = ["-uitest", "-today.settlePause", "8", "-today.doneOrder", "bottom"]
        app.launch()
        let call = app.buttons["Mark Call family done"]
        XCTAssertTrue(call.waitForExistence(timeout: 5))
        let water = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Add ' AND label ENDSWITH ' to Water'")).firstMatch
        XCTAssertTrue(water.exists)
        XCTAssertLessThan(call.frame.minY, water.frame.minY, "Call family starts above Water")
        call.tap()
        water.tap()
        let done = app.buttons["Undo Call family"]
        XCTAssertTrue(done.waitForExistence(timeout: 2))
        XCTAssertLessThan(done.frame.minY, water.frame.minY, "Still in place right after the taps")
        shot("t01-held")
        // Then, after the pause and a 0.45 s settle, below.
        let sunk = NSPredicate { _, _ in done.frame.minY > water.frame.minY }
        expectation(for: sunk, evaluatedWith: nil)
        waitForExpectations(timeout: 15)
        shot("t02-settled")
        done.tap()
    }

    /// Done habits stay where the person put them, the default since 3 Oct 2026 (the user; Rulebook U13): a done row
    /// keeps its place after the pause too.
    func testDoneRowStaysInPlace() {
        app.terminate()
        app.launchArguments = ["-uitest"]
        app.launch()
        let call = app.buttons["Mark Call family done"]
        XCTAssertTrue(call.waitForExistence(timeout: 5))
        let water = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Add ' AND label ENDSWITH ' to Water'")).firstMatch
        call.tap()
        water.tap()
        let done = app.buttons["Undo Call family"]
        XCTAssertTrue(done.waitForExistence(timeout: 2))
        Thread.sleep(forTimeInterval: 3)
        XCTAssertLessThan(done.frame.minY, water.frame.minY, "Stays above Water")
    }

    /// Folding (#59): a part folds and opens from its header; its rows go and come back, and "N left" stays.
    func testFoldAndOpen() {
        let water = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Add ' AND label ENDSWITH ' to Water'")).firstMatch
        XCTAssertTrue(water.waitForExistence(timeout: 5))
        let fold = app.buttons["Fold Anytime"]
        XCTAssertTrue(fold.exists)
        fold.tap()
        XCTAssertTrue(water.waitForNonExistence(timeout: 3), "Folded: the rows go")
        XCTAssertTrue(app.buttons["Open Anytime"].exists)
        shot("f01-folded")
        app.buttons["Open Anytime"].tap()
        XCTAssertTrue(water.waitForExistence(timeout: 3), "Open: the rows come back")
    }

    /// ≡ → Day and Week and ≡ → Appearance (#61): every choice is there and takes effect.
    func testDayWeekAndAppearance() {
        openFromMenu("dayAndWeek", title: "Day and Week")
        let dayStart = app.buttons["day-start-picker"]
        XCTAssertTrue(dayStart.waitForExistence(timeout: 3))
        XCTAssertTrue(dayStart.label.contains("Midnight"), "Midnight by default: \(dayStart.label)")
        dayStart.tap()
        let three = app.buttons.matching(NSPredicate(format: "label BEGINSWITH '3:00' OR label BEGINSWITH '03:00'")).firstMatch
        XCTAssertTrue(three.waitForExistence(timeout: 3))
        three.tap()
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label CONTAINS 'counts for the day before'")).firstMatch.waitForExistence(timeout: 3))
        let weekStart = app.buttons["week-start-picker"]
        XCTAssertTrue(weekStart.label.contains("Automatic"), "Automatic by default: \(weekStart.label)")
        weekStart.tap()
        let monday = app.buttons["Monday"]
        XCTAssertTrue(monday.waitForExistence(timeout: 3))
        monday.tap()
        XCTAssertTrue(app.buttons["week-start-picker"].label.contains("Monday"))
        shot("s01-day-and-week")
        back()

        openFromMenu("appearance", title: "Appearance")
        for name in ["Automatic", "Light", "Dark"] {
            XCTAssertTrue(app.buttons[name].waitForExistence(timeout: 3), name)
        }
        for id in ["appearance-haptics", "appearance-sound"] {
            XCTAssertTrue(app.switches[id].exists, id)
        }
        XCTAssertEqual(app.switches["appearance-haptics"].value as? String, "1", "Haptics on by default")
        XCTAssertEqual(app.switches["appearance-sound"].value as? String, "0", "Sound off by default")
        app.buttons["Dark"].tap()
        shot("s02-appearance-dark")
        // Put it back: this phone keeps the choice for the next test.
        app.buttons["Automatic"].tap()
        back()
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 3), "Back on Today")
    }

    /// The day-and-week golden cases (daylight saving in New York, week starts, saving): `SettingsCheck`.
    func testSettingsChecks() {
        app.terminate()
        app.launchArguments = ["-settingscheck"]
        app.launch()
        let passed = app.staticTexts["Settings: all checks passed"]
        if !passed.waitForExistence(timeout: 30) {
            XCTFail(app.staticTexts.firstMatch.label)
        }
    }
}
