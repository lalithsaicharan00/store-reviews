# claude/shared-habit-rules-ci24 @ 7087be7

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38261613607 · 2026-10-12 16:30 UTC
Commit: Merge remote-tracking branch 'origin/main' into claude/shared-habit-rules-switch

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (WidgetUITests,WidgetSystemUITests,TimerUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 14 tests, with 1 test skipped and 1 failure (0 unexpected) in 647.609 (647.627) seconds
	 Executed 14 tests, with 1 test skipped and 1 failure (0 unexpected) in 647.609 (647.629) seconds
	 Executed 2 tests, with 1 failure (0 unexpected) in 200.199 (200.204) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 166.800 (166.805) seconds
	 Executed 7 tests, with 1 test skipped and 0 failures (0 unexpected) in 280.609 (280.614) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/WidgetSystemUITests.swift:186: error: -[HabitsUITests.WidgetSystemUITests testLockScreenWidgetPickerAvailability] : Failed to get matching snapshots: Lost connection to the application (pid 67340). (Underlying Error: Couldn’t communicate with a helper application. Try your operation again. If that fails, quit and relaunch the application and try again. The connection to service created from an endpoint was invalidated: Failed to check-in, peer may have been unloaded: mach_error=10000003.)
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (63.286 seconds).
Test Case '-[HabitsUITests.TimerUITests testPlayOpensTimerScreenThatClosesWithoutStopping]' passed (35.316 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (31.049 seconds).
Test Case '-[HabitsUITests.TimerUITests testScreenCanBeTurnedOff]' passed (14.915 seconds).
Test Case '-[HabitsUITests.TimerUITests testTimerScreenPauseKeepsTimeAndResumes]' passed (22.234 seconds).
Test Case '-[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence]' passed (129.124 seconds).
Test Case '-[HabitsUITests.WidgetSystemUITests testLockScreenWidgetPickerAvailability]' failed (71.076 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' passed (176.248 seconds).
Test Case '-[HabitsUITests.WidgetUITests testGuideAndPrivacyAreFree]' passed (38.704 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLargerTextCountersAndCutDownAreReadable]' passed (27.915 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLongNamesAndUnitsKeepQuickActionVisible]' passed (15.077 seconds).
Test Case '-[HabitsUITests.WidgetUITests testReliabilityUnderBurstsRetriesAndRollover]' passed (12.793 seconds).
Test Case '-[HabitsUITests.WidgetUITests testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks]' passed (9.659 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
