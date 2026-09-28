import XCTest

/// The Goal screen for Check it off, Track an amount and Time it, and what + does on Today afterwards
/// (spec: New Habit Goal and Time of Day.md §3). Keeps a screenshot of each step.
final class GoalFlowUITests: XCTestCase {
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
        sleep(1)
        let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    private func row(_ title: String) -> XCUIElement {
        app.buttons.matching(NSPredicate(format: "label BEGINSWITH %@", title)).firstMatch
    }

    private func back() {
        let done = app.toolbars.buttons["Done"].firstMatch
        if done.exists { done.tap() }
        app.navigationBars.buttons["BackButton"].firstMatch.tap()
        sleep(1)
    }

    /// + → Build or maintain → the type → a name.
    private func newHabit(_ type: String, name: String) {
        app.navigationBars.buttons["New Habit"].firstMatch.tap()
        row("Build or maintain").tap()
        row(type).tap()
        XCTAssertTrue(app.navigationBars[type].waitForExistence(timeout: 3))
        let field = app.descendants(matching: .any)["name-field"]
        field.tap(); field.typeText(name + "\n")
    }

    private func openGoal() {
        row("Goal").tap()
        XCTAssertTrue(app.navigationBars["Goal"].waitForExistence(timeout: 3))
    }

    /// Tapping a number field selects its value, so typing replaces it.
    private func typeAmount(_ text: String) {
        let amount = app.textFields["goal-amount"]
        amount.tap(); sleep(1)
        amount.typeText(text)
    }

    private func summary(_ text: String) -> Bool {
        let element = app.descendants(matching: .any)["goal-summary"]
        return element.waitForExistence(timeout: 2) && "\(element.label) \(element.value ?? "")".contains(text)
    }

    private func dismissKeyboard() {
        let done = app.toolbars.buttons["Done"].firstMatch
        if done.exists && done.isHittable { done.tap(); sleep(1) }
    }

    private func chooseUnit(_ unit: String) {
        dismissKeyboard()
        app.buttons["goal-unit"].tap()
        XCTAssertTrue(app.navigationBars["Unit"].waitForExistence(timeout: 3))
        let choice = app.buttons[unit].firstMatch
        while !choice.isHittable { app.swipeUp(velocity: .slow) }
        choice.tap()
        sleep(1)
    }

    private func period(_ name: String) {
        app.segmentedControls["goal-period"].buttons[name].tap()
    }

    private func addHabit() {
        app.navigationBars.buttons["Add"].tap()
        sleep(2)
    }

    private func rowButton(_ label: String) -> XCUIElement {
        let button = app.buttons[label].firstMatch
        var tries = 0
        while !button.isHittable && tries < 6 { app.swipeUp(velocity: .slow); tries += 1 }
        return button
    }

    /// 2,000 ml a day: a measured unit, so + asks how much, and remembers the last amount.
    func testCountMeasuredAsksHowMuch() {
        newHabit("Track an amount", name: "Hydrate")
        openGoal()
        shot("g01-count-goal-empty")
        typeAmount("2000")
        chooseUnit("ml")
        shot("g02-count-goal-2000ml")
        XCTAssertTrue(summary("2k ml a day"))
        back()
        XCTAssertTrue(row("Goal, 2k ml a day").exists)
        shot("g03-count-form")
        addHabit()
        rowButton("Add amount to Hydrate").tap()
        XCTAssertTrue(app.navigationBars["Add Amount"].waitForExistence(timeout: 3))
        shot("g04-add-amount-sheet")
        app.textFields["log-amount"].typeText("250")
        app.navigationBars["Add Amount"].buttons["Add"].tap()
        sleep(2)
        shot("g05-today-250ml")
        rowButton("Add amount to Hydrate").tap()
        XCTAssertTrue(app.buttons["log-same-again"].waitForExistence(timeout: 3))
        shot("g06-add-amount-same-again")
        app.buttons["log-same-again"].tap()
        sleep(2)
        shot("g07-today-500ml")
    }

    /// 8 glasses a day: small whole goal, so + adds 1 with no question.
    func testCountSmallAddsOne() {
        newHabit("Track an amount", name: "Glasses")
        openGoal()
        typeAmount("8")
        chooseUnit("glasses")
        shot("g10-count-goal-8-glasses")
        back()
        addHabit()
        rowButton("Add 1 to Glasses").tap()
        sleep(1)
        shot("g11-today-1-of-8")
    }

