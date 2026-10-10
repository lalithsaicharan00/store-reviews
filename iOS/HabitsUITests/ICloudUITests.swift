import XCTest

/// iCloud sync (Architecture 11 §19): the checks against the fake iCloud (`CloudSyncCheck`), and the iCloud page in every
/// state it can be in, the questions it asks, and the free plan's second-device sheet. GitHub's simulator can't sign in
/// to iCloud, so a test launch's iCloud is `FakeCloud`, put in each state by `-test-cloud` (D8: never the person's).
final class ICloudUITests: XCTestCase {
    override func record(_ issue: XCTIssue) {
        let shot = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        shot.name = "FAIL-\(name)"
        shot.lifetime = .keepAlways
        var issue = issue
        issue.add(shot)
        super.record(issue)
    }

    override func setUp() { continueAfterFailure = false }

    /// Every guard and error of §3 and §7 against the fake iCloud, and the property test (`CloudSyncCheck`).
    func testSyncAgainstTheFakeICloud() {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest", "-cloudcheck"]
        app.launch()
        let passed = app.staticTexts["iCloud sync: all checks passed"]
        if !passed.waitForExistence(timeout: 900) {
            let failed = app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH %@", "iCloud sync failed")).firstMatch
            XCTFail(failed.exists ? failed.label : "The iCloud checks did not finish")
        }
    }

    /// §14: 25,000 logs a year for 15 years, up and down through the fake iCloud, within time and memory.
    func testTheExtremeAccount() {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest", "-cloudcheck-extreme"]
        app.launch()
        let done = app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH %@", "Extreme account")).firstMatch
        XCTAssertTrue(done.waitForExistence(timeout: 2_700), "The extreme account did not finish")
        XCTAssertTrue(done.label.hasPrefix("Extreme account: all checks passed"), done.label)
        let note = XCTAttachment(string: done.label); note.name = "extreme-account"; note.lifetime = .keepAlways; add(note)
    }

    /// The page's status, first, in each state, with the one thing to do (§17, W6).
    func testTheICloudPageInEveryState() {
        let app = XCUIApplication()
        let states: [(state: String, extra: [String], title: String, action: String?)] = [
            ("synced", [], "Synced with iCloud", "cloud-sync-now"),
            ("waiting", [], "Waiting for a connection", "cloud-sync-now"),
            ("full", [], "iCloud is full", "cloud-manage-storage"),
            ("off", [], "iCloud is off", "cloud-open-settings"),
            ("restricted", [], "iCloud isn't allowed", "cloud-open-settings"),
            ("bringing", [], "Bringing your habits from iCloud", nil),
            ("held", [], "Waiting for you: 120 deletions from iCloud", "cloud-apply-held"),
            ("brake", [], "Waiting for you: 60 deletions", "cloud-send-deletes"),
            ("free-this", ["-free"], "Synced with iCloud", "cloud-sync-now"),
            ("plus", [], "Synced with iCloud", "cloud-sync-now"),
        ]
        for (state, extra, title, action) in states {
            app.terminate()
            app.launchArguments = ["-uitest", "-test-cloud", state] + extra
            app.launch()
            openICloud(app)
            XCTAssertTrue(shows(app, "cloud-status", title, within: 20), "\(state): \(label(app, "cloud-status"))")
            if let action { XCTAssertTrue(app.buttons[action].waitForExistence(timeout: 5), "\(state): \(action) · \(labels(app))") }
            switch state {
            case "free-this":
                XCTAssertTrue(shows(app, "cloud-device", "This iPhone is the one syncing"), labels(app))
                XCTAssertTrue(app.buttons["cloud-see-plus"].exists)
            case "plus":
                XCTAssertTrue(waitUntil(10) { app.descendants(matching: .any).matching(identifier: "cloud-device").count == 2 }, "two devices: \(labels(app))")
            case "held", "brake":
                XCTAssertTrue(app.buttons["cloud-restore-instead"].exists, "Restore From a Backup one tap away")
            default: break
            }
            // Export is on the page in every state (D10); the list draws rows as they scroll in, so scroll to it.
            XCTAssertTrue(app.reveal(app.buttons["backup-save"]) && app.reveal(app.buttons["backup-export-csv"]), "\(state): export on the page · \(labels(app))")
            let shot = XCTAttachment(screenshot: app.screenshot()); shot.name = "icloud-\(state)"; shot.lifetime = .keepAlways; add(shot)
        }
    }

