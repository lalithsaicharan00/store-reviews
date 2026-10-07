import XCTest

/// Widget speed on the real iPhone (Current Work 65): flips the pages of the Home Screen's Often Enough Today list and
/// times how long the widget takes to show each flip, with the old week-long timelines and the new short ones side by
/// side in one run (S2). Paging changes no habit data, so it's safe on the person's own widgets. The app is opened only
/// with a debug switch for the timeline length (no test database, no data change). Run on the iPhone by hand
/// (`-only-testing:HabitsUITests/WidgetLatencyDeviceTests`); with no such widget it skips.
final class WidgetLatencyDeviceTests: XCTestCase {
    private let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
    private let app = XCUIApplication(bundleIdentifier: "com.oftenenough.app")

    func testPageFlipToVisibleChange() throws {
        var lines: [String] = []
        let variants = ProcessInfo.processInfo.environment["WIDGET_PAGE_VARIANTS"] == "process"
            ? ["extension", "live", "extension", "live"]
            : ["-widget-week-timeline", "-widget-short-timeline", "-widget-week-timeline", "-widget-short-timeline"]
        for variant in variants {
            app.launchArguments = variant.hasPrefix("-") ? [variant] : ["-widget-page-probe", variant == "live" ? "live" : "off"]
            app.launch()
            Thread.sleep(forTimeInterval: 4) // the launch publishes and the widgets reload with this variant
            app.terminate()
            guard let marker = try findList() else { throw XCTSkip("No Often Enough Today list with pages on the Home Screen") }
            var flips: [String] = []
            for _ in 1...3 {
                flips.append(timed(tap: "Next page", until: { !marker.exists }))
                flips.append(timed(tap: "Previous page", until: { marker.exists }))
            }
            lines.append("\(variant == "-widget-week-timeline" ? "week" : variant == "-widget-short-timeline" ? "short" : variant + " process"): " + flips.joined(separator: " "))
            XCUIDevice.shared.press(.home)
        }
        // Leave the person's widgets on the new timelines.
        app.launchArguments = ["-widget-short-timeline", "-widget-page-probe", "off"]; app.launch(); Thread.sleep(forTimeInterval: 2); app.terminate()
        let report = "Widget page flip → visible change (s): " + lines.joined(separator: " ; ")
        print(report)
        XCTContext.runActivity(named: report) { _ in }
    }

    /// Goes to the Home Screen page holding a Today list with pages, on its first page; returns a button only page 1 has.
    private func findList() throws -> XCUIElement? {
        XCUIDevice.shared.press(.home)
        Thread.sleep(forTimeInterval: 1)
        for _ in 0..<6 {
            if springboard.buttons["Next page"].firstMatch.exists { break }
            springboard.swipeLeft()
        }
        guard springboard.buttons["Next page"].firstMatch.waitForExistence(timeout: 3) else { return nil }
        // Back to the list's first page, then pick a row button only that page has.
        // On the first page "Previous page" is drawn but isn't a button.
        for _ in 0..<10 where springboard.buttons["Previous page"].firstMatch.exists {
            springboard.buttons["Previous page"].firstMatch.tap()
            Thread.sleep(forTimeInterval: 3)
        }
        let rows = springboard.buttons.allElementsBoundByIndex.map(\.label)
            .filter { $0.hasPrefix("Add ") || $0.hasPrefix("Record a slip") || $0.hasPrefix("Mark ") || $0.hasPrefix("Undo ") || $0.hasPrefix("Start ") }
        guard let first = rows.first else { return nil }
        return springboard.buttons[first].firstMatch
    }

    /// Seconds from the tap until `until` holds, checked every 50 ms; "–" if it never did within 20 s.
    private func timed(tap label: String, until done: () -> Bool) -> String {
        let button = springboard.buttons[label].firstMatch
        guard button.waitForExistence(timeout: 5) else { return "(no \(label))" }
        let start = Date.now
        button.tap()
        while Date.now.timeIntervalSince(start) < 20 {
            if done() { return String(format: "%.1f", Date.now.timeIntervalSince(start)) }
            Thread.sleep(forTimeInterval: 0.05)
        }
        return "–"
    }

