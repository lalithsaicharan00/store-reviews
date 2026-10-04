# claude/perf-bisect-v1 @ 33e0f3b

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37172462006 · 2026-10-04 03:07 UTC
Commit: Speed bisect variant v1 (not for merging)

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
| Today: +1 and day ‹ › | 13.3 | 44 ms | 0 | 5.4 % (separate profile) | 0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 alone | 0.0 | 0 ms | 0 | 5.4 % (separate profile) | 0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| Today: day ‹ › alone | 15.9 | 43 ms | 0 | 5.4 % (separate profile) | 0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| Today: Day sheet scrolling | 7.8 | 130 ms | 1 | 5.4 % (separate profile) | 0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Today: a row's Day sheet (first): longest stall 644 ms
- Today: a row's Day sheet (again): longest stall 302 ms
- Today: the note sheet: longest stall 592 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| tap-today | Widgets: one habit's month | 18 | 74 ms | 32.4 ms |
| tap-today | Reminders: plan every alert | 57 | 2 ms | 0.2 ms |
| tap-today | Change: Siri's habit names | 56 | 2 ms | 0.2 ms |
| tap-today | Widgets: the snapshot | 2 | 1 ms | 0.8 ms |
| tap-today | Count: Today's list drawn | 87 | 0 ms | 0.3 ms |
| tap-today | Count: a Today row drawn | 383 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet drawn | 14 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's entries drawn | 5 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
