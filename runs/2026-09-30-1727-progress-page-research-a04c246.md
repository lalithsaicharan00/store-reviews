# progress-page-research @ a04c246

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36749429734 · 2026-09-30 17:27 UTC
Commit: Progress page (Build Plan #60): weekly goals done for the day, limits judged at day end, archive dates, and Progress in the ≡ menu [ios-ci]

- Build: success
- UI tests (TodayUITests,TimerUITests,ProgressUITests): failure
- Speed tests: skipped

## UI tests
```
	 Executed 12 tests, with 3 failures (0 unexpected) in 445.306 (445.327) seconds
	 Executed 12 tests, with 3 failures (0 unexpected) in 445.306 (445.329) seconds
	 Executed 2 tests, with 0 failures (0 unexpected) in 57.106 (57.107) seconds
	 Executed 3 tests, with 0 failures (0 unexpected) in 132.982 (132.985) seconds
	 Executed 7 tests, with 3 failures (0 unexpected) in 255.218 (255.232) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ProgressUITests.swift:100: error: -[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod] : Failed to get matching snapshot: Lost connection to the application (pid 25382). (Underlying Error: Couldn’t communicate with a helper application. Try your operation again. If that fails, quit and relaunch the application and try again. The connection to service created from an endpoint was invalidated: Failed to check-in, peer may have been unloaded: mach_error=10000003.)
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ProgressUITests.swift:64: error: -[HabitsUITests.ProgressUITests testProgressChecks] : XCTAssertEqual failed: ("Progress failed (4): G1 marks: got Optional([Habits.HabitStore.DayMark.before, Habits.HabitStore.DayMark.done, Habits.HabitStore.DayMark.done, Habits.HabitStore.DayMark.skipped, Habits.HabitStore.DayMark.done, Habits.HabitStore.DayMark.open, Habits.HabitStore.DayMark.upcoming]), want Optional([Habits.HabitStore.DayMark.done, Habits.HabitStore.DayMark.done, Habits.HabitStore.DayMark.skipped, Habits.HabitStore.DayMark.done, Habits.HabitStore.DayMark.open, Habits.HabitStore.DayMark.upcoming, Habits.HabitStore.DayMark.upcoming]); G11 week from Sunday: got LocalDay(year: 2026, month: 9, day: 20), want LocalDay(year: 2026, month: 9, day: 21); G11 week to Saturday: got LocalDay(year: 2026, month: 9, day: 26), want LocalDay(year: 2026, month: 9, day: 27); G11 range title: Sep 20 – 26") is not equal to ("Progress: all checks passed")
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ProgressUITests.swift:79: error: -[HabitsUITests.ProgressUITests testOpenSwitchAndBack] : Failed to get matching snapshot: Lost connection to the application (pid 24058). (Underlying Error: Couldn’t communicate with a helper application. Try your operation again. If that fails, quit and relaunch the application and try again. The connection to service created from an endpoint was invalidated: Failed to check-in, peer may have been unloaded: mach_error=10000003.)
Test Case '-[HabitsUITests.ProgressUITests testDaySheetShowsOnToday]' passed (39.610 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (45.020 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (35.148 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' failed (43.028 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' failed (50.770 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' failed (11.806 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtOverTime]' passed (29.836 seconds).
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (24.507 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (32.598 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (20.077 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (78.597 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (34.307 seconds).
```
