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
        func enable(_ id: String) {
            let toggle = app.switches[id]
            if toggle.value as? String != "1" {
                toggle.coordinate(withNormalizedOffset: CGVector(dx: 0.9, dy: 0.5)).tap()
            }
            expectation(for: NSPredicate(format: "value == '1'"), evaluatedWith: toggle)
            waitForExpectations(timeout: 5)
        }
        enable("widget-plus")
        for (layout, families) in pairs.filter({ ["icons", "history"].contains($0.0) }) {
            app.buttons[layout].tap()
            if layout == "history" { app.buttons["select-Widget water"].tap() }
            for family in families {
                choose(family)
                let shot = XCTAttachment(screenshot: app.screenshot()); shot.name = "widget-plus-\(layout)-\(family)"; shot.lifetime = .keepAlways; add(shot)
            }
        }
        enable("widget-month")
        for family in ["systemSmall", "systemMedium", "systemLarge"] {
            choose(family)
            let shot = XCTAttachment(screenshot: app.screenshot()); shot.name = "widget-plus-month-\(family)"; shot.lifetime = .keepAlways; add(shot)
        }
        enable("widget-dark")
        let shot = XCTAttachment(screenshot: app.screenshot()); shot.name = "widget-dark-history"; shot.lifetime = .keepAlways; add(shot)
    }
    func testGuideAndPrivacyAreFree() {
        let app = XCUIApplication(); app.launchArguments = ["-uitest", "-empty", "-free"]
        app.launch()
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 10))
        app.buttons["menu-button"].tap(); app.buttons["menu-widgets"].tap()
        XCTAssertTrue(app.navigationBars["Widgets"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["Today agenda · small, medium and large"].exists)
        let privacy = app.switches["widgets-hide"]
        for _ in 0..<6 where !privacy.isHittable || privacy.frame.maxY > app.frame.maxY - 100 { app.swipeUp() }
        XCTAssertTrue(privacy.isHittable, app.debugDescription)
        let before = privacy.value as? String
        // SwiftUI exposes the full labelled Toggle row; tap the actual trailing switch.
        privacy.coordinate(withNormalizedOffset: CGVector(dx: 0.9, dy: 0.5)).tap()
        let changed = NSPredicate(format: "value == %@", before == "1" ? "0" : "1")
        expectation(for: changed, evaluatedWith: privacy); waitForExpectations(timeout: 5)
        if privacy.value as? String == "1" { privacy.coordinate(withNormalizedOffset: CGVector(dx: 0.9, dy: 0.5)).tap() }
    }

    func testLargerTextCountersAndCutDownAreReadable() {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest", "-empty", "-widget-fixture", "-widget-render", "-free",
                               "-UIPreferredContentSizeCategoryName", "UICTContentSizeCategoryXXXL"]
        app.launch()
        XCTAssertTrue(app.buttons["select-Widget quit"].waitForExistence(timeout: 15))
        for name in ["Widget quit", "Widget cut down", "Widget water"] {
            let select = app.buttons["select-\(name)"]
            app.scrollViews.element(boundBy: 1).swipeRight(); app.scrollViews.element(boundBy: 1).swipeRight()
            for _ in 0..<3 where !select.isHittable { app.scrollViews.element(boundBy: 1).swipeLeft() }
            XCTAssertTrue(select.isHittable, app.debugDescription); select.tap()
            let shot = XCTAttachment(screenshot: app.screenshot()); shot.name = "widget-larger-text-\(name)"; shot.lifetime = .keepAlways; add(shot)
        }
        app.buttons["agenda"].tap()
        let medium = app.buttons["family-systemMedium"]
        app.scrollViews.firstMatch.swipeRight()
        XCTAssertTrue(medium.isHittable); medium.tap()
        let shot = XCTAttachment(screenshot: app.screenshot()); shot.name = "widget-larger-text-agenda"; shot.lifetime = .keepAlways; add(shot)
    }

    func testLongNamesAndUnitsKeepQuickActionVisible() {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest", "-empty", "-widget-fixture", "-widget-render", "-widget-long-labels", "-free",
                               "-UIPreferredContentSizeCategoryName", "UICTContentSizeCategoryXXXL"]
        app.launch()
        let water = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH %@", "select-Widget water")).firstMatch
        XCTAssertTrue(water.waitForExistence(timeout: 15))
        water.coordinate(withNormalizedOffset: CGVector(dx: 0.05, dy: 0.5)).tap()
        let action = app.buttons.matching(NSPredicate(format: "label BEGINSWITH %@", "Add 1 large glasses of water to")).firstMatch
        XCTAssertTrue(action.exists && action.isHittable, app.debugDescription)
        XCTAssertFalse(action.frame.isEmpty)
        let shot = XCTAttachment(screenshot: app.screenshot()); shot.name = "widget-long-name-unit-larger-text"; shot.lifetime = .keepAlways; add(shot)
    }

}
