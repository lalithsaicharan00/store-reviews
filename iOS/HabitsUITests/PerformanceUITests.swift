import XCTest

/// Speed tests (30 Sep 2026): each one opens a screen with a year of history and keeps using it for a while, so
/// `Tools/perf/measure_perf.sh` can sample the app meanwhile (main thread busy %, and which of the app's functions
/// take the time). (Apple's scroll hitch ratio needs a real iPhone: the simulator
/// reports only how long a swipe took, so it isn't measured here.) Run on GitHub Actions with
/// "[ios-perf]" in a commit message; they check speed, not behaviour, so the normal test runs skip them.
///
/// Each test prints PERF-READY once its screen is open, and the script starts sampling then.
final class PerformanceUITests: XCTestCase {
    /// How long each test keeps using its screen. The script samples for less than this.
    static let busyFor: TimeInterval = 30

    private var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-uitest", "-perf-history"]
        app.launch()
        XCTAssertTrue(app.collectionViews.firstMatch.waitForExistence(timeout: 15))
    }

    private func ready() { print("PERF-READY \(name)") }

    /// Taps, then waits for `shown`; prints how long the screen took to open (the summary lists these).
    private func open(_ screen: String, tapping button: XCUIElement, until shown: XCUIElement) {
        let start = Date.now
        button.tap()
        guard shown.waitForExistence(timeout: 30) else {
            // What was on screen instead, so the log says whether the screen is slow, broken or just named differently.
            print("PERF-OPEN \(screen): didn't open in 30 s")
            print(app.debugDescription)
            XCTFail("\(screen) didn't open")
            return
        }
        print("PERF-OPEN \(screen): \(String(format: "%.1f", Date.now.timeIntervalSince(start))) s")
    }

    private func keepGoing(_ step: () -> Void) {
        let end = Date.now.addingTimeInterval(Self.busyFor)
        while Date.now < end { step() }
        print("PERF-DONE \(name)")
    }

    /// A slow drag the length of the screen, as a finger reading down the list.
    private func drag(up: Bool) {
        let window = app.windows.firstMatch
        let from = window.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: up ? 0.75 : 0.3))
        let to = window.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: up ? 0.3 : 0.75))
        from.press(forDuration: 0.01, thenDragTo: to, withVelocity: .slow, thenHoldForDuration: 0)
    }

    private func scrollUpAndDown() {
        for up in [true, true, true, false, false, false] { drag(up: up) }
    }

    func testScrollToday() {
        ready()
        keepGoing(scrollUpAndDown)
    }

    func testTapToday() {
        ready()
        let checks = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Mark ' OR label BEGINSWITH 'Undo '"))
        let folds = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Fold ' OR label BEGINSWITH 'Open '"))
        keepGoing {
            let check = checks.firstMatch
            if check.exists && check.isHittable { check.tap() }
            let fold = folds.element(boundBy: 1)
            if fold.exists && fold.isHittable { fold.tap() }
        }
    }

    /// Folding and opening Today's parts (#59): each part reads only its own fold, so this should redraw one part, not
    /// every row.
    func testFoldToday() {
        ready()
        let folds = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Fold ' OR label BEGINSWITH 'Open '"))
        keepGoing {
            for i in 0..<min(3, folds.count) {
                let fold = folds.element(boundBy: i)
                if fold.exists && fold.isHittable { fold.tap() }
            }
        }
    }

    /// A run of ticks, then a pause (#58): the button pop, the fill sweep, and done rows settling once per pause.
    func testTickRun() {
        ready()
        let checks = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Mark ' OR label BEGINSWITH 'Undo ' OR label BEGINSWITH 'Add '"))
        keepGoing {
            for i in 0..<3 {
                let check = checks.element(boundBy: i)
                if check.exists && check.isHittable { check.tap() }
            }
            Thread.sleep(forTimeInterval: 2) // the pause, then the settle
        }
    }

    /// ≡ → Habits (All Habits moved into the menu, 30 Sep 2026).
    private func openHabits() {
        open("Menu", tapping: app.buttons["menu-button"], until: app.buttons["menu-habits"])
        open("Habits", tapping: app.buttons["menu-habits"], until: app.navigationBars["Habits"])
    }

    func testScrollAllHabits() {
        openHabits()
        ready()
        keepGoing(scrollUpAndDown)
    }

    /// The ≡ menu opening and closing over a year of history: Today must not redraw under it.
    func testMenuOpenClose() {
        let menu = app.buttons["menu-button"]
        let today = app.buttons["menu-today"]
        open("Menu", tapping: menu, until: today)
        today.tap()
        _ = today.waitForNonExistence(timeout: 3)
        ready()
        keepGoing {
            menu.tap()
            _ = today.waitForExistence(timeout: 3)
            today.tap()
            _ = today.waitForNonExistence(timeout: 3)
        }
    }

    func testScrollHabitPage() {
        openHabits()
        let teeth = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Brush teeth'")).firstMatch
        XCTAssertTrue(teeth.waitForExistence(timeout: 10))
        // A year of daily history: its numbers and best streak are the heaviest page.
        // The page's own title bar: the Habits row shows "Brush teeth" too, so text alone passed without the page
        // opening (a tap selected the row until 30 Sep).
        open("Habit page", tapping: teeth, until: app.navigationBars["Brush teeth"])
        ready()
        keepGoing(scrollUpAndDown)
    }

    /// Progress with 30 habits and two years of history (report §20): open it, switch Week, Month and Year, go back and
    /// forth, and scroll. Targets: opens in under 300 ms, a switch in under 150 ms.
    func testProgress() {
        // With four groups (Build Plan #68): the chips are switched too, and All shows the Groups card.
        relaunch(["-perf-many", "-groups-demo"])
        openProgress()
        ready()
        let control = app.segmentedControls["progress-range"]
        let previous = app.buttons["progress-previous"], next = app.buttons["progress-next"]
        keepGoing {
            for chip in ["group-chip-Health", "group-chip-Mind", "group-chip-all"] { app.buttons[chip].tap() }
            control.buttons["Month"].tap()
            previous.tap(); next.tap()
            control.buttons["Year"].tap()
            previous.tap(); next.tap()
            control.buttons["Week"].tap()
            previous.tap(); next.tap()
            scrollUpAndDown()
        }
    }

    /// A habit's page from Progress, at Over Time, switching Week, Month, Year and All with two years of history.
    func testProgressHabitPage() {
        relaunch(["-perf-many"])
        openProgress()
        // The first row, so it's on screen without scrolling; a year or two of daily history.
        let row = app.buttons["progress-row-Read"]
        XCTAssertTrue(row.waitForExistence(timeout: 10))
        open("Habit page from Progress", tapping: row, until: app.navigationBars["Read"])
        let control = app.segmentedControls["over-time-range"]
        XCTAssertTrue(control.waitForExistence(timeout: 10))
        ready()
        keepGoing {
            for title in ["Week", "Month", "Year", "All"] { control.buttons[title].tap() }
            scrollUpAndDown()
        }
    }

    private func relaunch(_ extra: [String]) {
        app.terminate()
        app.launchArguments = ["-uitest", "-perf-history"] + extra
        app.launch()
        XCTAssertTrue(app.collectionViews.firstMatch.waitForExistence(timeout: 30))
    }

    /// ≡ → Progress.
    private func openProgress() {
        open("Menu", tapping: app.buttons["menu-button"], until: app.buttons["menu-progress"])
        open("Progress", tapping: app.buttons["menu-progress"], until: app.staticTexts["progress-period"])
    }

    func testCalendarMonths() {
        let previous = app.buttons["Previous month"]
        let next = app.buttons["Next month"]
        open("Calendar", tapping: app.buttons.matching(NSPredicate(format: "label ENDSWITH 'Open calendar'")).firstMatch, until: previous)
        ready()
        keepGoing {
            for _ in 0..<3 { previous.tap() }
            for _ in 0..<3 { next.tap() }
        }
    }
}
