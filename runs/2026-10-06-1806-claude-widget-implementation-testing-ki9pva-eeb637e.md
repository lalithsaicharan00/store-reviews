# claude/widget-implementation-testing-ki9pva @ eeb637e

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37505482424 · 2026-10-06 18:06 UTC
Commit: Widgets: the week strip gets its own name (WeekStrip already exists in Progress)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (WidgetUITests,WidgetSystemUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 1 test skipped and 1 failure (0 unexpected) in 270.062 (270.068) seconds
	 Executed 5 tests, with 2 failures (0 unexpected) in 154.278 (154.288) seconds
	 Executed 7 tests, with 1 test skipped and 3 failures (0 unexpected) in 424.340 (424.362) seconds
	 Executed 7 tests, with 1 test skipped and 3 failures (0 unexpected) in 424.340 (424.363) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/WidgetSystemUITests.swift:80: error: -[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence] : XCTAssertTrue failed - The widget shows the committed log
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/WidgetUITests.swift:164: error: -[HabitsUITests.WidgetUITests testLargerTextCountersAndCutDownAreReadable] : XCTAssertTrue failed - Attributes: Application, 0x114e1bc00, pid: 38224, label: 'Often Enough'
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/WidgetUITests.swift:73: error: -[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes] : XCTAssertTrue failed - Attributes: Application, 0x113141b80, pid: 34828, label: 'Often Enough'
Test Case '-[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence]' failed (179.589 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' failed (69.549 seconds).
Test Case '-[HabitsUITests.WidgetUITests testGuideAndPrivacyAreFree]' passed (26.546 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLargerTextCountersAndCutDownAreReadable]' failed (31.182 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLongNamesAndUnitsKeepQuickActionVisible]' passed (17.752 seconds).
Test Case '-[HabitsUITests.WidgetUITests testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks]' passed (9.248 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
