import XCTest

/// App Lock, Privacy & Security and Hide Names Outside the App (Current Work 58; spec "Privacy & Security — What to
/// Build"). Test launches never use the person's lock (D8): `-test-lock passcode|code` turns on the test's own lock, with
/// its own Keychain item, and a test Face ID panel (`fake-auth`) answers in place of the system's prompt.
/// `-test-face none` is an iPhone without Face ID, `-test-face-domain B` one whose faces changed, and
/// `-test-lock-advance N` moves the lock's clock on N seconds (T11).
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

    /// The switch, then Set Up App Lock with iPhone Passcode (the default): Turn On App Lock and Face ID.
    private func turnOnWithIPhonePasscode(_ app: XCUIApplication, file: StaticString = #filePath, line: UInt = #line) {
        flip(app.switches["privacy-lock"])
        XCTAssertTrue(app.navigationBars["Set Up App Lock"].waitForExistence(timeout: 5), labels(app), file: file, line: line)
        app.buttons["setup-turn-on"].tap()
        answer(app, true, file: file, line: line)
        XCTAssertTrue(gone(app.navigationBars["Set Up App Lock"]), labels(app), file: file, line: line)
        XCTAssertTrue(waitFor(app.switches["privacy-lock"], value: "1"), labels(app), file: file, line: line)
    }

    /// From the explainer (screen 4): Create App Passcode, Face ID, the passcode twice.
    private func createAppPasscode(_ app: XCUIApplication, _ code: String, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertTrue(app.staticTexts["How your app passcode works"].waitForExistence(timeout: 5), labels(app), file: file, line: line)
        app.buttons["setup-create-app-passcode"].tap()
        answer(app, true, file: file, line: line)
        XCTAssertTrue(app.staticTexts["Enter a six-digit passcode"].waitForExistence(timeout: 5), labels(app), file: file, line: line)
        chooseCode(app, code, file: file, line: line)
    }

    private func flip(_ toggle: XCUIElement) {
        toggle.coordinate(withNormalizedOffset: CGVector(dx: 0.92, dy: 0.5)).tap()
    }

    private func value(_ element: XCUIElement) -> String { element.value as? String ?? "" }

    private func waitFor(_ element: XCUIElement, value expected: String, timeout: TimeInterval = 5) -> Bool {
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: "value == %@", expected), object: element)
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

    // MARK: The page

    /// The App Lock row says Off; the switch opens Set Up App Lock and stays off until it's done (a cancelled Face ID
    /// changes nothing); on with iPhone Passcode, Hide Names is held on and the row says On; Lock Again is a menu; off
    /// again, Hide Names goes back to the person's own choice.
    func testLockOnAndOffAndHideNamesFollows() {
        let app = launch([])
        openPrivacy(app)
        let row = app.buttons["privacy-app-lock"], hide = app.switches["privacy-hide-names"]
        XCTAssertTrue(row.waitForExistence(timeout: 5) && hide.exists, labels(app))
        XCTAssertTrue(row.label.contains("Off") && row.label.contains("Lock the app with Face ID"), row.label)
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
        XCTAssertEqual(value(lock), "0", "Off by default")
        XCTAssertFalse(app.buttons["unlock-iphone-passcode"].exists || app.buttons["privacy-lock-again"].exists, "Options only once it's on")
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH %@", "The app will ask for Face ID each time you open it.")).firstMatch.exists, labels(app))
        shot(app, "app-lock-off")
        // On: the sheet first; the switch stays off meanwhile.
        flip(lock)
        XCTAssertTrue(app.navigationBars["Set Up App Lock"].waitForExistence(timeout: 5), labels(app))
        XCTAssertTrue(app.staticTexts["If Face ID doesn't work"].exists, labels(app))
        XCTAssertTrue(app.buttons["setup-iphone-passcode"].isSelected, "iPhone Passcode is the default")
        XCTAssertFalse(app.staticTexts["Recommended"].exists, "No badge")
        shot(app, "app-lock-setup")
        // A cancelled Face ID: still on the sheet, nothing changed.
        app.buttons["setup-turn-on"].tap()
        answer(app, false)
        XCTAssertTrue(app.navigationBars["Set Up App Lock"].exists, "A cancelled Face ID stays on the sheet")
        app.buttons["setup-turn-on"].tap()
        answer(app, true)
        XCTAssertTrue(gone(app.navigationBars["Set Up App Lock"]), labels(app))
        XCTAssertTrue(waitFor(lock, value: "1"), labels(app))
        XCTAssertTrue(app.buttons["unlock-iphone-passcode"].isSelected && !app.buttons["unlock-app-passcode"].isSelected, labels(app))
        XCTAssertTrue(app.staticTexts["Anyone who knows your iPhone passcode can open the app."].exists, labels(app))
        XCTAssertFalse(app.buttons["privacy-change-code"].exists, "No Change App Passcode in iPhone-passcode mode")
        shot(app, "app-lock-on-iphone-passcode")
        // Lock Again: a menu in its row.
        let again = app.buttons["privacy-lock-again"]
        XCTAssertTrue(again.waitForExistence(timeout: 5), labels(app))
        XCTAssertTrue((again.label + " " + value(again)).contains("Immediately"), "Immediately is the default: \(again.label) \(value(again))")
        again.tap()
        let fifteen = app.buttons["After 15 Minutes"]
        XCTAssertTrue(fifteen.waitForExistence(timeout: 5), labels(app))
        fifteen.tap()
        XCTAssertTrue(gone(fifteen, timeout: 3))
        XCTAssertTrue((again.label + " " + value(again)).contains("After 15 Minutes"), "\(again.label) \(value(again))")
        again.tap()
        XCTAssertTrue(app.buttons["After 1 Minute"].waitForExistence(timeout: 5)); app.buttons["After 1 Minute"].tap()
        XCTAssertTrue((again.label + " " + value(again)).contains("After 1 Minute"), "\(again.label) \(value(again))")
        back(app)
        XCTAssertTrue(waitFor(hide, value: "1") && !hide.isEnabled, "App Lock turns Hide Names on and holds it")
        XCTAssertTrue(app.buttons["privacy-app-lock"].label.contains("On"), app.buttons["privacy-app-lock"].label)
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH %@", "On while App Lock is on.")).firstMatch.exists, labels(app))
        shot(app, "privacy-app-lock-on")
        // Off again: Face ID, and Hide Names back to the person's own choice (off).
        openAppLock(app)
        flip(lock); answer(app, true)
        XCTAssertTrue(waitFor(lock, value: "0"))
        XCTAssertFalse(app.buttons["privacy-lock-again"].exists, "The page collapses back")
        back(app)
        XCTAssertTrue(waitFor(hide, value: "0") && hide.isEnabled, "Turning the lock off gives back the person's choice")
        // The person's choice on, then the lock on and off: still on.
        flip(hide); XCTAssertTrue(waitFor(hide, value: "1"))
        openAppLock(app)
        turnOnWithIPhonePasscode(app)
        flip(lock); answer(app, true); XCTAssertTrue(waitFor(lock, value: "0"))
        back(app)
        XCTAssertTrue(waitFor(hide, value: "1"), "The person's own choice (on) is kept")
        flip(hide)
    }

    /// ✕ or a failed check at each step of Set Up App Lock leaves App Lock off, with nothing saved.
    func testCancellingSetUpAtEachStepChangesNothing() {
        let app = launch([])
        openPrivacy(app)
        openAppLock(app)
        let lock = app.switches["privacy-lock"]
        let sheet = app.navigationBars["Set Up App Lock"]
        // Screen 3: ✕.
        flip(lock)
        XCTAssertTrue(sheet.waitForExistence(timeout: 5), labels(app))
        app.buttons["lock-sheet-cancel"].tap()
        XCTAssertTrue(gone(sheet) && waitFor(lock, value: "0"), labels(app))
        // Screen 4: back, then ✕.
        flip(lock)
        XCTAssertTrue(sheet.waitForExistence(timeout: 5))
        app.buttons["setup-app-passcode"].tap()
        XCTAssertTrue(app.buttons["setup-app-passcode"].isSelected)
        app.buttons["setup-continue"].tap()
        XCTAssertTrue(app.staticTexts["How your app passcode works"].waitForExistence(timeout: 5), labels(app))
        for text in ["If you forget it", "Use Face ID to choose a new app passcode.", "If Face ID changes", "If you forget it and Face ID can't help",
                     "Your habits are never deleted, whatever happens."] {
            XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label CONTAINS %@", text)).firstMatch.exists, "\(text): \(labels(app))")
        }
        shot(app, "app-lock-how-it-works")
        back(app)
        XCTAssertTrue(sheet.waitForExistence(timeout: 5))
        app.buttons["lock-sheet-cancel"].tap()
        XCTAssertTrue(gone(sheet) && waitFor(lock, value: "0"), labels(app))
        // Screen 4: the owner check cancelled stays there.
        flip(lock)
        XCTAssertTrue(sheet.waitForExistence(timeout: 5))
        app.buttons["setup-app-passcode"].tap(); app.buttons["setup-continue"].tap()
        XCTAssertTrue(app.buttons["setup-create-app-passcode"].waitForExistence(timeout: 5))
        app.buttons["setup-create-app-passcode"].tap()
        answer(app, false)
        XCTAssertTrue(app.staticTexts["How your app passcode works"].exists && !app.staticTexts["Enter a six-digit passcode"].exists, labels(app))
        // Screens 5 and 6: a passcode once, then back out of every screen and ✕.
        app.buttons["setup-create-app-passcode"].tap()
        answer(app, true)
        XCTAssertTrue(app.staticTexts["Enter a six-digit passcode"].waitForExistence(timeout: 5), labels(app))
        XCTAssertTrue(app.staticTexts["You'll only need it when Face ID doesn't work."].exists, labels(app))
        shot(app, "app-lock-enter")
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
    }

    /// App Passcode through screens 3 → 4 → 5 → 6, a mismatch back to 5; then the cover asks Face ID, and after a
    /// cancel the keypad: wrong, then right, back to the same page. Off again in app-passcode mode takes the app passcode.
    func testChooseCodeThenUnlockWithIt() {
        let app = launch([])
        openPrivacy(app)
        openAppLock(app)
        flip(app.switches["privacy-lock"])
        XCTAssertTrue(app.navigationBars["Set Up App Lock"].waitForExistence(timeout: 5), labels(app))
        app.buttons["setup-app-passcode"].tap()
        XCTAssertTrue(app.buttons["setup-continue"].waitForExistence(timeout: 3), "App Passcode: the button says Continue")
        app.buttons["setup-continue"].tap()
        XCTAssertTrue(app.buttons["setup-create-app-passcode"].waitForExistence(timeout: 5), labels(app))
        app.buttons["setup-create-app-passcode"].tap()
        answer(app, true)
        XCTAssertTrue(app.staticTexts["Enter a six-digit passcode"].waitForExistence(timeout: 5))
        enterCode(app, "135790")
        XCTAssertTrue(app.staticTexts["Enter it again"].waitForExistence(timeout: 5))
        XCTAssertEqual(value(app.switches["privacy-lock"]), "0", "Still off part-way")
        enterCode(app, "135791")
        XCTAssertTrue(app.staticTexts["The passcodes didn't match. Try again."].waitForExistence(timeout: 5), labels(app))
        XCTAssertTrue(app.staticTexts["Enter a six-digit passcode"].exists, "A mismatch returns to 5")
        chooseCode(app, "135790")
        XCTAssertTrue(gone(app.navigationBars["Set Up App Lock"]), labels(app))
        XCTAssertTrue(waitFor(app.switches["privacy-lock"], value: "1"), labels(app))
        XCTAssertTrue(app.buttons["unlock-app-passcode"].isSelected, labels(app))
        XCTAssertTrue(app.staticTexts["Only Face ID or your app passcode opens the app. Your iPhone passcode can't."].exists, labels(app))
        XCTAssertTrue(app.buttons["privacy-change-code"].exists, labels(app))
        shot(app, "app-lock-on-app-passcode")
        // Away and back: Face ID first; cancelled, the keypad.
        leaveAndReturn(app)
        XCTAssertTrue(cover(app).waitForExistence(timeout: 5), labels(app))
        answer(app, false)
        XCTAssertTrue(app.buttons["code-key-1"].waitForExistence(timeout: 5) && app.buttons["lock-forgot"].exists, labels(app))
        XCTAssertTrue(app.staticTexts["The app is locked"].exists && app.staticTexts["Enter your app passcode"].exists, labels(app))
        XCTAssertTrue(app.buttons["Forgot App Passcode?"].exists, labels(app))
        XCTAssertTrue(app.buttons["lock-use-face-id"].exists, "Use Face ID above the keypad when Face ID can be used")
        shot(app, "lock-cover-keypad")
        enterCode(app, "000000")
        XCTAssertTrue(app.staticTexts["That's not your app passcode."].waitForExistence(timeout: 5), labels(app))
        enterCode(app, "135790")
        XCTAssertTrue(gone(cover(app)), labels(app))
        XCTAssertTrue(app.navigationBars["App Lock"].exists, "Back on the same page")
        // Change App Passcode: Face ID, then the passcode twice in its own sheet.
        app.buttons["privacy-change-code"].tap()
        answer(app, true)
        XCTAssertTrue(app.navigationBars["Change App Passcode"].waitForExistence(timeout: 5), labels(app))
        chooseCode(app, "246813")
        XCTAssertTrue(gone(app.navigationBars["Change App Passcode"]), labels(app))
        // Turning the lock off in app-passcode mode: Face ID cancelled, then the app passcode (never the iPhone passcode).
        flip(app.switches["privacy-lock"]); answer(app, false)
        XCTAssertTrue(app.staticTexts["Enter your app passcode"].waitForExistence(timeout: 5), labels(app))
        XCTAssertTrue(app.navigationBars["Enter Your App Passcode"].exists, labels(app))
        enterCode(app, "246813")
        XCTAssertTrue(waitFor(app.switches["privacy-lock"], value: "0"), labels(app))
    }

    /// If Face ID doesn't work, both ways: iPhone Passcode → App Passcode opens the sheet at "How your app passcode
    /// works"; App Passcode → iPhone Passcode takes Face ID (or the app passcode), and the passcode is gone.
    func testSwitchingModesBothWays() {
        let app = launch([])
        openPrivacy(app)
        openAppLock(app)
        turnOnWithIPhonePasscode(app)
        app.buttons["unlock-app-passcode"].tap()
        XCTAssertTrue(app.navigationBars["App Passcode"].waitForExistence(timeout: 5), "Straight to screen 4: \(labels(app))")
        XCTAssertTrue(app.buttons["lock-sheet-cancel"].exists, "✕ on the sheet's first screen")
        // ✕ keeps iPhone Passcode.
        app.buttons["lock-sheet-cancel"].tap()
        XCTAssertTrue(gone(app.navigationBars["App Passcode"]))
        XCTAssertTrue(app.buttons["unlock-iphone-passcode"].isSelected, labels(app))
        app.buttons["unlock-app-passcode"].tap()
        createAppPasscode(app, "975310")
        XCTAssertTrue(gone(app.navigationBars["App Passcode"]), labels(app))
        XCTAssertTrue(app.buttons["unlock-app-passcode"].isSelected && app.buttons["privacy-change-code"].exists, labels(app))
        XCTAssertEqual(value(app.switches["privacy-lock"]), "1")
        // Back: Face ID cancelled, then the app passcode.
        app.buttons["unlock-iphone-passcode"].tap()
        answer(app, false)
        XCTAssertTrue(app.navigationBars["Enter Your App Passcode"].waitForExistence(timeout: 5), labels(app))
        enterCode(app, "975310")
        XCTAssertTrue(gone(app.navigationBars["Enter Your App Passcode"]), labels(app))
        XCTAssertTrue(app.buttons["unlock-iphone-passcode"].isSelected, labels(app))
        XCTAssertFalse(app.buttons["privacy-change-code"].exists, "The app passcode is gone")
        XCTAssertEqual(value(app.switches["privacy-lock"]), "1", "App Lock stays on")
        // Away and back: iPhone-passcode mode asks Face ID with the passcode (no keypad).
        leaveAndReturn(app)
        XCTAssertTrue(cover(app).waitForExistence(timeout: 5), labels(app))
        answer(app, false)
        XCTAssertTrue(app.buttons["app-unlock"].waitForExistence(timeout: 5) && !app.buttons["code-key-1"].exists, labels(app))
        app.buttons["app-unlock"].tap(); answer(app, true)
        XCTAssertTrue(gone(cover(app)))
    }

    /// An iPhone with no passcode: the switch is shown, off and disabled, and the footer says why.
    func testNoPasscodeShowsWhy() {
        let app = launch(["-test-passcode", "none", "-test-face", "none"])
        openPrivacy(app)
        XCTAssertTrue(app.buttons["privacy-app-lock"].label.contains("Lock the app with your passcode"), app.buttons["privacy-app-lock"].label)
        openAppLock(app)
        let lock = app.switches["privacy-lock"]
        XCTAssertTrue(lock.waitForExistence(timeout: 5) && !lock.isEnabled, labels(app))
        XCTAssertTrue(app.staticTexts["To use App Lock, set a passcode for this iPhone first: Settings → Face ID & Passcode."].exists, labels(app))
    }

    /// An iPhone with a passcode and no Face ID or Touch ID: no sheet, iPhone-passcode mode at once.
    func testNoFaceIDTurnsOnWithThePasscode() {
        let app = launch(["-test-face", "none"])
        openPrivacy(app)
        openAppLock(app)
        let lock = app.switches["privacy-lock"]
        flip(lock)
        XCTAssertFalse(app.navigationBars["Set Up App Lock"].waitForExistence(timeout: 2), "No sheet without Face ID")
        answer(app, true)
        XCTAssertTrue(waitFor(lock, value: "1"), labels(app))
        XCTAssertFalse(app.buttons["unlock-app-passcode"].exists, "No app passcode choice without Face ID")
        XCTAssertTrue(app.buttons["privacy-lock-again"].exists, labels(app))
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
        XCTAssertTrue(app.staticTexts["Use Face ID to choose a new app passcode."].exists, labels(app))
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
        XCTAssertTrue(app.buttons["lock-cancel-reset"].exists)
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
        XCTAssertTrue(app.staticTexts["The 24 hours are up. Choose a new app passcode with your iPhone passcode."].exists, labels(app))
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
