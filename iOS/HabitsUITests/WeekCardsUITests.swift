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

    override func tearDown() {
        XCUIDevice.shared.appearance = .light
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

    /// Top, then a screen at a time down to the end; then back to the top.
    private func walk(_ prefix: String) {
        shot("\(prefix)-1-top")
        for i in 2...7 {
            app.swipeUp(velocity: .slow)
            sleep(1)
            shot("\(prefix)-\(i)-scrolled")
        }
        for _ in 0..<8 { app.swipeDown(velocity: .fast) }
        sleep(1)
    }

    func testWeekCardsLightAndDark() {
        openWeek()
        XCTAssertTrue(app.buttons["progress-row-Read"].exists, "A card per habit")
        XCUIDevice.shared.appearance = .light
        sleep(1)
        walk("w-light")
        XCUIDevice.shared.appearance = .dark
        sleep(1)
        walk("w-dark")
        // Last week: the caption says so, and nothing is "so far".
        XCUIDevice.shared.appearance = .light
        app.buttons["progress-previous"].tap()
        sleep(1)
        shot("w-last-week")
    }

    func testWeekCardsWithGroups() {
        openWeek(["-groups-demo"])
        XCUIDevice.shared.appearance = .light
        sleep(1)
        shot("wg-1-top-groups")
        app.swipeUp(velocity: .slow)
        sleep(1)
        shot("wg-2-scrolled")
    }
}
