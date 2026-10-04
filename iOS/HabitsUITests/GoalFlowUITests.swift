import XCTest

/// How much and How often (Round 3 design, built 29 Sep 2026; Round 4 layout the same day), and what + does
/// on Today afterwards. Build or maintain → Track an amount → the form, whose amount starts as a suggestion.
/// Keeps a screenshot of each step.
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

    private func rowButton(_ label: String) -> XCUIElement {
        let button = app.buttons[label].firstMatch
        app.reveal(button)
        return button
    }

    private func back() {
        let done = app.toolbars.buttons["Done"].firstMatch
        if done.exists && done.isHittable { done.tap() }
        app.navigationBars.buttons["BackButton"].firstMatch.tap()
        sleep(1)
    }

    /// + → Build or maintain → Track an amount → the New Habit form → a name.
    private func newHabit(name: String) {
        app.navigationBars.buttons["New Habit"].firstMatch.tap()
        row("Build or maintain,").tap()
        row("Track an amount,").tap()
        XCTAssertTrue(app.navigationBars["New Habit"].waitForExistence(timeout: 3))
        let field = app.descendants(matching: .any)["name-field"]
        field.tap(); field.typeText(name + "\n")
    }

    private func openHowMuch() {
        row("How much").tap()
        XCTAssertTrue(app.navigationBars["How Much"].waitForExistence(timeout: 3))
    }

    /// The field starts with a suggestion: clear it, then type.
    private func replace(_ field: XCUIElement, with text: String) {
        XCTAssertTrue(field.waitForExistence(timeout: 2))
        field.tap(); sleep(1)
        let old = (field.value as? String) ?? ""
        field.typeText(String(repeating: XCUIKeyboardKey.delete.rawValue, count: old.count + 2) + text)
    }

    private func chooseUnit(_ unit: String) {
        let done = app.toolbars.buttons["Done"].firstMatch
        if done.exists && done.isHittable { done.tap(); sleep(1) }
        app.buttons["much-unit"].tap()
        let choice = app.buttons[unit].firstMatch
        app.reveal(choice)
        choice.tap(); sleep(1)
    }

    private func addHabit() {
        app.navigationBars["New Habit"].buttons["Add"].tap()
        let allow = XCUIApplication(bundleIdentifier: "com.apple.springboard").buttons["Allow"]
        if allow.waitForExistence(timeout: 3) { allow.tap() }
        sleep(2)
    }

    private var sentence: String { app.descendants(matching: .any)["habit-sentence"].label }

    /// Typing the way a person does: one key at a time on the number pad, checking the field after each key
    /// (the user reported typed amounts not showing). Then Log Amount on Today, key by key too.
    func testTypingKeyByKey() {
        newHabit(name: "Keys")
        openHowMuch()
        let amount = app.textFields["much-number"]
        XCTAssertTrue(amount.waitForExistence(timeout: 3))
        amount.tap(); sleep(1)
        amount.typeText(String(repeating: XCUIKeyboardKey.delete.rawValue, count: 4)) // the suggested 1
        let visibleKey = XCTNSPredicateExpectation(predicate: NSPredicate(format: "hittable == true"), object: app.keys["2"])
        XCTAssertEqual(XCTWaiter.wait(for: [visibleKey], timeout: 4), .completed, "The number keyboard is visible for editing")
        for (i, key) in ["2", "5", "0", "0"].enumerated() {
            app.keys[key].tap(); usleep(400_000)
            let typed = String("2500".prefix(i + 1))
            XCTAssertEqual(amount.value as? String, typed, "The field shows each key as it's typed")
        }
        shot("k01-typed-2500")
        chooseUnit("ml")
        XCTAssertTrue(app.descendants(matching: .any)["much-summary"].label.contains("2,500 ml"), "The read-back shows the typed amount")
        // Change it: tapping the field selects 2500, so typing replaces it.
        amount.tap(); sleep(1)
        app.keys["7"].tap(); usleep(400_000)
        XCTAssertEqual(amount.value as? String, "7")
        shot("k02-replaced-7")
        back()
        XCTAssertTrue(row("How much, 7 ml").waitForExistence(timeout: 3))
        XCTAssertEqual(sentence, "Keys 7 ml a day, anytime")
        addHabit()
        // Any amount other than +'s step: the row opens its Day sheet, and Add Entry there types it (3 Oct 2026).
        app.staticTexts["Keys"].firstMatch.tap()
        XCTAssertTrue(app.descendants(matching: .any)["day-result"].firstMatch.waitForExistence(timeout: 5), "The row opens its Day sheet")
        app.buttons["day-add-entry"].tap()
        let log = app.textFields["log-amount"]
        XCTAssertTrue(log.waitForExistence(timeout: 3))
        sleep(1)
        for key in ["3", "5", "0"] { app.keys[key].tap(); usleep(400_000) }
        XCTAssertEqual(log.value as? String, "350", "Add Entry shows what's typed")
        shot("k03-add-amount-350")
        app.navigationBars["Add Entry"].buttons["add-entry-save"].tap(); sleep(2)
        app.navigationBars.buttons["Done"].firstMatch.tap(); sleep(1)
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH '350/7 ml'")).firstMatch.waitForExistence(timeout: 3), "The typed amount is on Today")
        shot("k04-today-350")
    }

    /// The unit is optional: "8" alone is an amount, and it can be added.
    func testNumberShowsWithoutAUnit() {
        newHabit(name: "Pushups set")
        openHowMuch()
        let amount = app.textFields["much-number"]
        replace(amount, with: "8")
        XCTAssertTrue(app.descendants(matching: .any)["much-summary"].label.contains("8"), "The number shows before any unit is chosen")
        shot("u01-number-no-unit")
        back()
        XCTAssertTrue(row("How much, 8").exists)
        XCTAssertEqual(sentence, "Pushups set 8 a day, anytime")
        XCTAssertTrue(app.navigationBars["New Habit"].buttons["Add"].isEnabled, "No unit needed to add it")
        addHabit()
        let line = app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH '0/8'")).firstMatch
        app.reveal(line)
        XCTAssertTrue(line.exists, "Today shows just the numbers")
        shot("u02-today-no-unit")
    }

    /// One rule for logging an amount: + adds the step written on it, the same for every amount; the row
    /// opens Log Amount for anything else. A step the person types is kept.
    func testButtonAddsItsStepAndRowOpensAddAmount() {
        newHabit(name: "Glasses")
        openHowMuch()
        let amount = app.textFields["much-number"]
        replace(amount, with: "8")
        chooseUnit("glasses")
        back()
        let line = app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH 'Each tap on + adds 1 glass'")).firstMatch
        app.reveal(line)
        XCTAssertTrue(line.exists)
        addHabit()
        let plus = rowButton("Add 1 glass to Glasses")
        XCTAssertTrue(plus.exists)
        shot("l01-plus-step-button")
        plus.tap(); sleep(1)
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH '1/8 glasses'")).firstMatch.exists, "+ adds one glass")
        // Any other amount: the row opens its Day sheet, and Add Entry there takes it (3 Oct 2026).
        app.staticTexts["Glasses"].firstMatch.tap()
        XCTAssertTrue(app.descendants(matching: .any)["day-result"].firstMatch.waitForExistence(timeout: 3), "The row opens its Day sheet")
        app.buttons["day-add-entry"].tap()
        XCTAssertTrue(app.navigationBars["Add Entry"].waitForExistence(timeout: 3))
        sleep(1)
        let typed = app.textFields["log-amount"]
        typed.typeText("3")
        app.navigationBars["Add Entry"].buttons["add-entry-save"].tap(); sleep(2)
        app.navigationBars.buttons["Done"].firstMatch.tap(); sleep(1)
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH '4/8 glasses'")).firstMatch.exists, "The typed amount adds up")
        shot("l03-today-4-of-8")
    }

    /// A step of the person's own: a 500 ml bottle.
    func testOwnStep() {
        newHabit(name: "Water")
        openHowMuch()
        let amount = app.textFields["much-number"]
        replace(amount, with: "2000")
        chooseUnit("ml")
        back()
        let step = app.textFields["Each tap adds"]
        app.reveal(step)
        XCTAssertEqual(step.placeholderValue, "250", "A glass is suggested")
        step.tap(); step.typeText("500")
        app.toolbars.buttons["Done"].firstMatch.tap()
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH 'Each tap on + adds 500 ml'")).firstMatch.exists)
        addHabit()
        rowButton("Add 500 ml to Water").tap(); sleep(1)
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH '500/2k ml'")).firstMatch.exists)
    }

    /// How often with an amount: each choice is the whole sentence ending, with the amount in it.
    func testHowOftenChoicesSayTheAmount() {
        newHabit(name: "Run")
        openHowMuch()
        let amount = app.textFields["much-number"]
        replace(amount, with: "5")
        chooseUnit("km")
        back()
        row("How often").tap()
        XCTAssertTrue(app.buttons["5 km a day"].exists)
        XCTAssertTrue(app.buttons["5 km a week"].exists)
        app.buttons["often-times"].tap()
        XCTAssertTrue(app.buttons["5 km on 3 days a week"].waitForExistence(timeout: 2), "Chosen, the row says exactly what")
        shot("o01-amount-on-days")
        back()
        XCTAssertEqual(sentence, "Run 5 km on 3 days a week, anytime")
        XCTAssertEqual(app.textFields["Each tap adds"].placeholderValue, "5", "Each time, so + adds the whole 5 km")
    }

    /// The Unit screen: your own unit and the usual groups; no time (Time it is its own type).
    func testUnitScreen() {
        newHabit(name: "Anything")
        openHowMuch()
        chooseUnitScreenOnly()
        XCTAssertFalse(app.buttons["Hours and minutes"].exists)
        XCTAssertTrue(app.buttons["create-unit"].exists)
        XCTAssertTrue(app.buttons["glasses"].exists)
        shot("u10-unit-screen")
    }

    private func chooseUnitScreenOnly() {
        let done = app.toolbars.buttons["Done"].firstMatch
        if done.exists && done.isHittable { done.tap(); sleep(1) }
        app.buttons["much-unit"].tap()
        XCTAssertTrue(app.navigationBars["Unit"].waitForExistence(timeout: 3))
    }
}
