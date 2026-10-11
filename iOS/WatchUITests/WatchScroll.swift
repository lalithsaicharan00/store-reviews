import XCTest

/// Scrolling in the Watch UI tests. `swipeUp()` on the Watch flings: one swipe can carry a row from below the screen to
/// above it between two checks, so a test looking for Water (the second section) found Evening instead (run
/// 38097123253). These move the list by short drags that stop where they end, and check after each one.
extension XCUIApplication {
    /// True when the element is on the screen, clear of the title and clock at the top.
    func isShown(_ element: XCUIElement) -> Bool {
        guard element.exists, element.isHittable else { return false }
        let screen = windows.firstMatch.frame
        let frame = element.frame
        return !frame.isEmpty && frame.minY >= screen.minY + screen.height * 0.16 && frame.maxY <= screen.maxY + 1
    }

    /// Moves the list a little under half a screen: `down` shows what's further down.
    func nudge(down: Bool = true) {
        let window = windows.firstMatch
        let from = window.coordinate(withNormalizedOffset: CGVector(dx: 0.3, dy: down ? 0.72 : 0.32))
        let to = window.coordinate(withNormalizedOffset: CGVector(dx: 0.3, dy: down ? 0.32 : 0.72))
        // A plain press-and-drag still flung (two of them skipped two sections, run 38108831710): drag slowly and hold
        // before lifting, so the list stops where the finger stops. Looked up at run time: the slow drag isn't
        // declared for watchOS in every Xcode, and a missing method mustn't break the build.
        let selector = NSSelectorFromString("pressForDuration:thenDragToCoordinate:withVelocity:thenHoldForDuration:")
        if from.responds(to: selector), let method = from.method(for: selector) {
            typealias SlowDrag = @convention(c) (AnyObject, Selector, Double, AnyObject, Double, Double) -> Void
            unsafeBitCast(method, to: SlowDrag.self)(from, selector, 0.05, to, 150, 0.4)
        } else {
            from.press(forDuration: 0.05, thenDragTo: to)
        }
    }

    /// Scrolls until `element` is on the screen: down first, then back up. Returns whether it got there.
    @discardableResult
    func reveal(_ element: XCUIElement, steps: Int = 12) -> Bool {
        _ = element.waitForExistence(timeout: 3)
        for down in [true, false] {
            for _ in 0..<steps {
                if isShown(element) { return true }
                nudge(down: down)
            }
        }
        return isShown(element)
    }

    /// The routine's next (or previous) page: a quick flick on the dial, which a vertical pager takes as a page turn
    /// (`swipeUp()` on the whole screen didn't turn it, run 38112417583).
    func page(down: Bool = true) {
        let window = windows.firstMatch
        let from = window.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: down ? 0.62 : 0.3))
        let to = window.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: down ? 0.2 : 0.72))
        from.press(forDuration: 0.02, thenDragTo: to)
    }

    /// Waits until the element's label is `label` (a button whose words change after a tap).
    @discardableResult
    func waitForLabel(_ element: XCUIElement, _ label: String, timeout: TimeInterval = 8) -> Bool {
        let done = XCTNSPredicateExpectation(predicate: NSPredicate(format: "label == %@", label), object: element)
        return XCTWaiter().wait(for: [done], timeout: timeout) == .completed
    }

    /// Back to the top of the list (the large title).
    func scrollToTop() {
        for _ in 0..<8 { nudge(down: false) }
    }
}
