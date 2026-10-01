# progress-page-research @ 97980f8

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36800846605 · 2026-10-01 01:50 UTC
Commit: Today: the group filter chip sits in a bar pinned above the list, so ✕ is the chip itself

- Build: success
- UI tests (GroupsUITests,TodayUITests): success
- Speed tests: success

## UI tests
```
	 Executed 3 tests, with 0 failures (0 unexpected) in 140.033 (140.037) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 247.469 (247.476) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 387.503 (387.516) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 387.503 (387.518) seconds
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (40.716 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (67.015 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' passed (43.982 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (60.258 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (35.498 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (29.580 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (79.123 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (31.331 seconds).
```

## Speed (simulator on GitHub's Mac, a year of history; compare runs, not absolute numbers)

| Screen | App busy (main thread, minus the test) | SwiftUI redraw | Most time in the app's own code |
|---|---|---|---|
| testScrollToday | 5.2 % | 0.8 % | 0.1%  HabitRow.row(now:)<br>0.0%  HabitStore.streak(of:asOf:)<br>0.0%  closure #2 in HabitRow.row(now:)<br>0.0%  HabitStore.note(of:on:) |
| testTapToday | 31.9 % | 2.2 % | 0.4%  HabitRow.row(now:)<br>0.3%  HabitStore.dayProgress(of:on:now:)<br>0.2%  HabitStore.isDayMet(_:on:)<br>0.2%  partial apply for closure #5 in closure #1 in closure #8 in TodayView.content(now:) |
| testMenuOpenClose | 4.7 % | 1.1 % | 0.3%  MenuModel.setOpen(_:reduceMotion:then:)<br>0.3%  closure #1 in closure #1 in TodayView.topBar.getter<br>0.3%  MenuModel.withMutation<A, B>(keyPath:_:)<br>0.2%  partial apply for closure #1 in MenuModel.setOpen(_:reduceMotion:then:) |
| testScrollAllHabits | 6.3 % | 0.4 % | 0.0%  kotlin::objc_support::RunLoopSource::perform(void*)<br>0.0%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.0%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.0%  kotlin::alloc::FinalizerQueueTraits::processSingle(kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>& |
| testScrollHabitPage | 8.8 % | 2.5 % | 0.0%  HabitStore.quitRuns(of:now:)<br>0.0%  HabitStore.quitHistory(of:now:)<br>0.0%  HabitStore.slips(of:now:)<br>0.0%  HabitStore.entries(of:) |
| testCalendarMonths | 24.4 % | 3.1 % | 3.1%  CalendarSheet.dayButton(_:)<br>2.7%  HabitStore.todayScore(on:)<br>2.6%  HabitStore.dayScore(on:habits:today:)<br>2.5%  HabitStore.outcome(_:on:today:) |
| testProgress | 56.1 % | 34.7 % | 3.8%  ProgressModel.load(_:store:)<br>3.7%  HabitStore.progressSnapshot(_:containing:today:fullAt:group:)<br>3.2%  Collection.map<A, B>(_:)<br>2.1%  HabitStore.isDayMet(_:on:) |
| testProgressHabitPage | 8.4 % | 3.1 % | 0.4%  OverTimeSection.load(_:)<br>0.4%  HabitStore.overTime(_:range:anchor:today:)<br>0.2%  HabitStore.dayMark(_:on:)<br>0.2%  HabitStore.dayProgress(of:on:now:) |

Time to open (tap until the screen is there, including the test's own checks):

- Calendar: 3.2 s
- Habit page from Progress: 3.1 s
- Habit page: 2.1 s
- Habits: 1.7 s
- Habits: 1.8 s
- Menu: 2.7 s
- Menu: 3.0 s
- Menu: 3.1 s
- Progress: 2.2 s
- Progress: 2.3 s
