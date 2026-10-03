# claude/habit-details-ci-3 @ 4ab7159

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37133885827 · 2026-10-03 16:32 UTC
Commit: New Habit test: scroll to Ends as well as Starts (Ends was below the screen, not built yet by the form)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (HabitScenarioUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 8 tests, with 2 failures (0 unexpected) in 1146.333 (1146.349) seconds
	 Executed 8 tests, with 2 failures (0 unexpected) in 1146.333 (1146.361) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitScenarioUITests.swift:313: error: -[HabitsUITests.HabitScenarioUITests testStartsAndEnds] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitScenarioUITests.swift:319: error: -[HabitsUITests.HabitScenarioUITests testStartsAndEnds] : Failed to tap Button (First Match): No matches found for first query match sequence: `Descendants matching type Button` -> `Elements matching predicate 'label BEGINSWITH "Ends"'`, given input App element pid: 70877
Test Case '-[HabitsUITests.HabitScenarioUITests testCountsAndAmounts]' passed (256.726 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testCutDown]' passed (44.875 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testDaySets]' passed (221.095 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testDaySetsNamedAndAll]' passed (155.367 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testEachTypeStartsWithDefaults]' passed (78.236 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testLongest]' passed (54.347 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testMonthDateSets]' passed (279.126 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testStartsAndEnds]' failed (56.560 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
