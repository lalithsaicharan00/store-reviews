# claude/server-and-sync @ f668c22

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36955768712 · 2026-10-02 02:58 UTC
Commit: Demo data: Call family's calls never land on today, on any weekday

- Core storage and migrations: success
- Build: success
- UI tests (TodayUITests,ProgressUITests): failure
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 1 failure (0 unexpected) in 406.859 (406.869) seconds
	 Executed 18 tests, with 1 failure (0 unexpected) in 698.277 (698.294) seconds
	 Executed 18 tests, with 1 failure (0 unexpected) in 698.277 (698.296) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 291.418 (291.423) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ProgressUITests.swift:156: error: -[HabitsUITests.ProgressUITests testHidePercentages] : Failed to get matching snapshots: Timed out while evaluating UI query.
Test Case '-[HabitsUITests.ProgressUITests testDaySheetShowsOnToday]' passed (40.840 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (15.726 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndRuns]' passed (26.139 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' failed (132.801 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (76.502 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (28.991 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (23.202 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (9.512 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtOverTime]' passed (33.472 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (19.675 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (22.821 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (44.086 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (22.984 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (28.036 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (13.783 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (108.974 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (13.600 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (37.134 seconds).
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Progress: scrolling | 2.0 | 35 ms | 0 | 10.0 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  closure #9 in static PerfDriver.run(_:store:)<br>0.7%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:) |
| Progress: period ‹ › and range | 240.0 | 236 ms | 24 | 10.0 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  closure #9 in static PerfDriver.run(_:store:)<br>0.7%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Progress (first): longest stall 788 ms
- Progress (again): longest stall 189 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| progress | Progress year: whole snapshot | 2 | 74 ms | 48.1 ms |
| progress | Progress year: one habit's row | 30 | 35 ms | 2.2 ms |
| progress | Progress week: whole snapshot | 2 | 25 ms | 21.2 ms |
| progress | Progress year: day scores | 2 | 14 ms | 13.6 ms |
| progress | Progress year: row dots | 2 | 12 ms | 9.1 ms |
| progress | Progress week: day scores | 2 | 10 ms | 9.5 ms |
| progress | Progress month: whole snapshot | 2 | 9 ms | 4.4 ms |
| progress | Progress year: previous period | 1 | 7 ms | 7.3 ms |
| progress | Progress week: one habit's row | 30 | 4 ms | 2.5 ms |
| progress | Progress month: one habit's row | 30 | 3 ms | 0.3 ms |
| progress | Progress month: previous period | 2 | 2 ms | 1.2 ms |
| progress | Progress week: previous period | 2 | 2 ms | 1.4 ms |
| progress | Progress: earliest day | 6 | 2 ms | 1.2 ms |
| progress | Progress month: day scores | 2 | 1 ms | 1.1 ms |
| progress | Progress year: one quit row | 2 | 0 ms | 0.2 ms |
| progress | Progress week: one quit row | 4 | 0 ms | 0.2 ms |
| progress | Progress year: one habit's goals | 1 | 0 ms | 0.2 ms |
| progress | Progress month: one quit row | 4 | 0 ms | 0.1 ms |
| progress | Progress month: one habit's goals | 2 | 0 ms | 0.1 ms |
| progress | Progress week: one habit's goals | 2 | 0 ms | 0.0 ms |
