# details-page-update @ 4ebea87

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37202400309 · 2026-10-04 13:27 UTC
Commit: Day details and Edit Log: build the 4 Oct handoff natively

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (DayDetailsUITests,TodayRowSheetUITests,TodayRowLayoutUITests,UndoUITests,HabitPageUITests,GoalFlowUITests): failure
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 36 tests, with 3 failures (0 unexpected) in 2045.318 (2045.354) seconds
	 Executed 36 tests, with 3 failures (0 unexpected) in 2045.318 (2045.356) seconds
	 Executed 4 tests, with 2 failures (0 unexpected) in 88.001 (88.005) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 148.163 (148.167) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 389.146 (389.150) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 759.180 (759.186) seconds
	 Executed 6 tests, with 1 failure (0 unexpected) in 465.434 (465.441) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 195.395 (195.400) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/DayDetailsUITests.swift:218: error: -[HabitsUITests.DayDetailsUITests testEditLogAsksBeforeLosingOrDeleting] : XCTAssertTrue failed - with its unit
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayRowLayoutUITests.swift:123: error: -[HabitsUITests.TodayRowLayoutUITests testTaskRowOpensItsSheet] : XCTAssertTrue failed - The menu closes
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayRowLayoutUITests.swift:125: error: -[HabitsUITests.TodayRowLayoutUITests testTaskRowOpensItsSheet] : Failed to not hittable: Button, {{16.0, 384.0}, {370.0, 52.0}}, identifier: 'day-done', label: 'Mark done'
Test Case '-[HabitsUITests.DayDetailsUITests testEditLogAsksBeforeLosingOrDeleting]' failed (150.396 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindDark]' passed (79.798 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindShowsItsOwnDay]' passed (109.823 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testMultiCheckRecordEditsItsCount]' passed (36.247 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testQuitSlipRecordEditAndDelete]' passed (35.928 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testSkippedDayKeepsLogsAndNote]' passed (53.240 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testButtonAddsItsStepAndRowOpensAddAmount]' passed (104.031 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testHowOftenChoicesSayTheAmount]' passed (51.006 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testNumberShowsWithoutAUnit]' passed (43.960 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testOwnStep]' passed (73.082 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testTypingKeyByKey]' passed (85.148 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testUnitScreen]' passed (31.918 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testHistoryFlows]' passed (51.120 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFlows]' passed (39.795 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDailyTypes]' passed (287.848 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDark]' passed (121.763 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesPeriodLimitQuit]' passed (220.800 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testYearInPixels]' passed (37.854 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testAfterLogButtonsAndNoteSheet]' passed (35.560 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testOneLineUnderEveryName]' passed (10.983 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testQuitRowSwipeLogsASlip]' passed (18.806 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testTaskRowOpensItsSheet]' failed (22.652 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testLongPressMenu]' passed (17.678 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testRowOpensDaySheetForEveryKind]' passed (36.238 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetActionsAndDeleteInTheMenu]' passed (31.631 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetFollowsTheDayShown]' passed (20.362 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSwipeActions]' passed (26.023 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testTickTogglesAndPlusAdds]' passed (16.231 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (28.247 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (33.560 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (26.812 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds]' passed (36.357 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (17.142 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (15.727 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (23.567 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (13.983 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Day sheet: entry list scrolling | 2.8 | 26 ms | 0 | 14.4 % (separate profile) | 1.3%  perfTimed<A>(_:_:)<br>1.3%  static MainThreadMeter.time<A>(_:_:)<br>1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A) |
| Entry editor: typing | 26.5 | 70 ms | 0 | 14.4 % (separate profile) | 1.3%  perfTimed<A>(_:_:)<br>1.3%  static MainThreadMeter.time<A>(_:_:)<br>1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A) |
| Day sheet: add, edit and exact undo | 117.9 | 83 ms | 0 | 14.4 % (separate profile) | 1.3%  perfTimed<A>(_:_:)<br>1.3%  static MainThreadMeter.time<A>(_:_:)<br>1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A) |
| Log sheet: typing | 7.8 | 33 ms | 0 | 13.5 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  perfTimed<A>(_:_:)<br>1.2%  static MainThreadMeter.time<A>(_:_:) |
| Log sheet: entry list scrolling | 5.1 | 61 ms | 0 | 13.5 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  perfTimed<A>(_:_:)<br>1.2%  static MainThreadMeter.time<A>(_:_:) |
| Entry editor: typing | 39.7 | 84 ms | 0 | 13.5 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  perfTimed<A>(_:_:)<br>1.2%  static MainThreadMeter.time<A>(_:_:) |
| Day sheet: add, edit and exact undo | 157.9 | 148 ms | 2 | 13.5 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  perfTimed<A>(_:_:)<br>1.2%  static MainThreadMeter.time<A>(_:_:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- All Habits: longest stall 231 ms
- Habit page: longest stall 499 ms
- Day sheet (first): longest stall 326 ms
- Day sheet (again): longest stall 176 ms
- Entry editor: longest stall 945 ms
- Save entry: longest stall 331 ms
- All Habits: longest stall 311 ms
- Habit page: longest stall 365 ms
- Day sheet (first): longest stall 340 ms
- Day sheet (again): longest stall 283 ms
- Log sheet: longest stall 418 ms
- Log keyboard dismissal: longest stall 168 ms
- Entry editor: longest stall 511 ms
- Save entry: longest stall 414 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| day-sheet | Habit page: history | 146 | 703 ms | 10.4 ms |
| day-sheet | Widgets: one habit's month | 17 | 67 ms | 37.2 ms |
| day-sheet | Change: Siri's habit names | 145 | 5 ms | 0.2 ms |
| day-sheet | Widgets: the snapshot | 1 | 1 ms | 1.2 ms |
| day-sheet | Count: a Today row drawn | 201 | 1 ms | 0.9 ms |
| day-sheet | Reminders: plan every alert | 3 | 0 ms | 0.1 ms |
| day-sheet | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet drawn | 149 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet's activity drawn | 198 | 0 ms | 0.0 ms |
| day-sheet | Entry editor: whole editor drawn | 63 | 0 ms | 0.0 ms |
| log-sheet | Habit page: history | 146 | 707 ms | 13.0 ms |
| log-sheet | Widgets: one habit's month | 18 | 91 ms | 33.7 ms |
| log-sheet | Change: Siri's habit names | 145 | 5 ms | 0.1 ms |
| log-sheet | Widgets: the snapshot | 2 | 3 ms | 2.4 ms |
| log-sheet | Reminders: plan every alert | 3 | 0 ms | 0.2 ms |
| log-sheet | Count: Today's list drawn | 9 | 0 ms | 0.1 ms |
| log-sheet | Count: a Today row drawn | 201 | 0 ms | 0.0 ms |
| log-sheet | Count: the Day sheet drawn | 152 | 0 ms | 0.0 ms |
| log-sheet | Count: the Day sheet's activity drawn | 201 | 0 ms | 0.0 ms |
| log-sheet | Count: the Day sheet's entries drawn | 4 | 0 ms | 0.0 ms |
| log-sheet | Entry editor: whole editor drawn | 63 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
