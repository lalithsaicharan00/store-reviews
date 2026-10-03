# claude/progress-week-cards @ d8f0d1f

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37122429887 · 2026-10-03 13:04 UTC
Commit: Merge main into claude/progress-week-cards again (Arrange Your Day, text limits, Next Up)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (WeekCardsUITests,ProgressUITests,UndoUITests,TodayUITests,GroupsUITests,TimerUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 0 failures (0 unexpected) in 53.367 (53.368) seconds
	 Executed 41 tests, with 0 failures (0 unexpected) in 1710.868 (1710.913) seconds
	 Executed 41 tests, with 0 failures (0 unexpected) in 1710.868 (1710.917) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 434.340 (434.354) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 256.378 (256.382) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 257.576 (257.581) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 260.014 (260.021) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 449.193 (449.201) seconds
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (59.310 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (204.947 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' passed (58.576 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (73.384 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (38.123 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (13.997 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndRuns]' passed (25.889 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (69.836 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (55.908 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (25.557 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (19.247 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (6.633 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtOverTime]' passed (24.213 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (18.733 seconds).
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (23.131 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (30.236 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (18.696 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (38.393 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (18.443 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (23.582 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (12.131 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (97.733 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (13.049 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (35.550 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (38.811 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (43.871 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (33.852 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds]' passed (45.893 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (19.620 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (21.429 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (37.215 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (15.687 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testHabitPageDark]' passed (46.266 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCards]' passed (44.059 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCardsDark]' passed (26.052 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsDark]' passed (66.800 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsLight]' passed (76.586 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsWithGroups]' passed (23.671 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCards]' passed (73.675 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCardsDark]' passed (36.883 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearScrollAndHabitPage]' passed (55.200 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
