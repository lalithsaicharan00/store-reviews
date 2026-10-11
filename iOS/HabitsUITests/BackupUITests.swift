import XCTest

/// ≡ → iCloud & Backup: the backup files, the spreadsheet, restoring, importing and erasing (Architecture 03, 11 §13.3,
/// §17). Sync's own states are `ICloudUITests`. A test launch has no iCloud of the person's (D8): `-test-icloud` stands
/// in for the iCloud Drive backup files, `-test-cloud` for sync.
final class BackupUITests: XCTestCase {
    override func record(_ issue: XCTIssue) {
        let shot = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        shot.name = "FAIL-\(name)"
        shot.lifetime = .keepAlways
        var issue = issue
        issue.add(shot)
        super.record(issue)
    }

    override func setUp() { continueAfterFailure = false }

    func testBackupIntegrityChecks() {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest", "-backupcheck"]
        app.launch()
        let result = app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH %@", "Backup")).firstMatch
        XCTAssertTrue(result.waitForExistence(timeout: 180), "The backup checks did not finish")
        XCTAssertEqual(result.label, "Backup: all checks passed")
    }

    /// The page from Today's empty state: sync's status first, then backups, export and import, then deleting; no
    /// account anywhere, no "our server" (Architecture 11 §17).
    func testTheICloudPageFromAnEmptyToday() {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest", "-free", "-empty"]
        app.launch()
        let restore = app.buttons["empty-restore-backup"]
        XCTAssertTrue(restore.waitForExistence(timeout: 10))
        restore.tap()
        XCTAssertTrue(app.navigationBars["iCloud & Backup"].waitForExistence(timeout: 5), labels(app))
        XCTAssertTrue(shows(app, row: "cloud-status", "iCloud is off"), status(app, "cloud-status"))
        for id in ["backup-export-csv", "backup-save", "backup-import", "backup-restore"] {
            XCTAssertTrue(app.buttons[id].exists, id)
        }
        XCTAssertTrue(shows(app, row: "backup-status", "only on this iPhone"), status(app))
        for header in ["Backups", "Export and Import"] {
            XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label ==[c] %@", header)).firstMatch.exists, header)
        }
        // No account rows ("Sign in to iCloud in Settings" is iCloud's own and stays).
        for gone in ["Your Account", "Sign In", "Create Account"] {
            XCTAssertFalse(app.descendants(matching: .any).matching(NSPredicate(format: "label ==[c] %@", gone)).firstMatch.exists, gone)
        }
        for gone in ["Move to Another Device", "our server"] {
            XCTAssertFalse(app.staticTexts.matching(NSPredicate(format: "label CONTAINS[c] %@", gone)).firstMatch.exists, gone)
        }
        XCTAssertFalse(app.buttons["cloud-delete"].exists, "Nothing to delete from iCloud while iCloud is off")
        let shot = XCTAttachment(screenshot: app.screenshot())
        shot.name = "icloud-page-off"; shot.lifetime = .keepAlways; add(shot)
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
        // The remote share container appears before its buttons. Wait for Close instead of
        // swiping the container while its content is still arriving.
        let close = app.buttons["header.closeButton"]
        let sheet = app.otherElements["ActivityListView"]
        /// The system's share sheet can ignore a ✕ tapped while its content is still arriving (run 38039875406: the
        /// sheet stayed open): tap it again if the sheet is still there.
        func closeSheet(_ what: String) {
            XCTAssertTrue(close.waitForExistence(timeout: 15), "\(what): the share sheet's ✕")
            close.tap()
            if !sheet.waitForNonExistence(timeout: 4), close.exists { close.tap() }
            XCTAssertTrue(sheet.waitForNonExistence(timeout: 10), "\(what): the share sheet closes")
        }
        closeSheet("Export a Spreadsheet")
        let ready = XCTNSPredicateExpectation(predicate: NSPredicate(format: "hittable == true"), object: app.buttons["backup-save"])
        XCTAssertEqual(XCTWaiter.wait(for: [ready], timeout: 10), .completed, app.debugDescription)
        app.buttons["backup-save"].tap()
        closeSheet("Save a Backup File")
    }

