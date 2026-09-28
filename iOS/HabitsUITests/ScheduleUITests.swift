import XCTest

final class ScheduleUITests: XCTestCase {
    private var app: XCUIApplication!
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-uitest", "-empty"]
    }
    override func record(_ issue: XCTIssue) {
        var issue = issue
        let image = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        image.name = "FAIL-\(name)"; image.lifetime = .keepAlways
        issue.add(image); super.record(issue)
    }
    private func shot(_ name: String) {
        let image = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        image.name = name; image.lifetime = .keepAlways; add(image)
    }
    private func row(_ text: String) -> XCUIElement {
        app.buttons.matching(NSPredicate(format: "label BEGINSWITH %@", text)).firstMatch
    }
    private func back() { app.navigationBars.buttons["BackButton"].firstMatch.tap() }
    private func create(_ type: String, name: String = "Practice") {
        app.launch()
        app.navigationBars.buttons["New Habit"].tap()
        row("Build or maintain").tap(); row(type).tap()
        let field = app.descendants(matching: .any)["name-field"]
        XCTAssertTrue(field.waitForExistence(timeout: 3)); field.tap(); field.typeText(name + "\n")
    }
    private func choosePeriod(_ label: String) {
        app.buttons["goal-period"].tap(); app.buttons[label].firstMatch.tap()
    }
    func testCalendarAndPersistenceRules() {
        app.launchArguments += ["-schedulecheck"]
        app.launch()
        let result = app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH 'Placement'")).firstMatch
        XCTAssertTrue(result.waitForExistence(timeout: 30))
        XCTAssertEqual(result.label, "Placement: all checks passed")
    }
    func testFlexibleTimeAndExplicitTransitions() {
        create("Time it")
        row("Schedule").tap(); app.buttons["A number of days"].firstMatch.tap()
        app.buttons["flexible-count-Increment"].tap()
        shot("schedule-flexible-four-days")
        back()
        XCTAssertTrue(row("Schedule, 4 days a week").exists)
        XCTAssertTrue(app.staticTexts["20 min on any 4 days a week."].exists)
        row("Goal").tap()
        choosePeriod("A week")
        XCTAssertTrue(app.alerts["Use Any Day?"].waitForExistence(timeout: 2))
        app.alerts.buttons["Cancel"].tap()
        XCTAssertTrue(app.descendants(matching: .any)["goal-summary"].label.contains("a day"))
        choosePeriod("A week"); app.alerts.buttons["Use Any Day"].tap()
        shot("goal-weekly-with-explanation")
        back(); XCTAssertTrue(row("Schedule, Any day this week").exists)
        row("Schedule").tap(); shot("schedule-any-day")
        app.buttons["Use set days instead…"].firstMatch.tap()
        app.alerts.buttons["Cancel"].tap()
        XCTAssertTrue(app.buttons["Use set days instead…"].firstMatch.exists)
        app.buttons["Use set days instead…"].firstMatch.tap(); app.alerts.buttons["Change Goal to A day"].tap()
        back(); XCTAssertTrue(row("Schedule, 4 days a week").exists)
        row("Goal").tap(); choosePeriod("A month"); app.alerts.buttons["Use Any Day"].tap()
        choosePeriod("A day"); app.alerts.buttons["Restore Schedule"].tap()
        back(); XCTAssertTrue(row("Schedule, 4 days a week").exists)
        app.navigationBars.buttons["Add"].tap()
        XCTAssertTrue(app.staticTexts["0 of 4 days this week"].waitForExistence(timeout: 4))
        shot("today-daily-time-and-weekly-days")
    }
    func testSpecificDaysIntervalAndMonthlyPolicy() {
        create("Check it off")
        row("Schedule").tap(); app.buttons["Specific days"].firstMatch.tap()
        app.buttons["Weekdays"].firstMatch.tap(); shot("schedule-weekdays")
        app.buttons["Sunday"].firstMatch.tap(); app.buttons["Saturday"].firstMatch.tap()
        XCTAssertTrue(app.descendants(matching: .any)["schedule-summary"].label.contains("Every day"))
        app.buttons["Every…"].firstMatch.tap()
        app.buttons["schedule-interval-unit"].tap(); app.buttons["Weeks"].firstMatch.tap()
        shot("schedule-every-two-weeks")
        app.buttons["schedule-interval-unit"].tap(); app.buttons["Months"].firstMatch.tap()
        let last = app.buttons["Day 31"]
        for _ in 0..<3 where !last.isHittable { app.swipeUp() }
        last.tap()
        let policy = row("Shorter months")
        for _ in 0..<3 where !policy.isHittable { app.swipeDown() }
        XCTAssertTrue(policy.exists)
        policy.tap(); app.buttons["Skip that month"].firstMatch.tap()
        app.swipeDown(); shot("schedule-month-dates-policy")
    }
    func testOnceAWeekCanonicalizesToOneDay() {
        create("Check it off", name: "Call family")
        row("Goal").tap(); choosePeriod("A week")
        XCTAssertTrue(app.alerts.buttons["Use 1 Day"].waitForExistence(timeout: 2))
        app.alerts.buttons["Use 1 Day"].tap(); back()
        XCTAssertTrue(row("Schedule, 1 day a week").exists)
        XCTAssertTrue(row("Goal, Once").exists)
        shot("form-once-a-week")
    }
    func testYearlyAndCompletionRelativeTaskControls() {
        create("Check it off", name: "Anniversary")
        row("Schedule").tap(); app.buttons["Every…"].firstMatch.tap()
        app.buttons["schedule-interval-unit"].tap(); app.buttons["Years"].firstMatch.tap()
        row("Month,").tap(); app.buttons["February"].firstMatch.tap()
        row("Date,").tap(); app.buttons["29th"].firstMatch.tap()
        let leap = row("Years without 29 Feb")
        for _ in 0..<3 where !leap.isHittable { app.swipeUp() }
        XCTAssertTrue(leap.exists)
        leap.tap(); app.buttons["Skip that year"].firstMatch.tap()
        app.swipeDown(); shot("schedule-yearly-leap-policy")
        app.terminate(); app.launch()
        app.navigationBars.buttons["New Habit"].tap(); row("Add a task").tap()
        let name = app.descendants(matching: .any)["name-field"]
        name.tap(); name.typeText("Replace filter\n")
        row("Repeat,").tap(); app.buttons["On a schedule"].firstMatch.tap()
        row("Schedule,").tap(); app.buttons["After completion"].firstMatch.tap()
        shot("task-after-completion")
        back(); XCTAssertTrue(row("Schedule, 1 week after completion").exists)
    }

    func testLargeTextSchedule() {
        app.launchArguments += ["-UIPreferredContentSizeCategoryName", "UICTContentSizeCategoryAccessibilityXXXL"]
        create("Check it off")
        row("Schedule").tap()
        let specific = app.buttons["Specific days"].firstMatch
        for _ in 0..<4 where !specific.isHittable { app.swipeUp() }
        specific.tap()
        let monday = app.buttons["Monday"]
        for _ in 0..<5 where !monday.isHittable { app.swipeUp() }
        XCTAssertTrue(monday.isHittable)
        XCTAssertGreaterThanOrEqual(monday.frame.height, 44)
        shot("schedule-accessibility-text-weekdays")
    }
}
