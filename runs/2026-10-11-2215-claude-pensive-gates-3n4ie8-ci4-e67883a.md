# claude/pensive-gates-3n4ie8-ci4 @ e67883a

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38172270422 · 2026-10-11 22:15 UTC
Commit: Merge main (the Apple Watch app, Google Drive sync in the core, docs) into the iPad build

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (OnboardingUITests,HabitPageUITests,ArrangeUITests,FocusPlayerUITests,RemindersUITests,TasksUITests): cancelled
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 15 tests, with 0 failures (0 unexpected) in 431.146 (431.160) seconds
	 Executed 5 tests, with 1 failure (0 unexpected) in 287.723 (287.754) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ArrangeUITests.swift:117: error: -[HabitsUITests.ArrangeUITests testAddTimeOfDay] : XCTAssertTrue failed - The new one in Your day
Test Case '-[HabitsUITests.ArrangeUITests testAddTimeOfDay]' failed (55.142 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testArrangeChecks]' passed (72.103 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testEditArrangesTheDay]' passed (90.536 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testGroupRowBeforeAnyGroup]' passed (35.895 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testHideCompleted]' passed (34.047 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testBottomRowStaysPutAndOptionsShowEverything]' passed (41.207 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testChecklistPreservesPriorStepsAndQueueCanRevisit]' passed (31.520 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCompactProgressAcrossPeriodsAndTypes]' passed (57.637 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCountCheckAndUndoStayOnTheCurrentHabit]' passed (20.131 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testFastNavigationNeverSlidesBack]' passed (35.467 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLargeTextKeepsActionsAndChecklistReachable]' passed (17.133 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLimitIsNotInTheRoutineAndWaitsUnderQuitOrCutDown]' passed (23.465 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testManualTimePausesAndTheClockAlwaysShows]' passed (33.002 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testNavigationDoesNotWaitForSlowTimerWrites]' passed (18.598 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testOnlyALimitShowsUnderQuitOrCutDownWithoutStart]' passed (11.396 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSavedFocusProgressSurvivesTermination]' passed (26.599 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSwipeMovesOneHabitAtATime]' passed (16.372 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerDayBoundaryAndExactUndoPersistence]' passed (7.425 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerGoalDoesNotAutoAdvanceAndManualLogIsReachable]' passed (47.566 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerPauseBackgroundAndSkipPreserveTime]' passed (43.629 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testHistoryFlows]' passed (49.083 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testMilestonesNoneOneMany]' passed (110.368 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFlows]' passed (46.983 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFoldByMonthLikeHistory]' passed (43.759 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNoteViewEditAndDelete]' passed (62.930 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testOverallRecordBoxes]' passed (25.675 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPeriodCardSpacing]' passed (192.862 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDailyTypes]' passed (288.078 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDark]' passed (121.974 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesPeriodLimitQuit]' passed (242.134 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
