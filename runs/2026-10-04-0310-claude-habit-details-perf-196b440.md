# claude/habit-details-perf @ 196b440

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37172465382 · 2026-10-04 03:10 UTC
Commit: A skipped habit stays on Today as a neutral "Skipped today" row (it vanished, so Undo Skip had nowhere to be); sheets say Yesterday; NewHabit expects +1 for twice a day

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
| Today: +1 and day ‹ › | 72.8 | 88 ms | 0 | 4.1 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 alone | 3.7 | 35 ms | 0 | 4.1 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| Today: day ‹ › alone | 71.8 | 83 ms | 0 | 4.1 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| Today: Day sheet scrolling | 35.9 | 69 ms | 0 | 4.1 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Today: a row's Day sheet (first): longest stall 1192 ms
- Today: a row's Day sheet (again): longest stall 672 ms
- Today: the note sheet: longest stall 4009 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| tap-today | Widgets: one habit's month | 18 | 133 ms | 61.2 ms |
| tap-today | Reminders: plan every alert | 57 | 5 ms | 1.0 ms |
| tap-today | Widgets: the snapshot | 2 | 3 ms | 2.4 ms |
| tap-today | Change: Siri's habit names | 56 | 2 ms | 0.1 ms |
| tap-today | Count: Today's list drawn | 87 | 0 ms | 0.2 ms |
| tap-today | Count: a Today row drawn | 385 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet drawn | 14 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's entries drawn | 7 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
