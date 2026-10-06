import XCTest

/// The first launch and the help (Build Plan #62, #71; `Docs/Checklists/Onboarding and Help.md`). `-onboarding` shows
/// the welcome on the in-memory, empty store the other tests use; without it no test ever sees the welcome.
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

    private func next() {
        let button = app.buttons["onboarding-continue"]
        XCTAssertTrue(button.waitForExistence(timeout: 3))
        button.tap()
    }

    /// Current Work 52 (6 Oct 2026): at 1:30 AM with a 3 AM day start, the app's today is still yesterday; a habit
    /// added then took the calendar's date, so it started "tomorrow" and Today stayed empty until 3 AM. Found by
    /// `testWelcomeToFirstHabit`, which failed only when CI ran between midnight and 3 AM. `-clock-hour 1` makes it
    /// every run.
    func testFirstHabitAfterMidnightBeforeTheDayStartShowsOnToday() {
        launch(extra: ["-clock-hour", "1"])
        XCTAssertTrue(app.staticTexts["onboarding-page-name"].waitForExistence(timeout: 10))
        next()
        XCTAssertTrue(app.staticTexts["onboarding-page-free"].waitForExistence(timeout: 3))
        next()
        let dayStart = app.buttons["onboarding-day-start"]
        XCTAssertTrue(dayStart.waitForExistence(timeout: 3))
        dayStart.tap()
        let three = app.buttons.matching(NSPredicate(format: "label BEGINSWITH '3:00' OR label BEGINSWITH '03:00'")).firstMatch
        XCTAssertTrue(three.waitForExistence(timeout: 3))
        three.tap()
        XCTAssertTrue(app.buttons["onboarding-day-start"].label.contains("3:00"))
        next()
        let exercise = app.buttons["idea-Exercise"]
        XCTAssertTrue(exercise.waitForExistence(timeout: 3))
        exercise.tap()
        XCTAssertTrue(app.descendants(matching: .any)["name-field"].waitForExistence(timeout: 5))
        app.buttons["add-habit"].tap()
        XCTAssertTrue(app.buttons["Mark Exercise done"].waitForExistence(timeout: 5),
                      "A habit added at 1:30 AM, before a 3 AM day start, shows on Today")
        shot("52-after-midnight")
    }

    /// The whole welcome: the name, what's free, the day and week, then an idea that fills in the form and is added.
    func testWelcomeToFirstHabit() {
        launch()
        let name = app.staticTexts["onboarding-page-name"]
        XCTAssertTrue(name.waitForExistence(timeout: 10), "The welcome opens on a fresh install")
        XCTAssertEqual(name.label, "Often Enough")
        XCTAssertTrue(text(containing: "It needs to happen often enough").exists)
        XCTAssertTrue(text(containing: "Streaks count your goal").exists)
        XCTAssertTrue(text(containing: "Skipped and paused days never count against you").exists)
        XCTAssertEqual(app.descendants(matching: .any)["onboarding-dots"].label, "Page 1 of 4")
        XCTAssertTrue(app.buttons["onboarding-skip"].exists, "Every screen before the last can be skipped")
        XCTAssertTrue(app.buttons["onboarding-restore"].exists, "Someone coming back can restore first")
        XCTAssertFalse(app.buttons["onboarding-back"].exists, "Nothing to go back to on the first screen")
        shot("01-name")

        next()
        XCTAssertTrue(app.staticTexts["onboarding-page-free"].waitForExistence(timeout: 3))
        XCTAssertTrue(text(containing: "Free forever: up to 5 habits").exists)
        XCTAssertTrue(text(containing: "No account, no ads").exists)
        XCTAssertTrue(text(containing: "Your habits stay on this iPhone").exists)
        XCTAssertTrue(text(containing: "not a subscription").exists, "Plus is said to be one payment (C305)")
        XCTAssertFalse(app.buttons["Get Plus"].exists, "No buying in the welcome")
        shot("02-free")

        // Back works, then forward again.
        app.buttons["onboarding-back"].tap()
        XCTAssertTrue(app.staticTexts["onboarding-page-name"].waitForExistence(timeout: 3))
        next()
        XCTAssertTrue(app.staticTexts["onboarding-page-free"].waitForExistence(timeout: 3))

        next()
        XCTAssertTrue(text(containing: "Your days and weeks").waitForExistence(timeout: 3))
        let dayStart = app.buttons["onboarding-day-start"]
        XCTAssertTrue(dayStart.waitForExistence(timeout: 3))
        XCTAssertTrue(dayStart.label.contains("Midnight"), "Midnight by default: \(dayStart.label)")
        XCTAssertTrue(app.buttons["onboarding-week-start"].label.contains("Automatic"), "The region's week by default")
        dayStart.tap()
        let three = app.buttons.matching(NSPredicate(format: "label BEGINSWITH '3:00' OR label BEGINSWITH '03:00'")).firstMatch
        XCTAssertTrue(three.waitForExistence(timeout: 3))
        three.tap()
        XCTAssertTrue(app.buttons["onboarding-day-start"].label.contains("3:00"), "The new day start is shown")
        shot("03-days")

        next()
        XCTAssertTrue(text(containing: "What's one habit to start with?").waitForExistence(timeout: 3))
        XCTAssertFalse(app.buttons["onboarding-skip"].exists, "The last screen has Not Now instead of Skip")
        XCTAssertTrue(app.buttons["onboarding-not-now"].exists)
        XCTAssertFalse(app.buttons["onboarding-continue"].exists)
        let exercise = app.buttons["idea-Exercise"]
        XCTAssertTrue(exercise.waitForExistence(timeout: 3))
        XCTAssertTrue(exercise.label.contains("3 times a week"), "The idea says how often: \(exercise.label)")
        shot("04-ideas")

        // An idea only fills in the form: nothing is added until Add (C292).
        exercise.tap()
        let field = app.descendants(matching: .any)["name-field"]
        XCTAssertTrue(field.waitForExistence(timeout: 5))
        XCTAssertEqual(field.value as? String, "Exercise")
        XCTAssertTrue(app.descendants(matching: .any)["habit-sentence"].label.contains("3 times a week"),
                      "How often comes from the idea: \(app.descendants(matching: .any)["habit-sentence"].label)")
        shot("05-idea-form")
        app.buttons["add-habit"].tap()

        // The welcome has gone and the habit is on Today.
        XCTAssertTrue(app.buttons["Mark Exercise done"].waitForExistence(timeout: 5), "The new habit shows on Today")
        XCTAssertFalse(app.staticTexts["onboarding-page-name"].exists)
        shot("06-today")

        // The day start chosen in the welcome is the app's setting.
        app.buttons["menu-button"].tap()
        app.buttons["menu-dayAndWeek"].tap()
        let setting = app.buttons["day-start-picker"]
        XCTAssertTrue(setting.waitForExistence(timeout: 5))
        XCTAssertTrue(setting.label.contains("3:00"), "Day and Week shows the welcome's choice: \(setting.label)")
    }

    /// Skip goes straight to Today, which is never a dead end: an idea, a restore, the help.
    func testSkipLeadsToAHelpfulToday() {
        launch()
        let skip = app.buttons["onboarding-skip"]
        XCTAssertTrue(skip.waitForExistence(timeout: 10))
        skip.tap()

        XCTAssertTrue(app.staticTexts["No habits yet"].waitForExistence(timeout: 5))
        XCTAssertTrue(text(containing: "often enough").exists, "The empty Today speaks the name, not 'every day'")
        for id in ["empty-ideas", "empty-restore-backup", "empty-help"] {
            XCTAssertTrue(app.buttons[id].exists, id)
        }
        XCTAssertTrue(app.buttons["New Habit"].firstMatch.exists)
        shot("01-empty-today")

        // Start From an Idea: the same ideas, in a sheet with Cancel.
        app.buttons["empty-ideas"].tap()
        let water = app.buttons["idea-Drink water"]
        XCTAssertTrue(water.waitForExistence(timeout: 3))
        app.navigationBars["Ideas"].buttons["Cancel"].tap()
        XCTAssertTrue(app.staticTexts["No habits yet"].waitForExistence(timeout: 3), "Cancel adds nothing")

        app.buttons["empty-ideas"].tap()
        XCTAssertTrue(app.buttons["idea-Drink water"].waitForExistence(timeout: 3))
        app.buttons["idea-Drink water"].tap()
        let field = app.descendants(matching: .any)["name-field"]
        XCTAssertTrue(field.waitForExistence(timeout: 5))
        XCTAssertEqual(field.value as? String, "Drink water")
        // Amounts are never filled in (Design Rules), so Add waits for one, as for any amount habit.
        XCTAssertFalse(app.buttons["add-habit"].isEnabled, "An amount habit needs its amount before Add")
        let howMuch = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'How much'")).firstMatch
        app.reveal(howMuch)
        howMuch.tap()
        let number = app.textFields["much-number"]
        XCTAssertTrue(number.waitForExistence(timeout: 3))
        number.tap()
        number.typeText("8")
        app.navigationBars.buttons["BackButton"].firstMatch.tap()
        XCTAssertTrue(app.buttons["add-habit"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.buttons["add-habit"].isEnabled, "Add works once the amount is set")
        app.buttons["add-habit"].tap()
        XCTAssertTrue(app.navigationBars.buttons["New Habit"].waitForExistence(timeout: 5), "Today's toolbar is back")
        XCTAssertTrue(text(containing: "Drink water").waitForExistence(timeout: 5), "The idea's habit is on Today")
        XCTAssertFalse(app.staticTexts["No habits yet"].exists)
        shot("02-after-idea")
    }

    /// Not Now on the last screen, then the help: search, Contact Us without a mail app, and the welcome again.
    func testNotNowAndHelp() {
        launch()
        XCTAssertTrue(app.staticTexts["onboarding-page-name"].waitForExistence(timeout: 10))
        next(); next(); next()
        let notNow = app.buttons["onboarding-not-now"]
        XCTAssertTrue(notNow.waitForExistence(timeout: 3))

        // Make Your Own opens the usual New, and Cancel comes back to the ideas with nothing added.
        let own = app.buttons["onboarding-make-own"]
        XCTAssertTrue(own.isHittable, "Make Your Own is always in view, not under the ideas")
        own.tap()
        XCTAssertTrue(app.staticTexts["What do you want to do?"].waitForExistence(timeout: 3))
        app.navigationBars["New"].buttons["Cancel"].tap()
        XCTAssertTrue(notNow.waitForExistence(timeout: 3))
        notNow.tap()
        XCTAssertTrue(app.staticTexts["No habits yet"].waitForExistence(timeout: 5))

        app.buttons["empty-help"].tap()
        XCTAssertTrue(app.navigationBars["Help & Feedback"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons["help-contact"].exists)
        XCTAssertTrue(app.buttons["help-welcome"].exists)
        shot("01-help")

        // Search finds an answer by its words, not only its question.
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
        shot("02-help-search")
        // Empty the search (iOS 26 has a ✕ where Cancel was): the full page, Contact Us first, comes back.
        search.typeText(String(repeating: XCUIKeyboardKey.delete.rawValue, count: 4))

        // The simulator has no mail app: the address is offered instead, to copy.
        XCTAssertTrue(app.buttons["help-contact"].waitForExistence(timeout: 3))
        app.buttons["help-contact"].tap()
        let alert = app.alerts["Write to Us"]
        if alert.waitForExistence(timeout: 5) {
            XCTAssertTrue(alert.staticTexts.matching(NSPredicate(format: "label CONTAINS 'support@oftenenough.com'")).firstMatch.exists)
            shot("03-contact")
            alert.buttons["Copy Address"].tap()
        } else {
            // A mail app opened instead (a simulator with Mail): come back to the app.
            app.activate()
        }

        // The welcome again: the name and what's free, then Done, back on Help.
        XCTAssertTrue(app.buttons["help-welcome"].waitForExistence(timeout: 5))
        app.buttons["help-welcome"].tap()
        XCTAssertTrue(app.staticTexts["onboarding-page-name"].waitForExistence(timeout: 5))
        XCTAssertFalse(app.buttons["onboarding-skip"].exists, "The replay has no Skip")
        XCTAssertFalse(app.buttons["onboarding-restore"].exists, "The replay has no Restore")
        XCTAssertEqual(app.descendants(matching: .any)["onboarding-dots"].label, "Page 1 of 2")
        next()
        XCTAssertTrue(app.staticTexts["onboarding-page-free"].waitForExistence(timeout: 3))
        XCTAssertEqual(app.buttons["onboarding-continue"].label, "Done")
        next()
        // Done returns to Help (its search may still be active from above, which hides the page's title).
        XCTAssertTrue(app.buttons["help-welcome"].waitForExistence(timeout: 5), "Done returns to Help")
        XCTAssertFalse(app.staticTexts["onboarding-page-free"].exists)

        // About, from the menu, in a fresh launch with no welcome.
        app.terminate()
        launch(onboarding: false)
        XCTAssertTrue(app.staticTexts["No habits yet"].waitForExistence(timeout: 10))
        app.buttons["menu-button"].tap()
        app.buttons["menu-about"].tap()
        XCTAssertTrue(app.navigationBars["About"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["about-version"].label.hasPrefix("Version "))
        XCTAssertTrue(text(containing: "AndroidX Room").exists, "The acknowledgements list the libraries")
        shot("04-about")
    }

    /// Restore from a Backup File on the first screen ends the welcome on Backup & Export.
    func testRestoreFromTheWelcome() {
        launch()
        let restore = app.buttons["onboarding-restore"]
        XCTAssertTrue(restore.waitForExistence(timeout: 10))
        restore.tap()
        XCTAssertTrue(app.navigationBars["Backup & Export"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons["backup-restore"].exists)
        XCTAssertFalse(app.staticTexts["onboarding-page-name"].exists)
    }

    /// Without `-onboarding` (every other test, and anyone who already has habits) the welcome never shows.
    func testNoWelcomeInOtherRuns() {
        launch(onboarding: false)
        XCTAssertTrue(app.staticTexts["No habits yet"].waitForExistence(timeout: 10))
        XCTAssertFalse(app.staticTexts["onboarding-page-name"].exists)
    }

    /// The largest text size: every welcome screen still reaches Continue (C145).
    func testLargestTextReachesContinue() {
        launch(extra: ["-UIPreferredContentSizeCategoryName", "UICTContentSizeCategoryAccessibilityXXXL"])
        XCTAssertTrue(app.staticTexts["onboarding-page-name"].waitForExistence(timeout: 10))
        for _ in 0..<3 {
            let button = app.buttons["onboarding-continue"]
            XCTAssertTrue(button.waitForExistence(timeout: 3))
            XCTAssertTrue(button.isHittable, "Continue is on screen at the largest text size")
            button.tap()
        }
        XCTAssertTrue(app.buttons["onboarding-not-now"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.buttons["onboarding-not-now"].isHittable)
        shot("01-largest-text-ideas")
    }
}
