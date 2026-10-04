# claude/progress-week-cards-merge-check @ b55579d

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37164548659 · 2026-10-04 00:53 UTC
Commit: Today rows: only named accessibility actions on a row's container (a default action or hint merged the texts, so names stopped reading as text); HabitCreation expects +1 for twice a day (U14)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (TodayRowLayoutUITests,TodayRowSheetUITests,TodayUITests,UndoUITests,GoalFlowUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 32 tests, with 10 failures (0 unexpected) in 1028.126 (1028.165) seconds
	 Executed 32 tests, with 10 failures (0 unexpected) in 1028.126 (1028.169) seconds
	 Executed 4 tests, with 4 failures (0 unexpected) in 100.287 (100.289) seconds
	 Executed 6 tests, with 1 failure (0 unexpected) in 378.590 (378.611) seconds
	 Executed 6 tests, with 4 failures (0 unexpected) in 132.910 (132.914) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 235.308 (235.313) seconds
	 Executed 8 tests, with 1 failure (0 unexpected) in 181.030 (181.035) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/GoalFlowUITests.swift:120: error: -[HabitsUITests.GoalFlowUITests testTypingKeyByKey] : Failed to tap "Add an amount to Keys" Button: No matches found for first query match sequence: `Descendants matching type Button` -> `Elements matching predicate '"Add an amount to Keys" IN identifiers'`, given input App element pid: 42122
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayRowLayoutUITests.swift:44: error: -[HabitsUITests.TodayRowLayoutUITests testOneLineUnderEveryName] : XCTAssertTrue failed - Pay the phone bill
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayRowLayoutUITests.swift:46: error: -[HabitsUITests.TodayRowLayoutUITests testOneLineUnderEveryName] : XCTAssertTrue failed - Pay the phone bill's line says "Task": Best 45 days | Best 47 days | 12 min/20 min | 0/3 this week | 8/8 glasses
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayRowLayoutUITests.swift:47: error: -[HabitsUITests.TodayRowLayoutUITests testOneLineUnderEveryName] : Failed to get matching snapshot: No matches found for first query match sequence: `Descendants matching type StaticText` -> `Elements matching predicate 'identifier == "habit-line" AND label CONTAINS "Task"'`, given input App element pid: 48500
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayRowLayoutUITests.swift:89: error: -[HabitsUITests.TodayRowLayoutUITests testTaskRowOpensItsSheet] : Failed to tap "Pay the phone bill" StaticText: No matches found for first query match sequence: `Descendants matching type StaticText` -> `Elements matching predicate '"Pay the phone bill" IN identifiers'`, given input App element pid: 50162
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayRowSheetUITests.swift:108: error: -[HabitsUITests.TodayRowSheetUITests testSheetActionsAndDeleteInTheMenu] : Failed to tap "Cancel" Button: No matches found for first query match sequence: `Descendants matching type Button` -> `Elements matching predicate '"Cancel" IN identifiers'`, given input App element pid: 53766
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayRowSheetUITests.swift:123: error: -[HabitsUITests.TodayRowSheetUITests testSwipeActions] : XCTAssertTrue failed - Swipe right offers Undo
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayRowSheetUITests.swift:124: error: -[HabitsUITests.TodayRowSheetUITests testSwipeActions] : Failed to get matching snapshot: No matches found for Elements matching predicate '"row-swipe-undo" IN identifiers' from input {(
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayRowSheetUITests.swift:43: error: -[HabitsUITests.TodayRowSheetUITests testSheetFollowsTheDayShown] : Failed to tap "Water" StaticText: No matches found for first query match sequence: `Descendants matching type StaticText` -> `Elements matching predicate '"Water" IN identifiers'`, given input App element pid: 55743
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/UndoUITests.swift:185: error: -[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit] : XCTAssertTrue failed
Test Case '-[HabitsUITests.GoalFlowUITests testButtonAddsItsStepAndRowOpensAddAmount]' passed (124.283 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testHowOftenChoicesSayTheAmount]' passed (48.069 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testNumberShowsWithoutAUnit]' passed (40.000 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testOwnStep]' passed (53.201 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testTypingKeyByKey]' failed (86.966 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testUnitScreen]' passed (26.070 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testAfterLogButtonsAndNoteSheet]' passed (34.993 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testOneLineUnderEveryName]' failed (23.932 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testQuitRowSwipeLogsASlip]' passed (18.267 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testTaskRowOpensItsSheet]' failed (23.095 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testLongPressMenu]' passed (18.722 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testRowOpensDaySheetForEveryKind]' passed (34.203 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetActionsAndDeleteInTheMenu]' failed (31.866 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetFollowsTheDayShown]' failed (16.484 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSwipeActions]' failed (15.247 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testTickTogglesAndPlusAdds]' passed (16.388 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (17.264 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (37.501 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (17.646 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (22.307 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (10.776 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (91.018 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (10.705 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (28.092 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' failed (22.649 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (33.932 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (27.074 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds]' passed (33.939 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (17.485 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (12.947 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (22.153 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (10.852 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
