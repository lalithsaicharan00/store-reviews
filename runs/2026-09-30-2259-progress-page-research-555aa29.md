# progress-page-research @ 555aa29

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36786559073 · 2026-09-30 22:59 UTC
Commit: Routine player: the circle keeps its children's identifiers; a routine test taps the main Finish button

- Build: success
- UI tests (FocusPlayerUITests,RoutineCalendarUITests): failure
- Speed tests: skipped

## UI tests
```
	 Executed 12 tests, with 7 failures (0 unexpected) in 341.813 (341.825) seconds
	 Executed 19 tests, with 11 failures (0 unexpected) in 560.469 (560.489) seconds
	 Executed 19 tests, with 11 failures (0 unexpected) in 560.469 (560.490) seconds
	 Executed 7 tests, with 4 failures (0 unexpected) in 218.656 (218.662) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/FocusPlayerUITests.swift:100: error: -[HabitsUITests.FocusPlayerUITests testTimerPauseBackgroundAndSkipPreserveTime] : Failed to get matching snapshot: No matches found for Elements matching predicate '"focus-clock-value" IN identifiers' from input {(
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/FocusPlayerUITests.swift:135: error: -[HabitsUITests.FocusPlayerUITests testTimerGoalDoesNotAutoAdvanceAndManualLogIsReachable] : Failed to tap "Add" Button: No matches found for Elements matching predicate '"Add" IN identifiers' from input {(
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/FocusPlayerUITests.swift:203: error: -[HabitsUITests.FocusPlayerUITests testManualTimePausesAndClockCanBeHidden] : XCTAssertFalse failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/FocusPlayerUITests.swift:223: error: -[HabitsUITests.FocusPlayerUITests testCompactProgressAcrossPeriodsAndTypes] : Failed to get matching snapshot: No matches found for Elements matching predicate '"focus-clock-value" IN identifiers' from input {(
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/FocusPlayerUITests.swift:261: error: -[HabitsUITests.FocusPlayerUITests testNavigationDoesNotWaitForSlowTimerWrites] : Failed to get matching snapshot: Find single matching element. Multiple matching elements found for <XCUIElementQuery: 0x10814c410>.
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/FocusPlayerUITests.swift:50: error: -[HabitsUITests.FocusPlayerUITests testCountCheckAndUndoStayOnTheCurrentHabit] : Failed to get matching snapshot: Find single matching element. Multiple matching elements found for <XCUIElementQuery: 0x10814c280>.
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/FocusPlayerUITests.swift:71: error: -[HabitsUITests.FocusPlayerUITests testChecklistPreservesPriorStepsAndQueueCanRevisit] : Failed to get matching snapshot: Find single matching element. Multiple matching elements found for <XCUIElementQuery: 0x1078cbd40>.
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/RoutineCalendarUITests.swift:118: error: -[HabitsUITests.RoutineCalendarUITests testChecklistRoutineUsesExistingEntries] : XCTAssertFalse failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/RoutineCalendarUITests.swift:225: error: -[HabitsUITests.RoutineCalendarUITests testCalendarSixWeekMonthAtLargeTextSize] : XCTAssertFalse failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/RoutineCalendarUITests.swift:30: error: -[HabitsUITests.RoutineCalendarUITests testNonTimedRoutineAndSkipDoNotFalselyComplete] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/RoutineCalendarUITests.swift:52: error: -[HabitsUITests.RoutineCalendarUITests testPlayFollowsHeaderRules] : XCTAssertTrue failed
Test Case '-[HabitsUITests.FocusPlayerUITests testChecklistPreservesPriorStepsAndQueueCanRevisit]' failed (59.967 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCompactProgressAcrossPeriodsAndTypes]' failed (49.520 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCountCheckAndUndoStayOnTheCurrentHabit]' failed (25.083 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLargeTextKeepsActionsAndChecklistReachable]' passed (19.243 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLimitCheckInNeverLogsConsumptionOrCompletesTheDay]' passed (25.658 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testManualTimePausesAndClockCanBeHidden]' failed (25.658 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testNavigationDoesNotWaitForSlowTimerWrites]' failed (19.865 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSavedFocusProgressSurvivesTermination]' passed (25.145 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSectionWithOnlyALimitStillHasStart]' passed (18.018 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerDayBoundaryAndExactUndoPersistence]' passed (7.573 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerGoalDoesNotAutoAdvanceAndManualLogIsReachable]' failed (41.314 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerPauseBackgroundAndSkipPreserveTime]' failed (24.767 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarSixWeekMonthAtLargeTextSize]' failed (25.816 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarTotalsAndDaysWithoutHabits]' passed (35.407 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarUpdatesAfterLoggingAndPastNavigation]' passed (36.967 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testChecklistRoutineUsesExistingEntries]' failed (23.507 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testNonTimedRoutineAndSkipDoNotFalselyComplete]' failed (28.648 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testPlayFollowsHeaderRules]' failed (13.840 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testSingleHabitFullCompletionAndUndo]' passed (54.470 seconds).
```
