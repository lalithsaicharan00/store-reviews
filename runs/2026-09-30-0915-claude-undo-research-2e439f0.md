# claude/undo-research @ 2e439f0

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36690144089 · 2026-09-30 09:15 UTC
Commit: Keep CI on the latest code and reveal native log history before inspecting it [ios-ci] [ios-perf]

- Core storage and migrations: success
- Build: success
- UI tests (TodayUITests,TimerUITests,UndoUITests): failure
- Speed tests: success

## UI tests
```
	 Executed 2 tests, with 0 failures (0 unexpected) in 178.785 (178.790) seconds
	 Executed 2 tests, with 0 failures (0 unexpected) in 74.977 (74.981) seconds
	 Executed 5 tests, with 2 failures (0 unexpected) in 173.710 (173.715) seconds
	 Executed 9 tests, with 2 failures (0 unexpected) in 427.472 (427.490) seconds
	 Executed 9 tests, with 2 failures (0 unexpected) in 427.472 (427.496) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/UndoUITests.swift:109: error: -[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/UndoUITests.swift:69: error: -[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds] : XCTAssertTrue failed
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (82.129 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (96.657 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (36.246 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (38.731 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' failed (28.935 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (49.988 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (30.349 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds]' failed (47.817 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (16.622 seconds).
```

## Speed (simulator on GitHub's Mac, a year of history; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Today: scrolling | 397.4 | 5595 ms | 1 | 6.6 % | 0.7%  specialized static PerfDriver.run(_:store:)<br>0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:) |
| Today: +1 and day ‹ › | 117.6 | 577 ms | 1 | 6.7 % | 0.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  HabitRow.row(now:)<br>0.1%  partial apply for closure #1 in ReminderScheduler.scheduleReconcile(_:) |
| All Habits: scrolling | 6.9 | 55 ms | 0 | 5.7 % | 0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.6%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page: scrolling | 5.2 | 44 ms | 0 | 7.5 % | 0.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Calendar: month ‹ › | 52.9 | 76 ms | 0 | 7.0 % | 0.3%  partial apply for closure #1 in HabitsApp.today.getter<br>0.3%  closure #1 in HabitsApp.today.getter<br>0.3%  specialized AppModel.scheduleRefresh()<br>0.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A) |
| Habit form: typing | 358.3 | 1102 ms | 15 | 31.5 % | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  AlarmScheduler.isAuthorized.getter<br>1.0%  partial apply for closure #1 in ReminderScheduler.scheduleReconcile(_:) |
| Routine player: ‹ › | 132.6 | 182 ms | 2 | 6.1 % | 0.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  closure #1 in PerfCommandReceiver.body(content:)<br>0.3%  RoutinePlayer.navigate(to:reviewing:) |
| Day sheet: entry list scrolling | 12.2 | 44 ms | 0 | 10.6 % | 0.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized static PerfDriver.run(_:store:)<br>0.7%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 30.6 | 248 ms | 1 | 10.6 % | 0.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized static PerfDriver.run(_:store:)<br>0.7%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 66.2 | 142 ms | 1 | 10.6 % | 0.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized static PerfDriver.run(_:store:)<br>0.7%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:) |
| Log sheet: entry list scrolling | 42.7 | 442 ms | 1 | 9.4 % | 2.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.6%  partial apply for closure #1 in ReminderScheduler.scheduleReconcile(_:)<br>2.6%  closure #1 in ReminderScheduler.scheduleReconcile(_:) |
| Entry editor: typing | 269.3 | 3467 ms | 1 | 9.4 % | 2.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.6%  partial apply for closure #1 in ReminderScheduler.scheduleReconcile(_:)<br>2.6%  closure #1 in ReminderScheduler.scheduleReconcile(_:) |
| Day sheet: add, edit and exact undo | 210.7 | 1542 ms | 4 | 9.4 % | 2.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.6%  partial apply for closure #1 in ReminderScheduler.scheduleReconcile(_:)<br>2.6%  closure #1 in ReminderScheduler.scheduleReconcile(_:) |

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- All Habits (first): longest stall 610 ms
- All Habits (again): longest stall 345 ms
- All Habits: longest stall 1049 ms
- Habit page: longest stall 1049 ms
- Calendar (first): longest stall 764 ms
- Calendar (again): longest stall 376 ms
- New Habit (first): longest stall 890 ms
- New Habit (again): longest stall 261 ms
- Habit form (first): longest stall 3628 ms
- Habit form (again): longest stall 432 ms
- Routine player (first): longest stall 1422 ms
- Routine player (again): longest stall 417 ms
- All Habits: longest stall 10552 ms
- Habit page: longest stall 0 ms
- Day sheet (first): longest stall 292 ms
- Day sheet (again): longest stall 410 ms
- Entry editor: longest stall 246 ms
- All Habits: longest stall 921 ms
- Habit page: longest stall 740 ms
- Day sheet (first): longest stall 530 ms
- Day sheet (again): longest stall 824 ms
- Log sheet: longest stall 4943 ms
- Entry editor: longest stall 442 ms
