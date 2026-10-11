# claude/pensive-gates-3n4ie8-ci12 @ e67883a

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38174892496 · 2026-10-11 21:44 UTC
Commit: Merge main (the Apple Watch app, Google Drive sync in the core, docs) into the iPad build

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
| day-sheet,scroll-today | not measured (unknown scenario day-sheet,scroll-today) | | | | |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):


Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| day-sheet,scroll-today | Store load: read the database | 2 | 1085 ms | 643.7 ms |
| day-sheet,scroll-today | Widgets: one habit's week | 17 | 131 ms | 63.3 ms |
| day-sheet,scroll-today | Store load: into the app (5592 logs) | 1 | 53 ms | 52.7 ms |
| day-sheet,scroll-today | Store load: into the app (0 logs) | 1 | 3 ms | 2.9 ms |
| day-sheet,scroll-today | Widgets: the snapshot | 1 | 2 ms | 2.4 ms |
| day-sheet,scroll-today | Count: Today's list drawn | 8 | 0 ms | 0.4 ms |
| day-sheet,scroll-today | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| day-sheet,scroll-today | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
