# week-goal-button-squares-key @ a3d33bf

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37456070731 · 2026-10-06 11:52 UTC
Commit: TodayRowSheetUITests: a week count's Day sheet offers Add a check, not Mark done (Current Work 54; found by run 37432849062, 44 of 45 passed)

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
| Today: scrolling | 0.0 | 0 ms | 0 | 0.3 % (separate profile) | 0.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  closure #1 in AppModel.ensureLoaded()<br>0.1%  partial apply for closure #1 in AppModel.ensureLoaded() |
| Today: +1 and day ‹ › | 87.8 | 111 ms | 1 | 4.2 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 alone | 0.9 | 30 ms | 0 | 4.2 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| Today: day ‹ › alone | 63.4 | 92 ms | 0 | 4.2 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| Today: Day sheet scrolling | 24.7 | 204 ms | 1 | 4.2 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| Timer screen: a running clock | 67.2 | 792 ms | 2 | 4.2 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| Progress: scrolling | 4.8 | 46 ms | 0 | 3.6 % (separate profile) | 0.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| Progress: period ‹ › and range | 141.7 | 183 ms | 7 | 3.6 % (separate profile) | 0.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| Progress: key fold and open | 1.6 | 41 ms | 0 | 3.6 % (separate profile) | 0.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| Menu: open and close | 76.9 | 262 ms | 6 | 10.6 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.7%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Control: typing in a bare number field | 0.4 | 19 ms | 0 | 5.2 % (separate profile) | 2.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>2.5%  closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Today: a row's Day sheet (first): longest stall 864 ms
- Today: a row's Day sheet (again): longest stall 306 ms
- Today: the note sheet: longest stall 3915 ms
- Today: the timer screen: longest stall 74 ms
- Progress (first): longest stall 2029 ms
- Progress (again): longest stall 204 ms
- Typing control: longest stall 1209 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| scroll-today | Widgets: one habit's month | 17 | 123 ms | 55.4 ms |
| scroll-today | Widgets: the snapshot | 1 | 1 ms | 1.0 ms |
| scroll-today | Count: Today's list drawn | 7 | 1 ms | 0.7 ms |
| scroll-today | Reminders: plan every alert | 1 | 1 ms | 0.6 ms |
| scroll-today | Count: a Today row drawn | 18 | 0 ms | 0.0 ms |
| tap-today | Widgets: one habit's month | 19 | 203 ms | 92.8 ms |
| tap-today | Reminders: plan every alert | 58 | 5 ms | 0.9 ms |
| tap-today | Widgets: the snapshot | 3 | 3 ms | 2.0 ms |
| tap-today | Change: Siri's habit names | 58 | 3 ms | 0.2 ms |
| tap-today | Count: Today's list drawn | 95 | 0 ms | 0.0 ms |
| tap-today | Count: a Today row drawn | 419 | 0 ms | 0.1 ms |
| tap-today | Count: the Day sheet drawn | 6 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's activity drawn | 6 | 0 ms | 0.0 ms |
| progress | Widgets: one habit's month | 17 | 123 ms | 67.8 ms |
| progress | Progress year: whole snapshot | 2 | 43 ms | 27.0 ms |
| progress | Progress year: cards | 2 | 43 ms | 26.9 ms |
| progress | Progress year: one card | 30 | 40 ms | 5.1 ms |
| progress | Progress week: whole snapshot | 2 | 16 ms | 13.5 ms |
| progress | Progress week: cards | 2 | 15 ms | 12.5 ms |
| progress | Progress week: one card | 30 | 11 ms | 8.8 ms |
| progress | Progress month: whole snapshot | 2 | 5 ms | 3.0 ms |
| progress | Progress month: cards | 2 | 5 ms | 2.9 ms |
| progress | Progress month: one card | 30 | 4 ms | 0.3 ms |
| progress | Progress week: one quit card | 4 | 3 ms | 1.6 ms |
| progress | Widgets: the snapshot | 1 | 1 ms | 1.1 ms |
| progress | Reminders: plan every alert | 1 | 1 ms | 1.1 ms |
| progress | Progress year: one quit card | 2 | 0 ms | 0.3 ms |
| progress | Progress month: one quit card | 4 | 0 ms | 0.1 ms |
| progress | Count: Today's list drawn | 35 | 0 ms | 0.1 ms |
| progress | Count: a Today row drawn | 177 | 0 ms | 0.0 ms |
| menu | Widgets: one habit's month | 17 | 90 ms | 42.8 ms |
| menu | Widgets: the snapshot | 1 | 1 ms | 0.8 ms |
| menu | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| menu | Count: Today's list drawn | 6 | 0 ms | 0.0 ms |
| menu | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| typing-control | Widgets: one habit's month | 17 | 135 ms | 65.1 ms |
| typing-control | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| typing-control | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| typing-control | Count: Today's list drawn | 10 | 0 ms | 0.0 ms |
| typing-control | Count: a Today row drawn | 30 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
