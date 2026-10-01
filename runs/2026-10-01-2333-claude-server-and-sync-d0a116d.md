# claude/server-and-sync @ d0a116d

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36938608596 · 2026-10-01 23:33 UTC
Commit: Backup: the 'changed since the last backup' flag is written only when it flips, not after every change

- Core storage and migrations: success
- Build: success
- UI tests (TodayUITests,UndoUITests,TimerUITests,GroupsUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 0 failures (0 unexpected) in 61.961 (61.964) seconds
	 Executed 23 tests, with 0 failures (0 unexpected) in 1071.786 (1071.815) seconds
	 Executed 23 tests, with 0 failures (0 unexpected) in 1071.786 (1071.818) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 446.339 (446.350) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 221.861 (221.866) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 341.624 (341.630) seconds
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (71.167 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (115.682 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' passed (135.885 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (80.066 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (43.539 seconds).
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (26.293 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (35.668 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (24.126 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (101.358 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (23.908 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (32.198 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (13.132 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (97.298 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (11.641 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (37.962 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (37.632 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (33.180 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (31.254 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds]' passed (41.478 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (19.600 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (17.552 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (28.301 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (12.864 seconds).
```
