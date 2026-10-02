# claude/server-and-sync @ aca91eb

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36963816760 · 2026-10-02 04:56 UTC
Commit: Old UI tests brought up to the current player and sheets (Focus player, Routine Calendar, Goal flow, Schedule)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (TodayUITests,UndoUITests,TimerUITests,GroupsUITests): success
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 0 failures (0 unexpected) in 57.202 (57.203) seconds
	 Executed 23 tests, with 0 failures (0 unexpected) in 931.506 (931.527) seconds
	 Executed 23 tests, with 0 failures (0 unexpected) in 931.506 (931.528) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 318.834 (318.839) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 210.567 (210.572) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 344.903 (344.909) seconds
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (39.787 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (72.260 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' passed (108.496 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (67.766 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (30.525 seconds).
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (23.278 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (33.924 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (19.308 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (41.261 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (20.180 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (33.869 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (16.553 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (166.666 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (14.700 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (32.367 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (33.368 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (39.121 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (27.562 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds]' passed (38.612 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (18.068 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (15.408 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (26.067 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (12.361 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Today: +1 and day ‹ › | 19.9 | 70 ms | 0 | 6.1 % (separate profile) | 0.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.4%  closure #1 in HabitStore.queueEntryChange() |
| Today: scrolling | 7.6 | 75 ms | 0 | 1.2 % (separate profile) | 0.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.2%  closure #1 in AppModel.ensureLoaded() |
| Day sheet: entry list scrolling | 0.0 | 0 ms | 0 | 6.2 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 4.5 | 28 ms | 0 | 6.2 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 16.7 | 42 ms | 0 | 6.2 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page: scrolling | 120.9 | 1517 ms | 2 | 5.4 % (separate profile) | 0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.4%  closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- All Habits: longest stall 329 ms
- Habit page: longest stall 475 ms
- Day sheet (first): longest stall 475 ms
- Day sheet (again): longest stall 218 ms
- Entry editor: longest stall 857 ms
- Save entry: longest stall 324 ms
- All Habits: longest stall 434 ms
- Habit page: longest stall 502 ms

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
