import XCTest

final class WidgetUITests: XCTestCase {
    override func setUp() { continueAfterFailure = false }
    func testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks() {
        let app = XCUIApplication(); app.launchArguments = ["-uitest", "-widgetcheck"]
        app.launch()
        XCTAssertTrue(app.staticTexts["Widgets: all checks passed"].waitForExistence(timeout: 90), app.debugDescription)
    }
    func testEveryFamilyAndLayoutAtIPhoneSizes() {
        let app = XCUIApplication(); app.launchArguments = ["-uitest", "-empty", "-widget-fixture", "-widget-render", "-free"]
        app.launch()
        XCTAssertTrue(app.otherElements["widget-render"].waitForExistence(timeout: 15), app.debugDescription)
        for layout in ["agenda", "item", "icons", "history"] {
            app.buttons[layout].tap()
            for family in ["systemSmall", "systemMedium", "systemLarge", "accessoryInline", "accessoryCircular", "accessoryRectangular"] {
                let button = app.buttons["family-\(family)"]
                if !button.isHittable { app.scrollViews.firstMatch.swipeLeft() }
                XCTAssertTrue(button.exists && button.isHittable, "Missing widget family \(family)"); button.tap()
                let shot = XCTAttachment(screenshot: app.screenshot()); shot.name = "widget-free-\(layout)-family-\(family)"; shot.lifetime = .keepAlways; add(shot)
            }
        }
        app.switches["widget-plus"].tap()
        for layout in ["icons", "history"] {
            app.buttons[layout].tap()
            for family in ["systemMedium", "systemLarge"] {
                let button = app.buttons["family-\(family)"]
                if !button.isHittable { app.scrollViews.firstMatch.swipeRight() }
                button.tap()
                let shot = XCTAttachment(screenshot: app.screenshot()); shot.name = "widget-plus-\(layout)-family-\(family)"; shot.lifetime = .keepAlways; add(shot)
            }
        }
        app.switches["widget-dark"].tap()
        let shot = XCTAttachment(screenshot: app.screenshot()); shot.name = "widget-dark-history"; shot.lifetime = .keepAlways; add(shot)
    }
    func testGuideAndPrivacyAreFree() {
        let app = XCUIApplication(); app.launchArguments = ["-uitest", "-empty", "-free"]
        app.launch()
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 10))
        app.buttons["menu-button"].tap(); app.buttons["menu-widgets"].tap()
        XCTAssertTrue(app.navigationBars["Widgets"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["Today agenda · small, medium and large"].exists)
        app.revealAndTap(app.switches["widgets-hide"])
        XCTAssertEqual(app.switches["widgets-hide"].value as? String, "1")
        app.switches["widgets-hide"].tap()
    }
}
