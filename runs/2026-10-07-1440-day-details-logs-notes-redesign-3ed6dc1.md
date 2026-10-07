# day-details-logs-notes-redesign @ 3ed6dc1

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37630910873 · 2026-10-07 14:40 UTC
Commit: Add log and Edit log fit above the keyboard on every iPhone, not only the SE

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (SmallScreenUITests,DayDetailsUITests,UndoUITests,HabitCreationUITests/testDailyShapes,HabitCreationUITests/testMonthAndYearShapes,FocusPlayerUITests/testTimerPauseBackgroundAndSkipPreserveTime): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 15 tests, with 3 failures (0 unexpected) in 1046.289 (1046.306) seconds
	 Executed 2 tests, with 0 failures (0 unexpected) in 465.282 (465.286) seconds
	 Executed 31 tests, with 3 failures (0 unexpected) in 1980.161 (1980.218) seconds
	 Executed 31 tests, with 3 failures (0 unexpected) in 1980.161 (1980.220) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 152.660 (152.665) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 267.720 (267.743) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/DayDetailsUITests.swift:486: error: -[HabitsUITests.DayDetailsUITests testEveryKindsAddScreen] : XCTAssertTrue failed - Water: a drag puts the keyboard away
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/DayDetailsUITests.swift:488: error: -[HabitsUITests.DayDetailsUITests testEveryKindsAddScreen] : Failed to get matching snapshot: No matches found for Elements matching predicate '"record-footer" IN identifiers' from input {(
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/DayDetailsUITests.swift:488: error: -[HabitsUITests.DayDetailsUITests testEveryKindsAddScreen] : XCTAssertTrue failed - A footer says what will happen
Test Case '-[HabitsUITests.DayDetailsUITests testCurrencyAndNoUnitAmounts]' passed (51.862 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindDark]' passed (133.905 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindsAddScreen]' failed (38.194 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindShowsItsOwnDay]' passed (152.528 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testHistoryDaysOpenDayDetails]' passed (177.644 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testLogsRuleAndAllLogs]' passed (58.153 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testLogViewThenEditThenDelete]' passed (62.431 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testMarkADayDoneOnlyOnce]' passed (39.263 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testOlderMultiCheckLogStillCorrects]' passed (30.069 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testPastDayLogKeepsItsDayAndChosenTime]' passed (28.995 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testQuitSlipAddViewEditAndDelete]' passed (53.926 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testSkippedDayKeepsLogsAndNote]' passed (57.925 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTasksReschedule]' passed (78.629 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTickSteps]' passed (31.538 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTimeLogAddViewAndEdit]' passed (51.228 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerPauseBackgroundAndSkipPreserveTime]' passed (48.211 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testDailyShapes]' passed (139.332 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testMonthAndYearShapes]' passed (325.949 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAddLogFitsAboveTheKeyboard]' passed (33.818 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAddTimeFitsAboveTheKeyboard]' passed (19.408 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testDayDetailsKeepsSkipOnScreenWithFourLogsAndANote]' passed (49.793 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testEditLogFitsAboveTheKeyboard]' passed (28.597 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testNoteBoxFillsTheRoomAboveSave]' passed (21.043 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (36.778 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (48.930 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (33.807 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogManuallyAddsOneLog]' passed (35.164 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (22.211 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (34.168 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (42.174 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (14.489 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
