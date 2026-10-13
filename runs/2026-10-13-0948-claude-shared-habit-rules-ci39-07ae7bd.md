# claude/shared-habit-rules-ci39 @ 07ae7bd

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38373452976 · 2026-10-13 09:48 UTC
Commit: Current Work 92: the golden cases through the shared rules on the final code, 0 differences beyond the Lord Howe fix (run 38363493132)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (ProgressUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 9 tests, with 1 failure (0 unexpected) in 363.823 (363.834) seconds
	 Executed 9 tests, with 1 failure (0 unexpected) in 363.823 (363.836) seconds
	 Executed 9 tests, with 1 failure (0 unexpected) in 363.823 (363.837) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ProgressUITests.swift:39: error: -[HabitsUITests.ProgressUITests testLogSlipAndUndo] : XCTAssertTrue failed
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (25.641 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndMilestones]' passed (45.900 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (146.178 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' failed (18.983 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (38.016 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (21.700 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (11.318 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtProgress]' passed (31.284 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (24.804 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
