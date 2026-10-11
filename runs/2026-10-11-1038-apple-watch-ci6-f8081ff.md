# apple-watch-ci6 @ f8081ff

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38127623686 · 2026-10-11 10:38 UTC
Commit: Apple Watch: compile BackupFeatures for SHA256Hex, which iCloud's transport uses

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
| Today: scrolling | 0.0 | 0 ms | 0 | 3.4 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.6%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 and day ‹ › | 46.0 | 83 ms | 0 | 5.3 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.2%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 alone | 0.2 | 20 ms | 0 | 5.3 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.2%  closure #1 in AppModel.ensureLoaded() |
| Today: day ‹ › alone | 48.1 | 71 ms | 0 | 5.3 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.2%  closure #1 in AppModel.ensureLoaded() |
| Today: Day sheet scrolling | 0.0 | 0 ms | 0 | 5.3 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.2%  closure #1 in AppModel.ensureLoaded() |
| Timer screen: a running clock | 0.0 | 0 ms | 0 | 5.3 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.2%  closure #1 in AppModel.ensureLoaded() |
| Day sheet: entry list scrolling | 0.0 | 0 ms | 0 | 13.7 % (separate profile) | 1.7%  perfTimed<A>(_:_:)<br>1.7%  static MainThreadMeter.time<A>(_:_:)<br>1.5%  partial apply for closure #3 in HabitPageView.page(_:)<br>1.5%  HabitPageModel.load(_:tab:store:) |
| All logs: scrolling | 0.0 | 0 ms | 0 | 13.7 % (separate profile) | 1.7%  perfTimed<A>(_:_:)<br>1.7%  static MainThreadMeter.time<A>(_:_:)<br>1.5%  partial apply for closure #3 in HabitPageView.page(_:)<br>1.5%  HabitPageModel.load(_:tab:store:) |
| Entry editor: typing | 1.5 | 37 ms | 0 | 13.7 % (separate profile) | 1.7%  perfTimed<A>(_:_:)<br>1.7%  static MainThreadMeter.time<A>(_:_:)<br>1.5%  partial apply for closure #3 in HabitPageView.page(_:)<br>1.5%  HabitPageModel.load(_:tab:store:) |
| Day sheet: add, edit and exact undo | 174.5 | 96 ms | 0 | 13.7 % (separate profile) | 1.7%  perfTimed<A>(_:_:)<br>1.7%  static MainThreadMeter.time<A>(_:_:)<br>1.5%  partial apply for closure #3 in HabitPageView.page(_:)<br>1.5%  HabitPageModel.load(_:tab:store:) |
| Log sheet: typing | 4.1 | 30 ms | 0 | 7.0 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| All logs: scrolling | 0.0 | 0 ms | 0 | 7.0 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 1.5 | 21 ms | 0 | 7.0 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 217.4 | 97 ms | 0 | 7.0 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Routine player: ‹ › | 49.8 | 109 ms | 1 | 3.9 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.6%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Routine player: fast ‹ › | 30.4 | 74 ms | 0 | 3.9 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.6%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page: History scrolling | 4.1 | 69 ms | 0 | 6.1 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.4%  closure #1 in AppModel.ensureLoaded() |
| Habit page: Progress scrolling | 56.5 | 758 ms | 1 | 6.1 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.4%  closure #1 in AppModel.ensureLoaded() |
| Habit page: switching tabs | 20.3 | 68 ms | 0 | 6.1 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.4%  closure #1 in AppModel.ensureLoaded() |
| Progress: scrolling | 23.8 | 88 ms | 0 | 7.0 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.8%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Progress: period ‹ › and range | 99.5 | 113 ms | 2 | 7.0 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.8%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Progress: key fold and open | 0.5 | 25 ms | 0 | 7.0 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.8%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Widget: full publication, every habit's week | 0.0 | 0 ms | 0 | 4.4 % (separate profile) | 2.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.9%  WidgetPublisher.publish(_:hold:immediate:)<br>1.9%  WidgetPublisher.publishNow(_:hold:immediate:) |
| iCloud & Backup: scrolling | 0.0 | 0 ms | 0 | 3.0 % (separate profile) | 0.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.2%  closure #1 in AppModel.ensureLoaded() |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
