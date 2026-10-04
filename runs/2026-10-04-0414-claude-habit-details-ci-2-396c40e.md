# claude/habit-details-ci-2 @ 396c40e

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37175363972 · 2026-10-04 04:14 UTC
Commit: After-log line: one layout instead of ViewThatFits (it measured three layouts each time the line appeared and doubled the cost of changing days: 72 vs 14 ms/s, bisected side by side); Rulebook S10 and lesson L21

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (RoutineCalendarUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 7 tests, with 0 failures (0 unexpected) in 644.693 (644.701) seconds
	 Executed 7 tests, with 0 failures (0 unexpected) in 644.693 (644.703) seconds
	 Executed 7 tests, with 0 failures (0 unexpected) in 644.693 (644.704) seconds
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarSixWeekMonthAtLargeTextSize]' passed (71.324 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarTotalsAndDaysWithoutHabits]' passed (33.421 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarUpdatesAfterLoggingAndPastNavigation]' passed (25.949 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testChecklistRoutineUsesExistingEntries]' passed (18.920 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testNonTimedRoutineAndSkipDoNotFalselyComplete]' passed (339.351 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testPlayFollowsHeaderRules]' passed (56.012 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testSingleHabitFullCompletionAndUndo]' passed (99.716 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