    /// Real taps on a Small widget's +1 / ✓ (each logs one): does the app come to the front, and how long until the
    /// widget's value changes? First with the app closed, then twice with it in the background. Set `WIDGET_TAP_LABEL`
    /// to the button's label, e.g. "Add 1 to Water".
    func testSmallButtonLogsWithoutOpeningTheApp() throws {
        guard let label = ProcessInfo.processInfo.environment["WIDGET_TAP_LABEL"] else { throw XCTSkip("Set WIDGET_TAP_LABEL") }
        var results: [String] = []
        for round in ["closed", "background", "background"] {
            if round == "closed" { app.terminate() }
            XCUIDevice.shared.press(.home)
            Thread.sleep(forTimeInterval: 3)
            for _ in 0..<6 where !springboard.buttons[label].firstMatch.exists { springboard.swipeLeft() }
            let button = springboard.buttons[label].firstMatch
            guard button.waitForExistence(timeout: 3) else { throw XCTSkip("No \(label) on the Home Screen") }
            let before = springboard.descendants(matching: .any).allElementsBoundByIndex.map(\.label).joined(separator: "|")
            let start = Date.now
            button.tap()
            var changed = "no change in 10 s"
            while Date.now.timeIntervalSince(start) < 10 {
                if app.state == .runningForeground { changed = "THE APP OPENED"; break }
                if springboard.descendants(matching: .any).allElementsBoundByIndex.map(\.label).joined(separator: "|") != before {
                    changed = String(format: "changed in %.1f s", Date.now.timeIntervalSince(start)); break
                }
                Thread.sleep(forTimeInterval: 0.05)
            }
            results.append("\(round): \(changed)")
            Thread.sleep(forTimeInterval: 3)
        }
        let report = "Small \(label): " + results.joined(separator: ", ")
        print(report)
        XCTContext.runActivity(named: report) { _ in }
    }

    /// Which kind of intent survives a Small widget tap without opening the app: the app-process kind (today's log
    /// button) or Apple's default, run in the widget's own process. Both stand-ins change no data. Each is tapped with
    /// the app closed, then again with it suspended in the background.
    func testWhichIntentKindOpensTheApp() throws {
        let label = ProcessInfo.processInfo.environment["WIDGET_TAP_LABEL"] ?? "Add 1 to Water"
        var lines: [String] = []
        let modes = ProcessInfo.processInfo.environment["WIDGET_PROBE_MODES"]?.split(separator: ",").map(String.init)
            ?? ["live", "extension", "live", "extension"]
        for mode in modes {
            app.launchArguments = ["-widget-probe", mode, "-widget-timing", "on"]
            app.launch(); Thread.sleep(forTimeInterval: 4); app.terminate()
            var results: [String] = []
            for round in ["closed", "suspended", "suspended"] {
                XCUIDevice.shared.press(.home); Thread.sleep(forTimeInterval: 2)
                for _ in 0..<6 where !springboard.buttons[label].firstMatch.exists { springboard.swipeLeft() }
                let button = springboard.buttons[label].firstMatch
                guard button.waitForExistence(timeout: 5) else { results.append("\(round): no button"); continue }
                button.tap()
                Thread.sleep(forTimeInterval: 3)
                results.append("\(round): " + (app.state == .runningForeground ? "OPENED APP" : "stayed"))
            }
            lines.append("\(mode): " + results.joined(separator: ", "))
        }
        app.launchArguments = ["-widget-probe", "off"]; app.launch(); Thread.sleep(forTimeInterval: 3); app.terminate()
        let report = "Intent kind vs opening the app (\(label)): " + lines.joined(separator: " ; ")
        print(report)
        XCTContext.runActivity(named: report) { _ in }
    }

