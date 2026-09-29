import XCTest

/// Today's Undo bar (report "Undo After Logging", 29 Sep 2026): a tap that logs is offered back for a few seconds,
/// and Undo takes back exactly that entry. Demo data: Water, 8 glasses a day, 8 logged today, + adds 1 glass.
final class UndoUITests: XCTestCase {
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

    private func waterLine(_ text: String) -> XCUIElement {
        app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH %@", text)).firstMatch
    }

    func testUndoTakesBackOnePlus() {
        let add = app.buttons["Add 1 glass to Water"]
        XCTAssertTrue(app.reveal(add, clear: true))
        XCTAssertTrue(waterLine("8/8 glasses").exists)
        add.tap()
        let undo = app.buttons["today-undo"]
        XCTAssertTrue(undo.waitForExistence(timeout: 3), "A tap that logs offers Undo")
        XCTAssertTrue(app.staticTexts["Water: +1 glass"].exists, "The bar says what was logged")
        XCTAssertTrue(waterLine("9/8 glasses").waitForExistence(timeout: 3))
        undo.tap()
        XCTAssertTrue(waterLine("8/8 glasses").waitForExistence(timeout: 3), "Undo takes back exactly that glass")
        let gone = expectation(for: NSPredicate(format: "exists == false"), evaluatedWith: undo)
        wait(for: [gone], timeout: 3)
    }

    func testBarGoesAwayByItself() {
        let add = app.buttons["Add 1 glass to Water"]
        XCTAssertTrue(app.reveal(add, clear: true))
        add.tap()
        let undo = app.buttons["today-undo"]
        XCTAssertTrue(undo.waitForExistence(timeout: 3))
        let gone = expectation(for: NSPredicate(format: "exists == false"), evaluatedWith: undo)
        wait(for: [gone], timeout: 10)
        XCTAssertTrue(waterLine("9/8 glasses").exists, "The glass stays logged")
    }
}
