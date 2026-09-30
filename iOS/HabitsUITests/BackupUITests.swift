import XCTest

final class BackupUITests: XCTestCase {
    override func setUp() { continueAfterFailure = false }

    func testBackupIntegrityChecks() {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest", "-backupcheck"]
        app.launch()
        XCTAssertTrue(app.staticTexts["Backup: all checks passed"].waitForExistence(timeout: 30), app.debugDescription)
    }

    func testFreeBackupPageAndReinstallWarning() {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest", "-free", "-empty"]
        app.launch()
        let restore = app.buttons["empty-restore-backup"]
        XCTAssertTrue(restore.waitForExistence(timeout: 10))
        restore.tap()
        XCTAssertTrue(app.navigationBars["Backup & Export"].waitForExistence(timeout: 5))
        for id in ["backup-export-csv", "backup-save", "backup-restore"] {
            XCTAssertTrue(app.buttons[id].exists, id)
        }
        let warning = app.staticTexts["Deleting Habits removes its data and recovery copies from this iPhone. Reinstalling alone does not bring them back."]
        app.reveal(warning)
        XCTAssertTrue(warning.exists)
        let shot = XCTAttachment(screenshot: app.screenshot())
        shot.name = "backup-free-page"; shot.lifetime = .keepAlways; add(shot)
    }

    func testExportAndBackupOpenNativeShareSheet() {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest", "-free"]
        app.launch()
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 10))
        app.buttons["menu-button"].tap()
        app.buttons["menu-backup"].tap()
        XCTAssertTrue(app.buttons["backup-export-csv"].waitForExistence(timeout: 5))
        app.buttons["backup-export-csv"].tap()
        XCTAssertTrue(app.otherElements["ActivityListView"].waitForExistence(timeout: 10)
            || app.buttons["Copy"].exists || app.buttons["Close"].exists, app.debugDescription)
        if app.buttons["Close"].exists { app.buttons["Close"].tap() }
        else { app.swipeDown() }
        let ready = XCTNSPredicateExpectation(predicate: NSPredicate(format: "hittable == true"), object: app.buttons["backup-save"])
        XCTAssertEqual(XCTWaiter.wait(for: [ready], timeout: 10), .completed, app.debugDescription)
        app.buttons["backup-save"].tap()
        XCTAssertTrue(app.buttons["Close"].waitForExistence(timeout: 10) || app.otherElements["ActivityListView"].exists,
                      app.debugDescription)
    }
}
