import XCTest

/// Walks the New flow (What do you want to do? → how to track it → the form) and keeps a
/// screenshot of each screen. Only the flow; the form's details are checked by hand for now.
final class NewFlowUITests: XCTestCase {
    override func record(_ issue: XCTIssue) {
        let shot = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        shot.name = "FAIL-\(name)"
        shot.lifetime = .keepAlways
        var issue = issue
        issue.add(shot)
        super.record(issue)
    }

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

    private func row(_ title: String) -> XCUIElement {
        app.buttons.matching(NSPredicate(format: "label BEGINSWITH %@", title)).firstMatch
    }

    /// The system back button (the keyboard may be up, so dismiss it first).
    private func back() {
        let done = app.toolbars.buttons["Done"].firstMatch
        if done.exists { done.tap() }
        let button = app.navigationBars.buttons["BackButton"].firstMatch
        if button.waitForExistence(timeout: 2) { button.tap() }
        else { app.windows.firstMatch.coordinate(withNormalizedOffset: CGVector(dx: 0.01, dy: 0.5)).press(forDuration: 0.05, thenDragTo: app.windows.firstMatch.coordinate(withNormalizedOffset: CGVector(dx: 0.8, dy: 0.5))) }
        sleep(1)
    }

    func testFlow() {
        app.navigationBars.buttons["New Habit"].firstMatch.tap()
        XCTAssertTrue(app.staticTexts["What do you want to do?"].waitForExistence(timeout: 3))
        shot("f01-what-to-create")

        row("Build or maintain").tap()
        XCTAssertTrue(app.staticTexts["How do you want to track it?"].waitForExistence(timeout: 3))
        shot("f02-good-habit")
        row("Check it off").tap()
        XCTAssertTrue(app.navigationBars["Check it off"].waitForExistence(timeout: 3))
        let field = app.descendants(matching: .any)["name-field"]
        field.tap(); field.typeText("Brush teeth\n")
        shot("f03-check-form")
        let form = app.collectionViews["habit-form"]
        // Goal: 4 a day.
        row("Goal").tap()
        XCTAssertTrue(app.navigationBars["Goal"].waitForExistence(timeout: 3))
        let amount = app.textFields["goal-amount"]
        amount.tap(); sleep(1); amount.typeText("4")
        shot("f04-goal-screen")
        back()
        // Time of Day: Morning and Afternoon. The goal must stay 4.
        row("Time of Day").tap()
        XCTAssertTrue(app.navigationBars["Time of Day"].waitForExistence(timeout: 3))
        app.buttons["Morning"].firstMatch.tap()
        app.buttons["Afternoon"].firstMatch.tap()
        shot("f05-time-of-day-screen")
        back()
        XCTAssertTrue(row("Time of Day, Morning, Afternoon").waitForExistence(timeout: 3))
        XCTAssertTrue(row("Goal, 4 times a day").exists, "Picking parts of the day leaves the goal alone")
        // Repeat, with start and end dates.
        row("Repeat").tap()
        XCTAssertTrue(app.navigationBars["Repeat"].waitForExistence(timeout: 3))
        shot("f05b-repeat-screen")
        back()
        // Colour pops up.
        app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Colour'")).firstMatch.tap()
        XCTAssertTrue(app.navigationBars["Colour"].waitForExistence(timeout: 3))
        shot("f05c-colour-popup")
        app.navigationBars["Colour"].buttons["Done"].tap()
        sleep(1)
        shot("f03b-compact-form")
        form.swipeUp()
        XCUIDevice.shared.appearance = .dark
        sleep(1)
        shot("f06-reminders-dark")
        XCUIDevice.shared.appearance = .light
        sleep(1)
        shot("f06b-reminders-light")
        // Off hides the reminder rows and how to be reminded.
        let remind = app.switches["Remind Me"].firstMatch
        remind.switches.firstMatch.tap()
        XCTAssertFalse(app.buttons["Add Another Reminder"].waitForExistence(timeout: 1), "Reminders hide when the switch is off")
        shot("f06c-reminders-off-light")
        remind.switches.firstMatch.tap()
        form.swipeUp()
        XCTAssertTrue(app.buttons["Add Another Reminder"].waitForExistence(timeout: 2), "Switching it back on shows the reminders again")
        XCUIDevice.shared.appearance = .dark
        app.navigationBars["Check it off"].buttons["Add"].tap()
        sleep(3)
        shot("f07-today")

        app.navigationBars.buttons["New Habit"].firstMatch.tap()
        row("Build or maintain").tap()
        row("Track an amount").tap()
        XCTAssertTrue(app.navigationBars["Track an amount"].waitForExistence(timeout: 3))
        shot("f08-count-form")
        back()
        row("Time it").tap()
        XCTAssertTrue(app.navigationBars["Time it"].waitForExistence(timeout: 3))
        shot("f09-time-form")
        // Back to the first question, however many steps that takes.
        for _ in 0..<3 where !app.navigationBars["New"].exists { back() }

        row("Quit or cut down").tap()
        XCTAssertTrue(app.staticTexts["What do you want to do?"].waitForExistence(timeout: 3))
        shot("f10-bad-habit")
        row("Cut down").tap()
        XCTAssertTrue(app.navigationBars["Cut down"].waitForExistence(timeout: 3))
        for _ in 0..<3 where !app.navigationBars["New"].exists { back() }

        row("Add a task").tap()
        XCTAssertTrue(app.navigationBars["Task"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label CONTAINS \"Tasks don't have progress or stats\"")).firstMatch.exists)
        shot("f11-task-form")
    }
}
