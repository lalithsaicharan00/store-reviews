import XCTest

/// The first launch and the help (Current Work 73.1, 9 Oct 2026: the user's wireframes; before that Build Plan #62, #71).
/// `-onboarding` shows the welcome on the in-memory store the other tests use (with `-empty`, nothing in it; without,
/// the demo habits, as for someone whose data is already on the iPhone); without it no test ever sees the welcome.
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

    private func launch(onboarding: Bool = true, empty: Bool = true, extra: [String] = []) {
        app.launchArguments = ["-uitest"] + (empty ? ["-empty"] : []) + (onboarding ? ["-onboarding"] : []) + extra
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

    private func page(_ id: String) -> XCUIElement {
        app.staticTexts[id]
    }

    /// Taps a button once it's there, scrolling it into view at large text sizes.
    private func tap(_ id: String) {
        let button = app.buttons[id]
        XCTAssertTrue(button.waitForExistence(timeout: 5), "\(id) is there")
        for _ in 0..<6 where !button.isHittable { app.swipeUp() }
        button.tap()
    }

    private func next() { tap("onboarding-continue") }

    /// From the first screen to "Your first habit": I'm new here, then Continue on each page.
    private func toFirstHabit() {
        XCTAssertTrue(page("onboarding-page-welcome").waitForExistence(timeout: 10))
        tap("onboarding-new")
        for id in ["onboarding-page-free", "onboarding-page-build", "onboarding-page-quit", "onboarding-page-tasks", "onboarding-page-days"] {
            XCTAssertTrue(page(id).waitForExistence(timeout: 5), id)
            next()
        }
        XCTAssertTrue(page("onboarding-page-ideas").waitForExistence(timeout: 5))
    }

    /// Current Work 52 (6 Oct 2026): at 1:30 AM with a 3 AM day start, the app's today is still yesterday; a habit
    /// added then took the calendar's date, so it started "tomorrow" and Today stayed empty until 3 AM. `-clock-hour 1`
    /// makes it every run.
    func testFirstHabitAfterMidnightBeforeTheDayStartShowsOnToday() {
        launch(extra: ["-clock-hour", "1"])
        XCTAssertTrue(page("onboarding-page-welcome").waitForExistence(timeout: 10))
        tap("onboarding-new")
        for _ in 0..<4 { next() }
        let dayStart = app.buttons["onboarding-day-start"]
        XCTAssertTrue(dayStart.waitForExistence(timeout: 5))
        dayStart.tap()
        let three = app.buttons.matching(NSPredicate(format: "label BEGINSWITH '3:00' OR label BEGINSWITH '03:00'")).firstMatch
        XCTAssertTrue(three.waitForExistence(timeout: 3))
        three.tap()
        XCTAssertTrue(app.buttons["onboarding-day-start"].label.contains("3:00"))
        next()
        tap("idea-Exercise")
        XCTAssertTrue(app.descendants(matching: .any)["name-field"].waitForExistence(timeout: 5))
        app.buttons["add-habit"].tap()
        XCTAssertTrue(app.buttons["Add 1 to Exercise"].waitForExistence(timeout: 5),
                      "A habit added at 1:30 AM, before a 3 AM day start, shows on Today")
        shot("52-after-midnight")
    }

    /// The new person's whole way: the first screen's final words, what's included, the three pages on what the app
    /// does, the day and week, then an idea that opens its form straight away, filled in, and is added.
    func testNewPersonToFirstHabit() {
        launch()
        let welcome = page("onboarding-page-welcome")
        XCTAssertTrue(welcome.waitForExistence(timeout: 10), "The welcome opens on a fresh install")
        XCTAssertEqual(welcome.label, "Often Enough")
        XCTAssertTrue(text(containing: "Habits grow through repetition. You choose how often is enough.").exists)
        XCTAssertTrue(text(containing: "Have you used Often Enough before?").exists)
        XCTAssertTrue(app.buttons["onboarding-new"].label.contains("I'm new here"))
        XCTAssertTrue(app.buttons["onboarding-returning"].label.contains("I've used it before"))
        XCTAssertFalse(app.buttons["onboarding-skip"].exists, "Nothing to skip on the first screen: one tap answers it")
        XCTAssertFalse(app.navigationBars.buttons["BackButton"].exists, "Nothing to go back to on the first screen")
        shot("01-welcome")

        tap("onboarding-new")
        XCTAssertTrue(page("onboarding-page-free").waitForExistence(timeout: 5))
        for line in ["Up to 5 habits", "Unlimited tasks", "Widgets included", "No account needed", "More habits with optional Plus."] {
            XCTAssertTrue(text(containing: line).exists, line)
        }
        XCTAssertFalse(app.buttons["Get Plus"].exists, "No buying in the welcome")
        XCTAssertTrue(app.buttons["onboarding-skip"].exists, "Skip setup on every new-person page")
        shot("02-included")

        // Back returns to the first screen, then forward again.
        app.navigationBars.buttons.firstMatch.tap()
        XCTAssertTrue(page("onboarding-page-welcome").waitForExistence(timeout: 5))
        tap("onboarding-new")
        XCTAssertTrue(page("onboarding-page-free").waitForExistence(timeout: 5))

        next()
        XCTAssertTrue(page("onboarding-page-build").waitForExistence(timeout: 5))
        XCTAssertTrue(text(containing: "Example: Water, 3 of 8 glasses").exists, "The example rows read as examples")
        shot("03-build")
        next()
        XCTAssertTrue(page("onboarding-page-quit").waitForExistence(timeout: 5))
        shot("04-quit")
        next()
        XCTAssertTrue(page("onboarding-page-tasks").waitForExistence(timeout: 5))
        XCTAssertTrue(text(containing: "Included in the free plan").exists)
        shot("05-tasks")

        next()
        XCTAssertTrue(page("onboarding-page-days").waitForExistence(timeout: 5))
        let dayStart = app.buttons["onboarding-day-start"]
        XCTAssertTrue(dayStart.waitForExistence(timeout: 3))
        XCTAssertTrue(dayStart.label.contains("Midnight"), "Midnight by default: \(dayStart.label)")
        XCTAssertTrue(app.buttons["onboarding-week-start"].label.contains("Automatic"), "The region's week by default")
        XCTAssertTrue(text(containing: "You can change these later in ≡ › Day and Week.").exists)
        dayStart.tap()
        let three = app.buttons.matching(NSPredicate(format: "label BEGINSWITH '3:00' OR label BEGINSWITH '03:00'")).firstMatch
        XCTAssertTrue(three.waitForExistence(timeout: 3))
        three.tap()
        XCTAssertTrue(app.buttons["onboarding-day-start"].label.contains("3:00"), "The new day start is shown")
        shot("06-days")

        next()
        XCTAssertTrue(page("onboarding-page-ideas").waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons["onboarding-skip"].exists, "Skip setup on the last page too")
        XCTAssertTrue(app.buttons["onboarding-make-own"].isHittable, "Create my own habit is always in view")
        XCTAssertEqual(app.buttons["onboarding-make-own"].label, "Create my own habit")
        let exercise = app.buttons["idea-Exercise"]
        XCTAssertTrue(exercise.waitForExistence(timeout: 3))
        XCTAssertTrue(exercise.label.contains("3 times a week"), "The idea says how often: \(exercise.label)")
        shot("07-first-habit")

        // An idea opens the form straight away (no "What do you want to do?"), filled in; nothing is added until Add.
        exercise.tap()
        let field = app.descendants(matching: .any)["name-field"]
        XCTAssertTrue(field.waitForExistence(timeout: 5))
        XCTAssertFalse(app.staticTexts["What do you want to do?"].exists)
        XCTAssertEqual(field.value as? String, "Exercise")
        XCTAssertTrue(app.descendants(matching: .any)["habit-sentence"].label.contains("3 times a week"),
                      "How often comes from the idea: \(app.descendants(matching: .any)["habit-sentence"].label)")
        shot("08-idea-form")
        app.buttons["add-habit"].tap()

        // The welcome has gone and the habit is on Today.
        XCTAssertTrue(app.buttons["Add 1 to Exercise"].waitForExistence(timeout: 5), "The new habit shows on Today")
        XCTAssertFalse(page("onboarding-page-welcome").exists)
        shot("09-today")

        // The day start chosen in the welcome is the app's setting.
        app.buttons["menu-button"].tap()
        app.buttons["menu-dayAndWeek"].tap()
        let setting = app.buttons["day-start-picker"]
        XCTAssertTrue(setting.waitForExistence(timeout: 5))
        XCTAssertTrue(setting.label.contains("3:00"), "Day and Week shows the welcome's choice: \(setting.label)")
    }

    /// "Create my own habit" is exactly what + opens, as the next page; Back returns to the ideas; a habit made there
    /// ends the welcome on Today.
    func testCreateMyOwnHabitIsTheUsualNewFlow() {
        launch()
        toFirstHabit()
        tap("onboarding-make-own")
        XCTAssertTrue(app.staticTexts["What do you want to do?"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.navigationBars["New"].exists)
        for choice in ["Build or maintain", "Quit or cut down", "Add a task"] {
            XCTAssertTrue(text(containing: choice).exists, choice)
        }
        shot("01-new")
        app.navigationBars["New"].buttons.firstMatch.tap()
        XCTAssertTrue(page("onboarding-page-ideas").waitForExistence(timeout: 5), "Back returns to the ideas")

        tap("onboarding-make-own")
        XCTAssertTrue(app.staticTexts["What do you want to do?"].waitForExistence(timeout: 5))
        text(containing: "Build or maintain").tap()
        XCTAssertTrue(app.staticTexts["How do you want to track it?"].waitForExistence(timeout: 5))
        text(containing: "Check it off").tap()
        let field = app.descendants(matching: .any)["name-field"]
        XCTAssertTrue(field.waitForExistence(timeout: 5))
        field.tap()
        field.typeText("Stretch")
        app.buttons["add-habit"].tap()
        XCTAssertTrue(app.buttons["Mark Stretch done"].waitForExistence(timeout: 5), "The habit made in New is on Today")
        XCTAssertFalse(page("onboarding-page-ideas").exists)
    }

    /// Skip setup goes straight to Today, which is never a dead end: an idea, a restore, the help.
    func testSkipSetupLeadsToAHelpfulToday() {
        launch()
        XCTAssertTrue(page("onboarding-page-welcome").waitForExistence(timeout: 10))
        tap("onboarding-new")
        tap("onboarding-skip")

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

    /// I've used it before: every way back on one page, each opening its own; the transfer code typed key by key, as
    /// a person types it; the loading page's words; and Start without restoring.
    func testReturningWaysBack() {
        launch()
        XCTAssertTrue(page("onboarding-page-welcome").waitForExistence(timeout: 10))
        tap("onboarding-returning")
        XCTAssertTrue(page("onboarding-page-returning").waitForExistence(timeout: 5))
        XCTAssertTrue(text(containing: "Get your habits, tasks and history back.").exists)
        XCTAssertFalse(app.descendants(matching: .any)["onboarding-found"].exists, "Nothing on this iPhone, nothing signed in")
        for id in ["onboarding-way-sign-in", "onboarding-way-restore", "onboarding-way-transfer", "onboarding-start-fresh"] {
            XCTAssertTrue(app.buttons[id].exists, id)
        }
        shot("R01-welcome-back")

        // Sign back in: Apple and Google, and Restore a backup instead.
        tap("onboarding-way-sign-in")
        XCTAssertTrue(page("onboarding-page-sign-in").waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons["onboarding-google"].exists)
        XCTAssertTrue(app.buttons["onboarding-apple"].exists)
        shot("R02-sign-back-in")
        tap("onboarding-restore-instead")
        XCTAssertTrue(page("onboarding-page-restore").waitForExistence(timeout: 5))
        XCTAssertTrue(text(containing: "Where is your backup stored?").waitForExistence(timeout: 5), "No iCloud backup in a test launch")
        XCTAssertTrue(app.buttons["onboarding-restore-file"].exists)
        shot("R04-restore-a-backup")
        app.navigationBars.buttons.firstMatch.tap()
        XCTAssertTrue(page("onboarding-page-sign-in").waitForExistence(timeout: 5))
        app.navigationBars.buttons.firstMatch.tap()
        XCTAssertTrue(page("onboarding-page-returning").waitForExistence(timeout: 5))

        // Move from another device: the code, typed key by key, is cleaned as it's typed; Get my data waits for all
        // eight characters.
        tap("onboarding-way-transfer")
        XCTAssertTrue(page("onboarding-page-transfer").waitForExistence(timeout: 5))
        let field = app.textFields["onboarding-transfer-code"]
        XCTAssertTrue(field.waitForExistence(timeout: 5))
        if !app.keyboards.firstMatch.waitForExistence(timeout: 3) { field.tap() }
        let get = app.buttons["onboarding-get-data"]
        XCTAssertFalse(get.isEnabled, "Nothing to get without a code")
        var typed = ""
        for key in "k7pq-49x" {
            field.typeText(String(key))
            if key != "-" { typed.append(Character(String(key).uppercased())) }
            // The field puts the cleaned code back on the next turn (U6): compare what it holds once cleaned.
            let shown = ((field.value as? String) ?? "").uppercased().filter { $0 != "-" }
            XCTAssertEqual(shown, typed, "After \(key)")
        }
        XCTAssertFalse(get.isEnabled, "Seven characters aren't a code")
        field.typeText("m")
        XCTAssertTrue(get.waitForExistence(timeout: 2) && get.isEnabled, "Eight characters are")
        shot("R07-transfer-code")
        get.tap()
        XCTAssertTrue(page("onboarding-page-working").waitForExistence(timeout: 5))
        XCTAssertEqual(page("onboarding-page-working").label, "Getting your data.")
        XCTAssertTrue(text(containing: "From your other device.").exists)
        shot("R08-getting-your-data")
        // No device is showing this code: the server has nothing for it, and the page says so (through the server
        // since 10 Oct 2026; a wrong code is told within seconds).
        // `firstMatch`: the page reads as one element, which carries the text's id as well as the text itself.
        let failure = app.staticTexts["onboarding-working-failure"].firstMatch
        XCTAssertTrue(failure.waitForExistence(timeout: 30), "A code nobody showed is refused")
        XCTAssertTrue(failure.label.hasPrefix("That code doesn't match"), failure.label)
        shot("R08-code-doesnt-match")
        tap("onboarding-working-main")
        XCTAssertTrue(page("onboarding-page-transfer").waitForExistence(timeout: 5), "Enter the code again returns to the code")
        app.navigationBars.buttons.firstMatch.tap()

        // Start without restoring: Today, empty.
        XCTAssertTrue(page("onboarding-page-returning").waitForExistence(timeout: 5))
        tap("onboarding-start-fresh")
        XCTAssertTrue(app.staticTexts["No habits yet"].waitForExistence(timeout: 5))
    }

    /// Move from another device through the server, end to end with the dev server (the user, 10 Oct 2026: "server
    /// based … like WhatsApp"): the old device seals its habits with its code and hands them to the server; the new one,
    /// on the welcome, types the code and gets them, without either needing an account or the same network.
    func testMoveFromAnotherDeviceThroughTheServer() {
        let code = String((0..<8).map { _ in "0123456789ABCDEFGHJKMNPQRSTVWXYZ".randomElement()! })
        // The old device: the demo habits; ≡ › Backup & Export › Move to Another Device shows this test's code.
        launch(onboarding: false, empty: false, extra: ["-transfer-code", code])
        // Water, in Anytime, is shown at any hour (Stretch's Morning card folds once its hour has passed).
        XCTAssertTrue(app.buttons["Add 1 glass to Water"].waitForExistence(timeout: 15), "The old device has the demo habits")
        let menuButton = app.buttons["menu-button"], backupRow = app.buttons["menu-backup"]
        XCTAssertTrue(menuButton.waitForExistence(timeout: 10))
        menuButton.tap()
        XCTAssertTrue(backupRow.waitForExistence(timeout: 5))
        // The menu has finished opening before its row is tapped (T12).
        let open = XCTNSPredicateExpectation(predicate: NSPredicate(format: "hittable == true"), object: backupRow)
        XCTAssertEqual(XCTWaiter.wait(for: [open], timeout: 5), .completed, "The menu opened")
        backupRow.tap()
        XCTAssertTrue(app.buttons["backup-move"].waitForExistence(timeout: 5))
        app.buttons["backup-move"].tap()
        XCTAssertTrue(app.staticTexts["Waiting for the other device…"].waitForExistence(timeout: 30), "Handed to the server")
        shot("M01-old-device-waiting")
        // Ends without leaving the screen, so the sealed file waits on the server (for at most its hour).
        app.terminate()

        // The new device: nothing on it, the welcome.
        launch()
        XCTAssertTrue(page("onboarding-page-welcome").waitForExistence(timeout: 10))
        tap("onboarding-returning")
        tap("onboarding-way-transfer")
        let field = app.textFields["onboarding-transfer-code"]
        XCTAssertTrue(field.waitForExistence(timeout: 5))
        if !app.keyboards.firstMatch.waitForExistence(timeout: 3) { field.tap() }
        field.typeText(code)
        tap("onboarding-get-data")
        let failure = app.staticTexts["onboarding-working-failure"].firstMatch
        XCTAssertTrue(app.buttons["Add 1 glass to Water"].waitForExistence(timeout: 45),
                      "The habits arrived: \(failure.exists ? failure.label : "no failure shown")")
        shot("M02-new-device-today")
    }

    /// Data already on this iPhone (here, the demo habits): Welcome back offers it first; Continue says it's setting
    /// things up (not "getting" anything) and opens Today with it.
    func testDataOnThisDeviceComesFirst() {
        launch(empty: false)
        XCTAssertTrue(page("onboarding-page-welcome").waitForExistence(timeout: 10))
        tap("onboarding-returning")
        let found = app.descendants(matching: .any)["onboarding-found"]
        XCTAssertTrue(found.waitForExistence(timeout: 5))
        XCTAssertTrue(found.label.contains("We found data on this device."), found.label)
        XCTAssertTrue(found.label.contains("Continue with this data?"), found.label)
        XCTAssertTrue(text(containing: "Other ways to get your data").exists)
        shot("R01B-found-data")
        tap("onboarding-found-continue")
        // The page shows for about a second (`WorkingPage.settle`), so its title is checked in the same query that
        // finds it: a second query can come after Today has replaced it (run 37995167302).
        let working = app.staticTexts.matching(NSPredicate(format: "identifier == %@ AND label == %@",
                                                           "onboarding-page-working", "Setting things up.")).firstMatch
        XCTAssertTrue(working.waitForExistence(timeout: 5), "Continue shows \"Setting things up.\"")
        shot("R09-setting-things-up")
        XCTAssertTrue(app.buttons["menu-button"].waitForExistence(timeout: 10), "Today opens with the data")
        XCTAssertFalse(page("onboarding-page-working").exists)
    }

    /// Help: search, Contact Us without a mail app, and the welcome again (what's included and what the app does).
    func testHelpAndTheWelcomeAgain() {
        launch()
        XCTAssertTrue(page("onboarding-page-welcome").waitForExistence(timeout: 10))
        tap("onboarding-new")
        tap("onboarding-skip")
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

        // The welcome again: what's included and the three pages on what the app does, then Done, back on Help.
        XCTAssertTrue(app.buttons["help-welcome"].waitForExistence(timeout: 5))
        app.buttons["help-welcome"].tap()
        XCTAssertTrue(page("onboarding-page-free").waitForExistence(timeout: 5))
        XCTAssertFalse(app.buttons["onboarding-skip"].exists, "The replay has no Skip setup")
        XCTAssertTrue(app.buttons["onboarding-close"].exists, "The replay can be closed at once")
        next()
        XCTAssertTrue(page("onboarding-page-build").waitForExistence(timeout: 5))
        next()
        XCTAssertTrue(page("onboarding-page-quit").waitForExistence(timeout: 5))
        next()
        XCTAssertTrue(page("onboarding-page-tasks").waitForExistence(timeout: 5))
        XCTAssertEqual(app.buttons["onboarding-continue"].label, "Done")
        next()
        // Done returns to Help (its search may still be active from above, which hides the page's title).
        XCTAssertTrue(app.buttons["help-welcome"].waitForExistence(timeout: 5), "Done returns to Help")
        XCTAssertFalse(page("onboarding-page-tasks").exists)

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

    /// Without `-onboarding` (every other test, and anyone who already has habits) the welcome never shows.
    func testNoWelcomeInOtherRuns() {
        launch(onboarding: false)
        XCTAssertTrue(app.staticTexts["No habits yet"].waitForExistence(timeout: 10))
        XCTAssertFalse(page("onboarding-page-welcome").exists)
    }

    /// The largest text size: the first screen's answers can be reached, and every page keeps its bottom button on
    /// screen (C145).
    func testLargestTextReachesContinue() {
        launch(extra: ["-UIPreferredContentSizeCategoryName", "UICTContentSizeCategoryAccessibilityXXXL"])
        XCTAssertTrue(page("onboarding-page-welcome").waitForExistence(timeout: 10))
        tap("onboarding-new")
        for _ in 0..<5 {
            let button = app.buttons["onboarding-continue"]
            XCTAssertTrue(button.waitForExistence(timeout: 5))
            XCTAssertTrue(button.isHittable, "Continue is on screen at the largest text size")
            button.tap()
        }
        XCTAssertTrue(app.buttons["onboarding-make-own"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons["onboarding-make-own"].isHittable)
        shot("01-largest-text-first-habit")
    }
}
