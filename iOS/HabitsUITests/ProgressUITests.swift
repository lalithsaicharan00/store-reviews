import XCTest

/// Progress (Build Plan #60; report "Progress and Statistics — What People Want", 29 Sep 2026): opened from Today's
/// top bar; the overall share with its numbers, Week / Month / Year, every habit, and a habit's own statistics on its
/// page. Demo data: Water, done on each of the last 22 days.
final class ProgressUITests: XCTestCase {
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

    func testProgressFromToday() {
        app.buttons["Progress"].tap()
        XCTAssertTrue(app.navigationBars["Progress"].waitForExistence(timeout: 3), "One tap from Today")
        let summary = app.descendants(matching: .any)["progress-summary"]
        XCTAssertTrue(summary.waitForExistence(timeout: 3))
        XCTAssertTrue(summary.label.contains("%") && summary.label.contains("planned"), "A share with its numbers: \(summary.label)")
        XCTAssertTrue(app.staticTexts["This week"].exists)
        shot("progress-week")

        app.buttons["Previous week"].tap()
        XCTAssertTrue(app.staticTexts["Last week"].waitForExistence(timeout: 3), "‹ steps back a week")
        app.buttons["Next week"].tap()
        XCTAssertTrue(app.staticTexts["This week"].waitForExistence(timeout: 3))

        app.segmentedControls.buttons["Month"].tap()
        XCTAssertTrue(app.staticTexts["This month"].waitForExistence(timeout: 3))
        app.segmentedControls.buttons["Year"].tap()
        XCTAssertTrue(app.staticTexts["This year"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.staticTexts["Every day"].exists, "Year shows a grid of every day")
        shot("progress-year")

        // Every habit side by side; one opens its page with its own numbers.
        let water = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Water'")).firstMatch
        XCTAssertTrue(app.reveal(water))
        water.tap()
        XCTAssertTrue(app.navigationBars["Water"].waitForExistence(timeout: 3))
        let rates = app.descendants(matching: .any)["habit-rates"]
        XCTAssertTrue(app.reveal(rates), "The habit's page shows This month, All time and its total")
        XCTAssertTrue(app.staticTexts["Last 30 days"].exists || app.reveal(app.staticTexts["Last 30 days"]), "An amount habit has its chart")
        shot("habit-stats")
    }
}
