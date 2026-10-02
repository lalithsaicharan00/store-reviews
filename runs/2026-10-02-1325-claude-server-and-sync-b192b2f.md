# claude/server-and-sync @ b192b2f

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37010034373 · 2026-10-02 13:25 UTC
Commit: Lessons: a text field's binding belongs in the field's own view (entry editor 23.6 -> 2.3-5.6 ms/s typing)

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
| Day sheet: entry list scrolling | 3.3 | 43 ms | 0 | 2.0 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 12.3 | 81 ms | 0 | 2.0 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 49.1 | 47 ms | 0 | 2.0 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Today: +1 and day ‹ › | 96.7 | 189 ms | 2 | 10.1 % (separate profile) | 2.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>1.3%  closure #1 in HabitStore.queueEntryChange() |
| Today: +1 alone | 8.1 | 48 ms | 0 | 10.1 % (separate profile) | 2.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>1.3%  closure #1 in HabitStore.queueEntryChange() |
| Today: day ‹ › alone | 50.2 | 69 ms | 0 | 10.1 % (separate profile) | 2.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>1.3%  closure #1 in HabitStore.queueEntryChange() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- All Habits: longest stall 908 ms
- Habit page: longest stall 797 ms
- Day sheet (first): longest stall 785 ms
- Day sheet (again): longest stall 397 ms
- Entry editor: longest stall 2842 ms
- Save entry: longest stall 436 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| day-sheet | Entry editor: whole editor drawn | 8 | 1 ms | 1.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
