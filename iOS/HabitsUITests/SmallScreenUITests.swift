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

    /// Habit details → Progress (spec "Habit Progress" §2, 11 Oct 2026): the whole Overall record, its four boxes
    /// included, is on screen without scrolling (it ends at about 610 pt of the SE's 667).
    func testOverallRecordFitsWithoutScrolling() {
        app.launchArguments = ["-uitest", "-year-demo", "-appearance.theme", "dark"]
        app.launch()
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 10), "Today")
        let habits = app.buttons["menu-habits"]
        app.buttons["menu-button"].tap()
        if !habits.waitForExistence(timeout: 5) { app.buttons["menu-button"].tap() }
        XCTAssertTrue(habits.waitForExistence(timeout: 10), "The ≡ menu")
        habits.tap()
        XCTAssertTrue(app.navigationBars["Habits"].waitForExistence(timeout: 5), "Habits")
        app.revealAndTap(app.staticTexts["Water"].firstMatch)
        let progress = app.segmentedControls["habit-tabs"].buttons["Progress"]
        XCTAssertTrue(progress.waitForExistence(timeout: 5), "Water's page")
        progress.tap()
        if !progress.wait(for: \.isSelected, toEqual: true, timeout: 5) { progress.tap() }
        let ids = ["habit-progress-record", "habit-record-headline", "habit-streak-current", "habit-streak-best",
                   "habit-record-goal-met", "habit-record-best-period"]
        let record = app.descendants(matching: .any)["habit-progress-record"]
        XCTAssertTrue(record.waitForExistence(timeout: 5), "Overall record")
        // The spec's layout (ends at about 610 pt) has "What the squares mean" folded; until the person folds it once,
        // it's open and pushes the card down (run 38039012506: 521–838 pt), a picture of which is kept for the user.
        shot("se-progress-record-key-open")
        let key = app.descendants(matching: .any)["progress-key"]
        if key.exists {
            app.buttons["heat-key-toggle"].tap()
            XCTAssertTrue(key.waitForNonExistence(timeout: 3), "The key folds")
        }
        sleep(1)
        XCTAssertTrue(record.frame.minY >= 0 && record.frame.maxY <= window.maxY, "The Overall record fits: " + frames(ids))
        for id in ids.dropFirst() {
            XCTAssertTrue(app.descendants(matching: .any)[id].isHittable, "\(id) is on screen: " + frames(ids))
        }
        shot("se-progress-record")
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

    // MARK: Privacy & Security on the smallest iPhone (Current Work 58, T15), at an accessibility text size

    /// The cover with its keypad: every key, Forgot Code? and the dots on screen, at the largest accessibility size too.
    func testLockKeypadFitsAtAccessibilitySizes() {
        for size in ["UICTContentSizeCategoryL", "UICTContentSizeCategoryAccessibilityL"] {
            app.terminate()
            app.launchArguments = ["-uitest", "-empty", "-test-lock", "code", "-test-lock-code", "123456", "-test-lock-fresh",
                                   "-test-face", "none", "-UIPreferredContentSizeCategoryName", size]
            app.launch()
            let ids = ["code-dots", "code-key-1", "code-key-3", "code-key-0", "code-delete", "lock-forgot"]
            XCTAssertTrue(app.buttons["code-key-1"].waitForExistence(timeout: 10), frames(ids))
            shot("se-lock-keypad-\(size)")
            // At an accessibility size the cover scrolls; each key is reachable and whole.
            for id in ids {
                let element = app.descendants(matching: .any)[id].firstMatch
                for _ in 0..<4 where !element.isHittable { app.swipeUp() }
                XCTAssertTrue(element.isHittable && element.frame.maxY <= window.maxY, "\(id) on screen (\(size)): \(frames(ids))")
            }
            for digit in "123456" { app.buttons["code-key-\(digit)"].tap() }
            XCTAssertFalse(app.descendants(matching: .any)["app-lock-cover"].waitForExistence(timeout: 1) && app.buttons["code-key-1"].isHittable,
                           "The code opens it (\(size))")
        }
    }

    /// Set Up App Lock at the default text size (App Lock Redesign §8: screens 3–7 were designed on the SE and fit
    /// without scrolling): both choices above the button, and every rule of "How your app passcode works" above its
    /// button. Frames named on one line (T14).
    func testAppLockSetupFitsWithoutScrolling() {
        app.launchArguments = ["-uitest", "-empty"]
        app.launch()
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 10))
        app.buttons["menu-button"].tap()
        XCTAssertTrue(app.buttons["menu-privacy"].waitForExistence(timeout: 5))
        app.buttons["menu-privacy"].tap()
        XCTAssertTrue(app.buttons["privacy-app-lock"].waitForExistence(timeout: 5))
        app.buttons["privacy-app-lock"].tap()
        let lock = app.switches["privacy-lock"]
        XCTAssertTrue(lock.waitForExistence(timeout: 5))
        lock.coordinate(withNormalizedOffset: CGVector(dx: 0.92, dy: 0.5)).tap()
        let passcode = app.buttons["setup-app-passcode"], turnOn = app.buttons["setup-continue"]
        XCTAssertTrue(passcode.waitForExistence(timeout: 5) && turnOn.exists)
        let ids = ["setup-face-id", "setup-iphone-passcode", "setup-app-passcode", "setup-continue"]
        XCTAssertLessThanOrEqual(passcode.frame.maxY, turnOn.frame.minY, "Both choices above the button: \(frames(ids))")
        XCTAssertLessThanOrEqual(turnOn.frame.maxY, window.maxY, frames(ids))
        shot("se-setup-choose-default")
        passcode.tap()
        app.buttons["setup-continue"].tap()
        let create = app.buttons["setup-create-app-passcode"]
        XCTAssertTrue(create.waitForExistence(timeout: 5))
        let last = app.descendants(matching: .any).matching(NSPredicate(format: "label CONTAINS 'cancel it if it wasn'")).firstMatch
        XCTAssertTrue(last.exists)
        XCTAssertLessThanOrEqual(last.frame.maxY, create.frame.minY, "The last rule above Create App Passcode: rule \(last.frame), button \(create.frame)")
        shot("se-setup-how-it-works-default")
    }

    /// iCloud & Backup (Architecture 11 §17), the second-device sheet (the Plus screens' image 16) and Restore From a
    /// Backup on the SE: sync's status and its one action without scrolling in each state that needs the person, and the
    /// sheet's two choices. Frames on one line (T14).
    func testICloudPageSecondDeviceAndRestoreFit() {
        for state in ["full", "held", "synced"] {
            app.terminate()
            app.launchArguments = ["-uitest", "-test-cloud", state]
            app.launch()
            XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 10))
            app.buttons["menu-button"].tap()
            XCTAssertTrue(app.buttons["menu-backup"].waitForExistence(timeout: 5))
            app.buttons["menu-backup"].tap()
            let action = app.buttons[state == "full" ? "cloud-manage-storage" : state == "held" ? "cloud-apply-held" : "cloud-sync-now"]
            XCTAssertTrue(action.waitForExistence(timeout: 20), "\(state): \(frames(["cloud-status"]))")
            XCTAssertLessThanOrEqual(action.frame.maxY, window.maxY, "\(state): \(frames(["cloud-status", "cloud-sync-now", "cloud-manage-storage", "cloud-apply-held"]))")
            shot("se-icloud-\(state)")
        }
        let restore = app.buttons["backup-restore"]
        for _ in 0..<4 where !restore.isHittable { app.collectionViews.containing(.button, identifier: "backup-restore").firstMatch.swipeUp() }
        restore.tap()
        let file = app.buttons["restore-import"]
        XCTAssertTrue(file.waitForExistence(timeout: 5))
        XCTAssertLessThanOrEqual(file.frame.maxY, window.maxY, frames(["restore-icloud", "restore-import"]))
        shot("se-restore-from-a-backup")

        app.terminate()
        app.launchArguments = ["-uitest", "-free", "-test-cloud", "free-other"]
        app.launch()
        let move = app.buttons["second-device-move"]
        XCTAssertTrue(move.waitForExistence(timeout: 20))
        XCTAssertLessThanOrEqual(move.frame.maxY, window.maxY, "Both choices without scrolling: \(frames(["second-device-title", "second-device-see-plus", "second-device-move"]))")
        shot("se-second-device-sheet")
    }

    /// Privacy & Security, App Lock, Set Up App Lock (screens 3–6 of the App Lock redesign, designed on the SE) and the
    /// habit form's Reminders with Reminder Says, at a large text size. Every screen's button stays on screen.
    func testPrivacyCodeSheetsAndReminderSaysFit() {
        app.launchArguments = ["-uitest", "-empty", "-UIPreferredContentSizeCategoryName", "UICTContentSizeCategoryAccessibilityM"]
        app.launch()
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 10))
        app.buttons["menu-button"].tap()
        // At this text size the menu is taller than the SE: scroll it (not Today) to Privacy & Security.
        if !app.buttons["menu-privacy"].waitForExistence(timeout: 3) { app.buttons["menu-appearance"].swipeUp() }
        app.buttons["menu-privacy"].tap()
        let lockRow = app.buttons["privacy-app-lock"]
        XCTAssertTrue(lockRow.waitForExistence(timeout: 5))
        XCTAssertTrue(lockRow.frame.maxY <= window.maxY, "The App Lock row on screen: \(lockRow.frame)")
        shot("se-privacy-off")
        lockRow.tap()
        let lock = app.switches["privacy-lock"]
        XCTAssertTrue(lock.waitForExistence(timeout: 5))
        shot("se-app-lock-off")
        lock.coordinate(withNormalizedOffset: CGVector(dx: 0.92, dy: 0.5)).tap()
        let passcode = app.buttons["setup-app-passcode"]
        XCTAssertTrue(passcode.waitForExistence(timeout: 5))
        let turnOn = app.buttons["setup-continue"]
        XCTAssertTrue(turnOn.isHittable && turnOn.frame.maxY <= window.maxY, frames(["setup-face-id", "setup-iphone-passcode", "setup-app-passcode", "setup-continue"]))
        shot("se-setup-choose")
        // At this text size the sheet scrolls: its own list, never Today's behind it (T9).
        let sheetList = app.collectionViews.containing(.button, identifier: "setup-app-passcode").firstMatch
        for _ in 0..<5 where passcode.frame.maxY > turnOn.frame.minY { sheetList.swipeUp() }
        XCTAssertLessThanOrEqual(passcode.frame.maxY, turnOn.frame.minY, "App Passcode scrolls into view above the button: \(frames(["setup-app-passcode", "setup-continue"]))")
        shot("se-setup-choose-scrolled")
        passcode.tap()
        let next = app.buttons["setup-continue"]
        XCTAssertTrue(next.waitForExistence(timeout: 5))
        XCTAssertTrue(next.isHittable && next.frame.maxY <= window.maxY, frames(["setup-app-passcode", "setup-continue"]))
        next.tap()
        let create = app.buttons["setup-create-app-passcode"]
        XCTAssertTrue(create.waitForExistence(timeout: 5))
        XCTAssertTrue(create.isHittable && create.frame.maxY <= window.maxY, "Create App Passcode on screen: \(create.frame), window \(window)")
        shot("se-setup-how-it-works")
        // The App Passcode way has nothing else to check: straight to the passcode.
        create.tap()
        let ids = ["code-dots", "code-key-1", "code-key-0", "code-delete"]
        XCTAssertTrue(app.buttons["code-key-1"].waitForExistence(timeout: 5), frames(ids))
        shot("se-setup-enter")
        for digit in "123456" { app.buttons["code-key-\(digit)"].tap() }
        XCTAssertTrue(app.staticTexts["Enter it again"].waitForExistence(timeout: 5), frames(ids))
        shot("se-setup-again")
        for digit in "123456" { app.buttons["code-key-\(digit)"].tap() }
        XCTAssertTrue(app.buttons["privacy-change-code"].waitForExistence(timeout: 5), frames(["privacy-lock", "unlock-app-passcode", "privacy-change-code", "privacy-lock-again"]))
        shot("se-app-lock-on")
        app.terminate()

        // The habit form's Reminders: Reminder Says under the times, above the keyboard while typing.
        app.launchArguments = ["-uitest", "-empty", "-UIPreferredContentSizeCategoryName", "UICTContentSizeCategoryAccessibilityM"]
        app.launch()
        let new = app.navigationBars.buttons["New Habit"].firstMatch
        XCTAssertTrue(new.waitForExistence(timeout: 10)); new.tap()
        func row(_ prefix: String) -> XCUIElement { app.buttons.matching(NSPredicate(format: "label BEGINSWITH %@", prefix)).firstMatch }
        row("Build or maintain,").tap(); row("Check it off,").tap()
        // A name first, as people fill the form; then the form itself scrolls to Reminders (drags that began on the
        // name field focused it and pulled the sheet down: runs 37881272574, 37883783862).
        let name = app.descendants(matching: .any)["name-field"]
        XCTAssertTrue(name.waitForExistence(timeout: 5)); name.tap(); name.typeText("Private habit\n")
        let form = app.collectionViews["habit-form"]
        let reminders = app.descendants(matching: .any)["reminders-row"]
        for _ in 0..<12 where !(reminders.exists && reminders.isHittable) { form.swipeUp(velocity: .slow) }
        XCTAssertTrue(reminders.isHittable, frames(["reminders-row"]))
        reminders.tap()
        let remind = app.switches["Remind Me"]
        XCTAssertTrue(remind.waitForExistence(timeout: 5))
        remind.coordinate(withNormalizedOffset: CGVector(dx: 0.92, dy: 0.5)).tap()
        let says = app.textFields["reminder-says-field"]
        for _ in 0..<8 where !(says.exists && says.isHittable) { app.collectionViews.firstMatch.swipeUp(velocity: .slow) }
        XCTAssertTrue(says.isHittable, frames(["reminder-says-field"]))
        says.tap(); says.typeText("The usual")
        XCTAssertTrue(keyboard.waitForExistence(timeout: 5))
        aboveKeyboard(says, "Reminder Says")
        shot("se-reminder-says")
    }

    /// Today's after-log line never runs past the row (the user, 9 Oct 2026: a long step name in Undo pushed Add Note off
    /// the screen). A step's Undo is "Undo Last Step"; an amount's names it ("Undo +1 tablespoon"); at the largest text
    /// that still shows words, both stay on one line inside the row (there Add Note shows only its icon, so Undo keeps
    /// its words).
    func testAfterLogLineStaysInsideTheRow() {
        app.launchArguments = ["-uitest", "-longtext", "-clock-hour", "9", "-UIPreferredContentSizeCategoryName", "UICTContentSizeCategoryXXXL"]
        app.launch()
        func button(_ prefix: String) -> XCUIElement { app.buttons.matching(NSPredicate(format: "label BEGINSWITH %@", prefix)).firstMatch }
        XCTAssertTrue(button("Add 1 tablespoon").waitForExistence(timeout: 20), "The sample habits are there")
        func checkLine(_ what: String, label expected: String) {
            let undo = app.buttons["habit-inline-undo"], add = app.buttons["habit-add-note"]
            XCTAssertTrue(undo.waitForExistence(timeout: 3) && add.exists, "\(what): Undo and Add Note after a log")
            XCTAssertEqual(undo.label, expected, what)
            let line = "\(what): undo \(undo.frame), add note \(add.frame), window \(window)"
            XCTAssertLessThan(abs(undo.frame.midY - add.frame.midY), 2, "On one line: " + line)
            XCTAssertLessThan(undo.frame.height, 44, "Undo never wraps: " + line)
            XCTAssertLessThan(undo.frame.maxX, add.frame.minX, "Undo first, apart from Add Note: " + line)
            XCTAssertLessThanOrEqual(add.frame.maxX, window.maxX, "Add Note whole on screen: " + line)
            XCTAssertGreaterThanOrEqual(undo.frame.minX, window.minX, "Undo on screen: " + line)
        }
        // A checklist step at its 24-character limit.
        let step = button("Mark Double cleanse")
        if !step.exists {
            // The morning routine's card folds its habits (named Morning, or Before breakfast with long names).
            let section = app.buttons.matching(NSPredicate(format: "label == 'Open Morning' OR label == 'Open Before breakfast'")).firstMatch
            if app.reveal(section, clear: true) { section.tap() }
            let show = button("Show Morning skincare")
            XCTAssertTrue(app.reveal(show, clear: true), "The checklist row is on Today")
            show.tap()
        }
        // The sample day has every step done: untick the long one first, so ticking it logs and offers Undo.
        let done = button("Undo Double cleanse")
        XCTAssertTrue(app.reveal(step, clear: true) || app.reveal(done, clear: true), "The long step is shown")
        if done.exists { done.tap(); XCTAssertTrue(step.waitForExistence(timeout: 3), "Unticked") }
        step.tap()
        checkLine("A long step", label: "Undo Last Step")
        shot("se-after-log-step")
        // An amount with the longest unit.
        let plus = button("Add 1 tablespoon")
        XCTAssertTrue(app.reveal(plus, clear: true), "The amount row is on Today")
        plus.tap()
        checkLine("A long unit", label: "Undo +1 tablespoon")
        shot("se-after-log-amount")
    }
}
