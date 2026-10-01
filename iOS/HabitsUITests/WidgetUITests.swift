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
        XCTAssertTrue(app.descendants(matching: .any)["widget-render"].waitForExistence(timeout: 15), app.debugDescription)
        func choose(_ family: String) {
            let button = app.buttons["family-\(family)"]
            app.scrollViews.firstMatch.swipeRight(); app.scrollViews.firstMatch.swipeRight()
            for _ in 0..<3 where !button.isHittable { app.scrollViews.firstMatch.swipeLeft() }
            XCTAssertTrue(button.exists && button.isHittable, "Missing widget family \(family)")
            button.tap()
        }
        let pairs: [(String, [String])] = [
            ("agenda", ["systemSmall", "systemMedium", "systemLarge", "accessoryInline", "accessoryCircular", "accessoryRectangular"]),
            ("item", ["systemSmall", "accessoryInline", "accessoryCircular", "accessoryRectangular"]),
            ("icons", ["systemMedium", "systemLarge"]),
            ("history", ["systemSmall", "systemMedium", "systemLarge"])
        ]
        for (layout, families) in pairs {
            app.buttons[layout].tap()
            for family in families {
                choose(family)
                let shot = XCTAttachment(screenshot: app.screenshot()); shot.name = "widget-free-\(layout)-\(family)"; shot.lifetime = .keepAlways; add(shot)
            }
        }
        app.switches["widget-plus"].tap()
        for (layout, families) in pairs.filter({ ["icons", "history"].contains($0.0) }) {
            app.buttons[layout].tap()
            if layout == "history" { app.buttons["select-Widget water"].tap() }
            for family in families {
                choose(family)
                let shot = XCTAttachment(screenshot: app.screenshot()); shot.name = "widget-plus-\(layout)-\(family)"; shot.lifetime = .keepAlways; add(shot)
            }
        }
        app.switches["widget-month"].tap()
        for family in ["systemSmall", "systemMedium", "systemLarge"] {
            choose(family)
            let shot = XCTAttachment(screenshot: app.screenshot()); shot.name = "widget-plus-month-\(family)"; shot.lifetime = .keepAlways; add(shot)
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
