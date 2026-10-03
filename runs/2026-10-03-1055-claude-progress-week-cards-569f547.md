# claude/progress-week-cards @ 569f547

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37113158725 · 2026-10-03 10:55 UTC
Commit: Rulebook check before merging into main: no "due" or "missed" in the app's words; speed scenarios for the new interactions

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
| Today: scrolling | 20.8 | 296 ms | 1 | 0.2 % (separate profile) | 0.0%  kotlin::objc_support::RunLoopSource::perform(void*)<br>0.0%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.0%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.0%  kotlin::CalledFromNativeGuard::CalledFromNativeGuard(bool) |
| Today: +1 and day ‹ › | 63.4 | 81 ms | 0 |  | (none above noise) |
| Today: +1 alone | 5.4 | 46 ms | 0 |  | (none above noise) |
| Today: day ‹ › alone | 60.1 | 71 ms | 0 |  | (none above noise) |
| Today: group filter | 3.6 | 35 ms | 0 |  | (none above noise) |
| Menu: open and close | 72.0 | 254 ms | 2 |  | (none above noise) |
| All Habits: scrolling | 6.6 | 34 ms | 0 |  | (none above noise) |
| Habit page: scrolling | 1.5 | 37 ms | 0 |  | (none above noise) |
| Habit page (weekly total): scrolling | 2.4 | 30 ms | 0 |  | (none above noise) |
| Habit page (quit): scrolling | 52.7 | 633 ms | 2 |  | (none above noise) |
| Progress: scrolling | 18.0 | 79 ms | 0 |  | (none above noise) |
| Progress: period ‹ › and range | 119.3 | 212 ms | 3 |  | (none above noise) |
| Progress: key fold and open | 14.9 | 38 ms | 0 |  | (none above noise) |
| Progress Year: sideways | 7.9 | 102 ms | 1 |  | (none above noise) |
| Progress Year: scrolling | 15.0 | 58 ms | 0 |  | (none above noise) |
| Calendar: month ‹ › | 4.5 | 30 ms | 0 |  | (none above noise) |
| Habit form: typing | 20.3 | 70 ms | 0 | 5.3 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.8%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Routine player: ‹ › | 23.1 | 61 ms | 0 |  | (none above noise) |
| Day sheet: entry list scrolling | 2.3 | 36 ms | 0 | 12.9 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 3.5 | 45 ms | 0 | 12.9 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 72.2 | 65 ms | 0 | 12.9 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Log sheet: typing | 3.5 | 40 ms | 0 | 9.9 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Log sheet: entry list scrolling | 5.3 | 70 ms | 0 | 9.9 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 2.6 | 32 ms | 0 | 9.9 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 74.3 | 88 ms | 0 | 9.9 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Control: typing in a bare number field | 0.4 | 20 ms | 0 |  | (none above noise) |
| Widgets guide: scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Widget: durable amount log and publication | 1.2 | 27 ms | 0 |  | (none above noise) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Blank page (control, first): longest stall 259 ms
- Tasks (first): longest stall 281 ms
- Tasks (again): longest stall 133 ms
- Times of Day (first): longest stall 355 ms
- Times of Day (again): longest stall 271 ms
- Day and Week (first): longest stall 476 ms
- Day and Week (again): longest stall 288 ms
- Reminders (first): longest stall 366 ms
- Reminders (again): longest stall 271 ms
- Appearance (first): longest stall 364 ms
- Appearance (again): longest stall 224 ms
- Backup & Export (first): longest stall 522 ms
- Backup & Export (again): longest stall 259 ms
- Privacy (first): longest stall 246 ms
- Privacy (again): longest stall 223 ms
- Plus (first): longest stall 273 ms
- Plus (again): longest stall 140 ms
- Help & Feedback (first): longest stall 426 ms
- Help & Feedback (again): longest stall 261 ms
- About (first): longest stall 273 ms
- About (again): longest stall 233 ms
- Blank page (control, again): longest stall 158 ms
- All Habits (first): longest stall 270 ms
- All Habits (again): longest stall 210 ms
- All Habits: longest stall 437 ms
- Habit page: longest stall 1213 ms
- All Habits: longest stall 262 ms
- Habit page (weekly total): longest stall 0 ms
- All Habits: longest stall 420 ms
- Habit page (quit): longest stall 530 ms
- All Habits: longest stall 397 ms
- Habit page: longest stall 458 ms
- Edit habit (first): longest stall 789 ms
- Edit habit (again): longest stall 330 ms
- Progress (first): longest stall 689 ms
- Progress (again): longest stall 187 ms
- Progress Year (first): longest stall 714 ms
- Progress Year (again): longest stall 190 ms
- Calendar (first): longest stall 433 ms
- Calendar (again): longest stall 242 ms
- New Habit (first): longest stall 450 ms
- New Habit (again): longest stall 213 ms
- Habit form (first): longest stall 2094 ms
- Habit form (again): longest stall 220 ms
- Habit form, no keyboard (first): longest stall 611 ms
- Habit form, no keyboard (again): longest stall 328 ms
- Habit form, the launch's first keyboard: longest stall 604 ms
- Habit form, keyboard again: longest stall 320 ms
- Routine player (first): longest stall 456 ms
- Routine player (again): longest stall 171 ms
- All Habits: longest stall 391 ms
- Habit page: longest stall 486 ms
- Day sheet (first): longest stall 553 ms
- Day sheet (again): longest stall 283 ms
- Entry editor: longest stall 809 ms
- Save entry: longest stall 335 ms
- All Habits: longest stall 383 ms
- Habit page: longest stall 467 ms
- Day sheet (first): longest stall 525 ms
- Day sheet (again): longest stall 322 ms
- Log sheet: longest stall 437 ms
- Log keyboard dismissal: longest stall 89 ms
- Entry editor: longest stall 424 ms
- Save entry: longest stall 404 ms
- Typing control: longest stall 858 ms
- Widgets guide (first): longest stall 409 ms
- Widgets guide (again): longest stall 154 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| scroll-today | Widgets: one habit's month | 17 | 145 ms | 88.5 ms |
| scroll-today | Count: a Today row drawn | 24 | 3 ms | 3.5 ms |
| scroll-today | Widgets: the snapshot | 1 | 1 ms | 1.1 ms |
| scroll-today | Reminders: plan every alert | 1 | 1 ms | 0.8 ms |
| scroll-today | Count: Today's list drawn | 8 | 0 ms | 0.1 ms |
| tap-today | Widgets: one habit's month | 18 | 125 ms | 85.2 ms |
| tap-today | Reminders: plan every alert | 57 | 5 ms | 0.5 ms |
| tap-today | Change: Siri's habit names | 56 | 3 ms | 0.1 ms |
| tap-today | Widgets: the snapshot | 2 | 2 ms | 1.1 ms |
| tap-today | Count: Today's list drawn | 78 | 0 ms | 0.0 ms |
| tap-today | Count: a Today row drawn | 370 | 0 ms | 0.0 ms |
| groups | Widgets: one habit's month | 17 | 91 ms | 47.2 ms |
| groups | Widgets: the snapshot | 1 | 1 ms | 0.8 ms |
| groups | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| groups | Count: Today's list drawn | 48 | 0 ms | 0.0 ms |
| groups | Count: a Today row drawn | 261 | 0 ms | 0.0 ms |
| menu | Widgets: one habit's month | 17 | 112 ms | 62.6 ms |
| menu | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| menu | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| menu | Count: Today's list drawn | 16 | 0 ms | 0.0 ms |
| menu | Count: a Today row drawn | 69 | 0 ms | 0.0 ms |
| menu-pages | Widgets: one habit's month | 17 | 89 ms | 47.8 ms |
| menu-pages | Widgets: the snapshot | 1 | 1 ms | 0.8 ms |
| menu-pages | Reminders: plan every alert | 3 | 0 ms | 0.1 ms |
| menu-pages | Count: Today's list drawn | 74 | 0 ms | 0.1 ms |
| menu-pages | Count: a Today row drawn | 288 | 0 ms | 0.0 ms |
| all-habits | Widgets: one habit's month | 17 | 127 ms | 53.7 ms |
| all-habits | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| all-habits | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| all-habits | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| all-habits | Count: a Today row drawn | 33 | 0 ms | 0.0 ms |
| habit-page | Widgets: one habit's month | 17 | 101 ms | 53.7 ms |
| habit-page | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| habit-page | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| habit-page | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| habit-page | Count: a Today row drawn | 27 | 0 ms | 0.0 ms |
| habit-page-total | Widgets: one habit's month | 17 | 100 ms | 50.4 ms |
| habit-page-total | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| habit-page-total | Count: Today's list drawn | 7 | 0 ms | 0.1 ms |
| habit-page-total | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-page-total | Count: a Today row drawn | 18 | 0 ms | 0.0 ms |
| habit-page-quit | Widgets: one habit's month | 17 | 100 ms | 60.3 ms |
| habit-page-quit | Widgets: the snapshot | 1 | 1 ms | 0.8 ms |
| habit-page-quit | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-page-quit | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| habit-page-quit | Count: a Today row drawn | 24 | 0 ms | 0.0 ms |
| habit-edit | Widgets: one habit's month | 17 | 96 ms | 49.8 ms |
| habit-edit | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| habit-edit | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-edit | Count: Today's list drawn | 10 | 0 ms | 0.1 ms |
| habit-edit | Count: a Today row drawn | 41 | 0 ms | 0.0 ms |
| progress | Widgets: one habit's month | 17 | 85 ms | 44.8 ms |
| progress | Progress year: whole snapshot | 2 | 48 ms | 31.8 ms |
| progress | Progress year: cards | 2 | 48 ms | 31.7 ms |
| progress | Progress year: one card | 30 | 45 ms | 5.3 ms |
| progress | Progress week: whole snapshot | 2 | 17 ms | 10.6 ms |
| progress | Progress week: cards | 2 | 15 ms | 9.8 ms |
| progress | Progress week: one card | 30 | 12 ms | 7.3 ms |
| progress | Progress month: whole snapshot | 2 | 5 ms | 3.0 ms |
| progress | Progress month: cards | 2 | 5 ms | 2.9 ms |
| progress | Progress month: one card | 30 | 4 ms | 0.3 ms |
| progress | Progress week: one quit card | 4 | 1 ms | 0.8 ms |
| progress | Progress year: one quit card | 2 | 1 ms | 0.4 ms |
| progress | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| progress | Progress month: one quit card | 4 | 0 ms | 0.1 ms |
| progress | Count: Today's list drawn | 50 | 0 ms | 0.2 ms |
| progress | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| progress | Count: a Today row drawn | 270 | 0 ms | 0.0 ms |
| progress-year | Widgets: one habit's month | 17 | 119 ms | 64.5 ms |
| progress-year | Progress year: whole snapshot | 1 | 44 ms | 43.8 ms |
| progress-year | Progress year: cards | 1 | 41 ms | 41.2 ms |
| progress-year | Progress year: one card | 15 | 37 ms | 9.2 ms |
| progress-year | Progress year: one quit card | 2 | 2 ms | 1.9 ms |
| progress-year | Progress week: whole snapshot | 1 | 2 ms | 1.9 ms |
| progress-year | Progress week: cards | 1 | 2 ms | 1.7 ms |
| progress-year | Progress week: one card | 15 | 1 ms | 0.1 ms |
| progress-year | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| progress-year | Progress week: one quit card | 2 | 0 ms | 0.2 ms |
| progress-year | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| progress-year | Count: Today's list drawn | 14 | 0 ms | 0.1 ms |
| progress-year | Count: a Today row drawn | 48 | 0 ms | 0.0 ms |
| calendar | Widgets: one habit's month | 17 | 99 ms | 53.2 ms |
| calendar | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| calendar | Count: Today's list drawn | 9 | 0 ms | 0.1 ms |
| calendar | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| calendar | Count: a Today row drawn | 30 | 0 ms | 0.0 ms |
| new-habit | Widgets: one habit's month | 17 | 89 ms | 51.4 ms |
| new-habit | Widgets: the snapshot | 1 | 1 ms | 0.9 ms |
| new-habit | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| new-habit | Count: a Today row drawn | 79 | 0 ms | 0.0 ms |
| new-habit | Count: Today's list drawn | 14 | 0 ms | 0.0 ms |
| form-parts | Widgets: one habit's month | 17 | 112 ms | 58.0 ms |
| form-parts | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| form-parts | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| form-parts | Count: Today's list drawn | 12 | 0 ms | 0.0 ms |
| form-parts | Count: a Today row drawn | 76 | 0 ms | 0.0 ms |
| player | Widgets: one habit's month | 18 | 87 ms | 41.4 ms |
| player | Change: Siri's habit names | 37 | 2 ms | 0.3 ms |
| player | Reminders: plan every alert | 38 | 2 ms | 0.1 ms |
| player | Widgets: the snapshot | 2 | 2 ms | 1.6 ms |
| player | Count: Today's list drawn | 11 | 0 ms | 0.1 ms |
| player | Count: a Today row drawn | 30 | 0 ms | 0.0 ms |
| day-sheet | Widgets: one habit's month | 17 | 91 ms | 52.9 ms |
| day-sheet | Change: Siri's habit names | 145 | 7 ms | 0.1 ms |
| day-sheet | Reminders: plan every alert | 3 | 1 ms | 0.3 ms |
| day-sheet | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| day-sheet | Count: Today's list drawn | 10 | 0 ms | 0.0 ms |
| day-sheet | Entry editor: whole editor drawn | 8 | 0 ms | 0.0 ms |
| day-sheet | Count: a Today row drawn | 180 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet drawn | 16 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet's entries drawn | 53 | 0 ms | 0.0 ms |
| log-sheet | Widgets: one habit's month | 18 | 128 ms | 52.9 ms |
| log-sheet | Change: Siri's habit names | 145 | 7 ms | 0.1 ms |
| log-sheet | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| log-sheet | Reminders: plan every alert | 3 | 0 ms | 0.1 ms |
| log-sheet | Count: a Today row drawn | 177 | 0 ms | 0.1 ms |
| log-sheet | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| log-sheet | Count: the Day sheet drawn | 13 | 0 ms | 0.0 ms |
| log-sheet | Count: the Day sheet's entries drawn | 57 | 0 ms | 0.0 ms |
| log-sheet | Entry editor: whole editor drawn | 7 | 0 ms | 0.0 ms |
| typing-control | Widgets: one habit's month | 17 | 118 ms | 68.9 ms |
| typing-control | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| typing-control | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| typing-control | Count: Today's list drawn | 10 | 0 ms | 0.0 ms |
| typing-control | Count: a Today row drawn | 30 | 0 ms | 0.0 ms |
| widget-guide | Widgets: one habit's month | 17 | 121 ms | 80.6 ms |
| widget-guide | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| widget-guide | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| widget-guide | Count: Today's list drawn | 12 | 0 ms | 0.0 ms |
| widget-guide | Count: a Today row drawn | 39 | 0 ms | 0.0 ms |
| widget-log | Widgets: one habit's month | 40 | 180 ms | 63.4 ms |
| widget-log | Widgets: the snapshot | 24 | 12 ms | 1.1 ms |
| widget-log | Reminders: plan every alert | 51 | 4 ms | 0.2 ms |
| widget-log | Change: Siri's habit names | 54 | 3 ms | 0.2 ms |
| widget-log | Count: Today's list drawn | 7 | 0 ms | 0.1 ms |
| widget-log | Count: a Today row drawn | 159 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
