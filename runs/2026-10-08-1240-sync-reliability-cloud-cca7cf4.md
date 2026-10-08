# sync-reliability-cloud @ cca7cf4

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37774276922 · 2026-10-08 12:40 UTC
Commit: Current Work 66-72: test sync, backup, widgets, timers, reminders and alarms with the fixture fix [ios-ci] [ios-sync]

- Core storage and migrations: success
- Build: success
- Release build: skipped
- Same-build speed baseline: skipped
- UI tests (SyncUITests,BackupUITests,WidgetUITests,WidgetSystemUITests,TimerUITests,RemindersUITests,PlacementUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 1 test skipped and 1 failure (0 unexpected) in 137.676 (137.680) seconds
	 Executed 27 tests, with 1 test skipped and 1 failure (0 unexpected) in 1013.163 (1013.202) seconds
	 Executed 27 tests, with 1 test skipped and 1 failure (0 unexpected) in 1013.163 (1013.205) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 135.456 (135.460) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 131.479 (131.483) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 287.799 (287.805) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 264.958 (264.972) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/WidgetSystemUITests.swift:73: error: -[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence] : XCTAssertTrue failed - Attributes: Application, 0x1153c30c0, pid: 12950, label: ' '
Test Case '-[HabitsUITests.BackupUITests testAFreeAccountBacksUpToTheServer]' passed (83.972 seconds).
Test Case '-[HabitsUITests.BackupUITests testBackupIntegrityChecks]' passed (9.330 seconds).
Test Case '-[HabitsUITests.BackupUITests testDeletingTheAccountAndErasingThisPhone]' passed (46.252 seconds).
Test Case '-[HabitsUITests.BackupUITests testErasingEverythingWithoutAnAccount]' passed (29.874 seconds).
Test Case '-[HabitsUITests.BackupUITests testExportAndBackupOpenNativeShareSheet]' passed (45.564 seconds).
Test Case '-[HabitsUITests.BackupUITests testFreeBackupPageAndReinstallWarning]' passed (16.398 seconds).
Test Case '-[HabitsUITests.BackupUITests testTheEmptyFirstScreenOffersRestore]' passed (14.833 seconds).
Test Case '-[HabitsUITests.BackupUITests testWithoutAnAccountEverythingStaysOnThePhone]' passed (18.735 seconds).
Test Case '-[HabitsUITests.PlacementUITests testPlacementRules]' passed (6.550 seconds).
Test Case '-[HabitsUITests.RemindersUITests testDeniedPermissionOffersSettingsAndEmptyState]' passed (14.343 seconds).
Test Case '-[HabitsUITests.RemindersUITests testPlanningActionsPermissionsFailuresAndClockChanges]' passed (83.910 seconds).
Test Case '-[HabitsUITests.RemindersUITests testRealEmptyPageHasNoUnexpectedAlarmErrorOrPermissionPrompt]' passed (13.314 seconds).
Test Case '-[HabitsUITests.RemindersUITests testSavedRemindersOpenEditableTaskWithoutPermissionPrompt]' passed (23.889 seconds).
Test Case '-[HabitsUITests.SyncUITests testChangesTravelBetweenThisPhoneAndAnotherDevice]' passed (49.245 seconds).
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (29.945 seconds).
Test Case '-[HabitsUITests.TimerUITests testPlayOpensTimerScreenThatClosesWithoutStopping]' passed (32.222 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (31.895 seconds).
Test Case '-[HabitsUITests.TimerUITests testScreenCanBeTurnedOff]' passed (15.649 seconds).
Test Case '-[HabitsUITests.TimerUITests testTimerScreenPauseKeepsTimeAndResumes]' passed (21.768 seconds).
Test Case '-[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence]' failed (69.381 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' passed (173.759 seconds).
Test Case '-[HabitsUITests.WidgetUITests testGuideAndPrivacyAreFree]' passed (24.816 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLargerTextCountersAndCutDownAreReadable]' passed (31.902 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLongNamesAndUnitsKeepQuickActionVisible]' passed (18.652 seconds).
Test Case '-[HabitsUITests.WidgetUITests testReliabilityUnderBurstsRetriesAndRollover]' passed (22.444 seconds).
Test Case '-[HabitsUITests.WidgetUITests testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks]' passed (16.226 seconds).
```
