# claude/lucid-johnson-egrjup-ci5 @ d80d397

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38099890971 · 2026-10-11 01:49 UTC
Commit: Widgets faster: week and month totals from the per-day index; the widget lock opened for speed work; App Lock's SE test scrolls to App Passcode

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (ProgressUITests,UndoUITests,GroupsUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 1 failure (0 unexpected) in 536.894 (536.902) seconds
	 Executed 27 tests, with 1 failure (0 unexpected) in 1058.482 (1058.505) seconds
	 Executed 27 tests, with 1 failure (0 unexpected) in 1058.482 (1058.508) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 239.632 (239.637) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 281.956 (281.963) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/GroupsUITests.swift:143: error: -[HabitsUITests.GroupsUITests testChipsAndEmptyGroup] : XCTAssertTrue failed
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' failed (72.679 seconds).
Test Case '-[HabitsUITests.GroupsUITests testDeletingAGroupKeepsItsHabits]' passed (45.938 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (68.331 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' passed (45.882 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupDragDropsReliably]' passed (111.930 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (59.520 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupOrderIsThePersonsOwn]' passed (36.241 seconds).
Test Case '-[HabitsUITests.GroupsUITests testNamesAreUniqueAndAGroupCanPause]' passed (36.235 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (28.906 seconds).
Test Case '-[HabitsUITests.GroupsUITests testTodayAndProgressKeepTheirOwnChoiceAndStartPlaysWhatsShown]' passed (31.232 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (14.063 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndMilestones]' passed (34.280 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (76.068 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (45.377 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (32.839 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (20.323 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (8.554 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtProgress]' passed (29.139 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (21.313 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (33.934 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (56.875 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (32.863 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogManuallyAddsOneLog]' passed (26.861 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (23.335 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (19.634 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (31.408 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (14.721 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
