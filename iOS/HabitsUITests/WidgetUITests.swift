import XCTest

/// The widgets' data checks (`WidgetCheck`) and every family drawn with the extension's own views at iPhone sizes
/// (`WidgetRenderCheck`). WidgetKit's own host is `WidgetSystemUITests`.
final class WidgetUITests: XCTestCase {
    override func setUp() { continueAfterFailure = false }

    func testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks() {
        let app = XCUIApplication(); app.launchArguments = ["-uitest", "-widgetcheck"]
        app.launch()
        let passed = app.staticTexts["Widgets: all checks passed"]
        if !passed.waitForExistence(timeout: 120) {
            let failed = app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH %@", "Widgets failed")).firstMatch
            XCTFail(failed.exists ? failed.label : labels(app))
        }
    }

    /// Bursts of taps, retried and out-of-order callbacks, ✓ and ▶/⏸ storms, stale buttons, privacy mid-run, deletion
    /// with taps queued, overlapping publications, a damaged file, travel, midnight and a year of history.
    func testReliabilityUnderBurstsRetriesAndRollover() {
        let app = XCUIApplication(); app.launchArguments = ["-uitest", "-widgetreliability"]
        app.launch()
        let passed = app.staticTexts["Widget reliability: all checks passed"]
        if !passed.waitForExistence(timeout: 240) {
            let failed = app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH %@", "Widget reliability failed")).firstMatch
            XCTFail(failed.exists ? failed.label : "Widget reliability did not finish")
        }
    }

    // MARK: Every family, drawn

    private func launchRender(_ extra: [String] = []) -> XCUIApplication {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest", "-empty", "-widget-fixture", "-widget-render"] + extra
        app.launch()
        XCTAssertTrue(app.descendants(matching: .any)["widget-render"].waitForExistence(timeout: 20), labels(app))
        return app
    }
    private func choose(_ app: XCUIApplication, family: String) {
        let button = app.buttons["family-\(family)"]
        let strip = app.scrollViews.firstMatch
        strip.swipeRight(); strip.swipeRight()
        for _ in 0..<3 where !button.isHittable { strip.swipeLeft() }
        XCTAssertTrue(button.isHittable, "Missing widget family \(family)")
        button.tap()
    }
    private func select(_ app: XCUIApplication, _ name: String) {
        let button = app.buttons["select-\(name)"]
        let strip = app.scrollViews.element(boundBy: 1)
        strip.swipeRight(); strip.swipeRight()
        for _ in 0..<4 where !button.isHittable { strip.swipeLeft() }
        XCTAssertTrue(button.isHittable, "Missing habit \(name)")
        button.tap()
    }
    /// Something in the drawn widget whose label contains `text` (a row's link reads its name and line together).
    private func shows(_ app: XCUIApplication, _ text: String, timeout: TimeInterval = 3) -> Bool {
        app.descendants(matching: .any)["widget-render"].descendants(matching: .any)
            .matching(NSPredicate(format: "label CONTAINS %@", text)).firstMatch.waitForExistence(timeout: timeout)
    }
    /// Everything the drawn widget says, on one line: CI's log keeps only a failure's first line.
    private func labels(_ app: XCUIApplication) -> String {
        let all = app.descendants(matching: .any)["widget-render"].descendants(matching: .any).allElementsBoundByIndex
        return all.prefix(80).map(\.label).filter { !$0.isEmpty }.joined(separator: " | ")
    }
    private func shot(_ app: XCUIApplication, _ name: String) {
        let shot = XCTAttachment(screenshot: app.screenshot()); shot.name = name; shot.lifetime = .keepAlways; add(shot)
    }

