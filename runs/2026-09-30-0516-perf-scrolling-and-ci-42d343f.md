# perf-scrolling-and-ci @ 42d343f

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36670907220 · 2026-09-30 05:16 UTC
Commit: Faster calendar: entries indexed by habit and day; clearer speed tests [ios-ci] [ios-perf]

- Build: success
- UI tests (TodayUITests,TimerUITests): success
- Speed tests: success

## UI tests
```
	 Executed 2 tests, with 0 failures (0 unexpected) in 201.862 (201.867) seconds
	 Executed 2 tests, with 0 failures (0 unexpected) in 83.705 (83.707) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 285.567 (285.577) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 285.567 (285.579) seconds
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (87.066 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (114.796 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (42.929 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (40.776 seconds).
```

## Speed (simulator on GitHub's Mac, a year of history; compare runs, not absolute numbers)

| Screen | App busy (main thread, minus the test) | SwiftUI redraw | Most time in the app's own code |
|---|---|---|---|
| testScrollToday | 6.4 % | 0.9 % | 0.1%  String.capped(_:)<br>0.1%  HabitStore.quitRuns(of:now:)<br>0.1%  HabitStore.entries(of:)<br>0.1%  HabitStore.access<A>(keyPath:) |
| testTapToday | -37.1 % | 0.7 % | 0.1%  partial apply for closure #8 in TodayView.content(now:)<br>0.1%  closure #8 in TodayView.content(now:)<br>0.1%  TodayView.dayBar.getter<br>0.1%  HabitStore.isDone(_:on:) |
| testScrollAllHabits | 1.8 % | 0.6 % | 0.0%  static Format.elapsed(_:) |
| testScrollHabitPage | not measured (test exit 65; see testScrollHabitPage.log) | | |
| testCalendarMonths | 12.7 % | 1.3 % | 1.8%  CalendarSheet.dayButton(_:)<br>1.6%  HabitStore.daySummary(on:)<br>1.1%  partial apply for closure #2 in HabitStore.daySummary(on:)<br>1.1%  closure #2 in HabitStore.daySummary(on:) |

Time to open (tap until the screen is there, including the test's own checks):

- All Habits: 3.6 s
- All Habits: 4.0 s
- Calendar: 3.4 s
