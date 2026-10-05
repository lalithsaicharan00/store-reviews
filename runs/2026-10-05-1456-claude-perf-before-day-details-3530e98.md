# claude/perf-before-day-details @ 3530e98

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37324688193 · 2026-10-05 14:56 UTC
Commit: Checklists: limits under Quit or Cut Down (14) and Notes month cards (46) tested and completed; 18, 25, 26, 28 await round 4

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
| Today: scrolling | 18.2 | 157 ms | 2 | 0.7 % (separate profile) | 0.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.2%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 and day ‹ › | 76.7 | 272 ms | 1 | 9.4 % (separate profile) | 0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.4%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 alone | 4.4 | 38 ms | 0 | 9.4 % (separate profile) | 0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.4%  closure #1 in AppModel.ensureLoaded() |
| Today: day ‹ › alone | 119.3 | 200 ms | 1 | 9.4 % (separate profile) | 0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.4%  closure #1 in AppModel.ensureLoaded() |
| Today: Day sheet scrolling | 35.5 | 79 ms | 0 | 9.4 % (separate profile) | 0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.4%  closure #1 in AppModel.ensureLoaded() |
| Timer screen: a running clock | 1.4 | 34 ms | 0 | 9.4 % (separate profile) | 0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.4%  closure #1 in AppModel.ensureLoaded() |
| Habit form: typing | 32.1 | 118 ms | 1 | 3.1 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.0%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Progress: scrolling | 8.8 | 39 ms | 0 | 13.6 % (separate profile) | 1.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  AppModel.shared.unsafeMutableAddressor<br>1.1%  one-time initialization function for shared |
| Progress: period ‹ › and range | 162.9 | 186 ms | 9 | 13.6 % (separate profile) | 1.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  AppModel.shared.unsafeMutableAddressor<br>1.1%  one-time initialization function for shared |
| Progress: key fold and open | 0.0 | 0 ms | 0 | 13.6 % (separate profile) | 1.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  AppModel.shared.unsafeMutableAddressor<br>1.1%  one-time initialization function for shared |
| Menu: open and close | 75.3 | 328 ms | 3 | 5.3 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.4%  closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Today: a row's Day sheet (first): longest stall 1472 ms
- Today: a row's Day sheet (again): longest stall 661 ms
- Today: the note sheet: longest stall 1069 ms
- Today: the timer screen: longest stall 0 ms
- New Habit (first): longest stall 748 ms
- New Habit (again): longest stall 278 ms
- Habit form (first): longest stall 1524 ms
- Habit form (again): longest stall 676 ms
- Progress (first): longest stall 2781 ms
- Progress (again): longest stall 222 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| scroll-today | Widgets: one habit's month | 17 | 116 ms | 53.1 ms |
| scroll-today | Widgets: the snapshot | 1 | 1 ms | 0.7 ms |
| scroll-today | Count: Today's list drawn | 6 | 1 ms | 0.5 ms |
| scroll-today | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| scroll-today | Count: a Today row drawn | 30 | 0 ms | 0.0 ms |
| tap-today | Widgets: one habit's month | 19 | 163 ms | 78.2 ms |
| tap-today | Reminders: plan every alert | 58 | 5 ms | 1.2 ms |
| tap-today | Widgets: the snapshot | 3 | 5 ms | 3.1 ms |
| tap-today | Change: Siri's habit names | 58 | 3 ms | 0.1 ms |
| tap-today | Count: Today's list drawn | 92 | 0 ms | 0.0 ms |
| tap-today | Count: a Today row drawn | 631 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet drawn | 14 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's entries drawn | 5 | 0 ms | 0.0 ms |
| new-habit | Widgets: one habit's month | 17 | 129 ms | 71.7 ms |
| new-habit | Widgets: the snapshot | 1 | 1 ms | 0.6 ms |
| new-habit | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| new-habit | Count: Today's list drawn | 14 | 0 ms | 0.0 ms |
| new-habit | Count: a Today row drawn | 128 | 0 ms | 0.0 ms |
| progress | Widgets: one habit's month | 17 | 94 ms | 55.3 ms |
| progress | Progress year: whole snapshot | 2 | 53 ms | 31.2 ms |
| progress | Progress year: cards | 2 | 52 ms | 31.0 ms |
| progress | Progress year: one card | 30 | 48 ms | 4.2 ms |
| progress | Progress week: whole snapshot | 2 | 16 ms | 12.9 ms |
| progress | Progress week: cards | 2 | 15 ms | 11.8 ms |
| progress | Progress week: one card | 30 | 10 ms | 6.9 ms |
| progress | Progress month: whole snapshot | 2 | 10 ms | 5.8 ms |
| progress | Progress month: cards | 2 | 9 ms | 5.6 ms |
| progress | Progress month: one card | 30 | 7 ms | 1.1 ms |
| progress | Progress week: one quit card | 4 | 3 ms | 2.3 ms |
| progress | Progress year: one quit card | 2 | 1 ms | 0.5 ms |
| progress | Widgets: the snapshot | 1 | 1 ms | 0.7 ms |
| progress | Count: Today's list drawn | 24 | 1 ms | 0.7 ms |
| progress | Progress month: one quit card | 4 | 0 ms | 0.2 ms |
| progress | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| progress | Count: a Today row drawn | 226 | 0 ms | 0.0 ms |
| menu | Widgets: one habit's month | 17 | 89 ms | 46.4 ms |
| menu | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| menu | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| menu | Count: Today's list drawn | 6 | 0 ms | 0.0 ms |
| menu | Count: a Today row drawn | 18 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
