# claude/widget-implementation-testing-ki9pva @ ea2de5f

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37509097963 · 2026-10-06 18:35 UTC
Commit: Widget UI tests: look for the pager's spoken label, and say on one line what a failing widget showed

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (WidgetUITests,WidgetSystemUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 1 test skipped and 1 failure (0 unexpected) in 185.612 (185.615) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 417.457 (417.463) seconds
	 Executed 7 tests, with 1 test skipped and 1 failure (0 unexpected) in 603.068 (603.081) seconds
	 Executed 7 tests, with 1 test skipped and 1 failure (0 unexpected) in 603.068 (603.083) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/WidgetSystemUITests.swift:97: error: -[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence] : XCTAssertTrue failed - Attributes: Application, 0x10a5b1040, pid: 19481, label: ' '
Test Case '-[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence]' failed (124.387 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' passed (267.126 seconds).
Test Case '-[HabitsUITests.WidgetUITests testGuideAndPrivacyAreFree]' passed (63.337 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLargerTextCountersAndCutDownAreReadable]' passed (58.056 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLongNamesAndUnitsKeepQuickActionVisible]' passed (18.808 seconds).
Test Case '-[HabitsUITests.WidgetUITests testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks]' passed (10.129 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
