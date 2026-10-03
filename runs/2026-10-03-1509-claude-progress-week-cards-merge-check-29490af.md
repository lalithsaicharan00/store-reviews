# claude/progress-week-cards-merge-check @ 29490af

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37129405154 · 2026-10-03 15:09 UTC
Commit: UI tests start with completed habits shown; Hide Completed test holds Today long enough on a slow simulator

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (HabitPageUITests,UndoUITests,ProgressUITests,TasksUITests,WeekCardsUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 3 tests, with 0 failures (0 unexpected) in 127.143 (127.146) seconds
	 Executed 35 tests, with 2 failures (0 unexpected) in 1969.735 (1969.773) seconds
	 Executed 35 tests, with 2 failures (0 unexpected) in 1969.735 (1969.775) seconds
	 Executed 6 tests, with 1 failure (0 unexpected) in 954.374 (954.387) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 227.980 (227.985) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 407.229 (407.236) seconds
	 Executed 9 tests, with 1 failure (0 unexpected) in 253.009 (253.015) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitPageUITests.swift:157: error: -[HabitsUITests.HabitPageUITests testNotesFlows] : Failed to get matching snapshots: Timed out while evaluating UI query.
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ProgressUITests.swift:204: error: -[HabitsUITests.ProgressUITests testLogSlipAndUndo] : XCTAssertTrue failed - Log a Slip… on the habit page
Test Case '-[HabitsUITests.HabitPageUITests testHistoryFlows]' passed (84.237 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFlows]' failed (142.052 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDailyTypes]' passed (324.824 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDark]' passed (126.228 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesPeriodLimitQuit]' passed (234.433 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testYearInPixels]' passed (42.600 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (14.020 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndMilestones]' passed (28.787 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (67.445 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' failed (39.325 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (25.368 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (18.668 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (7.663 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtProgress]' passed (26.654 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (25.079 seconds).
Test Case '-[HabitsUITests.TasksUITests testCreateTaskFromTasksAndEditSurvivesRelaunch]' passed (50.595 seconds).
Test Case '-[HabitsUITests.TasksUITests testEveryTaskAppearsAndCanOpenEdit]' passed (69.460 seconds).
Test Case '-[HabitsUITests.TasksUITests testTaskModelAndPersistence]' passed (7.088 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (31.201 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (34.103 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (32.769 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds]' passed (37.163 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (22.280 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (23.700 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (32.181 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (14.583 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testHabitPageDark]' passed (46.521 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCards]' passed (40.753 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCardsDark]' passed (23.854 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsDark]' passed (62.467 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsLight]' passed (69.587 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsWithGroups]' passed (18.559 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCards]' passed (64.347 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCardsDark]' passed (30.909 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearScrollAndHabitPage]' passed (50.232 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
