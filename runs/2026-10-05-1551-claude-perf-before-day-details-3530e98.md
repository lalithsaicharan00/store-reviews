# claude/perf-before-day-details @ 3530e98

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37330449077 · 2026-10-05 15:51 UTC
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
| Today: scrolling | 44.0 | 483 ms | 1 | 8.2 % (separate profile) | 0.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.2%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 and day ‹ › | 61.3 | 94 ms | 0 | 8.9 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.9%  closure #1 in HabitStore.queueEntryChange() |
| Today: +1 alone | 1.8 | 26 ms | 0 | 8.9 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.9%  closure #1 in HabitStore.queueEntryChange() |
| Today: day ‹ › alone | 92.2 | 115 ms | 1 | 8.9 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.9%  closure #1 in HabitStore.queueEntryChange() |
| Today: Day sheet scrolling | 44.1 | 40 ms | 0 | 8.9 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.9%  closure #1 in HabitStore.queueEntryChange() |
| Timer screen: a running clock | 8.1 | 70 ms | 0 | 8.9 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.9%  closure #1 in HabitStore.queueEntryChange() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Today: a row's Day sheet (first): longest stall 1189 ms
- Today: a row's Day sheet (again): longest stall 624 ms
- Today: the note sheet: longest stall 1173 ms
- Today: the timer screen: longest stall 0 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| scroll-today | Widgets: one habit's month | 17 | 125 ms | 79.3 ms |
| scroll-today | Reminders: plan every alert | 1 | 1 ms | 1.0 ms |
| scroll-today | Count: Today's list drawn | 7 | 1 ms | 0.6 ms |
| scroll-today | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| scroll-today | Count: a Today row drawn | 36 | 0 ms | 0.0 ms |
| tap-today | Widgets: one habit's month | 19 | 134 ms | 56.4 ms |
| tap-today | Reminders: plan every alert | 59 | 4 ms | 1.0 ms |
| tap-today | Widgets: the snapshot | 3 | 4 ms | 3.0 ms |
| tap-today | Change: Siri's habit names | 58 | 3 ms | 0.1 ms |
| tap-today | Count: Today's list drawn | 95 | 1 ms | 0.5 ms |
| tap-today | Count: a Today row drawn | 660 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet drawn | 16 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's entries drawn | 4 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
