# progress-page-research @ 54ad3f4

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36792328616 · 2026-10-01 00:18 UTC
Commit: Groups: make, edit and filter by group; group stats on Progress [ios-ci] [ios-perf]

- Build: success
- UI tests (TodayUITests,TimerUITests,ProgressUITests,GroupsUITests): failure
- Speed tests: success

## UI tests
```
	 Executed 10 tests, with 1 failure (0 unexpected) in 212.383 (212.392) seconds
	 Executed 2 tests, with 0 failures (0 unexpected) in 70.370 (70.373) seconds
	 Executed 20 tests, with 3 failures (0 unexpected) in 688.591 (688.613) seconds
	 Executed 20 tests, with 3 failures (0 unexpected) in 688.591 (688.615) seconds
	 Executed 3 tests, with 0 failures (0 unexpected) in 157.104 (157.106) seconds
	 Executed 5 tests, with 2 failures (0 unexpected) in 248.733 (248.738) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/GroupsUITests.swift:102: error: -[HabitsUITests.GroupsUITests testFirstGroupFromFilter] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ProgressUITests.swift:88: error: -[HabitsUITests.ProgressUITests testOpenSwitchAndBack] : XCTAssertEqual failed: ("30 Aug – 5 Sep") is not equal to ("This week")
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ScrollHelpers.swift:49: error: -[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay] : Failed to tap "group-habit-Bed by 23:00" Button: No matches found for Elements matching predicate '"group-habit-Bed by 23:00" IN identifiers' from input {(
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (50.007 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' failed (69.102 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' failed (34.488 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (62.623 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (32.513 seconds).
Test Case '-[HabitsUITests.ProgressUITests testDaySheetShowsOnToday]' passed (17.647 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (12.566 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndRuns]' passed (17.722 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (24.388 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (26.912 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' failed (28.424 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (29.762 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (7.571 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtOverTime]' passed (29.727 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (17.665 seconds).
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (25.540 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (44.831 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (37.913 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (84.079 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (35.112 seconds).
```

## Speed (simulator on GitHub's Mac, a year of history; compare runs, not absolute numbers)

| Screen | App busy (main thread, minus the test) | SwiftUI redraw | Most time in the app's own code |
|---|---|---|---|
| testScrollToday | 2.9 % | 0.3 % | 0.1%  kotlin::objc_support::RunLoopSource::perform(void*)<br>0.1%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.1%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.1%  kotlin::alloc::FinalizerQueueTraits::processSingle(kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>& |
| testTapToday | 8.1 % | 0.6 % | 0.5%  partial apply for closure #5 in closure #1 in closure #8 in TodayView.content(now:)<br>0.5%  closure #5 in closure #1 in closure #8 in TodayView.content(now:)<br>0.5%  TodayView.partSection(_:items:day:isToday:isNow:)<br>0.4%  HabitStore.isSatisfied(_:on:) |
| testMenuOpenClose | 2.2 % | 0.5 % | 0.1%  closure #1 in closure #1 in TodayView.topBar.getter<br>0.1%  MenuModel.setOpen(_:reduceMotion:then:)<br>0.1%  partial apply for closure #1 in MenuModel.setOpen(_:reduceMotion:then:)<br>0.1%  closure #1 in MenuModel.setOpen(_:reduceMotion:then:) |
| testScrollAllHabits | 4.8 % | 0.4 % | 0.0%  kotlin::objc_support::RunLoopSource::perform(void*)<br>0.0%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.0%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.0%  kotlin::alloc::FinalizerQueueTraits::processSingle(kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>& |
| testScrollHabitPage | 2.1 % | 0.6 % | 0.0%  HabitStore.quitRuns(of:now:)<br>0.0%  HabitStore.quitHistory(of:now:)<br>0.0%  HabitStore.slips(of:now:)<br>0.0%  Collection.map<A, B>(_:) |
| testCalendarMonths | 8.3 % | 1.5 % | 0.8%  CalendarSheet.dayButton(_:)<br>0.7%  HabitStore.todayScore(on:)<br>0.7%  HabitStore.dayScore(on:habits:today:)<br>0.7%  HabitStore.outcome(_:on:today:) |
| testProgress | 15.6 % | 1.8 % | 0.5%  ProgressModel.load(_:store:)<br>0.5%  HabitStore.progressSnapshot(_:containing:today:fullAt:group:)<br>0.4%  Collection.map<A, B>(_:)<br>0.3%  HabitStore.isDayMet(_:on:) |
| testProgressHabitPage | 10.3 % | 2.3 % | 0.0%  OverTimeSection.load(_:)<br>0.0%  HabitStore.overTime(_:range:anchor:today:)<br>0.0%  partial apply for closure #31 in HabitStore.overTime(_:range:anchor:today:)<br>0.0%  closure #31 in HabitStore.overTime(_:range:anchor:today:) |

Time to open (tap until the screen is there, including the test's own checks):

- Calendar: 3.3 s
- Habit page from Progress: 2.9 s
- Habit page: 2.8 s
- Habits: 2.4 s
- Habits: 2.6 s
- Menu: 3.0 s
- Menu: 3.1 s
- Menu: 3.6 s
- Progress: 3.3 s
- Progress: 3.9 s
