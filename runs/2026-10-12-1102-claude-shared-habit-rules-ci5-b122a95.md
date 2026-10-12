# claude/shared-habit-rules-ci5 @ b122a95

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38225682613 · 2026-10-12 11:02 UTC
Commit: Current Work 92 (checkpoint 2): a log made before the shared rules' copy is built isn't lost

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (UndoUITests,CompletionFeedbackUITests,RoutineCalendarUITests,TasksUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 19 tests, with 1 failure (0 unexpected) in 739.359 (739.389) seconds
	 Executed 19 tests, with 1 failure (0 unexpected) in 739.359 (739.391) seconds
	 Executed 3 tests, with 0 failures (0 unexpected) in 131.207 (131.211) seconds
	 Executed 7 tests, with 1 failure (0 unexpected) in 330.560 (330.571) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 257.161 (257.169) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/RoutineCalendarUITests.swift:19: error: -[HabitsUITests.RoutineCalendarUITests testCalendarUpdatesAfterLoggingAndPastNavigation] : XCTAssertTrue failed
Test Case '-[HabitsUITests.CompletionFeedbackUITests testCompletionPlaysOnceWhenAHabitBecomesCompleteAndNeverForQuitOrLimits]' passed (20.431 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarSixWeekMonthAtLargeTextSize]' passed (27.745 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarTotalsAndDaysWithoutHabits]' passed (41.078 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarUpdatesAfterLoggingAndPastNavigation]' failed (63.554 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testChecklistRoutineUsesExistingEntries]' passed (66.819 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testNonTimedRoutineAndSkipDoNotFalselyComplete]' passed (59.825 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testPlayFollowsHeaderRules]' passed (23.023 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testSingleHabitFullCompletionAndUndo]' passed (48.516 seconds).
Test Case '-[HabitsUITests.TasksUITests testCreateTaskFromTasksAndEditSurvivesRelaunch]' passed (49.543 seconds).
Test Case '-[HabitsUITests.TasksUITests testEveryTaskAppearsAndCanOpenEdit]' passed (74.483 seconds).
Test Case '-[HabitsUITests.TasksUITests testTaskModelAndPersistence]' passed (7.181 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (36.405 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (53.787 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (59.997 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogManuallyAddsOneLog]' passed (28.242 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (20.467 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (16.287 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (28.287 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (13.689 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
