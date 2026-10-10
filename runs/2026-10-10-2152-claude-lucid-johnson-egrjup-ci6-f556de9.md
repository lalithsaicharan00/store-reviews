# claude/lucid-johnson-egrjup-ci6 @ f556de9

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38087086013 · 2026-10-10 21:52 UTC
Commit: iCloud sync: the database's iCloud work runs off the main thread; the screen re-reads once a fetch's pages stop

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (none): skipped
- Speed tests: failure
- Speed tests through XCTest: skipped

## Release build
```
** BUILD SUCCEEDED **
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| iCloud & Backup: scrolling | 0.0 | 0 ms | 0 | 18.2 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.6%  closure #1 in AppModel.ensureLoaded() |
| Today: scrolling during a big iCloud fetch | 31.8 | 238 ms | 2 | 12.6 % (separate profile) | 1.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.6%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Today: +1 during a big iCloud fetch | 22.2 | 150 ms | 2 | 12.6 % (separate profile) | 1.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.6%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Today: +1 and day ‹ › | 67.4 | 108 ms | 1 | 9.1 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 alone | 0.0 | 0 ms | 0 | 9.1 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| Today: day ‹ › alone | 62.0 | 73 ms | 0 | 9.1 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| Today: Day sheet scrolling | 0.0 | 0 ms | 0 | 9.1 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| Timer screen: a running clock | 24.6 | 126 ms | 2 | 9.1 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- iCloud & Backup (first): longest stall 700 ms
- iCloud & Backup (again): longest stall 195 ms
- iCloud & Backup → Restore From a Backup: longest stall 211 ms
- Today: a row's Day sheet (first): longest stall 854 ms
- Today: a row's Day sheet (again): longest stall 353 ms
- Today: the note sheet: longest stall 5524 ms
- Today: the timer screen: longest stall 0 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| icloud-page | Widgets: one habit's week | 17 | 174 ms | 123.6 ms |
| icloud-page | Widgets: the snapshot | 1 | 4 ms | 4.1 ms |
| icloud-page | Count: Today's list drawn | 14 | 1 ms | 1.0 ms |
| icloud-page | Reminders: plan every alert | 1 | 0 ms | 0.3 ms |
| icloud-page | Count: a Today row drawn | 66 | 0 ms | 0.0 ms |
| today-big-fetch | Widgets: one habit's week | 34 | 144 ms | 68.7 ms |
| today-big-fetch | Change: Siri's habit names | 226 | 13 ms | 0.2 ms |
| today-big-fetch | Reminders: plan every alert | 104 | 7 ms | 1.2 ms |
| today-big-fetch | Widgets: the snapshot | 2 | 5 ms | 3.4 ms |
| today-big-fetch | Count: Today's list drawn | 122 | 0 ms | 0.2 ms |
| today-big-fetch | Count: a Today row drawn | 2635 | 0 ms | 0.0 ms |
| tap-today | Widgets: one habit's week | 34 | 181 ms | 75.3 ms |
| tap-today | Widgets: the snapshot | 18 | 29 ms | 4.3 ms |
| tap-today | Reminders: plan every alert | 59 | 4 ms | 0.2 ms |
| tap-today | Change: Siri's habit names | 58 | 4 ms | 0.2 ms |
| tap-today | Count: Today's list drawn | 93 | 1 ms | 0.6 ms |
| tap-today | Count: the Day sheet drawn | 15 | 1 ms | 0.5 ms |
| tap-today | Count: a Today row drawn | 740 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's activity drawn | 15 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
