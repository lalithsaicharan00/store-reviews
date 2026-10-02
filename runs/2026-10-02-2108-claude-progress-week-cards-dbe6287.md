# claude/progress-week-cards @ dbe6287

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37061661076 · 2026-10-02 21:08 UTC
Commit: Progress: one heat map for Week, Month and Year

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (WeekCardsUITests,ProgressUITests): failure
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 16 tests, with 1 failure (0 unexpected) in 730.272 (730.307) seconds
	 Executed 16 tests, with 1 failure (0 unexpected) in 730.272 (730.309) seconds
	 Executed 7 tests, with 0 failures (0 unexpected) in 359.627 (359.635) seconds
	 Executed 9 tests, with 1 failure (0 unexpected) in 370.644 (370.671) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ProgressUITests.swift:193: error: -[HabitsUITests.ProgressUITests testLogSlipAndUndo] : Application 'com.oftenenough.app' does not have a process ID
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (39.656 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndRuns]' passed (27.454 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (80.335 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' failed (83.135 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (43.224 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (23.911 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (8.685 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtOverTime]' passed (39.629 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (24.616 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCards]' passed (46.131 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCardsDark]' passed (32.782 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsDark]' passed (73.514 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsLight]' passed (72.634 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsWithGroups]' passed (24.097 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCards]' passed (73.488 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCardsDark]' passed (36.981 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Progress: scrolling | 25.5 | 70 ms | 0 | 12.4 % (separate profile) | 0.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.6%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Progress: period ‹ › and range | 229.1 | 289 ms | 19 | 12.4 % (separate profile) | 0.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.6%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Progress Year: scrolling | 4.2 | 52 ms | 0 | 6.1 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.5%  closure #1 in AppModel.ensureLoaded() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Progress (first): longest stall 790 ms
- Progress (again): longest stall 258 ms
- Progress Year (first): longest stall 665 ms
- Progress Year (again): longest stall 176 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| progress | Progress year: whole snapshot | 2 | 55 ms | 32.3 ms |
| progress | Progress year: cards | 2 | 54 ms | 32.2 ms |
| progress | Progress year: one card | 30 | 51 ms | 3.4 ms |
| progress | Progress week: whole snapshot | 2 | 30 ms | 27.0 ms |
| progress | Progress week: cards | 2 | 28 ms | 25.3 ms |
| progress | Progress week: one card | 30 | 21 ms | 17.1 ms |
| progress | Progress month: whole snapshot | 2 | 6 ms | 4.3 ms |
| progress | Progress month: cards | 2 | 6 ms | 4.0 ms |
| progress | Progress month: one card | 30 | 5 ms | 0.3 ms |
| progress | Progress week: one quit card | 4 | 2 ms | 1.5 ms |
| progress | Progress year: one quit card | 2 | 1 ms | 0.3 ms |
| progress | Progress month: one quit card | 4 | 0 ms | 0.1 ms |
| progress-year | Progress year: whole snapshot | 1 | 43 ms | 42.5 ms |
| progress-year | Progress year: cards | 1 | 42 ms | 42.2 ms |
| progress-year | Progress year: one card | 15 | 38 ms | 8.7 ms |
| progress-year | Progress week: whole snapshot | 1 | 2 ms | 2.5 ms |
| progress-year | Progress week: cards | 1 | 2 ms | 2.2 ms |
| progress-year | Progress week: one card | 15 | 1 ms | 0.2 ms |
| progress-year | Progress year: one quit card | 2 | 1 ms | 1.0 ms |
| progress-year | Progress week: one quit card | 2 | 0 ms | 0.2 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
