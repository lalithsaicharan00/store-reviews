import XCTest

/// The first launch (Figma's onboarding flows, 17 Nov 2026): no welcome pages. A fresh install looks in iCloud, then
/// opens Today; an empty Today offers New Habit and Restore from a Backup. `-onboarding` makes a test launch a first
/// launch (with `-empty`, nothing on this iPhone); without it no test ever waits for iCloud's first look.
///
/// Only what a person could lose is tested here: habits coming back from iCloud (D14), going on by itself after No
/// Internet, and a first habit landing on the right day (D7). Restoring a file (flows 3, 6, 7) goes through Apple's
/// file picker, which a UI test can't fill; those flows were checked by hand on the Simulator (17 Nov 2026).
final class OnboardingUITests: XCTestCase {
    override func record(_ issue: XCTIssue) {
        let shot = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        shot.name = "FAIL-\(name)"
        shot.lifetime = .keepAlways
        var issue = issue
        issue.add(shot)
        super.record(issue)
    }

    private var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
    }

    private func launch(onboarding: Bool = true, extra: [String] = []) {
        app.launchArguments = ["-uitest", "-empty"] + (onboarding ? ["-onboarding"] : []) + extra
        app.launch()
    }

    private func shot(_ name: String) {
        let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    private func text(containing words: String) -> XCUIElement {
        app.descendants(matching: .any).matching(NSPredicate(format: "label CONTAINS %@", words)).firstMatch
    }

    private var emptyToday: XCUIElement { app.staticTexts["No Habits Yet"] }

    /// Flow 1: nothing in iCloud, so the empty Today: its words, New Habit and Restore from a Backup, and only ☰ and + in
    /// the bar (nothing to arrange yet). New Habit opens New.
    func testEmptyToday() {
        launch(extra: ["-test-cloud", "synced"])
        XCTAssertTrue(emptyToday.waitForExistence(timeout: 15))
        XCTAssertTrue(text(containing: "Add something you’d like to do often enough.").exists)
        XCTAssertTrue(app.buttons["empty-new-habit"].exists)
        XCTAssertTrue(app.buttons["empty-restore-backup"].exists)
        XCTAssertTrue(app.buttons["menu-button"].exists)
        XCTAssertFalse(app.buttons["arrange-button"].exists, "No Edit with nothing to arrange")
        XCTAssertFalse(app.buttons["filter-button"].exists, "No Filter")
        shot("01-empty-today")
        app.buttons["empty-new-habit"].tap()
        XCTAssertTrue(app.staticTexts["What do you want to do?"].waitForExistence(timeout: 5))
    }

    /// Flow 2: habits in iCloud come back by themselves (D14); Looking in iCloud… shows only after a second, and the
    /// empty Today never shows on the way.
    func testHabitsComeBackFromICloud() {
        launch(extra: ["-test-cloud", "has-habits-slow"])
        XCTAssertTrue(text(containing: "Looking in iCloud").waitForExistence(timeout: 10), "A slow first look says so")
        XCTAssertFalse(emptyToday.exists, "The empty Today doesn't flash before the habits come")
        shot("02-looking-in-icloud")
        XCTAssertTrue(app.staticTexts["Read from iCloud"].waitForExistence(timeout: 20), "Today has them")
        XCTAssertTrue(app.staticTexts["Walk from iCloud"].exists)
    }

    /// Flow 4: offline on a fresh install, No Internet Connection; Try Again while offline stays; once online the
    /// habits come back by themselves, with no tap.
    func testNoInternetGoesOnByItself() {
        launch(extra: ["-test-cloud", "offline-then-online"])
        XCTAssertTrue(app.staticTexts["No Internet Connection"].waitForExistence(timeout: 10))
        XCTAssertTrue(app.buttons["no-internet-not-now"].exists)
        shot("04-no-internet")
        app.buttons["no-internet-try-again"].tap()
        XCTAssertTrue(app.staticTexts["No Internet Connection"].exists, "Still offline: it stays")
        XCTAssertTrue(app.staticTexts["Read from iCloud"].waitForExistence(timeout: 30), "Online: the habits come back")
    }

    /// Flow 4, Not Now: Today at once, and the habits still come back once online.
    func testNotNowStillBringsHabitsBack() {
        launch(extra: ["-test-cloud", "offline-then-online"])
        XCTAssertTrue(app.buttons["no-internet-not-now"].waitForExistence(timeout: 10))
        app.buttons["no-internet-not-now"].tap()
        XCTAssertTrue(emptyToday.waitForExistence(timeout: 5), "Today, empty for now")
        XCTAssertTrue(app.staticTexts["Read from iCloud"].waitForExistence(timeout: 30), "They come back later")
    }

    /// Without `-onboarding` (every other test) Today never waits for iCloud.
    func testNoFirstLookInOtherRuns() {
        launch(onboarding: false)
        XCTAssertTrue(emptyToday.waitForExistence(timeout: 10))
        XCTAssertFalse(text(containing: "Looking in iCloud").exists)
    }

    /// Current Work 52 (6 Oct 2026): at 1:30 AM with a 3 AM day start, the app's today is still yesterday; a habit
    /// added then took the calendar's date, so it started "tomorrow" and Today stayed empty until 3 AM.
    func testFirstHabitAfterMidnightBeforeTheDayStartShowsOnToday() {
        launch(onboarding: false, extra: ["-clock-hour", "1"])
        XCTAssertTrue(emptyToday.waitForExistence(timeout: 10))
        app.buttons["menu-button"].tap()
        app.menuRow("dayAndWeek").tap()
        let dayStart = app.buttons["day-start-picker"]
        XCTAssertTrue(dayStart.waitForExistence(timeout: 5))
        dayStart.tap()
        let three = app.buttons.matching(NSPredicate(format: "label BEGINSWITH '3:00' OR label BEGINSWITH '03:00'")).firstMatch
        XCTAssertTrue(three.waitForExistence(timeout: 3))
        three.tap()
        XCTAssertTrue(dayStart.label.contains("3:00"), dayStart.label)
        app.navigationBars.buttons.element(boundBy: 0).tap()

        XCTAssertTrue(app.buttons["empty-new-habit"].waitForExistence(timeout: 5))
        app.buttons["empty-new-habit"].tap()
        text(containing: "Build or maintain").tap()
        text(containing: "Check it off").tap()
        let field = app.descendants(matching: .any)["name-field"]
        XCTAssertTrue(field.waitForExistence(timeout: 5))
        field.tap()
        field.typeText("Stretch")
        app.buttons["add-habit"].tap()
        XCTAssertTrue(app.buttons["Mark Stretch done"].waitForExistence(timeout: 5),
                      "A habit added at 1:30 AM, before a 3 AM day start, shows on Today")
    }

    /// Help: search finds an answer by its words, and Contact Us offers the address when there's no mail app. About shows
    /// the version.
    func testHelpAndAbout() {
        launch(onboarding: false)
        XCTAssertTrue(emptyToday.waitForExistence(timeout: 10))
        app.buttons["menu-button"].tap()
        app.menuRow("help").tap()
        XCTAssertTrue(app.navigationBars["Help & Feedback"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons["help-contact"].exists)

        let search = app.searchFields.firstMatch
        if !search.exists { app.swipeDown() }
        XCTAssertTrue(search.waitForExistence(timeout: 3))
        search.tap()
        search.typeText("slip")
        let slip = app.descendants(matching: .any)["help-topic-Log a slip"]
        XCTAssertTrue(slip.waitForExistence(timeout: 3), "Searching 'slip' finds Log a slip")
        slip.tap()
        XCTAssertTrue(text(containing: "your best run and your history are kept").waitForExistence(timeout: 3),
                      "The answer opens in place")
        search.typeText(String(repeating: XCUIKeyboardKey.delete.rawValue, count: 4))

        XCTAssertTrue(app.buttons["help-contact"].waitForExistence(timeout: 3))
        app.buttons["help-contact"].tap()
        let alert = app.alerts["Write to Us"]
        if alert.waitForExistence(timeout: 5) {
            XCTAssertTrue(alert.staticTexts.matching(NSPredicate(format: "label CONTAINS 'support@oftenenough.com'")).firstMatch.exists)
            alert.buttons["Copy Address"].tap()
        } else {
            app.activate() // a simulator with Mail opened it instead
        }

        app.terminate()
        launch(onboarding: false)
        XCTAssertTrue(emptyToday.waitForExistence(timeout: 10))
        app.buttons["menu-button"].tap()
        app.menuRow("about").tap()
        XCTAssertTrue(app.navigationBars["About"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["about-version"].label.hasPrefix("Version "))
    }
}
