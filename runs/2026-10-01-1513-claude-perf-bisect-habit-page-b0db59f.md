# claude/perf-bisect-habit-page @ b0db59f

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36879941206 · 2026-10-01 15:13 UTC
Commit: Scratch: bisect the main chart's parts

- Core storage and migrations: success
- Build: success
- UI tests (none): skipped
- Speed tests: success
- Speed tests through XCTest: skipped

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Habit page: scrolling | 78.7 | 839 ms | 2 | 1.8 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page: scrolling, no chart-selection | 40.6 | 272 ms | 2 | 6.5 % (separate profile) | 0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.6%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page: scrolling, no chart-xaxis | 40.9 | 422 ms | 1 | 28.1 % (separate profile) | 0.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  AppModel.shared.unsafeMutableAddressor<br>0.2%  one-time initialization function for shared |
| Habit page: scrolling, no chart-yaxis | 32.6 | 296 ms | 1 | 20.7 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page: scrolling, no chart-unit | 123.3 | 1338 ms | 2 | 13.8 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.8%  closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- All Habits: longest stall 505 ms
- Habit page: longest stall 434 ms
- All Habits: longest stall 441 ms
- Habit page: longest stall 429 ms
- All Habits: longest stall 1332 ms
- Habit page: longest stall 775 ms
- All Habits: longest stall 504 ms
- Habit page: longest stall 357 ms
- All Habits: longest stall 288 ms
- Habit page: longest stall 503 ms
