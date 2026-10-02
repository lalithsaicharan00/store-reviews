import XCTest

/// Progress (Build Plan #60), opened from the ≡ menu: the golden cases, and the screen itself (report §25.3).
final class ProgressUITests: XCTestCase {
    private var app: XCUIApplication!

    override func record(_ issue: XCTIssue) {
        let shot = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        shot.name = "FAIL-\(name)"
        shot.lifetime = .keepAlways
        var issue = issue
        issue.add(shot)
        super.record(issue)
    }

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
    }

    private func launch(_ arguments: [String] = []) {
        app.launchArguments = ["-uitest"] + arguments
        app.launch()
    }

    private func shot(_ name: String) {
        let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    /// ≡ → Progress.
    private func openProgress() {
        let menu = app.buttons["menu-button"]
        XCTAssertTrue(menu.waitForExistence(timeout: 10))
        menu.tap()
        let row = app.buttons["menu-progress"]
        XCTAssertTrue(row.waitForExistence(timeout: 3))
        row.tap()
        XCTAssertTrue(app.navigationBars["Progress"].waitForExistence(timeout: 5), "Progress opens from the menu")
    }

    private func back() {
        let bar = app.navigationBars.firstMatch
        for name in ["BackButton", "Back", "Today", "Progress"] where bar.buttons[name].exists {
            bar.buttons[name].tap()
            return
        }
        app.coordinate(withNormalizedOffset: CGVector(dx: 0.01, dy: 0.5))
            .press(forDuration: 0.05, thenDragTo: app.coordinate(withNormalizedOffset: CGVector(dx: 0.9, dy: 0.5)))
    }

    private func segment(_ title: String) -> XCUIElement {
        let control = app.segmentedControls["progress-range"]
        return control.exists ? control.buttons[title] : app.segmentedControls.firstMatch.buttons[title]
    }

    /// G1–G17 and the fixes behind them (#60a–#60c), run in the app with a fixed now.
    func testProgressChecks() {
        launch(["-progresscheck"])
        let result = app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH 'Progress'")).firstMatch
        XCTAssertTrue(result.waitForExistence(timeout: 90))
        XCTAssertEqual(result.label, "Progress: all checks passed")
    }

    /// The menu's Progress row opens it; Week and Month switch; ‹ › move; Back returns to Today.
    /// Week (2 Oct 2026): the dates with "This week" under them, a card per habit, no overview.
    func testOpenSwitchAndBack() {
        launch()
        openProgress()
        let period = app.staticTexts["progress-period"]
        XCTAssertTrue(period.waitForExistence(timeout: 5))
        XCTAssertTrue(period.label.contains("–"), "Week title is the dates: \(period.label)")
        XCTAssertEqual(app.staticTexts["progress-period-caption"].label, "This week")
        XCTAssertFalse(app.buttons["progress-next"].isEnabled, "No future weeks")
        XCTAssertFalse(app.descendants(matching: .any)["progress-tile-done"].exists, "No overview on Week")
        XCTAssertTrue(app.buttons["progress-row-Read"].exists, "A card per habit")
        shot("p01-week")

        segment("Month").tap()
        // Month (2 Oct 2026): the month's name, "This month" under it, and a card per habit.
        XCTAssertTrue(app.staticTexts["progress-period-caption"].waitForExistence(timeout: 3))
        XCTAssertEqual(app.staticTexts["progress-period-caption"].label, "This month")
        XCTAssertTrue(app.buttons["progress-row-Read"].exists, "A card per habit on Month")
        shot("p02-month")
        let month = period.label
        app.buttons["progress-previous"].tap()
        XCTAssertNotEqual(period.label, month, "‹ goes to the month before")
        XCTAssertTrue(app.buttons["progress-next"].isEnabled)
        app.buttons["progress-next"].tap()
        XCTAssertEqual(period.label, month)
        segment("Week").tap()
        XCTAssertTrue(app.staticTexts["progress-period-caption"].waitForExistence(timeout: 3))
        XCTAssertEqual(app.staticTexts["progress-period-caption"].label, "This week")

        back()
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 3), "Back on Today")
    }

    /// ‹ stops at the period holding the earliest habit's first day.
    func testPreviousStopsAtFirstPeriod() {
        launch()
        openProgress()
        segment("Month").tap()
        let previous = app.buttons["progress-previous"]
        for _ in 0..<12 where previous.isEnabled { previous.tap() }
        XCTAssertFalse(previous.isEnabled, "‹ is disabled at the first month")
        XCTAssertTrue(app.staticTexts["progress-period"].exists)
    }

    // The Day sheet test (a day ring opened it) was retired on 2 Oct 2026: Week and Month no longer have day rings
    // (the user removed them), so nothing on Progress opens the Day sheet. Today's calendar opens any day instead.

    /// A habit's row opens its own page at Over Time.
    func testRowOpensHabitPageAtOverTime() {
        launch()
        openProgress()
        let row = app.buttons["progress-row-Read"]
        XCTAssertTrue(row.waitForExistence(timeout: 5))
        row.tap()
        XCTAssertTrue(app.navigationBars["Read"].waitForExistence(timeout: 5), "The habit page opens")
        XCTAssertTrue(app.segmentedControls["over-time-range"].waitForExistence(timeout: 5), "At Over Time")
        XCTAssertTrue(app.staticTexts["over-time-period"].exists)
        shot("p04-over-time")
        for title in ["Year", "All", "Month"] {
            app.segmentedControls["over-time-range"].buttons[title].tap()
            XCTAssertTrue(app.staticTexts["over-time-period"].exists, title)
        }
        back()
        XCTAssertTrue(app.navigationBars["Progress"].waitForExistence(timeout: 3), "Back on Progress")
    }

    /// Show Percentages off hides every percentage on Progress; on brings them back.
    func testHidePercentages() {
        launch()
        openProgress()
        // Week and Month have no percentages (2 Oct 2026): their cards state counts. Year still has them. Wait for the
        // tabs first: a tap before they appear was lost and the test stayed on Week (run 37010612231).
        XCTAssertTrue(app.segmentedControls["progress-range"].waitForExistence(timeout: 10), "Week | Month | Year")
        segment("Year").tap()
        XCTAssertTrue(app.descendants(matching: .any)["progress-tile-done"].waitForExistence(timeout: 10), "Year's overview")
        let percent = app.descendants(matching: .any).matching(NSPredicate(format: "label CONTAINS ' percent'"))
        XCTAssertTrue(percent.firstMatch.waitForExistence(timeout: 5), "Percentages show by default")
        func toggle() {
            app.buttons["progress-options"].tap()
            let item = app.descendants(matching: .any).matching(NSPredicate(format: "label == 'Show Percentages'")).firstMatch
            XCTAssertTrue(item.waitForExistence(timeout: 3))
            item.tap()
        }
        toggle()
        XCTAssertTrue(percent.firstMatch.waitForNonExistence(timeout: 3), "Every percentage is hidden")
        shot("p05-no-percentages")
        toggle()
        XCTAssertTrue(percent.firstMatch.waitForExistence(timeout: 3), "They come back")
    }

    // MARK: Phase 2

    /// Year shows the grid of days; tapping a month opens it in Month (report §7.2).
    func testYearAndMonthTap() {
        launch()
        openProgress()
        segment("Year").tap()
        let period = app.staticTexts["progress-period"]
        XCTAssertEqual(period.label, String(Calendar.current.component(.year, from: .now)))
        XCTAssertTrue(app.descendants(matching: .any)["progress-year-grid"].waitForExistence(timeout: 5))
        shot("p06-year")
        let month = Calendar.current.component(.month, from: .now)
        let column = app.buttons["year-month-\(month)"]
        XCTAssertTrue(column.exists)
        column.tap()
        XCTAssertTrue(app.segmentedControls["progress-range"].buttons["Month"].isSelected, "The month opens in Month")
        // Month's title is the month's name; the year shows only for another year (2 Oct 2026).
        XCTAssertTrue(app.staticTexts["progress-period-caption"].waitForExistence(timeout: 3))
        XCTAssertEqual(app.staticTexts["progress-period-caption"].label, "This month", period.label)
    }

    /// A quit habit: Log a Slip… saves a slip with its own time, and Undo takes it back (Build Plan #60d).
    func testLogSlipAndUndo() {
        launch()
        openProgress()
        // Week is a scroll view of cards (no list for `reveal` to scroll): swipe to the quit card, near the end.
        let quit = app.buttons["progress-quit-Smoking"]
        for _ in 0..<10 where !(quit.exists && quit.isHittable) { app.swipeUp(velocity: .slow) }
        XCTAssertTrue(quit.exists && quit.isHittable, "The quit card")
        quit.tap()
        XCTAssertTrue(app.navigationBars["Smoking"].waitForExistence(timeout: 5))
        let log = app.buttons["habit-log-slip"]
        XCTAssertTrue(app.reveal(log), "Log a Slip… on the habit page")
        let before = app.staticTexts["quit-total-line"].label
        log.tap()
        XCTAssertTrue(app.navigationBars["Log a Slip"].waitForExistence(timeout: 3))
        shot("p07-log-slip")
        app.buttons["slip-save"].tap()
        let undo = app.buttons["slip-undo"]
        XCTAssertTrue(undo.waitForExistence(timeout: 3), "Undo right after")
        XCTAssertNotEqual(app.staticTexts["quit-total-line"].label, before, "The slip is counted")
        undo.tap()
        XCTAssertTrue(undo.waitForNonExistence(timeout: 3))
        XCTAssertEqual(app.staticTexts["quit-total-line"].label, before, "Undo takes it back")
    }

    /// A habit's page from Progress has its Year grid and Runs (report §8.4, §8.5).
    func testHabitPageYearAndRuns() {
        launch()
        openProgress()
        app.buttons["progress-row-Read"].tap()
        XCTAssertTrue(app.navigationBars["Read"].waitForExistence(timeout: 5))
        let grid = app.descendants(matching: .any)["habit-year-grid"]
        XCTAssertTrue(app.reveal(grid), "The Year grid")
        shot("p08-habit-year")
        let runs = app.descendants(matching: .any)["habit-runs"]
        XCTAssertTrue(app.reveal(runs), "Runs")
    }

    /// With no habits, the empty state.
    func testEmptyState() {
        launch(["-empty"])
        openProgress()
        XCTAssertTrue(app.staticTexts["No Progress Yet"].waitForExistence(timeout: 3))
    }
}
