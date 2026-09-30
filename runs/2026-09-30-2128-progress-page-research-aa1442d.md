# progress-page-research @ aa1442d

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36775276207 · 2026-09-30 21:28 UTC
Commit: Progress: keep day scores until the data or the day changes (Year switching was the hot spot) [ios-ci] [ios-perf]

- Build: success
- UI tests (TodayUITests,TimerUITests,ProgressUITests): failure
- Speed tests: success

## UI tests
```
	 Executed 10 tests, with 1 failure (0 unexpected) in 296.091 (296.102) seconds
	 Executed 15 tests, with 1 failure (0 unexpected) in 553.048 (553.078) seconds
	 Executed 15 tests, with 1 failure (0 unexpected) in 553.048 (553.081) seconds
	 Executed 2 tests, with 0 failures (0 unexpected) in 77.020 (77.024) seconds
	 Executed 3 tests, with 0 failures (0 unexpected) in 179.937 (179.944) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ProgressUITests.swift:27: error: -[HabitsUITests.ProgressUITests testDaySheetShowsOnToday] : Failed to get screenshot: Timed out while requesting screenshot.
Test Case '-[HabitsUITests.ProgressUITests testDaySheetShowsOnToday]' failed (82.413 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (25.037 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndRuns]' passed (26.212 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (23.994 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (32.798 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (28.486 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (23.406 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (7.118 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtOverTime]' passed (27.554 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (19.073 seconds).
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (31.290 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (45.730 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (27.846 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (98.341 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (53.750 seconds).
```

## Speed (simulator on GitHub's Mac, a year of history; compare runs, not absolute numbers)

| Screen | App busy (main thread, minus the test) | SwiftUI redraw | Most time in the app's own code |
|---|---|---|---|
| testScrollToday | 1.1 % | 0.3 % | 0.1%  HabitStore.quitRuns(of:now:)<br>0.1%  HabitStore.quitHistory(of:now:)<br>0.1%  HabitStore.slips(of:now:)<br>0.1%  Collection.map<A, B>(_:) |
| testTapToday | 31.2 % | 3.8 % | 1.2%  HabitRow.row(now:)<br>0.9%  HabitStore.isDayMet(_:on:)<br>0.9%  partial apply for closure #3 in closure #1 in closure #8 in TodayView.content(now:)<br>0.9%  closure #3 in closure #1 in closure #8 in TodayView.content(now:) |
| testMenuOpenClose | 2.8 % | 1.2 % | 0.0%  QuitRow.today.getter<br>0.0%  HabitStore.today(now:)<br>0.0%  LocalDay.init(_:calendar:)<br>0.0%  SideMenu.init(menu:) |
| testScrollAllHabits | 7.0 % | 0.6 % | 0.1%  kotlin::objc_support::RunLoopSource::perform(void*)<br>0.1%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.1%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.1%  kotlin::alloc::FinalizerQueueTraits::processSingle(kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>& |
| testScrollHabitPage | 6.1 % | 1.9 % | (none above noise) |
| testCalendarMonths | 11.6 % | 1.3 % | 1.5%  CalendarSheet.dayButton(_:)<br>1.4%  HabitStore.todayScore(on:)<br>1.3%  HabitStore.dayScore(on:habits:today:)<br>1.3%  HabitStore.outcome(_:on:today:) |
| testProgress | 38.3 % | 2.8 % | 10.3%  ProgressModel.load(_:store:)<br>10.2%  HabitStore.progressSnapshot(_:containing:today:fullAt:)<br>4.8%  HabitStore.previousTitle(_:_:today:)<br>4.8%  HabitStore.weekSpan(_:) |
| testProgressHabitPage | 4.3 % | 1.3 % | (none above noise) |

Time to open (tap until the screen is there, including the test's own checks):

- Calendar: 6.9 s
- Habit page from Progress: 3.4 s
- Habit page: 4.0 s
- Habits: 2.7 s
- Menu: 3.2 s
- Menu: 3.4 s
- Menu: 3.5 s
- Menu: 4.0 s
- Menu: 4.1 s
- Progress: 2.8 s
- Progress: 3.5 s
