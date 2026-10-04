# details-page-update @ 91e0e29

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37209334247 · 2026-10-04 15:29 UTC
Commit: Edit Log says "1 glass"; Day details logs say where they came from

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (DayDetailsScreenshotUITests,DayDetailsUITests,TodayRowSheetUITests,TodayRowLayoutUITests,UndoUITests,HabitPageUITests,GoalFlowUITests): cancelled
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 31 tests, with 0 failures (0 unexpected) in 829.844 (829.874) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 104.537 (104.541) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 169.815 (169.818) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 273.703 (273.707) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 284.789 (284.793) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 734.115 (734.120) seconds
	 Executed 67 tests, with 0 failures (0 unexpected) in 2657.009 (2657.072) seconds
	 Executed 67 tests, with 0 failures (0 unexpected) in 2657.009 (2657.088) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 260.207 (260.212) seconds
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test01_dailyCheckUndone]' passed (27.075 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test02_dailyCheckDone]' passed (27.193 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test03_weeklyCheck]' passed (23.004 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test04_repeatedChecks]' passed (89.748 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test05_checklist]' passed (18.640 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test06_monthlyCheck]' passed (22.508 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test07_amountGoal]' passed (22.846 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test08_amountLimit]' passed (17.460 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test09_timeGoal]' passed (14.512 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test10_quitNoSlip]' passed (17.039 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test11_quitWithSlip]' passed (32.125 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test12_limitExceeded]' passed (25.725 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test13_timerRunning]' passed (24.518 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test14_oneTimeTask]' passed (24.130 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test15_pastDay]' passed (23.868 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test16_managementMenuLight]' passed (25.182 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test17_taskWithNote]' passed (27.162 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test18_taskDone]' passed (35.334 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test19_skippedDay]' passed (23.165 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test20_pausedDay]' passed (15.854 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test21_skippedAmountKeepsLogsAndNote]' passed (29.022 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test22_waterAmount]' passed (27.079 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test23_coffeeLimitAmount]' passed (23.997 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test24_readDuration]' passed (21.399 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test25_fractionalTimer]' passed (20.102 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test26_multiCheckLog]' passed (21.773 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test27_quitSlipDateTime]' passed (28.062 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test28_deleteConfirmation]' passed (33.335 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test29_waterLightMode]' passed (26.333 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test30_minutesFocused]' passed (25.387 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test31_slipTimeDraft]' passed (36.266 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEditLogAsksBeforeLosingOrDeleting]' passed (40.723 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindDark]' passed (57.719 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindShowsItsOwnDay]' passed (90.453 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testMultiCheckRecordEditsItsCount]' passed (32.389 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testQuitSlipRecordEditAndDelete]' passed (29.005 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testSkippedDayKeepsLogsAndNote]' passed (34.501 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testButtonAddsItsStepAndRowOpensAddAmount]' passed (60.499 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testHowOftenChoicesSayTheAmount]' passed (42.140 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testNumberShowsWithoutAUnit]' passed (36.783 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testOwnStep]' passed (45.201 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testTypingKeyByKey]' passed (65.365 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testUnitScreen]' passed (23.714 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testHistoryFlows]' passed (49.701 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFlows]' passed (37.535 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDailyTypes]' passed (278.350 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDark]' passed (115.314 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesPeriodLimitQuit]' passed (214.447 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testYearInPixels]' passed (38.769 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testAfterLogButtonsAndNoteSheet]' passed (36.130 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testOneLineUnderEveryName]' passed (16.229 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
