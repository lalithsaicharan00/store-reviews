import XCTest

/// Today's section headers: "N left" always, ✓ when done, Start per the rules in
/// "Section Header — Start Button, Left Count and Icons". Screenshots only.
final class SectionHeaderUITests: XCTestCase {
    override func record(_ issue: XCTIssue) {
        let shot = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        shot.name = "FAIL-\(name)"
        shot.lifetime = .keepAlways
        var issue = issue
        issue.add(shot)
        super.record(issue)
    }

    private var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = true
        app = XCUIApplication()
        app.launchArguments = ["-uitest"]
        app.launch()
    }

    private func shot(_ name: String) {
        sleep(1)
        let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    func testHeaders() {
        XCTAssertTrue(app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Start'")).firstMatch.waitForExistence(timeout: 5))
        shot("s01-top")
        app.swipeUp(velocity: .slow)
        shot("s02-scrolled")
        app.swipeUp(velocity: .slow)
        shot("s03-bottom")
        // Fold every open section, then look at the folded headers.
        for _ in 0..<4 {
            let fold = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Fold'")).firstMatch
            guard fold.exists else { break }
            fold.tap(); sleep(1)
        }
        app.swipeDown(velocity: .fast); app.swipeDown(velocity: .fast)
        shot("s04-all-folded")
        // Open a later section: its Start appears, secondary.
        let open = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Open Evening'")).firstMatch
        if open.exists { open.tap(); sleep(1); shot("s05-evening-open") }
    }
}
