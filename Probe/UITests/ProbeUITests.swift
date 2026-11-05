import XCTest

enum Step { case tap(String), tapIndex(String, Int), tapAt(Double, Double), wait(Double), shot(String), swipeUp, swipeDown, type(String) }

struct Shot {
    let name: String
    var variant: String? = nil
    var bundle: String? = nil
    var steps: [Step] = []
}

final class ProbeUITests: XCTestCase {
    override func setUp() { continueAfterFailure = true }

    func testProbes() { for s in Shots.probes { run(s) } }
    func testCalendar() { run(Shots.calendar) }
    func testContacts() { run(Shots.contacts) }
    func testHealth() { run(Shots.health) }
    func testReminders() { run(Shots.reminders) }

    func run(_ s: Shot) {
        let app: XCUIApplication
        if let b = s.bundle { app = XCUIApplication(bundleIdentifier: b) }
        else { app = XCUIApplication(); app.launchArguments = ["-variant", s.variant ?? "index"] }
        app.launch()
        sleep(2)
        dismissWelcome(app)
        snap(s.name, app: s.bundle == nil ? nil : app)
        for st in s.steps {
            switch st {
            case .tap(let id): tap(app, id); sleep(1)
            case .tapIndex(let label, let i):
                _ = label
                let pickers = app.datePickers
                if pickers.count > i { pickers.element(boundBy: i).tap() } else { XCTFail("no date picker \(i)") }
                sleep(1)
            case .tapAt(let x, let y): app.coordinate(withNormalizedOffset: CGVector(dx: x, dy: y)).tap(); sleep(1)
            case .wait(let t): Thread.sleep(forTimeInterval: t)
            case .shot(let n): snap("\(s.name)-\(n)", app: s.bundle == nil ? nil : app)
            case .swipeUp: app.swipeUp(); sleep(1)
            case .swipeDown: app.swipeDown(); sleep(1)
            case .type(let t): app.typeText(t)
            }
        }
        app.terminate()
    }

    func tap(_ app: XCUIApplication, _ id: String) {
        let queries: [XCUIElementQuery] = [app.buttons, app.staticTexts, app.cells, app.otherElements, app.tabBars.buttons, app.images]
        for q in queries {
            let e = q[id].firstMatch
            if e.exists && e.isHittable { e.tap(); return }
        }
        let p = NSPredicate(format: "label CONTAINS[c] %@", id)
        let e = app.descendants(matching: .any).matching(p).firstMatch
        if e.exists { e.tap() } else { XCTFail("no element \(id)") }
    }

    func dismissWelcome(_ app: XCUIApplication) {
        for word in ["Continue", "Not Now", "Get Started", "Allow", "OK", "Done"] {
            let b = app.buttons[word].firstMatch
            if b.exists && b.isHittable { b.tap(); sleep(1) }
        }
    }

    /// Our own screens: a screenshot. Apple's apps: a screenshot kept only in the artifact, and the element tree as text.
    func snap(_ name: String, app: XCUIApplication? = nil) {
        let prefix = app == nil ? "" : "apple-"
        let a = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        a.name = prefix + name
        a.lifetime = .keepAlways
        add(a)
        if let app {
            let t = XCTAttachment(string: app.debugDescription)
            t.name = prefix + name + "-tree"
            t.lifetime = .keepAlways
            add(t)
        }
    }
}
