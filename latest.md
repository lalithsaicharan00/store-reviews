# claude/shared-habit-rules-ci21 @ 7087be7

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38261603238 · 2026-10-12 17:09 UTC
Commit: Merge remote-tracking branch 'origin/main' into claude/shared-habit-rules-switch

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (FocusPlayerUITests,NewHabitUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 15 tests, with 0 failures (0 unexpected) in 477.432 (477.442) seconds
	 Executed 20 tests, with 0 failures (0 unexpected) in 1071.279 (1071.304) seconds
	 Executed 35 tests, with 0 failures (0 unexpected) in 1548.711 (1548.748) seconds
	 Executed 35 tests, with 0 failures (0 unexpected) in 1548.711 (1548.750) seconds
Test Case '-[HabitsUITests.FocusPlayerUITests testBottomRowStaysPutAndOptionsShowEverything]' passed (88.791 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testChecklistPreservesPriorStepsAndQueueCanRevisit]' passed (21.698 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCompactProgressAcrossPeriodsAndTypes]' passed (66.361 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCountCheckAndUndoStayOnTheCurrentHabit]' passed (21.291 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testFastNavigationNeverSlidesBack]' passed (36.312 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLargeTextKeepsActionsAndChecklistReachable]' passed (16.080 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLimitIsNotInTheRoutineAndWaitsUnderQuitOrCutDown]' passed (26.273 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testManualTimePausesAndTheClockAlwaysShows]' passed (40.061 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testNavigationDoesNotWaitForSlowTimerWrites]' passed (20.084 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testOnlyALimitShowsUnderQuitOrCutDownWithoutStart]' passed (10.736 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSavedFocusProgressSurvivesTermination]' passed (27.866 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSwipeMovesOneHabitAtATime]' passed (14.715 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerDayBoundaryAndExactUndoPersistence]' passed (6.797 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerGoalDoesNotAutoAdvanceAndManualLogIsReachable]' passed (45.672 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerPauseBackgroundAndSkipPreserveTime]' passed (34.695 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAmountWithReminderRemoved]' passed (120.487 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAnytimeNeverCombines]' passed (49.224 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCertainDaysReadAsARange]' passed (47.513 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testChecklist]' passed (52.202 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffInTwoTimesOfDay]' passed (90.722 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffThreeTimesAWeek]' passed (42.627 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCopyChecks]' passed (15.263 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCustomUnit]' passed (47.504 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testDatesOfTheMonth]' passed (53.756 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testIconSheetClosesOnPick]' passed (37.711 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeAWeeklyTotal]' passed (50.343 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeTimeAndStaysEditable]' passed (71.284 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testNewTimeOfDayFromTheForm]' passed (50.894 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testOneTimeTask]' passed (25.994 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testQuitDiscard]' passed (28.863 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testReadTwoChaptersAWeek]' passed (63.478 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRemindMeOffHidesTheRest]' passed (50.308 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRunFiveMilesAndWalkTenThousandSteps]' passed (95.027 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTimeUnit]' passed (44.855 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTwoCertainDays]' passed (33.226 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
