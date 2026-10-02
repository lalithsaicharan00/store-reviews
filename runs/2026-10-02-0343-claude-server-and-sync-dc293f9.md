# claude/server-and-sync @ dc293f9

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36959652086 · 2026-10-02 03:43 UTC
Commit: Speed: a row's note line, milestone and Undo are their own small view, as is its note flash

- Core storage and migrations: success
- Build: success
- UI tests (TodayUITests,UndoUITests): success
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 16 tests, with 0 failures (0 unexpected) in 678.943 (678.961) seconds
	 Executed 16 tests, with 0 failures (0 unexpected) in 678.943 (678.963) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 328.238 (328.243) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 350.705 (350.715) seconds
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (44.983 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (96.568 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (23.112 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (27.449 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (12.952 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (97.839 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (13.299 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (34.503 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (32.702 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (55.318 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (52.241 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds]' passed (104.851 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (20.648 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (17.519 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (31.801 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (13.159 seconds).
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Today: +1 and day ‹ › | 122.9 | 136 ms | 2 | 9.3 % (separate profile) | 1.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.6%  closure #1 in AppModel.ensureLoaded() |
| Today: scrolling | 2.7 | 47 ms | 0 | 7.8 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.7%  closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

