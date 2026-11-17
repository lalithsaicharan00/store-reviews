import XCTest

/// Arrange Your Day and the Filter's Hide switches (the user, 3 Oct 2026; checklist
/// `Docs/Checklists/Today — Arrange Your Day (item 5 build).md`).
final class ArrangeUITests: XCTestCase {
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
        XCTAssertTrue(app.buttons["arrange-button"].waitForExistence(timeout: 10))
    }

    private func shot(_ name: String) {
        let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    private func any(_ id: String) -> XCUIElement { app.descendants(matching: .any)[id].firstMatch }

    /// The split rules in every direction, the card moves, the sorts and new habits at the end: `ArrangeCheck`.
    func testArrangeChecks() {
        app.launchArguments = ["-arrangecheck"]
        app.launch()
        let passed = app.staticTexts["Arrange: all checks passed"]
        if !passed.waitForExistence(timeout: 30) { XCTFail(app.staticTexts.firstMatch.label) }
    }

    /// Today in normal mode: Edit and +, no Filter; each time of day says when it starts; nothing under the last card
    /// (no Note for the Day since 17 Nov 2026). Edit opens Arrange Your Day with every habit; Anytime moves to the bottom
    /// and stays there after Done.
    func testEditArrangesTheDay() {
        launch()
        XCTAssertTrue(app.buttons["arrange-button"].exists)
        XCTAssertFalse(app.buttons["filter-button"].exists, "No Filter on Today")
        XCTAssertTrue(app.buttons["New Habit"].exists)
        let morning = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Morning, Starts '")).firstMatch
        XCTAssertTrue(morning.waitForExistence(timeout: 3), "Morning says when it starts")
        XCTAssertFalse(app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Anytime, Starts'")).firstMatch.exists,
                       "Anytime has no start")
        XCTAssertFalse(app.buttons["Edit Times of Day"].exists, "Gone from the bottom of Today")
        app.reveal(app.buttons["add-day-note"])
        XCTAssertFalse(app.buttons["add-day-note"].exists, "No Note for the Day at the bottom")
        shot("a01-today")

        app.buttons["arrange-button"].tap()
        XCTAssertTrue(any("arrange-heading").waitForExistence(timeout: 3))
        XCTAssertTrue(app.buttons["arrange-done"].exists, "Done, alone in the top bar")
        XCTAssertFalse(app.buttons["arrange-button"].exists)
        XCTAssertFalse(app.buttons["menu-button"].exists)
        // Every habit, not only today's: Call family is three times a week, Floss is in the Evening.
        XCTAssertTrue(any("arrange-row-Call family").exists)
        app.reveal(any("arrange-row-Floss"))
        XCTAssertTrue(any("arrange-row-Floss").exists, "Evening's habits are listed too")
        shot("a02-arrange")

        // Anytime moves; a timed section's menu has no Move.
        let anytime = app.buttons["arrange-menu-Anytime"]
        app.reveal(anytime)
        anytime.tap()
        XCTAssertFalse(app.buttons["Rename"].exists, "Anytime can't be renamed")
        XCTAssertTrue(app.buttons["Move to Bottom"].waitForExistence(timeout: 2))
        shot("a03-anytime-menu")
        app.buttons["Move to Bottom"].tap()
        sleep(1)
        let anytimeAgain = app.buttons["arrange-menu-Anytime"]
        app.reveal(anytimeAgain)
        anytimeAgain.tap()
        XCTAssertTrue(app.buttons["Move to Top"].waitForExistence(timeout: 2))
        XCTAssertFalse(app.buttons["Move to Bottom"].exists, "Already at the bottom")
        app.buttons["Move to Top"].tap()
        sleep(1)
        let evening = app.buttons["arrange-menu-Evening"]
        app.reveal(evening)
        evening.tap()
        XCTAssertTrue(app.buttons["Rename"].waitForExistence(timeout: 2))
        XCTAssertTrue(app.buttons["Change Time"].exists)
        XCTAssertTrue(app.buttons["A to Z"].exists)
        XCTAssertFalse(app.buttons["Move Up"].exists, "Timed sections follow their times")
        shot("a04-evening-menu")
        app.buttons["Change Time"].tap()
        XCTAssertTrue(app.navigationBars["Edit Time of Day"].waitForExistence(timeout: 3))
        XCTAssertTrue(any("plan-row-Evening").exists, "Your day, as it will look")
        app.navigationBars["Edit Time of Day"].buttons["Cancel"].tap()

        app.buttons["arrange-done"].tap()
        XCTAssertTrue(app.buttons["arrange-button"].waitForExistence(timeout: 3), "Back to Today")
        shot("a05-today-after")
    }

    /// Add a time of day from Arrange Your Day: the form shows the whole day; if it overlaps others, it asks before
    /// splitting them, then the new one is listed.
    func testAddTimeOfDay() {
        launch()
        app.buttons["arrange-button"].tap()
        let add = app.buttons["arrange-add-section"]
        app.reveal(add)
        add.tap()
        XCTAssertTrue(app.navigationBars["New Time of Day"].waitForExistence(timeout: 3))
        let name = app.textFields["section-name-field"]
        XCTAssertTrue(name.waitForExistence(timeout: 3))
        name.typeText("Mid Morning")
        XCTAssertTrue(any("plan-row-Mid Morning").waitForExistence(timeout: 2), "The new one in Your day")
        shot("a06-new-time-of-day")
        app.navigationBars["New Time of Day"].buttons["section-save"].tap()
        let split = app.buttons["section-split-confirm"].firstMatch
        if split.waitForExistence(timeout: 2) {
            shot("a07-split-confirm")
            split.tap()
        }
        let menu = app.buttons["arrange-menu-Mid Morning"]
        app.reveal(menu)
        XCTAssertTrue(menu.waitForExistence(timeout: 3), "Listed in Arrange Your Day")
        shot("a08-added")
    }

    /// The habit form shows Group before any group exists, with New Group in it.
    func testGroupRowBeforeAnyGroup() {
        launch()
        app.navigationBars.buttons["New Habit"].firstMatch.tap()
        XCTAssertTrue(app.navigationBars["New"].waitForExistence(timeout: 3))
        app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Build or maintain,'")).firstMatch.tap()
        app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Check it off,'")).firstMatch.tap()
        XCTAssertTrue(app.navigationBars["New Habit"].waitForExistence(timeout: 3))
        let group = app.buttons["group-row"]
        app.reveal(group)
        XCTAssertTrue(group.exists, "Group row with no groups yet")
        XCTAssertEqual(group.label, "Group, None")
        group.tap()
        XCTAssertTrue(app.buttons["group-picker-new"].waitForExistence(timeout: 3), "New Group from the form")
        shot("a11-group-picker")
    }
}
