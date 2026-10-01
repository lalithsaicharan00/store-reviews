# claude/perf-bisect-habit-page @ f6c8668

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36900127716 · 2026-10-01 18:08 UTC
Commit: New Habit from an idea: the name starts in TypedName (onboarding's initializer met the typed-name change)

- Core storage and migrations: success
- Build: success
- UI tests (OnboardingUITests,WidgetUITests,WidgetSystemUITests,TimerUITests,BackupUITests,PersistenceUITests,RemindersUITests,TasksUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 0 failures (0 unexpected) in 70.421 (70.422) seconds
	 Executed 2 tests, with 1 test skipped and 0 failures (0 unexpected) in 253.372 (253.377) seconds
	 Executed 28 tests, with 1 test skipped and 0 failures (0 unexpected) in 1438.463 (1438.508) seconds
	 Executed 28 tests, with 1 test skipped and 0 failures (0 unexpected) in 1438.463 (1438.509) seconds
	 Executed 3 tests, with 0 failures (0 unexpected) in 120.382 (120.387) seconds
	 Executed 3 tests, with 0 failures (0 unexpected) in 147.563 (147.569) seconds
	 Executed 3 tests, with 0 failures (0 unexpected) in 328.918 (328.921) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 64.641 (64.645) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 166.653 (166.658) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 286.512 (286.522) seconds
Test Case '-[HabitsUITests.BackupUITests testBackupIntegrityChecks]' passed (101.528 seconds).
Test Case '-[HabitsUITests.BackupUITests testExportAndBackupOpenNativeShareSheet]' passed (34.267 seconds).
Test Case '-[HabitsUITests.BackupUITests testFreeBackupPageAndReinstallWarning]' passed (11.768 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testLargestTextReachesContinue]' passed (18.282 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNotNowAndHelp]' passed (132.133 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNoWelcomeInOtherRuns]' passed (22.899 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testRestoreFromTheWelcome]' passed (20.261 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testSkipLeadsToAHelpfulToday]' passed (43.551 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testWelcomeToFirstHabit]' passed (49.387 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testFailedWriteIsTakenBack]' passed (37.504 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testHabitAndTickSurviveRelaunch]' passed (239.240 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testQuickTapsSurviveLeavingTheApp]' passed (52.174 seconds).
Test Case '-[HabitsUITests.RemindersUITests testDeniedPermissionOffersSettingsAndEmptyState]' passed (14.231 seconds).
Test Case '-[HabitsUITests.RemindersUITests testPlanningActionsPermissionsFailuresAndClockChanges]' passed (14.164 seconds).
Test Case '-[HabitsUITests.RemindersUITests testRealEmptyPageHasNoUnexpectedAlarmErrorOrPermissionPrompt]' passed (14.197 seconds).
Test Case '-[HabitsUITests.RemindersUITests testSavedRemindersOpenEditableTaskWithoutPermissionPrompt]' passed (22.050 seconds).
Test Case '-[HabitsUITests.TasksUITests testCreateTaskFromTasksAndEditSurvivesRelaunch]' passed (47.975 seconds).
Test Case '-[HabitsUITests.TasksUITests testEveryTaskAppearsAndCanOpenEdit]' passed (65.668 seconds).
Test Case '-[HabitsUITests.TasksUITests testTaskModelAndPersistence]' passed (6.739 seconds).
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (30.573 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (39.847 seconds).
Test Case '-[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence]' passed (179.568 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' passed (114.644 seconds).
Test Case '-[HabitsUITests.WidgetUITests testGuideAndPrivacyAreFree]' passed (20.946 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLargerTextCountersAndCutDownAreReadable]' passed (17.727 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLongNamesAndUnitsKeepQuickActionVisible]' passed (7.443 seconds).
Test Case '-[HabitsUITests.WidgetUITests testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks]' passed (5.893 seconds).
```
