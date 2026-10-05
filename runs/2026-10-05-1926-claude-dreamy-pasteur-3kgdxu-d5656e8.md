# claude/dreamy-pasteur-3kgdxu @ d5656e8

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37359131596 · 2026-10-05 19:26 UTC
Commit: Routine player: the fast ‹ › check samples the pager on screen every frame (the page frames it read didn't move during UIKit slides), in a 13-habit routine at three tap speeds

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (FocusPlayerUITests,RoutineCalendarUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 15 tests, with 3 failures (0 unexpected) in 574.213 (574.232) seconds
	 Executed 22 tests, with 3 failures (0 unexpected) in 836.822 (836.932) seconds
	 Executed 22 tests, with 3 failures (0 unexpected) in 836.822 (836.936) seconds
	 Executed 7 tests, with 0 failures (0 unexpected) in 262.610 (262.698) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/FocusPlayerUITests.swift:32: error: -[HabitsUITests.FocusPlayerUITests testChecklistPreservesPriorStepsAndQueueCanRevisit] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/FocusPlayerUITests.swift:378: error: -[HabitsUITests.FocusPlayerUITests testFastNavigationNeverSlidesBack] : XCTAssertTrue failed - Fast navigation: failed · 13 habits · › 150 ms: slid back 0.00, 0 reversals, settled 12.00/12, 69 mid-slide samples · ‹ 150 ms: slid back 0.00, 0 reversals, settled 0.00/0, 99 mid-slide samples · › 100 ms: slid back 0.00, 0 reversals, settled 12.00/12, 60 mid-slide samples · ‹ 100 ms: slid back 0.04, 0 reversals, settled 0.00/0, 84 mid-slide samples · › 50 ms: slid back 0.47, 0 reversals, settled 12.00/12, 39 mid-slide samples · ‹ 50 ms: slid back 0.20, 0 reversals, settled 0.00/0, 41 mid-slide samples
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/FocusPlayerUITests.swift:407: error: -[HabitsUITests.FocusPlayerUITests testNavigationDoesNotWaitForSlowTimerWrites] : XCTAssertLessThan failed: ("2.7442129850387573") is not less than ("1.8") - Navigation must not wait for the injected 2-second database write
Test Case '-[HabitsUITests.FocusPlayerUITests testBottomRowStaysPutAndOptionsShowEverything]' passed (68.957 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testChecklistPreservesPriorStepsAndQueueCanRevisit]' failed (99.972 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCompactProgressAcrossPeriodsAndTypes]' passed (82.224 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCountCheckAndUndoStayOnTheCurrentHabit]' passed (23.037 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testFastNavigationNeverSlidesBack]' failed (28.384 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLargeTextKeepsActionsAndChecklistReachable]' passed (21.339 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLimitIsNotInTheRoutineAndWaitsUnderQuitOrCutDown]' passed (33.296 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testManualTimePausesAndClockCanBeHidden]' passed (41.950 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testNavigationDoesNotWaitForSlowTimerWrites]' failed (23.052 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testOnlyALimitShowsUnderQuitOrCutDownWithoutStart]' passed (14.136 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSavedFocusProgressSurvivesTermination]' passed (29.383 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSwipeMovesOneHabitAtATime]' passed (15.081 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerDayBoundaryAndExactUndoPersistence]' passed (6.840 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerGoalDoesNotAutoAdvanceAndManualLogIsReachable]' passed (47.418 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerPauseBackgroundAndSkipPreserveTime]' passed (39.142 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarSixWeekMonthAtLargeTextSize]' passed (30.587 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarTotalsAndDaysWithoutHabits]' passed (37.142 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarUpdatesAfterLoggingAndPastNavigation]' passed (32.704 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testChecklistRoutineUsesExistingEntries]' passed (30.067 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testNonTimedRoutineAndSkipDoNotFalselyComplete]' passed (57.722 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testPlayFollowsHeaderRules]' passed (23.574 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testSingleHabitFullCompletionAndUndo]' passed (50.814 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
