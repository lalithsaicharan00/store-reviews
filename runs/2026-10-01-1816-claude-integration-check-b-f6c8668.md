# claude/integration-check-b @ f6c8668

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36900124053 · 2026-10-01 18:16 UTC
Commit: New Habit from an idea: the name starts in TypedName (onboarding's initializer met the typed-name change)

- Core storage and migrations: success
- Build: success
- UI tests (UndoUITests,HabitCreationUITests,ProgressUITests,GroupsUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 239.561 (239.569) seconds
	 Executed 29 tests, with 0 failures (0 unexpected) in 1894.464 (1894.506) seconds
	 Executed 29 tests, with 0 failures (0 unexpected) in 1894.464 (1894.508) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 312.974 (312.989) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 1098.936 (1098.942) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 242.993 (242.999) seconds
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (60.848 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (87.046 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' passed (56.904 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (69.506 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (38.671 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testBigNumbers]' passed (82.589 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testDailyShapes]' passed (127.359 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testMonthAndYearShapes]' passed (370.394 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testOtherTypes]' passed (181.453 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testSetDayShapes]' passed (182.358 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testWeeklyShapes]' passed (154.783 seconds).
Test Case '-[HabitsUITests.ProgressUITests testDaySheetShowsOnToday]' passed (20.337 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (12.851 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndRuns]' passed (28.632 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (26.498 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (48.037 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (26.014 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (23.667 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (6.554 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtOverTime]' passed (29.506 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (17.465 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (36.532 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (39.132 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (30.959 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds]' passed (48.655 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (19.279 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (19.883 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (34.557 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (13.996 seconds).
```
