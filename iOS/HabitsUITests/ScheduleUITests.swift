import XCTest

/// How often's set days: every few days or weeks, dates of the month, a yearly date, and a task's
/// "after it's done". Rewritten 29 Sep 2026 for the Round 3 How often screen (the Schedule screen is gone).
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
    private func create(name: String = "Practice") {
        app.launch()
        app.navigationBars.buttons["New Habit"].tap()
        row("Build or maintain").tap()
        let field = app.descendants(matching: .any)["name-field"]
        XCTAssertTrue(field.waitForExistence(timeout: 3)); field.tap(); field.typeText(name + "\n")
        row("How often").tap()
        XCTAssertTrue(app.navigationBars["How Often"].waitForExistence(timeout: 3))
    }
    private var summary: String { app.descendants(matching: .any)["often-summary"].label }
    private var sentence: String { app.descendants(matching: .any)["habit-sentence"].label }
    func testCalendarAndPersistenceRules() {
        app.launchArguments += ["-schedulecheck"]
        app.launch()
        let result = app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH 'Placement'")).firstMatch
        XCTAssertTrue(result.waitForExistence(timeout: 30))
        XCTAssertEqual(result.label, "Placement: all checks passed")
    }

    func testEveryFewDaysAndWeeks() {
        create(name: "Jog")
        app.buttons["often-every"].tap()
        XCTAssertTrue(summary.hasPrefix("Every other day"), summary)
        app.buttons["often-every-count-Increment"].tap()
        XCTAssertTrue(summary.hasPrefix("Every 3 days"), summary)
        shot("often-every-3-days")
        app.buttons["Few weeks"].tap()
        let today = Calendar.current.standaloneWeekdaySymbols[Calendar.current.component(.weekday, from: .now) - 1]
        XCTAssertTrue(summary.hasPrefix("Every 3 weeks on \(today)") || summary.hasPrefix("Every other week on \(today)"), summary)
        shot("often-every-weeks")
        back()
        XCTAssertTrue(sentence.hasPrefix("Jog every"), sentence)
    }

    func testMonthDatesAndShortMonths() {
        create(name: "Pay rent")
        app.buttons["often-date"].tap()
        let day = app.buttons["Day 31"]
        for _ in 0..<4 where !day.isHittable { app.swipeUp() }
        day.tap()
        let policy = row("Shorter months")
        for _ in 0..<3 where !policy.isHittable { app.swipeUp() }
        XCTAssertTrue(policy.exists, "A date over the 28th asks what shorter months do")
        XCTAssertTrue(app.staticTexts["Months without that date use their last day."].exists)
        app.swipeDown(); shot("often-month-dates-policy")
    }

    func testYearlyDateAndLeapDay() {
        create(name: "Anniversary")
        app.buttons["often-date"].tap()
        app.buttons["Year"].tap()
        row("Month,").tap(); app.buttons["February"].firstMatch.tap()
        row("Date,").tap(); app.buttons["29th"].firstMatch.tap()
        XCTAssertTrue(summary.hasPrefix("Every year on February 29"), summary)
        let leap = row("Years without 29 February")
        for _ in 0..<3 where !leap.isHittable { app.swipeUp() }
        XCTAssertTrue(leap.exists)
        leap.tap(); app.buttons["Skip that year"].firstMatch.tap()
        app.swipeDown(); shot("often-yearly-leap-policy")
        back()
        XCTAssertEqual(sentence, "Anniversary every year on February 29")
    }

    func testTaskAfterCompletion() {
        app.launch()
        app.navigationBars.buttons["New Habit"].tap(); row("Add a task").tap()
        let name = app.descendants(matching: .any)["name-field"]
        name.tap(); name.typeText("Replace filter\n")
        row("Repeat,").tap(); app.buttons["On a schedule"].firstMatch.tap()
        row("How often, Every day").tap(); app.buttons["After completion"].firstMatch.tap()
        shot("task-after-completion")
        back(); XCTAssertTrue(row("How often, 1 week after it's done").exists)
    }

    func testLargeTextHowOften() {
        app.launchArguments += ["-UIPreferredContentSizeCategoryName", "UICTContentSizeCategoryAccessibilityXXXL"]
        create()
        let certain = app.buttons["often-weekdays"]
        for _ in 0..<6 where !certain.isHittable { app.swipeUp() }
        certain.tap()
        let monday = app.buttons["Monday"]
        for _ in 0..<5 where !monday.isHittable { app.swipeUp() }
        XCTAssertTrue(monday.isHittable)
        XCTAssertGreaterThanOrEqual(monday.frame.height, 44)
        shot("often-accessibility-text-weekdays")
    }
}
