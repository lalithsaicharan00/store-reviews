import XCTest

/// Reminders and alarms on the real iPhone (Current Work 70). The habits come from the app's debug kit
/// (`-reminder-live`, `ReminderLiveTest`); this test only waits on the Home Screen for the real banners and alarms and
/// acts on them as a person would. `REMINDER_PLAN` lists the steps, separated by `|`; each is
/// `<texts the banner shows, comma-separated>:<action>`, where the action is `wait` (only see it arrive), `none`
/// (it must NOT arrive within `REMINDER_ABSENT` seconds), or a button's name to long-press the banner and tap
/// (`Done`, or `+` for an amount's +N); `!Done` taps a button shown on the alert itself (an alarm) without a long press. Each step prints `REMINDER-STEP <step> <arrived|tapped|absent|missing> <unix>`.
/// Run on the iPhone by hand (`-only-testing:HabitsUITests/ReminderDeviceTests`).
final class ReminderDeviceTests: XCTestCase {
    private let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")

    private func note(_ step: String, _ what: String) {
        print("REMINDER-STEP \(step) \(what) \(String(format: "%.3f", Date.now.timeIntervalSince1970))")
        let shot = XCTAttachment(screenshot: XCUIScreen.main.screenshot()); shot.name = "\(step)-\(what)"; shot.lifetime = .keepAlways; add(shot)
    }

    /// The first element on screen whose label holds every text.
    private func banner(_ texts: [String]) -> XCUIElement {
        let format = texts.map { _ in "label CONTAINS %@" }.joined(separator: " AND ")
        return springboard.descendants(matching: .any).matching(NSPredicate(format: format, argumentArray: texts)).firstMatch
    }

    func testPlan() throws {
        let env = ProcessInfo.processInfo.environment
        guard let plan = env["REMINDER_PLAN"] else { throw XCTSkip("No REMINDER_PLAN") }
        let timeout = Double(env["REMINDER_TIMEOUT"] ?? "") ?? 300
        let absent = Double(env["REMINDER_ABSENT"] ?? "") ?? 150
        XCUIDevice.shared.press(.home); Thread.sleep(forTimeInterval: 1)
        for (n, step) in plan.split(separator: "|").enumerated() {
            let parts = step.split(separator: ":", maxSplits: 1).map(String.init)
            let texts = parts[0].split(separator: ",").map(String.init)
            let action = parts.count > 1 ? parts[1] : "wait"
            let name = "\(n + 1)-" + texts.joined(separator: "-").replacingOccurrences(of: " ", with: "_")
            let element = banner(texts)
            if action == "none" {
                note(name, element.waitForExistence(timeout: absent) ? "ARRIVED-BUT-SHOULD-NOT" : "absent")
                continue
            }
            guard element.waitForExistence(timeout: timeout) else { note(name, "missing"); XCTFail("\(texts) never arrived"); continue }
            note(name, "arrived")
            guard action != "wait" else { Thread.sleep(forTimeInterval: 6); continue }
            // "!Done": a button shown on the alert itself (an alarm), tapped without a long press.
            let direct = action.hasPrefix("!")
            let label = direct ? String(action.dropFirst()) : action
            if !direct { element.press(forDuration: 1.2) }
            let button = label == "+"
                ? springboard.buttons.matching(NSPredicate(format: "label BEGINSWITH '+'")).firstMatch
                : springboard.buttons[label].firstMatch
            guard button.waitForExistence(timeout: 5) else { note(name, "no-\(label)-button"); XCTFail("No \(label) on \(texts)"); continue }
            button.tap()
            note(name, "tapped")
            Thread.sleep(forTimeInterval: 3)
        }
        Thread.sleep(forTimeInterval: 15)
        note("end", "done")
    }
}
