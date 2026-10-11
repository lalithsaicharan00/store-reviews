import XCTest

/// The iPad's Extra Large Today on the iPad's real Home Screen (Current Work 86, Design Notes §8): installed from the
/// system's widget gallery, a cold tap with the app closed flips the card at once and is saved behind it, quick taps all
/// count, and paging works with the app closed (Rulebook U26, U28: the switch and the safe save, unchanged). As with
/// `WidgetSystemUITests`, a skip means the hosted simulator didn't expose the gallery, never a pass. iPad only.
final class IPadWidgetSystemUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
        try XCTSkipUnless(UIDevice.current.userInterfaceIdiom == .pad, "iPad only")
    }

    private func save(_ app: XCUIApplication, _ name: String) {
        let shot = XCTAttachment(screenshot: app.screenshot()); shot.name = "ipad-" + name; shot.lifetime = .keepAlways; add(shot)
    }

    private func labels(_ app: XCUIApplication) -> String { WidgetSystemUITests.labels(in: app) }

    func testExtraLargeTodayOnTheHomeScreen() throws {
        #if !targetEnvironment(simulator)
        throw XCTSkip("Cold widget fixture uses the erased CI simulator's default database; never reset a device user's database")
        #endif
        XCUIDevice.shared.orientation = .landscapeLeft
        defer { XCUIDevice.shared.orientation = .portrait }
        let app = XCUIApplication()
        app.launchArguments = ["-empty", "-widget-fixture", "-free", "-dbname", "habits", "-reset-db"]
        app.launch()
        let todayShown = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Today,'")).firstMatch
        XCTAssertTrue(todayShown.waitForExistence(timeout: 20), "Today")
        app.terminate()
        app.launchArguments = ["-empty", "-widget-fixture", "-free", "-dbname", "habits"]
        app.launch()
        XCTAssertTrue(todayShown.waitForExistence(timeout: 20), "Today again")
        XCUIDevice.shared.press(.home)
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        springboard.coordinate(withNormalizedOffset: CGVector(dx: 0.6, dy: 0.85)).press(forDuration: 2)
        if springboard.buttons["Edit"].waitForExistence(timeout: 3) { springboard.buttons["Edit"].tap() }
        let addWidget = springboard.buttons["Add Widget"]
        guard addWidget.waitForExistence(timeout: 5) else {
            save(springboard, "home-widget-picker-unavailable")
            throw XCTSkip("Hosted simulator did not expose the iPad's Add Widget; real iPad validation remains required")
        }
        addWidget.tap()
        let search = springboard.searchFields.firstMatch
        guard search.waitForExistence(timeout: 5) else {
            save(springboard, "home-widget-search-unavailable")
            throw XCTSkip("The iPad's widget gallery search isn't in this simulator's accessibility tree")
        }
        search.tap(); search.typeText("Often Enough")
        let appRow = springboard.staticTexts["Often Enough"].firstMatch
        guard appRow.waitForExistence(timeout: 8) else {
            save(springboard, "home-widget-extension-unlisted")
            XCTFail("The app's widgets are missing from the iPad's gallery"); return
        }
        appRow.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        // The gallery's pages: find Today in Extra Large (iPad only), whichever page it's on.
        let today = springboard.buttons["Often Enough, Today"].firstMatch
        var found = false
        for _ in 0..<9 {
            if today.waitForExistence(timeout: 3), (today.value as? String)?.contains("Extra Large") == true { found = true; break }
            springboard.swipeLeft()
        }
        save(springboard, "home-gallery-extra-large")
        XCTAssertTrue(found, "Today in Extra Large in the iPad's gallery: \(springboard.debugDescription.prefix(2000))")
        guard found else { return }
        let confirm = springboard.buttons.matching(NSPredicate(format: "label CONTAINS %@", "Add Widget")).firstMatch
        XCTAssertTrue(confirm.waitForExistence(timeout: 5))
        confirm.tap()
        if springboard.buttons["Done"].waitForExistence(timeout: 5) { springboard.buttons["Done"].tap() }
        save(springboard, "home-extra-large-installed")
        // The app closed: the tap's intent must start it in the background (locked W1, W5).
        app.terminate()
        let add = springboard.buttons["Add 1 to Widget cut down"]
        XCTAssertTrue(add.waitForExistence(timeout: 20), "Extra Large shows the first card: \(labels(springboard))")
        let plus = springboard.coordinate(withNormalizedOffset: .zero).withOffset(CGVector(dx: add.frame.maxX - 22, dy: add.frame.midY))
        plus.tap()
        let logged = springboard.descendants(matching: .any).matching(NSPredicate(format: "label CONTAINS %@", "1 of 3 cups")).firstMatch
        if !logged.waitForExistence(timeout: 8), springboard.staticTexts["0 of 3 cups · Daily limit"].exists {
            save(springboard, "home-widget-touch-not-taken")
            plus.tap()
        }
        XCTAssertTrue(logged.waitForExistence(timeout: 30), "The card shows the tap: \(labels(springboard))")
        save(springboard, "home-extra-large-after-cold-log")
        // Ten a page: Widget water is on the first page beside it (Large needs a second page). Quick taps all count.
        let water = springboard.buttons["Add 1 to Widget water"]
        if water.waitForExistence(timeout: 10) {
            let waterPlus = springboard.coordinate(withNormalizedOffset: .zero).withOffset(CGVector(dx: water.frame.maxX - 22, dy: water.frame.midY))
            for _ in 0..<3 { waterPlus.tap(); Thread.sleep(forTimeInterval: 0.35) }
            let three = springboard.descendants(matching: .any).matching(NSPredicate(format: "label CONTAINS %@", "3 of 8 glasses")).firstMatch
            XCTAssertTrue(three.waitForExistence(timeout: 40), "Three quick taps, three glasses: \(labels(springboard))")
            save(springboard, "home-extra-large-quick-taps")
        } else {
            XCTFail("Widget water on Extra Large's first page: \(labels(springboard))")
        }
        // Saved, with the app never opened in front: the cut-down log is in the database once.
        app.launchArguments = ["-empty", "-free", "-dbname", "habits", "-widget-system-verify"]
        app.launch()
        XCTAssertTrue(app.staticTexts["Widget system: persisted log"].waitForExistence(timeout: 20), app.debugDescription)
    }
}
