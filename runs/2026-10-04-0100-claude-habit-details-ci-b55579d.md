# claude/habit-details-ci @ b55579d

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37164552881 · 2026-10-04 01:00 UTC
Commit: Today rows: only named accessibility actions on a row's container (a default action or hint merged the texts, so names stopped reading as text); HabitCreation expects +1 for twice a day (U14)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (HabitPageUITests,WeekCardsUITests,FocusPlayerUITests,RoutineCalendarUITests,SectionHeaderUITests,PlacementUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 12 tests, with 0 failures (0 unexpected) in 299.514 (299.525) seconds
	 Executed 36 tests, with 0 failures (0 unexpected) in 1703.961 (1703.994) seconds
	 Executed 36 tests, with 0 failures (0 unexpected) in 1703.961 (1703.996) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 771.551 (771.557) seconds
	 Executed 7 tests, with 0 failures (0 unexpected) in 202.083 (202.088) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 399.929 (399.933) seconds
Test Case '-[HabitsUITests.FocusPlayerUITests testChecklistPreservesPriorStepsAndQueueCanRevisit]' passed (26.987 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCompactProgressAcrossPeriodsAndTypes]' passed (87.639 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCountCheckAndUndoStayOnTheCurrentHabit]' passed (17.441 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLargeTextKeepsActionsAndChecklistReachable]' passed (14.261 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLimitCheckInNeverLogsConsumptionOrCompletesTheDay]' passed (18.248 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testManualTimePausesAndClockCanBeHidden]' passed (24.191 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testNavigationDoesNotWaitForSlowTimerWrites]' passed (14.864 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSavedFocusProgressSurvivesTermination]' passed (21.336 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSectionWithOnlyALimitStillHasStart]' passed (10.277 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerDayBoundaryAndExactUndoPersistence]' passed (5.279 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerGoalDoesNotAutoAdvanceAndManualLogIsReachable]' passed (28.530 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerPauseBackgroundAndSkipPreserveTime]' passed (30.462 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testHistoryFlows]' passed (45.822 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFlows]' passed (58.673 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDailyTypes]' passed (307.772 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDark]' passed (110.166 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesPeriodLimitQuit]' passed (207.400 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testYearInPixels]' passed (41.718 seconds).
Test Case '-[HabitsUITests.PlacementUITests testPlacementRules]' passed (6.413 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarSixWeekMonthAtLargeTextSize]' passed (23.679 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarTotalsAndDaysWithoutHabits]' passed (30.915 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarUpdatesAfterLoggingAndPastNavigation]' passed (24.999 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testChecklistRoutineUsesExistingEntries]' passed (20.675 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testNonTimedRoutineAndSkipDoNotFalselyComplete]' passed (42.757 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testPlayFollowsHeaderRules]' passed (19.940 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testSingleHabitFullCompletionAndUndo]' passed (39.117 seconds).
Test Case '-[HabitsUITests.SectionHeaderUITests testHeaders]' passed (24.472 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testHabitPageDark]' passed (42.832 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCards]' passed (38.566 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCardsDark]' passed (22.770 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsDark]' passed (62.742 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsLight]' passed (66.673 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsWithGroups]' passed (18.877 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCards]' passed (64.966 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCardsDark]' passed (31.531 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearScrollAndHabitPage]' passed (50.970 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
