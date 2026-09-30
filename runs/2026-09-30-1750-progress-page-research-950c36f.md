# progress-page-research @ 950c36f

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36751962658 · 2026-09-30 17:50 UTC
Commit: Progress: fix the Month crash (Canvas strip → native shapes), golden cases on the real Friday, crash reports in CI [ios-ci]

- Build: success
- UI tests (TodayUITests,TimerUITests,ProgressUITests): failure
- Speed tests: skipped

## UI tests
```
	 Executed 12 tests, with 3 failures (0 unexpected) in 431.631 (431.653) seconds
	 Executed 12 tests, with 3 failures (0 unexpected) in 431.631 (431.656) seconds
	 Executed 2 tests, with 0 failures (0 unexpected) in 61.734 (61.735) seconds
	 Executed 3 tests, with 0 failures (0 unexpected) in 158.349 (158.354) seconds
	 Executed 7 tests, with 3 failures (0 unexpected) in 211.548 (211.561) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ProgressUITests.swift:100: error: -[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod] : Failed to get matching snapshot: Lost connection to the application (pid 22608). (Underlying Error: Couldn’t communicate with a helper application. Try your operation again. If that fails, quit and relaunch the application and try again. The connection to service created from an endpoint was invalidated: Failed to check-in, peer may have been unloaded: mach_error=10000003.)
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ProgressUITests.swift:64: error: -[HabitsUITests.ProgressUITests testProgressChecks] : XCTAssertEqual failed: ("Progress failed (9): G1 row: got Optional("2 of 4 days so far"), want Optional("3 of 3 days so far"); G1 percent: got Optional(50), want Optional(100); G1 marks: got Optional([Habits.HabitStore.DayMark.missed, Habits.HabitStore.DayMark.done, Habits.HabitStore.DayMark.skipped, Habits.HabitStore.DayMark.missed, Habits.HabitStore.DayMark.done, Habits.HabitStore.DayMark.upcoming, Habits.HabitStore.DayMark.upcoming]), want Optional([Habits.HabitStore.DayMark.done, Habits.HabitStore.DayMark.done, Habits.HabitStore.DayMark.skipped, Habits.HabitStore.DayMark.done, Habits.HabitStore.DayMark.open, Habits.HabitStore.DayMark.upcoming, Habits.HabitStore.DayMark.upcoming]); G1 streak: got 1, want 3; G1 best: got 1, want 3; G1 Monday: got DayScore(done: 0, part: 0.0, partCount: 0, planned: 1), want DayScore(done: 1, part: 0.0, partCount: 0, planned: 1); G1 today open: got done, want open; G1 tally done: got 2, want 3; G1 tally planned: got 4, want 3") is not equal to ("Progress: all checks passed")
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ProgressUITests.swift:79: error: -[HabitsUITests.ProgressUITests testOpenSwitchAndBack] : Failed to get matching snapshot: Lost connection to the application (pid 20455). (Underlying Error: Couldn’t communicate with a helper application. Try your operation again. If that fails, quit and relaunch the application and try again. The connection to service created from an endpoint was invalidated: Failed to check-in, peer may have been unloaded: mach_error=10000003.)
Test Case '-[HabitsUITests.ProgressUITests testDaySheetShowsOnToday]' passed (42.036 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (13.236 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (27.066 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' failed (41.714 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' failed (44.656 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' failed (8.757 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtOverTime]' passed (34.083 seconds).
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (26.563 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (35.171 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (24.157 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (93.985 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (40.207 seconds).
```

## App crashes
```
### Habits-2026-09-30-174550.ips
EXC_BREAKPOINT SIGTRAP
Trace/BPT trap: 5
  libswiftCore.dylib: _assertionFailure(_:_:file:line:flags:)
  UIKitCore: ?
  UIKitCore: ?
  UIKitCore: -[UICollectionView _setNeedsVisibleCellsUpdate:withLayoutAttributes:]
  UIKitCore: -[UICollectionView _invalidateLayoutWithContext:]
  UIKitCore: -[UICollectionViewLayout invalidateLayoutWithContext:]
  UIKitCore: -[UICollectionViewCompositionalLayout invalidateLayoutWithContext:]
  UIKitCore: -[UICollectionViewCompositionalLayout _didPerformUpdateVisibleCellsPassWithLayoutOffset:]
  UIKitCore: -[UICollectionView _updateVisibleCellsNow:]
  UIKitCore: -[UICollectionView _updateVisibleCellsNow:]
  UIKitCore: -[UICollectionView _updateVisibleCellsNow:]
  UIKitCore: -[UICollectionView _updateVisibleCellsNow:]
  UIKitCore: -[UICollectionView _updateVisibleCellsNow:]
  UIKitCore: -[UICollectionView _updateVisibleCellsNow:]
  UIKitCore: -[UICollectionView _updateVisibleCellsNow:]
  UIKitCore: -[UICollectionView layoutSubviews]
  SwiftUI: UpdateCoalescingCollectionView.layoutSubviews()
  SwiftUI: @objc UpdateCoalescingCollectionView.layoutSubviews()
```
