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

    /// Habits & Tasks, on its Tasks side.
    func openTasksFromMenu() {
        buttons["menu-habitsAndTasks"].tap()
        let tasks = segmentedControls["habits-tasks-picker"].buttons["Tasks"]
        if tasks.waitForExistence(timeout: 5) { tasks.tap() }
    }
}
