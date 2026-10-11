# claude/lucid-johnson-egrjup-ci4 @ d80d397

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38099889413 · 2026-10-11 01:50 UTC
Commit: Widgets faster: week and month totals from the per-day index; the widget lock opened for speed work; App Lock's SE test scrolls to App Passcode

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (WidgetUITests,WidgetSystemUITests,TimerUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 13 tests, with 1 test skipped and 0 failures (0 unexpected) in 817.710 (817.736) seconds
	 Executed 13 tests, with 1 test skipped and 0 failures (0 unexpected) in 817.710 (817.738) seconds
	 Executed 2 tests, with 1 test skipped and 0 failures (0 unexpected) in 276.417 (276.427) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 221.614 (221.622) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 319.678 (319.684) seconds
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (41.989 seconds).
Test Case '-[HabitsUITests.TimerUITests testPlayOpensTimerScreenThatClosesWithoutStopping]' passed (32.969 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (31.678 seconds).
Test Case '-[HabitsUITests.TimerUITests testScreenCanBeTurnedOff]' passed (88.715 seconds).
Test Case '-[HabitsUITests.TimerUITests testTimerScreenPauseKeepsTimeAndResumes]' passed (26.263 seconds).
Test Case '-[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence]' passed (180.922 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' passed (204.285 seconds).
Test Case '-[HabitsUITests.WidgetUITests testGuideAndPrivacyAreFree]' passed (37.416 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLargerTextCountersAndCutDownAreReadable]' passed (30.145 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLongNamesAndUnitsKeepQuickActionVisible]' passed (18.820 seconds).
Test Case '-[HabitsUITests.WidgetUITests testReliabilityUnderBurstsRetriesAndRollover]' passed (19.614 seconds).
Test Case '-[HabitsUITests.WidgetUITests testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks]' passed (9.398 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
