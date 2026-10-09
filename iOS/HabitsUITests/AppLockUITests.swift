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
    private func answer(_ app: XCUIApplication, _ ok: Bool, file: StaticString = #filePath, line: UInt = #line) {
        let button = app.buttons[ok ? "fake-auth-ok" : "fake-auth-cancel"]
        XCTAssertTrue(button.waitForExistence(timeout: 10), "No Face ID prompt: \(labels(app))", file: file, line: line)
        button.tap()
    }

    private func enterCode(_ app: XCUIApplication, _ code: String) {
        for digit in code { app.buttons["code-key-\(digit)"].tap() }
    }

    private func openPrivacy(_ app: XCUIApplication) {
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 15), labels(app))
        app.buttons["menu-button"].tap()
        XCTAssertTrue(app.buttons["menu-privacy"].waitForExistence(timeout: 5))
        app.buttons["menu-privacy"].tap()
        XCTAssertTrue(app.navigationBars["Privacy & Security"].waitForExistence(timeout: 5), labels(app))
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

    /// Lock on and off (Face ID asked each time), Hide Names held on while locked and given back after, the menu without
    /// Widgets, Ask Again's three choices.
    func testLockOnAndOffAndHideNamesFollows() {
        let app = launch([])
        openPrivacy(app)
        let lock = app.switches["privacy-lock"], hide = app.switches["privacy-hide-names"]
        XCTAssertTrue(lock.waitForExistence(timeout: 5) && hide.exists, labels(app))
        XCTAssertEqual(value(lock), "0"); XCTAssertEqual(value(hide), "0")
        XCTAssertTrue(hide.isEnabled, "Hide Names is the person's own switch while unlocked")
        // The switch alone.
        flip(hide)
        XCTAssertTrue(waitFor(hide, value: "1"))
        flip(hide)
        XCTAssertTrue(waitFor(hide, value: "0"))
        // A cancelled Face ID changes nothing.
        flip(lock); answer(app, false)
        XCTAssertTrue(waitFor(lock, value: "0"), "A cancelled Face ID leaves the lock off")
        flip(lock); answer(app, true)
        XCTAssertTrue(waitFor(lock, value: "1"), labels(app))
        XCTAssertTrue(waitFor(hide, value: "1") && !hide.isEnabled, "App Lock turns Hide Names on and holds it")
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH %@", "On while App Lock is on.")).firstMatch.exists, labels(app))
        XCTAssertTrue(app.buttons["privacy-unlock-with"].exists && app.buttons["privacy-ask-again"].exists, labels(app))
        shot(app, "privacy-lock-on")
        // Ask Again.
        app.buttons["privacy-ask-again"].tap()
        XCTAssertTrue(app.buttons["ask-again-0"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons["ask-again-0"].isSelected, "Immediately is the default")
        app.buttons["ask-again-900"].tap()
        XCTAssertTrue(app.buttons["ask-again-900"].isSelected)
        app.buttons["ask-again-60"].tap()
        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssertTrue(app.buttons["privacy-ask-again"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons["privacy-ask-again"].label.contains("After 1 Minute"), app.buttons["privacy-ask-again"].label)
        // Off again: Face ID, and Hide Names back to the person's own choice (off).
        flip(lock); answer(app, true)
        XCTAssertTrue(waitFor(lock, value: "0"))
        XCTAssertTrue(waitFor(hide, value: "0") && hide.isEnabled, "Turning the lock off gives back the person's choice")
        // The person's choice on, then the lock on and off: still on.
        flip(hide); XCTAssertTrue(waitFor(hide, value: "1"))
        flip(lock); answer(app, true); XCTAssertTrue(waitFor(lock, value: "1"))
        flip(lock); answer(app, true); XCTAssertTrue(waitFor(lock, value: "0"))
        XCTAssertTrue(waitFor(hide, value: "1"), "The person's own choice (on) is kept")
        flip(hide)
    }

    /// Unlock With → Often Enough Code: Face ID once, Your Own Code, the code twice (a mismatch says so); then the cover asks
    /// Face ID, and after a cancel the keypad: wrong, then right, back to the same page.
    func testChooseCodeThenUnlockWithIt() {
        let app = launch([])
        openPrivacy(app)
        flip(app.switches["privacy-lock"]); answer(app, true)
        XCTAssertTrue(waitFor(app.switches["privacy-lock"], value: "1"))
        app.buttons["privacy-unlock-with"].tap()
        XCTAssertTrue(app.buttons["unlock-with-code"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["Choose an Often Enough code if people around you know your iPhone passcode."].exists, labels(app))
        app.buttons["unlock-with-code"].tap()
        answer(app, true)
        XCTAssertTrue(app.navigationBars["Your Own Code"].waitForExistence(timeout: 5), labels(app))
        XCTAssertTrue(app.staticTexts["Only Face ID or this code opens Often Enough. Your iPhone passcode won't."].exists, labels(app))
        shot(app, "lock-your-own-code")
        app.buttons["lock-choose-code"].tap()
        XCTAssertTrue(app.staticTexts["Enter a code"].waitForExistence(timeout: 5))
        enterCode(app, "135790")
        XCTAssertTrue(app.staticTexts["Enter it again"].waitForExistence(timeout: 5))
        enterCode(app, "135791")
        XCTAssertTrue(app.staticTexts["The two codes are different. Try again."].waitForExistence(timeout: 5), labels(app))
        enterCode(app, "135790"); enterCode(app, "135790")
        XCTAssertTrue(gone(app.navigationBars["Your Own Code"]), labels(app))
        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssertTrue(app.buttons["privacy-unlock-with"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons["privacy-unlock-with"].label.contains("Often Enough Code"), app.buttons["privacy-unlock-with"].label)
        XCTAssertTrue(app.buttons["privacy-change-code"].exists, labels(app))
        // Away and back: Face ID first; cancelled, the keypad.
        leaveAndReturn(app)
        XCTAssertTrue(cover(app).waitForExistence(timeout: 5), labels(app))
        answer(app, false)
        XCTAssertTrue(app.buttons["code-key-1"].waitForExistence(timeout: 5) && app.buttons["lock-forgot"].exists, labels(app))
        XCTAssertTrue(app.buttons["lock-use-face-id"].exists, "Use Face ID above the keypad when Face ID can be used")
        shot(app, "lock-cover-keypad")
        enterCode(app, "000000")
        XCTAssertTrue(app.staticTexts["That's not the code."].waitForExistence(timeout: 5), labels(app))
        enterCode(app, "135790")
        XCTAssertTrue(gone(cover(app)), labels(app))
        XCTAssertTrue(app.navigationBars["Privacy & Security"].exists, "Back on the same page")
        // Turning the lock off in code mode: Face ID cancelled, then the code (never the iPhone passcode).
        flip(app.switches["privacy-lock"]); answer(app, false)
        XCTAssertTrue(app.staticTexts["Enter your Often Enough code"].waitForExistence(timeout: 5), labels(app))
        enterCode(app, "135790")
        XCTAssertTrue(waitFor(app.switches["privacy-lock"], value: "0"), labels(app))
    }

    /// Wrong codes: "That's not the code."; five in a row wait a minute, the keypad says so and takes nothing; the minute
    /// passed (a set clock, T11), the right code opens. Nothing is erased.
    func testWrongCodesWaitThenTheRightCodeOpens() {
        var app = launch(["-test-lock", "code", "-test-lock-code", "112233", "-test-lock-fresh", "-test-face", "none"])
        XCTAssertTrue(cover(app).waitForExistence(timeout: 10), labels(app))
        XCTAssertFalse(app.buttons["lock-use-face-id"].exists, "No Face ID on this iPhone: no Use Face ID")
        for i in 1...4 {
            enterCode(app, "000000")
            XCTAssertTrue(app.staticTexts["That's not the code."].waitForExistence(timeout: 5), "Wrong code \(i): \(labels(app))")
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

    /// Face ID changed: the cover says so and asks for the code; afterwards "Use Face ID again?" with both answers.
    func testFaceIDChangedAsksForTheCodeAndThenAsks() {
        var app = launch(["-test-lock", "code", "-test-lock-code", "445566", "-test-lock-fresh"])
        answer(app, true)
        XCTAssertTrue(gone(cover(app)), labels(app))
        app.terminate()
        // Someone added a face.
        app = launch(["-test-lock", "code", "-test-face-domain", "B"])
        XCTAssertTrue(app.staticTexts["Face ID has changed on this iPhone"].waitForExistence(timeout: 10), labels(app))
        XCTAssertFalse(app.buttons["fake-auth-ok"].waitForExistence(timeout: 2), "Face ID isn't asked for after a change")
        XCTAssertFalse(app.buttons["lock-use-face-id"].exists)
        shot(app, "lock-face-id-changed")
        enterCode(app, "445566")
        let alert = app.alerts["Use Face ID again?"]
        XCTAssertTrue(alert.waitForExistence(timeout: 5), labels(app))
        alert.buttons["Keep Face ID Off"].tap()
        XCTAssertTrue(gone(cover(app)), labels(app))
        openPrivacy(app)
        XCTAssertTrue(app.buttons["privacy-use-face-id-again"].waitForExistence(timeout: 5), labels(app))
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH %@", "Face ID is off for Often Enough.")).firstMatch.exists, labels(app))
        // Kept off: coming back asks for the code, never Face ID.
        leaveAndReturn(app)
        XCTAssertTrue(app.buttons["code-key-1"].waitForExistence(timeout: 5), labels(app))
        XCTAssertFalse(app.buttons["fake-auth-ok"].waitForExistence(timeout: 2), "Face ID stays off")
        enterCode(app, "445566")
        XCTAssertTrue(gone(cover(app)))
        app.terminate()
        // Another change, and this time Use Face ID Again: Face ID opens it next time.
        app = launch(["-test-lock", "code", "-test-face-domain", "C"])
        XCTAssertTrue(app.buttons["code-key-1"].waitForExistence(timeout: 10), labels(app))
        enterCode(app, "445566")
        XCTAssertTrue(app.alerts["Use Face ID again?"].waitForExistence(timeout: 5))
        app.alerts["Use Face ID again?"].buttons["Use Face ID Again"].tap()
        XCTAssertTrue(gone(cover(app)))
        leaveAndReturn(app)
        answer(app, true)
        XCTAssertTrue(gone(cover(app)), labels(app))
    }

    /// Forgot Code? with Face ID: a new code at once.
    func testForgotCodeWithFaceID() {
        let app = launch(["-test-lock", "code", "-test-lock-code", "778899", "-test-lock-fresh"])
        answer(app, false)
        XCTAssertTrue(app.buttons["lock-forgot"].waitForExistence(timeout: 5), labels(app))
        app.buttons["lock-forgot"].tap()
        XCTAssertTrue(app.navigationBars["Forgot Your Code"].waitForExistence(timeout: 5), labels(app))
        XCTAssertTrue(app.staticTexts["Use Face ID to choose a new code."].exists, labels(app))
        app.buttons["lock-forgot-face-id"].tap()
        answer(app, true)
        XCTAssertTrue(app.staticTexts["Enter a code"].waitForExistence(timeout: 5), labels(app))
        enterCode(app, "102938"); enterCode(app, "102938")
        XCTAssertTrue(gone(cover(app)), labels(app))
        leaveAndReturn(app)
        answer(app, false)
        enterCode(app, "102938")
        XCTAssertTrue(gone(cover(app)), "The new code opens it")
    }

    /// Forgot Code? without Face ID: the 24-hour reset. Asked (the cover says when, Cancel Reset is there); the right code
    /// cancels it; asked again, after 24 hours (a set clock) the iPhone passcode chooses a new code.
    func testForgotCodeTwentyFourHourReset() {
        var app = launch(["-test-lock", "code", "-test-lock-code", "556677", "-test-lock-fresh", "-test-face", "none"])
        XCTAssertTrue(app.buttons["lock-forgot"].waitForExistence(timeout: 10), labels(app))
        app.buttons["lock-forgot"].tap()
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH %@", "Your iPhone passcode can reset the code after a 24-hour wait.")).firstMatch.waitForExistence(timeout: 5), labels(app))
        app.buttons["lock-start-reset"].tap()
        answer(app, true)
        let waiting = app.descendants(matching: .any)["lock-reset-waiting"]
        XCTAssertTrue(waiting.waitForExistence(timeout: 5), labels(app))
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label CONTAINS %@", "You can choose a new code from")).firstMatch.exists, labels(app))
        XCTAssertTrue(app.buttons["lock-cancel-reset"].exists)
        shot(app, "lock-reset-waiting")
        // The code still works throughout, and cancels the reset.
        enterCode(app, "556677")
        XCTAssertTrue(gone(cover(app)), labels(app))
        openPrivacy(app)
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
        shot(app, "lock-reset-ready")
        app.buttons["lock-choose-new-code"].tap()
        answer(app, true)
        XCTAssertTrue(app.staticTexts["Enter a code"].waitForExistence(timeout: 5), labels(app))
        enterCode(app, "908070"); enterCode(app, "908070")
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
        XCTAssertEqual(says.value as? String, "Evening check-in, the lo", "Cut at 24 characters")
        shot(app, "reminder-says")
        app.navigationBars.buttons.element(boundBy: 0).tap()
        app.navigationBars["New Habit"].buttons["Add"].tap()
        XCTAssertTrue(app.navigationBars["New Habit"].waitForNonExistence(timeout: 5), labels(app))
        let row = app.staticTexts["Private habit"].firstMatch
        XCTAssertTrue(row.waitForExistence(timeout: 5)); row.press(forDuration: 1.0)
        app.buttons["Edit Habit"].firstMatch.tap()
        XCTAssertTrue(app.navigationBars["Edit Habit"].waitForExistence(timeout: 5))
        for _ in 0..<6 where !reminders.isHittable { app.swipeUp() }
        reminders.tap()
        for _ in 0..<4 where !says.isHittable { app.swipeUp() }
        XCTAssertEqual(says.value as? String, "Evening check-in, the lo", "Saved with the habit")
    }
}
