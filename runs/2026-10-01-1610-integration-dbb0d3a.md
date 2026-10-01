# integration @ dbb0d3a

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36887194713 · 2026-10-01 16:10 UTC
Commit: Every chart drawn in one Canvas pass: running total, 30-day rate and the quit runs chart too

- Core storage and migrations: success
- Build: success
- UI tests (ProgressUITests): success
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 267.028 (267.037) seconds
	 Executed 10 tests, with 0 failures (0 unexpected) in 267.028 (267.039) seconds
	 Executed 10 tests, with 0 failures (0 unexpected) in 267.028 (267.040) seconds
Test Case '-[HabitsUITests.ProgressUITests testDaySheetShowsOnToday]' passed (44.455 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (23.905 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndRuns]' passed (25.779 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (30.776 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (31.229 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (25.471 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (22.755 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (8.640 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtOverTime]' passed (30.298 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (23.719 seconds).
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Habit page: scrolling | 15.1 | 210 ms | 1 | 0.9 % (separate profile) | 0.1%  specialized static PerfDriver.scroll()<br>0.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page (weekly total): scrolling | 8.5 | 45 ms | 0 | 7.1 % (separate profile) | 0.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.8%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page (quit): scrolling | 1.1 | 31 ms | 0 | 8.7 % (separate profile) | 0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.7%  closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- All Habits: longest stall 787 ms
- Habit page: longest stall 1361 ms
- All Habits: longest stall 702 ms
- Habit page (weekly total): longest stall 0 ms
- All Habits: longest stall 832 ms
- Habit page (quit): longest stall 1075 ms
