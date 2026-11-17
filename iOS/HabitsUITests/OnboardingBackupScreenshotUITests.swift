import XCTest

/// Current Work 73 + 3 (9 Oct 2026): ≡ → iCloud & Backup and the pages that speak about the data, as built, for Figma.
/// Screenshots only: each is named in the order it's laid out (`D01-sidebar`). The welcome's screenshots went with the
/// welcome (17 Nov 2026: the first launch has no pages; `OnboardingUITests` covers what's left). A test launch (`-uitest`:
/// in-memory database, its own fake iCloud), so the person's habits and iCloud are never touched (D8).
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
