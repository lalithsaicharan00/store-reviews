import XCTest

/// Long names, units and section names at their limits, on every screen that shows them.
/// Run it on the smallest and largest iPhones as well as the test phone.
final class LongTextUITests: XCTestCase {
    override func record(_ issue: XCTIssue) {
        let shot = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        shot.name = "FAIL-\(name)"
        shot.lifetime = .keepAlways
        var issue = issue
        issue.add(shot)
        super.record(issue)
    }

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
        let window = app.windows.firstMatch
        for _ in 0..<4 { app.swipeDown() }
        // Short drags avoid jumping over compact rows on the SE.
        for _ in 0..<20 {
            if element.exists && element.isHittable && element.frame.minY > 100 && element.frame.maxY < window.frame.maxY - 90 { return true }
            let upward = !element.exists || element.frame.minY > window.frame.midY
            window.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: upward ? 0.65 : 0.35))
                .press(forDuration: 0.05, thenDragTo: window.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: upward ? 0.42 : 0.58)))
        }
        return element.exists && element.isHittable
    }

    private func button(startingWith text: String) -> XCUIElement {
        app.buttons.matching(NSPredicate(format: "label BEGINSWITH %@", text)).firstMatch
    }

    /// Every choice is on screen with no scrolling, on each question screen.
    func testChooserShowsEverything() {
        app.navigationBars.buttons["New Habit"].firstMatch.tap()
        XCTAssertTrue(app.navigationBars["New"].waitForExistence(timeout: 3))
        sleep(1) // let the sheet finish rising
        shot("01-chooser")
        let screen = app.windows.firstMatch.frame
        func visible(_ titles: [String]) {
            for title in titles {
                let row = button(startingWith: title)
                XCTAssertTrue(row.exists, "\(title) is listed")
                XCTAssertLessThanOrEqual(row.frame.maxY, screen.maxY, "\(title) is visible without scrolling")
            }
        }
        visible(["Build or maintain", "Quit or cut down", "Add a task"])
        button(startingWith: "Build or maintain").tap()
        XCTAssertTrue(app.navigationBars["Build or maintain"].waitForExistence(timeout: 3))
        visible(["Check it off", "Track an amount", "Time it", "Checklist"])
        shot("01b-build")
        app.navigationBars.buttons["BackButton"].firstMatch.tap()
        button(startingWith: "Quit or cut down").tap()
        XCTAssertTrue(app.navigationBars["Quit or cut down"].waitForExistence(timeout: 3))
        visible(["Quit", "Cut down"])
    }

    func testTodayWithLongText() {
        let morning = button(startingWith: "Before breakfast")
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
        for name in ["Anytime", "Before breakfast", "Lunch break walk", "Once kids sleep"] {
            let header = button(startingWith: name)
            if header.exists, header.value as? String == "Open" { header.tap(); sleep(1) }
        }
        shot("04-today-folded")
        app.swipeUp()
        shot("05-today-folded-scrolled")
        let edit = app.buttons["Edit Times of Day"]
        XCTAssertTrue(edit.waitForExistence(timeout: 3))
        edit.tap()
        XCTAssertTrue(app.navigationBars["Times of Day"].waitForExistence(timeout: 3))
        shot("06-times-of-day")
        // The row in the sheet, not the Today header behind it: its label carries the hours.
        app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Before breakfast' AND label CONTAINS '–'")).firstMatch.tap()
        XCTAssertTrue(app.navigationBars["Edit Time of Day"].waitForExistence(timeout: 3))
        shot("07-section-editor")
        let field = app.textFields["Name"]
        field.tap()
        field.typeText(" and a lot more words")
        let atLimit = expectation(for: NSPredicate { el, _ in ((el as? XCUIElement)?.value as? String ?? "").count <= 16 }, evaluatedWith: field)
        wait(for: [atLimit], timeout: 3)
        XCTAssertTrue((field.value as? String ?? "") == "Before breakfast", "Typing into a full name keeps what was there")
        shot("08-section-editor-at-limit")
    }

    func testFormWithLongText() {
        app.navigationBars.buttons["New Habit"].firstMatch.tap()
        button(startingWith: "Build or maintain").tap()
        button(startingWith: "Track an amount").tap()
        let name = app.descendants(matching: .any)["name-field"]
        XCTAssertTrue(name.waitForExistence(timeout: 3))
        name.tap()
        name.typeText(String(repeating: "Read one more chapter of the book on the nightstand ", count: 3))
        // The cap is applied as each change lands, so wait for the last one before reading.
        let capped = expectation(for: NSPredicate { el, _ in ((el as? XCUIElement)?.value as? String ?? "").count <= 24 }, evaluatedWith: name)
        wait(for: [capped], timeout: 3)
        shot("09-form-long-name")
        app.toolbars.buttons["Done"].firstMatch.tap()

        // Goal: 12 of a long unit of your own (units stop at 12 characters).
        button(startingWith: "Goal").tap()
        let amount = app.textFields["goal-amount"]
        amount.tap(); sleep(1); amount.typeText("12")
        let done = app.toolbars.buttons["Done"].firstMatch
        if done.exists && done.isHittable { done.tap(); sleep(1) }
        app.buttons["goal-unit"].tap()
        app.buttons["create-unit"].tap()
        let own = app.textFields["custom-unit"]
        XCTAssertTrue(own.waitForExistence(timeout: 2))
        own.typeText("tablespoons of chia seeds and oats")
        XCTAssertLessThanOrEqual((own.value as? String ?? "").count, 12, "Units stop at 12 characters")
        own.typeText("\n")
        sleep(1)
        shot("10-goal-long-unit")
        app.navigationBars.buttons["BackButton"].firstMatch.tap(); sleep(1)

        // Time of Day: the long-named lunch section.
        button(startingWith: "Time of Day").tap()
        XCTAssertTrue(app.navigationBars["Time of Day"].waitForExistence(timeout: 3))
        // The Time of Day row itself (the Today header behind the sheet also starts "Lunch break").
        let lunch = app.buttons["Lunch break walk"].firstMatch
        XCTAssertTrue(lunch.waitForExistence(timeout: 2))
        lunch.tap()
        shot("11-time-of-day-long")
        app.navigationBars.buttons["BackButton"].firstMatch.tap(); sleep(1)
        shot("12-form-long-section")
        app.navigationBars["Track an amount"].buttons["Add"].tap()
        let allow = XCUIApplication(bundleIdentifier: "com.apple.springboard").buttons["Allow"]
        if allow.waitForExistence(timeout: 3) { allow.tap() }
        // Sections that aren't Now start folded; open this one to see the new row.
        let lunch2 = button(startingWith: "Lunch break walk")
        XCTAssertTrue(find(lunch2))
        if lunch2.value as? String == "Folded" { lunch2.tap(); sleep(1) }
        // 12 of an unknown unit: + asks how much.
        let row = button(startingWith: "Add amount to Read one more")
        if !find(row) {
            print("BUTTONS: " + app.buttons.allElementsBoundByIndex.map(\.label).joined(separator: " | "))
            shot("13-debug")
        }
        XCTAssertTrue(row.exists, "The habit is saved with its name cut to the limit")
        shot("13-saved-on-today")
    }
}
