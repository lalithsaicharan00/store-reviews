# claude/habit-details-ci @ 7e79386

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37124864062 · 2026-10-03 13:38 UTC
Commit: Habit page: HabitOverall, not HabitRecord (the shared core already has a HabitRecord)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (HabitPageUITests,UndoUITests,TasksUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 17 tests, with 6 failures (0 unexpected) in 1217.772 (1217.794) seconds
	 Executed 17 tests, with 6 failures (0 unexpected) in 1217.772 (1217.796) seconds
	 Executed 3 tests, with 0 failures (0 unexpected) in 135.154 (135.156) seconds
	 Executed 6 tests, with 2 failures (0 unexpected) in 886.815 (886.826) seconds
	 Executed 8 tests, with 4 failures (0 unexpected) in 195.803 (195.808) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitPageUITests.swift:168: error: -[HabitsUITests.HabitPageUITests testNotesFlows] : XCTAssertTrue failed - The note is found
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitPageUITests.swift:169: error: -[HabitsUITests.HabitPageUITests testNotesFlows] : Failed to tap Button (First Match): No matches found for first query match sequence: `Descendants matching type Button` -> `Elements matching predicate 'identifier BEGINSWITH "note-"'`, given input App element pid: 26255
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/UndoUITests.swift:109: error: -[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/UndoUITests.swift:150: error: -[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/UndoUITests.swift:163: error: -[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact] : XCTAssertTrue failed - Only the new log was removed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/UndoUITests.swift:187: error: -[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit] : XCTAssertTrue failed
Test Case '-[HabitsUITests.HabitPageUITests testHistoryFlows]' passed (129.914 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFlows]' failed (67.398 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDailyTypes]' passed (301.978 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDark]' passed (124.661 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesPeriodLimitQuit]' passed (221.017 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testYearInPixels]' passed (41.847 seconds).
Test Case '-[HabitsUITests.TasksUITests testCreateTaskFromTasksAndEditSurvivesRelaunch]' passed (51.266 seconds).
Test Case '-[HabitsUITests.TasksUITests testEveryTaskAppearsAndCanOpenEdit]' passed (78.216 seconds).
Test Case '-[HabitsUITests.TasksUITests testTaskModelAndPersistence]' passed (5.671 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' failed (32.963 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' failed (17.477 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' failed (25.399 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds]' failed (41.794 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (18.212 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (18.824 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (29.215 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (11.919 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
