import XCTest

/// Habits & Tasks › Tasks (Figma's Tasks page 999:1061, Completed tasks page 1002:230 and Archived tasks page 1001:178,
/// built 17 Nov 2026): One-time by when, Repeating by how often, a More button per row, Completed and Archived at the
/// end. Tasks are done on Today, never here (U38).
final class TasksUITests: XCTestCase {
    override func setUp() { continueAfterFailure = false }

    private func openTasks(_ app: XCUIApplication) {
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 10))
        app.buttons["menu-button"].tap(); app.openTasksFromMenu()
        XCTAssertTrue(app.tasksPage.waitForExistence(timeout: 5), "Habits & Tasks › Tasks opens")
    }

    private func row(_ app: XCUIApplication, _ name: String) -> XCUIElement {
        app.buttons["task-" + name]
    }

    private func back(_ app: XCUIApplication) {
        app.navigationBars.firstMatch.buttons.element(boundBy: 0).tap()
    }

    private func shot(_ app: XCUIApplication, _ name: String) {
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    func testTaskModelAndPersistence() {
        let app = XCUIApplication(); app.launchArguments = ["-uitest", "-taskcheck"]
        app.launch()
        XCTAssertTrue(app.staticTexts["Tasks: all checks passed"].waitForExistence(timeout: 30), app.debugDescription)
    }

    /// Every kind of task is reachable without knowing its day (U38): one-time on One-time, repeating on Repeating,
    /// done on Completed, archived on Archived; each opens its page and Edit Task, which changes nothing by opening.
    func testEveryTaskAppearsAndCanOpenEdit() {
        let app = XCUIApplication(); app.launchArguments = ["-uitest", "-free", "-task-fixture"]
        app.launch(); openTasks(app)
        func check(_ name: String, _ element: XCUIElement) {
            app.revealAndTap(element)
            XCTAssertTrue(app.navigationBars[name].waitForExistence(timeout: 5), "\(name) opens")
            app.buttons["habit-menu"].tap(); app.buttons["Edit Task"].tap()
            XCTAssertTrue(app.navigationBars["Edit Task"].waitForExistence(timeout: 5))
            XCTAssertFalse(app.buttons["add-habit"].isEnabled, "Opening \(name) must not change its date or other fields")
            app.buttons["Cancel"].firstMatch.tap()
            XCTAssertTrue(app.navigationBars[name].waitForExistence(timeout: 5))
            back(app)
        }
        for name in ["Old task", "Future task"] {
            check(name, row(app, name))
            XCTAssertTrue(app.tasksPage.waitForExistence(timeout: 5))
        }
        // Done three days ago: on Completed.
        app.revealAndTap(app.buttons["tasks-completed"])
        XCTAssertTrue(app.navigationBars["Completed Tasks"].waitForExistence(timeout: 5))
        check("Completed task", app.buttons["completed-Completed task"])
        back(app)
        XCTAssertTrue(app.tasksPage.waitForExistence(timeout: 5))
        // Archived: on Archived.
        app.revealAndTap(app.buttons["tasks-archived"])
        XCTAssertTrue(app.navigationBars["Archived Tasks"].waitForExistence(timeout: 5))
        check("Archived task", app.buttons["archived-Archived task"])
        back(app)
        XCTAssertTrue(app.tasksPage.waitForExistence(timeout: 5))
        // Repeating: on Repeating.
        app.tasksPage.buttons["Repeating"].tap()
        check("Repeating task", row(app, "Repeating task"))
        shot(app, "tasks-all-types")
    }

    func testCreateTaskFromTasksAndEditSurvivesRelaunch() {
        let app = XCUIApplication()
        app.launchArguments = ["-dbname", "uitest-tasks", "-reset-db", "-empty", "-free"]
        app.launch(); openTasks(app)
        XCTAssertTrue(app.staticTexts["No Tasks Yet"].exists, "Nothing yet: No Tasks Yet")
        app.buttons["habits-add"].tap()
        let field = app.descendants(matching: .any)["name-field"]
        XCTAssertTrue(field.waitForExistence(timeout: 5)); field.tap(); field.typeText("Book appointment\n")
        app.buttons["add-habit"].tap()
        let task = row(app, "Book appointment")
        XCTAssertTrue(task.waitForExistence(timeout: 5)); task.tap(); app.buttons["habit-menu"].tap(); app.buttons["Edit Task"].tap()
        XCTAssertTrue(app.navigationBars["Edit Task"].waitForExistence(timeout: 5))
        field.tap(); field.typeText(" Edited\n")
        let savedName = (field.value as! String).trimmingCharacters(in: .whitespacesAndNewlines)
        XCTAssertTrue(savedName.contains("Edited"))
        app.buttons["add-habit"].tap()
        XCTAssertTrue(app.navigationBars["Edit Task"].waitForNonExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts[savedName].firstMatch.waitForExistence(timeout: 5), app.debugDescription)
        app.terminate(); app.launchArguments.removeAll { $0 == "-reset-db" }; app.launch(); openTasks(app)
        XCTAssertTrue(row(app, savedName).waitForExistence(timeout: 5), "Edited task survives relaunch")
    }

    /// The page itself (Figma's One-time, Repeating, Menu open, Moved to Today and Completed states).
    func testTasksPage() {
        let app = XCUIApplication(); app.launchArguments = ["-uitest", "-tasks-page-fixture", "-open-place", "habitsAndTasks"]
        app.launch()
        let tasks = app.segmentedControls["habits-tasks-picker"].buttons["Tasks"]
        XCTAssertTrue(tasks.waitForExistence(timeout: 15)); tasks.tap()
        XCTAssertTrue(app.tasksPage.waitForExistence(timeout: 5))
        // One-time, by when: a task carried from an earlier day is on Today and says when it was planned.
        XCTAssertTrue(row(app, "Call the dentist").waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["Today"].exists && app.staticTexts["Tomorrow"].exists, "Today and Tomorrow")
        XCTAssertTrue(row(app, "Call the dentist").label.contains("Planned for "), "Carried: \(row(app, "Call the dentist").label)")
        XCTAssertTrue(row(app, "Book flights").label.contains("Done "), "A task done today stays at the end of Today")
        XCTAssertFalse(row(app, "Send the parcel").exists, "Done yesterday: on Completed, not here")
        XCTAssertFalse(row(app, "Feed the fish").exists, "Repeating tasks aren't on One-time")
        shot(app, "tasks-01-one-time")
        // ⋯ › Do Today: on Today, with a banner whose Show goes to Today.
        app.buttons["task-more-Clean the fridge"].tap()
        XCTAssertTrue(app.buttons["Pick a Day…"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.buttons["Duplicate"].exists && app.buttons["Archive"].exists && app.buttons["Delete"].exists)
        app.buttons["Do Today"].tap()
        let show = app.buttons["tasks-banner-show"]
        XCTAssertTrue(show.waitForExistence(timeout: 3), "Clean the fridge is on Today · Show")
        XCTAssertFalse(app.staticTexts["Tomorrow"].exists, "Nothing left on Tomorrow")
        shot(app, "tasks-02-moved-to-today")
        // Delete asks first, with Cancel and Delete only (D9); Cancel keeps it.
        app.buttons["task-more-Renew passport"].tap()
        app.buttons["Delete"].tap()
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.waitForExistence(timeout: 3))
        XCTAssertEqual(alert.buttons.count, 2, "Cancel and Delete only")
        alert.buttons["Cancel"].tap()
        XCTAssertTrue(row(app, "Renew passport").exists, "Cancel keeps it")
        // Repeating, by how often.
        app.tasksPage.buttons["Repeating"].tap()
        XCTAssertTrue(row(app, "Feed the fish").waitForExistence(timeout: 3))
        XCTAssertTrue(app.staticTexts["Every day"].exists && app.staticTexts["Every few days"].exists
                      && app.staticTexts["Every week"].exists && app.staticTexts["Every month"].exists, "Grouped by how often")
        XCTAssertTrue(row(app, "Feed the fish").label.contains("Done today"), row(app, "Feed the fish").label)
        XCTAssertFalse(row(app, "Call the dentist").exists, "One-time tasks aren't on Repeating")
        shot(app, "tasks-03-repeating")
        // Completed: Mark as Not Done puts it back on its list, and Undo takes that back.
        app.tasksPage.buttons["One-time"].tap()
        app.revealAndTap(app.buttons["tasks-completed"])
        XCTAssertTrue(app.navigationBars["Completed Tasks"].waitForExistence(timeout: 5))
        let parcel = app.buttons["completed-Send the parcel"]
        XCTAssertTrue(parcel.waitForExistence(timeout: 3))
        shot(app, "tasks-04-completed")
        app.buttons["completed-more-Send the parcel"].tap()
        app.buttons["Mark as Not Done"].tap()
        XCTAssertTrue(app.staticTexts["Nothing Completed Yet"].waitForExistence(timeout: 3), "Open again: off Completed")
        let undo = app.buttons["completed-undo"]
        XCTAssertTrue(undo.exists, "Send the parcel is open again · Undo")
        undo.tap()
        XCTAssertTrue(parcel.waitForExistence(timeout: 3), "Undo: done again")
    }
}
