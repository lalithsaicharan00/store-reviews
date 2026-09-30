# progress-page-research @ aa4e230

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36783494600 · 2026-09-30 22:35 UTC
Commit: Progress: week titles from month names, no interval formatter (still 7% of Progress's time) [ios-ci] [ios-perf]

- Build: success
- UI tests (TodayUITests,TimerUITests,ProgressUITests): success
- Speed tests: success

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 241.401 (241.408) seconds
	 Executed 15 tests, with 0 failures (0 unexpected) in 433.465 (433.483) seconds
	 Executed 15 tests, with 0 failures (0 unexpected) in 433.465 (433.484) seconds
	 Executed 2 tests, with 0 failures (0 unexpected) in 60.485 (60.488) seconds
	 Executed 3 tests, with 0 failures (0 unexpected) in 131.579 (131.581) seconds
Test Case '-[HabitsUITests.ProgressUITests testDaySheetShowsOnToday]' passed (60.013 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (12.659 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndRuns]' passed (16.364 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (23.933 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (38.464 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (25.118 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (16.198 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (5.681 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtOverTime]' passed (24.139 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (18.832 seconds).
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (24.787 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (35.698 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (21.929 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (78.858 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (30.793 seconds).
```

## Speed (simulator on GitHub's Mac, a year of history; compare runs, not absolute numbers)

| Screen | App busy (main thread, minus the test) | SwiftUI redraw | Most time in the app's own code |
|---|---|---|---|
| testScrollToday | 0.4 % | 0.1 % | 0.0%  HabitStore.quitRuns(of:now:)<br>0.0%  HabitStore.quitHistory(of:now:)<br>0.0%  HabitStore.slips(of:now:)<br>0.0%  QuitRow.today.getter |
| testTapToday | 19.2 % | 2.4 % | 0.9%  HabitRow.row(now:)<br>0.6%  HabitStore.isDayMet(_:on:)<br>0.5%  HabitStore.streak(of:asOf:)<br>0.5%  HabitStore.dayProgress(of:on:now:) |
| testMenuOpenClose | 4.2 % | 1.1 % | 0.2%  MenuModel.setOpen(_:reduceMotion:then:)<br>0.2%  partial apply for closure #1 in MenuModel.setOpen(_:reduceMotion:then:)<br>0.2%  closure #1 in MenuModel.setOpen(_:reduceMotion:then:)<br>0.2%  MenuModel.isOpen.setter |
| testScrollAllHabits | 6.6 % | 0.6 % | 0.0%  HabitStore.quitRuns(of:now:)<br>0.0%  HabitStore.quitHistory(of:now:)<br>0.0%  HabitStore.slips(of:now:)<br>0.0%  HabitStore.entries(of:) |
| testScrollHabitPage | 6.2 % | 2.0 % | 0.0%  kotlin::objc_support::RunLoopSource::perform(void*)<br>0.0%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.0%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.0%  kotlin::alloc::FinalizerQueueTraits::processSingle(kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>& |
| testCalendarMonths | 15.5 % | 1.2 % | 2.4%  CalendarSheet.dayButton(_:)<br>2.1%  HabitStore.todayScore(on:)<br>2.0%  HabitStore.dayScore(on:habits:today:)<br>1.9%  HabitStore.outcome(_:on:today:) |
| testProgress | 8.2 % | 1.4 % | 1.7%  ProgressModel.load(_:store:)<br>1.7%  HabitStore.progressSnapshot(_:containing:today:fullAt:)<br>1.6%  HabitStore.progressRow(_:in:range:today:)<br>1.3%  Collection.map<A, B>(_:) |
| testProgressHabitPage | 7.0 % | 2.0 % | 0.1%  OverTimeSection.load(_:)<br>0.1%  HabitStore.overTime(_:range:anchor:today:)<br>0.1%  HabitStore.dayMark(_:on:)<br>0.0%  HabitStore.isDayMet(_:on:) |

Time to open (tap until the screen is there, including the test's own checks):

- Calendar: 3.5 s
- Habit page from Progress: 3.2 s
- Habit page: 2.9 s
- Habits: 2.2 s
- Habits: 2.8 s
- Menu: 2.7 s
- Menu: 3.2 s
- Menu: 3.5 s
- Menu: 4.0 s
- Menu: 4.3 s
- Progress: 2.9 s
- Progress: 3.1 s
