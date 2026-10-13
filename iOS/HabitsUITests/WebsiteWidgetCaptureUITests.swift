import XCTest

/// Authentic SpringBoard marketing captures, not the app-hosted widget rendering harness.
/// Run only on an erased GitHub simulator. A missing host/configuration is a failure, never a substitute image.
final class WebsiteWidgetCaptureUITests: XCTestCase {
    private let sb = XCUIApplication(bundleIdentifier: "com.apple.springboard")
    override func setUp() {
        continueAfterFailure = false
        executionTimeAllowance = 900
        XCUIDevice.shared.orientation = .portrait
    }
    private func save(_ name: String) {
        let shot = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        shot.name = "website-" + name; shot.lifetime = .keepAlways; add(shot)
        let tree = XCTAttachment(string: sb.debugDescription)
        tree.name = "website-" + name + "-tree"; tree.lifetime = .keepAlways; add(tree)
    }
    private func seed(reset: Bool) throws {
        #if !targetEnvironment(simulator)
        throw XCTSkip("Erased CI simulator only; never seed a person's phone")
        #endif
        let app = XCUIApplication()
        app.launchArguments = ["-empty", "-widget-fixture", "-website-widget-fixture", "-dbname", "habits"]
        if reset { app.launchArguments += ["-reset-db"] }
        app.launch()
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 30), "Capture fixture app opened")
        // Disarm reset before a system/cold launch, then finish any interrupted fixture (T14).
        app.terminate()
        app.launchArguments = ["-empty", "-widget-fixture", "-website-widget-fixture", "-dbname", "habits"]
        app.launch()
        let openMorning = app.buttons["Open Morning"]
        if openMorning.waitForExistence(timeout: 5) { openMorning.tap() }
        for _ in 0..<4 where !app.staticTexts["Kitchen"].exists { app.swipeUp() }
        XCTAssertTrue(app.staticTexts["Kitchen"].waitForExistence(timeout: 30), "Capture fixture finished")
        XCUIDevice.shared.press(.home)
        Thread.sleep(forTimeInterval: 3)
    }
    private func widgets() -> [XCUIElement] {
        sb.icons.matching(NSPredicate(format: "label == %@ AND value CONTAINS %@", "Often Enough", "Widget"))
            .allElementsBoundByIndex.filter { $0.frame.width > 50 && $0.frame.minX >= 0 && $0.frame.maxX <= sb.frame.width }
    }
    private func beginEdit() {
        sb.coordinate(withNormalizedOffset: CGVector(dx: 0.92, dy: 0.72)).press(forDuration: 2)
        if sb.buttons["Edit Home Screen"].waitForExistence(timeout: 2) { sb.buttons["Edit Home Screen"].tap() }
        if sb.buttons["Edit"].waitForExistence(timeout: 3) { sb.buttons["Edit"].tap() }
    }
    private func install(page: Int, name: String, size: String) {
        beginEdit()
        XCTAssertTrue(sb.buttons["Add Widget"].waitForExistence(timeout: 8), "Home Screen Add Widget available")
        sb.buttons["Add Widget"].tap()
        let search = sb.searchFields.firstMatch
        XCTAssertTrue(search.waitForExistence(timeout: 8), "Native widget gallery search available")
        search.tap(); search.typeText("Often Enough")
        let row = sb.staticTexts["Often Enough"].firstMatch
        XCTAssertTrue(row.waitForExistence(timeout: 12), "App extension listed in system gallery")
        row.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        for index in 1..<page {
            sb.swipeLeft()
            let indicator = sb.pageIndicators.matching(NSPredicate(format: "value == %@", "page \(index + 1) of 6")).firstMatch
            if !indicator.waitForExistence(timeout: 3) {
                let prior = sb.pageIndicators.matching(NSPredicate(format: "value == %@", "page \(index) of 6")).firstMatch
                if prior.exists { sb.swipeLeft() }
            }
        }
        let preview = sb.buttons["Often Enough, " + name].firstMatch
        XCTAssertTrue(preview.waitForExistence(timeout: 12), "Correct native gallery family: " + name)
        XCTAssertTrue((preview.value as? String)?.contains(size) == true, "Native family size: " + size)
        let addWidget = sb.buttons.matching(NSPredicate(format: "label CONTAINS %@", "Add Widget")).firstMatch
        XCTAssertTrue(addWidget.waitForExistence(timeout: 8)); addWidget.tap()
        if sb.buttons["Done"].waitForExistence(timeout: 5) { sb.buttons["Done"].tap() }
        Thread.sleep(forTimeInterval: 3)
        save("installed-" + name + "-" + size)
    }
    private func configure(_ widget: XCUIElement, parameter: String, value: String) {
        widget.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.45)).press(forDuration: 2)
        let edit = sb.buttons["Edit Widget"]
        XCTAssertTrue(edit.waitForExistence(timeout: 8), "Edit Widget available for " + value); edit.tap()
        save("configure-" + value)
        let choose = sb.buttons["Choose"].firstMatch
        if choose.waitForExistence(timeout: 2) { choose.tap() }
        else {
            let current = sb.buttons.matching(NSPredicate(format: "label == %@ OR label BEGINSWITH %@", parameter, parameter + ",")).firstMatch
            if current.exists { current.tap() }
            else {
                let field = sb.staticTexts[parameter].firstMatch
                XCTAssertTrue(field.waitForExistence(timeout: 5), "Native configuration parameter " + parameter)
                field.coordinate(withNormalizedOffset: CGVector(dx: 0.85, dy: 0.5)).tap()
            }
        }
        save("choices-" + value)
        let choice = sb.descendants(matching: .any).matching(NSPredicate(format: "label == %@", value)).firstMatch
        XCTAssertTrue(choice.waitForExistence(timeout: 12), "Native configuration choice " + value)
        choice.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        sb.coordinate(withNormalizedOffset: CGVector(dx: 0.06, dy: 0.82)).tap()
        Thread.sleep(forTimeInterval: 4)
        save("configured-" + value)
    }
    private func unconfiguredSmall() -> XCUIElement {
        let candidates = widgets().filter { $0.frame.width < 230 && $0.frame.height < 240 }
        return candidates.first { $0.descendants(matching: .any).matching(NSPredicate(format: "label CONTAINS %@", "Choose a habit")).firstMatch.exists } ?? candidates.first!
    }
    func testHomeScreenCaptures() throws {
        try seed(reset: true)
        // A new Home page in native edit mode keeps the capture away from the default app grid.
        beginEdit()
        sb.swipeLeft(); sb.swipeLeft()
        if sb.buttons["Done"].exists { sb.buttons["Done"].tap() }
        save("home-start-page")
        install(page: 3, name: "Today", size: "Large")
        let large = widgets().first { $0.frame.height > 260 }
        XCTAssertNotNil(large, "Actual Large widget installed")
        configure(large!, parameter: "Show", value: "Morning")
        install(page: 1, name: "One habit", size: "Small")
        configure(unconfiguredSmall(), parameter: "Habit", value: "Water")
        install(page: 1, name: "One habit", size: "Small")
        configure(unconfiguredSmall(), parameter: "Habit", value: "Smoke-free")
        save("home-small-pair-and-large")
        let shown = sb.debugDescription
        XCTAssertTrue(shown.contains("Water") && shown.contains("Smoke-free") && shown.contains("Kitchen"),
                      "Two Small and section-filtered Large are visible together")
        // Two Small (2 rows) + Large (4 rows) fill the real phone grid. Weekly is captured on another native page.
        beginEdit(); sb.swipeLeft()
        if sb.buttons["Done"].exists { sb.buttons["Done"].tap() }
        install(page: 4, name: "This week", size: "Medium")
        let weekly = widgets().first { $0.frame.width > 250 && $0.frame.height < 250 }
        XCTAssertNotNil(weekly, "Actual Weekly Medium installed")
        configure(weekly!, parameter: "Habit", value: "Coffee")
        save("home-weekly")
        XCTAssertTrue(sb.debugDescription.contains("Coffee"), "Configured weekly habit visible")
    }
    func testLockScreenCapture() throws {
        try seed(reset: false)
        let settings = XCUIApplication(bundleIdentifier: "com.apple.Preferences")
        settings.launch()
        let wallpaper = settings.descendants(matching: .any).matching(NSPredicate(format: "label == %@", "Wallpaper")).firstMatch
        for _ in 0..<5 where !wallpaper.isHittable { settings.swipeUp() }
        if wallpaper.isHittable {
            wallpaper.tap()
        } else {
            XCUIDevice.shared.press(.home)
            sb.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.01))
                .press(forDuration: 0.1, thenDragTo: sb.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.8)))
            sb.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).press(forDuration: 2)
        }
        save("lock-editor-entry")
        // Wallpaper customization may be hosted by PosterBoard rather than SpringBoard/Settings.
        let poster = XCUIApplication(bundleIdentifier: "com.apple.PosterBoard")
        let hosts = [poster, sb, settings]
        guard let editor = hosts.first(where: { $0.state == .runningForeground && $0.buttons["Customize"].exists }) else {
            XCTFail("Actual Lock Screen Customize unavailable; see capture attachment"); return
        }
        editor.buttons["Customize"].firstMatch.tap()
        let lock = editor.buttons["Lock Screen"].firstMatch
        if lock.waitForExistence(timeout: 3) { lock.tap() }
        else { editor.coordinate(withNormalizedOffset: CGVector(dx: 0.27, dy: 0.35)).tap() }
        let widgetArea = editor.buttons["Add Widgets"].firstMatch
        if widgetArea.waitForExistence(timeout: 4) { widgetArea.tap() }
        else { editor.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.37)).tap() }
        save("lock-add-widgets")
        guard let picker = hosts.first(where: { $0.state == .runningForeground && $0.staticTexts["Often Enough"].firstMatch.exists }) else {
            XCTFail("Native Lock Screen gallery does not expose Often Enough"); return
        }
        picker.staticTexts["Often Enough"].firstMatch.tap()
        let summary = picker.buttons.matching(NSPredicate(format: "label CONTAINS %@", "Today")).firstMatch
        XCTAssertTrue(summary.waitForExistence(timeout: 8), "Native rectangular Lock widget preview")
        summary.tap()
        save("lock-summary-added")
        let circle = picker.buttons.matching(NSPredicate(format: "label CONTAINS %@", "One habit")).firstMatch
        XCTAssertTrue(circle.waitForExistence(timeout: 8), "Native circular Lock widget preview")
        circle.tap(); circle.tap()
        if picker.buttons["Close"].exists { picker.buttons["Close"].tap() }
        save("lock-configure-circles")
        // Native system identifiers can vary across iOS runtimes; retain editor evidence for diagnosis.
        // A final capture is accepted only after configured circles and summary are verified, never from this editor.
        let choices = picker.buttons.matching(NSPredicate(format: "label CONTAINS %@", "Choose")).allElementsBoundByIndex
        for (index, target) in ["Water", "Stretch"].enumerated() where index < choices.count {
            choices[index].tap()
            let option = picker.descendants(matching: .any).matching(NSPredicate(format: "label == %@", target)).firstMatch
            XCTAssertTrue(option.waitForExistence(timeout: 8)); option.tap()
        }
        if picker.buttons["Done"].exists { picker.buttons["Done"].tap() }
        if picker.buttons["Set as Wallpaper Pair"].exists { picker.buttons["Set as Wallpaper Pair"].tap() }
        XCUIDevice.shared.press(.home)
        sb.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.01))
            .press(forDuration: 0.1, thenDragTo: sb.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.8)))
        save("lock-installed-summary-and-circles")
        let tree = sb.debugDescription
        XCTAssertTrue(tree.contains("left") && tree.contains("Water") && tree.contains("Stretch"),
                      "Installed Lock summary and configured native circles visible")
    }
}
