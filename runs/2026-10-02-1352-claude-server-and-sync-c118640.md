# claude/server-and-sync @ c118640

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37013082314 · 2026-10-02 13:52 UTC
Commit: Speed runs: time what each data change sets off (reminders' plan, widgets' months and snapshot, Siri's names)

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
| Day sheet: entry list scrolling | 1.5 | 37 ms | 0 | 5.2 % (separate profile) | 1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.7%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 20.4 | 62 ms | 0 | 5.2 % (separate profile) | 1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.7%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 115.5 | 187 ms | 4 | 5.2 % (separate profile) | 1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.7%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Today: +1 and day ‹ › | 118.5 | 171 ms | 3 | 6.1 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.5%  closure #1 in HabitStore.queueEntryChange() |
| Today: +1 alone | 35.0 | 96 ms | 0 | 6.1 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.5%  closure #1 in HabitStore.queueEntryChange() |
| Today: day ‹ › alone | 37.0 | 58 ms | 0 | 6.1 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.5%  closure #1 in HabitStore.queueEntryChange() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- All Habits: longest stall 814 ms
- Habit page: longest stall 590 ms
- Day sheet (first): longest stall 614 ms
- Day sheet (again): longest stall 402 ms
- Entry editor: longest stall 2323 ms
- Save entry: longest stall 673 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| day-sheet | Widgets: one habit's month | 60 | 362 ms | 118.4 ms |
| day-sheet | Widgets: the snapshot | 45 | 30 ms | 6.5 ms |
| day-sheet | Change: Siri's habit names | 145 | 7 ms | 0.8 ms |
| day-sheet | Reminders: plan every alert | 4 | 2 ms | 1.0 ms |
| day-sheet | Entry editor: whole editor drawn | 8 | 1 ms | 0.8 ms |
| tap-today | Widgets: one habit's month | 73 | 322 ms | 63.6 ms |
| tap-today | Widgets: the snapshot | 57 | 31 ms | 2.0 ms |
| tap-today | Reminders: plan every alert | 56 | 4 ms | 0.2 ms |
| tap-today | Change: Siri's habit names | 56 | 3 ms | 0.2 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
