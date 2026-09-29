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
        for _ in 0..<6 where !(element.exists && element.isHittable) { form.swipeUp() }
    }

    private func open(name: String) {
        app.navigationBars.buttons["New Habit"].firstMatch.tap()
        row("Build or maintain").tap()
        let field = app.descendants(matching: .any)["name-field"]
        XCTAssertTrue(field.waitForExistence(timeout: 3))
        field.tap()
        field.typeText(name + "\n")
    }

    private func pickParts(_ parts: [String]) {
        row("Time of Day").tap()
        XCTAssertTrue(app.navigationBars["Time of Day"].waitForExistence(timeout: 3))
        for part in parts { app.buttons[part].firstMatch.tap() }
        shot("w-time-of-day-\(parts.joined(separator: "-"))")
        app.navigationBars.buttons["BackButton"].firstMatch.tap()
        sleep(1)
    }

    func testCheckOffMorningAndEveningWithReminders() {
        open(name: "Brush teeth")
        shot("w01-default-anytime")
        XCTAssertTrue(row("Time of Day, Anytime").exists, "Anytime is the default")
        pickParts(["Morning", "Evening"])
        XCTAssertTrue(row("Time of Day, Morning and Evening").exists)
        // One reminder per time of day, labelled with its part (count by name: Starts is a date picker too).
        for part in ["Morning", "Evening"] {
            let reminder = app.staticTexts["\(part) reminder"]
            scrollTo(reminder)
            XCTAssertTrue(reminder.exists, "\(part) has its reminder")
        }
        shot("w03-reminders-on")
        app.collectionViews["habit-form"].swipeUp()
        shot("w04-reminders-footer")
        app.navigationBars["New Habit"].buttons["Add"].tap()
        let allow = XCUIApplication(bundleIdentifier: "com.apple.springboard").buttons["Allow"]
        if allow.waitForExistence(timeout: 3) { allow.tap() }
        sleep(2)
        shot("w05-today")
    }

    /// Parts of the day are multi-select for every type, amounts included.
    func testAmountPicksSeveralParts() {
        open(name: "Water")
        pickParts(["Morning", "Afternoon"])
        XCTAssertTrue(row("Time of Day, Morning and Afternoon").exists)
        shot("w06-amount-two-parts")
    }
}
