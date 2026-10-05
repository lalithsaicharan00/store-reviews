# claude/timer-swipe-limits-and-fixes @ c9909e6

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37262115569 · 2026-10-05 05:07 UTC
Commit: Today: limits leave the times of day and join quit habits in one "Quit or Cut Down" card; Cut down has no Time of Day (Current Work 14)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (FocusPlayerUITests,NewHabitUITests,HabitCreationUITests,HabitScenarioUITests,TodayUITests,LongTextUITests,RoutineCalendarUITests,GroupsUITests): cancelled
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 13 tests, with 2 failures (0 unexpected) in 406.365 (406.378) seconds
	 Executed 6 tests, with 2 failures (0 unexpected) in 832.882 (832.886) seconds
	 Executed 8 tests, with 1 failure (0 unexpected) in 853.311 (853.318) seconds
	 Executed 9 tests, with 1 failure (0 unexpected) in 420.958 (420.963) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/FocusPlayerUITests.swift:35: error: -[HabitsUITests.FocusPlayerUITests testBottomRowStaysPutAndOptionsShowEverything] : failed - Expected the page for Clean kitchen alone; found ["Drink water"]
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/FocusPlayerUITests.swift:365: error: -[HabitsUITests.FocusPlayerUITests testNavigationDoesNotWaitForSlowTimerWrites] : failed - Expected the page for Less coffee alone; found ["Water the plants"]
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/GroupsUITests.swift:330: error: -[HabitsUITests.GroupsUITests testGroupOrderIsThePersonsOwn] : XCTAssertTrue failed - Your order, with Sort A to Z
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitCreationUITests.swift:192: error: -[HabitsUITests.HabitCreationUITests testSetDayShapes] : Failed to tap "Monday" Button: No matches found for first query match sequence: `Descendants matching type Button` -> `Elements matching predicate '"Monday" IN identifiers'`, given input App element pid: 82494
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitCreationUITests.swift:43: error: -[HabitsUITests.HabitCreationUITests testSetDayShapes] : XCTAssertTrue failed - Can't find "Monday" Button
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitScenarioUITests.swift:108: error: -[HabitsUITests.HabitScenarioUITests testDaySets] : Failed to tap "Monday" Button: No matches found for first query match sequence: `Descendants matching type Button` -> `Elements matching predicate '"Monday" IN identifiers'`, given input App element pid: 2290
Test Case '-[HabitsUITests.FocusPlayerUITests testBottomRowStaysPutAndOptionsShowEverything]' failed (83.339 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testChecklistPreservesPriorStepsAndQueueCanRevisit]' passed (29.280 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCompactProgressAcrossPeriodsAndTypes]' passed (49.634 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCountCheckAndUndoStayOnTheCurrentHabit]' passed (17.192 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLargeTextKeepsActionsAndChecklistReachable]' passed (18.234 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLimitIsNotInTheRoutineAndWaitsUnderQuitOrCutDown]' passed (28.076 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testManualTimePausesAndClockCanBeHidden]' passed (31.951 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testNavigationDoesNotWaitForSlowTimerWrites]' failed (23.143 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testOnlyALimitShowsUnderQuitOrCutDownWithoutStart]' passed (9.729 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSavedFocusProgressSurvivesTermination]' passed (27.512 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerDayBoundaryAndExactUndoPersistence]' passed (11.211 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerGoalDoesNotAutoAdvanceAndManualLogIsReachable]' passed (44.442 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerPauseBackgroundAndSkipPreserveTime]' passed (32.623 seconds).
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (34.217 seconds).
Test Case '-[HabitsUITests.GroupsUITests testDeletingAGroupKeepsItsHabits]' passed (51.983 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (75.956 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' passed (51.333 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (67.974 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupOrderIsThePersonsOwn]' failed (30.282 seconds).
Test Case '-[HabitsUITests.GroupsUITests testNamesAreUniqueAndAGroupCanPause]' passed (40.865 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (35.880 seconds).
Test Case '-[HabitsUITests.GroupsUITests testTodayAndProgressKeepTheirOwnChoiceAndStartPlaysWhatsShown]' passed (32.466 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testBigNumbers]' passed (66.418 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testDailyShapes]' passed (116.388 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testMonthAndYearShapes]' passed (250.725 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testOtherTypes]' passed (174.362 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testSetDayShapes]' failed (82.145 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testWeeklyShapes]' passed (142.844 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testCountsAndAmounts]' passed (192.286 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testCutDown]' passed (44.492 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testDaySets]' failed (46.204 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testDaySetsNamedAndAll]' passed (147.600 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testEachTypeStartsWithDefaults]' passed (74.766 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testLongest]' passed (46.667 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testMonthDateSets]' passed (234.196 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testStartsAndEnds]' passed (67.100 seconds).
Test Case '-[HabitsUITests.LongTextUITests testChooserShowsEverything]' passed (76.134 seconds).
Test Case '-[HabitsUITests.LongTextUITests testFormWithLongText]' passed (138.775 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
