# day-details-logs-notes-redesign-ci-e @ 6d228b6

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37615444144 · 2026-10-07 11:59 UTC
Commit: Day details fits the iPhone SE: spacing from the window's height, 44-pt rows, the designed first gap

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (SmallScreenUITests,DayDetailsUITests/testLogsRuleAndAllLogs,DayDetailsUITests/testSkippedDayKeepsLogsAndNote): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 0 failures (0 unexpected) in 134.653 (134.659) seconds
	 Executed 5 tests, with 1 failure (0 unexpected) in 213.782 (213.791) seconds
	 Executed 7 tests, with 1 failure (0 unexpected) in 348.435 (348.453) seconds
	 Executed 7 tests, with 1 failure (0 unexpected) in 348.435 (348.456) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/SmallScreenUITests.swift:134: error: -[HabitsUITests.SmallScreenUITests testDayDetailsKeepsSkipOnScreenWithFourLogsAndANote] : XCTAssertTrue failed - Skip today is drawn without scrolling: day-identity 131–171, day-result 246–273, day-add-step 305–355, day-edit-note 373–444, day-all-logs 609–660, day-skip none, window 667
Test Case '-[HabitsUITests.DayDetailsUITests testLogsRuleAndAllLogs]' passed (74.459 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testSkippedDayKeepsLogsAndNote]' passed (60.194 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAddLogFitsAboveTheKeyboard]' passed (22.474 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAddTimeFitsAboveTheKeyboard]' passed (95.066 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testDayDetailsKeepsSkipOnScreenWithFourLogsAndANote]' failed (48.911 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testEditLogFitsAboveTheKeyboard]' passed (26.234 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testNoteBoxFillsTheRoomAboveSave]' passed (21.097 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
