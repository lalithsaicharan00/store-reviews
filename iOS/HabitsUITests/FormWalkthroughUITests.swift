import XCTest

/// Walks through Time of Day and Reminders on the form and keeps a screenshot of each step, for review.
/// Rewritten 28 Sep 2026: Time of Day is its own screen, always multi-select for every type (spec §5).
final class FormWalkthroughUITests: XCTestCase {
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

    private func scrollTo(_ element: XCUIElement) {
        let form = app.collectionViews["habit-form"]
        app.reveal(element)
    }

    private func open(name: String, type: String = "Check It Off") {
        app.navigationBars.buttons["New Habit"].firstMatch.tap()
        row("Build or Maintain,").tap()
        row(type + ",").tap()
        let field = app.descendants(matching: .any)["name-field"]
        XCTAssertTrue(field.waitForExistence(timeout: 3))
        field.tap()
        field.typeText(name + "\n")
    }

    private func pickParts(_ parts: [String]) {
        scrollTo(row("Routine"))
        row("Routine").tap()
        XCTAssertTrue(app.navigationBars["Routine"].waitForExistence(timeout: 3))
        for part in parts { app.buttons[part].firstMatch.tap() }
        shot("w-time-of-day-\(parts.joined(separator: "-"))")
        app.navigationBars.buttons["BackButton"].firstMatch.tap()
        sleep(1)
    }

    func testCheckOffMorningAndEveningWithReminders() {
        open(name: "Brush teeth")
        shot("w01-default-anytime")
        XCTAssertTrue(row("Routine, Anytime").exists, "Anytime is the default")
        pickParts(["Morning", "Evening"])
        XCTAssertTrue(row("Routine, Morning and Evening").exists)
        // Reminders start off; turned on, there's one per time of day, labelled with its part.
        let reminders = row("Reminders")
        scrollTo(reminders)
        XCTAssertEqual(reminders.label, "Reminders, Off")
        reminders.tap()
        app.switches["Remind Me"].firstMatch.switches.firstMatch.tap()
        for part in ["Morning", "Evening"] {
            XCTAssertTrue(app.staticTexts["\(part) reminder"].waitForExistence(timeout: 2), "\(part) has its reminder")
        }
        shot("w03-reminders-on")
        app.swipeUp()
        shot("w04-reminders-footer")
        app.navigationBars.buttons["BackButton"].firstMatch.tap(); sleep(1)
        app.navigationBars["New Habit"].buttons["Add"].tap()
        let allow = XCUIApplication(bundleIdentifier: "com.apple.springboard").buttons["Allow"]
        if allow.waitForExistence(timeout: 3) { allow.tap() }
        sleep(2)
        shot("w05-today")
    }

    /// Parts of the day are multi-select for every type, amounts included.
    func testAmountPicksSeveralParts() {
        open(name: "Water", type: "Track an Amount")
        pickParts(["Morning", "Afternoon"])
        XCTAssertTrue(row("Routine, Morning and Afternoon").exists)
        shot("w06-amount-two-parts")
    }
}
