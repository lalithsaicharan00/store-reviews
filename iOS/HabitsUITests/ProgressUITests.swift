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
    func testOpenSwitchAndBack() {
        launch()
        openProgress()
        let period = app.staticTexts["progress-period"]
        XCTAssertTrue(period.waitForExistence(timeout: 5))
        XCTAssertEqual(period.label, "This week")
        XCTAssertFalse(app.buttons["progress-next"].isEnabled, "No future weeks")
        XCTAssertTrue(app.descendants(matching: .any)["progress-tile-done"].exists, "The overview's numbers")
        shot("p01-week")

        segment("Month").tap()
        XCTAssertTrue(period.label.contains(String(Calendar.current.component(.year, from: .now))), "Month title: \(period.label)")
        shot("p02-month")
        let month = period.label
        app.buttons["progress-previous"].tap()
        XCTAssertNotEqual(period.label, month, "‹ goes to the month before")
        XCTAssertTrue(app.buttons["progress-next"].isEnabled)
        app.buttons["progress-next"].tap()
        XCTAssertEqual(period.label, month)
        segment("Week").tap()
        XCTAssertEqual(period.label, "This week")

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

    /// A ring opens the Day sheet; "Show on Today" closes Progress and opens that day on Today.
    func testDaySheetShowsOnToday() {
        launch()
        openProgress()
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: .now)!
        let c = Calendar.current.dateComponents([.year, .month, .day], from: yesterday)
        var ring = app.buttons["progress-day-\(c.year!)-\(c.month!)-\(c.day!)"]
        if !ring.exists {
            // Yesterday was in last week: use the month instead.
            segment("Month").tap()
            if !app.buttons["progress-day-\(c.year!)-\(c.month!)-\(c.day!)"].exists { app.buttons["progress-previous"].tap() }
            ring = app.buttons["progress-day-\(c.year!)-\(c.month!)-\(c.day!)"]
        }
        XCTAssertTrue(ring.waitForExistence(timeout: 3))
        ring.tap()
        XCTAssertTrue(app.staticTexts["progress-day-summary"].waitForExistence(timeout: 3), "The Day sheet opens")
        shot("p03-day-sheet")
        app.buttons["progress-show-on-today"].tap()
        XCTAssertTrue(app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Yesterday,'")).firstMatch.waitForExistence(timeout: 5),
                      "Today opens on that day")
        XCTAssertFalse(app.navigationBars["Progress"].exists, "Progress closed")
    }

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

    /// With no habits, the empty state.
    func testEmptyState() {
        launch(["-empty"])
        openProgress()
        XCTAssertTrue(app.staticTexts["No Progress Yet"].waitForExistence(timeout: 3))
    }
}
