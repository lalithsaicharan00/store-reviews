import XCTest

/// System UI may be unavailable on a hosted simulator. Explicit skips remain release blockers,
/// never substituted with the app-hosted rendering tests.
final class WidgetSystemUITests: XCTestCase {
    override func setUp() { continueAfterFailure = false }
    private func save(_ app: XCUIApplication, _ name: String) {
        let shot = XCTAttachment(screenshot: app.screenshot()); shot.name = name; shot.lifetime = .keepAlways; add(shot)
        let tree = XCTAttachment(string: app.debugDescription); tree.name = name + "-accessibility"; tree.lifetime = .keepAlways; add(tree)
    }
    func testHomeScreenInstallTapAndColdPersistence() throws {
        let app = XCUIApplication()
        app.launchArguments = ["-empty", "-widget-fixture", "-free", "-dbname", "widget-system", "-reset-db"]
        app.launch()
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 15))
        // The app's background handler waits for durable writes and the shared snapshot.
        XCUIDevice.shared.press(.home)
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        springboard.coordinate(withNormalizedOffset: CGVector(dx: 0.92, dy: 0.7)).press(forDuration: 2)
        if springboard.buttons["Edit"].waitForExistence(timeout: 3) { springboard.buttons["Edit"].tap() }
        let addWidget = springboard.buttons["Add Widget"]
        guard addWidget.waitForExistence(timeout: 5) else {
            save(springboard, "home-widget-picker-unavailable")
            throw XCTSkip("Hosted simulator did not expose Home Screen Add Widget; real WidgetKit host validation remains required")
        }
        addWidget.tap()
        let search = springboard.searchFields.firstMatch
        guard search.waitForExistence(timeout: 5) else {
            save(springboard, "home-widget-search-unavailable")
            throw XCTSkip("Widget gallery search is not available through this simulator's system accessibility tree")
        }
        search.tap(); search.typeText("Habits")
        let appRow = springboard.staticTexts["Habits"].firstMatch
        guard appRow.waitForExistence(timeout: 8) else {
            save(springboard, "home-widget-extension-unlisted")
            XCTFail("Built app's extension is missing from the real widget gallery"); return
        }
        appRow.tap()
        // Today is first after the existing Live Activity; choose the medium page before adding.
        springboard.swipeLeft()
        guard springboard.buttons["Add Widget"].waitForExistence(timeout: 5) else {
            save(springboard, "home-widget-add-missing"); XCTFail("Widget gallery has no Add Widget button"); return
        }
        springboard.buttons["Add Widget"].tap()
        if springboard.buttons["Done"].waitForExistence(timeout: 5) { springboard.buttons["Done"].tap() }
        save(springboard, "home-widget-installed")
        // Kill the app before tapping: LiveActivityIntent must start the app process in the background.
        app.terminate()
        let check = springboard.buttons["Check off Widget check"]
        XCTAssertTrue(check.waitForExistence(timeout: 15), springboard.debugDescription)
        check.tap()
        save(springboard, "home-widget-after-cold-check")
        app.launchArguments = ["-empty", "-free", "-dbname", "widget-system"]
        app.launch()
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 15))
        app.buttons["menu-button"].tap(); app.buttons["menu-widgets"].tap()
        // A separate diagnostic view validates disk state, without re-seeding or reusing memory.
        app.terminate(); app.launchArguments += ["-widget-system-verify"]; app.launch()
        XCTAssertTrue(app.staticTexts["Widget system: persisted check"].waitForExistence(timeout: 15), app.debugDescription)
    }
    func testLockScreenWidgetPickerAvailability() throws {
        let settings = XCUIApplication(bundleIdentifier: "com.apple.Preferences")
        settings.launch()
        let wallpaper = settings.cells["Wallpaper"]
        if !wallpaper.exists { settings.swipeUp() }
        guard wallpaper.waitForExistence(timeout: 5) else {
            save(settings, "lock-wallpaper-unavailable")
            throw XCTSkip("Simulator Wallpaper editor unavailable; actual Lock Screen family installation and interaction need a device")
        }
        wallpaper.tap()
        let customize = settings.buttons["Customize"].firstMatch
        guard customize.waitForExistence(timeout: 5) else {
            save(settings, "lock-customization-unavailable")
            throw XCTSkip("Simulator cannot customize the actual Lock Screen through system accessibility")
        }
        customize.tap()
        settings.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.32)).tap()
        save(settings, "lock-widget-picker")
        // Discovery here is only a capability check. Do not claim interaction is tested from this screenshot.
        throw XCTSkip("Lock Screen picker inspected; installed inline/circular/rectangular widgets and locked-state actions still require device validation")
    }
}
