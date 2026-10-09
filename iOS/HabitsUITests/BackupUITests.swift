import XCTest

/// ≡ → Backup & Export: the free backup file, spreadsheet and restore, and a free account's backup on the real dev
/// server (Backup, Sync and Accounts — One Seamless Experience). The end-to-end test signs in with this GitHub Actions run's identity token as a free account
/// (server: POST /v1/auth/ci with plus: false), so it only runs on GitHub Actions.
final class BackupUITests: XCTestCase {
    private let api = "https://api-dev.oftenenough.com"

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
        for id in ["backup-export-csv", "backup-save", "backup-restore", "backup-move", "backup-account"] {
            XCTAssertTrue(app.buttons[id].exists, id)
        }
        // The status says where the habits are and what deleting the app does, in one line (report "Backup & Export
        // and Your Account", 9 Oct 2026); the groups follow what people come to do; no Sync row and no "our server".
        XCTAssertTrue(shows(app, row: "backup-status", "No backup copy yet"), status(app))
        XCTAssertFalse(app.staticTexts.matching(NSPredicate(format: "label CONTAINS[c] 'Deleting the app'")).firstMatch.exists,
                       "Never \"deleting the app deletes your habits\" (the user, 9 Oct 2026)")
        for header in ["Backed Up To", "Move and Restore", "Export"] {
            XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label ==[c] %@", header)).firstMatch.exists, header)
        }
        XCTAssertFalse(app.staticTexts.matching(NSPredicate(format: "label CONTAINS[c] 'our server'")).firstMatch.exists)
        XCTAssertFalse(app.staticTexts.matching(NSPredicate(format: "label ==[c] 'Sync'")).firstMatch.exists, "No Sync row")
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
        // The remote share container appears before its buttons. Wait for Close instead of
        // swiping the container while its content is still arriving.
        let close = app.buttons["header.closeButton"]
        XCTAssertTrue(close.waitForExistence(timeout: 15), app.debugDescription)
        close.tap()
        XCTAssertTrue(app.otherElements["ActivityListView"].waitForNonExistence(timeout: 10), app.debugDescription)
        let ready = XCTNSPredicateExpectation(predicate: NSPredicate(format: "hittable == true"), object: app.buttons["backup-save"])
        XCTAssertEqual(XCTWaiter.wait(for: [ready], timeout: 10), .completed, app.debugDescription)
        app.buttons["backup-save"].tap()
        XCTAssertTrue(close.waitForExistence(timeout: 15), app.debugDescription)
        close.tap()
        XCTAssertTrue(app.otherElements["ActivityListView"].waitForNonExistence(timeout: 10))
    }

    /// No account: the screen says the habits are only on this iPhone, sync is Plus, and a file can be made.
    func testWithoutAnAccountEverythingStaysOnThePhone() throws {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest"]
        app.launch()
        openBackup(app)
        XCTAssertTrue(shows(app, row: "backup-status", "Only on this iPhone"), status(app))
        XCTAssertFalse(app.buttons["Back Up Now"].exists, "Nowhere to back up to without an account")
        // Account and Backup Redesign, screen 4: the backup place first, the account below it as an option.
        let account = app.buttons["backup-account"]
        XCTAssertTrue(account.label.contains("Your Account") && account.label.contains("Not signed in"), account.label)
        XCTAssertTrue(app.staticTexts["Optional. If you sign in, your habits are backed up to your account instead."].exists, "The account is an option")
        let iCloud = app.buttons["backup-icloud-status"]
        XCTAssertTrue(shows(app, row: "backup-icloud-status", "Off"), "No iCloud here: the iCloud row says Off")
        XCTAssertLessThan(iCloud.frame.minY, account.frame.minY, "iCloud comes before Your Account without an account")
        XCTAssertFalse(app.buttons["backup-google-drive"].exists, "No Google Drive row until it truly works")
        XCTAssertFalse(app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH 'Sync is part of Plus'")).firstMatch.exists,
                       "Backup never looks like a Plus perk")
        app.revealAndTap(app.buttons["backup-save"])
        let shared = app.otherElements["ActivityListView"].waitForExistence(timeout: 10) || app.buttons["Save to Files"].waitForExistence(timeout: 2)
        XCTAssertTrue(shared, "The share sheet opens with the backup file")
    }

    /// Without an account, "Erase All My Data" leaves the app as on first launch.
    func testErasingEverythingWithoutAnAccount() throws {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest"]
        app.launch()
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 10))
        XCTAssertFalse(app.staticTexts["No habits yet"].exists, "The demo habits are there to start with")
        openBackup(app)
        let erase = app.buttons["backup-erase"]
        for _ in 0..<4 where !erase.isHittable { app.swipeUp() }
        erase.tap()
        let confirm = app.buttons["Erase Everything"]
        XCTAssertTrue(confirm.waitForExistence(timeout: 5), "It asks first, and offers an export")
        XCTAssertTrue(app.buttons["Save a Backup File First"].exists)
        confirm.tap()
        XCTAssertTrue(app.alerts["Erased"].waitForExistence(timeout: 10))
        app.alerts["Erased"].buttons.firstMatch.tap()
        app.navigationBars["Backup & Export"].buttons.firstMatch.tap()
        XCTAssertTrue(app.staticTexts["No habits yet"].waitForExistence(timeout: 10), "Everything on this iPhone is gone")
    }

    /// Restore is offered on the empty first screen, and Restore From a Backup without an account lists iCloud and a
    /// backup file (screen 6), never the account.
    func testTheEmptyFirstScreenOffersRestore() throws {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest", "-empty"]
        app.launch()
        XCTAssertTrue(app.staticTexts["No habits yet"].waitForExistence(timeout: 10))
        app.buttons["empty-restore-backup"].tap()
        XCTAssertTrue(app.navigationBars["Backup & Export"].waitForExistence(timeout: 5))
        app.buttons["backup-restore"].tap()
        XCTAssertTrue(app.navigationBars["Restore From a Backup"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["Where is your backup stored?"].exists, labels(app))
        XCTAssertTrue(app.buttons["restore-icloud"].exists && app.buttons["restore-import"].exists, labels(app))
        XCTAssertFalse(app.buttons["restore-account"].exists, "No account row without an account")
        XCTAssertFalse(app.buttons["restore-google-drive"].exists, "No Google Drive row until it truly works")
        XCTAssertTrue(app.staticTexts["Restoring replaces the habits on this iPhone. You can undo it for 30 days."].exists, labels(app))
        let shot = XCTAttachment(screenshot: app.screenshot()); shot.name = "restore-no-account"; shot.lifetime = .keepAlways; add(shot)
        app.buttons["restore-icloud"].tap()
        XCTAssertTrue(app.navigationBars["iCloud"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label CONTAINS 'iCloud'")).firstMatch.waitForExistence(timeout: 70), labels(app))
    }

    /// A free account: the phone backs up to the server, the server holds a checked copy, and Restore lists it.
    func testAFreeAccountBacksUpToTheServer() throws {
        continueAfterFailure = false
        let token = try ciToken()
        let subject = "backup-ui-\(UUID().uuidString)"
        let app = XCUIApplication()
        app.launchArguments = ["-dbname", "uitest-backup", "-reset-db", "-empty", "-ci-sign-in-free", token, subject]
        app.launch()
        XCTAssertTrue(app.staticTexts["No habits yet"].waitForExistence(timeout: 20), "The app opens with no habits")
        app.buttons["New Habit"].firstMatch.tap()
        XCTAssertTrue(app.navigationBars["New"].waitForExistence(timeout: 3))
        app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Build or maintain'")).firstMatch.tap()
        app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Check it off'")).firstMatch.tap()
        let name = app.descendants(matching: .any)["name-field"]
        XCTAssertTrue(name.waitForExistence(timeout: 3))
        name.tap()
        name.typeText("Backed up walk")
        app.navigationBars["New Habit"].buttons["Add"].tap()
        XCTAssertTrue(app.buttons["Mark Backed up walk done"].waitForExistence(timeout: 5))

        openBackup(app)
        XCTAssertTrue(shows(app, row: "backup-status", "Your account", within: 10), "Signed in: the backup goes to the account. \(status(app))")
        // Screen 4b: the account first, and why iCloud isn't used; no iCloud row, no Erase (Delete Account is on Account).
        XCTAssertTrue(shows(app, row: "backup-account", "Free", within: 10), "Your Account · Free")
        XCTAssertTrue(app.staticTexts["Backed up as you go, with the last 7 days kept. iCloud and Google Drive are used only when you're not signed in."].exists, labels(app))
        XCTAssertFalse(app.buttons["backup-icloud-status"].exists, "One backup place at a time: no iCloud row signed in")
        XCTAssertFalse(app.buttons["backup-erase"].exists)
        app.buttons["Back Up Now"].tap()
        let backedUp = app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH 'Backed up'")).firstMatch
        XCTAssertTrue(backedUp.waitForExistence(timeout: 30), "The backup is confirmed by the server's checksum")
        let signedIn = XCTAttachment(screenshot: app.screenshot()); signedIn.name = "backup-signed-in-free"; signedIn.lifetime = .keepAlways; add(signedIn)

        // The server holds the copy, with the habit counted.
        let other = try call("POST", "/v1/auth/ci", ["idToken": token, "subject": subject, "plus": false, "device": device()])
        XCTAssertEqual(other.status, 200, "\(other.json)")
        let access = try XCTUnwrap(other.json["accessToken"] as? String)
        let list = try call("GET", "/v1/backup", nil, token: access)
        let copies = try XCTUnwrap(list.json["copies"] as? [[String: Any]])
        XCTAssertTrue(copies.contains { ($0["habits"] as? Int) == 1 }, "The server's copy has the habit: \(list.json)")

        // A copy uploaded by itself (backed up as you go) is at most 12 an hour; the server took this one (above).
        // Restore lists it under Your Account (screen 6b: any of the last 7 days); restoring it here changes nothing.
        app.buttons["backup-restore"].tap()
        XCTAssertTrue(app.navigationBars["Restore From a Backup"].waitForExistence(timeout: 5))
        XCTAssertFalse(app.buttons["restore-icloud"].exists, "Signed in, the account is the only backup place")
        let account = app.buttons["restore-account"]
        XCTAssertTrue(account.exists && account.label.contains("Any of the last 7 days"), account.label)
        account.tap()
        XCTAssertTrue(app.navigationBars["Your Account"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.descendants(matching: .any).matching(NSPredicate(format: "label CONTAINS[c] '(this device)'")).firstMatch.waitForExistence(timeout: 15), labels(app))
        let copy = app.buttons["restore-account-copy"].firstMatch
        XCTAssertTrue(copy.waitForExistence(timeout: 15))
        let restoreShot = XCTAttachment(screenshot: app.screenshot()); restoreShot.name = "restore-free-account"; restoreShot.lifetime = .keepAlways; add(restoreShot)
        copy.tap()
        XCTAssertTrue(app.staticTexts["Everything in this backup is already here. Nothing needs to change."].waitForExistence(timeout: 15))

        _ = try? call("POST", "/v1/account/delete", [:], token: access)
    }

    /// Deleting the account from the app: the server says so to the account's other devices, and "Erase This iPhone
    /// Too" leaves the app as on first launch.
    func testDeletingTheAccountAndErasingThisPhone() throws {
        continueAfterFailure = false
        let token = try ciToken()
        let subject = "delete-ui-\(UUID().uuidString)"
        let app = XCUIApplication()
        app.launchArguments = ["-dbname", "uitest-delete", "-reset-db", "-skip-device-auth", "-ci-sign-in-free", token, subject]
        app.launch()
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 20))
        openBackup(app)
        let account = app.descendants(matching: .any)["backup-account"]
        XCTAssertTrue(account.waitForExistence(timeout: 20), "Signed in (the app made the account), the account row is there")
        // Another device of the same account, signed in before the deletion.
        let other = try call("POST", "/v1/auth/ci", ["idToken": token, "subject": subject, "plus": false, "device": device()])
        let refresh = try XCTUnwrap(other.json["refreshToken"] as? String, "\(other.json)")
        account.tap()
        XCTAssertTrue(app.navigationBars["Account"].waitForExistence(timeout: 5))
        XCTAssertTrue(shows(app, row: "account-plan", "Free", within: 10), "The plan is on the account page")
        let page = XCTAttachment(screenshot: app.screenshot()); page.name = "account-signed-in-free"; page.lifetime = .keepAlways; add(page)
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label CONTAINS '(this device)'")).firstMatch.waitForExistence(timeout: 10), "This device is listed")
        app.buttons["Delete Account…"].tap()
        XCTAssertTrue(app.navigationBars["Delete Account"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons["Save a Backup File First"].exists, "An export is offered first")
        app.buttons["account-delete-confirm"].tap()
        let erase = app.buttons["Erase This iPhone Too"]
        XCTAssertTrue(erase.waitForExistence(timeout: 10), "It asks about this iPhone's habits")
        erase.tap()
        XCTAssertTrue(app.staticTexts["Your account is deleted."].waitForExistence(timeout: 30))

        let after = try call("POST", "/v1/auth/refresh", ["refreshToken": refresh])
        XCTAssertEqual(after.status, 401)
        XCTAssertEqual(after.json["error"] as? String, "account_deleted", "The other device is told the account is gone")

        app.buttons["Done"].tap()
        XCTAssertTrue(app.buttons["account-sign-in"].waitForExistence(timeout: 10), "The account page is signed out now")
        app.navigationBars["Account"].buttons.firstMatch.tap()
        XCTAssertTrue(app.navigationBars["Backup & Export"].waitForExistence(timeout: 10), "Back on Backup & Export")
        XCTAssertTrue(shows(app, row: "backup-account", "Not signed in", within: 10), "Signed out here too")
        app.navigationBars["Backup & Export"].buttons.firstMatch.tap()
        XCTAssertTrue(app.staticTexts["No habits yet"].waitForExistence(timeout: 10), "This iPhone was erased")
    }

    /// The sidebar (screen 1): Backup & Export, Privacy & Security, then Account, with no value signed out. Account signed
    /// out (screen 2): who you are and where the habits are, then Sign In and Create Account as two rows, each opening its
    /// own sheet with Apple's and Google's buttons (2b, 2c). Move to Another Device opens the transfer code straight away
    /// (screen 5).
    func testAccountInTheMenuAndMovingToAnotherDevice() {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest"]
        app.launch()
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 10))
        app.buttons["menu-button"].tap()
        let row = app.buttons["menu-account"], backupRow = app.buttons["menu-backup"], privacyRow = app.buttons["menu-privacy"]
        XCTAssertTrue(row.waitForExistence(timeout: 5))
        XCTAssertTrue(backupRow.frame.minY < privacyRow.frame.minY && privacyRow.frame.minY < row.frame.minY,
                      "Backup & Export, Privacy & Security, Account: \(backupRow.frame.minY) \(privacyRow.frame.minY) \(row.frame.minY)")
        XCTAssertFalse(row.label.contains("Not Signed In") || row.label.contains("Free") || row.label.contains("Plus"),
                       "Signed out, no value (\"Not Signed In\" read like a warning): \(row.label)")
        let sidebar = XCTAttachment(screenshot: app.screenshot()); sidebar.name = "sidebar"; sidebar.lifetime = .keepAlways; add(sidebar)
        row.tap()
        XCTAssertTrue(app.navigationBars["Account"].waitForExistence(timeout: 5))
        XCTAssertTrue(shows(app, row: "account-identity", "Not signed in"), labels(app))
        XCTAssertTrue(app.buttons["account-sign-in"].exists && app.buttons["account-create"].exists, labels(app))
        XCTAssertLessThan(app.buttons["account-sign-in"].frame.minY, app.buttons["account-create"].frame.minY, "Sign In first")
        XCTAssertTrue(app.staticTexts["A free account is for one device. Syncing several devices is part of Plus."].exists, labels(app))
        XCTAssertFalse(app.staticTexts.matching(NSPredicate(format: "label CONTAINS[c] 'our server'")).firstMatch.exists)
        let page = XCTAttachment(screenshot: app.screenshot()); page.name = "account-signed-out"; page.lifetime = .keepAlways; add(page)
        func apple() -> Bool { app.buttons["sign-in-apple"].exists || app.buttons["Continue with Apple"].exists || app.otherElements["sign-in-apple"].exists }
        // Sign In.
        app.buttons["account-sign-in"].tap()
        XCTAssertTrue(app.navigationBars["Sign In"].waitForExistence(timeout: 5), labels(app))
        XCTAssertTrue(app.staticTexts["Use the same way you signed in before."].exists, labels(app))
        XCTAssertTrue(app.staticTexts["No account found? You'll be asked before a new one is made."].exists, labels(app))
        XCTAssertTrue(apple() && app.buttons["sign-in-google"].exists, "Apple's and Google's buttons: \(labels(app))")
        let signIn = XCTAttachment(screenshot: app.screenshot()); signIn.name = "sign-in-sheet"; signIn.lifetime = .keepAlways; add(signIn)
        app.buttons["sign-in-cancel"].tap()
        XCTAssertTrue(app.navigationBars["Sign In"].waitForNonExistence(timeout: 5))
        // Create Account.
        app.buttons["account-create"].tap()
        XCTAssertTrue(app.navigationBars["Create Account"].waitForExistence(timeout: 5), labels(app))
        XCTAssertTrue(app.staticTexts["Choose how you'll sign in. Already have an account? You'll be signed in to it."].exists, labels(app))
        XCTAssertTrue(app.staticTexts["Used only to back up your habits. Never sold, never for ads."].exists, labels(app))
        XCTAssertTrue(apple() && app.buttons["sign-in-google"].exists, labels(app))
        let create = XCTAttachment(screenshot: app.screenshot()); create.name = "create-account-sheet"; create.lifetime = .keepAlways; add(create)
        app.buttons["sign-in-cancel"].tap()
        XCTAssertTrue(app.navigationBars["Create Account"].waitForNonExistence(timeout: 5))
        app.navigationBars["Account"].buttons.firstMatch.tap()
        // Back on Today before the menu opens again: ≡ tapped while Account was still sliding away left the menu open
        // with Backup & Export not taken (run 37995167302).
        XCTAssertTrue(app.navigationBars["Account"].waitForNonExistence(timeout: 5), labels(app))

        // Move to Another Device: the transfer code at once, with its three steps.
        openBackup(app)
        app.buttons["backup-move"].tap()
        XCTAssertTrue(app.navigationBars["Move to Another Device"].waitForExistence(timeout: 5), labels(app))
        for step in ["Install Often Enough on the other device", "Choose I've used it before, then Move from another device", "Enter this code"] {
            XCTAssertTrue(app.descendants(matching: .any).matching(NSPredicate(format: "label CONTAINS %@", step)).firstMatch.exists, "\(step): \(labels(app))")
        }
        let code = app.staticTexts["transfer-code"]
        XCTAssertTrue(code.waitForExistence(timeout: 5))
        XCTAssertEqual(code.label.count, "Transfer code: ".count + 15, "Eight characters, read one by one: \(code.label)")
        XCTAssertTrue(app.staticTexts["Keep this screen open until your habits arrive on the other device. They stay on this device too."].exists, labels(app))
        let codeShot = XCTAttachment(screenshot: app.screenshot()); codeShot.name = "move-to-another-device"; codeShot.lifetime = .keepAlways; add(codeShot)
        app.navigationBars["Move to Another Device"].buttons.firstMatch.tap()
        XCTAssertTrue(app.navigationBars["Backup & Export"].waitForExistence(timeout: 5))
    }

    /// Plus (screens 3b, 4c, 6c): Backup & Export says backed up and in sync, the account first; Account says Plus
    /// (lifetime) and Last Synced; Restore lists Your Account's 90 days; a restore says it replaces the habits on every
    /// device and asks first. On the dev server with this run's identity (GitHub Actions only).
    func testPlusBackupAccountAndRestoreSayAllDevices() throws {
        continueAfterFailure = false
        let token = try ciToken()
        let subject = "plus-ui-\(UUID().uuidString)"
        let app = XCUIApplication()
        app.launchArguments = ["-dbname", "uitest-plus", "-reset-db", "-empty", "-ci-sign-in", token, subject]
        app.launch()
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 20))
        app.buttons["menu-button"].tap()
        XCTAssertTrue(app.buttons["menu-account"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons["menu-account"].label.contains("Plus"), "Signed in, the plan: \(app.buttons["menu-account"].label)")
        app.buttons["menu-account"].tap()
        XCTAssertTrue(app.navigationBars["Account"].waitForExistence(timeout: 5))
        XCTAssertTrue(shows(app, row: "account-plan", "Plus (lifetime)", within: 10), labels(app))
        XCTAssertTrue(app.descendants(matching: .any)["account-last-synced"].waitForExistence(timeout: 15), "Plus: Last Synced")
        XCTAssertTrue(app.staticTexts["To add a device, sign in on it with this account."].waitForExistence(timeout: 10), labels(app))
        XCTAssertTrue(app.buttons["account-sign-out"].exists && app.buttons["account-delete"].exists)
        let page = XCTAttachment(screenshot: app.screenshot()); page.name = "account-plus"; page.lifetime = .keepAlways; add(page)
        app.navigationBars["Account"].buttons.firstMatch.tap()
        openBackup(app)
        let status = app.descendants(matching: .any)["backup-status"]
        _ = XCTWaiter.wait(for: [XCTNSPredicateExpectation(predicate: NSPredicate(format: "label BEGINSWITH 'Backed up and in sync'"), object: status)], timeout: 30)
        XCTAssertTrue(status.label.hasPrefix("Backed up and in sync") && status.label.contains("Your account"), status.label)
        XCTAssertTrue(shows(app, row: "backup-account", "Plus · Keeps your devices in sync"), labels(app))
        XCTAssertFalse(app.buttons["backup-icloud-status"].exists, "Plus keeps no iCloud copy")
        let backupShot = XCTAttachment(screenshot: app.screenshot()); backupShot.name = "backup-plus"; backupShot.lifetime = .keepAlways; add(backupShot)
        app.buttons["backup-restore"].tap()
        XCTAssertTrue(app.navigationBars["Restore From a Backup"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons["restore-account"].label.contains("Any day in the last 90 days"), app.buttons["restore-account"].label)
        XCTAssertTrue(app.staticTexts["Restoring replaces your habits on all your devices, since they stay in sync. You can undo it for 30 days."].exists, labels(app))
        app.buttons["restore-account"].tap()
        XCTAssertTrue(app.navigationBars["Your Account"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["No daily copies yet. The first is kept tonight."].waitForExistence(timeout: 15), "A new account has no nightly copy yet: \(labels(app))")
        app.terminate()

        // A backup file opened while signed in with Plus: Replace says all devices, and asks first.
        app.launchArguments = ["-dbname", "uitest-plus", "-test-restore-preview"]
        app.launch()
        let replace = app.buttons["restore-replace"]
        XCTAssertTrue(replace.waitForExistence(timeout: 20), labels(app))
        XCTAssertTrue(replace.label.contains("Replace on All Devices") || replace.label == "Restore", replace.label)
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label CONTAINS 'on all your devices'")).firstMatch.exists, labels(app))
        replace.tap()
        let everywhere = app.buttons["Replace on All Devices"].firstMatch
        XCTAssertTrue(app.staticTexts["Replace your habits on all your devices?"].waitForExistence(timeout: 5) || everywhere.waitForExistence(timeout: 1), labels(app))
        let confirm = XCTAttachment(screenshot: app.screenshot()); confirm.name = "restore-plus-confirmation"; confirm.lifetime = .keepAlways; add(confirm)
        app.buttons["Cancel"].firstMatch.tap()

        let me = try call("POST", "/v1/auth/ci", ["idToken": token, "subject": subject, "device": device()])
        if let access = me.json["accessToken"] as? String { _ = try? call("POST", "/v1/account/delete", [:], token: access) }
    }

    /// A backup file opened without an account: Replace says this iPhone only, and runs without asking again (its undo
    /// is kept for 30 days).
    func testRestoreWithoutAnAccountSaysThisIPhone() {
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

    /// Without an account the habits back up to iCloud, and Backup & Export says so, with iCloud's own state: working
    /// (when), full (red, with Back Up to Your Account Instead), off (Open Settings) (the user, 9 Oct 2026, Current Work
    /// 58.12). The simulator has no iCloud, so `-test-icloud` stands in for it (test launches only, D8).
    func testICloudWithoutAnAccount() {
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
        XCTAssertTrue(shows(app, row: "backup-icloud-status", "Your Apple Account"), "iCloud, the place in use")
        XCTAssertTrue(app.buttons["backup-icloud-status"].isSelected, "✓ on iCloud")
        XCTAssertTrue(app.buttons["backup-now"].exists, "Back Up Now, to iCloud")
        XCTAssertTrue(shows(app, row: "backup-account", "Not signed in"))
        XCTAssertTrue(app.staticTexts["Backed up automatically as you go."].exists, labels(app))
        shot("backup-icloud-ok")

        open("full")
        XCTAssertTrue(shows(app, row: "backup-status", "your iCloud is full"), status(app))
        XCTAssertTrue(shows(app, row: "backup-icloud-status", "Full"))
        XCTAssertTrue(app.buttons["backup-fix"].label.contains("Back Up to Your Account Instead"), app.buttons["backup-fix"].label)
        XCTAssertFalse(app.buttons["backup-now"].exists, "No Back Up Now while iCloud is full: the fix is the one thing to tap")
        shot("backup-icloud-full")

        open("signedOut")
        XCTAssertTrue(shows(app, row: "backup-status", "isn't signed in to iCloud"), status(app))
        XCTAssertTrue(shows(app, row: "backup-icloud-status", "Off"))
        XCTAssertTrue(app.buttons["backup-fix"].label.contains("Open Settings"))
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
    private func status(_ app: XCUIApplication) -> String {
        let row = app.descendants(matching: .any)["backup-status"]
        return row.exists ? "status: \(row.label)" : "no status row"
    }

    /// ≡ → Backup & Export.
    private func openBackup(_ app: XCUIApplication) {
        let menuButton = app.buttons["menu-button"], row = app.buttons["menu-backup"]
        XCTAssertTrue(menuButton.waitForExistence(timeout: 10))
        XCTAssertTrue(waitUntil(5) { menuButton.isHittable }, "≡ on Today: \(labels(app))")
        menuButton.tap()
        XCTAssertTrue(row.waitForExistence(timeout: 5))
        XCTAssertTrue(waitUntil(5) { row.isHittable }, "The menu open: \(labels(app))")
        row.tap()
        XCTAssertTrue(app.navigationBars["Backup & Export"].waitForExistence(timeout: 5), labels(app))
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

    /// This run's GitHub identity token for the dev server. Skips the test outside GitHub Actions.
    private func ciToken() throws -> String {
        let env = ProcessInfo.processInfo.environment
        guard let url = env["ACTIONS_ID_TOKEN_REQUEST_URL"], let bearer = env["ACTIONS_ID_TOKEN_REQUEST_TOKEN"], !url.isEmpty, !bearer.isEmpty else {
            throw XCTSkip("Runs on GitHub Actions only: it signs in with the run's identity token")
        }
        var request = URLRequest(url: URL(string: url + "&audience=oftenenough-api-dev")!)
        request.setValue("Bearer \(bearer)", forHTTPHeaderField: "Authorization")
        let (status, json) = try send(request)
        XCTAssertEqual(status, 200, "GitHub gave an identity token")
        return try XCTUnwrap(json["value"] as? String)
    }

    private func device() -> [String: Any] {
        ["id": UUID().uuidString.lowercased(), "platform": "ipados", "name": "UI test iPad", "appVersion": "test"]
    }

    /// One retry when the runner's network times out (seen once on GitHub's Mac, 1 Oct: the server answered in under
    /// a second from elsewhere). Any reply from the server, error or not, is returned as is.
    private func call(_ method: String, _ path: String, _ body: [String: Any]?, token: String? = nil) throws -> (status: Int, json: [String: Any]) {
        do {
            return try callOnce(method, path, body, token: token)
        } catch let error as URLError where error.code == .timedOut {
            return try callOnce(method, path, body, token: token)
        } catch {
            throw NSError(domain: "BackupUITests", code: 1, userInfo: [NSLocalizedDescriptionKey: "\(method) \(path): \(error)"])
        }
    }

    private func callOnce(_ method: String, _ path: String, _ body: [String: Any]?, token: String? = nil) throws -> (status: Int, json: [String: Any]) {
        var request = URLRequest(url: URL(string: api + path)!, timeoutInterval: 60)
        request.httpMethod = method
        if let body {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
            request.setValue("application/json", forHTTPHeaderField: "content-type")
        }
        if let token { request.setValue("Bearer \(token)", forHTTPHeaderField: "authorization") }
        return try send(request)
    }

    /// Plain synchronous HTTP for the test runner.
    private func send(_ request: URLRequest) throws -> (status: Int, json: [String: Any]) {
        let done = DispatchSemaphore(value: 0)
        var result: (Int, Data?, Error?) = (0, nil, nil)
        URLSession.shared.dataTask(with: request) { data, response, error in
            result = ((response as? HTTPURLResponse)?.statusCode ?? 0, data, error)
            done.signal()
        }.resume()
        done.wait()
        if let error = result.2 { throw error }
        let json = result.1.flatMap { try? JSONSerialization.jsonObject(with: $0) } as? [String: Any] ?? [:]
        return (result.0, json)
    }
}
