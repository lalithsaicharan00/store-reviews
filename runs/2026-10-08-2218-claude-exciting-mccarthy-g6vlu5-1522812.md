# claude/exciting-mccarthy-g6vlu5 @ 1522812

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37847053285 · 2026-10-08 22:18 UTC
Commit: Add note: ask for the keyboard again until the field has it (a slow sheet slide dropped it; run 37841204161)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (HabitPageUITests): success
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 1310.401 (1310.418) seconds
	 Executed 10 tests, with 0 failures (0 unexpected) in 1310.401 (1310.423) seconds
	 Executed 10 tests, with 0 failures (0 unexpected) in 1310.401 (1310.424) seconds
Test Case '-[HabitsUITests.HabitPageUITests testHistoryFlows]' passed (124.244 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFlows]' passed (63.377 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFoldByMonthLikeHistory]' passed (54.796 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNoteViewEditAndDelete]' passed (68.519 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDailyTypes]' passed (322.123 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDark]' passed (139.466 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesPeriodLimitQuit]' passed (249.243 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testSquaresKeyFoldedOnceIsFoldedEverywhere]' passed (76.693 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testYearInPixels]' passed (46.549 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testYearInPixelsDayNumbers]' passed (165.392 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Add note: typing | 8.6 | 60 ms | 0 | 2.7 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  closure #1 in AppModel.ensureLoaded()<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded() |
| Edit note: typing | 9.1 | 120 ms | 1 | 2.7 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  closure #1 in AppModel.ensureLoaded()<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded() |
| Habit page: History scrolling | 10.1 | 158 ms | 1 | 4.8 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page: Progress scrolling | 23.2 | 108 ms | 1 | 4.8 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page: switching tabs | 30.6 | 77 ms | 0 | 4.8 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.5%  closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- All Habits: longest stall 531 ms
- Habit page: longest stall 568 ms
- Day sheet: longest stall 538 ms
- Add note: longest stall 1601 ms
- Note view: longest stall 252 ms
- Edit note (keyboard): longest stall 326 ms
- All Habits: longest stall 620 ms
- Habit page: longest stall 690 ms
- Habit page: Notes: longest stall 80 ms
- Habit page: Progress: longest stall 557 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| notes | Widgets: one habit's week | 17 | 208 ms | 171.5 ms |
| notes | Habit page: history | 3 | 27 ms | 10.8 ms |
| notes | Widgets: the snapshot | 4 | 10 ms | 6.6 ms |
| notes | Reminders: plan every alert | 4 | 2 ms | 1.8 ms |
| notes | Change: Siri's habit names | 3 | 0 ms | 0.1 ms |
| notes | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| notes | Count: a Today row drawn | 96 | 0 ms | 0.0 ms |
| notes | Count: the Day sheet drawn | 8 | 0 ms | 0.0 ms |
| notes | Count: the Day sheet's activity drawn | 9 | 0 ms | 0.0 ms |
| habit-page | Widgets: one habit's week | 17 | 201 ms | 158.6 ms |
| habit-page | Habit page: history | 1 | 14 ms | 14.5 ms |
| habit-page | Habit page: overall record | 1 | 13 ms | 13.3 ms |
| habit-page | Habit page: milestones | 1 | 9 ms | 8.9 ms |
| habit-page | Widgets: the snapshot | 1 | 1 ms | 1.2 ms |
| habit-page | Reminders: plan every alert | 1 | 1 ms | 0.7 ms |
| habit-page | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| habit-page | Count: a Today row drawn | 63 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
