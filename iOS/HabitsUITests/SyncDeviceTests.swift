import XCTest

/// Sync on the real iPhone (Current Work 67): taps the person's own Home Screen widgets and Today rows, then waits
/// with the app closed or in the background, so the dev server's logs show whether each change reached the server
/// without the app being opened. Each step prints `SYNC-STEP <name> <unix time>` to match against the server's logs.
/// Changes the person's own data: take it back afterwards with `-undo-widget-logs-since <first time> -undo-any-source`.
/// Run on the iPhone by hand (`-only-testing:HabitsUITests/SyncDeviceTests/<test>`); needs a signed-in Plus account.
final class SyncDeviceTests: XCTestCase {
    private let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
    private let app = XCUIApplication(bundleIdentifier: "com.oftenenough.app")
    private var wait: TimeInterval { Double(ProcessInfo.processInfo.environment["SYNC_WAIT"] ?? "") ?? 25 }

    private func step(_ name: String) {
        print("SYNC-STEP \(name) \(String(format: "%.3f", Date.now.timeIntervalSince1970))")
        let shot = XCTAttachment(screenshot: XCUIScreen.main.screenshot()); shot.name = name; shot.lifetime = .keepAlways; add(shot)
    }

    private func homeScreen(showing label: String) {
        XCUIDevice.shared.press(.home); Thread.sleep(forTimeInterval: 2)
        for _ in 0..<6 where !springboard.buttons[label].firstMatch.exists { springboard.swipeLeft() }
    }

    /// Widget taps with the app closed: one +, one ✓, then a quick run of five +. Each is followed by a wait with the
    /// app never opened; the server must receive each change within seconds, and the run of five as one or two requests.
    func testWidgetTapsWithTheAppClosed() throws {
        app.terminate()
        homeScreen(showing: "Add 1 to Water")
        guard springboard.buttons["Add 1 to Water"].firstMatch.exists else { throw XCTSkip("No Water widget") }
        let water = springboard.buttons["Add 1 to Water"].firstMatch.frame
        let plus = springboard.coordinate(withNormalizedOffset: .zero).withOffset(CGVector(dx: water.maxX - 38, dy: water.minY + 38))
        step("0-start")
        plus.tap(); step("1-water-plus")
        Thread.sleep(forTimeInterval: wait); step("2-after-wait")
        if springboard.buttons["Mark Meds done"].firstMatch.exists || springboard.buttons["Meds"].firstMatch.exists {
            let meds = springboard.buttons["Mark Meds done"].firstMatch.exists ? springboard.buttons["Mark Meds done"].firstMatch.frame : springboard.buttons["Meds"].firstMatch.frame
            springboard.coordinate(withNormalizedOffset: .zero).withOffset(CGVector(dx: meds.maxX - 38, dy: meds.minY + 38)).tap()
            step("3-meds-check")
            Thread.sleep(forTimeInterval: wait); step("4-after-wait")
        }
        for i in 1...5 { plus.tap(); Thread.sleep(forTimeInterval: 0.3); if i == 1 { step("5-burst-start") } }
        step("6-burst-end")
        Thread.sleep(forTimeInterval: wait); step("7-after-wait")
        XCTAssertFalse(app.state == .runningForeground, "The app came to the front")
    }

    /// In the app: one tap then a wait in front; a run of ten quick taps (one request expected after the quiet period);
    /// then a tap followed at once by going to the Home Screen (the change must still reach the server).
    func testAppTapsInFrontAndLeaving() throws {
        app.launchArguments = []
        app.launch()
        // Done rows sink after the pause (U13), so the row is found again before each step.
        // A habit far from its goal, so its row doesn't move: `SYNC_HABIT` (default "Test", +100 toward 999).
        let name = ProcessInfo.processInfo.environment["SYNC_HABIT"] ?? "Test"
        func water() throws -> XCUIElement {
            let button = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Add ' AND label ENDSWITH %@", " to \(name)")).firstMatch
            _ = button.waitForExistence(timeout: 5)
            for _ in 0..<8 where !(button.exists && button.isHittable) { app.swipeDown() }
            for _ in 0..<12 where !(button.exists && button.isHittable) { app.swipeUp() }
            guard button.exists, button.isHittable else { throw XCTSkip("No \(name) row on Today") }
            return button
        }
        var button = try water()
        Thread.sleep(forTimeInterval: 5)
        step("0-start")
        button.tap(); step("1-one-tap")
        Thread.sleep(forTimeInterval: 10); step("2-after-wait")
        button = try water()
        for i in 1...10 { button.tap(); if i == 1 { step("3-burst-start") } }
        step("4-burst-end")
        Thread.sleep(forTimeInterval: 15); step("5-after-wait")
        button = try water()
        button.tap(); XCUIDevice.shared.press(.home); step("6-tap-then-home")
        Thread.sleep(forTimeInterval: wait); step("7-after-wait")
    }
}
