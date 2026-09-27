import XCTest

/// Creates every kind of item through + on a real device, and keeps screenshots of each state.
final class NewHabitUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-uitest"]
        app.launch()
    }

    private func shot(_ name: String) {
        let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    /// Forms build rows lazily, so scroll the sheet's form until the element can be tapped.
    private func scrollTo(_ element: XCUIElement) {
        let form = app.collectionViews["habit-form"]
        for _ in 0..<6 where !(element.exists && element.isHittable) { form.swipeUp() }
    }

    private func open(_ type: String) {
        app.navigationBars.buttons["New Habit"].firstMatch.tap()
        XCTAssertTrue(app.navigationBars["New"].waitForExistence(timeout: 3))
        app.buttons[type].tap()
        XCTAssertTrue(app.navigationBars[type].waitForExistence(timeout: 3))
    }

    private func type(name: String) {
        let field = app.descendants(matching: .any)["name-field"]
        XCTAssertTrue(field.waitForExistence(timeout: 3))
        field.tap()
        field.typeText(name + "\n")
    }

    private func allowNotificationsIfAsked() {
        let allow = XCUIApplication(bundleIdentifier: "com.apple.springboard").buttons["Allow"]
        if allow.waitForExistence(timeout: 3) { allow.tap() }
    }

    private func pickHowOften(_ option: String) {
        let row = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'How Often'")).firstMatch
        scrollTo(row)
        row.tap()
        app.buttons[option].firstMatch.tap()
    }

    func testChooserThenAmountWithReminderRemoved() {
        app.navigationBars.buttons["New Habit"].firstMatch.tap()
        XCTAssertTrue(app.navigationBars["New"].waitForExistence(timeout: 3))
        shot("01-chooser")
        app.buttons["Count an amount"].tap()
        type(name: "Drink water")
        shot("02-amount-form")

        // Nothing is pre-filled: the amount is empty and Add waits for it.
        XCTAssertFalse(app.navigationBars["Count an amount"].buttons["Add"].isEnabled, "No example values are saved")
        // The whole row opens the number pad, and the keyboard has Done.
        app.textFields["Amount"].tap()
        app.textFields["Amount"].typeText("8")
        XCTAssertTrue(app.buttons["Done"].firstMatch.waitForExistence(timeout: 2))
        shot("03-number-keyboard")
        app.buttons["Done"].firstMatch.tap()
        let unitRow = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Unit'")).firstMatch
        scrollTo(unitRow)
        unitRow.tap()
        XCTAssertTrue(app.navigationBars["Unit"].waitForExistence(timeout: 2))
        shot("03b-units")
        app.buttons["glasses"].tap()
        XCTAssertEqual(app.descendants(matching: .any)["name-field"].value as? String, "Drink water", "Coming back from Unit leaves the name alone")

        let addReminder = app.buttons["Add Reminder"]
        scrollTo(addReminder)
        addReminder.tap()
        allowNotificationsIfAsked()
        let remove = app.buttons["Remove reminder"]
        XCTAssertTrue(remove.waitForExistence(timeout: 3), "A reminder row has a remove button")
        shot("04-reminder")
        remove.tap()
        XCTAssertFalse(app.buttons["Remove reminder"].waitForExistence(timeout: 1), "The reminder is removed")

        app.navigationBars["Count an amount"].buttons["Add"].tap()
        XCTAssertTrue(app.staticTexts["Drink water"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.staticTexts["0/8 glasses"].exists)
        shot("05-on-today")
    }

    func testDoItThreeTimesAWeek() {
        open("Check it off")
        type(name: "Gym")
        pickHowOften("A Few Times a Week")
        let summary = app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH 'Any days you like'")).firstMatch
        XCTAssertTrue(summary.waitForExistence(timeout: 2), "Any-day rules say so, unlike set schedules")
        shot("06-times-a-week")
        app.navigationBars["Check it off"].buttons["Add"].tap()
        XCTAssertTrue(app.staticTexts["0/3 this week"].waitForExistence(timeout: 3))
    }

    func testChecklist() {
        open("Checklist")
        type(name: "Workout")
        XCTAssertFalse(app.textFields["e.g. Push-ups"].exists, "No empty item until Add Item")
        XCTAssertFalse(app.navigationBars["Checklist"].buttons["Add"].isEnabled, "A checklist needs an item")
        let addItem = app.buttons["Add Item"]
        scrollTo(addItem)
        addItem.tap()
        let item = app.textFields["e.g. Push-ups"].firstMatch
        XCTAssertTrue(item.waitForExistence(timeout: 2))
        item.typeText("Push-ups\n")
        app.textFields["Next item"].firstMatch.typeText("Squats")
        shot("07-checklist")
        app.navigationBars["Checklist"].buttons["Add"].tap()
        XCTAssertTrue(app.staticTexts["Workout"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.staticTexts["0/2 items"].exists)
    }

    func testOneTimeTask() {
        open("To-do")
        let field = app.descendants(matching: .any)["name-field"]
        XCTAssertTrue(field.waitForExistence(timeout: 3))
        field.tap()
        field.typeText("Book dentist\n")
        shot("08-task")
        app.navigationBars["To-do"].buttons["Add"].tap()
        XCTAssertTrue(app.staticTexts["Book dentist"].waitForExistence(timeout: 3))
        app.buttons["Mark Book dentist done"].tap()
        XCTAssertTrue(app.buttons["Undo Book dentist"].waitForExistence(timeout: 3) || app.staticTexts["All done"].exists)
    }

    func testLimitCanBeAWeeklyTotal() {
        open("Set a limit")
        type(name: "Cigarettes")
        XCTAssertTrue(app.staticTexts["No more than"].exists)
        let row = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'How Often'")).firstMatch
        scrollTo(row)
        row.tap()
        XCTAssertFalse(app.buttons["A Few Times a Week"].waitForExistence(timeout: 1), "Amounts use totals, not a count of days")
        shot("09-limit-menu")
        app.buttons["A Weekly Total"].firstMatch.tap()
        XCTAssertTrue(app.staticTexts["Weekly limit"].waitForExistence(timeout: 2))
    }

    func testAmountWeeklyTotal() {
        open("Time it")
        type(name: "Practise piano")
        pickHowOften("A Weekly Total")
        let minutes = app.textFields["Minutes"]
        scrollTo(minutes)
        XCTAssertTrue(app.staticTexts["Weekly goal"].exists)
        minutes.tap()
        minutes.typeText("180")
        app.toolbars.buttons["Done"].firstMatch.tap()
        shot("15-weekly-total")
        app.navigationBars["Time it"].buttons["Add"].tap()
        XCTAssertTrue(app.staticTexts["0/180 min this week"].waitForExistence(timeout: 3))
    }

    /// One habit in two day sections: a row in each, ticked separately.
    func testCheckOffInTwoSections() {
        open("Check it off")
        type(name: "Brush teeth")
        let menu = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Day Section'")).firstMatch
        scrollTo(menu)
        menu.tap()
        app.buttons["Morning"].firstMatch.tap()
        app.buttons["Evening"].firstMatch.tap()
        shot("16-two-sections-menu")
        app.windows.firstMatch.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.08)).tap()
        XCTAssertTrue(app.buttons["Day Section, Morning, Evening"].waitForExistence(timeout: 2))
        shot("17-two-sections-form")
        app.navigationBars["Check it off"].buttons["Add"].tap()
        // Open both sections, then tick the habit in one of them only.
        for name in ["Morning", "Evening"] {
            // Lists only build the rows on screen, so scroll until the header is there.
            let header = app.buttons.matching(NSPredicate(format: "label BEGINSWITH %@", name)).firstMatch
            for _ in 0..<5 where !(header.exists && header.isHittable) { app.swipeUp() }
            XCTAssertTrue(header.exists, "\(name) is on Today")
            if header.value as? String == "Folded" { header.tap(); sleep(1) }
        }
        // Morning's row: tick it, and Evening's row stays to do.
        app.swipeDown(); app.swipeDown()
        let tick = app.buttons["Mark Brush teeth done"].firstMatch
        for _ in 0..<5 where !(tick.exists && tick.isHittable) { app.swipeUp() }
        tick.tap()
        // Morning is finished; Evening's tick is still to do.
        let morning = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Morning'")).firstMatch
        XCTAssertTrue(morning.waitForExistence(timeout: 3))
        XCTAssertTrue(morning.label.contains("All done"), "Ticking in Morning finishes Morning")
        let evening = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Evening'")).firstMatch
        for _ in 0..<5 where !(evening.exists && evening.isHittable) { app.swipeUp() }
        XCTAssertTrue(evening.label.contains("left"), "Evening's tick is separate")
        XCTAssertTrue(app.buttons["Mark Brush teeth done"].exists)
        shot("18-two-sections-today")
    }

    func testIconSheetClosesOnPick() {
        open("Check it off")
        type(name: "Walk the dog")
        app.buttons["Icon"].tap()
        XCTAssertTrue(app.navigationBars["Icon"].waitForExistence(timeout: 3))
        shot("10-icon-sheet")
        app.buttons["bike"].firstMatch.tap()
        XCTAssertFalse(app.navigationBars["Icon"].waitForExistence(timeout: 1), "Picking closes the sheet")
    }

    func testQuitDiscard() {
        open("Quit")
        type(name: "Sugar")
        XCTAssertTrue(app.staticTexts["Started"].exists)
        XCTAssertFalse(app.buttons["Add Reminder"].exists)
        app.navigationBars["Quit"].buttons["Cancel"].tap()
        let discard = app.buttons["Discard Changes"]
        XCTAssertTrue(discard.waitForExistence(timeout: 2))
        discard.tap()
        XCTAssertTrue(app.navigationBars["New"].waitForExistence(timeout: 2))
    }

    func testCustomUnit() {
        open("Count an amount")
        type(name: "Read")
        let unitRow = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Unit'")).firstMatch
        scrollTo(unitRow)
        unitRow.tap()
        let own = app.textFields["Your own unit, e.g. chapters"]
        XCTAssertTrue(own.waitForExistence(timeout: 2))
        own.tap()
        own.typeText("chapters\n")
        XCTAssertTrue(app.staticTexts["chapters"].waitForExistence(timeout: 2), "The typed unit is used")
        shot("11-custom-unit")
    }

    func testDatesOfTheMonth() {
        open("Check it off")
        type(name: "Pay rent")
        pickHowOften("On Dates of the Month")
        let add = app.navigationBars["Check it off"].buttons["Add"]
        XCTAssertFalse(add.isEnabled, "At least one date is needed")
        app.buttons["Day 1"].tap()
        XCTAssertTrue(add.isEnabled)
        shot("12-month-dates")
    }

    func testNewSectionFromTheForm() {
        open("Check it off")
        type(name: "Pack lunch")
        let menu = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Day Section'")).firstMatch
        scrollTo(menu)
        menu.tap()
        app.buttons["New Section…"].tap()
        let name = app.textFields["Section name"]
        XCTAssertTrue(name.waitForExistence(timeout: 3))
        name.typeText("Before work")
        shot("13-new-section")
        app.navigationBars["New Section"].buttons["Save"].tap()
        XCTAssertTrue(app.buttons["Day Section, Before work"].waitForExistence(timeout: 3), "The new section is chosen")
        app.navigationBars["Check it off"].buttons["Add"].tap()
        let header = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Before work'")).firstMatch
        if !header.waitForExistence(timeout: 3) { print("TREE-DUMP\n" + app.debugDescription) }
        XCTAssertTrue(header.exists, "Today shows the new section")
        shot("14-section-on-today")
    }
}
