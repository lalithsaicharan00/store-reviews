# claude/progress-week-cards-merge-check @ c0e9137

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37137382413 · 2026-10-03 17:24 UTC
Commit: Quit record card keeps its controls' own ids (its id replaced Log a Slip's); calendar test's undo check reads the day bar; Starts/Ends test drags the form, not Today behind it

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (HabitPageUITests,UndoUITests,ProgressUITests,TasksUITests,WeekCardsUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 3 tests, with 0 failures (0 unexpected) in 121.780 (121.783) seconds
	 Executed 35 tests, with 2 failures (0 unexpected) in 1947.823 (1947.859) seconds
	 Executed 35 tests, with 2 failures (0 unexpected) in 1947.823 (1947.860) seconds
	 Executed 6 tests, with 2 failures (0 unexpected) in 940.273 (940.284) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 195.976 (195.980) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 264.009 (264.017) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 425.784 (425.790) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitPageUITests.swift:116: error: -[HabitsUITests.HabitPageUITests testHistoryFlows] : Failed to tap "history-add-entry" Button: No matches found for Elements matching predicate '"history-add-entry" IN identifiers' from input {(
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitPageUITests.swift:46: error: -[HabitsUITests.HabitPageUITests testHistoryFlows] : XCTAssertTrue failed - Water's page
Test Case '-[HabitsUITests.HabitPageUITests testHistoryFlows]' failed (111.599 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFlows]' passed (76.161 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDailyTypes]' passed (302.680 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDark]' passed (149.296 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesPeriodLimitQuit]' passed (260.021 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testYearInPixels]' passed (40.516 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (12.781 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndMilestones]' passed (30.643 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (64.830 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (49.702 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (29.156 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (21.241 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (8.249 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtProgress]' passed (26.442 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (20.964 seconds).
Test Case '-[HabitsUITests.TasksUITests testCreateTaskFromTasksAndEditSurvivesRelaunch]' passed (46.468 seconds).
Test Case '-[HabitsUITests.TasksUITests testEveryTaskAppearsAndCanOpenEdit]' passed (69.375 seconds).
Test Case '-[HabitsUITests.TasksUITests testTaskModelAndPersistence]' passed (5.937 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (28.971 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (33.900 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (26.732 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds]' passed (34.101 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (18.170 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (15.424 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (27.021 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (11.659 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testHabitPageDark]' passed (42.961 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCards]' passed (42.581 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCardsDark]' passed (23.674 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsDark]' passed (65.059 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsLight]' passed (73.763 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsWithGroups]' passed (20.460 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCards]' passed (68.612 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCardsDark]' passed (33.866 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearScrollAndHabitPage]' passed (54.809 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
