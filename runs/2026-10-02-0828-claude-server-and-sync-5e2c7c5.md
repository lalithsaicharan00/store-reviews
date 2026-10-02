# claude/server-and-sync @ 5e2c7c5

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36981365705 · 2026-10-02 08:28 UTC
Commit: Progress's view options work again: the app-wide green switch style had reached the menu's toggles [ios-ci]

- Core storage and migrations: success
- Build: success
- Release build: skipped
- Same-build speed baseline: skipped
- UI tests (TodayUITests,TimerUITests,ProgressUITests,GroupsUITests,UndoUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 246.165 (246.173) seconds
	 Executed 2 tests, with 0 failures (0 unexpected) in 62.162 (62.164) seconds
	 Executed 33 tests, with 1 failure (0 unexpected) in 1116.361 (1116.393) seconds
	 Executed 33 tests, with 1 failure (0 unexpected) in 1116.361 (1116.395) seconds
	 Executed 5 tests, with 1 failure (0 unexpected) in 307.548 (307.554) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 227.637 (227.643) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 272.848 (272.855) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/GroupsUITests.swift:49: error: -[HabitsUITests.GroupsUITests testChipsAndEmptyGroup] : XCTAssertTrue failed
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' failed (86.302 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (76.302 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' passed (45.364 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (61.463 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (38.117 seconds).
Test Case '-[HabitsUITests.ProgressUITests testDaySheetShowsOnToday]' passed (19.731 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (12.681 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndRuns]' passed (15.553 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (32.009 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (58.004 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (29.157 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (22.883 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (8.812 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtOverTime]' passed (27.960 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (19.375 seconds).
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (26.898 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (35.265 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (21.797 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (42.498 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (23.402 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (28.911 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (14.027 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (98.198 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (12.724 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (31.293 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (35.903 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (35.339 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (31.081 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds]' passed (42.050 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (19.827 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (17.735 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (33.039 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (12.663 seconds).
```
