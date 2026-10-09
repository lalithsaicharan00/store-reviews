# app-lock-privacy-security-perf @ 5c4c2c8

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37995172857 · 2026-10-09 22:45 UTC
Commit: Current Work 58.13: the SE test's App Lock row has its own name (it hid the test's row helper)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (none): skipped
- Speed tests: cancelled
- Speed tests through XCTest: skipped

## Release build
```
** BUILD SUCCEEDED **
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Today: scrolling | 39.9 | 150 ms | 1 | 1.6 % (separate profile) | 0.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.2%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 and day ‹ › | 147.7 | 125 ms | 3 |  | (none above noise) |
| Today: +1 alone | 4.3 | 58 ms | 0 |  | (none above noise) |
| Today: day ‹ › alone | 137.4 | 122 ms | 3 |  | (none above noise) |
| Today: Day sheet scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Timer screen: a running clock | 20.4 | 99 ms | 0 |  | (none above noise) |
| Today: group filter | 63.3 | 70 ms | 0 |  | (none above noise) |
| Arrange Your Day: scrolling | 21.3 | 63 ms | 0 |  | (none above noise) |
| Arrange Your Day: move Anytime and sort | 27.6 | 63 ms | 0 |  | (none above noise) |
| Today: hide completed on and off | 90.4 | 118 ms | 3 |  | (none above noise) |
| Menu: open and close | 126.5 | 173 ms | 13 |  | (none above noise) |
| All Habits: scrolling | 19.0 | 89 ms | 0 |  | (none above noise) |
| Habit page: History scrolling | 15.9 | 122 ms | 1 |  | (none above noise) |
| Habit page: Progress scrolling | 34.9 | 166 ms | 2 |  | (none above noise) |
| Habit page: switching tabs | 53.3 | 100 ms | 1 |  | (none above noise) |
| Habit page (weekly total): History scrolling | 12.7 | 34 ms | 0 |  | (none above noise) |
| Habit page (weekly total): Progress scrolling | 2.5 | 29 ms | 0 |  | (none above noise) |
| Habit page (quit): History scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Habit page (quit): Progress scrolling | 6.4 | 33 ms | 0 |  | (none above noise) |
| Progress: scrolling | 35.8 | 52 ms | 0 |  | (none above noise) |
| Progress: period ‹ › and range | 215.3 | 225 ms | 17 |  | (none above noise) |
| Progress: key fold and open | 3.5 | 71 ms | 0 |  | (none above noise) |
| Progress Year: sideways | 1.0 | 31 ms | 0 |  | (none above noise) |
| Progress Year: scrolling | 39.1 | 94 ms | 0 |  | (none above noise) |
| Calendar: month ‹ › | 17.3 | 46 ms | 0 |  | (none above noise) |
| Habit form: typing | 40.5 | 80 ms | 0 | 2.7 % (separate profile) | 0.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.2%  closure #1 in AppModel.ensureLoaded() |
| Routine player: ‹ › | 60.0 | 76 ms | 0 |  | (none above noise) |
| Routine player: fast ‹ › | 60.1 | 122 ms | 2 |  | (none above noise) |
| Day sheet: entry list scrolling | 0.0 | 0 ms | 0 | 11.7 % (separate profile) | 2.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.0%  static PerfDriver.run(_:store:)<br>2.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:) |
| All logs: scrolling | 0.0 | 0 ms | 0 | 11.7 % (separate profile) | 2.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.0%  static PerfDriver.run(_:store:)<br>2.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 3.4 | 25 ms | 0 | 11.7 % (separate profile) | 2.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.0%  static PerfDriver.run(_:store:)<br>2.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 344.2 | 132 ms | 11 | 11.7 % (separate profile) | 2.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.0%  static PerfDriver.run(_:store:)<br>2.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:) |
| Log sheet: typing | 8.8 | 46 ms | 0 | 15.3 % (separate profile) | 1.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.5%  static PerfDriver.run(_:store:)<br>1.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:) |
| All logs: scrolling | 0.0 | 0 ms | 0 | 15.3 % (separate profile) | 1.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.5%  static PerfDriver.run(_:store:)<br>1.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 1.8 | 22 ms | 0 | 15.3 % (separate profile) | 1.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.5%  static PerfDriver.run(_:store:)<br>1.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 357.6 | 139 ms | 10 | 15.3 % (separate profile) | 1.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.5%  static PerfDriver.run(_:store:)<br>1.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:) |
| Add screen (Water): typing | 2.9 | 24 ms | 0 |  | (none above noise) |
| Add screen (Read): typing | 39.8 | 64 ms | 0 |  | (none above noise) |
| Add note: typing | 3.0 | 30 ms | 0 | 2.3 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.4%  closure #1 in AppModel.ensureLoaded() |
| Edit note: typing | 12.4 | 112 ms | 1 | 2.3 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.4%  closure #1 in AppModel.ensureLoaded() |
| Control: typing in a bare number field | 0.2 | 18 ms | 0 |  | (none above noise) |
| Widgets guide: scrolling | 15.7 | 52 ms | 0 |  | (none above noise) |
| Widget: durable amount log and publication | 4.8 | 58 ms | 0 |  | (none above noise) |
| Widget: full publication, every habit's week | 0.0 | 0 ms | 0 |  | (none above noise) |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
