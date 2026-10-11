# claude/lucid-johnson-egrjup-main2 @ 47a939c

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38099545468 · 2026-10-11 01:09 UTC
Commit: Plus screens done: run numbers, branches safe to delete, and the build prompt folder deleted

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
| Backup & Export: scrolling | 0.0 | 0 ms | 0 | 100.0 % (separate profile) | 10.0%  TodayView.observedNavigation.getter<br>7.5%  __swift_instantiateConcreteTypeFromMangledNameAbstractV2<br>6.2%  closure #1 in TodayView.navigation.getter<br>6.2%  closure #1 in closure #1 in TodayView.navigation.getter |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Backup & Export (first): longest stall 1154 ms
- Backup & Export (again): longest stall 348 ms
- Backup & Export → Restore From a Backup: longest stall 298 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| backup-page | Widgets: one habit's week | 17 | 110 ms | 68.2 ms |
| backup-page | Widgets: the snapshot | 1 | 2 ms | 2.1 ms |
| backup-page | Reminders: plan every alert | 1 | 1 ms | 0.5 ms |
| backup-page | Count: Today's list drawn | 13 | 0 ms | 0.1 ms |
| backup-page | Count: a Today row drawn | 30 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
