# claude/progress-week-cards @ 569f547

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37113157131 · 2026-10-03 10:11 UTC
Commit: Rulebook check before merging into main: no "due" or "missed" in the app's words; speed scenarios for the new interactions

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (WeekCardsUITests,ProgressUITests,UndoUITests,TodayUITests,GroupsUITests,TimerUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 0 failures (0 unexpected) in 62.663 (62.666) seconds
	 Executed 41 tests, with 0 failures (0 unexpected) in 1699.750 (1699.793) seconds
	 Executed 41 tests, with 0 failures (0 unexpected) in 1699.750 (1699.795) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 341.161 (341.166) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 245.757 (245.764) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 289.399 (289.406) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 323.224 (323.232) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 437.544 (437.551) seconds
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (73.356 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (134.179 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' passed (43.980 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (58.394 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (31.251 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (12.029 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndRuns]' passed (32.864 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (74.112 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (96.594 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (27.300 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (21.702 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (8.422 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtOverTime]' passed (28.645 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (21.556 seconds).
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (25.441 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (37.223 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (23.352 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (41.729 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (21.646 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (28.000 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (14.933 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (106.706 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (17.036 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (35.997 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (43.111 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (44.125 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (36.752 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds]' passed (42.140 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (18.892 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (18.464 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (28.118 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (14.156 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testHabitPageDark]' passed (44.447 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCards]' passed (43.280 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCardsDark]' passed (24.666 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsDark]' passed (66.275 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsLight]' passed (73.919 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsWithGroups]' passed (20.165 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCards]' passed (72.048 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCardsDark]' passed (34.511 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearScrollAndHabitPage]' passed (58.233 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
