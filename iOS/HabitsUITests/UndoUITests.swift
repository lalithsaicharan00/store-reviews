import XCTest

/// Runs on GitHub's Mac. History opens safely, corrections affect one entry, and Undo stays visible.
final class UndoUITests: XCTestCase {
    private var app: XCUIApplication!
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-uitest", "-focus-fixture"]
        app.launch()
        XCTAssertTrue(app.buttons["Add 1 glass to Drink water"].waitForExistence(timeout: 10))
    }
    override func record(_ issue: XCTIssue) {
        var issue = issue
        let shot = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        shot.name = name
        shot.lifetime = .keepAlways
        issue.add(shot)
        let tree = XCTAttachment(string: app?.debugDescription ?? "No app")
        tree.name = "accessibility-tree"
        tree.lifetime = .keepAlways
        issue.add(tree)
        super.record(issue)
    }
    private func shot(_ name: String) {
        let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }
    private func daySheet(_ name: String) {
        app.buttons["All habits"].tap()
        app.revealAndTap(app.staticTexts[name])
        let today = app.buttons["habit-today-progress"]
        XCTAssertTrue(today.waitForExistence(timeout: 5))
        today.tap()
        XCTAssertTrue(app.descendants(matching: .any)["day-result"].firstMatch.waitForExistence(timeout: 5))
    }
    private var entries: XCUIElementQuery { app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'entry-'")) }

    func testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited() {
        app.revealAndTap(app.buttons["Start Read a little timer"])
        let row = app.staticTexts["Read a little"]
        app.reveal(row)
        row.press(forDuration: 1.2)
        app.buttons["Edit Today's Progress…"].tap()
        XCTAssertTrue(app.buttons["Pause timer and save time"].waitForExistence(timeout: 3))
        app.buttons["Pause timer and save time"].tap()
        XCTAssertTrue(app.descendants(matching: .any)["day-result"].firstMatch.exists, "Stopping a timer keeps its sheet open")
        XCTAssertEqual(entries.count, 1)
        entries.firstMatch.tap()
        let seconds = app.textFields["entry-seconds"]
        app.revealAndTap(seconds)
        seconds.typeText("30")
        shot("undo-time-editor-keyboard")
        app.navigationBars["Edit Entry"].buttons["Save"].tap()
        XCTAssertTrue(entries.firstMatch.waitForExistence(timeout: 3))
        XCTAssertTrue(entries.firstMatch.label.contains("30 sec"))
    }

    func testSkipFromTodayKeepsHistoryOpenAndCanBeUndone() {
        let row = app.staticTexts["Stretch"]
        app.reveal(row)
        row.press(forDuration: 1.2)
        app.buttons["Edit Today's Progress…"].tap()
        app.revealAndTap(app.buttons["Skip today"])
        XCTAssertTrue(app.buttons["Undo skip"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.descendants(matching: .any)["day-result"].firstMatch.exists)
        app.buttons["Undo skip"].tap()
        XCTAssertTrue(app.switches["day-done"].isEnabled)
    }

    func testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact() {
        app.buttons["Start Anytime routine"].tap()
        XCTAssertTrue(app.buttons["focus-primary"].waitForExistence(timeout: 3))
        app.buttons["focus-primary"].tap()
        let undo = app.buttons["focus-persistent-undo"]
        XCTAssertTrue(undo.waitForExistence(timeout: 3))
        sleep(6)
        XCTAssertTrue(undo.exists)
        shot("undo-routine-persistent")
        undo.tap()
        XCTAssertEqual(app.staticTexts["focus-progress-circle"].label, "1 / 2 glasses")
        XCTAssertFalse(undo.exists)
    }

    func testStoreCorrectionsRecalculateAndPersist() {
        app.terminate()
        app.launchArguments = ["-uitest", "-undocheck"]
        app.launch()
        XCTAssertTrue(app.staticTexts["Undo: all checks passed"].waitForExistence(timeout: 15))
    }

    func testEditAndDeleteOneEntryInDaySheet() {
        daySheet("Drink water")
        XCTAssertTrue(app.staticTexts["1/2 glasses"].exists)
        XCTAssertEqual(entries.count, 1)
        shot("undo-day-sheet")
        entries.firstMatch.tap()
        XCTAssertTrue(app.navigationBars["Edit Entry"].waitForExistence(timeout: 3))
        let field = app.textFields["entry-amount"]
        field.tap()
        shot("undo-entry-editor-keyboard")
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
        // Nested sheets expose covered accessibility elements too. Query the frontmost native Form.
        let entries = app.collectionViews["log-form"].buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'entry-'"))
        XCTAssertTrue(app.navigationBars["Log Amount"].waitForExistence(timeout: 3))
        let keyboardDone = app.toolbars.buttons["Done"].firstMatch
        if keyboardDone.waitForExistence(timeout: 3) { keyboardDone.tap() }
        let logForm = app.collectionViews["log-form"]
        for _ in 0..<5 {
            if entries.firstMatch.exists && entries.firstMatch.isHittable { break }
            logForm.swipeUp()
        }
        XCTAssertTrue(app.reveal(entries.firstMatch))
        XCTAssertEqual(entries.count, 1)
        shot("undo-log-sheet")
        app.revealAndTap(entries.firstMatch)
        XCTAssertTrue(app.navigationBars["Edit Entry"].waitForExistence(timeout: 3))
        app.buttons["Delete Entry"].tap()
        XCTAssertTrue(app.staticTexts["No entries yet"].waitForExistence(timeout: 3))
        let field = app.textFields["log-amount"]
        app.revealAndTap(field); field.typeText("2")
        app.navigationBars["Log Amount"].buttons["Log"].tap()
        XCTAssertTrue(app.staticTexts["2/2 glasses"].waitForExistence(timeout: 3))
        XCTAssertEqual(self.entries.count, 1) // Log has dismissed; inspect the Day sheet now.
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
        let calendarDays = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'habit-day-' AND enabled == YES"))
        XCTAssertGreaterThan(calendarDays.count, 0)
        let calendarDay = calendarDays.element(boundBy: calendarDays.count - 1) // last enabled day is today
        XCTAssertTrue(calendarDay.exists)
        calendarDay.tap()
        XCTAssertTrue(app.descendants(matching: .any)["day-result"].firstMatch.waitForExistence(timeout: 3))
        XCTAssertTrue(app.staticTexts["No entries yet"].exists, "Opening a calendar day never logs")
        app.switches["day-done"].coordinate(withNormalizedOffset: CGVector(dx: 0.9, dy: 0.5)).tap()
        XCTAssertTrue(app.staticTexts["3/3"].waitForExistence(timeout: 3))
        app.switches["day-done"].coordinate(withNormalizedOffset: CGVector(dx: 0.9, dy: 0.5)).tap()
        XCTAssertTrue(app.staticTexts["No entries yet"].waitForExistence(timeout: 3))
        let skip = app.buttons.matching(NSPredicate(format: "label IN {'Skip today','Skip this day'}")).firstMatch
        app.revealAndTap(skip)
        XCTAssertTrue(app.buttons["Undo skip"].waitForExistence(timeout: 3))
        app.buttons["Undo skip"].tap()
        XCTAssertTrue(app.staticTexts["0/3"].waitForExistence(timeout: 3))
    }
}