    /// 12 books a year: over 10, but books happen one at a time, so + still adds 1.
    func testCountBooksPerYear() {
        newHabit("Track an amount", name: "Books")
        openGoal()
        period("Yearly")
        typeAmount("12")
        chooseUnit("books")
        shot("g20-count-goal-12-books-year")
        back()
        XCTAssertTrue(row("Goal, 12 books a year").exists)
        XCTAssertFalse(row("Repeat").exists, "A year goal has no daily schedule")
        shot("g21-count-form-year")
    }

    /// Check it off: 3 times a week, straight from the Goal screen; Repeat leaves the form.
    func testCheckWeekly() {
        newHabit("Check it off", name: "Gym")
        openGoal()
        shot("g30-check-goal-default")
        period("Weekly")
        typeAmount("3")
        shot("g31-check-goal-3-week")
        back()
        XCTAssertTrue(row("Goal, 3 times a week").exists)
        XCTAssertFalse(row("Repeat").exists)
        shot("g32-check-form-week")
    }

    /// Time it: wheels open at 20 min; a week goal of 3 h typed exactly.
    func testTimeWeekly() {
        newHabit("Time it", name: "Study")
        openGoal()
        shot("g40-time-goal-default")
        period("Weekly")
        app.segmentedControls["duration-entry-mode"].buttons["Type"].tap()
        // Type focuses hours at once; Next moves to minutes. Both sit on one row above the keyboard.
        sleep(1)
        XCTAssertEqual(app.buttons.matching(identifier: "Next").count, 1, "One Next button on the keyboard, not one per row")
        app.textFields["duration-hours"].typeText("3")
        app.toolbars.buttons["Next"].firstMatch.tap(); sleep(1)
        app.textFields["duration-minutes"].typeText("0")
        shot("g41-time-goal-3h-week")
        back()
        XCTAssertTrue(row("Goal, 3 h a week").exists)
        shot("g42-time-form-week")
    }

