# app-lock-privacy-security-ci3 @ 8b453f0

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38039877414 · 2026-10-10 09:44 UTC
Commit: Tests for free sync and the move: the right alert, the file picker's ✕, Water for the old device's habits; the closed sidebar is no longer an "alert"

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (TodayUITests,GroupsUITests,AppLockUITests,AppReliabilityUITests,TestLaunchIsolationUITests,PersistenceUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 441.889 (441.895) seconds
	 Executed 16 tests, with 0 failures (0 unexpected) in 803.124 (803.138) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 128.449 (128.453) seconds
	 Executed 40 tests, with 0 failures (0 unexpected) in 1715.730 (1715.771) seconds
	 Executed 40 tests, with 0 failures (0 unexpected) in 1715.730 (1715.772) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 279.605 (279.614) seconds
Test Case '-[HabitsUITests.AppLockUITests testALinkOpensBehindTheCoverAndShowsAfterUnlock]' passed (29.633 seconds).
Test Case '-[HabitsUITests.AppLockUITests testAskAgainImmediatelyAndAfterAMinute]' passed (47.753 seconds).
Test Case '-[HabitsUITests.AppLockUITests testCancelLeavesUnlockAndTypedTextIsKept]' passed (40.472 seconds).
Test Case '-[HabitsUITests.AppLockUITests testCancellingSetUpAtEachStepChangesNothing]' passed (70.139 seconds).
Test Case '-[HabitsUITests.AppLockUITests testChooseCodeThenUnlockWithIt]' passed (119.849 seconds).
Test Case '-[HabitsUITests.AppLockUITests testFaceIDChangedAsksForTheCodeAndThenAsks]' passed (120.958 seconds).
Test Case '-[HabitsUITests.AppLockUITests testForgotCodeTwentyFourHourReset]' passed (61.978 seconds).
Test Case '-[HabitsUITests.AppLockUITests testForgotCodeWithFaceID]' passed (34.218 seconds).
Test Case '-[HabitsUITests.AppLockUITests testLockOnAndOffAndHideNamesFollows]' passed (84.408 seconds).
Test Case '-[HabitsUITests.AppLockUITests testLockRulesAndHiddenNamesEverywhere]' passed (6.591 seconds).
Test Case '-[HabitsUITests.AppLockUITests testNoFaceIDTurnsOnWithThePasscode]' passed (22.278 seconds).
Test Case '-[HabitsUITests.AppLockUITests testNoPasscodeShowsWhy]' passed (14.549 seconds).
Test Case '-[HabitsUITests.AppLockUITests testReminderSaysIsSavedWithTheHabit]' passed (40.727 seconds).
Test Case '-[HabitsUITests.AppLockUITests testSwitchingModesBothWays]' passed (62.520 seconds).
Test Case '-[HabitsUITests.AppLockUITests testWidgetChooseLinkOpensHelp]' passed (13.290 seconds).
Test Case '-[HabitsUITests.AppLockUITests testWrongCodesWaitThenTheRightCodeOpens]' passed (33.760 seconds).
Test Case '-[HabitsUITests.AppReliabilityUITests testBurstsRetriesStormsMidnightTravelAndAYear]' passed (13.444 seconds).
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (29.010 seconds).
Test Case '-[HabitsUITests.GroupsUITests testDeletingAGroupKeepsItsHabits]' passed (34.819 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (59.128 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' passed (39.785 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupDragDropsReliably]' passed (97.488 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (53.438 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupOrderIsThePersonsOwn]' passed (33.599 seconds).
Test Case '-[HabitsUITests.GroupsUITests testNamesAreUniqueAndAGroupCanPause]' passed (34.727 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (28.268 seconds).
Test Case '-[HabitsUITests.GroupsUITests testTodayAndProgressKeepTheirOwnChoiceAndStartPlaysWhatsShown]' passed (31.628 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testFailedWriteIsTakenBack]' passed (33.315 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testHabitAndTickSurviveRelaunch]' passed (44.476 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testQuickTapsSurviveLeavingTheApp]' passed (40.371 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testUnopenableDatabaseSaysSoAndTakesNoChanges]' passed (10.288 seconds).
Test Case '-[HabitsUITests.TestLaunchIsolationUITests testATestLaunchLeavesThePersonsWidgetsAndSettings]' passed (49.219 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (18.703 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (40.326 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (20.180 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (26.605 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (13.907 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (110.561 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (13.740 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (35.583 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
