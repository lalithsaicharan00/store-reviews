# claude/server-and-sync @ d4892c7

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37003880858 · 2026-10-02 12:58 UTC
Commit: Entry editor and log sheet: each number field in its own small view, so a keystroke redraws the field only

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (UndoUITests): success
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 8 tests, with 0 failures (0 unexpected) in 366.422 (366.430) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 366.422 (366.431) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 366.422 (366.432) seconds
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (69.299 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (132.892 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (36.339 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds]' passed (43.334 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (19.407 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (18.377 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (32.212 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (14.563 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Day sheet: entry list scrolling | 0.0 | 17 ms | 0 | 8.8 % (separate profile) | 1.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 5.6 | 34 ms | 0 | 8.8 % (separate profile) | 1.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 75.8 | 100 ms | 1 | 8.8 % (separate profile) | 1.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Log sheet: typing | 15.3 | 42 ms | 0 | 9.2 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Log sheet: entry list scrolling | 4.0 | 56 ms | 0 | 9.2 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 2.3 | 28 ms | 0 | 9.2 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 49.9 | 148 ms | 1 | 9.2 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Control: typing in a bare number field | 0.0 | 0 ms | 0 | 4.5 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.7%  closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- All Habits: longest stall 253 ms
- Habit page: longest stall 401 ms
- Day sheet (first): longest stall 440 ms
- Day sheet (again): longest stall 255 ms
- Entry editor: longest stall 849 ms
- Save entry: longest stall 378 ms
- All Habits: longest stall 258 ms
- Habit page: longest stall 388 ms
- Day sheet (first): longest stall 492 ms
- Day sheet (again): longest stall 414 ms
- Log sheet: longest stall 419 ms
- Log keyboard dismissal: longest stall 185 ms
- Entry editor: longest stall 492 ms
- Save entry: longest stall 546 ms
- Typing control: longest stall 690 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| day-sheet | Entry editor: whole editor drawn | 8 | 1 ms | 0.7 ms |
| log-sheet | Entry editor: whole editor drawn | 7 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
