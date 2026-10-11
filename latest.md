# claude/pensive-gates-3n4ie8-ci7 @ c5b1da3

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38131146101 · 2026-10-11 11:37 UTC
Commit: Current Work 86/88: Day details' popover hangs on Today, pointing at its row; iPad tests; iPad speed runs; coming back to the iPhone

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (WidgetUITests,WidgetSystemUITests,AppLockUITests,AppReliabilityUITests,RemindersUITests,TasksUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 1 test skipped and 0 failures (0 unexpected) in 278.338 (278.342) seconds
	 Executed 21 tests, with 0 failures (0 unexpected) in 1315.092 (1315.110) seconds
	 Executed 3 tests, with 0 failures (0 unexpected) in 119.840 (119.842) seconds
	 Executed 38 tests, with 2 tests skipped and 0 failures (0 unexpected) in 2191.213 (2191.257) seconds
	 Executed 38 tests, with 2 tests skipped and 0 failures (0 unexpected) in 2191.213 (2191.258) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 113.922 (113.926) seconds
	 Executed 7 tests, with 1 test skipped and 0 failures (0 unexpected) in 338.304 (338.312) seconds
Test Case '-[HabitsUITests.AppLockUITests testALinkOpensBehindTheCoverAndShowsAfterUnlock]' passed (36.035 seconds).
Test Case '-[HabitsUITests.AppLockUITests testAppPasscodeWayAndItsReset]' passed (159.278 seconds).
Test Case '-[HabitsUITests.AppLockUITests testAskAgainImmediatelyAndAfterAMinute]' passed (46.480 seconds).
Test Case '-[HabitsUITests.AppLockUITests testCancelLeavesUnlockAndTypedTextIsKept]' passed (38.149 seconds).
Test Case '-[HabitsUITests.AppLockUITests testCancellingSetUpAtEachStepChangesNothing]' passed (74.412 seconds).
Test Case '-[HabitsUITests.AppLockUITests testFaceIDChangedAsksForTheCodeAndThenAsks]' passed (91.182 seconds).
Test Case '-[HabitsUITests.AppLockUITests testFaceIDLockedOutIsNotTurnedOff]' passed (50.110 seconds).
Test Case '-[HabitsUITests.AppLockUITests testFaceIDOffForTheApp]' passed (135.824 seconds).
Test Case '-[HabitsUITests.AppLockUITests testForgotCodeTwentyFourHourReset]' passed (111.091 seconds).
Test Case '-[HabitsUITests.AppLockUITests testForgotCodeWithFaceID]' passed (32.652 seconds).
Test Case '-[HabitsUITests.AppLockUITests testIPhonePasscodeTurnedOff]' passed (41.474 seconds).
Test Case '-[HabitsUITests.AppLockUITests testIPhonePasscodeWay]' passed (61.127 seconds).
Test Case '-[HabitsUITests.AppLockUITests testLockOnAndOffAndHideNamesFollows]' passed (114.367 seconds).
Test Case '-[HabitsUITests.AppLockUITests testLockRulesAndHiddenNamesEverywhere]' passed (6.598 seconds).
Test Case '-[HabitsUITests.AppLockUITests testNoFaceIDOnThisIPhone]' passed (39.648 seconds).
Test Case '-[HabitsUITests.AppLockUITests testNoPasscodeUsesTheAppPasscodeAlone]' passed (45.064 seconds).
Test Case '-[HabitsUITests.AppLockUITests testOlderLockUpgrades]' passed (46.806 seconds).
Test Case '-[HabitsUITests.AppLockUITests testReminderSaysIsSavedWithTheHabit]' passed (50.240 seconds).
Test Case '-[HabitsUITests.AppLockUITests testSwitchingWays]' passed (66.890 seconds).
Test Case '-[HabitsUITests.AppLockUITests testWidgetChooseLinkOpensHelp]' passed (25.383 seconds).
Test Case '-[HabitsUITests.AppLockUITests testWrongCodesWaitThenTheRightCodeOpens]' passed (42.282 seconds).
Test Case '-[HabitsUITests.AppReliabilityUITests testBurstsRetriesStormsMidnightTravelAndAYear]' passed (25.717 seconds).
Test Case '-[HabitsUITests.RemindersUITests testDeniedPermissionOffersSettingsAndEmptyState]' passed (14.781 seconds).
Test Case '-[HabitsUITests.RemindersUITests testPlanningActionsPermissionsFailuresAndClockChanges]' passed (66.208 seconds).
Test Case '-[HabitsUITests.RemindersUITests testRealEmptyPageHasNoUnexpectedAlarmErrorOrPermissionPrompt]' passed (12.942 seconds).
Test Case '-[HabitsUITests.RemindersUITests testSavedRemindersOpenEditableTaskWithoutPermissionPrompt]' passed (19.991 seconds).
Test Case '-[HabitsUITests.TasksUITests testCreateTaskFromTasksAndEditSurvivesRelaunch]' passed (46.179 seconds).
Test Case '-[HabitsUITests.TasksUITests testEveryTaskAppearsAndCanOpenEdit]' passed (68.035 seconds).
Test Case '-[HabitsUITests.TasksUITests testTaskModelAndPersistence]' passed (5.626 seconds).
Test Case '-[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence]' passed (148.181 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' passed (219.339 seconds).
Test Case '-[HabitsUITests.WidgetUITests testGuideAndPrivacyAreFree]' passed (38.849 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLargerTextCountersAndCutDownAreReadable]' passed (30.451 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLongNamesAndUnitsKeepQuickActionVisible]' passed (16.629 seconds).
Test Case '-[HabitsUITests.WidgetUITests testReliabilityUnderBurstsRetriesAndRollover]' passed (20.166 seconds).
Test Case '-[HabitsUITests.WidgetUITests testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks]' passed (12.628 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
