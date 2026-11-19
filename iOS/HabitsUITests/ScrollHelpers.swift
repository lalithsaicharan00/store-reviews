import XCTest

/// One way to bring a row into view, for every UI test (29 Sep 2026). The old helpers swiped a fixed number of
/// times (up to 20, often after three "back to the top" swipes) without checking whether the list moved, so
/// with one card on Today, or at the end of a list, they kept swiping into the bounce and wasted minutes.
///
/// This one doesn't swipe when the row is already visible, heads the right way when the row's position is
/// known, and stops as soon as a swipe moves nothing.
extension XCUIApplication {
    /// - Parameter clear: also keep the row away from the top bar and the floating day bar on Today.
    @discardableResult
    func reveal(_ element: XCUIElement, clear: Bool = false, maxSwipes: Int = 10) -> Bool {
        let element = element.firstMatch // a query that matches twice mustn't stop the test
        let window = windows.firstMatch
        func visible() -> Bool {
            guard element.exists, element.isHittable else { return false }
            guard clear else { return true }
            let frame = element.frame
            return frame.minY > 100 && frame.maxY < window.frame.maxY - 110
        }
        if visible() { return true }
        let list = collectionViews.firstMatch
        guard list.exists else { return element.exists }

        // Known position: go straight towards it. Unknown (not built yet): later rows first, then earlier ones.
        var directions: [Bool] = [true, false] // true = swipe up, to see rows further down
        if element.exists {
            directions = element.frame.midY < window.frame.midY ? [false, true] : [true, false]
        }
        for up in directions {
            var last = list.cells.firstMatch.frame
            for _ in 0..<maxSwipes {
                // A short drag, so a row just under a bar isn't flung past.
                let from = window.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: up ? 0.7 : 0.3))
                let to = window.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: up ? 0.35 : 0.65))
                from.press(forDuration: 0.05, thenDragTo: to)
                if visible() { return true }
                let now = list.cells.firstMatch.frame
                if now == last { break } // nothing moved: the end of the list
                last = now
            }
        }
        return visible()
    }

    /// Brings the row into view and taps it.
    func revealAndTap(_ element: XCUIElement, clear: Bool = false) {
        reveal(element, clear: clear)
        element.tap()
    }
}

extension XCUIApplication {
    /// Turns one wheel of the record screens' duration picker (0 hours, 1 minutes, 2 seconds) to a value such as
    /// "15 minutes": the wheel is iOS's own, so it's turned, never typed into (17 Nov 2026).
    func setDuration(_ wheel: Int, to value: String, file: StaticString = #filePath, line: UInt = #line) {
        let wheels = pickers["record-duration"].pickerWheels
        XCTAssertTrue(wheels.firstMatch.waitForExistence(timeout: 3), "The duration wheel", file: file, line: line)
        wheels.element(boundBy: wheel).adjust(toPickerWheelValue: value)
    }
}

extension XCUIApplication {
    /// History's "which day?" calendar (Go to Date… and Add, 19 Nov 2026): taps the first day that can be picked in the
    /// month it opens on (today's) and returns that day's key ("2026-11-01"), or nil if the calendar never showed.
    /// iOS's calendar names a day by its weekday ("Sunday, November 1"); the month and year buttons have none.
    func pickCalendarDay(file: StaticString = #filePath, line: UInt = #line) -> String? {
        let weekdays = Calendar.current.weekdaySymbols
        let names = weekdays.map { _ in "label CONTAINS %@" }.joined(separator: " OR ")
        let days = buttons.matching(NSPredicate(format: "enabled == YES AND (\(names))", argumentArray: weekdays))
        guard days.firstMatch.waitForExistence(timeout: 5) else {
            XCTFail("The calendar's days never showed", file: file, line: line)
            return nil
        }
        let day = days.firstMatch
        guard let number = day.label.split(whereSeparator: { !$0.isNumber }).compactMap({ Int($0) }).first(where: { $0 <= 31 }) else {
            XCTFail("No day number in “\(day.label)”", file: file, line: line)
            return nil
        }
        let now = Calendar.current.dateComponents([.year, .month], from: .now)
        day.tap()
        return String(format: "%04d-%02d-%02d", now.year ?? 0, now.month ?? 0, number)
    }
}
