# claude/progress-week-cards @ 75133cb

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37001497708 · 2026-10-02 12:26 UTC
Commit: Progress Week: a card per habit, dates bar pinned, no overview or rings [ios-ci] [ios-perf]

- Core storage and migrations: success
- Build: success
- Release build: skipped
- Same-build speed baseline: skipped
- UI tests (TodayUITests,TimerUITests,ProgressUITests,GroupsUITests,UndoUITests): failure
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 2 failures (0 unexpected) in 209.772 (209.785) seconds
	 Executed 2 tests, with 0 failures (0 unexpected) in 63.790 (63.792) seconds
	 Executed 33 tests, with 3 failures (0 unexpected) in 1185.732 (1185.778) seconds
	 Executed 33 tests, with 3 failures (0 unexpected) in 1185.732 (1185.783) seconds
	 Executed 5 tests, with 1 failure (0 unexpected) in 356.530 (356.541) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 261.456 (261.462) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 294.185 (294.194) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/GroupsUITests.swift:25: error: -[HabitsUITests.GroupsUITests testFirstGroupFromFilter] : Failed to terminate com.oftenenough.app:19782: Failed to terminate com.oftenenough.app:0
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ProgressUITests.swift:156: error: -[HabitsUITests.ProgressUITests testHidePercentages] : XCTAssertTrue failed - Percentages show by default
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ProgressUITests.swift:194: error: -[HabitsUITests.ProgressUITests testLogSlipAndUndo] : XCTAssertTrue failed - The Quitting row
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (56.324 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (112.365 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' failed (65.072 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (83.770 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (38.999 seconds).
Test Case '-[HabitsUITests.ProgressUITests testDaySheetShowsOnToday]' passed (22.891 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (14.856 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndRuns]' passed (23.485 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' failed (20.350 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' failed (17.839 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (25.945 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (22.214 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (9.801 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtOverTime]' passed (30.185 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (22.206 seconds).
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (28.031 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (35.759 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (24.533 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (43.300 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (23.083 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (32.998 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (14.863 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (104.219 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (14.523 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (36.665 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (37.238 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (48.039 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (34.956 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds]' passed (45.306 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (20.774 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (23.423 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (36.458 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (15.262 seconds).
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Today: scrolling | 23.9 | 193 ms | 2 | 8.6 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.9%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 and day ‹ › | 70.4 | 167 ms | 1 |  | (none above noise) |
| Today: group filter | 6.4 | 50 ms | 0 |  | (none above noise) |
| Menu: open and close | 103.1 | 473 ms | 8 |  | (none above noise) |
| All Habits: scrolling | 8.6 | 47 ms | 0 |  | (none above noise) |
| Habit page: scrolling | 29.5 | 241 ms | 2 |  | (none above noise) |
| Habit page (weekly total): scrolling | 5.3 | 41 ms | 0 |  | (none above noise) |
| Habit page (quit): scrolling | 9.9 | 92 ms | 0 |  | (none above noise) |
| Progress: scrolling | 14.2 | 57 ms | 0 |  | (none above noise) |
| Progress: period ‹ › and range | 196.7 | 311 ms | 11 |  | (none above noise) |
| Calendar: month ‹ › | 7.7 | 95 ms | 0 |  | (none above noise) |
| Habit form: typing | 17.1 | 84 ms | 0 | 9.0 % (separate profile) | 2.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.7%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.7%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Routine player: ‹ › | 16.9 | 71 ms | 0 |  | (none above noise) |
| Day sheet: entry list scrolling | 0.4 | 23 ms | 0 | 15.9 % (separate profile) | 2.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 68.6 | 66 ms | 0 | 15.9 % (separate profile) | 2.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 36.1 | 46 ms | 0 | 15.9 % (separate profile) | 2.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Log sheet: typing | 70.0 | 55 ms | 0 | 12.6 % (separate profile) | 1.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Log sheet: entry list scrolling | 1.7 | 40 ms | 0 | 12.6 % (separate profile) | 1.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 36.6 | 48 ms | 0 | 12.6 % (separate profile) | 1.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 50.5 | 187 ms | 1 | 12.6 % (separate profile) | 1.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Widgets guide: scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Widget: durable amount log and publication | 0.0 | 0 ms | 0 |  | (none above noise) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Blank page (control, first): longest stall 306 ms
- Tasks (first): longest stall 276 ms
- Tasks (again): longest stall 237 ms
- Times of Day (first): longest stall 306 ms
- Times of Day (again): longest stall 301 ms
- Day and Week (first): longest stall 430 ms
- Day and Week (again): longest stall 209 ms
- Reminders (first): longest stall 548 ms
- Reminders (again): longest stall 272 ms
- Appearance (first): longest stall 321 ms
- Appearance (again): longest stall 247 ms
- Backup & Export (first): longest stall 355 ms
- Backup & Export (again): longest stall 272 ms
- Privacy (first): longest stall 211 ms
- Privacy (again): longest stall 322 ms
- Plus (first): longest stall 145 ms
- Plus (again): longest stall 140 ms
- Help & Feedback (first): longest stall 460 ms
- Help & Feedback (again): longest stall 285 ms
- About (first): longest stall 234 ms
- About (again): longest stall 293 ms
- Blank page (control, again): longest stall 181 ms
- All Habits (first): longest stall 461 ms
- All Habits (again): longest stall 225 ms
- All Habits: longest stall 486 ms
- Habit page: longest stall 466 ms
- All Habits: longest stall 390 ms
- Habit page (weekly total): longest stall 0 ms
- All Habits: longest stall 651 ms
- Habit page (quit): longest stall 1769 ms
- All Habits: longest stall 506 ms
- Habit page: longest stall 550 ms
- Edit habit (first): longest stall 568 ms
- Edit habit (again): longest stall 288 ms
- Progress (first): longest stall 710 ms
- Progress (again): longest stall 241 ms
- Calendar (first): longest stall 609 ms
- Calendar (again): longest stall 239 ms
- New Habit (first): longest stall 621 ms
- New Habit (again): longest stall 177 ms
- Habit form (first): longest stall 1587 ms
- Habit form (again): longest stall 381 ms
- Habit form, no keyboard (first): longest stall 537 ms
- Habit form, no keyboard (again): longest stall 296 ms
- Habit form, the launch's first keyboard: longest stall 617 ms
- Habit form, keyboard again: longest stall 293 ms
- Routine player (first): longest stall 539 ms
- Routine player (again): longest stall 130 ms
- All Habits: longest stall 275 ms
- Habit page: longest stall 439 ms
- Day sheet (first): longest stall 456 ms
- Day sheet (again): longest stall 318 ms
- Entry editor: longest stall 838 ms
- Save entry: longest stall 514 ms
- All Habits: longest stall 465 ms
- Habit page: longest stall 469 ms
- Day sheet (first): longest stall 420 ms
- Day sheet (again): longest stall 324 ms
- Log sheet: longest stall 452 ms
- Log keyboard dismissal: longest stall 161 ms
- Entry editor: longest stall 451 ms
- Save entry: longest stall 911 ms
- Widgets guide (first): longest stall 420 ms
- Widgets guide (again): longest stall 124 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| progress | Progress year: whole snapshot | 2 | 79 ms | 48.5 ms |
| progress | Progress year: one habit's row | 30 | 43 ms | 4.0 ms |
| progress | Progress week: whole snapshot | 2 | 33 ms | 27.2 ms |
| progress | Progress month: whole snapshot | 2 | 15 ms | 10.5 ms |
| progress | Progress year: day scores | 2 | 14 ms | 13.9 ms |
| progress | Progress week: cards | 2 | 13 ms | 7.6 ms |
| progress | Progress year: row dots | 2 | 8 ms | 3.9 ms |
| progress | Progress week: one card | 30 | 7 ms | 3.5 ms |
| progress | Progress year: previous period | 1 | 6 ms | 6.0 ms |
| progress | Progress month: day scores | 2 | 4 ms | 3.7 ms |
| progress | Progress month: one habit's row | 30 | 3 ms | 0.5 ms |
| progress | Progress month: previous period | 2 | 3 ms | 2.1 ms |
| progress | Progress week: one quit card | 4 | 1 ms | 0.8 ms |
| progress | Progress year: one quit row | 2 | 0 ms | 0.2 ms |
| progress | Progress year: one habit's goals | 1 | 0 ms | 0.2 ms |
| progress | Progress: earliest day | 4 | 0 ms | 0.1 ms |
| progress | Progress month: one quit row | 4 | 0 ms | 0.1 ms |
| progress | Progress month: one habit's goals | 2 | 0 ms | 0.1 ms |
