import XCTest

/// The Plus screens (Current Work 80, 10 Oct 2026), on a test launch's stand-in App Store (`PlusTestBackend`, Rulebook
/// D8: a test never touches the person's own purchases), scripted by launch arguments: the free plan full
/// (`-plus-fixture`: Drink water, Read, Walk, Meditate, Vitamins, and Stretch archived), prices that don't load, Ask to
/// Buy, purchases turned off, Plus owned or shared by a family, and Plus that ended.
final class PlusUITests: XCTestCase {
    override func setUp() {
        continueAfterFailure = false
    }

    override func record(_ issue: XCTIssue) {
        var issue = issue
        let shot = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        shot.name = "FAIL-\(name)"
        shot.lifetime = .keepAlways
        issue.add(shot)
        super.record(issue)
    }

    private func launch(_ extra: [String] = []) -> XCUIApplication {
        let app = XCUIApplication()
        app.launchArguments = ["-uitest", "-free", "-empty", "-plus-fixture"] + extra
        app.launch()
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 15), "Today")
        return app
    }

    private func shot(_ app: XCUIApplication, _ name: String) {
        let shot = XCTAttachment(screenshot: app.screenshot()); shot.name = name; shot.lifetime = .keepAlways; add(shot)
    }

    /// The labels on screen, on one line, from one snapshot of the tree (Rulebook T14).
    private func labels(_ app: XCUIApplication) -> String {
        let tree = app.debugDescription
        let pattern = try! NSRegularExpression(pattern: "label: '([^']*)'")
        let found = pattern.matches(in: tree, range: NSRange(tree.startIndex..., in: tree)).compactMap { match in
            Range(match.range(at: 1), in: tree).map { String(tree[$0]) }
        }
        return found.prefix(60).joined(separator: " | ")
    }

    private func button(startingWith prefix: String, _ app: XCUIApplication) -> XCUIElement {
        app.buttons.matching(NSPredicate(format: "label BEGINSWITH %@", prefix)).firstMatch
    }

    /// ≡ › Plus.
    private func openPlus(_ app: XCUIApplication) {
        app.buttons["menu-button"].tap()
        let row = app.buttons["menu-plus"]
        if !row.waitForExistence(timeout: 3) || !row.isHittable { app.buttons["menu-appearance"].swipeUp() }
        XCTAssertTrue(row.waitForExistence(timeout: 3), labels(app))
        XCTAssertTrue(row.label.contains("5 of 5"), "The free count, in plain words: \(row.label)")
        row.tap()
        XCTAssertTrue(app.navigationBars["Plus"].waitForExistence(timeout: 5), labels(app))
    }

    /// New → Build or maintain, at 5 of 5: the 6th-habit sheet, straight away.
    private func openSixthHabitSheet(_ app: XCUIApplication) {
        app.buttons["New Habit"].firstMatch.tap()
        XCTAssertTrue(app.navigationBars["New"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["5 of 5 free habits used. Tasks are always free."].exists, labels(app))
        button(startingWith: "Build or maintain", app).tap()
        XCTAssertTrue(app.staticTexts["Add a 6th habit"].waitForExistence(timeout: 5), labels(app))
    }

    /// Screens 2 and 11: both plans side by side, the button follows the choice, and ✕ is the only way out.
    func testSixthHabitSheetOffersBothPlansAndNoNotNow() {
        let app = launch()
        openSixthHabitSheet(app)
        XCTAssertTrue(app.buttons["plan-plus"].exists && app.buttons["plan-family"].exists, labels(app))
        let buy = app.buttons["plus-buy"]
        XCTAssertTrue(buy.waitForExistence(timeout: 5))
        XCTAssertEqual(buy.label, "Get Plus · $24.99")
        XCTAssertFalse(app.buttons["Not now"].exists || app.buttons["Not Now"].exists, "No Not now (the user, 10 Oct 2026)")
        XCTAssertTrue(app.buttons["plus-make-room"].exists, "Make room instead: \(labels(app))")
        shot(app, "plus-02-sixth-habit")
        app.buttons["plan-family"].tap()
        XCTAssertEqual(buy.label, "Get Plus Family · $59.99")
        XCTAssertTrue(app.buttons["plan-family"].isSelected, "Plus Family chosen")
        app.buttons["plus-close"].tap()
        XCTAssertTrue(app.staticTexts["Add a 6th habit"].waitForNonExistence(timeout: 5))
        XCTAssertTrue(app.navigationBars["New"].exists, "✕ goes back to New")
    }

    /// Screens 2, 7: Get Plus → "Plus is yours" → Done, and the 6th habit goes ahead and is saved.
    func testBuyingPlusSavesTheSixthHabit() {
        let app = launch()
        openSixthHabitSheet(app)
        app.buttons["plus-buy"].tap()
        XCTAssertTrue(app.staticTexts["Plus is yours"].waitForExistence(timeout: 10), labels(app))
        XCTAssertTrue(app.staticTexts["Your habits stay on your devices and in your own iCloud. We never see them."].exists)
        shot(app, "plus-07-plus-is-yours")
        app.buttons["plus-done"].tap()
        let check = button(startingWith: "Check it off", app)
        XCTAssertTrue(check.waitForExistence(timeout: 5), "Back to the habit being added: \(labels(app))")
        check.tap()
        let name = app.descendants(matching: .any)["name-field"]
        XCTAssertTrue(name.waitForExistence(timeout: 5))
        name.tap()
        name.typeText("Floss")
        app.navigationBars["New Habit"].buttons["Add"].tap()
        XCTAssertTrue(app.buttons["Mark Floss done"].waitForExistence(timeout: 10), "The 6th habit is saved: \(labels(app))")
        // Plus now: the menu row has no count, and the page says it's yours.
        app.buttons["menu-button"].tap()
        let row = app.buttons["menu-plus"]
        if !row.waitForExistence(timeout: 3) || !row.isHittable { app.buttons["menu-appearance"].swipeUp() }
        XCTAssertFalse(row.label.contains("of 5"), row.label)
        row.tap()
        XCTAssertTrue(app.staticTexts["Plus is yours"].waitForExistence(timeout: 5), labels(app))
        XCTAssertTrue(app.buttons["plus-upgrade"].exists, "Upgrade to Plus Family, for a Plus owner")
    }

    /// Screens 5 and 6: Archive on each habit, Delete only behind ••• asking first; archiving one goes ahead for free.
    func testMakeRoomArchivesOneAndGoesAhead() {
        let app = launch()
        openSixthHabitSheet(app)
        app.buttons["plus-make-room"].tap()
        XCTAssertTrue(app.navigationBars["Make Room"].waitForExistence(timeout: 5), labels(app))
        for name in ["Drink water", "Read", "Walk", "Meditate", "Vitamins"] {
            XCTAssertTrue(app.buttons["make-room-archive-\(name)"].exists, "Archive \(name): \(labels(app))")
        }
        XCTAssertFalse(app.buttons["Delete"].exists, "Delete is never in view")
        app.buttons["make-room-more-Walk"].tap()
        let delete = app.buttons["Delete…"]
        XCTAssertTrue(delete.waitForExistence(timeout: 3), labels(app))
        delete.tap()
        let alert = app.alerts["Delete Walk?"]
        XCTAssertTrue(alert.waitForExistence(timeout: 3), labels(app))
        XCTAssertTrue(alert.buttons["Archive Instead"].exists && alert.buttons["Delete"].exists && alert.buttons["Cancel"].exists)
        shot(app, "plus-06-delete-alert")
        alert.buttons["Cancel"].tap()
        app.buttons["make-room-archive-Read"].tap()
        XCTAssertTrue(button(startingWith: "Check it off", app).waitForExistence(timeout: 8), "The new habit goes ahead: \(labels(app))")
        XCTAssertTrue(app.navigationBars["Build or maintain"].exists, labels(app))
    }

    /// Screens 10 and 20: the Plus page with Plus chosen; Restore with nothing bought says so, with Contact Us.
    func testPlusPageAndRestoreWithNothingFound() {
        let app = launch()
        openPlus(app)
        XCTAssertTrue(app.staticTexts["One payment, yours forever."].exists, labels(app))
        XCTAssertTrue(app.buttons["plan-plus"].isSelected, "Plus is chosen first")
        XCTAssertEqual(app.buttons["plus-buy"].label, "Get Plus · $24.99")
        shot(app, "plus-10-page")
        app.buttons["plus-restore"].tap()
        let alert = app.alerts["No Plus on this Apple Account"]
        XCTAssertTrue(alert.waitForExistence(timeout: 5), labels(app))
        XCTAssertTrue(alert.buttons["Contact Us"].exists && alert.buttons["OK"].exists)
        alert.buttons["OK"].tap()
        XCTAssertTrue(app.buttons["plus-buy"].exists, "Still the Plus page: nothing was restored")
    }

    /// Screens 13 and 14: prices that don't load show no price and Try Again; purchases turned off say why.
    func testPricesThatFailShowTryAgain() {
        var app = launch(["-plus-prices-fail"])
        openPlus(app)
        XCTAssertTrue(app.descendants(matching: .any)["plus-prices-failed"].waitForExistence(timeout: 5), labels(app))
        XCTAssertFalse(app.staticTexts["$24.99"].exists, "No made-up price")
        shot(app, "plus-13-prices-failed")
        app.buttons["plus-try-again"].tap()
        let buy = app.buttons["plus-buy"]
        XCTAssertTrue(buy.waitForExistence(timeout: 5), labels(app))
        expectation(for: NSPredicate(format: "label == %@", "Get Plus · $24.99"), evaluatedWith: buy)
        waitForExpectations(timeout: 5)
        app.terminate()

        app = launch(["-plus-payments-off"])
        openPlus(app)
        XCTAssertTrue(app.staticTexts["plus-payments-off"].waitForExistence(timeout: 5), labels(app))
        XCTAssertFalse(app.buttons["plus-buy"].isEnabled, "The button is off when purchases are")
        XCTAssertTrue(app.buttons["plus-restore"].exists, "Restore Purchases is always on the page")
    }

    /// Screen 15: Ask to Buy waits, and says the page can be closed.
    func testAskToBuyShowsWaiting() {
        let app = launch(["-plus-ask-to-buy"])
        openPlus(app)
        app.buttons["plus-buy"].tap()
        XCTAssertTrue(app.descendants(matching: .any)["plus-waiting"].waitForExistence(timeout: 5), labels(app))
        XCTAssertEqual(app.buttons["plus-buy"].label, "Waiting for Approval")
        XCTAssertFalse(app.buttons["plus-buy"].isEnabled)
        shot(app, "plus-15-waiting")
    }

    /// Screens 18, 21, 17 and 22: an owner's page, the upgrade to Plus Family, and a family member's page.
    func testOwnerUpgradesAndFamilyMemberPage() {
        var app = launch(["-plus-owned"])
        app.buttons["menu-button"].tap()
        let row = app.buttons["menu-plus"]
        if !row.waitForExistence(timeout: 3) || !row.isHittable { app.buttons["menu-appearance"].swipeUp() }
        XCTAssertFalse(row.label.contains("of 5"), "Someone with Plus sees no count: \(row.label)")
        row.tap()
        XCTAssertTrue(app.staticTexts["Plus is yours"].waitForExistence(timeout: 5), labels(app))
        XCTAssertFalse(app.buttons["plus-buy"].exists, "Never Get Plus again")
        shot(app, "plus-18-owner")
        app.buttons["plus-upgrade"].tap()
        XCTAssertTrue(app.navigationBars["Upgrade"].waitForExistence(timeout: 5), labels(app))
        let upgrade = app.buttons["plus-upgrade-buy"]
        XCTAssertTrue(upgrade.waitForExistence(timeout: 5))
        XCTAssertEqual(upgrade.label, "Upgrade · $35.00")
        upgrade.tap()
        XCTAssertTrue(app.staticTexts["Plus Family is yours"].waitForExistence(timeout: 10), labels(app))
        shot(app, "plus-17-family-is-yours")
        app.buttons["plus-done"].tap()
        XCTAssertTrue(app.staticTexts["Plus is yours"].waitForExistence(timeout: 5))
        XCTAssertFalse(app.buttons["plus-upgrade"].exists, "No upgrade once it's Plus Family")
        app.terminate()

        app = launch(["-plus-family-member"])
        openPlusPageWithPlus(app)
        XCTAssertTrue(app.staticTexts["Shared by your Apple family"].waitForExistence(timeout: 5), labels(app))
        XCTAssertFalse(app.buttons["plus-upgrade"].exists || app.buttons["plus-restore"].exists || app.buttons["plus-buy"].exists,
                       "No purchase buttons for a family member: \(labels(app))")
        shot(app, "plus-22-family-member")
    }

    /// Screen 23: Plus that ended is told once, and every habit stays.
    func testPlusEndedIsToldOnce() {
        let app = launch(["-plus-ended", "refund"])
        XCTAssertTrue(app.staticTexts["Plus has ended"].waitForExistence(timeout: 10), labels(app))
        XCTAssertTrue(app.staticTexts["It was refunded through the App Store."].exists)
        shot(app, "plus-23-ended")
        app.buttons["plus-ended-ok"].tap()
        XCTAssertTrue(app.staticTexts["Plus has ended"].waitForNonExistence(timeout: 5))
        XCTAssertTrue(app.buttons["Mark Read done"].exists, "Every habit stays: \(labels(app))")
    }

    /// Screen 4: bringing back an archived habit at 5 of 5 opens the same sheet; once room is made it comes back.
    func testBringingBackAnArchivedHabit() {
        let app = launch()
        app.buttons["menu-button"].tap()
        XCTAssertTrue(app.buttons["menu-habits"].waitForExistence(timeout: 5))
        app.buttons["menu-habits"].tap()
        XCTAssertTrue(app.navigationBars["Habits"].waitForExistence(timeout: 5), labels(app))
        let stretch = button(startingWith: "Stretch", app)
        XCTAssertTrue(stretch.waitForExistence(timeout: 5), labels(app))
        stretch.swipeLeft()
        let restore = app.buttons["Restore"]
        XCTAssertTrue(restore.waitForExistence(timeout: 3), labels(app))
        restore.tap()
        XCTAssertTrue(app.staticTexts["Bring back Stretch"].waitForExistence(timeout: 5), labels(app))
        XCTAssertTrue(app.staticTexts["Stretch would be your 6th habit."].exists, labels(app))
        shot(app, "plus-04-restoring")
        app.buttons["plus-make-room"].tap()
        XCTAssertTrue(app.buttons["make-room-archive-Walk"].waitForExistence(timeout: 5), labels(app))
        app.buttons["make-room-archive-Walk"].tap()
        XCTAssertTrue(app.staticTexts["Bring back Stretch"].waitForNonExistence(timeout: 8), labels(app))
        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssertTrue(app.buttons["Mark Stretch done"].waitForExistence(timeout: 8), "Stretch is back on Today: \(labels(app))")
        XCTAssertFalse(app.buttons["Mark Walk done"].exists, "Walk was archived to make room")
    }

    /// Screen 16: a second device on the free plan. Plus first with See Plus (the Plus page), the free move last with the
    /// only filled button; ✕ changes nothing.
    func testSecondDeviceSheetOpensThePlusPage() {
        let app = launch(["-test-ask-replace", "iPhone"])
        let title = app.staticTexts["use-here-title"]
        XCTAssertTrue(title.waitForExistence(timeout: 15), labels(app))
        XCTAssertTrue(title.label.hasPrefix("Use your habits on this "), title.label)
        let seePlus = app.buttons["use-here-see-plus"], move = app.buttons["use-here-continue"]
        XCTAssertTrue(seePlus.exists && move.exists, labels(app))
        XCTAssertLessThan(seePlus.frame.minY, move.frame.minY, "Plus first, the free move last")
        shot(app, "plus-16-second-device")
        seePlus.tap()
        XCTAssertTrue(app.buttons["plus-buy"].waitForExistence(timeout: 5), "See Plus opens the Plus page: \(labels(app))")
        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssertTrue(app.buttons["use-here-cancel"].waitForExistence(timeout: 5), labels(app))
        app.buttons["use-here-cancel"].tap()
        XCTAssertTrue(title.waitForNonExistence(timeout: 5), "✕ closes it")
    }

    private func openPlusPageWithPlus(_ app: XCUIApplication) {
        app.buttons["menu-button"].tap()
        let row = app.buttons["menu-plus"]
        if !row.waitForExistence(timeout: 3) || !row.isHittable { app.buttons["menu-appearance"].swipeUp() }
        row.tap()
        XCTAssertTrue(app.navigationBars["Plus"].waitForExistence(timeout: 5), labels(app))
    }
}
