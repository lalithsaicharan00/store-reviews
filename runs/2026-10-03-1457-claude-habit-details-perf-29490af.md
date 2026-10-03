# claude/habit-details-perf @ 29490af

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37129411245 · 2026-10-03 14:57 UTC
Commit: UI tests start with completed habits shown; Hide Completed test holds Today long enough on a slow simulator

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
| Today: scrolling | 30.6 | 423 ms | 1 | 14.1 % (separate profile) | 0.3%  static DaySection.startsText(_:)<br>0.3%  static DaySection.clock(_:)<br>0.1%  __swift_instantiateConcreteTypeFromMangledNameV2<br>0.1%  HabitRow.row(now:) |
| Today: +1 and day ‹ › | 25.1 | 43 ms | 0 |  | (none above noise) |
| Today: +1 alone | 0.7 | 22 ms | 0 |  | (none above noise) |
| Today: day ‹ › alone | 5.7 | 30 ms | 0 |  | (none above noise) |
| Today: group filter | 0.6 | 21 ms | 0 |  | (none above noise) |
| Arrange Your Day: scrolling | 1.2 | 26 ms | 0 |  | (none above noise) |
| Arrange Your Day: move Anytime and sort | 1.5 | 26 ms | 0 |  | (none above noise) |
| Today: hide completed on and off | 11.4 | 83 ms | 0 |  | (none above noise) |
| Menu: open and close | 28.6 | 163 ms | 1 |  | (none above noise) |
| All Habits: scrolling | 0.1 | 18 ms | 0 |  | (none above noise) |
| Habit page: History scrolling | 5.3 | 96 ms | 0 |  | (none above noise) |
| Habit page: Progress scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Habit page: switching tabs | 24.6 | 59 ms | 0 |  | (none above noise) |
| Habit page (weekly total): History scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Habit page (weekly total): Progress scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Habit page (quit): History scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Habit page (quit): Progress scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Progress: scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Progress: period ‹ › and range | 45.6 | 82 ms | 0 |  | (none above noise) |
| Progress: key fold and open | 4.5 | 38 ms | 0 |  | (none above noise) |
| Progress Year: sideways | 0.0 | 0 ms | 0 |  | (none above noise) |
| Progress Year: scrolling | 0.1 | 18 ms | 0 |  | (none above noise) |
| Calendar: month ‹ › | 4.4 | 30 ms | 0 |  | (none above noise) |
| Habit form: typing | 17.6 | 236 ms | 1 | 9.8 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.3%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Routine player: ‹ › | 9.6 | 42 ms | 0 |  | (none above noise) |
| Day sheet: entry list scrolling | 0.7 | 25 ms | 0 | 12.8 % (separate profile) | 1.5%  perfTimed<A>(_:_:)<br>1.5%  static MainThreadMeter.time<A>(_:_:)<br>1.4%  partial apply for closure #2 in HabitPageView.page(_:)<br>1.4%  HabitPageModel.load(_:tab:store:) |
| Entry editor: typing | 7.2 | 64 ms | 0 | 12.8 % (separate profile) | 1.5%  perfTimed<A>(_:_:)<br>1.5%  static MainThreadMeter.time<A>(_:_:)<br>1.4%  partial apply for closure #2 in HabitPageView.page(_:)<br>1.4%  HabitPageModel.load(_:tab:store:) |
| Day sheet: add, edit and exact undo | 40.3 | 51 ms | 0 | 12.8 % (separate profile) | 1.5%  perfTimed<A>(_:_:)<br>1.5%  static MainThreadMeter.time<A>(_:_:)<br>1.4%  partial apply for closure #2 in HabitPageView.page(_:)<br>1.4%  HabitPageModel.load(_:tab:store:) |
| Log sheet: typing | 4.1 | 49 ms | 0 | 9.7 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.0%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Log sheet: entry list scrolling | 0.9 | 30 ms | 0 | 9.7 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.0%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 0.0 | 0 ms | 0 | 9.7 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.0%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 48.5 | 168 ms | 1 | 9.7 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.0%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Control: typing in a bare number field | 0.6 | 21 ms | 0 |  | (none above noise) |
| Widgets guide: scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Widget: durable amount log and publication | 0.0 | 0 ms | 0 |  | (none above noise) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Arrange Your Day (first): longest stall 185 ms
- Arrange Your Day (again): longest stall 66 ms
- Blank page (control, first): longest stall 128 ms
- Tasks (first): longest stall 245 ms
- Tasks (again): longest stall 102 ms
- Times of Day (first): longest stall 102 ms
- Times of Day (again): longest stall 137 ms
- Day and Week (first): longest stall 270 ms
- Day and Week (again): longest stall 122 ms
- Reminders (first): longest stall 148 ms
- Reminders (again): longest stall 83 ms
- Appearance (first): longest stall 162 ms
- Appearance (again): longest stall 133 ms
- Backup & Export (first): longest stall 141 ms
- Backup & Export (again): longest stall 97 ms
- Privacy (first): longest stall 93 ms
- Privacy (again): longest stall 144 ms
- Plus (first): longest stall 81 ms
- Plus (again): longest stall 109 ms
- Help & Feedback (first): longest stall 278 ms
- Help & Feedback (again): longest stall 174 ms
- About (first): longest stall 154 ms
- About (again): longest stall 104 ms
- Blank page (control, again): longest stall 103 ms
- All Habits (first): longest stall 260 ms
- All Habits (again): longest stall 146 ms
- All Habits: longest stall 308 ms
- Habit page: longest stall 1033 ms
- Habit page: Notes: longest stall 21 ms
- Habit page: Progress: longest stall 195 ms
- All Habits: longest stall 173 ms
- Habit page (weekly total): longest stall 0 ms
- Habit page (weekly total): Progress: longest stall 0 ms
- All Habits: longest stall 261 ms
- Habit page (quit): longest stall 289 ms
- Habit page (quit): Progress: longest stall 116 ms
- All Habits: longest stall 296 ms
- Habit page: longest stall 305 ms
- Edit habit (first): longest stall 487 ms
- Edit habit (again): longest stall 182 ms
- Progress (first): longest stall 694 ms
- Progress (again): longest stall 179 ms
- Progress Year (first): longest stall 394 ms
- Progress Year (again): longest stall 90 ms
- Calendar (first): longest stall 248 ms
- Calendar (again): longest stall 157 ms
- New Habit (first): longest stall 233 ms
- New Habit (again): longest stall 113 ms
- Habit form (first): longest stall 388 ms
- Habit form (again): longest stall 194 ms
- Habit form, no keyboard (first): longest stall 466 ms
- Habit form, no keyboard (again): longest stall 193 ms
- Habit form, the launch's first keyboard: longest stall 191 ms
- Habit form, keyboard again: longest stall 271 ms
- Routine player (first): longest stall 301 ms
- Routine player (again): longest stall 98 ms
- All Habits: longest stall 258 ms
- Habit page: longest stall 359 ms
- Day sheet (first): longest stall 365 ms
- Day sheet (again): longest stall 162 ms
- Entry editor: longest stall 761 ms
- Save entry: longest stall 231 ms
- All Habits: longest stall 166 ms
- Habit page: longest stall 356 ms
- Day sheet (first): longest stall 352 ms
- Day sheet (again): longest stall 190 ms
- Log sheet: longest stall 284 ms
- Log keyboard dismissal: longest stall 62 ms
- Entry editor: longest stall 352 ms
- Save entry: longest stall 308 ms
- Typing control: longest stall 492 ms
- Widgets guide (first): longest stall 253 ms
- Widgets guide (again): longest stall 134 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| scroll-today | Widgets: one habit's month | 17 | 76 ms | 37.4 ms |
| scroll-today | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| scroll-today | Count: Today's list drawn | 6 | 0 ms | 0.1 ms |
| scroll-today | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| scroll-today | Count: a Today row drawn | 24 | 0 ms | 0.0 ms |
| tap-today | Widgets: one habit's month | 18 | 67 ms | 34.7 ms |
| tap-today | Reminders: plan every alert | 57 | 2 ms | 0.1 ms |
| tap-today | Change: Siri's habit names | 56 | 2 ms | 0.1 ms |
| tap-today | Widgets: the snapshot | 2 | 1 ms | 0.9 ms |
| tap-today | Count: Today's list drawn | 90 | 0 ms | 0.0 ms |
| tap-today | Count: a Today row drawn | 690 | 0 ms | 0.0 ms |
| groups | Widgets: one habit's month | 17 | 65 ms | 34.9 ms |
| groups | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| groups | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| groups | Count: Today's list drawn | 45 | 0 ms | 0.0 ms |
| groups | Count: a Today row drawn | 492 | 0 ms | 0.0 ms |
| arrange | Widgets: one habit's month | 34 | 93 ms | 34.1 ms |
| arrange | Change: Siri's habit names | 25 | 1 ms | 0.1 ms |
| arrange | Reminders: plan every alert | 26 | 1 ms | 0.1 ms |
| arrange | Arrange: each card's habits | 27 | 1 ms | 0.1 ms |
| arrange | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| arrange | Count: Today's list drawn | 40 | 0 ms | 0.0 ms |
| arrange | Count: a Today row drawn | 359 | 0 ms | 0.0 ms |
| arrange | Count: Arrange Your Day drawn | 27 | 0 ms | 0.0 ms |
| menu | Widgets: one habit's month | 17 | 56 ms | 26.5 ms |
| menu | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| menu | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| menu | Count: Today's list drawn | 6 | 0 ms | 0.0 ms |
| menu | Count: a Today row drawn | 24 | 0 ms | 0.0 ms |
| menu-pages | Widgets: one habit's month | 17 | 65 ms | 34.4 ms |
| menu-pages | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| menu-pages | Reminders: plan every alert | 3 | 0 ms | 0.1 ms |
| menu-pages | Count: a Today row drawn | 537 | 0 ms | 0.0 ms |
| menu-pages | Count: Today's list drawn | 76 | 0 ms | 0.0 ms |
| all-habits | Widgets: one habit's month | 17 | 61 ms | 30.8 ms |
| all-habits | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| all-habits | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| all-habits | Count: Today's list drawn | 10 | 0 ms | 0.0 ms |
| all-habits | Count: a Today row drawn | 51 | 0 ms | 0.0 ms |
| habit-page | Widgets: one habit's month | 17 | 82 ms | 39.2 ms |
| habit-page | Habit page: history | 1 | 8 ms | 7.6 ms |
| habit-page | Habit page: overall record | 1 | 2 ms | 2.4 ms |
| habit-page | Habit page: milestones | 1 | 1 ms | 1.2 ms |
| habit-page | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| habit-page | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-page | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| habit-page | Count: a Today row drawn | 48 | 0 ms | 0.0 ms |
| habit-page-total | Widgets: one habit's month | 17 | 70 ms | 32.8 ms |
| habit-page-total | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| habit-page-total | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-page-total | Count: Today's list drawn | 7 | 0 ms | 0.0 ms |
| habit-page-total | Count: a Today row drawn | 36 | 0 ms | 0.0 ms |
| habit-page-quit | Widgets: one habit's month | 17 | 71 ms | 32.9 ms |
| habit-page-quit | Habit page: history | 1 | 2 ms | 2.4 ms |
| habit-page-quit | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| habit-page-quit | Habit page: overall record | 1 | 0 ms | 0.1 ms |
| habit-page-quit | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-page-quit | Habit page: milestones | 1 | 0 ms | 0.0 ms |
| habit-page-quit | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| habit-page-quit | Count: a Today row drawn | 48 | 0 ms | 0.0 ms |
| habit-edit | Widgets: one habit's month | 17 | 58 ms | 26.9 ms |
| habit-edit | Habit page: history | 1 | 7 ms | 7.2 ms |
| habit-edit | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| habit-edit | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-edit | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| habit-edit | Count: a Today row drawn | 70 | 0 ms | 0.0 ms |
| progress | Widgets: one habit's month | 17 | 66 ms | 34.6 ms |
| progress | Progress year: whole snapshot | 2 | 38 ms | 22.8 ms |
| progress | Progress year: cards | 2 | 38 ms | 22.8 ms |
| progress | Progress year: one card | 30 | 37 ms | 2.2 ms |
| progress | Progress week: whole snapshot | 2 | 9 ms | 7.2 ms |
| progress | Progress week: cards | 2 | 8 ms | 6.5 ms |
| progress | Progress week: one card | 30 | 7 ms | 5.0 ms |
| progress | Progress month: whole snapshot | 2 | 5 ms | 3.3 ms |
| progress | Progress month: cards | 2 | 5 ms | 3.2 ms |
| progress | Progress month: one card | 30 | 4 ms | 0.4 ms |
| progress | Progress week: one quit card | 4 | 0 ms | 0.2 ms |
| progress | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| progress | Progress year: one quit card | 2 | 0 ms | 0.2 ms |
| progress | Progress month: one quit card | 4 | 0 ms | 0.1 ms |
| progress | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| progress | Count: Today's list drawn | 51 | 0 ms | 0.0 ms |
| progress | Count: a Today row drawn | 528 | 0 ms | 0.0 ms |
| progress-year | Widgets: one habit's month | 17 | 60 ms | 29.9 ms |
| progress-year | Progress year: whole snapshot | 1 | 25 ms | 25.3 ms |
| progress-year | Progress year: cards | 1 | 25 ms | 25.2 ms |
| progress-year | Progress year: one card | 15 | 24 ms | 5.4 ms |
| progress-year | Progress week: whole snapshot | 1 | 1 ms | 1.4 ms |
| progress-year | Progress week: cards | 1 | 1 ms | 1.3 ms |
| progress-year | Progress week: one card | 15 | 1 ms | 0.1 ms |
| progress-year | Progress year: one quit card | 2 | 0 ms | 0.3 ms |
| progress-year | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| progress-year | Progress week: one quit card | 2 | 0 ms | 0.1 ms |
| progress-year | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| progress-year | Count: Today's list drawn | 14 | 0 ms | 0.0 ms |
| progress-year | Count: a Today row drawn | 93 | 0 ms | 0.0 ms |
| calendar | Widgets: one habit's month | 17 | 59 ms | 29.5 ms |
| calendar | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| calendar | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| calendar | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| calendar | Count: a Today row drawn | 72 | 0 ms | 0.0 ms |
| new-habit | Widgets: one habit's month | 17 | 62 ms | 31.5 ms |
| new-habit | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| new-habit | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| new-habit | Count: Today's list drawn | 14 | 0 ms | 0.0 ms |
| new-habit | Count: a Today row drawn | 128 | 0 ms | 0.0 ms |
| form-parts | Widgets: one habit's month | 17 | 65 ms | 35.1 ms |
| form-parts | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| form-parts | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| form-parts | Count: Today's list drawn | 12 | 0 ms | 0.0 ms |
| form-parts | Count: a Today row drawn | 128 | 0 ms | 0.0 ms |
| player | Widgets: one habit's month | 18 | 63 ms | 30.3 ms |
| player | Widgets: the snapshot | 2 | 3 ms | 3.0 ms |
| player | Reminders: plan every alert | 38 | 2 ms | 0.1 ms |
| player | Change: Siri's habit names | 37 | 1 ms | 0.1 ms |
| player | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| player | Count: a Today row drawn | 60 | 0 ms | 0.0 ms |
| day-sheet | Habit page: history | 146 | 592 ms | 9.4 ms |
| day-sheet | Widgets: one habit's month | 17 | 61 ms | 30.6 ms |
| day-sheet | Change: Siri's habit names | 145 | 4 ms | 0.2 ms |
| day-sheet | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| day-sheet | Reminders: plan every alert | 3 | 0 ms | 0.1 ms |
| day-sheet | Count: Today's list drawn | 10 | 0 ms | 0.0 ms |
| day-sheet | Count: a Today row drawn | 207 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet drawn | 147 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet's entries drawn | 55 | 0 ms | 0.0 ms |
| day-sheet | Entry editor: whole editor drawn | 8 | 0 ms | 0.0 ms |
| log-sheet | Habit page: history | 146 | 705 ms | 16.5 ms |
| log-sheet | Widgets: one habit's month | 18 | 80 ms | 25.5 ms |
| log-sheet | Change: Siri's habit names | 145 | 5 ms | 0.3 ms |
| log-sheet | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| log-sheet | Reminders: plan every alert | 3 | 0 ms | 0.1 ms |
| log-sheet | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| log-sheet | Count: the Day sheet drawn | 152 | 0 ms | 0.0 ms |
| log-sheet | Count: a Today row drawn | 207 | 0 ms | 0.0 ms |
| log-sheet | Count: the Day sheet's entries drawn | 58 | 0 ms | 0.0 ms |
| log-sheet | Entry editor: whole editor drawn | 7 | 0 ms | 0.0 ms |
| typing-control | Widgets: one habit's month | 17 | 59 ms | 29.2 ms |
| typing-control | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| typing-control | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| typing-control | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| typing-control | Count: a Today row drawn | 72 | 0 ms | 0.0 ms |
| widget-guide | Widgets: one habit's month | 17 | 57 ms | 29.1 ms |
| widget-guide | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| widget-guide | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| widget-guide | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| widget-guide | Count: a Today row drawn | 69 | 0 ms | 0.0 ms |
| widget-log | Widgets: one habit's month | 41 | 105 ms | 26.7 ms |
| widget-log | Widgets: the snapshot | 25 | 7 ms | 0.3 ms |
| widget-log | Reminders: plan every alert | 50 | 3 ms | 0.1 ms |
| widget-log | Change: Siri's habit names | 56 | 2 ms | 0.5 ms |
| widget-log | Count: Today's list drawn | 6 | 0 ms | 0.0 ms |
| widget-log | Count: a Today row drawn | 177 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
