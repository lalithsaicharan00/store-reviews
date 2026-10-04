# claude/habit-details-perf @ 70d556f

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37167906012 · 2026-10-04 01:37 UTC
Commit: Tests follow the row work: swipes drag a fixed distance (a name is too narrow for XCUITest's swipe), yesterday opens Anytime first, the task test uses the task fixture, GoalFlow types other amounts through the Day sheet, results read "3/3 times"; the delete question gets an explicit Cancel

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
| tap-today,day-sheet | Widgets: one habit's month | 17 | 114 ms | 50.4 ms |
| tap-today,day-sheet | Widgets: the snapshot | 1 | 1 ms | 1.1 ms |
| tap-today,day-sheet | Reminders: plan every alert | 1 | 0 ms | 0.4 ms |
| tap-today,day-sheet | Count: Today's list drawn | 6 | 0 ms | 0.0 ms |
| tap-today,day-sheet | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
