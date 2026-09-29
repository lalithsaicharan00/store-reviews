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

        // Build or maintain asks how to track it, then the form (the user kept this step, 29 Sep).
        row("Build or maintain").tap()
        XCTAssertTrue(app.staticTexts["How do you want to track it?"].waitForExistence(timeout: 3))
        shot("f02-how-to-track")
        row("Check it off,").tap()
        XCTAssertTrue(app.navigationBars["New Habit"].waitForExistence(timeout: 3))
        let field = app.descendants(matching: .any)["name-field"]
        field.tap(); field.typeText("Brush teeth\n")
        shot("f03-check-form")
        let form = app.collectionViews["habit-form"]
        // How often: 4 times a day.
        row("How often").tap()
        XCTAssertTrue(app.navigationBars["How Often"].waitForExistence(timeout: 3))
        app.buttons["often-timesADay"].tap()
        app.buttons["often-per-day-Increment"].tap(); app.buttons["often-per-day-Increment"].tap()
        shot("f04-how-often-screen")
        back()
        XCTAssertEqual(app.descendants(matching: .any)["habit-sentence"].label, "Brush teeth 4 times a day, anytime")
        // Time of Day: Morning and Afternoon. The goal must stay 4.
        row("Time of Day").tap()
        XCTAssertTrue(app.navigationBars["Time of Day"].waitForExistence(timeout: 3))
        app.buttons["Morning"].firstMatch.tap()
        app.buttons["Afternoon"].firstMatch.tap()
        shot("f05-time-of-day-screen")
        back()
        XCTAssertTrue(row("Time of Day, Morning and Afternoon").waitForExistence(timeout: 3))
        XCTAssertTrue(row("How often, 4 times a day").exists, "Picking parts of the day leaves how often alone")
        // Colour pops up.
        app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Colour'")).firstMatch.tap()
        XCTAssertTrue(app.navigationBars["Colour"].waitForExistence(timeout: 3))
        shot("f05c-colour-popup")
        app.navigationBars["Colour"].buttons["Done"].tap()
        sleep(1)
        shot("f03b-compact-form")
        form.swipeUp()
        row("Reminders").tap()
        XCTAssertTrue(app.navigationBars["Reminders"].waitForExistence(timeout: 3))
        XCUIDevice.shared.appearance = .dark
        sleep(1)
        shot("f06-reminders-dark")
        XCUIDevice.shared.appearance = .light
        sleep(1)
        shot("f06b-reminders-light")
        // Reminders start off; on shows the rows, off hides them again.
        let remind = app.switches["Remind Me"].firstMatch
        remind.switches.firstMatch.tap()
        XCTAssertTrue(app.buttons["Add Another Reminder"].waitForExistence(timeout: 2), "On shows the reminders")
        remind.switches.firstMatch.tap()
        XCTAssertFalse(app.buttons["Add Another Reminder"].waitForExistence(timeout: 1), "Reminders hide when the switch is off")
        shot("f06c-reminders-off-light")
        remind.switches.firstMatch.tap()
        XCTAssertTrue(app.buttons["Add Another Reminder"].waitForExistence(timeout: 2), "Switching it back on shows the reminders again")
        back()
        XCUIDevice.shared.appearance = .dark
        app.navigationBars["New Habit"].buttons["Add"].tap()
        sleep(3)
        shot("f07-today")

        app.navigationBars.buttons["New Habit"].firstMatch.tap()

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
