# claude/progress-week-cards @ a3590fd

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37013592699 · 2026-10-02 14:31 UTC
Commit: Quit cards: days still to come show as due later this week, not as not scheduled

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (TodayUITests,TimerUITests,ProgressUITests,GroupsUITests,UndoUITests): success
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 246.154 (246.163) seconds
	 Executed 2 tests, with 0 failures (0 unexpected) in 53.120 (53.122) seconds
	 Executed 33 tests, with 0 failures (0 unexpected) in 1092.092 (1092.123) seconds
	 Executed 33 tests, with 0 failures (0 unexpected) in 1092.092 (1092.124) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 328.007 (328.016) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 214.534 (214.539) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 250.277 (250.280) seconds
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (37.771 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (86.366 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' passed (94.641 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (73.288 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (35.942 seconds).
Test Case '-[HabitsUITests.ProgressUITests testDaySheetShowsOnToday]' passed (24.498 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (12.973 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndRuns]' passed (18.733 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (28.463 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (50.571 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (23.141 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (29.337 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (10.822 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtOverTime]' passed (31.687 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (15.930 seconds).
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (23.065 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (30.055 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (20.247 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (39.389 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (18.394 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (24.239 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (12.266 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (93.103 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (10.866 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (31.774 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (31.573 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (33.771 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (30.077 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds]' passed (38.269 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (19.131 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (18.942 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (29.907 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (12.865 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Today: scrolling | 19.4 | 191 ms | 1 | 4.3 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.6%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 and day ‹ › | 34.7 | 57 ms | 0 |  | (none above noise) |
| Today: group filter | 0.0 | 0 ms | 0 |  | (none above noise) |
| Menu: open and close | 55.1 | 194 ms | 1 |  | (none above noise) |
| All Habits: scrolling | 11.8 | 32 ms | 0 |  | (none above noise) |
| Habit page: scrolling | 22.3 | 183 ms | 2 |  | (none above noise) |
| Habit page (weekly total): scrolling | 7.9 | 40 ms | 0 |  | (none above noise) |
| Habit page (quit): scrolling | 1.0 | 26 ms | 0 |  | (none above noise) |
| Progress: scrolling | 4.2 | 31 ms | 0 |  | (none above noise) |
| Progress: period ‹ › and range | 216.6 | 394 ms | 14 |  | (none above noise) |
| Calendar: month ‹ › | 8.2 | 37 ms | 0 |  | (none above noise) |
| Habit form: typing | 15.5 | 65 ms | 0 | 14.6 % (separate profile) | 4.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>4.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>3.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>3.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Routine player: ‹ › | 25.6 | 64 ms | 0 |  | (none above noise) |
| Day sheet: entry list scrolling | 0.7 | 22 ms | 0 | 10.7 % (separate profile) | 1.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.2%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 35.3 | 50 ms | 0 | 10.7 % (separate profile) | 1.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.2%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 38.4 | 52 ms | 0 | 10.7 % (separate profile) | 1.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.2%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Log sheet: typing | 68.8 | 61 ms | 0 | 14.6 % (separate profile) | 1.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Log sheet: entry list scrolling | 3.0 | 46 ms | 0 | 14.6 % (separate profile) | 1.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 61.5 | 64 ms | 0 | 14.6 % (separate profile) | 1.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 60.6 | 178 ms | 1 | 14.6 % (separate profile) | 1.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Widgets guide: scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Widget: durable amount log and publication | 0.2 | 19 ms | 0 |  | (none above noise) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Blank page (control, first): longest stall 209 ms
- Tasks (first): longest stall 229 ms
- Tasks (again): longest stall 138 ms
- Times of Day (first): longest stall 133 ms
- Times of Day (again): longest stall 135 ms
- Day and Week (first): longest stall 271 ms
- Day and Week (again): longest stall 179 ms
- Reminders (first): longest stall 231 ms
- Reminders (again): longest stall 258 ms
- Appearance (first): longest stall 242 ms
- Appearance (again): longest stall 174 ms
- Backup & Export (first): longest stall 186 ms
- Backup & Export (again): longest stall 160 ms
- Privacy (first): longest stall 161 ms
- Privacy (again): longest stall 201 ms
- Plus (first): longest stall 103 ms
- Plus (again): longest stall 100 ms
- Help & Feedback (first): longest stall 809 ms
- Help & Feedback (again): longest stall 290 ms
- About (first): longest stall 249 ms
- About (again): longest stall 151 ms
- Blank page (control, again): longest stall 74 ms
- All Habits (first): longest stall 582 ms
- All Habits (again): longest stall 301 ms
- All Habits: longest stall 260 ms
- Habit page: longest stall 440 ms
- All Habits: longest stall 237 ms
- Habit page (weekly total): longest stall 0 ms
- All Habits: longest stall 213 ms
- Habit page (quit): longest stall 563 ms
- All Habits: longest stall 393 ms
- Habit page: longest stall 412 ms
- Edit habit (first): longest stall 831 ms
- Edit habit (again): longest stall 314 ms
- Progress (first): longest stall 494 ms
- Progress (again): longest stall 162 ms
- Calendar (first): longest stall 410 ms
- Calendar (again): longest stall 207 ms
- New Habit (first): longest stall 386 ms
- New Habit (again): longest stall 219 ms
- Habit form (first): longest stall 1372 ms
- Habit form (again): longest stall 365 ms
- Habit form, no keyboard (first): longest stall 838 ms
- Habit form, no keyboard (again): longest stall 347 ms
- Habit form, the launch's first keyboard: longest stall 1162 ms
- Habit form, keyboard again: longest stall 255 ms
- Routine player (first): longest stall 607 ms
- Routine player (again): longest stall 126 ms
- All Habits: longest stall 183 ms
- Habit page: longest stall 337 ms
- Day sheet (first): longest stall 402 ms
- Day sheet (again): longest stall 210 ms
- Entry editor: longest stall 914 ms
- Save entry: longest stall 295 ms
- All Habits: longest stall 385 ms
- Habit page: longest stall 415 ms
- Day sheet (first): longest stall 529 ms
- Day sheet (again): longest stall 287 ms
- Log sheet: longest stall 547 ms
- Log keyboard dismissal: longest stall 193 ms
- Entry editor: longest stall 577 ms
- Save entry: longest stall 655 ms
- Widgets guide (first): longest stall 435 ms
- Widgets guide (again): longest stall 216 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| progress | Progress year: whole snapshot | 2 | 88 ms | 53.2 ms |
| progress | Progress year: one habit's row | 30 | 50 ms | 3.7 ms |
| progress | Progress month: whole snapshot | 2 | 25 ms | 13.0 ms |
| progress | Progress year: day scores | 2 | 12 ms | 11.8 ms |
| progress | Progress week: whole snapshot | 2 | 12 ms | 9.4 ms |
| progress | Progress year: row dots | 2 | 11 ms | 6.7 ms |
| progress | Progress month: previous period | 2 | 9 ms | 7.7 ms |
| progress | Progress year: previous period | 1 | 6 ms | 6.4 ms |
| progress | Progress week: cards | 2 | 6 ms | 4.1 ms |
| progress | Progress month: one habit's row | 30 | 5 ms | 0.8 ms |
| progress | Progress week: one card | 30 | 3 ms | 0.8 ms |
| progress | Progress month: day scores | 2 | 3 ms | 2.9 ms |
| progress | Progress week: one quit card | 4 | 1 ms | 0.7 ms |
| progress | Progress year: one habit's goals | 1 | 0 ms | 0.3 ms |
| progress | Progress month: one quit row | 4 | 0 ms | 0.1 ms |
| progress | Progress year: one quit row | 2 | 0 ms | 0.1 ms |
| progress | Progress: earliest day | 4 | 0 ms | 0.0 ms |
| progress | Progress month: one habit's goals | 2 | 0 ms | 0.1 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
