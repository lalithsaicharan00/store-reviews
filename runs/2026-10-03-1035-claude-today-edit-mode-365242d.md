# claude/today-edit-mode @ 365242d

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37115060822 · 2026-10-03 10:35 UTC
Commit: Arrange tests: confirm button matched twice, the form's Group row found the way the Groups tests find it, New Time of Day says Add

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (ArrangeUITests,LongTextUITests/testFormWithLongText,NewHabitUITests/testLimitCanBeAWeeklyTotal,NewHabitUITests/testNewTimeOfDayFromTheForm,TodayUITests,SectionHeaderUITests,TasksUITests,PlacementUITests): failure
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 0 failures (0 unexpected) in 76.821 (76.822) seconds
	 Executed 21 tests, with 1 failure (0 unexpected) in 875.735 (875.754) seconds
	 Executed 21 tests, with 1 failure (0 unexpected) in 875.735 (875.757) seconds
	 Executed 3 tests, with 0 failures (0 unexpected) in 98.132 (98.133) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 255.042 (255.047) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 393.879 (393.885) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/LongTextUITests.swift:133: error: -[HabitsUITests.LongTextUITests testFormWithLongText] : Asynchronous wait failed: Exceeded timeout of 3 seconds, with unfulfilled expectations: "Expect predicate `BLOCKPREDICATE(0x117cdcf90)` for object "name-field" TextField".
Test Case '-[HabitsUITests.ArrangeUITests testAddTimeOfDay]' passed (62.867 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testArrangeChecks]' passed (8.874 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testEditArrangesTheDay]' passed (124.884 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testGroupRowBeforeAnyGroup]' passed (34.298 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testHideCompleted]' passed (24.118 seconds).
Test Case '-[HabitsUITests.LongTextUITests testFormWithLongText]' failed (21.315 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeAWeeklyTotal]' passed (35.458 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testNewTimeOfDayFromTheForm]' passed (41.363 seconds).
Test Case '-[HabitsUITests.PlacementUITests testPlacementRules]' passed (5.912 seconds).
Test Case '-[HabitsUITests.SectionHeaderUITests testHeaders]' passed (24.634 seconds).
Test Case '-[HabitsUITests.TasksUITests testCreateTaskFromTasksAndEditSurvivesRelaunch]' passed (38.197 seconds).
Test Case '-[HabitsUITests.TasksUITests testEveryTaskAppearsAndCanOpenEdit]' passed (54.499 seconds).
Test Case '-[HabitsUITests.TasksUITests testTaskModelAndPersistence]' passed (5.436 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (18.582 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (68.270 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (36.665 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (76.645 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (17.053 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (133.894 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (12.557 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (30.214 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Arrange Your Day: scrolling | 0.0 | 0 ms | 0 | 7.8 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.8%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Arrange Your Day: move Anytime and sort | 2.0 | 29 ms | 0 | 7.8 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.8%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Today: hide completed on and off | 26.4 | 48 ms | 0 | 7.8 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.8%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Today: scrolling | 2.6 | 37 ms | 0 | 4.5 % (separate profile) | 0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.4%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 and day ‹ › | 13.5 | 39 ms | 0 | 8.4 % (separate profile) | 0.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 alone | 0.0 | 0 ms | 0 | 8.4 % (separate profile) | 0.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| Today: day ‹ › alone | 9.5 | 29 ms | 0 | 8.4 % (separate profile) | 0.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Arrange Your Day (first): longest stall 138 ms
- Arrange Your Day (again): longest stall 121 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| arrange | Widgets: one habit's month | 34 | 90 ms | 30.7 ms |
| arrange | Reminders: plan every alert | 28 | 2 ms | 0.1 ms |
| arrange | Change: Siri's habit names | 27 | 1 ms | 0.1 ms |
| arrange | Arrange: each card's habits | 29 | 1 ms | 0.1 ms |
| arrange | Widgets: the snapshot | 2 | 1 ms | 0.3 ms |
| arrange | Count: a Today row drawn | 198 | 0 ms | 0.5 ms |
| arrange | Count: Today's list drawn | 42 | 0 ms | 0.1 ms |
| arrange | Count: Arrange Your Day drawn | 29 | 0 ms | 0.0 ms |
| scroll-today | Widgets: one habit's month | 17 | 61 ms | 29.6 ms |
| scroll-today | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| scroll-today | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| scroll-today | Count: Today's list drawn | 6 | 0 ms | 0.0 ms |
| scroll-today | Count: a Today row drawn | 12 | 0 ms | 0.0 ms |
| tap-today | Widgets: one habit's month | 18 | 61 ms | 29.7 ms |
| tap-today | Reminders: plan every alert | 57 | 2 ms | 0.1 ms |
| tap-today | Change: Siri's habit names | 56 | 2 ms | 0.1 ms |
| tap-today | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| tap-today | Count: Today's list drawn | 78 | 0 ms | 0.0 ms |
| tap-today | Count: a Today row drawn | 372 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
