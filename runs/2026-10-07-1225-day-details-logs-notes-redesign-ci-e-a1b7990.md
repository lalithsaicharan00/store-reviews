# day-details-logs-notes-redesign-ci-e @ a1b7990

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37618114751 · 2026-10-07 12:25 UTC
Commit: Day details on the iPhone SE: 44-pt log rows, trimmed card insets, compact first gap

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (SmallScreenUITests/testDayDetailsKeepsSkipOnScreenWithFourLogsAndANote): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/SmallScreenUITests.swift:137: error: -[HabitsUITests.SmallScreenUITests testDayDetailsKeepsSkipOnScreenWithFourLogsAndANote] : XCTAssertLessThanOrEqual failed: ("701.5") is greater than ("667.0") - Skip today ends on screen: day-identity 127–167, day-result 234–261, day-add-step 293–343, day-edit-note 357–420, day-all-logs 572–623, day-skip 651–701, window 667
Test Case '-[HabitsUITests.SmallScreenUITests testDayDetailsKeepsSkipOnScreenWithFourLogsAndANote]' failed (80.720 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
