import XCTest

/// Current Work 73 + 3 (9 Oct 2026): every screen of the welcome and ≡ → iCloud & Backup, as built, for the Figma
/// page "onboarding" (first taken of the earlier welcome; the welcome's tests follow the rebuilt one, 73.1). Screenshots only: each is named in the order it's laid out (`A01-welcome-name`). A test launch
/// (`-uitest`: in-memory database, its own fake iCloud), so the person's habits and iCloud are never touched (D8).
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
            // The idea's form is pushed on the welcome; nothing typed, so it leaves by Back without asking (U18).
            XCTAssertFalse(app.navigationBars["New Habit"].buttons["Cancel"].exists, "An untouched idea has no Cancel to confirm")
            tap(app.navigationBars["New Habit"].buttons.firstMatch, "The idea form's Back")
            XCTAssertFalse(app.buttons["Discard Changes"].waitForExistence(timeout: 1), "Nothing typed, nothing to discard")
            XCTAssertTrue(app.staticTexts["onboarding-page-ideas"].waitForExistence(timeout: 5), "Back returns to the ideas")
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
        tap(app.buttons["onboarding-way-restore"], "Restore a backup")
        shot("B03-restore-a-backup")
        back()
        app.terminate()
        launch(["-empty", "-onboarding", "-test-cloud", "has-habits"])
        tap(app.buttons["onboarding-returning"], "I've used it before")
        _ = app.descendants(matching: .any)["onboarding-found"].waitForExistence(timeout: 20)
        shot("B02-welcome-back-from-icloud")
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

    /// ≡ → iCloud & Backup (the demo habits), in its states, and every sheet and question it opens.
    func testD_ICloudAndBackup() {
        launch(["-test-cloud", "synced"])
        tap(app.buttons["menu-button"], "≡")
        shot("D01-sidebar")
        tap(app.buttons["menu-backup"], "iCloud & Backup")
        XCTAssertTrue(app.navigationBars["iCloud & Backup"].waitForExistence(timeout: 5))
        shot("D03-icloud-backup-top")

        // Restore first, while it's on screen: the erase question below is a popover with no Cancel.
        if tap(app.buttons["backup-restore"], "Restore From a Backup") {
            XCTAssertTrue(app.navigationBars["Restore From a Backup"].waitForExistence(timeout: 5))
            shot("D08-restore-from-a-backup")
            if tap(app.buttons["restore-icloud"], "Restore → iCloud") {
                shot("D09-restore-icloud")
                back()
            }
            back()
        }
        app.swipeUp()
        shot("D04-icloud-backup-middle")
        app.swipeUp(); app.swipeUp()
        shot("D05-icloud-backup-bottom")
        if tap(app.buttons["cloud-delete"], "Delete My Data From iCloud") {
            shot("D06-delete-from-icloud-question")
        }

        // The states that need the person, and the questions (Architecture 11 §10–12).
        for state in ["full", "waiting", "off", "held", "free-other", "removed", "other-account"] {
            app.terminate()
            launch(["-test-cloud", state] + (state == "free-other" ? ["-free"] : []))
            sleep(3)
            shot("D10-\(state)-on-launch")
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
