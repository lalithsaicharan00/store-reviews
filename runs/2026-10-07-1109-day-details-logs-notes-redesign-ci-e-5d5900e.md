# day-details-logs-notes-redesign-ci-e @ 5d5900e

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37609712083 · 2026-10-07 11:09 UTC
Commit: Small-screen checks: SmallScreenUITests and a workflow option to test on a chosen simulator

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (SmallScreenUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 5 tests, with 3 failures (0 unexpected) in 134.139 (134.153) seconds
	 Executed 5 tests, with 3 failures (0 unexpected) in 134.139 (134.155) seconds
	 Executed 5 tests, with 3 failures (0 unexpected) in 134.139 (134.157) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/SmallScreenUITests.swift:124: error: -[HabitsUITests.SmallScreenUITests testDayDetailsKeepsSkipOnScreenWithFourLogsAndANote] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/SmallScreenUITests.swift:125: error: -[HabitsUITests.SmallScreenUITests testDayDetailsKeepsSkipOnScreenWithFourLogsAndANote] : Failed to get matching snapshot: No matches found for Elements matching predicate '"day-skip" IN identifiers' from input {(
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/SmallScreenUITests.swift:58: error: -[HabitsUITests.SmallScreenUITests testAddLogFitsAboveTheKeyboard] : XCTAssertGreaterThan failed: ("373.5") is not greater than ("395.5") - Add is under the amount
Test Case '-[HabitsUITests.SmallScreenUITests testAddLogFitsAboveTheKeyboard]' failed (42.441 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAddTimeFitsAboveTheKeyboard]' passed (17.907 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testDayDetailsKeepsSkipOnScreenWithFourLogsAndANote]' failed (29.847 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testEditLogFitsAboveTheKeyboard]' passed (27.309 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testNoteBoxFillsTheRoomAboveSave]' passed (16.634 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
