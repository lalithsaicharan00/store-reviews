import XCTest

/// Settings (Build Plan #61; report "Settings — What People Need There", 29 Sep 2026): from the avatar on Today; the
/// day's end and the week's start; streaks can be hidden and come back; How It Works is searchable.
final class SettingsUITests: XCTestCase {
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

    private var streaks: XCUIElementQuery {
        app.descendants(matching: .any).matching(NSPredicate(format: "label BEGINSWITH 'Streak:'"))
    }

    func testHideStreaksAndBringThemBack() {
        XCTAssertTrue(streaks.firstMatch.waitForExistence(timeout: 3), "Demo habits have streaks on Today")
        app.buttons["Settings"].tap()
        XCTAssertTrue(app.navigationBars["Settings"].waitForExistence(timeout: 3), "The avatar opens Settings")
        XCTAssertTrue(app.buttons["settings-day-end"].exists || app.staticTexts["Day Ends At"].exists)
        let toggle = app.switches["settings-streaks"]
        XCTAssertTrue(toggle.exists)
        toggle.switches.firstMatch.exists ? toggle.switches.firstMatch.tap() : toggle.tap()
        app.buttons["Done"].tap()
        let gone = expectation(for: NSPredicate(format: "count == 0"), evaluatedWith: streaks)
        wait(for: [gone], timeout: 3)

        app.buttons["Settings"].tap()
        let again = app.switches["settings-streaks"]
        XCTAssertTrue(again.waitForExistence(timeout: 3))
        again.switches.firstMatch.exists ? again.switches.firstMatch.tap() : again.tap()
        app.buttons["Done"].tap()
        XCTAssertTrue(streaks.firstMatch.waitForExistence(timeout: 3), "Streaks come back")
    }

    func testHelpIsSearchable() {
        app.buttons["Settings"].tap()
        app.buttons["How It Works"].tap()
        XCTAssertTrue(app.navigationBars["How It Works"].waitForExistence(timeout: 3))
        let search = app.searchFields.firstMatch
        XCTAssertTrue(search.waitForExistence(timeout: 3))
        search.tap()
        search.typeText("undo")
        XCTAssertTrue(app.buttons["Undo a wrong tap"].waitForExistence(timeout: 3) || app.staticTexts["Undo a wrong tap"].exists)
        XCTAssertFalse(app.staticTexts["Run a routine"].exists, "Search narrows the list")
    }
}
