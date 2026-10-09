# app-lock-privacy-security-ci3 @ 1f55c74

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37998277662 · 2026-10-09 22:45 UTC
Commit: SmallScreenUITests: Set Up App Lock scrolls at large text and fits at the default size; Account, sign-in sheet, Backup & Export, Move and Restore on the SE (T15)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (SmallScreenUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 572.064 (572.277) seconds
	 Executed 10 tests, with 0 failures (0 unexpected) in 572.064 (572.278) seconds
	 Executed 10 tests, with 0 failures (0 unexpected) in 572.064 (572.279) seconds
Test Case '-[HabitsUITests.SmallScreenUITests testAccountBackupRestoreAndMoveFit]' passed (117.264 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAddLogFitsAboveTheKeyboard]' passed (45.748 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAddTimeFitsAboveTheKeyboard]' passed (21.742 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAfterLogLineStaysInsideTheRow]' passed (113.272 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAppLockSetupFitsWithoutScrolling]' passed (25.091 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testDayDetailsKeepsSkipOnScreenWithFourLogsAndANote]' passed (49.617 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testEditLogFitsAboveTheKeyboard]' passed (26.916 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testLockKeypadFitsAtAccessibilitySizes]' passed (61.851 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testNoteBoxFillsTheRoomAboveSave]' passed (20.173 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testPrivacyCodeSheetsAndReminderSaysFit]' passed (90.391 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
