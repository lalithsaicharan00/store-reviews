# app-lock-privacy-security-ci5 @ 61c65ac

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37899410443 · 2026-10-09 08:02 UTC
Commit: Current Work 58.9: the SE Undo test opens the folded morning card first, at a set hour (run 37896918162)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (SmallScreenUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 8 tests, with 3 failures (0 unexpected) in 297.906 (297.917) seconds
	 Executed 8 tests, with 3 failures (0 unexpected) in 297.906 (297.918) seconds
	 Executed 8 tests, with 3 failures (0 unexpected) in 297.906 (297.921) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/SmallScreenUITests.swift:171: error: -[HabitsUITests.SmallScreenUITests testPrivacyCodeSheetsAndReminderSaysFit] : Failed to tap "menu-privacy" Button: No matches found for Elements matching predicate '"menu-privacy" IN identifiers' from input {(
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/SmallScreenUITests.swift:251: error: -[HabitsUITests.SmallScreenUITests testAfterLogLineStaysInsideTheRow] : XCTAssertTrue failed - The long step is shown
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/SmallScreenUITests.swift:252: error: -[HabitsUITests.SmallScreenUITests testAfterLogLineStaysInsideTheRow] : Failed to tap Button (First Match): No matches found for first query match sequence: `Descendants matching type Button` -> `Elements matching predicate 'label BEGINSWITH "Mark Double cleanse"'`, given input App element pid: 33319
Test Case '-[HabitsUITests.SmallScreenUITests testAddLogFitsAboveTheKeyboard]' passed (39.502 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAddTimeFitsAboveTheKeyboard]' passed (76.191 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAfterLogLineStaysInsideTheRow]' failed (50.838 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testDayDetailsKeepsSkipOnScreenWithFourLogsAndANote]' passed (47.627 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testEditLogFitsAboveTheKeyboard]' passed (20.297 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testLockKeypadFitsAtAccessibilitySizes]' passed (35.054 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testNoteBoxFillsTheRoomAboveSave]' passed (16.537 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testPrivacyCodeSheetsAndReminderSaysFit]' failed (11.861 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
