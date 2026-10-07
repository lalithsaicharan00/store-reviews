# day-details-logs-notes-redesign-ci-c @ aa6ee1e

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37624444958 · 2026-10-07 13:41 UTC
Commit: Day details on the iPhone SE: 44-pt buttons and rows, the first and logs gaps as designed

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (FocusPlayerUITests,RoutineCalendarUITests,TimerUITests,GoalFlowUITests,ProgressUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 15 tests, with 1 failure (0 unexpected) in 521.756 (521.772) seconds
	 Executed 42 tests, with 1 failure (0 unexpected) in 1607.848 (1607.895) seconds
	 Executed 42 tests, with 1 failure (0 unexpected) in 1607.848 (1607.896) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 118.377 (118.381) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 439.415 (439.424) seconds
	 Executed 7 tests, with 0 failures (0 unexpected) in 238.543 (238.548) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 289.756 (289.767) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/FocusPlayerUITests.swift:151: error: -[HabitsUITests.FocusPlayerUITests testTimerPauseBackgroundAndSkipPreserveTime] : XCTAssertEqual failed: ("0:12 / 20 min") is not equal to ("0:10 / 20 min")
Test Case '-[HabitsUITests.FocusPlayerUITests testBottomRowStaysPutAndOptionsShowEverything]' passed (69.890 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testChecklistPreservesPriorStepsAndQueueCanRevisit]' passed (27.050 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCompactProgressAcrossPeriodsAndTypes]' passed (67.607 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCountCheckAndUndoStayOnTheCurrentHabit]' passed (20.799 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testFastNavigationNeverSlidesBack]' passed (36.732 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLargeTextKeepsActionsAndChecklistReachable]' passed (20.025 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLimitIsNotInTheRoutineAndWaitsUnderQuitOrCutDown]' passed (27.127 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testManualTimePausesAndTheClockAlwaysShows]' passed (58.070 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testNavigationDoesNotWaitForSlowTimerWrites]' passed (26.919 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testOnlyALimitShowsUnderQuitOrCutDownWithoutStart]' passed (13.183 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSavedFocusProgressSurvivesTermination]' passed (33.078 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSwipeMovesOneHabitAtATime]' passed (20.069 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerDayBoundaryAndExactUndoPersistence]' passed (8.418 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerGoalDoesNotAutoAdvanceAndManualLogIsReachable]' passed (52.222 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerPauseBackgroundAndSkipPreserveTime]' failed (40.566 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testButtonAddsItsStepAndRowOpensAddAmount]' passed (92.752 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testHowOftenChoicesSayTheAmount]' passed (77.932 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testNumberShowsWithoutAUnit]' passed (61.684 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testOwnStep]' passed (69.094 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testTypingKeyByKey]' passed (96.589 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testUnitScreen]' passed (41.364 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (14.082 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndMilestones]' passed (38.708 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (72.367 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (52.800 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (29.116 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (19.776 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (10.237 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtProgress]' passed (29.750 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (22.919 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarSixWeekMonthAtLargeTextSize]' passed (25.100 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarTotalsAndDaysWithoutHabits]' passed (43.329 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarUpdatesAfterLoggingAndPastNavigation]' passed (30.118 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testChecklistRoutineUsesExistingEntries]' passed (22.945 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testNonTimedRoutineAndSkipDoNotFalselyComplete]' passed (51.420 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testPlayFollowsHeaderRules]' passed (21.307 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testSingleHabitFullCompletionAndUndo]' passed (44.323 seconds).
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (29.832 seconds).
Test Case '-[HabitsUITests.TimerUITests testPlayOpensTimerScreenThatClosesWithoutStopping]' passed (31.049 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (26.054 seconds).
Test Case '-[HabitsUITests.TimerUITests testScreenCanBeTurnedOff]' passed (11.440 seconds).
Test Case '-[HabitsUITests.TimerUITests testTimerScreenPauseKeepsTimeAndResumes]' passed (20.002 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
