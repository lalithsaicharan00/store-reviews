# claude/undo-research @ de4269a

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36713736531 · 2026-09-30 12:48 UTC
Commit: Update entries in place and measure native keyboard input [ios-ci] [ios-perf]

- Core storage and migrations: success
- Build: success
- UI tests (TodayUITests,TimerUITests,UndoUITests): success
- Speed tests: failure

## UI tests
```
	 Executed 12 tests, with 0 failures (0 unexpected) in 541.988 (542.005) seconds
	 Executed 12 tests, with 0 failures (0 unexpected) in 541.988 (542.007) seconds
	 Executed 2 tests, with 0 failures (0 unexpected) in 138.248 (138.253) seconds
	 Executed 2 tests, with 0 failures (0 unexpected) in 92.766 (92.769) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 310.973 (310.981) seconds
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (97.390 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (40.858 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (45.150 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (47.616 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (51.912 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (77.070 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (34.882 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds]' passed (40.671 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (19.907 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (29.229 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (40.255 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (17.049 seconds).
```

## Speed (simulator on GitHub's Mac, a year of history; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Today: scrolling | 40.4 | 379 ms | 2 | 2.2 % (separate profile) | 0.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.2%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Today: +1 and day ‹ › | 122.5 | 270 ms | 1 |  | (none above noise) |
| All Habits: scrolling | 10.5 | 70 ms | 0 |  | (none above noise) |
| Habit page: scrolling | 4.6 | 47 ms | 0 |  | (none above noise) |
| Calendar: month ‹ › | 64.4 | 79 ms | 0 |  | (none above noise) |
**new-habit failed:** native keyboard input was unavailable or produced unexpected text; see stalls-new-habit.txt.
| Habit form: typing | 1.5 | 40 ms | 0 | 3.4 % (separate profile) | 0.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.2%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Routine player: ‹ › | 22.0 | 73 ms | 0 |  | (none above noise) |
| Day sheet: entry list scrolling | 2.3 | 32 ms | 0 | 21.4 % (separate profile) | 4.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>4.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>4.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>4.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 70.0 | 195 ms | 1 | 21.4 % (separate profile) | 4.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>4.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>4.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>4.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 323.9 | 250 ms | 30 | 21.4 % (separate profile) | 4.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>4.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>4.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>4.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Log sheet: typing | 68.7 | 55 ms | 0 | 21.9 % (separate profile) | 4.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>4.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>4.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>4.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Log sheet: entry list scrolling | 5.2 | 59 ms | 0 | 21.9 % (separate profile) | 4.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>4.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>4.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>4.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 47.4 | 44 ms | 0 | 21.9 % (separate profile) | 4.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>4.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>4.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>4.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 348.0 | 300 ms | 35 | 21.9 % (separate profile) | 4.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>4.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>4.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>4.1%  closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- All Habits (first): longest stall 724 ms
- All Habits (again): longest stall 351 ms
- All Habits: longest stall 329 ms
- Habit page: longest stall 406 ms
- Calendar (first): longest stall 741 ms
- Calendar (again): longest stall 468 ms
- New Habit (first): longest stall 360 ms
- New Habit (again): longest stall 307 ms
- Habit form (first): longest stall 2252 ms
- Habit form (again): longest stall 442 ms
- Routine player (first): longest stall 493 ms
- Routine player (again): longest stall 167 ms
- All Habits: longest stall 467 ms
- Habit page: longest stall 361 ms
- Day sheet (first): longest stall 280 ms
- Day sheet (again): longest stall 344 ms
- Entry editor: longest stall 1916 ms
- Save entry: longest stall 278 ms
- All Habits: longest stall 605 ms
- Habit page: longest stall 299 ms
- Day sheet (first): longest stall 294 ms
- Day sheet (again): longest stall 189 ms
- Log sheet: longest stall 587 ms
- Log keyboard dismissal: longest stall 140 ms
- Entry editor: longest stall 502 ms
- Save entry: longest stall 640 ms
