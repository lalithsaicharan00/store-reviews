# apple-watch-ci2 @ f8081ff

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38127622227 · 2026-10-11 10:10 UTC
Commit: Apple Watch: compile BackupFeatures for SHA256Hex, which iCloud's transport uses

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (TodayUITests,TimerUITests,PersistenceUITests,PlusUITests,TestLaunchIsolationUITests,AppReliabilityUITests,UndoUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 294.209 (294.219) seconds
	 Executed 37 tests, with 0 failures (0 unexpected) in 1329.298 (1329.344) seconds
	 Executed 37 tests, with 0 failures (0 unexpected) in 1329.298 (1329.348) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 194.284 (194.287) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 147.295 (147.299) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 269.010 (269.016) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 317.518 (317.525) seconds
Test Case '-[HabitsUITests.AppReliabilityUITests testBurstsRetriesStormsMidnightTravelAndAYear]' passed (46.929 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testFailedWriteIsTakenBack]' passed (54.233 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testHabitAndTickSurviveRelaunch]' passed (59.187 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testQuickTapsSurviveLeavingTheApp]' passed (67.084 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testUnopenableDatabaseSaysSoAndTakesNoChanges]' passed (13.780 seconds).
Test Case '-[HabitsUITests.PlusUITests testAskToBuyShowsWaiting]' passed (19.585 seconds).
Test Case '-[HabitsUITests.PlusUITests testBringingBackAnArchivedHabit]' passed (30.114 seconds).
Test Case '-[HabitsUITests.PlusUITests testBuyingPlusSavesTheSixthHabit]' passed (41.640 seconds).
Test Case '-[HabitsUITests.PlusUITests testMakeRoomArchivesOneAndGoesAhead]' passed (39.332 seconds).
Test Case '-[HabitsUITests.PlusUITests testOwnerUpgradesAndFamilyMemberPage]' passed (41.852 seconds).
Test Case '-[HabitsUITests.PlusUITests testPlusEndedIsToldOnce]' passed (15.469 seconds).
Test Case '-[HabitsUITests.PlusUITests testPlusPageAndRestoreWithNothingFound]' passed (20.983 seconds).
Test Case '-[HabitsUITests.PlusUITests testPricesThatFailShowTryAgain]' passed (39.976 seconds).
Test Case '-[HabitsUITests.PlusUITests testSecondDeviceSheetOpensThePlusPage]' passed (22.372 seconds).
Test Case '-[HabitsUITests.PlusUITests testSixthHabitSheetOffersBothPlansAndNoNotNow]' passed (22.886 seconds).
Test Case '-[HabitsUITests.TestLaunchIsolationUITests testATestLaunchLeavesThePersonsWidgetsAndSettings]' passed (60.054 seconds).
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (33.799 seconds).
Test Case '-[HabitsUITests.TimerUITests testPlayOpensTimerScreenThatClosesWithoutStopping]' passed (34.414 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (34.398 seconds).
Test Case '-[HabitsUITests.TimerUITests testScreenCanBeTurnedOff]' passed (18.073 seconds).
Test Case '-[HabitsUITests.TimerUITests testTimerScreenPauseKeepsTimeAndResumes]' passed (26.611 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (29.613 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (46.515 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (25.793 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (27.492 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (16.209 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (118.249 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (16.851 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (36.796 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (41.413 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (49.222 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (35.377 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogManuallyAddsOneLog]' passed (36.872 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (22.117 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (19.515 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (43.889 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (20.606 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
