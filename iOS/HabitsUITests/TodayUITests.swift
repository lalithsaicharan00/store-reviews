import XCTest

/// Drives the Today screen on a real device or simulator and keeps screenshots of each state.
final class TodayUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-uitest"]
        app.launch()
    }

    private func shot(_ name: String) {
        let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    func testTodayScreen() {
        XCTAssertTrue(app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Quitting'")).firstMatch.waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["Anytime"].exists)
        shot("01-today")

        // Tick a yes/no habit, then undo it.
        let call = app.buttons["Mark Call family done"]
        XCTAssertTrue(call.waitForExistence(timeout: 2))
        call.tap()
        shot("02-call-ticked")
        let undo = app.buttons["Undo Call family"]
        if undo.waitForExistence(timeout: 2) { undo.tap() }

        // Fold and open the Anytime part.
        app.staticTexts["Anytime"].tap()
        shot("03-anytime-folded")
        app.staticTexts["Anytime"].tap()

        // The day bar is the system bottom toolbar (Figma 193:6): ‹, the day label, ›.
        for name in ["Previous day", "Next day"] {
            XCTAssertTrue(app.buttons[name].isHittable, name)
        }

        // Previous day, then back to today through the calendar. The bar's buttons stay put.
        let before = (app.buttons["Previous day"].frame, app.buttons["Next day"].frame)
        app.buttons["Previous day"].tap()
        XCTAssertTrue(app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Yesterday,'")).firstMatch.waitForExistence(timeout: 2))
        shot("04-yesterday")
        XCTAssertEqual(app.buttons["Previous day"].frame, before.0, "‹ doesn't move")
        XCTAssertEqual(app.buttons["Next day"].frame, before.1, "› doesn't move")
        app.buttons["Previous day"].tap()
        XCTAssertEqual(app.buttons["Next day"].frame, before.1, "› doesn't move for a dated label")
        // Step forward one day at a time, waiting for each change.
        let yesterday = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Yesterday,'")).firstMatch
        app.buttons["Next day"].tap()
        XCTAssertTrue(yesterday.waitForExistence(timeout: 3))
        app.buttons["Next day"].tap()
        let label = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Today,'")).firstMatch
        XCTAssertTrue(label.waitForExistence(timeout: 3))
        label.tap()
        XCTAssertTrue(app.navigationBars["Go to a day"].waitForExistence(timeout: 2))
        shot("05-calendar")
        app.buttons["Today"].firstMatch.tap()

        // + opens New Habit.
        app.buttons["New Habit"].tap()
        XCTAssertTrue(app.navigationBars["New"].waitForExistence(timeout: 3))
        shot("06-new-habit")
    }
}
