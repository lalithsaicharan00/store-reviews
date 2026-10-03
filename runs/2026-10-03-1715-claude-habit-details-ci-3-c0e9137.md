# claude/habit-details-ci-3 @ c0e9137

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37137384310 · 2026-10-03 17:15 UTC
Commit: Quit record card keeps its controls' own ids (its id replaced Log a Slip's); calendar test's undo check reads the day bar; Starts/Ends test drags the form, not Today behind it

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (RoutineCalendarUITests,HabitScenarioUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 15 tests, with 0 failures (0 unexpected) in 1477.201 (1477.222) seconds
	 Executed 15 tests, with 0 failures (0 unexpected) in 1477.201 (1477.223) seconds
	 Executed 7 tests, with 0 failures (0 unexpected) in 246.156 (246.162) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 1231.046 (1231.057) seconds
Test Case '-[HabitsUITests.HabitScenarioUITests testCountsAndAmounts]' passed (271.780 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testCutDown]' passed (46.308 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testDaySets]' passed (228.486 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testDaySetsNamedAndAll]' passed (176.857 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testEachTypeStartsWithDefaults]' passed (105.992 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testLongest]' passed (64.776 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testMonthDateSets]' passed (288.667 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testStartsAndEnds]' passed (48.181 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarSixWeekMonthAtLargeTextSize]' passed (27.612 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarTotalsAndDaysWithoutHabits]' passed (35.648 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarUpdatesAfterLoggingAndPastNavigation]' passed (31.326 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testChecklistRoutineUsesExistingEntries]' passed (27.676 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testNonTimedRoutineAndSkipDoNotFalselyComplete]' passed (50.445 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testPlayFollowsHeaderRules]' passed (24.453 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testSingleHabitFullCompletionAndUndo]' passed (48.995 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
