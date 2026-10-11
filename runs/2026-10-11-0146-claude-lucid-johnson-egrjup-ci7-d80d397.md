# claude/lucid-johnson-egrjup-ci7 @ d80d397

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38099892738 · 2026-10-11 01:46 UTC
Commit: Widgets faster: week and month totals from the per-day index; the widget lock opened for speed work; App Lock's SE test scrolls to App Passcode

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
| Today: scrolling during a big iCloud fetch | 0.0 | 0 ms | 0 | 5.0 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Today: +1 during a big iCloud fetch | 17.6 | 283 ms | 1 | 5.0 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Today: +1 and day ‹ › | 80.2 | 134 ms | 1 | 14.1 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  perfTimed<A>(_:_:)<br>0.4%  static MainThreadMeter.time<A>(_:_:) |
| Today: +1 alone | 0.9 | 25 ms | 0 | 14.1 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  perfTimed<A>(_:_:)<br>0.4%  static MainThreadMeter.time<A>(_:_:) |
| Today: day ‹ › alone | 76.6 | 120 ms | 1 | 14.1 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  perfTimed<A>(_:_:)<br>0.4%  static MainThreadMeter.time<A>(_:_:) |
| Today: Day sheet scrolling | 0.0 | 0 ms | 0 | 14.1 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  perfTimed<A>(_:_:)<br>0.4%  static MainThreadMeter.time<A>(_:_:) |
| Timer screen: a running clock | 4.5 | 77 ms | 0 | 14.1 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  perfTimed<A>(_:_:)<br>0.4%  static MainThreadMeter.time<A>(_:_:) |
| Widget: durable amount log and publication | 0.8 | 24 ms | 0 | 6.5 % (separate profile) | 0.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  WidgetPublisher.publish(_:hold:immediate:)<br>0.8%  WidgetPublisher.publishNow(_:hold:immediate:) |
| Today: scrolling | 0.0 | 0 ms | 0 | 4.5 % (separate profile) | 0.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Today: a row's Day sheet (first): longest stall 886 ms
- Today: a row's Day sheet (again): longest stall 470 ms
- Today: the note sheet: longest stall 4574 ms
- Today: the timer screen: longest stall 0 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| today-big-fetch | Widgets: one habit's week | 102 | 247 ms | 47.0 ms |
| today-big-fetch | Widgets: the snapshot | 6 | 9 ms | 2.6 ms |
| today-big-fetch | Change: Siri's habit names | 52 | 5 ms | 1.3 ms |
| today-big-fetch | Reminders: plan every alert | 13 | 2 ms | 0.4 ms |
| today-big-fetch | Count: a Today row drawn | 204 | 0 ms | 0.0 ms |
| today-big-fetch | Count: Today's list drawn | 17 | 0 ms | 0.1 ms |
| tap-today | Widgets: one habit's week | 34 | 221 ms | 81.0 ms |
| tap-today | Widgets: the snapshot | 18 | 34 ms | 6.5 ms |
| tap-today | Reminders: plan every alert | 59 | 5 ms | 0.3 ms |
| tap-today | Change: Siri's habit names | 58 | 5 ms | 0.2 ms |
| tap-today | Count: Today's list drawn | 93 | 1 ms | 0.7 ms |
| tap-today | Count: the Day sheet drawn | 10 | 1 ms | 0.8 ms |
| tap-today | Count: a Today row drawn | 395 | 0 ms | 0.3 ms |
| tap-today | Count: the Day sheet's activity drawn | 10 | 0 ms | 0.0 ms |
| widget-log | Widgets: one habit's week | 55 | 137 ms | 40.6 ms |
| widget-log | Widgets: the snapshot | 39 | 41 ms | 6.7 ms |
| widget-log | Change: Siri's habit names | 82 | 7 ms | 1.2 ms |
| widget-log | Reminders: plan every alert | 75 | 6 ms | 1.5 ms |
| widget-log | Count: Today's list drawn | 7 | 0 ms | 0.1 ms |
| widget-log | Count: a Today row drawn | 231 | 0 ms | 0.0 ms |
| scroll-today | Widgets: one habit's week | 17 | 117 ms | 65.5 ms |
| scroll-today | Widgets: the snapshot | 1 | 1 ms | 0.9 ms |
| scroll-today | Count: a Today row drawn | 6 | 1 ms | 0.5 ms |
| scroll-today | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| scroll-today | Count: Today's list drawn | 7 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
