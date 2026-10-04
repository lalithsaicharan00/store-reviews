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
    /// ≡ → Habits: All Habits moved into the menu (the user's final decision, 30 Sep 2026).
    private func openHabits() {
        let menu = app.buttons["menu-button"]
        XCTAssertTrue(menu.waitForExistence(timeout: 5))
        menu.tap()
        let row = app.buttons["menu-habits"]
        XCTAssertTrue(row.waitForExistence(timeout: 3))
        row.tap()
    }

    private func daySheet(_ name: String) {
        openHabits()
        app.revealAndTap(app.staticTexts[name])
        // The habit page opens on History: its first row is today (newest first, this month open).
        let today = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'habit-day-'")).firstMatch
        XCTAssertTrue(today.waitForExistence(timeout: 5))
        today.tap()
        XCTAssertTrue(app.descendants(matching: .any)["day-result"].firstMatch.waitForExistence(timeout: 5))
    }
    /// The Day sheet's status says `text` ("1 of 2 glasses", Day details 4 Oct 2026). It used to be matched on the habit
    /// page's Today row behind the sheet, which the page no longer has (3 Oct 2026: History · Notes · Progress).
    private func resultShows(_ text: String, wait: TimeInterval = 3) -> Bool {
        let row = app.staticTexts.matching(NSPredicate(format: "identifier == 'day-result' AND label == %@", text)).firstMatch
        return row.waitForExistence(timeout: wait)
    }
    /// The saved logs that open Edit Log (links, so buttons) and single checks' named Undo buttons.
    private var entries: XCUIElementQuery { app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'entry-' AND NOT identifier IN {'entry-delete','entry-save','entry-back'}")) }
    private var checkUndos: XCUIElementQuery { app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'undo-entry-'")) }

    /// Delete this log asks first; nothing goes until the alert's Delete Log (Rulebook U19).
    private func deleteThisLog() {
        app.revealAndTap(app.buttons["entry-delete"])
        let confirm = app.alerts.buttons["Delete Log"]
        XCTAssertTrue(confirm.waitForExistence(timeout: 3), "Delete asks first")
        shot("undo-delete-asks")
        confirm.tap()
    }

    func testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited() {
        app.revealAndTap(app.buttons["Start Read a little timer"])
        let row = app.staticTexts["Read a little"]
        app.reveal(row)
        // A tap on the row opens its Day sheet (3 Oct 2026; it replaced the menu's "Edit Today's Progress…").
        row.tap()
        XCTAssertTrue(app.buttons["Pause timer and save time"].waitForExistence(timeout: 3))
        app.buttons["Pause timer and save time"].tap()
        XCTAssertTrue(app.descendants(matching: .any)["day-result"].firstMatch.exists, "Stopping a timer keeps its sheet open")
        XCTAssertEqual(entries.count, 1)
        entries.firstMatch.tap()
        let seconds = app.textFields["entry-seconds"]
        app.revealAndTap(seconds)
        seconds.typeText("30")
        shot("undo-time-editor-keyboard")
        app.navigationBars["Edit Log"].buttons["Save"].tap()
        XCTAssertTrue(entries.firstMatch.waitForExistence(timeout: 3))
        XCTAssertTrue(entries.firstMatch.label.contains("30 sec"))
    }

    func testSkipFromTodayKeepsHistoryOpenAndCanBeUndone() {
        let row = app.staticTexts["Stretch"]
        app.reveal(row)
        row.tap()
        app.revealAndTap(app.buttons["Skip today"])
        XCTAssertTrue(app.buttons["Undo skip"].waitForExistence(timeout: 3), "Skip turns into Undo skip")
        XCTAssertTrue(resultShows("Skipped"))
        XCTAssertFalse(app.buttons["day-add-one"].isEnabled, "Skipped: Add a check stays in place, disabled (U15)")
        shot("undo-skipped-day")
        app.buttons["Undo skip"].tap()
        XCTAssertTrue(app.buttons["Skip today"].waitForExistence(timeout: 3), "Undo skip turns back into Skip today")
        XCTAssertTrue(app.buttons["day-add-one"].isEnabled)
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
        // The circle is a container (its children keep their identifiers), and the player keeps the pages beside the
        // current one loaded, so look for the number with this value.
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "identifier == 'focus-quantity' AND label == '1 / 2 glasses'")).firstMatch.waitForExistence(timeout: 3))
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
        XCTAssertTrue(resultShows("1 of 2 glasses", wait: 1))
        XCTAssertEqual(entries.count, 1)
        shot("undo-day-sheet")
        entries.firstMatch.tap()
        XCTAssertTrue(app.navigationBars["Edit Log"].waitForExistence(timeout: 3))
        XCTAssertFalse(app.keyboards.firstMatch.exists, "The editor opens with the keyboard closed")
        let field = app.textFields["entry-amount"]
        field.tap()
        shot("undo-entry-editor-keyboard")
        field.typeText("3") // existing number is selected by the app's native number-field behaviour
        app.navigationBars["Edit Log"].buttons["Save"].tap()
        XCTAssertTrue(resultShows("3 of 2 glasses"))
        XCTAssertEqual(entries.count, 1, "Editing replaces the entry rather than adding another")
        entries.firstMatch.tap()
        deleteThisLog()
        XCTAssertTrue(entries.firstMatch.waitForNonExistence(timeout: 3), "The one log is gone")
        XCTAssertTrue(resultShows("0 of 2 glasses", wait: 1))
        XCTAssertFalse(app.staticTexts["Today's logs"].exists, "No empty logs section")
    }

    func testLogSheetSharesEntryEditingAndStillAdds() {
        daySheet("Drink water")
        app.buttons["day-add-entry"].tap()
        // Nested sheets expose covered accessibility elements too. Query the frontmost native Form.
        let entries = app.collectionViews["log-form"].buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'entry-'"))
        XCTAssertTrue(app.navigationBars["Add Entry"].waitForExistence(timeout: 3))
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
        XCTAssertTrue(app.navigationBars["Edit Log"].waitForExistence(timeout: 3))
        deleteThisLog()
        XCTAssertTrue(app.staticTexts["No entries yet"].waitForExistence(timeout: 3))
        let field = app.textFields["log-amount"]
        app.revealAndTap(field); field.typeText("2")
        app.navigationBars["Add Entry"].buttons["add-entry-save"].tap()
        XCTAssertTrue(resultShows("2 of 2 glasses"))
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
        XCTAssertTrue(resultShows("1 of 2 glasses", wait: 1), "Only the new log was removed")
        XCTAssertEqual(entries.count, 1)
    }

    func testDayControlsAndCalendarOpeningAreExplicit() {
        openHabits()
        app.revealAndTap(app.staticTexts["Stretch"])
        let calendarDays = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'habit-day-' AND enabled == YES"))
        // History, newest first: the first day row is today.
        XCTAssertTrue(calendarDays.firstMatch.waitForExistence(timeout: 5))
        let calendarDay = calendarDays.element(boundBy: 0)
        XCTAssertTrue(calendarDay.exists)
        // The key's section sits above the calendar (3 Oct 2026): today's square can still be below the screen's edge.
        app.revealAndTap(calendarDay, clear: true)
        XCTAssertTrue(app.descendants(matching: .any)["day-result"].firstMatch.waitForExistence(timeout: 3))
        XCTAssertTrue(resultShows("0 of 3 checks", wait: 1), "Opening a calendar day never logs")
        XCTAssertEqual(checkUndos.count, 0, "No empty checks section")
        // Several a day: Add a check adds one each tap, never takes one back (U14).
        let add = app.buttons["day-add-one"]
        XCTAssertEqual(add.label, "Add a check")
        for _ in 0..<3 { add.tap(); usleep(400_000) }
        XCTAssertTrue(resultShows("3 of 3 checks"))
        XCTAssertEqual(checkUndos.count, 3, "Each check is its own row")
        shot("undo-checks-today")
        // Each check's own Undo takes back that one check, not the day.
        checkUndos.firstMatch.tap()
        XCTAssertTrue(resultShows("2 of 3 checks"))
        XCTAssertEqual(checkUndos.count, 2)
        let skip = app.buttons.matching(NSPredicate(format: "label IN {'Skip today','Skip this day'}")).firstMatch
        app.revealAndTap(skip)
        XCTAssertTrue(app.buttons["Undo skip"].waitForExistence(timeout: 3))
        XCTAssertEqual(checkUndos.count, 2, "Skipping keeps the saved checks (U15)")
        app.buttons["Undo skip"].tap()
        XCTAssertTrue(resultShows("2 of 3 checks"))
    }
}
