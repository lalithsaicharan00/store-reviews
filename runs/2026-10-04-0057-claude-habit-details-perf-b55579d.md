# claude/habit-details-perf @ b55579d

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37164554299 · 2026-10-04 00:57 UTC
Commit: Today rows: only named accessibility actions on a row's container (a default action or hint merged the texts, so names stopped reading as text); HabitCreation expects +1 for twice a day (U14)

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
| Today: scrolling | 0.0 | 0 ms | 0 | 0.7 % (separate profile) | 0.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.2%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 and day ‹ › | 50.2 | 126 ms | 1 |  | (none above noise) |
| Today: +1 alone | 1.4 | 34 ms | 0 |  | (none above noise) |
| Today: day ‹ › alone | 29.8 | 68 ms | 0 |  | (none above noise) |
| Today: Day sheet scrolling | 32.9 | 217 ms | 1 |  | (none above noise) |
| Today: group filter | 0.6 | 21 ms | 0 |  | (none above noise) |
| Arrange Your Day: scrolling | 10.2 | 169 ms | 1 |  | (none above noise) |
| Arrange Your Day: move Anytime and sort | 4.4 | 37 ms | 0 |  | (none above noise) |
| Today: hide completed on and off | 5.6 | 28 ms | 0 |  | (none above noise) |
| Menu: open and close | 46.9 | 211 ms | 2 |  | (none above noise) |
| All Habits: scrolling | 13.7 | 57 ms | 0 |  | (none above noise) |
| Habit page: History scrolling | 15.1 | 120 ms | 1 |  | (none above noise) |
| Habit page: Progress scrolling | 18.7 | 129 ms | 1 |  | (none above noise) |
| Habit page: switching tabs | 47.5 | 96 ms | 0 |  | (none above noise) |
| Habit page (weekly total): History scrolling | 3.1 | 34 ms | 0 |  | (none above noise) |
| Habit page (weekly total): Progress scrolling | 0.3 | 22 ms | 0 |  | (none above noise) |
| Habit page (quit): History scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Habit page (quit): Progress scrolling | 0.5 | 21 ms | 0 |  | (none above noise) |
| Progress: scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Progress: period ‹ › and range | 50.7 | 85 ms | 0 |  | (none above noise) |
| Progress: key fold and open | 6.3 | 38 ms | 0 |  | (none above noise) |
| Progress Year: sideways | 0.1 | 18 ms | 0 |  | (none above noise) |
| Progress Year: scrolling | 5.4 | 86 ms | 0 |  | (none above noise) |
| Calendar: month ‹ › | 13.4 | 74 ms | 0 |  | (none above noise) |
| Habit form: typing | 8.5 | 67 ms | 0 | 10.2 % (separate profile) | 1.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.3%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Routine player: ‹ › | 15.8 | 60 ms | 0 |  | (none above noise) |
| Day sheet: entry list scrolling | 2.4 | 32 ms | 0 | 18.1 % (separate profile) | 1.6%  perfTimed<A>(_:_:)<br>1.6%  static MainThreadMeter.time<A>(_:_:)<br>1.4%  partial apply for closure #2 in HabitPageView.page(_:)<br>1.4%  HabitPageModel.load(_:tab:store:) |
| Entry editor: typing | 2.2 | 27 ms | 0 | 18.1 % (separate profile) | 1.6%  perfTimed<A>(_:_:)<br>1.6%  static MainThreadMeter.time<A>(_:_:)<br>1.4%  partial apply for closure #2 in HabitPageView.page(_:)<br>1.4%  HabitPageModel.load(_:tab:store:) |
| Day sheet: add, edit and exact undo | 179.1 | 67 ms | 0 | 18.1 % (separate profile) | 1.6%  perfTimed<A>(_:_:)<br>1.6%  static MainThreadMeter.time<A>(_:_:)<br>1.4%  partial apply for closure #2 in HabitPageView.page(_:)<br>1.4%  HabitPageModel.load(_:tab:store:) |
| Log sheet: typing | 2.6 | 35 ms | 0 | 13.7 % (separate profile) | 2.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.7%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.7%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Log sheet: entry list scrolling | 3.1 | 39 ms | 0 | 13.7 % (separate profile) | 2.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.7%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.7%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 11.3 | 36 ms | 0 | 13.7 % (separate profile) | 2.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.7%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.7%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 363.9 | 267 ms | 5 | 13.7 % (separate profile) | 2.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.7%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.7%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Control: typing in a bare number field | 1.0 | 25 ms | 0 |  | (none above noise) |
| Widgets guide: scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Widget: durable amount log and publication | 1.8 | 38 ms | 0 |  | (none above noise) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Today: a row's Day sheet (first): longest stall 1244 ms
- Today: a row's Day sheet (again): longest stall 398 ms
- Today: the note sheet: longest stall 1911 ms
- Arrange Your Day (first): longest stall 662 ms
- Arrange Your Day (again): longest stall 75 ms
- Blank page (control, first): longest stall 208 ms
- Tasks (first): longest stall 247 ms
- Tasks (again): longest stall 129 ms
- Times of Day (first): longest stall 141 ms
- Times of Day (again): longest stall 167 ms
- Day and Week (first): longest stall 232 ms
- Day and Week (again): longest stall 160 ms
- Reminders (first): longest stall 172 ms
- Reminders (again): longest stall 176 ms
- Appearance (first): longest stall 168 ms
- Appearance (again): longest stall 216 ms
- Backup & Export (first): longest stall 333 ms
- Backup & Export (again): longest stall 190 ms
- Privacy (first): longest stall 142 ms
- Privacy (again): longest stall 147 ms
- Plus (first): longest stall 176 ms
- Plus (again): longest stall 165 ms
- Help & Feedback (first): longest stall 288 ms
- Help & Feedback (again): longest stall 146 ms
- About (first): longest stall 252 ms
- About (again): longest stall 118 ms
- Blank page (control, again): longest stall 82 ms
- All Habits (first): longest stall 728 ms
- All Habits (again): longest stall 403 ms
- All Habits: longest stall 493 ms
- Habit page: longest stall 2112 ms
- Habit page: Notes: longest stall 238 ms
- Habit page: Progress: longest stall 149 ms
- All Habits: longest stall 294 ms
- Habit page (weekly total): longest stall 0 ms
- Habit page (weekly total): Progress: longest stall 0 ms
- All Habits: longest stall 270 ms
- Habit page (quit): longest stall 354 ms
- Habit page (quit): Progress: longest stall 132 ms
- All Habits: longest stall 316 ms
- Habit page: longest stall 517 ms
- Edit habit (first): longest stall 618 ms
- Edit habit (again): longest stall 228 ms
- Progress (first): longest stall 454 ms
- Progress (again): longest stall 155 ms
- Progress Year (first): longest stall 582 ms
- Progress Year (again): longest stall 182 ms
- Calendar (first): longest stall 262 ms
- Calendar (again): longest stall 216 ms
- New Habit (first): longest stall 247 ms
- New Habit (again): longest stall 145 ms
- Habit form (first): longest stall 386 ms
- Habit form (again): longest stall 217 ms
- Habit form, no keyboard (first): longest stall 565 ms
- Habit form, no keyboard (again): longest stall 404 ms
- Habit form, the launch's first keyboard: longest stall 1315 ms
- Habit form, keyboard again: longest stall 321 ms
- Routine player (first): longest stall 370 ms
- Routine player (again): longest stall 96 ms
- All Habits: longest stall 236 ms
- Habit page: longest stall 532 ms
- Day sheet (first): longest stall 556 ms
- Day sheet (again): longest stall 331 ms
- Entry editor: longest stall 925 ms
- Save entry: longest stall 547 ms
- All Habits: longest stall 440 ms
- Habit page: longest stall 421 ms
- Day sheet (first): longest stall 558 ms
- Day sheet (again): longest stall 415 ms
- Log sheet: longest stall 433 ms
- Log keyboard dismissal: longest stall 351 ms
- Entry editor: longest stall 550 ms
- Save entry: longest stall 726 ms
- Typing control: longest stall 807 ms
- Widgets guide (first): longest stall 544 ms
- Widgets guide (again): longest stall 172 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| scroll-today | Widgets: one habit's month | 17 | 98 ms | 52.0 ms |
| scroll-today | Reminders: plan every alert | 1 | 1 ms | 1.0 ms |
| scroll-today | Widgets: the snapshot | 1 | 1 ms | 0.9 ms |
| scroll-today | Count: Today's list drawn | 6 | 0 ms | 0.5 ms |
| scroll-today | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| tap-today | Widgets: one habit's month | 18 | 68 ms | 32.5 ms |
| tap-today | Reminders: plan every alert | 57 | 5 ms | 0.5 ms |
| tap-today | Change: Siri's habit names | 56 | 2 ms | 0.2 ms |
| tap-today | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| tap-today | Count: Today's list drawn | 88 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet drawn | 16 | 0 ms | 0.0 ms |
| tap-today | Count: a Today row drawn | 392 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's entries drawn | 5 | 0 ms | 0.0 ms |
| groups | Widgets: one habit's month | 17 | 69 ms | 36.9 ms |
| groups | Reminders: plan every alert | 1 | 1 ms | 0.7 ms |
| groups | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| groups | Count: Today's list drawn | 45 | 0 ms | 0.0 ms |
| groups | Count: a Today row drawn | 246 | 0 ms | 0.0 ms |
| arrange | Widgets: one habit's month | 34 | 96 ms | 35.9 ms |
| arrange | Reminders: plan every alert | 28 | 2 ms | 0.2 ms |
| arrange | Change: Siri's habit names | 27 | 1 ms | 0.1 ms |
| arrange | Arrange: each card's habits | 29 | 1 ms | 0.1 ms |
| arrange | Widgets: the snapshot | 2 | 1 ms | 0.3 ms |
| arrange | Count: Today's list drawn | 43 | 0 ms | 0.0 ms |
| arrange | Count: a Today row drawn | 211 | 0 ms | 0.0 ms |
| arrange | Count: Arrange Your Day drawn | 29 | 0 ms | 0.0 ms |
| menu | Widgets: one habit's month | 17 | 61 ms | 31.9 ms |
| menu | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| menu | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| menu | Count: Today's list drawn | 15 | 0 ms | 0.0 ms |
| menu | Count: a Today row drawn | 66 | 0 ms | 0.0 ms |
| menu-pages | Widgets: one habit's month | 17 | 59 ms | 30.6 ms |
| menu-pages | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| menu-pages | Reminders: plan every alert | 3 | 0 ms | 0.1 ms |
| menu-pages | Count: Today's list drawn | 75 | 0 ms | 0.0 ms |
| menu-pages | Count: a Today row drawn | 291 | 0 ms | 0.0 ms |
| all-habits | Widgets: one habit's month | 17 | 138 ms | 82.7 ms |
| all-habits | Widgets: the snapshot | 1 | 1 ms | 1.0 ms |
| all-habits | Count: Today's list drawn | 10 | 0 ms | 0.1 ms |
| all-habits | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| all-habits | Count: a Today row drawn | 30 | 0 ms | 0.0 ms |
| habit-page | Widgets: one habit's month | 17 | 68 ms | 30.7 ms |
| habit-page | Habit page: history | 1 | 16 ms | 15.8 ms |
| habit-page | Habit page: overall record | 1 | 3 ms | 2.9 ms |
| habit-page | Habit page: milestones | 1 | 1 ms | 1.1 ms |
| habit-page | Widgets: the snapshot | 1 | 1 ms | 0.6 ms |
| habit-page | Count: Today's list drawn | 9 | 0 ms | 0.3 ms |
| habit-page | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-page | Count: a Today row drawn | 30 | 0 ms | 0.0 ms |
| habit-page-total | Widgets: one habit's month | 17 | 99 ms | 54.8 ms |
| habit-page-total | Widgets: the snapshot | 1 | 1 ms | 0.7 ms |
| habit-page-total | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-page-total | Count: Today's list drawn | 7 | 0 ms | 0.0 ms |
| habit-page-total | Count: a Today row drawn | 18 | 0 ms | 0.0 ms |
| habit-page-quit | Widgets: one habit's month | 17 | 52 ms | 25.7 ms |
| habit-page-quit | Habit page: history | 1 | 3 ms | 2.6 ms |
| habit-page-quit | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| habit-page-quit | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| habit-page-quit | Habit page: overall record | 1 | 0 ms | 0.1 ms |
| habit-page-quit | Count: Today's list drawn | 8 | 0 ms | 0.1 ms |
| habit-page-quit | Habit page: milestones | 1 | 0 ms | 0.0 ms |
| habit-page-quit | Count: a Today row drawn | 24 | 0 ms | 0.0 ms |
| habit-edit | Widgets: one habit's month | 17 | 64 ms | 33.1 ms |
| habit-edit | Habit page: history | 1 | 12 ms | 12.1 ms |
| habit-edit | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| habit-edit | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-edit | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| habit-edit | Count: a Today row drawn | 40 | 0 ms | 0.0 ms |
| progress | Widgets: one habit's month | 17 | 74 ms | 41.4 ms |
| progress | Progress year: whole snapshot | 2 | 38 ms | 23.2 ms |
| progress | Progress year: cards | 2 | 38 ms | 23.2 ms |
| progress | Progress year: one card | 30 | 37 ms | 2.8 ms |
| progress | Progress week: whole snapshot | 2 | 10 ms | 7.5 ms |
| progress | Progress week: cards | 2 | 9 ms | 6.7 ms |
| progress | Progress week: one card | 30 | 7 ms | 5.4 ms |
| progress | Progress month: whole snapshot | 2 | 5 ms | 3.2 ms |
| progress | Progress month: cards | 2 | 4 ms | 3.1 ms |
| progress | Progress month: one card | 30 | 4 ms | 0.3 ms |
| progress | Progress week: one quit card | 4 | 0 ms | 0.3 ms |
| progress | Progress year: one quit card | 2 | 0 ms | 0.2 ms |
| progress | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| progress | Progress month: one quit card | 4 | 0 ms | 0.1 ms |
| progress | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| progress | Count: Today's list drawn | 48 | 0 ms | 0.0 ms |
| progress | Count: a Today row drawn | 258 | 0 ms | 0.0 ms |
| progress-year | Widgets: one habit's month | 17 | 106 ms | 50.8 ms |
| progress-year | Progress year: whole snapshot | 1 | 39 ms | 39.5 ms |
| progress-year | Progress year: cards | 1 | 39 ms | 39.1 ms |
| progress-year | Progress year: one card | 15 | 37 ms | 11.3 ms |
| progress-year | Progress week: whole snapshot | 1 | 2 ms | 1.9 ms |
| progress-year | Progress week: cards | 1 | 1 ms | 1.3 ms |
| progress-year | Progress week: one card | 15 | 1 ms | 0.2 ms |
| progress-year | Progress year: one quit card | 2 | 1 ms | 0.5 ms |
| progress-year | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| progress-year | Progress week: one quit card | 2 | 0 ms | 0.2 ms |
| progress-year | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| progress-year | Count: Today's list drawn | 13 | 0 ms | 0.0 ms |
| progress-year | Count: a Today row drawn | 45 | 0 ms | 0.0 ms |
| calendar | Widgets: one habit's month | 17 | 62 ms | 33.3 ms |
| calendar | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| calendar | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| calendar | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| calendar | Count: a Today row drawn | 36 | 0 ms | 0.0 ms |
| new-habit | Widgets: one habit's month | 17 | 51 ms | 24.0 ms |
| new-habit | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| new-habit | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| new-habit | Count: Today's list drawn | 13 | 0 ms | 0.0 ms |
| new-habit | Count: a Today row drawn | 76 | 0 ms | 0.0 ms |
| form-parts | Widgets: one habit's month | 17 | 82 ms | 46.1 ms |
| form-parts | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| form-parts | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| form-parts | Count: Today's list drawn | 12 | 0 ms | 0.0 ms |
| form-parts | Count: a Today row drawn | 81 | 0 ms | 0.0 ms |
| player | Widgets: one habit's month | 18 | 79 ms | 38.4 ms |
| player | Widgets: the snapshot | 2 | 2 ms | 1.8 ms |
| player | Reminders: plan every alert | 38 | 2 ms | 0.1 ms |
| player | Change: Siri's habit names | 37 | 2 ms | 0.1 ms |
| player | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| player | Count: a Today row drawn | 24 | 0 ms | 0.0 ms |
| day-sheet | Habit page: history | 146 | 784 ms | 11.4 ms |
| day-sheet | Widgets: one habit's month | 17 | 65 ms | 29.8 ms |
| day-sheet | Change: Siri's habit names | 145 | 5 ms | 0.1 ms |
| day-sheet | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| day-sheet | Reminders: plan every alert | 3 | 0 ms | 0.1 ms |
| day-sheet | Count: Today's list drawn | 10 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet drawn | 156 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet's entries drawn | 56 | 0 ms | 0.0 ms |
| day-sheet | Count: a Today row drawn | 177 | 0 ms | 0.0 ms |
| day-sheet | Entry editor: whole editor drawn | 8 | 0 ms | 0.0 ms |
| log-sheet | Habit page: history | 146 | 1075 ms | 17.8 ms |
| log-sheet | Widgets: one habit's month | 17 | 74 ms | 37.2 ms |
| log-sheet | Change: Siri's habit names | 145 | 8 ms | 0.2 ms |
| log-sheet | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| log-sheet | Reminders: plan every alert | 3 | 0 ms | 0.1 ms |
| log-sheet | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| log-sheet | Entry editor: whole editor drawn | 7 | 0 ms | 0.0 ms |
| log-sheet | Count: the Day sheet drawn | 165 | 0 ms | 0.0 ms |
| log-sheet | Count: a Today row drawn | 177 | 0 ms | 0.0 ms |
| log-sheet | Count: the Day sheet's entries drawn | 63 | 0 ms | 0.0 ms |
| typing-control | Widgets: one habit's month | 17 | 119 ms | 70.1 ms |
| typing-control | Widgets: the snapshot | 1 | 1 ms | 0.9 ms |
| typing-control | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| typing-control | Count: Today's list drawn | 10 | 0 ms | 0.0 ms |
| typing-control | Count: a Today row drawn | 33 | 0 ms | 0.0 ms |
| widget-guide | Widgets: one habit's month | 17 | 129 ms | 63.3 ms |
| widget-guide | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| widget-guide | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| widget-guide | Count: Today's list drawn | 12 | 0 ms | 0.1 ms |
| widget-guide | Count: a Today row drawn | 39 | 0 ms | 0.0 ms |
| widget-log | Widgets: one habit's month | 40 | 184 ms | 57.3 ms |
| widget-log | Widgets: the snapshot | 24 | 12 ms | 1.4 ms |
| widget-log | Reminders: plan every alert | 52 | 4 ms | 0.7 ms |
| widget-log | Change: Siri's habit names | 54 | 3 ms | 0.7 ms |
| widget-log | Count: Today's list drawn | 7 | 0 ms | 0.0 ms |
| widget-log | Count: a Today row drawn | 159 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
