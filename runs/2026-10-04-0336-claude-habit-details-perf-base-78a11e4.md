# claude/habit-details-perf-base @ 78a11e4

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37173649322 · 2026-10-04 03:36 UTC
Commit: Today's rows: a tap opens the Day sheet for the day shown; ✓ toggles that day's tick, + adds; swipes reveal Note/Skip/Pause and a named Undo; long press matches the sheet; Delete only in the sheet's ⋯ menu; done habits stay in place

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
| Today: +1 and day ‹ › | 90.8 | 234 ms | 1 | 3.5 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.9%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 alone | 21.3 | 173 ms | 2 | 3.5 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.9%  closure #1 in AppModel.ensureLoaded() |
| Today: day ‹ › alone | 141.5 | 256 ms | 6 | 3.5 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.9%  closure #1 in AppModel.ensureLoaded() |
| Today: Day sheet scrolling | 102.1 | 460 ms | 2 | 3.5 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.9%  closure #1 in AppModel.ensureLoaded() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Today: a row's Day sheet (first): longest stall 1811 ms
- Today: a row's Day sheet (again): longest stall 686 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| tap-today | Widgets: one habit's month | 18 | 147 ms | 81.1 ms |
| tap-today | Reminders: plan every alert | 51 | 4 ms | 0.3 ms |
| tap-today | Change: Siri's habit names | 54 | 3 ms | 0.3 ms |
| tap-today | Widgets: the snapshot | 2 | 3 ms | 2.0 ms |
| tap-today | Count: Today's list drawn | 80 | 1 ms | 1.1 ms |
| tap-today | Count: the Day sheet drawn | 2 | 0 ms | 0.0 ms |
| tap-today | Count: a Today row drawn | 203 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's entries drawn | 2 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
