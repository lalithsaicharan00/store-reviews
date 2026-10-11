# claude/pensive-gates-3n4ie8-ci5 @ c5b1da3

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38131142188 · 2026-10-11 12:50 UTC
Commit: Current Work 86/88: Day details' popover hangs on Today, pointing at its row; iPad tests; iPad speed runs; coming back to the iPhone

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (ArrangeUITests,FocusPlayerUITests,PlacementUITests,ScheduleUITests,SectionHeaderUITests,TodayRowLayoutUITests,TodayRowSheetUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 15 tests, with 0 failures (0 unexpected) in 371.518 (371.526) seconds
	 Executed 38 tests, with 0 failures (0 unexpected) in 1064.505 (1064.538) seconds
	 Executed 38 tests, with 0 failures (0 unexpected) in 1064.505 (1064.539) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 79.879 (79.881) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 265.006 (265.011) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 154.052 (154.058) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 161.494 (161.497) seconds
Test Case '-[HabitsUITests.ArrangeUITests testAddTimeOfDay]' passed (81.457 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testArrangeChecks]' passed (8.048 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testEditArrangesTheDay]' passed (99.414 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testGroupRowBeforeAnyGroup]' passed (41.342 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testHideCompleted]' passed (34.745 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testBottomRowStaysPutAndOptionsShowEverything]' passed (40.892 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testChecklistPreservesPriorStepsAndQueueCanRevisit]' passed (27.585 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCompactProgressAcrossPeriodsAndTypes]' passed (47.671 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCountCheckAndUndoStayOnTheCurrentHabit]' passed (19.823 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testFastNavigationNeverSlidesBack]' passed (32.799 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLargeTextKeepsActionsAndChecklistReachable]' passed (16.152 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLimitIsNotInTheRoutineAndWaitsUnderQuitOrCutDown]' passed (23.841 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testManualTimePausesAndTheClockAlwaysShows]' passed (27.534 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testNavigationDoesNotWaitForSlowTimerWrites]' passed (16.276 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testOnlyALimitShowsUnderQuitOrCutDownWithoutStart]' passed (9.582 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSavedFocusProgressSurvivesTermination]' passed (22.486 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSwipeMovesOneHabitAtATime]' passed (11.884 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerDayBoundaryAndExactUndoPersistence]' passed (5.611 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerGoalDoesNotAutoAdvanceAndManualLogIsReachable]' passed (39.588 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerPauseBackgroundAndSkipPreserveTime]' passed (29.794 seconds).
Test Case '-[HabitsUITests.PlacementUITests testPlacementRules]' passed (5.874 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testCalendarAndPersistenceRules]' passed (5.790 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testEveryFewDaysAndWeeks]' passed (30.224 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testLargeTextHowOften]' passed (27.222 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testMonthDatesAndShortMonths]' passed (31.046 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testTaskAfterCompletion]' passed (21.946 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testYearlyDateAndLeapDay]' passed (45.264 seconds).
Test Case '-[HabitsUITests.SectionHeaderUITests testHeaders]' passed (26.683 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testAfterLogButtonsAndNoteSheet]' passed (26.752 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testOneLineUnderEveryName]' passed (10.393 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testQuitRowSwipeLogsASlip]' passed (15.882 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testTaskRowOpensItsSheet]' passed (26.852 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testLongPressMenu]' passed (16.950 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testRowOpensDaySheetForEveryKind]' passed (31.902 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetActionsAndDeleteInTheMenu]' passed (29.819 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetFollowsTheDayShown]' passed (19.686 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSwipeActions]' passed (26.474 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testTickTogglesAndPlusAdds]' passed (29.221 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
