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
        if name.contains("testTasksPage") || name.contains("testTaskEdit") { app.launchArguments += ["-perf-tasks"] }
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

    func testTasksPage() {
        open("Menu", tapping: app.buttons["menu-button"], until: app.buttons["menu-tasks"])
        open("Tasks", tapping: app.buttons["menu-tasks"], until: app.navigationBars["Tasks"])
        ready(); keepGoing(scrollUpAndDown)
    }

    func testTaskEdit() {
        open("Menu", tapping: app.buttons["menu-button"], until: app.buttons["menu-tasks"])
        open("Tasks", tapping: app.buttons["menu-tasks"], until: app.navigationBars["Tasks"])
        let task = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Pay the phone bill'")).firstMatch
        open("Task", tapping: task, until: app.navigationBars["Pay the phone bill"])
        open("Edit Task", tapping: app.buttons["Edit"], until: app.navigationBars["Edit Task"])
        ready(); keepGoing(scrollUpAndDown)
    }

    func testBackupPage() {
        open("Menu", tapping: app.buttons["menu-button"], until: app.buttons["menu-backup"])
        open("Backup & Export", tapping: app.buttons["menu-backup"], until: app.navigationBars["Backup & Export"])
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
