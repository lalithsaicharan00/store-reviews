import XCTest

/// The iPad (Current Work 86; `iOS/Docs/iPad/`): the sidebar, Today's column and its top-centre day control, Day details
/// as a popover at its row (and everything pushed inside it), a narrow window as the iPhone app, a typed amount surviving
/// rotation and the window changing width, Habits list–detail, Progress, the settings pages, sheets and popovers, the
/// Columns view and the keyboard's commands. Screenshots of every designed screen, landscape and portrait, to compare
/// with `iOS/Docs/iPad/Designs/`. Skipped on an iPhone (its own tests cover it). Failures say what was on screen in one
/// line (Rulebook T14).
final class IPadUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = true
        try XCTSkipUnless(UIDevice.current.userInterfaceIdiom == .pad, "iPad only")
        app = XCUIApplication()
        XCUIDevice.shared.orientation = .landscapeLeft
    }

    override func tearDown() {
        XCUIDevice.shared.orientation = .portrait
        super.tearDown()
    }

    override func record(_ issue: XCTIssue) {
        var issue = issue
        let shot = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        shot.name = "FAIL-\(name)"
        shot.lifetime = .keepAlways
        issue.add(shot)
        let tree = XCTAttachment(string: app?.debugDescription ?? "No app")
        tree.name = "accessibility-tree"
        tree.lifetime = .keepAlways
        issue.add(tree)
        super.record(issue)
    }

    private func shot(_ name: String) {
        let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        attachment.name = "ipad-" + name
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    private func launch(_ extra: [String] = [], landscape: Bool = true) {
        XCUIDevice.shared.orientation = landscape ? .landscapeLeft : .portrait
        app.launchArguments = ["-uitest", "-appearance.theme", "light"] + extra
        app.launch()
        XCTAssertTrue(today.waitForExistence(timeout: 20), "Today: \(labels())")
    }

    // MARK: Elements

    private func any(_ id: String) -> XCUIElement { app.descendants(matching: .any)[id].firstMatch }
    private var today: XCUIElement { app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Today,' OR label BEGINSWITH 'Yesterday,' OR label BEGINSWITH 'Tomorrow,'")).firstMatch }
    private var sidebar: XCUIElement { any("pad-sidebar") }
    private var result: XCUIElement { any("day-result") }
    private var amount: XCUIElement { app.textFields["record-amount"].firstMatch }

    /// What's on screen, on one line: the labels that matter (T14).
    private func labels() -> String {
        let tree = app.debugDescription
        let pattern = try! NSRegularExpression(pattern: "(?:identifier|label): '([^']*)'")
        let range = NSRange(tree.startIndex..., in: tree)
        var seen = Set<String>()
        return pattern.matches(in: tree, range: range).compactMap { Range($0.range(at: 1), in: tree).map { String(tree[$0]) } }
            .filter { !$0.isEmpty && seen.insert($0).inserted }
            .prefix(60).joined(separator: " | ")
    }

    private func frame(_ element: XCUIElement) -> String {
        let f = element.frame
        return "\(Int(f.minX)),\(Int(f.minY)) \(Int(f.width))×\(Int(f.height))"
    }

    private func openRow(_ name: String) {
        let row = app.staticTexts[name].firstMatch
        app.reveal(row, clear: true)
        row.tap()
        XCTAssertTrue(result.waitForExistence(timeout: 6), "\(name) opens Day details: \(labels())")
    }

    /// A tap where nothing is: the top bar's empty middle-left, beside the sidebar.
    private func tapOutside() {
        app.windows.firstMatch.coordinate(withNormalizedOffset: CGVector(dx: 0.97, dy: 0.97)).tap()
    }

    private func place(_ id: String) {
        if !sidebar.exists { any("sidebar-button").tap() }
        XCTAssertTrue(sidebar.waitForExistence(timeout: 5), "Sidebar: \(labels())")
        app.buttons[id].firstMatch.tap()
    }

    // MARK: Today, the sidebar and the day control

    func testSidebarTodayColumnAndDayControl() {
        launch()
        // Landscape: the sidebar beside Today, its rows in the ≡ menu's order, "N left" beside Today.
        XCTAssertTrue(sidebar.waitForExistence(timeout: 5), "Sidebar in landscape: \(labels())")
        for id in ["menu-today", "menu-progress", "menu-habits", "menu-tasks", "menu-timesOfDay", "menu-dayAndWeek",
                   "menu-reminders", "menu-appearance", "menu-backup", "menu-privacy", "menu-plus", "menu-help", "menu-about"] {
            XCTAssertTrue(app.buttons[id].exists, "Sidebar row \(id): \(labels())")
        }
        XCTAssertTrue(app.buttons["menu-today"].label.contains("left"), "\"N left\" beside Today: \(app.buttons["menu-today"].label)")
        let order = ["menu-today", "menu-progress", "menu-habits", "menu-tasks", "menu-timesOfDay", "menu-help", "menu-about"]
            .map { app.buttons[$0].frame.minY }
        XCTAssertEqual(order, order.sorted(), "The menu's order")
        // No ≡ on the iPad; the day control at the top centre (‹ · Today ⌄ · ›), not in a bottom bar.
        XCTAssertFalse(app.buttons["menu-button"].exists, "No ≡ on the iPad")
        let window = app.windows.firstMatch.frame
        XCTAssertLessThan(today.frame.midY, 120, "The day control is at the top: \(frame(today))")
        let content = window.maxX - (sidebar.frame.maxX)
        XCTAssertLessThan(abs(today.frame.midX - (sidebar.frame.maxX + content / 2)), 60, "…centred beside the sidebar: \(frame(today)) sidebar \(frame(sidebar))")
        // Today's cards: one column at most ~700 pt, centred in the room beside the sidebar.
        let header = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Anytime'")).firstMatch
        XCTAssertTrue(header.waitForExistence(timeout: 5), "Anytime's header: \(labels())")
        let card = app.collectionViews.firstMatch.cells.containing(.button, identifier: nil).firstMatch
        XCTAssertLessThanOrEqual(card.frame.width, 720, "The column is ≈ 700 pt: header \(frame(header)), cell \(frame(card))")
        XCTAssertGreaterThanOrEqual(card.frame.width, 600, "…and uses the room: cell \(frame(card))")
        let room = (sidebar.frame.maxX, window.maxX)
        XCTAssertLessThan(abs(card.frame.midX - (room.0 + room.1) / 2), 30, "…centred: cell \(frame(card)), room \(room)")
        shot("01-today-landscape")

        // ‹ and › change the day; Back to Today appears beside the control on another day.
        app.buttons["Previous day"].firstMatch.tap()
        XCTAssertTrue(app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Yesterday'")).firstMatch.waitForExistence(timeout: 3), labels())
        XCTAssertTrue(app.buttons["back-to-today"].exists, "Back to Today on another day: \(labels())")
        XCTAssertLessThan(app.buttons["back-to-today"].frame.midY, 120, "…at the top: \(frame(app.buttons["back-to-today"]))")
        app.buttons["back-to-today"].tap()
        XCTAssertTrue(app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Today,'")).firstMatch.waitForExistence(timeout: 3), labels())
        XCTAssertFalse(app.buttons["back-to-today"].exists, "No Back to Today on today")

        // Put the sidebar away: its button comes to Today's top left; Today stays one centred column.
        app.buttons["sidebar-hide"].tap()
        XCTAssertTrue(sidebar.waitForNonExistence(timeout: 3), labels())
        XCTAssertTrue(any("sidebar-button").waitForExistence(timeout: 3), "The sidebar button at the top left: \(labels())")
        shot("01-today-landscape-sidebar-away")
        any("sidebar-button").tap()
        XCTAssertTrue(sidebar.waitForExistence(timeout: 3), labels())

        // Portrait: the sidebar is put away and slides over Today, which doesn't move.
        XCUIDevice.shared.orientation = .portrait
        XCTAssertTrue(sidebar.waitForNonExistence(timeout: 5), "Portrait puts the sidebar away: \(labels())")
        let before = header.frame
        shot("01-today-portrait")
        any("sidebar-button").tap()
        XCTAssertTrue(sidebar.waitForExistence(timeout: 3), labels())
        XCTAssertEqual(header.frame.minX, before.minX, accuracy: 1, "Today doesn't move under the sidebar")
        shot("01-today-portrait-sidebar-over")
        app.buttons["menu-today"].tap()
        XCTAssertTrue(sidebar.waitForNonExistence(timeout: 3), "Choosing a row puts the slid-over sidebar away: \(labels())")
    }

    // MARK: Day details as a popover

    func testDayDetailsPopoverLogsAndAllLogs() {
        launch()
        openRow("Water")
        // A popover at the row: no ✕, the iPhone's width, Today still there beside it.
        XCTAssertFalse(app.buttons["day-close"].exists, "No ✕ in the popover: \(labels())")
        let form = app.collectionViews["day-form"]
        XCTAssertEqual(form.frame.width, 375, accuracy: 30, "The iPhone's width: \(frame(form))")
        XCTAssertTrue(sidebar.exists, "Today and the sidebar stay in view")
        shot("02-day-details-landscape")
        // +1 a few times: the logs, then "All N logs" pushed inside the popover with a back button.
        for _ in 0..<4 { app.buttons["day-add-step"].firstMatch.tap() }
        let all = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'All '")).firstMatch
        if all.waitForExistence(timeout: 3) {
            shot("03-day-details-many-logs")
            all.tap()
            XCTAssertTrue(any("all-logs").waitForExistence(timeout: 3), "All logs inside the popover: \(labels())")
            shot("03-all-logs-in-popover")
        }
        // A tap outside closes it.
        tapOutside()
        XCTAssertTrue(result.waitForNonExistence(timeout: 4), "A tap outside closes Day details: \(labels())")

        // Portrait: the same popover.
        XCUIDevice.shared.orientation = .portrait
        openRow("Call family")
        XCTAssertFalse(app.buttons["day-close"].exists, "No ✕ in portrait either")
        shot("02-day-details-portrait")
        tapOutside()
        XCTAssertTrue(result.waitForNonExistence(timeout: 4), labels())
    }

    func testAddLogInsidePopoverSurvivesRotationAndOutsideTaps() {
        launch()
        openRow("Water")
        app.buttons["day-add-entry"].firstMatch.tap()
        XCTAssertTrue(amount.waitForExistence(timeout: 5), "Add log pushed inside the popover: \(labels())")
        XCTAssertTrue(app.buttons["record-cancel"].exists || app.buttons["Cancel"].exists, "Add log keeps ✕: \(labels())")
        amount.typeText("2")
        shot("04-add-log-keyboard-landscape")
        // Something typed: a tap outside doesn't close it.
        tapOutside()
        XCTAssertTrue(amount.waitForExistence(timeout: 2), "Typing survives a tap outside: \(labels())")
        // Rotation keeps the typed amount.
        XCUIDevice.shared.orientation = .portrait
        XCTAssertTrue(amount.waitForExistence(timeout: 5), "Add log survives rotation: \(labels())")
        XCTAssertEqual(amount.value as? String, "2", "The typed amount survives rotation")
        shot("04-add-log-keyboard-portrait")
        XCUIDevice.shared.orientation = .landscapeLeft
        XCTAssertEqual(amount.value as? String, "2", "…and rotating back")
        // Add: back to Day details inside the popover, with the new log.
        app.buttons["record-add"].tap()
        XCTAssertTrue(result.waitForExistence(timeout: 5), "Add returns to Day details: \(labels())")
        XCTAssertTrue(app.descendants(matching: .any).matching(NSPredicate(format: "label BEGINSWITH '2 glasses'")).firstMatch.waitForExistence(timeout: 3),
                      "The log of 2: \(labels())")
    }

    /// The window goes narrow mid-edit and back (Build Prompt §1, priority 2): the popover becomes the iPhone's sheet and
    /// back, and the typed amount stays.
    func testNarrowWindowMidEditKeepsTheTypedAmount() {
        let start = Date()
        launch(["-pad-size-script", "30:compact,60:regular"])
        openRow("Water")
        app.buttons["day-add-entry"].firstMatch.tap()
        XCTAssertTrue(amount.waitForExistence(timeout: 5), labels())
        amount.typeText("3")
        _ = XCTWaiter.wait(for: [XCTestExpectation(description: "narrow")], timeout: max(1, 46 - Date().timeIntervalSince(start)))
        XCTAssertTrue(amount.waitForExistence(timeout: 5), "Narrow: Add log still open: \(labels())")
        XCTAssertEqual(amount.value as? String, "3", "Narrow: the typed amount stays")
        shot("05-narrow-mid-edit")
        _ = XCTWaiter.wait(for: [XCTestExpectation(description: "wide")], timeout: max(1, 76 - Date().timeIntervalSince(start)))
        XCTAssertTrue(amount.waitForExistence(timeout: 5), "Wide again: Add log still open: \(labels())")
        XCTAssertEqual(amount.value as? String, "3", "Wide again: the typed amount stays")
        app.buttons["record-add"].tap()
        XCTAssertTrue(app.descendants(matching: .any).matching(NSPredicate(format: "label BEGINSWITH '3 glasses'")).firstMatch.waitForExistence(timeout: 5),
                      "Saved once, after both changes: \(labels())")
    }

    func testNarrowWindowIsTheIPhoneApp() {
        launch(["-pad-compact"])
        // The iPhone's Today: the sidebar put away behind its button, the day bar at the bottom, Day details as a sheet with ✕.
        XCTAssertFalse(sidebar.exists, "Narrow: no sidebar beside Today: \(labels())")
        XCTAssertTrue(any("sidebar-button").exists, "Narrow: the sidebar button: \(labels())")
        XCTAssertGreaterThan(today.frame.midY, app.windows.firstMatch.frame.height - 140, "Narrow: the day bar at the bottom: \(frame(today))")
        shot("05-narrow-window")
        openRow("Water")
        XCTAssertTrue(app.buttons["day-close"].waitForExistence(timeout: 3), "Narrow: the iPhone's sheet with ✕: \(labels())")
        shot("05-narrow-day-details-sheet")
        app.buttons["day-close"].tap()
        XCTAssertTrue(result.waitForNonExistence(timeout: 4), labels())
        any("sidebar-button").tap()
        XCTAssertTrue(sidebar.waitForExistence(timeout: 3), "Narrow: the sidebar slides over: \(labels())")
        app.buttons["menu-progress"].tap()
        XCTAssertTrue(app.navigationBars["Progress"].waitForExistence(timeout: 5), labels())
    }

    // MARK: The other places

    func testHabitsListAndPageSideBySide() {
        launch()
        place("menu-habits")
        XCTAssertTrue(app.buttons["habits-row-Read"].waitForExistence(timeout: 5), "The Habits list: \(labels())")
        app.buttons["habits-row-Read"].tap()
        XCTAssertTrue(app.staticTexts["Read"].waitForExistence(timeout: 3), labels())
        XCTAssertTrue(app.buttons["habits-row-Water"].exists, "The list stays beside the page")
        shot("06-habits-list-detail-landscape")
        app.buttons["habits-row-Water"].tap()
        XCTAssertTrue(app.buttons["habits-row-Read"].exists, "Moving between habits needs no Back")
        XCUIDevice.shared.orientation = .portrait
        XCTAssertTrue(app.buttons["habits-row-Read"].waitForExistence(timeout: 5), "Portrait: list and page side by side: \(labels())")
        shot("06-habits-list-detail-portrait")
        place("menu-tasks")
        shot("06-tasks")
    }

    func testProgressTwoAcrossWithRangeAtTheTop() {
        launch()
        place("menu-progress")
        let range = app.segmentedControls["progress-range"].firstMatch
        XCTAssertTrue(range.waitForExistence(timeout: 5), "Week · Month · Year: \(labels())")
        XCTAssertLessThan(range.frame.midY, 120, "…at the top centre: \(frame(range))")
        let cards = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'progress-row-'"))
        XCTAssertTrue(cards.firstMatch.waitForExistence(timeout: 5), labels())
        if cards.count >= 2 {
            XCTAssertEqual(cards.element(boundBy: 0).frame.minY, cards.element(boundBy: 1).frame.minY, accuracy: 2,
                           "Two across: \(frame(cards.element(boundBy: 0))) and \(frame(cards.element(boundBy: 1)))")
        }
        shot("07-progress-landscape")
        range.buttons["Month"].tap(); shot("07-progress-month")
        range.buttons["Year"].tap(); shot("07-progress-year")
        range.buttons["Week"].tap()
        XCUIDevice.shared.orientation = .portrait
        _ = cards.firstMatch.waitForExistence(timeout: 5)
        shot("07-progress-portrait")
    }

    func testSettingsPagesBesideTheSidebar() {
        launch()
        for (id, name) in [("menu-timesOfDay", "times-of-day"), ("menu-dayAndWeek", "day-and-week"), ("menu-reminders", "reminders"),
                           ("menu-appearance", "appearance"), ("menu-backup", "icloud-backup"), ("menu-privacy", "privacy"),
                           ("menu-plus", "plus"), ("menu-help", "help"), ("menu-about", "about")] {
            place(id)
            XCTAssertTrue(sidebar.exists, "\(name) beside the sidebar")
            let list = app.collectionViews.firstMatch
            _ = list.waitForExistence(timeout: 5)
            shot("12-\(name)-landscape")
        }
        // The iPad's words and rows (README, "Words that change on the iPad").
        place("menu-appearance")
        XCTAssertTrue(app.buttons["appearance-layout"].exists || any("appearance-layout").exists, "Appearance → Layout on the iPad: \(labels())")
        XCTAssertFalse(app.switches["appearance-haptics"].exists, "No Haptics row on the iPad")
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label CONTAINS 'follows your iPad'")).firstMatch.exists, "\"your iPad\": \(labels())")
        XCTAssertFalse(app.staticTexts.matching(NSPredicate(format: "label CONTAINS 'Dynamic Island'")).firstMatch.exists, "No Dynamic Island")
        place("menu-reminders")
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label ==[c] 'On This iPad'")).firstMatch.waitForExistence(timeout: 3), "\"On This iPad\": \(labels())")
        // A page a setting opens is pushed in the same place.
        place("menu-timesOfDay")
        let morning = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Morning'")).firstMatch
        if morning.waitForExistence(timeout: 3) {
            morning.tap()
            XCTAssertTrue(sidebar.exists, "Pushed beside the sidebar")
            shot("13-time-of-day")
        }
        XCUIDevice.shared.orientation = .portrait
        place("menu-about")
        shot("12-about-portrait")
    }

    func testSheetsAndPopovers() {
        launch()
        // The calendar: a popover from "Today ⌄", no Done.
        today.tap()
        XCTAssertTrue(any("calendar-month").waitForExistence(timeout: 4), "Calendar popover: \(labels())")
        XCTAssertFalse(app.buttons["Done"].exists, "No Done in the calendar popover")
        shot("09-calendar-popover")
        tapOutside()
        XCTAssertTrue(any("calendar-month").waitForNonExistence(timeout: 3), labels())
        // Filter: a popover from its button; Edit Group pushed inside it.
        app.buttons["filter-button"].tap()
        XCTAssertTrue(app.navigationBars["Filter"].waitForExistence(timeout: 4), "Filter popover: \(labels())")
        XCTAssertFalse(app.buttons["Done"].exists, "No Done in the Filter popover")
        shot("09-filter-popover")
        if app.buttons["groups-edit"].exists {
            app.buttons["groups-edit"].tap()
            let row = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'groups-row-'")).firstMatch
            if row.waitForExistence(timeout: 3) { row.tap(); shot("09-edit-group-in-filter") }
        }
        tapOutside()
        // New (+): a form sheet in the middle of the screen.
        app.buttons["New Habit"].firstMatch.tap()
        let title = app.navigationBars["New"].firstMatch
        XCTAssertTrue(title.waitForExistence(timeout: 4), "New: \(labels())")
        XCTAssertLessThan(title.frame.width, app.windows.firstMatch.frame.width - 200, "A form sheet, not full width: \(frame(title))")
        shot("08-new-form-sheet")
        let build = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Build or maintain'")).firstMatch
        if build.exists { build.tap(); shot("08-how-to-track") }
    }

    func testArrangeTimerAndPlayerFullScreen() {
        launch()
        app.buttons["arrange-button"].tap()
        XCTAssertTrue(app.buttons["arrange-done"].waitForExistence(timeout: 4), labels())
        shot("10-arrange-your-day")
        app.buttons["arrange-done"].tap()
        // The timer: full screen, ⌄ puts it away.
        let start = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Start Read'")).firstMatch
        app.reveal(start, clear: true)
        if start.exists {
            start.tap()
            let screen = any("timer-screen")
            XCTAssertTrue(screen.waitForExistence(timeout: 5), "Timer: \(labels())")
            XCTAssertEqual(screen.frame.width, app.windows.firstMatch.frame.width, accuracy: 2, "Full screen: \(frame(screen))")
            shot("11-timer-full-screen")
            app.buttons["timer-screen-close"].tap()
            XCTAssertTrue(screen.waitForNonExistence(timeout: 4), labels())
        }
    }

    // MARK: Columns and the keyboard

    func testColumnsViewAndKeyboardCommands() {
        launch()
        // ⌘2: Columns. Each time of day its own column, side by side.
        app.typeKey("2", modifierFlags: .command)
        XCTAssertTrue(any("today-columns").waitForExistence(timeout: 4), "⌘2 shows Columns: \(labels())")
        let columns = app.descendants(matching: .any).matching(NSPredicate(format: "identifier BEGINSWITH 'today-column-'"))
        XCTAssertGreaterThanOrEqual(columns.count, 2, labels())
        if columns.count >= 2 {
            XCTAssertEqual(columns.element(boundBy: 0).frame.minY, columns.element(boundBy: 1).frame.minY, accuracy: 2, "Side by side")
        }
        shot("16-columns-landscape")
        // A row in a column opens Day details at itself (Morning's, the first column).
        openRow("Stretch")
        tapOutside()
        // ⌘1: List again.
        app.typeKey("1", modifierFlags: .command)
        XCTAssertTrue(any("today-columns").waitForNonExistence(timeout: 4), "⌘1 shows the list: \(labels())")
        // ⌘← and ⌘→ change the day, ⌘T goes back to today.
        app.typeKey(XCUIKeyboardKey.leftArrow.rawValue, modifierFlags: .command)
        XCTAssertTrue(app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Yesterday'")).firstMatch.waitForExistence(timeout: 3), "⌘←: \(labels())")
        app.typeKey("t", modifierFlags: .command)
        XCTAssertTrue(app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Today,'")).firstMatch.waitForExistence(timeout: 3), "⌘T: \(labels())")
        app.typeKey(XCUIKeyboardKey.rightArrow.rawValue, modifierFlags: .command)
        XCTAssertTrue(app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Tomorrow'")).firstMatch.waitForExistence(timeout: 3), "⌘→: \(labels())")
        app.typeKey("t", modifierFlags: .command)
        // ⌃⌘S hides and shows the sidebar.
        app.typeKey("s", modifierFlags: [.control, .command])
        XCTAssertTrue(sidebar.waitForNonExistence(timeout: 3), "⌃⌘S hides the sidebar: \(labels())")
        app.typeKey("s", modifierFlags: [.control, .command])
        XCTAssertTrue(sidebar.waitForExistence(timeout: 3), "⌃⌘S shows it: \(labels())")
        // ⌘N: New.
        app.typeKey("n", modifierFlags: .command)
        XCTAssertTrue(app.navigationBars["New"].waitForExistence(timeout: 4), "⌘N opens New: \(labels())")
        app.navigationBars["New"].buttons.firstMatch.tap()
        XCTAssertTrue(app.navigationBars["New"].waitForNonExistence(timeout: 4), "New's ✕: \(labels())")
        // Appearance → Layout: Columns, for people without a keyboard.
        place("menu-appearance")
        let picker = app.buttons["appearance-layout"].firstMatch
        if picker.waitForExistence(timeout: 3) {
            picker.tap()
            app.buttons["Columns"].firstMatch.tap()
            place("menu-today")
            XCTAssertTrue(any("today-columns").waitForExistence(timeout: 4), "Appearance → Layout → Columns: \(labels())")
        }
    }

    func testWelcomeAndEmptyToday() {
        app.launchArguments = ["-uitest", "-empty", "-appearance.theme", "light"]
        app.launch()
        _ = app.buttons.firstMatch.waitForExistence(timeout: 15)
        shot("14-welcome-or-empty-landscape")
        XCUIDevice.shared.orientation = .portrait
        shot("14-welcome-or-empty-portrait")
    }

    // MARK: Plus and the second device

    func testPlusOnTheIPad() {
        launch(["-free", "-empty", "-plus-fixture"])
        // The Plus page beside the sidebar, in a 540-pt column; the sidebar counts the free plan.
        XCTAssertTrue(app.buttons["menu-plus"].label.contains("5 of 5"), "Sidebar: \(app.buttons["menu-plus"].label)")
        place("menu-plus")
        XCTAssertTrue(app.navigationBars["Plus"].waitForExistence(timeout: 5), labels())
        let buy = app.buttons["plus-buy"]
        XCTAssertTrue(buy.waitForExistence(timeout: 5), labels())
        XCTAssertLessThanOrEqual(buy.frame.width, 560, "Plus reads in a 540-pt column: \(frame(buy))")
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label CONTAINS 'your iPhone and Apple Watch'")).firstMatch.exists,
                      "Plus names the other devices on the iPad: \(labels())")
        shot("19-plus-page")
        // The 6th habit: a form sheet over Today, Make Room pushed inside it.
        place("menu-today")
        app.buttons["New Habit"].firstMatch.tap()
        XCTAssertTrue(app.navigationBars["New"].waitForExistence(timeout: 5), labels())
        app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Build or maintain'")).firstMatch.tap()
        let title = app.staticTexts["Add a 6th habit"]
        XCTAssertTrue(title.waitForExistence(timeout: 5), labels())
        XCTAssertLessThan(buy.frame.width, app.windows.firstMatch.frame.width - 200, "A form sheet: \(frame(buy))")
        shot("18-sixth-habit")
        app.buttons["plus-make-room"].tap()
        XCTAssertTrue(app.navigationBars["Make Room"].waitForExistence(timeout: 5) || app.staticTexts["Make Room"].waitForExistence(timeout: 2),
                      "Make Room pushed inside the sheet: \(labels())")
        shot("18-make-room")
    }

    func testSecondDeviceSheetOnTheIPad() {
        app.launchArguments = ["-uitest", "-free", "-test-cloud", "free-other"]
        app.launch()
        let title = app.staticTexts["use-here-title"]
        XCTAssertTrue(title.waitForExistence(timeout: 20), labels())
        XCTAssertEqual(title.label, "Use your habits on this iPad?")
        XCTAssertTrue(app.staticTexts["use-here-text"].label.contains("Your iPhone stops syncing and keeps everything it has"),
                      app.staticTexts["use-here-text"].label)
        XCTAssertLessThan(title.frame.width, app.windows.firstMatch.frame.width - 200, "A form sheet: \(frame(title))")
        shot("20-second-device")
        app.buttons["use-here-cancel"].tap()
        XCTAssertTrue(title.waitForNonExistence(timeout: 5))
        place("menu-backup")
        let status = any("cloud-status")
        XCTAssertTrue(status.waitForExistence(timeout: 5) && status.label.contains("Your iPhone is the one syncing"), "\(status.label) — \(labels())")
        app.buttons["cloud-move-here"].tap()
        let device = app.descendants(matching: .any).matching(NSPredicate(format: "identifier == 'cloud-device' AND label CONTAINS 'This iPad is the one syncing'")).firstMatch
        XCTAssertTrue(device.waitForExistence(timeout: 20), labels())
        shot("12-icloud-this-ipad")
    }

    func testPlusEndedIsAFormSheet() {
        launch(["-free", "-empty", "-plus-fixture", "-plus-ended", "refund"])
        let ended = app.staticTexts["Plus has ended"]
        XCTAssertTrue(ended.waitForExistence(timeout: 10), labels())
        XCTAssertLessThan(app.buttons["plus-ended-ok"].frame.width, app.windows.firstMatch.frame.width - 200, "A form sheet")
        shot("20-plus-ended")
        app.buttons["plus-ended-ok"].tap()
        XCTAssertTrue(ended.waitForNonExistence(timeout: 5))
    }
}
