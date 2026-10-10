import XCTest

/// App Lock, Privacy & Security and Hide Names Outside the App (Current Work 58; spec "Privacy & Security — What to
/// Build"). Test launches never use the person's lock (D8): `-test-lock passcode|code` turns on the test's own lock, with
/// its own Keychain item, and a test Face ID panel (`fake-auth`) answers in place of the system's prompt.
/// `-test-face none` is an iPhone without Face ID, `-test-face denied` Face ID switched off for the app,
/// `-test-passcode none` an iPhone with no passcode, `-test-face-domain B` one whose faces changed, and
/// `-test-lock-advance N` moves the lock's clock on N seconds (T11). `-test-lock faceid|iphone|app` starts with that
/// everyday way and its app passcode; `-test-lock passcode|code` is a lock made before round 2 (no way saved).
final class AppLockUITests: XCTestCase {
    override func setUp() { continueAfterFailure = false }

    private func launch(_ arguments: [String]) -> XCUIApplication {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest", "-empty"] + arguments
        app.launch()
        return app
    }

    private var cover: (XCUIApplication) -> XCUIElement { { $0.descendants(matching: .any)["app-lock-cover"] } }

    /// The test Face ID panel's answer (it stands in for the system's prompt).
    /// A tap on the test panel that left it showing (once, at a launch, run 37880056940) is said in the log and
    /// screenshot, then tried once more: the panel is the test's stand-in for the system's prompt, not the app.
    private func answer(_ app: XCUIApplication, _ ok: Bool, file: StaticString = #filePath, line: UInt = #line) {
        let button = app.buttons[ok ? "fake-auth-ok" : "fake-auth-cancel"]
        XCTAssertTrue(button.waitForExistence(timeout: 10), "No Face ID prompt: \(labels(app))", file: file, line: line)
        let reason = app.staticTexts["fake-auth-reason"].label
        button.tap()
        let panel = app.descendants(matching: .any)["fake-auth"]
        let still = app.staticTexts["fake-auth-reason"]
        if !gone(panel, timeout: 3), still.exists, still.label == reason {
            print("AppLockUITests: the test Face ID panel's tap was lost (\(reason)); tapping again. \(labels(app))")
            shot(app, "fake-auth-tap-lost")
            button.tap()
        }
    }

    /// A new code, twice: the second only once the keypad asks for it again (typed while "Enter it again" was still
    /// arriving, digits were lost: run 37896905498).
    private func chooseCode(_ app: XCUIApplication, _ code: String, file: StaticString = #filePath, line: UInt = #line) {
        enterCode(app, code)
        XCTAssertTrue(app.staticTexts["Enter it again"].waitForExistence(timeout: 5), "Asks for the code again: \(labels(app))", file: file, line: line)
        enterCode(app, code)
    }

    /// A code sheet over the app (not the cover): wait until the cover the app shows while it isn't in front has gone
    /// (it flashed after the test Face ID panel closed and took a digit: run of 10 Oct 2026, testSwitchingWays), then
    /// type.
    private func enterCodeInSheet(_ app: XCUIApplication, _ code: String, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertTrue(gone(cover(app), timeout: 5), "The cover is in the way: \(labels(app))", file: file, line: line)
        XCTAssertTrue(app.buttons["code-key-1"].waitForExistence(timeout: 5) && app.buttons["code-key-1"].isHittable, labels(app), file: file, line: line)
        enterCode(app, code)
    }

    /// The code keys: a code sheet's own (`code-setup`) when one is up over the cover's keypad.
    private func enterCode(_ app: XCUIApplication, _ code: String) {
        let setup = app.descendants(matching: .any)["code-setup"]
        let scope: XCUIElement = setup.exists ? setup : app
        for digit in code { scope.buttons["code-key-\(digit)"].tap() }
    }

