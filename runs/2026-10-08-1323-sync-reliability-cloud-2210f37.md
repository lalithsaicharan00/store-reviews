# sync-reliability-cloud @ 2210f37

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37778952272 · 2026-10-08 13:23 UTC
Commit: Current Work 66-72: test sync, backup, widgets, timers, reminders and alarms [ios-ci] [ios-sync]

- Core storage and migrations: success
- Build: success
- Release build: skipped
- Same-build speed baseline: skipped
- UI tests (SyncUITests,BackupUITests,WidgetUITests,WidgetSystemUITests,TimerUITests,RemindersUITests,PlacementUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 1 test skipped and 1 failure (0 unexpected) in 265.122 (265.133) seconds
	 Executed 27 tests, with 1 test skipped and 1 failure (0 unexpected) in 1131.693 (1131.737) seconds
	 Executed 27 tests, with 1 test skipped and 1 failure (0 unexpected) in 1131.693 (1131.738) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 128.345 (128.348) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 152.194 (152.199) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 278.483 (278.491) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 259.283 (259.292) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/WidgetSystemUITests.swift:118: error: -[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence] : failed - The widget didn't show the committed log. Widget: Today, 0 of 5 done | Today | Previous page | Page 1 of 4 | Next page | Add 1 to Widget cut down | Widget cut down | 0 of 3 cups · Daily limit | Widget quit, Quitting, 40 days and 1 hr, 14 min | Widget quit | Record a slip for Widget quit | Horizontal scroll bar, 1 page | Horizontal scroll bar, 1 page. App: Widget system: no durable widget log · 0 taps waiting in the shared file
Test Case '-[HabitsUITests.BackupUITests testAFreeAccountBacksUpToTheServer]' passed (92.575 seconds).
Test Case '-[HabitsUITests.BackupUITests testBackupIntegrityChecks]' passed (8.056 seconds).
Test Case '-[HabitsUITests.BackupUITests testDeletingTheAccountAndErasingThisPhone]' passed (39.861 seconds).
Test Case '-[HabitsUITests.BackupUITests testErasingEverythingWithoutAnAccount]' passed (27.073 seconds).
Test Case '-[HabitsUITests.BackupUITests testExportAndBackupOpenNativeShareSheet]' passed (43.911 seconds).
Test Case '-[HabitsUITests.BackupUITests testFreeBackupPageAndReinstallWarning]' passed (15.123 seconds).
Test Case '-[HabitsUITests.BackupUITests testTheEmptyFirstScreenOffersRestore]' passed (13.535 seconds).
Test Case '-[HabitsUITests.BackupUITests testWithoutAnAccountEverythingStaysOnThePhone]' passed (19.149 seconds).
Test Case '-[HabitsUITests.PlacementUITests testPlacementRules]' passed (7.626 seconds).
Test Case '-[HabitsUITests.RemindersUITests testDeniedPermissionOffersSettingsAndEmptyState]' passed (16.477 seconds).
Test Case '-[HabitsUITests.RemindersUITests testPlanningActionsPermissionsFailuresAndClockChanges]' passed (75.801 seconds).
Test Case '-[HabitsUITests.RemindersUITests testRealEmptyPageHasNoUnexpectedAlarmErrorOrPermissionPrompt]' passed (14.915 seconds).
Test Case '-[HabitsUITests.RemindersUITests testSavedRemindersOpenEditableTaskWithoutPermissionPrompt]' passed (21.152 seconds).
Test Case '-[HabitsUITests.SyncUITests testChangesTravelBetweenThisPhoneAndAnotherDevice]' passed (40.639 seconds).
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (45.509 seconds).
Test Case '-[HabitsUITests.TimerUITests testPlayOpensTimerScreenThatClosesWithoutStopping]' passed (33.543 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (31.541 seconds).
Test Case '-[HabitsUITests.TimerUITests testScreenCanBeTurnedOff]' passed (15.987 seconds).
Test Case '-[HabitsUITests.TimerUITests testTimerScreenPauseKeepsTimeAndResumes]' passed (25.614 seconds).
Test Case '-[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence]' failed (165.752 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' passed (169.039 seconds).
Test Case '-[HabitsUITests.WidgetUITests testGuideAndPrivacyAreFree]' passed (26.985 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLargerTextCountersAndCutDownAreReadable]' passed (32.142 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLongNamesAndUnitsKeepQuickActionVisible]' passed (19.793 seconds).
Test Case '-[HabitsUITests.WidgetUITests testReliabilityUnderBurstsRetriesAndRollover]' passed (20.536 seconds).
Test Case '-[HabitsUITests.WidgetUITests testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks]' passed (9.988 seconds).
```
