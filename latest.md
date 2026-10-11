# apple-watch-ci6 @ f8081ff

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38132905623 · 2026-10-11 13:43 UTC
Commit: Apple Watch: compile BackupFeatures for SHA256Hex, which iCloud's transport uses

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
| Today: scrolling | 24.4 | 314 ms | 1 | 2.5 % (separate profile) | 0.6%  TodayView.observedNavigation.getter<br>0.6%  closure #1 in TodayView.navigation.getter<br>0.4%  closure #1 in closure #1 in TodayView.navigation.getter<br>0.3%  TodayView.content(now:) |
| Today: +1 and day ‹ › | 82.8 | 93 ms | 0 | 9.3 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.6%  closure #1 in HabitStore.queueEntryChange() |
| Today: +1 alone | 1.2 | 34 ms | 0 | 9.3 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.6%  closure #1 in HabitStore.queueEntryChange() |
| Today: day ‹ › alone | 65.3 | 75 ms | 0 | 9.3 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.6%  closure #1 in HabitStore.queueEntryChange() |
| Today: Day sheet scrolling | 0.0 | 0 ms | 0 | 9.3 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.6%  closure #1 in HabitStore.queueEntryChange() |
| Timer screen: a running clock | 26.8 | 232 ms | 2 | 9.3 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.6%  closure #1 in HabitStore.queueEntryChange() |
| Day sheet: entry list scrolling | 0.0 | 0 ms | 0 | 9.2 % (separate profile) | 1.1%  perfTimed<A>(_:_:)<br>1.1%  static MainThreadMeter.time<A>(_:_:)<br>1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A) |
| All logs: scrolling | 0.0 | 0 ms | 0 | 9.2 % (separate profile) | 1.1%  perfTimed<A>(_:_:)<br>1.1%  static MainThreadMeter.time<A>(_:_:)<br>1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A) |
| Entry editor: typing | 0.0 | 0 ms | 0 | 9.2 % (separate profile) | 1.1%  perfTimed<A>(_:_:)<br>1.1%  static MainThreadMeter.time<A>(_:_:)<br>1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A) |
| Day sheet: add, edit and exact undo | 118.2 | 91 ms | 0 | 9.2 % (separate profile) | 1.1%  perfTimed<A>(_:_:)<br>1.1%  static MainThreadMeter.time<A>(_:_:)<br>1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A) |
| Log sheet: typing | 0.4 | 20 ms | 0 | 12.0 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| All logs: scrolling | 0.0 | 0 ms | 0 | 12.0 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 1.2 | 27 ms | 0 | 12.0 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 284.5 | 109 ms | 4 | 12.0 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Widget: full publication, every habit's week | 0.0 | 0 ms | 0 | 4.8 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  WidgetPublisher.publish(_:hold:immediate:)<br>1.3%  WidgetPublisher.publishNow(_:hold:immediate:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Today: a row's Day sheet (first): longest stall 648 ms
- Today: a row's Day sheet (again): longest stall 298 ms
- Today: the note sheet: longest stall 2132 ms
- Today: the timer screen: longest stall 1540 ms
- All Habits: longest stall 428 ms
- Habit page: longest stall 1630 ms
- Day sheet (first): longest stall 902 ms
- Day sheet (again): longest stall 350 ms
- All logs: longest stall 160 ms
- Day sheet (for a log): longest stall 233 ms
- Entry editor: longest stall 154 ms
- Edit log (keyboard): longest stall 1115 ms
- Save entry: longest stall 214 ms
- All Habits: longest stall 397 ms
- Habit page: longest stall 411 ms
- Day sheet (first): longest stall 328 ms
- Day sheet (again): longest stall 306 ms
- Log sheet: longest stall 718 ms
- Log keyboard dismissal: longest stall 204 ms
- All logs: longest stall 245 ms
- Day sheet (for a log): longest stall 388 ms
- Entry editor: longest stall 281 ms
- Edit log (keyboard): longest stall 437 ms
- Save entry: longest stall 210 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| scroll-today | Store load: read the database | 2 | 1066 ms | 649.8 ms |
| scroll-today | Widgets: one habit's week | 17 | 141 ms | 74.1 ms |
| scroll-today | Store load: into the app (5592 logs) | 1 | 82 ms | 82.2 ms |
| scroll-today | Widgets: the snapshot | 1 | 4 ms | 4.0 ms |
| scroll-today | Store load: into the app (0 logs) | 1 | 4 ms | 3.6 ms |
| scroll-today | Reminders: plan every alert | 1 | 1 ms | 1.3 ms |
| scroll-today | Count: Today's list drawn | 7 | 1 ms | 0.6 ms |
| scroll-today | Count: a Today row drawn | 12 | 0 ms | 0.0 ms |
| tap-today | Store load: read the database | 2 | 1678 ms | 1464.4 ms |
| tap-today | Widgets: one habit's week | 34 | 164 ms | 68.8 ms |
| tap-today | Store load: into the app (5592 logs) | 1 | 56 ms | 56.4 ms |
| tap-today | Widgets: the snapshot | 18 | 28 ms | 4.4 ms |
| tap-today | Reminders: plan every alert | 58 | 7 ms | 2.2 ms |
| tap-today | Change: Siri's habit names | 57 | 5 ms | 0.4 ms |
| tap-today | Count: Today's list drawn | 95 | 1 ms | 1.1 ms |
| tap-today | Store load: into the app (0 logs) | 1 | 1 ms | 0.9 ms |
| tap-today | Count: a Today row drawn | 616 | 0 ms | 0.3 ms |
| tap-today | Count: the Day sheet drawn | 16 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's activity drawn | 16 | 0 ms | 0.0 ms |
| day-sheet | Habit page: history | 145 | 684 ms | 29.3 ms |
| day-sheet | Store load: read the database | 2 | 407 ms | 362.6 ms |
| day-sheet | Widgets: one habit's week | 18 | 105 ms | 57.8 ms |
| day-sheet | Store load: into the app (5592 logs) | 1 | 42 ms | 42.2 ms |
| day-sheet | Change: Siri's habit names | 144 | 11 ms | 0.8 ms |
| day-sheet | Widgets: the snapshot | 2 | 5 ms | 3.7 ms |
| day-sheet | Store load: into the app (0 logs) | 1 | 1 ms | 0.7 ms |
| day-sheet | Reminders: plan every alert | 2 | 0 ms | 0.1 ms |
| day-sheet | Count: Today's list drawn | 9 | 0 ms | 0.1 ms |
| day-sheet | Count: the Day sheet drawn | 158 | 0 ms | 0.0 ms |
| day-sheet | Entry editor: whole editor drawn | 188 | 0 ms | 0.0 ms |
| day-sheet | Count: a Today row drawn | 174 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet's activity drawn | 207 | 0 ms | 0.0 ms |
| log-sheet | Habit page: history | 145 | 953 ms | 13.9 ms |
| log-sheet | Store load: read the database | 2 | 515 ms | 467.0 ms |
| log-sheet | Widgets: one habit's week | 18 | 104 ms | 58.0 ms |
| log-sheet | Store load: into the app (5592 logs) | 1 | 58 ms | 57.8 ms |
| log-sheet | Change: Siri's habit names | 144 | 13 ms | 0.9 ms |
| log-sheet | Widgets: the snapshot | 2 | 9 ms | 7.5 ms |
| log-sheet | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| log-sheet | Reminders: plan every alert | 2 | 0 ms | 0.2 ms |
| log-sheet | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| log-sheet | Count: the Day sheet's activity drawn | 218 | 0 ms | 0.0 ms |
| log-sheet | Count: a Today row drawn | 174 | 0 ms | 0.0 ms |
| log-sheet | Count: the Day sheet drawn | 170 | 0 ms | 0.0 ms |
| log-sheet | Entry editor: whole editor drawn | 199 | 0 ms | 0.0 ms |
| widget-publish | Widgets: one habit's week | 408 | 568 ms | 45.3 ms |
| widget-publish | Store load: read the database | 2 | 439 ms | 373.0 ms |
| widget-publish | Store load: into the app (5592 logs) | 1 | 67 ms | 66.5 ms |
| widget-publish | Widgets: the snapshot | 24 | 27 ms | 3.1 ms |
| widget-publish | Store load: into the app (0 logs) | 1 | 1 ms | 1.0 ms |
| widget-publish | Reminders: plan every alert | 1 | 0 ms | 0.3 ms |
| widget-publish | Count: Today's list drawn | 7 | 0 ms | 0.0 ms |
| widget-publish | Count: a Today row drawn | 12 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
