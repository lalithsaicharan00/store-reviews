import XCTest

/// Edit Today (Figma 827:39487, 17 Nov 2026): every habit by routine, held and dragged into place.
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

    /// Today in normal mode: Edit and +, no Filter; each routine says when it starts; nothing under the last card
    /// (no Note for the Day since 17 Nov 2026). Edit opens Edit Today (Figma 827:39487) with every habit, each routine
    /// heading with its hours and Edit, Anytime and Quitting with a handle; Back returns to Today.
    func testEditArrangesTheDay() {
        launch()
        XCTAssertTrue(app.buttons["arrange-button"].exists)
        XCTAssertFalse(app.buttons["filter-button"].exists, "No Filter on Today")
        XCTAssertTrue(app.buttons["New Habit"].exists)
        let morning = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Morning, Starts '")).firstMatch
        XCTAssertTrue(morning.waitForExistence(timeout: 3), "Morning says when it starts")
        XCTAssertFalse(app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Anytime, Starts'")).firstMatch.exists,
                       "Anytime has no start")
        app.reveal(app.buttons["add-day-note"])
        XCTAssertFalse(app.buttons["add-day-note"].exists, "No Note for the Day at the bottom")
        shot("a01-today")

        app.buttons["arrange-button"].tap()
        XCTAssertTrue(app.navigationBars["Edit Today"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.buttons["arrange-done"].exists, "Back, alone in the top bar")
        XCTAssertFalse(app.buttons["arrange-button"].exists)
        XCTAssertFalse(app.buttons["menu-button"].exists)
        // Every habit, not only today's: Call family is three times a week, Floss is in the Evening.
        XCTAssertTrue(any("arrange-row-Call family").exists)
        XCTAssertTrue(any("arrange-heading-Anytime").exists)
        XCTAssertFalse(app.buttons["arrange-edit-Anytime"].exists, "Anytime is built in: no Edit")
        app.reveal(any("arrange-row-Floss"))
        XCTAssertTrue(any("arrange-row-Floss").exists, "Evening's habits are listed too")
        shot("a02-edit-today")

        // A timed routine's Edit opens its editor.
        let evening = app.buttons["arrange-edit-Evening"]
        app.reveal(evening)
        evening.tap()
        XCTAssertTrue(app.navigationBars["Edit Routine"].waitForExistence(timeout: 3))
        XCTAssertTrue(any("plan-row-Evening").exists, "Your day, as it will look")
        shot("a03-edit-routine")
        app.navigationBars["Edit Routine"].buttons["Cancel"].tap()

        app.buttons["arrange-done"].tap()
        XCTAssertTrue(app.buttons["arrange-button"].waitForExistence(timeout: 3), "Back to Today")
        shot("a04-today-after")
    }

    /// A habit held and dragged into another routine moves there (Figma's Dragging a habit); a routine left with no
    /// habits says "Drag a habit here", and a habit dropped on it goes in (Figma's Empty routine). T12: each drop ends
    /// well inside its destination and rests before letting go.
    func testDragAHabitIntoAnotherRoutine() {
        launch()
        app.buttons["arrange-button"].tap()
        XCTAssertTrue(app.navigationBars["Edit Today"].waitForExistence(timeout: 3))
        let afternoon = ["Walk", "Lunch, no phone", "Meds 14:00"]
        let evening = any("arrange-row-Floss")
        for name in afternoon {
            let row = any("arrange-row-\(name)")
            app.reveal(row)
            app.reveal(evening)
            XCTAssertTrue(row.exists, name)
            row.press(forDuration: 1, thenDragTo: evening, withVelocity: .slow, thenHoldForDuration: 2)
            sleep(1)
        }
        let empty = any("arrange-empty")
        app.reveal(empty)
        XCTAssertTrue(empty.waitForExistence(timeout: 3), "An emptied routine says Drag a habit here")
        shot("a05-empty-routine")

        let walk = any("arrange-row-Walk")
        app.reveal(walk)
        walk.press(forDuration: 1, thenDragTo: empty, withVelocity: .slow, thenHoldForDuration: 2)
        XCTAssertFalse(empty.waitForExistence(timeout: 2), "Walk went into the empty routine")
        shot("a06-dropped-in")
    }

    /// Add a routine from Edit Today: the form shows the whole day; if it overlaps others, it asks before splitting
    /// them, then the new one is listed with its Edit.
    func testAddTimeOfDay() {
        launch()
        app.buttons["arrange-button"].tap()
        let add = app.buttons["arrange-add-section"]
        app.reveal(add)
        add.tap()
        XCTAssertTrue(app.navigationBars["New Routine"].waitForExistence(timeout: 3))
        let name = app.textFields["section-name-field"]
        XCTAssertTrue(name.waitForExistence(timeout: 3))
        name.typeText("Mid Morning")
        XCTAssertTrue(any("plan-row-Mid Morning").waitForExistence(timeout: 2), "The new one in Your day")
        shot("a07-new-time-of-day")
        app.navigationBars["New Routine"].buttons["section-save"].tap()
        let split = app.buttons["section-split-confirm"].firstMatch
        if split.waitForExistence(timeout: 2) {
            shot("a08-split-confirm")
            split.tap()
        }
        let edit = app.buttons["arrange-edit-Mid Morning"]
        app.reveal(edit)
        XCTAssertTrue(edit.waitForExistence(timeout: 3), "Listed in Edit Today")
        shot("a09-added")
    }

    /// The habit form has no Group: groups are gone (17 Nov 2026, the user; Android A64).
    func testHabitFormHasNoGroup() {
        launch()
        app.navigationBars.buttons["New Habit"].firstMatch.tap()
        XCTAssertTrue(app.staticTexts["What Do You Want to Do?"].waitForExistence(timeout: 3))
        app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Build or Maintain,'")).firstMatch.tap()
        app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Check It Off,'")).firstMatch.tap()
        XCTAssertTrue(app.navigationBars["New Habit"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.descendants(matching: .any)["habit-form"].waitForExistence(timeout: 3))
        XCTAssertFalse(app.buttons["group-row"].exists, "No Group row")
    }
}
