import XCTest

final class StarterUITests: XCTestCase {
    func testAppOpens() {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.staticTexts["Often Enough"].waitForExistence(timeout: 30))
    }
}
