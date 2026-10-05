# details-page-update @ c09cdb9

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37330393173 · 2026-10-05 15:35 UTC
Commit: HabitCreationUITests.testOtherTypes: wait for the task's preview to catch up

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (none): skipped
- Speed tests: success
- Speed tests through XCTest: skipped

## Release build
```
** BUILD SUCCEEDED **
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Today: scrolling | 22.7 | 304 ms | 1 | 1.6 % (separate profile) | 0.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.2%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 and day ‹ › | 68.7 | 114 ms | 1 | 7.7 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.5%  closure #1 in HabitStore.queueEntryChange() |
| Today: +1 alone | 5.5 | 42 ms | 0 | 7.7 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.5%  closure #1 in HabitStore.queueEntryChange() |
| Today: day ‹ › alone | 51.2 | 70 ms | 0 | 7.7 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.5%  closure #1 in HabitStore.queueEntryChange() |
| Today: Day sheet scrolling | 6.9 | 33 ms | 0 | 7.7 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.5%  closure #1 in HabitStore.queueEntryChange() |
| Timer screen: a running clock | 6.1 | 64 ms | 0 | 7.7 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.5%  closure #1 in HabitStore.queueEntryChange() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Today: a row's Day sheet (first): longest stall 829 ms
- Today: a row's Day sheet (again): longest stall 358 ms
- Today: the note sheet: longest stall 2082 ms
- Today: the timer screen: longest stall 2071 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| scroll-today | Widgets: one habit's month | 17 | 110 ms | 59.3 ms |
| scroll-today | Reminders: plan every alert | 1 | 3 ms | 3.0 ms |
| scroll-today | Widgets: the snapshot | 1 | 1 ms | 0.7 ms |
| scroll-today | Count: Today's list drawn | 6 | 0 ms | 0.0 ms |
| scroll-today | Count: a Today row drawn | 30 | 0 ms | 0.0 ms |
| tap-today | Widgets: one habit's month | 19 | 138 ms | 68.4 ms |
| tap-today | Widgets: the snapshot | 3 | 6 ms | 4.8 ms |
| tap-today | Reminders: plan every alert | 59 | 4 ms | 0.1 ms |
| tap-today | Change: Siri's habit names | 58 | 3 ms | 0.1 ms |
| tap-today | Count: Today's list drawn | 102 | 0 ms | 0.0 ms |
| tap-today | Count: a Today row drawn | 719 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet drawn | 13 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's activity drawn | 13 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
