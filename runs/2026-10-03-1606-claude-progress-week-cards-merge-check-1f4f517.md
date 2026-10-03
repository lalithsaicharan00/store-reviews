# claude/progress-week-cards-merge-check @ 1f4f517

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37132733759 · 2026-10-03 16:06 UTC
Commit: Branch list: progress-week-research merged, integration and server-and-sync level with main, weekly-overview-stats already deleted

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (HabitPageUITests,UndoUITests,ProgressUITests,TasksUITests,WeekCardsUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 3 tests, with 0 failures (0 unexpected) in 118.825 (118.827) seconds
	 Executed 35 tests, with 1 failure (0 unexpected) in 1960.232 (1960.272) seconds
	 Executed 35 tests, with 1 failure (0 unexpected) in 1960.232 (1960.275) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 948.526 (948.540) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 225.183 (225.189) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 432.205 (432.210) seconds
	 Executed 9 tests, with 1 failure (0 unexpected) in 235.494 (235.500) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ProgressUITests.swift:206: error: -[HabitsUITests.ProgressUITests testLogSlipAndUndo] : XCTAssertTrue failed - Log a Slip… on the habit page
Test Case '-[HabitsUITests.HabitPageUITests testHistoryFlows]' passed (162.470 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFlows]' passed (42.977 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDailyTypes]' passed (310.113 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDark]' passed (161.927 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesPeriodLimitQuit]' passed (229.040 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testYearInPixels]' passed (41.998 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (12.796 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndMilestones]' passed (25.587 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (66.348 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' failed (39.357 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (23.970 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (16.740 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (5.566 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtProgress]' passed (25.393 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (19.737 seconds).
Test Case '-[HabitsUITests.TasksUITests testCreateTaskFromTasksAndEditSurvivesRelaunch]' passed (44.072 seconds).
Test Case '-[HabitsUITests.TasksUITests testEveryTaskAppearsAndCanOpenEdit]' passed (69.035 seconds).
Test Case '-[HabitsUITests.TasksUITests testTaskModelAndPersistence]' passed (5.718 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (33.511 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (37.867 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (29.803 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds]' passed (38.070 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (19.997 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (21.314 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (31.633 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (12.989 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testHabitPageDark]' passed (45.847 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCards]' passed (40.246 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCardsDark]' passed (24.335 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsDark]' passed (65.647 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsLight]' passed (73.065 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsWithGroups]' passed (19.918 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCards]' passed (69.593 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCardsDark]' passed (36.922 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearScrollAndHabitPage]' passed (56.633 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
