# claude/habit-details-perf-base @ 78a11e4

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37167907495 · 2026-10-04 01:51 UTC
Commit: Today's rows: a tap opens the Day sheet for the day shown; ✓ toggles that day's tick, + adds; swipes reveal Note/Skip/Pause and a named Undo; long press matches the sheet; Delete only in the sheet's ⋯ menu; done habits stay in place

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
| tap-today,day-sheet | not measured (unknown scenario tap-today,day-sheet) | | | | |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):


Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| tap-today,day-sheet | Widgets: one habit's month | 17 | 100 ms | 34.9 ms |
| tap-today,day-sheet | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| tap-today,day-sheet | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| tap-today,day-sheet | Count: Today's list drawn | 6 | 0 ms | 0.0 ms |
| tap-today,day-sheet | Count: a Today row drawn | 12 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
