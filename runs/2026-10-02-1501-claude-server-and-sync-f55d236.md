# claude/server-and-sync @ f55d236

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37020652987 · 2026-10-02 15:01 UTC
Commit: Speed runs: count how often Today's list, its rows, the Day sheet and its entries are drawn

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
| Day sheet: entry list scrolling | 5.3 | 58 ms | 0 | 10.3 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.6%  closure #1 in AppModel.ensureLoaded() |
| Entry editor: typing | 11.0 | 43 ms | 0 | 10.3 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.6%  closure #1 in AppModel.ensureLoaded() |
| Day sheet: add, edit and exact undo | 77.1 | 91 ms | 0 | 10.3 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.6%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 and day ‹ › | 120.2 | 260 ms | 3 | 2.7 % (separate profile) | 0.1%  perfTimed<A>(_:_:)<br>0.1%  static MainThreadMeter.time<A>(_:_:)<br>0.1%  specialized $defer #1 <A>() in static MainThreadMeter.time<A>(_:_:)<br>0.1%  TodayView.observedNavigation.getter |
| Today: +1 alone | 15.7 | 86 ms | 0 | 2.7 % (separate profile) | 0.1%  perfTimed<A>(_:_:)<br>0.1%  static MainThreadMeter.time<A>(_:_:)<br>0.1%  specialized $defer #1 <A>() in static MainThreadMeter.time<A>(_:_:)<br>0.1%  TodayView.observedNavigation.getter |
| Today: day ‹ › alone | 63.6 | 65 ms | 0 | 2.7 % (separate profile) | 0.1%  perfTimed<A>(_:_:)<br>0.1%  static MainThreadMeter.time<A>(_:_:)<br>0.1%  specialized $defer #1 <A>() in static MainThreadMeter.time<A>(_:_:)<br>0.1%  TodayView.observedNavigation.getter |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- All Habits: longest stall 646 ms
- Habit page: longest stall 515 ms
- Day sheet (first): longest stall 608 ms
- Day sheet (again): longest stall 312 ms
- Entry editor: longest stall 3109 ms
- Save entry: longest stall 574 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| day-sheet | Widgets: one habit's month | 17 | 115 ms | 66.3 ms |
| day-sheet | Change: Siri's habit names | 145 | 8 ms | 0.4 ms |
| day-sheet | Reminders: plan every alert | 3 | 2 ms | 1.1 ms |
| day-sheet | Widgets: the snapshot | 1 | 1 ms | 1.0 ms |
| day-sheet | Count: Today's list drawn | 9 | 1 ms | 0.6 ms |
| day-sheet | Entry editor: whole editor drawn | 8 | 0 ms | 0.0 ms |
| day-sheet | Count: a Today row drawn | 207 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet drawn | 4 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet's entries drawn | 54 | 0 ms | 0.0 ms |
| tap-today | Widgets: one habit's month | 18 | 166 ms | 88.5 ms |
| tap-today | Reminders: plan every alert | 56 | 4 ms | 0.2 ms |
| tap-today | Change: Siri's habit names | 56 | 3 ms | 0.2 ms |
| tap-today | Widgets: the snapshot | 2 | 2 ms | 0.9 ms |
| tap-today | Count: Today's list drawn | 78 | 0 ms | 0.1 ms |
| tap-today | Count: a Today row drawn | 539 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
