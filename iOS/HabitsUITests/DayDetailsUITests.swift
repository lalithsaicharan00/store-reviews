import XCTest

/// Day details, the Log view and Edit log, All logs and the Add screen for every kind of habit (7 Oct 2026 redesign;
/// Rulebook U14–U19, U21, U22, T3). Each kind opens from its row on Today, titled with the day; says what that day holds
/// in its own words; offers its own buttons; shows its logs (at most three rows, then "All N logs"); opens a log as a
/// view first (Delete | Edit), then edit mode with Save; and adds through one Add screen per kind. Screenshots of every
/// state, light and dark, for the design review on the iPhone (U9).
final class DayDetailsUITests: XCTestCase {
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

    /// The mixed fixture: an amount, several checks a day, a checklist, a timer, a limit and a task, plus a weekly
    /// check and month, year and flexible goals. Without it, the usual demo (with a quit habit).
    private func launch(fixture: Bool = true, dark: Bool = false, extra: [String] = []) {
        var arguments = ["-uitest"]
        if fixture { arguments += ["-focus-fixture", "-focus-period-fixture"] }
        arguments += ["-appearance.theme", dark ? "dark" : "light"] + extra
        app.launchArguments = arguments
        app.launch()
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 10))
    }

    /// The Day-details fixture with one habit's Add screen open at launch (`-open-add`).
    private func launchAdd(_ name: String, dark: Bool = false, offset: Int? = nil, extra: [String] = []) {
        var arguments = ["-uitest", "-day-details-fixture", "-appearance.theme", dark ? "dark" : "light", "-open-add", name]
        if let offset { arguments += ["-open-day-offset", String(offset)] }
        app.launchArguments = arguments + extra
        app.launch()
    }

    private var result: XCUIElement { app.descendants(matching: .any)["day-result"].firstMatch }
    private var form: XCUIElement { app.collectionViews["day-form"] }
    /// The day's log rows that open a Log view.
    private var links: XCUIElementQuery {
        app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'entry-'"))
    }
    private var undoRows: XCUIElementQuery {
        app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'undo-entry-'"))
    }

    private func open(_ name: String) {
        let row = app.staticTexts[name].firstMatch
        app.reveal(row, clear: true)
        row.tap()
        XCTAssertTrue(result.waitForExistence(timeout: 5), "\(name)'s row opens Day details")
        XCTAssertTrue(app.navigationBars["Today"].exists, "\(name): titled with the day")
    }

    private func close() {
        app.buttons["day-close"].tap()
        XCTAssertTrue(result.waitForNonExistence(timeout: 5))
    }

    /// Scrolls the sheet's own list, not Today's behind it (Rulebook T9).
    private func inSheet(_ element: XCUIElement) {
        for _ in 0..<6 where !(element.exists && element.isHittable) { form.swipeUp(velocity: .slow) }
    }

    private func status(_ text: String, wait: TimeInterval = 3) -> Bool {
        app.staticTexts.matching(NSPredicate(format: "identifier == 'day-result' AND label == %@", text)).firstMatch.waitForExistence(timeout: wait)
    }

    /// What's on screen, on one line, for a failure message (Rulebook T14).
    private var shown: String {
        let labels = app.staticTexts.allElementsBoundByIndex.prefix(40).map(\.label).filter { !$0.isEmpty }
        return labels.joined(separator: " | ")
    }

    private func button(_ id: String, _ label: String, enabled: Bool = true, file: StaticString = #filePath, line: UInt = #line) {
        let b = app.buttons[id]
        XCTAssertTrue(b.exists, "\(id) exists", file: file, line: line)
        XCTAssertEqual(b.label, label, file: file, line: line)
        XCTAssertEqual(b.isEnabled, enabled, "\(label) enabled", file: file, line: line)
    }

    private func footer(contains text: String, file: StaticString = #filePath, line: UInt = #line) {
        let footer = app.staticTexts["record-footer"]
        XCTAssertTrue(footer.waitForExistence(timeout: 3), "A footer says what will happen", file: file, line: line)
        XCTAssertTrue(footer.label.contains(text), "Footer: \(footer.label)", file: file, line: line)
    }

    // MARK: Day details

    /// Every kind: its status in its own words and its own buttons (one rule per kind, design decisions §8); a limit and
    /// a task have no Skip; no empty logs.
    func testEveryKindShowsItsOwnDay() {
        launch()
        open("Drink water")
        XCTAssertTrue(status("1 of 2 glasses"), "An amount: how far along")
        // "+1" on screen, exactly as Today's round button; VoiceOver says it in full (U16).
        button("day-add-step", "Add 1 glass")
        button("day-add-entry", "Log manually")
        XCTAssertEqual(app.buttons["day-add-step"].frame.height, app.buttons["day-add-entry"].frame.height, accuracy: 1,
                       "The two logging buttons are the same size")
        XCTAssertEqual(app.buttons["day-add-step"].frame.minY, app.buttons["day-add-entry"].frame.minY, accuracy: 1,
                       "in one row")
        XCTAssertTrue(app.staticTexts["Today's logs"].exists, "Its logs, under a heading")
        XCTAssertEqual(links.count, 1, "One row per log")
        XCTAssertTrue(app.buttons["day-add-note"].exists, "The note for this day, in the card")
        XCTAssertLessThan(app.buttons["day-add-note"].frame.maxY, app.staticTexts["Today's logs"].frame.minY,
                          "The note is in This day, above the logs")
        inSheet(app.buttons["day-skip"])
        button("day-skip", "Skip today")
        XCTAssertGreaterThan(app.buttons["day-skip"].frame.minY, links.firstMatch.frame.maxY, "Skip today is last")
        shot("dd-01-amount")
        close()

        open("Stretch")
        XCTAssertTrue(status("0 of 3 times"), "Several a day: times")
        button("day-add-one", "Add a check")
        XCTAssertFalse(app.staticTexts["Checks today"].exists, "No empty checks section")
        app.buttons["day-add-one"].tap()
        XCTAssertTrue(status("1 of 3 times"), "One check per tap")
        XCTAssertTrue(app.staticTexts["Checks today"].waitForExistence(timeout: 3), "The check, in its own row")
        XCTAssertTrue(undoRows.firstMatch.exists, "A single check has its own Undo, not an editor")
        XCTAssertEqual(links.count, 0, "and no chevron")
        shot("dd-02-several-checks")
        close()

        open("Clean kitchen")
        XCTAssertTrue(status("1 of 3 steps done"), "A checklist: its steps")
        let step = app.buttons["day-step-1"]
        XCTAssertTrue(step.exists)
        XCTAssertEqual(step.value as? String, "Not done")
        step.tap()
        XCTAssertTrue(status("2 of 3 steps done"), "A step ticks from the sheet")
        step.tap()
        XCTAssertTrue(status("1 of 3 steps done"), "and unticks")
        XCTAssertFalse(app.buttons["day-add-entry"].exists, "No logging button for a checklist: the steps are the controls")
        XCTAssertLessThan(step.frame.maxY, app.buttons["day-add-note"].frame.minY, "The steps sit above the note")
        shot("dd-03-checklist")
        close()

        open("Read a little")
        XCTAssertTrue(status("0 of 20 min"), "Time: how far along")
        button("day-start-timer", "Start timer")
        button("day-add-entry", "Log manually")
        app.buttons["day-start-timer"].tap()
        button("day-stop-timer", "Stop and save")
        XCTAssertTrue(app.staticTexts["day-running"].exists, "The running clock in the status")
        shot("dd-04-time-running")
        app.buttons["day-stop-timer"].tap()
        XCTAssertTrue(app.buttons["day-start-timer"].waitForExistence(timeout: 3))
        close()

        open("Less coffee")
        XCTAssertTrue(status("0 cups today"), "A limit is a fact, not a bar to fill")
        XCTAssertTrue(app.staticTexts["Limit 2 cups · within limit"].exists)
        button("day-add-step", "Add 1 cup")
        button("day-add-entry", "Log manually")
        XCTAssertFalse(app.buttons["day-skip"].exists, "A limit can't be skipped")
        shot("dd-05-limit")
        close()

        open("Water the plants")
        XCTAssertTrue(status("Not done"), "A task: done or not")
        button("day-done", "Mark done")
        XCTAssertFalse(app.buttons["day-skip"].exists, "A task has no Skip")
        XCTAssertFalse(app.buttons["day-open-page"].exists, "A task has no habit page")
        app.buttons["day-done"].tap()
        XCTAssertTrue(status("Done"))
        button("day-done", "Undo done")
        shot("dd-06-task-done")
        app.buttons["day-done"].tap()
        XCTAssertTrue(status("Not done"), "Undo done takes it back")
        close()

        open("Call family")
        XCTAssertTrue(status("Not checked today"), "A weekly goal: this day's checks first")
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label ENDSWITH ' this week'")).firstMatch.exists,
                      "The week as context")
        // Every check counts, even two on one day (Current Work 54): Add a check, never a day's done toggle.
        button("day-add-one", "Add a check")
        XCTAssertFalse(app.buttons["day-done"].exists, "No Mark done for a week count")
        app.buttons["day-add-one"].tap()
        XCTAssertTrue(status("1 time today"))
        app.buttons["day-add-one"].tap()
        XCTAssertTrue(status("2 times today"), "A second check the same day counts too")
        XCTAssertTrue(app.staticTexts["Checks today"].waitForExistence(timeout: 3), "Each check in its own row")
        shot("dd-07-weekly")
        undoRows.firstMatch.tap()
        XCTAssertTrue(status("1 time today"), "A check's Undo takes back that one only")
        close()

        open("Yearly distance")
        XCTAssertTrue(status("0 km today"), "A year's total: this day, then the year")
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label ENDSWITH ' this year'")).firstMatch.exists)
        button("day-add-step", "Add 5 km")
        shot("dd-08-yearly")
        close()
    }

    /// The logs rule (U17): one to three logs all shown with no extra row; four or more, the two newest and "All N logs",
    /// which opens All logs (every log, newest first, a total, no Close), whose rows open the Log view.
    func testLogsRuleAndAllLogs() {
        launch()
        open("Drink water")
        let add = app.buttons["day-add-step"]
        for count in 2...3 {
            add.tap()
            XCTAssertTrue(status("\(count) of 2 glasses"))
            XCTAssertEqual(links.count, count, "\(count) logs: all shown")
            XCTAssertFalse(app.buttons["day-all-logs"].exists, "\(count) logs: never an All logs row")
        }
        shot("dd-logs-three")
        add.tap()
        XCTAssertTrue(status("4 of 2 glasses"))
        XCTAssertEqual(links.count, 2, "Four logs: the two newest")
        let all = app.buttons["day-all-logs"]
        XCTAssertTrue(all.exists, "and All 4 logs")
        XCTAssertTrue(all.label.contains("All 4 logs"), "All logs row: \(all.label)")
        inSheet(app.buttons["day-skip"])
        XCTAssertTrue(app.buttons["day-skip"].isHittable, "Skip today still reachable")
        shot("dd-logs-four")
        all.tap()
        XCTAssertTrue(app.navigationBars["Today's logs"].waitForExistence(timeout: 3), "All logs, titled as the heading")
        XCTAssertEqual(links.count, 4, "Every log of the day")
        XCTAssertTrue(app.staticTexts["all-logs-footer"].label.hasPrefix("4 glasses in all."), "The total")
        XCTAssertFalse(app.buttons["day-close"].exists, "No Close on All logs")
        XCTAssertFalse(app.buttons["record-add"].exists, "No add button")
        shot("dd-all-logs")
        links.element(boundBy: 3).tap()
        XCTAssertTrue(app.navigationBars["Log"].waitForExistence(timeout: 3), "A tap opens the Log view")
        app.buttons["record-delete"].tap()
        app.alerts.buttons["Delete Log"].tap()
        XCTAssertTrue(app.navigationBars["Today's logs"].waitForExistence(timeout: 3), "Back to All logs after deleting")
        XCTAssertEqual(links.count, 3)
        app.navigationBars["Today's logs"].buttons.element(boundBy: 0).tap()
        XCTAssertTrue(status("3 of 2 glasses"), "Exactly one log removed")
        XCTAssertFalse(app.buttons["day-all-logs"].exists, "Three logs: no All logs row")
        close()
    }

    /// Skipped: Skip turns into Undo skip in the same place; the buttons to add stay, turned off; the saved log and the
    /// note stay, and the log can still be seen and corrected (U15).
    func testSkippedDayKeepsLogsAndNote() {
        launch()
        open("Drink water")
        let note = app.buttons["day-add-note"]
        inSheet(note)
        note.tap()
        XCTAssertTrue(app.navigationBars["Add note"].waitForExistence(timeout: 3), "Add note opens")
        let field = app.textViews["note-field"]
        XCTAssertTrue(field.waitForExistence(timeout: 3))
        XCTAssertFalse(app.descendants(matching: .any)["record-habit"].exists, "No habit card on a note")
        XCTAssertFalse(app.buttons["note-save"].isEnabled, "Save is off until something is written")
        field.tap()
        field.typeText("Had water before breakfast.")
        app.buttons["note-save"].tap()
        XCTAssertTrue(app.buttons["day-edit-note"].waitForExistence(timeout: 3), "The saved note shows in the card")
        let skip = app.buttons["day-skip"]
        inSheet(skip)
        skip.tap()
        XCTAssertTrue(status("Skipped"))
        XCTAssertTrue(app.staticTexts["1 glass saved · Doesn't count toward your streak"].exists, "What the day keeps")
        button("day-skip", "Undo skip")
        button("day-add-step", "Add 1 glass", enabled: false)
        button("day-add-entry", "Log manually", enabled: false)
        XCTAssertEqual(links.count, 1, "The saved log stays")
        XCTAssertTrue(app.buttons["day-edit-note"].isEnabled, "The note stays and can be changed")
        shot("dd-09-skipped-with-log-and-note")
        links.firstMatch.tap()
        XCTAssertTrue(app.navigationBars["Log"].waitForExistence(timeout: 3), "A skipped day's log can still be seen")
        app.navigationBars["Log"].buttons.element(boundBy: 0).tap()
        XCTAssertTrue(result.waitForExistence(timeout: 3))
        app.buttons["day-skip"].tap()
        XCTAssertTrue(status("1 of 2 glasses"), "Undo skip brings the day back as it was")
        button("day-add-step", "Add 1 glass")
        close()
    }

    // MARK: Log view and Edit log

    /// An amount log opens as a view, Log: the habit, date and time, the number and its unit, where it came from, and
    /// Delete log | Edit. Edit opens Edit log with the keyboard and Save; ✕ with changes asks first; Save returns to
    /// the view with the new value; Delete log asks first and removes exactly one log (U19).
    func testLogViewThenEditThenDelete() {
        launch()
        open("Drink water")
        app.buttons["day-add-step"].tap()
        XCTAssertTrue(status("2 of 2 glasses"))
        XCTAssertEqual(links.count, 2)
        links.firstMatch.tap()
        XCTAssertTrue(app.navigationBars["Log"].waitForExistence(timeout: 3), "A log row opens Log, a view")
        XCTAssertTrue(app.descendants(matching: .any)["record-habit"].exists, "Habit · [icon] name")
        XCTAssertTrue(app.descendants(matching: .any)["record-date"].firstMatch.exists, "Its date")
        XCTAssertTrue(app.descendants(matching: .any)["record-time"].firstMatch.exists, "Its time")
        XCTAssertEqual(app.staticTexts["record-value"].label, "1 glass", "The amount, the main thing")
        XCTAssertFalse(app.keyboards.firstMatch.exists, "Viewing: no keyboard")
        XCTAssertFalse(app.buttons["record-save"].exists, "Never a greyed-out Save on the view")
        let delete = app.buttons["record-delete"], edit = app.buttons["record-edit"]
        XCTAssertEqual(delete.label, "Delete log")
        XCTAssertEqual(delete.frame.minY, edit.frame.minY, accuracy: 1, "Delete log | Edit side by side")
        XCTAssertLessThan(delete.frame.minX, edit.frame.minX, "Delete on the left")
        shot("dd-10-log-view")
        edit.tap()
        XCTAssertTrue(app.navigationBars["Edit log"].waitForExistence(timeout: 3), "Edit opens edit mode")
        let field = app.textFields["record-amount"]
        XCTAssertTrue(field.waitForExistence(timeout: 3))
        XCTAssertTrue(app.keyboards.firstMatch.waitForExistence(timeout: 3), "The value has the keyboard")
        XCTAssertTrue(app.descendants(matching: .any)["record-time"].firstMatch.exists, "The time can change")
        let save = app.buttons["record-save"]
        XCTAssertTrue(save.isEnabled, "Save is always on")
        XCTAssertLessThan(save.frame.maxY, app.keyboards.firstMatch.frame.minY + 1, "Save rides above the keyboard")
        field.typeText("3")
        shot("dd-11-edit-log")
        app.buttons["record-cancel"].tap()
        let discard = app.alerts.buttons["Discard Changes"]
        XCTAssertTrue(discard.waitForExistence(timeout: 3), "✕ with changes asks first")
        app.alerts.buttons["Keep Editing"].tap()
        XCTAssertTrue(discard.waitForNonExistence(timeout: 3))
        XCTAssertEqual(field.value as? String, "3", "Keep Editing keeps the draft")
        save.tap()
        XCTAssertTrue(app.navigationBars["Log"].waitForExistence(timeout: 3), "Save returns to the view")
        XCTAssertEqual(app.staticTexts["record-value"].label, "3 glasses", "with the new value")
        app.buttons["record-delete"].tap()
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.waitForExistence(timeout: 3), "Delete asks first")
        XCTAssertTrue(alert.label.contains("Delete this log?"))
        XCTAssertTrue(alert.staticTexts.matching(NSPredicate(format: "label CONTAINS '3 glasses at' AND label CONTAINS 'Your other logs stay.'")).firstMatch.exists,
                      "It names the one log")
        shot("dd-12-delete-asks")
        alert.buttons["Cancel"].tap()
        XCTAssertTrue(app.navigationBars["Log"].exists, "Cancel deletes nothing")
        app.buttons["record-delete"].tap()
        app.alerts.buttons["Delete Log"].tap()
        XCTAssertTrue(status("1 of 2 glasses"), "Exactly one log removed: \(shown)")
        XCTAssertEqual(links.count, 1, "The other log stays")
        close()
    }

    /// A time habit: Add log types hours, minutes and seconds (HOW LONG), its clock row is "Finished at"; the session
    /// opens as Log with its length; Edit changes the minutes.
    func testTimeLogAddViewAndEdit() {
        launch()
        open("Read a little")
        app.buttons["day-add-entry"].tap()
        XCTAssertTrue(app.navigationBars["Add log"].waitForExistence(timeout: 3), "Log manually opens Add log")
        XCTAssertTrue(app.staticTexts["How long"].exists || app.staticTexts["HOW LONG"].exists, "HOW LONG, never TIME")
        XCTAssertTrue(app.staticTexts["Finished at"].exists, "The clock row is Finished at")
        let minutes = app.textFields["record-minutes"]
        XCTAssertTrue(minutes.waitForExistence(timeout: 3))
        XCTAssertTrue(app.keyboards.firstMatch.waitForExistence(timeout: 3), "Minutes have the keyboard")
        XCTAssertTrue(app.textFields["record-hours"].exists && app.textFields["record-seconds"].exists)
        minutes.typeText("15")
        shot("dd-time-add")
        app.buttons["record-add"].tap()
        XCTAssertTrue(status("15 of 20 min"), "One session added: \(shown)")
        links.firstMatch.tap()
        XCTAssertTrue(app.navigationBars["Log"].waitForExistence(timeout: 3))
        XCTAssertEqual(app.descendants(matching: .any)["record-duration"].firstMatch.label, "15 minutes")
        shot("dd-time-log-view")
        app.buttons["record-edit"].tap()
        XCTAssertTrue(app.navigationBars["Edit log"].waitForExistence(timeout: 3))
        let edit = app.textFields["record-minutes"]
        XCTAssertTrue(edit.waitForExistence(timeout: 3))
        edit.typeText("3")
        app.buttons["record-save"].tap()
        XCTAssertTrue(app.navigationBars["Log"].waitForExistence(timeout: 3))
        XCTAssertEqual(app.descendants(matching: .any)["record-duration"].firstMatch.label, "3 minutes")
        app.navigationBars["Log"].buttons.element(boundBy: 0).tap()
        XCTAssertTrue(status("3 of 20 min"))
        close()
    }

    /// An older log of several checks (saved before checks went one at a time) still opens as Log and corrects its
    /// count (U19).
    func testOlderMultiCheckLogStillCorrects() {
        app.launchArguments = ["-uitest", "-day-details-fixture", "-appearance.theme", "light", "-open-day", "Squats"]
        app.launch()
        XCTAssertTrue(result.waitForExistence(timeout: 30))
        XCTAssertTrue(status("2 of 3 times"))
        XCTAssertEqual(links.count, 1, "Two checks in one record: a row that opens Log")
        links.firstMatch.tap()
        XCTAssertTrue(app.navigationBars["Log"].waitForExistence(timeout: 3))
        XCTAssertEqual(app.staticTexts["record-value"].label, "2 checks")
        app.buttons["record-edit"].tap()
        let field = app.textFields["record-amount"]
        XCTAssertTrue(field.waitForExistence(timeout: 3))
        XCTAssertEqual(field.value as? String, "2")
        field.typeText("3")
        app.buttons["record-save"].tap()
        XCTAssertTrue(app.navigationBars["Log"].waitForExistence(timeout: 3))
        XCTAssertEqual(app.staticTexts["record-value"].label, "3 checks")
        shot("dd-13-multi-check-record")
    }

    /// A quit habit: Record a slip opens Add slip; the slip opens Slip (view) with its date, time and time zone; Edit
    /// opens Edit slip with the time to correct; Delete slip asks first (U3/U19).
    func testQuitSlipAddViewEditAndDelete() {
        launch(fixture: false)
        open("Smoking")
        let before = links.count
        let record = app.buttons["day-add-entry"]
        XCTAssertTrue(record.label == "Record a slip" || record.label == "Record another slip")
        record.tap()
        XCTAssertTrue(app.navigationBars["Add slip"].waitForExistence(timeout: 3), "Add slip, the same shape as every Add")
        footer(contains: "A slip is recorded with its time.")
        shot("dd-14-add-slip")
        app.buttons["record-add"].tap()
        XCTAssertTrue(app.staticTexts["Slips today"].waitForExistence(timeout: 3), "Slips, under their own heading")
        XCTAssertEqual(links.count, before + 1, "The new slip, in its own row")
        button("day-add-entry", "Record another slip")
        shot("dd-14-quit-with-slip")
        links.firstMatch.tap()
        XCTAssertTrue(app.navigationBars["Slip"].waitForExistence(timeout: 3), "A slip opens Slip, a view")
        XCTAssertTrue(app.staticTexts["Time zone"].exists, "Where it was recorded")
        XCTAssertEqual(app.buttons["record-delete"].label, "Delete slip")
        shot("dd-15-slip-view")
        app.buttons["record-edit"].tap()
        XCTAssertTrue(app.navigationBars["Edit slip"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.descendants(matching: .any)["record-time"].firstMatch.exists, "Its time, to correct")
        XCTAssertFalse(app.keyboards.firstMatch.exists, "Nothing to type for a slip")
        app.buttons["record-cancel"].tap()
        XCTAssertTrue(app.navigationBars["Slip"].waitForExistence(timeout: 3), "✕ with no change leaves edit mode")
        app.buttons["record-delete"].tap()
        XCTAssertTrue(app.alerts.firstMatch.waitForExistence(timeout: 3))
        XCTAssertTrue(app.alerts.firstMatch.label.contains("Delete this slip?"))
        app.alerts.buttons["Delete Slip"].tap()
        XCTAssertTrue(result.waitForExistence(timeout: 3))
        XCTAssertEqual(links.count, before, "Exactly one slip removed")
        close()
    }

    // MARK: Add, for every kind

    /// One Add screen shape for every kind (U22): ✕ and a one-line title, Habit · Date · Time, the kind's main thing,
    /// a footer saying what will happen, and one filled button at the bottom.
    func testEveryKindsAddScreen() {
        let kinds: [(name: String, title: String, button: String, footer: String)] = [
            ("Water", "Add log", "Add", "Adds a new log. Other logs stay as they are."),
            ("Push-ups", "Add log", "Add", "Adds a new log."),
            ("Savings", "Add log", "Add", "Adds a new log."),
            ("Coffee", "Add log", "Add", "Records what happened. Your limit stays the same."),
            ("Read", "Add log", "Add", "Adds one session. Other logs stay as they are."),
            ("Stretch breaks", "Add a check", "Add", "Checks already there stay."),
            ("Call family", "Add a check", "Add", "It counts toward this week."),
            ("Deep clean", "Add a check", "Add", "It counts toward this month."),
            ("Take vitamins", "Mark a day done", "Mark done", "as done at"),
            ("Gym", "Mark a day done", "Mark done", "It counts toward that week."),
            ("Tidy desk", "Tick steps", "Save", "Saves these steps for"),
            ("Smoking", "Add slip", "Add", "A slip is recorded with its time."),
        ]
        for kind in kinds {
            launchAdd(kind.name)
            let bar = app.navigationBars[kind.title]
            XCTAssertTrue(bar.waitForExistence(timeout: 30), "\(kind.name): \(kind.title)")
            XCTAssertTrue(app.buttons["record-cancel"].exists, "\(kind.name): an icon-only ✕")
            XCTAssertEqual(app.buttons["record-cancel"].label, "Cancel", "\(kind.name): named Cancel")
            XCTAssertTrue(app.descendants(matching: .any)["record-habit"].firstMatch.label.contains(kind.name), "\(kind.name): Habit row")
            XCTAssertTrue(app.descendants(matching: .any)["record-date"].firstMatch.exists, "\(kind.name): Date")
            XCTAssertTrue(app.descendants(matching: .any)["record-time"].firstMatch.exists, "\(kind.name): Time")
            XCTAssertEqual(app.buttons["record-add"].label, kind.button, "\(kind.name): the one filled button")
            XCTAssertFalse(app.buttons["Add Entry"].exists, "\(kind.name): never Add Entry")
            XCTAssertFalse(app.steppers.firstMatch.exists, "\(kind.name): no Times stepper (one check per add)")
            if app.keyboards.firstMatch.waitForExistence(timeout: 2) {
                XCTAssertLessThan(app.buttons["record-add"].frame.maxY, app.keyboards.firstMatch.frame.minY + 1,
                                  "\(kind.name): the button rides above the keyboard")
                app.typeText("2")
                // The footer hides while typing where it would reach the button; it's back once the keyboard is down.
                app.collectionViews["log-form"].swipeDown(velocity: .slow)
                XCTAssertTrue(app.keyboards.firstMatch.waitForNonExistence(timeout: 3), "\(kind.name): a drag puts the keyboard away")
            }
            footer(contains: kind.footer)
            shot("add-\(kind.name)")
            app.terminate()
        }
    }

    /// Typing a currency amount keeps the symbol before the digits, and no unit line (design decisions §8).
    func testCurrencyAndNoUnitAmounts() {
        launchAdd("Savings")
        XCTAssertTrue(app.navigationBars["Add log"].waitForExistence(timeout: 30))
        let field = app.textFields["record-amount"]
        XCTAssertTrue(field.waitForExistence(timeout: 3))
        XCTAssertTrue(app.keyboards.firstMatch.waitForExistence(timeout: 3), "The decimal pad is up as the screen opens")
        XCTAssertTrue(app.staticTexts["£"].exists, "£ before the digits")
        XCTAssertFalse(app.buttons["record-add"].isEnabled, "Add is off until there's a number")
        field.typeText("15")
        XCTAssertTrue(app.buttons["record-add"].isEnabled)
        app.buttons["record-add"].tap()
        XCTAssertTrue(app.navigationBars["Add log"].waitForNonExistence(timeout: 3), "Add closes the screen")
        app.terminate()

        launchAdd("Push-ups")
        XCTAssertTrue(app.navigationBars["Add log"].waitForExistence(timeout: 30))
        XCTAssertEqual(app.textFields["record-amount"].label, "Amount", "No unit: just the number")
        shot("add-no-unit")
    }

    /// Mark a day done records the day, and is off for a day that's already done, saying so (design decisions §8, row 8).
    func testMarkADayDoneOnlyOnce() {
        launchAdd("Take vitamins", extra: ["-then-open-day"])
        XCTAssertTrue(app.navigationBars["Mark a day done"].waitForExistence(timeout: 30))
        XCTAssertTrue(app.buttons["record-add"].isEnabled)
        XCTAssertFalse(app.keyboards.firstMatch.exists, "Nothing to type")
        app.buttons["record-add"].tap()
        XCTAssertTrue(result.waitForExistence(timeout: 5), "Then that day's details")
        XCTAssertTrue(status("Done"), "The day is marked done: \(shown)")
        app.terminate()
        // The fixture took yesterday's vitamins.
        launchAdd("Take vitamins", offset: -1)
        XCTAssertTrue(app.navigationBars["Mark a day done"].waitForExistence(timeout: 30))
        XCTAssertFalse(app.buttons["record-add"].isEnabled, "Already done: Mark done is off")
        footer(contains: "is already done")
        shot("add-already-done")
    }

    /// Tick steps saves the steps chosen for the day, and only when something changed.
    func testTickSteps() {
        launchAdd("Tidy desk", extra: ["-then-open-day"])
        XCTAssertTrue(app.navigationBars["Tick steps"].waitForExistence(timeout: 30))
        XCTAssertFalse(app.buttons["record-add"].isEnabled, "Nothing changed yet")
        let third = app.buttons["record-step-2"]
        XCTAssertEqual(third.value as? String, "Not done")
        third.tap()
        XCTAssertEqual(third.value as? String, "Done")
        XCTAssertTrue(app.buttons["record-add"].isEnabled)
        app.buttons["record-add"].tap()
        XCTAssertTrue(result.waitForExistence(timeout: 5))
        XCTAssertTrue(status("3 of 3 steps done"), "The step was saved: \(shown)")
    }

    /// A past day's log, added from that day, is stored on that day, at the same clock time (not today's moment
    /// copied onto it): with the store's clock at 2:30 PM, the log reads 2:30 PM on yesterday (D7; the time of a log).
    func testPastDayLogKeepsItsDayAndChosenTime() {
        launchAdd("Water", offset: -1, extra: ["-clock-hour", "14", "-then-open-day"])
        XCTAssertTrue(app.navigationBars["Add log"].waitForExistence(timeout: 30))
        // The Date row reads as one element with its "Yesterday" word.
        XCTAssertTrue(app.descendants(matching: .any).matching(NSPredicate(format: "label CONTAINS 'Yesterday'")).firstMatch.exists,
                      "The day it was opened from is chosen: \(shown)")
        let field = app.textFields["record-amount"]
        XCTAssertTrue(field.waitForExistence(timeout: 3))
        field.typeText("2")
        app.buttons["record-add"].tap()
        XCTAssertTrue(result.waitForExistence(timeout: 5), "Then that day's details")
        XCTAssertTrue(app.navigationBars["Yesterday"].exists, "An earlier day is titled by its day, never Today")
        XCTAssertTrue(app.staticTexts["Logs for " + Self.dayWords(-1)].exists, "Its logs say the day: \(shown)")
        let row = links.matching(NSPredicate(format: "label CONTAINS '2:30' AND label CONTAINS '2 glasses'")).firstMatch
        XCTAssertTrue(row.waitForExistence(timeout: 3), "Stored on yesterday at the chosen time: \(shown)")
        row.tap()
        XCTAssertTrue(app.navigationBars["Log"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.descendants(matching: .any)["record-date"].firstMatch.label.contains("Yesterday"), "Date: yesterday")
        shot("dd-past-day-log")
    }

    /// "Tue 6 Oct", as the app writes a day in a heading.
    private static func dayWords(_ offset: Int) -> String {
        let day = Calendar.current.date(byAdding: .day, value: offset, to: .now)!
        return day.formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated)).replacingOccurrences(of: ",", with: "")
    }

    // MARK: Tasks and History

    /// Reschedule (the user, 4 Oct 2026): no date row; Do tomorrow and Another day…, whose calendar offers only the days
    /// the task can move to. A weekly task moves only today's occurrence, to a day before next week's; a daily task
    /// can't move; a done task has nothing to move.
    func testTasksReschedule() {
        app.launchArguments = ["-uitest", "-day-details-fixture", "-appearance.theme", "dark", "-open-day", "Water the plants"]
        app.launch()
        XCTAssertTrue(result.waitForExistence(timeout: 30), "The weekly task's Day details")
        XCTAssertTrue(app.staticTexts["Reschedule"].exists || app.staticTexts["RESCHEDULE"].exists, "A Reschedule section")
        XCTAssertFalse(app.descendants(matching: .any)["day-task-date"].firstMatch.exists, "No date row")
        XCTAssertFalse(app.buttons["day-skip"].exists, "No Skip for a task")
        let another = app.buttons["day-another-day"]
        inSheet(another)
        XCTAssertTrue(app.buttons["day-do-tomorrow"].exists, "Tomorrow comes before next week's: Do tomorrow")
        shot("dd-16-weekly-task-reschedule")
        another.tap()
        XCTAssertTrue(app.navigationBars["Another Day"].waitForExistence(timeout: 3), "Another day… opens a calendar")
        shot("dd-17-reschedule-calendar")
        let move = app.navigationBars["Another Day"].buttons["reschedule-move"]
        XCTAssertTrue(move.isEnabled, "Tomorrow is picked to start with")
        move.tap()
        XCTAssertTrue(result.waitForNonExistence(timeout: 5), "Moving closes Day details")
        app.terminate()

        app.launchArguments = ["-uitest", "-day-details-fixture", "-appearance.theme", "dark", "-open-day", "Feed the cat"]
        app.launch()
        XCTAssertTrue(result.waitForExistence(timeout: 30), "The daily task's Day details")
        XCTAssertFalse(app.buttons["day-do-tomorrow"].exists, "A daily task's next one is tomorrow: no Do tomorrow")
        XCTAssertFalse(app.buttons["day-another-day"].exists, "and no other day before it")
        shot("dd-18-daily-task-no-reschedule")
        app.terminate()

        app.launchArguments = ["-uitest", "-day-details-fixture", "-appearance.theme", "dark", "-open-day", "Test"]
        app.launch()
        XCTAssertTrue(result.waitForExistence(timeout: 30), "The one-time task's Day details")
        XCTAssertTrue(app.buttons["day-do-tomorrow"].exists && app.buttons["day-another-day"].exists)
        app.buttons["day-done"].tap()
        XCTAssertTrue(app.buttons["day-another-day"].waitForNonExistence(timeout: 3), "Done: nothing to reschedule")
        XCTAssertFalse(app.staticTexts["Planned for"].exists, "No Planned for row")
        shot("dd-19-task-done-no-reschedule")
    }

    /// A day opened from a habit's History is the same Day details, for that day (the user, 5 Oct 2026): titled by that
    /// day ("Today" only for today, U21), no link back to the page it came from, a past day's own words ("Skip this
    /// day", no timer), and Close. History's Add is named for the kind (never "Add Entry").
    func testHistoryDaysOpenDayDetails() {
        for (name, key, add) in [("Water", "amount", "Add log"), ("Read", "time", "Add log"), ("Meds", "check", "Mark a day done"),
                                 ("Skincare", "checklist", "Tick steps"), ("Call family", "weekly", "Add a check")] {
            launch(fixture: false, dark: true)
            app.buttons["menu-button"].tap()
            XCTAssertTrue(app.buttons["menu-habits"].waitForExistence(timeout: 3))
            app.buttons["menu-habits"].tap()
            app.revealAndTap(app.staticTexts[name])
            let history = app.buttons["history-add-entry"]
            XCTAssertTrue(history.waitForExistence(timeout: 5))
            XCTAssertEqual(history.label, add, "\(name): History's Add says what it adds")
            let days = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'habit-day-' AND enabled == YES"))
            XCTAssertTrue(days.firstMatch.waitForExistence(timeout: 5), "\(name): History's days")
            // Newest first: the second row is an earlier day.
            let past = days.count > 1 ? days.element(boundBy: 1) : days.firstMatch
            app.revealAndTap(past, clear: true)
            XCTAssertTrue(result.waitForExistence(timeout: 5), "\(name): the History day opens Day details")
            if days.count > 1 {
                XCTAssertFalse(app.navigationBars["Today"].exists, "\(name): an earlier day is never titled Today")
            }
            XCTAssertFalse(app.buttons["day-open-page"].exists, "\(name): no link to the page it was opened from")
            XCTAssertTrue(app.buttons["day-more"].exists && app.buttons["day-close"].exists, "\(name): ⋯ and Close")
            XCTAssertFalse(app.buttons["day-start-timer"].exists, "\(name): no timer on an earlier day")
            XCTAssertFalse(app.buttons["Skip today"].exists, "\(name): an earlier day never says today")
            shot("dd-history-\(key)")
            close()
            app.terminate()
        }
    }

    /// The same sheets in dark mode, for the design review (U1/U9).
    func testEveryKindDark() {
        launch(dark: true)
        for (name, key) in [("Drink water", "amount"), ("Stretch", "checks"), ("Clean kitchen", "checklist"),
                            ("Read a little", "time"), ("Less coffee", "limit"), ("Water the plants", "task"), ("Call family", "weekly")] {
            open(name)
            shot("dd-dark-\(key)")
            close()
        }
        open("Drink water")
        links.firstMatch.tap()
        XCTAssertTrue(app.navigationBars["Log"].waitForExistence(timeout: 3))
        shot("dd-dark-log-view")
        app.buttons["record-edit"].tap()
        XCTAssertTrue(app.navigationBars["Edit log"].waitForExistence(timeout: 3))
        shot("dd-dark-edit-log")
        app.buttons["record-cancel"].tap()
        app.navigationBars["Log"].buttons.element(boundBy: 0).tap()
        app.buttons["day-add-entry"].tap()
        XCTAssertTrue(app.navigationBars["Add log"].waitForExistence(timeout: 3))
        shot("dd-dark-add-log")
    }
}
