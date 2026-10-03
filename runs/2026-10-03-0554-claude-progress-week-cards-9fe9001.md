# claude/progress-week-cards @ 9fe9001

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37099653104 · 2026-10-03 05:54 UTC
Commit: Heat map: one ✓ everywhere, grey for every due day, a three-row key

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (WeekCardsUITests,ProgressUITests): success
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 18 tests, with 0 failures (0 unexpected) in 780.267 (780.310) seconds
	 Executed 18 tests, with 0 failures (0 unexpected) in 780.267 (780.312) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 336.341 (336.370) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 443.925 (443.937) seconds
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (35.941 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndRuns]' passed (40.076 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (74.998 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (74.628 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (31.711 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (20.489 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (8.601 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtOverTime]' passed (27.977 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (21.920 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testHabitPageDark]' passed (49.118 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCards]' passed (42.573 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCardsDark]' passed (24.287 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsDark]' passed (68.269 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsLight]' passed (69.923 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsWithGroups]' passed (21.245 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCards]' passed (73.361 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCardsDark]' passed (36.124 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearScrollAndHabitPage]' passed (59.026 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Progress Year: scrolling | 20.2 | 87 ms | 0 | 7.6 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.7%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page: scrolling | 9.4 | 76 ms | 0 | 3.6 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.8%  closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Progress Year (first): longest stall 935 ms
- Progress Year (again): longest stall 113 ms
- All Habits: longest stall 327 ms
- Habit page: longest stall 316 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| progress-year | Progress year: whole snapshot | 1 | 49 ms | 49.0 ms |
| progress-year | Progress year: cards | 1 | 49 ms | 48.8 ms |
| progress-year | Progress year: one card | 15 | 38 ms | 12.9 ms |
| progress-year | Progress year: one quit card | 2 | 7 ms | 7.0 ms |
| progress-year | Progress week: whole snapshot | 1 | 3 ms | 3.1 ms |
| progress-year | Progress week: cards | 1 | 3 ms | 2.9 ms |
| progress-year | Progress week: one card | 15 | 2 ms | 0.3 ms |
| progress-year | Progress week: one quit card | 2 | 0 ms | 0.3 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