    /// A full iCloud needs the person: Today shows a small card that opens the page (§17); nothing else about sync shows.
    func testTodaysCardWhenICloudNeedsYou() {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest", "-test-cloud", "full"]
        app.launch()
        let card = app.descendants(matching: .any)["cloud-card"]
        XCTAssertTrue(card.waitForExistence(timeout: 20), labels(app))
        XCTAssertTrue(card.label.contains("iCloud is full"), card.label)
        app.revealAndTap(app.buttons["cloud-card-open"])
        XCTAssertTrue(app.navigationBars["iCloud & Backup"].waitForExistence(timeout: 5))
        app.terminate()
        app.launchArguments = ["-uitest", "-test-cloud", "synced"]
        app.launch()
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 10))
        XCTAssertFalse(app.descendants(matching: .any)["cloud-card"].waitForExistence(timeout: 5), "No card while everything works")
    }

    /// §11: the habits were removed from iCloud: asked once; Not Now keeps everything here and stops syncing.
    func testRemovedFromICloudAsksFirst() {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest", "-test-cloud", "removed"]
        app.launch()
        let alert = app.alerts["Your habits were removed from iCloud"]
        XCTAssertTrue(alert.waitForExistence(timeout: 20), labels(app))
        XCTAssertTrue(alert.buttons["Back Up Again"].exists && alert.buttons["Not Now"].exists)
        let shot = XCTAttachment(screenshot: app.screenshot()); shot.name = "icloud-removed-alert"; shot.lifetime = .keepAlways; add(shot)
        alert.buttons["Not Now"].tap()
        XCTAssertFalse(app.staticTexts["No habits yet"].exists, "Nothing here was deleted")
        openICloud(app)
        XCTAssertTrue(shows(app, "cloud-status", "iCloud sync is off on this iPhone"), label(app, "cloud-status"))
        XCTAssertTrue(app.buttons["cloud-turn-on"].exists)
    }

    /// §10: a different Apple Account: asked first, with what's where; Add merges, nothing replaced.
    func testADifferentAppleAccountAsksFirst() {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest", "-test-cloud", "other-account"]
        app.launch()
        let alert = app.alerts["This iPhone uses a different Apple Account"]
        XCTAssertTrue(alert.waitForExistence(timeout: 20), labels(app))
        XCTAssertTrue(alert.staticTexts.matching(NSPredicate(format: "label CONTAINS 'Its iCloud has 14 habits'")).firstMatch.exists, labels(app))
        let shot = XCTAttachment(screenshot: app.screenshot()); shot.name = "icloud-other-account-alert"; shot.lifetime = .keepAlways; add(shot)
        alert.buttons["Add to This Account's iCloud"].tap()
        openICloud(app)
        XCTAssertTrue(shows(app, "cloud-status", "Synced with iCloud", within: 20) || shows(app, "cloud-status", "Syncing"), label(app, "cloud-status"))
    }

    /// §12 and the Plus screens' image 16: a free second device asks, Plus first; Use on This iPhone moves syncing here.
    func testTheSecondDeviceSheet() {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest", "-free", "-test-cloud", "free-other"]
        app.launch()
        let title = app.staticTexts["use-here-title"]
        XCTAssertTrue(title.waitForExistence(timeout: 20), labels(app))
        XCTAssertEqual(title.label, "Use your habits on this iPhone?")
        XCTAssertTrue(app.staticTexts["The free plan syncs one device at a time through iCloud."].exists, labels(app))
        let plus = app.buttons["use-here-see-plus"], move = app.buttons["use-here-continue"]
        XCTAssertTrue(plus.exists && move.exists)
        XCTAssertLessThan(plus.frame.minY, move.frame.minY, "Plus first, the free move last (the user's decision)")
        XCTAssertTrue(app.staticTexts["use-here-text"].label.contains("Your iPad stops syncing and keeps everything it has"), app.staticTexts["use-here-text"].label)
        let shot = XCTAttachment(screenshot: app.screenshot()); shot.name = "second-device-sheet"; shot.lifetime = .keepAlways; add(shot)
        // ✕ changes nothing: the page says the iPad is the one syncing.
        app.buttons["use-here-cancel"].tap()
        XCTAssertTrue(title.waitForNonExistence(timeout: 5))
        openICloud(app)
        XCTAssertTrue(shows(app, "cloud-status", "Your iPad is the one syncing"), label(app, "cloud-status"))
        app.buttons["cloud-move-here"].tap()
        XCTAssertTrue(shows(app, "cloud-device", "This iPhone is the one syncing", within: 20), labels(app))
    }

    // MARK: Helpers

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

    private func label(_ app: XCUIApplication, _ id: String) -> String {
        let row = app.descendants(matching: .any)[id]
        return row.exists ? "\(id): \(row.label)" : "no \(id)"
    }

    /// ≡ → iCloud & Backup.
    private func openICloud(_ app: XCUIApplication) {
        let menuButton = app.buttons["menu-button"], row = app.buttons["menu-backup"]
        XCTAssertTrue(menuButton.waitForExistence(timeout: 10))
        XCTAssertTrue(waitUntil(5) { menuButton.isHittable }, "≡ on Today: \(labels(app))")
        menuButton.tap()
        XCTAssertTrue(row.waitForExistence(timeout: 5))
        XCTAssertTrue(waitUntil(5) { row.isHittable }, "The menu open: \(labels(app))")
        XCTAssertTrue(row.label.contains("iCloud & Backup"), row.label)
        row.tap()
        XCTAssertTrue(app.navigationBars["iCloud & Backup"].waitForExistence(timeout: 5), labels(app))
    }

    private func shows(_ app: XCUIApplication, _ identifier: String, _ text: String, within seconds: TimeInterval = 3) -> Bool {
        let row = app.descendants(matching: .any)[identifier]
        let deadline = Date().addingTimeInterval(seconds)
        repeat {
            if row.exists, row.label.contains(text) || (row.value as? String)?.contains(text) == true { return true }
            Thread.sleep(forTimeInterval: 0.5)
        } while Date() < deadline
        return false
    }
}
