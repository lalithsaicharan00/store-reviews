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

    /// A habit's card opens its own page on Progress (3 Oct 2026: History · Notes · Progress); the other tabs are there.
    func testRowOpensHabitPageAtProgress() {
        launch()
        openProgress()
        let row = app.buttons["progress-row-Read"]
        XCTAssertTrue(row.waitForExistence(timeout: 5))
        row.tap()
        XCTAssertTrue(app.navigationBars["Read"].waitForExistence(timeout: 5), "The habit page opens")
        let tabs = app.segmentedControls["habit-tabs"]
        XCTAssertTrue(tabs.waitForExistence(timeout: 5), "History · Notes · Progress")
        XCTAssertTrue(tabs.buttons["Progress"].isSelected, "Opened from Progress, on Progress")
        XCTAssertTrue(app.descendants(matching: .any)["habit-progress-record"].waitForExistence(timeout: 5), "Overall record")
        shot("p04-habit-progress")
        tabs.buttons["History"].tap()
        XCTAssertTrue(app.buttons["history-add-entry"].waitForExistence(timeout: 5), "History")
        tabs.buttons["Notes"].tap()
        XCTAssertTrue(app.buttons["notes-add"].waitForExistence(timeout: 5), "Notes")
        back()
        XCTAssertTrue(app.navigationBars["Progress"].waitForExistence(timeout: 3), "Back on Progress")
    }

    /// Show Percentages off hides the habit page's percentages; on brings them back. Progress's cards state counts and
    /// have no percentages (Week, Month and Year, 2 Oct 2026), so the check opens a check-off habit from its card.
    func testHidePercentages() {
        launch()
        openProgress()
        XCTAssertTrue(app.segmentedControls["progress-range"].waitForExistence(timeout: 10), "Week | Month | Year")
        let percent = app.descendants(matching: .any).matching(NSPredicate(format: "label CONTAINS ' percent'"))
        func openFloss() {
            let card = app.buttons["progress-row-Floss"]
            for _ in 0..<12 where !(card.exists && card.isHittable) { app.swipeUp(velocity: .slow) }
            XCTAssertTrue(card.exists && card.isHittable, "Floss's card")
            card.tap()
            XCTAssertTrue(app.navigationBars["Floss"].waitForExistence(timeout: 5), "The habit page")
            XCTAssertTrue(app.descendants(matching: .any)["habit-progress-record"].waitForExistence(timeout: 5), "On Progress")
        }
        func toggle() {
            app.buttons["progress-options"].tap()
            let item = app.descendants(matching: .any).matching(NSPredicate(format: "label == 'Show Percentages'")).firstMatch
            XCTAssertTrue(item.waitForExistence(timeout: 3))
            item.tap()
        }
        openFloss()
        XCTAssertTrue(percent.firstMatch.waitForExistence(timeout: 5), "Percentages show by default")
        back()
        XCTAssertTrue(app.navigationBars["Progress"].waitForExistence(timeout: 5))
        toggle()
        openFloss()
        XCTAssertTrue(app.descendants(matching: .any)["habit-progress-record"].waitForExistence(timeout: 5))
        XCTAssertFalse(percent.firstMatch.exists, "Every percentage is hidden")
        shot("p05-no-percentages")
        back()
        XCTAssertTrue(app.navigationBars["Progress"].waitForExistence(timeout: 5))
        toggle()
        openFloss()
        XCTAssertTrue(percent.firstMatch.waitForExistence(timeout: 5), "They come back")
    }

    // MARK: Phase 2

    /// Year: a card per habit with its year as a heat map (the user, 2 Oct 2026); the year's number on top, "This
    /// year" under it. Tapping a card opens the habit.
    func testYearAndMonthTap() {
        launch()
        openProgress()
        XCTAssertTrue(app.segmentedControls["progress-range"].waitForExistence(timeout: 10))
        segment("Year").tap()
        let period = app.staticTexts["progress-period"]
        let year = Calendar.current.component(.year, from: .now)
        XCTAssertTrue(app.staticTexts["progress-period-caption"].waitForExistence(timeout: 5))
        XCTAssertEqual(period.label, String(year))
        XCTAssertEqual(app.staticTexts["progress-period-caption"].label, "This year")
        XCTAssertTrue(app.buttons["progress-row-Read"].waitForExistence(timeout: 5), "A card per habit")
        shot("p06-year")
        app.buttons["progress-row-Read"].tap()
        XCTAssertTrue(app.navigationBars["Read"].waitForExistence(timeout: 5), "The habit page opens")
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

    /// A habit's page from Progress has its Milestones and Year in Pixels (3 Oct 2026).
    func testHabitPageYearAndMilestones() {
        launch()
        openProgress()
        app.buttons["progress-row-Read"].tap()
        XCTAssertTrue(app.navigationBars["Read"].waitForExistence(timeout: 5))
        let milestones = app.descendants(matching: .any)["habit-milestones"]
        for _ in 0..<6 where !(milestones.exists && milestones.isHittable) { app.swipeUp(velocity: .slow) }
        XCTAssertTrue(milestones.exists, "Milestones")
        let grid = app.descendants(matching: .any)["habit-year-grid"]
        for _ in 0..<10 where !(grid.exists && grid.isHittable) { app.swipeUp(velocity: .slow) }
        XCTAssertTrue(grid.exists, "Year in Pixels")
        shot("p08-habit-year")
    }

    /// With no habits, the empty state.
    func testEmptyState() {
        launch(["-empty"])
        openProgress()
        XCTAssertTrue(app.staticTexts["No Progress Yet"].waitForExistence(timeout: 3))
    }
}
