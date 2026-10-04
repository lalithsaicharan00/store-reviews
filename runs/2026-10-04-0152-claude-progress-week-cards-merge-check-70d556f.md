# claude/progress-week-cards-merge-check @ 70d556f

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37167900140 · 2026-10-04 01:52 UTC
Commit: Tests follow the row work: swipes drag a fixed distance (a name is too narrow for XCUITest's swipe), yesterday opens Anytime first, the task test uses the task fixture, GoalFlow types other amounts through the Day sheet, results read "3/3 times"; the delete question gets an explicit Cancel

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (TodayRowLayoutUITests,TodayRowSheetUITests,UndoUITests,GoalFlowUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 24 tests, with 2 failures (0 unexpected) in 950.880 (950.899) seconds
	 Executed 24 tests, with 2 failures (0 unexpected) in 950.880 (950.904) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 82.767 (82.769) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 413.661 (413.667) seconds
	 Executed 6 tests, with 2 failures (0 unexpected) in 266.210 (266.213) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 188.243 (188.246) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayRowSheetUITests.swift:149: error: -[HabitsUITests.TodayRowSheetUITests testSwipeActions] : Failed to get matching snapshot: No matches found for first query match sequence: `Descendants matching type StaticText` -> `Elements matching predicate '"Water" IN identifiers'`, given input App element pid: 55880
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayRowSheetUITests.swift:87: error: -[HabitsUITests.TodayRowSheetUITests testSheetFollowsTheDayShown] : XCTAssertTrue failed - Opened from yesterday, it's yesterday
Test Case '-[HabitsUITests.GoalFlowUITests testButtonAddsItsStepAndRowOpensAddAmount]' passed (146.034 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testHowOftenChoicesSayTheAmount]' passed (52.932 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testNumberShowsWithoutAUnit]' passed (46.206 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testOwnStep]' passed (55.792 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testTypingKeyByKey]' passed (84.902 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testUnitScreen]' passed (27.796 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testAfterLogButtonsAndNoteSheet]' passed (34.775 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testOneLineUnderEveryName]' passed (10.844 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testQuitRowSwipeLogsASlip]' passed (18.121 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testTaskRowOpensItsSheet]' passed (19.027 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testLongPressMenu]' passed (26.645 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testRowOpensDaySheetForEveryKind]' passed (105.399 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetActionsAndDeleteInTheMenu]' passed (69.350 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetFollowsTheDayShown]' failed (25.381 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSwipeActions]' failed (23.298 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testTickTogglesAndPlusAdds]' passed (16.136 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (26.850 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (34.222 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (25.927 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds]' passed (34.894 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (18.005 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (14.062 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (23.426 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (10.856 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
