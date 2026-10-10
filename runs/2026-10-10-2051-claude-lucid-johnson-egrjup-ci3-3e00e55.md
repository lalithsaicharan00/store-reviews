# claude/lucid-johnson-egrjup-ci3 @ 3e00e55

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38083496474 · 2026-10-10 20:51 UTC
Commit: iCloud sync: Design Rules' iCloud page, What's Built, and what's left for the user in item 81

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (SmallScreenUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 11 tests, with 2 failures (0 unexpected) in 470.648 (470.656) seconds
	 Executed 11 tests, with 2 failures (0 unexpected) in 470.648 (470.658) seconds
	 Executed 11 tests, with 2 failures (0 unexpected) in 470.648 (470.660) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/SmallScreenUITests.swift:288: error: -[HabitsUITests.SmallScreenUITests testPrivacyCodeSheetsAndReminderSaysFit] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/SmallScreenUITests.swift:294: error: -[HabitsUITests.SmallScreenUITests testPrivacyCodeSheetsAndReminderSaysFit] : Failed to get matching snapshot: No matches found for Elements matching predicate '"setup-app-passcode" IN identifiers' from input {(
Test Case '-[HabitsUITests.SmallScreenUITests testAddLogFitsAboveTheKeyboard]' passed (80.878 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAddTimeFitsAboveTheKeyboard]' passed (27.665 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAfterLogLineStaysInsideTheRow]' passed (102.127 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAppLockSetupFitsWithoutScrolling]' passed (19.993 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testDayDetailsKeepsSkipOnScreenWithFourLogsAndANote]' passed (34.929 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testEditLogFitsAboveTheKeyboard]' passed (16.873 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testICloudPageSecondDeviceAndRestoreFit]' passed (53.861 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testLockKeypadFitsAtAccessibilitySizes]' passed (62.457 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testNoteBoxFillsTheRoomAboveSave]' passed (21.066 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testOverallRecordFitsWithoutScrolling]' passed (24.515 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testPrivacyCodeSheetsAndReminderSaysFit]' failed (26.285 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
