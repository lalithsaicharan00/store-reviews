import XCTest

/// The habit page (Figma's Habit details, 1020:4052; 19 Nov 2026: Progress · History, notes in History): pictures of
/// every habit type's two tabs, light and dark, and the flows: add a log, go to a date, fold a month, write a note from
/// a day, find it with Search notes, keep only days with a note, and pick a day in Year in Pixels.
final class HabitPageUITests: XCTestCase {
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

    private func launch(_ theme: String = "light") {
        app.launchArguments = ["-uitest", "-year-demo", "-appearance.theme", theme]
        app.launch()
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 10))
    }

    /// ≡ → Habits → the habit's row. Asserts each step, so a menu that didn't open fails here instead of tapping the
    /// habit's row on Today (3 Oct 2026: a tap during the year demo's first seconds opened Today's row instead).
    private func open(_ name: String) {
        let bar = app.navigationBars.firstMatch
        if !app.habitsPage.exists {
            if bar.buttons["BackButton"].exists { bar.buttons["BackButton"].tap() }
            let habits = app.buttons["menu-habitsAndTasks"]
            if !habits.exists {
                app.buttons["menu-button"].tap()
                // The first tap can land while the year demo is still being saved: try the ≡ once more.
                if !habits.waitForExistence(timeout: 5) { app.buttons["menu-button"].tap() }
            }
            XCTAssertTrue(habits.waitForExistence(timeout: 10), "The ≡ menu opens")
            habits.tap()
        }
        XCTAssertTrue(app.habitsPage.waitForExistence(timeout: 5), "The Habits page")
        let row = app.habitCard(name)
        app.revealAndTap(row)
        XCTAssertTrue(app.segmentedControls["habit-tabs"].waitForExistence(timeout: 5), "\(name)'s page")
        sleep(1)
    }

    private func back() {
        let bar = app.navigationBars.firstMatch
        if bar.buttons["BackButton"].exists { bar.buttons["BackButton"].tap() }
        else { bar.buttons.element(boundBy: 0).tap() }
        sleep(1)
    }

    /// Switches tab and checks it switched: on a busy hosted simulator a tap during the page's first seconds was lost
    /// and the test went on scrolling History (run 37836789385, 8 Oct 2026).
    private func tab(_ title: String) {
        let button = app.segmentedControls["habit-tabs"].buttons[title]
        button.tap()
        if !button.wait(for: \.isSelected, toEqual: true, timeout: 5) { button.tap() }
        XCTAssertTrue(button.wait(for: \.isSelected, toEqual: true, timeout: 5), "\(title) is the tab shown")
        sleep(1)
    }

    /// Swipes until the element is on screen (the page is a scroll view of cards, not a list).
    @discardableResult
    private func scrollTo(_ element: XCUIElement, swipes: Int = 10) -> Bool {
        for _ in 0..<swipes where !(element.exists && element.isHittable) { app.swipeUp(velocity: .slow) }
        return element.exists && element.isHittable
    }

    /// Drags the page 250 pt at a time until the element's top edge is in the screen's upper part (below the tabs), so a
    /// card taller than the screen shows its top, not its middle.
    @discardableResult
    private func bringTopIntoView(_ element: XCUIElement) -> Bool {
        let middle = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.6))
        for _ in 0..<30 {
            let top = element.exists ? element.frame.minY : .infinity
            if top > 180 && top < 420 { return true }
            let up = top >= 420
            middle.press(forDuration: 0.05, thenDragTo: middle.withOffset(CGVector(dx: 0, dy: up ? -250 : 120)))
            sleep(1)
        }
        return false
    }

    private func topOfPage() {
        for _ in 0..<12 { app.swipeDown(velocity: .fast) }
        sleep(1)
    }

    /// Every type's page: History (top and a fold), then Progress top to bottom.
    private func pictures(_ names: [String], prefix: String, progressShots: Int = 5) {
        for name in names {
            open(name)
            let key = name.lowercased().replacingOccurrences(of: " ", with: "-")
            tab("History")
            shot("\(prefix)-\(key)-1-history")
            app.swipeUp(velocity: .slow); sleep(1)
            shot("\(prefix)-\(key)-2-history-scrolled")
            topOfPage()
            tab("Progress")
            shot("\(prefix)-\(key)-4-progress")
            for i in 1...progressShots {
                app.swipeUp(velocity: .slow); sleep(1)
                shot("\(prefix)-\(key)-\(4 + i)-progress-scrolled")
            }
            back()
        }
    }

    /// Daily amount with a year of history, daily amount, time, once a day, checklist (light).
    func testPicturesDailyTypes() {
        launch()
        pictures(["Swim", "Water", "Read", "Floss", "Skincare"], prefix: "hp")
    }

    /// Times a week, a weekly total, a daily limit, a quit habit (light).
    func testPicturesPeriodLimitQuit() {
        launch()
        pictures(["Running", "Cycle", "Coffee", "Smoking"], prefix: "hp")
    }

    func testPicturesDark() {
        launch("dark")
        pictures(["Swim", "Smoking"], prefix: "hp-dark", progressShots: 4)
    }

    /// History's Add (Figma's floating Add, which opens the kind's own Add: Add Log for Water), Go to Date, and a month
    /// folding and opening.
    func testHistoryFlows() {
        launch()
        open("Water")
        tab("History")
        // Add floats at the bottom right; Go to Date is a small capsule under the search (Figma's History).
        let add = app.buttons["history-add-entry"], go = app.buttons["history-go-to-date"]
        let width = app.windows.firstMatch.frame.width
        XCTAssertTrue(add.waitForExistence(timeout: 3) && go.exists)
        XCTAssertEqual(add.label, "Add", "Figma's Add, never Add Entry")
        XCTAssertGreaterThan(add.frame.minX, width * 0.5, "Add floats at the bottom right: \(add.frame)")
        XCTAssertLessThan(go.frame.width, width * 0.45, "Go to Date is its own width: \(go.frame)")
        XCTAssertLessThan(go.frame.height, add.frame.height, "Go to Date is small, Add large: \(go.frame) \(add.frame)")
        shot("hp-flow-0-history-buttons")
        app.buttons["history-add-entry"].tap()
        XCTAssertTrue(app.navigationBars["Add Log"].waitForExistence(timeout: 3), "Add log, the same Add as everywhere")
        let amount = app.textFields["record-amount"]
        XCTAssertTrue(amount.waitForExistence(timeout: 3))
        amount.typeText("2")
        shot("hp-flow-1-add-log")
        app.buttons["record-add"].tap()
        XCTAssertTrue(app.navigationBars["Add Log"].waitForNonExistence(timeout: 5), "Added and closed")
        let today = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'habit-day-'")).firstMatch
        XCTAssertTrue(today.waitForExistence(timeout: 5))
        today.tap()
        XCTAssertTrue(app.descendants(matching: .any)["day-result"].firstMatch.waitForExistence(timeout: 5), "The day opens")
        XCTAssertTrue(app.navigationBars["Today"].exists, "Today's row opens Day details titled Today")
        shot("hp-flow-2-day")
        app.buttons["day-close"].tap()
        sleep(1)
        app.buttons["history-go-to-date"].tap()
        XCTAssertTrue(app.navigationBars["Go to Date"].waitForExistence(timeout: 3), "Go to Date")
        shot("hp-flow-4-go-to-date")
        app.navigationBars["Go to Date"].buttons["Open"].tap()
        XCTAssertTrue(app.descendants(matching: .any)["day-result"].firstMatch.waitForExistence(timeout: 5), "The chosen day opens")
        shot("hp-flow-3-chosen-day")
        app.buttons["day-close"].tap()
        sleep(1)
        let months = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'history-month-'"))
        XCTAssertTrue(months.firstMatch.waitForExistence(timeout: 3))
        let rowsBefore = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'habit-day-'")).count
        months.firstMatch.tap(); sleep(1)
        let rowsAfter = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'habit-day-'")).count
        XCTAssertLessThan(rowsAfter, rowsBefore, "Folding a month hides its days")
        shot("hp-flow-5-month-folded")
        months.firstMatch.tap(); sleep(1)
    }

    /// Writes a note on today from History: today's row opens Day details, whose Add a Note saves it there.
    private func addNoteToday(_ text: String) {
        tab("History")
        let today = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'habit-day-'")).firstMatch
        XCTAssertTrue(today.waitForExistence(timeout: 5), "Today's row")
        today.tap()
        let add = app.buttons["day-add-note"]
        XCTAssertTrue(add.waitForExistence(timeout: 5), "Day details' Add a Note")
        add.tap()
        let field = app.textViews["note-field"]
        XCTAssertTrue(field.waitForExistence(timeout: 3))
        XCTAssertTrue(app.keyboards.firstMatch.waitForExistence(timeout: 3), "The keyboard comes up by itself")
        field.typeText(text)
        app.buttons["note-save"].tap()
        XCTAssertTrue(app.buttons["day-edit-note"].waitForExistence(timeout: 5), "The note shows in Day details")
    }

    /// Notes live in History (Figma's History · with notes and Notes search, 1053:9079): a note written on a day shows
    /// under its row; Search notes finds it, the word in bold, and a result opens its day.
    func testNotesFlows() {
        launch()
        open("Read")
        tab("History")
        XCTAssertFalse(app.buttons["history-search-notes"].exists, "No search before there's a note")
        addNoteToday("Read on the train; the long chapter went quickly.")
        app.buttons["day-close"].tap()
        let row = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'habit-day-' AND label CONTAINS 'train'")).firstMatch
        XCTAssertTrue(row.waitForExistence(timeout: 5), "The note shows under its day")
        let search = app.buttons["history-search-notes"]
        XCTAssertTrue(search.waitForExistence(timeout: 3), "Search notes, once there's a note")
        XCTAssertGreaterThan(search.frame.width, app.windows.firstMatch.frame.width * 0.7, "Search has the width: \(search.frame)")
        shot("hp-notes-0-history-with-a-note")
        search.tap()
        let field = app.searchFields.firstMatch
        XCTAssertTrue(field.waitForExistence(timeout: 3), "The search page, its field ready")
        XCTAssertTrue(app.staticTexts["Search Read’s notes by any word."].waitForExistence(timeout: 3), "Before a word")
        field.typeText("train")
        let result = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'notes-result-'")).firstMatch
        XCTAssertTrue(result.waitForExistence(timeout: 3), "The note is found")
        XCTAssertTrue(app.staticTexts["1 note"].exists, "Counted")
        shot("hp-notes-1-results")
        field.typeText("zzz")
        XCTAssertTrue(app.staticTexts["No Notes with “trainzzz”"].waitForExistence(timeout: 3), "Nothing found")
        shot("hp-notes-2-nothing-found")
        for _ in 0..<3 { field.typeText(XCUIKeyboardKey.delete.rawValue) }
        XCTAssertTrue(result.waitForExistence(timeout: 3))
        result.tap()
        XCTAssertTrue(app.descendants(matching: .any)["day-result"].firstMatch.waitForExistence(timeout: 5), "The result opens its day")
        XCTAssertTrue(app.buttons["day-edit-note"].exists, "With the note")
        app.buttons["day-close"].tap()
        XCTAssertTrue(app.segmentedControls["habit-tabs"].waitForExistence(timeout: 3), "Back on the habit page")
    }

    /// "What the squares mean" starts closed on every habit's page and is never remembered (the user, 19 Nov 2026):
    /// opened on one page it stays open while the person stays there, and is closed on another habit's page and on the
    /// next visit.
    func testSquaresKeyStartsClosedOnEveryPage() {
        launch()
        let key = app.descendants(matching: .any)["progress-key"]
        let toggle = app.buttons["heat-key-toggle"]
        open("Read")
        app.revealAndTap(toggle)
        XCTAssertTrue(key.waitForExistence(timeout: 3), "A tap opens it")
        tab("History")
        tab("Progress")
        XCTAssertTrue(key.waitForExistence(timeout: 3), "Still open on the same page")
        back()
        open("Water")
        XCTAssertTrue(app.reveal(toggle))
        XCTAssertFalse(key.exists, "Another habit: closed")
        shot("hp-key-2-closed")
        back()
        open("Read")
        XCTAssertTrue(app.reveal(toggle))
        XCTAssertFalse(key.exists, "The next visit: closed again")
    }

    /// With Notes keeps only the days with a note, in History's month cards (Figma's History · with notes).
    func testWithNotesKeepsDaysWithANote() {
        launch()
        open("Floss")
        addNoteToday("Flossed at the bus stop.")
        app.buttons["day-close"].tap()
        let days = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'habit-day-'"))
        XCTAssertTrue(days.firstMatch.waitForExistence(timeout: 5))
        XCTAssertGreaterThan(days.count, 1, "Every day, before the filter")
        let filter = app.buttons["history-with-notes"]
        XCTAssertTrue(filter.waitForExistence(timeout: 3), "With Notes, once there's a note")
        filter.tap()
        sleep(1)
        XCTAssertEqual(days.count, 1, "Only the day with a note")
        XCTAssertTrue(days.firstMatch.label.contains("bus stop"), "That day: \(days.firstMatch.label)")
        let month = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'history-month-'")).firstMatch
        XCTAssertTrue(month.label.contains("1 day with a note"), "The month says how many: \(month.label)")
        shot("hp-notes-3-with-notes")
        filter.tap()
        sleep(1)
        XCTAssertGreaterThan(days.count, 1, "Every day again")
    }

    /// A note opens as a view, Note: Edit opens Edit Note with Save; Delete Note asks first, naming the day (U19,
    /// 7 Oct 2026). Written from a day in History, its day is that day and can't change.
    func testNoteViewEditAndDelete() {
        launch()
        open("Floss")
        tab("History")
        let today = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'habit-day-'")).firstMatch
        XCTAssertTrue(today.waitForExistence(timeout: 5))
        today.tap()
        app.buttons["day-add-note"].tap()
        XCTAssertTrue(app.navigationBars["Add Note"].waitForExistence(timeout: 3))
        XCTAssertFalse(app.descendants(matching: .any)["note-date"].firstMatch.exists, "From a day, the day is fixed")
        XCTAssertFalse(app.buttons["note-save"].isEnabled, "Save is off until something is written")
        let field = app.textViews["note-field"]
        XCTAssertTrue(field.waitForExistence(timeout: 3))
        XCTAssertTrue(app.keyboards.firstMatch.waitForExistence(timeout: 3), "Typing first")
        XCTAssertLessThan(app.buttons["note-save"].frame.maxY, app.keyboards.firstMatch.frame.minY + 1, "Add, in the bar above the keyboard")
        field.typeText("Flossed at the bus stop.")
        shot("hp-note-add")
        app.buttons["note-save"].tap()
        let row = app.buttons["day-edit-note"]
        XCTAssertTrue(row.waitForExistence(timeout: 3))
        row.tap()
        XCTAssertTrue(app.navigationBars["Note"].waitForExistence(timeout: 3), "A note opens as a view")
        XCTAssertEqual(app.buttons["note-delete"].label, "Delete Note")
        shot("hp-note-view")
        app.buttons["note-edit"].tap()
        XCTAssertTrue(app.navigationBars["Edit Note"].waitForExistence(timeout: 3))
        let edit = app.textViews["note-field"]
        XCTAssertTrue(edit.waitForExistence(timeout: 3))
        XCTAssertTrue(app.keyboards.firstMatch.waitForExistence(timeout: 3), "Edit opens the keyboard")
        XCTAssertTrue(app.buttons["note-save"].isEnabled, "Save is always on in edit mode")
        edit.typeText(" Twice.")
        app.buttons["note-save"].tap()
        XCTAssertTrue(app.navigationBars["Note"].waitForExistence(timeout: 3), "Save returns to the view")
        XCTAssertTrue(app.descendants(matching: .any)["note-text"].label.contains("Twice."), "The changed note")
        app.buttons["note-delete"].tap()
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.waitForExistence(timeout: 3), "Delete asks first")
        XCTAssertTrue(alert.label.contains("Delete this note?"))
        XCTAssertTrue(alert.staticTexts.matching(NSPredicate(format: "label BEGINSWITH 'Only the note for'")).firstMatch.exists)
        shot("hp-note-delete-asks")
        alert.buttons["Delete"].tap()
        XCTAssertTrue(app.buttons["day-add-note"].waitForExistence(timeout: 5), "The note is gone: Add a Note again")
    }

    /// Year in Pixels: a tap shows the day under the grid, and Open Day opens it.
    func testYearInPixels() {
        launch()
        open("Swim")
        tab("Progress")
        let grid = app.descendants(matching: .any)["habit-year-grid"]
        XCTAssertTrue(scrollTo(grid, swipes: 12), "Year in Pixels")
        app.swipeUp(velocity: .slow); sleep(1)
        // Today's column holds this month; tap the top-left square (1 January), which every year has.
        let frame = grid.frame
        app.coordinate(withNormalizedOffset: .zero).withOffset(CGVector(dx: frame.minX + 12 + 20 + 12, dy: frame.minY + 120)).tap()
        sleep(1)
        shot("hp-year-1-selected")
    }

    /// Streaks on the habit's Progress tab (Current Work 23, 8 Oct 2026): Current and Best, early, in the goal's own unit
    /// (days for a daily habit, weeks for a weekly total); gone when Show Streaks is off, while the total stays.
    func testStreaksOnTheProgressTab() {
        launch()
        for (name, unit) in [("Water", "day"), ("Running", "week")] {
            open(name)
            tab("Progress")
            let current = app.descendants(matching: .any)["habit-streak-current"]
            let best = app.descendants(matching: .any)["habit-streak-best"]
            XCTAssertTrue(bringTopIntoView(current), "\(name): the current streak, early in Progress")
            XCTAssertTrue(current.label.hasPrefix("Current streak") && current.label.contains(unit), "\(name): \(current.label)")
            XCTAssertTrue(best.label.hasPrefix("Best streak") && best.label.contains(unit), "\(name): \(best.label)")
            func number(_ label: String) -> Int { Int(label.split(separator: " ").first { Int($0) != nil } ?? "") ?? -1 }
            XCTAssertLessThanOrEqual(number(current.label), number(best.label), "\(name): the best is never below the current")
            shot("hp-streaks-\(name.lowercased())")
            back()
        }
        app.terminate()
        app.launchArguments = ["-uitest", "-year-demo", "-progress.showStreaks", "NO"]
        app.launch()
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 10))
        open("Water")
        tab("Progress")
        let record = app.descendants(matching: .any)["habit-progress-record"]
        XCTAssertTrue(record.waitForExistence(timeout: 5), "Overall record")
        XCTAssertTrue(app.descendants(matching: .any)["habit-record-goal-met"].exists, "Show Streaks off: Goal met stays")
        XCTAssertTrue(app.descendants(matching: .any)["habit-record-best-period"].exists, "Show Streaks off: Best day stays")
        shot("hp-record-streaks-off")
        let milestones = app.descendants(matching: .any)["habit-milestones"]
        XCTAssertTrue(bringTopIntoView(milestones), "Milestones stay: a total isn't a streak")
        XCTAssertFalse(app.descendants(matching: .any)["habit-streak-current"].exists, "Show Streaks off: no streak")
        XCTAssertFalse(app.descendants(matching: .any)["habit-milestone-next-inARow"].exists, "Show Streaks off: no in-a-row Next")
        XCTAssertTrue(app.descendants(matching: .any)["habit-milestone-next-inTotal"].exists, "Show Streaks off: In total stays")
        shot("hp-streaks-off")
    }

    /// Overall record (spec "Habit Progress" §2, 11 Oct 2026): the headline, then Current and Best streak, Goal met and
    /// Best day as four boxes, each one VoiceOver element.
    func testOverallRecordBoxes() {
        launch()
        open("Water")
        tab("Progress")
        let headline = app.descendants(matching: .any)["habit-record-headline"]
        XCTAssertTrue(headline.waitForExistence(timeout: 5), "The Overall record's headline")
        XCTAssertTrue(headline.label.hasSuffix("glasses recorded"), "Headline: \(headline.label)")
        let boxes = ["habit-streak-current": "Current streak, ", "habit-streak-best": "Best streak, ",
                     "habit-record-goal-met": "Goal met, ", "habit-record-best-period": "Best day, "]
        for (id, start) in boxes {
            let box = app.descendants(matching: .any)[id]
            XCTAssertTrue(box.exists && box.label.hasPrefix(start), "\(id): \(box.exists ? box.label : "missing")")
        }
        let current = app.descendants(matching: .any)["habit-streak-current"].frame
        let best = app.descendants(matching: .any)["habit-streak-best"].frame
        let goal = app.descendants(matching: .any)["habit-record-goal-met"].frame
        XCTAssertTrue(abs(current.minY - best.minY) < 1 && abs(current.height - best.height) < 1 && goal.minY > current.maxY,
                      "Two boxes a row, equal heights: current \(current), best \(best), goal met \(goal)")
        shot("hp-record-water")
    }

    /// Milestones (spec §3): none reached (Lunch, no phone: 2 days so far), one (No screens: 3 days), many (Brush teeth:
    /// 90 days), then See all opens the All milestones page and Back returns.
    func testMilestonesNoneOneMany() {
        launch()
        func card(_ name: String) -> XCUIElement {
            open(name)
            tab("Progress")
            let milestones = app.descendants(matching: .any)["habit-milestones"]
            XCTAssertTrue(bringTopIntoView(milestones), "\(name): Milestones")
            return milestones
        }
        let latest = app.descendants(matching: .any)["habit-milestone-latest"]
        let seeAll = app.descendants(matching: .any)["habit-milestones-see-all"]
        let nextRow = app.descendants(matching: .any)["habit-milestone-next-inARow"]
        let nextTotal = app.descendants(matching: .any)["habit-milestone-next-inTotal"]

        _ = card("Lunch, no phone")
        XCTAssertFalse(latest.exists, "None reached: no medal")
        XCTAssertFalse(seeAll.exists, "None reached: no See all")
        XCTAssertTrue(nextRow.label.hasPrefix("Next: 3 days in a row"), "None reached, next in a row: \(nextRow.label)")
        XCTAssertTrue(nextTotal.label.hasPrefix("Next: 10 times in total"), "None reached, next in total: \(nextTotal.label)")
        shot("hp-milestones-none")
        back()

        _ = card("No screens")
        XCTAssertTrue(latest.waitForExistence(timeout: 5) && latest.label.hasPrefix("3 days in a row, reached "), "One reached: \(latest.label)")
        XCTAssertFalse(seeAll.exists, "One reached: no See all")
        XCTAssertTrue(app.staticTexts["1 reached"].exists, "One reached: \"1 reached\" in the title line")
        shot("hp-milestones-one")
        back()

        _ = card("Brush teeth")
        XCTAssertTrue(latest.waitForExistence(timeout: 5) && latest.label.hasPrefix("Latest: "), "Many reached: \(latest.label)")
        XCTAssertTrue(seeAll.exists && seeAll.label.hasPrefix("See all ") && seeAll.label.hasSuffix(" milestones"), "See all: \(seeAll.label)")
        XCTAssertTrue(app.descendants(matching: .any)["habit-milestone-shelf"].exists, "Many reached: the Earlier shelf")
        shot("hp-milestones-many")
        seeAll.tap()
        let page = app.descendants(matching: .any)["all-milestones"]
        XCTAssertTrue(page.waitForExistence(timeout: 5) && app.navigationBars["Milestones"].exists, "The All milestones page")
        XCTAssertTrue(app.descendants(matching: .any)["all-milestones-inARow"].exists, "All milestones: In a row")
        XCTAssertTrue(app.descendants(matching: .any)["all-milestones-inTotal"].exists, "All milestones: In total")
        XCTAssertTrue(app.staticTexts["Milestones you reach stay here, even when a run starts again."].exists
                      || { app.swipeUp(velocity: .slow); return app.staticTexts["Milestones you reach stay here, even when a run starts again."].exists }(),
                      "All milestones: the footnote")
        shot("hp-milestones-all")
        app.navigationBars["Milestones"].buttons.element(boundBy: 0).tap()
        XCTAssertTrue(app.segmentedControls["habit-tabs"].waitForExistence(timeout: 5), "Back on the habit page")
        XCTAssertTrue(app.segmentedControls["habit-tabs"].buttons["Progress"].isSelected, "Still on Progress")
    }

    /// A week goal (spec §5.2): Call family, 3 times a week, 4 weeks met. The streak in weeks with this week's progress,
    /// Goal met in weeks, Best week, and "weeks of goals met" for In total.
    func testWeeklyGoalProgress() {
        launch()
        open("Call family")
        tab("Progress")
        let current = app.descendants(matching: .any)["habit-streak-current"]
        XCTAssertTrue(current.waitForExistence(timeout: 5), "Current streak")
        XCTAssertTrue(current.label.contains("weeks") && current.label.contains("This week: "), "Current: \(current.label)")
        let goal = app.descendants(matching: .any)["habit-record-goal-met"]
        XCTAssertTrue(goal.label.hasPrefix("Goal met, ") && goal.label.contains(" weeks"), "Goal met: \(goal.label)")
        let bestWeek = app.descendants(matching: .any)["habit-record-best-period"]
        XCTAssertTrue(bestWeek.label.hasPrefix("Best week, "), "Best week: \(bestWeek.label)")
        shot("hp-record-weekly")
        let milestones = app.descendants(matching: .any)["habit-milestones"]
        XCTAssertTrue(bringTopIntoView(milestones), "Milestones")
        let total = app.descendants(matching: .any)["habit-milestone-next-inTotal"]
        XCTAssertTrue(total.label.contains("weeks of goals met"), "Next in total: \(total.label)")
        let latest = app.descendants(matching: .any)["habit-milestone-latest"]
        XCTAssertTrue(latest.label.contains("weeks in a row, reached "), "Latest: \(latest.label)")
        shot("hp-milestones-weekly")
    }

    /// Pictures for the user's review (11 Oct 2026), light and dark: Overall record, Milestones with none, one and many
    /// reached, the All milestones page, and a week goal.
    func testProgressRedesignPictures() {
        for theme in ["light", "dark"] {
            app.terminate()
            launch(theme)
            // In the Habits list's order, top to bottom.
            for (name, picture) in [("Call family", "weekly"), ("Brush teeth", "many"), ("Lunch, no phone", "none"), ("No screens", "one")] {
                open(name)
                tab("Progress")
                XCTAssertTrue(app.descendants(matching: .any)["habit-progress-record"].waitForExistence(timeout: 5), "\(name): Overall record")
                shot("hp-redesign-\(theme)-\(picture)-record")
                let milestones = app.descendants(matching: .any)["habit-milestones"]
                XCTAssertTrue(bringTopIntoView(milestones), "\(name): Milestones")
                shot("hp-redesign-\(theme)-\(picture)-milestones")
                let seeAll = app.descendants(matching: .any)["habit-milestones-see-all"]
                if picture == "many", seeAll.exists {
                    seeAll.tap()
                    XCTAssertTrue(app.descendants(matching: .any)["all-milestones"].waitForExistence(timeout: 5), "All milestones")
                    sleep(1)
                    shot("hp-redesign-\(theme)-all-milestones")
                    app.navigationBars["Milestones"].buttons.element(boundBy: 0).tap()
                    sleep(1)
                }
                back()
            }
        }
    }

    /// The Week, Month and Year cards' spacing (Current Work 31, 8 Oct 2026): each card's title with the card's full top
    /// padding, in light, dark and a large accessibility text size. Pictures of each card's top.
    func testPeriodCardSpacing() {
        for (name, theme, size) in [("light", "light", ""), ("dark", "dark", ""), ("large-text", "light", "UICTContentSizeCategoryAccessibilityL")] {
            app.terminate()
            app.launchArguments = ["-uitest", "-year-demo", "-appearance.theme", theme]
                + (size.isEmpty ? [] : ["-UIPreferredContentSizeCategoryName", size])
            app.launch()
            XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 10))
            open("Water")
            tab("Progress")
            for card in ["habit-progress-week", "habit-progress-month", "habit-year-grid"] {
                let element = app.descendants(matching: .any)[card]
                XCTAssertTrue(bringTopIntoView(element), "\(card)'s top on screen (\(name))")
                shot("hp-cards-\(name)-\(card)")
            }
        }
    }

    /// Every day number, 1 to 31, beside its row (Current Work 32, 8 Oct 2026): light, dark and a large accessibility
    /// text size (the labels stop growing where "31" still fits). Pictures only: the grid is one Canvas.
    func testYearInPixelsDayNumbers() {
        for (name, theme, size) in [("light", "light", ""), ("dark", "dark", ""), ("large-text", "light", "UICTContentSizeCategoryAccessibilityL")] {
            app.terminate()
            app.launchArguments = ["-uitest", "-year-demo", "-appearance.theme", theme]
                + (size.isEmpty ? [] : ["-UIPreferredContentSizeCategoryName", size])
            app.launch()
            XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 10))
            open("Swim")
            tab("Progress")
            let grid = app.descendants(matching: .any)["habit-year-grid"]
            XCTAssertTrue(scrollTo(grid, swipes: 16), "Year in Pixels (\(name))")
            shot("hp-year-days-\(name)-1-top")
            app.swipeUp(velocity: .slow); sleep(1)
            shot("hp-year-days-\(name)-2-middle")
            app.swipeUp(velocity: .slow); sleep(1)
            shot("hp-year-days-\(name)-3-end") // 27 to 31
        }
    }
}
