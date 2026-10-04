# details-page-update @ b5492ee

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37205960716 · 2026-10-04 14:24 UTC
Commit: Edit Log typing back to one redraw; 31 wireframe states as screenshots

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (DayDetailsScreenshotUITests,DayDetailsUITests,TodayRowLayoutUITests,UndoUITests): failure
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 31 tests, with 1 failure (0 unexpected) in 890.947 (890.976) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 133.575 (133.581) seconds
	 Executed 49 tests, with 1 failure (0 unexpected) in 1692.222 (1692.279) seconds
	 Executed 49 tests, with 1 failure (0 unexpected) in 1692.222 (1692.280) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 402.041 (402.048) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 265.659 (265.666) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/DayDetailsScreenshotUITests.swift:43: error: -[HabitsUITests.DayDetailsScreenshotUITests test17_taskWithNote] : XCTAssertTrue failed - Test's Day details open
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test01_dailyCheckUndone]' passed (39.672 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test02_dailyCheckDone]' passed (59.166 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test03_weeklyCheck]' passed (23.865 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test04_repeatedChecks]' passed (76.323 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test05_checklist]' passed (22.121 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test06_monthlyCheck]' passed (16.488 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test07_amountGoal]' passed (14.294 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test08_amountLimit]' passed (15.476 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test09_timeGoal]' passed (15.773 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test10_quitNoSlip]' passed (16.537 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test11_quitWithSlip]' passed (33.614 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test12_limitExceeded]' passed (19.867 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test13_timerRunning]' passed (28.784 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test14_oneTimeTask]' passed (14.250 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test15_pastDay]' passed (12.283 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test16_managementMenuLight]' passed (23.873 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test17_taskWithNote]' failed (46.737 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test18_taskDone]' passed (24.525 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test19_skippedDay]' passed (23.579 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test20_pausedDay]' passed (19.598 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test21_skippedAmountKeepsLogsAndNote]' passed (27.910 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test22_waterAmount]' passed (24.883 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test23_coffeeLimitAmount]' passed (40.181 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test24_readDuration]' passed (24.179 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test25_fractionalTimer]' passed (26.016 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test26_multiCheckLog]' passed (26.708 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test27_quitSlipDateTime]' passed (37.065 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test28_deleteConfirmation]' passed (35.963 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test29_waterLightMode]' passed (28.978 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test30_minutesFocused]' passed (33.607 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test31_slipTimeDraft]' passed (38.633 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEditLogAsksBeforeLosingOrDeleting]' passed (62.188 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindDark]' passed (71.288 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindShowsItsOwnDay]' passed (133.783 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testMultiCheckRecordEditsItsCount]' passed (41.204 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testQuitSlipRecordEditAndDelete]' passed (39.673 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testSkippedDayKeepsLogsAndNote]' passed (53.905 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testAfterLogButtonsAndNoteSheet]' passed (50.538 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testOneLineUnderEveryName]' passed (22.085 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testQuitRowSwipeLogsASlip]' passed (22.764 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testTaskRowOpensItsSheet]' passed (38.189 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (37.765 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (45.952 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (35.686 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds]' passed (58.204 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (20.880 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (24.144 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (28.427 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (14.602 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Day sheet: entry list scrolling | 1.7 | 24 ms | 0 | 14.8 % (separate profile) | 1.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  perfTimed<A>(_:_:)<br>1.3%  static MainThreadMeter.time<A>(_:_:) |
| Entry editor: typing | 5.7 | 97 ms | 0 | 14.8 % (separate profile) | 1.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  perfTimed<A>(_:_:)<br>1.3%  static MainThreadMeter.time<A>(_:_:) |
| Day sheet: add, edit and exact undo | 267.7 | 136 ms | 2 | 14.8 % (separate profile) | 1.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  perfTimed<A>(_:_:)<br>1.3%  static MainThreadMeter.time<A>(_:_:) |
| Log sheet: typing | 6.8 | 27 ms | 0 | 17.6 % (separate profile) | 2.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Log sheet: entry list scrolling | 5.0 | 64 ms | 0 | 17.6 % (separate profile) | 2.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 7.4 | 52 ms | 0 | 17.6 % (separate profile) | 2.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 360.4 | 216 ms | 15 | 17.6 % (separate profile) | 2.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.9%  closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- All Habits: longest stall 633 ms
- Habit page: longest stall 723 ms
- Day sheet (first): longest stall 499 ms
- Day sheet (again): longest stall 267 ms
- Entry editor: longest stall 1324 ms
- Save entry: longest stall 504 ms
- All Habits: longest stall 543 ms
- Habit page: longest stall 563 ms
- Day sheet (first): longest stall 410 ms
- Day sheet (again): longest stall 291 ms
- Log sheet: longest stall 502 ms
- Log keyboard dismissal: longest stall 212 ms
- Entry editor: longest stall 506 ms
- Save entry: longest stall 503 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| day-sheet | Habit page: history | 149 | 980 ms | 17.4 ms |
| day-sheet | Widgets: one habit's month | 17 | 106 ms | 68.8 ms |
| day-sheet | Change: Siri's habit names | 148 | 6 ms | 0.1 ms |
| day-sheet | Reminders: plan every alert | 3 | 1 ms | 0.3 ms |
| day-sheet | Count: Today's list drawn | 9 | 0 ms | 0.4 ms |
| day-sheet | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| day-sheet | Count: the Day sheet drawn | 156 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet's activity drawn | 206 | 0 ms | 0.0 ms |
| day-sheet | Count: a Today row drawn | 204 | 0 ms | 0.0 ms |
| day-sheet | Entry editor: whole editor drawn | 8 | 0 ms | 0.0 ms |
| log-sheet | Habit page: history | 146 | 972 ms | 19.2 ms |
| log-sheet | Widgets: one habit's month | 18 | 164 ms | 74.9 ms |
| log-sheet | Change: Siri's habit names | 145 | 10 ms | 1.6 ms |
| log-sheet | Widgets: the snapshot | 2 | 6 ms | 5.6 ms |
| log-sheet | Reminders: plan every alert | 3 | 0 ms | 0.1 ms |
| log-sheet | Count: Today's list drawn | 9 | 0 ms | 0.1 ms |
| log-sheet | Count: the Day sheet drawn | 148 | 0 ms | 0.0 ms |
| log-sheet | Count: a Today row drawn | 195 | 0 ms | 0.0 ms |
| log-sheet | Count: the Day sheet's activity drawn | 197 | 0 ms | 0.0 ms |
| log-sheet | Count: the Day sheet's entries drawn | 6 | 0 ms | 0.0 ms |
| log-sheet | Entry editor: whole editor drawn | 8 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
