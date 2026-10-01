import XCTest

/// Settings → Backup & Sync, and a free account's backup on the real dev server (Backup, Sync and Accounts — One
/// Seamless Experience). The end-to-end test signs in with this GitHub Actions run's identity token as a free account
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

    /// No account: the screen says the habits are only on this iPhone, sync is Plus, and a file can be made.
    func testWithoutAnAccountEverythingStaysOnThePhone() throws {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest"]
        app.launch()
        app.buttons["Settings"].firstMatch.tap()
        XCTAssertTrue(app.navigationBars["Backup & Sync"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["Saved only on this iPhone"].exists)
        XCTAssertTrue(shows(app, row: "backup-where", "This iPhone only"))
        XCTAssertTrue(app.staticTexts["Sync is part of Plus. Your devices talk through your account."].exists)
        XCTAssertFalse(app.buttons["Back Up Now"].exists, "Nowhere to back up to without an account")
        app.buttons["Export a File"].tap()
        let shared = app.otherElements["ActivityListView"].waitForExistence(timeout: 10) || app.buttons["Save to Files"].waitForExistence(timeout: 2)
        XCTAssertTrue(shared, "The share sheet opens with the backup file")
    }

    /// "I've used this before" is offered on the empty first screen, and opens the restore choices.
    func testTheEmptyFirstScreenOffersRestore() throws {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest", "-empty"]
        app.launch()
        XCTAssertTrue(app.staticTexts["No habits yet"].waitForExistence(timeout: 10))
        app.buttons["I've Used This Before"].tap()
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

        app.buttons["Settings"].firstMatch.tap()
        XCTAssertTrue(app.navigationBars["Backup & Sync"].waitForExistence(timeout: 5))
        XCTAssertTrue(shows(app, row: "backup-where", "Your account (our server)", within: 10), "Signed in: the backup goes to the account")
        XCTAssertTrue(app.staticTexts["Sync is part of Plus. Your devices talk through your account."].exists, "A free account doesn't sync")
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
        app.buttons["Restore…"].tap()
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
        app.launchArguments = ["-dbname", "uitest-delete", "-reset-db", "-ci-sign-in-free", token, subject]
        app.launch()
        XCTAssertTrue(app.buttons["Settings"].firstMatch.waitForExistence(timeout: 20))
        app.buttons["Settings"].firstMatch.tap()
        let account = app.descendants(matching: .any)["backup-account"]
        XCTAssertTrue(account.waitForExistence(timeout: 20), "Signed in (the app made the account), the account row is there")
        // Another device of the same account, signed in before the deletion.
        let other = try call("POST", "/v1/auth/ci", ["idToken": token, "subject": subject, "plus": false, "device": device()])
        let refresh = try XCTUnwrap(other.json["refreshToken"] as? String, "\(other.json)")
        account.tap()
        XCTAssertTrue(app.navigationBars["Your Account"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label CONTAINS '(this device)'")).firstMatch.waitForExistence(timeout: 10), "This device is listed")
        app.buttons["Delete Account…"].tap()
        XCTAssertTrue(app.navigationBars["Delete Account"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons["Export a File First"].exists, "An export is offered first")
        app.buttons["account-delete-confirm"].tap()
        let erase = app.buttons["Erase This iPhone Too"]
        XCTAssertTrue(erase.waitForExistence(timeout: 5), "It asks about this iPhone's habits")
        erase.tap()
        XCTAssertTrue(app.staticTexts["Your account is deleted."].waitForExistence(timeout: 30))

        let after = try call("POST", "/v1/auth/refresh", ["refreshToken": refresh])
        XCTAssertEqual(after.status, 401)
        XCTAssertEqual(after.json["error"] as? String, "account_deleted", "The other device is told the account is gone")

        app.buttons["Done"].tap()
        XCTAssertTrue(app.buttons["Sign In to Back Up to Your Account"].waitForExistence(timeout: 10), "Signed out here")
        app.buttons["Close"].firstMatch.tap()
        XCTAssertTrue(app.staticTexts["No habits yet"].waitForExistence(timeout: 10), "This iPhone was erased")
    }

    // MARK: Helpers

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
