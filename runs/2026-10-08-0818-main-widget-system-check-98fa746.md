# main-widget-system-check @ 98fa746

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37746030895 · 2026-10-08 08:18 UTC
Commit: Scratch (safe to delete): WidgetSystemUITests on main's widget code, to check two failures seen on sync-outside-app [ios-ci] [ios-widgets-recheck]

- Core storage and migrations: success
- Build: success
- Release build: skipped
- Same-build speed baseline: skipped
- UI tests (WidgetUITests,WidgetSystemUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 1 test skipped and 1 failure (0 unexpected) in 257.839 (257.845) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 288.520 (288.525) seconds
	 Executed 8 tests, with 1 test skipped and 1 failure (0 unexpected) in 546.359 (546.373) seconds
	 Executed 8 tests, with 1 test skipped and 1 failure (0 unexpected) in 546.359 (546.374) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/WidgetSystemUITests.swift:99: error: -[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence] : failed - The widget didn't show the committed log. Widget: . App: Widget system: no durable widget log · intent not dispatched
Test Case '-[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence]' failed (160.824 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' passed (172.389 seconds).
Test Case '-[HabitsUITests.WidgetUITests testGuideAndPrivacyAreFree]' passed (23.888 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLargerTextCountersAndCutDownAreReadable]' passed (32.031 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLongNamesAndUnitsKeepQuickActionVisible]' passed (25.076 seconds).
Test Case '-[HabitsUITests.WidgetUITests testReliabilityUnderBurstsRetriesAndRollover]' passed (24.449 seconds).
Test Case '-[HabitsUITests.WidgetUITests testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks]' passed (10.687 seconds).
```
