# claude/progress-week-cards-merge-check @ c751e33

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37161180764 · 2026-10-03 23:53 UTC
Commit: Today's rows, one shape: one line under every name (what today asks: how far along, or how often, then the time; tasks say Task; quit rows their best run), after-log Undo and Add/Edit Note as small capsules on one line, notes in their own sheet with Save, a task's row opens a task sheet (Done, date, Do Tomorrow), done habits move down again

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (TodayRowLayoutUITests,TodayRowSheetUITests,TodayUITests,UndoUITests,GoalFlowUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 32 tests, with 20 failures (0 unexpected) in 1316.450 (1316.492) seconds
	 Executed 32 tests, with 20 failures (0 unexpected) in 1316.450 (1316.493) seconds
	 Executed 4 tests, with 5 failures (0 unexpected) in 168.662 (168.665) seconds
	 Executed 6 tests, with 4 failures (0 unexpected) in 464.798 (464.811) seconds
	 Executed 6 tests, with 8 failures (0 unexpected) in 197.394 (197.399) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 290.135 (290.146) seconds
	 Executed 8 tests, with 3 failures (0 unexpected) in 195.462 (195.466) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/GoalFlowUITests.swift:120: error: -[HabitsUITests.GoalFlowUITests testTypingKeyByKey] : Failed to tap "Add an amount to Keys" Button: No matches found for first query match sequence: `Descendants matching type Button` -> `Elements matching predicate '"Add an amount to Keys" IN identifiers'`, given input App element pid: 38145
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/GoalFlowUITests.swift:146: error: -[HabitsUITests.GoalFlowUITests testNumberShowsWithoutAUnit] : XCTAssertTrue failed - Today shows just the numbers
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/GoalFlowUITests.swift:167: error: -[HabitsUITests.GoalFlowUITests testButtonAddsItsStepAndRowOpensAddAmount] : XCTAssertTrue failed - + adds one glass
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/GoalFlowUITests.swift:198: error: -[HabitsUITests.GoalFlowUITests testOwnStep] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayRowLayoutUITests.swift:109: error: -[HabitsUITests.TodayRowLayoutUITests testQuitRowSwipeLogsASlip] : Failed to swipe left "Smoking" StaticText: No matches found for first query match sequence: `Descendants matching type StaticText` -> `Elements matching predicate '"Smoking" IN identifiers'`, given input App element pid: 46880
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayRowLayoutUITests.swift:44: error: -[HabitsUITests.TodayRowLayoutUITests testOneLineUnderEveryName] : XCTAssertTrue failed - Water
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayRowLayoutUITests.swift:46: error: -[HabitsUITests.TodayRowLayoutUITests testOneLineUnderEveryName] : XCTAssertTrue failed - Water's line says "/8 glasses": 
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayRowLayoutUITests.swift:47: error: -[HabitsUITests.TodayRowLayoutUITests testOneLineUnderEveryName] : Failed to get matching snapshot: No matches found for first query match sequence: `Descendants matching type StaticText` -> `Elements matching predicate 'identifier == "habit-line" AND label CONTAINS "/8 glasses"'`, given input App element pid: 45453
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayRowLayoutUITests.swift:89: error: -[HabitsUITests.TodayRowLayoutUITests testTaskRowOpensItsSheet] : Failed to tap "Pay the phone bill" StaticText: No matches found for first query match sequence: `Descendants matching type StaticText` -> `Elements matching predicate '"Pay the phone bill" IN identifiers'`, given input App element pid: 48691
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayRowSheetUITests.swift:120: error: -[HabitsUITests.TodayRowSheetUITests testSwipeActions] : XCTAssertTrue failed - Water starts at 8/8
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayRowSheetUITests.swift:121: error: -[HabitsUITests.TodayRowSheetUITests testSwipeActions] : Failed to swipe right "Water" StaticText: No matches found for first query match sequence: `Descendants matching type StaticText` -> `Elements matching predicate '"Water" IN identifiers'`, given input App element pid: 55023
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayRowSheetUITests.swift:156: error: -[HabitsUITests.TodayRowSheetUITests testTickTogglesAndPlusAdds] : XCTAssertTrue failed - + adds past the goal
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayRowSheetUITests.swift:159: error: -[HabitsUITests.TodayRowSheetUITests testTickTogglesAndPlusAdds] : XCTAssertTrue failed - + adds again, never takes one back
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayRowSheetUITests.swift:170: error: -[HabitsUITests.TodayRowSheetUITests testLongPressMenu] : Failed to get matching snapshot: No matches found for first query match sequence: `Descendants matching type StaticText` -> `Elements matching predicate '"Water" IN identifiers'`, given input App element pid: 49645
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayRowSheetUITests.swift:43: error: -[HabitsUITests.TodayRowSheetUITests testRowOpensDaySheetForEveryKind] : Failed to tap "Water" StaticText: No matches found for first query match sequence: `Descendants matching type StaticText` -> `Elements matching predicate '"Water" IN identifiers'`, given input App element pid: 51518
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayRowSheetUITests.swift:43: error: -[HabitsUITests.TodayRowSheetUITests testSheetActionsAndDeleteInTheMenu] : Failed to tap "Call family" StaticText: No matches found for first query match sequence: `Descendants matching type StaticText` -> `Elements matching predicate '"Call family" IN identifiers'`, given input App element pid: 52630
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayRowSheetUITests.swift:43: error: -[HabitsUITests.TodayRowSheetUITests testSheetFollowsTheDayShown] : Failed to tap "Water" StaticText: No matches found for first query match sequence: `Descendants matching type StaticText` -> `Elements matching predicate '"Water" IN identifiers'`, given input App element pid: 54255
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/UndoUITests.swift:185: error: -[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/UndoUITests.swift:63: error: -[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited] : Failed to tap "Read a little" StaticText: No matches found for Elements matching predicate '"Read a little" IN identifiers' from input {(
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/UndoUITests.swift:81: error: -[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone] : Failed to tap "Stretch" StaticText: No matches found for Elements matching predicate '"Stretch" IN identifiers' from input {(
Test Case '-[HabitsUITests.GoalFlowUITests testButtonAddsItsStepAndRowOpensAddAmount]' failed (108.334 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testHowOftenChoicesSayTheAmount]' passed (66.883 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testNumberShowsWithoutAUnit]' failed (83.807 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testOwnStep]' failed (65.551 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testTypingKeyByKey]' failed (95.951 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testUnitScreen]' passed (44.272 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testAfterLogButtonsAndNoteSheet]' passed (56.509 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testOneLineUnderEveryName]' failed (36.923 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testQuitRowSwipeLogsASlip]' failed (39.730 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testTaskRowOpensItsSheet]' failed (35.500 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testLongPressMenu]' failed (41.816 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testRowOpensDaySheetForEveryKind]' failed (36.780 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetActionsAndDeleteInTheMenu]' failed (36.498 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetFollowsTheDayShown]' failed (23.220 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSwipeActions]' failed (32.963 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testTickTogglesAndPlusAdds]' failed (26.117 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (25.904 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (48.646 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (22.573 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (28.150 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (16.817 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (104.134 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (15.064 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (28.846 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' failed (33.157 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (32.111 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (28.647 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds]' passed (35.410 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (17.664 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' failed (18.282 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' failed (18.891 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (11.301 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
