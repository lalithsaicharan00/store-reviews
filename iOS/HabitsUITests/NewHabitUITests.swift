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

    private func revealOnToday(_ element: XCUIElement) {
        let window = app.windows.firstMatch
        for _ in 0..<20 {
            if element.exists && element.isHittable && element.frame.minY > 100 && element.frame.maxY < window.frame.maxY - 90 { return }
            let upward = !element.exists || element.frame.minY > window.frame.midY
            window.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: upward ? 0.65 : 0.35))
                .press(forDuration: 0.05, thenDragTo: window.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: upward ? 0.42 : 0.58)))
        }
        XCTAssertTrue(element.isHittable)
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

        let addTime = app.buttons["Add Time"]
        scrollTo(addTime)
        addTime.tap()
        allowNotificationsIfAsked()
        let remove = app.buttons["Remove time"]
        XCTAssertTrue(remove.waitForExistence(timeout: 3), "A time row has a remove button")
        shot("04-reminder")
        remove.tap()
        XCTAssertFalse(app.buttons["Remove time"].waitForExistence(timeout: 1), "The time is removed")

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

    /// Taps Add Time `count` times; each new time is an hour after the last (the first is 9:00 AM in Anytime).
    private func addTimes(_ count: Int) {
        let add = app.buttons["Add Time"]
        for i in 0..<count {
            scrollTo(add)
            add.tap()
            if i == 0 { allowNotificationsIfAsked() }
        }
    }

    /// Sets the `index`th time row's picker, e.g. to 9 PM, with its wheels (12- or 24-hour phones).
    private func setTime(row index: Int, hour24: Int, minute: Int = 0) {
        let picker = app.datePickers.element(boundBy: index)
        scrollTo(picker)
        picker.tap()
        let wheels = app.pickerWheels
        XCTAssertTrue(wheels.firstMatch.waitForExistence(timeout: 3), "The time wheels open")
        if wheels.count >= 3 {
            wheels.element(boundBy: 0).adjust(toPickerWheelValue: "\(hour24 % 12 == 0 ? 12 : hour24 % 12)")
            wheels.element(boundBy: 1).adjust(toPickerWheelValue: String(format: "%02d", minute))
            wheels.element(boundBy: 2).adjust(toPickerWheelValue: hour24 < 12 ? "AM" : "PM")
        } else {
            wheels.element(boundBy: 0).adjust(toPickerWheelValue: String(format: "%02d", hour24))
            wheels.element(boundBy: 1).adjust(toPickerWheelValue: String(format: "%02d", minute))
        }
        // Close the wheels by tapping outside them.
        app.windows.firstMatch.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.1)).tap()
    }

    private func element(_ label: String) -> XCUIElement {
        app.descendants(matching: .any).matching(NSPredicate(format: "label == %@", label)).firstMatch
    }

    private func text(startingWith prefix: String) -> XCUIElement {
        app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH %@", prefix)).firstMatch
    }

    /// Two times, in two sections: a row in each, ticked separately.
    func testCheckOffInTwoSections() {
        open("Check it off")
        type(name: "Brush teeth")
        // Morning first, so the first time is 7:00 AM; the second becomes 9:00 PM.
        let menu = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Day Section'")).firstMatch
        scrollTo(menu)
        menu.tap()
        app.buttons["Morning"].firstMatch.tap()
        XCTAssertTrue(app.buttons["Day Section, Morning"].waitForExistence(timeout: 2))
        addTimes(2)
        setTime(row: 1, hour24: 21)
        shot("16-two-times")
        XCTAssertTrue(element("Day Section, Morning, Evening, set by the times").waitForExistence(timeout: 2))
        let when = text(startingWith: "Shows in Morning and Evening, with a tick in each")
        scrollTo(when)
        XCTAssertTrue(when.exists)
        // Times use the phone's format (with a narrow space before AM), so match the hours only.
        let reminders = app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH 'A notification at 7:00' OR label BEGINSWITH 'A notification at 07:00'")).firstMatch
        scrollTo(reminders)
        XCTAssertTrue(reminders.exists)
        XCTAssertTrue(reminders.label.contains("None for a time you've already ticked."))
        shot("17-two-sections-form")
        app.navigationBars["Check it off"].buttons["Add"].tap()
        sleep(3) // Today scrolls to the new row and flashes it
        shot("17b-after-add")
        // Open both sections, then tick the habit in one of them only.
        for name in ["Morning", "Evening"] {
            // Lists only build the rows on screen, so scroll until the header is there.
            let header = app.buttons.matching(NSPredicate(format: "label BEGINSWITH %@", name)).firstMatch
            revealOnToday(header)
            XCTAssertTrue(header.exists, "\(name) is on Today")
            if header.value as? String == "Folded" { header.tap(); sleep(1) }
        }
        // Morning's row: tick it, and Evening's row stays to do.
        app.swipeDown(); app.swipeDown()
        let tick = app.buttons["Mark Brush teeth done"].firstMatch
        revealOnToday(tick)
        tick.tap()
        // Morning is finished; Evening's tick is still to do.
        let morning = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Morning'")).firstMatch
        XCTAssertTrue(morning.waitForExistence(timeout: 3))
        XCTAssertTrue(morning.label.contains("All done"), "Ticking in Morning finishes Morning")
        let evening = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Evening'")).firstMatch
        revealOnToday(evening)
        XCTAssertTrue(evening.label.contains("left"), "Evening's tick is separate")
        let eveningTick = app.buttons["Mark Brush teeth done"].firstMatch
        revealOnToday(eveningTick)
        XCTAssertTrue(eveningTick.exists, "Evening's row is still to do")
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
        XCTAssertFalse(app.buttons["Add Time"].exists)
        XCTAssertTrue(text(startingWith: "The counter runs from here. It shows at the top of Today under Quitting").exists)
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
        revealOnToday(header)
        XCTAssertTrue(header.exists, "Today shows the new section")
        shot("14-section-on-today")
        let disclosure = header.value as? String
        let play = app.buttons["Start Before work routine"]
        XCTAssertTrue(play.isHittable)
        play.tap()
        XCTAssertTrue(app.navigationBars["Before work routine"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.collectionViews["routine-list"].buttons["Mark Pack lunch done"].exists)
        app.buttons["Close"].tap()
        XCTAssertEqual(header.value as? String, disclosure)
        if disclosure == "Folded" { header.tap() }
        XCTAssertTrue(play.isHittable, "Custom sections also expose play when expanded")
    }

    /// An amount with times in two sections isn't split: one row, in Anytime.
    func testAmountWithSpreadTimesShowsInAnytime() {
        open("Count an amount")
        type(name: "Water")
        app.textFields["Amount"].tap()
        app.textFields["Amount"].typeText("8")
        app.toolbars.buttons["Done"].firstMatch.tap()
        let unitRow = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Unit'")).firstMatch
        scrollTo(unitRow)
        unitRow.tap()
        app.buttons["glasses"].tap()
        // 9, 10, 11 AM and 12 PM: Morning and Afternoon.
        addTimes(4)
        XCTAssertTrue(element("Day Section, Anytime, set by the times").waitForExistence(timeout: 2))
        let footer = text(startingWith: "Shows once, in Anytime: an amount adds up across the day")
        scrollTo(footer)
        XCTAssertTrue(footer.exists)
        XCTAssertEqual(app.staticTexts.matching(NSPredicate(format: "label == 'Time'")).count, 4, "Spread times aren't labelled with a section")
        shot("19-spread-amount-form")
        app.navigationBars["Count an amount"].buttons["Add"].tap()
        let anytime = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Anytime'")).firstMatch
        revealOnToday(anytime)
        if anytime.value as? String == "Folded" { anytime.tap(); sleep(1) }
        let row = app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH '0/8 glasses'")).firstMatch
        revealOnToday(row)
        XCTAssertTrue(row.label.contains("· 9:00") || row.label.contains("· 09:00"), "The row shows its first time: \(row.label)")
        XCTAssertEqual(app.buttons.matching(NSPredicate(format: "label == 'Add 1 to Water'")).count, 1, "One row only")
        shot("20-spread-amount-today")
    }

    /// Remind Me off: no Alert or Remind Again, and the footer says the times only place it.
    func testRemindMeOffHidesAlertAndRemindAgain() {
        open("Check it off")
        type(name: "Stretch")
        addTimes(1)
        let remind = app.switches["Remind Me"].firstMatch
        scrollTo(remind)
        XCTAssertTrue(app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Remind Again If Not Done'")).firstMatch.exists)
        shot("21-reminders-on")
        remind.switches.firstMatch.tap()
        XCTAssertFalse(app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Remind Again If Not Done'")).firstMatch.waitForExistence(timeout: 1))
        XCTAssertFalse(app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Alert'")).firstMatch.exists)
        XCTAssertTrue(text(startingWith: "No notifications. The times only place it on Today.").exists)
        shot("22-reminders-off")
    }

    /// Removing the last time keeps the section the time put it in.
    func testRemovingTheLastTimeKeepsTheSection() {
        open("Check it off")
        type(name: "Journal")
        addTimes(1) // 9:00 AM, in Morning
        XCTAssertTrue(element("Day Section, Morning, set by the times").waitForExistence(timeout: 2))
        app.buttons["Remove time"].tap()
        XCTAssertTrue(app.buttons["Day Section, Morning"].waitForExistence(timeout: 2), "It stays in Morning")
        XCTAssertTrue(text(startingWith: "Shows in Morning on Today (").exists)
        XCTAssertFalse(app.switches["Remind Me"].exists, "No time, no reminders")
    }

    /// A set schedule that isn't due today says when it first is.
    func testFirstDueForCertainDays() {
        open("Check it off")
        type(name: "Gym")
        pickHowOften("On Certain Days")
        // Keep three days that aren't today (Mon/Wed/Fri, or Tue/Thu/Sat if today is one of those).
        let today = Calendar.current.component(.weekday, from: .now)
        let keep: Set<Int> = [2, 4, 6].contains(today) ? [3, 5, 7] : [2, 4, 6]
        let names = Calendar.current.standaloneWeekdaySymbols
        for day in 1...7 where !keep.contains(day) {
            let button = app.buttons[names[day - 1]]
            scrollTo(button)
            button.tap()
        }
        let firstDue = app.staticTexts.matching(NSPredicate(format: "label CONTAINS 'First due'")).firstMatch
        XCTAssertTrue(firstDue.waitForExistence(timeout: 2), "The form says when it first shows")
        shot("23-first-due")
    }
}