    /// What the person sees: real taps on a widget button, timed by screenshots until the pixels of the widget's
    /// value text change (the button's own press highlight is left out). First with the app closed, then with it in
    /// the background. Afterwards the app takes back exactly the widget logs these taps made. `WIDGET_TAP_LABEL` is the
    /// button ("Add 1 to Water"); `WIDGET_VALUE_TEXT` a word in the value line that changes ("glass").
    func testTapToPixelsChange() throws {
        let label = ProcessInfo.processInfo.environment["WIDGET_TAP_LABEL"] ?? "Add 1 to Water"
        let word = ProcessInfo.processInfo.environment["WIDGET_VALUE_TEXT"] ?? "glass"
        let began = Date.now.addingTimeInterval(-1)
        if ProcessInfo.processInfo.environment["WIDGET_TIMING"] == "on" {
            app.launchArguments = ["-widget-timing", "on"]; app.launch(); Thread.sleep(forTimeInterval: 3); app.terminate()
        }
        var results: [String] = []
        for round in ["closed", "background", "background", "closed", "background"] {
            if round == "closed" { app.terminate() }
            XCUIDevice.shared.press(.home)
            Thread.sleep(forTimeInterval: 3)
            for _ in 0..<6 where !springboard.buttons[label].firstMatch.exists { springboard.swipeLeft() }
            let button = springboard.buttons[label].firstMatch
            guard button.waitForExistence(timeout: 3) else { throw XCTSkip("No \(label) on the Home Screen") }
            let value = springboard.staticTexts.matching(NSPredicate(format: "label CONTAINS %@", word)).firstMatch
            guard value.exists else { throw XCTSkip("No text containing \(word)") }
            let scale = XCUIScreen.main.screenshot().image.scale
            func crop(_ frame: CGRect) -> CGRect {
                CGRect(x: frame.minX * scale, y: frame.minY * scale, width: frame.width * scale, height: frame.height * scale)
            }
            let valueCrop = crop(value.frame), buttonCrop = crop(button.frame)
            func pixels(_ shot: CGImage?, _ area: CGRect) -> Data? {
                guard let image = shot?.cropping(to: area), let data = image.dataProvider?.data else { return nil }
                return data as Data
            }
            let first = XCUIScreen.main.screenshot().image.cgImage
            let valueBefore = pixels(first, valueCrop), buttonBefore = pixels(first, buttonCrop)
            let start = Date.now
            button.tap()
            // XCUITest's own tap (touch down, up, waiting for idle) is part of the time: reported so it can be subtracted.
            let tapCall = Date.now.timeIntervalSince(start)
            var buttonChanged = "no change", valueChanged = "no change in 8 s"
            while Date.now.timeIntervalSince(start) < 8 {
                if app.state == .runningForeground { valueChanged = "THE APP OPENED"; break }
                let shot = XCUIScreen.main.screenshot().image.cgImage
                let elapsed = String(format: "%.2f s", Date.now.timeIntervalSince(start))
                if buttonChanged == "no change", let now = pixels(shot, buttonCrop), now != buttonBefore { buttonChanged = elapsed }
                if let now = pixels(shot, valueCrop), now != valueBefore { valueChanged = elapsed; break }
            }
            let clock = DateFormatter(); clock.dateFormat = "HH:mm:ss.SSS"
            results.append("\(round) tapped \(clock.string(from: start)): button \(buttonChanged), number \(valueChanged) (tap call \(String(format: "%.2f", tapCall)) s)")
            Thread.sleep(forTimeInterval: 2)
        }
        app.launchArguments = ["-undo-widget-logs-since", String(began.timeIntervalSince1970)]
        app.launch(); Thread.sleep(forTimeInterval: 4); app.terminate()
        let report = "Tap → widget pixels change (\(label)): " + results.joined(separator: ", ")
        print(report)
        XCTContext.runActivity(named: report) { _ in }
    }

    /// Pictures of a widget after one real tap (0.3, 1, 2 and 5 s), so what the switch shows can be seen, not inferred.
    /// The app then takes back the widget logs it made.
    func testPicturesAfterATap() throws {
        let label = ProcessInfo.processInfo.environment["WIDGET_TAP_LABEL"] ?? "Add 1 to Water"
        let began = Date.now.addingTimeInterval(-1)
        XCUIDevice.shared.press(.home); Thread.sleep(forTimeInterval: 2)
        for _ in 0..<6 where !springboard.buttons[label].firstMatch.exists { springboard.swipeLeft() }
        let button = springboard.buttons[label].firstMatch
        guard button.waitForExistence(timeout: 3) else { throw XCTSkip("No \(label)") }
        func save(_ name: String) {
            let shot = XCTAttachment(screenshot: XCUIScreen.main.screenshot()); shot.name = name; shot.lifetime = .keepAlways; add(shot)
        }
        save("0-before")
        let start = Date.now
        button.tap()
        for (name, at) in [("1-0.3s", 0.3), ("2-1s", 1.0), ("3-2s", 2.0), ("4-5s", 5.0)] {
            let wait = at - Date.now.timeIntervalSince(start)
            if wait > 0 { Thread.sleep(forTimeInterval: wait) }
            save(name)
        }
        app.launchArguments = ["-undo-widget-logs-since", String(began.timeIntervalSince1970)]
        app.launch(); Thread.sleep(forTimeInterval: 4); app.terminate()
    }

