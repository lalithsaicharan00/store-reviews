import XCTest

/// Long names, units and section names at their limits, on every screen that shows them.
/// Run it on the smallest and largest iPhones as well as the test phone.
final class LongTextUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-uitest", "-longtext"]
        app.launch()
    }

    private func shot(_ name: String) {
        let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    /// From the top of Today, scrolls down slowly until `element` is on screen.
    private func find(_ element: XCUIElement) -> Bool {
        for _ in 0..<4 { app.swipeDown() }
        let screen = app.windows.firstMatch.frame
        // Past the lower quarter too, so the bottom bar never covers it.
        for _ in 0..<10 where !(element.exists && element.isHittable && element.frame.maxY < screen.maxY * 0.75) {
            app.swipeUp(velocity: .slow)
        }
        return element.exists
    }

    private func button(startingWith text: String) -> XCUIElement {
        app.buttons.matching(NSPredicate(format: "label BEGINSWITH %@", text)).firstMatch
    }

    /// Every kind of item is on screen when + opens, with no scrolling.
    func testChooserShowsEverything() {
        app.navigationBars.buttons["New Habit"].firstMatch.tap()
        XCTAssertTrue(app.navigationBars["New"].waitForExistence(timeout: 3))
        sleep(1) // let the sheet finish rising
        shot("01-chooser")
        let screen = app.windows.firstMatch.frame
        for type in ["Check it off", "Count an amount", "Time it", "Checklist", "Set a limit", "Quit", "To-do"] {
            let row = app.buttons[type]
            XCTAssertTrue(row.exists, "\(type) is listed")
            XCTAssertLessThanOrEqual(row.frame.maxY, screen.maxY, "\(type) is visible without scrolling")
        }
    }

    func testTodayWithLongText() {
        let morning = button(startingWith: "Early morning")
        for _ in 0..<4 where !morning.exists { app.swipeUp() }
        XCTAssertTrue(morning.exists)
        app.swipeDown(); app.swipeDown(); app.swipeDown()
        // Long names show 15 characters, then "…", on one line.
        let water = app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH 'Drink a big glass'")).firstMatch
        for _ in 0..<3 where !water.exists { app.swipeUp() }
        XCTAssertTrue(water.exists)
        XCTAssertLessThan(water.frame.height, 30, "A long name stays on one line (15 characters, then …)")
        app.swipeDown(); app.swipeDown()
        shot("02-today-open")
        // The circular play control retains a 44 pt tap target beside a long name.
        let start = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Start ' AND label ENDSWITH ' routine'")).firstMatch
        for _ in 0..<3 where !start.exists { app.swipeUp() }
        XCTAssertTrue(start.exists, "Routine play remains available")
        XCTAssertGreaterThanOrEqual(start.frame.width, 44, "Play keeps its accessible tap target")
        // Bring the Now card to the middle of the screen for the picture.
        let middle = app.windows.firstMatch.frame.midY
        if start.frame.midY > middle { app.windows.firstMatch.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.8)).press(forDuration: 0.05, thenDragTo: app.windows.firstMatch.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.8 - (start.frame.midY - middle) / app.windows.firstMatch.frame.height))) }
        sleep(1)
        shot("03-today-now-open")
        app.swipeDown(); app.swipeDown()
        // Quitting starts open and folds like the other cards.
        let quitting = button(startingWith: "Quitting")
        XCTAssertTrue(quitting.waitForExistence(timeout: 2))
        let smoking = app.descendants(matching: .any).matching(NSPredicate(format: "label BEGINSWITH 'Smoking'")).firstMatch
        XCTAssertTrue(smoking.exists, "Quitting starts open")
        quitting.tap()
        XCTAssertFalse(smoking.waitForExistence(timeout: 1), "Folding Quitting hides its rows")
        // Fold every section to see the header icons and "+N".
        for name in ["Anytime", "Early morning", "Lunch break", "Evening once"] {
            let header = button(startingWith: name)
            if header.exists, header.value as? String == "Open" { header.tap(); sleep(1) }
        }
        shot("04-today-folded")
        app.swipeUp()
        shot("05-today-folded-scrolled")
        let edit = app.buttons["Edit Day Sections"]
        XCTAssertTrue(edit.waitForExistence(timeout: 3))
        edit.tap()
        XCTAssertTrue(app.navigationBars["Day Sections"].waitForExistence(timeout: 3))
        shot("06-day-sections")
        // The row in the sheet, not the Today header behind it: its label carries the hours.
        app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Early morning' AND label CONTAINS '–'")).firstMatch.tap()
        XCTAssertTrue(app.navigationBars["Edit Section"].waitForExistence(timeout: 3))
        shot("07-section-editor")
        let field = app.textFields["Section name"]
        field.tap()
        field.typeText(" and a lot more words")
        let atLimit = expectation(for: NSPredicate { el, _ in ((el as? XCUIElement)?.value as? String ?? "").count <= 30 }, evaluatedWith: field)
        wait(for: [atLimit], timeout: 3)
        XCTAssertTrue((field.value as? String ?? "").hasPrefix("Early morning before"), "Typing into a full name keeps what was there")
        shot("08-section-editor-at-limit")
    }

    func testFormWithLongText() {
        app.navigationBars.buttons["New Habit"].firstMatch.tap()
        app.buttons["Count an amount"].tap()
        let name = app.descendants(matching: .any)["name-field"]
        XCTAssertTrue(name.waitForExistence(timeout: 3))
        name.tap()
        name.typeText(String(repeating: "Read one more chapter of the book on the nightstand ", count: 3))
        XCTAssertLessThanOrEqual((name.value as? String ?? "").count, 100, "Names stop at 100 characters")
        shot("09-form-long-name")
        app.toolbars.buttons["Done"].firstMatch.tap()

        let unitRow = button(startingWith: "Unit")
        let form = app.collectionViews["habit-form"]
        for _ in 0..<4 where !unitRow.isHittable { form.swipeUp() }
        unitRow.tap()
        let own = app.textFields["Your own unit, e.g. chapters"]
        XCTAssertTrue(own.waitForExistence(timeout: 2))
        own.tap()
        own.typeText("tablespoons of chia seeds and oats")
        XCTAssertLessThanOrEqual((own.value as? String ?? "").count, 24, "Units stop at 24 characters")
        own.typeText("\n")
        let amount = app.textFields["Amount"]
        XCTAssertTrue(amount.waitForExistence(timeout: 3))
        amount.tap()
        amount.typeText("12")
        app.toolbars.buttons["Done"].firstMatch.tap()
        shot("10-form-long-unit")

        let section = button(startingWith: "Day Section")
        for _ in 0..<4 where !section.isHittable { form.swipeUp() }
        section.tap()
        shot("11-section-menu")
        let lunch = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Lunch break'")).firstMatch
        XCTAssertTrue(lunch.waitForExistence(timeout: 2))
        lunch.tap()
        shot("12-form-long-section")
        app.navigationBars["Count an amount"].buttons["Add"].tap()
        // Sections that aren't Now start folded; open this one to see the new row.
        let lunch2 = button(startingWith: "Lunch break")
        XCTAssertTrue(find(lunch2))
        if lunch2.value as? String == "Folded" { lunch2.tap(); sleep(1) }
        let row = button(startingWith: "Add 1 to Read one more")
        if !find(row) {
            print("BUTTONS: " + app.buttons.allElementsBoundByIndex.map(\.label).joined(separator: " | "))
            shot("13-debug")
        }
        XCTAssertTrue(row.exists, "The habit is saved with its name cut to the limit")
        shot("13-saved-on-today")
    }
}
