# claude/pensive-gates-3n4ie8-ci12 @ e67883a

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38177733182 · 2026-10-11 22:13 UTC
Commit: Merge main (the Apple Watch app, Google Drive sync in the core, docs) into the iPad build

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
| Day sheet: entry list scrolling | 0.0 | 0 ms | 0 | 12.2 % (separate profile) | 1.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| All logs: scrolling | 0.0 | 0 ms | 0 | 12.2 % (separate profile) | 1.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 32.9 | 390 ms | 1 | 12.2 % (separate profile) | 1.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 332.2 | 255 ms | 8 | 12.2 % (separate profile) | 1.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Today: scrolling | 22.8 | 128 ms | 2 | 3.7 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  partial apply for closure #1 in AppModel.ensureLoaded()<br>1.0%  closure #1 in AppModel.ensureLoaded() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- All Habits: longest stall 904 ms
- Habit page: longest stall 14298 ms
- Day sheet (first): longest stall 0 ms
- Day sheet (again): longest stall 276 ms
- All logs: longest stall 183 ms
- Day sheet (for a log): longest stall 346 ms
- Entry editor: longest stall 188 ms
- Edit log (keyboard): longest stall 2642 ms
- Save entry: longest stall 335 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| day-sheet | Store load: read the database | 2 | 1013 ms | 741.4 ms |
| day-sheet | Habit page: history | 136 | 964 ms | 34.4 ms |
| day-sheet | Widgets: one habit's week | 18 | 506 ms | 196.4 ms |
| day-sheet | Store load: into the app (5592 logs) | 1 | 62 ms | 61.5 ms |
| day-sheet | Change: Siri's habit names | 135 | 13 ms | 0.6 ms |
| day-sheet | Widgets: the snapshot | 2 | 6 ms | 3.2 ms |
| day-sheet | Store load: into the app (0 logs) | 1 | 3 ms | 3.0 ms |
| day-sheet | Reminders: plan every alert | 7 | 1 ms | 0.8 ms |
| day-sheet | Count: Today's list drawn | 9 | 1 ms | 0.9 ms |
| day-sheet | Count: the Day sheet drawn | 155 | 1 ms | 0.5 ms |
| day-sheet | Entry editor: whole editor drawn | 185 | 1 ms | 0.6 ms |
| day-sheet | Count: the Day sheet's activity drawn | 200 | 0 ms | 0.0 ms |
| day-sheet | Count: a Today row drawn | 174 | 0 ms | 0.0 ms |
| scroll-today | Store load: read the database | 2 | 782 ms | 715.5 ms |
| scroll-today | Widgets: one habit's week | 17 | 110 ms | 63.8 ms |
| scroll-today | Store load: into the app (5592 logs) | 1 | 66 ms | 66.1 ms |
| scroll-today | Widgets: the snapshot | 1 | 1 ms | 1.2 ms |
| scroll-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| scroll-today | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| scroll-today | Count: Today's list drawn | 10 | 0 ms | 0.0 ms |
| scroll-today | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
