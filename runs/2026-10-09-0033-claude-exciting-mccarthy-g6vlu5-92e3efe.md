# claude/exciting-mccarthy-g6vlu5 @ 92e3efe

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37860896648 · 2026-10-09 00:33 UTC
Commit: Current Work 23: Current and Best streak, early in the habit's Progress tab, in the goal's own unit

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (HabitPageUITests,ProgressUITests/testHabitPageYearAndMilestones): success
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 12 tests, with 0 failures (0 unexpected) in 1549.214 (1549.225) seconds
	 Executed 13 tests, with 0 failures (0 unexpected) in 1580.889 (1580.911) seconds
	 Executed 13 tests, with 0 failures (0 unexpected) in 1580.889 (1580.912) seconds
Test Case '-[HabitsUITests.HabitPageUITests testHistoryFlows]' passed (129.711 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFlows]' passed (51.588 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFoldByMonthLikeHistory]' passed (39.443 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNoteViewEditAndDelete]' passed (51.958 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPeriodCardSpacing]' passed (180.807 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDailyTypes]' passed (399.616 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDark]' passed (120.103 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesPeriodLimitQuit]' passed (242.695 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testSquaresKeyFoldedOnceIsFoldedEverywhere]' passed (74.150 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testStreaksOnTheProgressTab]' passed (77.863 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testYearInPixels]' passed (41.160 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testYearInPixelsDayNumbers]' passed (140.121 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndMilestones]' passed (31.675 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Habit page: History scrolling | 17.3 | 144 ms | 1 | 2.6 % (separate profile) | 0.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.2%  closure #1 in AppModel.ensureLoaded() |
| Habit page: Progress scrolling | 9.9 | 155 ms | 1 | 2.6 % (separate profile) | 0.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.2%  closure #1 in AppModel.ensureLoaded() |
| Habit page: switching tabs | 19.0 | 66 ms | 0 | 2.6 % (separate profile) | 0.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.2%  closure #1 in AppModel.ensureLoaded() |
| Habit page (weekly total): History scrolling | 2.9 | 33 ms | 0 | 8.2 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  static PerfDriver.run(_:store:)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page (weekly total): Progress scrolling | 1.2 | 21 ms | 0 | 8.2 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  static PerfDriver.run(_:store:)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- All Habits: longest stall 550 ms
- Habit page: longest stall 658 ms
- Habit page: Notes: longest stall 42 ms
- Habit page: Progress: longest stall 229 ms
- All Habits: longest stall 361 ms
- Habit page (weekly total): longest stall 0 ms
- Habit page (weekly total): Progress: longest stall 0 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| habit-page | Widgets: one habit's week | 17 | 128 ms | 87.0 ms |
| habit-page | Habit page: history | 1 | 9 ms | 9.4 ms |
| habit-page | Habit page: overall record | 1 | 2 ms | 2.0 ms |
| habit-page | Count: a Today row drawn | 24 | 2 ms | 1.9 ms |
| habit-page | Widgets: the snapshot | 1 | 1 ms | 1.4 ms |
| habit-page | Reminders: plan every alert | 1 | 1 ms | 1.3 ms |
| habit-page | Habit page: milestones | 1 | 1 ms | 1.2 ms |
| habit-page | Count: Today's list drawn | 8 | 0 ms | 0.1 ms |
| habit-page-total | Widgets: one habit's week | 17 | 63 ms | 39.8 ms |
| habit-page-total | Widgets: the snapshot | 1 | 1 ms | 0.9 ms |
| habit-page-total | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-page-total | Count: Today's list drawn | 7 | 0 ms | 0.0 ms |
| habit-page-total | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
