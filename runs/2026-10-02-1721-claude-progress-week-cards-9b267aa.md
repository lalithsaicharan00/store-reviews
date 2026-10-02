# claude/progress-week-cards @ 9b267aa

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37035760133 · 2026-10-02 17:21 UTC
Commit: Progress Year: a GitHub-style heat map per habit

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (WeekCardsUITests,ProgressUITests,GroupsUITests): success
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 21 tests, with 0 failures (0 unexpected) in 1037.680 (1037.713) seconds
	 Executed 21 tests, with 0 failures (0 unexpected) in 1037.680 (1037.718) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 355.774 (355.783) seconds
	 Executed 7 tests, with 0 failures (0 unexpected) in 391.571 (391.584) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 290.335 (290.343) seconds
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (48.137 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (123.117 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' passed (61.237 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (78.985 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (44.298 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (14.146 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndRuns]' passed (21.859 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (79.659 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (59.145 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (28.751 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (21.920 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (11.010 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtOverTime]' passed (31.276 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (22.569 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCards]' passed (42.328 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCardsDark]' passed (28.391 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsDark]' passed (82.845 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsLight]' passed (86.014 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsWithGroups]' passed (26.841 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCards]' passed (83.286 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCardsDark]' passed (41.867 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Progress: scrolling | 21.1 | 70 ms | 0 | 12.2 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.4%  closure #1 in AppModel.ensureLoaded() |
| Progress: period ‹ › and range | 196.3 | 258 ms | 12 | 12.2 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.4%  closure #1 in AppModel.ensureLoaded() |
| Progress Year: scrolling | 39.2 | 134 ms | 1 | 4.4 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.9%  closure #1 in AppModel.ensureLoaded() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Progress (first): longest stall 1099 ms
- Progress (again): longest stall 264 ms
- Progress Year (first): longest stall 532 ms
- Progress Year (again): longest stall 222 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| progress | Progress year: whole snapshot | 2 | 66 ms | 43.1 ms |
| progress | Progress year: cards | 2 | 66 ms | 42.9 ms |
| progress | Progress year: one card | 30 | 62 ms | 5.3 ms |
| progress | Progress week: whole snapshot | 2 | 34 ms | 27.4 ms |
| progress | Progress week: cards | 2 | 33 ms | 26.8 ms |
| progress | Progress week: one card | 30 | 19 ms | 12.3 ms |
| progress | Progress month: whole snapshot | 2 | 11 ms | 8.0 ms |
| progress | Progress month: cards | 2 | 11 ms | 7.8 ms |
| progress | Progress week: one quit card | 4 | 10 ms | 9.0 ms |
| progress | Progress month: one card | 30 | 8 ms | 0.7 ms |
| progress | Progress year: one quit card | 2 | 0 ms | 0.2 ms |
| progress | Progress month: one quit card | 4 | 0 ms | 0.1 ms |
| progress-year | Progress year: whole snapshot | 1 | 44 ms | 44.4 ms |
| progress-year | Progress year: cards | 1 | 44 ms | 44.2 ms |
| progress-year | Progress year: one card | 15 | 40 ms | 10.8 ms |
| progress-year | Progress week: whole snapshot | 1 | 5 ms | 5.0 ms |
| progress-year | Progress week: cards | 1 | 5 ms | 4.6 ms |
| progress-year | Progress week: one card | 15 | 3 ms | 0.4 ms |
| progress-year | Progress year: one quit card | 2 | 1 ms | 1.0 ms |
| progress-year | Progress week: one quit card | 2 | 1 ms | 0.7 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
