# claude/timer-swipe-limits-and-fixes @ 95310e2

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37214813652 · 2026-10-04 16:37 UTC
Commit: Timers: ▶ starts the timer and opens it full screen (a swipe puts it away while it keeps running); the bar opens it; the Live Activity gets Pause and opens that timer; switches for both (Current Work 16 and 15)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (TimerUITests,UndoUITests,FocusPlayerUITests,TodayUITests): failure
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 13 tests, with 1 failure (0 unexpected) in 494.462 (494.483) seconds
	 Executed 34 tests, with 2 failures (0 unexpected) in 1173.940 (1173.983) seconds
	 Executed 34 tests, with 2 failures (0 unexpected) in 1173.940 (1173.988) seconds
	 Executed 5 tests, with 1 failure (0 unexpected) in 129.113 (129.118) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 250.076 (250.081) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 300.289 (300.298) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/FocusPlayerUITests.swift:91: error: -[HabitsUITests.FocusPlayerUITests testCountCheckAndUndoStayOnTheCurrentHabit] : XCTAssertEqual failed: ("3 / 3") is not equal to ("2 / 3")
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TimerUITests.swift:76: error: -[HabitsUITests.TimerUITests testPlayOpensTimerScreenThatClosesWithoutStopping] : XCTAssertTrue failed - A swipe down puts it away
Test Case '-[HabitsUITests.FocusPlayerUITests testBottomRowStaysPutAndOptionsShowEverything]' passed (58.971 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testChecklistPreservesPriorStepsAndQueueCanRevisit]' passed (32.674 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCompactProgressAcrossPeriodsAndTypes]' passed (66.532 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCountCheckAndUndoStayOnTheCurrentHabit]' failed (72.889 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLargeTextKeepsActionsAndChecklistReachable]' passed (41.294 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLimitCheckInNeverLogsConsumptionOrCompletesTheDay]' passed (27.045 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testManualTimePausesAndClockCanBeHidden]' passed (35.559 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testNavigationDoesNotWaitForSlowTimerWrites]' passed (20.895 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSavedFocusProgressSurvivesTermination]' passed (35.810 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSectionWithOnlyALimitStillHasStart]' passed (12.551 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerDayBoundaryAndExactUndoPersistence]' passed (6.426 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerGoalDoesNotAutoAdvanceAndManualLogIsReachable]' passed (43.616 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerPauseBackgroundAndSkipPreserveTime]' passed (40.199 seconds).
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (30.464 seconds).
Test Case '-[HabitsUITests.TimerUITests testPlayOpensTimerScreenThatClosesWithoutStopping]' failed (32.200 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (31.572 seconds).
Test Case '-[HabitsUITests.TimerUITests testScreenCanBeTurnedOff]' passed (13.103 seconds).
Test Case '-[HabitsUITests.TimerUITests testTimerScreenPauseKeepsTimeAndResumes]' passed (21.774 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (27.079 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (42.851 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (27.502 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (31.764 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (16.826 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (106.087 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (13.901 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (34.280 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (50.077 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (41.050 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (35.125 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds]' passed (40.221 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (19.325 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (18.145 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (34.019 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (12.113 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Today: +1 and day ‹ › | 75.8 | 83 ms | 0 | 8.1 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.6%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 alone | 0.7 | 28 ms | 0 | 8.1 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.6%  closure #1 in AppModel.ensureLoaded() |
| Today: day ‹ › alone | 76.2 | 118 ms | 1 | 8.1 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.6%  closure #1 in AppModel.ensureLoaded() |
| Today: Day sheet scrolling | 47.0 | 122 ms | 1 | 8.1 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.6%  closure #1 in AppModel.ensureLoaded() |
| Timer screen: a running clock | 5.6 | 50 ms | 0 | 8.1 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.6%  closure #1 in AppModel.ensureLoaded() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Today: a row's Day sheet (first): longest stall 1568 ms
- Today: a row's Day sheet (again): longest stall 873 ms
- Today: the note sheet: longest stall 1533 ms
- Today: the timer screen: longest stall 801 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| tap-today | Widgets: one habit's month | 19 | 90 ms | 34.6 ms |
| tap-today | Widgets: the snapshot | 3 | 5 ms | 3.4 ms |
| tap-today | Reminders: plan every alert | 57 | 3 ms | 0.2 ms |
| tap-today | Change: Siri's habit names | 57 | 2 ms | 0.1 ms |
| tap-today | Count: a Today row drawn | 633 | 0 ms | 0.3 ms |
| tap-today | Reminders: build requests | 57 | 0 ms | 0.0 ms |
| tap-today | Count: Today's list drawn | 93 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet drawn | 15 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's entries drawn | 6 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
