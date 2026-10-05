import XCTest

/// Every habit shape people describe ("How People Describe a Habit", F01–F18), plus every type (timer,
/// checklist, cut down, tasks), made through + the way a person would (29 Sep 2026, the user: "is it easy for
/// the user to create all of the habits?"). Each checks the text preview and Today, and prints the taps it
/// took ("TAPS name: n"), counting each tap and each field typed into as one.
final class HabitCreationUITests: XCTestCase {
    override func record(_ issue: XCTIssue) {
        let shot = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        shot.name = "FAIL-\(name)"
        shot.lifetime = .keepAlways
        var issue = issue
        issue.add(shot)
        super.record(issue)
    }

    private var app: XCUIApplication!
    private var taps = 0
    private let cal = Calendar.current

    override func setUp() {
        continueAfterFailure = true
        app = XCUIApplication()
        app.launchArguments = ["-uitest", "-empty"]
        app.launch()
    }

    // MARK: Helpers (each counts as the person's taps)

    private func shot(_ name: String) {
        let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    private func row(_ title: String) -> XCUIElement {
        app.buttons.matching(NSPredicate(format: "label BEGINSWITH %@", title)).firstMatch
    }

    private func tap(_ element: XCUIElement, scroll: Bool = true) {
        if scroll { app.reveal(element) }
        XCTAssertTrue(element.exists, "Can't find \(element)")
        element.tap()
        taps += 1
    }

    private func type(_ text: String, into field: XCUIElement, clear: Bool = false) {
        XCTAssertTrue(field.waitForExistence(timeout: 3))
        if (field.value(forKey: "hasKeyboardFocus") as? Bool) != true { field.tap() }
        if clear, let old = field.value as? String, !old.isEmpty {
            field.typeText(String(repeating: XCUIKeyboardKey.delete.rawValue, count: old.count))
        }
        field.typeText(text)
        taps += 1
    }

    private func dismissKeyboard() {
        let done = app.toolbars.buttons["Done"].firstMatch
        if done.exists && done.isHittable { done.tap() }
    }

    private func back() {
        dismissKeyboard()
        app.navigationBars.buttons["BackButton"].firstMatch.tap()
        taps += 1
        sleep(1)
    }

    /// + → Build or maintain → the type (or Quit or cut down → Cut down, or Add a task) → a name.
    private func start(_ kind: String, name: String) {
        taps = 0
        tap(app.navigationBars.buttons["New Habit"].firstMatch, scroll: false)
        XCTAssertTrue(app.navigationBars["New"].waitForExistence(timeout: 3))
        switch kind {
        case "Cut down":
            tap(row("Quit or cut down,"), scroll: false); tap(row("Cut down,"), scroll: false)
        case "Task":
            tap(row("Add a task,"), scroll: false)
        default:
            tap(row("Build or maintain,"), scroll: false); tap(row(kind + ","), scroll: false)
        }
        type(name + "\n", into: app.descendants(matching: .any)["name-field"])
    }

    private func amount(_ number: String, unit: String? = nil, limit: Bool = false) {
        tap(row(limit ? "Limit" : "How much"))
        type(number, into: app.textFields["much-number"], clear: true)
        if let unit {
            dismissKeyboard()
            tap(app.buttons["much-unit"], scroll: false)
            tap(app.buttons[unit].firstMatch)
            sleep(1)
        }
        back()
    }

    private func often(_ choice: String, then steps: () -> Void = {}) {
        tap(row("How often"))
        XCTAssertTrue(app.navigationBars["How Often"].waitForExistence(timeout: 3))
        tap(app.buttons["often-" + choice])
        steps()
        back()
    }

    private func increment(_ id: String, _ times: Int) {
        let plus = app.buttons[id + "-Increment"]
        for _ in 0..<times { tap(plus) }
    }

    private var sentence: String { app.descendants(matching: .any)["habit-sentence"].label }

    /// Checks the text preview, adds it, checks Today, and prints the taps.
    private func finish(_ want: String, title: String = "New Habit", today: String? = nil, label: String) {
        XCTAssertEqual(sentence, want, "Text preview for \(label)")
        shot(label + "-form")
        let addButton = app.navigationBars[title].buttons["Add"]
        XCTAssertTrue(addButton.isEnabled, "Add is enabled for \(label)")
        addButton.tap(); taps += 1
        let allow = XCUIApplication(bundleIdentifier: "com.apple.springboard").buttons["Allow"]
        if allow.waitForExistence(timeout: 2) { allow.tap() }
        sleep(1)
        if let today {
            let element = app.descendants(matching: .any).matching(NSPredicate(format: "label BEGINSWITH %@", today)).firstMatch
            app.reveal(element, clear: true)
            XCTAssertTrue(element.exists, "Today shows \(today) for \(label)")
        }
        print("TAPS \(label): \(taps)")
        let note = XCTAttachment(string: "\(label): \(taps) taps")
        note.name = "TAPS-\(label)"
        note.lifetime = .keepAlways
        add(note)
    }

    // MARK: Every day, several a day, N a week

    func testDailyShapes() {
        start("Check it off", name: "Make bed")                                    // F01
        finish("Make bed every day, anytime", today: "Mark Make bed done", label: "F01-every-day")

        start("Track an amount", name: "Drink water")                              // F02
        amount("8", unit: "glasses")
        finish("Drink water 8 glasses a day, anytime", today: "Add 1 glass to Drink water", label: "F02-amount-a-day")

        start("Check it off", name: "Brush teeth")                                 // F03
        often("timesADay")
        // Several times a day is a +1 counter on Today (Rulebook U14: ✓ toggles, + adds).
        finish("Brush teeth twice a day, anytime", today: "Add 1 to Brush teeth", label: "F03-twice-a-day")

        start("Time it", name: "Meditate")                                         // time
        tap(row("How long"))
        tap(app.buttons["Type"].firstMatch, scroll: false)
        type("10", into: app.textFields["duration-minutes"], clear: true)
        back()
        finish("Meditate 10 min a day, anytime", today: "Start Meditate timer", label: "T1-timer")
    }

    func testWeeklyShapes() {
        start("Check it off", name: "Gym")                                          // F04
        often("times")
        finish("Gym 3 times a week, anytime", today: "0/3 this week", label: "F04-3-times-a-week")

        start("Track an amount", name: "Run")                                       // F05
        amount("5", unit: "km")
        often("times")
        finish("Run 5 km on 3 days a week, anytime", today: "Add 5 km to Run", label: "F05-amount-on-3-days")

        start("Track an amount", name: "Read")                                      // F06
        amount("2", unit: "chapters")
        often("total-week")
        finish("Read 2 chapters a week, anytime", today: "0/2 chapters this week", label: "F06-amount-a-week")

        start("Check it off", name: "Call mum")                                     // F07
        often("times") { for _ in 0..<2 { tap(app.buttons["often-count-Decrement"]) } }
        finish("Call mum once a week, anytime", today: "0/1 this week", label: "F07-once-a-week")
    }

    // MARK: Set days, intervals, dates

    func testSetDayShapes() {
        let today = cal.component(.weekday, from: .now)
        let full = cal.standaloneWeekdaySymbols
        start("Check it off", name: "Laundry")                                      // F08
        often("weekdays") {
            for day in [4, 7] where day != today { tap(app.buttons[full[day - 1]].firstMatch) }
            if ![4, 7].contains(today) { tap(app.buttons[full[today - 1]].firstMatch) }
        }
        // Not due on other days, so Today shows it only on Wednesday or Saturday.
        finish("Laundry every Wednesday and Saturday, anytime", today: [4, 7].contains(today) ? "Laundry" : nil, label: "F08-set-weekdays")

        start("Check it off", name: "Walk")                                          // six days
        often("weekdays") {
            // One more day first, then drop Monday if it's today, then the rest: all seven chosen at once turns the
            // days into "every day" and the weekday buttons go (failed every Monday, found 5 Oct 2026).
            let days = [1, 3, 4, 5, 6, 7].filter { $0 != today }
            tap(app.buttons[full[days[0] - 1]].firstMatch)
            if today == 2 { tap(app.buttons[full[1]].firstMatch) }
            for day in days.dropFirst() { tap(app.buttons[full[day - 1]].firstMatch) }
        }
        // Not due on Mondays, so Today shows it every other day (failed on a Monday, 5 Oct 2026).
        finish("Walk every day except Monday, anytime", today: today == 2 ? nil : "Walk", label: "F08b-six-days")

        start("Check it off", name: "Water plants")                                 // F09 days
        often("everyDays") { increment("often-every-count", 1) }
        finish("Water plants every 3 days, anytime", today: "Water plants", label: "F09a-every-3-days")

        start("Check it off", name: "Change sheets")                                 // F09 weeks
        often("everyWeeks")
        finish("Change sheets every other week, anytime", today: "Change sheets", label: "F09b-every-other-week")

        start("Check it off", name: "Replace filter")                                // F09 months
        often("everyMonths")
        XCTAssertTrue(sentence.hasPrefix("Replace filter on the") && sentence.contains("every 3 months"), sentence)
        finish(sentence, label: "F09c-every-3-months")
    }

    func testMonthAndYearShapes() {
        let date = cal.component(.day, from: .now)
        start("Check it off", name: "Pay rent")                                      // F10
        often("date") {
            if date != 1 { tap(app.buttons["Day 1"]); tap(app.buttons["Day \(date)"]) }
        }
        finish("Pay rent on the 1st of every month, anytime", today: date == 1 ? "Pay rent" : nil, label: "F10-monthly-date")

        start("Check it off", name: "Hike")                                           // F11
        often("times") { tap(app.buttons["Month"].firstMatch); tap(app.buttons["often-count-Decrement"]) }
        finish("Hike twice a month, anytime", today: "0/2 this month", label: "F11-twice-a-month")

        start("Track an amount", name: "Finish")                                      // F12
        amount("2", unit: "books")
        often("total-month")
        finish("Finish 2 books a month, anytime", today: "0/2 books this month", label: "F12-amount-a-month")

        start("Check it off", name: "Check-up")                                       // F13
        often("date") {
            tap(app.buttons["Year"].firstMatch)
            tap(row("Month,")); tap(app.buttons["October"].firstMatch)
            tap(row("Date,"))
            let first = app.buttons["1st"].firstMatch
            for _ in 0..<4 where !first.isHittable { app.swipeDown(velocity: .slow) }
            tap(first, scroll: false)
        }
        finish("Check-up every year on October 1, anytime", today: nil, label: "F13-yearly-date")

        start("Check it off", name: "Swim")                                            // F14
        often("times") { tap(app.buttons["Year"].firstMatch); increment("often-count", 9) }
        finish("Swim 12 times a year, anytime", today: "0/12 this year", label: "F14-12-times-a-year")

        start("Track an amount", name: "Read")                                        // F15
        amount("20", unit: "books")
        often("total-year")
        finish("Read 20 books a year, anytime", today: "0/20 books this year", label: "F15-amount-a-year")
    }

    // MARK: Other types

    func testOtherTypes() {
        start("Checklist", name: "Clean kitchen")
        tap(row("Steps"))
        tap(app.buttons["Add Step"])
        type("Dishes\n", into: app.textFields["e.g. Dishes"].firstMatch)
        type("Sink\n", into: app.textFields["Next step"].firstMatch)
        let fields = app.textFields.matching(identifier: "Next step")
        type("Floor", into: fields.element(boundBy: fields.count - 1))
        back()
        finish("Clean kitchen every day, anytime", today: "0/3 steps", label: "C1-checklist")

        start("Cut down", name: "Coffee")
        amount("2", unit: "coffees", limit: true)
        finish("At most 2 coffees a day", title: "Cut down", today: "Coffee", label: "L1-cut-down")

        start("Check it off", name: "Stretch")
        tap(row("Time of Day"))
        tap(app.buttons["Morning"].firstMatch, scroll: false); tap(app.buttons["Evening"].firstMatch, scroll: false)
        back()
        tap(row("Reminders"))
        tap(app.switches["Remind Me"].firstMatch.switches.firstMatch, scroll: false)
        XCTAssertTrue(app.staticTexts["Morning reminder"].waitForExistence(timeout: 2), "Turning reminders on brings one per part of the day")
        back()
        finish("Stretch every day, morning and evening", today: "Stretch", label: "P1-two-parts-reminders")

        start("Task", name: "Book dentist")
        XCTAssertEqual(sentence, "Book dentist today")
        let add = app.navigationBars["Task"].buttons["Add"]
        add.tap(); taps += 1
        print("TAPS X1-one-time-task: \(taps)")

        start("Task", name: "Replace brush")
        tap(row("Repeat,")); tap(app.buttons["On a schedule"].firstMatch, scroll: false)
        tap(row("How often"))
        tap(app.buttons["often-afterDone"])
        tap(app.buttons["Months"].firstMatch); increment("often-after-count", 2)
        back()
        finish("Replace brush 3 months after it's done, anytime", title: "Task", today: "Replace brush", label: "X2-task-after-done")
    }

    /// Numbers: full and grouped in sentences ("10,000 steps"), "k" on Today's line and button ("1k/10k", "+1k").
    func testBigNumbers() {
        start("Track an amount", name: "Walk")
        amount("10000", unit: "steps")
        finish("Walk 10,000 steps a day, anytime", today: "0/10k steps", label: "N1-10k-steps")
        let plus = app.buttons["Add 1,000 steps to Walk"]
        XCTAssertTrue(plus.exists, "+ says its step in full for VoiceOver")
        plus.tap(); sleep(1)
        XCTAssertTrue(app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH '1k/10k steps'")).firstMatch.exists, "1,000 reads 1k on Today")
        start("Track an amount", name: "Save")
        amount("1500")
        finish("Save 1,500 a day, anytime", today: "0/1.5k", label: "N2-1500")
        shot("N-today")
    }
}
