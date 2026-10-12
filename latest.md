# claude/shared-habit-rules-perf5 @ 0d56740

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38247037194 · 2026-10-12 13:48 UTC
Commit: Current Work 92 (checkpoint 2): time the shared rules' own work; the bisect lists timed work per variant; the profile names Kotlin's functions and its collector's pauses

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
| Day sheet: entry list scrolling | 0.0 | 0 ms | 0 | 13.0 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  perfTimed<A>(_:_:)<br>0.9%  static MainThreadMeter.time<A>(_:_:)<br>0.1%  kotlin-gc (main thread stopped for the Kotlin collector)<br>0.1%  kotlin kfun:app.habits.core.LiveRules#dayMark<br>0.1%  kotlin kfun:app.habits.rules.HabitRules#dayMark<br>0.1%  kotlin kfun:app.habits.rules.Zone#dayOf<br>0.1%  kotlin kfun:app.habits.rules.HabitRules#startDay<br>0.1%  kotlin kfun:app.habits.rules.HabitRules#isDue<br>0.1%  kotlin kfun:kotlinx.datetime#toLocalDateTime__at__kotlin.time.Instant<br>0.1%  kotlin kfun:app.habits.rules.HabitRules#dayProgress<br>0.1%  kotlin kfun:kotlinx.datetime.TimeZone#instantToLocalDateTime |
| All logs: scrolling | 0.0 | 0 ms | 0 | 13.0 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  perfTimed<A>(_:_:)<br>0.9%  static MainThreadMeter.time<A>(_:_:)<br>0.1%  kotlin-gc (main thread stopped for the Kotlin collector)<br>0.1%  kotlin kfun:app.habits.core.LiveRules#dayMark<br>0.1%  kotlin kfun:app.habits.rules.HabitRules#dayMark<br>0.1%  kotlin kfun:app.habits.rules.Zone#dayOf<br>0.1%  kotlin kfun:app.habits.rules.HabitRules#startDay<br>0.1%  kotlin kfun:app.habits.rules.HabitRules#isDue<br>0.1%  kotlin kfun:kotlinx.datetime#toLocalDateTime__at__kotlin.time.Instant<br>0.1%  kotlin kfun:app.habits.rules.HabitRules#dayProgress<br>0.1%  kotlin kfun:kotlinx.datetime.TimeZone#instantToLocalDateTime |
| Entry editor: typing | 9.0 | 70 ms | 0 | 13.0 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  perfTimed<A>(_:_:)<br>0.9%  static MainThreadMeter.time<A>(_:_:)<br>0.1%  kotlin-gc (main thread stopped for the Kotlin collector)<br>0.1%  kotlin kfun:app.habits.core.LiveRules#dayMark<br>0.1%  kotlin kfun:app.habits.rules.HabitRules#dayMark<br>0.1%  kotlin kfun:app.habits.rules.Zone#dayOf<br>0.1%  kotlin kfun:app.habits.rules.HabitRules#startDay<br>0.1%  kotlin kfun:app.habits.rules.HabitRules#isDue<br>0.1%  kotlin kfun:kotlinx.datetime#toLocalDateTime__at__kotlin.time.Instant<br>0.1%  kotlin kfun:app.habits.rules.HabitRules#dayProgress<br>0.1%  kotlin kfun:kotlinx.datetime.TimeZone#instantToLocalDateTime |
| Day sheet: add, edit and exact undo | 555.1 | 256 ms | 34 | 13.0 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  perfTimed<A>(_:_:)<br>0.9%  static MainThreadMeter.time<A>(_:_:)<br>0.1%  kotlin-gc (main thread stopped for the Kotlin collector)<br>0.1%  kotlin kfun:app.habits.core.LiveRules#dayMark<br>0.1%  kotlin kfun:app.habits.rules.HabitRules#dayMark<br>0.1%  kotlin kfun:app.habits.rules.Zone#dayOf<br>0.1%  kotlin kfun:app.habits.rules.HabitRules#startDay<br>0.1%  kotlin kfun:app.habits.rules.HabitRules#isDue<br>0.1%  kotlin kfun:kotlinx.datetime#toLocalDateTime__at__kotlin.time.Instant<br>0.1%  kotlin kfun:app.habits.rules.HabitRules#dayProgress<br>0.1%  kotlin kfun:kotlinx.datetime.TimeZone#instantToLocalDateTime |
| Widget: full publication, every habit's week | 0.7 | 28 ms | 0 | 3.5 % (separate profile) | 1.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.7%  WidgetPublisher.publish(_:hold:immediate:)<br>1.7%  WidgetPublisher.publishNow(_:hold:immediate:)<br>0.1%  kotlin-gc (main thread stopped for the Kotlin collector)<br>0.2%  kotlin kfun:app.habits.core.LiveRules#dayMark<br>0.2%  kotlin kfun:app.habits.rules.HabitRules#dayMark<br>0.2%  kotlin kfun:app.habits.rules.Zone#dayOf<br>0.2%  kotlin kfun:app.habits.rules.HabitRules#dayProgress$default<br>0.2%  kotlin kfun:app.habits.rules.HabitRules#isDayMet<br>0.2%  kotlin kfun:kotlin.collections.HashMap#get<br>0.1%  kotlin kfun:app.habits.rules.HabitRules#dayProgress<br>0.1%  kotlin kfun:app.habits.rules.HabitRules#startDay |
| Today: +1 and day ‹ › | 206.2 | 142 ms | 6 | 0.6 % (separate profile) | (none above noise) |
| Today: +1 alone | 67.0 | 117 ms | 1 | 0.6 % (separate profile) | (none above noise) |
| Today: day ‹ › alone | 78.7 | 89 ms | 0 | 0.6 % (separate profile) | (none above noise) |
| Today: Day sheet scrolling | 0.0 | 0 ms | 0 | 0.6 % (separate profile) | (none above noise) |
| Timer screen: a running clock | 0.0 | 0 ms | 0 | 0.6 % (separate profile) | (none above noise) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- All Habits: longest stall 547 ms
- Habit page: longest stall 2824 ms
- Day sheet (first): longest stall 0 ms
- Day sheet (again): longest stall 342 ms
- All logs: longest stall 204 ms
- Day sheet (for a log): longest stall 313 ms
- Entry editor: longest stall 185 ms
- Edit log (keyboard): longest stall 4312 ms
- Save entry: longest stall 202 ms
- Today: a row's Day sheet (first): longest stall 707 ms
- Today: a row's Day sheet (again): longest stall 322 ms
- Today: the note sheet: longest stall 2709 ms
- Today: the timer screen: longest stall 182 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| day-sheet | Habit page: history | 142 | 2560 ms | 102.5 ms |
| day-sheet | Store load: read the database | 2 | 1139 ms | 1005.8 ms |
| day-sheet | Widgets: one habit's week | 18 | 190 ms | 95.4 ms |
| day-sheet | Shared rules: built from every log | 4 | 76 ms | 49.5 ms |
| day-sheet | Store load: into the app (5593 logs) | 1 | 70 ms | 70.1 ms |
| day-sheet | Change: Siri's habit names | 141 | 13 ms | 0.5 ms |
| day-sheet | Shared rules: habits and settings again | 5 | 6 ms | 3.2 ms |
| day-sheet | Shared rules: a log changed | 47 | 6 ms | 0.4 ms |
| day-sheet | Shared rules: a log added | 47 | 5 ms | 1.6 ms |
| day-sheet | Shared rules: a log removed | 47 | 5 ms | 0.4 ms |
| day-sheet | Widgets: the snapshot | 2 | 4 ms | 3.1 ms |
| day-sheet | Store load: into the app (0 logs) | 1 | 2 ms | 2.1 ms |
| day-sheet | Reminders: plan every alert | 2 | 2 ms | 1.0 ms |
| day-sheet | Count: Today's list drawn | 61 | 0 ms | 0.3 ms |
| day-sheet | Count: the Day sheet's activity drawn | 291 | 0 ms | 0.1 ms |
| day-sheet | Count: a Today row drawn | 399 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet drawn | 259 | 0 ms | 0.0 ms |
| day-sheet | Entry editor: whole editor drawn | 291 | 0 ms | 0.0 ms |
| widget-publish | Widgets: one habit's week | 408 | 815 ms | 38.1 ms |
| widget-publish | Store load: read the database | 2 | 716 ms | 669.2 ms |
| widget-publish | Shared rules: built from every log | 4 | 48 ms | 41.6 ms |
| widget-publish | Store load: into the app (5593 logs) | 1 | 48 ms | 47.7 ms |
| widget-publish | Widgets: the snapshot | 24 | 26 ms | 2.8 ms |
| widget-publish | Shared rules: habits and settings again | 5 | 3 ms | 1.7 ms |
| widget-publish | Store load: into the app (0 logs) | 1 | 2 ms | 1.6 ms |
| widget-publish | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| widget-publish | Count: Today's list drawn | 13 | 0 ms | 0.0 ms |
| widget-publish | Count: a Today row drawn | 60 | 0 ms | 0.0 ms |
| tap-today | Store load: read the database | 2 | 1006 ms | 947.5 ms |
| tap-today | Widgets: one habit's week | 33 | 219 ms | 62.8 ms |
| tap-today | Shared rules: built from every log | 4 | 72 ms | 69.8 ms |
| tap-today | Store load: into the app (5593 logs) | 1 | 71 ms | 70.7 ms |
| tap-today | Widgets: the snapshot | 17 | 34 ms | 6.5 ms |
| tap-today | Shared rules: a log added | 56 | 6 ms | 0.5 ms |
| tap-today | Change: Siri's habit names | 57 | 6 ms | 0.8 ms |
| tap-today | Shared rules: habits and settings again | 7 | 5 ms | 2.5 ms |
| tap-today | Reminders: plan every alert | 55 | 5 ms | 0.6 ms |
| tap-today | Count: Today's list drawn | 150 | 0 ms | 0.1 ms |
| tap-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| tap-today | Count: a Today row drawn | 943 | 0 ms | 0.1 ms |
| tap-today | Count: the Day sheet drawn | 12 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's activity drawn | 12 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
