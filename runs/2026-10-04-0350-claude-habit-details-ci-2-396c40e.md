# claude/habit-details-ci-2 @ 396c40e

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37173647219 · 2026-10-04 03:50 UTC
Commit: After-log line: one layout instead of ViewThatFits (it measured three layouts each time the line appeared and doubled the cost of changing days: 72 vs 14 ms/s, bisected side by side); Rulebook S10 and lesson L21

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (RoutineCalendarUITests,ArrangeUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 12 tests, with 1 failure (0 unexpected) in 1075.303 (1075.329) seconds
	 Executed 12 tests, with 1 failure (0 unexpected) in 1075.303 (1075.332) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 269.365 (269.382) seconds
	 Executed 7 tests, with 1 failure (0 unexpected) in 805.938 (805.945) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/RoutineCalendarUITests.swift:235: error: -[HabitsUITests.RoutineCalendarUITests testSingleHabitFullCompletionAndUndo] : XCTAssertTrue failed
Test Case '-[HabitsUITests.ArrangeUITests testAddTimeOfDay]' passed (76.844 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testArrangeChecks]' passed (55.513 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testEditArrangesTheDay]' passed (80.727 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testGroupRowBeforeAnyGroup]' passed (31.325 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testHideCompleted]' passed (24.956 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarSixWeekMonthAtLargeTextSize]' passed (22.634 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarTotalsAndDaysWithoutHabits]' passed (34.356 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarUpdatesAfterLoggingAndPastNavigation]' passed (26.841 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testChecklistRoutineUsesExistingEntries]' passed (25.961 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testNonTimedRoutineAndSkipDoNotFalselyComplete]' passed (41.175 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testPlayFollowsHeaderRules]' passed (19.710 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testSingleHabitFullCompletionAndUndo]' failed (635.260 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
