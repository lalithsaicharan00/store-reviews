import XCTest

/// Opens every screen and state in the Watch designs (A–H) and saves a screenshot of each, named
/// "<46mm|42mm>-<picture>-<state>" (Apple Watch build prompt §6). CI runs it on a 46 mm and a 42 mm Watch and exports
/// the PNGs to ci-results/watch/shots for review. The main screens are taken again at an accessibility text size (H20).
/// A screenshot is taken whatever happens; a state that can't be reached fails the test with what was on screen (T14).
final class WatchScreenshotTests: XCTestCase {
    private var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = true
    }

    // MARK: Helpers

    private func launch(_ fixture: String, _ extra: [String] = []) {
        app = XCUIApplication()
        app.launchArguments = ["-uitest", "-watch-fixture", fixture, "-clock-hour", "10"] + extra
        app.launch()
    }

    private var size: String {
        app.windows.firstMatch.frame.width < 200 ? "42mm" : "46mm"
    }

    private func shot(_ name: String) {
        // Let springs and fades settle; the screenshot is what a person would see.
        Thread.sleep(forTimeInterval: 0.8)
        let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        attachment.name = "\(size)-\(name)"
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    @discardableResult
    private func wait(_ element: XCUIElement, _ what: String, timeout: TimeInterval = 15) -> Bool {
        if element.waitForExistence(timeout: timeout) { return true }
        XCTFail("\(what) not on screen. Showing: \(labels())")
        return false
    }

    /// What's on screen, on one line (T14).
    private func labels() -> String {
        app.staticTexts.allElementsBoundByIndex.prefix(25).map(\.label).joined(separator: " | ")
    }

    private func openRow(_ name: String) {
        let row = app.otherElements["row-\(name)"].firstMatch
        if !row.exists { app.swipeUp() }
        if wait(app.staticTexts[name].firstMatch, "\(name)'s row") { app.staticTexts[name].firstMatch.tap() }
        wait(app.otherElements["dial"].firstMatch.exists ? app.otherElements["dial"].firstMatch : app.buttons["more"].firstMatch, "Day details")
    }

    private func scrollDown(_ times: Int = 1) {
        for _ in 0..<times { app.swipeUp() }
    }

    // MARK: A · Today

    func testATodayStates() {
        launch("design")
        wait(app.staticTexts["Vitamins"], "Today")
        shot("A1-today")
        scrollDown(2)
        shot("A2-whole-list")
        scrollDown(2)
        shot("A2-whole-list-end")

        launch("design")
        wait(app.staticTexts["Water"], "Water")
        app.swipeUp()
        let add = app.buttons["button-Add 1 glass to Water"]
        if wait(add, "Water's +1") { add.tap() }
        wait(app.buttons["undo"], "Undo +1 glass")
        shot("A3-after-a-tap")

        launch("all-done")
        wait(app.staticTexts["Vitamins"], "Today")
        Thread.sleep(forTimeInterval: 2)
        shot("A4-all-done")

        launch("nothing-planned")
        wait(app.staticTexts["Nothing planned for today"], "Nothing planned")
        shot("A5-nothing-planned")

        launch("first-launch")
        wait(app.staticTexts["Getting your habits from your iPhone…"], "First launch")
        shot("A6-first-launch")

        launch("empty")
        wait(app.staticTexts["No habits yet"], "No habits yet")
        shot("A7-no-habits")
    }

    // MARK: B · Day details

    func testBDayDetails() {
        launch("design")
        openRow("Water")
        shot("B1-amount")
        scrollDown()
        shot("B2-todays-logs")
        app.swipeDown(); app.swipeDown()
        if wait(app.buttons["log-manually"], "Log manually") { app.buttons["log-manually"].tap() }
        wait(app.otherElements["amount"].firstMatch.exists ? app.otherElements["amount"].firstMatch : app.staticTexts["glasses"], "Log manually")
        shot("B3-log-manually-amount")
        app.staticTexts["1"].firstMatch.tap()
        Thread.sleep(forTimeInterval: 1)
        shot("B18-say-or-type")

        launch("design")
        openRow("Vitamins")
        shot("B4-check")
        if wait(app.buttons["main-action"], "Mark done") { app.buttons["main-action"].tap() }
        shot("B5-check-done")

        launch("design")
        openRow("Meditate")
        shot("B6-time")
        if wait(app.buttons["log-manually"], "Log manually") { app.buttons["log-manually"].tap() }
        shot("B15-log-manually-time")

        launch("running")
        openRow("Meditate")
        shot("B7-running")
        launch("running", ["-wrist-down"])
        openRow("Meditate")
        shot("B8-wrist-down")

        launch("design")
        openRow("Wind down")
        shot("B9-checklist")

        launch("design")
        openRow("No smoking")
        shot("B10-quit")
        if wait(app.buttons["main-action"], "Record a slip") { app.buttons["main-action"].tap() }
        shot("H7-record-a-slip")
        let record = app.buttons["Record a slip"].firstMatch
        if record.exists { record.tap() }
        shot("H8-after-a-slip")

        launch("design")
        openRow("Water")
        scrollDown()
        let log = app.buttons["log-row"].firstMatch
        if wait(log, "a log") { log.tap() }
        shot("B11-one-log")
        if wait(app.buttons["delete"], "Delete") { app.buttons["delete"].tap() }
        shot("B12-delete-asks-first")

        launch("design")
        openRow("Water")
        if wait(app.buttons["more"], "More") { app.buttons["more"].tap() }
        shot("B13-more")
        let skip = app.buttons["more-skip"]
        if wait(skip, "Skip today") { skip.tap() }
        shot("B14-skipped")

        launch("kinds")
        openRow("Read pages")
        shot("B16-asks-how-much")
        launch("kinds")
        openRow("Weight")
        if wait(app.buttons["main-action"], "Log amount") { app.buttons["main-action"].tap() }
        shot("B17-decimals-from-last")

        launch("logs")
        openRow("Water")
        scrollDown(2)
        shot("B2-four-logs")
    }

    // MARK: C · Routine

    func testCRoutine() {
        launch("design")
        let start = app.buttons["start-morning"]
        if wait(start, "Morning's ▶") { start.tap() }
        wait(app.otherElements["routine"].firstMatch.exists ? app.otherElements["routine"].firstMatch : app.buttons["routine-main"], "the routine")
        shot("C1-morning-1")
        app.swipeUp()
        shot("C2-morning-2")
        if wait(app.buttons["routine-main"], "Start") { app.buttons["routine-main"].tap() }
        shot("C2-morning-2-running")
        if app.buttons["routine-list"].exists { app.buttons["routine-list"].tap() }
        shot("C4-routine-list")
        if app.buttons["Stretch"].firstMatch.exists { app.buttons["Stretch"].firstMatch.tap() }
        if wait(app.buttons["routine-main"], "Mark done") { app.buttons["routine-main"].tap() }
        shot("C3-morning-3-done")
        if app.buttons["routine-main"].exists { app.buttons["routine-main"].tap() }
        shot("C5-morning-done")
        if app.buttons["routine-done"].exists { app.buttons["routine-done"].tap() }
        shot("C6-closed-timer-running")
    }

    // MARK: G · Plus

    func testGPlus() {
        for (moment, name) in [("offer", "G1-without-plus"), ("bought", "G3-plus-is-yours"), ("waiting", "G4-waiting-for-approval"),
                               ("unreachable", "G5-couldnt-reach-app-store"), ("ended", "G6-plus-ended")] {
            launch("design", ["-free", "-plus-moment", moment])
            wait(app.otherElements["plus-screen"].firstMatch.exists ? app.otherElements["plus-screen"].firstMatch : app.staticTexts.firstMatch, "the Plus screen")
            shot(name)
            if moment == "offer" { scrollDown(2); shot("G1-scrolled") }
        }
    }

    // MARK: H · Added after the cross-check

    func testHStates() {
        launch("limits")
        wait(app.staticTexts["Coffee"], "Coffee")
        shot("H1-limits")
        openRow("Coffee")
        shot("H2-limit-page")
        if wait(app.buttons["main-action"], "+1 cup") { app.buttons["main-action"].tap(); app.buttons["main-action"].tap() }
        shot("H3-over-the-limit")

        launch("week")
        openRow("Call family")
        shot("H4-three-times-a-week")

        launch("tasks")
        wait(app.staticTexts["Pay rent"], "Pay rent")
        shot("H5-tasks")

        launch("skipped-paused")
        wait(app.staticTexts["Stretch"], "Stretch")
        scrollDown(4)
        shot("H6-skipped-and-paused")

        launch("milestone")
        wait(app.staticTexts["Read"], "Read")
        scrollDown(3)
        let read = app.buttons["button-Mark Read done"]
        if wait(read, "Read's ✓") { read.tap() }
        shot("H9-milestone")
        openRow("Read")
        scrollDown()
        shot("H10-streak")

        launch("design", ["-fail-entry-writes"])
        wait(app.staticTexts["Water"], "Water")
        app.swipeUp()
        let add = app.buttons["button-Add 1 glass to Water"]
        if wait(add, "Water's +1") { add.tap() }
        _ = app.buttons["save-problem"].waitForExistence(timeout: 5)
        app.swipeDown(); app.swipeDown(); app.swipeDown()
        shot("H18-couldnt-save")
    }

    // MARK: H20 · Larger text

    func testHLargerText() {
        launch("design", ["-text-size", "accessibility2"])
        wait(app.staticTexts["Vitamins"], "Today")
        shot("H20-larger-text-today")
        openRow("Water")
        shot("H20-larger-text-day-details")
        launch("design", ["-text-size", "accessibility2"])
        let start = app.buttons["start-morning"]
        if wait(start, "Morning's ▶") { start.tap() }
        shot("H20-larger-text-routine")
    }

    // MARK: E · The watch face (drawn in the app's gallery from the same snapshot and views)

    func testEFaceGallery() {
        launch("design", ["-face-gallery"])
        wait(app.otherElements["face-gallery"].firstMatch.exists ? app.otherElements["face-gallery"].firstMatch : app.staticTexts.firstMatch, "the gallery")
        shot("E1-complications")
        scrollDown(); shot("E2-log-from-the-face")
        scrollDown(); shot("E3-E4-timer-and-smart-stack")
        launch("running", ["-face-gallery"])
        Thread.sleep(forTimeInterval: 1)
        shot("E3-while-a-timer-runs")
        launch("design", ["-face-gallery", "-hide-names"])
        Thread.sleep(forTimeInterval: 1)
        shot("E5-names-hidden")
        launch("design", ["-face-gallery", "-free"])
        Thread.sleep(forTimeInterval: 1)
        shot("G7-face-without-plus")
    }
}
