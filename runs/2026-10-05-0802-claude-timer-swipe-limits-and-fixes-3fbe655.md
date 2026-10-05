# claude/timer-swipe-limits-and-fixes @ 3fbe655

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37276908176 · 2026-10-05 08:02 UTC
Commit: Merging the Branches: claude/timer-swipe-limits-and-fixes merged into main and safe to delete

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (HabitPageUITests,WeekCardsUITests): failure
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 465.358 (465.364) seconds
	 Executed 18 tests, with 3 failures (0 unexpected) in 1561.954 (1561.980) seconds
	 Executed 18 tests, with 3 failures (0 unexpected) in 1561.954 (1561.982) seconds
	 Executed 8 tests, with 3 failures (0 unexpected) in 1096.596 (1096.613) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitPageUITests.swift:178: error: -[HabitsUITests.HabitPageUITests testNotesFlows] : Failed to synthesize event: Neither element nor any descendant has keyboard focus. Event dispatch snapshot: TextField, {{32.0, 281.7}, {338.0, 174.3}}, identifier: 'note-field', placeholderValue: 'Write a note'
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitPageUITests.swift:215: error: -[HabitsUITests.HabitPageUITests testSquaresKeyOpensOnlyOnTheFirstVisitToEachHabit] : XCTAssertFalse failed - Next visit: folded
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitPageUITests.swift:218: error: -[HabitsUITests.HabitPageUITests testSquaresKeyOpensOnlyOnTheFirstVisitToEachHabit] : XCTAssertTrue failed - A tap opens it
Test Case '-[HabitsUITests.HabitPageUITests testHistoryFlows]' passed (111.641 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFlows]' failed (125.321 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFoldByMonthLikeHistory]' passed (53.564 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDailyTypes]' passed (306.173 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDark]' passed (134.411 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesPeriodLimitQuit]' passed (249.429 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testSquaresKeyOpensOnlyOnTheFirstVisitToEachHabit]' failed (72.211 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testYearInPixels]' passed (43.846 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testHabitPageDark]' passed (48.380 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCards]' passed (42.033 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCardsDark]' passed (25.798 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testSquaresKeyOpensOnlyOnEachRangesFirstVisit]' passed (37.677 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsDark]' passed (66.318 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsLight]' passed (70.569 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsWithGroups]' passed (19.905 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCards]' passed (66.652 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCardsDark]' passed (31.896 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearScrollAndHabitPage]' passed (56.128 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Today: +1 and day ‹ › | 77.7 | 90 ms | 0 | 12.4 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.6%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 alone | 5.3 | 42 ms | 0 | 12.4 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.6%  closure #1 in AppModel.ensureLoaded() |
| Today: day ‹ › alone | 87.4 | 89 ms | 0 | 12.4 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.6%  closure #1 in AppModel.ensureLoaded() |
| Today: Day sheet scrolling | 82.6 | 546 ms | 1 | 12.4 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.6%  closure #1 in AppModel.ensureLoaded() |
| Timer screen: a running clock | 0.2 | 20 ms | 0 | 12.4 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.6%  closure #1 in AppModel.ensureLoaded() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Today: a row's Day sheet (first): longest stall 1959 ms
- Today: a row's Day sheet (again): longest stall 599 ms
- Today: the note sheet: longest stall 1800 ms
- Today: the timer screen: longest stall 547 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| tap-today | Widgets: one habit's month | 19 | 129 ms | 53.0 ms |
| tap-today | Reminders: plan every alert | 59 | 6 ms | 0.7 ms |
| tap-today | Change: Siri's habit names | 58 | 4 ms | 1.1 ms |
| tap-today | Widgets: the snapshot | 3 | 3 ms | 1.9 ms |
| tap-today | Count: Today's list drawn | 93 | 1 ms | 0.7 ms |
| tap-today | Count: the Day sheet drawn | 16 | 0 ms | 0.0 ms |
| tap-today | Count: a Today row drawn | 409 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's entries drawn | 4 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
