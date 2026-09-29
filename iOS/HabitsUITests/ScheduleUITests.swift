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
        row("Build or maintain,").tap()
        row("Check it off,").tap()
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

    /// Every few days, weeks (days optional) or months, each read back in the pinned sentence.
    func testEveryFewDaysAndWeeks() {
        create(name: "Jog")
        app.revealAndTap(app.buttons["often-everyDays"])
        XCTAssertEqual(summary, "Jog every other day, anytime")
        app.buttons["often-every-count-Increment"].tap()
        XCTAssertEqual(summary, "Jog every 3 days, anytime")
        shot("often-every-3-days")
        app.revealAndTap(app.buttons["often-everyWeeks"])
        XCTAssertEqual(summary, "Jog every other week, anytime", "No days needed")
        let days = app.switches["often-weeks-days"]
        XCTAssertEqual(days.value as? String, "0", "Set days are off until wanted")
        days.switches.firstMatch.tap()
        let today = Calendar.current.standaloneWeekdaySymbols[Calendar.current.component(.weekday, from: .now) - 1]
        XCTAssertEqual(summary, "Jog every other week on \(today), anytime")
        shot("often-every-weeks")
        app.revealAndTap(app.buttons["often-everyMonths"])
        XCTAssertTrue(summary.contains("every 3 months"), summary)
        back()
        XCTAssertTrue(sentence.hasPrefix("Jog "), sentence)
    }

    func testMonthDatesAndShortMonths() {
        create(name: "Pay rent")
        app.revealAndTap(app.buttons["often-date"])
        let day = app.buttons["Day 31"]
        app.reveal(day)
        day.tap()
        let policy = row("Shorter months")
        app.reveal(policy)
        XCTAssertTrue(policy.exists, "A date over the 28th asks what shorter months do")
        let note = app.staticTexts["Months without that date use their last day."]
        app.reveal(note)
        XCTAssertTrue(note.exists)
        app.swipeDown(); shot("often-month-dates-policy")
    }

    func testYearlyDateAndLeapDay() {
        create(name: "Anniversary")
        app.revealAndTap(app.buttons["often-date"])
        app.revealAndTap(app.buttons["Year"])
        app.revealAndTap(row("Month,")); app.buttons["February"].firstMatch.tap()
        app.revealAndTap(row("Date,"))
        let date = app.buttons["29th"].firstMatch
        app.reveal(date); date.tap()
        XCTAssertEqual(summary, "Anniversary every year on February 29, anytime")
        let leap = row("Years without 29 February")
        app.reveal(leap)
        XCTAssertTrue(leap.exists)
        leap.tap(); app.buttons["Skip that year"].firstMatch.tap()
        app.swipeDown(); shot("often-yearly-leap-policy")
        back()
        XCTAssertEqual(sentence, "Anniversary every year on February 29, anytime")
    }

    /// A task's How often is the habit screen without counts, plus After it's done.
    func testTaskAfterCompletion() {
        app.launch()
        app.navigationBars.buttons["New Habit"].tap(); row("Add a task").tap()
        let name = app.descendants(matching: .any)["name-field"]
        name.tap(); name.typeText("Replace filter\n")
        XCTAssertEqual(sentence, "Replace filter today")
        row("Repeat,").tap(); app.buttons["On a schedule"].firstMatch.tap()
        row("How often").tap()
        XCTAssertFalse(app.buttons["often-timesADay"].exists, "No counts for a task")
        XCTAssertFalse(app.buttons["often-times"].exists, "No counts for a task")
        let after = app.buttons["often-afterDone"]
        app.reveal(after)
        after.tap()
        XCTAssertEqual(summary, "Replace filter 1 week after it's done, anytime")
        shot("task-after-completion")
        back(); XCTAssertTrue(row("How often, 1 week after it's done").exists)
    }

    func testLargeTextHowOften() {
        app.launchArguments += ["-UIPreferredContentSizeCategoryName", "UICTContentSizeCategoryAccessibilityXXXL"]
        create()
        let certain = app.buttons["often-weekdays"]
        app.reveal(certain)
        certain.tap()
        let monday = app.buttons["Monday"]
        app.reveal(monday)
        XCTAssertTrue(monday.isHittable)
        XCTAssertGreaterThanOrEqual(monday.frame.height, 44)
        shot("often-accessibility-text-weekdays")
    }
}
