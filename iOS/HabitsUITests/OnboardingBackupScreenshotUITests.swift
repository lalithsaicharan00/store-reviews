import XCTest

/// Current Work 73 + 3 (9 Oct 2026): every screen of the welcome and ≡ → Backup & Export, as built, for the Figma
/// page "onboarding" (first taken of the earlier welcome; the welcome's tests follow the rebuilt one, 73.1). Screenshots only: each is named in the order it's laid out (`A01-welcome-name`). A test launch
/// (`-uitest`: in-memory database, signed out), so the person's habits and account are never touched (D8).
final class OnboardingBackupScreenshotUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = true
        app = XCUIApplication()
    }

    private func launch(_ extra: [String]) {
        app.launchArguments = ["-uitest", "-appearance.theme", "light"] + extra
        app.launch()
    }

    private func shot(_ name: String) {
        sleep(1)
        let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    @discardableResult
    private func tap(_ element: XCUIElement, _ what: String) -> Bool {
        guard element.waitForExistence(timeout: 8) else {
            XCTFail("\(what) not found")
            return false
        }
        for _ in 0..<5 where !element.isHittable { app.swipeUp() }
        element.tap()
        return true
    }

    private func back() {
        let bar = app.navigationBars.firstMatch
        if bar.buttons.firstMatch.exists { bar.buttons.firstMatch.tap() }
    }

    private func closeSheet() {
        for label in ["Cancel", "Close", "Done"] {
            let button = app.navigationBars.buttons[label].firstMatch
            if button.exists { button.tap(); return }
        }
        app.swipeDown(velocity: .fast)
    }

    /// The welcome (Current Work 73.1), page by page, with what each page opens; then the empty Today.
    func testA_Welcome() {
        launch(["-empty", "-onboarding"])
        XCTAssertTrue(app.staticTexts["onboarding-page-welcome"].waitForExistence(timeout: 30))
        shot("A01-welcome")
        if tap(app.buttons["onboarding-privacy"], "Privacy link") {
            shot("A02-welcome-privacy")
            back()
        }
        tap(app.buttons["onboarding-new"], "I'm new here")
        shot("A03-included")
        tap(app.buttons["onboarding-continue"], "Continue 1")
        shot("A04-build")
        tap(app.buttons["onboarding-continue"], "Continue 2")
        shot("A05-quit")
        tap(app.buttons["onboarding-continue"], "Continue 3")
        shot("A06-tasks")
        tap(app.buttons["onboarding-continue"], "Continue 4")
        shot("A07-days")
        if tap(app.buttons["onboarding-day-start"], "Day start picker") {
            shot("A08-day-start-menu")
            app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.12)).tap()
        }
        tap(app.buttons["onboarding-continue"], "Continue 5")
        shot("A09-first-habit")
        app.swipeUp()
        shot("A10-first-habit-scrolled")
        app.swipeDown()
        if tap(app.buttons["idea-Exercise"], "Exercise idea") {
            shot("A11-idea-form")
            // The idea's form is a sheet over the welcome: its own Cancel, not the welcome's back button.
            tap(app.navigationBars["New Habit"].buttons["Cancel"], "The idea form's Cancel")
            XCTAssertTrue(app.staticTexts["onboarding-page-ideas"].waitForExistence(timeout: 5), "Cancel returns to the ideas")
        }
        if tap(app.buttons["onboarding-make-own"], "Create my own habit") {
            shot("A12-create-my-own")
            tap(app.navigationBars["New"].buttons.firstMatch, "New's back button")
            XCTAssertTrue(app.staticTexts["onboarding-page-ideas"].waitForExistence(timeout: 5), "Back returns to the ideas")
        }
        tap(app.buttons["onboarding-skip"], "Skip setup")
        XCTAssertTrue(app.staticTexts["No habits yet"].waitForExistence(timeout: 10))
        shot("A13-empty-today")
    }

    /// I've used it before: every way back and the pages each opens.
    func testB_WelcomeBack() {
        launch(["-empty", "-onboarding"])
        tap(app.buttons["onboarding-returning"], "I've used it before")
        shot("B01-welcome-back")
        tap(app.buttons["onboarding-way-sign-in"], "Sign in to your account")
        shot("B02-sign-back-in")
        back()
        tap(app.buttons["onboarding-way-restore"], "Restore a backup")
        shot("B03-restore-a-backup")
        back()
        tap(app.buttons["onboarding-way-transfer"], "Move from another device")
        shot("B04-transfer-code")
        back()
        app.terminate()
        launch(["-onboarding"])
        tap(app.buttons["onboarding-returning"], "I've used it before")
        shot("B05-welcome-back-data-found")
    }

    /// Help → Show the Welcome Again: what's included and what the app does.
    func testC_WelcomeReplay() {
        launch([])
        tap(app.buttons["menu-button"], "≡")
        tap(app.buttons["menu-help"], "Help & Feedback")
        shot("C01-help")
        if tap(app.buttons["help-welcome"], "Show the Welcome Again") {
            shot("C02-replay-included")
            tap(app.buttons["onboarding-continue"], "Continue")
            shot("C03-replay-build")
        }
    }

    /// ≡ → Backup & Export without an account (the demo habits), and every sheet and question it opens.
    func testD_BackupAndExport() {
        launch([])
        tap(app.buttons["menu-button"], "≡")
        shot("D01-sidebar")
        tap(app.buttons["menu-backup"], "Backup & Export")
        XCTAssertTrue(app.navigationBars["Backup & Export"].waitForExistence(timeout: 5))
        shot("D03-backup-export-top")

        // Restore first, while it's on screen: the erase question below is a popover with no Cancel.
        if tap(app.buttons["backup-restore"], "Restore From a Backup") {
            XCTAssertTrue(app.navigationBars["Restore From a Backup"].waitForExistence(timeout: 5))
            shot("D08-restore-from-a-backup")
            if tap(app.buttons["restore-icloud"], "Restore → iCloud") {
                shot("D09-restore-icloud")
                back()
            }
            if tap(app.buttons["restore-import"], "Backup File") {
                shot("D10-import-a-file")
                let cancel = app.buttons["Cancel"].firstMatch
                if cancel.waitForExistence(timeout: 5) { cancel.tap() }
            }
            back()
        }

        app.swipeUp()
        shot("D04-backup-export-middle")
        app.swipeUp(); app.swipeUp()
        shot("D05-backup-export-bottom")
        if tap(app.buttons["backup-account"], "Your Account") {
            shot("D06-your-account")
            if tap(app.buttons["account-sign-in"], "Sign In") {
                shot("D06b-sign-in-sheet")
                closeSheet()
            }
            back()
        }
        // Share sheets are left out: on the iPhone they show the person's own contacts.
        if tap(app.buttons["backup-erase"], "Erase All My Data") {
            shot("D07-erase-question")
        }
    }

    /// The other pages that speak about the account or the data: Plus and Privacy.
    func testE_PlusAndPrivacy() {
        launch(["-empty", "-free"])
        tap(app.buttons["menu-button"], "≡")
        tap(app.buttons["menu-plus"], "Plus")
        shot("E01-plus")
        back()
        tap(app.buttons["menu-button"], "≡")
        tap(app.buttons["menu-privacy"], "Privacy")
        shot("E03-privacy")
    }
}
