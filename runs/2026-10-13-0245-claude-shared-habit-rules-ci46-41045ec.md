# claude/shared-habit-rules-ci46 @ 41045ec

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38329445759 · 2026-10-13 02:45 UTC
Commit: Current Work 92 (checkpoint 2): the shared rules are given their inputs without SwiftUI seeing it; the Watch keeps its Swift rules

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (WidgetUITests,WidgetSystemUITests,TimerUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 14 tests, with 2 tests skipped and 0 failures (0 unexpected) in 726.586 (726.607) seconds
	 Executed 14 tests, with 2 tests skipped and 0 failures (0 unexpected) in 726.586 (726.609) seconds
	 Executed 2 tests, with 1 test skipped and 0 failures (0 unexpected) in 152.135 (152.137) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 191.213 (191.225) seconds
	 Executed 7 tests, with 1 test skipped and 0 failures (0 unexpected) in 383.238 (383.243) seconds
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (56.114 seconds).
Test Case '-[HabitsUITests.TimerUITests testPlayOpensTimerScreenThatClosesWithoutStopping]' passed (74.983 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (27.454 seconds).
Test Case '-[HabitsUITests.TimerUITests testScreenCanBeTurnedOff]' passed (15.000 seconds).
Test Case '-[HabitsUITests.TimerUITests testTimerScreenPauseKeepsTimeAndResumes]' passed (17.662 seconds).
Test Case '-[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence]' passed (117.272 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' passed (199.193 seconds).
Test Case '-[HabitsUITests.WidgetUITests testGuideAndPrivacyAreFree]' passed (44.007 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLargerTextCountersAndCutDownAreReadable]' passed (32.098 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLongNamesAndUnitsKeepQuickActionVisible]' passed (57.654 seconds).
Test Case '-[HabitsUITests.WidgetUITests testReliabilityUnderBurstsRetriesAndRollover]' passed (38.948 seconds).
Test Case '-[HabitsUITests.WidgetUITests testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks]' passed (11.141 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
