# claude/habit-details-ci @ 2c42b97

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37176337638 · 2026-10-04 04:50 UTC
Commit: Checklists: Next Up 7, 8, 13 and 21 done (18's mental-model part), the row sheet and row layout checklists ticked, the merge recorded (the user's one-time decision; W3 stands)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (HabitPageUITests,WeekCardsUITests,FocusPlayerUITests,SectionHeaderUITests,PlacementUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 12 tests, with 0 failures (0 unexpected) in 316.372 (316.391) seconds
	 Executed 29 tests, with 0 failures (0 unexpected) in 1517.124 (1517.170) seconds
	 Executed 29 tests, with 0 failures (0 unexpected) in 1517.124 (1517.172) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 738.863 (738.874) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 428.785 (428.794) seconds
Test Case '-[HabitsUITests.FocusPlayerUITests testChecklistPreservesPriorStepsAndQueueCanRevisit]' passed (25.136 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCompactProgressAcrossPeriodsAndTypes]' passed (44.608 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCountCheckAndUndoStayOnTheCurrentHabit]' passed (23.166 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLargeTextKeepsActionsAndChecklistReachable]' passed (22.374 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLimitCheckInNeverLogsConsumptionOrCompletesTheDay]' passed (22.808 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testManualTimePausesAndClockCanBeHidden]' passed (27.727 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testNavigationDoesNotWaitForSlowTimerWrites]' passed (20.575 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSavedFocusProgressSurvivesTermination]' passed (24.248 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSectionWithOnlyALimitStillHasStart]' passed (11.745 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerDayBoundaryAndExactUndoPersistence]' passed (6.154 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerGoalDoesNotAutoAdvanceAndManualLogIsReachable]' passed (44.043 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerPauseBackgroundAndSkipPreserveTime]' passed (43.789 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testHistoryFlows]' passed (57.764 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFlows]' passed (44.537 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDailyTypes]' passed (266.539 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDark]' passed (110.676 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesPeriodLimitQuit]' passed (219.773 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testYearInPixels]' passed (39.573 seconds).
Test Case '-[HabitsUITests.PlacementUITests testPlacementRules]' passed (6.254 seconds).
Test Case '-[HabitsUITests.SectionHeaderUITests testHeaders]' passed (26.850 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testHabitPageDark]' passed (46.215 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCards]' passed (40.429 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCardsDark]' passed (25.217 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsDark]' passed (64.184 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsLight]' passed (72.129 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsWithGroups]' passed (20.549 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCards]' passed (69.896 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCardsDark]' passed (32.894 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearScrollAndHabitPage]' passed (57.274 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
