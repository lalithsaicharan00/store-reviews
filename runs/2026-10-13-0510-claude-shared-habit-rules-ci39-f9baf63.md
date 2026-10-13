# claude/shared-habit-rules-ci39 @ f9baf63

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38345185625 · 2026-10-13 05:10 UTC
Commit: Current Work 92 (checkpoint 2): a Today row's numbers in one call to the shared rules (HabitRules.row, coreRow)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (ProgressUITests/testHidePercentages,DayDetailsUITests/testTickSteps): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 1 failure (0 unexpected) in 115.085 (115.089) seconds
	 Executed 2 tests, with 1 failure (0 unexpected) in 115.085 (115.090) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ProgressUITests.swift:148: error: -[HabitsUITests.ProgressUITests testHidePercentages] : XCTAssertTrue failed - The habit page
Test Case '-[HabitsUITests.DayDetailsUITests testTickSteps]' passed (27.619 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' failed (87.467 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
