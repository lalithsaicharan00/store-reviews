# claude/integration-check-b @ c47a1c4

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36873632879 · 2026-10-01 14:52 UTC
Commit: Over Time chart: marks only where something is drawn

- Core storage and migrations: success
- Build: success
- UI tests (UndoUITests,HabitCreationUITests,ProgressUITests,GroupsUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 220.555 (220.563) seconds
	 Executed 29 tests, with 0 failures (0 unexpected) in 1757.624 (1757.663) seconds
	 Executed 29 tests, with 0 failures (0 unexpected) in 1757.624 (1757.665) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 318.161 (318.172) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 953.832 (953.840) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 265.077 (265.085) seconds
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (68.497 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (92.466 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' passed (57.835 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (64.955 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (34.407 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testBigNumbers]' passed (65.171 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testDailyShapes]' passed (111.833 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testMonthAndYearShapes]' passed (255.610 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testOtherTypes]' passed (187.711 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testSetDayShapes]' passed (171.212 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testWeeklyShapes]' passed (162.295 seconds).
Test Case '-[HabitsUITests.ProgressUITests testDaySheetShowsOnToday]' passed (27.557 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (14.661 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndRuns]' passed (22.122 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (27.864 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (34.048 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (24.640 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (19.349 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (6.109 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtOverTime]' passed (24.744 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (19.461 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (34.312 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (41.078 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (35.548 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds]' passed (50.125 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (22.015 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (27.407 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (38.018 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (16.573 seconds).
```
