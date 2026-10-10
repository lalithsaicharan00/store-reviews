# habit-progress-milestones @ 32dcca9

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38046477483 · 2026-10-10 11:14 UTC
Commit: Habit Progress: a best run's and best week's dates in the phone's own order, as every other date on the page ("Sep 26 – Oct 1" in US English, "26 Sep – 1 Oct" in British)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (ProgressUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 9 tests, with 0 failures (0 unexpected) in 281.837 (281.853) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 281.837 (281.854) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 281.837 (281.855) seconds
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (16.993 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndMilestones]' passed (30.875 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (100.518 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (43.673 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (23.336 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (15.690 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (6.441 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtProgress]' passed (24.871 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (19.439 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
