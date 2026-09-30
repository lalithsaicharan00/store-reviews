# progress-page-research @ 15e5746

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36779795576 · 2026-09-30 22:04 UTC
Commit: Progress: make the week-title formatter once (5% of Progress's time in the speed run) [ios-ci] [ios-perf]

- Build: success
- UI tests (TodayUITests,TimerUITests,ProgressUITests): success
- Speed tests: success

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 212.378 (212.386) seconds
	 Executed 15 tests, with 0 failures (0 unexpected) in 402.408 (402.425) seconds
	 Executed 15 tests, with 0 failures (0 unexpected) in 402.408 (402.426) seconds
	 Executed 2 tests, with 0 failures (0 unexpected) in 58.286 (58.290) seconds
	 Executed 3 tests, with 0 failures (0 unexpected) in 131.744 (131.746) seconds
Test Case '-[HabitsUITests.ProgressUITests testDaySheetShowsOnToday]' passed (44.983 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (13.420 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndRuns]' passed (20.368 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (24.288 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (24.205 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (21.822 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (17.351 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (6.039 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtOverTime]' passed (22.912 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (16.991 seconds).
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (24.559 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (33.727 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (19.693 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (78.108 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (33.943 seconds).
```

## Speed (simulator on GitHub's Mac, a year of history; compare runs, not absolute numbers)

| Screen | App busy (main thread, minus the test) | SwiftUI redraw | Most time in the app's own code |
|---|---|---|---|
| testScrollToday | 0.5 % | 0.1 % | 0.0%  default argument 2 of View.frame(width:height:alignment:) |
| testTapToday | 18.5 % | 2.6 % | 1.0%  HabitRow.row(now:)<br>0.6%  HabitStore.isDayMet(_:on:)<br>0.6%  HabitStore.dayProgress(of:on:now:)<br>0.5%  HabitStore.streak(of:asOf:) |
| testMenuOpenClose | 3.9 % | 1.1 % | 0.1%  closure #1 in closure #1 in TodayView.topBar.getter<br>0.1%  MenuModel.setOpen(_:reduceMotion:then:)<br>0.1%  partial apply for closure #1 in MenuModel.setOpen(_:reduceMotion:then:)<br>0.1%  closure #1 in MenuModel.setOpen(_:reduceMotion:then:) |
| testScrollAllHabits | 7.9 % | 0.7 % | 0.0%  QuitRow.today.getter<br>0.0%  HabitStore.today(now:)<br>0.0%  LocalDay.init(_:calendar:) |
| testScrollHabitPage | 5.0 % | 1.7 % | 0.0%  HabitStore.quitRuns(of:now:)<br>0.0%  HabitStore.quitHistory(of:now:)<br>0.0%  HabitStore.access<A>(keyPath:)<br>0.0%  static Format.elapsed(_:) |
| testCalendarMonths | 18.3 % | 2.2 % | 3.4%  CalendarSheet.dayButton(_:)<br>3.0%  HabitStore.todayScore(on:)<br>2.9%  HabitStore.dayScore(on:habits:today:)<br>2.7%  HabitStore.outcome(_:on:today:) |
| testProgress | 30.0 % | 3.9 % | 9.0%  ProgressModel.load(_:store:)<br>9.0%  HabitStore.progressSnapshot(_:containing:today:fullAt:)<br>7.0%  HabitStore.previousTitle(_:_:today:)<br>7.0%  HabitStore.weekSpan(_:) |
| testProgressHabitPage | 10.9 % | 2.6 % | 0.2%  kotlin::objc_support::RunLoopSource::perform(void*)<br>0.2%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.2%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.2%  kotlin::alloc::FinalizerQueueTraits::processSingle(kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>& |

Time to open (tap until the screen is there, including the test's own checks):

- Calendar: 3.2 s
- Habit page from Progress: 2.2 s
- Habit page: 2.7 s
- Habits: 2.0 s
- Habits: 5.2 s
- Menu: 2.8 s
- Menu: 3.1 s
- Menu: 3.2 s
- Menu: 3.5 s
- Menu: 4.7 s
- Progress: 2.3 s
- Progress: 3.3 s
