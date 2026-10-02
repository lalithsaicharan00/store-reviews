# claude/server-and-sync @ 90da261

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37016130735 · 2026-10-02 14:31 UTC
Commit: Widgets publish 2 s after the last change, not 180 ms: a run of taps pays for one projection, after the taps

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (WidgetUITests,WidgetSystemUITests): success
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 1 test skipped and 0 failures (0 unexpected) in 425.082 (425.089) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 176.193 (176.198) seconds
	 Executed 7 tests, with 1 test skipped and 0 failures (0 unexpected) in 601.275 (601.289) seconds
	 Executed 7 tests, with 1 test skipped and 0 failures (0 unexpected) in 601.275 (601.290) seconds
Test Case '-[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence]' passed (297.987 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' passed (113.785 seconds).
Test Case '-[HabitsUITests.WidgetUITests testGuideAndPrivacyAreFree]' passed (21.332 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLargerTextCountersAndCutDownAreReadable]' passed (20.901 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLongNamesAndUnitsKeepQuickActionVisible]' passed (12.492 seconds).
Test Case '-[HabitsUITests.WidgetUITests testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks]' passed (7.683 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Day sheet: entry list scrolling | 2.3 | 37 ms | 0 | 6.0 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 4.3 | 42 ms | 0 | 6.0 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 45.6 | 48 ms | 0 | 6.0 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Today: +1 and day ‹ › | 124.6 | 146 ms | 3 | 5.1 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.3%  closure #1 in HabitStore.queueEntryChange() |
| Today: +1 alone | 6.7 | 47 ms | 0 | 5.1 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.3%  closure #1 in HabitStore.queueEntryChange() |
| Today: day ‹ › alone | 53.3 | 68 ms | 0 | 5.1 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.3%  closure #1 in HabitStore.queueEntryChange() |
| Widget: durable amount log and publication | 0.0 | 0 ms | 0 | 1.3 % (separate profile) | 0.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  perfTimed<A>(_:_:)<br>0.2%  static MainThreadMeter.time<A>(_:_:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- All Habits: longest stall 530 ms
- Habit page: longest stall 470 ms
- Day sheet (first): longest stall 496 ms
- Day sheet (again): longest stall 322 ms
- Entry editor: longest stall 1448 ms
- Save entry: longest stall 253 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| day-sheet | Widgets: one habit's month | 17 | 93 ms | 50.2 ms |
| day-sheet | Change: Siri's habit names | 145 | 6 ms | 0.2 ms |
| day-sheet | Reminders: plan every alert | 3 | 1 ms | 1.0 ms |
| day-sheet | Widgets: the snapshot | 1 | 1 ms | 0.8 ms |
| day-sheet | Entry editor: whole editor drawn | 8 | 1 ms | 0.7 ms |
| tap-today | Widgets: one habit's month | 18 | 166 ms | 87.7 ms |
| tap-today | Reminders: plan every alert | 57 | 4 ms | 0.2 ms |
| tap-today | Change: Siri's habit names | 56 | 3 ms | 0.3 ms |
| tap-today | Widgets: the snapshot | 2 | 2 ms | 1.1 ms |
| widget-log | Widgets: one habit's month | 40 | 113 ms | 36.6 ms |
| widget-log | Widgets: the snapshot | 24 | 8 ms | 0.6 ms |
| widget-log | Reminders: plan every alert | 49 | 2 ms | 0.1 ms |
| widget-log | Change: Siri's habit names | 54 | 2 ms | 0.2 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
