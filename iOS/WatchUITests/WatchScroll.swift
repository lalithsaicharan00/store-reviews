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
        from.press(forDuration: 0.05, thenDragTo: to)
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

    /// Back to the top of the list (the large title).
    func scrollToTop() {
        for _ in 0..<8 { nudge(down: false) }
    }
}