    /// Quick runs of taps (Current Work 66): a ✓ tapped twice fast (ends unticked, as the switch shows) and a + tapped
    /// three times fast (three logs). Pictures at 0.3 s after each run and once the widget has caught up. The app then
    /// takes back the widget logs the test made.
    func testQuickRepeatedTaps() throws {
        let check = ProcessInfo.processInfo.environment["WIDGET_CHECK_LABEL"] ?? "Mark Meds done"
        let plusLabel = ProcessInfo.processInfo.environment["WIDGET_TAP_LABEL"] ?? "Add 1 to Water"
        let began = Date.now.addingTimeInterval(-1)
        XCUIDevice.shared.press(.home); Thread.sleep(forTimeInterval: 2)
        for _ in 0..<6 where !springboard.buttons[check].firstMatch.exists { springboard.swipeLeft() }
        func save(_ name: String) {
            let shot = XCTAttachment(screenshot: XCUIScreen.main.screenshot()); shot.name = name; shot.lifetime = .keepAlways; add(shot)
        }
        save("0-before")
        let tick = springboard.buttons[check].firstMatch
        guard tick.waitForExistence(timeout: 3) else { throw XCTSkip("No \(check)") }
        tick.tap(); save("1-check-once")
        // The same switch again (its name now says Undo), straight away.
        springboard.buttons.matching(NSPredicate(format: "label == %@ OR label BEGINSWITH 'Undo '", check)).firstMatch.tap()
        save("2-check-twice")
        let plus = springboard.buttons[plusLabel].firstMatch
        plus.tap(); plus.tap(); plus.tap()
        save("3-plus-three-times")
        Thread.sleep(forTimeInterval: 8)
        save("4-caught-up")
        app.launchArguments = ["-undo-widget-logs-since", String(began.timeIntervalSince1970)]
        app.launch(); Thread.sleep(forTimeInterval: 4); app.terminate()
        XCUIDevice.shared.press(.home); Thread.sleep(forTimeInterval: 2)
        for _ in 0..<6 where !springboard.buttons[check].firstMatch.exists { springboard.swipeLeft() }
        Thread.sleep(forTimeInterval: 4)
        save("5-after-cleanup")
    }

    /// A widget link replaces whatever was open (Current Work 66): the timer, then a checklist's Day details, then a log
    /// sheet, then the timer again, each opened from the Home Screen the way a widget opens it. Opening a timer without
    /// `?start=1` only shows it, so nothing is saved. IDs: `WIDGET_TIMER_ID`, `WIDGET_STEPS_ID`, `WIDGET_LOG_ID`.
    func testLinksReplaceWhatWasOpen() throws {
        let env = ProcessInfo.processInfo.environment
        guard let timer = env["WIDGET_TIMER_ID"], let steps = env["WIDGET_STEPS_ID"], let log = env["WIDGET_LOG_ID"] else {
            throw XCTSkip("Set WIDGET_TIMER_ID, WIDGET_STEPS_ID and WIDGET_LOG_ID")
        }
        func save(_ name: String) {
            let shot = XCTAttachment(screenshot: XCUIScreen.main.screenshot()); shot.name = name; shot.lifetime = .keepAlways; add(shot)
        }
        for (i, link) in ["timer/" + timer, "item/" + steps, "log/" + log, "timer/" + timer].enumerated() {
            XCUIDevice.shared.press(.home); Thread.sleep(forTimeInterval: 1.5)
            XCUIDevice.shared.system.open(URL(string: "oftenenough://" + link)!)
            // iOS may ask to open the app the first time.
            let openButton = springboard.buttons["Open"]
            if openButton.waitForExistence(timeout: 1.5) { openButton.tap() }
            Thread.sleep(forTimeInterval: 2.5)
            save("\(i)-" + link.split(separator: "/")[0])
        }
        app.terminate()
    }

