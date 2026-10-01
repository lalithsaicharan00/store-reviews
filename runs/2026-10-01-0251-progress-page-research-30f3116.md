# progress-page-research @ 30f3116

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36805069277 · 2026-10-01 02:51 UTC
Commit: Progress: All and every group's day scores in one pass over the habits

- Build: success
- UI tests (ProgressUITests,GroupsUITests): success
- Speed tests: success

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 250.221 (250.228) seconds
	 Executed 15 tests, with 0 failures (0 unexpected) in 622.320 (622.337) seconds
	 Executed 15 tests, with 0 failures (0 unexpected) in 622.320 (622.339) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 372.099 (372.106) seconds
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (95.383 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (117.573 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' passed (54.656 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (65.620 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (38.868 seconds).
Test Case '-[HabitsUITests.ProgressUITests testDaySheetShowsOnToday]' passed (20.952 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (23.630 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndRuns]' passed (31.595 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (31.171 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (32.911 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (28.033 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (22.948 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (6.732 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtOverTime]' passed (32.733 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (19.514 seconds).
```

## Speed (simulator on GitHub's Mac, a year of history; compare runs, not absolute numbers)

| Screen | App busy (main thread, minus the test) | SwiftUI redraw | Most time in the app's own code |
|---|---|---|---|
| testScrollToday | 6.6 % | 0.7 % | (none above noise) |
| testTapToday | 13.7 % | 1.6 % | 0.5%  partial apply for closure #5 in closure #1 in closure #8 in TodayView.content(now:)<br>0.5%  closure #5 in closure #1 in closure #8 in TodayView.content(now:)<br>0.5%  TodayView.partSection(_:items:day:isToday:isNow:)<br>0.4%  HabitStore.isDone(_:on:) |
| testMenuOpenClose | 6.8 % | 1.6 % | 0.5%  closure #1 in closure #1 in TodayView.topBar.getter<br>0.5%  MenuModel.setOpen(_:reduceMotion:then:)<br>0.5%  partial apply for closure #1 in MenuModel.setOpen(_:reduceMotion:then:)<br>0.5%  closure #1 in MenuModel.setOpen(_:reduceMotion:then:) |
| testScrollAllHabits | 4.8 % | 0.4 % | 0.2%  kotlin::objc_support::RunLoopSource::perform(void*)<br>0.2%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.2%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.2%  kotlin::alloc::FinalizerQueueTraits::processSingle(kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>& |
| testScrollHabitPage | 13.7 % | 4.5 % | 0.0%  kotlin::objc_support::RunLoopSource::perform(void*)<br>0.0%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.0%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.0%  kotlin::alloc::FinalizerQueueTraits::processSingle(kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>& |
| testCalendarMonths | 19.3 % | 2.7 % | 1.8%  CalendarSheet.dayButton(_:)<br>1.6%  HabitStore.todayScore(on:)<br>1.5%  HabitStore.dayScore(on:habits:today:)<br>1.4%  HabitStore.outcome(_:on:today:) |
| testProgress | 59.3 % | 26.6 % | 10.1%  ProgressModel.load(_:store:)<br>10.1%  HabitStore.progressSnapshot(_:containing:today:fullAt:group:)<br>8.1%  Collection.map<A, B>(_:)<br>5.3%  HabitStore.progressRow(_:in:range:today:) |
| testProgressHabitPage | 25.2 % | 2.1 % | 0.3%  kotlin::objc_support::RunLoopSource::perform(void*)<br>0.3%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.3%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.3%  kotlin::alloc::FinalizerQueueTraits::processSingle(kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>& |

Time to open (tap until the screen is there, including the test's own checks):

- Calendar: 3.5 s
- Habit page from Progress: 3.2 s
- Habit page: 5.0 s
- Habits: 2.3 s
- Habits: 2.6 s
- Menu: 3.2 s
- Menu: 3.3 s
- Menu: 3.4 s
- Menu: 4.1 s
- Progress: 3.0 s
- Progress: 6.4 s
