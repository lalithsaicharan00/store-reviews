# claude/pensive-gates-3n4ie8-main-ci @ 161c177

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38177812590 · 2026-10-11 22:10 UTC
Commit: Merging the Branches: claude/drive-sync merged; its test copies safe to delete

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
| Day sheet: entry list scrolling | 0.0 | 0 ms | 0 | 13.9 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.0%  closure #1 in static PerfDriver.startIfAsked(store:) |
| All logs: scrolling | 0.0 | 0 ms | 0 | 13.9 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.0%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 6.6 | 45 ms | 0 | 13.9 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.0%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 201.8 | 87 ms | 0 | 13.9 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.0%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Today: scrolling | 24.2 | 165 ms | 2 | 2.9 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.3%  closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- All Habits: longest stall 768 ms
- Habit page: longest stall 2541 ms
- Day sheet (first): longest stall 1013 ms
- Day sheet (again): longest stall 423 ms
- All logs: longest stall 251 ms
- Day sheet (for a log): longest stall 432 ms
- Entry editor: longest stall 230 ms
- Edit log (keyboard): longest stall 2854 ms
- Save entry: longest stall 246 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| day-sheet | Store load: read the database | 2 | 1270 ms | 967.8 ms |
| day-sheet | Habit page: history | 145 | 772 ms | 11.8 ms |
| day-sheet | Widgets: one habit's week | 18 | 135 ms | 60.8 ms |
| day-sheet | Store load: into the app (5592 logs) | 1 | 80 ms | 80.2 ms |
| day-sheet | Change: Siri's habit names | 144 | 13 ms | 1.2 ms |
| day-sheet | Store load: into the app (0 logs) | 1 | 10 ms | 10.2 ms |
| day-sheet | Widgets: the snapshot | 2 | 3 ms | 2.4 ms |
| day-sheet | Reminders: plan every alert | 2 | 2 ms | 1.4 ms |
| day-sheet | Count: Today's list drawn | 10 | 0 ms | 0.0 ms |
| day-sheet | Entry editor: whole editor drawn | 199 | 0 ms | 0.0 ms |
| day-sheet | Count: a Today row drawn | 191 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet drawn | 166 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet's activity drawn | 214 | 0 ms | 0.0 ms |
| scroll-today | Store load: read the database | 2 | 1101 ms | 1029.3 ms |
| scroll-today | Widgets: one habit's week | 17 | 88 ms | 50.0 ms |
| scroll-today | Store load: into the app (5592 logs) | 1 | 51 ms | 51.3 ms |
| scroll-today | Widgets: the snapshot | 1 | 2 ms | 1.6 ms |
| scroll-today | Store load: into the app (0 logs) | 1 | 1 ms | 0.8 ms |
| scroll-today | Count: Today's list drawn | 8 | 0 ms | 0.5 ms |
| scroll-today | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| scroll-today | Count: a Today row drawn | 24 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