    /// The whole card at once (Current Work 66): one tap each on a Small ✓, a Small + and a list row's button, with
    /// pictures 0.3 s after each tap and once the app has caught up. The app then takes back the logs the test made.
    func testWholeCardChangesAtOnce() throws {
        let began = Date.now.addingTimeInterval(-1)
        func save(_ name: String) {
            let shot = XCTAttachment(screenshot: XCUIScreen.main.screenshot()); shot.name = name; shot.lifetime = .keepAlways; add(shot)
        }
        XCUIDevice.shared.press(.home); Thread.sleep(forTimeInterval: 2)
        for _ in 0..<6 where !springboard.buttons["Mark Meds done"].firstMatch.exists { springboard.swipeLeft() }
        save("0-before")
        springboard.buttons["Mark Meds done"].firstMatch.tap(); Thread.sleep(forTimeInterval: 0.3); save("1-meds-0.3s")
        springboard.buttons["Add 1 to Water"].firstMatch.tap(); Thread.sleep(forTimeInterval: 0.3); save("2-water-0.3s")
        // A list row: the Today list's next page, then its first ✓ or +.
        if springboard.buttons["Next page"].firstMatch.exists {
            springboard.buttons["Next page"].firstMatch.tap(); Thread.sleep(forTimeInterval: 2.5); save("3-list-page")
            let listTop = springboard.buttons["Next page"].firstMatch.frame.minY
            let row = springboard.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Mark ' OR label BEGINSWITH 'Add '"))
                .allElementsBoundByIndex.first { $0.frame.minY > listTop && $0.frame.minY < listTop + 140 }
            if let row { row.tap(); Thread.sleep(forTimeInterval: 0.3); save("4-list-row-0.3s") }
        }
        Thread.sleep(forTimeInterval: 6); save("5-caught-up")
        app.launchArguments = ["-undo-widget-logs-since", String(began.timeIntervalSince1970)]
        app.launch(); Thread.sleep(forTimeInterval: 4); app.terminate()
        XCUIDevice.shared.press(.home); Thread.sleep(forTimeInterval: 2)
        for _ in 0..<6 where !springboard.buttons["Mark Meds done"].firstMatch.exists { springboard.swipeLeft() }
        if springboard.buttons["Previous page"].firstMatch.exists { springboard.buttons["Previous page"].firstMatch.tap() }
        Thread.sleep(forTimeInterval: 4); save("6-after-cleanup")
    }

    /// A list row's tap (Current Work 66): pages through the Today list to a row with an unticked ✓, taps it, and takes
    /// pictures at 0.3 s and once caught up. The app then takes the log back and the list returns to its first page.
    func testListRowChangesAtOnce() throws {
        let began = Date.now.addingTimeInterval(-1)
        func save(_ name: String) {
            let shot = XCTAttachment(screenshot: XCUIScreen.main.screenshot()); shot.name = name; shot.lifetime = .keepAlways; add(shot)
        }
        XCUIDevice.shared.press(.home); Thread.sleep(forTimeInterval: 2)
        for _ in 0..<6 where !springboard.buttons["Next page"].firstMatch.exists { springboard.swipeLeft() }
        var target: XCUIElement?
        for _ in 0..<14 {
            let top = springboard.buttons["Next page"].firstMatch.frame.minY
            target = springboard.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Mark '")).allElementsBoundByIndex
                .first { $0.frame.minY > top && $0.frame.minY < top + 150 }
            if target != nil || !springboard.buttons["Next page"].firstMatch.exists { break }
            springboard.buttons["Next page"].firstMatch.tap(); Thread.sleep(forTimeInterval: 2.5)
        }
        guard let target else { throw XCTSkip("No unticked ✓ in the Today list") }
        save("0-before")
        // The row's round button, by where it is: the name's line, at the row's right edge.
        let name = String(target.label.dropFirst(5).dropLast(5))
        let top = springboard.buttons["Next page"].firstMatch.frame.minY
        let text = springboard.staticTexts.matching(NSPredicate(format: "label == %@", name)).allElementsBoundByIndex
            .first { $0.frame.minY > top && $0.frame.minY < top + 150 }
        guard let text else { throw XCTSkip("No row text for \(name)") }
        let point = CGPoint(x: target.frame.maxX - 22, y: text.frame.midY + 9)
        let button = springboard.coordinate(withNormalizedOffset: .zero).withOffset(CGVector(dx: point.x, dy: point.y))
        button.tap()
        Thread.sleep(forTimeInterval: 0.3); save("1-row-0.3s")
        if ProcessInfo.processInfo.environment["WIDGET_TAP_TWICE"] != nil {
            button.tap(); Thread.sleep(forTimeInterval: 0.3); save("1b-row-again-0.3s")
        }
        Thread.sleep(forTimeInterval: 6); save("2-caught-up")
        app.launchArguments = ["-undo-widget-logs-since", String(began.timeIntervalSince1970)]
        app.launch(); Thread.sleep(forTimeInterval: 4); app.terminate()
        XCUIDevice.shared.press(.home); Thread.sleep(forTimeInterval: 2)
        for _ in 0..<6 where !springboard.buttons["Next page"].firstMatch.exists { springboard.swipeLeft() }
        for _ in 0..<14 where springboard.buttons["Previous page"].firstMatch.exists {
            springboard.buttons["Previous page"].firstMatch.tap(); Thread.sleep(forTimeInterval: 1.5)
        }
        Thread.sleep(forTimeInterval: 2); save("3-after-cleanup")
    }

