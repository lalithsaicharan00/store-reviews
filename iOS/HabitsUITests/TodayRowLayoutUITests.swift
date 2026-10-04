import XCTest

/// Today's row layout (3 Oct 2026; checklist "Today — Row Layout, Subtext, Notes and the Task Sheet", report "Today's
/// Rows — The Line Under the Name, Notes and Spacing"): one line under every name, the same kind of fact on every row;
/// after a log, Undo and Add Note as small buttons on one line; a note written in its own sheet with Save, then Edit
/// Note; a task's row opens a sheet shaped for a task; a quit row shows its best run and logs a slip from a swipe.
final class TodayRowLayoutUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = true
        app = XCUIApplication()
    }

    /// The demo habits; with `tasks`, the task fixture instead (an old one-time task carried to today, a repeating one).
    private func launch(tasks: Bool = false) {
        app.launchArguments = tasks ? ["-uitest", "-free", "-task-fixture"] : ["-uitest"]
        app.launch()
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 10))
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

    private func line(containing text: String) -> XCUIElement {
        app.staticTexts.matching(NSPredicate(format: "identifier == 'habit-line' AND label CONTAINS %@", text)).firstMatch
    }

    /// Every kind of row has exactly one line under its name, on one line: an amount, a weekly count, a quit habit (a
    /// task's is checked with the task fixture below).
    func testOneLineUnderEveryName() {
        launch()
        for (name, start) in [("Water", "/8 glasses"), ("Call family", "this week"), ("Smoking", "Best")] {
            let row = app.staticTexts[name].firstMatch
            app.reveal(row, clear: true)
            XCTAssertTrue(row.exists, name)
            let text = line(containing: start)
            XCTAssertTrue(text.exists, "\(name)'s line says \"\(start)\": " + app.staticTexts.matching(identifier: "habit-line").allElementsBoundByIndex.map(\.label).joined(separator: " | "))
            XCTAssertLessThan(text.frame.height, 26, "\(name)'s line stays on one line")
            XCTAssertLessThan(abs(text.frame.minY - row.frame.maxY), 8, "\(name)'s line sits right under the name")
        }
        XCTAssertFalse(app.buttons["Slipped"].exists, "No \"Slipped\" line under the quit row")
        shot("l01-rows")
    }

    /// After a log: the named Undo and Add Note sit side by side on one line, never wrapped. Add Note opens a sheet with
    /// Save (never a field in the row); once there's a note, the button says Edit Note.
    func testAfterLogButtonsAndNoteSheet() {
        launch()
        let plus = app.buttons["Add 1 glass to Water"]
        app.reveal(plus, clear: true)
        plus.tap()
        let undo = app.buttons["habit-inline-undo"]
        let add = app.buttons["habit-add-note"]
        XCTAssertTrue(undo.waitForExistence(timeout: 3) && add.exists, "Undo and Add Note after a log")
        XCTAssertEqual(undo.label, "Undo +1 glass", "Undo says what it takes back")
        XCTAssertLessThan(abs(undo.frame.midY - add.frame.midY), 2, "Undo and Add Note on one line")
        XCTAssertLessThan(undo.frame.height, 40, "Undo never wraps onto a second line")
        XCTAssertLessThan(undo.frame.maxX, add.frame.minX, "Side by side, Undo first")
        shot("l02-after-log")
        add.tap()
        XCTAssertTrue(app.navigationBars["Add Note"].waitForExistence(timeout: 3), "Add Note opens its own sheet")
        let field = app.descendants(matching: .any)["note-field"].firstMatch
        XCTAssertTrue(field.waitForExistence(timeout: 3))
        for key in ["F", "e", "l", "t", " ", "g", "o", "o", "d"] { field.typeText(key) }
        shot("l03-note-sheet")
        app.navigationBars["Add Note"].buttons["Save"].tap()
        XCTAssertTrue(app.navigationBars["Add Note"].waitForNonExistence(timeout: 3), "Save closes it")
        XCTAssertTrue(app.buttons["habit-edit-note"].waitForExistence(timeout: 3), "Once there's a note: Edit Note")
        XCTAssertFalse(app.staticTexts["Felt good"].exists, "The note's text isn't in the row")
        shot("l04-edit-note")
        app.buttons["habit-edit-note"].tap()
        XCTAssertTrue(app.navigationBars["Edit Note"].waitForExistence(timeout: 3), "Edit Note opens the same sheet")
        XCTAssertTrue(app.buttons["Delete Note"].exists, "A note can be deleted from it")
        app.navigationBars["Edit Note"].buttons["Cancel"].tap()
    }

    /// A task's row opens its own sheet: Done, its date and Do Tomorrow, the note, Edit Task; no day paging.
    func testTaskRowOpensItsSheet() {
        launch(tasks: true)
        let task = app.staticTexts["Old task"].firstMatch
        app.reveal(task, clear: true)
        XCTAssertTrue(task.exists, "The old task is carried to today")
        XCTAssertTrue(line(containing: "Task · From").exists, "A task's line says it's a task, and where it came from: "
                      + app.staticTexts.matching(identifier: "habit-line").allElementsBoundByIndex.map(\.label).joined(separator: " | "))
        shot("l05a-task-row")
        task.tap()
        XCTAssertTrue(app.navigationBars["Today · Old task"].waitForExistence(timeout: 5), "The task's sheet")
        XCTAssertTrue(app.switches["day-done"].exists, "Done")
        XCTAssertTrue(app.descendants(matching: .any)["day-task-date"].firstMatch.exists, "Its date")
        XCTAssertFalse(app.buttons["day-previous"].exists, "A one-time task doesn't page through days")
        let tomorrow = app.buttons["day-do-tomorrow"]
        let form = app.collectionViews["day-form"]
        for _ in 0..<4 where !(tomorrow.exists && tomorrow.isHittable) { form.swipeUp(velocity: .slow) }
        XCTAssertTrue(app.buttons["day-edit-habit"].exists, "Edit Task")
        shot("l05-task-sheet")
        tomorrow.tap()
        XCTAssertTrue(app.navigationBars["Today · Old task"].waitForNonExistence(timeout: 3), "Do Tomorrow closes it")
        XCTAssertTrue(app.staticTexts["Old task"].waitForNonExistence(timeout: 5), "The task moved to tomorrow")
    }

    /// A quit row: one line (its best run), the live count on the right, and Log Slip on the swipe where the "Slipped"
    /// button was.
    func testQuitRowSwipeLogsASlip() {
        launch()
        let smoking = app.staticTexts["Smoking"].firstMatch
        app.reveal(smoking, clear: true)
        smoking.swipeLeft()
        let slip = app.buttons["row-swipe-slip"]
        XCTAssertTrue(slip.waitForExistence(timeout: 3), "Swipe left: Log Slip")
        shot("l06-quit-swipe")
        slip.tap()
        XCTAssertTrue(app.navigationBars["Log a Slip"].waitForExistence(timeout: 3), "Log Slip opens Log a Slip")
        app.buttons["slip-save"].tap()
        let undo = app.buttons["habit-inline-undo"]
        XCTAssertTrue(undo.waitForExistence(timeout: 3), "After a slip: Undo Slip, as after any log")
        XCTAssertEqual(undo.label, "Undo Slip")
        shot("l07-after-slip")
        undo.tap()
        XCTAssertTrue(undo.waitForNonExistence(timeout: 3))
    }
}
