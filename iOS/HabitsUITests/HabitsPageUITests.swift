import XCTest

/// Habits & Tasks › Habits and Archived Habits (Figma's Habits page 986:150825 and Archived habits page 988:7736,
/// built 17 Nov 2026): routine headings with Edit, a card per habit, the view and period in the bottom bar, Archived at
/// the end; an archived habit's ⋯ restores it with a banner whose Undo archives it again.
final class HabitsPageUITests: XCTestCase {
    private let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launchArguments = ["-uitest", "-open-place", "habitsAndTasks"]
        app.launch()
        XCTAssertTrue(app.habitsPage.waitForExistence(timeout: 15), "Habits & Tasks opens")
    }

    private func shot(_ name: String) {
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    func testHabitsPage() {
        XCTAssertTrue(app.habitCard("Stretch").waitForExistence(timeout: 5), "A card per habit")
        XCTAssertTrue(app.buttons["habits-edit-Morning"].exists, "A routine's heading has Edit")
        XCTAssertTrue(app.buttons["progress-range"].exists, "The view in the bottom bar")
        XCTAssertTrue(app.buttons["progress-period"].exists, "The period in the bottom bar")
        XCTAssertFalse(app.buttons["habits-back-to-now"].exists, "No Back to This Week on this week")
        shot("habits-01-week")
        // Another week: Back to This Week floats above the bar and brings it back.
        app.buttons["progress-previous"].tap()
        let back = app.buttons["habits-back-to-now"]
        XCTAssertTrue(back.waitForExistence(timeout: 3), "Back to This Week on another week")
        shot("habits-02-another-week")
        back.tap()
        XCTAssertTrue(back.waitForNonExistence(timeout: 3))
        // Edit opens Edit Routine.
        app.buttons["habits-edit-Morning"].tap()
        XCTAssertTrue(app.textFields["section-name-field"].waitForExistence(timeout: 5), "Edit Routine opens")
    }

    func testArchiveRestoreAndUndo() {
        // Archive Stretch from its card's ⋯.
        let more = app.buttons["progress-more-Stretch"]
        XCTAssertTrue(more.waitForExistence(timeout: 5))
        more.tap()
        app.buttons["Archive"].tap()
        XCTAssertTrue(app.habitCard("Stretch").waitForNonExistence(timeout: 5), "Archived: off the page")
        // Archived, at the end of the page.
        app.revealAndTap(app.buttons["habits-archived"])
        XCTAssertTrue(app.navigationBars["Archived Habits"].waitForExistence(timeout: 5))
        let row = app.buttons["archived-Stretch"]
        XCTAssertTrue(row.waitForExistence(timeout: 5), "Stretch is archived")
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH 'Archived '")).firstMatch.exists,
                      "Its row says when it was archived")
        shot("archived-01-list")
        // ⋯ › Restore: the banner says so, and Undo puts it back.
        app.buttons["archived-more-Stretch"].tap()
        XCTAssertTrue(app.buttons["Delete"].waitForExistence(timeout: 3), "Delete beside Restore")
        app.buttons["Restore"].tap()
        XCTAssertTrue(row.waitForNonExistence(timeout: 3), "Restored: off the list")
        XCTAssertTrue(app.staticTexts["No Archived Habits"].waitForExistence(timeout: 3), "Nothing archived")
        let undo = app.buttons["archived-undo"]
        XCTAssertTrue(undo.exists, "Stretch restored · Undo")
        shot("archived-02-restored")
        undo.tap()
        XCTAssertTrue(row.waitForExistence(timeout: 3), "Undo archives it again")
        // Delete asks first, with Cancel and Delete only (D9); Cancel keeps it.
        app.buttons["archived-more-Stretch"].tap()
        app.buttons["Delete"].tap()
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.waitForExistence(timeout: 3))
        XCTAssertEqual(alert.buttons.count, 2, "Cancel and Delete only")
        alert.buttons["Cancel"].tap()
        XCTAssertTrue(row.exists, "Cancel keeps it")
    }

    /// Search (Figma's Search page 991:8050): the field is active from the start; habits first under a count, a row
    /// opens its page; no match offers Add “yoga”, which opens Create New with the name filled in.
    func testSearch() {
        app.buttons["habits-search"].tap()
        let field = app.searchFields.firstMatch
        XCTAssertTrue(field.waitForExistence(timeout: 5), "The search field")
        field.typeText("wa")
        let water = app.buttons["search-Water"]
        XCTAssertTrue(water.waitForExistence(timeout: 3), "Water matches")
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label ENDSWITH ' habits' OR label ENDSWITH ' habit'")).firstMatch.exists,
                      "A count over the habits")
        shot("search-01-results")
        water.tap()
        XCTAssertTrue(app.navigationBars["Water"].waitForExistence(timeout: 5), "Its page opens")
        app.navigationBars["Water"].buttons.element(boundBy: 0).tap()
        XCTAssertTrue(water.waitForExistence(timeout: 5), "Back on the results")
        field.tap()
        field.typeText(XCUIKeyboardKey.delete.rawValue + XCUIKeyboardKey.delete.rawValue + "yoga")
        let add = app.buttons["search-add"]
        XCTAssertTrue(add.waitForExistence(timeout: 3), "No match: Add “yoga”")
        XCTAssertTrue(app.staticTexts["No Results for “yoga”"].exists)
        shot("search-02-no-match")
        add.tap()
        app.staticTexts["Build or maintain"].tap()
        app.staticTexts["Check it off"].tap()
        XCTAssertTrue(app.textFields["yoga"].waitForExistence(timeout: 5) || app.staticTexts["yoga"].waitForExistence(timeout: 1),
                      "The name is filled in")
    }
}
