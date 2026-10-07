# day-details-logs-notes-redesign @ d847158

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37609521328 · 2026-10-07 11:26 UTC
Commit: Day details redesign: Core sync test for an edited log time; checklist, Design Rules and branch notes

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (DayDetailsUITests,UndoUITests,TodayRowLayoutUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 15 tests, with 9 failures (0 unexpected) in 1113.702 (1113.721) seconds
	 Executed 27 tests, with 10 failures (0 unexpected) in 1410.556 (1410.584) seconds
	 Executed 27 tests, with 10 failures (0 unexpected) in 1410.556 (1410.588) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 93.354 (93.356) seconds
	 Executed 8 tests, with 1 failure (0 unexpected) in 203.500 (203.504) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/DayDetailsUITests.swift:250: error: -[HabitsUITests.DayDetailsUITests testLogsRuleAndAllLogs] : XCTAssertTrue failed - Back to All logs after deleting
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/DayDetailsUITests.swift:251: error: -[HabitsUITests.DayDetailsUITests testLogsRuleAndAllLogs] : XCTAssertEqual failed: ("0") is not equal to ("3")
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/DayDetailsUITests.swift:252: error: -[HabitsUITests.DayDetailsUITests testLogsRuleAndAllLogs] : Failed to tap Button (Element at index 0): No matches found for Elements matching predicate '"Today's logs" IN identifiers' from input {(
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/DayDetailsUITests.swift:351: error: -[HabitsUITests.DayDetailsUITests testLogViewThenEditThenDelete] : XCTAssertTrue failed - Exactly one log removed: Less coffee | 0/2 cups max | 9 left | Drink water | 1/2 glasses | Stretch | 0/3 times | Clean kitchen | 1/3 steps | Read a little | 0 min/20 min | Water the plants | Task | Call family | 2/3 this week | Monthly reading | 0 min/1 h this month | Quit or Cut Down | Anytime | Start | Undo Wash dishes | Add Note | Today | 0/9
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/DayDetailsUITests.swift:352: error: -[HabitsUITests.DayDetailsUITests testLogViewThenEditThenDelete] : XCTAssertEqual failed: ("0") is not equal to ("1") - The other log stays
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/DayDetailsUITests.swift:353: error: -[HabitsUITests.DayDetailsUITests testLogViewThenEditThenDelete] : Failed to tap "day-close" Button: No matches found for Elements matching predicate '"day-close" IN identifiers' from input {(
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/DayDetailsUITests.swift:444: error: -[HabitsUITests.DayDetailsUITests testQuitSlipAddViewEditAndDelete] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/DayDetailsUITests.swift:446: error: -[HabitsUITests.DayDetailsUITests testQuitSlipAddViewEditAndDelete] : Failed to tap "day-close" Button: No matches found for Elements matching predicate '"day-close" IN identifiers' from input {(
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/DayDetailsUITests.swift:550: error: -[HabitsUITests.DayDetailsUITests testPastDayLogKeepsItsDayAndChosenTime] : XCTAssertTrue failed - The day it was opened from is chosen
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/UndoUITests.swift:158: error: -[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet] : XCTAssertTrue failed
Test Case '-[HabitsUITests.DayDetailsUITests testCurrencyAndNoUnitAmounts]' passed (92.103 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindDark]' passed (99.994 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindsAddScreen]' passed (303.106 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindShowsItsOwnDay]' passed (138.933 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testHistoryDaysOpenDayDetails]' passed (112.821 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testLogsRuleAndAllLogs]' failed (34.389 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testLogViewThenEditThenDelete]' failed (52.066 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testMarkADayDoneOnlyOnce]' passed (34.373 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testOlderMultiCheckLogStillCorrects]' passed (28.162 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testPastDayLogKeepsItsDayAndChosenTime]' failed (28.579 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testQuitSlipAddViewEditAndDelete]' failed (40.325 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testSkippedDayKeepsLogsAndNote]' passed (40.436 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTasksReschedule]' passed (56.786 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTickSteps]' passed (16.391 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTimeLogAddViewAndEdit]' passed (35.239 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testAfterLogButtonsAndNoteSheet]' passed (30.637 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testOneLineUnderEveryName]' passed (12.143 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testQuitRowSwipeLogsASlip]' passed (18.394 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testTaskRowOpensItsSheet]' passed (32.180 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (31.734 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' failed (41.319 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (29.241 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogManuallyAddsOneLog]' passed (26.165 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (19.353 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (17.640 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (25.976 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (12.073 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
