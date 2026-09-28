import XCTest

/// Walks through Time of Day and Reminders on the form and keeps a screenshot of each step, for review.
final class FormWalkthroughUITests: XCTestCase {
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

    private func scrollTo(_ element: XCUIElement) {
        let form = app.collectionViews["habit-form"]
        for _ in 0..<6 where !(element.exists && element.isHittable) { form.swipeUp() }
    }

    private func open(_ type: String, name: String) {
        app.navigationBars.buttons["New Habit"].firstMatch.tap()
        app.buttons[type].tap()
        let field = app.descendants(matching: .any)["name-field"]
        XCTAssertTrue(field.waitForExistence(timeout: 3))
        field.tap()
        field.typeText(name + "\n")
    }

    func testCheckOffMorningAndEveningWithReminders() {
        open("Check it off", name: "Brush teeth")
        let morning = app.buttons["Morning"].firstMatch
        scrollTo(morning)
        app.collectionViews["habit-form"].swipeUp()
        shot("w01-default-anytime")
        XCTAssertTrue(app.staticTexts["Or pick one or more parts of the day:"].exists)
        morning.tap()
        app.buttons["Evening"].firstMatch.tap()
        let sentence = app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH 'It shows in Morning and Evening, with a tick in each'")).firstMatch
        scrollTo(sentence)
        XCTAssertTrue(sentence.exists)
        shot("w02-morning-evening")
        let remind = app.switches["Remind Me"].firstMatch
        scrollTo(remind)
        remind.switches.firstMatch.tap()
        let allow = XCUIApplication(bundleIdentifier: "com.apple.springboard").buttons["Allow"]
        if allow.waitForExistence(timeout: 3) { allow.tap() }
        XCTAssertTrue(app.datePickers.count == 2, "One reminder per time of day")
        shot("w03-reminders-on")
        app.collectionViews["habit-form"].swipeUp()
        shot("w04-reminders-footer")
        app.navigationBars["Check it off"].buttons["Add"].tap()
        sleep(3)
        shot("w05-today")
    }

    func testAmountPicksOne() {
        open("Count an amount", name: "Water")
        let anytime = app.buttons["Anytime"].firstMatch
        scrollTo(anytime)
        XCTAssertTrue(app.staticTexts["Or pick a part of the day:"].exists)
        app.buttons["Afternoon"].firstMatch.tap()
        shot("w06-amount-one")
    }
}
