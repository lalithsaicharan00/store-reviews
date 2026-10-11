# claude/pensive-gates-3n4ie8-ci3 @ c5b1da3

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38131139022 · 2026-10-11 11:37 UTC
Commit: Current Work 86/88: Day details' popover hangs on Today, pointing at its row; iPad tests; iPad speed runs; coming back to the iPhone

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (TodayUITests,TimerUITests,ProgressUITests,GroupsUITests,UndoUITests,DayDetailsUITests): cancelled
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 500.157 (500.163) seconds
	 Executed 15 tests, with 3 failures (0 unexpected) in 1239.249 (1239.262) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 110.287 (110.290) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 221.219 (221.223) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/DayDetailsUITests.swift:604: error: -[HabitsUITests.DayDetailsUITests testTasksReschedule] : XCTAssertTrue failed - Moving closes Day details
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/DayDetailsUITests.swift:68: error: -[HabitsUITests.DayDetailsUITests testEveryKindDark] : Failed to not hittable: StaticText, {{76.0, 212.8}, {87.7, 20.3}}, label: 'Less coffee'
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/DayDetailsUITests.swift:75: error: -[HabitsUITests.DayDetailsUITests testEveryKindDark] : XCTAssertTrue failed
Test Case '-[HabitsUITests.DayDetailsUITests testCurrencyAndNoUnitAmounts]' passed (58.946 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindDark]' failed (166.972 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindsAddScreen]' passed (363.013 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindShowsItsOwnDay]' passed (115.129 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testHistoryDaysOpenDayDetails]' passed (129.078 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testLogsRuleAndAllLogs]' passed (36.459 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testLogViewThenEditThenDelete]' passed (46.352 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testMarkADayDoneOnlyOnce]' passed (45.347 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testOlderMultiCheckLogStillCorrects]' passed (36.406 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testPastDayLogKeepsItsDayAndChosenTime]' passed (30.252 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testQuitSlipAddViewEditAndDelete]' passed (36.975 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testSkippedDayKeepsLogsAndNote]' passed (40.803 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTasksReschedule]' failed (77.400 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTickSteps]' passed (18.260 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTimeLogAddViewAndEdit]' passed (37.857 seconds).
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (33.190 seconds).
Test Case '-[HabitsUITests.GroupsUITests testDeletingAGroupKeepsItsHabits]' passed (34.737 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (62.950 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' passed (43.220 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupDragDropsReliably]' passed (131.844 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (60.980 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupOrderIsThePersonsOwn]' passed (36.521 seconds).
Test Case '-[HabitsUITests.GroupsUITests testNamesAreUniqueAndAGroupCanPause]' passed (36.862 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (29.421 seconds).
Test Case '-[HabitsUITests.GroupsUITests testTodayAndProgressKeepTheirOwnChoiceAndStartPlaysWhatsShown]' passed (30.432 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (11.722 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndMilestones]' passed (23.889 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (58.133 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (40.339 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (22.916 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (15.622 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (6.567 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtProgress]' passed (24.110 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (17.921 seconds).
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (26.858 seconds).
Test Case '-[HabitsUITests.TimerUITests testPlayOpensTimerScreenThatClosesWithoutStopping]' passed (29.210 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (26.500 seconds).
Test Case '-[HabitsUITests.TimerUITests testScreenCanBeTurnedOff]' passed (10.785 seconds).
Test Case '-[HabitsUITests.TimerUITests testTimerScreenPauseKeepsTimeAndResumes]' passed (16.933 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (18.460 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (37.127 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (16.689 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (22.749 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (12.208 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
