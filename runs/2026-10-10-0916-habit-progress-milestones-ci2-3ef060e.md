# habit-progress-milestones-ci2 @ 3ef060e

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38039012506 · 2026-10-10 09:16 UTC
Commit: Habit Progress: Overall record boxes, milestones as medals, All milestones page

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (SmallScreenUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 11 tests, with 3 failures (0 unexpected) in 531.842 (531.854) seconds
	 Executed 11 tests, with 3 failures (0 unexpected) in 531.842 (531.855) seconds
	 Executed 11 tests, with 3 failures (0 unexpected) in 531.842 (531.859) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/SmallScreenUITests.swift:81: error: -[HabitsUITests.SmallScreenUITests testOverallRecordFitsWithoutScrolling] : XCTAssertTrue failed - The Overall record fits: habit-progress-record 521–838, habit-record-headline 573–607, habit-streak-current 623–709, habit-streak-best 623–709, habit-record-goal-met 717–822, habit-record-best-period 717–822, window 667
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/SmallScreenUITests.swift:83: error: -[HabitsUITests.SmallScreenUITests testOverallRecordFitsWithoutScrolling] : XCTAssertTrue failed - habit-record-best-period is on screen: habit-progress-record 521–838, habit-record-headline 573–607, habit-streak-current 623–709, habit-streak-best 623–709, habit-record-goal-met 717–822, habit-record-best-period 717–822, window 667
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/SmallScreenUITests.swift:83: error: -[HabitsUITests.SmallScreenUITests testOverallRecordFitsWithoutScrolling] : XCTAssertTrue failed - habit-record-goal-met is on screen: habit-progress-record 521–838, habit-record-headline 573–607, habit-streak-current 623–709, habit-streak-best 623–709, habit-record-goal-met 717–822, habit-record-best-period 717–822, window 667
Test Case '-[HabitsUITests.SmallScreenUITests testAccountBackupRestoreAndMoveFit]' passed (56.943 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAddLogFitsAboveTheKeyboard]' passed (40.365 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAddTimeFitsAboveTheKeyboard]' passed (19.341 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAfterLogLineStaysInsideTheRow]' passed (150.677 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAppLockSetupFitsWithoutScrolling]' passed (29.694 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testDayDetailsKeepsSkipOnScreenWithFourLogsAndANote]' passed (40.926 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testEditLogFitsAboveTheKeyboard]' passed (20.592 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testLockKeypadFitsAtAccessibilitySizes]' passed (34.460 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testNoteBoxFillsTheRoomAboveSave]' passed (16.676 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testOverallRecordFitsWithoutScrolling]' failed (37.451 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testPrivacyCodeSheetsAndReminderSaysFit]' passed (84.717 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
