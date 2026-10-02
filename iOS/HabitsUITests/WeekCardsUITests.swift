import XCTest

/// Pictures of Progress's Week view (habit cards, 2 Oct 2026), light and dark, top to bottom, for the user to see the
/// design. Checks only that the page opens on Week with its dates and cards; the pictures are the point.
final class WeekCardsUITests: XCTestCase {
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
        continueAfterFailure = true
        app = XCUIApplication()
    }

    private func shot(_ name: String) {
        let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    /// ≡ → Progress, on Week.
    private func openWeek(_ arguments: [String] = []) {
        app.launchArguments = ["-uitest"] + arguments
        app.launch()
        let menu = app.buttons["menu-button"]
        XCTAssertTrue(menu.waitForExistence(timeout: 10))
        menu.tap()
        let row = app.buttons["menu-progress"]
        XCTAssertTrue(row.waitForExistence(timeout: 3))
        row.tap()
        XCTAssertTrue(app.navigationBars["Progress"].waitForExistence(timeout: 5))
        let week = app.segmentedControls["progress-range"].buttons["Week"]
        if week.waitForExistence(timeout: 3), !week.isSelected { week.tap() }
        XCTAssertTrue(app.staticTexts["progress-period"].waitForExistence(timeout: 5), "The week's dates")
        sleep(1)
    }

    /// The key at the top, then a screen at a time down to the end; then back to the top.
    private func walk(_ prefix: String) {
        XCTAssertTrue(app.descendants(matching: .any)["progress-key"].waitForExistence(timeout: 3), "What the squares mean")
        shot("\(prefix)-1-top")
        for i in 2...8 {
            app.swipeUp(velocity: .slow)
            sleep(1)
            shot("\(prefix)-\(i)-scrolled")
        }
        for _ in 0..<8 { app.swipeDown(velocity: .fast) }
        sleep(1)
    }

    /// The app's own Appearance setting decides light or dark (a test before may have left it on Light), so each
    /// pass sets it at launch.
    func testWeekCardsLight() {
        openWeek(["-year-demo", "-appearance.theme", "light"])
        XCTAssertTrue(app.buttons["progress-row-Swim"].exists, "A card per habit")
        walk("w-light")
        // Last week: the caption says so, and nothing is "so far".
        app.buttons["progress-previous"].tap()
        sleep(1)
        shot("w-last-week")
    }

    func testWeekCardsDark() {
        openWeek(["-year-demo", "-appearance.theme", "dark"])
        walk("w-dark")
    }

    /// Month (2 Oct 2026): the same cards with a month of marks, light and dark.
    func testMonthCards() {
        openWeek(["-year-demo", "-appearance.theme", "light"])
        app.segmentedControls["progress-range"].buttons["Month"].tap()
        XCTAssertTrue(app.staticTexts["progress-period-caption"].waitForExistence(timeout: 5))
        XCTAssertEqual(app.staticTexts["progress-period-caption"].label, "This month")
        sleep(1)
        shot("m-light-1-top")
        for i in 2...6 {
            app.swipeUp(velocity: .slow)
            sleep(1)
            shot("m-light-\(i)-scrolled")
        }
    }

    func testMonthCardsDark() {
        openWeek(["-year-demo", "-appearance.theme", "dark"])
        app.segmentedControls["progress-range"].buttons["Month"].tap()
        XCTAssertTrue(app.staticTexts["progress-period-caption"].waitForExistence(timeout: 5))
        sleep(1)
        shot("m-dark-1-top")
        app.swipeUp(velocity: .slow)
        sleep(1)
        shot("m-dark-2-scrolled")
    }

    /// Year (2 Oct 2026): each habit's whole year as a heat map, sized to the card. The year demo has every habit type.
    func testYearCards() { year("y-light", theme: "light") }
    func testYearCardsDark() { year("y-dark", theme: "dark") }

    private func year(_ prefix: String, theme: String) {
        openWeek(["-year-demo", "-appearance.theme", theme])
        app.segmentedControls["progress-range"].buttons["Year"].tap()
        XCTAssertTrue(app.staticTexts["progress-period-caption"].waitForExistence(timeout: 5))
        XCTAssertEqual(app.staticTexts["progress-period-caption"].label, "This year")
        let swim = app.buttons["progress-row-Swim"]
        XCTAssertTrue(swim.waitForExistence(timeout: 5), "Swim's card")
        sleep(1)
        shot("\(prefix)-1-top")
        XCTAssertTrue(app.descendants(matching: .any)["progress-key"].exists, "What the squares mean")
        for i in 2...(theme == "light" ? 8 : 4) {
            app.swipeUp(velocity: .slow)
            sleep(1)
            shot("\(prefix)-\(i)-scrolled")
        }
        guard theme == "light" else { return }
        // Last year: every day drawn, December at the end.
        for _ in 0..<8 { app.swipeDown(velocity: .fast) }
        app.buttons["progress-previous"].tap()
        sleep(1)
        shot("\(prefix)-10-last-year")
    }

    func testWeekCardsWithGroups() {
        openWeek(["-groups-demo", "-appearance.theme", "light"])
        shot("wg-1-top-groups")
        app.swipeUp(velocity: .slow)
        sleep(1)
        shot("wg-2-scrolled")
    }
}
