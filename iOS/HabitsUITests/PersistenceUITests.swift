import XCTest

/// Proves that what the user does survives the app being killed, using a real database file
/// on the device (a test-only file, never the user's).
final class PersistenceUITests: XCTestCase {
    override func record(_ issue: XCTIssue) {
        let shot = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        shot.name = "FAIL-\(name)"
        shot.lifetime = .keepAlways
        var issue = issue
        issue.add(shot)
        super.record(issue)
    }

    private func launch(reset: Bool) -> XCUIApplication {
        let app = XCUIApplication()
        app.launchArguments = ["-dbname", "uitest-persistence", "-empty"] + (reset ? ["-reset-db"] : [])
        app.launch()
        return app
    }

    private func shot(_ name: String) {
        let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    func testHabitAndTickSurviveRelaunch() {
        continueAfterFailure = false
        var app = launch(reset: true)
        XCTAssertTrue(app.staticTexts["No habits yet"].waitForExistence(timeout: 5), "A fresh database starts empty")
        shot("01-empty")

        app.buttons["New Habit"].firstMatch.tap()
        XCTAssertTrue(app.navigationBars["New"].waitForExistence(timeout: 3))
        app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Build or maintain'")).firstMatch.tap()
        app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Check it off'")).firstMatch.tap()
        let name = app.descendants(matching: .any)["name-field"]
        XCTAssertTrue(name.waitForExistence(timeout: 3))
        name.tap()
        name.typeText("Stretch")
        app.navigationBars["New Habit"].buttons["Add"].tap()
        let tick = app.buttons["Mark Stretch done"]
        if !tick.waitForExistence(timeout: 5) { print("TREE-DUMP\n" + app.debugDescription); shot("01b-debug") }
        XCTAssertTrue(tick.exists)
        tick.tap()
        // The part says it's finished. Just added, it stays open, so the row doesn't vanish under the finger.
        let header = app.buttons["Anytime, All done"]
        if !header.waitForExistence(timeout: 3) { print("TREE-DUMP\n" + app.debugDescription); shot("02-debug") }
        XCTAssertTrue(header.exists, "Ticking the only habit finishes the part")
        XCTAssertTrue(app.buttons["Undo Stretch"].waitForExistence(timeout: 3))
        shot("02-created-and-ticked")

        app.terminate()
        app = launch(reset: false)
        let doneHeader = app.buttons["Anytime, All done"]
        XCTAssertTrue(doneHeader.waitForExistence(timeout: 5), "The habit and its tick are still there after a relaunch")
        doneHeader.tap()
        XCTAssertTrue(app.buttons["Undo Stretch"].waitForExistence(timeout: 3), "The tick is still there after a relaunch")
        shot("03-after-relaunch")

        // Undo, relaunch again: the undo is saved too.
        app.buttons["Undo Stretch"].tap()
        XCTAssertTrue(app.buttons["Mark Stretch done"].waitForExistence(timeout: 3))
        app.terminate()
        app = launch(reset: false)
        XCTAssertTrue(app.buttons["Mark Stretch done"].waitForExistence(timeout: 5), "The undo survives a relaunch")
        shot("04-undo-after-relaunch")
    }

    /// When the database can't be opened, the app says so and shows nothing editable: it must never look
    /// like a fresh, empty app whose changes would vanish on quit.
    func testUnopenableDatabaseSaysSoAndTakesNoChanges() {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launchArguments = ["-dbname", "uitest-persistence", "-empty", "-simulate-open-failure"]
        app.launch()
        let alert = app.alerts["Something went wrong"]
        XCTAssertTrue(alert.waitForExistence(timeout: 5), "The failure is reported")
        XCTAssertTrue(alert.staticTexts.matching(NSPredicate(format: "label CONTAINS 'be opened'")).firstMatch.exists)
        shot("05-open-failure")
        alert.buttons["OK"].tap()
        XCTAssertFalse(app.staticTexts["No habits yet"].waitForExistence(timeout: 2), "An unopened database must not look empty")
        shot("06-after-dismiss")
    }
}
