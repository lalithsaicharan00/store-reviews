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
        // The key folds and opens again (left open for the tests after).
        let key = app.descendants(matching: .any)["progress-key"]
        let toggle = app.buttons["heat-key-toggle"]
        XCTAssertTrue(toggle.waitForExistence(timeout: 3), "The key's header")
        toggle.tap()
        XCTAssertTrue(key.waitForNonExistence(timeout: 3), "Folded")
        sleep(1)
        shot("w-key-folded")
        toggle.tap()
        XCTAssertTrue(key.waitForExistence(timeout: 3), "Open again")
        // Last week: the caption says so, and nothing is "so far".
        app.buttons["progress-previous"].tap()
        sleep(1)
        shot("w-last-week")
    }

    func testWeekCardsDark() {
        openWeek(["-year-demo", "-appearance.theme", "dark"])
        walk("w-dark")
    }

    /// Progress's key is one key for the whole app (Current Work 57, 6 Oct 2026): open until the person folds it; folded in
    /// Week, it's folded in Month and Year too and on the next visit, and a tap opens it again.
    func testSquaresKeyFoldedOnceIsFoldedEverywhere() {
        openWeek(["-year-demo"])
        let key = app.descendants(matching: .any)["progress-key"]
        let toggle = app.buttons["heat-key-toggle"]
        let ranges = app.segmentedControls["progress-range"]
        XCTAssertTrue(key.waitForExistence(timeout: 3), "Never folded: open")
        ranges.buttons["Month"].tap()
        XCTAssertTrue(key.waitForExistence(timeout: 3), "Month: still open")
        ranges.buttons["Week"].tap()
        toggle.tap()
        XCTAssertTrue(key.waitForNonExistence(timeout: 3), "Folded in Week")
        ranges.buttons["Month"].tap()
        XCTAssertTrue(toggle.waitForExistence(timeout: 3))
        XCTAssertFalse(key.exists, "Month: folded too, the same key")
        ranges.buttons["Year"].tap()
        XCTAssertTrue(toggle.waitForExistence(timeout: 3))
        XCTAssertFalse(key.exists, "Year: folded too")
        // Leave Progress and come back.
        let bar = app.navigationBars["Progress"]
        if bar.buttons["BackButton"].exists { bar.buttons["BackButton"].tap() } else { bar.buttons.element(boundBy: 0).tap() }
        sleep(1)
        let menu = app.buttons["menu-progress"]
        if !menu.waitForExistence(timeout: 3) { app.buttons["menu-button"].tap() }
        XCTAssertTrue(menu.waitForExistence(timeout: 3))
        menu.tap()
        XCTAssertTrue(toggle.waitForExistence(timeout: 5))
        XCTAssertFalse(key.exists, "The next visit: folded")
        shot("w-key-next-visit")
        toggle.tap()
        XCTAssertTrue(key.waitForExistence(timeout: 3), "A tap opens it")
        ranges.buttons["Month"].tap()
        XCTAssertTrue(key.waitForExistence(timeout: 3), "Opened by hand: open on the other ranges in this visit")
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

    /// Year scrolls sideways inside its card (older weeks to the left) and the card still opens the habit; the habit's
    /// page shows its month and its year in the same squares (the user, 3 Oct 2026).
    func testYearScrollAndHabitPage() {
        openWeek(["-year-demo", "-appearance.theme", "light"])
        app.segmentedControls["progress-range"].buttons["Year"].tap()
        let swim = app.buttons["progress-row-Swim"]
        XCTAssertTrue(swim.waitForExistence(timeout: 5), "Swim's card")
        sleep(1)
        swim.coordinate(withNormalizedOffset: CGVector(dx: 0.3, dy: 0.82))
            .press(forDuration: 0.05, thenDragTo: swim.coordinate(withNormalizedOffset: CGVector(dx: 0.98, dy: 0.82)))
        sleep(1)
        shot("ys-1-older-weeks")
        XCTAssertFalse(app.navigationBars["Swim"].exists, "Dragging the year doesn't open the habit")
        swim.tap()
        XCTAssertTrue(app.navigationBars["Swim"].waitForExistence(timeout: 5), "The card still opens the habit")
        sleep(1)
        shot("hp-1-top")
        // The page opens at Over Time; its month calendar is just above.
        let calendar = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'habit-day-'")).firstMatch
        for _ in 0..<4 where !(calendar.exists && calendar.isHittable) { app.swipeDown(velocity: .slow) }
        sleep(1)
        shot("hp-0-month")
        for i in 2...7 {
            app.swipeUp(velocity: .slow)
            sleep(1)
            shot("hp-\(i)-scrolled")
        }
    }

    func testHabitPageDark() {
        openWeek(["-year-demo", "-appearance.theme", "dark"])
        let swim = app.buttons["progress-row-Swim"]
        XCTAssertTrue(swim.waitForExistence(timeout: 5), "Swim's card")
        swim.tap()
        XCTAssertTrue(app.navigationBars["Swim"].waitForExistence(timeout: 5))
        let calendar = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'habit-day-'")).firstMatch
        for _ in 0..<4 where !(calendar.exists && calendar.isHittable) { app.swipeDown(velocity: .slow) }
        sleep(1)
        shot("hp-dark-0-month")
        for i in 1...5 {
            app.swipeUp(velocity: .slow)
            sleep(1)
            shot("hp-dark-\(i)")
        }
    }

    func testWeekCardsWithGroups() {
        openWeek(["-groups-demo", "-appearance.theme", "light"])
        shot("wg-1-top-groups")
        app.swipeUp(velocity: .slow)
        sleep(1)
        shot("wg-2-scrolled")
    }
}
