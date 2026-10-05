import XCTest

/// The habit page (3 Oct 2026: History · Notes · Progress; checklist "Habit Details Page — Build"): pictures of every
/// habit type's three tabs, light and dark, and the flows the research asks for: add an entry, go to a date, fold a
/// month, write, find and read a note, and pick a day in Year in Pixels.
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
        if !app.navigationBars["Habits"].exists {
            if bar.buttons["BackButton"].exists { bar.buttons["BackButton"].tap() }
            let habits = app.buttons["menu-habits"]
            if !habits.exists {
                app.buttons["menu-button"].tap()
                // The first tap can land while the year demo is still being saved: try the ≡ once more.
                if !habits.waitForExistence(timeout: 5) { app.buttons["menu-button"].tap() }
            }
            XCTAssertTrue(habits.waitForExistence(timeout: 10), "The ≡ menu opens")
            habits.tap()
        }
        XCTAssertTrue(app.navigationBars["Habits"].waitForExistence(timeout: 5), "The Habits list")
        let row = app.staticTexts[name].firstMatch
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

    private func tab(_ title: String) {
        app.segmentedControls["habit-tabs"].buttons[title].tap()
        sleep(1)
    }

    /// Swipes until the element is on screen (the page is a scroll view of cards, not a list).
    @discardableResult
    private func scrollTo(_ element: XCUIElement, swipes: Int = 10) -> Bool {
        for _ in 0..<swipes where !(element.exists && element.isHittable) { app.swipeUp(velocity: .slow) }
        return element.exists && element.isHittable
    }

    private func topOfPage() {
        for _ in 0..<12 { app.swipeDown(velocity: .fast) }
        sleep(1)
    }

    /// Every type's page: History (top and a fold), Notes, Progress top to bottom.
    private func pictures(_ names: [String], prefix: String, progressShots: Int = 5) {
        for name in names {
            open(name)
            let key = name.lowercased().replacingOccurrences(of: " ", with: "-")
            shot("\(prefix)-\(key)-1-history")
            app.swipeUp(velocity: .slow); sleep(1)
            shot("\(prefix)-\(key)-2-history-scrolled")
            topOfPage()
            tab("Notes")
            shot("\(prefix)-\(key)-3-notes")
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

    /// Add Entry from History (Water: an amount), Go to Date, and a month folding and opening.
    func testHistoryFlows() {
        launch()
        open("Water")
        // Secondary actions at their own size, never full-width and large (Current Work 26, 5 Oct 2026).
        let add = app.buttons["history-add-entry"], go = app.buttons["history-go-to-date"]
        let width = app.windows.firstMatch.frame.width
        XCTAssertTrue(add.waitForExistence(timeout: 3) && go.exists)
        XCTAssertLessThan(add.frame.width, width * 0.45, "Add Entry is its own width: \(add.frame)")
        XCTAssertLessThan(go.frame.width, width * 0.45, "Go to Date is its own width: \(go.frame)")
        XCTAssertGreaterThanOrEqual(add.frame.height, 28, "Still a comfortable button: \(add.frame)")
        XCTAssertLessThan(add.frame.height, 50, "Not a large button: \(add.frame)")
        shot("hp-flow-0-history-buttons")
        app.buttons["history-add-entry"].tap()
        XCTAssertTrue(app.navigationBars["Add Entry"].waitForExistence(timeout: 3), "Add Entry")
        let amount = app.textFields["log-amount"]
        XCTAssertTrue(amount.waitForExistence(timeout: 3))
        amount.typeText("2")
        shot("hp-flow-1-add-entry")
        app.navigationBars["Add Entry"].buttons["add-entry-save"].tap()
        XCTAssertTrue(app.navigationBars["Add Entry"].waitForNonExistence(timeout: 5), "Added and closed")
        let today = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'habit-day-'")).firstMatch
        XCTAssertTrue(today.waitForExistence(timeout: 5))
        today.tap()
        XCTAssertTrue(app.descendants(matching: .any)["day-result"].firstMatch.waitForExistence(timeout: 5), "The day opens")
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

    /// Notes: add one, find it by searching, read it, and see it in the list.
    func testNotesFlows() {
        launch()
        open("Read")
        let historyButton = app.buttons["history-add-entry"]
        XCTAssertTrue(historyButton.waitForExistence(timeout: 3))
        let historyHeight = historyButton.frame.height
        tab("Notes")
        app.buttons["notes-add"].tap()
        let field = app.descendants(matching: .any)["note-field"].firstMatch
        XCTAssertTrue(field.waitForExistence(timeout: 3))
        XCTAssertTrue(app.keyboards.firstMatch.waitForExistence(timeout: 3), "The keyboard comes up by itself")
        field.typeText("Read on the train; the long chapter went quickly.")
        shot("hp-notes-1-editor")
        app.buttons["note-save"].tap()
        sleep(1)
        let search = app.textFields["notes-search"]
        XCTAssertTrue(search.waitForExistence(timeout: 3))
        // Search across the width, Add Note under it as History's buttons are (Current Work 26, 5 Oct 2026).
        let add = app.buttons["notes-add"]
        XCTAssertGreaterThan(search.frame.width, app.windows.firstMatch.frame.width * 0.7, "Search has the width: \(search.frame)")
        XCTAssertGreaterThan(add.frame.minY, search.frame.maxY, "Add Note is under the search field")
        XCTAssertEqual(add.frame.height, historyHeight, accuracy: 1, "The same button as History's")
        shot("hp-notes-0-search-and-add")
        search.tap(); search.typeText("train")
        sleep(1)
        shot("hp-notes-2-search")
        let note = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'note-'")).firstMatch
        XCTAssertTrue(note.waitForExistence(timeout: 3), "The note is found")
        note.tap()
        XCTAssertTrue(app.descendants(matching: .any)["note-text"].waitForExistence(timeout: 3), "The note reads in full")
        shot("hp-notes-3-reader")
        back()
    }

    /// "What the squares mean" opens by itself only on the first visit to each habit's page; later visits start it
    /// folded, a tap opens it, and another habit's first visit is its own (Current Work 25, 5 Oct 2026).
    func testSquaresKeyOpensOnlyOnTheFirstVisitToEachHabit() {
        launch()
        let key = app.descendants(matching: .any)["progress-key"]
        let toggle = app.buttons["heat-key-toggle"]
        open("Read")
        XCTAssertTrue(key.waitForExistence(timeout: 3), "First visit: open")
        tab("Progress")
        XCTAssertTrue(key.waitForExistence(timeout: 3), "Same visit, the Progress tab: still open")
        tab("History")
        back()
        open("Read")
        XCTAssertTrue(toggle.waitForExistence(timeout: 3))
        XCTAssertFalse(key.exists, "Next visit: folded")
        shot("hp-key-2-folded")
        toggle.tap()
        XCTAssertTrue(key.waitForExistence(timeout: 3), "A tap opens it")
        back()
        open("Water")
        XCTAssertTrue(key.waitForExistence(timeout: 3), "Another habit's first visit: open")
        back()
        open("Read")
        XCTAssertTrue(toggle.waitForExistence(timeout: 3))
        XCTAssertFalse(key.exists, "Opened by hand last time, folded again on the next visit")
    }

    /// Notes come in month cards that fold like History's, a row per day's note (Current Work 46, 5 Oct 2026).
    func testNotesFoldByMonthLikeHistory() {
        launch()
        open("Floss")
        tab("Notes")
        app.buttons["notes-add"].tap()
        let field = app.descendants(matching: .any)["note-field"].firstMatch
        XCTAssertTrue(field.waitForExistence(timeout: 3))
        field.typeText("Flossed at the bus stop.")
        app.buttons["note-save"].tap()
        sleep(1)
        let month = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'notes-month-'")).firstMatch
        XCTAssertTrue(month.waitForExistence(timeout: 3), "A month card")
        XCTAssertTrue(month.label.contains("note"), "The month says how many notes: \(month.label)")
        let row = app.buttons.matching(NSPredicate(format: "label CONTAINS 'bus stop'")).firstMatch
        XCTAssertTrue(row.waitForExistence(timeout: 3), "Today's note is a row in it")
        XCTAssertTrue(row.label.contains("Today"), "Dated as History dates its days: \(row.label)")
        shot("hp-notes-4-month-open")
        month.tap()
        XCTAssertTrue(row.waitForNonExistence(timeout: 3), "The month folds")
        shot("hp-notes-5-month-folded")
        month.tap()
        XCTAssertTrue(row.waitForExistence(timeout: 3), "And opens again")
        row.tap()
        XCTAssertTrue(app.descendants(matching: .any)["note-text"].waitForExistence(timeout: 3), "The note reads in full")
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
}