    /// "Erase All My Data" leaves the app as on first launch.
    func testErasingEverything() throws {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest"]
        app.launch()
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 10))
        XCTAssertFalse(app.staticTexts["No habits yet"].exists, "The demo habits are there to start with")
        openBackup(app)
        let erase = app.buttons["backup-erase"]
        for _ in 0..<5 where !erase.isHittable { app.swipeUp() }
        erase.tap()
        let confirm = app.buttons["Erase Everything"]
        XCTAssertTrue(confirm.waitForExistence(timeout: 5), "It asks first, and offers an export")
        XCTAssertTrue(app.buttons["Save a Backup File First"].exists)
        confirm.tap()
        XCTAssertTrue(app.alerts["Erased"].waitForExistence(timeout: 10))
        app.alerts["Erased"].buttons.firstMatch.tap()
        app.navigationBars["iCloud & Backup"].buttons.firstMatch.tap()
        XCTAssertTrue(app.staticTexts["No habits yet"].waitForExistence(timeout: 10), "Everything on this iPhone is gone")
    }

    /// Restore From a Backup lists iCloud's dated copies and a backup file (screen 6), never an account.
    func testRestoreListsICloudAndAFile() throws {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest", "-empty"]
        app.launch()
        XCTAssertTrue(app.staticTexts["No habits yet"].waitForExistence(timeout: 10))
        app.buttons["empty-restore-backup"].tap()
        XCTAssertTrue(app.navigationBars["iCloud & Backup"].waitForExistence(timeout: 5))
        app.revealAndTap(app.buttons["backup-restore"])
        XCTAssertTrue(app.navigationBars["Restore From a Backup"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["Where is your backup stored?"].exists, labels(app))
        XCTAssertTrue(app.buttons["restore-icloud"].exists && app.buttons["restore-import"].exists, labels(app))
        XCTAssertTrue(shows(app, row: "restore-icloud", "Any day of the last week, month or six months"), labels(app))
        XCTAssertFalse(app.buttons["restore-account"].exists, "No account row")
        XCTAssertFalse(app.buttons["restore-google-drive"].exists, "No Google Drive row until it truly works")
        XCTAssertTrue(app.staticTexts["Restoring replaces the habits on this iPhone. You can undo it for 30 days."].exists, labels(app))
        let shot = XCTAttachment(screenshot: app.screenshot()); shot.name = "restore-places"; shot.lifetime = .keepAlways; add(shot)
        app.buttons["restore-icloud"].tap()
        XCTAssertTrue(app.navigationBars["iCloud"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label CONTAINS 'iCloud'")).firstMatch.waitForExistence(timeout: 70), labels(app))
    }

    /// A backup file opened here: Replace says this iPhone only, and runs without asking again (its undo
    /// is kept for 30 days).
    func testRestoreSaysThisIPhone() {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest", "-test-restore-preview"]
        app.launch()
        let replace = app.buttons["restore-replace"]
        XCTAssertTrue(replace.waitForExistence(timeout: 20), labels(app))
        XCTAssertTrue(replace.label.contains("Replace What's on This Device"), replace.label)
        XCTAssertFalse(app.staticTexts.matching(NSPredicate(format: "label CONTAINS 'on all your devices'")).firstMatch.exists)
        replace.tap()
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH 'Restored.'")).firstMatch.waitForExistence(timeout: 15), labels(app))
        app.buttons["Done"].firstMatch.tap()
        openBackup(app)
        XCTAssertTrue(app.buttons["backup-undo"].waitForExistence(timeout: 5), "Undo Last Restore, for 30 days")
    }

    /// The backup files in iCloud Drive, as iCloud & Backup says them, in iCloud's own states: working (when), full (red,
    /// Manage Storage), off (Open Settings) (Current Work 58.12). The simulator has no iCloud Drive, so `-test-icloud`
    /// stands in for it (test launches only, D8).
    func testBackupFilesInICloud() {
        let app = XCUIApplication()
        func open(_ state: String) {
            app.terminate()
            app.launchArguments = ["-uitest", "-test-icloud", state]
            app.launch()
            openBackup(app)
        }
        func shot(_ name: String) {
            let attachment = XCTAttachment(screenshot: app.screenshot()); attachment.name = name; attachment.lifetime = .keepAlways; add(attachment)
        }
        open("ok")
        XCTAssertTrue(shows(app, row: "backup-status", "Backed up"), status(app))
        XCTAssertTrue(shows(app, row: "backup-status", "iCloud"), status(app))
        XCTAssertTrue(app.buttons["backup-now"].exists, "Back Up Now, to iCloud")
        shot("backup-icloud-ok")

        open("full")
        XCTAssertTrue(shows(app, row: "backup-status", "your iCloud is full"), status(app))
        XCTAssertTrue(app.buttons["backup-fix"].label.contains("Manage Storage"), app.buttons["backup-fix"].label)
        shot("backup-icloud-full")

        open("signedOut")
        XCTAssertTrue(shows(app, row: "backup-status", "isn't signed in to iCloud"), status(app))
        XCTAssertTrue(app.buttons["backup-fix"].label.contains("Open Settings"))
        XCTAssertFalse(app.buttons["backup-now"].exists, "No Back Up Now while iCloud is off: the fix is the one thing to tap")
        shot("backup-icloud-signed-out")

        open("offForApp")
        XCTAssertTrue(shows(app, row: "backup-status", "turned off for Often Enough"), status(app))
        XCTAssertTrue(app.buttons["backup-fix"].label.contains("Open Settings"))
    }

    // MARK: Helpers

    /// Polls `condition` until it holds or `seconds` pass.
    private func waitUntil(_ seconds: TimeInterval, _ condition: () -> Bool) -> Bool {
        let deadline = Date().addingTimeInterval(seconds)
        repeat {
            if condition() { return true }
            Thread.sleep(forTimeInterval: 0.25)
        } while Date() < deadline
        return condition()
    }

    /// What's on screen, on one line (T14).
    private func labels(_ app: XCUIApplication) -> String {
        app.descendants(matching: .any).allElementsBoundByIndex.prefix(60).map(\.label).filter { !$0.isEmpty }.joined(separator: " | ")
    }

    /// The status row's words, for a failure message (T14).
    private func status(_ app: XCUIApplication, _ id: String = "backup-status") -> String {
        let row = app.descendants(matching: .any)[id]
        return row.exists ? "status: \(row.label)" : "no status row"
    }

    /// ≡ → iCloud & Backup.
    private func openBackup(_ app: XCUIApplication) {
        let menuButton = app.buttons["menu-button"], row = app.buttons["menu-backup"]
        XCTAssertTrue(menuButton.waitForExistence(timeout: 10))
        XCTAssertTrue(waitUntil(5) { menuButton.isHittable }, "≡ on Today: \(labels(app))")
        menuButton.tap()
        XCTAssertTrue(row.waitForExistence(timeout: 5))
        XCTAssertTrue(waitUntil(5) { row.isHittable }, "The menu open: \(labels(app))")
        row.tap()
        XCTAssertTrue(app.navigationBars["iCloud & Backup"].waitForExistence(timeout: 5), labels(app))
    }

    /// A Form row made of a title and a value (`LabeledContent`) is one element: its value holds the text.
    private func shows(_ app: XCUIApplication, row identifier: String, _ text: String, within seconds: TimeInterval = 3) -> Bool {
        let row = app.descendants(matching: .any)[identifier]
        let deadline = Date().addingTimeInterval(seconds)
        repeat {
            if row.exists, row.label.contains(text) || (row.value as? String)?.contains(text) == true { return true }
            Thread.sleep(forTimeInterval: 0.5)
        } while Date() < deadline
        return false
    }
}
