# day-details-logs-notes-redesign-ci-e @ aa6ee1e

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37621197950 · 2026-10-07 12:52 UTC
Commit: Day details on the iPhone SE: 44-pt buttons and rows, the first and logs gaps as designed

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (SmallScreenUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 5 tests, with 0 failures (0 unexpected) in 241.358 (241.367) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 241.358 (241.369) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 241.358 (241.371) seconds
Test Case '-[HabitsUITests.SmallScreenUITests testAddLogFitsAboveTheKeyboard]' passed (121.518 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAddTimeFitsAboveTheKeyboard]' passed (24.148 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testDayDetailsKeepsSkipOnScreenWithFourLogsAndANote]' passed (44.295 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testEditLogFitsAboveTheKeyboard]' passed (30.833 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testNoteBoxFillsTheRoomAboveSave]' passed (20.564 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
