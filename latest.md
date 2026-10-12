# codex/website-widgets-capture @ 9db1f89

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38281051206 · 2026-10-12 17:28 UTC
Commit: Capture native iPhone Home and Lock widgets [ios-ci] [website-widget-capture]

- Core storage and migrations: success
- Build: success
- Release build: skipped
- Same-build speed baseline: skipped
- UI tests (WebsiteWidgetCaptureUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 2 failures (0 unexpected) in 193.462 (194.001) seconds
	 Executed 2 tests, with 2 failures (0 unexpected) in 193.462 (194.004) seconds
	 Executed 2 tests, with 2 failures (0 unexpected) in 193.462 (194.005) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/WebsiteWidgetCaptureUITests.swift:32: error: -[HabitsUITests.WebsiteWidgetCaptureUITests testHomeScreenCaptures] : XCTAssertTrue failed - Capture fixture finished
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/WebsiteWidgetCaptureUITests.swift:32: error: -[HabitsUITests.WebsiteWidgetCaptureUITests testLockScreenCapture] : XCTAssertTrue failed - Capture fixture finished
Test Case '-[HabitsUITests.WebsiteWidgetCaptureUITests testHomeScreenCaptures]' failed (78.396 seconds).
Test Case '-[HabitsUITests.WebsiteWidgetCaptureUITests testLockScreenCapture]' failed (115.066 seconds).
```
