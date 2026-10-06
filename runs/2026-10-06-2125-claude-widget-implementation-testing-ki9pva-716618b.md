# claude/widget-implementation-testing-ki9pva @ 716618b

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37530191993 · 2026-10-06 21:25 UTC
Commit: Lock Screen system test: ask only hosts that are still running

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (WidgetSystemUITests): success
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 1 test skipped and 0 failures (0 unexpected) in 270.215 (270.219) seconds
	 Executed 2 tests, with 1 test skipped and 0 failures (0 unexpected) in 270.215 (270.221) seconds
	 Executed 2 tests, with 1 test skipped and 0 failures (0 unexpected) in 270.215 (270.222) seconds
Test Case '-[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence]' passed (171.689 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Today: scrolling | 13.4 | 71 ms | 0 | 3.4 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.7%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 and day ‹ › | 13.2 | 42 ms | 0 | 10.5 % (separate profile) | 2.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>1.2%  closure #1 in HabitStore.queueEntryChange() |
| Today: +1 alone | 0.4 | 22 ms | 0 | 10.5 % (separate profile) | 2.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>1.2%  closure #1 in HabitStore.queueEntryChange() |
| Today: day ‹ › alone | 12.8 | 58 ms | 0 | 10.5 % (separate profile) | 2.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>1.2%  closure #1 in HabitStore.queueEntryChange() |
| Today: Day sheet scrolling | 0.0 | 0 ms | 0 | 10.5 % (separate profile) | 2.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>1.2%  closure #1 in HabitStore.queueEntryChange() |
| Timer screen: a running clock | 0.0 | 0 ms | 0 | 10.5 % (separate profile) | 2.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>1.2%  closure #1 in HabitStore.queueEntryChange() |
| Widget: durable amount log and publication | 0.0 | 0 ms | 0 | 2.4 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  WidgetPublisher.publishNow(_:hold:)<br>0.6%  WidgetPublisher.publish(_:hold:) |
| Widget: full publication, every habit's week | 0.0 | 0 ms | 0 | 3.1 % (separate profile) | 1.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.8%  WidgetPublisher.publish(_:hold:)<br>1.8%  WidgetPublisher.publishNow(_:hold:) |
| Widgets guide: scrolling | 0.0 | 0 ms | 0 | 6.1 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.1%  closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Today: a row's Day sheet (first): longest stall 514 ms
- Today: a row's Day sheet (again): longest stall 244 ms
- Today: the note sheet: longest stall 665 ms
- Today: the timer screen: longest stall 643 ms
- Widgets guide (first): longest stall 567 ms
- Widgets guide (again): longest stall 138 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| scroll-today | Widgets: one habit's week | 17 | 75 ms | 51.5 ms |
| scroll-today | Widgets: the snapshot | 1 | 1 ms | 1.0 ms |
| scroll-today | Reminders: plan every alert | 1 | 1 ms | 0.6 ms |
| scroll-today | Count: Today's list drawn | 10 | 0 ms | 0.0 ms |
| scroll-today | Count: a Today row drawn | 93 | 0 ms | 0.0 ms |
| tap-today | Widgets: one habit's week | 19 | 51 ms | 27.7 ms |
| tap-today | Widgets: the snapshot | 3 | 4 ms | 2.7 ms |
| tap-today | Reminders: plan every alert | 58 | 3 ms | 0.1 ms |
| tap-today | Change: Siri's habit names | 58 | 2 ms | 0.1 ms |
| tap-today | Count: the Day sheet drawn | 15 | 0 ms | 0.4 ms |
| tap-today | Count: Today's list drawn | 92 | 0 ms | 0.0 ms |
| tap-today | Count: a Today row drawn | 792 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's activity drawn | 15 | 0 ms | 0.0 ms |
| widget-log | Widgets: one habit's week | 40 | 69 ms | 26.6 ms |
| widget-log | Widgets: the snapshot | 24 | 20 ms | 1.2 ms |
| widget-log | Reminders: plan every alert | 48 | 2 ms | 0.1 ms |
| widget-log | Change: Siri's habit names | 54 | 2 ms | 0.1 ms |
| widget-log | Count: Today's list drawn | 7 | 0 ms | 0.0 ms |
| widget-log | Count: a Today row drawn | 181 | 0 ms | 0.0 ms |
| widget-publish | Widgets: one habit's week | 408 | 442 ms | 30.4 ms |
| widget-publish | Widgets: the snapshot | 24 | 20 ms | 1.7 ms |
| widget-publish | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| widget-publish | Count: Today's list drawn | 6 | 0 ms | 0.0 ms |
| widget-publish | Count: a Today row drawn | 32 | 0 ms | 0.0 ms |
| widget-guide | Widgets: one habit's week | 17 | 60 ms | 39.6 ms |
| widget-guide | Widgets: the snapshot | 1 | 1 ms | 0.9 ms |
| widget-guide | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| widget-guide | Count: Today's list drawn | 12 | 0 ms | 0.0 ms |
| widget-guide | Count: a Today row drawn | 106 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
