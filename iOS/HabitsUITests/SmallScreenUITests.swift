import XCTest

/// The 7 Oct 2026 redesign on the smallest iPhone (design decisions §2–3: designed for the iPhone SE first). Run on an
/// iPhone SE simulator with the workflow's `device` input ("iPhone SE (3rd generation)"); on a larger iPhone the same
/// checks pass with room to spare, and the SE-only layout (Date and Time in one row, the footer hidden while typing) is
/// checked only when the screen is SE-sized. Every typing field stays above the keyboard with the main button visible,
/// and Day details with four logs and a note keeps Skip today on screen.
final class SmallScreenUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = true
        app = XCUIApplication()
    }

    override func record(_ issue: XCTIssue) {
        var issue = issue
        let shot = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        shot.name = "FAIL-\(name)"
        shot.lifetime = .keepAlways
        issue.add(shot)
        super.record(issue)
    }

    private func shot(_ name: String) {
        let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    private var window: CGRect { app.windows.firstMatch.frame }
    /// An iPhone SE-sized screen (667 pt tall).
    private var isSmall: Bool { window.height < 700 }
    private var keyboard: XCUIElement { app.keyboards.firstMatch }

    /// Where each named element is, on one line, for a failure message (Rulebook T14).
    private func frames(_ ids: [String]) -> String {
        ids.map { id in
            let e = app.descendants(matching: .any)[id].firstMatch
            return e.exists ? "\(id) \(Int(e.frame.minY))–\(Int(e.frame.maxY))" : "\(id) none"
        }.joined(separator: ", ") + ", window \(Int(window.height))" + (keyboard.exists ? ", keyboard \(Int(keyboard.frame.minY))" : "")
    }

    private func launch(_ arguments: [String]) {
        app.launchArguments = ["-uitest", "-day-details-fixture", "-appearance.theme", "dark"] + arguments
        app.launch()
    }

    /// `element` is fully on screen, above the keyboard (one line naming what was where, Rulebook T14).
    private func aboveKeyboard(_ element: XCUIElement, _ what: String, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertTrue(element.exists, "\(what) exists", file: file, line: line)
        XCTAssertTrue(element.isHittable, "\(what) can be tapped: \(element.frame)", file: file, line: line)
        XCTAssertLessThanOrEqual(element.frame.maxY, keyboard.frame.minY + 1,
                                 "\(what) \(element.frame) is above the keyboard at \(keyboard.frame.minY)", file: file, line: line)
        XCTAssertGreaterThanOrEqual(element.frame.minY, 0, "\(what) is below the top edge", file: file, line: line)
    }

    func testAddLogFitsAboveTheKeyboard() {
        launch(["-open-add", "Water"])
        XCTAssertTrue(app.navigationBars["Add log"].waitForExistence(timeout: 30))
        XCTAssertTrue(keyboard.waitForExistence(timeout: 5), "The decimal pad is up as Add log opens")
        let amount = app.textFields["record-amount"]
        aboveKeyboard(amount, "The amount")
        aboveKeyboard(app.buttons["record-add"], "Add")
        XCTAssertGreaterThan(app.buttons["record-add"].frame.minY, amount.frame.maxY,
                             "Add is under the amount: " + frames(["record-habit", "record-date", "record-time", "record-amount", "record-add"]))
        if isSmall {
            let date = app.descendants(matching: .any)["record-date"].firstMatch
            let time = app.descendants(matching: .any)["record-time"].firstMatch
            XCTAssertEqual(date.frame.midY, time.frame.midY, accuracy: 4, "SE, keyboard up: Date and Time share one row")
            XCTAssertFalse(app.staticTexts["record-footer"].exists, "SE, keyboard up: the footer hides")
        }
        amount.typeText("2")
        aboveKeyboard(amount, "The typed amount")
        shot("se-add-log")
    }

    func testAddTimeFitsAboveTheKeyboard() {
        launch(["-open-add", "Read"])
        XCTAssertTrue(app.navigationBars["Add log"].waitForExistence(timeout: 30))
        XCTAssertTrue(keyboard.waitForExistence(timeout: 5))
        for id in ["record-hours", "record-minutes", "record-seconds"] { aboveKeyboard(app.textFields[id], id) }
        aboveKeyboard(app.buttons["record-add"], "Add")
        shot("se-add-time")
    }

    func testEditLogFitsAboveTheKeyboard() {
        launch(["-open-day", "Water"])
        let link = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'entry-'")).firstMatch
        XCTAssertTrue(link.waitForExistence(timeout: 30))
        link.tap()
        XCTAssertTrue(app.navigationBars["Log"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons["record-delete"].isHittable && app.buttons["record-edit"].isHittable, "Delete log | Edit on screen")
        app.buttons["record-edit"].tap()
        XCTAssertTrue(keyboard.waitForExistence(timeout: 5))
        aboveKeyboard(app.textFields["record-amount"], "The amount")
        aboveKeyboard(app.buttons["record-save"], "Save")
        shot("se-edit-log")
    }

    func testNoteBoxFillsTheRoomAboveSave() {
        launch(["-open-day", "Water"])
        let add = app.buttons["day-add-note"]
        XCTAssertTrue(add.waitForExistence(timeout: 30))
        add.tap()
        XCTAssertTrue(app.navigationBars["Add note"].waitForExistence(timeout: 5))
        XCTAssertTrue(keyboard.waitForExistence(timeout: 5), "Typing first")
        let box = app.textViews["note-field"]
        let save = app.buttons["note-save"]
        aboveKeyboard(save, "Save")
        XCTAssertLessThanOrEqual(box.frame.maxY, save.frame.minY + 1, "The box ends above Save")
        XCTAssertGreaterThan(box.frame.height, 100, "The box has room to write: \(box.frame)")
        shot("se-add-note")
    }

    /// The case that started it (Current Work 59): four logs and a note pushed Skip off the SE. Now: the two newest,
    /// "All 4 logs", the note inside This day, and Skip today on screen without scrolling.
    func testDayDetailsKeepsSkipOnScreenWithFourLogsAndANote() {
        launch(["-open-day", "Water"])
        let plus = app.buttons["day-add-step"]
        XCTAssertTrue(plus.waitForExistence(timeout: 30))
        plus.tap(); usleep(500_000); plus.tap(); usleep(500_000)
        app.buttons["day-add-note"].tap()
        let box = app.textViews["note-field"]
        XCTAssertTrue(box.waitForExistence(timeout: 5))
        box.tap()
        box.typeText("Big glass after the run. The office bottle was only half full.")
        app.buttons["note-save"].tap()
        XCTAssertTrue(app.buttons["day-edit-note"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons["day-all-logs"].exists, "Four logs: All 4 logs")
        let skip = app.buttons["day-skip"]
        let layout = frames(["day-identity", "day-result", "day-add-step", "day-edit-note", "day-all-logs", "day-skip"])
        XCTAssertTrue(skip.exists, "Skip today is drawn without scrolling: " + layout)
        if skip.exists {
            XCTAssertTrue(skip.isHittable, "Skip today is on screen: " + layout)
            XCTAssertLessThanOrEqual(skip.frame.maxY, window.maxY, "Skip today ends on screen: " + layout)
        }
        shot("se-day-details-four-logs-note")
    }
}
