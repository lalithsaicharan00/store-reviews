# claude/awesome-newton-pmu4y7-ci2 @ 966b1a6

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38063954222 · 2026-10-10 16:00 UTC
Commit: Plus screens with StoreKit 2 (Current Work 80): the 6th-habit sheet, Make Room, the Plus page, Your Plus, the upgrade, Plus is yours, Plus has ended, the second-device sheet

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (SmallScreenUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 12 tests, with 2 failures (0 unexpected) in 538.189 (538.204) seconds
	 Executed 12 tests, with 2 failures (0 unexpected) in 538.189 (538.205) seconds
	 Executed 12 tests, with 2 failures (0 unexpected) in 538.189 (538.209) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/SmallScreenUITests.swift:299: error: -[HabitsUITests.SmallScreenUITests testPrivacyCodeSheetsAndReminderSaysFit] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/SmallScreenUITests.swift:305: error: -[HabitsUITests.SmallScreenUITests testPrivacyCodeSheetsAndReminderSaysFit] : Failed to get matching snapshot: No matches found for Elements matching predicate '"setup-app-passcode" IN identifiers' from input {(
Test Case '-[HabitsUITests.SmallScreenUITests testAccountBackupRestoreAndMoveFit]' passed (48.970 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAddLogFitsAboveTheKeyboard]' passed (105.445 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAddTimeFitsAboveTheKeyboard]' passed (22.422 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAfterLogLineStaysInsideTheRow]' passed (125.543 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAppLockSetupFitsWithoutScrolling]' passed (24.454 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testDayDetailsKeepsSkipOnScreenWithFourLogsAndANote]' passed (41.784 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testEditLogFitsAboveTheKeyboard]' passed (22.381 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testLockKeypadFitsAtAccessibilitySizes]' passed (43.959 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testNoteBoxFillsTheRoomAboveSave]' passed (20.358 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testOverallRecordFitsWithoutScrolling]' passed (29.441 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testPlusSheetAndPageFit]' passed (27.718 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testPrivacyCodeSheetsAndReminderSaysFit]' failed (25.713 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