    /// The copy on the two choice screens (Habit Flow Copy — Deep Research Report).
    func testChoiceScreensCopy() {
        app.navigationBars.buttons["New Habit"].firstMatch.tap()
        XCTAssertTrue(app.staticTexts["What do you want to do?"].waitForExistence(timeout: 3))
        XCTAssertFalse(app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH 'Example'")).firstMatch.exists, "No examples on the first screen")
        shot("c01-what-do-you-want-to-do")
        row("Build or maintain").tap()
        XCTAssertTrue(app.navigationBars["Build or maintain"].waitForExistence(timeout: 3))
        XCTAssertTrue(row("Track an amount").exists)
        shot("c02-build-or-maintain")
        back()
        row("Quit or cut down").tap()
        XCTAssertTrue(app.navigationBars["Quit or cut down"].waitForExistence(timeout: 3))
        shot("c03-quit-or-cut-down")
    }

    /// Check it off with a unit stays a check-off: ✓ on Today, "1/8 glasses". The Unit screen offers your own unit.
    func testCheckWithUnitStaysCheck() {
        newHabit("Check it off", name: "Hydrate")
        openGoal()
        typeAmount("8")
        dismissKeyboard()
        app.buttons["goal-unit"].tap()
        XCTAssertTrue(app.navigationBars["Unit"].waitForExistence(timeout: 3))
        XCTAssertFalse(app.buttons["ml"].exists, "No measured units for a check-off")
        shot("r01-unit-screen-check")
        app.buttons["create-unit"].tap()
        XCTAssertTrue(app.textFields["custom-unit"].waitForExistence(timeout: 2))
        shot("r02-create-own-unit")
        app.navigationBars.buttons["BackButton"].firstMatch.tap(); sleep(1)
        chooseUnit("glasses")
        shot("r03-check-goal-8-glasses")
        back()
        XCTAssertTrue(row("Goal, 8 glasses a day").exists)
        addHabit()
        rowButton("Mark Hydrate done").tap()
        sleep(1)
        shot("r04-today-check-glasses")
    }

    /// The period copy for each choice, and the read-back at the top.
    func testPeriodCopy() {
        newHabit("Track an amount", name: "Steps")
        openGoal()
        typeAmount("8000")
        chooseUnit("steps")
        shot("r10-daily")
        period("Weekly"); shot("r11-weekly")
        period("Monthly"); shot("r12-monthly")
        period("Yearly"); shot("r13-yearly")
    }

    /// Typing the way a person does: one key at a time on the number pad, checking the field and the
    /// read-back after each key (the user reported typed amounts not showing).
    func testTypingKeyByKey() {
        newHabit("Track an amount", name: "Keys")
        openGoal()
        let amount = app.textFields["goal-amount"]
        XCTAssertTrue(amount.waitForExistence(timeout: 3))
        for (i, key) in ["2", "5", "0", "0"].enumerated() {
            app.keys[key].tap(); usleep(400_000)
            let typed = String("2500".prefix(i + 1))
            XCTAssertEqual(amount.value as? String, typed, "The field shows each key as it's typed")
        }
        shot("k01-typed-2500")
        chooseUnit("ml")
        XCTAssertTrue(summary("2.5k ml a day"), "The read-back shows the typed goal")
        // Change it: tapping the field selects 2500, so typing replaces it.
        amount.tap(); sleep(1)
        app.keys["7"].tap(); usleep(400_000)
        XCTAssertEqual(amount.value as? String, "7")
        shot("k02-replaced-7")
        back()
        let goalRow = row("Goal, 7 ml a day")
        if !goalRow.waitForExistence(timeout: 3) {
            shot("k02b-form-after-back")
            XCTFail("Goal row: " + app.buttons.allElementsBoundByIndex.map(\.label).filter { $0.hasPrefix("Goal") }.joined(separator: " | "))
        }
        addHabit()
        rowButton("Add amount to Keys").tap()
        let log = app.textFields["log-amount"]
        XCTAssertTrue(log.waitForExistence(timeout: 3))
        sleep(1)
        for key in ["3", "5", "0"] { app.keys[key].tap(); usleep(400_000) }
        XCTAssertEqual(log.value as? String, "350", "Add Amount shows what's typed")
        shot("k03-add-amount-350")
        app.navigationBars["Add Amount"].buttons["Add"].tap(); sleep(2)
        shot("k04-today-350")
    }

    /// The unit is optional: the number shows as soon as it's typed ("8" / "a day"), and a goal with no
    /// unit can be added (the user's decision, 28 Sep).
    func testNumberShowsWithoutAUnit() {
        newHabit("Track an amount", name: "Pushups set")
        openGoal()
        typeAmount("8")
        XCTAssertTrue(summary("8 a day"), "The number shows before any unit is chosen")
        shot("u01-number-no-unit")
        period("Weekly")
        XCTAssertTrue(summary("8 a week"))
        period("Daily")
        back()
        XCTAssertTrue(row("Goal, 8 a day").exists)
        XCTAssertTrue(app.navigationBars["Track an amount"].buttons["Add"].isEnabled, "No unit needed to add it")
        addHabit()
        let line = app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH '0/8'")).firstMatch
        for _ in 0..<6 where !line.exists { app.swipeUp(velocity: .slow) }
        XCTAssertTrue(line.exists, "Today shows just the numbers")
        shot("u02-today-no-unit")
    }

    /// One rule for logging counts: the button says what it does ("+1" adds one; "+" asks how much), and
    /// tapping the row always opens Add Amount, for every count habit.
    func testRowOpensAddAmountAndButtonSaysPlusOne() {
        newHabit("Track an amount", name: "Glasses")
        openGoal()
        typeAmount("8")
        chooseUnit("glasses")
        back()
        addHabit()
        let plusOne = rowButton("Add 1 to Glasses")
        XCTAssertTrue(plusOne.exists)
        shot("l01-plus-one-button")
        plusOne.tap(); sleep(1)
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH '1/8 glasses'")).firstMatch.exists, "+1 adds one")
        // Tapping the row itself opens Add Amount.
        app.staticTexts["Glasses"].firstMatch.tap()
        XCTAssertTrue(app.navigationBars["Add Amount"].waitForExistence(timeout: 3), "The row opens Add Amount")
        sleep(1)
        shot("l02-row-opens-add-amount")
        app.textFields["log-amount"].typeText("3")
        app.navigationBars["Add Amount"].buttons["Add"].tap(); sleep(2)
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH '4/8 glasses'")).firstMatch.exists, "The typed amount adds up")
        shot("l03-today-4-of-8")
    }
}