    private func openPrivacy(_ app: XCUIApplication) {
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 15), labels(app))
        app.buttons["menu-button"].tap()
        XCTAssertTrue(app.buttons["menu-privacy"].waitForExistence(timeout: 5))
        app.buttons["menu-privacy"].tap()
        XCTAssertTrue(app.navigationBars["Privacy & Security"].waitForExistence(timeout: 5), labels(app))
    }

    /// Privacy & Security › App Lock (Current Work 58.13): the row says Off or On; the page holds the switch.
    private func openAppLock(_ app: XCUIApplication, file: StaticString = #filePath, line: UInt = #line) {
        let row = app.buttons["privacy-app-lock"]
        XCTAssertTrue(row.waitForExistence(timeout: 5), labels(app), file: file, line: line)
        row.tap()
        XCTAssertTrue(app.navigationBars["App Lock"].waitForExistence(timeout: 5), labels(app), file: file, line: line)
    }

    private func back(_ app: XCUIApplication) {
        app.navigationBars.buttons.element(boundBy: 0).tap()
    }

    /// The switch, then Set Up App Lock (A2): the way, Continue, Create App Passcode (Face ID or the iPhone passcode
    /// once, except for App Passcode), the passcode twice; App Lock reads on.
    private func turnOn(_ app: XCUIApplication, way: String, code: String, file: StaticString = #filePath, line: UInt = #line) {
        flip(app.switches["privacy-lock"])
        XCTAssertTrue(app.navigationBars["Set Up App Lock"].waitForExistence(timeout: 5), labels(app), file: file, line: line)
        app.buttons["setup-\(way)"].tap()
        XCTAssertTrue(app.buttons["setup-\(way)"].isSelected, "\(way) chosen: \(labels(app))", file: file, line: line)
        app.buttons["setup-continue"].tap()
        createAppPasscode(app, code, ownerCheck: way != "app-passcode", file: file, line: line)
        XCTAssertTrue(gone(app.navigationBars["App Passcode"]), labels(app), file: file, line: line)
        XCTAssertTrue(waitFor(app.switches["privacy-lock"], value: "1"), labels(app), file: file, line: line)
    }

    /// From the explainer (A6–A8): Create App Passcode, the owner check when the way has one, the passcode twice.
    private func createAppPasscode(_ app: XCUIApplication, _ code: String, ownerCheck: Bool = true, file: StaticString = #filePath, line: UInt = #line) {
        let create = app.buttons["setup-create-app-passcode"]
        XCTAssertTrue(create.waitForExistence(timeout: 5), labels(app), file: file, line: line)
        create.tap()
        if ownerCheck { answer(app, true, file: file, line: line) }
        XCTAssertTrue(app.staticTexts["Enter a six-digit passcode"].waitForExistence(timeout: 5), labels(app), file: file, line: line)
        chooseCode(app, code, file: file, line: line)
    }

    /// A row's text, wherever iOS puts a combined row's words (its label, or its value). A way that can't be chosen is
    /// plain text, not a button.
    private func row(_ app: XCUIApplication, _ id: String) -> String {
        let element = app.descendants(matching: .any)[id].firstMatch
        return element.label + " " + value(element)
    }

    /// A way that can't be chosen: shown (with its reason), but not a button.
    private func unavailable(_ app: XCUIApplication, _ id: String) -> Bool {
        app.descendants(matching: .any)[id].firstMatch.exists && !app.buttons[id].exists
    }

    /// Lock Again, a menu in its row: by its id, or by its title where the menu button doesn't carry the id.
    private func lockAgain(_ app: XCUIApplication) -> XCUIElement {
        let byID = app.buttons["privacy-lock-again"]
        return byID.exists ? byID : app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Lock Again'")).firstMatch
    }

    /// Any element whose label contains `text` (a row whose texts are combined into one element).
    private func shows(_ app: XCUIApplication, _ text: String) -> Bool {
        app.descendants(matching: .any).matching(NSPredicate(format: "label CONTAINS %@", text)).firstMatch.exists
    }

    private func flip(_ toggle: XCUIElement) {
        toggle.coordinate(withNormalizedOffset: CGVector(dx: 0.92, dy: 0.5)).tap()
    }

    private func value(_ element: XCUIElement) -> String { element.value as? String ?? "" }

    private func waitFor(_ element: XCUIElement, value expected: String, timeout: TimeInterval = 5) -> Bool {
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: "value == %@", expected), object: element)
        return XCTWaiter.wait(for: [expectation], timeout: timeout) == .completed
    }

    private func waitForSelected(_ element: XCUIElement, timeout: TimeInterval = 5) -> Bool {
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: "isSelected == true"), object: element)
        return XCTWaiter.wait(for: [expectation], timeout: timeout) == .completed
    }

    private func gone(_ element: XCUIElement, timeout: TimeInterval = 8) -> Bool {
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: "exists == false"), object: element)
        return XCTWaiter.wait(for: [expectation], timeout: timeout) == .completed
    }

    /// Leave the app and come back, as the person does with the app switcher.
    private func leaveAndReturn(_ app: XCUIApplication, away: TimeInterval = 1) {
        XCUIDevice.shared.press(.home)
        _ = XCTWaiter.wait(for: [XCTestExpectation(description: "away")], timeout: away)
        app.activate()
    }

    /// What's on screen, on one line (T14).
    private func labels(_ app: XCUIApplication) -> String {
        app.descendants(matching: .any).allElementsBoundByIndex.prefix(70).map(\.label).filter { !$0.isEmpty }.joined(separator: " | ")
    }

    private func shot(_ app: XCUIApplication, _ name: String) {
        let shot = XCTAttachment(screenshot: app.screenshot()); shot.name = name; shot.lifetime = .keepAlways; add(shot)
    }

    // MARK: The checks in the app

    func testLockRulesAndHiddenNamesEverywhere() {
        let app = XCUIApplication(); app.launchArguments = ["-uitest", "-applockcheck"]
        app.launch()
        let passed = app.staticTexts["App lock: all checks passed"]
        if !passed.waitForExistence(timeout: 120) {
            let failed = app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH %@", "App lock failed")).firstMatch
            XCTFail(failed.exists ? failed.label : labels(app))
        }
    }

    // MARK: The page and Set Up App Lock (round 2: A1–A8, B1–B5)

    /// A1: the switch is "App Lock", never named for Face ID; the row says Off. The switch opens Set Up App Lock (A2,
    /// Face ID the default) and stays off until the end; the Face ID way's explainer (A6) and its owner check (cancelled
    /// stays); on (B1, B5): Face ID chosen, Change App Passcode, Lock Again a menu, Hide Names held on. Off again with
    /// Face ID; Hide Names goes back to the person's own choice.
    func testLockOnAndOffAndHideNamesFollows() {
        let app = launch([])
        openPrivacy(app)
        let lockRow = app.buttons["privacy-app-lock"], hide = app.switches["privacy-hide-names"]
        XCTAssertTrue(lockRow.waitForExistence(timeout: 5) && hide.exists, labels(app))
        XCTAssertTrue(lockRow.label.contains("Off") && lockRow.label.contains("Lock the app with Face ID or a passcode"), lockRow.label)
        XCTAssertEqual(value(hide), "0")
        XCTAssertTrue(hide.isEnabled, "Hide Names is the person's own switch while unlocked")
        XCTAssertTrue(app.staticTexts["Widgets, reminders, alarms and Siri show icons and numbers instead of habit names."].exists, labels(app))
        shot(app, "privacy-app-lock-off")
        flip(hide)
        XCTAssertTrue(waitFor(hide, value: "1"))
        flip(hide)
        XCTAssertTrue(waitFor(hide, value: "0"))
        openAppLock(app)
        let lock = app.switches["privacy-lock"]
        XCTAssertTrue(lock.waitForExistence(timeout: 5))
        XCTAssertEqual(lock.label, "App Lock", "A1: the switch never names Face ID")
        XCTAssertEqual(value(lock), "0", "Off by default")
        XCTAssertFalse(app.buttons["unlock-face-id"].exists || lockAgain(app).exists, "Options only once it's on")
        XCTAssertTrue(shows(app, "The app asks for Face ID or a passcode each time you open it."), labels(app))
        shot(app, "a1-app-lock-off")
        // On: the sheet first; the switch stays off meanwhile.
        flip(lock)
        XCTAssertTrue(app.navigationBars["Set Up App Lock"].waitForExistence(timeout: 5), labels(app))
        XCTAssertTrue(app.staticTexts["How do you want to open the app?"].exists, labels(app))
        XCTAssertTrue(app.buttons["setup-face-id"].isSelected, "A2: Face ID is the default")
        XCTAssertTrue(app.buttons["setup-face-id"].isEnabled && app.buttons["setup-iphone-passcode"].isEnabled && app.buttons["setup-app-passcode"].isEnabled)
        XCTAssertTrue(row(app, "setup-face-id").contains("If Face ID can't recognise you, your app passcode opens the app."), row(app, "setup-face-id"))
        XCTAssertTrue(row(app, "setup-iphone-passcode").contains("As when you unlock your iPhone: Face ID, or your iPhone passcode."), row(app, "setup-iphone-passcode"))
        XCTAssertFalse(app.buttons["privacy-allow-face-id"].exists, "Face ID is allowed: nothing to allow")
        XCTAssertFalse(app.staticTexts["Recommended"].exists, "No badge")
        XCTAssertEqual(value(lock), "0", "Still off while setting up")
        shot(app, "a2-choose")
        app.buttons["setup-continue"].tap()
        XCTAssertTrue(app.staticTexts["Now create an app passcode"].waitForExistence(timeout: 5), labels(app))
        for text in ["It opens the app whenever Face ID can't.", "When it's asked", "If you forget it", "Face ID sets a new one straight away.",
                     "If Face ID can't help either", "Your habits are never deleted, whatever happens."] {
            XCTAssertTrue(shows(app, text), "A6 \(text): \(labels(app))")
        }
        shot(app, "a6-face-id-backup")
        // A cancelled owner check stays on A6.
        app.buttons["setup-create-app-passcode"].tap()
        answer(app, false)
        XCTAssertTrue(app.staticTexts["Now create an app passcode"].exists && !app.staticTexts["Enter a six-digit passcode"].exists, labels(app))
        createAppPasscode(app, "246802")
        XCTAssertTrue(waitFor(lock, value: "1"), labels(app))
        XCTAssertTrue(app.buttons["unlock-face-id"].isSelected && !app.buttons["unlock-iphone-passcode"].isSelected && !app.buttons["unlock-app-passcode"].isSelected, labels(app))
        XCTAssertTrue(shows(app, "If Face ID can't recognise you, your app passcode opens the app. Your iPhone passcode can't."), labels(app))
        XCTAssertTrue(app.buttons["privacy-change-code"].label.contains("Change App Passcode"), labels(app))
        XCTAssertFalse(app.buttons["privacy-use-face-id-again"].exists)
        shot(app, "b1-on-face-id")
        // Lock Again: a menu in its row.
        let again = lockAgain(app)
        XCTAssertTrue(again.waitForExistence(timeout: 5), labels(app))
        XCTAssertTrue((again.label + " " + value(again)).contains("Immediately"), "Immediately is the default: \(again.label) \(value(again))")
        again.tap()
        let fifteen = app.buttons["After 15 Minutes"]
        XCTAssertTrue(fifteen.waitForExistence(timeout: 5), labels(app))
        fifteen.tap()
        XCTAssertTrue(gone(fifteen, timeout: 3))
        XCTAssertTrue((again.label + " " + value(again)).contains("After 15 Minutes"), "\(again.label) \(value(again))")
        again.tap()
        XCTAssertTrue(app.buttons["Immediately"].waitForExistence(timeout: 5)); app.buttons["Immediately"].tap()
        back(app)
        XCTAssertTrue(waitFor(hide, value: "1") && !hide.isEnabled, "App Lock turns Hide Names on and holds it")
        XCTAssertTrue(app.buttons["privacy-app-lock"].label.contains("On") && app.buttons["privacy-app-lock"].label.contains("Opens with Face ID"),
                      app.buttons["privacy-app-lock"].label)
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH %@", "On while App Lock is on.")).firstMatch.exists, labels(app))
        shot(app, "b5-privacy-on")
        // Off again: Face ID, and Hide Names back to the person's own choice (off).
        openAppLock(app)
        flip(lock); answer(app, true)
        XCTAssertTrue(waitFor(lock, value: "0"))
        XCTAssertFalse(lockAgain(app).exists, "The page collapses back")
        back(app)
        XCTAssertTrue(waitFor(hide, value: "0") && hide.isEnabled, "Turning the lock off gives back the person's choice")
        // The person's choice on, then the lock on and off: still on.
        flip(hide); XCTAssertTrue(waitFor(hide, value: "1"))
        openAppLock(app)
        turnOn(app, way: "iphone-passcode", code: "135791")
        flip(lock); answer(app, true); XCTAssertTrue(waitFor(lock, value: "0"))
        back(app)
        XCTAssertTrue(waitFor(hide, value: "1"), "The person's own choice (on) is kept")
        flip(hide)
    }

    /// ✕ or a failed check at each step of Set Up App Lock leaves App Lock off, with nothing saved; a mismatch goes back
    /// to the first entry.
    func testCancellingSetUpAtEachStepChangesNothing() {
        let app = launch([])
        openPrivacy(app)
        openAppLock(app)
        let lock = app.switches["privacy-lock"]
        let sheet = app.navigationBars["Set Up App Lock"]
        // A2: ✕.
        flip(lock)
        XCTAssertTrue(sheet.waitForExistence(timeout: 5), labels(app))
        app.buttons["lock-sheet-cancel"].tap()
        XCTAssertTrue(gone(sheet) && waitFor(lock, value: "0"), labels(app))
        // A8: back, then ✕.
        flip(lock)
        XCTAssertTrue(sheet.waitForExistence(timeout: 5))
        app.buttons["setup-app-passcode"].tap()
        XCTAssertTrue(app.buttons["setup-app-passcode"].isSelected)
        app.buttons["setup-continue"].tap()
        XCTAssertTrue(app.staticTexts["Create your app passcode"].waitForExistence(timeout: 5), labels(app))
        for text in ["It's the only way into the app.", "Every time you open the app", "Face ID and your iPhone passcode won't open it.",
                     "Ask for a reset. After 24 hours you choose a new app passcode.", "Why the wait"] {
            XCTAssertTrue(shows(app, text), "A8 \(text): \(labels(app))")
        }
        shot(app, "a8-app-passcode")
        back(app)
        XCTAssertTrue(sheet.waitForExistence(timeout: 5))
        app.buttons["lock-sheet-cancel"].tap()
        XCTAssertTrue(gone(sheet) && waitFor(lock, value: "0"), labels(app))
        // A8 → 5 → 6, a mismatch back to 5, then back out of every screen and ✕.
        flip(lock)
        XCTAssertTrue(sheet.waitForExistence(timeout: 5))
        app.buttons["setup-app-passcode"].tap(); app.buttons["setup-continue"].tap()
        XCTAssertTrue(app.buttons["setup-create-app-passcode"].waitForExistence(timeout: 5))
        app.buttons["setup-create-app-passcode"].tap()
        XCTAssertFalse(app.buttons["fake-auth-ok"].waitForExistence(timeout: 2), "App Passcode: no Face ID or iPhone passcode check")
        XCTAssertTrue(app.staticTexts["Enter a six-digit passcode"].waitForExistence(timeout: 5), labels(app))
        XCTAssertTrue(app.staticTexts["You'll enter it each time you open the app."].exists, labels(app))
        shot(app, "a8-enter")
        enterCode(app, "246802")
        XCTAssertTrue(app.staticTexts["Enter it again"].waitForExistence(timeout: 5), labels(app))
        XCTAssertEqual(value(lock), "0", "Still off part-way")
        enterCode(app, "246803")
        XCTAssertTrue(app.staticTexts["The passcodes didn't match. Try again."].waitForExistence(timeout: 5), labels(app))
        XCTAssertTrue(app.staticTexts["Enter a six-digit passcode"].exists, "A mismatch returns to 5")
        enterCode(app, "246802")
        XCTAssertTrue(app.staticTexts["Enter it again"].waitForExistence(timeout: 5), labels(app))
        back(app)
        XCTAssertTrue(app.staticTexts["Enter a six-digit passcode"].waitForExistence(timeout: 5), "Back from 6 returns to 5: \(labels(app))")
        back(app); back(app)
        XCTAssertTrue(sheet.waitForExistence(timeout: 5), labels(app))
        app.buttons["lock-sheet-cancel"].tap()
        XCTAssertTrue(gone(sheet) && waitFor(lock, value: "0"), "Nothing saved: \(labels(app))")
        back(app)
        XCTAssertTrue(app.buttons["privacy-app-lock"].label.contains("Off"), app.buttons["privacy-app-lock"].label)
        // Nothing was saved: leaving and coming back doesn't lock.
        leaveAndReturn(app)
        XCTAssertFalse(cover(app).waitForExistence(timeout: 2), "No lock after a cancelled setup: \(labels(app))")
    }

    /// The iPhone Passcode way (A7, B2): its explainer, then on; coming back asks iOS's own check (Unlock, no keypad);
    /// Change App Passcode takes the iPhone passcode, never the old app passcode.
    func testIPhonePasscodeWay() {
        let app = launch([])
        openPrivacy(app)
        openAppLock(app)
        flip(app.switches["privacy-lock"])
        XCTAssertTrue(app.navigationBars["Set Up App Lock"].waitForExistence(timeout: 5), labels(app))
        app.buttons["setup-iphone-passcode"].tap()
        app.buttons["setup-continue"].tap()
        XCTAssertTrue(app.staticTexts["Now create an app passcode"].waitForExistence(timeout: 5), labels(app))
        for text in ["It opens the app if this iPhone's passcode is ever turned off.", "Only if this iPhone has no passcode any more.",
                     "Your iPhone passcode sets a new one straight away. With no iPhone passcode, after a 24-hour wait."] {
            XCTAssertTrue(shows(app, text), "A7 \(text): \(labels(app))")
        }
        shot(app, "a7-iphone-passcode-backup")
        app.buttons["setup-create-app-passcode"].tap()
        answer(app, true)
        XCTAssertTrue(app.staticTexts["You'll only need it if this iPhone's passcode is turned off."].waitForExistence(timeout: 5), labels(app))
        chooseCode(app, "314159")
        XCTAssertTrue(waitFor(app.switches["privacy-lock"], value: "1"), labels(app))
        XCTAssertTrue(app.buttons["unlock-iphone-passcode"].isSelected, labels(app))
        XCTAssertTrue(shows(app, "Face ID or your iPhone passcode opens the app. Your app passcode is the backup if this iPhone's passcode is turned off."), labels(app))
        shot(app, "b2-on-iphone-passcode")
        // Change App Passcode: the iPhone's own check, then the new passcode twice.
        app.buttons["privacy-change-code"].tap()
        answer(app, true)
        XCTAssertTrue(app.navigationBars["Change App Passcode"].waitForExistence(timeout: 5), labels(app))
        XCTAssertFalse(app.navigationBars["Enter Your App Passcode"].exists, "The old app passcode isn't asked in this way")
        chooseCode(app, "271828")
        XCTAssertTrue(gone(app.navigationBars["Change App Passcode"]), labels(app))
        // Away and back: iOS's own check; a cancel leaves Unlock, never a keypad.
        leaveAndReturn(app)
        XCTAssertTrue(cover(app).waitForExistence(timeout: 5), labels(app))
        answer(app, false)
        XCTAssertTrue(app.buttons["app-unlock"].waitForExistence(timeout: 5) && !app.buttons["code-key-1"].exists, labels(app))
        shot(app, "c-iphone-passcode-unlock")
        app.buttons["app-unlock"].tap(); answer(app, true)
        XCTAssertTrue(gone(cover(app)), labels(app))
    }

    /// The App Passcode way (B3, C4, D4, C5, C6): only the keypad, never Face ID; Forgot is the 24-hour wait with nothing
    /// else to check; while it waits the lock screen says so and the right passcode cancels it; started again, after 24
    /// hours (a set clock) a new passcode, again with nothing else to check.
    func testAppPasscodeWayAndItsReset() {
        var app = launch([])
        openPrivacy(app)
        openAppLock(app)
        turnOn(app, way: "app-passcode", code: "580580")
        XCTAssertTrue(app.buttons["unlock-app-passcode"].isSelected, labels(app))
        XCTAssertTrue(shows(app, "Only your app passcode opens the app. Face ID and your iPhone passcode can't."), labels(app))
        shot(app, "b3-on-app-passcode")
        // Away and back: the keypad at once, no Face ID.
        leaveAndReturn(app)
        XCTAssertTrue(app.buttons["code-key-1"].waitForExistence(timeout: 5), labels(app))
        XCTAssertFalse(app.buttons["fake-auth-ok"].waitForExistence(timeout: 2), "App Passcode: Face ID is never asked")
        XCTAssertFalse(app.buttons["lock-use-face-id"].exists, "No Use Face ID")
        XCTAssertTrue(app.staticTexts["The app is locked"].exists && app.staticTexts["Enter your app passcode"].exists, labels(app))
        shot(app, "c4-app-passcode")
        enterCode(app, "000000")
        XCTAssertTrue(app.staticTexts["That's not your app passcode."].waitForExistence(timeout: 5), labels(app))
        // Forgot: the 24-hour wait alone.
        app.buttons["lock-forgot"].tap()
        XCTAssertTrue(app.navigationBars["Forgot App Passcode"].waitForExistence(timeout: 5), labels(app))
        XCTAssertTrue(app.staticTexts["Reset your app passcode"].exists, labels(app))
        XCTAssertTrue(shows(app, "After a 24-hour wait you can choose a new app passcode."), labels(app))
        XCTAssertTrue(shows(app, "Entering your app passcode before then cancels it"), labels(app))
        shot(app, "d4-forgot-app-passcode")
        app.buttons["lock-start-reset"].tap()
        XCTAssertFalse(app.buttons["fake-auth-ok"].waitForExistence(timeout: 2), "Nothing else to check")
        let waiting = app.descendants(matching: .any)["lock-reset-waiting"]
        XCTAssertTrue(waiting.waitForExistence(timeout: 5), labels(app))
        XCTAssertTrue(shows(app, "You can choose a new app passcode from"), labels(app))
        XCTAssertTrue(shows(app, "If you didn't ask for this, enter your app passcode to cancel it."), labels(app))
        XCTAssertFalse(app.buttons["lock-cancel-reset"].exists, "No Face ID to cancel with")
        XCTAssertFalse(app.buttons["lock-forgot"].exists, "No second reset while one waits")
        shot(app, "c5-reset-waiting")
        // The right passcode cancels it and opens the app.
        enterCode(app, "580580")
        XCTAssertTrue(gone(cover(app)), labels(app))
        XCTAssertTrue(app.navigationBars["App Lock"].waitForExistence(timeout: 5), "Back where it was: \(labels(app))")
        XCTAssertFalse(app.buttons["privacy-cancel-reset"].exists, "The reset was cancelled")
        // Asked again, and this time left alone.
        leaveAndReturn(app)
        XCTAssertTrue(app.buttons["lock-forgot"].waitForExistence(timeout: 5), labels(app))
        app.buttons["lock-forgot"].tap(); app.buttons["lock-start-reset"].tap()
        XCTAssertTrue(app.descendants(matching: .any)["lock-reset-waiting"].waitForExistence(timeout: 5), labels(app))
        app.terminate()
        // 23 hours on: still waiting, still the keypad.
        app = launch(["-test-lock", "app", "-test-lock-advance", "82800"])
        XCTAssertTrue(app.descendants(matching: .any)["lock-reset-waiting"].waitForExistence(timeout: 10), "23 hours: still waiting: \(labels(app))")
        XCTAssertFalse(app.buttons["lock-choose-new-code"].exists, labels(app))
        app.terminate()
        // 24 hours on: ready, and a new passcode with nothing else to check.
        app = launch(["-test-lock", "app", "-test-lock-advance", "87000"])
        XCTAssertTrue(app.buttons["lock-choose-new-code"].waitForExistence(timeout: 10), labels(app))
        XCTAssertTrue(app.staticTexts["The 24 hours are up"].exists && app.staticTexts["You can choose a new app passcode now."].exists, labels(app))
        shot(app, "c6-reset-ready")
        app.buttons["lock-choose-new-code"].tap()
        XCTAssertFalse(app.buttons["fake-auth-ok"].waitForExistence(timeout: 2), "Nothing else to check")
        XCTAssertTrue(app.staticTexts["Enter a six-digit passcode"].waitForExistence(timeout: 5), labels(app))
        chooseCode(app, "424242")
        XCTAssertTrue(gone(cover(app)), labels(app))
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 5), "The habits are all there")
        leaveAndReturn(app)
        enterCode(app, "424242")
        XCTAssertTrue(gone(cover(app)), "The new passcode opens it")
    }

    /// Changing the everyday way on the page: each change asks the current way first (Face ID → iPhone Passcode by Face
    /// ID; iPhone Passcode → App Passcode by the iPhone's own check; App Passcode → Face ID by the app passcode, then Face
    /// ID once to trust it). The app passcode stays the same throughout. Off from the Face ID way never takes the iPhone
    /// passcode: Face ID cancelled, then the app passcode.
    func testSwitchingWays() {
        let app = launch(["-test-lock", "faceid", "-test-lock-code", "975310", "-test-lock-fresh"])
        answer(app, true)
        XCTAssertTrue(gone(cover(app)), labels(app))
        openPrivacy(app)
        openAppLock(app)
        XCTAssertTrue(app.buttons["unlock-face-id"].waitForExistence(timeout: 5) && app.buttons["unlock-face-id"].isSelected, labels(app))
        app.buttons["unlock-iphone-passcode"].tap()
        XCTAssertTrue(app.staticTexts["fake-auth-reason"].waitForExistence(timeout: 5), labels(app))
        XCTAssertEqual(app.staticTexts["fake-auth-reason"].label, "Change how the app opens")
        answer(app, true)
        XCTAssertTrue(waitForSelected(app.buttons["unlock-iphone-passcode"]), labels(app))
        app.buttons["unlock-app-passcode"].tap()
        answer(app, true)
        XCTAssertTrue(waitForSelected(app.buttons["unlock-app-passcode"]), labels(app))
        app.buttons["unlock-face-id"].tap()
        XCTAssertTrue(app.navigationBars["Enter Your App Passcode"].waitForExistence(timeout: 5), "App Passcode: its own passcode first: \(labels(app))")
        enterCodeInSheet(app, "975310")
        answer(app, true)
        XCTAssertTrue(waitForSelected(app.buttons["unlock-face-id"]), labels(app))
        // The same app passcode all along: Face ID cancelled on return, then the keypad.
        leaveAndReturn(app)
        answer(app, false)
        XCTAssertTrue(app.buttons["lock-use-face-id"].waitForExistence(timeout: 5), "Use Face ID above the keypad: \(labels(app))")
        shot(app, "c1-face-id-didnt-work")
        enterCode(app, "975310")
        XCTAssertTrue(gone(cover(app)), labels(app))
        // Off: Face ID cancelled, then the app passcode (never the iPhone passcode).
        flip(app.switches["privacy-lock"]); answer(app, false)
        XCTAssertTrue(app.navigationBars["Enter Your App Passcode"].waitForExistence(timeout: 5), labels(app))
        enterCodeInSheet(app, "975310")
        XCTAssertTrue(waitFor(app.switches["privacy-lock"], value: "0"), labels(app))
    }

    /// Face ID set up but switched off for the app in Settings (the user's iPhone, 10 Oct 2026): A3 says Face ID can't be
    /// used and offers Settings, with iPhone Passcode the default; never the old no-Face-ID shortcut. Chosen before and
    /// switched off since (B4, C2): the keypad, and the page says why. Allowed again with an untrusted passcode: Use Face
    /// ID Again.
    func testFaceIDOffForTheApp() {
        var app = launch(["-test-face", "denied"])
        openPrivacy(app)
        openAppLock(app)
        flip(app.switches["privacy-lock"])
        XCTAssertTrue(app.navigationBars["Set Up App Lock"].waitForExistence(timeout: 5), "The setup sheet, as designed: \(labels(app))")
        XCTAssertTrue(unavailable(app, "setup-face-id"), "Face ID can't be chosen: \(labels(app))")
        XCTAssertTrue(row(app, "setup-face-id").contains("Can't be used: Face ID is turned off for this app in Settings."), row(app, "setup-face-id"))
        XCTAssertTrue(app.buttons["privacy-allow-face-id"].exists, labels(app))
        XCTAssertTrue(app.buttons["setup-iphone-passcode"].isSelected, "A3: iPhone Passcode is the default")
        XCTAssertTrue(row(app, "setup-iphone-passcode").contains("Your iPhone passcode opens the app."), row(app, "setup-iphone-passcode"))
        shot(app, "a3-face-id-not-allowed")
        app.buttons["lock-sheet-cancel"].tap()
        app.terminate()
        // Chosen before, switched off since.
        app = launch(["-test-lock", "faceid", "-test-lock-code", "864200", "-test-lock-fresh", "-test-face", "denied"])
        XCTAssertTrue(cover(app).waitForExistence(timeout: 10), labels(app))
        XCTAssertFalse(app.buttons["fake-auth-ok"].waitForExistence(timeout: 2), "Face ID isn't asked while it's switched off")
        XCTAssertTrue(app.staticTexts["Face ID is turned off for the app in Settings."].exists, labels(app))
        XCTAssertFalse(app.buttons["lock-use-face-id"].exists, labels(app))
        shot(app, "c2-face-id-turned-off")
        enterCode(app, "864200")
        XCTAssertTrue(gone(cover(app)), labels(app))
        openPrivacy(app)
        XCTAssertTrue(app.buttons["privacy-app-lock"].label.contains("Opens with Face ID"), app.buttons["privacy-app-lock"].label)
        openAppLock(app)
        XCTAssertTrue(app.buttons["unlock-face-id"].waitForExistence(timeout: 5) && app.buttons["unlock-face-id"].isSelected, labels(app))
        XCTAssertTrue(row(app, "unlock-face-id").contains("Turned off for this app in Settings."), row(app, "unlock-face-id"))
        XCTAssertTrue(app.buttons["privacy-allow-face-id"].exists, labels(app))
        XCTAssertTrue(shows(app, "Until Face ID is allowed, your app passcode opens the app."), labels(app))
        XCTAssertFalse(app.buttons["privacy-use-face-id-again"].exists, "Nothing to turn back on while Face ID isn't allowed")
        shot(app, "b4-face-id-turned-off")
        app.terminate()
        // Allowed again: the passcode made meanwhile trusts no Face ID, so the keypad, then Use Face ID Again.
        app = launch(["-test-lock", "faceid", "-test-lock-code", "864200", "-test-lock-fresh", "-test-lock-untrusted"])
        XCTAssertTrue(cover(app).waitForExistence(timeout: 10), labels(app))
        XCTAssertFalse(app.buttons["lock-use-face-id"].exists, "No untrusted Face ID on the cover: \(labels(app))")
        enterCode(app, "864200")
        XCTAssertTrue(gone(cover(app)), labels(app))
        openPrivacy(app)
        openAppLock(app)
        let useAgain = app.buttons["privacy-use-face-id-again"]
        XCTAssertTrue(useAgain.waitForExistence(timeout: 5), labels(app))
        XCTAssertFalse(app.buttons["privacy-allow-face-id"].exists, labels(app))
        useAgain.tap(); answer(app, true)
        XCTAssertTrue(gone(useAgain, timeout: 5), labels(app))
        leaveAndReturn(app)
        answer(app, true)
        XCTAssertTrue(gone(cover(app)), "Face ID opens it again: \(labels(app))")
    }

    /// Face ID locked out after failed tries (not switched off): the lock screen never blames Settings; the app passcode
    /// opens it, and Face ID can still be chosen in setup (the passcode ends a lock-out).
    func testFaceIDLockedOutIsNotTurnedOff() {
        var app = launch(["-test-lock", "faceid", "-test-lock-code", "246135", "-test-lock-fresh", "-test-face", "lockout"])
        XCTAssertTrue(app.buttons["code-key-1"].waitForExistence(timeout: 10), labels(app))
        XCTAssertTrue(app.staticTexts["The app is locked"].exists, labels(app))
        XCTAssertFalse(app.staticTexts["Face ID is turned off for the app in Settings."].exists, "A lock-out isn't Settings: \(labels(app))")
        enterCode(app, "246135")
        XCTAssertTrue(gone(cover(app)), labels(app))
        app.terminate()
        app = launch(["-test-face", "lockout"])
        openPrivacy(app)
        openAppLock(app)
        flip(app.switches["privacy-lock"])
        XCTAssertTrue(app.navigationBars["Set Up App Lock"].waitForExistence(timeout: 5), labels(app))
        XCTAssertTrue(app.buttons["setup-face-id"].isEnabled && app.buttons["setup-face-id"].isSelected, labels(app))
        XCTAssertFalse(app.buttons["privacy-allow-face-id"].exists, labels(app))
    }

    /// No Face ID on this iPhone (A4): Face ID can't be chosen and says where to set it up; the iPhone Passcode way
    /// is only the passcode.
    func testNoFaceIDOnThisIPhone() {
        let app = launch(["-test-face", "none"])
        openPrivacy(app)
        XCTAssertTrue(app.buttons["privacy-app-lock"].label.contains("Lock the app with a passcode"), app.buttons["privacy-app-lock"].label)
        openAppLock(app)
        flip(app.switches["privacy-lock"])
        XCTAssertTrue(app.navigationBars["Set Up App Lock"].waitForExistence(timeout: 5), "Always the setup sheet: \(labels(app))")
        XCTAssertTrue(unavailable(app, "setup-face-id"), labels(app))
        XCTAssertTrue(row(app, "setup-face-id").contains("Not set up on this iPhone. Set it up in Settings › Face ID & Passcode."), row(app, "setup-face-id"))
        XCTAssertFalse(app.buttons["privacy-allow-face-id"].exists, "Nothing to allow")
        XCTAssertTrue(app.buttons["setup-iphone-passcode"].isSelected, labels(app))
        XCTAssertTrue(row(app, "setup-iphone-passcode").contains("Your iPhone passcode opens the app. Anyone who knows it can open the app."), row(app, "setup-iphone-passcode"))
        shot(app, "a4-no-face-id")
        app.buttons["setup-continue"].tap()
        createAppPasscode(app, "112358")
        XCTAssertTrue(waitFor(app.switches["privacy-lock"], value: "1"), labels(app))
        XCTAssertTrue(unavailable(app, "unlock-face-id"), "Face ID can't be chosen on the page either: \(labels(app))")
        XCTAssertTrue(shows(app, "Your iPhone passcode opens the app. Your app passcode is the backup if this iPhone's passcode is turned off."), labels(app))
    }

    /// An iPhone with no passcode (A5): Face ID and iPhone Passcode can't be chosen; App Lock still works with the app
    /// passcode alone (the user, 10 Oct 2026), and Forgot is the 24-hour wait.
    func testNoPasscodeUsesTheAppPasscodeAlone() {
        let app = launch(["-test-passcode", "none", "-test-face", "none"])
        openPrivacy(app)
        openAppLock(app)
        let lock = app.switches["privacy-lock"]
        XCTAssertTrue(lock.waitForExistence(timeout: 5) && lock.isEnabled, "App Lock can be turned on: \(labels(app))")
        flip(lock)
        XCTAssertTrue(app.navigationBars["Set Up App Lock"].waitForExistence(timeout: 5), labels(app))
        XCTAssertTrue(unavailable(app, "setup-face-id") && unavailable(app, "setup-iphone-passcode"), labels(app))
        XCTAssertTrue(row(app, "setup-face-id").contains("Needs a passcode on this iPhone."), row(app, "setup-face-id"))
        XCTAssertTrue(row(app, "setup-iphone-passcode").contains("This iPhone has no passcode."), row(app, "setup-iphone-passcode"))
        XCTAssertTrue(app.buttons["setup-app-passcode"].isSelected, labels(app))
        XCTAssertTrue(shows(app, "To use Face ID or your iPhone passcode, set a passcode in Settings › Face ID & Passcode."), labels(app))
        shot(app, "a5-no-passcode")
        app.buttons["setup-continue"].tap()
        createAppPasscode(app, "909090", ownerCheck: false)
        XCTAssertTrue(waitFor(lock, value: "1"), labels(app))
        XCTAssertTrue(app.buttons["unlock-app-passcode"].isSelected, labels(app))
        leaveAndReturn(app)
        XCTAssertTrue(app.buttons["code-key-1"].waitForExistence(timeout: 5), labels(app))
        app.buttons["lock-forgot"].tap()
        XCTAssertTrue(shows(app, "After a 24-hour wait you can choose a new app passcode."), labels(app))
        app.buttons["lock-sheet-cancel"].tap()
        enterCode(app, "909090")
        XCTAssertTrue(gone(cover(app)), labels(app))
    }

    /// The iPhone passcode turned off after the iPhone Passcode way was chosen (C3): the backup app passcode opens the
    /// app, Forgot is the wait alone. A lock made before round 2 with no app passcode, on an iPhone with no passcode:
    /// nothing can check anyone, so it opens (never a lock-out) and the page offers Create App Passcode.
    func testIPhonePasscodeTurnedOff() {
        var app = launch(["-test-lock", "iphone", "-test-lock-code", "314159", "-test-lock-fresh", "-test-passcode", "none"])
        XCTAssertTrue(app.staticTexts["This iPhone has no passcode now"].waitForExistence(timeout: 10), labels(app))
        XCTAssertTrue(app.buttons["code-key-1"].exists && !app.buttons["app-unlock"].exists, labels(app))
        shot(app, "c3-no-passcode-now")
        app.buttons["lock-forgot"].tap()
        XCTAssertTrue(shows(app, "After a 24-hour wait you can choose a new app passcode."), labels(app))
        app.buttons["lock-sheet-cancel"].tap()
        enterCode(app, "314159")
        XCTAssertTrue(gone(cover(app)), labels(app))
        openPrivacy(app)
        openAppLock(app)
        XCTAssertTrue(shows(app, "This iPhone has no passcode now. Your app passcode opens the app."), labels(app))
        app.terminate()
        app = launch(["-test-lock", "passcode", "-test-passcode", "none"])
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 10), "An older lock with nothing to check opens: \(labels(app))")
        XCTAssertFalse(cover(app).exists)
        openPrivacy(app)
        openAppLock(app)
        XCTAssertTrue(app.buttons["privacy-change-code"].label.contains("Create App Passcode"), labels(app))
        XCTAssertTrue(shows(app, "This iPhone has no passcode now, so nothing can lock the app. Create an app passcode."), labels(app))
    }

    /// A lock made before round 2 (the iPhone's own check, no app passcode): it keeps working as it did; the page offers
    /// Create App Passcode (the backup), and moving to App Passcode makes the passcode first.
    func testOlderLockUpgrades() {
        let app = launch(["-test-lock", "passcode"])
        answer(app, true)
        XCTAssertTrue(gone(cover(app)), labels(app))
        openPrivacy(app)
        openAppLock(app)
        XCTAssertTrue(app.buttons["unlock-iphone-passcode"].waitForExistence(timeout: 5) && app.buttons["unlock-iphone-passcode"].isSelected, labels(app))
        XCTAssertTrue(app.buttons["privacy-change-code"].label.contains("Create App Passcode"), labels(app))
        XCTAssertTrue(shows(app, "Create an app passcode as a backup, in case this iPhone's passcode is turned off."), labels(app))
        shot(app, "older-lock")
        app.buttons["unlock-app-passcode"].tap()
        answer(app, true)
        XCTAssertTrue(app.staticTexts["Create your app passcode"].waitForExistence(timeout: 5), "Straight to its app passcode: \(labels(app))")
        createAppPasscode(app, "777333", ownerCheck: false)
        XCTAssertTrue(waitForSelected(app.buttons["unlock-app-passcode"]), labels(app))
        XCTAssertTrue(app.buttons["privacy-change-code"].label.contains("Change App Passcode"), labels(app))
        leaveAndReturn(app)
        XCTAssertTrue(app.buttons["code-key-1"].waitForExistence(timeout: 5), labels(app))
        enterCode(app, "777333")
        XCTAssertTrue(gone(cover(app)), labels(app))
    }

    /// Wrong codes: "That's not the code."; five in a row wait a minute, the keypad says so and takes nothing; the minute
    /// passed (a set clock, T11), the right code opens. Nothing is erased.
    func testWrongCodesWaitThenTheRightCodeOpens() {
        var app = launch(["-test-lock", "code", "-test-lock-code", "112233", "-test-lock-fresh", "-test-face", "none"])
        XCTAssertTrue(cover(app).waitForExistence(timeout: 10), labels(app))
        XCTAssertFalse(app.buttons["lock-use-face-id"].exists, "No Face ID on this iPhone: no Use Face ID")
        for i in 1...4 {
            enterCode(app, "000000")
            XCTAssertTrue(app.staticTexts["That's not your app passcode."].waitForExistence(timeout: 5), "Wrong code \(i): \(labels(app))")
        }
        enterCode(app, "000000")
        XCTAssertTrue(app.staticTexts["Try again in 1 minute."].waitForExistence(timeout: 5), labels(app))
        XCTAssertFalse(app.buttons["code-key-1"].isEnabled, "The keypad waits")
        shot(app, "lock-wrong-code-wait")
        app.terminate()
        app = launch(["-test-lock", "code", "-test-face", "none", "-test-lock-advance", "70"])
        XCTAssertTrue(cover(app).waitForExistence(timeout: 10), labels(app))
        XCTAssertTrue(app.buttons["code-key-1"].isEnabled, "The minute is over: \(labels(app))")
        enterCode(app, "112233")
        XCTAssertTrue(gone(cover(app)), labels(app))
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 5))
    }

    /// Face ID changed (screens 9–10): the cover says so and asks for the app passcode; afterwards "Did you change Face
    /// ID?" with both answers.
    func testFaceIDChangedAsksForTheCodeAndThenAsks() {
        var app = launch(["-test-lock", "code", "-test-lock-code", "445566", "-test-lock-fresh"])
        answer(app, true)
        XCTAssertTrue(gone(cover(app)), labels(app))
        app.terminate()
        // Someone added a face.
        app = launch(["-test-lock", "code", "-test-face-domain", "B"])
        XCTAssertTrue(app.staticTexts["Face ID was changed"].waitForExistence(timeout: 10), labels(app))
        XCTAssertTrue(app.staticTexts["Enter your app passcode to open the app."].exists, labels(app))
        XCTAssertFalse(app.staticTexts["code-prompt"].exists || app.staticTexts["Enter your app passcode"].exists, "No second prompt above the dots")
        XCTAssertTrue(app.buttons["Forgot App Passcode?"].exists, labels(app))
        XCTAssertFalse(app.buttons["fake-auth-ok"].waitForExistence(timeout: 2), "Face ID isn't asked for after a change")
        XCTAssertFalse(app.buttons["lock-use-face-id"].exists)
        shot(app, "lock-face-id-changed")
        enterCode(app, "445566")
        let alert = app.alerts["Did you change Face ID?"]
        XCTAssertTrue(alert.waitForExistence(timeout: 5), labels(app))
        XCTAssertTrue(alert.staticTexts["If not, someone may have added their face. Turn it off and check Settings → Face ID & Passcode."].exists, labels(app))
        XCTAssertTrue(alert.buttons["Yes, Use Face ID"].exists, labels(app))
        shot(app, "lock-did-you-change-face-id")
        alert.buttons["No, Turn It Off"].tap()
        XCTAssertTrue(gone(cover(app)), labels(app))
        openPrivacy(app)
        openAppLock(app)
        XCTAssertTrue(app.buttons["privacy-use-face-id-again"].waitForExistence(timeout: 5), labels(app))
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH %@", "Face ID is off for the app.")).firstMatch.exists, labels(app))
        // Kept off: coming back asks for the code, never Face ID.
        leaveAndReturn(app)
        XCTAssertTrue(app.buttons["code-key-1"].waitForExistence(timeout: 5), labels(app))
        XCTAssertFalse(app.buttons["fake-auth-ok"].waitForExistence(timeout: 2), "Face ID stays off")
        enterCode(app, "445566")
        XCTAssertTrue(gone(cover(app)))
        app.terminate()
        // Face ID kept off: a later change has nothing to ask (only the code opens it until Use Face ID Again).
        app = launch(["-test-lock", "code", "-test-face-domain", "C"])
        XCTAssertTrue(app.buttons["code-key-1"].waitForExistence(timeout: 10), labels(app))
        XCTAssertFalse(app.buttons["fake-auth-ok"].waitForExistence(timeout: 2), "Face ID stays off")
        enterCode(app, "445566")
        XCTAssertFalse(app.alerts["Did you change Face ID?"].waitForExistence(timeout: 2), "Nothing to ask while Face ID is off")
        XCTAssertTrue(gone(cover(app)), labels(app))
        app.terminate()
        // Face ID trusted again (a fresh code), then a change, and this time Use Face ID Again: Face ID opens it next time.
        app = launch(["-test-lock", "code", "-test-lock-code", "445566", "-test-lock-fresh"])
        answer(app, true)
        XCTAssertTrue(gone(cover(app)), labels(app))
        app.terminate()
        app = launch(["-test-lock", "code", "-test-face-domain", "B"])
        XCTAssertTrue(app.buttons["code-key-1"].waitForExistence(timeout: 10), labels(app))
        enterCode(app, "445566")
        XCTAssertTrue(app.alerts["Did you change Face ID?"].waitForExistence(timeout: 5), labels(app))
        app.alerts["Did you change Face ID?"].buttons["Yes, Use Face ID"].tap()
        XCTAssertTrue(gone(cover(app)))
        leaveAndReturn(app)
        answer(app, true)
        XCTAssertTrue(gone(cover(app)), labels(app))
    }

    /// Forgot App Passcode? with Face ID: a new app passcode at once.
    func testForgotCodeWithFaceID() {
        let app = launch(["-test-lock", "code", "-test-lock-code", "778899", "-test-lock-fresh"])
        answer(app, false)
        XCTAssertTrue(app.buttons["lock-forgot"].waitForExistence(timeout: 5), labels(app))
        app.buttons["lock-forgot"].tap()
        XCTAssertTrue(app.navigationBars["Forgot App Passcode"].waitForExistence(timeout: 5), labels(app))
        XCTAssertTrue(app.staticTexts["Face ID can prove it's you."].exists, labels(app))
        shot(app, "d1-forgot-face-id")
        app.buttons["lock-forgot-face-id"].tap()
        answer(app, true)
        XCTAssertTrue(app.staticTexts["Enter a six-digit passcode"].waitForExistence(timeout: 5), labels(app))
        chooseCode(app, "102938")
        XCTAssertTrue(gone(cover(app)), labels(app))
        leaveAndReturn(app)
        answer(app, false)
        enterCode(app, "102938")
        XCTAssertTrue(gone(cover(app)), "The new code opens it")
    }

    /// Forgot App Passcode? without Face ID: the 24-hour reset. Asked (the cover says when, Cancel Reset is there); the right code
    /// cancels it; asked again, after 24 hours (a set clock) the iPhone passcode chooses a new code.
    func testForgotCodeTwentyFourHourReset() {
        var app = launch(["-test-lock", "code", "-test-lock-code", "556677", "-test-lock-fresh", "-test-face", "none"])
        XCTAssertTrue(app.buttons["lock-forgot"].waitForExistence(timeout: 10), labels(app))
        app.buttons["lock-forgot"].tap()
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH %@", "Your iPhone passcode can set a new app passcode after a 24-hour wait.")).firstMatch.waitForExistence(timeout: 5), labels(app))
        app.buttons["lock-start-reset"].tap()
        answer(app, true)
        let waiting = app.descendants(matching: .any)["lock-reset-waiting"]
        XCTAssertTrue(waiting.waitForExistence(timeout: 5), labels(app))
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label CONTAINS %@", "You can choose a new app passcode from")).firstMatch.exists, labels(app))
        XCTAssertFalse(app.buttons["lock-cancel-reset"].exists, "No Face ID to cancel with: the app passcode cancels it")
        XCTAssertTrue(shows(app, "If you didn't ask for this, enter your app passcode to cancel it."), labels(app))
        shot(app, "lock-reset-waiting")
        // The code still works throughout, and cancels the reset.
        enterCode(app, "556677")
        XCTAssertTrue(gone(cover(app)), labels(app))
        openPrivacy(app)
        openAppLock(app)
        XCTAssertFalse(app.buttons["privacy-cancel-reset"].exists, "The reset was cancelled")
        app.terminate()
        // Asked again; the next day it's ready.
        app = launch(["-test-lock", "code", "-test-face", "none"])
        XCTAssertTrue(app.buttons["lock-forgot"].waitForExistence(timeout: 10))
        app.buttons["lock-forgot"].tap(); app.buttons["lock-start-reset"].tap(); answer(app, true)
        XCTAssertTrue(app.descendants(matching: .any)["lock-reset-waiting"].waitForExistence(timeout: 5))
        app.terminate()
        app = launch(["-test-lock", "code", "-test-face", "none", "-test-lock-advance", "87000"])
        XCTAssertTrue(app.buttons["lock-choose-new-code"].waitForExistence(timeout: 10), labels(app))
        XCTAssertTrue(app.staticTexts["The 24 hours are up"].exists && app.staticTexts["Choose a new app passcode with your iPhone passcode."].exists, labels(app))
        shot(app, "lock-reset-ready")
        app.buttons["lock-choose-new-code"].tap()
        answer(app, true)
        XCTAssertTrue(app.staticTexts["Enter a six-digit passcode"].waitForExistence(timeout: 5), labels(app))
        chooseCode(app, "908070")
        XCTAssertTrue(gone(cover(app)), labels(app))
    }

    // MARK: When it asks

    /// Ask Again: Immediately asks on every return; After 1 Minute doesn't for a quick switch, and does after the minute
    /// (a set clock). The cover shows while the app isn't in front, and it never asks while the app is.
    func testAskAgainImmediatelyAndAfterAMinute() {
        var app = launch(["-test-lock", "passcode"])
        answer(app, true)
        XCTAssertTrue(gone(cover(app)))
        leaveAndReturn(app)
        answer(app, true)
        XCTAssertTrue(gone(cover(app)), "Immediately: asks on every return")
        XCTAssertFalse(app.buttons["fake-auth-ok"].waitForExistence(timeout: 3), "Never asks while the app is in front")
        app.terminate()
        app = launch(["-test-lock", "passcode", "-test-lock-ask", "60"])
        answer(app, true)
        leaveAndReturn(app)
        XCTAssertFalse(app.buttons["fake-auth-ok"].waitForExistence(timeout: 3), "After 1 Minute: a quick switch doesn't ask")
        XCTAssertFalse(cover(app).exists)
        app.terminate()
        app = launch(["-test-lock", "passcode", "-test-lock-ask", "900"])
        answer(app, true)
        leaveAndReturn(app, away: 2)
        XCTAssertFalse(app.buttons["fake-auth-ok"].waitForExistence(timeout: 3), "After 15 Minutes: a quick switch doesn't ask")
    }

    /// A cancel leaves Unlock; returning keeps the screen and the typed text (the cover sits over the app).
    func testCancelLeavesUnlockAndTypedTextIsKept() {
        let app = launch(["-test-lock", "passcode"])
        answer(app, true)
        XCTAssertTrue(gone(cover(app)), labels(app))
        // A habit's name, half typed, in the New Habit form.
        let new = app.navigationBars.buttons["New Habit"].firstMatch
        XCTAssertTrue(new.waitForExistence(timeout: 10), labels(app))
        new.tap()
        XCTAssertTrue(app.navigationBars["New"].waitForExistence(timeout: 3))
        func row(_ prefix: String) -> XCUIElement { app.buttons.matching(NSPredicate(format: "label BEGINSWITH %@", prefix)).firstMatch }
        row("Build or maintain,").tap()
        row("Check it off,").tap()
        let name = app.descendants(matching: .any)["name-field"]
        XCTAssertTrue(name.waitForExistence(timeout: 5), labels(app))
        name.tap(); name.typeText("Half typed")
        leaveAndReturn(app)
        answer(app, false)
        XCTAssertTrue(app.buttons["app-unlock"].waitForExistence(timeout: 5), "After a cancel: Unlock")
        // The cover is over the sheet: Unlock can be tapped, and the half-typed form and the keyboard can't be seen
        // (an overlay sat under the sheet, run 37883781520).
        XCTAssertTrue(app.buttons["app-unlock"].isHittable, "The cover is over the New Habit sheet: \(labels(app))")
        XCTAssertFalse(name.isHittable, "The form can't be seen over the cover")
        XCTAssertFalse(app.keyboards.firstMatch.exists, "Typing ended when it locked")
        shot(app, "lock-over-a-sheet")
        app.buttons["app-unlock"].tap()
        answer(app, true)
        XCTAssertTrue(gone(cover(app)))
        XCTAssertTrue(((name.value as? String) ?? "").contains("Half typed"), "The typed text is kept: \(name.value ?? "")")
    }

    // MARK: Every way in waits for the unlock

    /// A link (as a widget's Choose a habit sends) opens underneath the cover and shows once unlocked: Help → Widgets →
    /// "Choose a habit for a widget".
    func testALinkOpensBehindTheCoverAndShowsAfterUnlock() {
        let app = launch(["-test-lock", "passcode"])
        answer(app, true)
        XCTAssertTrue(gone(cover(app)))
        XCUIDevice.shared.press(.home)
        app.open(URL(string: "oftenenough://widgets")!)
        XCTAssertTrue(cover(app).waitForExistence(timeout: 10), "The link waits for the unlock: \(labels(app))")
        XCTAssertFalse(app.navigationBars["Help & Feedback"].isHittable && !cover(app).exists, "Nothing shows before the unlock")
        answer(app, true)
        XCTAssertTrue(gone(cover(app)))
        XCTAssertTrue(app.navigationBars["Help & Feedback"].waitForExistence(timeout: 5), labels(app))
        XCTAssertTrue(app.descendants(matching: .any)["help-topic-Choose a habit for a widget"].exists, labels(app))
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH %@", "Touch and hold the widget, tap Edit Widget")).firstMatch.exists,
                      "The topic is open: \(labels(app))")
    }

    /// Without the lock: a widget's Choose a habit opens Help → Widgets → "Choose a habit for a widget" (spec §1).
    func testWidgetChooseLinkOpensHelp() {
        let app = launch([])
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 10))
        app.open(URL(string: "oftenenough://widgets")!)
        XCTAssertTrue(app.navigationBars["Help & Feedback"].waitForExistence(timeout: 5), labels(app))
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH %@", "Touch and hold the widget, tap Edit Widget")).firstMatch.waitForExistence(timeout: 3), labels(app))
    }

    // MARK: Reminder Says

    /// The habit form's Reminders: Reminder Says, under the times, saved with the habit and shown again when editing
    /// (spec §3.7). 24 characters at most (U6).
    func testReminderSaysIsSavedWithTheHabit() {
        let app = launch(["-reminder-fake"])
        let new = app.navigationBars.buttons["New Habit"].firstMatch
        XCTAssertTrue(new.waitForExistence(timeout: 10), labels(app)); new.tap()
        func row(_ prefix: String) -> XCUIElement { app.buttons.matching(NSPredicate(format: "label BEGINSWITH %@", prefix)).firstMatch }
        row("Build or maintain,").tap(); row("Check it off,").tap()
        let name = app.descendants(matching: .any)["name-field"]
        XCTAssertTrue(name.waitForExistence(timeout: 5)); name.tap(); name.typeText("Private habit\n")
        let reminders = app.descendants(matching: .any)["reminders-row"]
        for _ in 0..<6 where !reminders.isHittable { app.swipeUp() }
        reminders.tap()
        let says = app.textFields["reminder-says-field"]
        XCTAssertFalse(says.waitForExistence(timeout: 1), "Only while there's a reminder")
        let remind = app.switches["Remind Me"]
        XCTAssertTrue(remind.waitForExistence(timeout: 5)); flip(remind)
        for _ in 0..<4 where !says.isHittable { app.swipeUp() }
        XCTAssertTrue(says.isHittable, labels(app))
        XCTAssertTrue(app.staticTexts["Shown in this habit's reminders. When names are hidden outside the app, it's shown instead of the name."].exists, labels(app))
        says.tap(); says.typeText("Evening check-in, the long version")
        // The field catches up after the last key (run 37889767163 read it mid-way: "Evening check-in").
        XCTAssertTrue(waitFor(says, value: "Evening check-in, the lo"), "Cut at 24 characters: \(value(says))")
        shot(app, "reminder-says")
        app.navigationBars.buttons.element(boundBy: 0).tap()
        app.navigationBars["New Habit"].buttons["Add"].tap()
        XCTAssertTrue(app.navigationBars["New Habit"].waitForNonExistence(timeout: 5), labels(app))
        let row = app.staticTexts["Private habit"].firstMatch
        XCTAssertTrue(row.waitForExistence(timeout: 5)); row.press(forDuration: 1.0)
        let edit = app.buttons["Edit Habit"].firstMatch
        XCTAssertTrue(edit.waitForExistence(timeout: 5), "The touch-and-hold menu: \(labels(app))")
        edit.tap()
        XCTAssertTrue(app.navigationBars["Edit Habit"].waitForExistence(timeout: 5))
        for _ in 0..<6 where !reminders.isHittable { app.swipeUp() }
        reminders.tap()
        for _ in 0..<4 where !says.isHittable { app.swipeUp() }
        XCTAssertEqual(says.value as? String, "Evening check-in, the lo", "Saved with the habit")
    }
}
