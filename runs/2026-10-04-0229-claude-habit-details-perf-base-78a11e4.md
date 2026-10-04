# claude/habit-details-perf-base @ 78a11e4

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37170420116 · 2026-10-04 02:29 UTC
Commit: Today's rows: a tap opens the Day sheet for the day shown; ✓ toggles that day's tick, + adds; swipes reveal Note/Skip/Pause and a named Undo; long press matches the sheet; Delete only in the sheet's ⋯ menu; done habits stay in place

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
| Today: +1 and day ‹ › | 41.4 | 180 ms | 1 | 5.0 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.3%  closure #1 in HabitStore.queueEntryChange() |
| Today: +1 alone | 24.9 | 148 ms | 2 | 5.0 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.3%  closure #1 in HabitStore.queueEntryChange() |
| Today: day ‹ › alone | 69.8 | 269 ms | 2 | 5.0 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.3%  closure #1 in HabitStore.queueEntryChange() |
| Today: Day sheet scrolling | 10.0 | 106 ms | 1 | 5.0 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.3%  closure #1 in HabitStore.queueEntryChange() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Today: a row's Day sheet (first): longest stall 1092 ms
- Today: a row's Day sheet (again): longest stall 350 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| tap-today | Widgets: one habit's month | 18 | 115 ms | 71.5 ms |
| tap-today | Change: Siri's habit names | 54 | 10 ms | 7.8 ms |
| tap-today | Reminders: plan every alert | 49 | 4 ms | 1.1 ms |
| tap-today | Widgets: the snapshot | 2 | 3 ms | 2.2 ms |
| tap-today | Count: Today's list drawn | 84 | 0 ms | 0.2 ms |
| tap-today | Count: the Day sheet drawn | 4 | 0 ms | 0.0 ms |
| tap-today | Count: a Today row drawn | 206 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's entries drawn | 4 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
