# claude/timer-swipe-limits-and-fixes @ a9b9a23

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37272372742 · 2026-10-05 07:15 UTC
Commit: Notes: search across the full width, Add Note under it in History's button style (Current Work 26, 28)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (HabitCreationUITests,HabitScenarioUITests,LongTextUITests,RoutineCalendarUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 24 tests, with 1 failure (0 unexpected) in 2074.931 (2074.955) seconds
	 Executed 24 tests, with 1 failure (0 unexpected) in 2074.931 (2074.957) seconds
	 Executed 3 tests, with 0 failures (0 unexpected) in 114.279 (114.281) seconds
	 Executed 6 tests, with 1 failure (0 unexpected) in 920.411 (920.420) seconds
	 Executed 7 tests, with 0 failures (0 unexpected) in 184.305 (184.309) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 855.936 (855.942) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitCreationUITests.swift:126: error: -[HabitsUITests.HabitCreationUITests testSetDayShapes] : XCTAssertTrue failed - Today shows Walk for F08b-six-days
Test Case '-[HabitsUITests.HabitCreationUITests testBigNumbers]' passed (95.027 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testDailyShapes]' passed (109.120 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testMonthAndYearShapes]' passed (245.713 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testOtherTypes]' passed (228.492 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testSetDayShapes]' failed (122.347 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testWeeklyShapes]' passed (119.712 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testCountsAndAmounts]' passed (160.036 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testCutDown]' passed (33.785 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testDaySets]' passed (155.686 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testDaySetsNamedAndAll]' passed (117.246 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testEachTypeStartsWithDefaults]' passed (65.191 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testLongest]' passed (44.560 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testMonthDateSets]' passed (241.337 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testStartsAndEnds]' passed (38.095 seconds).
Test Case '-[HabitsUITests.LongTextUITests testChooserShowsEverything]' passed (21.982 seconds).
Test Case '-[HabitsUITests.LongTextUITests testFormWithLongText]' passed (62.524 seconds).
Test Case '-[HabitsUITests.LongTextUITests testTodayWithLongText]' passed (29.773 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarSixWeekMonthAtLargeTextSize]' passed (20.346 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarTotalsAndDaysWithoutHabits]' passed (30.067 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarUpdatesAfterLoggingAndPastNavigation]' passed (23.430 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testChecklistRoutineUsesExistingEntries]' passed (18.379 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testNonTimedRoutineAndSkipDoNotFalselyComplete]' passed (38.245 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testPlayFollowsHeaderRules]' passed (17.431 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testSingleHabitFullCompletionAndUndo]' passed (36.408 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
