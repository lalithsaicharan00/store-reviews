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
        for id in ["backup-export-csv", "backup-save", "backup-restore"] {
            XCTAssertTrue(app.buttons[id].exists, id)
        }
        // The status says where the habits are and what deleting the app does, in one line (report "Backup & Export
        // and Your Account", 9 Oct 2026); the groups follow what people come to do; no Sync row and no "our server".
        XCTAssertTrue(shows(app, row: "backup-status", "Deleting the app deletes your habits"), status(app))
        for header in ["Backed Up To", "Restore & Move", "Export"] {
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
        XCTAssertTrue(app.buttons["backup-sign-in"].exists, "Your Account: Sign In, where the copies go")
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

    /// Restore is offered on the empty first screen, and opens the restore choices: the account and a file.
    func testTheEmptyFirstScreenOffersRestore() throws {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest", "-empty"]
        app.launch()
        XCTAssertTrue(app.staticTexts["No habits yet"].waitForExistence(timeout: 10))
        app.buttons["empty-restore-backup"].tap()
        XCTAssertTrue(app.navigationBars["Backup & Export"].waitForExistence(timeout: 5))
        app.buttons["backup-restore"].tap()
        XCTAssertTrue(app.navigationBars["Restore Your Habits"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons["Sign In"].exists)
        XCTAssertTrue(app.buttons["Import a File"].exists)
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
        XCTAssertTrue(shows(app, row: "backup-status", "In your account", within: 10), "Signed in: the backup goes to the account. \(status(app))")
        app.buttons["Back Up Now"].tap()
        let backedUp = app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH 'Backed up'")).firstMatch
        XCTAssertTrue(backedUp.waitForExistence(timeout: 30), "The backup is confirmed by the server's checksum")

        // The server holds the copy, with the habit counted.
        let other = try call("POST", "/v1/auth/ci", ["idToken": token, "subject": subject, "plus": false, "device": device()])
        XCTAssertEqual(other.status, 200, "\(other.json)")
        let access = try XCTUnwrap(other.json["accessToken"] as? String)
        let list = try call("GET", "/v1/backup", nil, token: access)
        let copies = try XCTUnwrap(list.json["copies"] as? [[String: Any]])
        XCTAssertTrue(copies.contains { ($0["habits"] as? Int) == 1 }, "The server's copy has the habit: \(list.json)")

        // Restore lists it; restoring it here changes nothing.
        app.buttons["backup-restore"].tap()
        XCTAssertTrue(app.navigationBars["Restore Your Habits"].waitForExistence(timeout: 5))
        let copy = app.buttons.matching(NSPredicate(format: "label CONTAINS '(this device)'")).firstMatch
        XCTAssertTrue(copy.waitForExistence(timeout: 15))
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
        XCTAssertTrue(app.buttons["backup-sign-in"].exists, "Signed out here too")
        app.navigationBars["Backup & Export"].buttons.firstMatch.tap()
        XCTAssertTrue(app.staticTexts["No habits yet"].waitForExistence(timeout: 10), "This iPhone was erased")
    }

    /// ≡ → Account (the user, 9 Oct 2026: signing in and out where people look for it): signed out, the menu row says
    /// Sign In and the page offers it; Backup & Export → Move to a New iPhone says the two steps and sends a file.
    func testAccountInTheMenuAndMovingToANewIPhone() {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest"]
        app.launch()
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 10))
        app.buttons["menu-button"].tap()
        let row = app.buttons["menu-account"]
        XCTAssertTrue(row.waitForExistence(timeout: 5))
        XCTAssertTrue(row.label.contains("Sign In"), "Signed out, the row says so: \(row.label)")
        row.tap()
        XCTAssertTrue(app.navigationBars["Account"].waitForExistence(timeout: 5))
        app.buttons["account-sign-in"].tap()
        XCTAssertTrue(app.navigationBars["Sign In"].waitForExistence(timeout: 5), "Sign In opens the sign-in sheet")
        XCTAssertFalse(app.staticTexts.matching(NSPredicate(format: "label CONTAINS[c] 'our server'")).firstMatch.exists)
        app.navigationBars["Sign In"].buttons["Cancel"].tap()
        app.navigationBars["Account"].buttons.firstMatch.tap()

        openBackup(app)
        app.buttons["backup-move"].tap()
        XCTAssertTrue(app.navigationBars["Move to a New iPhone"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["Send a backup file to the new iPhone"].exists, "The two steps for a phone with no account")
        app.buttons["backup-move-send"].tap()
        let shared = app.otherElements["ActivityListView"].waitForExistence(timeout: 10) || app.buttons["Save to Files"].waitForExistence(timeout: 2)
        XCTAssertTrue(shared, "Send a Backup File opens the share sheet")
        let shot = XCTAttachment(screenshot: app.screenshot()); shot.name = "move-to-a-new-iphone"; shot.lifetime = .keepAlways; add(shot)
    }

    // MARK: Helpers

    /// The status row's words, for a failure message (T14).
    private func status(_ app: XCUIApplication) -> String {
        let row = app.descendants(matching: .any)["backup-status"]
        return row.exists ? "status: \(row.label)" : "no status row"
    }

    /// ≡ → Backup & Export.
    private func openBackup(_ app: XCUIApplication) {
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 10))
        app.buttons["menu-button"].tap()
        XCTAssertTrue(app.buttons["menu-backup"].waitForExistence(timeout: 5))
        app.buttons["menu-backup"].tap()
        XCTAssertTrue(app.navigationBars["Backup & Export"].waitForExistence(timeout: 5))
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
