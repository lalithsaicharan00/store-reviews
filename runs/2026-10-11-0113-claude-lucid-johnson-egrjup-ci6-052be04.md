# claude/lucid-johnson-egrjup-ci6 @ 052be04

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38099547344 · 2026-10-11 01:13 UTC
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
| iCloud & Backup: scrolling | 0.0 | 0 ms | 0 | 1.7 % (separate profile) | 0.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- iCloud & Backup (first): longest stall 523 ms
- iCloud & Backup (again): longest stall 291 ms
- iCloud & Backup → Restore From a Backup: longest stall 190 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| icloud-page | Widgets: one habit's week | 17 | 149 ms | 104.4 ms |
| icloud-page | Widgets: the snapshot | 1 | 3 ms | 2.7 ms |
| icloud-page | Count: a Today row drawn | 27 | 2 ms | 1.6 ms |
| icloud-page | Reminders: plan every alert | 1 | 1 ms | 0.8 ms |
| icloud-page | Count: Today's list drawn | 13 | 0 ms | 0.1 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
