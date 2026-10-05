# claude/repro-fast-nav-50 @ 645aa82

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37384134763 · 2026-10-05 23:09 UTC
Commit: EXPERIMENT only (Current Work 50): a TabView that jumps when a tap comes during a slide; turn-around runs (› then ‹ with no pause) and how far the pages trail the player

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (FocusPlayerUITests/testFastNavigationTab,FocusPlayerUITests/testFastNavigationTabInstant): failure
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 2 failures (0 unexpected) in 101.921 (101.924) seconds
	 Executed 2 tests, with 2 failures (0 unexpected) in 101.921 (101.925) seconds
	 Executed 2 tests, with 2 failures (0 unexpected) in 101.921 (101.926) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/FocusPlayerUITests.swift:378: error: -[HabitsUITests.FocusPlayerUITests testFastNavigationTab] : XCTAssertTrue failed - Fast navigation: failed · 13 habits · › 150 ms: slid back 0.21, 6 reversals, at 12.00/12, 69 mid-slide, behind up to 1.47 · ‹ 150 ms: slid back 0.00, 0 reversals, at 0.00/0, 58 mid-slide, behind up to 1.64 · › 100 ms: slid back 0.00, 0 reversals, at 12.00/12, 36 mid-slide, behind up to 1.82 · ‹ 100 ms: slid back 0.00, 0 reversals, at 0.00/0, 42 mid-slide, behind up to 2.06 · › 50 ms: slid back 0.60, 1 reversals, at 12.00/12, 17 mid-slide, behind up to 1.00 · ‹ 50 ms: slid back 0.00, 0 reversals, at 0.00/0, 24 mid-slide, behind up to 1.88 · turn › 100 ms: slid back 0.00, 0 reversals, at 11.16/12, 21 mid-slide, behind up to 1.88 · turn ‹ 100 ms: slid back 0.00, 0 reversals, at 0.00/0, 33 mid-slide, behind up to 1.82 · turn › 50 ms: slid back 0.00, 0 reversals, at 11.59/12, 10 mid-slide, behind up to 1.00 · turn ‹ 50 ms: slid back 0.70, 1 reversals, at 0.00/0, 28 mid-slide, behind up to 1.67
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/FocusPlayerUITests.swift:411: error: -[HabitsUITests.FocusPlayerUITests testFastNavigationTabInstant] : XCTAssertTrue failed - Fast navigation: failed · 13 habits · › 150 ms: slid back 0.00, 1 reversals, at 12.00/12, 58 mid-slide, behind up to 1.60 · ‹ 150 ms: slid back 0.00, 0 reversals, at 0.00/0, 41 mid-slide, behind up to 1.00 · › 100 ms: slid back 0.00, 1 reversals, at 12.00/12, 9 mid-slide, behind up to 1.84 · ‹ 100 ms: slid back 0.00, 0 reversals, at 0.00/0, 7 mid-slide, behind up to 1.82 · › 50 ms: slid back 0.00, 0 reversals, at 12.00/12, 3 mid-slide, behind up to 1.67 · ‹ 50 ms: slid back 0.00, 0 reversals, at 0.00/0, 2 mid-slide, behind up to 1.00 · turn › 100 ms: slid back 0.00, 0 reversals, at 12.00/12, 8 mid-slide, behind up to 1.82 · turn ‹ 100 ms: slid back 0.00, 0 reversals, at 0.00/0, 10 mid-slide, behind up to 1.75 · turn › 50 ms: slid back 0.00, 0 reversals, at 12.00/12, 4 mid-slide, behind up to 1.88 · turn ‹ 50 ms: slid back 0.00, 0 reversals, at 0.00/0, 4 mid-slide, behind up to 1.88
Test Case '-[HabitsUITests.FocusPlayerUITests testFastNavigationTab]' failed (62.933 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testFastNavigationTabInstant]' failed (38.987 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Routine player: ‹ › | 32.4 | 72 ms | 0 | 7.0 % (separate profile) | 1.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.0%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Routine player: fast ‹ › | 31.4 | 73 ms | 0 | 7.0 % (separate profile) | 1.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.0%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Routine player: ‹ › | 54.6 | 97 ms | 0 | 9.7 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.8%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Routine player: fast ‹ › | 33.8 | 66 ms | 0 | 9.7 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.8%  closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Routine player (first): longest stall 714 ms
- Routine player (again): longest stall 310 ms
- Routine player (first): longest stall 493 ms
- Routine player (again): longest stall 244 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| player | Widgets: one habit's month | 19 | 74 ms | 37.1 ms |
| player | Widgets: the snapshot | 3 | 5 ms | 2.9 ms |
| player | Reminders: plan every alert | 50 | 4 ms | 0.7 ms |
| player | Change: Siri's habit names | 49 | 3 ms | 0.2 ms |
| player | Count: Today's list drawn | 12 | 1 ms | 0.6 ms |
| player | Count: a Today row drawn | 88 | 0 ms | 0.0 ms |
| player-instant | Widgets: one habit's month | 18 | 68 ms | 32.9 ms |
| player-instant | Widgets: the snapshot | 2 | 4 ms | 3.9 ms |
| player-instant | Reminders: plan every alert | 50 | 3 ms | 0.2 ms |
| player-instant | Change: Siri's habit names | 49 | 2 ms | 0.2 ms |
| player-instant | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| player-instant | Count: a Today row drawn | 80 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
