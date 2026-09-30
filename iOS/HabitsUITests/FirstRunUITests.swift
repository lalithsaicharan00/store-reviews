import XCTest

/// The first run (report "The First Run — Start in One Tap", 30 Sep): a fresh install opens straight on Today with
/// New Habit, Restore from a Backup and How It Works; no tour, questions or account first.
final class FirstRunUITests: XCTestCase {
    func testFreshInstallOffersNewRestoreAndHelp() {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launchArguments = ["-uitest", "-empty"]
        app.launch()

        XCTAssertTrue(app.staticTexts["No habits yet"].waitForExistence(timeout: 5), "Today is the first screen")
        XCTAssertTrue(app.buttons["first-new-habit"].exists)
        XCTAssertTrue(app.buttons["first-restore"].exists, "Someone who has used Habits before can restore first")

        app.buttons["first-help"].tap()
        XCTAssertTrue(app.navigationBars["How It Works"].waitForExistence(timeout: 3))
        app.navigationBars["How It Works"].buttons["Done"].tap()
        XCTAssertTrue(app.buttons["first-new-habit"].waitForExistence(timeout: 3))

        app.buttons["first-new-habit"].tap()
        XCTAssertTrue(app.navigationBars["New"].waitForExistence(timeout: 3), "One tap to the first habit")
    }
}
