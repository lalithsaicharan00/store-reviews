# claude/habit-details-perf @ 9a0b575

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37133202084 · 2026-10-03 16:05 UTC
Commit: Calendar tests: the calendar's dates are plain (2 Oct decision), so the day's count is checked on the day bar

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (RoutineCalendarUITests,HabitScenarioUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 15 tests, with 3 failures (0 unexpected) in 1412.182 (1412.200) seconds
	 Executed 15 tests, with 3 failures (0 unexpected) in 1412.182 (1412.201) seconds
	 Executed 7 tests, with 1 failure (0 unexpected) in 211.611 (211.617) seconds
	 Executed 8 tests, with 2 failures (0 unexpected) in 1200.572 (1200.582) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitScenarioUITests.swift:311: error: -[HabitsUITests.HabitScenarioUITests testStartsAndEnds] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitScenarioUITests.swift:317: error: -[HabitsUITests.HabitScenarioUITests testStartsAndEnds] : Failed to tap Button (First Match): No matches found for first query match sequence: `Descendants matching type Button` -> `Elements matching predicate 'label BEGINSWITH "Ends"'`, given input App element pid: 77712
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/RoutineCalendarUITests.swift:246: error: -[HabitsUITests.RoutineCalendarUITests testSingleHabitFullCompletionAndUndo] : XCTAssertEqual failed: ("Optional("Today")") is not equal to ("Optional("Today. 0 of 1 done")")
Test Case '-[HabitsUITests.HabitScenarioUITests testCountsAndAmounts]' passed (272.136 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testCutDown]' passed (46.062 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testDaySets]' passed (236.398 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testDaySetsNamedAndAll]' passed (180.749 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testEachTypeStartsWithDefaults]' passed (88.940 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testLongest]' passed (52.410 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testMonthDateSets]' passed (282.466 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testStartsAndEnds]' failed (41.411 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarSixWeekMonthAtLargeTextSize]' passed (25.798 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarTotalsAndDaysWithoutHabits]' passed (31.398 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarUpdatesAfterLoggingAndPastNavigation]' passed (26.079 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testChecklistRoutineUsesExistingEntries]' passed (21.947 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testNonTimedRoutineAndSkipDoNotFalselyComplete]' passed (41.949 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testPlayFollowsHeaderRules]' passed (21.669 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testSingleHabitFullCompletionAndUndo]' failed (42.770 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
