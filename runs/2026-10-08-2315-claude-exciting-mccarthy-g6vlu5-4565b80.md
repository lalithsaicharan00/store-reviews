# claude/exciting-mccarthy-g6vlu5 @ 4565b80

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37853078424 · 2026-10-08 23:15 UTC
Commit: Current Work 31: the habit page's Week, Month and Year cards keep their whole top padding; Year 16 above and below

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (HabitPageUITests): failure
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 11 tests, with 1 failure (0 unexpected) in 1653.131 (1653.155) seconds
	 Executed 11 tests, with 1 failure (0 unexpected) in 1653.131 (1653.157) seconds
	 Executed 11 tests, with 1 failure (0 unexpected) in 1653.131 (1653.158) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitPageUITests.swift:32: error: -[HabitsUITests.HabitPageUITests testNotesFlows] : Failed to terminate com.oftenenough.app:35058: Failed to terminate com.oftenenough.app:0
Test Case '-[HabitsUITests.HabitPageUITests testHistoryFlows]' passed (84.120 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFlows]' failed (63.599 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFoldByMonthLikeHistory]' passed (57.745 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNoteViewEditAndDelete]' passed (316.332 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPeriodCardSpacing]' passed (257.437 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDailyTypes]' passed (292.630 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDark]' passed (127.434 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesPeriodLimitQuit]' passed (231.317 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testSquaresKeyFoldedOnceIsFoldedEverywhere]' passed (66.901 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testYearInPixels]' passed (36.108 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testYearInPixelsDayNumbers]' passed (119.507 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Habit page: History scrolling | 1.8 | 44 ms | 0 | 9.3 % (separate profile) | 1.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page: Progress scrolling | 0.1 | 18 ms | 0 | 9.3 % (separate profile) | 1.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page: switching tabs | 8.4 | 37 ms | 0 | 9.3 % (separate profile) | 1.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page (weekly total): History scrolling | 1.5 | 25 ms | 0 | 9.2 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized static PerfDriver.scroll()<br>1.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page (weekly total): Progress scrolling | 0.0 | 0 ms | 0 | 9.2 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized static PerfDriver.scroll()<br>1.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- All Habits: longest stall 229 ms
- Habit page: longest stall 309 ms
- Habit page: Notes: longest stall 0 ms
- Habit page: Progress: longest stall 116 ms
- All Habits: longest stall 138 ms
- Habit page (weekly total): longest stall 0 ms
- Habit page (weekly total): Progress: longest stall 0 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| habit-page | Widgets: one habit's week | 17 | 50 ms | 32.6 ms |
| habit-page | Habit page: history | 1 | 6 ms | 5.8 ms |
| habit-page | Habit page: overall record | 1 | 1 ms | 1.2 ms |
| habit-page | Habit page: milestones | 1 | 1 ms | 1.0 ms |
| habit-page | Widgets: the snapshot | 1 | 1 ms | 0.7 ms |
| habit-page | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| habit-page | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| habit-page | Count: a Today row drawn | 63 | 0 ms | 0.0 ms |
| habit-page-total | Widgets: one habit's week | 17 | 61 ms | 36.9 ms |
| habit-page-total | Widgets: the snapshot | 1 | 1 ms | 0.9 ms |
| habit-page-total | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-page-total | Count: Today's list drawn | 7 | 0 ms | 0.0 ms |
| habit-page-total | Count: a Today row drawn | 48 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
