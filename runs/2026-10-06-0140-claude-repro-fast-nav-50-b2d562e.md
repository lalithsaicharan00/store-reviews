# claude/repro-fast-nav-50 @ b2d562e

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37395449320 · 2026-10-06 01:40 UTC
Commit: FocusPlayerUITests: the slow-write navigation test injects 4 s writes and allows 3 s (a wait still fails); › is now a Liquid Glass bar button whose press animation XCUITest waits out (~0.9 s, run 37387468173)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (DayDetailsScreenshotUITests,DayDetailsUITests,WeekCardsUITests,NewFlowUITests,TodayRowLayoutUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 485.903 (485.914) seconds
	 Executed 31 tests, with 0 failures (0 unexpected) in 870.929 (871.026) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 142.922 (142.926) seconds
	 Executed 54 tests, with 0 failures (0 unexpected) in 2273.819 (2273.957) seconds
	 Executed 54 tests, with 0 failures (0 unexpected) in 2273.819 (2273.959) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 651.391 (651.403) seconds
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test01_dailyCheckUndone]' passed (98.990 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test02_dailyCheckDone]' passed (31.156 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test03_weeklyCheck]' passed (23.077 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test04_repeatedChecks]' passed (19.688 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test05_checklist]' passed (19.135 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test06_monthlyCheck]' passed (20.157 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test07_amountGoal]' passed (14.938 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test08_amountLimit]' passed (16.503 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test09_timeGoal]' passed (23.111 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test10_quitNoSlip]' passed (18.751 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test11_quitWithSlip]' passed (25.230 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test12_limitExceeded]' passed (27.171 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test13_timerRunning]' passed (41.890 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test14_oneTimeTask]' passed (25.133 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test15_pastDay]' passed (23.040 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test16_managementMenuLight]' passed (38.793 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test17_taskWithNote]' passed (31.638 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test18_taskDone]' passed (25.795 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test19_skippedDay]' passed (26.501 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test20_pausedDay]' passed (21.324 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test21_skippedAmountKeepsLogsAndNote]' passed (30.184 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test22_waterAmount]' passed (20.424 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test23_coffeeLimitAmount]' passed (28.849 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test24_readDuration]' passed (24.207 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test25_fractionalTimer]' passed (23.459 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test26_multiCheckLog]' passed (20.099 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test27_quitSlipDateTime]' passed (32.700 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test28_deleteConfirmation]' passed (34.532 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test29_waterLightMode]' passed (22.327 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test30_minutesFocused]' passed (25.013 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test31_slipTimeDraft]' passed (37.114 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEditLogAsksBeforeLosingOrDeleting]' passed (50.306 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindDark]' passed (103.943 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindShowsItsOwnDay]' passed (141.788 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testHistoryDaysOpenDayDetails]' passed (152.439 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testMultiCheckRecordEditsItsCount]' passed (31.861 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testQuitSlipRecordEditAndDelete]' passed (39.018 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testSkippedDayKeepsLogsAndNote]' passed (49.083 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTasksReschedule]' passed (82.953 seconds).
Test Case '-[HabitsUITests.NewFlowUITests testFlow]' passed (122.675 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testAfterLogButtonsAndNoteSheet]' passed (58.361 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testOneLineUnderEveryName]' passed (21.356 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testQuitRowSwipeLogsASlip]' passed (23.138 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testTaskRowOpensItsSheet]' passed (40.067 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testHabitPageDark]' passed (50.079 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCards]' passed (46.417 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCardsDark]' passed (25.090 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testSquaresKeyOpensOnlyOnEachRangesFirstVisit]' passed (36.977 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsDark]' passed (65.450 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsLight]' passed (75.665 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsWithGroups]' passed (21.778 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCards]' passed (68.985 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCardsDark]' passed (34.195 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearScrollAndHabitPage]' passed (61.267 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
