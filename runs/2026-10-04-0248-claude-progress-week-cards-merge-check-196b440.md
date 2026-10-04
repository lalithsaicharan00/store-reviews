# claude/progress-week-cards-merge-check @ 196b440

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37170555616 · 2026-10-04 02:48 UTC
Commit: A skipped habit stays on Today as a neutral "Skipped today" row (it vanished, so Undo Skip had nowhere to be); sheets say Yesterday; NewHabit expects +1 for twice a day

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (TodayRowSheetUITests,TodayRowLayoutUITests,TodayUITests,UndoUITests,GoalFlowUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 32 tests, with 0 failures (0 unexpected) in 1167.223 (1167.252) seconds
	 Executed 32 tests, with 0 failures (0 unexpected) in 1167.223 (1167.253) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 193.886 (193.889) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 183.799 (183.804) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 301.349 (301.355) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 222.727 (222.732) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 265.462 (265.467) seconds
Test Case '-[HabitsUITests.GoalFlowUITests testButtonAddsItsStepAndRowOpensAddAmount]' passed (72.996 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testHowOftenChoicesSayTheAmount]' passed (49.141 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testNumberShowsWithoutAUnit]' passed (35.521 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testOwnStep]' passed (46.452 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testTypingKeyByKey]' passed (70.886 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testUnitScreen]' passed (26.353 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testAfterLogButtonsAndNoteSheet]' passed (132.169 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testOneLineUnderEveryName]' passed (15.690 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testQuitRowSwipeLogsASlip]' passed (21.965 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testTaskRowOpensItsSheet]' passed (24.062 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testLongPressMenu]' passed (21.794 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testRowOpensDaySheetForEveryKind]' passed (43.259 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetActionsAndDeleteInTheMenu]' passed (38.834 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetFollowsTheDayShown]' passed (24.114 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSwipeActions]' passed (29.615 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testTickTogglesAndPlusAdds]' passed (26.183 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (22.314 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (40.563 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (19.163 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (25.090 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (12.607 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (100.762 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (12.129 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (32.832 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (32.772 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (37.697 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (29.883 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds]' passed (40.911 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (19.532 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (18.140 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (31.175 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (12.616 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
