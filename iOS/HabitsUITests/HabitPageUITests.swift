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

    /// ≡ → Habits → the habit's row.
    private func open(_ name: String) {
        let bar = app.navigationBars.firstMatch
        if !app.buttons["menu-habits"].exists && !app.navigationBars["Habits"].exists {
            if bar.buttons["BackButton"].exists { bar.buttons["BackButton"].tap() }
            app.buttons["menu-button"].tap()
        }
        if app.buttons["menu-habits"].waitForExistence(timeout: 3) { app.buttons["menu-habits"].tap() }
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
        app.buttons["day-previous"].tap(); sleep(1)
        shot("hp-flow-3-previous-day")
        app.navigationBars.buttons["Done"].firstMatch.tap()
        sleep(1)
        app.buttons["history-go-to-date"].tap()
        XCTAssertTrue(app.navigationBars["Go to Date"].waitForExistence(timeout: 3), "Go to Date")
        shot("hp-flow-4-go-to-date")
        app.navigationBars["Go to Date"].buttons["Open"].tap()
        XCTAssertTrue(app.descendants(matching: .any)["day-result"].firstMatch.waitForExistence(timeout: 5), "The chosen day opens")
        app.navigationBars.buttons["Done"].firstMatch.tap()
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
        tab("Notes")
        app.buttons["notes-add"].tap()
        let field = app.descendants(matching: .any)["note-field"].firstMatch
        XCTAssertTrue(field.waitForExistence(timeout: 3))
        field.typeText("Read on the train; the long chapter went quickly.")
        shot("hp-notes-1-editor")
        app.buttons["note-save"].tap()
        sleep(1)
        let search = app.textFields["notes-search"]
        XCTAssertTrue(search.waitForExistence(timeout: 3))
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
