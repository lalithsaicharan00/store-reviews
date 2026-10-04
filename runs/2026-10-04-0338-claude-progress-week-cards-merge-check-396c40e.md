# claude/progress-week-cards-merge-check @ 396c40e

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37173645868 · 2026-10-04 03:38 UTC
Commit: After-log line: one layout instead of ViewThatFits (it measured three layouts each time the line appeared and doubled the cost of changing days: 72 vs 14 ms/s, bisected side by side); Rulebook S10 and lesson L21

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (TodayRowLayoutUITests,TodayRowSheetUITests,TodayUITests,UndoUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 26 tests, with 0 failures (0 unexpected) in 710.409 (710.431) seconds
	 Executed 26 tests, with 0 failures (0 unexpected) in 710.409 (710.432) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 88.428 (88.431) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 149.196 (149.200) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 178.681 (178.685) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 294.104 (294.113) seconds
Test Case '-[HabitsUITests.TodayRowLayoutUITests testAfterLogButtonsAndNoteSheet]' passed (43.728 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testOneLineUnderEveryName]' passed (10.279 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testQuitRowSwipeLogsASlip]' passed (16.605 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testTaskRowOpensItsSheet]' passed (17.816 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testLongPressMenu]' passed (18.632 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testRowOpensDaySheetForEveryKind]' passed (34.627 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetActionsAndDeleteInTheMenu]' passed (33.821 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetFollowsTheDayShown]' passed (21.786 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSwipeActions]' passed (23.909 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testTickTogglesAndPlusAdds]' passed (16.421 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (17.445 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (36.387 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (16.419 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (31.938 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (19.163 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (125.177 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (10.660 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (36.915 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (26.114 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (30.423 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (25.730 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds]' passed (34.023 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (16.859 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (13.232 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (21.242 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (11.059 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
