# animations-and-settings @ fb1395e

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36799044685 · 2026-10-01 01:34 UTC
Commit: Pause test: lengthen the settle pause on GitHub's slow simulator (debug only)

- Build: success
- UI tests (TodayUITests): success
- Speed tests: success

## UI tests
```
	 Executed 8 tests, with 0 failures (0 unexpected) in 356.509 (356.520) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 356.509 (356.522) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 356.509 (356.524) seconds
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (106.100 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (45.731 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (19.193 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (28.391 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (13.610 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (97.466 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (14.500 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (31.518 seconds).
```

## Speed (simulator on GitHub's Mac, a year of history; compare runs, not absolute numbers)

| Screen | App busy (main thread, minus the test) | SwiftUI redraw | Most time in the app's own code |
|---|---|---|---|
| testScrollToday | 6.7 % | 1.6 % | 0.0%  HabitRow.row(now:)<br>0.0%  closure #2 in HabitRow.row(now:)<br>0.0%  closure #1 in closure #2 in HabitRow.row(now:)<br>0.0%  closure #1 in closure #1 in closure #2 in HabitRow.row(now:) |
| testTapToday | 5.1 % | 1.0 % | 0.1%  HabitStore.isSatisfied(_:on:)<br>0.1%  HabitStore.isComplete(_:on:)<br>0.1%  HabitStore.isDone(_:on:)<br>0.1%  Collection.map<A, B>(_:) |
| testTickRun | 13.8 % | 2.3 % | 0.7%  HabitRow.row(now:)<br>0.5%  Collection.map<A, B>(_:)<br>0.5%  HabitStore.isDayMet(_:on:)<br>0.5%  HabitStore.dayProgress(of:on:now:) |
| testFoldToday | 17.8 % | 0.8 % | 0.2%  HabitRow.row(now:)<br>0.1%  HabitStore.streak(of:asOf:)<br>0.1%  kotlin::objc_support::RunLoopSource::perform(void*)<br>0.1%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a |
| testMenuOpenClose | 6.5 % | 1.3 % | 0.2%  closure #1 in closure #1 in TodayView.topBar.getter<br>0.2%  MenuModel.setOpen(_:reduceMotion:then:)<br>0.2%  partial apply for closure #1 in MenuModel.setOpen(_:reduceMotion:then:)<br>0.2%  closure #1 in MenuModel.setOpen(_:reduceMotion:then:) |
| testScrollAllHabits | 4.9 % | 0.4 % | 0.0%  kotlin::objc_support::RunLoopSource::perform(void*)<br>0.0%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.0%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.0%  kotlin::alloc::FinalizerQueueTraits::processSingle(kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>& |
| testScrollHabitPage | 2.2 % | 0.7 % | (none above noise) |
| testCalendarMonths | 19.5 % | 2.1 % | 1.6%  CalendarSheet.dayButton(_:)<br>1.5%  HabitStore.todayScore(on:)<br>1.4%  HabitStore.dayScore(on:habits:today:)<br>1.3%  HabitStore.outcome(_:on:today:) |
| testProgress | 29.5 % | 6.2 % | 5.7%  ProgressModel.load(_:store:)<br>5.6%  HabitStore.progressSnapshot(_:containing:today:fullAt:group:)<br>4.9%  Collection.map<A, B>(_:)<br>3.6%  score #1 (_:_:_:) in HabitStore.progressSnapshot(_:containing:today:fullAt:group:) |
| testProgressHabitPage | 1.3 % | 0.4 % | 0.0%  OverTimeSection.load(_:)<br>0.0%  HabitStore.overTime(_:range:anchor:today:)<br>0.0%  partial apply for closure #31 in HabitStore.overTime(_:range:anchor:today:)<br>0.0%  closure #31 in HabitStore.overTime(_:range:anchor:today:) |

Time to open (tap until the screen is there, including the test's own checks):

- Calendar: 4.0 s
- Habit page from Progress: 6.0 s
- Habit page: 2.3 s
- Habits: 1.9 s
- Habits: 2.3 s
- Menu: 2.8 s
- Menu: 3.0 s
- Menu: 3.1 s
- Menu: 3.8 s
- Progress: 3.4 s
- Progress: 3.8 s
