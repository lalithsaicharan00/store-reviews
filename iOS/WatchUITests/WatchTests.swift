import XCTest

/// Shared launching and checks for the Watch UI tests. Every failure message is one line naming what was on screen (T14).
class WatchTestCase: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
    }

    func launch(_ fixture: String, _ extra: [String] = []) {
        app = XCUIApplication()
        app.launchArguments = ["-uitest", "-watch-fixture", fixture, "-clock-hour", "10"] + extra
        app.launch()
    }

    func labels() -> String {
        app.staticTexts.allElementsBoundByIndex.prefix(30).map(\.label).joined(separator: " | ")
    }

    func require(_ element: XCUIElement, _ what: String, timeout: TimeInterval = 15, file: StaticString = #filePath, line: UInt = #line) {
        if !element.waitForExistence(timeout: timeout) {
            XCTFail("\(what) not found. On screen: \(labels())", file: file, line: line)
        }
    }

    /// The element is fully on the screen, not cut by its edges (the round corners are inside the safe area), named with
    /// its frame on one line (T15).
    func requireOnScreen(_ element: XCUIElement, _ what: String, file: StaticString = #filePath, line: UInt = #line) {
        let screen = app.windows.firstMatch.frame
        let frame = element.frame
        XCTAssertTrue(screen.contains(frame), "\(what) at \(frame) leaves the screen \(screen)", file: file, line: line)
    }

    /// Scrolls to the element (short drags, `WatchScroll`), failing with what was on screen if it never shows.
    func reveal(_ element: XCUIElement, _ what: String, file: StaticString = #filePath, line: UInt = #line) {
        if !app.reveal(element) { XCTFail("\(what) not found. On screen: \(labels())", file: file, line: line) }
    }

    func openRow(_ name: String) {
        reveal(app.staticTexts[name].firstMatch, "\(name)'s row")
        app.staticTexts[name].firstMatch.tap()
        require(app.buttons["more"], "Day details for \(name)")
    }
}

/// Today (A): opens at once from the Watch's own database, in Today's order, with the iPhone's words; a tap logs and
/// offers a named Undo; nothing moves until the pause, then done rows sink.
final class WatchTodayTests: WatchTestCase {
    func testOpensWithTheIPhonesSectionsAndWords() {
        launch("design")
        // The iPhone's default order: Quitting, Anytime, Morning, Afternoon, Evening (store.todayCards).
        require(app.staticTexts["1 of 7 done"], "the day bar's count (habits, not ticks)")
        require(app.staticTexts["Quit or Cut Down"], "Quit or Cut Down, first and named as on the iPhone")
        reveal(app.staticTexts["Water"].firstMatch, "Water, in Anytime")
        reveal(app.buttons["start-morning"], "Morning's ▶")
        requireOnScreen(app.buttons["start-morning"], "Morning's ▶")
        reveal(app.staticTexts["Vitamins"].firstMatch, "Vitamins")
        XCTAssertTrue(app.staticTexts["Every day"].exists, "a single tick's line says how often. On screen: \(labels())")
        reveal(app.staticTexts["12/20 min"].firstMatch, "Meditate's line")
        requireOnScreen(app.staticTexts["Vitamins"].firstMatch, "Vitamins")
    }

    func testAPlusOneLogsAtOnceAndUndoNamesIt() {
        launch("design")
        let add = app.buttons["button-Add 1 glass to Water"]
        reveal(add, "Water's +1")
        add.tap()
        require(app.staticTexts["4/8 glasses"], "Water at 4/8 after one tap")
        let undo = app.buttons["undo"]
        require(undo, "the after-tap Undo")
        XCTAssertEqual(undo.label, "Undo +1 glass")
        undo.tap()
        require(app.staticTexts["3/8 glasses"], "Water back at 3/8 after Undo")
    }

    func testACheckTogglesAndDoneRowsSinkAfterThePause() {
        launch("design")
        let vitamins = app.buttons["button-Mark Vitamins done"]
        reveal(vitamins, "Vitamins' ✓")
        let before = app.staticTexts["Vitamins"].frame.minY
        vitamins.tap()
        require(app.buttons["button-Undo Vitamins"], "Vitamins ticked")
        // Nothing moves under the finger (U4)…
        XCTAssertEqual(app.staticTexts["Vitamins"].frame.minY, before, accuracy: 2, "Vitamins moved during the hold")
        // …then, after the pause, it sinks below the rest of Morning (U13).
        Thread.sleep(forTimeInterval: 2.5)
        XCTAssertGreaterThan(app.staticTexts["Vitamins"].frame.minY, before + 10, "Vitamins didn't sink. On screen: \(labels())")
    }

