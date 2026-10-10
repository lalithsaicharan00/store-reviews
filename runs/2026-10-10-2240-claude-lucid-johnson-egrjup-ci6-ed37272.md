# claude/lucid-johnson-egrjup-ci6 @ ed37272

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38089514195 · 2026-10-10 22:40 UTC
Commit: iCloud sync: during a fetch the screen re-reads every 5 s and once it ends; the speed run says how long the big fetch took

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
| Today: scrolling during a big iCloud fetch | 47.5 | 432 ms | 2 | 6.1 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  closure #1 in AppModel.ensureLoaded()<br>0.9%  partial apply for closure #1 in AppModel.ensureLoaded() |
| Today: +1 during a big iCloud fetch | 56.2 | 258 ms | 4 | 6.1 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  closure #1 in AppModel.ensureLoaded()<br>0.9%  partial apply for closure #1 in AppModel.ensureLoaded() |
| iCloud & Backup (synced): scrolling | 1.6 | 30 ms | 0 | 3.5 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| iCloud & Backup (waiting): scrolling | 0.3 | 22 ms | 0 | 3.5 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| iCloud & Backup (full): scrolling | 0.0 | 0 ms | 0 | 3.5 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| iCloud & Backup (off): scrolling | 0.0 | 0 ms | 0 | 3.5 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| iCloud & Backup (bringing): scrolling | 0.0 | 0 ms | 0 | 3.5 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| iCloud & Backup (free-other): scrolling | 6.3 | 44 ms | 0 | 3.5 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| iCloud & Backup (plus): scrolling | 21.1 | 99 ms | 0 | 3.5 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| iCloud & Backup (removed): scrolling | 0.0 | 0 ms | 0 | 3.5 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| iCloud & Backup (other-account): scrolling | 0.0 | 0 ms | 0 | 3.5 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| iCloud & Backup (held): scrolling | 0.0 | 0 ms | 0 | 3.5 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| Today: scrolling | 12.9 | 59 ms | 0 | 4.1 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- iCloud & Backup (synced): longest stall 849 ms
- iCloud & Backup (waiting): longest stall 361 ms
- iCloud & Backup (full): longest stall 193 ms
- iCloud & Backup (off): longest stall 263 ms
- iCloud & Backup (bringing): longest stall 360 ms
- iCloud & Backup (free-other): longest stall 269 ms
- iCloud & Backup (plus): longest stall 400 ms
- iCloud & Backup (removed): longest stall 17 ms
- iCloud & Backup (other-account): longest stall 402 ms
- iCloud & Backup (held): longest stall 292 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| today-big-fetch | Widgets: one habit's week | 85 | 375 ms | 137.3 ms |
| today-big-fetch | Change: Siri's habit names | 94 | 22 ms | 2.4 ms |
| today-big-fetch | Widgets: the snapshot | 5 | 15 ms | 5.7 ms |
| today-big-fetch | Reminders: plan every alert | 53 | 8 ms | 1.0 ms |
| today-big-fetch | Count: Today's list drawn | 48 | 1 ms | 0.6 ms |
| today-big-fetch | Count: a Today row drawn | 910 | 0 ms | 0.1 ms |
| icloud-states | Widgets: one habit's week | 17 | 113 ms | 64.7 ms |
| icloud-states | Widgets: the snapshot | 1 | 3 ms | 2.9 ms |
| icloud-states | Count: Today's list drawn | 48 | 2 ms | 1.5 ms |
| icloud-states | Reminders: plan every alert | 1 | 1 ms | 1.3 ms |
| icloud-states | Count: a Today row drawn | 452 | 0 ms | 0.0 ms |
| scroll-today | Widgets: one habit's week | 17 | 69 ms | 40.2 ms |
| scroll-today | Widgets: the snapshot | 1 | 1 ms | 1.3 ms |
| scroll-today | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| scroll-today | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| scroll-today | Count: a Today row drawn | 24 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
