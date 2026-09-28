import XCTest

/// Creates every kind of item through + (the current two-question flow and form), and keeps screenshots.
/// Rewritten 28 Sep 2026 for the decided spec (iOS/New Habit Goal and Time of Day.md). Retired checks, and why:
/// times that placed a habit in a section, and a separate tick per part of the day, were both replaced by
/// Time of Day (display only, one shared row); the How Often menu became the Repeat screen.
final class NewHabitUITests: XCTestCase {
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
        app.launchArguments = ["-uitest"]
        app.launch()
    }

    private func shot(_ name: String) {
        let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    private func row(_ title: String) -> XCUIElement {
        app.buttons.matching(NSPredicate(format: "label BEGINSWITH %@", title)).firstMatch
    }

    /// Forms build rows lazily, so scroll the form until the element can be tapped.
    private func scrollTo(_ element: XCUIElement) {
        let form = app.collectionViews["habit-form"]
        for _ in 0..<6 where !(element.exists && element.isHittable) { form.swipeUp() }
    }

    private func revealOnToday(_ element: XCUIElement) {
        let window = app.windows.firstMatch
        // Start from the top: the list builds rows lazily, so a row above the screen doesn't "exist" yet.
        for _ in 0..<3 { app.swipeDown(velocity: .fast) }
        for _ in 0..<20 {
            if element.exists && element.isHittable && element.frame.minY > 100 && element.frame.maxY < window.frame.maxY - 90 { return }
            let upward = !element.exists || element.frame.minY > window.frame.midY
            window.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: upward ? 0.65 : 0.35))
                .press(forDuration: 0.05, thenDragTo: window.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: upward ? 0.42 : 0.58)))
        }
        if !element.exists { print("TEXTS: " + app.staticTexts.allElementsBoundByIndex.map(\.label).joined(separator: " | ")) }
        XCTAssertTrue(element.exists)
    }

    private func back() {
        let done = app.toolbars.buttons["Done"].firstMatch
        if done.exists && done.isHittable { done.tap() }
        app.navigationBars.buttons["BackButton"].firstMatch.tap()
        sleep(1)
    }

    /// + → the first question → (the second) → the form.
    private func open(_ first: String, _ second: String? = nil, title: String) {
        app.navigationBars.buttons["New Habit"].firstMatch.tap()
        XCTAssertTrue(app.navigationBars["New"].waitForExistence(timeout: 3))
        // Choice rows read "Title, detail…": match the title and its comma, so "Quit" can't match
        // the Quitting header behind the sheet.
        row(first + ",").tap()
        if let second { row(second + ",").tap() }
        XCTAssertTrue(app.navigationBars[title].waitForExistence(timeout: 3))
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

    private func text(startingWith prefix: String) -> XCUIElement {
        app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH %@", prefix)).firstMatch
    }

    private func setGoal(_ amount: String, unit: String? = nil, period: String? = nil) {
        row("Goal").tap()
        XCTAssertTrue(app.navigationBars["Goal"].waitForExistence(timeout: 3))
        if let period { app.segmentedControls["goal-period"].buttons[period].tap() }
        let field = app.textFields["goal-amount"]
        field.tap(); sleep(1); field.typeText(amount)
        if let unit {
            let done = app.toolbars.buttons["Done"].firstMatch
            if done.exists && done.isHittable { done.tap(); sleep(1) }
            app.buttons["goal-unit"].tap()
            let choice = app.buttons[unit].firstMatch
            while !choice.isHittable { app.swipeUp(velocity: .slow) }
            choice.tap(); sleep(1)
        }
        back()
    }

    private func repeatScreen(_ option: String) {
        row("Repeat").tap()
        XCTAssertTrue(app.navigationBars["Repeat"].waitForExistence(timeout: 3))
        app.buttons[option].firstMatch.tap()
    }

    /// Track an amount: nothing pre-filled, Add waits for a goal; one reminder by default, removable.
    func testAmountWithReminderRemoved() {
        open("Build or maintain", "Track an amount", title: "Track an amount")
        type(name: "Drink water")
        XCTAssertFalse(app.navigationBars["Track an amount"].buttons["Add"].isEnabled, "No goal, no Add")
        setGoal("8", unit: "glasses")
        XCTAssertTrue(row("Goal, 8 glasses a day").exists)
        XCTAssertEqual(app.descendants(matching: .any)["name-field"].value as? String, "Drink water", "Coming back leaves the name alone")
        let remove = app.buttons["Remove reminder"].firstMatch
        scrollTo(remove)
        XCTAssertTrue(remove.exists, "A reminder is on by default, and removable")
        shot("04-reminder")
        remove.tap()
        XCTAssertFalse(app.buttons["Remove reminder"].waitForExistence(timeout: 1), "The reminder is removed")
        app.navigationBars["Track an amount"].buttons["Add"].tap()
        let today = app.staticTexts["0/8 glasses"]
        revealOnToday(today)
        XCTAssertTrue(today.exists)
        shot("05-on-today")
    }

    func testCheckOffThreeTimesAWeek() {
        open("Build or maintain", "Check it off", title: "Check it off")
        type(name: "Gym")
        setGoal("3", period: "Weekly")
        XCTAssertTrue(row("Goal, 3 times a week").exists)
        XCTAssertFalse(row("Repeat").exists, "A weekly goal has no daily schedule")
        app.navigationBars["Check it off"].buttons["Add"].tap()
        allowNotificationsIfAsked()
        sleep(2); shot("06b-after-add")
        let line = text(startingWith: "0/3 this week")
        revealOnToday(line)
        XCTAssertTrue(line.exists)
    }

    func testChecklist() {
        open("Build or maintain", "Checklist", title: "Checklist")
        type(name: "Workout")
        XCTAssertFalse(app.navigationBars["Checklist"].buttons["Add"].isEnabled, "A checklist needs an item")
        row("Items").tap()
        XCTAssertFalse(app.textFields["e.g. Push-ups"].exists, "No empty item until Add Item")
        app.buttons["Add Item"].tap()
        let item = app.textFields["e.g. Push-ups"].firstMatch
        XCTAssertTrue(item.waitForExistence(timeout: 2))
        item.typeText("Push-ups\n")
        app.textFields["Next item"].firstMatch.typeText("Squats")
        shot("07-checklist")
        back()
        XCTAssertTrue(row("Items, 2 items").exists)
        app.navigationBars["Checklist"].buttons["Add"].tap()
        allowNotificationsIfAsked()
        sleep(2); shot("07b-after-add")
        let line = text(startingWith: "0/2 items") // then " · 9:00 AM", its reminder time
        revealOnToday(line)
        XCTAssertTrue(line.exists)
    }

    func testOneTimeTask() {
        open("Add a task", title: "Task")
        type(name: "Book dentist")
        XCTAssertTrue(text(startingWith: "If it isn't done, it moves forward to today").exists)
        shot("08-task")
        app.navigationBars["Task"].buttons["Add"].tap()
        let tick = app.buttons["Mark Book dentist done"]
        revealOnToday(tick)
        tick.tap()
        XCTAssertTrue(app.buttons["Undo Book dentist"].waitForExistence(timeout: 3) || app.buttons.matching(NSPredicate(format: "label CONTAINS 'All done'")).firstMatch.exists)
    }

    /// Cut down: a maximum, and it can be a weekly total.
    func testLimitCanBeAWeeklyTotal() {
        open("Quit or cut down", "Cut down", title: "Cut down")
        type(name: "Cigarettes")
        repeatScreen("A Weekly Total")
        XCTAssertFalse(app.buttons["A Few Times a Week"].exists, "Amounts use totals, not a count of days")
        shot("09-limit-repeat")
        back()
        row("Goal").tap()
        XCTAssertTrue(app.staticTexts["Weekly limit"].waitForExistence(timeout: 2))
        // The limit's number shows what's typed (the field isn't sized to its placeholder).
        let field = app.textFields["No more than"]
        field.tap(); field.typeText("20")
        XCTAssertEqual(field.value as? String, "20")
        shot("09b-limit-typed")
    }

    /// Two parts of the day: the same row in each, with one shared progress (spec §5).
    func testCheckOffInTwoTimesOfDay() {
        open("Build or maintain", "Check it off", title: "Check it off")
        type(name: "Brush teeth")
        setGoal("2")
        row("Time of Day").tap()
        XCTAssertTrue(app.navigationBars["Time of Day"].waitForExistence(timeout: 3))
        app.buttons["Morning"].firstMatch.tap()
        app.buttons["Evening"].firstMatch.tap()
        back()
        XCTAssertTrue(row("Time of Day, Morning, Evening").exists)
        XCTAssertTrue(row("Goal, 2 times a day").exists, "Picking parts leaves the goal alone")
        // One reminder per part of the day, labelled with its part (the Starts date is a picker too, so count by name).
        for part in ["Morning", "Evening"] {
            let reminder = app.staticTexts["\(part) reminder"]
            scrollTo(reminder)
            XCTAssertTrue(reminder.exists, "\(part) has its reminder")
        }
        shot("17-two-parts-form")
        app.navigationBars["Check it off"].buttons["Add"].tap()
        allowNotificationsIfAsked()
        sleep(2)
        for name in ["Morning", "Evening"] {
            let header = row(name)
            revealOnToday(header)
            if header.value as? String == "Folded" { header.tap(); sleep(1) }
        }
        let tick = app.buttons["Mark Brush teeth done"].firstMatch
        revealOnToday(tick)
        tick.tap(); sleep(1)
        // One shared progress: both rows now show 1/2.
        for name in ["Morning", "Evening"] {
            let header = row(name)
            revealOnToday(header)
            // 1 of 2 done, shared: the habit still counts as left in both parts (Morning "1 left", Evening its 5 + 1).
            XCTAssertTrue(header.label.contains(name == "Morning" ? "1 left" : "6 left"), "\(name): \(header.label)")
        }
        let shared = app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH '1/2'")).firstMatch
        revealOnToday(shared)
        XCTAssertTrue(shared.exists, "The rows show the shared 1/2")
        shot("18-two-parts-today")
    }

    func testIconSheetClosesOnPick() {
        open("Build or maintain", "Check it off", title: "Check it off")
        type(name: "Walk the dog")
        app.buttons["Icon"].tap()
        XCTAssertTrue(app.navigationBars["Icon"].waitForExistence(timeout: 3))
        shot("10-icon-sheet")
        app.buttons["bike"].firstMatch.tap()
        XCTAssertFalse(app.navigationBars["Icon"].waitForExistence(timeout: 1), "Picking closes the sheet")
    }

    func testQuitDiscard() {
        open("Quit or cut down", "Quit", title: "Quit")
        type(name: "Sugar")
        XCTAssertTrue(app.staticTexts["Started"].exists)
        XCTAssertFalse(app.switches["Remind Me"].exists, "Quit has no reminders")
        XCTAssertTrue(text(startingWith: "The counter runs from here. It shows at the top of Today under Quitting").exists)
        app.navigationBars["Quit"].buttons["Cancel"].tap()
        let discard = app.buttons["Discard Changes"]
        XCTAssertTrue(discard.waitForExistence(timeout: 2))
        discard.tap()
        XCTAssertFalse(app.navigationBars["Quit"].waitForExistence(timeout: 1))
    }

    /// Your own unit: the green ⊕ row opens a field; the typed unit is used.
    func testCustomUnit() {
        open("Build or maintain", "Track an amount", title: "Track an amount")
        type(name: "Read")
        row("Goal").tap()
        let field = app.textFields["goal-amount"]
        field.tap(); sleep(1); field.typeText("3")
        let done = app.toolbars.buttons["Done"].firstMatch
        if done.exists && done.isHittable { done.tap(); sleep(1) }
        app.buttons["goal-unit"].tap()
        app.buttons["create-unit"].tap()
        let own = app.textFields["custom-unit"]
        XCTAssertTrue(own.waitForExistence(timeout: 2))
        own.typeText("chapters\n")
        XCTAssertTrue(app.descendants(matching: .any)["goal-summary"].label.contains("3 chapters"), "The typed unit is used")
        shot("11-custom-unit")
    }

    func testDatesOfTheMonth() {
        open("Build or maintain", "Check it off", title: "Check it off")
        type(name: "Pay rent")
        repeatScreen("On Dates of the Month")
        app.buttons["Day 1"].tap()
        shot("12-month-dates")
        back()
        XCTAssertTrue(app.navigationBars["Check it off"].buttons["Add"].isEnabled)
    }

    func testDatesOfTheMonthNeedADate() {
        open("Build or maintain", "Check it off", title: "Check it off")
        type(name: "Pay rent")
        repeatScreen("On Dates of the Month")
        back()
        XCTAssertFalse(app.navigationBars["Check it off"].buttons["Add"].isEnabled, "At least one date is needed")
    }

    /// A new time of day from the form; on Today it's folded (not Now), with no ▶ until opened.
    func testNewTimeOfDayFromTheForm() {
        open("Build or maintain", "Check it off", title: "Check it off")
        type(name: "Pack lunch")
        row("Time of Day").tap()
        app.buttons["New Time of Day"].tap()
        let name = app.textFields["Name"]
        XCTAssertTrue(name.waitForExistence(timeout: 3))
        name.typeText("Before work")
        shot("13-new-time-of-day")
        app.navigationBars["New Time of Day"].buttons["Save"].tap()
        XCTAssertTrue(app.buttons["Before work"].waitForExistence(timeout: 3))
        back()
        XCTAssertTrue(row("Time of Day, Before work").exists, "The new time of day is chosen")
        app.navigationBars["Check it off"].buttons["Add"].tap()
        allowNotificationsIfAsked()
        let header = row("Before work")
        revealOnToday(header)
        XCTAssertTrue(header.exists, "Today shows the new time of day")
        if header.value as? String == "Folded" { header.tap(); sleep(1) }
        let play = app.buttons["Start Before work routine"]
        XCTAssertTrue(play.waitForExistence(timeout: 2), "An open section has ▶ Start")
        shot("14-time-of-day-on-today")
        play.tap()
        XCTAssertTrue(app.navigationBars["Before work routine"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.collectionViews["routine-list"].buttons["Mark Pack lunch done"].exists)
        app.buttons["Close"].tap()
    }

    /// Remind Me off hides the reminder rows and how to be reminded.
    func testRemindMeOffHidesTheRest() {
        open("Build or maintain", "Check it off", title: "Check it off")
        type(name: "Stretch")
        let remind = app.switches["Remind Me"].firstMatch
        scrollTo(remind)
        let again = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'If Not Done, Remind Again'")).firstMatch
        scrollTo(again)
        XCTAssertTrue(again.exists)
        shot("21-reminders-on")
        remind.switches.firstMatch.tap()
        XCTAssertFalse(again.waitForExistence(timeout: 1))
        XCTAssertTrue(text(startingWith: "No reminders. You'll see it on Today.").exists)
        shot("22-reminders-off")
    }

    /// A set schedule that isn't due today says when it first is.
    func testFirstDueForCertainDays() {
        open("Build or maintain", "Check it off", title: "Check it off")
        type(name: "Gym")
        repeatScreen("On Certain Days")
        let today = Calendar.current.component(.weekday, from: .now)
        let keep: Set<Int> = [2, 4, 6].contains(today) ? [3, 5, 7] : [2, 4, 6]
        let names = Calendar.current.standaloneWeekdaySymbols
        for day in 1...7 where !keep.contains(day) { app.buttons[names[day - 1]].tap() }
        let firstDue = app.staticTexts.matching(NSPredicate(format: "label CONTAINS 'First due'")).firstMatch
        XCTAssertTrue(firstDue.waitForExistence(timeout: 2), "The Repeat screen says when it first shows")
        shot("23-first-due")
    }
}
