# archive/animations-and-settings-2026-10-01 @ 369834b

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36820863911 · 2026-10-01 06:09 UTC
Commit: Animations and Settings checklist: the Progress speed question is answered (not this branch)

- Build: success
- UI tests (GoalFlowUITests,HabitCreationUITests,FocusPlayerUITests): failure
- Speed tests: skipped

## UI tests
```
	 Executed 12 tests, with 8 failures (0 unexpected) in 267.195 (267.206) seconds
	 Executed 24 tests, with 10 failures (0 unexpected) in 1306.079 (1306.101) seconds
	 Executed 24 tests, with 10 failures (0 unexpected) in 1306.079 (1306.102) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 759.502 (759.508) seconds
	 Executed 6 tests, with 2 failures (0 unexpected) in 279.382 (279.385) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/FocusPlayerUITests.swift:100: error: -[HabitsUITests.FocusPlayerUITests testTimerPauseBackgroundAndSkipPreserveTime] : Failed to get matching snapshot: No matches found for Elements matching predicate '"focus-clock-value" IN identifiers' from input {(
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/FocusPlayerUITests.swift:135: error: -[HabitsUITests.FocusPlayerUITests testTimerGoalDoesNotAutoAdvanceAndManualLogIsReachable] : Failed to tap "Add" Button: No matches found for Elements matching predicate '"Add" IN identifiers' from input {(
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/FocusPlayerUITests.swift:203: error: -[HabitsUITests.FocusPlayerUITests testManualTimePausesAndClockCanBeHidden] : XCTAssertFalse failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/FocusPlayerUITests.swift:223: error: -[HabitsUITests.FocusPlayerUITests testCompactProgressAcrossPeriodsAndTypes] : Failed to get matching snapshot: No matches found for Elements matching predicate '"focus-clock-value" IN identifiers' from input {(
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/FocusPlayerUITests.swift:261: error: -[HabitsUITests.FocusPlayerUITests testNavigationDoesNotWaitForSlowTimerWrites] : Failed to get matching snapshot: Find single matching element. Multiple matching elements found for <XCUIElementQuery: 0x113fd8910>.
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/FocusPlayerUITests.swift:50: error: -[HabitsUITests.FocusPlayerUITests testCountCheckAndUndoStayOnTheCurrentHabit] : Failed to get matching snapshot: Find single matching element. Multiple matching elements found for <XCUIElementQuery: 0x113fd8500>.
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/FocusPlayerUITests.swift:71: error: -[HabitsUITests.FocusPlayerUITests testChecklistPreservesPriorStepsAndQueueCanRevisit] : Failed to get matching snapshot: Find single matching element. Multiple matching elements found for <XCUIElementQuery: 0x113fd8050>.
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/FocusPlayerUITests.swift:84: error: -[HabitsUITests.FocusPlayerUITests testLimitCheckInNeverLogsConsumptionOrCompletesTheDay] : Failed to get matching snapshot: Find single matching element. Multiple matching elements found for <XCUIElementQuery: 0x113fd8640>.
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/GoalFlowUITests.swift:126: error: -[HabitsUITests.GoalFlowUITests testTypingKeyByKey] : Failed to tap "Add" Button: No matches found for Elements matching predicate '"Add Amount" IN identifiers' from input {(
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/GoalFlowUITests.swift:168: error: -[HabitsUITests.GoalFlowUITests testButtonAddsItsStepAndRowOpensAddAmount] : XCTAssertTrue failed - The row opens Add Amount
Test Case '-[HabitsUITests.FocusPlayerUITests testChecklistPreservesPriorStepsAndQueueCanRevisit]' failed (70.300 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCompactProgressAcrossPeriodsAndTypes]' failed (29.441 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCountCheckAndUndoStayOnTheCurrentHabit]' failed (14.252 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLargeTextKeepsActionsAndChecklistReachable]' passed (14.198 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLimitCheckInNeverLogsConsumptionOrCompletesTheDay]' failed (16.880 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testManualTimePausesAndClockCanBeHidden]' failed (24.788 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testNavigationDoesNotWaitForSlowTimerWrites]' failed (17.885 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSavedFocusProgressSurvivesTermination]' passed (18.452 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSectionWithOnlyALimitStillHasStart]' passed (9.941 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerDayBoundaryAndExactUndoPersistence]' passed (5.208 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerGoalDoesNotAutoAdvanceAndManualLogIsReachable]' failed (27.694 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerPauseBackgroundAndSkipPreserveTime]' failed (18.154 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testButtonAddsItsStepAndRowOpensAddAmount]' failed (53.677 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testHowOftenChoicesSayTheAmount]' passed (46.459 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testNumberShowsWithoutAUnit]' passed (40.162 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testOwnStep]' passed (45.871 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testTypingKeyByKey]' failed (68.360 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testUnitScreen]' passed (24.853 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testBigNumbers]' passed (56.317 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testDailyShapes]' passed (96.505 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testMonthAndYearShapes]' passed (218.890 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testOtherTypes]' passed (144.216 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testSetDayShapes]' passed (123.328 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testWeeklyShapes]' passed (120.245 seconds).
```
