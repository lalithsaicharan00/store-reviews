import XCTest

/// Speed tests (30 Sep 2026): each one opens a screen with a year of history and keeps using it the way a person
/// does (scrolling, tapping, typing) while `Tools/perf/measure_perf.sh` measures the app. Run on GitHub Actions with
/// "[ios-perf]" in a commit message; they check speed, not behaviour, so the normal test runs skip them.
///
/// The app is launched with `-perf-meter`: it records every stretch its main thread was busy for a frame or more
/// (`MainThreadMeter`). Each test prints the times of its measured window (PERF-WINDOW) and of each screen opening
/// (PERF-OPEN), and the script reads the app's stalls in those windows. PERF-READY starts `sample`, which says
/// which of the app's functions took the time.
///
/// Inside a window the test never searches the screen: a search runs on the app's main thread and would count as
/// the app's stall. Buttons are found once, before the window, and then tapped by their position.
final class PerformanceUITests: XCTestCase {
    /// How long each test keeps using its screen. The script samples for less than this.
    static let busyFor: TimeInterval = 20

    private var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-uitest", "-perf-history", "-perf-meter"]
        app.launch()
        XCTAssertTrue(app.collectionViews.firstMatch.waitForExistence(timeout: 15))
    }

    private var now: String { String(format: "%.3f", Date.now.timeIntervalSince1970) }

    /// Taps, then waits for `shown`; the app's longest stall in between is how long the tap froze it.
    private func open(_ screen: String, tapping button: XCUIElement, until shown: XCUIElement) {
        XCTAssertTrue(button.waitForExistence(timeout: 10), "\(screen): the button to open it isn't there")
        let start = now
        button.tap()
        guard shown.waitForExistence(timeout: 30) else {
            // What was on screen instead, so the log says whether the screen is slow, broken or just named differently.
            print("PERF-OPEN-FAILED \(screen)")
            print(app.debugDescription)
            XCTFail("\(screen) didn't open")
            return
        }
        print("PERF-OPEN \(screen)|\(start)|\(now)")
    }

    /// Repeats `step` for `busyFor` seconds: the measured window.
    private func keepGoing(_ step: () -> Void) {
        print("PERF-READY \(name)")
        let start = now
        let end = Date.now.addingTimeInterval(Self.busyFor)
        while Date.now < end { step() }
        print("PERF-WINDOW \(start) \(now)")
    }

    /// Where an element is now, to tap later without searching the screen again.
    private func point(_ element: XCUIElement) -> XCUICoordinate {
        XCTAssertTrue(element.waitForExistence(timeout: 10), "\(element) isn't there")
        let frame = element.frame
        return app.coordinate(withNormalizedOffset: .zero).withOffset(CGVector(dx: frame.midX, dy: frame.midY))
    }

    /// A slow drag the length of the screen, as a finger reading down the list.
    private func drag(up: Bool) {
        let from = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: up ? 0.75 : 0.3))
        let to = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: up ? 0.3 : 0.75))
        from.press(forDuration: 0.01, thenDragTo: to, withVelocity: .slow, thenHoldForDuration: 0)
    }

    private func scrollUpAndDown() {
        for up in [true, true, true, false, false, false] { drag(up: up) }
    }

    func testScrollToday() {
        keepGoing(scrollUpAndDown)
    }

    /// +1 on Water (already done, so its row stays put), then the day before and back: each tap redraws Today.
    func testTapToday() {
        let plus = point(app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Add ' AND label ENDSWITH ' to Water'")).firstMatch)
        let previous = point(app.buttons["Previous day"])
        let next = point(app.buttons["Next day"])
        plus.tap() // its "Add note" line appears once, before the window
        keepGoing {
            plus.tap()
            previous.tap()
            next.tap()
        }
    }

    func testScrollAllHabits() {
        open("All Habits", tapping: app.buttons["All habits"], until: app.navigationBars["All Habits"])
        keepGoing(scrollUpAndDown)
    }

    func testScrollHabitPage() {
        open("All Habits", tapping: app.buttons["All habits"], until: app.navigationBars["All Habits"])
        // A year of daily history: its numbers and best streak are the heaviest page.
        let teeth = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Brush teeth'")).firstMatch
        open("Habit page", tapping: teeth, until: app.navigationBars["Brush teeth"])
        keepGoing(scrollUpAndDown)
    }

    func testCalendarMonths() {
        open("Calendar", tapping: app.buttons.matching(NSPredicate(format: "label ENDSWITH 'Open calendar'")).firstMatch,
             until: app.buttons["Previous month"])
        let previous = point(app.buttons["Previous month"])
        let next = point(app.buttons["Next month"])
        keepGoing {
            for _ in 0..<3 { previous.tap() }
            for _ in 0..<3 { next.tap() }
        }
    }

    /// Typing a name: every letter redraws the form, its preview row and its sentence.
    func testNewHabitForm() {
        open("New Habit", tapping: app.navigationBars.buttons["New Habit"].firstMatch,
             until: app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Build or maintain'")).firstMatch)
        app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Build or maintain'")).firstMatch.tap()
        let field = app.descendants(matching: .any)["name-field"]
        open("Habit form", tapping: app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Check it off'")).firstMatch,
             until: field)
        field.tap()
        let name = "Drink a glass of water"
        let erase = String(repeating: XCUIKeyboardKey.delete.rawValue, count: name.count)
        keepGoing {
            app.typeText(name)
            app.typeText(erase)
        }
    }

    /// Moving through a routine: each page shows a habit, and a timed one starts and stops its timer.
    func testRoutinePlayer() {
        open("Routine player", tapping: app.buttons["start-Anytime"], until: app.buttons["focus-up-next"])
        let next = point(app.buttons["focus-up-next"])
        let previous = point(app.buttons["Previous habit"])
        keepGoing {
            next.tap()
            previous.tap()
        }
    }
}
