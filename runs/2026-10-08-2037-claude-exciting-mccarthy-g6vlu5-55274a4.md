# claude/exciting-mccarthy-g6vlu5 @ 55274a4

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37836789385 · 2026-10-08 20:37 UTC
Commit: Current Work 32: Year in Pixels shows every day number, 1 to 31, right-aligned beside its row

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (HabitPageUITests/testYearInPixelsDayNumbers,HabitPageUITests/testYearInPixels): failure
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 2 failures (0 unexpected) in 356.964 (356.968) seconds
	 Executed 2 tests, with 2 failures (0 unexpected) in 356.964 (356.971) seconds
	 Executed 2 tests, with 2 failures (0 unexpected) in 356.964 (356.973) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitPageUITests.swift:319: error: -[HabitsUITests.HabitPageUITests testYearInPixels] : XCTAssertTrue failed - Year in Pixels
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitPageUITests.swift:322: error: -[HabitsUITests.HabitPageUITests testYearInPixels] : Failed to get matching snapshot: No matches found for Elements matching predicate '"habit-year-grid" IN identifiers' from input {(
Test Case '-[HabitsUITests.HabitPageUITests testYearInPixels]' failed (187.008 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testYearInPixelsDayNumbers]' passed (169.956 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Habit page: History scrolling | 2.4 | 46 ms | 0 | 2.3 % (separate profile) | 0.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.3%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page: Progress scrolling | 7.9 | 64 ms | 0 | 2.3 % (separate profile) | 0.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.3%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page: switching tabs | 13.9 | 50 ms | 0 | 2.3 % (separate profile) | 0.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.3%  closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- All Habits: longest stall 485 ms
- Habit page: longest stall 528 ms
- Habit page: Notes: longest stall 32 ms
- Habit page: Progress: longest stall 249 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| habit-page | Widgets: one habit's week | 17 | 74 ms | 47.5 ms |
| habit-page | Habit page: history | 1 | 12 ms | 11.6 ms |
| habit-page | Habit page: overall record | 1 | 2 ms | 2.1 ms |
| habit-page | Habit page: milestones | 1 | 1 ms | 1.3 ms |
| habit-page | Widgets: the snapshot | 1 | 1 ms | 0.7 ms |
| habit-page | Reminders: plan every alert | 1 | 1 ms | 0.7 ms |
| habit-page | Count: Today's list drawn | 8 | 1 ms | 0.6 ms |
| habit-page | Count: a Today row drawn | 63 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
