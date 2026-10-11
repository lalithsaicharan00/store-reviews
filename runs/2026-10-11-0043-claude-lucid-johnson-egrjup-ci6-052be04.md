# claude/lucid-johnson-egrjup-ci6 @ 052be04

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38098087675 · 2026-10-11 00:43 UTC
Commit: iCloud & Backup: one file picker in the stack; Import a Backup File opens Restore with its picker

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
| iCloud & Backup: scrolling | 0.0 | 0 ms | 0 | 2.0 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.6%  closure #1 in AppModel.ensureLoaded() |
| iCloud & Backup (synced): scrolling | 6.5 | 109 ms | 1 | 7.0 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| iCloud & Backup (waiting): scrolling | 0.0 | 0 ms | 0 | 7.0 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| iCloud & Backup (full): scrolling | 0.0 | 0 ms | 0 | 7.0 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| iCloud & Backup (off): scrolling | 0.0 | 0 ms | 0 | 7.0 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| iCloud & Backup (bringing): scrolling | 0.1 | 19 ms | 0 | 7.0 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| iCloud & Backup (free-other): scrolling | 0.9 | 30 ms | 0 | 7.0 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| iCloud & Backup (plus): scrolling | 0.0 | 0 ms | 0 | 7.0 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| iCloud & Backup (removed): scrolling | 0.0 | 0 ms | 0 | 7.0 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| iCloud & Backup (other-account): scrolling | 0.0 | 0 ms | 0 | 7.0 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| iCloud & Backup (held): scrolling | 0.0 | 0 ms | 0 | 7.0 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.1%  closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- iCloud & Backup (first): longest stall 742 ms
- iCloud & Backup (again): longest stall 220 ms
- iCloud & Backup → Restore From a Backup: longest stall 2509 ms
- iCloud & Backup (synced): longest stall 416 ms
- iCloud & Backup (waiting): longest stall 236 ms
- iCloud & Backup (full): longest stall 240 ms
- iCloud & Backup (off): longest stall 110 ms
- iCloud & Backup (bringing): longest stall 220 ms
- iCloud & Backup (free-other): longest stall 293 ms
- iCloud & Backup (plus): longest stall 174 ms
- iCloud & Backup (removed): longest stall 74 ms
- iCloud & Backup (other-account): longest stall 0 ms
- iCloud & Backup (held): longest stall 184 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| icloud-page | Widgets: one habit's week | 17 | 174 ms | 110.5 ms |
| icloud-page | Reminders: plan every alert | 1 | 2 ms | 2.1 ms |
| icloud-page | Widgets: the snapshot | 1 | 1 ms | 1.5 ms |
| icloud-page | Count: Today's list drawn | 14 | 1 ms | 0.8 ms |
| icloud-page | Count: a Today row drawn | 30 | 1 ms | 0.6 ms |
| icloud-states | Widgets: one habit's week | 17 | 88 ms | 52.7 ms |
| icloud-states | Widgets: the snapshot | 1 | 3 ms | 2.9 ms |
| icloud-states | Count: Today's list drawn | 43 | 0 ms | 0.0 ms |
| icloud-states | Count: a Today row drawn | 153 | 0 ms | 0.0 ms |
| icloud-states | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
