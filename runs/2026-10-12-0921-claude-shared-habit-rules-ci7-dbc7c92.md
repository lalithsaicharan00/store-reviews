# claude/shared-habit-rules-ci7 @ dbc7c92

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38216896877 · 2026-10-12 09:21 UTC
Commit: Current Work 92 (checkpoint 2): returns where a body stopped being one expression; import Core in +Phase2

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (WeekCardsUITests,TodayRowSheetUITests,FocusPlayerUITests,RemindersUITests,NewHabitUITests,SectionHeaderUITests): cancelled
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 15 tests, with 0 failures (0 unexpected) in 494.543 (494.609) seconds
	 Executed 20 tests, with 0 failures (0 unexpected) in 1115.447 (1115.470) seconds
Test Case '-[HabitsUITests.FocusPlayerUITests testBottomRowStaysPutAndOptionsShowEverything]' passed (63.474 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testChecklistPreservesPriorStepsAndQueueCanRevisit]' passed (35.781 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCompactProgressAcrossPeriodsAndTypes]' passed (71.732 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCountCheckAndUndoStayOnTheCurrentHabit]' passed (23.008 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testFastNavigationNeverSlidesBack]' passed (37.264 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLargeTextKeepsActionsAndChecklistReachable]' passed (20.980 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLimitIsNotInTheRoutineAndWaitsUnderQuitOrCutDown]' passed (27.791 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testManualTimePausesAndTheClockAlwaysShows]' passed (42.277 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testNavigationDoesNotWaitForSlowTimerWrites]' passed (19.949 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testOnlyALimitShowsUnderQuitOrCutDownWithoutStart]' passed (12.755 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSavedFocusProgressSurvivesTermination]' passed (32.308 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSwipeMovesOneHabitAtATime]' passed (17.638 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerDayBoundaryAndExactUndoPersistence]' passed (6.924 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerGoalDoesNotAutoAdvanceAndManualLogIsReachable]' passed (46.294 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerPauseBackgroundAndSkipPreserveTime]' passed (36.367 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAmountWithReminderRemoved]' passed (106.835 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAnytimeNeverCombines]' passed (61.479 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCertainDaysReadAsARange]' passed (48.150 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testChecklist]' passed (67.563 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffInTwoTimesOfDay]' passed (98.823 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffThreeTimesAWeek]' passed (50.786 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCopyChecks]' passed (14.822 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCustomUnit]' passed (48.644 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testDatesOfTheMonth]' passed (41.298 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testIconSheetClosesOnPick]' passed (33.841 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeAWeeklyTotal]' passed (47.185 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeTimeAndStaysEditable]' passed (79.879 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testNewTimeOfDayFromTheForm]' passed (59.280 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testOneTimeTask]' passed (26.682 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testQuitDiscard]' passed (29.093 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testReadTwoChaptersAWeek]' passed (67.060 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRemindMeOffHidesTheRest]' passed (45.112 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRunFiveMilesAndWalkTenThousandSteps]' passed (96.934 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTimeUnit]' passed (49.913 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTwoCertainDays]' passed (42.069 seconds).
Test Case '-[HabitsUITests.RemindersUITests testDeniedPermissionOffersSettingsAndEmptyState]' passed (12.777 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
