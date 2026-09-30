# progress-page-research @ 72cf684

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36770714647 · 2026-09-30 20:48 UTC
Commit: Progress: fix the build (snapshot's optional fields go last) [ios-ci] [ios-perf]

- Build: success
- UI tests (TodayUITests,TimerUITests,ProgressUITests): success
- Speed tests: success

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 343.377 (343.391) seconds
	 Executed 15 tests, with 0 failures (0 unexpected) in 573.399 (573.424) seconds
	 Executed 15 tests, with 0 failures (0 unexpected) in 573.399 (573.435) seconds
	 Executed 2 tests, with 0 failures (0 unexpected) in 69.891 (69.894) seconds
	 Executed 3 tests, with 0 failures (0 unexpected) in 160.130 (160.135) seconds
Test Case '-[HabitsUITests.ProgressUITests testDaySheetShowsOnToday]' passed (123.519 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (23.145 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndRuns]' passed (20.549 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (30.601 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (30.863 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (28.643 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (22.438 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (10.597 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtOverTime]' passed (28.935 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (24.088 seconds).
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (31.957 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (37.934 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (26.176 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (93.483 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (40.471 seconds).
```

## Speed (simulator on GitHub's Mac, a year of history; compare runs, not absolute numbers)

| Screen | App busy (main thread, minus the test) | SwiftUI redraw | Most time in the app's own code |
|---|---|---|---|
| testScrollToday | 1.5 % | 0.6 % | 0.1%  HabitRow.row(now:)<br>0.1%  kotlin::objc_support::RunLoopSource::perform(void*)<br>0.1%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.1%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a |
| testTapToday | 17.0 % | 2.1 % | 0.4%  HabitRow.row(now:)<br>0.3%  HabitStore.isDayMet(_:on:)<br>0.3%  HabitStore.dayProgress(of:on:now:)<br>0.2%  HabitStore.streak(of:asOf:) |
| testMenuOpenClose | 2.8 % | 1.0 % | 0.0%  closure #1 in closure #1 in TodayView.topBar.getter<br>0.0%  MenuModel.setOpen(_:reduceMotion:then:)<br>0.0%  partial apply for closure #1 in MenuModel.setOpen(_:reduceMotion:then:)<br>0.0%  closure #1 in MenuModel.setOpen(_:reduceMotion:then:) |
| testScrollAllHabits | 8.0 % | 0.7 % | 0.0%  kotlin::objc_support::RunLoopSource::perform(void*)<br>0.0%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.0%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.0%  kotlin::alloc::FinalizerQueueTraits::processSingle(kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>& |
| testScrollHabitPage | 10.0 % | 3.0 % | 0.0%  kotlin::objc_support::RunLoopSource::perform(void*)<br>0.0%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.0%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.0%  kotlin::alloc::FinalizerQueueTraits::processSingle(kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>& |
| testCalendarMonths | 10.8 % | 1.5 % | 1.3%  CalendarSheet.dayButton(_:)<br>1.2%  HabitStore.todayScore(on:)<br>1.2%  HabitStore.dayScore(on:habits:today:)<br>1.2%  HabitStore.outcome(_:on:today:) |
| testProgress | 22.4 % | 6.2 % | 8.5%  ProgressModel.load(_:store:)<br>8.5%  HabitStore.progressSnapshot(_:containing:today:fullAt:)<br>5.0%  Collection.map<A, B>(_:)<br>4.4%  HabitStore.progressRow(_:in:range:today:) |
| testProgressHabitPage | 16.6 % | 3.6 % | 0.8%  OverTimeSection.load(_:)<br>0.8%  HabitStore.overTime(_:range:anchor:today:)<br>0.5%  HabitStore.dayMark(_:on:)<br>0.5%  HabitStore.byWeekday(_:in:today:) |

Time to open (tap until the screen is there, including the test's own checks):

- Calendar: 6.4 s
- Habit page from Progress: 2.9 s
- Habit page: 3.5 s
- Habits: 2.3 s
- Habits: 2.4 s
- Menu: 3.0 s
- Menu: 3.3 s
- Menu: 3.4 s
- Progress: 2.4 s
- Progress: 2.8 s
