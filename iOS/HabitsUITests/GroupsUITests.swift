import XCTest

/// Groups (Build Plan #68; `Docs/Specs/Groups — What to Build.md`): made from Today's Filter, filtering Today, edited in
/// one place, picked in the habit form, and counted on Progress. `-groups-demo` adds Health, Mind, Home and an empty
/// Reading to the demo habits.
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
        XCTAssertTrue(app.buttons["filter-button"].waitForExistence(timeout: 10))
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

    private func openFilter() {
        app.buttons["filter-button"].tap()
        XCTAssertTrue(app.navigationBars["Filter"].waitForExistence(timeout: 3))
    }

    private func closeFilter() {
        app.navigationBars["Filter"].buttons["Done"].tap()
        XCTAssertTrue(app.navigationBars["Filter"].waitForNonExistence(timeout: 3))
    }

    /// The chips scroll sideways: bring one into view first.
    private func tapChip(_ name: String) {
        let element = chip(name)
        XCTAssertTrue(element.waitForExistence(timeout: 3), name)
        for _ in 0..<3 where !element.isHittable { chip("all").swipeLeft() }
        element.tap()
    }

    /// The group form sits in a sheet over Today: scroll the form itself, not Today's list, until the row can be tapped.
    private func tapInForm(_ element: XCUIElement) {
        let form = app.collectionViews["group-form"]
        XCTAssertTrue(form.waitForExistence(timeout: 3))
        for _ in 0..<10 where !(element.exists && element.isHittable) { form.swipeUp(velocity: .slow) }
        element.tap()
    }

    /// Clears a text field and types, with the cursor put at the end first.
    private func retype(_ field: XCUIElement, _ text: String) {
        XCTAssertTrue(field.waitForExistence(timeout: 3))
        field.coordinate(withNormalizedOffset: CGVector(dx: 0.95, dy: 0.5)).tap()
        let old = (field.value as? String) ?? ""
        field.typeText(String(repeating: XCUIKeyboardKey.delete.rawValue, count: old.count + 2) + text)
    }

    /// No groups yet: Filter explains them, + New Group makes one with habits, its chip filters Today (Quitting too),
    /// and the ✕ chip at the top of Today clears it.
    func testFirstGroupFromFilter() {
        launch()
        XCTAssertTrue(text("Water").waitForExistence(timeout: 5))
        XCTAssertTrue(text("Read").exists)
        XCTAssertTrue(text("Smoking").exists)
        XCTAssertFalse(app.buttons["group-filter-chip"].exists, "No filter to begin with")
        openFilter()
        XCTAssertTrue(text("Group habits by area, like Health or Work, then filter by them here.").exists)
        shot("g01-no-groups")

        app.buttons["group-new"].tap()
        XCTAssertTrue(app.navigationBars["New Group"].waitForExistence(timeout: 3))
        let field = app.textFields["group-name-field"]
        XCTAssertTrue(field.waitForExistence(timeout: 3))
        field.tap()
        field.typeText("Health\n")
        // Read isn't done yet today, so Anytime stays open with it (a card with everything done folds).
        tapInForm(app.buttons["group-habit-Read"])
        tapInForm(app.buttons["group-habit-Walk"])
        shot("g02-new-group")
        app.navigationBars["New Group"].buttons["group-save"].tap()

        let health = chip("Health")
        XCTAssertTrue(health.waitForExistence(timeout: 3), "The new group's chip")
        XCTAssertTrue(health.label.hasPrefix("Health, "), health.label)
        XCTAssertTrue(app.buttons["groups-edit"].exists, "Edit sits on the Groups heading once a group exists")
        tapChip("Health")
        XCTAssertTrue(health.isSelected)
        shot("g03-filter")
        closeFilter()

        let active = app.buttons["group-filter-chip"]
        XCTAssertTrue(active.waitForExistence(timeout: 3), "The active filter is obvious")
        XCTAssertEqual(active.label, "Showing Health only")
        XCTAssertTrue(text("Read").exists)
        XCTAssertFalse(text("Water").exists, "Water has no group")
        XCTAssertFalse(text("Smoking").exists, "Quitting shows only the group")
        shot("g04-today-filtered")

        active.tap()
        XCTAssertTrue(active.waitForNonExistence(timeout: 3), "✕ clears the filter")
        XCTAssertTrue(text("Smoking").waitForExistence(timeout: 3), "Quitting is back")
        // Water is done, so it sits at the end of Anytime, below the fold on a small screen.
        app.reveal(text("Water"))
        shot("g04b-today-all")
        XCTAssertTrue(text("Water").exists, "✕ shows everything again")
    }

    /// Chip numbers and the empty group: Mind filters Today; the empty Reading chip is last and opens its editor, where
    /// Read moves over from Mind.
    func testChipsAndEmptyGroup() {
        launch(["-groups-demo"])
        openFilter()
        XCTAssertTrue(chip("all").label.hasPrefix("All, "), chip("all").label)
        let reading = chip("Reading")
        XCTAssertTrue(reading.waitForExistence(timeout: 3))
        XCTAssertEqual(reading.label, "Reading, no habits yet")
        XCTAssertGreaterThan(reading.frame.minX, chip("Mind").frame.minX, "Empty groups go last")
        XCTAssertLessThan(chip("Health").frame.minX, chip("Home").frame.minX, "A to Z")
        tapChip("Mind")
        shot("g05-chips")

        tapChip("Reading")
        XCTAssertTrue(app.navigationBars["Edit Group"].waitForExistence(timeout: 3), "An empty group opens to add habits")
        tapInForm(app.buttons["group-habit-Read"])
        XCTAssertTrue(text("Moves from Mind").exists)
        shot("g06-move-read")
        app.navigationBars["Edit Group"].buttons["group-save"].tap()
        XCTAssertTrue(app.navigationBars["Filter"].waitForExistence(timeout: 3))
        XCTAssertTrue(chip("Reading").label.hasPrefix("Reading, 1 "), chip("Reading").label)
        closeFilter()

        XCTAssertEqual(app.buttons["group-filter-chip"].label, "Showing Mind only")
        XCTAssertFalse(text("Read").exists, "Read moved to Reading")
        XCTAssertFalse(text("Water").exists, "Water is in Health")
    }

    /// One editor: rename, delete, and a filtered group left with nothing shows the way back to All.
    func testEditRenameDeleteAndEmptyDay() {
        launch(["-groups-demo"])
        openFilter()
        tapChip("Home")
        app.buttons["groups-edit"].tap()
        XCTAssertTrue(app.navigationBars["Groups"].waitForExistence(timeout: 3))
        XCTAssertTrue(text("A to Z. Drag a group to put them in your own order.").exists)

        // Rename.
        app.descendants(matching: .any)["groups-row-Mind"].firstMatch.tap()
        XCTAssertTrue(app.navigationBars["Edit Group"].waitForExistence(timeout: 3))
        retype(app.textFields["group-name-field"], "Mind and Body")
        app.navigationBars["Edit Group"].buttons["group-save"].tap()
        XCTAssertTrue(app.descendants(matching: .any)["groups-row-Mind and Body"].firstMatch.waitForExistence(timeout: 3))

        // Delete from a swipe: the empty Reading.
        let reading = app.descendants(matching: .any)["groups-row-Reading"].firstMatch
        reading.swipeLeft()
        app.buttons["Delete"].firstMatch.tap()
        app.buttons["Delete Group"].firstMatch.tap()
        XCTAssertTrue(reading.waitForNonExistence(timeout: 3), "Reading deleted")

        // Home, the filter, loses all its habits.
        app.descendants(matching: .any)["groups-row-Home"].firstMatch.tap()
        XCTAssertTrue(app.navigationBars["Edit Group"].waitForExistence(timeout: 3))
        for name in ["Smoking", "Call family", "Bed by 23:00"] { tapInForm(app.buttons["group-habit-\(name)"]) }
        shot("g07-home-emptied")
        app.navigationBars["Edit Group"].buttons["group-save"].tap()
        XCTAssertTrue(app.navigationBars["Groups"].waitForExistence(timeout: 3))
        app.navigationBars["Groups"].buttons.element(boundBy: 0).tap()
        XCTAssertTrue(app.navigationBars["Filter"].waitForExistence(timeout: 3))
        XCTAssertEqual(chip("Home").label, "Home, no habits yet")
        closeFilter()

        XCTAssertTrue(app.staticTexts["group-empty-day"].waitForExistence(timeout: 3), "Nothing from Home: said, not a blank list")
        shot("g08-empty-day")
        app.buttons["group-show-all"].tap()
        XCTAssertTrue(text("Read").waitForExistence(timeout: 3))
        XCTAssertFalse(app.buttons["group-filter-chip"].exists)
    }

    /// The habit form's Group row: pick a group, or make one from there; a habit added while Today is filtered starts
    /// in that group and shows at once.
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

        openFilter()
        tapChip("Mind")
        closeFilter()
        XCTAssertTrue(text("Journal").waitForExistence(timeout: 3), "Journal is in Mind")

        // Filtered to Mind, + starts in Mind; a group made from the picker is picked.
        app.navigationBars.buttons["New Habit"].firstMatch.tap()
        row("Build or maintain,").tap()
        row("Check it off,").tap()
        XCTAssertTrue(app.navigationBars["New Habit"].waitForExistence(timeout: 3))
        app.descendants(matching: .any)["name-field"].tap()
        app.descendants(matching: .any)["name-field"].typeText("Plan week\n")
        app.reveal(group)
        XCTAssertEqual(group.label, "Group, Mind", "Starts in the group Today shows")
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
        // Added to Work while Today shows Mind: Today shows everything, so it isn't lost.
        XCTAssertTrue(text("Plan week").waitForExistence(timeout: 5))
        XCTAssertFalse(app.buttons["group-filter-chip"].exists)
    }

    /// Progress: a Groups card with a bar per group, habits under their group's heading, and chips that filter it all.
    /// Habits (≡) lists habits by group.
    func testProgressAndHabitsByGroup() {
        launch(["-groups-demo"])
        app.buttons["menu-button"].tap()
        app.buttons["menu-progress"].tap()
        XCTAssertTrue(app.navigationBars["Progress"].waitForExistence(timeout: 5))
        let healthBar = app.buttons["progress-group-Health"]
        XCTAssertTrue(healthBar.waitForExistence(timeout: 5), "A bar per group")
        XCTAssertTrue(app.buttons["progress-group-Mind"].exists)
        XCTAssertFalse(app.buttons["progress-group-Reading"].exists, "An empty group has no bar")
        shot("g10-progress-all")

        tapChip("Mind")
        XCTAssertTrue(app.buttons["progress-row-Read"].waitForExistence(timeout: 3))
        XCTAssertFalse(app.buttons["progress-row-Water"].exists, "Only Mind's habits")
        XCTAssertFalse(healthBar.exists, "No Groups card with one group chosen")
        shot("g11-progress-mind")

        tapChip("all")
        XCTAssertTrue(healthBar.waitForExistence(timeout: 3))
        healthBar.tap()
        XCTAssertTrue(chip("Health").isSelected, "Tapping a bar chooses its group")
        XCTAssertTrue(app.buttons["progress-row-Water"].waitForExistence(timeout: 3))
        XCTAssertFalse(app.buttons["progress-row-Read"].exists)

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
