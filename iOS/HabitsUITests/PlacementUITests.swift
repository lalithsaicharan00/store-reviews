import XCTest

/// The placement rules (times decide the section), checked on the device with fixed data.
final class PlacementUITests: XCTestCase {
    func testPlacementRules() {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest", "-placementcheck"]
        app.launch()
        let result = app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH 'Placement'")).firstMatch
        XCTAssertTrue(result.waitForExistence(timeout: 10))
        XCTAssertEqual(result.label, "Placement: all checks passed")
    }
}
