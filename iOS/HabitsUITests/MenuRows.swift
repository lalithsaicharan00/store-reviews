import XCTest

/// The ☰ menu (Figma's Side menu, 17 Nov 2026) lists Today, Habits & Tasks, Plus, Settings, Contact Us and Send
/// Feedback; every other page is a row on Settings. `menuRow` gives a page's row, opening Settings on the way when the
/// menu is open at its top, so a test reads "open the menu, tap Privacy" as before.
extension XCUIApplication {
    func menuRow(_ place: String) -> XCUIElement {
        let row = buttons["menu-" + place]
        if row.exists { return row }
        let settings = buttons["menu-settings"]
        if settings.waitForExistence(timeout: 3) {
            settings.tap()
            _ = row.waitForExistence(timeout: 5)
        }
        return row
    }

    /// Habits & Tasks (Figma 986:150825, 17 Nov 2026): it has no title, so its Habits | Tasks control says it's open.
    var habitsPage: XCUIElement { segmentedControls["habits-tasks-picker"] }

    /// A habit's card on Habits & Tasks › Habits (a quit habit's card has its own id).
    func habitCard(_ name: String) -> XCUIElement {
        buttons.matching(NSPredicate(format: "identifier IN %@", ["progress-row-" + name, "progress-quit-" + name])).firstMatch
    }

    /// ☰ › Habits & Tasks, on Habits.
    func openHabitsFromMenu() {
        buttons["menu-habitsAndTasks"].tap()
        XCTAssertTrue(habitsPage.waitForExistence(timeout: 5), "Habits & Tasks opens")
    }

    /// Habits & Tasks › Tasks (Figma 999:1061): its One-time | Repeating control in the bottom bar says it's open.
    var tasksPage: XCUIElement { segmentedControls["tasks-plan"] }

    /// Habits & Tasks, on its Tasks side.
    func openTasksFromMenu() {
        buttons["menu-habitsAndTasks"].tap()
        let tasks = segmentedControls["habits-tasks-picker"].buttons["Tasks"]
        if tasks.waitForExistence(timeout: 5) { tasks.tap() }
        _ = tasksPage.waitForExistence(timeout: 5)
    }
}
