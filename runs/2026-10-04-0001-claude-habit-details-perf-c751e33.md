# claude/habit-details-perf @ c751e33

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37161185249 · 2026-10-04 00:01 UTC
Commit: Today's rows, one shape: one line under every name (what today asks: how far along, or how often, then the time; tasks say Task; quit rows their best run), after-log Undo and Add/Edit Note as small capsules on one line, notes in their own sheet with Save, a task's row opens a task sheet (Done, date, Do Tomorrow), done habits move down again

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (none): skipped
- Speed tests: success
- Speed tests through XCTest: skipped

## Release build
```
** BUILD SUCCEEDED **
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Today: scrolling | 16.4 | 110 ms | 1 | 1.7 % (separate profile) | 0.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.4%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 and day ‹ › | 38.4 | 81 ms | 0 |  | (none above noise) |
| Today: +1 alone | 1.7 | 43 ms | 0 |  | (none above noise) |
| Today: day ‹ › alone | 58.1 | 84 ms | 0 |  | (none above noise) |
| Today: Day sheet scrolling | 17.8 | 33 ms | 0 |  | (none above noise) |
| Today: group filter | 3.7 | 33 ms | 0 |  | (none above noise) |
| Arrange Your Day: scrolling | 3.8 | 52 ms | 0 |  | (none above noise) |
| Arrange Your Day: move Anytime and sort | 0.5 | 24 ms | 0 |  | (none above noise) |
| Today: hide completed on and off | 15.4 | 44 ms | 0 |  | (none above noise) |
| Menu: open and close | 36.3 | 137 ms | 1 |  | (none above noise) |
| All Habits: scrolling | 6.4 | 30 ms | 0 |  | (none above noise) |
| Habit page: History scrolling | 6.7 | 67 ms | 0 |  | (none above noise) |
| Habit page: Progress scrolling | 11.6 | 108 ms | 1 |  | (none above noise) |
| Habit page: switching tabs | 41.0 | 103 ms | 1 |  | (none above noise) |
| Habit page (weekly total): History scrolling | 2.0 | 30 ms | 0 |  | (none above noise) |
| Habit page (weekly total): Progress scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Habit page (quit): History scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Habit page (quit): Progress scrolling | 1.3 | 28 ms | 0 |  | (none above noise) |
| Progress: scrolling | 24.1 | 51 ms | 0 |  | (none above noise) |
| Progress: period ‹ › and range | 119.9 | 152 ms | 5 |  | (none above noise) |
| Progress: key fold and open | 25.1 | 54 ms | 0 |  | (none above noise) |
| Progress Year: sideways | 0.0 | 0 ms | 0 |  | (none above noise) |
| Progress Year: scrolling | 20.3 | 58 ms | 0 |  | (none above noise) |
| Calendar: month ‹ › | 10.7 | 32 ms | 0 |  | (none above noise) |
| Habit form: typing | 46.0 | 422 ms | 2 | 12.9 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.8%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Routine player: ‹ › | 17.7 | 62 ms | 0 |  | (none above noise) |
| Day sheet: entry list scrolling | 6.1 | 72 ms | 0 | 13.0 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 1.5 | 31 ms | 0 | 13.0 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 130.7 | 74 ms | 0 | 13.0 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Log sheet: typing | 8.8 | 26 ms | 0 | 20.0 % (separate profile) | 2.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.3%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>2.3%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Log sheet: entry list scrolling | 5.0 | 63 ms | 0 | 20.0 % (separate profile) | 2.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.3%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>2.3%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 0.9 | 25 ms | 0 | 20.0 % (separate profile) | 2.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.3%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>2.3%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 180.0 | 191 ms | 1 | 20.0 % (separate profile) | 2.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.3%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>2.3%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Control: typing in a bare number field | 0.0 | 0 ms | 0 |  | (none above noise) |
| Widgets guide: scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Widget: durable amount log and publication | 0.2 | 20 ms | 0 |  | (none above noise) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Today: a row's Day sheet (first): longest stall 834 ms
- Today: a row's Day sheet (again): longest stall 483 ms
- Today: the note sheet: longest stall 1750 ms
- Arrange Your Day (first): longest stall 208 ms
- Arrange Your Day (again): longest stall 80 ms
- Blank page (control, first): longest stall 175 ms
- Tasks (first): longest stall 220 ms
- Tasks (again): longest stall 216 ms
- Times of Day (first): longest stall 251 ms
- Times of Day (again): longest stall 183 ms
- Day and Week (first): longest stall 443 ms
- Day and Week (again): longest stall 200 ms
- Reminders (first): longest stall 364 ms
- Reminders (again): longest stall 303 ms
- Appearance (first): longest stall 330 ms
- Appearance (again): longest stall 316 ms
- Backup & Export (first): longest stall 295 ms
- Backup & Export (again): longest stall 366 ms
- Privacy (first): longest stall 238 ms
- Privacy (again): longest stall 174 ms
- Plus (first): longest stall 162 ms
- Plus (again): longest stall 157 ms
- Help & Feedback (first): longest stall 577 ms
- Help & Feedback (again): longest stall 324 ms
- About (first): longest stall 296 ms
- About (again): longest stall 282 ms
- Blank page (control, again): longest stall 134 ms
- All Habits (first): longest stall 400 ms
- All Habits (again): longest stall 312 ms
- All Habits: longest stall 366 ms
- Habit page: longest stall 1733 ms
- Habit page: Notes: longest stall 141 ms
- Habit page: Progress: longest stall 248 ms
- All Habits: longest stall 421 ms
- Habit page (weekly total): longest stall 0 ms
- Habit page (weekly total): Progress: longest stall 0 ms
- All Habits: longest stall 180 ms
- Habit page (quit): longest stall 313 ms
- Habit page (quit): Progress: longest stall 202 ms
- All Habits: longest stall 303 ms
- Habit page: longest stall 567 ms
- Edit habit (first): longest stall 845 ms
- Edit habit (again): longest stall 363 ms
- Progress (first): longest stall 1339 ms
- Progress (again): longest stall 246 ms
- Progress Year (first): longest stall 714 ms
- Progress Year (again): longest stall 202 ms
- Calendar (first): longest stall 384 ms
- Calendar (again): longest stall 279 ms
- New Habit (first): longest stall 497 ms
- New Habit (again): longest stall 223 ms
- Habit form (first): longest stall 863 ms
- Habit form (again): longest stall 365 ms
- Habit form, no keyboard (first): longest stall 731 ms
- Habit form, no keyboard (again): longest stall 234 ms
- Habit form, the launch's first keyboard: longest stall 456 ms
- Habit form, keyboard again: longest stall 340 ms
- Routine player (first): longest stall 471 ms
- Routine player (again): longest stall 158 ms
- All Habits: longest stall 435 ms
- Habit page: longest stall 399 ms
- Day sheet (first): longest stall 494 ms
- Day sheet (again): longest stall 375 ms
- Entry editor: longest stall 803 ms
- Save entry: longest stall 324 ms
- All Habits: longest stall 506 ms
- Habit page: longest stall 574 ms
- Day sheet (first): longest stall 757 ms
- Day sheet (again): longest stall 486 ms
- Log sheet: longest stall 630 ms
- Log keyboard dismissal: longest stall 181 ms
- Entry editor: longest stall 553 ms
- Save entry: longest stall 389 ms
- Typing control: longest stall 551 ms
- Widgets guide (first): longest stall 379 ms
- Widgets guide (again): longest stall 207 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| scroll-today | Widgets: one habit's month | 17 | 94 ms | 38.7 ms |
| scroll-today | Reminders: plan every alert | 1 | 1 ms | 1.0 ms |
| scroll-today | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| scroll-today | Count: Today's list drawn | 6 | 0 ms | 0.0 ms |
| scroll-today | Count: a Today row drawn | 40 | 0 ms | 0.0 ms |
| tap-today | Widgets: one habit's month | 18 | 73 ms | 40.0 ms |
| tap-today | Reminders: plan every alert | 57 | 3 ms | 0.1 ms |
| tap-today | Change: Siri's habit names | 56 | 2 ms | 0.3 ms |
| tap-today | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| tap-today | Count: Today's list drawn | 93 | 0 ms | 0.0 ms |
| tap-today | Count: a Today row drawn | 782 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet drawn | 12 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's entries drawn | 4 | 0 ms | 0.0 ms |
| groups | Widgets: one habit's month | 17 | 62 ms | 32.2 ms |
| groups | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| groups | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| groups | Count: Today's list drawn | 44 | 0 ms | 0.0 ms |
| groups | Count: a Today row drawn | 602 | 0 ms | 0.0 ms |
| arrange | Widgets: one habit's month | 34 | 94 ms | 31.2 ms |
| arrange | Reminders: plan every alert | 28 | 2 ms | 0.2 ms |
| arrange | Arrange: each card's habits | 29 | 1 ms | 0.1 ms |
| arrange | Change: Siri's habit names | 27 | 1 ms | 0.1 ms |
| arrange | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| arrange | Count: Today's list drawn | 41 | 0 ms | 0.0 ms |
| arrange | Count: a Today row drawn | 506 | 0 ms | 0.0 ms |
| arrange | Count: Arrange Your Day drawn | 29 | 0 ms | 0.0 ms |
| menu | Widgets: one habit's month | 17 | 95 ms | 45.7 ms |
| menu | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| menu | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| menu | Count: Today's list drawn | 6 | 0 ms | 0.0 ms |
| menu | Count: a Today row drawn | 40 | 0 ms | 0.0 ms |
| menu-pages | Widgets: one habit's month | 17 | 66 ms | 32.9 ms |
| menu-pages | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| menu-pages | Reminders: plan every alert | 3 | 0 ms | 0.1 ms |
| menu-pages | Count: Today's list drawn | 74 | 0 ms | 0.0 ms |
| menu-pages | Count: a Today row drawn | 686 | 0 ms | 0.0 ms |
| all-habits | Widgets: one habit's month | 17 | 84 ms | 42.9 ms |
| all-habits | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| all-habits | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| all-habits | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| all-habits | Count: a Today row drawn | 87 | 0 ms | 0.0 ms |
| habit-page | Widgets: one habit's month | 17 | 119 ms | 82.1 ms |
| habit-page | Habit page: history | 1 | 11 ms | 11.0 ms |
| habit-page | Habit page: overall record | 1 | 8 ms | 8.3 ms |
| habit-page | Habit page: milestones | 1 | 3 ms | 2.8 ms |
| habit-page | Reminders: plan every alert | 1 | 1 ms | 1.0 ms |
| habit-page | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| habit-page | Count: Today's list drawn | 9 | 0 ms | 0.3 ms |
| habit-page | Count: a Today row drawn | 78 | 0 ms | 0.0 ms |
| habit-page-total | Widgets: one habit's month | 17 | 109 ms | 47.9 ms |
| habit-page-total | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| habit-page-total | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-page-total | Count: Today's list drawn | 7 | 0 ms | 0.0 ms |
| habit-page-total | Count: a Today row drawn | 48 | 0 ms | 0.0 ms |
| habit-page-quit | Widgets: one habit's month | 17 | 71 ms | 35.3 ms |
| habit-page-quit | Habit page: history | 1 | 2 ms | 1.9 ms |
| habit-page-quit | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| habit-page-quit | Habit page: overall record | 1 | 0 ms | 0.3 ms |
| habit-page-quit | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-page-quit | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| habit-page-quit | Habit page: milestones | 1 | 0 ms | 0.0 ms |
| habit-page-quit | Count: a Today row drawn | 55 | 0 ms | 0.0 ms |
| habit-edit | Widgets: one habit's month | 17 | 87 ms | 46.2 ms |
| habit-edit | Habit page: history | 1 | 11 ms | 10.6 ms |
| habit-edit | Widgets: the snapshot | 1 | 1 ms | 0.9 ms |
| habit-edit | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-edit | Count: Today's list drawn | 9 | 0 ms | 0.1 ms |
| habit-edit | Count: a Today row drawn | 88 | 0 ms | 0.0 ms |
| progress | Widgets: one habit's month | 17 | 97 ms | 37.3 ms |
| progress | Progress year: whole snapshot | 2 | 57 ms | 35.8 ms |
| progress | Progress year: cards | 2 | 57 ms | 35.7 ms |
| progress | Progress year: one card | 30 | 54 ms | 3.9 ms |
| progress | Progress week: whole snapshot | 2 | 25 ms | 18.6 ms |
| progress | Progress week: cards | 2 | 23 ms | 17.7 ms |
| progress | Progress week: one card | 30 | 19 ms | 12.8 ms |
| progress | Progress month: whole snapshot | 2 | 7 ms | 5.3 ms |
| progress | Progress month: cards | 2 | 7 ms | 5.1 ms |
| progress | Progress month: one card | 30 | 6 ms | 0.5 ms |
| progress | Progress week: one quit card | 4 | 1 ms | 0.7 ms |
| progress | Progress year: one quit card | 2 | 0 ms | 0.3 ms |
| progress | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| progress | Progress month: one quit card | 4 | 0 ms | 0.1 ms |
| progress | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| progress | Count: Today's list drawn | 49 | 0 ms | 0.0 ms |
| progress | Count: a Today row drawn | 651 | 0 ms | 0.0 ms |
| progress-year | Widgets: one habit's month | 17 | 124 ms | 65.7 ms |
| progress-year | Progress year: whole snapshot | 1 | 45 ms | 44.9 ms |
| progress-year | Progress year: cards | 1 | 45 ms | 44.7 ms |
| progress-year | Progress year: one card | 15 | 41 ms | 10.3 ms |
| progress-year | Progress week: whole snapshot | 1 | 3 ms | 3.3 ms |
| progress-year | Progress week: cards | 1 | 3 ms | 3.0 ms |
| progress-year | Progress week: one card | 15 | 2 ms | 0.3 ms |
| progress-year | Progress year: one quit card | 2 | 1 ms | 0.9 ms |
| progress-year | Widgets: the snapshot | 1 | 1 ms | 0.9 ms |
| progress-year | Reminders: plan every alert | 1 | 1 ms | 0.6 ms |
| progress-year | Progress week: one quit card | 2 | 0 ms | 0.2 ms |
| progress-year | Count: Today's list drawn | 14 | 0 ms | 0.0 ms |
| progress-year | Count: a Today row drawn | 132 | 0 ms | 0.0 ms |
| calendar | Widgets: one habit's month | 17 | 71 ms | 36.7 ms |
| calendar | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| calendar | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| calendar | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| calendar | Count: a Today row drawn | 94 | 0 ms | 0.0 ms |
| new-habit | Widgets: one habit's month | 17 | 106 ms | 59.5 ms |
| new-habit | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| new-habit | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| new-habit | Count: Today's list drawn | 13 | 0 ms | 0.0 ms |
| new-habit | Count: a Today row drawn | 148 | 0 ms | 0.0 ms |
| form-parts | Widgets: one habit's month | 17 | 90 ms | 58.6 ms |
| form-parts | Widgets: the snapshot | 1 | 1 ms | 0.5 ms |
| form-parts | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| form-parts | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| form-parts | Count: a Today row drawn | 148 | 0 ms | 0.0 ms |
| player | Widgets: one habit's month | 18 | 101 ms | 54.8 ms |
| player | Widgets: the snapshot | 2 | 5 ms | 4.0 ms |
| player | Reminders: plan every alert | 38 | 2 ms | 0.1 ms |
| player | Change: Siri's habit names | 37 | 1 ms | 0.1 ms |
| player | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| player | Count: a Today row drawn | 80 | 0 ms | 0.0 ms |
| day-sheet | Habit page: history | 146 | 681 ms | 12.7 ms |
| day-sheet | Widgets: one habit's month | 17 | 64 ms | 33.0 ms |
| day-sheet | Change: Siri's habit names | 145 | 5 ms | 0.1 ms |
| day-sheet | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| day-sheet | Reminders: plan every alert | 3 | 0 ms | 0.2 ms |
| day-sheet | Count: Today's list drawn | 10 | 0 ms | 0.0 ms |
| day-sheet | Count: a Today row drawn | 233 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet drawn | 153 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet's entries drawn | 54 | 0 ms | 0.0 ms |
| day-sheet | Entry editor: whole editor drawn | 8 | 0 ms | 0.0 ms |
| log-sheet | Habit page: history | 146 | 790 ms | 11.3 ms |
| log-sheet | Widgets: one habit's month | 17 | 98 ms | 47.6 ms |
| log-sheet | Change: Siri's habit names | 145 | 6 ms | 0.1 ms |
| log-sheet | Widgets: the snapshot | 1 | 1 ms | 0.7 ms |
| log-sheet | Reminders: plan every alert | 3 | 0 ms | 0.1 ms |
| log-sheet | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| log-sheet | Count: a Today row drawn | 225 | 0 ms | 0.0 ms |
| log-sheet | Count: the Day sheet drawn | 158 | 0 ms | 0.0 ms |
| log-sheet | Count: the Day sheet's entries drawn | 58 | 0 ms | 0.0 ms |
| log-sheet | Entry editor: whole editor drawn | 7 | 0 ms | 0.0 ms |
| typing-control | Widgets: one habit's month | 17 | 149 ms | 96.7 ms |
| typing-control | Widgets: the snapshot | 1 | 0 ms | 0.5 ms |
| typing-control | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| typing-control | Count: Today's list drawn | 10 | 0 ms | 0.1 ms |
| typing-control | Count: a Today row drawn | 79 | 0 ms | 0.0 ms |
| widget-guide | Widgets: one habit's month | 17 | 61 ms | 32.2 ms |
| widget-guide | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| widget-guide | Reminders: plan every alert | 2 | 0 ms | 0.1 ms |
| widget-guide | Count: Today's list drawn | 11 | 0 ms | 0.1 ms |
| widget-guide | Count: a Today row drawn | 36 | 0 ms | 0.0 ms |
| widget-log | Widgets: one habit's month | 40 | 144 ms | 43.7 ms |
| widget-log | Widgets: the snapshot | 24 | 11 ms | 1.0 ms |
| widget-log | Reminders: plan every alert | 51 | 3 ms | 0.2 ms |
| widget-log | Change: Siri's habit names | 54 | 2 ms | 0.1 ms |
| widget-log | Count: Today's list drawn | 7 | 0 ms | 0.0 ms |
| widget-log | Count: a Today row drawn | 153 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