    func testFirstLaunchNeverSaysNoHabits() {
        launch("first-launch")
        require(app.staticTexts["Getting your habits from your iPhone…"], "the first-launch wait (WA2)")
        XCTAssertFalse(app.staticTexts["No habits yet"].exists)
    }

    func testEmptyAndNothingPlanned() {
        launch("empty")
        require(app.staticTexts["No habits yet"], "No habits yet (after hearing back)")
        launch("nothing-planned")
        require(app.staticTexts["Nothing planned for today"], "Nothing planned")
    }

    func testLimitsTasksSkippedAndPaused() {
        launch("limits")
        require(app.staticTexts["1/2 cups max"], "a limit's line")
        launch("tasks")
        // The time is the system's ("2:00 PM" with a narrow space before PM), so match its start.
        require(app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH %@", "Task · 2:00")).firstMatch, "a task's line")
        launch("skipped-paused")
        require(app.staticTexts["Skipped today"], "a skipped habit stays, neutral")
        reveal(app.buttons["paused"], "the folded Paused row")
    }

    func testAFailedSaveSaysSoAndShowsWhatsSaved() {
        launch("design", ["-fail-entry-writes"])
        reveal(app.buttons["button-Add 1 glass to Water"], "Water's +1")
        app.buttons["button-Add 1 glass to Water"].tap()
        require(app.staticTexts["3/8 glasses"], "Water back at what's saved", timeout: 10)
        reveal(app.buttons["save-problem"], "Couldn't save that log")
    }
}

/// Day details (B, H2–H4, H7–H10): every kind, today only.
final class WatchDayDetailsTests: WatchTestCase {
    func testAmountDialMainActionAndLogs() {
        launch("design")
        openRow("Water")
        require(app.staticTexts["3"], "Water's dial")
        let main = app.buttons["main-action"]
        require(main, "+1 glass")
        main.tap()
        require(app.staticTexts["4"], "the dial at 4")
        reveal(app.staticTexts["Today's logs"], "today's logs")
        reveal(app.buttons["skip-today"], "Skip today, last")
    }

    func testCheckMarkDoneThenUndo() {
        launch("design")
        openRow("Vitamins")
        require(app.staticTexts["Not yet"], "Not yet")
        app.buttons["main-action"].tap()
        require(app.staticTexts["Done"], "Done")
        XCTAssertEqual(app.buttons["main-action"].label, "Undo done")
    }

    func testChecklistStepsTick() {
        launch("design")
        openRow("Wind down")
        require(app.staticTexts["2 of 5 steps"], "2 of 5 steps")
        app.buttons["step-Read 10 pages"].tap()
        require(app.staticTexts["3 of 5 steps"], "3 of 5 after a tap")
    }

    func testTimerStartsAndPauses() {
        launch("design")
        openRow("Meditate")
        require(app.staticTexts["12 min"], "12 min saved")
        app.buttons["main-action"].tap()
        require(app.buttons["Pause timer"], "Pause while running")
        Thread.sleep(forTimeInterval: 2)
        app.buttons["main-action"].tap()
        require(app.buttons["Start timer"], "Start again after Pause")
    }

    func testQuitSlipAsksFirst() {
        launch("design")
        openRow("No smoking")
        app.buttons["main-action"].tap()
        require(app.staticTexts["Record a slip?"], "the slip asks first (H7)")
        app.buttons["Record a slip"].firstMatch.tap()
        require(app.staticTexts["0 h 0 min"], "the run starts again from the slip (H8)")
    }

    func testSkipAndUndoSkip() {
        launch("design")
        openRow("Water")
        app.buttons["more"].tap()
        require(app.buttons["more-skip"], "Skip today in More")
        app.buttons["more-skip"].tap()
        require(app.staticTexts["Skipped"], "Skipped")
        app.buttons["undo-skip"].tap()
        require(app.staticTexts["3"], "back to 3 after Undo skip")
    }

    func testDeleteALogAsksFirstAndGoesBackFirst() {
        launch("design")
        openRow("Water")
        reveal(app.buttons["log-row"].firstMatch, "a log")
        app.buttons["log-row"].firstMatch.tap()
        require(app.buttons["delete"], "the log's Delete")
        app.buttons["delete"].tap()
        require(app.staticTexts["Delete this log?"], "Delete asks first")
        app.buttons["Delete"].firstMatch.tap()
        require(app.staticTexts["2"], "Water at 2 after deleting a log, back on Day details (U27)")
    }