    /// Quick + taps move on (Current Work 66): Water's + three times, a picture 0.3 s after each; then a list row's ▶
    /// (Stretch) started and stopped from the widget, with pictures. The app then takes back what the test made.
    func testQuickPlusAndTimer() throws {
        let began = Date.now.addingTimeInterval(-1)
        func save(_ name: String) {
            let shot = XCTAttachment(screenshot: XCUIScreen.main.screenshot()); shot.name = name; shot.lifetime = .keepAlways; add(shot)
        }
        XCUIDevice.shared.press(.home); Thread.sleep(forTimeInterval: 2)
        for _ in 0..<6 where !springboard.buttons["Add 1 to Water"].firstMatch.exists { springboard.swipeLeft() }
        save("0-before")
        // The + by position: after the first tap the switch's inner card answers the next one.
        let water = springboard.buttons["Add 1 to Water"].firstMatch.frame
        let plus = springboard.coordinate(withNormalizedOffset: .zero).withOffset(CGVector(dx: water.maxX - 38, dy: water.minY + 38))
        for i in 1...3 { plus.tap(); Thread.sleep(forTimeInterval: 0.3); save("\(i)-plus-\(i)") }
        // Stretch's ▶ on the Today list.
        for _ in 0..<14 where !springboard.buttons["Start Stretch timer"].firstMatch.exists && springboard.buttons["Next page"].firstMatch.exists {
            springboard.buttons["Next page"].firstMatch.tap(); Thread.sleep(forTimeInterval: 2)
        }
        if ProcessInfo.processInfo.environment["WIDGET_SKIP_TIMER"] == nil, springboard.buttons["Start Stretch timer"].firstMatch.exists {
            let play = springboard.buttons["Start Stretch timer"].firstMatch.frame
            let point = springboard.coordinate(withNormalizedOffset: .zero).withOffset(CGVector(dx: play.midX, dy: play.midY))
            save("4-timer-before")
            point.tap(); Thread.sleep(forTimeInterval: 0.3); save("5-timer-started-0.3s")
            Thread.sleep(forTimeInterval: 3); save("6-timer-running-3s")
            point.tap(); Thread.sleep(forTimeInterval: 0.3); save("7-timer-stopped-0.3s")
        }
        Thread.sleep(forTimeInterval: 6); save("8-caught-up")
        app.launchArguments = ["-undo-widget-logs-since", String(began.timeIntervalSince1970)]
        app.launch(); Thread.sleep(forTimeInterval: 4); app.terminate()
        XCUIDevice.shared.press(.home); Thread.sleep(forTimeInterval: 2)
        for _ in 0..<6 where !springboard.buttons["Add 1 to Water"].firstMatch.exists { springboard.swipeLeft() }
        for _ in 0..<14 where springboard.buttons["Previous page"].firstMatch.exists {
            springboard.buttons["Previous page"].firstMatch.tap(); Thread.sleep(forTimeInterval: 1.5)
        }
        Thread.sleep(forTimeInterval: 2); save("9-after-cleanup")
    }

