# claude/habit-details-perf @ 396c40e

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37173648190 · 2026-10-04 04:01 UTC
Commit: After-log line: one layout instead of ViewThatFits (it measured three layouts each time the line appeared and doubled the cost of changing days: 72 vs 14 ms/s, bisected side by side); Rulebook S10 and lesson L21

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
| Today: scrolling | 0.0 | 0 ms | 0 | 0.6 % (separate profile) | 0.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.0%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.0%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 and day ‹ › | 64.2 | 129 ms | 1 |  | (none above noise) |
| Today: +1 alone | 3.1 | 38 ms | 0 |  | (none above noise) |
| Today: day ‹ › alone | 62.8 | 101 ms | 1 |  | (none above noise) |
| Today: Day sheet scrolling | 90.9 | 345 ms | 4 |  | (none above noise) |
| Today: group filter | 27.5 | 51 ms | 0 |  | (none above noise) |
| Arrange Your Day: scrolling | 17.3 | 84 ms | 0 |  | (none above noise) |
| Arrange Your Day: move Anytime and sort | 22.9 | 97 ms | 0 |  | (none above noise) |
| Today: hide completed on and off | 56.9 | 79 ms | 0 |  | (none above noise) |
| Menu: open and close | 113.7 | 353 ms | 12 |  | (none above noise) |
| All Habits: scrolling | 14.5 | 72 ms | 0 |  | (none above noise) |
| Habit page: History scrolling | 13.5 | 132 ms | 1 |  | (none above noise) |
| Habit page: Progress scrolling | 26.3 | 159 ms | 2 |  | (none above noise) |
| Habit page: switching tabs | 59.2 | 141 ms | 1 |  | (none above noise) |
| Habit page (weekly total): History scrolling | 6.3 | 33 ms | 0 |  | (none above noise) |
| Habit page (weekly total): Progress scrolling | 7.5 | 29 ms | 0 |  | (none above noise) |
| Habit page (quit): History scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Habit page (quit): Progress scrolling | 4.3 | 42 ms | 0 |  | (none above noise) |
| Progress: scrolling | 10.0 | 77 ms | 0 |  | (none above noise) |
| Progress: period ‹ › and range | 125.0 | 142 ms | 6 |  | (none above noise) |
| Progress: key fold and open | 19.5 | 58 ms | 0 |  | (none above noise) |
| Progress Year: sideways | 0.0 | 0 ms | 0 |  | (none above noise) |
| Progress Year: scrolling | 21.9 | 98 ms | 0 |  | (none above noise) |
| Calendar: month ‹ › | 8.6 | 33 ms | 0 |  | (none above noise) |
| Habit form: typing | 9.3 | 50 ms | 0 | 7.1 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.2%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Routine player: ‹ › | 14.5 | 48 ms | 0 |  | (none above noise) |
| Day sheet: entry list scrolling | 5.7 | 57 ms | 0 | 18.2 % (separate profile) | 1.8%  perfTimed<A>(_:_:)<br>1.8%  static MainThreadMeter.time<A>(_:_:)<br>1.5%  partial apply for closure #2 in HabitPageView.page(_:)<br>1.5%  HabitPageModel.load(_:tab:store:) |
| Entry editor: typing | 3.9 | 45 ms | 0 | 18.2 % (separate profile) | 1.8%  perfTimed<A>(_:_:)<br>1.8%  static MainThreadMeter.time<A>(_:_:)<br>1.5%  partial apply for closure #2 in HabitPageView.page(_:)<br>1.5%  HabitPageModel.load(_:tab:store:) |
| Day sheet: add, edit and exact undo | 129.8 | 62 ms | 0 | 18.2 % (separate profile) | 1.8%  perfTimed<A>(_:_:)<br>1.8%  static MainThreadMeter.time<A>(_:_:)<br>1.5%  partial apply for closure #2 in HabitPageView.page(_:)<br>1.5%  HabitPageModel.load(_:tab:store:) |
| Log sheet: typing | 7.2 | 127 ms | 1 | 16.5 % (separate profile) | 1.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Log sheet: entry list scrolling | 1.0 | 31 ms | 0 | 16.5 % (separate profile) | 1.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 0.8 | 22 ms | 0 | 16.5 % (separate profile) | 1.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 188.1 | 193 ms | 2 | 16.5 % (separate profile) | 1.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Control: typing in a bare number field | 0.0 | 0 ms | 0 |  | (none above noise) |
| Widgets guide: scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Widget: durable amount log and publication | 0.6 | 26 ms | 0 |  | (none above noise) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Today: a row's Day sheet (first): longest stall 1111 ms
- Today: a row's Day sheet (again): longest stall 586 ms
- Today: the note sheet: longest stall 2623 ms
- Arrange Your Day (first): longest stall 501 ms
- Arrange Your Day (again): longest stall 265 ms
- Blank page (control, first): longest stall 199 ms
- Tasks (first): longest stall 387 ms
- Tasks (again): longest stall 183 ms
- Times of Day (first): longest stall 240 ms
- Times of Day (again): longest stall 243 ms
- Day and Week (first): longest stall 585 ms
- Day and Week (again): longest stall 273 ms
- Reminders (first): longest stall 335 ms
- Reminders (again): longest stall 182 ms
- Appearance (first): longest stall 362 ms
- Appearance (again): longest stall 347 ms
- Backup & Export (first): longest stall 290 ms
- Backup & Export (again): longest stall 230 ms
- Privacy (first): longest stall 223 ms
- Privacy (again): longest stall 218 ms
- Plus (first): longest stall 263 ms
- Plus (again): longest stall 152 ms
- Help & Feedback (first): longest stall 383 ms
- Help & Feedback (again): longest stall 215 ms
- About (first): longest stall 276 ms
- About (again): longest stall 244 ms
- Blank page (control, again): longest stall 160 ms
- All Habits (first): longest stall 674 ms
- All Habits (again): longest stall 323 ms
- All Habits: longest stall 869 ms
- Habit page: longest stall 2746 ms
- Habit page: Notes: longest stall 196 ms
- Habit page: Progress: longest stall 187 ms
- All Habits: longest stall 734 ms
- Habit page (weekly total): longest stall 0 ms
- Habit page (weekly total): Progress: longest stall 0 ms
- All Habits: longest stall 612 ms
- Habit page (quit): longest stall 648 ms
- Habit page (quit): Progress: longest stall 217 ms
- All Habits: longest stall 397 ms
- Habit page: longest stall 512 ms
- Edit habit (first): longest stall 798 ms
- Edit habit (again): longest stall 328 ms
- Progress (first): longest stall 610 ms
- Progress (again): longest stall 177 ms
- Progress Year (first): longest stall 827 ms
- Progress Year (again): longest stall 198 ms
- Calendar (first): longest stall 418 ms
- Calendar (again): longest stall 202 ms
- New Habit (first): longest stall 449 ms
- New Habit (again): longest stall 168 ms
- Habit form (first): longest stall 729 ms
- Habit form (again): longest stall 409 ms
- Habit form, no keyboard (first): longest stall 498 ms
- Habit form, no keyboard (again): longest stall 308 ms
- Habit form, the launch's first keyboard: longest stall 305 ms
- Habit form, keyboard again: longest stall 420 ms
- Routine player (first): longest stall 598 ms
- Routine player (again): longest stall 166 ms
- All Habits: longest stall 358 ms
- Habit page: longest stall 567 ms
- Day sheet (first): longest stall 1113 ms
- Day sheet (again): longest stall 456 ms
- Entry editor: longest stall 980 ms
- Save entry: longest stall 308 ms
- All Habits: longest stall 292 ms
- Habit page: longest stall 533 ms
- Day sheet (first): longest stall 418 ms
- Day sheet (again): longest stall 255 ms
- Log sheet: longest stall 342 ms
- Log keyboard dismissal: longest stall 49 ms
- Entry editor: longest stall 366 ms
- Save entry: longest stall 670 ms
- Typing control: longest stall 669 ms
- Widgets guide (first): longest stall 372 ms
- Widgets guide (again): longest stall 156 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| scroll-today | Widgets: one habit's month | 17 | 98 ms | 41.9 ms |
| scroll-today | Reminders: plan every alert | 1 | 1 ms | 1.0 ms |
| scroll-today | Widgets: the snapshot | 1 | 1 ms | 0.8 ms |
| scroll-today | Count: Today's list drawn | 6 | 0 ms | 0.0 ms |
| scroll-today | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| tap-today | Widgets: one habit's month | 18 | 130 ms | 44.8 ms |
| tap-today | Reminders: plan every alert | 56 | 4 ms | 0.2 ms |
| tap-today | Change: Siri's habit names | 55 | 2 ms | 0.1 ms |
| tap-today | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| tap-today | Count: Today's list drawn | 88 | 0 ms | 0.1 ms |
| tap-today | Count: a Today row drawn | 383 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet drawn | 8 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's entries drawn | 3 | 0 ms | 0.0 ms |
| groups | Widgets: one habit's month | 17 | 118 ms | 68.5 ms |
| groups | Reminders: plan every alert | 1 | 6 ms | 6.2 ms |
| groups | Count: Today's list drawn | 45 | 1 ms | 0.6 ms |
| groups | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| groups | Count: a Today row drawn | 246 | 0 ms | 0.0 ms |
| arrange | Widgets: one habit's month | 34 | 166 ms | 60.9 ms |
| arrange | Arrange: each card's habits | 29 | 3 ms | 1.0 ms |
| arrange | Reminders: plan every alert | 26 | 3 ms | 0.3 ms |
| arrange | Change: Siri's habit names | 27 | 2 ms | 0.1 ms |
| arrange | Widgets: the snapshot | 2 | 2 ms | 0.8 ms |
| arrange | Count: Today's list drawn | 38 | 0 ms | 0.1 ms |
| arrange | Count: a Today row drawn | 181 | 0 ms | 0.0 ms |
| arrange | Count: Arrange Your Day drawn | 29 | 0 ms | 0.0 ms |
| menu | Widgets: one habit's month | 17 | 96 ms | 51.3 ms |
| menu | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| menu | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| menu | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| menu | Count: a Today row drawn | 30 | 0 ms | 0.0 ms |
| menu-pages | Widgets: one habit's month | 17 | 195 ms | 129.8 ms |
| menu-pages | Widgets: the snapshot | 1 | 1 ms | 0.9 ms |
| menu-pages | Reminders: plan every alert | 3 | 0 ms | 0.3 ms |
| menu-pages | Count: Today's list drawn | 83 | 0 ms | 0.0 ms |
| menu-pages | Count: a Today row drawn | 339 | 0 ms | 0.0 ms |
| all-habits | Widgets: one habit's month | 17 | 104 ms | 63.1 ms |
| all-habits | Widgets: the snapshot | 1 | 1 ms | 1.1 ms |
| all-habits | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| all-habits | Count: Today's list drawn | 10 | 0 ms | 0.0 ms |
| all-habits | Count: a Today row drawn | 30 | 0 ms | 0.0 ms |
| habit-page | Widgets: one habit's month | 17 | 189 ms | 122.0 ms |
| habit-page | Habit page: history | 1 | 17 ms | 16.8 ms |
| habit-page | Habit page: overall record | 1 | 13 ms | 12.8 ms |
| habit-page | Habit page: milestones | 1 | 2 ms | 2.3 ms |
| habit-page | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| habit-page | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-page | Count: Today's list drawn | 10 | 0 ms | 0.0 ms |
| habit-page | Count: a Today row drawn | 33 | 0 ms | 0.0 ms |
| habit-page-total | Widgets: one habit's month | 17 | 101 ms | 52.1 ms |
| habit-page-total | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| habit-page-total | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-page-total | Count: Today's list drawn | 7 | 0 ms | 0.0 ms |
| habit-page-total | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| habit-page-quit | Widgets: one habit's month | 17 | 162 ms | 95.8 ms |
| habit-page-quit | Habit page: history | 1 | 2 ms | 2.0 ms |
| habit-page-quit | Widgets: the snapshot | 1 | 1 ms | 0.9 ms |
| habit-page-quit | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| habit-page-quit | Habit page: overall record | 1 | 0 ms | 0.2 ms |
| habit-page-quit | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| habit-page-quit | Habit page: milestones | 1 | 0 ms | 0.0 ms |
| habit-page-quit | Count: a Today row drawn | 24 | 0 ms | 0.0 ms |
| habit-edit | Widgets: one habit's month | 17 | 105 ms | 50.1 ms |
| habit-edit | Habit page: history | 1 | 10 ms | 9.8 ms |
| habit-edit | Widgets: the snapshot | 1 | 1 ms | 0.7 ms |
| habit-edit | Reminders: plan every alert | 1 | 0 ms | 0.3 ms |
| habit-edit | Count: Today's list drawn | 9 | 0 ms | 0.1 ms |
| habit-edit | Count: a Today row drawn | 37 | 0 ms | 0.0 ms |
| progress | Widgets: one habit's month | 17 | 110 ms | 61.3 ms |
| progress | Progress year: whole snapshot | 2 | 48 ms | 30.7 ms |
| progress | Progress year: cards | 2 | 48 ms | 30.6 ms |
| progress | Progress year: one card | 30 | 45 ms | 2.9 ms |
| progress | Progress week: whole snapshot | 2 | 14 ms | 10.2 ms |
| progress | Progress week: cards | 2 | 12 ms | 9.2 ms |
| progress | Progress week: one card | 30 | 10 ms | 5.7 ms |
| progress | Progress month: whole snapshot | 2 | 5 ms | 3.4 ms |
| progress | Progress month: cards | 2 | 5 ms | 3.2 ms |
| progress | Progress month: one card | 30 | 4 ms | 0.3 ms |
| progress | Widgets: the snapshot | 1 | 1 ms | 0.9 ms |
| progress | Progress week: one quit card | 4 | 1 ms | 0.6 ms |
| progress | Progress year: one quit card | 2 | 0 ms | 0.3 ms |
| progress | Progress month: one quit card | 4 | 0 ms | 0.1 ms |
| progress | Count: Today's list drawn | 51 | 0 ms | 0.0 ms |
| progress | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| progress | Count: a Today row drawn | 270 | 0 ms | 0.0 ms |
| progress-year | Widgets: one habit's month | 17 | 93 ms | 54.8 ms |
| progress-year | Progress year: whole snapshot | 1 | 53 ms | 52.6 ms |
| progress-year | Progress year: cards | 1 | 52 ms | 52.4 ms |
| progress-year | Progress year: one card | 15 | 49 ms | 8.7 ms |
| progress-year | Progress week: whole snapshot | 1 | 2 ms | 1.6 ms |
| progress-year | Progress week: cards | 1 | 1 ms | 1.3 ms |
| progress-year | Progress year: one quit card | 2 | 1 ms | 0.6 ms |
| progress-year | Progress week: one card | 15 | 1 ms | 0.1 ms |
| progress-year | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| progress-year | Progress week: one quit card | 2 | 0 ms | 0.2 ms |
| progress-year | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| progress-year | Count: a Today row drawn | 45 | 0 ms | 0.1 ms |
| progress-year | Count: Today's list drawn | 12 | 0 ms | 0.0 ms |
| calendar | Widgets: one habit's month | 17 | 71 ms | 35.9 ms |
| calendar | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| calendar | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| calendar | Count: Today's list drawn | 10 | 0 ms | 0.1 ms |
| calendar | Count: a Today row drawn | 33 | 0 ms | 0.0 ms |
| new-habit | Widgets: one habit's month | 17 | 139 ms | 86.6 ms |
| new-habit | Count: Today's list drawn | 14 | 1 ms | 0.9 ms |
| new-habit | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| new-habit | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| new-habit | Count: a Today row drawn | 79 | 0 ms | 0.0 ms |
| form-parts | Widgets: one habit's month | 17 | 83 ms | 41.2 ms |
| form-parts | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| form-parts | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| form-parts | Count: Today's list drawn | 12 | 0 ms | 0.0 ms |
| form-parts | Count: a Today row drawn | 79 | 0 ms | 0.0 ms |
| player | Widgets: one habit's month | 18 | 90 ms | 41.8 ms |
| player | Widgets: the snapshot | 2 | 3 ms | 3.0 ms |
| player | Reminders: plan every alert | 38 | 3 ms | 0.1 ms |
| player | Change: Siri's habit names | 37 | 2 ms | 0.1 ms |
| player | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| player | Count: a Today row drawn | 30 | 0 ms | 0.0 ms |
| day-sheet | Habit page: history | 149 | 656 ms | 11.8 ms |
| day-sheet | Widgets: one habit's month | 17 | 67 ms | 37.1 ms |
| day-sheet | Change: Siri's habit names | 148 | 5 ms | 0.1 ms |
| day-sheet | Reminders: plan every alert | 3 | 1 ms | 0.5 ms |
| day-sheet | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| day-sheet | Count: Today's list drawn | 10 | 0 ms | 0.0 ms |
| day-sheet | Count: a Today row drawn | 180 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet drawn | 143 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet's entries drawn | 57 | 0 ms | 0.0 ms |
| day-sheet | Entry editor: whole editor drawn | 8 | 0 ms | 0.0 ms |
| log-sheet | Habit page: history | 146 | 803 ms | 14.4 ms |
| log-sheet | Widgets: one habit's month | 18 | 94 ms | 35.6 ms |
| log-sheet | Change: Siri's habit names | 145 | 6 ms | 0.5 ms |
| log-sheet | Widgets: the snapshot | 2 | 5 ms | 5.0 ms |
| log-sheet | Reminders: plan every alert | 3 | 0 ms | 0.1 ms |
| log-sheet | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| log-sheet | Count: the Day sheet drawn | 158 | 0 ms | 0.0 ms |
| log-sheet | Count: a Today row drawn | 177 | 0 ms | 0.0 ms |
| log-sheet | Count: the Day sheet's entries drawn | 60 | 0 ms | 0.0 ms |
| log-sheet | Entry editor: whole editor drawn | 7 | 0 ms | 0.0 ms |
| typing-control | Widgets: one habit's month | 17 | 95 ms | 43.7 ms |
| typing-control | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| typing-control | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| typing-control | Count: Today's list drawn | 10 | 0 ms | 0.0 ms |
| typing-control | Count: a Today row drawn | 33 | 0 ms | 0.0 ms |
| widget-guide | Widgets: one habit's month | 17 | 81 ms | 38.3 ms |
| widget-guide | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| widget-guide | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| widget-guide | Count: Today's list drawn | 12 | 0 ms | 0.0 ms |
| widget-guide | Count: a Today row drawn | 36 | 0 ms | 0.0 ms |
| widget-log | Widgets: one habit's month | 40 | 116 ms | 31.9 ms |
| widget-log | Widgets: the snapshot | 24 | 9 ms | 0.8 ms |
| widget-log | Reminders: plan every alert | 48 | 3 ms | 0.2 ms |
| widget-log | Change: Siri's habit names | 54 | 2 ms | 0.1 ms |
| widget-log | Count: Today's list drawn | 7 | 0 ms | 0.0 ms |
| widget-log | Count: a Today row drawn | 159 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
