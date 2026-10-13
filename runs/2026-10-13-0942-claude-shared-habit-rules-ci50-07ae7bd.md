# claude/shared-habit-rules-ci50 @ 07ae7bd

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38373457016 · 2026-10-13 09:42 UTC
Commit: Current Work 92: the golden cases through the shared rules on the final code, 0 differences beyond the Lord Howe fix (run 38363493132)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (ProgressUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 9 tests, with 0 failures (0 unexpected) in 349.149 (349.159) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 349.149 (349.161) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 349.149 (349.163) seconds
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (44.892 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndMilestones]' passed (37.125 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (80.652 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (72.215 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (27.280 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (22.291 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (12.338 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtProgress]' passed (29.476 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (22.879 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
