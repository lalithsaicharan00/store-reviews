# details-page-update @ c09cdb9

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37330464579 · 2026-10-05 16:00 UTC
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
| Today: scrolling | 22.7 | 215 ms | 2 | 4.4 % (separate profile) | 0.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.9%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 and day ‹ › | 117.4 | 118 ms | 2 | 9.2 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.7%  closure #1 in HabitStore.queueEntryChange() |
| Today: +1 alone | 3.4 | 34 ms | 0 | 9.2 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.7%  closure #1 in HabitStore.queueEntryChange() |
| Today: day ‹ › alone | 59.4 | 65 ms | 0 | 9.2 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.7%  closure #1 in HabitStore.queueEntryChange() |
| Today: Day sheet scrolling | 7.7 | 27 ms | 0 | 9.2 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.7%  closure #1 in HabitStore.queueEntryChange() |
| Timer screen: a running clock | 13.7 | 69 ms | 0 | 9.2 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.7%  closure #1 in HabitStore.queueEntryChange() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Today: a row's Day sheet (first): longest stall 655 ms
- Today: a row's Day sheet (again): longest stall 234 ms
- Today: the note sheet: longest stall 1136 ms
- Today: the timer screen: longest stall 1464 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| scroll-today | Widgets: one habit's month | 17 | 200 ms | 133.4 ms |
| scroll-today | Reminders: plan every alert | 1 | 2 ms | 2.4 ms |
| scroll-today | Widgets: the snapshot | 1 | 1 ms | 0.8 ms |
| scroll-today | Count: Today's list drawn | 6 | 0 ms | 0.1 ms |
| scroll-today | Count: a Today row drawn | 30 | 0 ms | 0.0 ms |
| tap-today | Widgets: one habit's month | 19 | 124 ms | 51.4 ms |
| tap-today | Reminders: plan every alert | 57 | 4 ms | 0.2 ms |
| tap-today | Widgets: the snapshot | 3 | 3 ms | 2.0 ms |
| tap-today | Change: Siri's habit names | 57 | 2 ms | 0.1 ms |
| tap-today | Count: a Today row drawn | 678 | 0 ms | 0.1 ms |
| tap-today | Count: Today's list drawn | 97 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet drawn | 5 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's activity drawn | 5 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
