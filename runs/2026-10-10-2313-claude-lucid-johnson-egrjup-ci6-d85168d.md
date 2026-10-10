# claude/lucid-johnson-egrjup-ci6 @ d85168d

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38092815203 · 2026-10-10 23:13 UTC
Commit: iCloud sync: a fetched record that carries no delete skips the brake's database read; fewer re-reads during a fetch

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
| Today: scrolling during a big iCloud fetch | 32.9 | 137 ms | 1 | 1.7 % (separate profile) | 0.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.2%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 during a big iCloud fetch | 66.9 | 996 ms | 1 | 1.7 % (separate profile) | 0.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.2%  closure #1 in AppModel.ensureLoaded() |
| iCloud & Backup: scrolling | 0.0 | 0 ms | 0 | 7.6 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.5%  closure #1 in AppModel.ensureLoaded() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- iCloud & Backup (first): longest stall 752 ms
- iCloud & Backup (again): longest stall 289 ms
- iCloud & Backup → Restore From a Backup: longest stall 259 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| today-big-fetch | Widgets: one habit's week | 85 | 1030 ms | 831.5 ms |
| today-big-fetch | Widgets: the snapshot | 5 | 11 ms | 7.8 ms |
| today-big-fetch | Change: Siri's habit names | 47 | 3 ms | 0.6 ms |
| today-big-fetch | Count: Today's list drawn | 14 | 1 ms | 0.6 ms |
| today-big-fetch | Reminders: plan every alert | 9 | 1 ms | 0.4 ms |
| today-big-fetch | Count: a Today row drawn | 245 | 0 ms | 0.0 ms |
| icloud-page | Widgets: one habit's week | 17 | 151 ms | 84.0 ms |
| icloud-page | Widgets: the snapshot | 1 | 2 ms | 2.4 ms |
| icloud-page | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| icloud-page | Count: Today's list drawn | 16 | 0 ms | 0.1 ms |
| icloud-page | Count: a Today row drawn | 74 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