    func testLimitAndWeekGoal() {
        launch("limits")
        openRow("Coffee")
        require(app.staticTexts["Daily limit"], "Daily limit")
        app.buttons["main-action"].tap()
        require(app.staticTexts["Limit reached"], "Limit reached")
        launch("week")
        openRow("Call family")
        require(app.staticTexts["1/3"], "1 of 3 this week")
        XCTAssertEqual(app.buttons["main-action"].label, "Add a check")
    }
}

/// Log manually (B3, B15–B17): the Crown's number with − and +, and time wheels.
final class WatchLogManuallyTests: WatchTestCase {
    func testAmountWithPlusAndMinus() {
        launch("design")
        openRow("Water")
        app.buttons["log-manually"].tap()
        require(app.buttons["add"], "Add")
        app.buttons["plus"].tap(); app.buttons["plus"].tap()
        XCTAssertEqual(app.buttons["add"].label, "Add 3 glasses")
        app.buttons["minus"].tap()
        app.buttons["add"].tap()
        require(app.staticTexts["5"], "Water at 5 after adding 2")
    }

    func testAnAmountThatAsksStartsAtTheLastValue() {
        launch("kinds")
        openRow("Weight")
        app.buttons["main-action"].tap()
        require(app.buttons["add"], "Add")
        XCTAssertEqual(app.buttons["add"].label, "Add 72.6 kg")
        app.buttons["minus"].tap()
        XCTAssertEqual(app.buttons["add"].label, "Add 72.5 kg", "decimals step by one place")
    }

    func testTimeWheels() {
        launch("design")
        openRow("Meditate")
        app.buttons["log-manually"].tap()
        require(app.buttons["add"], "Add")
        XCTAssertEqual(app.buttons["add"].label, "Add 25 min")
        app.buttons["add"].tap()
        require(app.staticTexts["37 min"], "Meditate at 37 min")
    }
}

/// The routine player (C, R1–R9).
final class WatchRoutineTests: WatchTestCase {
    func testPagesNeverLogAndTheFinishSummarises() {
        launch("design")
        reveal(app.buttons["start-morning"], "Morning's ▶")
        app.buttons["start-morning"].tap()
        require(app.buttons["routine-main"], "the routine")
        XCTAssertEqual(app.buttons["routine-main"].label, "Mark done")
        app.swipeUp() // move to Meditate: nothing logged
        require(app.otherElements["routine-page-Meditate"], "page 2")
        app.swipeDown()
        app.buttons["routine-main"].tap() // Vitamins done
        require(app.buttons["routine-main"], "Next")
        XCTAssertEqual(app.buttons["routine-main"].label, "Next")
        app.buttons["routine-close"].tap()
        reveal(app.buttons["button-Undo Vitamins"], "Vitamins ticked on Today after the routine")
    }

    func testClosingKeepsTheTimerRunning() {
        launch("design")
        reveal(app.buttons["start-morning"], "Morning's ▶")
        app.buttons["start-morning"].tap()
        require(app.buttons["routine-main"], "the routine")
        app.swipeUp()
        app.buttons["routine-main"].tap() // start Meditate
        app.buttons["routine-close"].tap()
        reveal(app.buttons["button-Stop Meditate timer"], "the timer still running on Today (C6)")
    }

    func testTheListJumpsWithoutLogging() {
        launch("design")
        reveal(app.buttons["start-morning"], "Morning's ▶")
        app.buttons["start-morning"].tap()
        app.buttons["routine-list"].tap()
        require(app.buttons["Stretch"].firstMatch, "Stretch in the list")
        app.buttons["Stretch"].firstMatch.tap()
        require(app.otherElements["routine-page-Stretch"], "Stretch's page")
    }
}

/// Plus (G): without it the Watch shows the offer; each state's words.
final class WatchPlusTests: WatchTestCase {
    func testWithoutPlusTheOfferShowsAndRestoreIsThere() {
        launch("design", ["-free", "-plus-moment", "offer"])
        require(app.staticTexts["Apple Watch is part of Plus"], "G1")
        require(app.buttons["get-plus"], "Get Plus")
        reveal(app.buttons["restore"], "Restore Purchases, always on the page")
    }

    func testEveryMoment() {
        for (moment, words) in [("bought", "Plus is yours"), ("waiting", "Waiting for approval"),
                                ("unreachable", "Couldn't reach the App Store"), ("ended", "Plus has ended on this Apple Account")] {
            launch("design", ["-free", "-plus-moment", moment])
            require(app.staticTexts[words], moment)
        }
    }

    func testWithPlusTodayOpens() {
        launch("design")
        reveal(app.staticTexts["Vitamins"].firstMatch, "Today with Plus")
    }
}
