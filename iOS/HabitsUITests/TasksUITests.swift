import XCTest

final class TasksUITests: XCTestCase {
    override func setUp() { continueAfterFailure = false }
    private func openTasks(_ app: XCUIApplication) {
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 10))
        app.buttons["menu-button"].tap(); app.buttons["menu-tasks"].tap()
        XCTAssertTrue(app.navigationBars["Tasks"].waitForExistence(timeout: 5))
    }
    private func row(_ app: XCUIApplication, _ name: String) -> XCUIElement {
        app.buttons.matching(NSPredicate(format: "label BEGINSWITH %@", name)).firstMatch
    }
    func testTaskModelAndPersistence() {
        let app = XCUIApplication(); app.launchArguments = ["-uitest", "-taskcheck"]
        app.launch()
        XCTAssertTrue(app.staticTexts["Tasks: all checks passed"].waitForExistence(timeout: 30), app.debugDescription)
    }
    func testEveryTaskAppearsAndCanOpenEdit() {
        let app = XCUIApplication(); app.launchArguments = ["-uitest", "-free", "-task-fixture"]
        app.launch(); openTasks(app)
        for name in ["Old task", "Future task", "Completed task", "Repeating task", "Archived task"] {
            app.revealAndTap(row(app, name))
            XCTAssertTrue(app.navigationBars[name].waitForExistence(timeout: 5))
            app.buttons["Edit"].tap()
            XCTAssertTrue(app.navigationBars["Edit Task"].waitForExistence(timeout: 5))
            XCTAssertFalse(app.buttons["add-habit"].isEnabled, "Opening \(name) must not change its date or other fields")
            app.buttons["Cancel"].firstMatch.tap()
            let bar = app.navigationBars.firstMatch
            if bar.buttons["BackButton"].exists { bar.buttons["BackButton"].tap() }
            else if bar.buttons["Tasks"].exists { bar.buttons["Tasks"].tap() }
            else { app.coordinate(withNormalizedOffset: CGVector(dx: 0.01, dy: 0.5)).press(forDuration: 0.05, thenDragTo: app.coordinate(withNormalizedOffset: CGVector(dx: 0.9, dy: 0.5))) }
            XCTAssertTrue(app.navigationBars["Tasks"].waitForExistence(timeout: 5))
        }
        let shot = XCTAttachment(screenshot: app.screenshot()); shot.name = "tasks-all-types"; shot.lifetime = .keepAlways; add(shot)
    }
    func testCreateTaskFromTasksAndEditSurvivesRelaunch() {
        let app = XCUIApplication()
        app.launchArguments = ["-dbname", "uitest-tasks", "-reset-db", "-empty", "-free"]
        app.launch(); openTasks(app)
        app.buttons["tasks-add"].tap()
        let field = app.descendants(matching: .any)["name-field"]
        XCTAssertTrue(field.waitForExistence(timeout: 5)); field.tap(); field.typeText("Book appointment\n")
        app.buttons["add-habit"].tap()
        let task = row(app, "Book appointment")
        XCTAssertTrue(task.waitForExistence(timeout: 5)); task.tap(); app.buttons["Edit"].tap()
        XCTAssertTrue(app.navigationBars["Edit Task"].waitForExistence(timeout: 5))
        field.tap(); field.typeText(" Edited\n")
        let savedName = field.value as! String
        XCTAssertTrue(savedName.contains("Edited"))
        app.buttons["add-habit"].tap()
        XCTAssertTrue(app.navigationBars[savedName].waitForExistence(timeout: 5))
        app.terminate(); app.launchArguments.removeAll { $0 == "-reset-db" }; app.launch(); openTasks(app)
        XCTAssertTrue(row(app, savedName).waitForExistence(timeout: 5), "Edited task survives relaunch")
    }
}
