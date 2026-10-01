# claude/perf-bisect-habit-page @ 72e05f4

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36870303082 · 2026-10-01 14:02 UTC
Commit: Scratch: habit page speed bisect (leave out one section per scenario); not for merging

- Core storage and migrations: success
- Build: success
- UI tests (none): skipped
- Speed tests: success
- Speed tests through XCTest: skipped

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Habit page: scrolling | 107.8 | 1081 ms | 2 | 5.7 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.2%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page: scrolling, no charts | 26.9 | 110 ms | 1 | 21.3 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page: scrolling, no overtime | 11.2 | 75 ms | 0 | 5.2 % (separate profile) | 0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.7%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page: scrolling, no year | 15.6 | 249 ms | 1 | 4.0 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page: scrolling, no runs | 36.9 | 291 ms | 1 | 9.4 % (separate profile) | 0.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.8%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page: scrolling, no all | 0.2 | 19 ms | 0 | 4.8 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.6%  closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- All Habits: longest stall 502 ms
- Habit page: longest stall 430 ms
- All Habits: longest stall 1073 ms
- Habit page: longest stall 726 ms
- All Habits: longest stall 526 ms
- Habit page: longest stall 673 ms
- All Habits: longest stall 279 ms
- Habit page: longest stall 326 ms
- All Habits: longest stall 559 ms
- Habit page: longest stall 606 ms
- All Habits: longest stall 410 ms
- Habit page: longest stall 434 ms
