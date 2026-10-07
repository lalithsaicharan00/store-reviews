# day-details-logs-notes-redesign-ci-c @ d847158

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37609528689 · 2026-10-07 11:31 UTC
Commit: Day details redesign: Core sync test for an edited log time; checklist, Design Rules and branch notes

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (FocusPlayerUITests,RoutineCalendarUITests,TimerUITests,GoalFlowUITests,ProgressUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 15 tests, with 1 failure (0 unexpected) in 511.427 (511.439) seconds
	 Executed 42 tests, with 1 failure (0 unexpected) in 1619.069 (1619.170) seconds
	 Executed 42 tests, with 1 failure (0 unexpected) in 1619.069 (1619.177) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 127.590 (127.595) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 480.850 (480.855) seconds
	 Executed 7 tests, with 0 failures (0 unexpected) in 241.823 (241.885) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 257.379 (257.389) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/FocusPlayerUITests.swift:396: error: -[HabitsUITests.FocusPlayerUITests testFastNavigationNeverSlidesBack] : XCTAssertTrue failed - Fast navigation: failed · 13 habits · › 150 ms: slid back 0.00, 0 reversals, at 12.00/12, 34 mid-slide, behind up to 1.00 · ‹ 150 ms: slid back 0.00, 0 reversals, at 0.00/0, 37 mid-slide, behind up to 1.00 · › 100 ms: slid back 0.00, 0 reversals, at 12.00/12, 16 mid-slide, behind up to 1.82 · ‹ 100 ms: slid back 0.00, 0 reversals, at 0.00/0, 11 mid-slide, behind up to 1.00 · › 50 ms: slid back 0.00, 0 reversals, at 12.00/12, 3 mid-slide, behind up to 1.00 · ‹ 50 ms: slid back 0.00, 0 reversals, at 0.00/0, 1 mid-slide, behind up to 1.00 · turn › 100 ms: slid back 0.00, 0 reversals, at 12.00/12, 12 mid-slide, behind up to 1.82 · turn ‹ 100 ms: slid back 0.00, 0 reversals, at 0.00/0, 13 mid-slide, behind up to 1.80 · turn › 50 ms: slid back 0.00, 0 reversals, at 12.00/12, 2 mid-slide, behind up to 1.96 · turn ‹ 50 ms: slid back 0.00, 0 reversals, at 0.00/0, 0 mid-slide, behind up to 1.00
Test Case '-[HabitsUITests.FocusPlayerUITests testBottomRowStaysPutAndOptionsShowEverything]' passed (126.594 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testChecklistPreservesPriorStepsAndQueueCanRevisit]' passed (28.410 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCompactProgressAcrossPeriodsAndTypes]' passed (52.960 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCountCheckAndUndoStayOnTheCurrentHabit]' passed (19.588 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testFastNavigationNeverSlidesBack]' failed (34.889 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLargeTextKeepsActionsAndChecklistReachable]' passed (16.640 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLimitIsNotInTheRoutineAndWaitsUnderQuitOrCutDown]' passed (24.070 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testManualTimePausesAndTheClockAlwaysShows]' passed (33.190 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testNavigationDoesNotWaitForSlowTimerWrites]' passed (21.626 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testOnlyALimitShowsUnderQuitOrCutDownWithoutStart]' passed (14.147 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSavedFocusProgressSurvivesTermination]' passed (33.503 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSwipeMovesOneHabitAtATime]' passed (12.961 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerDayBoundaryAndExactUndoPersistence]' passed (6.067 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerGoalDoesNotAutoAdvanceAndManualLogIsReachable]' passed (46.672 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerPauseBackgroundAndSkipPreserveTime]' passed (40.108 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testButtonAddsItsStepAndRowOpensAddAmount]' passed (90.575 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testHowOftenChoicesSayTheAmount]' passed (52.525 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testNumberShowsWithoutAUnit]' passed (47.964 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testOwnStep]' passed (175.758 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testTypingKeyByKey]' passed (85.372 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testUnitScreen]' passed (28.657 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (15.149 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndMilestones]' passed (32.229 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (61.298 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (46.309 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (29.391 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (19.099 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (7.289 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtProgress]' passed (25.419 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (21.197 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarSixWeekMonthAtLargeTextSize]' passed (24.492 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarTotalsAndDaysWithoutHabits]' passed (35.012 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarUpdatesAfterLoggingAndPastNavigation]' passed (27.265 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testChecklistRoutineUsesExistingEntries]' passed (28.034 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testNonTimedRoutineAndSkipDoNotFalselyComplete]' passed (58.224 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testPlayFollowsHeaderRules]' passed (20.999 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testSingleHabitFullCompletionAndUndo]' passed (47.797 seconds).
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (29.390 seconds).
Test Case '-[HabitsUITests.TimerUITests testPlayOpensTimerScreenThatClosesWithoutStopping]' passed (33.126 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (31.798 seconds).
Test Case '-[HabitsUITests.TimerUITests testScreenCanBeTurnedOff]' passed (13.288 seconds).
Test Case '-[HabitsUITests.TimerUITests testTimerScreenPauseKeepsTimeAndResumes]' passed (19.988 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
