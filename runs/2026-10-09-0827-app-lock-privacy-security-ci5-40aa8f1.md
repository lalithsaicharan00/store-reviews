# app-lock-privacy-security-ci5 @ 40aa8f1

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37902708954 · 2026-10-09 08:27 UTC
Commit: Current Work 58.9/58.11: SE tests untick the done step first, and scroll the taller menu to Privacy (run 37899410443)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (SmallScreenUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 8 tests, with 0 failures (0 unexpected) in 332.339 (332.346) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 332.339 (332.347) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 332.339 (332.348) seconds
Test Case '-[HabitsUITests.SmallScreenUITests testAddLogFitsAboveTheKeyboard]' passed (23.829 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAddTimeFitsAboveTheKeyboard]' passed (17.590 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAfterLogLineStaysInsideTheRow]' passed (73.130 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testDayDetailsKeepsSkipOnScreenWithFourLogsAndANote]' passed (88.474 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testEditLogFitsAboveTheKeyboard]' passed (20.217 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testLockKeypadFitsAtAccessibilitySizes]' passed (29.845 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testNoteBoxFillsTheRoomAboveSave]' passed (13.729 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testPrivacyCodeSheetsAndReminderSaysFit]' passed (65.524 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
