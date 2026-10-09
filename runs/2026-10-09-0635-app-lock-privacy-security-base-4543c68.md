# app-lock-privacy-security-base @ 4543c68

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37892222401 · 2026-10-09 06:35 UTC
Commit: Current Work 58: App Lock and widget privacy research, decisions 1-4 and the Privacy & Security spec

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
| Today: +1 and day ‹ › | 43.4 | 73 ms | 0 | 6.6 % (separate profile) | 0.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.3%  closure #1 in HabitStore.queueEntryChange() |
| Today: +1 alone | 3.4 | 66 ms | 0 | 6.6 % (separate profile) | 0.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.3%  closure #1 in HabitStore.queueEntryChange() |
| Today: day ‹ › alone | 45.5 | 93 ms | 0 | 6.6 % (separate profile) | 0.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.3%  closure #1 in HabitStore.queueEntryChange() |
| Today: Day sheet scrolling | 0.0 | 0 ms | 0 | 6.6 % (separate profile) | 0.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.3%  closure #1 in HabitStore.queueEntryChange() |
| Timer screen: a running clock | 10.5 | 165 ms | 1 | 6.6 % (separate profile) | 0.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.3%  closure #1 in HabitStore.queueEntryChange() |
| Today: group filter | 42.1 | 88 ms | 0 | 2.7 % (separate profile) | 0.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.2%  closure #1 in AppModel.ensureLoaded() |
| Arrange Your Day: scrolling | 3.7 | 33 ms | 0 | 4.8 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  partial apply for closure #1 in AppModel.ensureLoaded()<br>1.0%  closure #1 in AppModel.ensureLoaded() |
| Arrange Your Day: move Anytime and sort | 4.4 | 30 ms | 0 | 4.8 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  partial apply for closure #1 in AppModel.ensureLoaded()<br>1.0%  closure #1 in AppModel.ensureLoaded() |
| Today: hide completed on and off | 23.1 | 86 ms | 0 | 4.8 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  partial apply for closure #1 in AppModel.ensureLoaded()<br>1.0%  closure #1 in AppModel.ensureLoaded() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Today: a row's Day sheet (first): longest stall 1254 ms
- Today: a row's Day sheet (again): longest stall 361 ms
- Today: the note sheet: longest stall 1048 ms
- Today: the timer screen: longest stall 1102 ms
- Arrange Your Day (first): longest stall 326 ms
- Arrange Your Day (again): longest stall 141 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| tap-today | Widgets: one habit's week | 33 | 153 ms | 53.5 ms |
| tap-today | Widgets: the snapshot | 17 | 24 ms | 5.1 ms |
| tap-today | Reminders: plan every alert | 57 | 5 ms | 1.1 ms |
| tap-today | Change: Siri's habit names | 57 | 4 ms | 0.9 ms |
| tap-today | Count: Today's list drawn | 91 | 1 ms | 0.4 ms |
| tap-today | Count: a Today row drawn | 384 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet drawn | 4 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's activity drawn | 4 | 0 ms | 0.0 ms |
| groups | Widgets: one habit's week | 17 | 97 ms | 63.2 ms |
| groups | Widgets: the snapshot | 1 | 2 ms | 1.5 ms |
| groups | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| groups | Count: Today's list drawn | 48 | 0 ms | 0.1 ms |
| groups | Count: a Today row drawn | 252 | 0 ms | 0.0 ms |
| arrange | Widgets: one habit's week | 34 | 127 ms | 64.6 ms |
| arrange | Widgets: the snapshot | 13 | 12 ms | 1.9 ms |
| arrange | Reminders: plan every alert | 28 | 2 ms | 0.6 ms |
| arrange | Change: Siri's habit names | 27 | 1 ms | 0.1 ms |
| arrange | Arrange: each card's habits | 29 | 1 ms | 0.2 ms |
| arrange | Count: Today's list drawn | 41 | 0 ms | 0.0 ms |
| arrange | Count: a Today row drawn | 183 | 0 ms | 0.0 ms |
| arrange | Count: Arrange Your Day drawn | 29 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
