# details-page-update @ c09cdb9

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37324703983 · 2026-10-05 15:06 UTC
Commit: HabitCreationUITests.testOtherTypes: wait for the task's preview to catch up

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (HabitCreationUITests/testOtherTypes,WidgetSystemUITests/testLockScreenWidgetPickerAvailability): success
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 1 test skipped and 0 failures (0 unexpected) in 372.057 (372.069) seconds
	 Executed 2 tests, with 1 test skipped and 0 failures (0 unexpected) in 372.057 (372.073) seconds
Test Case '-[HabitsUITests.HabitCreationUITests testOtherTypes]' passed (269.884 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Today: scrolling | 41.4 | 516 ms | 1 | 2.7 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  closure #1 in AppModel.ensureLoaded()<br>1.4%  partial apply for closure #1 in AppModel.ensureLoaded() |
| Today: +1 and day ‹ › | 150.3 | 131 ms | 2 | 3.2 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.4%  closure #1 in HabitStore.queueEntryChange() |
| Today: +1 alone | 15.5 | 65 ms | 0 | 3.2 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.4%  closure #1 in HabitStore.queueEntryChange() |
| Today: day ‹ › alone | 162.3 | 121 ms | 8 | 3.2 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.4%  closure #1 in HabitStore.queueEntryChange() |
| Today: Day sheet scrolling | 13.8 | 30 ms | 0 | 3.2 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.4%  closure #1 in HabitStore.queueEntryChange() |
| Timer screen: a running clock | 38.9 | 143 ms | 1 | 3.2 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.4%  closure #1 in HabitStore.queueEntryChange() |
| Habit form: typing | 30.4 | 108 ms | 1 | 5.4 % (separate profile) | 1.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.8%  closure #1 in AppModel.ensureLoaded() |
| Progress: scrolling | 10.8 | 42 ms | 0 | 6.4 % (separate profile) | 0.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Progress: period ‹ › and range | 164.8 | 226 ms | 9 | 6.4 % (separate profile) | 0.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Progress: key fold and open | 0.0 | 0 ms | 0 | 6.4 % (separate profile) | 0.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Menu: open and close | 81.8 | 348 ms | 5 | 8.6 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.5%  closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Today: a row's Day sheet (first): longest stall 1175 ms
- Today: a row's Day sheet (again): longest stall 470 ms
- Today: the note sheet: longest stall 1367 ms
- Today: the timer screen: longest stall 1620 ms
- New Habit (first): longest stall 431 ms
- New Habit (again): longest stall 219 ms
- Habit form (first): longest stall 836 ms
- Habit form (again): longest stall 393 ms
- Progress (first): longest stall 3533 ms
- Progress (again): longest stall 432 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| scroll-today | Widgets: one habit's month | 17 | 123 ms | 87.0 ms |
| scroll-today | Reminders: plan every alert | 1 | 1 ms | 1.1 ms |
| scroll-today | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| scroll-today | Count: Today's list drawn | 6 | 0 ms | 0.0 ms |
| scroll-today | Reminders: build requests | 1 | 0 ms | 0.0 ms |
| scroll-today | Count: a Today row drawn | 30 | 0 ms | 0.0 ms |
| tap-today | Widgets: one habit's month | 19 | 112 ms | 41.5 ms |
| tap-today | Reminders: plan every alert | 58 | 5 ms | 0.2 ms |
| tap-today | Change: Siri's habit names | 58 | 4 ms | 0.5 ms |
| tap-today | Widgets: the snapshot | 3 | 3 ms | 2.4 ms |
| tap-today | Reminders: build requests | 58 | 0 ms | 0.0 ms |
| tap-today | Count: Today's list drawn | 104 | 0 ms | 0.0 ms |
| tap-today | Count: a Today row drawn | 768 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet drawn | 15 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's activity drawn | 15 | 0 ms | 0.0 ms |
| new-habit | Widgets: one habit's month | 17 | 110 ms | 59.2 ms |
| new-habit | Widgets: the snapshot | 1 | 1 ms | 1.1 ms |
| new-habit | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| new-habit | Count: Today's list drawn | 14 | 0 ms | 0.1 ms |
| new-habit | Reminders: build requests | 1 | 0 ms | 0.0 ms |
| new-habit | Count: a Today row drawn | 134 | 0 ms | 0.0 ms |
| progress | Widgets: one habit's month | 17 | 112 ms | 43.9 ms |
| progress | Progress year: whole snapshot | 2 | 64 ms | 41.0 ms |
| progress | Progress year: cards | 2 | 64 ms | 40.8 ms |
| progress | Progress year: one card | 30 | 60 ms | 5.0 ms |
| progress | Progress week: whole snapshot | 2 | 25 ms | 22.4 ms |
| progress | Progress week: cards | 2 | 19 ms | 16.0 ms |
| progress | Progress week: one card | 30 | 12 ms | 9.9 ms |
| progress | Progress month: whole snapshot | 2 | 7 ms | 3.4 ms |
| progress | Progress month: cards | 2 | 6 ms | 3.2 ms |
| progress | Progress month: one card | 30 | 6 ms | 1.6 ms |
| progress | Progress week: one quit card | 4 | 3 ms | 2.2 ms |
| progress | Widgets: the snapshot | 1 | 1 ms | 0.8 ms |
| progress | Progress year: one quit card | 2 | 0 ms | 0.3 ms |
| progress | Progress month: one quit card | 4 | 0 ms | 0.1 ms |
| progress | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| progress | Count: Today's list drawn | 24 | 0 ms | 0.0 ms |
| progress | Reminders: build requests | 1 | 0 ms | 0.0 ms |
| progress | Count: a Today row drawn | 230 | 0 ms | 0.0 ms |
| menu | Widgets: one habit's month | 17 | 87 ms | 45.1 ms |
| menu | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| menu | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| menu | Count: Today's list drawn | 7 | 0 ms | 0.0 ms |
| menu | Reminders: build requests | 1 | 0 ms | 0.0 ms |
| menu | Count: a Today row drawn | 36 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
