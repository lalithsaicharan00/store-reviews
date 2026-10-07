import XCTest

/// Every screen of the 7 October 2026 redesign (Day Details, Logs and Notes — 7 October Redesign/Images/Every kind),
/// shown as built, in dark mode as the images are: each screenshot is named after its image (`01-1-day-details` for
/// "01 Amount, daily goal — 1 Day details") so the two can be laid side by side for the user's review (Rulebook U9).
/// The habits come from `DayDetailsFixture`; `-open-day` opens a habit's Day details at launch, `-open-add` its Add
/// screen.
final class DayDetailsScreenshotUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = true
        app = XCUIApplication()
    }

    override func record(_ issue: XCTIssue) {
        var issue = issue
        let shot = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        shot.name = "FAIL-\(name)"
        shot.lifetime = .keepAlways
        issue.add(shot)
        super.record(issue)
    }

    private func shot(_ name: String) {
        sleep(1)
        let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    private var result: XCUIElement { app.descendants(matching: .any)["day-result"].firstMatch }
    private var links: XCUIElementQuery { app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'entry-'")) }

    /// Launches on the fixture with `name`'s Day details open.
    private func open(_ name: String, yesterday: Bool = false, light: Bool = false) {
        var arguments = ["-uitest", "-day-details-fixture", "-appearance.theme", light ? "light" : "dark", "-open-day", name]
        if yesterday { arguments += ["-open-day-offset", "-1"] }
        app.launchArguments = arguments
        app.launch()
        // 30 s: the sheet opens once the app has loaded, which took longer than 15 s on one hosted run (4 Oct 2026; its
        // failure screenshot showed the sheet open just after).
        XCTAssertTrue(result.waitForExistence(timeout: 30), "\(name)'s Day details open")
    }

    /// Launches on the fixture with `name`'s Add screen open.
    private func openAdd(_ name: String, yesterday: Bool = false, title: String, thenDay: Bool = false) {
        var arguments = ["-uitest", "-day-details-fixture", "-appearance.theme", "dark", "-open-add", name]
        if yesterday { arguments += ["-open-day-offset", "-1"] }
        if thenDay { arguments += ["-then-open-day"] }
        app.launchArguments = arguments
        app.launch()
        XCTAssertTrue(app.navigationBars[title].waitForExistence(timeout: 30), "\(name)'s \(title) opens")
    }

    private func tap(_ id: String, times: Int = 1) {
        let button = app.buttons[id]
        XCTAssertTrue(button.waitForExistence(timeout: 5), id)
        for _ in 0..<times { button.tap(); usleep(500_000) }
    }

    private func writeNote(_ text: String) {
        tap("day-add-note")
        let field = app.textViews["note-field"]
        XCTAssertTrue(field.waitForExistence(timeout: 5))
        field.tap()
        field.typeText(text)
        app.buttons["note-save"].tap()
        XCTAssertTrue(app.buttons["day-edit-note"].waitForExistence(timeout: 5))
    }

    private func recordSlip() {
        tap("day-add-entry")
        XCTAssertTrue(app.navigationBars["Add slip"].waitForExistence(timeout: 5))
        app.buttons["record-add"].tap()
        XCTAssertTrue(links.firstMatch.waitForExistence(timeout: 5), "The slip shows")
    }

    private func openLog(containing text: String? = nil, title: String = "Log") {
        let link = text.map { t in links.matching(NSPredicate(format: "label CONTAINS %@", t)).firstMatch } ?? links.firstMatch
        XCTAssertTrue(link.waitForExistence(timeout: 5))
        link.tap()
        XCTAssertTrue(app.navigationBars[title].waitForExistence(timeout: 5), "The log's view opens")
    }

    private func edit(_ title: String = "Edit log") {
        tap("record-edit")
        XCTAssertTrue(app.navigationBars[title].waitForExistence(timeout: 5))
    }

    // MARK: 01 Amount, daily goal (Water: 2 logs today)

    func test01_amount() {
        open("Water")
        tap("day-add-step", times: 2)
        writeNote("Big glass after the run. The office bottle was only half full.")
        shot("01-1-day-details")
        tap("day-all-logs")
        XCTAssertTrue(app.navigationBars["Today's logs"].waitForExistence(timeout: 5))
        shot("01-2-all-logs")
        app.navigationBars["Today's logs"].buttons.element(boundBy: 0).tap()
        tap("day-add-entry")
        XCTAssertTrue(app.navigationBars["Add log"].waitForExistence(timeout: 5))
        app.textFields["record-amount"].typeText("2")
        shot("01-3-add-log")
        tap("record-cancel")
        app.alerts.buttons["Discard Changes"].tap()
        openLog()
        shot("01-4-log-view")
        edit()
        shot("01-5-edit-log")
    }

    // MARK: 02–04 Amounts: no unit and a week goal; a currency, no quick step, a month goal; a limit

    func test02_noUnitWeek() {
        open("Push-ups"); tap("day-add-step", times: 2); shot("02-1-day-details")
        tap("day-add-entry"); XCTAssertTrue(app.navigationBars["Add log"].waitForExistence(timeout: 5)); shot("02-2-add-log")
        tap("record-cancel"); openLog(); shot("02-3-log-view"); edit(); shot("02-4-edit-log")
    }

    func test03_currencyMonth() {
        openAdd("Savings", title: "Add log", thenDay: true)
        app.textFields["record-amount"].typeText("15")
        shot("03-2-add-log")
        tap("record-add")
        XCTAssertTrue(result.waitForExistence(timeout: 5))
        shot("03-1-day-details")
        openLog(); shot("03-3-log-view"); edit(); shot("03-4-edit-log")
    }

    func test04_limit() {
        open("Coffee"); tap("day-add-step"); shot("04-1-day-details")
        tap("day-add-entry"); XCTAssertTrue(app.navigationBars["Add log"].waitForExistence(timeout: 5)); shot("04-2-add-log")
        tap("record-cancel"); openLog(); shot("04-3-log-view"); edit(); shot("04-4-edit-log")
    }

    // MARK: 05–07 Time: a daily goal; a running timer and an earlier day; a week goal

    func test05_time() {
        open("Read"); shot("05-1-day-details")
        tap("day-add-entry")
        XCTAssertTrue(app.navigationBars["Add log"].waitForExistence(timeout: 5))
        app.textFields["record-minutes"].typeText("15")
        shot("05-3-add-log")
        tap("record-cancel")
        app.alerts.buttons["Discard Changes"].tap()
        openLog(); shot("05-4-log-view"); edit(); shot("05-5-edit-log")
    }

    func test06_timerRunningAndEarlierDay() {
        open("Read"); tap("day-start-timer"); sleep(3); shot("06-1-day-details-timer-running")
        app.terminate()
        open("Read", yesterday: true); shot("06-2-day-details-yesterday")
    }

    func test07_fractionalTimer() { open("Social media"); openLog(); shot("07-3-log-view-fractional-seconds") }

    // MARK: 08–12 Checks

    func test08_onceADay() {
        open("Take vitamins"); shot("08-1-day-details-not-done")
        tap("day-done"); shot("08-2-day-details-done")
        app.terminate()
        openAdd("Take vitamins", title: "Mark a day done"); shot("08-3-mark-a-day-done")
    }

    func test09_severalADay() {
        open("Stretch breaks"); tap("day-add-one", times: 2); shot("09-1-day-details")
        tap("day-all-logs")
        XCTAssertTrue(app.navigationBars["Checks today"].waitForExistence(timeout: 5))
        shot("09-2-all-logs")
        app.terminate()
        openAdd("Stretch breaks", yesterday: true, title: "Add a check"); shot("09-3-add-a-check")
    }

    func test10_weekGoal() {
        open("Call family"); shot("10-1-day-details")
        app.terminate()
        openAdd("Call family", title: "Add a check"); shot("10-2-add-a-check")
    }

    func test11_monthGoal() {
        open("Deep clean"); shot("11-1-day-details")
        app.terminate()
        openAdd("Deep clean", title: "Add a check"); shot("11-2-add-a-check")
    }

    func test12_daysAWeek() {
        open("Gym"); shot("12-1-day-details")
        app.terminate()
        openAdd("Gym", title: "Mark a day done"); shot("12-2-mark-a-day-done")
    }

    func test12b_olderMultiCheckLog() { open("Squats"); openLog(); shot("12b-log-view-older-multi-check") }

    // MARK: 13 Checklist, 14 Quit, 15 Task

    func test13_checklist() {
        open("Tidy desk"); shot("13-1-day-details")
        app.terminate()
        openAdd("Tidy desk", yesterday: true, title: "Tick steps"); shot("13-2-tick-steps")
    }

    func test14_quit() {
        open("Smoking"); shot("14-1-day-details-no-slips")
        recordSlip(); shot("14-2-day-details-one-slip")
        openLog(title: "Slip"); shot("14-4-slip-view")
        edit("Edit slip"); shot("14-5-edit-slip")
        app.terminate()
        openAdd("Smoking", title: "Add slip"); shot("14-3-add-slip")
    }

    func test15_task() {
        open("Test"); shot("15-1-day-details-not-done")
        tap("day-done"); shot("15-2-day-details-done")
    }

    // MARK: 16 Day states

    func test16_dayStates() {
        open("Water")
        writeNote("Had water before breakfast.")
        tap("day-skip")
        shot("16-1-skipped")
        app.terminate()
        open("Meditate"); shot("16-2-paused")
        app.terminate()
        open("Water", yesterday: true); shot("16-3-an-earlier-day-yesterday")
    }

    // MARK: 17 Notes, 18 Delete confirmations

    func test17_notes() {
        open("Read")
        tap("day-add-note")
        XCTAssertTrue(app.navigationBars["Add note"].waitForExistence(timeout: 5))
        sleep(1)
        shot("17-1-add-note")
        let field = app.textViews["note-field"]
        field.tap()
        field.typeText("Finished chapter six. The short morning session was easier than I expected.")
        tap("note-save")
        tap("day-edit-note")
        XCTAssertTrue(app.navigationBars["Note"].waitForExistence(timeout: 5))
        shot("17-2-note-view")
        tap("note-edit")
        XCTAssertTrue(app.navigationBars["Edit note"].waitForExistence(timeout: 5))
        shot("17-3-edit-note")
        tap("record-cancel")
        tap("note-delete")
        XCTAssertTrue(app.alerts.firstMatch.waitForExistence(timeout: 3))
        shot("18-3-delete-note")
    }

    func test18_deleteConfirmations() {
        open("Water")
        openLog()
        tap("record-delete")
        XCTAssertTrue(app.alerts.firstMatch.waitForExistence(timeout: 3))
        shot("18-1-delete-log")
        app.terminate()
        open("Smoking")
        recordSlip()
        openLog(title: "Slip")
        tap("record-delete")
        XCTAssertTrue(app.alerts.firstMatch.waitForExistence(timeout: 3))
        shot("18-2-delete-slip")
    }

    // MARK: Light mode and the management menu

    func test19_lightMode() {
        open("Water", light: true); shot("light-day-details")
        openLog(); shot("light-log-view")
    }

    func test20_managementMenu() {
        open("Coffee", light: true)
        tap("day-more")
        XCTAssertTrue(app.buttons["Delete Habit…"].waitForExistence(timeout: 3))
        shot("light-management-menu")
    }
}
