# claude/habit-details-ci-3 @ 70d556f

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37167903135 · 2026-10-04 02:01 UTC
Commit: Tests follow the row work: swipes drag a fixed distance (a name is too narrow for XCUITest's swipe), yesterday opens Anytime first, the task test uses the task fixture, GoalFlow types other amounts through the Day sheet, results read "3/3 times"; the delete question gets an explicit Cancel

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (HabitScenarioUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 8 tests, with 0 failures (0 unexpected) in 1472.165 (1472.177) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 1472.165 (1472.180) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 1472.165 (1472.182) seconds
Test Case '-[HabitsUITests.HabitScenarioUITests testCountsAndAmounts]' passed (305.443 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testCutDown]' passed (42.252 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testDaySets]' passed (192.153 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testDaySetsNamedAndAll]' passed (144.239 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testEachTypeStartsWithDefaults]' passed (75.348 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testLongest]' passed (48.638 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testMonthDateSets]' passed (209.151 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testStartsAndEnds]' passed (454.941 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
