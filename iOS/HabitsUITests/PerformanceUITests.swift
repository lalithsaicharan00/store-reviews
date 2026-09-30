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

    func testScrollAllHabits() {
        open("All Habits", tapping: app.buttons["All habits"], until: app.navigationBars["All Habits"])
        ready()
        keepGoing(scrollUpAndDown)
    }

    func testScrollHabitPage() {
        open("All Habits", tapping: app.buttons["All habits"], until: app.navigationBars["All Habits"])
        let teeth = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Brush teeth'")).firstMatch
        XCTAssertTrue(teeth.waitForExistence(timeout: 10))
        // A year of daily history: its numbers and best streak are the heaviest page.
        open("Habit page", tapping: teeth, until: app.staticTexts["Brush teeth"]) // the page heading; All Habits rows read "Brush teeth, 2 min a day"
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
