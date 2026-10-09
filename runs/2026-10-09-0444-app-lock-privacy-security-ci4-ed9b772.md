# app-lock-privacy-security-ci4 @ ed9b772

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37883783862 · 2026-10-09 04:44 UTC
Commit: Current Work 58: Use Face ID again? is asked on the cover before it opens (run 37880056940)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (SmallScreenUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 7 tests, with 2 failures (0 unexpected) in 371.969 (371.980) seconds
	 Executed 7 tests, with 2 failures (0 unexpected) in 371.969 (371.981) seconds
	 Executed 7 tests, with 2 failures (0 unexpected) in 371.969 (371.982) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/SmallScreenUITests.swift:203: error: -[HabitsUITests.SmallScreenUITests testPrivacyCodeSheetsAndReminderSaysFit] : XCTAssertTrue failed - reminders-row none, window 667
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/SmallScreenUITests.swift:204: error: -[HabitsUITests.SmallScreenUITests testPrivacyCodeSheetsAndReminderSaysFit] : Failed to tap "reminders-row" Any: No matches found for Elements matching predicate '"reminders-row" IN identifiers' from input {(
Test Case '-[HabitsUITests.SmallScreenUITests testAddLogFitsAboveTheKeyboard]' passed (52.052 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAddTimeFitsAboveTheKeyboard]' passed (20.563 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testDayDetailsKeepsSkipOnScreenWithFourLogsAndANote]' passed (124.130 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testEditLogFitsAboveTheKeyboard]' passed (39.114 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testLockKeypadFitsAtAccessibilitySizes]' passed (51.133 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testNoteBoxFillsTheRoomAboveSave]' passed (21.803 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testPrivacyCodeSheetsAndReminderSaysFit]' failed (63.174 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
