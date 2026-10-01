# animations-and-settings @ d9bb44f

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36801814679 · 2026-10-01 02:11 UTC
Commit: Merge progress-page-research: the pinned group filter bar and Groups test fixes [ios-ci] [ios-perf]

- Build: success
- UI tests (TodayUITests,TimerUITests,ProgressUITests,GroupsUITests): success
- Speed tests: success

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 199.935 (199.944) seconds
	 Executed 2 tests, with 0 failures (0 unexpected) in 61.477 (61.481) seconds
	 Executed 25 tests, with 0 failures (0 unexpected) in 850.957 (850.997) seconds
	 Executed 25 tests, with 0 failures (0 unexpected) in 850.957 (850.999) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 318.442 (318.457) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 271.104 (271.110) seconds
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (45.033 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (87.738 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' passed (54.203 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (93.193 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (38.275 seconds).
Test Case '-[HabitsUITests.ProgressUITests testDaySheetShowsOnToday]' passed (22.485 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (13.298 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndRuns]' passed (18.462 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (26.687 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (28.558 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (22.715 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (18.750 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (6.340 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtOverTime]' passed (25.459 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (17.181 seconds).
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (27.788 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (33.690 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (20.897 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (41.519 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (22.761 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (27.018 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (12.950 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (98.059 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (15.706 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (32.192 seconds).
```

## Speed (simulator on GitHub's Mac, a year of history; compare runs, not absolute numbers)

| Screen | App busy (main thread, minus the test) | SwiftUI redraw | Most time in the app's own code |
|---|---|---|---|
| testScrollToday | 8.6 % | 1.3 % | 0.1%  kotlin::objc_support::RunLoopSource::perform(void*)<br>0.1%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.1%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.1%  kotlin::alloc::FinalizerQueueTraits::processSingle(kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>& |
| testTapToday | 11.5 % | 1.5 % | 0.4%  HabitStore.isDayMet(_:on:)<br>0.3%  HabitStore.dayProgress(of:on:now:)<br>0.3%  HabitRow.row(now:)<br>0.3%  Collection.map<A, B>(_:) |
| testTickRun | 8.2 % | 1.5 % | 0.5%  HabitRow.row(now:)<br>0.3%  Collection.map<A, B>(_:)<br>0.3%  HabitStore.isDone(_:on:)<br>0.3%  HabitStore.dayProgress(of:on:now:) |
| testFoldToday | 17.5 % | 0.9 % | 0.1%  HabitRow.row(now:)<br>0.0%  closure #2 in HabitRow.row(now:)<br>0.0%  HabitStore.streak(of:asOf:)<br>0.0%  HabitStore.isDone(_:on:) |
| testMenuOpenClose | 3.0 % | 0.7 % | 0.2%  closure #1 in closure #1 in TodayView.topBar.getter<br>0.2%  MenuModel.setOpen(_:reduceMotion:then:)<br>0.2%  partial apply for closure #1 in MenuModel.setOpen(_:reduceMotion:then:)<br>0.2%  closure #1 in MenuModel.setOpen(_:reduceMotion:then:) |
| testScrollAllHabits | 5.3 % | 0.6 % | 0.0%  kotlin::objc_support::RunLoopSource::perform(void*)<br>0.0%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.0%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.0%  kotlin::alloc::FinalizerQueueTraits::processSingle(kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>& |
| testScrollHabitPage | 8.4 % | 2.5 % | 0.0%  static Format.elapsed(_:)<br>0.0%  HabitStore.quitRuns(of:now:) |
| testCalendarMonths | 16.9 % | 2.1 % | 2.2%  CalendarSheet.dayButton(_:)<br>2.0%  HabitStore.todayScore(on:)<br>1.8%  HabitStore.dayScore(on:habits:today:)<br>1.7%  HabitStore.outcome(_:on:today:) |
| testProgress | 25.5 % | 5.3 % | 6.9%  ProgressModel.load(_:store:)<br>6.9%  HabitStore.progressSnapshot(_:containing:today:fullAt:group:)<br>5.8%  Collection.map<A, B>(_:)<br>3.7%  HabitStore.isDayMet(_:on:) |
| testProgressHabitPage | 3.8 % | 1.6 % | 0.5%  OverTimeSection.load(_:)<br>0.5%  HabitStore.overTime(_:range:anchor:today:)<br>0.2%  partial apply for closure #31 in HabitStore.overTime(_:range:anchor:today:)<br>0.2%  closure #31 in HabitStore.overTime(_:range:anchor:today:) |

Time to open (tap until the screen is there, including the test's own checks):

- Calendar: 3.5 s
- Habit page from Progress: 2.8 s
- Habit page: 2.2 s
- Habits: 1.9 s
- Habits: 2.0 s
- Menu: 2.9 s
- Menu: 3.1 s
- Menu: 3.5 s
- Menu: 3.7 s
- Progress: 2.6 s
- Progress: 2.8 s
