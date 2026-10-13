# claude/shared-habit-rules-ci43 @ 41045ec

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38329439841 · 2026-10-13 03:31 UTC
Commit: Current Work 92 (checkpoint 2): the shared rules are given their inputs without SwiftUI seeing it; the Watch keeps its Swift rules

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (FocusPlayerUITests,NewHabitUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 15 tests, with 1 failure (0 unexpected) in 459.221 (459.233) seconds
	 Executed 20 tests, with 1 failure (0 unexpected) in 1017.506 (1017.518) seconds
	 Executed 35 tests, with 2 failures (0 unexpected) in 1476.727 (1476.753) seconds
	 Executed 35 tests, with 2 failures (0 unexpected) in 1476.727 (1476.755) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/FocusPlayerUITests.swift:410: error: -[HabitsUITests.FocusPlayerUITests testSwipeMovesOneHabitAtATime] : failed - Expected the page for Drink water alone; found ["Stretch"]
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/NewHabitUITests.swift:322: error: -[HabitsUITests.NewHabitUITests testLimitCanBeAWeeklyTotal] : XCTAssertEqual failed: ("Optional("2")") is not equal to ("Optional("20")")
Test Case '-[HabitsUITests.FocusPlayerUITests testBottomRowStaysPutAndOptionsShowEverything]' passed (54.929 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testChecklistPreservesPriorStepsAndQueueCanRevisit]' passed (23.478 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCompactProgressAcrossPeriodsAndTypes]' passed (64.747 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCountCheckAndUndoStayOnTheCurrentHabit]' passed (20.015 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testFastNavigationNeverSlidesBack]' passed (37.536 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLargeTextKeepsActionsAndChecklistReachable]' passed (17.712 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLimitIsNotInTheRoutineAndWaitsUnderQuitOrCutDown]' passed (23.428 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testManualTimePausesAndTheClockAlwaysShows]' passed (38.688 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testNavigationDoesNotWaitForSlowTimerWrites]' passed (21.095 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testOnlyALimitShowsUnderQuitOrCutDownWithoutStart]' passed (12.982 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSavedFocusProgressSurvivesTermination]' passed (32.217 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSwipeMovesOneHabitAtATime]' failed (20.011 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerDayBoundaryAndExactUndoPersistence]' passed (8.087 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerGoalDoesNotAutoAdvanceAndManualLogIsReachable]' passed (46.552 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerPauseBackgroundAndSkipPreserveTime]' passed (37.745 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAmountWithReminderRemoved]' passed (98.992 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAnytimeNeverCombines]' passed (47.050 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCertainDaysReadAsARange]' passed (51.449 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testChecklist]' passed (48.231 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffInTwoTimesOfDay]' passed (84.679 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffThreeTimesAWeek]' passed (44.504 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCopyChecks]' passed (16.916 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCustomUnit]' passed (49.109 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testDatesOfTheMonth]' passed (47.093 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testIconSheetClosesOnPick]' passed (36.688 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeAWeeklyTotal]' failed (31.512 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeTimeAndStaysEditable]' passed (79.056 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testNewTimeOfDayFromTheForm]' passed (52.119 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testOneTimeTask]' passed (30.032 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testQuitDiscard]' passed (30.968 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testReadTwoChaptersAWeek]' passed (65.700 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRemindMeOffHidesTheRest]' passed (43.972 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRunFiveMilesAndWalkTenThousandSteps]' passed (86.117 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTimeUnit]' passed (42.170 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTwoCertainDays]' passed (31.149 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
