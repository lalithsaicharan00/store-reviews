# codex/website-widgets-capture @ e1772a0

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38342664113 · 2026-10-13 04:52 UTC
Commit: Capture configured native widgets after opening Morning [ios-ci] [website-widget-capture]

- Core storage and migrations: skipped
- Build: success
- Release build: skipped
- Same-build speed baseline: skipped
- UI tests (WebsiteWidgetCaptureUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 2 failures (0 unexpected) in 176.124 (176.129) seconds
	 Executed 2 tests, with 2 failures (0 unexpected) in 176.124 (176.137) seconds
	 Executed 2 tests, with 2 failures (0 unexpected) in 176.124 (176.139) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/WebsiteWidgetCaptureUITests.swift:165: error: -[HabitsUITests.WebsiteWidgetCaptureUITests testLockScreenCapture] : failed - Native Lock Screen gallery does not expose Often Enough
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/WebsiteWidgetCaptureUITests.swift:53: error: -[HabitsUITests.WebsiteWidgetCaptureUITests testHomeScreenCaptures] : XCTAssertTrue failed - Home Screen Add Widget available
Test Case '-[HabitsUITests.WebsiteWidgetCaptureUITests testHomeScreenCaptures]' failed (89.263 seconds).
Test Case '-[HabitsUITests.WebsiteWidgetCaptureUITests testLockScreenCapture]' failed (86.862 seconds).
```
