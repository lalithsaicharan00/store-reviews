import XCTest

/// The habit page opened from Today (long-press → View Habit), and a past day filled in or changed from its
/// calendar (report "Filling In a Past Day From the Habit Page", 29 Sep 2026). Demo data: Water, 8 glasses a day,
/// done on each of the last 22 days.
final class HabitPageUITests: XCTestCase {
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
        XCTAssertTrue(app.buttons["Start Anytime routine"].waitForExistence(timeout: 8))
    }

    /// The calendar cell for a day, by its VoiceOver label ("Monday, 28 September, done").
    private func cell(_ date: Date) -> XCUIElement {
        let weekday = date.formatted(.dateTime.weekday(.wide))
        let month = date.formatted(.dateTime.month(.wide))
        let day = date.formatted(.dateTime.day())
        return app.buttons.matching(NSPredicate(format: "label BEGINSWITH %@ AND label CONTAINS %@ AND label CONTAINS %@",
                                                weekday, month, " \(day)")).firstMatch
    }

    private func waitFor(_ element: XCUIElement, labelContaining text: String) -> Bool {
        let e = expectation(for: NSPredicate(format: "label CONTAINS %@", text), evaluatedWith: element)
        return XCTWaiter.wait(for: [e], timeout: 3) == .completed
    }

    func testViewHabitAndChangeYesterday() {
        let water = app.staticTexts["Water"].firstMatch
        XCTAssertTrue(app.reveal(water, clear: true))
        water.press(forDuration: 1.0)
        let view = app.buttons["View Habit"]
        XCTAssertTrue(view.waitForExistence(timeout: 3), "View Habit is in the row's long-press menu")
        XCTAssertTrue(app.buttons["Edit Habit"].exists, "Edit Habit stays in the menu")
        view.tap()
        XCTAssertTrue(app.navigationBars["Water"].waitForExistence(timeout: 3), "The habit's page opens")

        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: .now)!
        if !Calendar.current.isDate(yesterday, equalTo: .now, toGranularity: .month) {
            app.buttons["Previous month"].tap() // the page opens on this month
        }
        let day = cell(yesterday)
        XCTAssertTrue(app.reveal(day), "Yesterday is a button in the calendar")
        day.tap()
        let status = app.staticTexts["day-status"]
        XCTAssertTrue(status.waitForExistence(timeout: 3), "A tap opens the day; it doesn't change it")
        XCTAssertTrue(status.label.contains("8 of 8"), "It says what the day was: \(status.label)")
        XCTAssertTrue(app.buttons["Log Amount Manually"].exists)

        // Take out what was logged that day: the day becomes not done, and only that day.
        app.buttons["delete-entry"].firstMatch.tap()
        XCTAssertTrue(waitFor(status, labelContaining: "0 of 8"), "The day is now empty: \(status.label)")
        XCTAssertTrue(app.buttons["Skip This Day"].waitForExistence(timeout: 3), "An empty day can be skipped")
        app.buttons["Done"].tap()
        XCTAssertTrue(cell(yesterday).label.hasSuffix("not done"), "The calendar shows the change: \(cell(yesterday).label)")

        // Put it back.
        cell(yesterday).tap()
        XCTAssertTrue(app.buttons["Log Amount Manually"].waitForExistence(timeout: 3))
        app.buttons["Log Amount Manually"].tap()
        let amount = app.textFields["log-amount"]
        XCTAssertTrue(amount.waitForExistence(timeout: 3))
        amount.typeText("8")
        app.buttons["Log"].tap()
        XCTAssertTrue(waitFor(app.staticTexts["day-status"], labelContaining: "8 of 8"))
        app.buttons["Done"].tap()
        XCTAssertTrue(cell(yesterday).label.hasSuffix(", done"))
    }
}
