# claude/server-and-sync @ bbe6509

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36975791462 · 2026-10-02 07:56 UTC
Commit: Plan: progress to check-in 3 (iPhone install, its three bugs, Apple token revocation)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (ProgressUITests,GoalFlowUITests,HabitScenarioUITests): failure
- Speed tests: cancelled
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 1 failure (0 unexpected) in 183.063 (183.070) seconds
	 Executed 24 tests, with 1 failure (0 unexpected) in 1631.778 (1631.803) seconds
	 Executed 24 tests, with 1 failure (0 unexpected) in 1631.778 (1631.805) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 440.968 (440.980) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 1007.746 (1007.751) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ProgressUITests.swift:160: error: -[HabitsUITests.ProgressUITests testHidePercentages] : XCTAssertTrue failed - Every percentage is hidden
Test Case '-[HabitsUITests.GoalFlowUITests testButtonAddsItsStepAndRowOpensAddAmount]' passed (160.644 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testHowOftenChoicesSayTheAmount]' passed (67.075 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testNumberShowsWithoutAUnit]' passed (44.661 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testOwnStep]' passed (57.961 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testTypingKeyByKey]' passed (79.384 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testUnitScreen]' passed (31.243 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testCountsAndAmounts]' passed (218.540 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testCutDown]' passed (49.159 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testDaySets]' passed (212.569 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testDaySetsNamedAndAll]' passed (128.069 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testEachTypeStartsWithDefaults]' passed (63.402 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testLongest]' passed (53.968 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testMonthDateSets]' passed (250.795 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testStartsAndEnds]' passed (31.244 seconds).
Test Case '-[HabitsUITests.ProgressUITests testDaySheetShowsOnToday]' passed (18.602 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (12.095 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndRuns]' passed (15.140 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' failed (19.839 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (31.179 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (20.516 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (16.334 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (6.350 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtOverTime]' passed (23.984 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (19.024 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Today: scrolling | 29.0 | 206 ms | 2 | 6.7 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.8%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Today: +1 and day ‹ › | 71.5 | 178 ms | 1 |  | (none above noise) |
| Today: group filter | 0.7 | 26 ms | 0 |  | (none above noise) |
| Menu: open and close | 55.7 | 184 ms | 2 |  | (none above noise) |
| All Habits: scrolling | 0.5 | 25 ms | 0 |  | (none above noise) |
| Habit page: scrolling | 25.9 | 173 ms | 2 |  | (none above noise) |
| Habit page (weekly total): scrolling | 1.9 | 35 ms | 0 |  | (none above noise) |
| Habit page (quit): scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Progress: scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Progress: period ‹ › and range | 88.9 | 139 ms | 1 |  | (none above noise) |
| Calendar: month ‹ › | 19.4 | 48 ms | 0 |  | (none above noise) |
| Habit form: typing | 6.9 | 42 ms | 0 | 12.0 % (separate profile) | 1.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.2%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Routine player: ‹ › | 15.3 | 57 ms | 0 |  | (none above noise) |
| Day sheet: entry list scrolling | 0.0 | 0 ms | 0 | 11.2 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 18.9 | 37 ms | 0 | 11.2 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 31.7 | 46 ms | 0 | 11.2 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Log sheet: typing | 37.8 | 52 ms | 0 | 1.2 % (separate profile) | 0.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Log sheet: entry list scrolling | 0.7 | 26 ms | 0 | 1.2 % (separate profile) | 0.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 7.3 | 52 ms | 0 | 1.2 % (separate profile) | 0.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 32.3 | 142 ms | 1 | 1.2 % (separate profile) | 0.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Widgets guide: scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Widget: durable amount log and publication | 0.0 | 0 ms | 0 |  | (none above noise) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Tasks: longest stall 179 ms
- Times of Day: longest stall 144 ms
- Day and Week: longest stall 246 ms
- Reminders: longest stall 154 ms
- Appearance: longest stall 175 ms
- Backup & Export: longest stall 207 ms
- Privacy: longest stall 114 ms
- Plus: longest stall 107 ms
- Help & Feedback: longest stall 276 ms
- About: longest stall 261 ms
- All Habits (first): longest stall 275 ms
- All Habits (again): longest stall 129 ms
- All Habits: longest stall 496 ms
- Habit page: longest stall 557 ms
- All Habits: longest stall 308 ms
- Habit page (weekly total): longest stall 0 ms
- All Habits: longest stall 261 ms
- Habit page (quit): longest stall 371 ms
- All Habits: longest stall 225 ms
- Habit page: longest stall 254 ms
- Edit habit (first): longest stall 483 ms
- Edit habit (again): longest stall 199 ms
- Progress (first): longest stall 485 ms
- Progress (again): longest stall 159 ms
- Calendar (first): longest stall 513 ms
- Calendar (again): longest stall 351 ms
- New Habit (first): longest stall 316 ms
- New Habit (again): longest stall 190 ms
- Habit form (first): longest stall 1294 ms
- Habit form (again): longest stall 465 ms
- Routine player (first): longest stall 399 ms
- Routine player (again): longest stall 101 ms
- All Habits: longest stall 333 ms
- Habit page: longest stall 356 ms
- Day sheet (first): longest stall 476 ms
- Day sheet (again): longest stall 244 ms
- Entry editor: longest stall 763 ms
- Save entry: longest stall 185 ms
- All Habits: longest stall 240 ms
- Habit page: longest stall 275 ms
- Day sheet (first): longest stall 327 ms
- Day sheet (again): longest stall 178 ms
- Log sheet: longest stall 274 ms
- Log keyboard dismissal: longest stall 55 ms
- Entry editor: longest stall 299 ms
- Save entry: longest stall 261 ms
- Widgets guide (first): longest stall 351 ms
- Widgets guide (again): longest stall 246 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| progress | Progress year: whole snapshot | 2 | 61 ms | 41.2 ms |
| progress | Progress year: one habit's row | 30 | 33 ms | 2.0 ms |
| progress | Progress year: day scores | 2 | 14 ms | 13.7 ms |
| progress | Progress week: whole snapshot | 2 | 14 ms | 12.3 ms |
| progress | Progress week: day scores | 2 | 7 ms | 7.3 ms |
| progress | Progress month: whole snapshot | 2 | 7 ms | 3.7 ms |
| progress | Progress year: previous period | 1 | 5 ms | 5.3 ms |
| progress | Progress year: row dots | 2 | 4 ms | 1.9 ms |
| progress | Progress month: one habit's row | 30 | 3 ms | 0.2 ms |
| progress | Progress week: one habit's row | 30 | 2 ms | 0.8 ms |
| progress | Progress month: previous period | 2 | 2 ms | 1.0 ms |
| progress | Progress month: day scores | 2 | 1 ms | 0.8 ms |
| progress | Progress week: previous period | 2 | 1 ms | 0.3 ms |
| progress | Progress year: one habit's goals | 1 | 0 ms | 0.2 ms |
| progress | Progress year: one quit row | 2 | 0 ms | 0.1 ms |
| progress | Progress: earliest day | 6 | 0 ms | 0.0 ms |
| progress | Progress month: one quit row | 4 | 0 ms | 0.1 ms |
| progress | Progress week: one quit row | 4 | 0 ms | 0.1 ms |
| progress | Progress month: one habit's goals | 2 | 0 ms | 0.0 ms |
| progress | Progress week: one habit's goals | 2 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
