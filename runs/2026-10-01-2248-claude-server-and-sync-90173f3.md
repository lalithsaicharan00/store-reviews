# claude/server-and-sync @ 90173f3

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36935413642 · 2026-10-01 22:48 UTC
Commit: Merge and Hardening: second iOS run

- Core storage and migrations: success
- Build: success
- UI tests (none): skipped
- Speed tests: success
- Speed tests through XCTest: skipped

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Day sheet: entry list scrolling | 9.3 | 78 ms | 0 | 12.8 % (separate profile) | 2.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>2.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 115.0 | 92 ms | 0 | 12.8 % (separate profile) | 2.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>2.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 535.0 | 231 ms | 36 | 12.8 % (separate profile) | 2.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>2.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page (quit): scrolling | 12.8 | 98 ms | 0 | 4.9 % (separate profile) | 0.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.7%  closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- All Habits: longest stall 655 ms
- Habit page: longest stall 549 ms
- Day sheet (first): longest stall 818 ms
- Day sheet (again): longest stall 489 ms
- Entry editor: longest stall 3268 ms
- Save entry: longest stall 800 ms
- All Habits: longest stall 456 ms
- Habit page (quit): longest stall 1653 ms
