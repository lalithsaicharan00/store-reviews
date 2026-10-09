# app-lock-privacy-security-ci5 @ 4a83db8

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37896918162 · 2026-10-09 07:28 UTC
Commit: Current Work 58.10–58.11: the user's Backup & Export and account points, recorded before the research (W1)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (SmallScreenUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 8 tests, with 3 failures (0 unexpected) in 402.698 (402.707) seconds
	 Executed 8 tests, with 3 failures (0 unexpected) in 402.698 (402.709) seconds
	 Executed 8 tests, with 3 failures (0 unexpected) in 402.698 (402.710) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/SmallScreenUITests.swift:228: error: -[HabitsUITests.SmallScreenUITests testAfterLogLineStaysInsideTheRow] : XCTAssertTrue failed - The sample habits are there
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/SmallScreenUITests.swift:245: error: -[HabitsUITests.SmallScreenUITests testAfterLogLineStaysInsideTheRow] : XCTAssertTrue failed - The checklist row is on Today
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/SmallScreenUITests.swift:246: error: -[HabitsUITests.SmallScreenUITests testAfterLogLineStaysInsideTheRow] : Failed to tap Button (First Match): No matches found for first query match sequence: `Descendants matching type Button` -> `Elements matching predicate 'label BEGINSWITH "Show Morning skincare"'`, given input App element pid: 30794
Test Case '-[HabitsUITests.SmallScreenUITests testAddLogFitsAboveTheKeyboard]' passed (40.113 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAddTimeFitsAboveTheKeyboard]' passed (22.617 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAfterLogLineStaysInsideTheRow]' failed (104.393 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testDayDetailsKeepsSkipOnScreenWithFourLogsAndANote]' passed (64.817 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testEditLogFitsAboveTheKeyboard]' passed (27.556 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testLockKeypadFitsAtAccessibilitySizes]' passed (61.760 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testNoteBoxFillsTheRoomAboveSave]' passed (17.794 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testPrivacyCodeSheetsAndReminderSaysFit]' passed (63.648 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
