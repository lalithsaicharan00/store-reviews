# claude/widget-implementation-testing-ki9pva @ 0b1009f

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37512708872 · 2026-10-06 19:02 UTC
Commit: Widget system test: page once the rows settle, and say on one line what the widget shows when paging fails

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (WidgetUITests,WidgetSystemUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 1 test skipped and 1 failure (0 unexpected) in 323.893 (323.898) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 261.038 (261.044) seconds
	 Executed 8 tests, with 1 test skipped and 1 failure (0 unexpected) in 584.931 (584.945) seconds
	 Executed 8 tests, with 1 test skipped and 1 failure (0 unexpected) in 584.931 (584.946) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/WidgetSystemUITests.swift:95: error: -[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence] : Failed to get matching snapshot: No matches found for Element at index 227 from input {(
Test Case '-[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence]' failed (225.613 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' passed (168.952 seconds).
Test Case '-[HabitsUITests.WidgetUITests testGuideAndPrivacyAreFree]' passed (21.511 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLargerTextCountersAndCutDownAreReadable]' passed (28.345 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLongNamesAndUnitsKeepQuickActionVisible]' passed (16.970 seconds).
Test Case '-[HabitsUITests.WidgetUITests testReliabilityUnderBurstsRetriesAndRollover]' passed (16.518 seconds).
Test Case '-[HabitsUITests.WidgetUITests testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks]' passed (8.743 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
