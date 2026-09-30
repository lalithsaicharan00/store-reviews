# perf-smooth-app @ 64eeb9a

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36682040044 · 2026-09-30 07:29 UTC
Commit: Speed runs: start the sampler at launch so its attach pause never lands in a measured window

- Build: success
- UI tests (NewFlowUITests): failure
- Speed tests: success

## UI tests
```
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/NewFlowUITests.swift:98: error: -[HabitsUITests.NewFlowUITests testFlow] : XCTAssertFalse failed - Reminders hide when the switch is off
Test Case '-[HabitsUITests.NewFlowUITests testFlow]' failed (185.193 seconds).
```

## Speed (simulator on GitHub's Mac, a year of history; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Today: scrolling | 0.0 | 0 ms | 0 | 1.0 % | 0.1%  HabitRow.row(now:)<br>0.1%  thunk for @escaping @callee_guaranteed (@guaranteed CFRunLoopObserverRef?, @unowned CFRunLoopActivity) -> ()<br>0.0%  closure #1 in closure #1 in closure #2 in HabitRow.row(now:)<br>0.0%  HabitRow.subtitle(progress:goal:) |
| Today: +1 and day ‹ › | 91.6 | 300 ms | 3 | 4.8 % | 0.2%  HabitRow.row(now:)<br>0.1%  specialized static Format.trimmed(_:places:)<br>0.1%  closure #1 in closure #1 in closure #2 in HabitRow.row(now:)<br>0.1%  HabitRow.subtitle(progress:goal:) |
| All Habits: scrolling | 9.5 | 66 ms | 0 | 8.0 % | 1.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  partial apply for closure #1 in ReminderScheduler.scheduleReconcile(_:)<br>1.0%  closure #1 in ReminderScheduler.scheduleReconcile(_:) |
| Habit page: scrolling | 11.8 | 79 ms | 0 | 4.8 % | 0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.7%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Calendar: month ‹ › | 51.1 | 241 ms | 2 | 13.4 % | 1.9%  partial apply for closure #1 in HabitsApp.today.getter<br>1.9%  closure #1 in HabitsApp.today.getter<br>1.9%  specialized AppModel.scheduleRefresh()<br>0.3%  one-time initialization function for shared |
| Habit form: typing | 186.9 | 141 ms | 7 | 22.3 % | 0.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in ReminderScheduler.scheduleReconcile(_:)<br>0.5%  closure #1 in ReminderScheduler.scheduleReconcile(_:) |
| Routine player: ‹ › | 252.0 | 545 ms | 7 | 11.5 % | 0.6%  closure #1 in PerfCommandReceiver.body(content:)<br>0.6%  RoutinePlayer.navigate(to:reviewing:)<br>0.6%  RoutinePlayer.startCurrentTimer()<br>0.6%  HabitStore.toggleTimer(_:slot:) |

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- All Habits (first): longest stall 447 ms
- All Habits (again): longest stall 327 ms
- All Habits: longest stall 351 ms
- Habit page: longest stall 416 ms
- Calendar (first): longest stall 1064 ms
- Calendar (again): longest stall 330 ms
- New Habit (first): longest stall 0 ms
- New Habit (again): longest stall 442 ms
- Habit form (first): longest stall 2644 ms
- Habit form (again): longest stall 0 ms
- Routine player (first): longest stall 1616 ms
- Routine player (again): longest stall 454 ms
