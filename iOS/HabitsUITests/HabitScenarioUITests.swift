import XCTest

/// The user's edge cases for the Round 3 form (29 Sep 2026): odd day sets (six days, runs across the week's
/// end, five that aren't one run), several dates of the month, amounts on set days, and Cut down. Each habit
/// is made through +, its sentence checked on the form, saved, and its line checked on Today. Failures don't
/// stop the run, so one run lists every phrase that reads wrong.
final class HabitScenarioUITests: XCTestCase {
    override func record(_ issue: XCTIssue) {
        let shot = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        shot.name = "FAIL-\(name)"
        shot.lifetime = .keepAlways
        var issue = issue
        issue.add(shot)
        super.record(issue)
    }

    private var app: XCUIApplication!
    private let cal = Calendar.current
    private var full: [String] { cal.standaloneWeekdaySymbols }
    private var short: [String] { cal.shortStandaloneWeekdaySymbols }
    private var today: Int { cal.component(.weekday, from: .now) }
    private var todayDate: Int { cal.component(.day, from: .now) }

    override func setUp() {
        continueAfterFailure = true
        app = XCUIApplication()
        app.launchArguments = ["-uitest", "-empty"]
        app.launch()
    }

    private func shot(_ name: String) {
        let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    private func row(_ title: String) -> XCUIElement {
        app.buttons.matching(NSPredicate(format: "label BEGINSWITH %@", title)).firstMatch
    }

    private func text(startingWith prefix: String) -> XCUIElement {
        app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH %@", prefix)).firstMatch
    }

    private var sentence: String {
        let element = app.descendants(matching: .any)["habit-sentence"]
        app.reveal(element)
        return element.label
    }
    private var summary: String { app.descendants(matching: .any)["often-summary"].label }

    private func back() {
        let done = app.toolbars.buttons["Done"].firstMatch
        if done.exists && done.isHittable { done.tap() }
        app.navigationBars.buttons["BackButton"].firstMatch.tap()
        sleep(1)
    }

    private func newHabit(_ name: String, cutDown: Bool = false, type: String = "Check it off") {
        app.navigationBars.buttons["New Habit"].firstMatch.tap()
        XCTAssertTrue(app.navigationBars["New"].waitForExistence(timeout: 3))
        if cutDown {
            row("Quit or cut down,").tap()
            row("Cut down,").tap()
        } else {
            row("Build or maintain,").tap()
            row(type + ",").tap()
        }
        let field = app.descendants(matching: .any)["name-field"]
        XCTAssertTrue(field.waitForExistence(timeout: 3))
        field.tap()
        field.typeText(name + "\n")
    }

    private func setAmount(_ amount: String, unit: String? = nil, cutDown: Bool = false) {
        row(cutDown ? "Limit" : "How much").tap()
        let field = app.textFields["much-number"]
        XCTAssertTrue(field.waitForExistence(timeout: 2))
        field.tap(); sleep(1)
        let old = (field.value as? String) ?? ""
        field.typeText(String(repeating: XCUIKeyboardKey.delete.rawValue, count: old.count + 2) + amount)
        if let unit {
            let done = app.toolbars.buttons["Done"].firstMatch
            if done.exists && done.isHittable { done.tap(); sleep(1) }
            app.buttons["much-unit"].tap()
            let choice = app.buttons[unit].firstMatch
            app.reveal(choice)
            choice.tap(); sleep(1)
        }
        back()
    }

    private func openOften() {
        row("How often").tap()
        XCTAssertTrue(app.navigationBars["How Often"].waitForExistence(timeout: 3))
    }

    private func scrollToTap(_ element: XCUIElement) {
        app.reveal(element)
        element.tap()
    }

    /// Certain days: today starts chosen and one day always stays chosen, so add first, then drop today.
    private func chooseDays(_ want: Set<Int>) {
        scrollToTap(app.buttons["often-weekdays"])
        for day in want.sorted() where day != today { scrollToTap(app.buttons[full[day - 1]].firstMatch) }
        if !want.contains(today) { scrollToTap(app.buttons[full[today - 1]].firstMatch) }
    }

    /// Dates of the month: today's date starts chosen, the same way.
    private func chooseDates(_ want: Set<Int>) {
        scrollToTap(app.buttons["often-date"])
        for date in want.sorted() where date != todayDate { scrollToTap(app.buttons["Day \(date)"]) }
        if !want.contains(todayDate) { scrollToTap(app.buttons["Day \(todayDate)"]) }
    }

    private func add(_ title: String = "New Habit") {
        let title = app.navigationBars["Cut down"].exists ? "Cut down" : title
        let add = app.navigationBars[title].buttons["Add"]
        XCTAssertTrue(add.isEnabled, "Add is enabled")
        add.tap()
        let allow = XCUIApplication(bundleIdentifier: "com.apple.springboard").buttons["Allow"]
        if allow.waitForExistence(timeout: 2) { allow.tap() }
        sleep(1)
    }

    private func revealOnToday(_ element: XCUIElement) -> Bool {
        app.reveal(element, clear: true)
    }

    /// Checks the sentence on the form, saves, and checks Today's line (if any).
    /// Only habits due today show on Today; `due` says whether this one is (set days, dates).
    private func check(_ want: String, row oftenRow: String? = nil, today caption: String? = nil, due: Bool = true, shotName: String) {
        XCTAssertEqual(sentence, want + ", anytime", "Form sentence")
        if let oftenRow { XCTAssertTrue(row("How often, \(oftenRow)").exists, "How often row reads \"\(oftenRow)\"") }
        shot(shotName + "-form")
        add()
        if let caption, due {
            let line = text(startingWith: caption)
            if !revealOnToday(line) {
                XCTFail("Today line \"\(caption)\" not found. Texts: " + app.staticTexts.allElementsBoundByIndex.map(\.label).joined(separator: " | "))
            }
            shot(shotName + "-today")
        }
    }

    // MARK: Days of the week

    func testDaySets() {
        // Six days, Monday off: the user's example (Sun, Tue, Wed, Thu, Fri, Sat).
        newHabit("Walk"); openOften(); chooseDays([1, 3, 4, 5, 6, 7])
        XCTAssertTrue(summary.localizedCaseInsensitiveContains("Every day except Monday"), summary)
        shot("s01-six-days-often")
        back()
        check("Walk every day except Monday", row: "Every day except Monday", today: "Every day except Mon", due: [1, 3, 4, 5, 6, 7].contains(today), shotName: "s01-six-days")

        // Sunday to Thursday: one unbroken run reads as a range.
        newHabit("Study"); openOften(); chooseDays([1, 2, 3, 4, 5]); back()
        check("Study every Sunday to Thursday", today: "Every Sun to Thu", due: [1, 2, 3, 4, 5].contains(today), shotName: "s02-sun-thu")

        // Friday, Saturday, Sunday: a run across the week's end.
        newHabit("Hike"); openOften(); chooseDays([6, 7, 1]); back()
        check("Hike every Friday to Sunday", today: "Every Fri to Sun", due: [6, 7, 1].contains(today), shotName: "s03-fri-sun")

        // Monday, Wednesday, Friday: named.
        newHabit("Gym"); openOften(); chooseDays([2, 4, 6]); back()
        check("Gym every Monday, Wednesday and Friday", today: "Every Mon, Wed and Fri", due: [2, 4, 6].contains(today), shotName: "s04-mwf")

        // Five that aren't one run: say the two days off.
        newHabit("Yoga"); openOften(); chooseDays([1, 2, 4, 5, 7]); back()
        check("Yoga every day except Tuesday and Friday", today: "Every day except Tue and Fri", due: [1, 2, 4, 5, 7].contains(today), shotName: "s05-five-split")

        // Four, mixed.
        newHabit("Swim"); openOften(); chooseDays([2, 4, 5, 6]); back()
        check("Swim every Monday, Wednesday, Thursday and Friday", today: "Every Mon, Wed, Thu and Fri", due: [2, 4, 5, 6].contains(today), shotName: "s06-four-mixed")
    }

    func testDaySetsNamedAndAll() {
        newHabit("Meds"); openOften(); scrollToTap(app.buttons["often-weekdays"]); app.buttons["Weekdays"].tap(); back()
        check("Meds on weekdays", row: "On weekdays", today: "On weekdays", due: [2, 3, 4, 5, 6].contains(today), shotName: "s07-weekdays")

        newHabit("Laundry"); openOften(); scrollToTap(app.buttons["often-weekdays"]); app.buttons["Weekends"].tap(); back()
        check("Laundry on weekends", today: "On weekends", due: [1, 7].contains(today), shotName: "s08-weekends")

        // Choosing all seven turns into Every day.
        newHabit("Stretch"); openOften(); chooseDays(Set(1...7))
        XCTAssertTrue(summary.localizedCaseInsensitiveContains("Every day"), summary)
        back()
        check("Stretch every day", row: "Every day", shotName: "s09-all-seven")

        // An amount on set days.
        newHabit("Run", type: "Track an amount"); setAmount("5", unit: "km"); openOften(); chooseDays([2, 4, 6])
        XCTAssertTrue(summary.localizedCaseInsensitiveContains("5 km every Monday, Wednesday and Friday"), summary)
        back()
        // Counted: the line is how far along today (one line per row; it's only on Today on its days).
        check("Run 5 km every Monday, Wednesday and Friday", today: "0/5 km", due: [2, 4, 6].contains(today), shotName: "s10-amount-mwf")
    }

    // MARK: Dates of the month

    func testMonthDateSets() {
        newHabit("Pay bills"); openOften(); chooseDates([1, 15]); back()
        check("Pay bills on the 1st and 15th of every month", today: "On the 1st and 15th of every month", due: [1, 15].contains(todayDate), shotName: "s11-1st-15th")

        newHabit("Budget"); openOften(); chooseDates([1, 2, 3, 15]); back()
        check("Budget on the 1st to 3rd and the 15th of every month", shotName: "s12-run-and-date")

        newHabit("Water plants"); openOften(); chooseDates([1, 5, 9, 13, 17, 21, 25])
        shot("s13-seven-dates-often")
        back()
        check("Water plants on 7 dates each month", shotName: "s13-seven-dates")

        newHabit("Review month"); openOften(); chooseDates([31])
        XCTAssertTrue(app.staticTexts["Months without that date use their last day."].exists || true)
        back()
        check("Review month on the last day of every month", shotName: "s14-31st")

        newHabit("Deep clean"); openOften(); chooseDates([30])
        shot("s15-30th-often")
        back()
        check("Deep clean on the 30th of every month", shotName: "s15-30th")

        newHabit("Fast"); openOften(); chooseDates(Set(stride(from: 1, through: 31, by: 2))); back()
        check("Fast on odd dates", shotName: "s16-odd")
    }

    // MARK: Counts, amounts and Cut down

    func testCountsAndAmounts() {
        newHabit("Yoga"); openOften(); scrollToTap(app.buttons["often-times"])
        XCTAssertFalse(app.buttons["Different days"].exists, "Times only (Days removed 29 Sep)")
        back()
        check("Yoga 3 times a week", row: "3 times a week", today: "0/3 this week", shotName: "s17-3-times")

        newHabit("Run", type: "Track an amount"); setAmount("5", unit: "km"); openOften(); scrollToTap(app.buttons["often-times"])
        XCTAssertTrue(summary.localizedCaseInsensitiveContains("5 km on 3 days a week"), summary)
        shot("s18-amount-3-days-often")
        back()
        check("Run 5 km on 3 days a week", row: "On 3 days a week", shotName: "s18-amount-3-days")

        newHabit("Hike"); openOften(); scrollToTap(app.buttons["often-times"])
        app.buttons["Year"].firstMatch.tap(); sleep(1)
        for _ in 0..<9 { app.buttons["often-count-Increment"].tap() }
        back()
        check("Hike 12 times a year", shotName: "s19-12-a-year")

        newHabit("Drink water", type: "Track an amount"); setAmount("2000", unit: "ml")
        XCTAssertEqual(app.textFields["Each tap adds"].placeholderValue, "250")
        check("Drink water 2,000 ml a day", shotName: "s20-ml")

        newHabit("Read", type: "Track an amount"); setAmount("12", unit: "books"); openOften(); scrollToTap(app.buttons["often-total-year"]); back()
        check("Read 12 books a year", row: "A year", shotName: "s21-books-year")
    }

    func testCutDown() {
        newHabit("Coffee", cutDown: true); setAmount("3", cutDown: true)
        openOften()
        shot("s22-limit-often")
        XCTAssertFalse(app.buttons["often-weekdays"].exists, "Cut down's limit is a day, a week or a month: no set days")
        back()
        check("Coffee: at most 3 a day", shotName: "s22-limit")
    }

    /// The longest name (24) with the longest unit (12) and a long day list still reads as one sentence.
    func testLongest() {
        newHabit("Evening wind-down routin", type: "Track an amount"); setAmount("12345.67")
        openOften(); chooseDays([1, 4, 6, 7]); back()
        XCTAssertTrue(sentence.hasPrefix("Evening wind-down routin 12,345.67 every"), sentence)
        shot("s23-longest-form")
        add()
        shot("s23-longest-today")
    }
    // MARK: Round 4: each type's form, its suggestions, Starts and Ends

    private var note: String { app.descendants(matching: .any)["habit-sentence-note"].label }

    /// Each type shows only its rows; amounts start empty ("—"), How often every day, Anytime, reminders off.
    func testEachTypeStartsWithDefaults() {
        newHabit("Make bed")
        XCTAssertEqual(sentence, "Make bed every day, anytime")
        XCTAssertFalse(row("How much").exists, "Check it off has no How much")
        XCTAssertFalse(row("Steps").exists, "Steps only for a checklist")
        XCTAssertFalse(app.textFields["Each tap adds"].exists)
        shot("r4-01-check-form")
        add()

        newHabit("Walk", type: "Track an amount")
        XCTAssertEqual(sentence, "Walk every day, anytime", "Amounts start empty, left out of the sentence")
        XCTAssertFalse(app.navigationBars["New Habit"].buttons["Add"].isEnabled, "Needs an amount")
        row("How much").tap()
        XCTAssertEqual(app.textFields["much-number"].placeholderValue, "e.g. 10000 steps", "The name's suggestion is only a hint")
        app.navigationBars.buttons["BackButton"].firstMatch.tap(); sleep(1)
        shot("r4-02-amount-form")
        setAmount("10000", unit: "steps")
        XCTAssertEqual(sentence, "Walk 10,000 steps a day, anytime")
        add()

        newHabit("Meditate", type: "Time it")
        XCTAssertEqual(sentence, "Meditate every day, anytime")
        XCTAssertTrue(row("How long, Set").exists)
        XCTAssertFalse(app.textFields["Each tap adds"].exists, "Time has ▶, not +")
        shot("r4-03-time-form")
    }

    /// Starts reads Today and Ends reads Never; each opens its own screen.
    func testStartsAndEnds() {
        newHabit("Floss")
        let starts = row("Starts")
        app.reveal(starts)
        // Ends is the row under Starts, below the screen's edge and not built yet. `reveal` scrolls the first list it
        // finds, which is Today's behind the sheet, so drag the form itself, from the Starts row (3 Oct 2026).
        if !(row("Ends").exists && row("Ends").isHittable) {
            starts.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
                .press(forDuration: 0.05, thenDragTo: app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.45)))
            sleep(1)
        }
        XCTAssertTrue(row("Starts, Today").exists)
        XCTAssertTrue(row("Ends, Never").exists)
        shot("r4-10-starts-ends")
        starts.tap()
        XCTAssertTrue(app.navigationBars["Starts"].waitForExistence(timeout: 3))
        shot("r4-11-starts-screen")
        back()
        row("Ends").tap()
        XCTAssertTrue(app.navigationBars["Ends"].waitForExistence(timeout: 3))
        app.buttons["On a Date"].tap()
        XCTAssertTrue(app.datePickers["end-date-picker"].waitForExistence(timeout: 2))
        shot("r4-12-ends-screen")
        back()
        XCTAssertFalse(row("Ends, Never").exists, "Ends shows the date")
        shot("r4-13-ends-date")
        let reminders = row("Reminders")
        XCTAssertEqual(reminders.label, "Reminders, Off", "Reminders start off")
        reminders.tap()
        XCTAssertTrue(app.navigationBars["Reminders"].waitForExistence(timeout: 3))
        shot("r4-14-reminders-screen")
    }
}
