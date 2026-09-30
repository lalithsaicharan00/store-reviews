import XCTest

/// Runs on GitHub's Mac. History opens safely, corrections affect one entry, and Undo stays visible.
final class UndoUITests: XCTestCase {
    private var app: XCUIApplication!
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-uitest", "-focus-fixture"]
        app.launch()
        XCTAssertTrue(app.buttons["All habits"].waitForExistence(timeout: 10))
    }
    override func record(_ issue: XCTIssue) {
        var issue = issue
        let shot = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        shot.name = name
        shot.lifetime = .keepAlways
        issue.add(shot)
        super.record(issue)
    }
    private func daySheet(_ name: String) {
        app.buttons["All habits"].tap()
        app.revealAndTap(app.staticTexts[name])
        let today = app.buttons["habit-today-progress"]
        XCTAssertTrue(today.waitForExistence(timeout: 5))
        today.tap()
        XCTAssertTrue(app.staticTexts["day-result"].waitForExistence(timeout: 5))
    }
    private var entries: XCUIElementQuery { app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'entry-'")) }

    func testEditAndDeleteOneEntryInDaySheet() {
        daySheet("Drink water")
        XCTAssertTrue(app.staticTexts["1/2 glasses"].exists)
        XCTAssertEqual(entries.count, 1)
        entries.firstMatch.tap()
        XCTAssertTrue(app.navigationBars["Edit Entry"].waitForExistence(timeout: 3))
        let field = app.textFields["entry-amount"]
        field.tap()
        field.typeText("3") // existing number is selected by the app's native number-field behaviour
        app.navigationBars["Edit Entry"].buttons["Save"].tap()
        XCTAssertTrue(app.staticTexts["3/2 glasses"].waitForExistence(timeout: 3))
        XCTAssertEqual(entries.count, 1, "Editing replaces the entry rather than adding another")
        entries.firstMatch.tap()
        app.revealAndTap(app.buttons["Delete Entry"])
        XCTAssertTrue(app.staticTexts["No entries yet"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.staticTexts["0/2 glasses"].exists)
    }

    func testLogSheetSharesEntryEditingAndStillAdds() {
        daySheet("Drink water")
        app.buttons["day-add-entry"].tap()
        XCTAssertTrue(app.navigationBars["Log Amount"].waitForExistence(timeout: 3))
        XCTAssertEqual(entries.count, 1)
        entries.firstMatch.tap()
        XCTAssertTrue(app.navigationBars["Edit Entry"].waitForExistence(timeout: 3))
        app.buttons["Delete Entry"].tap()
        XCTAssertTrue(app.staticTexts["No entries yet"].waitForExistence(timeout: 3))
        let field = app.textFields["log-amount"]
        field.tap(); field.typeText("2")
        app.navigationBars["Log Amount"].buttons["Log"].tap()
        XCTAssertTrue(app.staticTexts["2/2 glasses"].waitForExistence(timeout: 3))
        XCTAssertEqual(entries.count, 1)
    }

    func testInlineUndoSurvivesAndIsExact() {
        let add = app.buttons["Add 1 glass to Drink water"]
        app.revealAndTap(add)
        let undo = app.buttons["habit-inline-undo"].firstMatch
        XCTAssertTrue(undo.waitForExistence(timeout: 3))
        sleep(6) // deliberately longer than the player's transient message
        XCTAssertTrue(undo.exists, "Undo has no timer")
        undo.tap()
        daySheet("Drink water")
        XCTAssertTrue(app.staticTexts["1/2 glasses"].exists, "Only the new log was removed")
        XCTAssertEqual(entries.count, 1)
    }

    func testDayControlsAndCalendarOpeningAreExplicit() {
        app.buttons["All habits"].tap()
        app.revealAndTap(app.staticTexts["Stretch"])
        let today = app.buttons["habit-today-progress"]
        XCTAssertTrue(today.waitForExistence(timeout: 3))
        let calendarDay = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'habit-day-' AND enabled == YES")).firstMatch
        XCTAssertTrue(calendarDay.exists)
        calendarDay.tap()
        XCTAssertTrue(app.staticTexts["day-result"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.staticTexts["No entries yet"].exists, "Opening a calendar day never logs")
        app.switches["day-done"].tap()
        XCTAssertTrue(app.staticTexts["3/3"].waitForExistence(timeout: 3))
        app.switches["day-done"].tap()
        XCTAssertTrue(app.staticTexts["No entries yet"].waitForExistence(timeout: 3))
        let skip = app.buttons.matching(NSPredicate(format: "label IN {'Skip today','Skip this day'}")).firstMatch
        app.revealAndTap(skip)
        XCTAssertTrue(app.buttons["Undo skip"].waitForExistence(timeout: 3))
        app.buttons["Undo skip"].tap()
        XCTAssertTrue(app.staticTexts["0/3"].waitForExistence(timeout: 3))
    }
}
