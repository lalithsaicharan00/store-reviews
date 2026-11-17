import XCTest

/// Groups (Build Plan #68; `Docs/Specs/Groups — What to Build.md`): picked or made in the habit form, and chosen on
/// Progress. Today has no Filter since 17 Nov 2026 (Figma's Today is ☰ · Edit · +), so Today never filters by group and
/// the tests that went through its Filter went with it. `-groups-demo` adds Health, Mind, Home and an empty Reading to
/// the demo habits.
final class GroupsUITests: XCTestCase {
    private var app: XCUIApplication!

    override func record(_ issue: XCTIssue) {
        let shot = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        shot.name = "FAIL-\(name)"
        shot.lifetime = .keepAlways
        var issue = issue
        issue.add(shot)
        super.record(issue)
    }

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
    }

    private func launch(_ arguments: [String] = []) {
        app.launchArguments = ["-uitest"] + arguments
        app.launch()
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 10))
    }

    private func shot(_ name: String) {
        let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    private func text(_ label: String) -> XCUIElement { app.staticTexts[label] }
    private func chip(_ name: String) -> XCUIElement { app.buttons["group-chip-\(name)"] }
    private func row(_ title: String) -> XCUIElement {
        app.buttons.matching(NSPredicate(format: "label BEGINSWITH %@", title)).firstMatch
    }

    /// The chips scroll sideways: bring one into view first.
    private func tapChip(_ name: String) {
        let element = chip(name)
        XCTAssertTrue(element.waitForExistence(timeout: 3), name)
        for _ in 0..<3 where !element.isHittable { chip("all").swipeLeft() }
        element.tap()
    }

    /// The habit form's Group row: pick a group, or make one from there and it's picked; every habit shows on Today.
    func testGroupInHabitForm() {
        launch(["-groups-demo"])
        app.navigationBars.buttons["New Habit"].firstMatch.tap()
        XCTAssertTrue(app.navigationBars["New"].waitForExistence(timeout: 3))
        row("Build or maintain,").tap()
        row("Check it off,").tap()
        XCTAssertTrue(app.navigationBars["New Habit"].waitForExistence(timeout: 3))
        let name = app.descendants(matching: .any)["name-field"]
        name.tap()
        name.typeText("Journal\n")
        let group = app.buttons["group-row"]
        app.reveal(group)
        XCTAssertEqual(group.label, "Group, None")
        group.tap()
        XCTAssertTrue(app.navigationBars["Group"].waitForExistence(timeout: 3))
        app.buttons["group-option-Mind"].tap()
        XCTAssertTrue(app.navigationBars["New Habit"].waitForExistence(timeout: 3))
        XCTAssertEqual(group.label, "Group, Mind")
        shot("g09-form-group")
        app.navigationBars["New Habit"].buttons["Add"].tap()

        XCTAssertTrue(app.navigationBars.buttons["New Habit"].firstMatch.waitForExistence(timeout: 5))
        XCTAssertTrue(app.reveal(text("Journal"), clear: true), "Journal is on Today")

        // A group made from the picker is picked.
        app.navigationBars.buttons["New Habit"].firstMatch.tap()
        row("Build or maintain,").tap()
        row("Check it off,").tap()
        XCTAssertTrue(app.navigationBars["New Habit"].waitForExistence(timeout: 3))
        app.descendants(matching: .any)["name-field"].tap()
        app.descendants(matching: .any)["name-field"].typeText("Plan week\n")
        app.reveal(group)
        XCTAssertEqual(group.label, "Group, None", "Today has no filter, so a new habit starts in no group")
        group.tap()
        app.buttons["group-picker-new"].tap()
        XCTAssertTrue(app.navigationBars["New Group"].waitForExistence(timeout: 3))
        XCTAssertFalse(app.buttons["group-habit-Read"].exists, "From the form, the habit being made joins it")
        app.textFields["group-name-field"].typeText("Work\n")
        app.navigationBars["New Group"].buttons["group-save"].tap()
        XCTAssertTrue(app.navigationBars["Group"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.buttons["group-option-Work"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.buttons["group-option-Work"].isSelected, "The new group is picked")
        app.navigationBars["Group"].buttons.element(boundBy: 0).tap()
        XCTAssertEqual(group.label, "Group, Work")
        app.navigationBars["New Habit"].buttons["Add"].tap()
        XCTAssertTrue(app.navigationBars.buttons["New Habit"].firstMatch.waitForExistence(timeout: 5))
        XCTAssertTrue(app.reveal(text("Plan week"), clear: true), "Plan week is on Today")
    }

    /// Progress: the chips choose which habits' cards show (Week, Month and Year are cards only since 2 Oct 2026, with no
    /// Groups card or group numbers). Habits (≡) lists habits by group.
    func testProgressAndHabitsByGroup() {
        launch(["-groups-demo"])
        app.buttons["menu-button"].tap()
        app.buttons["menu-progress"].tap()
        XCTAssertTrue(app.navigationBars["Progress"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons["progress-row-Water"].waitForExistence(timeout: 5), "Every habit's card under All")
        shot("g10-progress-all")

        tapChip("Mind")
        XCTAssertTrue(app.buttons["progress-row-Read"].waitForExistence(timeout: 3))
        XCTAssertFalse(app.buttons["progress-row-Water"].exists, "Only Mind's habits")
        shot("g11-progress-mind")

        tapChip("Health")
        XCTAssertTrue(chip("Health").isSelected)
        XCTAssertTrue(app.buttons["progress-row-Water"].waitForExistence(timeout: 3))
        XCTAssertFalse(app.buttons["progress-row-Read"].exists)
        tapChip("all")

        // Habits, by group.
        app.navigationBars["Progress"].buttons.element(boundBy: 0).tap()
        app.buttons["menu-button"].tap()
        app.buttons["menu-habits"].tap()
        XCTAssertTrue(app.navigationBars["Habits"].waitForExistence(timeout: 5))
        XCTAssertTrue(text("Health").exists)
        app.reveal(text("No Group"))
        XCTAssertTrue(text("No Group").exists, "Habits with no group get their own section")
        shot("g12-habits-by-group")
    }
}
