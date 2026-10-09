# app-lock-privacy-security-ci4 @ 807739b

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37881272574 · 2026-10-09 04:20 UTC
Commit: Rulebook T1: watch each run with a background watcher; parallel batches on their own branches (the user, 9 Oct 2026)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (SmallScreenUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 7 tests, with 1 failure (0 unexpected) in 335.483 (335.490) seconds
	 Executed 7 tests, with 1 failure (0 unexpected) in 335.483 (335.492) seconds
	 Executed 7 tests, with 1 failure (0 unexpected) in 335.483 (335.494) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/SmallScreenUITests.swift:203: error: -[HabitsUITests.SmallScreenUITests testPrivacyCodeSheetsAndReminderSaysFit] : Failed to tap "reminders-row" Any: No matches found for Elements matching predicate '"reminders-row" IN identifiers' from input {(
Test Case '-[HabitsUITests.SmallScreenUITests testAddLogFitsAboveTheKeyboard]' passed (54.677 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAddTimeFitsAboveTheKeyboard]' passed (21.287 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testDayDetailsKeepsSkipOnScreenWithFourLogsAndANote]' passed (42.899 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testEditLogFitsAboveTheKeyboard]' passed (23.587 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testLockKeypadFitsAtAccessibilitySizes]' passed (44.284 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testNoteBoxFillsTheRoomAboveSave]' passed (21.807 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testPrivacyCodeSheetsAndReminderSaysFit]' failed (126.941 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
