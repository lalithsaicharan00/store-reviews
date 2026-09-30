# claude/undo-research @ 10e464b

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36697854061 · 2026-09-30 10:18 UTC
Commit: Finish native correction controls, accessible Undo targets and valid keyboard profiling [ios-ci] [ios-perf]

- Core storage and migrations: success
- Build: success
- UI tests (TodayUITests,TimerUITests,UndoUITests): failure
- Speed tests: success

## UI tests
```
	 Executed 12 tests, with 2 failures (0 unexpected) in 524.397 (524.417) seconds
	 Executed 12 tests, with 2 failures (0 unexpected) in 524.397 (524.418) seconds
	 Executed 2 tests, with 0 failures (0 unexpected) in 116.190 (116.193) seconds
	 Executed 2 tests, with 0 failures (0 unexpected) in 80.872 (80.873) seconds
	 Executed 8 tests, with 2 failures (0 unexpected) in 327.336 (327.346) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/UndoUITests.swift:125: error: -[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/UndoUITests.swift:83: error: -[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact] : Failed to get matching snapshot: No matches found for Elements matching predicate '"focus-quantity" IN identifiers' from input {(
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (41.649 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (74.541 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (38.053 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (42.819 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (30.714 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (60.656 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (56.298 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds]' failed (71.810 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' failed (28.340 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (23.076 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (40.725 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (15.716 seconds).
```

## Speed (simulator on GitHub's Mac, a year of history; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Today: scrolling | 13.0 | 106 ms | 1 | 1.7 % (separate profile) | 0.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Today: +1 and day ‹ › | 66.3 | 88 ms | 0 |  | (none above noise) |
| All Habits: scrolling | 10.8 | 65 ms | 0 |  | (none above noise) |
| Habit page: scrolling | 0.4 | 22 ms | 0 |  | (none above noise) |
| Calendar: month ‹ › | 30.5 | 49 ms | 0 |  | (none above noise) |
| Habit form: typing | 34.7 | 105 ms | 1 | 12.3 % (separate profile) | 1.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  partial apply for closure #1 in ReminderScheduler.scheduleReconcile(_:)<br>1.4%  closure #1 in ReminderScheduler.scheduleReconcile(_:) |
| Routine player: ‹ › | 40.5 | 95 ms | 0 |  | (none above noise) |
| Day sheet: entry list scrolling | 0.7 | 25 ms | 0 | 10.2 % (separate profile) | 1.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in ReminderScheduler.scheduleReconcile(_:)<br>0.9%  closure #1 in ReminderScheduler.scheduleReconcile(_:) |
| Entry editor: typing | 173.2 | 391 ms | 1 | 10.2 % (separate profile) | 1.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in ReminderScheduler.scheduleReconcile(_:)<br>0.9%  closure #1 in ReminderScheduler.scheduleReconcile(_:) |
| Day sheet: add, edit and exact undo | 114.0 | 180 ms | 1 | 10.2 % (separate profile) | 1.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in ReminderScheduler.scheduleReconcile(_:)<br>0.9%  closure #1 in ReminderScheduler.scheduleReconcile(_:) |
| Log sheet: entry list scrolling | 2.0 | 30 ms | 0 | 15.3 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 301.2 | 1391 ms | 1 | 15.3 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 119.1 | 140 ms | 2 | 15.3 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.4%  closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- All Habits (first): longest stall 1584 ms
- All Habits (again): longest stall 486 ms
- All Habits: longest stall 605 ms
- Habit page: longest stall 674 ms
- Calendar (first): longest stall 448 ms
- Calendar (again): longest stall 255 ms
- New Habit (first): longest stall 546 ms
- New Habit (again): longest stall 252 ms
- Habit form (first): longest stall 3024 ms
- Habit form (again): longest stall 422 ms
- Routine player (first): longest stall 1043 ms
- Routine player (again): longest stall 232 ms
- All Habits: longest stall 544 ms
- Habit page: longest stall 705 ms
- Day sheet (first): longest stall 424 ms
- Day sheet (again): longest stall 364 ms
- Entry editor: longest stall 2349 ms
- All Habits: longest stall 374 ms
- Habit page: longest stall 369 ms
- Day sheet (first): longest stall 346 ms
- Day sheet (again): longest stall 468 ms
- Log sheet: longest stall 731 ms
- Entry editor: longest stall 731 ms
