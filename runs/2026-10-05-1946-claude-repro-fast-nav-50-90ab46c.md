# claude/repro-fast-nav-50 @ 90ab46c

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37363991450 · 2026-10-05 19:46 UTC
Commit: Reproduction only: the player's fast ‹ › speed scenario, for an old-pager baseline

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
| Routine player: ‹ › | 13.0 | 85 ms | 0 | 3.9 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  static PerfDriver.run(_:store:)<br>0.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:) |
| Routine player: fast ‹ › | 5.7 | 54 ms | 0 | 3.9 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  static PerfDriver.run(_:store:)<br>0.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Routine player (first): longest stall 352 ms
- Routine player (again): longest stall 98 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| player | Widgets: one habit's month | 19 | 67 ms | 32.6 ms |
| player | Widgets: the snapshot | 3 | 6 ms | 2.9 ms |
| player | Reminders: plan every alert | 50 | 2 ms | 0.3 ms |
| player | Change: Siri's habit names | 49 | 2 ms | 0.1 ms |
| player | Count: Today's list drawn | 11 | 0 ms | 0.3 ms |
| player | Count: a Today row drawn | 72 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
