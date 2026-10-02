# claude/server-and-sync @ 02ee25f

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36951672347 · 2026-10-02 02:05 UTC
Commit: Speed: Today's rows open one sheet each again, duration rows keep one clock host on every day, the day count redraws alone

- Core storage and migrations: success
- Build: success
- UI tests (TodayUITests,TimerUITests,UndoUITests): failure
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 18 tests, with 3 failures (0 unexpected) in 808.743 (808.767) seconds
	 Executed 18 tests, with 3 failures (0 unexpected) in 808.743 (808.769) seconds
	 Executed 2 tests, with 0 failures (0 unexpected) in 133.561 (133.566) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 457.162 (457.173) seconds
	 Executed 8 tests, with 3 failures (0 unexpected) in 218.020 (218.025) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayUITests.swift:198: error: -[HabitsUITests.TodayUITests testDoneRowWaitsForThePause] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayUITests.swift:222: error: -[HabitsUITests.TodayUITests testDoneRowStaysInPlace] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayUITests.swift:37: error: -[HabitsUITests.TodayUITests testTodayScreen] : XCTAssertTrue failed
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (40.323 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (93.238 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (20.174 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (39.310 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' failed (18.446 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' failed (17.896 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (11.308 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (91.844 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (10.350 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' failed (8.693 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (29.809 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (110.991 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (101.708 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds]' passed (44.489 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (20.365 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (49.615 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (79.805 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (20.378 seconds).
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Today: scrolling | 20.7 | 326 ms | 1 | 7.7 % (separate profile) | 1.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.8%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Today: +1 and day ‹ › | 141.4 | 245 ms | 3 | 11.0 % (separate profile) | 1.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.8%  closure #1 in AppModel.ensureLoaded() |
| Progress: scrolling | 0.0 | 0 ms | 0 | 8.9 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Progress: period ‹ › and range | 203.7 | 1320 ms | 7 | 8.9 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Progress (first): longest stall 454 ms
- Progress (again): longest stall 216 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| progress | Progress year: whole snapshot | 2 | 67 ms | 45.4 ms |
| progress | Progress year: one habit's row | 30 | 37 ms | 2.5 ms |
| progress | Progress week: whole snapshot | 2 | 17 ms | 15.3 ms |
| progress | Progress year: day scores | 2 | 12 ms | 11.9 ms |
| progress | Progress month: whole snapshot | 2 | 12 ms | 6.8 ms |
| progress | Progress year: previous period | 1 | 8 ms | 7.9 ms |
| progress | Progress week: day scores | 2 | 7 ms | 6.4 ms |
| progress | Progress month: one habit's row | 30 | 5 ms | 0.5 ms |
| progress | Progress year: row dots | 2 | 5 ms | 2.8 ms |
| progress | Progress week: one habit's row | 30 | 4 ms | 3.2 ms |
| progress | Progress month: previous period | 2 | 2 ms | 1.2 ms |
| progress | Progress week: previous period | 2 | 1 ms | 0.6 ms |
| progress | Progress month: day scores | 2 | 1 ms | 0.8 ms |
| progress | Progress month: one quit row | 4 | 0 ms | 0.1 ms |
| progress | Progress week: one quit row | 4 | 0 ms | 0.2 ms |
| progress | Progress year: one habit's goals | 1 | 0 ms | 0.3 ms |
| progress | Progress: earliest day | 6 | 0 ms | 0.1 ms |
| progress | Progress year: one quit row | 2 | 0 ms | 0.1 ms |
| progress | Progress month: one habit's goals | 2 | 0 ms | 0.1 ms |
| progress | Progress week: one habit's goals | 2 | 0 ms | 0.0 ms |
