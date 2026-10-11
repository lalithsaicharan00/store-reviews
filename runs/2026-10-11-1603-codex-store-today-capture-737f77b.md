# codex/store-today-capture @ 737f77b

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38151781373 · 2026-10-11 16:03 UTC
Commit: Prepare native Today artwork capture with habits and one task

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (TodayUITests/testStoreTodayCapture): success
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
Test Case '-[HabitsUITests.TodayUITests testStoreTodayCapture]' passed (64.249 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Today: scrolling | 17.5 | 214 ms | 1 | 6.3 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.7%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Today: +1 and day ‹ › | 101.1 | 118 ms | 1 | 1.5 % (separate profile) | 0.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.4%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 alone | 5.1 | 39 ms | 0 | 1.5 % (separate profile) | 0.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.4%  closure #1 in AppModel.ensureLoaded() |
| Today: day ‹ › alone | 107.8 | 135 ms | 2 | 1.5 % (separate profile) | 0.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.4%  closure #1 in AppModel.ensureLoaded() |
| Today: Day sheet scrolling | 0.0 | 0 ms | 0 | 1.5 % (separate profile) | 0.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.4%  closure #1 in AppModel.ensureLoaded() |
| Timer screen: a running clock | 7.3 | 61 ms | 0 | 1.5 % (separate profile) | 0.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.4%  closure #1 in AppModel.ensureLoaded() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Today: a row's Day sheet (first): longest stall 840 ms
- Today: a row's Day sheet (again): longest stall 401 ms
- Today: the note sheet: longest stall 2594 ms
- Today: the timer screen: longest stall 1901 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| scroll-today | Widgets: one habit's week | 17 | 77 ms | 37.9 ms |
| scroll-today | Widgets: the snapshot | 1 | 4 ms | 3.8 ms |
| scroll-today | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| scroll-today | Count: Today's list drawn | 7 | 0 ms | 0.2 ms |
| scroll-today | Count: a Today row drawn | 12 | 0 ms | 0.0 ms |
| tap-today | Widgets: one habit's week | 33 | 186 ms | 67.2 ms |
| tap-today | Widgets: the snapshot | 17 | 32 ms | 6.5 ms |
| tap-today | Change: Siri's habit names | 58 | 8 ms | 1.9 ms |
| tap-today | Reminders: plan every alert | 58 | 7 ms | 2.6 ms |
| tap-today | Count: Today's list drawn | 96 | 0 ms | 0.1 ms |
| tap-today | Count: a Today row drawn | 630 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet drawn | 11 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's activity drawn | 11 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
