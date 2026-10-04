import XCTest

/// The 31 Day-details and Entry-editor wireframes (handoff "Day Details and Entry Editor", 4 Oct 2026), each shown as
/// built: the same habit, the same state, the same appearance. Each screenshot is named after its wireframe's image
/// (`day-06-amount-goal`, `entry-07-delete-confirmation`) so the two can be laid side by side for the user's review
/// (Rulebook U9). The habits come from `DayDetailsFixture`; `-open-day` opens a habit's Day details at launch.
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
    private var links: XCUIElementQuery {
        app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'entry-' AND NOT identifier IN {'entry-delete','entry-save','entry-back'}"))
    }

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

    private func tap(_ id: String, times: Int = 1) {
        let button = app.buttons[id]
        XCTAssertTrue(button.waitForExistence(timeout: 5), id)
        for _ in 0..<times { button.tap(); usleep(500_000) }
    }

    private func writeNote(_ text: String) {
        tap("day-add-note")
        let field = app.textFields["note-field"]
        XCTAssertTrue(field.waitForExistence(timeout: 5))
        field.typeText(text)
        app.navigationBars["Note"].buttons["Save"].tap()
        XCTAssertTrue(app.buttons["day-edit-note"].waitForExistence(timeout: 5))
    }

    private func recordSlip() {
        tap("day-add-entry")
        XCTAssertTrue(app.navigationBars["Add Entry"].waitForExistence(timeout: 5))
        app.navigationBars["Add Entry"].buttons["add-entry-save"].tap()
        XCTAssertTrue(links.firstMatch.waitForExistence(timeout: 5), "The slip shows")
    }

    private func openLog(containing text: String? = nil) {
        let link = text.map { t in links.matching(NSPredicate(format: "label CONTAINS %@", t)).firstMatch } ?? links.firstMatch
        XCTAssertTrue(link.waitForExistence(timeout: 5))
        link.tap()
        XCTAssertTrue(app.buttons["entry-delete"].waitForExistence(timeout: 5), "The log editor opens")
    }

    // MARK: Day details: checks and checklist

    func test01_dailyCheckUndone() { open("Take vitamins"); shot("day-01-daily-check-undone") }
    func test02_dailyCheckDone() { open("Take vitamins"); tap("day-done"); shot("day-02-daily-check-done") }
    func test03_weeklyCheck() { open("Call family"); shot("day-03-weekly-check") }
    func test04_repeatedChecks() { open("Stretch breaks"); shot("day-04-repeated-checks") }
    func test05_checklist() { open("Tidy desk"); shot("day-05-checklist") }
    func test06_monthlyCheck() { open("Deep clean"); shot("day-13-monthly-check") }

    // MARK: Day details: amounts, time and quit

    func test07_amountGoal() { open("Water"); shot("day-06-amount-goal") }
    func test08_amountLimit() { open("Coffee"); shot("day-07-amount-limit") }
    func test09_timeGoal() { open("Read"); shot("day-08-time-goal") }
    func test10_quitNoSlip() { open("Smoking"); shot("day-09-quit-no-slip") }
    func test11_quitWithSlip() { open("Smoking"); recordSlip(); shot("day-17-quit-with-slip") }
    func test12_limitExceeded() { open("Coffee"); tap("day-add-step", times: 3); shot("day-18-limit-exceeded") }
    func test13_timerRunning() { open("Read"); tap("day-start-timer"); sleep(3); shot("day-19-timer-running") }

    // MARK: Day details: tasks, dates and management

    func test14_oneTimeTask() { open("Test"); shot("day-10-one-time-task") }
    func test15_pastDay() { open("Water", yesterday: true); shot("day-11-past-day") }
    func test16_managementMenuLight() {
        open("Coffee", light: true)
        tap("day-add-step")
        tap("day-more")
        XCTAssertTrue(app.buttons["Delete Habit…"].waitForExistence(timeout: 3))
        shot("day-12-management-menu-light")
    }
    func test17_taskWithNote() { open("Test"); writeNote("Bring the receipt from the drawer."); shot("day-16-task-with-note") }
    func test18_taskDone() { open("Test"); tap("day-done"); shot("day-20-task-done") }

    // MARK: Day details: skipped and paused

    func test19_skippedDay() { open("Take vitamins"); tap("day-skip"); shot("day-14-skipped-day") }
    func test20_pausedDay() { open("Meditate"); shot("day-15-paused-day") }
    func test21_skippedAmountKeepsLogsAndNote() {
        open("Water")
        writeNote("Had water before breakfast.")
        tap("day-skip")
        shot("day-21-skipped-amount-logs-kept")
    }

    // MARK: Entry editor

    func test22_waterAmount() { open("Water"); openLog(); shot("entry-01-water-amount") }
    func test23_coffeeLimitAmount() { open("Coffee"); tap("day-add-step"); openLog(); shot("entry-02-coffee-limit-amount") }
    func test24_readDuration() { open("Read"); openLog(containing: "Manual log"); shot("entry-03-read-duration") }
    func test25_fractionalTimer() { open("Social media"); openLog(); shot("entry-04-fractional-timer") }
    func test26_multiCheckLog() { open("Squats"); openLog(); shot("entry-05-multi-check-log") }
    func test27_quitSlipDateTime() { open("Smoking"); recordSlip(); openLog(); shot("entry-06-quit-slip-date-time") }
    func test28_deleteConfirmation() {
        open("Water")
        openLog()
        app.buttons["entry-delete"].tap()
        XCTAssertTrue(app.alerts.firstMatch.waitForExistence(timeout: 3))
        shot("entry-07-delete-confirmation")
    }
    func test29_waterLightMode() { open("Water", light: true); openLog(); shot("entry-08-water-light-mode") }
    func test30_minutesFocused() {
        open("Read")
        openLog(containing: "Manual log")
        app.textFields["entry-minutes"].tap()
        XCTAssertTrue(app.keyboards.firstMatch.waitForExistence(timeout: 3))
        shot("entry-09-duration-minutes-focused")
    }
    /// The slip's time, being changed: its date stays as recorded until a slip can move days in storage (D7).
    func test31_slipTimeDraft() {
        open("Smoking")
        recordSlip()
        openLog()
        let time = app.descendants(matching: .any)["entry-slip-time"].firstMatch
        XCTAssertTrue(time.waitForExistence(timeout: 3))
        if time.buttons.firstMatch.exists { time.buttons.firstMatch.tap() } else { time.tap() }
        shot("entry-10-slip-date-time-draft")
    }
}
