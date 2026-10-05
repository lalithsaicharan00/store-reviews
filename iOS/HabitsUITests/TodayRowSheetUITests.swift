import XCTest

/// Today's rows (3 Oct 2026; checklist "Today — Row Sheet, Swipe Actions, Order and Tap Again", report "Today's Rows —
/// Tap, Swipe, the Day Sheet and Delete"): a tap opens the habit's Day sheet for the day Today shows; swipes reveal
/// labelled actions (Note, Skip, Pause on the left; a named Undo on the right); the round button follows one rule (✓
/// toggles that day's tick, + adds); the touch-and-hold menu matches the sheet; Delete lives only in the sheet's ⋯ menu.
final class TodayRowSheetUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = true
        app = XCUIApplication()
    }

    override func record(_ issue: XCTIssue) {
        let shot = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        shot.name = "FAIL-\(name)"
        shot.lifetime = .keepAlways
        var issue = issue
        issue.add(shot)
        super.record(issue)
    }

    private func shot(_ name: String) {
        let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    private func launch(_ extra: [String] = []) {
        app.launchArguments = ["-uitest"] + extra
        app.launch()
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 10))
    }

    private var result: XCUIElement { app.descendants(matching: .any)["day-result"].firstMatch }

    /// Taps a habit's row (its name) on Today and waits for its Day sheet.
    private func openSheet(_ name: String) {
        let row = app.staticTexts[name].firstMatch
        app.reveal(row, clear: true)
        row.tap()
        XCTAssertTrue(result.waitForExistence(timeout: 5), "\(name)'s row opens its Day sheet")
    }

    /// Swipes a row a fixed 220 pt from its name: XCUITest sizes a swipe to the element, and a name is too narrow for
    /// a real swipe (the short drag landed as a tap and opened the Day sheet, CI 4 Oct 2026).
    private func swipe(_ element: XCUIElement, right: Bool, distance: CGFloat = 220) {
        let start = element.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
        start.press(forDuration: 0.05, thenDragTo: start.withOffset(CGVector(dx: right ? distance : -distance, dy: 0)))
    }

    /// The sheet's Close icon (xmark, spoken "Close"; Rulebook U18).
    private func closeSheet() {
        let close = app.buttons["day-close"]
        XCTAssertEqual(close.label, "Close", "The Close icon is named Close for VoiceOver")
        close.tap()
        XCTAssertTrue(result.waitForNonExistence(timeout: 5))
    }

    /// Swipes the sheet's own list up until `element` can be tapped (Rulebook T9: not Today's list behind it).
    private func revealInSheet(_ element: XCUIElement) {
        let form = app.collectionViews["day-form"]
        for _ in 0..<6 where !(element.exists && element.isHittable) { form.swipeUp(velocity: .slow) }
    }

    /// Every kind of habit opens the same Day details, titled with the day alone (the habit's name is in its identity
    /// row, once), with ⋯ and Close and no bottom ‹ day › pager (handoff, 4 Oct 2026): an amount, a time, a weekly
    /// count, a quit habit. Each says what that day holds and offers its own actions.
    func testRowOpensDaySheetForEveryKind() {
        launch()
        let expected: [(String, String, [String])] = [
            ("Water", "amount", ["day-add-step", "day-add-entry"]),
            ("Read", "time", ["day-start-timer", "day-add-entry"]),
            ("Call family", "weekly", ["day-done"]),
            ("Smoking", "quit", ["day-add-entry"]),
        ]
        for (name, key, actions) in expected {
            openSheet(name)
            XCTAssertTrue(app.navigationBars["Today"].exists, "Titled with the day: Today")
            XCTAssertFalse(app.navigationBars["Today · \(name)"].exists, "Never the habit's name twice")
            XCTAssertTrue(app.buttons["day-open-page"].exists, "The identity row opens the habit page")
            XCTAssertTrue(app.buttons["day-more"].exists, "⋯ holds the habit's actions")
            XCTAssertFalse(app.buttons["day-previous"].exists || app.buttons["day-next"].exists, "No bottom pager")
            for id in actions { XCTAssertTrue(app.buttons[id].exists, "\(name): \(id)") }
            XCTAssertFalse(app.staticTexts["No entries yet"].exists, "No empty entries card")
            shot("r01-sheet-\(key)")
            closeSheet()
        }
    }

    /// The sheet is the day Today shows: on yesterday, a row opens yesterday; › moves the whole sheet to today.
    func testSheetFollowsTheDayShown() {
        launch()
        app.buttons["Previous day"].firstMatch.tap()
        sleep(1)
        // Yesterday's parts of the day are all done, so they're folded: open Anytime first.
        let open = app.buttons["Open Anytime"]
        if open.waitForExistence(timeout: 3) { open.tap(); sleep(1) }
        openSheet("Water")
        XCTAssertTrue(app.navigationBars["Yesterday"].exists, "Opened from yesterday, it's yesterday")
        let skip = app.buttons["Skip this day"]
        revealInSheet(skip)
        XCTAssertTrue(skip.exists, "Its words are this day's: Skip this day")
        XCTAssertFalse(app.buttons["Skip today"].exists, "Never \"today\" on yesterday's sheet")
        shot("r02-yesterday")
        closeSheet()
    }

    /// From the sheet: the identity row opens the habit's page; ⋯ holds View Habit, Edit Habit and Pause, then Archive
    /// and Delete, last; Delete asks first, offering Archive instead (U14).
    func testSheetActionsAndDeleteInTheMenu() {
        launch()
        openSheet("Call family")
        XCTAssertFalse(app.buttons["Delete Habit…"].exists, "No Delete in view")
        XCTAssertFalse(app.buttons["day-edit-habit"].exists, "Edit Habit is in ⋯, not in view")
        let page = app.buttons["day-open-page"]
        revealInSheet(page)
        shot("r03-sheet-actions")
        page.tap()
        XCTAssertTrue(app.segmentedControls["habit-tabs"].waitForExistence(timeout: 5), "Open Habit Page")
        shot("r04-habit-page-from-sheet")
        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssertTrue(result.waitForExistence(timeout: 3), "Back to the sheet")
        app.buttons["day-more"].tap()
        XCTAssertTrue(app.buttons["View Habit"].waitForExistence(timeout: 3), "View Habit in the ⋯ menu")
        XCTAssertTrue(app.buttons["day-edit-habit"].exists, "Edit Habit in the ⋯ menu")
        XCTAssertTrue(app.buttons["Pause…"].exists, "Pause in the ⋯ menu")
        XCTAssertTrue(app.buttons["Archive"].exists, "Archive in the ⋯ menu")
        let delete = app.buttons["Delete Habit…"]
        XCTAssertTrue(delete.exists, "Delete in the ⋯ menu")
        XCTAssertLessThan(app.buttons["Archive"].frame.minY, delete.frame.minY, "Delete last")
        shot("r05-more-menu")
        delete.tap()
        XCTAssertTrue(app.buttons["Archive Instead"].waitForExistence(timeout: 3), "Delete asks first and offers Archive")
        shot("r06-delete-asks")
        // iOS 26 shows the question as a popover anchored to ⋯ with no Cancel button: a tap outside it dismisses.
        let cancel = app.buttons["Cancel"].firstMatch
        if cancel.exists { cancel.tap() } else { app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.62)).tap() }
        XCTAssertTrue(app.buttons["Archive Instead"].waitForNonExistence(timeout: 3), "The question closes")
        XCTAssertTrue(app.navigationBars["Today"].waitForExistence(timeout: 3) && page.exists, "Nothing deleted")
        closeSheet()
    }

    /// Swipe right: Undo, naming what it takes back, removes exactly one entry. Swipe left: Skip and Note, revealed with
    /// their labels, never performed by the swipe however far it goes (4 Oct 2026); Skip turns into Undo Skip.
    func testSwipeActions() {
        launch()
        let water = app.staticTexts["Water"].firstMatch
        app.reveal(water, clear: true)
        let before = app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH '8/8 glasses'")).firstMatch
        XCTAssertTrue(before.exists, "Water starts at 8/8")
        swipe(water, right: true)
        let undo = app.buttons["row-swipe-undo"]
        XCTAssertTrue(undo.waitForExistence(timeout: 3), "Swipe right offers Undo")
        XCTAssertEqual(undo.label, "Undo +1 glass", "Undo says what it takes back")
        shot("r07-swipe-undo")
        undo.tap()
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH '7/8 glasses'")).firstMatch.waitForExistence(timeout: 3),
                      "Exactly one glass taken back")
        // A swipe all the way across only reveals: it never opens the note (the user, 4 Oct 2026).
        swipe(water, right: false, distance: 360)
        XCTAssertTrue(app.buttons["row-swipe-skip"].waitForExistence(timeout: 3), "Swipe left: Skip")
        XCTAssertTrue(app.buttons["row-swipe-note"].exists, "Swipe left: Note")
        XCTAssertFalse(app.buttons["row-swipe-pause"].exists, "Pause is in the long-press menu and the Day sheet, not the swipe")
        XCTAssertFalse(app.descendants(matching: .any)["note-field"].firstMatch.waitForExistence(timeout: 1.5), "A long swipe doesn't open the note sheet")
        let skip = app.buttons["row-swipe-skip"].frame, note = app.buttons["row-swipe-note"].frame
        XCTAssertGreaterThan(skip.minX, note.minX, "Skip sits at the edge, Note beside it")
        XCTAssertGreaterThanOrEqual(min(skip.width, note.width), 44, "Both buttons are at least Apple's 44-point target (iOS draws them 50 wide)")
        shot("r08-swipe-left")
        app.buttons["row-swipe-skip"].tap()
        sleep(1)
        swipe(water, right: false)
        let undoSkip = app.buttons["Undo Skip"]
        XCTAssertTrue(undoSkip.waitForExistence(timeout: 3), "Skipped: the same swipe offers Undo Skip")
        undoSkip.tap()
    }

    /// ✓ toggles that day's tick (a weekly count too); + always adds, past the goal, and never takes one back.
    func testTickTogglesAndPlusAdds() {
        launch()
        let mark = app.buttons["Mark Call family done"]
        app.reveal(mark, clear: true)
        XCTAssertTrue(mark.exists)
        mark.tap()
        let undo = app.buttons["Undo Call family"]
        XCTAssertTrue(undo.waitForExistence(timeout: 3), "✓ ticks today")
        undo.tap()
        XCTAssertTrue(app.buttons["Mark Call family done"].waitForExistence(timeout: 3), "The same ✓ takes today's tick back")
        let plus = app.buttons["Add 1 glass to Water"]
        app.reveal(plus, clear: true)
        plus.tap(); sleep(1)
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH '9/8 glasses'")).firstMatch.waitForExistence(timeout: 3),
                      "+ adds past the goal")
        plus.tap(); sleep(1)
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH '10/8 glasses'")).firstMatch.waitForExistence(timeout: 3),
                      "+ adds again, never takes one back")
        shot("r09-plus-adds")
    }

    /// Touch and hold: the sheet's actions (Open Habit Page, Add Entry, Skip, Pause, a named Undo), no Delete, and no
    /// "Edit Today's Progress…" (a tap does that now).
    func testLongPressMenu() {
        launch()
        let water = app.staticTexts["Water"].firstMatch
        app.reveal(water, clear: true)
        water.press(forDuration: 1.2)
        let open = app.buttons["Open Habit Page"]
        XCTAssertTrue(open.waitForExistence(timeout: 3))
        XCTAssertTrue(app.buttons["Add Entry…"].exists)
        XCTAssertTrue(app.buttons["Skip Today"].exists)
        XCTAssertTrue(app.buttons["Pause…"].exists)
        XCTAssertTrue(app.buttons["Undo +1 glass"].exists, "Undo names what it takes back")
        XCTAssertFalse(app.buttons["Edit Today's Progress…"].exists)
        XCTAssertFalse(app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Delete'")).firstMatch.exists, "No Delete")
        shot("r10-long-press")
        open.tap()
        XCTAssertTrue(app.segmentedControls["habit-tabs"].waitForExistence(timeout: 5), "Open Habit Page from Today")
        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 5), "Back to Today")
    }
}
