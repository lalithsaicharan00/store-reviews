# claude/habit-details-perf @ 70d556f

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37170418764 · 2026-10-04 02:33 UTC
Commit: Tests follow the row work: swipes drag a fixed distance (a name is too narrow for XCUITest's swipe), yesterday opens Anytime first, the task test uses the task fixture, GoalFlow types other amounts through the Day sheet, results read "3/3 times"; the delete question gets an explicit Cancel

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
| Today: +1 and day ‹ › | 133.9 | 210 ms | 8 | 0.5 % (separate profile) | 0.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.1%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 alone | 11.2 | 53 ms | 0 | 0.5 % (separate profile) | 0.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.1%  closure #1 in AppModel.ensureLoaded() |
| Today: day ‹ › alone | 143.7 | 189 ms | 5 | 0.5 % (separate profile) | 0.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.1%  closure #1 in AppModel.ensureLoaded() |
| Today: Day sheet scrolling | 48.7 | 285 ms | 1 | 0.5 % (separate profile) | 0.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.1%  closure #1 in AppModel.ensureLoaded() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Today: a row's Day sheet (first): longest stall 2184 ms
- Today: a row's Day sheet (again): longest stall 0 ms
- Today: the note sheet: longest stall 2249 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| tap-today | Widgets: one habit's month | 18 | 181 ms | 102.1 ms |
| tap-today | Reminders: plan every alert | 51 | 5 ms | 0.8 ms |
| tap-today | Widgets: the snapshot | 2 | 4 ms | 3.0 ms |
| tap-today | Change: Siri's habit names | 53 | 3 ms | 0.2 ms |
| tap-today | Count: Today's list drawn | 84 | 1 ms | 0.6 ms |
| tap-today | Count: a Today row drawn | 370 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet drawn | 4 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's entries drawn | 4 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
