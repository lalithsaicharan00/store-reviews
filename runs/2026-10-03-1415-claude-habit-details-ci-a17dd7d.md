# claude/habit-details-ci @ a17dd7d

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37127064287 · 2026-10-03 14:15 UTC
Commit: Habit page: History and Notes months with ids unique across tabs (History's card showed under Notes); Undo tests read the Day sheet's own Result row

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (HabitPageUITests,UndoUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 14 tests, with 0 failures (0 unexpected) in 1127.136 (1127.154) seconds
	 Executed 14 tests, with 0 failures (0 unexpected) in 1127.136 (1127.157) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 873.177 (873.185) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 253.959 (253.966) seconds
Test Case '-[HabitsUITests.HabitPageUITests testHistoryFlows]' passed (127.302 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFlows]' passed (69.857 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDailyTypes]' passed (283.856 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDark]' passed (115.884 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesPeriodLimitQuit]' passed (234.599 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testYearInPixels]' passed (41.680 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (34.687 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (41.516 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (33.153 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds]' passed (44.444 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (19.398 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (24.291 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (41.165 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (15.305 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
