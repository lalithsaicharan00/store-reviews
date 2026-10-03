# claude/habit-details-ci-3 @ 78a11e4

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37141084390 · 2026-10-03 18:27 UTC
Commit: Today's rows: a tap opens the Day sheet for the day shown; ✓ toggles that day's tick, + adds; swipes reveal Note/Skip/Pause and a named Undo; long press matches the sheet; Delete only in the sheet's ⋯ menu; done habits stay in place

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (HabitPageUITests,WeekCardsUITests,FocusPlayerUITests,RoutineCalendarUITests,SectionHeaderUITests,PlacementUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 12 tests, with 0 failures (0 unexpected) in 438.483 (438.497) seconds
	 Executed 36 tests, with 0 failures (0 unexpected) in 2091.071 (2091.119) seconds
	 Executed 36 tests, with 0 failures (0 unexpected) in 2091.071 (2091.121) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 893.512 (893.525) seconds
	 Executed 7 tests, with 0 failures (0 unexpected) in 250.135 (250.141) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 467.561 (467.568) seconds
Test Case '-[HabitsUITests.FocusPlayerUITests testChecklistPreservesPriorStepsAndQueueCanRevisit]' passed (66.691 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCompactProgressAcrossPeriodsAndTypes]' passed (70.454 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCountCheckAndUndoStayOnTheCurrentHabit]' passed (20.295 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLargeTextKeepsActionsAndChecklistReachable]' passed (26.461 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLimitCheckInNeverLogsConsumptionOrCompletesTheDay]' passed (31.029 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testManualTimePausesAndClockCanBeHidden]' passed (37.725 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testNavigationDoesNotWaitForSlowTimerWrites]' passed (22.004 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSavedFocusProgressSurvivesTermination]' passed (33.579 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSectionWithOnlyALimitStillHasStart]' passed (14.968 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerDayBoundaryAndExactUndoPersistence]' passed (7.323 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerGoalDoesNotAutoAdvanceAndManualLogIsReachable]' passed (62.522 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerPauseBackgroundAndSkipPreserveTime]' passed (45.433 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testHistoryFlows]' passed (83.064 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFlows]' passed (55.812 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDailyTypes]' passed (309.902 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDark]' passed (140.540 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesPeriodLimitQuit]' passed (248.895 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testYearInPixels]' passed (55.300 seconds).
Test Case '-[HabitsUITests.PlacementUITests testPlacementRules]' passed (7.560 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarSixWeekMonthAtLargeTextSize]' passed (27.594 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarTotalsAndDaysWithoutHabits]' passed (35.995 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarUpdatesAfterLoggingAndPastNavigation]' passed (30.691 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testChecklistRoutineUsesExistingEntries]' passed (26.645 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testNonTimedRoutineAndSkipDoNotFalselyComplete]' passed (55.497 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testPlayFollowsHeaderRules]' passed (22.868 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testSingleHabitFullCompletionAndUndo]' passed (50.844 seconds).
Test Case '-[HabitsUITests.SectionHeaderUITests testHeaders]' passed (33.821 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testHabitPageDark]' passed (53.316 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCards]' passed (42.148 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCardsDark]' passed (26.297 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsDark]' passed (69.961 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsLight]' passed (79.268 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsWithGroups]' passed (24.964 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCards]' passed (72.613 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCardsDark]' passed (36.633 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearScrollAndHabitPage]' passed (62.361 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
