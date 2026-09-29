import XCTest

/// Creates every kind of item through + (the current two-question flow and form), and keeps screenshots.
/// Rewritten 28 Sep 2026 for the decided spec (iOS/Docs/Specs/New Habit Goal and Time of Day.md). Retired checks, and why:
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

    /// How much → An amount → the number (and a unit from the list) → back to the form.
    private func setAmount(_ amount: String, unit: String? = nil) {
        row("How much").tap()
        XCTAssertTrue(app.navigationBars["How Much"].waitForExistence(timeout: 3))
        app.buttons["much-amount"].tap()
        let field = app.textFields["much-number"]
        XCTAssertTrue(field.waitForExistence(timeout: 2))
        field.tap(); sleep(1); field.typeText(amount)
        if let unit {
            let done = app.toolbars.buttons["Done"].firstMatch
            if done.exists && done.isHittable { done.tap(); sleep(1) }
            app.buttons["much-unit"].tap()
            let choice = app.buttons[unit].firstMatch
            for _ in 0..<8 where !choice.isHittable { app.swipeUp(velocity: .slow) }
            choice.tap(); sleep(1)
        }
        back()
    }

    /// How often → a choice by its identifier ("often-times", "often-weekdays", "often-total-week"…).
    private func openOften() {
        row("How often").tap()
        XCTAssertTrue(app.navigationBars["How Often"].waitForExistence(timeout: 3))
    }

    private var sentence: String { app.descendants(matching: .any)["habit-sentence"].label }

    private var addButton: XCUIElement { app.navigationBars["New Habit"].buttons["Add"] }

    /// An amount: Add waits for the number; the sentence, the step and Today all say the same thing.
    func testAmountWithReminderRemoved() {
        open("Build or maintain", title: "New Habit")
        type(name: "Drink water")
        XCTAssertEqual(sentence, "Drink water every day", "Just do it, every day, until an amount is set")
        row("How much").tap()
        app.buttons["much-amount"].tap()
        back()
        XCTAssertFalse(addButton.isEnabled, "An amount with no number: no Add")
        setAmount("8", unit: "glasses")
        XCTAssertTrue(row("How much, 8 glasses").exists)
        XCTAssertEqual(sentence, "Drink water 8 glasses a day")
        XCTAssertTrue(app.textFields["Each + adds"].exists, "The step is shown on the form")
        XCTAssertTrue(text(startingWith: "On Today, + adds 1 glass").exists)
        XCTAssertEqual(app.descendants(matching: .any)["name-field"].value as? String, "Drink water", "Coming back leaves the name alone")
        let remove = app.buttons["Remove reminder"].firstMatch
        scrollTo(remove)
        XCTAssertTrue(remove.exists, "A reminder is on by default, and removable")
        shot("04-reminder")
        remove.tap()
        XCTAssertFalse(app.buttons["Remove reminder"].waitForExistence(timeout: 1), "The reminder is removed")
        addButton.tap()
        let today = app.staticTexts["0/8 glasses"]
        revealOnToday(today)
        XCTAssertTrue(today.exists)
        XCTAssertTrue(app.buttons["Add 1 glass to Drink water"].exists, "+ says what it adds")
        shot("05-on-today")
    }

    /// Just do it, 3 times a week: every ✓ counts; Today shows 0/3 this week.
    func testCheckOffThreeTimesAWeek() {
        open("Build or maintain", title: "New Habit")
        type(name: "Gym")
        openOften()
        app.buttons["often-times"].tap()
        XCTAssertTrue(app.descendants(matching: .any)["often-summary"].label.hasPrefix("3 times a week"))
        shot("06-how-often-times")
        back()
        XCTAssertTrue(row("How often, 3 times a week").exists)
        XCTAssertEqual(sentence, "Gym 3 times a week")
        addButton.tap()
        allowNotificationsIfAsked()
        sleep(2); shot("06b-after-add")
        let line = text(startingWith: "0/3 this week")
        revealOnToday(line)
        XCTAssertTrue(line.exists)
    }

    /// The user's example: "my weekly goal is two chapters".
    func testReadTwoChaptersAWeek() {
        open("Build or maintain", title: "New Habit")
        type(name: "Read")
        setAmount("2", unit: "chapters")
        openOften()
        app.buttons["often-total-week"].tap()
        XCTAssertTrue(app.descendants(matching: .any)["often-summary"].label.hasPrefix("2 chapters a week"))
        back()
        XCTAssertTrue(row("How often, A week").exists)
        XCTAssertEqual(sentence, "Read 2 chapters a week")
        shot("24-read-two-chapters-a-week")
        addButton.tap()
        allowNotificationsIfAsked()
        let line = text(startingWith: "0/2 chapters this week")
        revealOnToday(line)
        XCTAssertTrue(line.exists)
        XCTAssertTrue(app.buttons["Add 1 chapter to Read"].exists)
    }

    /// The user's example: "run 5 miles every day"; and 10,000 steps gets a step people can see (+1,000), not a number pad.
    func testRunFiveMilesAndWalkTenThousandSteps() {
        open("Build or maintain", title: "New Habit")
        type(name: "Run")
        setAmount("5", unit: "miles")
        XCTAssertEqual(sentence, "Run 5 miles a day")
        addButton.tap()
        allowNotificationsIfAsked()
        open("Build or maintain", title: "New Habit")
        type(name: "Walk")
        setAmount("10000", unit: "steps")
        XCTAssertEqual(sentence, "Walk 10,000 steps a day")
        XCTAssertEqual(app.textFields["Each + adds"].placeholderValue, "1,000")
        addButton.tap()
        let plus = app.buttons["Add 1,000 steps to Walk"]
        revealOnToday(plus)
        plus.tap(); sleep(1)
        XCTAssertTrue(text(startingWith: "1k/10k steps").exists, "One tap added 1,000")
        shot("25-steps-plus-1000")
    }

    /// Chosen days read as people say them, on the form and on Today: three days in a row are a range.
    func testCertainDaysReadAsARange() {
        let cal = Calendar.current
        let full = cal.standaloneWeekdaySymbols, short = cal.shortStandaloneWeekdaySymbols
        let today = cal.component(.weekday, from: .now)
        let days = [today, today % 7 + 1, (today + 1) % 7 + 1] // today and the next two days
        open("Build or maintain", title: "New Habit")
        type(name: "Run")
        openOften()
        app.buttons["often-weekdays"].tap()
        for day in days.dropFirst() { app.buttons[full[day - 1]].firstMatch.tap() } // today starts chosen
        back()
        let words = "every \(full[days[0] - 1]) to \(full[days[2] - 1])"
        XCTAssertEqual(sentence, "Run " + words)
        XCTAssertTrue(row("How often, E" + words.dropFirst()).exists)
        shot("26-days-range-form")
        addButton.tap()
        allowNotificationsIfAsked()
        let caption = app.staticTexts["Every \(short[days[0] - 1]) to \(short[days[2] - 1])"]
        revealOnToday(caption)
        XCTAssertTrue(caption.exists, "Today says how often")
        shot("27-days-range-today")
    }

    /// Two chosen days: "every Monday and Wednesday" style, with today one of them.
    func testTwoCertainDays() {
        let cal = Calendar.current
        let full = cal.standaloneWeekdaySymbols
        let today = cal.component(.weekday, from: .now)
        let other = (today + 2) % 7 + 1 // two days after today: not next to it, so no range
        let start = cal.firstWeekday // the app's week start follows the phone's until changed
        let first = [today, other].sorted { (($0 - start + 7) % 7) < (($1 - start + 7) % 7) }
        open("Build or maintain", title: "New Habit")
        type(name: "Gym")
        openOften()
        app.buttons["often-weekdays"].tap()
        app.buttons[full[other - 1]].firstMatch.tap()
        back()
        XCTAssertEqual(sentence, "Gym every \(full[first[0] - 1]) and \(full[first[1] - 1])")
    }

    /// Steps: done when every step is ticked; the How much row steps aside while there are steps.
    func testChecklist() {
        open("Build or maintain", title: "New Habit")
        type(name: "Clean kitchen")
        let steps = row("Steps")
        scrollTo(steps)
        steps.tap()
        XCTAssertFalse(app.textFields["e.g. Dishes"].exists, "No empty step until Add Step")
        app.buttons["Add Step"].tap()
        let item = app.textFields["e.g. Dishes"].firstMatch
        XCTAssertTrue(item.waitForExistence(timeout: 2))
        item.typeText("Dishes\n")
        app.textFields["Next step"].firstMatch.typeText("Floor")
        shot("07-checklist")
        back()
        XCTAssertTrue(row("Steps, 2 steps").exists)
        XCTAssertFalse(row("How much").exists, "Steps replace How much")
        XCTAssertEqual(sentence, "Clean kitchen every day")
        addButton.tap()
        allowNotificationsIfAsked()
        sleep(2); shot("07b-after-add")
        let line = text(startingWith: "0/2 steps") // then " · 9:00 AM", its reminder time
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

    /// Cut down: a maximum, and it can be a weekly total. The sentence says it.
    func testLimitCanBeAWeeklyTotal() {
        open("Quit or cut down", "Cut down", title: "Cut down")
        type(name: "Cigarettes")
        row("Limit").tap()
        // The limit's number shows what's typed (the field isn't sized to its placeholder).
        let field = app.textFields["much-number"]
        XCTAssertTrue(field.waitForExistence(timeout: 2))
        field.tap(); field.typeText("20")
        XCTAssertEqual(field.value as? String, "20")
        shot("09b-limit-typed")
        back()
        openOften()
        app.buttons["often-total-week"].tap()
        shot("09-limit-period")
        back()
        XCTAssertEqual(sentence, "Cigarettes: at most 20 a week")
        XCTAssertTrue(app.navigationBars["Cut down"].buttons["Add"].isEnabled)
    }

    /// Two parts of the day: the same row in each, with one shared progress (spec §5).
    func testCheckOffInTwoTimesOfDay() {
        open("Build or maintain", title: "New Habit")
        type(name: "Brush teeth")
        openOften()
        app.buttons["often-timesADay"].tap()
        back()
        XCTAssertEqual(sentence, "Brush teeth twice a day")
        row("Time of Day").tap()
        XCTAssertTrue(app.navigationBars["Time of Day"].waitForExistence(timeout: 3))
        app.buttons["Morning"].firstMatch.tap()
        app.buttons["Evening"].firstMatch.tap()
        back()
        XCTAssertTrue(row("Time of Day, Morning and Evening").exists)
        XCTAssertTrue(row("How often, Twice a day").exists, "Picking parts leaves how often alone")
        // One reminder per part of the day, labelled with its part (the Starts date is a picker too, so count by name).
        for part in ["Morning", "Evening"] {
            let reminder = app.staticTexts["\(part) reminder"]
            scrollTo(reminder)
            XCTAssertTrue(reminder.exists, "\(part) has its reminder")
        }
        shot("17-two-parts-form")
        addButton.tap()
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

    /// Time of Day: Anytime by default; picking a part clears Anytime, Anytime clears the parts, and
    /// unticking the last part goes back to Anytime. Never "Anytime, Morning".
    func testAnytimeNeverCombines() {
        open("Build or maintain", title: "New Habit")
        type(name: "Stretch")
        XCTAssertTrue(row("Time of Day, Anytime").exists, "Anytime is the default")
        row("Time of Day").tap()
        let anytime = app.buttons["Anytime"].firstMatch, morning = app.buttons["Morning"].firstMatch, evening = app.buttons["Evening"].firstMatch
        XCTAssertTrue(anytime.isSelected)
        morning.tap()
        XCTAssertTrue(morning.isSelected); XCTAssertFalse(anytime.isSelected, "A part clears Anytime")
        evening.tap()
        XCTAssertTrue(morning.isSelected && evening.isSelected, "Parts combine")
        anytime.tap()
        XCTAssertTrue(anytime.isSelected); XCTAssertFalse(morning.isSelected || evening.isSelected, "Anytime clears the parts")
        morning.tap(); morning.tap()
        XCTAssertTrue(anytime.isSelected, "Unticking the last part goes back to Anytime")
        shot("28-anytime-alone")
        back()
        XCTAssertTrue(row("Time of Day, Anytime").exists)
    }

    func testIconSheetClosesOnPick() {
        open("Build or maintain", title: "New Habit")
        type(name: "Walk the dog")
        app.buttons["Icon"].tap()
        XCTAssertTrue(app.navigationBars["Icon"].waitForExistence(timeout: 3))
        shot("10-icon-sheet")
        app.buttons["bike"].firstMatch.tap()
        XCTAssertFalse(app.navigationBars["Icon"].waitForExistence(timeout: 1), "Picking closes the sheet")
        app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Colour'")).firstMatch.tap()
        app.buttons["Green"].firstMatch.tap()
        XCTAssertTrue(app.buttons["Colour, Green"].waitForExistence(timeout: 2), "Picking a colour closes its sheet too")
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
        open("Build or maintain", title: "New Habit")
        type(name: "Pray")
        row("How much").tap()
        app.buttons["much-amount"].tap()
        let field = app.textFields["much-number"]
        field.tap(); sleep(1); field.typeText("5")
        let done = app.toolbars.buttons["Done"].firstMatch
        if done.exists && done.isHittable { done.tap(); sleep(1) }
        app.buttons["much-unit"].tap()
        app.buttons["create-unit"].tap()
        let own = app.textFields["custom-unit"]
        XCTAssertTrue(own.waitForExistence(timeout: 2))
        own.typeText("prayers\n")
        XCTAssertTrue(app.descendants(matching: .any)["much-summary"].label.contains("5 prayers"), "The typed unit is used")
        shot("11-custom-unit")
        back()
        XCTAssertEqual(sentence, "Pray 5 prayers a day")
    }

    /// Time as the unit: hours and minutes, and ▶ on Today.
    func testTimeUnit() {
        open("Build or maintain", title: "New Habit")
        type(name: "Meditate")
        row("How much").tap()
        app.buttons["much-amount"].tap()
        app.buttons["much-unit"].tap()
        app.buttons["Hours and minutes"].firstMatch.tap()
        XCTAssertTrue(app.descendants(matching: .any)["much-summary"].label.contains("20 min"), "Time starts at 20 min")
        back()
        XCTAssertEqual(sentence, "Meditate 20 min a day")
        XCTAssertFalse(app.textFields["Each + adds"].exists, "Time has ▶, not +")
    }

    func testDatesOfTheMonth() {
        open("Build or maintain", title: "New Habit")
        type(name: "Pay rent")
        openOften()
        app.buttons["often-date"].tap()
        let today = Calendar.current.component(.day, from: .now)
        if today != 1 { app.buttons["Day 1"].tap(); app.buttons["Day \(today)"].tap() } // just the 1st
        shot("12-month-dates")
        back()
        XCTAssertEqual(sentence, "Pay rent on the 1st of every month")
        XCTAssertTrue(addButton.isEnabled)
    }

    /// A new time of day from the form; on Today it's folded (not Now), with no ▶ until opened.
    func testNewTimeOfDayFromTheForm() {
        open("Build or maintain", title: "New Habit")
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
        addButton.tap()
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
        open("Build or maintain", title: "New Habit")
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

    /// Every phrase reviewed in the copy oracle, and the form's choices said back, checked in the app (`CopyCheck`).
    func testCopyChecks() {
        app.terminate()
        app.launchArguments = ["-uitest", "-copycheck"]
        app.launch()
        let result = app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH 'Copy'")).firstMatch
        XCTAssertTrue(result.waitForExistence(timeout: 10))
        XCTAssertEqual(result.label, "Copy: all checks passed")
    }
}
