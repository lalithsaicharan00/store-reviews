# claude/shared-habit-rules-main-check3 @ ad7a898

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38240333054 · 2026-10-12 13:07 UTC
Commit: Current Work 92: checkpoint 1 ticked (runs 38213677372, 38213679929, 38224578250, 38216734746)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (RoutineCalendarUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 7 tests, with 2 failures (0 unexpected) in 321.631 (321.641) seconds
	 Executed 7 tests, with 2 failures (0 unexpected) in 321.631 (321.643) seconds
	 Executed 7 tests, with 2 failures (0 unexpected) in 321.631 (321.644) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/RoutineCalendarUITests.swift:173: error: -[HabitsUITests.RoutineCalendarUITests testCalendarTotalsAndDaysWithoutHabits] : Asynchronous wait failed: Exceeded timeout of 5 seconds, with unfulfilled expectations: "Expect predicate `hittable == 1` for object "Next month" Button".
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/RoutineCalendarUITests.swift:18: error: -[HabitsUITests.RoutineCalendarUITests testCalendarUpdatesAfterLoggingAndPastNavigation] : Failed to terminate com.oftenenough.app:55921: Failed to terminate com.oftenenough.app:0
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarSixWeekMonthAtLargeTextSize]' passed (47.432 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarTotalsAndDaysWithoutHabits]' failed (31.805 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarUpdatesAfterLoggingAndPastNavigation]' failed (65.556 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testChecklistRoutineUsesExistingEntries]' passed (51.374 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testNonTimedRoutineAndSkipDoNotFalselyComplete]' passed (57.400 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testPlayFollowsHeaderRules]' passed (22.803 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testSingleHabitFullCompletionAndUndo]' passed (45.262 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
