# claude/progress-week-cards @ 99a10b0

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37023535465 · 2026-10-02 15:32 UTC
Commit: Progress Month: a card per habit with a month of marks, built like Week

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (ProgressUITests,WeekCardsUITests,GroupsUITests): failure
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 19 tests, with 1 failure (0 unexpected) in 815.452 (815.477) seconds
	 Executed 19 tests, with 1 failure (0 unexpected) in 815.452 (815.482) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 246.429 (246.432) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 342.514 (342.521) seconds
	 Executed 9 tests, with 1 failure (0 unexpected) in 226.510 (226.517) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ProgressUITests.swift:174: error: -[HabitsUITests.ProgressUITests testYearAndMonthTap] : XCTAssertTrue failed - October
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (73.810 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (107.060 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' passed (53.180 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (69.782 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (38.681 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (14.952 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndRuns]' passed (19.641 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (34.159 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (53.561 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (28.306 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (20.115 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (9.879 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtOverTime]' passed (25.812 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' failed (20.083 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCards]' passed (43.399 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCardsDark]' passed (25.971 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsDark]' passed (76.057 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsLight]' passed (77.246 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsWithGroups]' passed (23.756 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Progress: scrolling | 8.5 | 67 ms | 0 | 14.8 % (separate profile) | 0.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Progress: period ‹ › and range | 182.7 | 577 ms | 12 | 14.8 % (separate profile) | 0.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.5%  closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Progress (first): longest stall 648 ms
- Progress (again): longest stall 107 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| progress | Progress year: whole snapshot | 2 | 64 ms | 44.4 ms |
| progress | Progress year: one habit's row | 30 | 35 ms | 1.9 ms |
| progress | Progress week: whole snapshot | 2 | 25 ms | 21.0 ms |
| progress | Progress week: cards | 2 | 23 ms | 19.9 ms |
| progress | Progress year: day scores | 2 | 15 ms | 14.8 ms |
| progress | Progress week: one quit card | 4 | 11 ms | 10.1 ms |
| progress | Progress week: one card | 30 | 10 ms | 7.3 ms |
| progress | Progress year: previous period | 1 | 6 ms | 5.5 ms |
| progress | Progress month: whole snapshot | 2 | 5 ms | 3.5 ms |
| progress | Progress month: cards | 2 | 5 ms | 3.4 ms |
| progress | Progress year: row dots | 2 | 4 ms | 1.9 ms |
| progress | Progress month: one card | 30 | 4 ms | 0.4 ms |
| progress | Progress month: one quit card | 4 | 0 ms | 0.1 ms |
| progress | Progress year: one habit's goals | 1 | 0 ms | 0.3 ms |
| progress | Progress year: one quit row | 2 | 0 ms | 0.1 ms |
| progress | Progress: earliest day | 2 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
