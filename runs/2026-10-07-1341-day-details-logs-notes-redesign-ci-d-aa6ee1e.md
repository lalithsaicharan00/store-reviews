# day-details-logs-notes-redesign-ci-d @ aa6ee1e

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37624448992 · 2026-10-07 13:41 UTC
Commit: Day details on the iPhone SE: 44-pt buttons and rows, the first and logs gaps as designed

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (HabitCreationUITests,NewHabitUITests,SmallScreenUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 20 tests, with 0 failures (0 unexpected) in 887.459 (887.473) seconds
	 Executed 31 tests, with 4 failures (0 unexpected) in 1831.283 (1831.311) seconds
	 Executed 31 tests, with 4 failures (0 unexpected) in 1831.283 (1831.312) seconds
	 Executed 5 tests, with 1 failure (0 unexpected) in 129.778 (129.781) seconds
	 Executed 6 tests, with 3 failures (0 unexpected) in 814.046 (814.055) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitCreationUITests.swift:115: error: -[HabitsUITests.HabitCreationUITests testDailyShapes] : XCTAssertEqual failed: ("Enter a habit name to see the preview.") is not equal to ("Make bed every day, anytime") - Text preview for F01-every-day
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitCreationUITests.swift:235: error: -[HabitsUITests.HabitCreationUITests testMonthAndYearShapes] : Failed to tap Button (First Match): No matches found for first query match sequence: `Descendants matching type Button` -> `Elements matching predicate 'label BEGINSWITH "Month,"'`, given input App element pid: 33971
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitCreationUITests.swift:43: error: -[HabitsUITests.HabitCreationUITests testMonthAndYearShapes] : XCTAssertTrue failed - Can't find Button (First Match)
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/SmallScreenUITests.swift:66: error: -[HabitsUITests.SmallScreenUITests testAddLogFitsAboveTheKeyboard] : XCTAssertGreaterThan failed: ("514.0") is not greater than ("525.0") - Add is under the amount: record-habit 150–202, record-date 217–251, record-time 281–317, record-amount 416–525, record-add 514–558, window 874, keyboard 583
Test Case '-[HabitsUITests.HabitCreationUITests testBigNumbers]' passed (95.947 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testDailyShapes]' failed (132.006 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testMonthAndYearShapes]' failed (139.188 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testOtherTypes]' passed (154.597 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testSetDayShapes]' passed (143.900 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testWeeklyShapes]' passed (148.407 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAmountWithReminderRemoved]' passed (91.113 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAnytimeNeverCombines]' passed (39.163 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCertainDaysReadAsARange]' passed (36.108 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testChecklist]' passed (42.866 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffInTwoTimesOfDay]' passed (89.916 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffThreeTimesAWeek]' passed (35.591 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCopyChecks]' passed (11.994 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCustomUnit]' passed (38.345 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testDatesOfTheMonth]' passed (38.410 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testIconSheetClosesOnPick]' passed (28.173 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeAWeeklyTotal]' passed (38.899 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeTimeAndStaysEditable]' passed (62.218 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testNewTimeOfDayFromTheForm]' passed (44.714 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testOneTimeTask]' passed (21.747 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testQuitDiscard]' passed (24.923 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testReadTwoChaptersAWeek]' passed (56.325 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRemindMeOffHidesTheRest]' passed (34.602 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRunFiveMilesAndWalkTenThousandSteps]' passed (85.427 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTimeUnit]' passed (37.805 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTwoCertainDays]' passed (29.118 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAddLogFitsAboveTheKeyboard]' failed (34.780 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAddTimeFitsAboveTheKeyboard]' passed (15.933 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testDayDetailsKeepsSkipOnScreenWithFourLogsAndANote]' passed (39.457 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testEditLogFitsAboveTheKeyboard]' passed (20.741 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testNoteBoxFillsTheRoomAboveSave]' passed (18.866 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
