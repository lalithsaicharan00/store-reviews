# app-lock-privacy-security-ci2 @ 1918454

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37892225073 · 2026-10-09 06:39 UTC
Commit: Design Rules: the lock cover's own window; locking ends typing (Current Work 58)

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
| Today: +1 and day ‹ › | 46.7 | 91 ms | 0 | 0.2 % (separate profile) | 0.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.2%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 alone | 0.2 | 19 ms | 0 | 0.2 % (separate profile) | 0.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.2%  closure #1 in AppModel.ensureLoaded() |
| Today: day ‹ › alone | 65.5 | 58 ms | 0 | 0.2 % (separate profile) | 0.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.2%  closure #1 in AppModel.ensureLoaded() |
| Today: Day sheet scrolling | 0.0 | 0 ms | 0 | 0.2 % (separate profile) | 0.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.2%  closure #1 in AppModel.ensureLoaded() |
| Timer screen: a running clock | 24.3 | 277 ms | 1 | 0.2 % (separate profile) | 0.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.2%  closure #1 in AppModel.ensureLoaded() |
| Today: group filter | 30.8 | 84 ms | 0 | 11.9 % (separate profile) | 0.3%  AppModel.shared.unsafeMutableAddressor<br>0.3%  one-time initialization function for shared<br>0.3%  AppModel.().init()<br>0.3%  static FakeAuthWindow.install() |
| Arrange Your Day: scrolling | 5.7 | 39 ms | 0 | 3.3 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.3%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Arrange Your Day: move Anytime and sort | 14.6 | 61 ms | 0 | 3.3 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.3%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Today: hide completed on and off | 35.5 | 111 ms | 1 | 3.3 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.3%  closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Today: a row's Day sheet (first): longest stall 935 ms
- Today: a row's Day sheet (again): longest stall 284 ms
- Today: the note sheet: longest stall 4666 ms
- Today: the timer screen: longest stall 0 ms
- Arrange Your Day (first): longest stall 332 ms
- Arrange Your Day (again): longest stall 85 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| tap-today | Widgets: one habit's week | 33 | 220 ms | 66.2 ms |
| tap-today | Widgets: the snapshot | 17 | 24 ms | 4.7 ms |
| tap-today | Reminders: plan every alert | 58 | 4 ms | 0.9 ms |
| tap-today | Change: Siri's habit names | 58 | 3 ms | 0.1 ms |
| tap-today | Count: Today's list drawn | 101 | 0 ms | 0.0 ms |
| tap-today | Count: a Today row drawn | 396 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet drawn | 11 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's activity drawn | 11 | 0 ms | 0.0 ms |
| groups | Widgets: one habit's week | 17 | 100 ms | 62.1 ms |
| groups | Widgets: the snapshot | 1 | 1 ms | 0.9 ms |
| groups | Count: Today's list drawn | 46 | 0 ms | 0.3 ms |
| groups | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| groups | Count: a Today row drawn | 237 | 0 ms | 0.0 ms |
| arrange | Widgets: one habit's week | 34 | 120 ms | 56.6 ms |
| arrange | Widgets: the snapshot | 13 | 16 ms | 2.5 ms |
| arrange | Change: Siri's habit names | 27 | 3 ms | 0.5 ms |
| arrange | Reminders: plan every alert | 28 | 3 ms | 0.2 ms |
| arrange | Arrange: each card's habits | 29 | 1 ms | 0.2 ms |
| arrange | Count: Today's list drawn | 41 | 0 ms | 0.0 ms |
| arrange | Count: a Today row drawn | 183 | 0 ms | 0.0 ms |
| arrange | Count: Arrange Your Day drawn | 29 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