    func testEveryFamilyAndLayoutAtIPhoneSizes() {
        let app = launchRender()
        // Small · one habit: its name, today's value and its one button.
        app.buttons["layout-item"].tap(); choose(app, family: "systemSmall"); select(app, "Widget water")
        XCTAssertTrue(shows(app, "0 of 8 glasses"), labels(app))
        XCTAssertTrue(app.buttons["Add 1 to Widget water"].exists, "Small: +1 adds one glass")
        shot(app, "widget-small-water")
        for (name, expected, button) in [("Widget check", "Not checked", "Mark Widget check done"),
                                         ("Widget steps", "0 of 8k steps", "Log an amount for Widget steps"),
                                         ("Widget timer", "0 of 10 min", "Start Widget timer timer"),
                                         ("Widget routine", "0 of 3 steps", "Open Widget routine steps"),
                                         ("Widget cut down", "0 of 3 cups max", "Add 1 to Widget cut down"),
                                         ("Widget quit", "Quitting", "Record a slip for Widget quit")] {
            select(app, name)
            XCTAssertTrue(shows(app, expected), "\(name): \(expected) — \(labels(app))")
            XCTAssertTrue(app.buttons[button].exists || app.links[button].exists, "\(name): \(button) — \(labels(app))")
            shot(app, "widget-small-\(name)")
        }

        // Large Today: the cards in Today's order, five a page with ‹ 1/2 ›.
        app.buttons["layout-habits"].tap(); app.buttons["view-today"].tap(); choose(app, family: "systemLarge")
        XCTAssertTrue(shows(app, "Today") && shows(app, "Page 1 of 2") && shows(app, "0 of 5 done"), labels(app))
        XCTAssertTrue(shows(app, "Widget cut down") && shows(app, "Widget routine") == false, "Page 1 holds the first five — \(labels(app))")
        shot(app, "widget-large-today-page-1")
        app.buttons["render-next-page"].tap()
        XCTAssertTrue(shows(app, "Page 2 of 2") && shows(app, "Widget routine"), "Page 2 holds the rest at the top — \(labels(app))")
        shot(app, "widget-large-today-page-2")

        // Medium Today: two a page.
        app.buttons["view-today"].tap(); choose(app, family: "systemMedium")
        XCTAssertTrue(shows(app, "Page 1 of 4") && shows(app, "Widget cut down") && shows(app, "Widget quit"), labels(app))
        shot(app, "widget-medium-today")

        // A section: Morning only, without repeating "Morning" in each row.
        app.buttons["view-morning"].tap()
        XCTAssertTrue(shows(app, "Morning") && shows(app, "Widget check") && shows(app, "Widget timer"), labels(app))
        XCTAssertFalse(shows(app, "Widget water", timeout: 1), "A section shows only its own habits")
        shot(app, "widget-medium-morning")

        // Tasks: Large five a page, Medium two.
        app.buttons["layout-tasks"].tap(); app.buttons["view-today"].tap(); choose(app, family: "systemLarge")
        XCTAssertTrue(shows(app, "Tasks") && shows(app, "Page 1 of 2") && shows(app, "Widget task 1") && shows(app, "0 of 7 done"), labels(app))
        XCTAssertFalse(shows(app, "Widget water", timeout: 1), "The task list never shows habits")
        shot(app, "widget-large-tasks")
        choose(app, family: "systemMedium")
        XCTAssertTrue(shows(app, "Page 1 of 4"), labels(app))
        shot(app, "widget-medium-tasks")

        // This week: one habit, its week.
        app.buttons["layout-week"].tap(); choose(app, family: "systemMedium"); select(app, "Widget water")
        XCTAssertTrue(shows(app, "This week:") && shows(app, "/ 8 glasses"), labels(app))
        shot(app, "widget-week-water")
        select(app, "Widget quit")
        XCTAssertTrue(shows(app, "Since ") && shows(app, "Quitting"), labels(app))
        shot(app, "widget-week-quit")

        // Lock Screen: the circle, the line, the rectangle.
        app.buttons["layout-item"].tap(); select(app, "Widget water"); choose(app, family: "accessoryCircular")
        XCTAssertTrue(shows(app, "Widget water"), labels(app))
        shot(app, "widget-lock-circle")
        choose(app, family: "accessoryInline")
        XCTAssertTrue(shows(app, "Widget water · 0/8"), labels(app))
        app.buttons["layout-habits"].tap(); app.buttons["view-today"].tap(); choose(app, family: "accessoryRectangular")
        XCTAssertTrue(shows(app, "0 of 5 done") && shows(app, "5 left · Widget water"), labels(app))
        shot(app, "widget-lock-rectangle")
        choose(app, family: "accessoryInline")
        XCTAssertTrue(shows(app, "0 of 5 habits done"), labels(app))

        // Names hidden outside the app (Current Work 58): discreet cards, no names anywhere, buttons still there.
        app.buttons["render-discreet"].tap()
        app.buttons["layout-habits"].tap(); app.buttons["view-today"].tap(); choose(app, family: "systemLarge")
        XCTAssertTrue(shows(app, "Today") && shows(app, "of 5 done") && !shows(app, "Widget ", timeout: 1), labels(app))
        XCTAssertTrue(app.buttons["Add 1"].exists || app.buttons["Mark done"].exists, "Discreet rows keep their buttons: \(labels(app))")
        shot(app, "widget-discreet-large-today")
        app.buttons["layout-item"].tap(); choose(app, family: "systemSmall"); select(app, "Widget water")
        XCTAssertTrue(shows(app, "0 of 8 glasses") && app.buttons["Add 1"].exists && !shows(app, "Widget water", timeout: 1), labels(app))
        shot(app, "widget-discreet-small")
        choose(app, family: "accessoryCircular")
        XCTAssertTrue(shows(app, "Habit, ") && !shows(app, "Widget water", timeout: 1), labels(app))
        app.buttons["layout-tasks"].tap(); app.buttons["view-today"].tap(); choose(app, family: "systemLarge")
        XCTAssertTrue(shows(app, "7 tasks left") && !shows(app, "Widget task", timeout: 1), labels(app))
        shot(app, "widget-discreet-tasks")
        app.buttons["layout-habits"].tap(); choose(app, family: "accessoryRectangular")
        XCTAssertTrue(shows(app, "5 left") && !shows(app, "Widget", timeout: 1), labels(app))
        app.buttons["render-discreet"].tap()

        // A snapshot from an older build ("Content hidden") still draws as before.
        app.buttons["render-hidden"].tap(); choose(app, family: "systemLarge")
        XCTAssertTrue(shows(app, "Content hidden") && !shows(app, "Widget", timeout: 1), labels(app))
        shot(app, "widget-hidden")
        app.buttons["render-hidden"].tap()

        // Dark.
        let dark = app.switches["widget-dark"]
        dark.coordinate(withNormalizedOffset: CGVector(dx: 0.9, dy: 0.5)).tap()
        expectation(for: NSPredicate(format: "value == '1'"), evaluatedWith: dark); waitForExpectations(timeout: 5)
        shot(app, "widget-dark-large-today")
        app.buttons["layout-week"].tap(); choose(app, family: "systemMedium")
        shot(app, "widget-dark-week")
    }

