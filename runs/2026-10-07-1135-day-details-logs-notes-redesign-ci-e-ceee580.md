# day-details-logs-notes-redesign-ci-e @ ceee580

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37613190433 · 2026-10-07 11:35 UTC
Commit: iPhone SE: Add log and Edit log fit above the keyboard; Day details' card padding

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (SmallScreenUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 5 tests, with 1 failure (0 unexpected) in 123.106 (123.110) seconds
	 Executed 5 tests, with 1 failure (0 unexpected) in 123.106 (123.111) seconds
	 Executed 5 tests, with 1 failure (0 unexpected) in 123.106 (123.112) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/SmallScreenUITests.swift:134: error: -[HabitsUITests.SmallScreenUITests testDayDetailsKeepsSkipOnScreenWithFourLogsAndANote] : XCTAssertTrue failed - Skip today is drawn without scrolling: day-identity 131–171, day-result 246–273, day-add-step 305–355, day-edit-note 373–444, day-all-logs 612–664, day-skip none, window 667
Test Case '-[HabitsUITests.SmallScreenUITests testAddLogFitsAboveTheKeyboard]' passed (43.451 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAddTimeFitsAboveTheKeyboard]' passed (14.677 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testDayDetailsKeepsSkipOnScreenWithFourLogsAndANote]' failed (32.972 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testEditLogFitsAboveTheKeyboard]' passed (16.846 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testNoteBoxFillsTheRoomAboveSave]' passed (15.161 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
