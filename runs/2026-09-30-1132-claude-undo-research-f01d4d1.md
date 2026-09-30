# claude/undo-research @ f01d4d1

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36705418731 · 2026-09-30 11:32 UTC
Commit: Keep native progress fields independent while typing and serialize validation [ios-ci] [ios-perf]

- Core storage and migrations: success
- Build: success
- UI tests (TodayUITests,TimerUITests,UndoUITests): success
- Speed tests: success

## UI tests
```
	 Executed 12 tests, with 0 failures (0 unexpected) in 552.455 (552.478) seconds
	 Executed 12 tests, with 0 failures (0 unexpected) in 552.455 (552.480) seconds
	 Executed 2 tests, with 0 failures (0 unexpected) in 146.672 (146.679) seconds
	 Executed 2 tests, with 0 failures (0 unexpected) in 89.046 (89.052) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 316.737 (316.745) seconds
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (101.375 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (45.297 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (39.842 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (49.204 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (40.479 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (65.007 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (48.053 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds]' passed (54.474 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (21.360 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (24.765 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (44.294 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (18.305 seconds).
```

## Speed (simulator on GitHub's Mac, a year of history; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Today: scrolling | 22.2 | 285 ms | 1 | 5.4 % (separate profile) | 0.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Today: +1 and day ‹ › | 116.3 | 370 ms | 3 |  | (none above noise) |
| All Habits: scrolling | 5.4 | 32 ms | 0 |  | (none above noise) |
| Habit page: scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Calendar: month ‹ › | 33.6 | 76 ms | 0 |  | (none above noise) |
| Habit form: typing | 333.6 | 470 ms | 10 | 20.2 % (separate profile) | 0.2%  HabitRow.row(now:)<br>0.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:) |
| Routine player: ‹ › | 153.5 | 328 ms | 6 |  | (none above noise) |
| Day sheet: entry list scrolling | 3.1 | 31 ms | 0 | 28.0 % (separate profile) | 5.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>5.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>5.2%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>5.2%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 192.6 | 135 ms | 2 | 28.0 % (separate profile) | 5.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>5.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>5.2%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>5.2%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 578.7 | 470 ms | 32 | 28.0 % (separate profile) | 5.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>5.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>5.2%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>5.2%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Log sheet: typing | 200.2 | 109 ms | 1 | 29.0 % (separate profile) | 4.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>4.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>4.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>4.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Log sheet: entry list scrolling | 11.5 | 122 ms | 1 | 29.0 % (separate profile) | 4.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>4.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>4.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>4.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 182.4 | 75 ms | 0 | 29.0 % (separate profile) | 4.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>4.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>4.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>4.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 304.1 | 264 ms | 32 | 29.0 % (separate profile) | 4.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>4.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>4.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>4.5%  closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- All Habits (first): longest stall 408 ms
- All Habits (again): longest stall 252 ms
- All Habits: longest stall 557 ms
- Habit page: longest stall 443 ms
- Calendar (first): longest stall 736 ms
- Calendar (again): longest stall 329 ms
- New Habit (first): longest stall 372 ms
- New Habit (again): longest stall 246 ms
- Habit form (first): longest stall 3091 ms
- Habit form (again): longest stall 559 ms
- Routine player (first): longest stall 1392 ms
- Routine player (again): longest stall 339 ms
- All Habits: longest stall 432 ms
- Habit page: longest stall 619 ms
- Day sheet (first): longest stall 572 ms
- Day sheet (again): longest stall 330 ms
- Entry editor: longest stall 2837 ms
- All Habits: longest stall 321 ms
- Habit page: longest stall 500 ms
- Day sheet (first): longest stall 427 ms
- Day sheet (again): longest stall 233 ms
- Log sheet: longest stall 1074 ms
- Entry editor: longest stall 584 ms
