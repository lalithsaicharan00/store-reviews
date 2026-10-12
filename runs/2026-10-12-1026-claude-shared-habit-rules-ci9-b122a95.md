# claude/shared-habit-rules-ci9 @ b122a95

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38225688872 · 2026-10-12 10:26 UTC
Commit: Current Work 92 (checkpoint 2): a log made before the shared rules' copy is built isn't lost

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (WidgetUITests,WidgetSystemUITests,TimerUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 14 tests, with 1 test skipped and 2 failures (0 unexpected) in 786.128 (786.233) seconds
	 Executed 14 tests, with 1 test skipped and 2 failures (0 unexpected) in 786.128 (786.235) seconds
	 Executed 2 tests, with 1 failure (0 unexpected) in 348.147 (348.217) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 235.122 (235.135) seconds
	 Executed 7 tests, with 1 test skipped and 1 failure (0 unexpected) in 202.858 (202.873) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/WidgetSystemUITests.swift:186: error: -[HabitsUITests.WidgetSystemUITests testLockScreenWidgetPickerAvailability] : Failed to get matching snapshots: Lost connection to the application (pid 64963). (Underlying Error: Couldn’t communicate with a helper application. Try your operation again. If that fails, quit and relaunch the application and try again. connection to service created from an endpoint)
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/WidgetUITests.swift:35: error: -[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes] : Failed to terminate com.oftenenough.app:64639: Failed to terminate com.oftenenough.app:0
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (52.603 seconds).
Test Case '-[HabitsUITests.TimerUITests testPlayOpensTimerScreenThatClosesWithoutStopping]' passed (35.661 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (30.584 seconds).
Test Case '-[HabitsUITests.TimerUITests testScreenCanBeTurnedOff]' passed (35.544 seconds).
Test Case '-[HabitsUITests.TimerUITests testTimerScreenPauseKeepsTimeAndResumes]' passed (80.730 seconds).
Test Case '-[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence]' passed (160.853 seconds).
Test Case '-[HabitsUITests.WidgetSystemUITests testLockScreenWidgetPickerAvailability]' failed (187.294 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' failed (69.349 seconds).
Test Case '-[HabitsUITests.WidgetUITests testGuideAndPrivacyAreFree]' passed (42.813 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLargerTextCountersAndCutDownAreReadable]' passed (34.965 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLongNamesAndUnitsKeepQuickActionVisible]' passed (16.742 seconds).
Test Case '-[HabitsUITests.WidgetUITests testReliabilityUnderBurstsRetriesAndRollover]' passed (21.375 seconds).
Test Case '-[HabitsUITests.WidgetUITests testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks]' passed (12.627 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
