# day-details-logs-notes-redesign-ci-b @ d847158

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37609524557 · 2026-10-07 11:30 UTC
Commit: Day details redesign: Core sync test for an edited log time; checklist, Design Rules and branch notes

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (DayDetailsScreenshotUITests,HabitPageUITests,TodayRowSheetUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 21 tests, with 0 failures (0 unexpected) in 894.750 (894.764) seconds
	 Executed 36 tests, with 0 failures (0 unexpected) in 1967.352 (1967.385) seconds
	 Executed 36 tests, with 0 failures (0 unexpected) in 1967.352 (1967.387) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 163.961 (163.965) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 908.640 (908.652) seconds
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test01_amount]' passed (118.181 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test02_noUnitWeek]' passed (39.765 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test03_currencyMonth]' passed (28.727 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test04_limit]' passed (33.987 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test05_time]' passed (34.758 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test06_timerRunningAndEarlierDay]' passed (31.328 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test07_fractionalTimer]' passed (15.622 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test08_onceADay]' passed (25.508 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test09_severalADay]' passed (31.469 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test10_weekGoal]' passed (25.279 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test11_monthGoal]' passed (33.686 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test12_daysAWeek]' passed (37.135 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test12b_olderMultiCheckLog]' passed (34.572 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test13_checklist]' passed (48.507 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test14_quit]' passed (103.516 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test15_task]' passed (40.501 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test16_dayStates]' passed (59.870 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test17_notes]' passed (47.939 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test18_deleteConfirmations]' passed (59.470 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test19_lightMode]' passed (22.634 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test20_managementMenu]' passed (22.296 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testHistoryFlows]' passed (55.064 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFlows]' passed (45.842 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFoldByMonthLikeHistory]' passed (45.739 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNoteViewEditAndDelete]' passed (52.092 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDailyTypes]' passed (271.650 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDark]' passed (117.381 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesPeriodLimitQuit]' passed (217.092 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testSquaresKeyFoldedOnceIsFoldedEverywhere]' passed (64.931 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testYearInPixels]' passed (38.851 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testLongPressMenu]' passed (19.097 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testRowOpensDaySheetForEveryKind]' passed (33.903 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetActionsAndDeleteInTheMenu]' passed (32.141 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetFollowsTheDayShown]' passed (20.454 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSwipeActions]' passed (27.284 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testTickTogglesAndPlusAdds]' passed (31.083 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
