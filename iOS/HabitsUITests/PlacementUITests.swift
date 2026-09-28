import XCTest

/// The placement rules (times decide the section), checked on the device with fixed data.
final class PlacementUITests: XCTestCase {
    override func record(_ issue: XCTIssue) {
        let shot = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        shot.name = "FAIL-\(name)"
        shot.lifetime = .keepAlways
        var issue = issue
        issue.add(shot)
        super.record(issue)
    }

    func testPlacementRules() {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest", "-placementcheck"]
        app.launch()
        let result = app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH 'Placement'")).firstMatch
        XCTAssertTrue(result.waitForExistence(timeout: 10))
        XCTAssertEqual(result.label, "Placement: all checks passed")
    }
}
