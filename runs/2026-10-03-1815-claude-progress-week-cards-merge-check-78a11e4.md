# claude/progress-week-cards-merge-check @ 78a11e4

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37141080814 · 2026-10-03 18:15 UTC
Commit: Today's rows: a tap opens the Day sheet for the day shown; ✓ toggles that day's tick, + adds; swipes reveal Note/Skip/Pause and a named Undo; long press matches the sheet; Delete only in the sheet's ⋯ menu; done habits stay in place

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (TodayRowSheetUITests,TodayUITests,UndoUITests,GoalFlowUITests,PersistenceUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 32 tests, with 14 failures (0 unexpected) in 1418.512 (1418.553) seconds
	 Executed 32 tests, with 14 failures (0 unexpected) in 1418.512 (1418.556) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 146.199 (146.203) seconds
	 Executed 6 tests, with 4 failures (0 unexpected) in 489.789 (489.799) seconds
	 Executed 6 tests, with 8 failures (0 unexpected) in 211.286 (211.292) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 308.389 (308.398) seconds
	 Executed 8 tests, with 2 failures (0 unexpected) in 262.849 (262.856) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/GoalFlowUITests.swift:120: error: -[HabitsUITests.GoalFlowUITests testTypingKeyByKey] : Failed to tap "Add an amount to Keys" Button: No matches found for first query match sequence: `Descendants matching type Button` -> `Elements matching predicate '"Add an amount to Keys" IN identifiers'`, given input App element pid: 40454
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/GoalFlowUITests.swift:146: error: -[HabitsUITests.GoalFlowUITests testNumberShowsWithoutAUnit] : XCTAssertTrue failed - Today shows just the numbers
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/GoalFlowUITests.swift:167: error: -[HabitsUITests.GoalFlowUITests testButtonAddsItsStepAndRowOpensAddAmount] : XCTAssertTrue failed - + adds one glass
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/GoalFlowUITests.swift:198: error: -[HabitsUITests.GoalFlowUITests testOwnStep] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayRowSheetUITests.swift:120: error: -[HabitsUITests.TodayRowSheetUITests testSwipeActions] : XCTAssertTrue failed - Water starts at 8/8
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayRowSheetUITests.swift:121: error: -[HabitsUITests.TodayRowSheetUITests testSwipeActions] : Failed to swipe right "Water" StaticText: No matches found for first query match sequence: `Descendants matching type StaticText` -> `Elements matching predicate '"Water" IN identifiers'`, given input App element pid: 54791
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayRowSheetUITests.swift:156: error: -[HabitsUITests.TodayRowSheetUITests testTickTogglesAndPlusAdds] : XCTAssertTrue failed - + adds past the goal
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayRowSheetUITests.swift:159: error: -[HabitsUITests.TodayRowSheetUITests testTickTogglesAndPlusAdds] : XCTAssertTrue failed - + adds again, never takes one back
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayRowSheetUITests.swift:170: error: -[HabitsUITests.TodayRowSheetUITests testLongPressMenu] : Failed to get matching snapshot: No matches found for first query match sequence: `Descendants matching type StaticText` -> `Elements matching predicate '"Water" IN identifiers'`, given input App element pid: 49181
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayRowSheetUITests.swift:43: error: -[HabitsUITests.TodayRowSheetUITests testRowOpensDaySheetForEveryKind] : Failed to tap "Water" StaticText: No matches found for first query match sequence: `Descendants matching type StaticText` -> `Elements matching predicate '"Water" IN identifiers'`, given input App element pid: 51121
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayRowSheetUITests.swift:43: error: -[HabitsUITests.TodayRowSheetUITests testSheetActionsAndDeleteInTheMenu] : Failed to tap "Call family" StaticText: No matches found for first query match sequence: `Descendants matching type StaticText` -> `Elements matching predicate '"Call family" IN identifiers'`, given input App element pid: 51981
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayRowSheetUITests.swift:43: error: -[HabitsUITests.TodayRowSheetUITests testSheetFollowsTheDayShown] : Failed to tap "Water" StaticText: No matches found for first query match sequence: `Descendants matching type StaticText` -> `Elements matching predicate '"Water" IN identifiers'`, given input App element pid: 53982
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/UndoUITests.swift:63: error: -[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited] : Failed to tap "Read a little" StaticText: No matches found for Elements matching predicate '"Read a little" IN identifiers' from input {(
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/UndoUITests.swift:81: error: -[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone] : Failed to tap "Stretch" StaticText: No matches found for Elements matching predicate '"Stretch" IN identifiers' from input {(
Test Case '-[HabitsUITests.GoalFlowUITests testButtonAddsItsStepAndRowOpensAddAmount]' failed (159.540 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testHowOftenChoicesSayTheAmount]' passed (73.432 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testNumberShowsWithoutAUnit]' failed (64.299 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testOwnStep]' failed (68.724 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testTypingKeyByKey]' failed (89.872 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testUnitScreen]' passed (33.922 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testFailedWriteIsTakenBack]' passed (37.591 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testHabitAndTickSurviveRelaunch]' passed (50.391 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testQuickTapsSurviveLeavingTheApp]' passed (46.366 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testUnopenableDatabaseSaysSoAndTakesNoChanges]' passed (11.852 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testLongPressMenu]' failed (36.681 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testRowOpensDaySheetForEveryKind]' failed (34.161 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetActionsAndDeleteInTheMenu]' failed (43.554 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetFollowsTheDayShown]' failed (23.172 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSwipeActions]' failed (39.874 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testTickTogglesAndPlusAdds]' failed (33.842 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (23.873 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (45.613 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (22.645 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (29.565 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (21.985 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (112.457 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (14.976 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (37.275 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (44.904 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (49.820 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (35.201 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds]' passed (44.760 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (19.897 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' failed (25.541 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' failed (27.800 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (14.926 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
