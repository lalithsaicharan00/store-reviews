import XCTest

/// System UI may be unavailable on a hosted simulator. Explicit skips remain release blockers,
/// never substituted with the app-hosted rendering tests.
final class WidgetSystemUITests: XCTestCase {
    override func setUp() { continueAfterFailure = false }
    private func save(_ app: XCUIApplication, _ name: String) {
        let shot = XCTAttachment(screenshot: app.screenshot()); shot.name = name; shot.lifetime = .keepAlways; add(shot)
        let tree = XCTAttachment(string: app.debugDescription); tree.name = name + "-accessibility"; tree.lifetime = .keepAlways; add(tree)
        print("Widget system \(name):\n" + app.debugDescription)
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
        save(springboard, "home-gallery-results")
        // Remote gallery labels can report an unavailable hit point while their visible row is tappable.
        appRow.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        // Today is first after the existing Live Activity; choose the medium page before adding.
        springboard.swipeLeft()
        let confirm = springboard.buttons.matching(NSPredicate(format: "label CONTAINS %@", "Add Widget")).firstMatch
        guard confirm.waitForExistence(timeout: 5) else {
            save(springboard, "home-widget-add-missing"); XCTFail("Widget gallery has no Add Widget button"); return
        }
        confirm.tap()
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
        let wallpaper = settings.buttons["Wallpaper"]
        for _ in 0..<3 where !wallpaper.isHittable { settings.swipeUp() }
        var editor = settings
        if wallpaper.isHittable {
            wallpaper.tap()
        } else {
            save(settings, "lock-wallpaper-unavailable")
            // Some simulator Settings builds omit Wallpaper. Try the real Notification Center
            // wallpaper editor before reporting the system-host limitation.
            XCUIDevice.shared.press(.home)
            editor = XCUIApplication(bundleIdentifier: "com.apple.springboard")
            editor.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.01))
                .press(forDuration: 0.1, thenDragTo: editor.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.75)))
            editor.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.55)).press(forDuration: 2)
        }
        let customize = editor.buttons["Customize"].firstMatch
        guard customize.waitForExistence(timeout: 5) else {
            save(editor, "lock-customization-unavailable")
            throw XCTSkip("Simulator cannot customize the actual Lock Screen through system accessibility")
        }
        customize.tap()
        editor.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.32)).tap()
        save(editor, "lock-widget-picker")
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        let hosts = [settings, springboard]
        guard let host = hosts.first(where: { $0.staticTexts["Habits"].firstMatch.exists }) else {
            save(springboard, "lock-gallery-accessibility")
            throw XCTSkip("Lock widget gallery does not expose the app; physical-device installation remains required")
        }
        host.staticTexts["Habits"].firstMatch.tap()
        save(host, "lock-app-widgets")
        let today = host.buttons.matching(NSPredicate(format: "label CONTAINS %@", "Today on Lock Screen")).firstMatch
        guard today.waitForExistence(timeout: 5) else {
            save(host, "lock-widget-previews-unavailable")
            throw XCTSkip("Simulator gallery previews are not accessible; actual Lock Screen widget interaction remains unverified")
        }
        today.tap()
        if host.buttons["Close"].exists { host.buttons["Close"].tap() }
        if host.buttons["Done"].exists { host.buttons["Done"].tap() }
        save(host, "lock-summary-installed")
        XCTAssertTrue(host.staticTexts.matching(NSPredicate(format: "label CONTAINS %@", "left today")).firstMatch.waitForExistence(timeout: 10), host.debugDescription)
        // This validates summary installation. A locked-state quick action and every accessory family
        // cannot be claimed from it; the report retains those separate device checks.
    }
}
