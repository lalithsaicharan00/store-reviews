# details-page-update @ 9a8a0b1

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37281527130 · 2026-10-05 08:46 UTC
Commit: Merge main (HabitCreationUITests fix) into details-page-update

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (DayDetailsUITests,TodayRowSheetUITests,TodayRowLayoutUITests,UndoUITests,HabitPageUITests/testHistoryFlows,TimerUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 32 tests, with 2 failures (0 unexpected) in 1411.330 (1411.367) seconds
	 Executed 32 tests, with 2 failures (0 unexpected) in 1411.330 (1411.369) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 104.956 (104.960) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 133.031 (133.034) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 208.507 (208.511) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 250.088 (250.095) seconds
	 Executed 8 tests, with 2 failures (0 unexpected) in 656.962 (656.971) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/DayDetailsUITests.swift:225: error: -[HabitsUITests.DayDetailsUITests testEditLogAsksBeforeLosingOrDeleting] : XCTAssertTrue failed - Back with changes asks first
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/DayDetailsUITests.swift:231: error: -[HabitsUITests.DayDetailsUITests testEditLogAsksBeforeLosingOrDeleting] : XCTAssertEqual failed: ("Optional("30")") is not equal to ("Optional("3")") - Keep Editing keeps the draft
Test Case '-[HabitsUITests.DayDetailsUITests testEditLogAsksBeforeLosingOrDeleting]' failed (132.825 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindDark]' passed (75.975 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindShowsItsOwnDay]' passed (115.135 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testHistoryDaysOpenDayDetails]' passed (142.660 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testMultiCheckRecordEditsItsCount]' passed (32.804 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testQuitSlipRecordEditAndDelete]' passed (42.117 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testSkippedDayKeepsLogsAndNote]' passed (48.370 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTasksReschedule]' passed (67.076 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testHistoryFlows]' passed (57.786 seconds).
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (36.344 seconds).
Test Case '-[HabitsUITests.TimerUITests testPlayOpensTimerScreenThatClosesWithoutStopping]' passed (33.951 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (30.152 seconds).
Test Case '-[HabitsUITests.TimerUITests testScreenCanBeTurnedOff]' passed (13.018 seconds).
Test Case '-[HabitsUITests.TimerUITests testTimerScreenPauseKeepsTimeAndResumes]' passed (19.566 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testAfterLogButtonsAndNoteSheet]' passed (37.295 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testOneLineUnderEveryName]' passed (13.192 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testQuitRowSwipeLogsASlip]' passed (18.603 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testTaskRowOpensItsSheet]' passed (35.866 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testLongPressMenu]' passed (24.363 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testRowOpensDaySheetForEveryKind]' passed (45.212 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetActionsAndDeleteInTheMenu]' passed (46.990 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetFollowsTheDayShown]' passed (28.548 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSwipeActions]' passed (41.803 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testTickTogglesAndPlusAdds]' passed (21.591 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (40.434 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (47.811 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (34.272 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds]' passed (40.668 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (21.387 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (21.166 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (27.650 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (16.699 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