    /// A picture of one habit's list row (`WIDGET_ROW_NAME`), paging the Today list to it; no habit is tapped.
    func testPictureOfRow() throws {
        let name = ProcessInfo.processInfo.environment["WIDGET_ROW_NAME"] ?? "Call family"
        XCUIDevice.shared.press(.home); Thread.sleep(forTimeInterval: 2)
        for _ in 0..<6 where !springboard.buttons["Next page"].firstMatch.exists { springboard.swipeLeft() }
        for _ in 0..<14 where !springboard.staticTexts[name].firstMatch.exists && !springboard.buttons["Add 1 to " + name].firstMatch.exists && !springboard.buttons["Log an amount for " + name].firstMatch.exists && springboard.buttons["Next page"].firstMatch.exists {
            springboard.buttons["Next page"].firstMatch.tap(); Thread.sleep(forTimeInterval: 1.5)
        }
        Thread.sleep(forTimeInterval: 1.5)
        let shot = XCTAttachment(screenshot: XCUIScreen.main.screenshot()); shot.name = "row"; shot.lifetime = .keepAlways; add(shot)
        for _ in 0..<14 where springboard.buttons["Previous page"].firstMatch.exists {
            springboard.buttons["Previous page"].firstMatch.tap(); Thread.sleep(forTimeInterval: 1.2)
        }
    }

    /// An earlier widget's log sheet never comes back (the user, 8 Oct 2026): a log link, home, a checklist's Day details
    /// link, then Close; the app must show Today, not the old log sheet. Nothing is saved.
    func testOldLogSheetDoesNotComeBack() throws {
        let env = ProcessInfo.processInfo.environment
        guard let steps = env["WIDGET_STEPS_ID"], let log = env["WIDGET_LOG_ID"] else { throw XCTSkip("Set WIDGET_STEPS_ID and WIDGET_LOG_ID") }
        func save(_ name: String) {
            let shot = XCTAttachment(screenshot: XCUIScreen.main.screenshot()); shot.name = name; shot.lifetime = .keepAlways; add(shot)
        }
        for (i, link) in ["log/" + log, "item/" + steps].enumerated() {
            XCUIDevice.shared.press(.home); Thread.sleep(forTimeInterval: 1.5)
            XCUIDevice.shared.system.open(URL(string: "oftenenough://" + link)!)
            if springboard.buttons["Open"].waitForExistence(timeout: 1.5) { springboard.buttons["Open"].tap() }
            Thread.sleep(forTimeInterval: 2.5)
            save("\(i)-" + link.split(separator: "/")[0])
        }
        app.buttons["Close"].firstMatch.tap()
        Thread.sleep(forTimeInterval: 2)
        save("2-after-close")
        XCTAssertFalse(app.staticTexts["Add log"].exists, "The earlier log sheet came back")
        app.terminate()
    }

    /// Logged in the app, then straight back to the Home Screen (the user, 8 Oct 2026): pictures of the widgets 0.5, 1
    /// and 2 s after leaving. The app then takes back the one log the test made.
    func testWidgetFollowsTheAppAtOnce() throws {
        let label = ProcessInfo.processInfo.environment["APP_TAP_LABEL"] ?? "Add 1 to Water"
        func save(_ name: String) {
            let shot = XCTAttachment(screenshot: XCUIScreen.main.screenshot()); shot.name = name; shot.lifetime = .keepAlways; add(shot)
        }
        XCUIDevice.shared.press(.home); Thread.sleep(forTimeInterval: 1.5)
        for _ in 0..<6 where !springboard.buttons["Add 1 to Water"].firstMatch.exists { springboard.swipeLeft() }
        save("0-widget-before")
        app.launchArguments = []
        app.activate()
        let button = app.buttons[label].firstMatch
        for _ in 0..<6 where !button.isHittable { app.swipeUp() }
        guard button.waitForExistence(timeout: 5) else { throw XCTSkip("No \(label) in the app") }
        let began = Date.now.addingTimeInterval(-1)
        button.tap()
        XCUIDevice.shared.press(.home)
        let left = Date.now
        for (name, at) in [("1-0.5s", 0.5), ("2-1s", 1.0), ("3-2s", 2.0)] {
            let wait = at - Date.now.timeIntervalSince(left)
            if wait > 0 { Thread.sleep(forTimeInterval: wait) }
            save(name)
        }
        app.launchArguments = ["-undo-widget-logs-since", String(began.timeIntervalSince1970), "-undo-any-source"]
        app.launch(); Thread.sleep(forTimeInterval: 4); app.terminate()
    }
}
