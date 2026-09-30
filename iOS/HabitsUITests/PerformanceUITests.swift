import XCTest

/// Speed tests (30 Sep 2026): each one opens a screen with a year of history and keeps using it for a while, so
/// `Tools/perf/measure_perf.sh` can sample the app meanwhile (main thread busy %, and which of the app's functions
/// take the time). `testScrollHitches` also reports Apple's scroll hitch ratio. Run on GitHub Actions with
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
        app.buttons["All habits"].tap()
        XCTAssertTrue(app.navigationBars["All Habits"].waitForExistence(timeout: 5))
        ready()
        keepGoing(scrollUpAndDown)
    }

    func testScrollHabitPage() {
        app.buttons["All habits"].tap()
        let teeth = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Brush teeth'")).firstMatch
        XCTAssertTrue(teeth.waitForExistence(timeout: 5))
        teeth.tap()
        XCTAssertTrue(app.navigationBars["Brush teeth"].waitForExistence(timeout: 5))
        ready()
        keepGoing(scrollUpAndDown)
    }

    func testCalendarMonths() {
        app.buttons.matching(NSPredicate(format: "label ENDSWITH 'Open calendar'")).firstMatch.tap()
        let previous = app.buttons["Previous month"]
        let next = app.buttons["Next month"]
        XCTAssertTrue(previous.waitForExistence(timeout: 5))
        ready()
        keepGoing {
            for _ in 0..<3 { previous.tap() }
            for _ in 0..<3 { next.tap() }
        }
    }

    /// Apple's own measure of stutter: milliseconds of dropped frames per second of scrolling (under 5 is smooth).
    func testScrollHitches() {
        let list = app.collectionViews.firstMatch
        let options = XCTMeasureOptions()
        options.iterationCount = 5
        options.invocationOptions = [.manuallyStop] // only the swipe up is measured; the swipe down resets
        measure(metrics: [XCTOSSignpostMetric.scrollingAndDecelerationMetric], options: options) {
            list.swipeUp(velocity: .fast)
            stopMeasuring()
            list.swipeDown(velocity: .fast)
        }
    }
}
