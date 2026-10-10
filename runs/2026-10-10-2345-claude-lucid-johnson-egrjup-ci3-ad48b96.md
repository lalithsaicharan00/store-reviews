# claude/lucid-johnson-egrjup-ci3 @ ad48b96

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38094556445 · 2026-10-10 23:45 UTC
Commit: Merge main (the Plus screens) into claude/lucid-johnson-egrjup

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (SmallScreenUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 12 tests, with 2 failures (0 unexpected) in 484.907 (484.915) seconds
	 Executed 12 tests, with 2 failures (0 unexpected) in 484.907 (484.916) seconds
	 Executed 12 tests, with 2 failures (0 unexpected) in 484.907 (484.918) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/SmallScreenUITests.swift:288: error: -[HabitsUITests.SmallScreenUITests testPrivacyCodeSheetsAndReminderSaysFit] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/SmallScreenUITests.swift:294: error: -[HabitsUITests.SmallScreenUITests testPrivacyCodeSheetsAndReminderSaysFit] : Failed to get matching snapshot: No matches found for Elements matching predicate '"setup-app-passcode" IN identifiers' from input {(
Test Case '-[HabitsUITests.SmallScreenUITests testAddLogFitsAboveTheKeyboard]' passed (32.870 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAddTimeFitsAboveTheKeyboard]' passed (17.143 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAfterLogLineStaysInsideTheRow]' passed (141.734 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAppLockSetupFitsWithoutScrolling]' passed (24.237 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testDayDetailsKeepsSkipOnScreenWithFourLogsAndANote]' passed (55.979 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testEditLogFitsAboveTheKeyboard]' passed (25.303 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testICloudPageSecondDeviceAndRestoreFit]' passed (50.589 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testLockKeypadFitsAtAccessibilitySizes]' passed (34.156 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testNoteBoxFillsTheRoomAboveSave]' passed (18.035 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testOverallRecordFitsWithoutScrolling]' passed (23.829 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testPlusSheetAndPageFit]' passed (28.722 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testPrivacyCodeSheetsAndReminderSaysFit]' failed (32.310 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
