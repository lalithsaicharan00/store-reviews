import XCTest

/// End to end: this app, the real dev server (api-dev.oftenenough.com) and a second device played by the test.
/// The app signs in with this GitHub Actions run's identity token (server: POST /v1/auth/ci), so the test only
/// runs on GitHub Actions; anywhere else it's skipped.
final class SyncUITests: XCTestCase {
    private let api = "https://api-dev.oftenenough.com"

    override func record(_ issue: XCTIssue) {
        let shot = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        shot.name = "FAIL-\(name)"
        shot.lifetime = .keepAlways
        var issue = issue
        issue.add(shot)
        super.record(issue)
    }

    func testChangesTravelBetweenThisPhoneAndAnotherDevice() throws {
        continueAfterFailure = false
        let token = try ciToken()
        let subject = "sync-ui-\(UUID().uuidString)"

        // This phone signs in (creating the account), then makes a habit and ticks it, as a person would.
        let app = XCUIApplication()
        app.launchArguments = ["-dbname", "uitest-sync", "-reset-db", "-empty", "-ci-sign-in", token, subject]
        app.launch()
        XCTAssertTrue(app.staticTexts["No habits yet"].waitForExistence(timeout: 20), "The app opens with no habits")
        app.buttons["New Habit"].firstMatch.tap()
        XCTAssertTrue(app.navigationBars["New"].waitForExistence(timeout: 3))
        app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Build or maintain'")).firstMatch.tap()
        app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Check it off'")).firstMatch.tap()
        let name = app.descendants(matching: .any)["name-field"]
        XCTAssertTrue(name.waitForExistence(timeout: 3))
        name.tap()
        name.typeText("Synced stretch")
        app.navigationBars["New Habit"].buttons["Add"].tap()
        let tick = app.buttons["Mark Synced stretch done"]
        XCTAssertTrue(tick.waitForExistence(timeout: 5))
        tick.tap()

        // Another device signs in to the same account and waits for the habit and its tick to arrive.
        let other = try post("/v1/auth/ci", ["idToken": token, "subject": subject, "device": device()])
        XCTAssertEqual(other.status, 200, "The second device opens the account the phone created: \(other.json)")
        let access = try XCTUnwrap(other.json["accessToken"] as? String)
        var cursor = 0
        var ops: [[String: Any]] = []
        let deadline = Date().addingTimeInterval(90)
        func arrived() -> (habitRow: String?, ticked: Bool) {
            let habit = ops.first { ($0["table"] as? String) == "habit" && (($0["fields"] as? [String: Any])?["name"] as? String) == "Synced stretch" }
            let row = habit?["row"] as? String
            let ticked = row != nil && ops.contains { ($0["table"] as? String) == "entry" && (($0["fields"] as? [String: Any])?["habit_id"] as? String) == row }
            return (row, ticked)
        }
        while Date() < deadline && !arrived().ticked {
            let reply = try post("/v1/sync", ["cursor": cursor, "ops": []], token: access)
            XCTAssertEqual(reply.status, 200)
            ops += reply.json["ops"] as? [[String: Any]] ?? []
            cursor = reply.json["cursor"] as? Int ?? cursor
            if !arrived().ticked { Thread.sleep(forTimeInterval: 3) }
        }
        XCTAssertNotNil(arrived().habitRow, "The habit made on the phone reached the server")
        XCTAssertTrue(arrived().ticked, "The tick made on the phone reached the server")

        // The other device adds a habit; the phone shows it after coming back to the foreground.
        let now = Int(Date().timeIntervalSince1970 * 1000)
        let fields: [String: Any] = [
            "name": "From the iPad", "symbol": "book.fill", "color": "orange", "kind": "check", "unit": NSNull(),
            "increment": 1.0, "part": "anytime", "goal": 1.0, "period": "day", "frequency": "daily", "at_most": false,
            "position": 1, "created_at": now, "updated_at": now, "deleted_at": NSNull(), "remind": true, "alert": "notification",
        ]
        let op: [String: Any] = [
            "id": UUID().uuidString, "table": "habit", "row": UUID().uuidString, "fields": fields,
            "hlc": String(format: "%018ld-%05ld-uitest", now, 0), "schema": 6,
        ]
        let pushed = try post("/v1/sync", ["cursor": cursor, "ops": [op]], token: access)
        XCTAssertEqual(pushed.json["applied"] as? [String], [op["id"] as! String], "The server took the other device's habit: \(pushed.json)")
        XCUIDevice.shared.press(.home)
        app.activate()
        XCTAssertTrue(app.buttons["Mark From the iPad done"].waitForExistence(timeout: 45), "The other device's habit appears on the phone")
        XCTAssertTrue(app.buttons["Undo Synced stretch"].exists || app.buttons["Anytime, All done"].exists || !app.buttons["Mark Synced stretch done"].exists,
                      "The phone's own tick is still there after merging")

        // What the person sees signed in with Plus (Current Work 58.10–58.11): Backup & Export says when and where, and
        // ≡ → Account says the plan and when this iPhone last synced.
        func shot(_ name: String) {
            let attachment = XCTAttachment(screenshot: app.screenshot()); attachment.name = name; attachment.lifetime = .keepAlways; add(attachment)
        }
        app.buttons["menu-button"].tap()
        XCTAssertTrue(app.buttons["menu-backup"].waitForExistence(timeout: 5))
        app.buttons["menu-backup"].tap()
        let status = app.descendants(matching: .any)["backup-status"]
        XCTAssertTrue(status.waitForExistence(timeout: 10))
        _ = XCTWaiter.wait(for: [XCTNSPredicateExpectation(predicate: NSPredicate(format: "label BEGINSWITH 'Backed up'"), object: status)], timeout: 30)
        XCTAssertTrue(status.label.contains("In your account"), "Signed in, the copies are in the account: \(status.label)")
        shot("backup-signed-in-plus")
        app.descendants(matching: .any)["backup-account"].tap()
        XCTAssertTrue(app.navigationBars["Account"].waitForExistence(timeout: 5))
        let synced = app.descendants(matching: .any)["account-last-synced"]
        XCTAssertTrue(synced.waitForExistence(timeout: 15), "Plus: when this iPhone last synced")
        shot("account-signed-in-plus")
        app.navigationBars["Account"].buttons.firstMatch.tap()
        app.navigationBars["Backup & Export"].buttons.firstMatch.tap()

        // And it's saved on the phone: it's still there after a relaunch, with no sign-in.
        app.terminate()
        app.launchArguments = ["-dbname", "uitest-sync", "-empty"]
        app.launch()
        XCTAssertTrue(app.buttons["Mark From the iPad done"].waitForExistence(timeout: 10), "Synced data survives a relaunch")

        // Clean up the test account on the server.
        _ = try? post("/v1/account/delete", [:], token: access)
    }

    // MARK: Helpers

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

    private func post(_ path: String, _ body: [String: Any], token: String? = nil) throws -> (status: Int, json: [String: Any]) {
        var request = URLRequest(url: URL(string: api + path)!, timeoutInterval: 30)
        request.httpMethod = "POST"
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        request.setValue("application/json", forHTTPHeaderField: "content-type")
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
