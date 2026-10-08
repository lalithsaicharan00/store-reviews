# sync-reliability-cloud @ 8ea0d9d

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37769869356 · 2026-10-08 11:59 UTC
Commit: Current Work 66-72: test sync, backup, widgets, timers, reminders and alarms with the fixes [ios-ci] [ios-sync]

- Core storage and migrations: success
- Build: success
- Release build: skipped
- Same-build speed baseline: skipped
- UI tests (SyncUITests,BackupUITests,WidgetUITests,WidgetSystemUITests,TimerUITests,RemindersUITests,PlacementUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 1 test skipped and 1 failure (0 unexpected) in 211.473 (211.487) seconds
	 Executed 27 tests, with 1 test skipped and 1 failure (0 unexpected) in 1136.153 (1136.210) seconds
	 Executed 27 tests, with 1 test skipped and 1 failure (0 unexpected) in 1136.153 (1136.213) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 120.128 (120.134) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 239.559 (239.568) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 278.098 (278.104) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 231.582 (231.595) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/WidgetSystemUITests.swift:116: error: -[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence] : XCTAssertTrue failed - Page 2 after ›: Today, 0 of 13 done | Today | Previous page | Page 2 of 9 | Next page | 0 of 2 cups · Daily limit | Horizontal scroll bar, 1 page | Horizontal scroll bar, 1 page
Test Case '-[HabitsUITests.BackupUITests testAFreeAccountBacksUpToTheServer]' passed (57.712 seconds).
Test Case '-[HabitsUITests.BackupUITests testBackupIntegrityChecks]' passed (7.870 seconds).
Test Case '-[HabitsUITests.BackupUITests testDeletingTheAccountAndErasingThisPhone]' passed (39.163 seconds).
Test Case '-[HabitsUITests.BackupUITests testErasingEverythingWithoutAnAccount]' passed (39.150 seconds).
Test Case '-[HabitsUITests.BackupUITests testExportAndBackupOpenNativeShareSheet]' passed (30.207 seconds).
Test Case '-[HabitsUITests.BackupUITests testFreeBackupPageAndReinstallWarning]' passed (19.330 seconds).
Test Case '-[HabitsUITests.BackupUITests testTheEmptyFirstScreenOffersRestore]' passed (14.274 seconds).
Test Case '-[HabitsUITests.BackupUITests testWithoutAnAccountEverythingStaysOnThePhone]' passed (23.877 seconds).
Test Case '-[HabitsUITests.PlacementUITests testPlacementRules]' passed (8.066 seconds).
Test Case '-[HabitsUITests.RemindersUITests testDeniedPermissionOffersSettingsAndEmptyState]' passed (14.807 seconds).
Test Case '-[HabitsUITests.RemindersUITests testPlanningActionsPermissionsFailuresAndClockChanges]' passed (66.342 seconds).
Test Case '-[HabitsUITests.RemindersUITests testRealEmptyPageHasNoUnexpectedAlarmErrorOrPermissionPrompt]' passed (18.379 seconds).
Test Case '-[HabitsUITests.RemindersUITests testSavedRemindersOpenEditableTaskWithoutPermissionPrompt]' passed (20.601 seconds).
Test Case '-[HabitsUITests.SyncUITests testChangesTravelBetweenThisPhoneAndAnotherDevice]' passed (47.246 seconds).
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (32.632 seconds).
Test Case '-[HabitsUITests.TimerUITests testPlayOpensTimerScreenThatClosesWithoutStopping]' passed (115.707 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (47.546 seconds).
Test Case '-[HabitsUITests.TimerUITests testScreenCanBeTurnedOff]' passed (18.022 seconds).
Test Case '-[HabitsUITests.TimerUITests testTimerScreenPauseKeepsTimeAndResumes]' passed (25.653 seconds).
Test Case '-[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence]' failed (143.969 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' passed (164.964 seconds).
Test Case '-[HabitsUITests.WidgetUITests testGuideAndPrivacyAreFree]' passed (29.510 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLargerTextCountersAndCutDownAreReadable]' passed (35.905 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLongNamesAndUnitsKeepQuickActionVisible]' passed (18.787 seconds).
Test Case '-[HabitsUITests.WidgetUITests testReliabilityUnderBurstsRetriesAndRollover]' passed (19.350 seconds).
Test Case '-[HabitsUITests.WidgetUITests testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks]' passed (9.581 seconds).
```
