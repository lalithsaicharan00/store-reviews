# sync-reliability-cloud @ 27ce48c

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37784250768 · 2026-10-08 13:56 UTC
Commit: Current Work 66-72: test sync, backup, widgets, timers, reminders and alarms [ios-ci] [ios-sync]

- Core storage and migrations: success
- Build: success
- Release build: skipped
- Same-build speed baseline: skipped
- UI tests (SyncUITests,BackupUITests,WidgetUITests,WidgetSystemUITests,TimerUITests,RemindersUITests,PlacementUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 1 test skipped and 0 failures (0 unexpected) in 173.306 (173.310) seconds
	 Executed 27 tests, with 1 test skipped and 0 failures (0 unexpected) in 878.858 (878.892) seconds
	 Executed 27 tests, with 1 test skipped and 0 failures (0 unexpected) in 878.858 (878.894) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 88.669 (88.673) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 112.975 (112.978) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 239.556 (239.563) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 226.952 (226.960) seconds
Test Case '-[HabitsUITests.BackupUITests testAFreeAccountBacksUpToTheServer]' passed (67.136 seconds).
Test Case '-[HabitsUITests.BackupUITests testBackupIntegrityChecks]' passed (29.233 seconds).
Test Case '-[HabitsUITests.BackupUITests testDeletingTheAccountAndErasingThisPhone]' passed (33.358 seconds).
Test Case '-[HabitsUITests.BackupUITests testErasingEverythingWithoutAnAccount]' passed (23.507 seconds).
Test Case '-[HabitsUITests.BackupUITests testExportAndBackupOpenNativeShareSheet]' passed (26.463 seconds).
Test Case '-[HabitsUITests.BackupUITests testFreeBackupPageAndReinstallWarning]' passed (13.937 seconds).
Test Case '-[HabitsUITests.BackupUITests testTheEmptyFirstScreenOffersRestore]' passed (14.538 seconds).
Test Case '-[HabitsUITests.BackupUITests testWithoutAnAccountEverythingStaysOnThePhone]' passed (18.780 seconds).
Test Case '-[HabitsUITests.PlacementUITests testPlacementRules]' passed (7.887 seconds).
Test Case '-[HabitsUITests.RemindersUITests testDeniedPermissionOffersSettingsAndEmptyState]' passed (12.379 seconds).
Test Case '-[HabitsUITests.RemindersUITests testPlanningActionsPermissionsFailuresAndClockChanges]' passed (46.650 seconds).
Test Case '-[HabitsUITests.RemindersUITests testRealEmptyPageHasNoUnexpectedAlarmErrorOrPermissionPrompt]' passed (12.697 seconds).
Test Case '-[HabitsUITests.RemindersUITests testSavedRemindersOpenEditableTaskWithoutPermissionPrompt]' passed (16.944 seconds).
Test Case '-[HabitsUITests.SyncUITests testChangesTravelBetweenThisPhoneAndAnotherDevice]' passed (29.513 seconds).
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (30.470 seconds).
Test Case '-[HabitsUITests.TimerUITests testPlayOpensTimerScreenThatClosesWithoutStopping]' passed (29.780 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (24.259 seconds).
Test Case '-[HabitsUITests.TimerUITests testScreenCanBeTurnedOff]' passed (10.331 seconds).
Test Case '-[HabitsUITests.TimerUITests testTimerScreenPauseKeepsTimeAndResumes]' passed (18.135 seconds).
Test Case '-[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence]' passed (115.097 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' passed (144.554 seconds).
Test Case '-[HabitsUITests.WidgetUITests testGuideAndPrivacyAreFree]' passed (25.138 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLargerTextCountersAndCutDownAreReadable]' passed (31.029 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLongNamesAndUnitsKeepQuickActionVisible]' passed (16.023 seconds).
Test Case '-[HabitsUITests.WidgetUITests testReliabilityUnderBurstsRetriesAndRollover]' passed (14.279 seconds).
Test Case '-[HabitsUITests.WidgetUITests testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks]' passed (8.533 seconds).
```
