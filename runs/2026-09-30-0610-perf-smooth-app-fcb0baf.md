# perf-smooth-app @ fcb0baf

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36674587867 · 2026-09-30 06:10 UTC
Commit: Smooth app: optimised phone build, remembered streaks, instant taps, stall meter [ios-ci] [ios-perf]

- Build: success
- UI tests (TodayUITests,TimerUITests): success
- Speed tests: success

## UI tests
```
	 Executed 2 tests, with 0 failures (0 unexpected) in 157.870 (157.874) seconds
	 Executed 2 tests, with 0 failures (0 unexpected) in 62.324 (62.325) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 220.194 (220.202) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 220.194 (220.205) seconds
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (99.242 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (58.628 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (25.971 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (36.353 seconds).
```

## Speed (simulator on GitHub's Mac, a year of history; compare runs, not absolute numbers)

| Screen | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | SwiftUI redraw | Most time in the app's own code |
|---|---|---|---|---|---|
| testScrollToday | 227.7 | 1368 ms | 13 |  % | (none above noise) |
| testTapToday | 543.9 | 2464 ms | 27 | 4.8 % | 99.8%  main<br>0.4%  HabitRow.row(now:)<br>0.2%  closure #1 in closure #1 in closure #2 in HabitRow.row(now:)<br>0.2%  specialized static Format.trimmed(_:places:) |
| testScrollAllHabits | 281.0 | 2690 ms | 12 | 0.6 % | 100.0%  main<br>0.1%  partial apply for specialized closure #1 in TimelineView<>.init(_:content:)<br>0.1%  specialized closure #1 in TimelineView<>.init(_:content:)<br>0.1%  thunk for @escaping @callee_guaranteed (@guaranteed CFRunLoopObserverRef?, @unowned CFRunLoopActivity) -> () |
| testScrollHabitPage | 155.3 | 292 ms | 14 | 2.3 % | 100.0%  main<br>0.2%  thunk for @escaping @callee_guaranteed (@guaranteed CFRunLoopObserverRef?, @unowned CFRunLoopActivity) -> ()<br>0.1%  partial apply for closure #1 in MainThreadMeter.().init()<br>0.0%  kotlin::objc_support::RunLoopSource::perform(void*) |
| testCalendarMonths | 610.1 | 666 ms | 63 | 0.6 % | 100.0%  main<br>0.1%  thunk for @escaping @callee_guaranteed (@guaranteed UITraitCollection) -> (@owned UIColor)<br>0.1%  closure #1 in variable initialization expression of static Color.ink<br>0.1%  CalendarSheet.dayButton(_:) |
| testNewHabitForm | 818.1 | 4169 ms | 26 | 6.3 % | 100.0%  main<br>0.0%  HabitForm.timeOfDayRow.getter<br>0.0%  closure #1 in HabitForm.timeOfDayRow.getter<br>0.0%  objectdestroyTm |
| testRoutinePlayer | 487.2 | 1900 ms | 22 | 0.9 % | 99.9%  main<br>0.9%  closure #1 in closure #1 in RoutinePlayer.navigationControls.getter<br>0.9%  RoutinePlayer.navigate(to:reviewing:)<br>0.9%  RoutinePlayer.startCurrentTimer() |

Opening a screen (longest stall between the tap and the screen being there; under 100 ms feels instant):

- All Habits: longest stall 1159 ms
- All Habits: longest stall 964 ms
- Habit page: longest stall 1242 ms
- Calendar: longest stall 868 ms
- New Habit: longest stall 693 ms
- Habit form: longest stall 2127 ms
- Routine player: longest stall 1040 ms
