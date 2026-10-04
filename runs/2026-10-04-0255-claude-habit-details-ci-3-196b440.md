# claude/habit-details-ci-3 @ 196b440

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37170559109 · 2026-10-04 02:55 UTC
Commit: A skipped habit stays on Today as a neutral "Skipped today" row (it vanished, so Undo Skip had nowhere to be); sheets say Yesterday; NewHabit expects +1 for twice a day

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (TasksUITests,TimerUITests,ProgressUITests,LongTextUITests,FocusPlayerUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 12 tests, with 0 failures (0 unexpected) in 311.821 (311.829) seconds
	 Executed 2 tests, with 0 failures (0 unexpected) in 49.334 (49.335) seconds
	 Executed 29 tests, with 0 failures (0 unexpected) in 884.229 (884.248) seconds
	 Executed 29 tests, with 0 failures (0 unexpected) in 884.229 (884.251) seconds
	 Executed 3 tests, with 0 failures (0 unexpected) in 105.704 (105.705) seconds
	 Executed 3 tests, with 0 failures (0 unexpected) in 187.825 (187.827) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 229.546 (229.550) seconds
Test Case '-[HabitsUITests.FocusPlayerUITests testChecklistPreservesPriorStepsAndQueueCanRevisit]' passed (79.558 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCompactProgressAcrossPeriodsAndTypes]' passed (48.543 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCountCheckAndUndoStayOnTheCurrentHabit]' passed (15.770 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLargeTextKeepsActionsAndChecklistReachable]' passed (14.586 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLimitCheckInNeverLogsConsumptionOrCompletesTheDay]' passed (19.807 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testManualTimePausesAndClockCanBeHidden]' passed (23.915 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testNavigationDoesNotWaitForSlowTimerWrites]' passed (14.708 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSavedFocusProgressSurvivesTermination]' passed (19.857 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSectionWithOnlyALimitStillHasStart]' passed (10.694 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerDayBoundaryAndExactUndoPersistence]' passed (5.665 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerGoalDoesNotAutoAdvanceAndManualLogIsReachable]' passed (29.678 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerPauseBackgroundAndSkipPreserveTime]' passed (29.040 seconds).
Test Case '-[HabitsUITests.LongTextUITests testChooserShowsEverything]' passed (20.974 seconds).
Test Case '-[HabitsUITests.LongTextUITests testFormWithLongText]' passed (83.959 seconds).
Test Case '-[HabitsUITests.LongTextUITests testTodayWithLongText]' passed (82.892 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (15.229 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndMilestones]' passed (34.878 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (56.676 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (38.917 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (21.714 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (15.315 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (5.176 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtProgress]' passed (23.816 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (17.825 seconds).
Test Case '-[HabitsUITests.TasksUITests testCreateTaskFromTasksAndEditSurvivesRelaunch]' passed (39.159 seconds).
Test Case '-[HabitsUITests.TasksUITests testEveryTaskAppearsAndCanOpenEdit]' passed (61.105 seconds).
Test Case '-[HabitsUITests.TasksUITests testTaskModelAndPersistence]' passed (5.439 seconds).
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (21.477 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (27.857 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