    /// The Widgets page went into Help → Widgets, and its switch into Privacy & Security (Current Work 58, spec §1, T3).
    func testGuideAndPrivacyAreFree() {
        let app = XCUIApplication(); app.launchArguments = ["-uitest", "-empty", "-free"]
        app.launch()
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 10))
        app.buttons["menu-button"].tap()
        XCTAssertTrue(app.buttons["menu-privacy"].waitForExistence(timeout: 5))
        XCTAssertFalse(app.buttons["menu-widgets"].exists, "No Widgets page in the menu any more")
        app.buttons["menu-help"].tap()
        XCTAssertTrue(app.navigationBars["Help & Feedback"].waitForExistence(timeout: 5))
        let kinds = app.descendants(matching: .any)["help-topic-Which widgets are there?"]
        for _ in 0..<8 where !kinds.isHittable { app.swipeUp() }
        XCTAssertTrue(kinds.isHittable, "Help → Widgets lists the widgets")
        XCTAssertFalse(app.staticTexts["See Plus"].exists, "No Plus restrictions on widgets for now (the user, 6 Oct 2026)")
        app.navigationBars.buttons.element(boundBy: 0).tap()
        app.buttons["menu-button"].tap(); app.buttons["menu-privacy"].tap()
        XCTAssertTrue(app.navigationBars["Privacy & Security"].waitForExistence(timeout: 5))
        let privacy = app.switches["privacy-hide-names"]
        for _ in 0..<6 where !privacy.isHittable || privacy.frame.maxY > app.frame.maxY - 100 { app.swipeUp() }
        XCTAssertTrue(privacy.isHittable, labels(app))
        let before = privacy.value as? String
        // SwiftUI exposes the full labelled Toggle row; tap the actual trailing switch.
        privacy.coordinate(withNormalizedOffset: CGVector(dx: 0.9, dy: 0.5)).tap()
        let changed = NSPredicate(format: "value == %@", before == "1" ? "0" : "1")
        expectation(for: changed, evaluatedWith: privacy); waitForExpectations(timeout: 5)
        if privacy.value as? String == "1" { privacy.coordinate(withNormalizedOffset: CGVector(dx: 0.9, dy: 0.5)).tap() }
    }

    func testLargerTextCountersAndCutDownAreReadable() {
        let app = launchRender(["-UIPreferredContentSizeCategoryName", "UICTContentSizeCategoryXXXL"])
        app.buttons["layout-item"].tap(); choose(app, family: "systemSmall")
        for name in ["Widget quit", "Widget cut down", "Widget water"] {
            select(app, name)
            shot(app, "widget-larger-text-\(name)")
        }
        XCTAssertTrue(app.buttons["Add 1 to Widget water"].isHittable, "The button stays whole at larger text")
        // Medium lists show one row a page at the largest sizes rather than squeeze two (spec §5).
        app.buttons["layout-habits"].tap(); app.buttons["view-today"].tap(); choose(app, family: "systemMedium")
        XCTAssertTrue(shows(app, "Page 1 of 7"), labels(app))
        shot(app, "widget-larger-text-medium")
    }

    func testLongNamesAndUnitsKeepQuickActionVisible() {
        let app = launchRender(["-widget-long-labels", "-UIPreferredContentSizeCategoryName", "UICTContentSizeCategoryXXXL"])
        app.buttons["layout-item"].tap(); choose(app, family: "systemSmall"); select(app, "Widget water")
        let action = app.buttons["Add 1 to Widget water"]
        XCTAssertTrue(action.exists && action.isHittable && !action.frame.isEmpty, labels(app))
        shot(app, "widget-long-unit-larger-text")
        app.buttons["layout-habits"].tap(); choose(app, family: "systemLarge")
        XCTAssertTrue(app.buttons["Mark Read before breakfast done"].isHittable, "A long name never pushes the button out")
        shot(app, "widget-long-name-large")
    }
}
