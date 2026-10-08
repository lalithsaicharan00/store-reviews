# claude/exciting-mccarthy-g6vlu5 @ 5726570

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37812076363 · 2026-10-08 17:31 UTC
Commit: Current Work 53: a group drag drops inside the rows, and the editor shows the new order at once (S7)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (GroupsUITests): failure
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 9 tests, with 1 failure (0 unexpected) in 569.708 (569.720) seconds
	 Executed 9 tests, with 1 failure (0 unexpected) in 569.708 (569.722) seconds
	 Executed 9 tests, with 1 failure (0 unexpected) in 569.708 (569.725) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/GroupsUITests.swift:336: error: -[HabitsUITests.GroupsUITests testGroupOrderIsThePersonsOwn] : XCTAssertTrue failed - Your order, with Sort A to Z
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (57.247 seconds).
Test Case '-[HabitsUITests.GroupsUITests testDeletingAGroupKeepsItsHabits]' passed (60.736 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (115.280 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' passed (65.757 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (100.635 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupOrderIsThePersonsOwn]' failed (33.858 seconds).
Test Case '-[HabitsUITests.GroupsUITests testNamesAreUniqueAndAGroupCanPause]' passed (51.939 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (41.795 seconds).
Test Case '-[HabitsUITests.GroupsUITests testTodayAndProgressKeepTheirOwnChoiceAndStartPlaysWhatsShown]' passed (42.461 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Today: group filter | 33.4 | 88 ms | 0 | 8.4 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  partial apply for closure #1 in AppModel.ensureLoaded()<br>1.0%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 and day ‹ › | 175.1 | 167 ms | 6 | 12.3 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.6%  closure #1 in HabitStore.queueEntryChange() |
| Today: +1 alone | 19.7 | 116 ms | 1 | 12.3 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.6%  closure #1 in HabitStore.queueEntryChange() |
| Today: day ‹ › alone | 99.1 | 90 ms | 0 | 12.3 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.6%  closure #1 in HabitStore.queueEntryChange() |
| Today: Day sheet scrolling | 0.0 | 0 ms | 0 | 12.3 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.6%  closure #1 in HabitStore.queueEntryChange() |
| Timer screen: a running clock | 0.0 | 0 ms | 0 | 12.3 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.6%  closure #1 in HabitStore.queueEntryChange() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Today: a row's Day sheet (first): longest stall 804 ms
- Today: a row's Day sheet (again): longest stall 277 ms
- Today: the note sheet: longest stall 1583 ms
- Today: the timer screen: longest stall 589 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| groups | Widgets: one habit's week | 17 | 131 ms | 84.1 ms |
| groups | Widgets: the snapshot | 1 | 1 ms | 1.2 ms |
| groups | Count: Today's list drawn | 45 | 1 ms | 1.2 ms |
| groups | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| groups | Count: a Today row drawn | 492 | 0 ms | 0.0 ms |
| tap-today | Widgets: one habit's week | 34 | 185 ms | 78.9 ms |
| tap-today | Widgets: the snapshot | 18 | 40 ms | 9.0 ms |
| tap-today | Reminders: plan every alert | 58 | 4 ms | 0.2 ms |
| tap-today | Change: Siri's habit names | 58 | 3 ms | 0.2 ms |
| tap-today | Count: Today's list drawn | 92 | 0 ms | 0.1 ms |
| tap-today | Count: a Today row drawn | 632 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet drawn | 15 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's activity drawn | 15 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
