import XCTest

/// Day details and Edit Log for every kind of habit (4 Oct 2026; handoff "Day Details and Entry Editor", Rulebook
/// U14–U19, T3). Each kind opens from its row on Today, titled with the day; says what that day holds in its own
/// words; offers its own buttons; shows logs only when there are some; and corrects one log at a time. Screenshots of
/// every kind, light and dark, for the design review on the iPhone (U9).
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
    private func launch(fixture: Bool = true, dark: Bool = false) {
        var arguments = ["-uitest"]
        if fixture { arguments += ["-focus-fixture", "-focus-period-fixture"] }
        arguments += ["-appearance.theme", dark ? "dark" : "light"]
        app.launchArguments = arguments
        app.launch()
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 10))
    }

    private var result: XCUIElement { app.descendants(matching: .any)["day-result"].firstMatch }
    private var form: XCUIElement { app.collectionViews["day-form"] }
    private var links: XCUIElementQuery {
        app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'entry-' AND NOT identifier IN {'entry-delete','entry-save','entry-back'}"))
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

    private func button(_ id: String, _ label: String, enabled: Bool = true, file: StaticString = #filePath, line: UInt = #line) {
        let b = app.buttons[id]
        XCTAssertTrue(b.exists, "\(id) exists", file: file, line: line)
        XCTAssertEqual(b.label, label, file: file, line: line)
        XCTAssertEqual(b.isEnabled, enabled, "\(label) enabled", file: file, line: line)
    }

    /// Every kind: its status in its own words and its own buttons; a limit and a task have no Skip; no empty logs.
    func testEveryKindShowsItsOwnDay() {
        launch()
        open("Drink water")
        XCTAssertTrue(status("1 of 2 glasses"), "An amount: how far along")
        button("day-add-step", "Add 1 glass")
        button("day-add-entry", "Log amount manually")
        XCTAssertTrue(app.staticTexts["Today's logs"].exists, "Its logs, under a heading")
        XCTAssertEqual(links.count, 1, "One row per log")
        XCTAssertTrue(app.buttons["day-add-note"].exists, "The note for this day")
        inSheet(app.buttons["day-skip"])
        button("day-skip", "Skip today")
        shot("dd-01-amount")
        close()

        open("Stretch")
        XCTAssertTrue(status("0 of 3 checks"), "Several a day: checks, not entries")
        button("day-add-one", "Add a check")
        XCTAssertFalse(app.staticTexts["Checks today"].exists, "No empty checks section")
        app.buttons["day-add-one"].tap()
        XCTAssertTrue(status("1 of 3 checks"))
        XCTAssertTrue(app.staticTexts["Checks today"].waitForExistence(timeout: 3), "The check, in its own row")
        XCTAssertTrue(app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'undo-entry-'")).firstMatch.exists,
                      "A single check has its own Undo, not a Times 1 editor")
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
        XCTAssertFalse(app.buttons["day-add-entry"].exists, "No Add Entry for a step")
        shot("dd-03-checklist")
        close()

        open("Read a little")
        XCTAssertTrue(status("0 of 20 min"), "Time: how far along")
        button("day-start-timer", "Start timer")
        button("day-add-entry", "Log time manually")
        shot("dd-04-time")
        close()

        open("Less coffee")
        XCTAssertTrue(status("0 cups today"), "A limit is a fact, not a bar to fill")
        XCTAssertTrue(app.staticTexts["Limit 2 cups · within limit"].exists)
        button("day-add-step", "Add 1 cup")
        button("day-add-entry", "Log amount manually")
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
        XCTAssertTrue(status("1 check today"))
        app.buttons["day-add-one"].tap()
        XCTAssertTrue(status("2 checks today"), "A second check the same day counts too")
        XCTAssertTrue(app.staticTexts["Checks today"].waitForExistence(timeout: 3), "Each check in its own row")
        shot("dd-07-weekly")
        app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'undo-entry-'")).firstMatch.tap()
        XCTAssertTrue(status("1 check today"), "A check's Undo takes back that one only")
        close()

        open("Yearly distance")
        XCTAssertTrue(status("0 km today"), "A year's total: this day, then the year")
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label ENDSWITH ' this year'")).firstMatch.exists)
        shot("dd-08-yearly")
        close()
    }

    /// Skipped: Skip turns into Undo skip in the same place; the buttons to add stay, disabled; the saved log and the
    /// note stay, and the log can still be corrected (U15).
    func testSkippedDayKeepsLogsAndNote() {
        launch()
        open("Drink water")
        let note = app.buttons["day-add-note"]
        inSheet(note)
        note.tap()
        let field = app.textFields["note-field"]
        XCTAssertTrue(field.waitForExistence(timeout: 3), "The note opens its own editor")
        field.typeText("Had water before breakfast.")
        app.navigationBars["Note"].buttons["Save"].tap()
        XCTAssertTrue(app.buttons["day-edit-note"].waitForExistence(timeout: 3), "The saved note shows in the sheet")
        let skip = app.buttons["day-skip"]
        inSheet(skip)
        let noteRow = app.buttons["day-edit-note"]
        let gap = skip.frame.minY - noteRow.frame.maxY
        skip.tap()
        XCTAssertTrue(status("Skipped"))
        XCTAssertTrue(app.staticTexts["1 glass saved · Doesn't count toward your streak"].exists, "What the day keeps")
        button("day-skip", "Undo skip")
        XCTAssertEqual(skip.frame.minY - noteRow.frame.maxY, gap, accuracy: 2, "Undo skip is where Skip was, under the note")
        button("day-add-step", "Add 1 glass", enabled: false)
        button("day-add-entry", "Log amount manually", enabled: false)
        XCTAssertEqual(links.count, 1, "The saved log stays")
        XCTAssertTrue(app.buttons["day-edit-note"].isEnabled, "The note stays and can be changed")
        shot("dd-09-skipped-with-log-and-note")
        links.firstMatch.tap()
        XCTAssertTrue(app.navigationBars["Edit Log"].waitForExistence(timeout: 3), "A skipped day's log can still be corrected")
        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssertTrue(result.waitForExistence(timeout: 3))
        app.buttons["day-skip"].tap()
        XCTAssertTrue(status("1 of 2 glasses"), "Undo skip brings the day back as it was")
        button("day-add-step", "Add 1 glass")
        close()
    }

    /// Edit Log: the value and unit first, the keyboard closed until a value is tapped, the chevron back with no title,
    /// Back with changes asks first, and Delete this log asks before removing exactly one log (U19).
    func testEditLogAsksBeforeLosingOrDeleting() {
        launch()
        open("Drink water")
        app.buttons["day-add-step"].tap()
        XCTAssertTrue(status("2 of 2 glasses"))
        XCTAssertEqual(links.count, 2)
        links.firstMatch.tap()
        XCTAssertTrue(app.navigationBars["Edit Log"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.staticTexts["Amount logged"].exists, "The log's own value first")
        XCTAssertTrue(app.textFields["entry-amount"].label.contains("glass"), "with its unit")
        XCTAssertFalse(app.keyboards.firstMatch.exists, "No keyboard until a value is tapped")
        shot("dd-10-edit-log")
        let field = app.textFields["entry-amount"]
        field.tap()
        field.typeText("3")
        XCTAssertEqual(app.navigationBars["Edit Log"].buttons.matching(NSPredicate(format: "label == 'Back'")).count, 1,
                       "One back chevron, never two (iOS 26 showed both, 5 Oct 2026)")
        app.navigationBars["Edit Log"].buttons["entry-back"].tap()
        let discard = app.alerts.buttons["Discard Changes"]
        XCTAssertTrue(discard.waitForExistence(timeout: 3), "Back with changes asks first")
        shot("dd-11-discard-asks")
        app.alerts.buttons["Keep Editing"].tap()
        XCTAssertTrue(discard.waitForNonExistence(timeout: 3))
        XCTAssertEqual(field.value as? String, "3", "Keep Editing keeps the draft")
        if app.keyboards.firstMatch.exists { app.toolbars.buttons["Done"].firstMatch.tap() }
        app.buttons["entry-delete"].tap()
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.waitForExistence(timeout: 3), "Delete asks first")
        XCTAssertTrue(alert.label.contains("Delete this log?"))
        shot("dd-12-delete-asks")
        alert.buttons["Cancel"].tap()
        XCTAssertTrue(app.navigationBars["Edit Log"].exists, "Cancel deletes nothing")
        app.buttons["entry-delete"].tap()
        app.alerts.buttons["Delete Log"].tap()
        XCTAssertTrue(status("1 of 2 glasses"), "Exactly one log removed")
        XCTAssertEqual(links.count, 1, "The other log stays")
        close()
    }

    /// A record holding several checks opens Edit Log with its count; Add Entry in History makes one.
    func testMultiCheckRecordEditsItsCount() {
        launch()
        app.buttons["menu-button"].tap()
        XCTAssertTrue(app.buttons["menu-habits"].waitForExistence(timeout: 3))
        app.buttons["menu-habits"].tap()
        app.revealAndTap(app.staticTexts["Stretch"])
        let add = app.buttons["history-add-entry"]
        XCTAssertTrue(add.waitForExistence(timeout: 5))
        add.tap()
        let times = app.steppers["add-entry-times"]
        XCTAssertTrue(times.waitForExistence(timeout: 3))
        times.buttons.element(boundBy: 1).tap()
        app.navigationBars["Add Entry"].buttons["add-entry-save"].tap()
        let today = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'habit-day-'")).firstMatch
        XCTAssertTrue(today.waitForExistence(timeout: 5))
        today.tap()
        XCTAssertTrue(status("2 of 3 checks", wait: 5))
        XCTAssertEqual(links.count, 1, "Two checks in one record: a row that opens Edit Log")
        links.firstMatch.tap()
        XCTAssertTrue(app.navigationBars["Edit Log"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.staticTexts["Checks in this log"].exists)
        XCTAssertEqual(app.textFields["entry-amount"].value as? String, "2")
        shot("dd-13-multi-check-record")
        app.navigationBars["Edit Log"].buttons.element(boundBy: 0).tap()
        XCTAssertTrue(result.waitForExistence(timeout: 3))
    }

    /// A quit habit: no slips is a neutral fact; Record a slip; the slip opens Edit Slip with its date, time and time
    /// zone; Delete this slip asks first (U3/U19).
    func testQuitSlipRecordEditAndDelete() {
        launch(fixture: false)
        open("Smoking")
        let before = links.count
        let record = app.buttons["day-add-entry"]
        XCTAssertTrue(record.label == "Record a slip" || record.label == "Record another slip")
        record.tap()
        XCTAssertTrue(app.navigationBars["Add Entry"].waitForExistence(timeout: 3))
        app.navigationBars["Add Entry"].buttons["add-entry-save"].tap()
        XCTAssertTrue(app.staticTexts["Slips today"].waitForExistence(timeout: 3), "Slips, under their own heading")
        XCTAssertEqual(links.count, before + 1)
        button("day-add-entry", "Record another slip")
        shot("dd-14-quit-with-slip")
        links.firstMatch.tap()
        XCTAssertTrue(app.navigationBars["Edit Slip"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.staticTexts["When it happened"].exists, "The slip's moment, under its heading")
        XCTAssertTrue(app.staticTexts["Date"].exists, "The slip's date")
        XCTAssertTrue(app.descendants(matching: .any)["entry-slip-time"].firstMatch.exists, "Its time, to correct")
        XCTAssertTrue(app.staticTexts["Time zone"].exists, "Where it was recorded")
        shot("dd-15-edit-slip")
        app.buttons["entry-delete"].tap()
        XCTAssertTrue(app.alerts.firstMatch.waitForExistence(timeout: 3))
        XCTAssertTrue(app.alerts.firstMatch.label.contains("Delete this slip?"))
        app.alerts.buttons["Delete Slip"].tap()
        XCTAssertTrue(result.waitForExistence(timeout: 3))
        XCTAssertEqual(links.count, before, "Exactly one slip removed")
        close()
    }

    /// Reschedule (the user, 4 Oct 2026): no date row; Do Tomorrow and Another Day…, whose calendar offers only the days
    /// the task can move to. A weekly task moves only today's occurrence, to a day before next week's; a daily task
    /// can't move; a done task has nothing to move.
    func testTasksReschedule() {
        app.launchArguments = ["-uitest", "-day-details-fixture", "-appearance.theme", "dark", "-open-day", "Water the plants"]
        app.launch()
        XCTAssertTrue(result.waitForExistence(timeout: 30), "The weekly task's Day details")
        XCTAssertTrue(app.staticTexts["Reschedule"].exists, "A Reschedule section")
        XCTAssertFalse(app.descendants(matching: .any)["day-task-date"].firstMatch.exists, "No date row")
        let another = app.buttons["day-another-day"]
        inSheet(another)
        XCTAssertTrue(app.buttons["day-do-tomorrow"].exists, "Tomorrow comes before next week's: Do Tomorrow")
        shot("dd-16-weekly-task-reschedule")
        another.tap()
        XCTAssertTrue(app.navigationBars["Another Day"].waitForExistence(timeout: 3), "Another Day… opens a calendar")
        shot("dd-17-reschedule-calendar")
        let move = app.navigationBars["Another Day"].buttons["reschedule-move"]
        XCTAssertTrue(move.isEnabled, "Tomorrow is picked to start with")
        move.tap()
        XCTAssertTrue(result.waitForNonExistence(timeout: 5), "Moving closes Day details")
        app.terminate()

        app.launchArguments = ["-uitest", "-day-details-fixture", "-appearance.theme", "dark", "-open-day", "Feed the cat"]
        app.launch()
        XCTAssertTrue(result.waitForExistence(timeout: 30), "The daily task's Day details")
        XCTAssertFalse(app.buttons["day-do-tomorrow"].exists, "A daily task's next one is tomorrow: no Do Tomorrow")
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

    /// A day opened from a habit's History is the same Day details, for that day (the user, 5 Oct 2026): titled with the
    /// day, no link back to the page it came from, a past day's own words ("Skip this day", no timer), and Close.
    func testHistoryDaysOpenDayDetails() {
        for (name, key) in [("Water", "amount"), ("Read", "time"), ("Meds", "check"), ("Skincare", "checklist"), ("Call family", "weekly")] {
            launch(fixture: false, dark: true)
            app.buttons["menu-button"].tap()
            XCTAssertTrue(app.buttons["menu-habits"].waitForExistence(timeout: 3))
            app.buttons["menu-habits"].tap()
            app.revealAndTap(app.staticTexts[name])
            let days = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'habit-day-' AND enabled == YES"))
            XCTAssertTrue(days.firstMatch.waitForExistence(timeout: 5), "\(name): History's days")
            // Newest first: the second row is an earlier day.
            let past = days.count > 1 ? days.element(boundBy: 1) : days.firstMatch
            app.revealAndTap(past, clear: true)
            XCTAssertTrue(result.waitForExistence(timeout: 5), "\(name): the History day opens Day details")
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
    }
}
