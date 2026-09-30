# claude/undo-research @ f0d9445

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36718621499 · 2026-09-30 13:37 UTC
Commit: Coalesce progress notifications before native list updates [ios-ci] [ios-perf]

- Core storage and migrations: success
- Build: success
- UI tests (TodayUITests,TimerUITests,UndoUITests): success
- Speed tests: success

## UI tests
```
	 Executed 12 tests, with 0 failures (0 unexpected) in 637.380 (637.405) seconds
	 Executed 12 tests, with 0 failures (0 unexpected) in 637.380 (637.406) seconds
	 Executed 2 tests, with 0 failures (0 unexpected) in 181.692 (181.697) seconds
	 Executed 2 tests, with 0 failures (0 unexpected) in 92.556 (92.562) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 363.133 (363.143) seconds
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (54.531 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (38.024 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (22.874 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (158.818 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (69.399 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (76.765 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (37.343 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds]' passed (59.987 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (23.923 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (26.754 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (49.896 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (19.066 seconds).
```

## Speed (simulator on GitHub's Mac, a year of history; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Today: scrolling | 25.2 | 193 ms | 2 | 4.0 % (separate profile) | 0.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.3%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Today: +1 and day ‹ › | 283.0 | 240 ms | 5 |  | (none above noise) |
| All Habits: scrolling | 8.0 | 39 ms | 0 |  | (none above noise) |
| Habit page: scrolling | 1.2 | 26 ms | 0 |  | (none above noise) |
| Calendar: month ‹ › | 56.2 | 427 ms | 1 |  | (none above noise) |
| Habit form: typing | 78.8 | 106 ms | 1 | 19.1 % (separate profile) | 7.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>7.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>4.6%  partial apply for closure #1 in ReminderScheduler.scheduleReconcile(_:)<br>4.6%  closure #1 in ReminderScheduler.scheduleReconcile(_:) |
| Routine player: ‹ › | 255.9 | 3590 ms | 2 |  | (none above noise) |
| Day sheet: entry list scrolling | 4.7 | 37 ms | 0 | 25.1 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 106.9 | 61 ms | 0 | 25.1 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 109.7 | 84 ms | 0 | 25.1 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Log sheet: typing | 198.9 | 290 ms | 4 | 13.3 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.2%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Log sheet: entry list scrolling | 5.9 | 45 ms | 0 | 13.3 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.2%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 87.5 | 78 ms | 0 | 13.3 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.2%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 74.5 | 164 ms | 1 | 13.3 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.2%  closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- All Habits (first): longest stall 407 ms
- All Habits (again): longest stall 342 ms
- All Habits: longest stall 428 ms
- Habit page: longest stall 484 ms
- Calendar (first): longest stall 484 ms
- Calendar (again): longest stall 320 ms
- New Habit (first): longest stall 321 ms
- New Habit (again): longest stall 228 ms
- Habit form (first): longest stall 2444 ms
- Habit form (again): longest stall 486 ms
- Routine player (first): longest stall 1040 ms
- Routine player (again): longest stall 164 ms
- All Habits: longest stall 528 ms
- Habit page: longest stall 747 ms
- Day sheet (first): longest stall 610 ms
- Day sheet (again): longest stall 331 ms
- Entry editor: longest stall 2494 ms
- Save entry: longest stall 559 ms
- All Habits: longest stall 494 ms
- Habit page: longest stall 696 ms
- Day sheet (first): longest stall 563 ms
- Day sheet (again): longest stall 398 ms
- Log sheet: longest stall 1482 ms
- Log keyboard dismissal: longest stall 224 ms
- Entry editor: longest stall 530 ms
- Save entry: longest stall 582 ms
