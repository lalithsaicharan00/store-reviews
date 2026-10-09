# app-lock-privacy-security-ci2 @ 61c65ac

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37900900842 · 2026-10-09 08:32 UTC
Commit: Current Work 58.9: the SE Undo test opens the folded morning card first, at a set hour (run 37896918162)

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
| Today: scrolling | 0.0 | 0 ms | 0 | 12.5 % (separate profile) | 12.5%  partial apply for closure #1 in closure #1 in closure #1 in TodayView.navigation.getter<br>12.5%  closure #1 in closure #1 in closure #1 in TodayView.navigation.getter<br>12.5%  TodayView.tick()<br>12.5%  TodayView.goalTimes(now:) |
| Today: +1 and day ‹ › | 75.2 | 127 ms | 1 |  | (none above noise) |
| Today: +1 alone | 3.2 | 39 ms | 0 |  | (none above noise) |
| Today: day ‹ › alone | 65.1 | 90 ms | 0 |  | (none above noise) |
| Today: Day sheet scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Timer screen: a running clock | 21.0 | 136 ms | 2 |  | (none above noise) |
| Today: group filter | 15.5 | 48 ms | 0 |  | (none above noise) |
| Arrange Your Day: scrolling | 2.6 | 33 ms | 0 |  | (none above noise) |
| Arrange Your Day: move Anytime and sort | 25.7 | 62 ms | 0 |  | (none above noise) |
| Today: hide completed on and off | 75.2 | 211 ms | 1 |  | (none above noise) |
| Menu: open and close | 68.7 | 237 ms | 4 |  | (none above noise) |
| All Habits: scrolling | 0.5 | 24 ms | 0 |  | (none above noise) |
| Habit page: History scrolling | 4.8 | 68 ms | 0 |  | (none above noise) |
| Habit page: Progress scrolling | 15.6 | 150 ms | 1 |  | (none above noise) |
| Habit page: switching tabs | 51.0 | 107 ms | 1 |  | (none above noise) |
| Habit page (weekly total): History scrolling | 2.3 | 23 ms | 0 |  | (none above noise) |
| Habit page (weekly total): Progress scrolling | 5.0 | 27 ms | 0 |  | (none above noise) |
| Habit page (quit): History scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Habit page (quit): Progress scrolling | 5.9 | 51 ms | 0 |  | (none above noise) |
| Progress: scrolling | 4.4 | 36 ms | 0 |  | (none above noise) |
| Progress: period ‹ › and range | 88.9 | 134 ms | 3 |  | (none above noise) |
| Progress: key fold and open | 0.3 | 21 ms | 0 |  | (none above noise) |
| Progress Year: sideways | 0.0 | 0 ms | 0 |  | (none above noise) |
| Progress Year: scrolling | 11.9 | 35 ms | 0 |  | (none above noise) |
| Calendar: month ‹ › | 2.0 | 32 ms | 0 |  | (none above noise) |
| Habit form: typing | 65.4 | 525 ms | 3 | 4.1 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  partial apply for closure #1 in AppModel.ensureLoaded()<br>1.0%  closure #1 in AppModel.ensureLoaded() |
| Routine player: ‹ › | 24.3 | 77 ms | 0 |  | (none above noise) |
| Routine player: fast ‹ › | 47.2 | 170 ms | 1 |  | (none above noise) |
| Day sheet: entry list scrolling | 0.0 | 0 ms | 0 | 10.6 % (separate profile) | 1.1%  perfTimed<A>(_:_:)<br>1.1%  static MainThreadMeter.time<A>(_:_:)<br>1.0%  partial apply for closure #3 in HabitPageView.page(_:)<br>1.0%  HabitPageModel.load(_:tab:store:) |
| All logs: scrolling | 0.0 | 0 ms | 0 | 10.6 % (separate profile) | 1.1%  perfTimed<A>(_:_:)<br>1.1%  static MainThreadMeter.time<A>(_:_:)<br>1.0%  partial apply for closure #3 in HabitPageView.page(_:)<br>1.0%  HabitPageModel.load(_:tab:store:) |
| Entry editor: typing | 1.6 | 26 ms | 0 | 10.6 % (separate profile) | 1.1%  perfTimed<A>(_:_:)<br>1.1%  static MainThreadMeter.time<A>(_:_:)<br>1.0%  partial apply for closure #3 in HabitPageView.page(_:)<br>1.0%  HabitPageModel.load(_:tab:store:) |
| Day sheet: add, edit and exact undo | 77.0 | 84 ms | 0 | 10.6 % (separate profile) | 1.1%  perfTimed<A>(_:_:)<br>1.1%  static MainThreadMeter.time<A>(_:_:)<br>1.0%  partial apply for closure #3 in HabitPageView.page(_:)<br>1.0%  HabitPageModel.load(_:tab:store:) |
| Log sheet: typing | 3.1 | 41 ms | 0 | 11.4 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| All logs: scrolling | 0.0 | 0 ms | 0 | 11.4 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 1.7 | 30 ms | 0 | 11.4 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 104.6 | 90 ms | 0 | 11.4 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Add screen (Water): typing | 6.4 | 69 ms | 0 |  | (none above noise) |
| Add screen (Read): typing | 6.7 | 32 ms | 0 |  | (none above noise) |
| Add note: typing | 3.7 | 51 ms | 0 | 13.7 % (separate profile) | 2.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Edit note: typing | 1.3 | 39 ms | 0 | 13.7 % (separate profile) | 2.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Control: typing in a bare number field | 0.0 | 0 ms | 0 |  | (none above noise) |
| Widgets guide: scrolling | 10.8 | 38 ms | 0 |  | (none above noise) |
| Widget: durable amount log and publication | 0.4 | 23 ms | 0 |  | (none above noise) |
| Widget: full publication, every habit's week | 4.1 | 79 ms | 0 |  | (none above noise) |
| Privacy & Security: scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Hide names: widgets published and reminders re-planned | 1.1 | 24 ms | 0 |  | (none above noise) |
| Lock keypad: typing | 0.0 | 0 ms | 0 |  | (none above noise) |
| Lock: the right code opens | 13.1 | 47 ms | 0 |  | (none above noise) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Today: a row's Day sheet (first): longest stall 796 ms
- Today: a row's Day sheet (again): longest stall 334 ms
- Today: the note sheet: longest stall 4033 ms
- Today: the timer screen: longest stall 0 ms
- Arrange Your Day (first): longest stall 298 ms
- Arrange Your Day (again): longest stall 118 ms
- Blank page (control, first): longest stall 201 ms
- Tasks (first): longest stall 286 ms
- Tasks (again): longest stall 231 ms
- Times of Day (first): longest stall 159 ms
- Times of Day (again): longest stall 265 ms
- Day and Week (first): longest stall 445 ms
- Day and Week (again): longest stall 194 ms
- Reminders (first): longest stall 231 ms
- Reminders (again): longest stall 266 ms
- Appearance (first): longest stall 333 ms
- Appearance (again): longest stall 263 ms
- Account (first): longest stall 310 ms
- Account (again): longest stall 162 ms
- Backup & Export (first): longest stall 150 ms
- Backup & Export (again): longest stall 209 ms
- Privacy & Security (first): longest stall 202 ms
- Privacy & Security (again): longest stall 155 ms
- Plus (first): longest stall 80 ms
- Plus (again): longest stall 100 ms
- Help & Feedback (first): longest stall 266 ms
- Help & Feedback (again): longest stall 157 ms
- About (first): longest stall 328 ms
- About (again): longest stall 317 ms
- Blank page (control, again): longest stall 186 ms
- All Habits (first): longest stall 274 ms
- All Habits (again): longest stall 158 ms
- All Habits: longest stall 518 ms
- Habit page: longest stall 1297 ms
- Habit page: Notes: longest stall 74 ms
- Habit page: Progress: longest stall 279 ms
- All Habits: longest stall 416 ms
- Habit page (weekly total): longest stall 0 ms
- Habit page (weekly total): Progress: longest stall 0 ms
- All Habits: longest stall 531 ms
- Habit page (quit): longest stall 624 ms
- Habit page (quit): Progress: longest stall 191 ms
- All Habits: longest stall 353 ms
- Habit page: longest stall 311 ms
- Edit habit (first): longest stall 663 ms
- Edit habit (again): longest stall 276 ms
- Progress (first): longest stall 553 ms
- Progress (again): longest stall 198 ms
- Progress Year (first): longest stall 631 ms
- Progress Year (again): longest stall 271 ms
- Calendar (first): longest stall 303 ms
- Calendar (again): longest stall 235 ms
- New Habit (first): longest stall 431 ms
- New Habit (again): longest stall 177 ms
- Habit form (first): longest stall 992 ms
- Habit form (again): longest stall 526 ms
- Habit form, no keyboard (first): longest stall 546 ms
- Habit form, no keyboard (again): longest stall 254 ms
- Habit form, the launch's first keyboard: longest stall 323 ms
- Habit form, keyboard again: longest stall 378 ms
- Routine player (first): longest stall 528 ms
- Routine player (again): longest stall 151 ms
- Routine player: Day details: longest stall 541 ms
- All Habits: longest stall 570 ms
- Habit page: longest stall 693 ms
- Day sheet (first): longest stall 642 ms
- Day sheet (again): longest stall 372 ms
- All logs: longest stall 177 ms
- Day sheet (for a log): longest stall 415 ms
- Entry editor: longest stall 203 ms
- Edit log (keyboard): longest stall 1172 ms
- Save entry: longest stall 135 ms
- All Habits: longest stall 355 ms
- Habit page: longest stall 365 ms
- Day sheet (first): longest stall 327 ms
- Day sheet (again): longest stall 161 ms
- Log sheet: longest stall 512 ms
- Log keyboard dismissal: longest stall 285 ms
- All logs: longest stall 163 ms
- Day sheet (for a log): longest stall 378 ms
- Entry editor: longest stall 135 ms
- Edit log (keyboard): longest stall 255 ms
- Save entry: longest stall 157 ms
- All Habits: longest stall 410 ms
- Habit page (Water): longest stall 404 ms
- Day sheet (Water): longest stall 377 ms
- Add screen (Water): longest stall 563 ms
- All Habits: longest stall 136 ms
- Habit page (Read): longest stall 143 ms
- Day sheet (Read): longest stall 225 ms
- Add screen (Read): longest stall 292 ms
- All Habits: longest stall 234 ms
- Habit page (Call family): longest stall 118 ms
- Day sheet (Call family): longest stall 153 ms
- Add screen (Call family): longest stall 161 ms
- All Habits: longest stall 200 ms
- Habit page (Meds): longest stall 122 ms
- Day sheet (Meds): longest stall 165 ms
- Add screen (Meds): longest stall 139 ms
- All Habits: longest stall 152 ms
- Habit page (Skincare): longest stall 130 ms
- Day sheet (Skincare): longest stall 281 ms
- Add screen (Skincare): longest stall 181 ms
- All Habits: longest stall 113 ms
- Habit page (Smoking): longest stall 112 ms
- Day sheet (Smoking): longest stall 143 ms
- Add screen (Smoking): longest stall 165 ms
- All Habits: longest stall 326 ms
- Habit page: longest stall 321 ms
- Day sheet: longest stall 309 ms
- Add note: longest stall 453 ms
- Note view: longest stall 112 ms
- Edit note (keyboard): longest stall 130 ms
- Typing control: longest stall 711 ms
- Widgets guide (first): longest stall 444 ms
- Widgets guide (again): longest stall 376 ms
- Privacy & Security (first): longest stall 388 ms
- Privacy & Security (again): longest stall 240 ms
- Lock cover with keypad: longest stall 92 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| scroll-today | Widgets: one habit's week | 17 | 148 ms | 64.7 ms |
| scroll-today | Widgets: the snapshot | 1 | 10 ms | 10.0 ms |
| scroll-today | Count: Today's list drawn | 7 | 0 ms | 0.5 ms |
| scroll-today | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| scroll-today | Count: a Today row drawn | 6 | 0 ms | 0.0 ms |
| tap-today | Widgets: one habit's week | 34 | 167 ms | 57.0 ms |
| tap-today | Widgets: the snapshot | 18 | 26 ms | 3.8 ms |
| tap-today | Change: Siri's habit names | 57 | 5 ms | 0.7 ms |
| tap-today | Reminders: plan every alert | 58 | 5 ms | 0.3 ms |
| tap-today | Count: Today's list drawn | 92 | 0 ms | 0.0 ms |
| tap-today | Count: a Today row drawn | 390 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet drawn | 10 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's activity drawn | 10 | 0 ms | 0.0 ms |
| groups | Widgets: one habit's week | 17 | 94 ms | 60.5 ms |
| groups | Widgets: the snapshot | 1 | 2 ms | 2.0 ms |
| groups | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| groups | Count: Today's list drawn | 45 | 0 ms | 0.0 ms |
| groups | Count: a Today row drawn | 234 | 0 ms | 0.0 ms |
| arrange | Widgets: one habit's week | 34 | 170 ms | 90.3 ms |
| arrange | Widgets: the snapshot | 12 | 20 ms | 3.0 ms |
| arrange | Change: Siri's habit names | 25 | 3 ms | 0.5 ms |
| arrange | Reminders: plan every alert | 26 | 3 ms | 0.4 ms |
| arrange | Arrange: each card's habits | 27 | 1 ms | 0.1 ms |
| arrange | Count: Today's list drawn | 46 | 0 ms | 0.0 ms |
| arrange | Count: Arrange Your Day drawn | 27 | 0 ms | 0.0 ms |
| arrange | Count: a Today row drawn | 204 | 0 ms | 0.0 ms |
| menu | Widgets: one habit's week | 17 | 124 ms | 54.2 ms |
| menu | Widgets: the snapshot | 1 | 2 ms | 1.8 ms |
| menu | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| menu | Count: Today's list drawn | 17 | 0 ms | 0.0 ms |
| menu | Count: a Today row drawn | 9 | 0 ms | 0.0 ms |
| menu-pages | Widgets: one habit's week | 17 | 101 ms | 51.7 ms |
| menu-pages | Widgets: the snapshot | 1 | 3 ms | 2.8 ms |
| menu-pages | Reminders: plan every alert | 3 | 0 ms | 0.1 ms |
| menu-pages | Count: Today's list drawn | 80 | 0 ms | 0.0 ms |
| menu-pages | Count: a Today row drawn | 297 | 0 ms | 0.0 ms |
| all-habits | Widgets: one habit's week | 17 | 52 ms | 29.2 ms |
| all-habits | Widgets: the snapshot | 1 | 1 ms | 1.4 ms |
| all-habits | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| all-habits | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| all-habits | Count: a Today row drawn | 21 | 0 ms | 0.0 ms |
| habit-page | Widgets: one habit's week | 17 | 71 ms | 38.5 ms |
| habit-page | Habit page: history | 1 | 8 ms | 7.7 ms |
| habit-page | Widgets: the snapshot | 1 | 2 ms | 2.3 ms |
| habit-page | Habit page: overall record | 1 | 2 ms | 2.3 ms |
| habit-page | Habit page: milestones | 1 | 2 ms | 2.0 ms |
| habit-page | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-page | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| habit-page | Count: a Today row drawn | 9 | 0 ms | 0.0 ms |
| habit-page-total | Widgets: one habit's week | 17 | 74 ms | 42.7 ms |
| habit-page-total | Widgets: the snapshot | 1 | 1 ms | 0.8 ms |
| habit-page-total | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-page-total | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| habit-page-total | Count: a Today row drawn | 9 | 0 ms | 0.0 ms |
| habit-page-quit | Widgets: one habit's week | 17 | 132 ms | 93.1 ms |
| habit-page-quit | Widgets: the snapshot | 1 | 3 ms | 2.6 ms |
| habit-page-quit | Habit page: history | 1 | 2 ms | 1.7 ms |
| habit-page-quit | Habit page: overall record | 1 | 0 ms | 0.2 ms |
| habit-page-quit | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-page-quit | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| habit-page-quit | Habit page: milestones | 1 | 0 ms | 0.0 ms |
| habit-page-quit | Count: a Today row drawn | 6 | 0 ms | 0.0 ms |
| habit-edit | Widgets: one habit's week | 17 | 82 ms | 43.9 ms |
| habit-edit | Habit page: history | 1 | 8 ms | 7.6 ms |
| habit-edit | Widgets: the snapshot | 1 | 2 ms | 2.5 ms |
| habit-edit | Reminders: plan every alert | 1 | 0 ms | 0.0 ms |
| habit-edit | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| habit-edit | Count: a Today row drawn | 22 | 0 ms | 0.0 ms |
| progress | Widgets: one habit's week | 17 | 74 ms | 48.2 ms |
| progress | Progress year: whole snapshot | 2 | 51 ms | 36.5 ms |
| progress | Progress year: cards | 2 | 51 ms | 36.4 ms |
| progress | Progress year: one card | 30 | 47 ms | 4.9 ms |
| progress | Progress week: whole snapshot | 2 | 18 ms | 14.7 ms |
| progress | Progress week: cards | 2 | 16 ms | 13.8 ms |
| progress | Progress week: one card | 30 | 14 ms | 11.1 ms |
| progress | Progress month: whole snapshot | 2 | 8 ms | 4.8 ms |
| progress | Progress month: cards | 2 | 8 ms | 4.7 ms |
| progress | Progress month: one card | 30 | 6 ms | 1.3 ms |
| progress | Widgets: the snapshot | 1 | 2 ms | 1.9 ms |
| progress | Progress week: one quit card | 4 | 1 ms | 0.3 ms |
| progress | Progress year: one quit card | 2 | 0 ms | 0.3 ms |
| progress | Progress month: one quit card | 4 | 0 ms | 0.2 ms |
| progress | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| progress | Count: Today's list drawn | 27 | 0 ms | 0.0 ms |
| progress | Count: a Today row drawn | 114 | 0 ms | 0.0 ms |
| progress-year | Widgets: one habit's week | 17 | 66 ms | 34.8 ms |
| progress-year | Progress year: whole snapshot | 1 | 32 ms | 32.0 ms |
| progress-year | Progress year: cards | 1 | 32 ms | 31.7 ms |
| progress-year | Progress year: one card | 15 | 30 ms | 11.6 ms |
| progress-year | Widgets: the snapshot | 1 | 2 ms | 1.9 ms |
| progress-year | Progress week: whole snapshot | 1 | 2 ms | 1.7 ms |
| progress-year | Progress week: cards | 1 | 2 ms | 1.5 ms |
| progress-year | Progress week: one card | 15 | 1 ms | 0.1 ms |
| progress-year | Progress year: one quit card | 2 | 0 ms | 0.3 ms |
| progress-year | Progress week: one quit card | 2 | 0 ms | 0.2 ms |
| progress-year | Count: Today's list drawn | 14 | 0 ms | 0.1 ms |
| progress-year | Reminders: plan every alert | 1 | 0 ms | 0.0 ms |
| progress-year | Count: a Today row drawn | 33 | 0 ms | 0.0 ms |
| calendar | Widgets: one habit's week | 17 | 71 ms | 44.7 ms |
| calendar | Widgets: the snapshot | 1 | 1 ms | 0.9 ms |
| calendar | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| calendar | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| calendar | Count: a Today row drawn | 18 | 0 ms | 0.0 ms |
| new-habit | Widgets: one habit's week | 17 | 71 ms | 38.4 ms |
| new-habit | Widgets: the snapshot | 1 | 2 ms | 2.0 ms |
| new-habit | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| new-habit | Count: Today's list drawn | 16 | 0 ms | 0.0 ms |
| new-habit | Count: a Today row drawn | 71 | 0 ms | 0.0 ms |
| form-parts | Widgets: one habit's week | 17 | 81 ms | 48.7 ms |
| form-parts | Widgets: the snapshot | 1 | 1 ms | 1.1 ms |
| form-parts | Reminders: plan every alert | 1 | 0 ms | 0.3 ms |
| form-parts | Count: Today's list drawn | 15 | 0 ms | 0.0 ms |
| form-parts | Count: a Today row drawn | 81 | 0 ms | 0.0 ms |
| player | Widgets: one habit's week | 31 | 102 ms | 41.0 ms |
| player | Widgets: the snapshot | 15 | 30 ms | 5.5 ms |
| player | Change: Siri's habit names | 49 | 4 ms | 0.2 ms |
| player | Reminders: plan every alert | 50 | 3 ms | 0.3 ms |
| player | Count: Today's list drawn | 12 | 0 ms | 0.0 ms |
| player | Count: a Today row drawn | 21 | 0 ms | 0.0 ms |
| player | Count: the Day sheet drawn | 9 | 0 ms | 0.0 ms |
| player | Count: the Day sheet's activity drawn | 9 | 0 ms | 0.0 ms |
| day-sheet | Habit page: history | 144 | 595 ms | 14.4 ms |
| day-sheet | Widgets: one habit's week | 18 | 110 ms | 58.5 ms |
| day-sheet | Change: Siri's habit names | 144 | 8 ms | 0.2 ms |
| day-sheet | Widgets: the snapshot | 2 | 4 ms | 3.0 ms |
| day-sheet | Reminders: plan every alert | 2 | 1 ms | 0.5 ms |
| day-sheet | Count: Today's list drawn | 9 | 0 ms | 0.1 ms |
| day-sheet | Entry editor: whole editor drawn | 181 | 0 ms | 0.0 ms |
| day-sheet | Count: a Today row drawn | 159 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet drawn | 148 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet's activity drawn | 196 | 0 ms | 0.0 ms |
| log-sheet | Habit page: history | 145 | 608 ms | 7.7 ms |
| log-sheet | Widgets: one habit's week | 18 | 67 ms | 35.4 ms |
| log-sheet | Change: Siri's habit names | 144 | 9 ms | 0.2 ms |
| log-sheet | Widgets: the snapshot | 2 | 2 ms | 1.1 ms |
| log-sheet | Reminders: plan every alert | 2 | 0 ms | 0.1 ms |
| log-sheet | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| log-sheet | Count: the Day sheet drawn | 159 | 0 ms | 0.0 ms |
| log-sheet | Count: the Day sheet's activity drawn | 207 | 0 ms | 0.0 ms |
| log-sheet | Count: a Today row drawn | 159 | 0 ms | 0.0 ms |
| log-sheet | Entry editor: whole editor drawn | 188 | 0 ms | 0.0 ms |
| add-screens | Widgets: one habit's week | 17 | 76 ms | 36.4 ms |
| add-screens | Habit page: history | 6 | 34 ms | 11.8 ms |
| add-screens | Widgets: the snapshot | 1 | 2 ms | 1.8 ms |
| add-screens | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| add-screens | Count: Today's list drawn | 27 | 0 ms | 0.0 ms |
| add-screens | Count: the Day sheet drawn | 73 | 0 ms | 0.0 ms |
| add-screens | Count: the Day sheet's activity drawn | 73 | 0 ms | 0.0 ms |
| add-screens | Count: a Today row drawn | 84 | 0 ms | 0.0 ms |
| notes | Widgets: one habit's week | 17 | 61 ms | 32.2 ms |
| notes | Habit page: history | 3 | 20 ms | 11.8 ms |
| notes | Widgets: the snapshot | 4 | 6 ms | 2.0 ms |
| notes | Reminders: plan every alert | 4 | 1 ms | 0.3 ms |
| notes | Change: Siri's habit names | 3 | 0 ms | 0.3 ms |
| notes | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| notes | Count: a Today row drawn | 21 | 0 ms | 0.0 ms |
| notes | Count: the Day sheet drawn | 14 | 0 ms | 0.0 ms |
| notes | Count: the Day sheet's activity drawn | 15 | 0 ms | 0.0 ms |
| typing-control | Widgets: one habit's week | 17 | 76 ms | 49.2 ms |
| typing-control | Widgets: the snapshot | 1 | 2 ms | 2.0 ms |
| typing-control | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| typing-control | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| typing-control | Count: a Today row drawn | 27 | 0 ms | 0.0 ms |
| widget-guide | Widgets: one habit's week | 17 | 93 ms | 45.0 ms |
| widget-guide | Widgets: the snapshot | 1 | 2 ms | 2.4 ms |
| widget-guide | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| widget-guide | Count: Today's list drawn | 12 | 0 ms | 0.1 ms |
| widget-guide | Count: a Today row drawn | 27 | 0 ms | 0.0 ms |
| widget-log | Widgets: one habit's week | 56 | 139 ms | 45.9 ms |
| widget-log | Widgets: the snapshot | 40 | 39 ms | 2.5 ms |
| widget-log | Change: Siri's habit names | 84 | 6 ms | 0.2 ms |
| widget-log | Reminders: plan every alert | 77 | 4 ms | 0.1 ms |
| widget-log | Count: Today's list drawn | 7 | 0 ms | 0.0 ms |
| widget-log | Count: a Today row drawn | 237 | 0 ms | 0.0 ms |
| widget-publish | Widgets: one habit's week | 408 | 462 ms | 39.6 ms |
| widget-publish | Widgets: the snapshot | 24 | 20 ms | 1.6 ms |
| widget-publish | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| widget-publish | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| widget-publish | Count: a Today row drawn | 6 | 0 ms | 0.0 ms |
| privacy | Widgets: one habit's week | 17 | 69 ms | 31.0 ms |
| privacy | Widgets: the snapshot | 30 | 24 ms | 1.7 ms |
| privacy | Reminders: plan every alert | 30 | 1 ms | 0.1 ms |
| privacy | Count: Today's list drawn | 42 | 0 ms | 0.0 ms |
| privacy | Count: a Today row drawn | 204 | 0 ms | 0.0 ms |
| lock-keypad | Widgets: one habit's week | 17 | 67 ms | 33.6 ms |
| lock-keypad | Widgets: the snapshot | 1 | 2 ms | 1.6 ms |
| lock-keypad | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| lock-keypad | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| lock-keypad | Count: a Today row drawn | 24 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
