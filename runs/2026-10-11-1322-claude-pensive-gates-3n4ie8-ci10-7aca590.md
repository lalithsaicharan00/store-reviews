# claude/pensive-gates-3n4ie8-ci10 @ 7aca590

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38131557328 · 2026-10-11 13:22 UTC
Commit: Current Work 86: container ids keep their rows' own (T9), the sidebar command names itself, onboarding's column, iPad widget sizes in the render check, the iPad's Design Rules and README

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
| iPad Today: scrolling | 0.0 | 0 ms | 0 | 6.7 % (separate profile) | 0.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.1%  closure #1 in AppModel.ensureLoaded() |
| iPad Today: +1 and day ‹ › | 90.2 | 112 ms | 2 | 6.7 % (separate profile) | 0.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.1%  closure #1 in AppModel.ensureLoaded() |
| iPad: typing in Add log inside the popover | 27.2 | 202 ms | 2 | 6.7 % (separate profile) | 0.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.1%  closure #1 in AppModel.ensureLoaded() |
| iPad Columns: scrolling sideways | 3.0 | 62 ms | 0 | 8.5 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.8%  closure #1 in static PerfDriver.startIfAsked(store:) |
| iPad Columns: scrolling down | 0.0 | 0 ms | 0 | 8.5 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.8%  closure #1 in static PerfDriver.startIfAsked(store:) |
| iPad Columns: +1 and day ‹ › | 683.4 | 1405 ms | 37 | 8.5 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.8%  closure #1 in static PerfDriver.startIfAsked(store:) |
| iPad Habits: moving between habits | 238.9 | 174 ms | 27 | 28.5 % (separate profile) | 0.4%  partial apply for closure #3 in HabitPageView.page(_:)<br>0.4%  HabitPageModel.load(_:tab:store:)<br>0.4%  perfTimed<A>(_:_:)<br>0.4%  static MainThreadMeter.time<A>(_:_:) |
| iPad Progress: scrolling | 31.4 | 64 ms | 0 | 28.5 % (separate profile) | 0.4%  partial apply for closure #3 in HabitPageView.page(_:)<br>0.4%  HabitPageModel.load(_:tab:store:)<br>0.4%  perfTimed<A>(_:_:)<br>0.4%  static MainThreadMeter.time<A>(_:_:) |
| Today: scrolling | 0.0 | 0 ms | 0 | 0.2 % (separate profile) | 0.0%  kotlin::objc_support::RunLoopSource::perform(void*)<br>0.0%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.0%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.0%  kotlin::alloc::FinalizerQueueTraits::processSingle(kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>& |
| Today: +1 and day ‹ › | 133.0 | 196 ms | 6 | 12.6 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  perfTimed<A>(_:_:)<br>0.4%  static MainThreadMeter.time<A>(_:_:) |
| Today: +1 alone | 0.5 | 22 ms | 0 | 12.6 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  perfTimed<A>(_:_:)<br>0.4%  static MainThreadMeter.time<A>(_:_:) |
| Today: day ‹ › alone | 100.8 | 126 ms | 1 | 12.6 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  perfTimed<A>(_:_:)<br>0.4%  static MainThreadMeter.time<A>(_:_:) |
| Today: Day sheet scrolling | 0.0 | 0 ms | 0 | 12.6 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  perfTimed<A>(_:_:)<br>0.4%  static MainThreadMeter.time<A>(_:_:) |
| Timer screen: a running clock | 0.0 | 0 ms | 0 | 12.6 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  perfTimed<A>(_:_:)<br>0.4%  static MainThreadMeter.time<A>(_:_:) |
| Day sheet: entry list scrolling | 0.0 | 0 ms | 0 | 10.0 % (separate profile) | 1.0%  perfTimed<A>(_:_:)<br>1.0%  static MainThreadMeter.time<A>(_:_:)<br>0.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A) |
| All logs: scrolling | 0.0 | 0 ms | 0 | 10.0 % (separate profile) | 1.0%  perfTimed<A>(_:_:)<br>1.0%  static MainThreadMeter.time<A>(_:_:)<br>0.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A) |
| Entry editor: typing | 3.3 | 52 ms | 0 | 10.0 % (separate profile) | 1.0%  perfTimed<A>(_:_:)<br>1.0%  static MainThreadMeter.time<A>(_:_:)<br>0.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A) |
| Day sheet: add, edit and exact undo | 110.9 | 70 ms | 0 | 10.0 % (separate profile) | 1.0%  perfTimed<A>(_:_:)<br>1.0%  static MainThreadMeter.time<A>(_:_:)<br>0.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- iPad: Day details popover (first): longest stall 1124 ms
- iPad: Day details popover (again): longest stall 350 ms
- iPad: Add log inside the popover: longest stall 2139 ms
- iPad: List to Columns: longest stall 347 ms
- iPad: Columns to List: longest stall 258 ms
- iPad: Habits, list and page (first): longest stall 2134 ms
- iPad: Habits, list and page (again): longest stall 662 ms
- iPad: Progress, two across (first): longest stall 673 ms
- iPad: Progress, two across (again): longest stall 392 ms
- iPad: Appearance beside the sidebar (first): longest stall 634 ms
- iPad: Appearance beside the sidebar (again): longest stall 375 ms
- iPad: Today from the sidebar: longest stall 69 ms
- iPad: the sidebar put away: longest stall 319 ms
- iPad: the sidebar back: longest stall 167 ms
- Today: a row's Day sheet (first): longest stall 814 ms
- Today: a row's Day sheet (again): longest stall 355 ms
- Today: the note sheet: longest stall 2483 ms
- Today: the timer screen: longest stall 278 ms
- All Habits: longest stall 701 ms
- Habit page: longest stall 750 ms
- Day sheet (first): longest stall 637 ms
- Day sheet (again): longest stall 453 ms
- All logs: longest stall 121 ms
- Day sheet (for a log): longest stall 344 ms
- Entry editor: longest stall 284 ms
- Edit log (keyboard): longest stall 1518 ms
- Save entry: longest stall 537 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| pad-today | Widgets: one habit's week | 31 | 103 ms | 51.1 ms |
| pad-today | Widgets: the snapshot | 15 | 14 ms | 1.4 ms |
| pad-today | Reminders: plan every alert | 15 | 1 ms | 0.5 ms |
| pad-today | Change: Siri's habit names | 14 | 1 ms | 0.1 ms |
| pad-today | Count: Today's list drawn | 49 | 1 ms | 0.6 ms |
| pad-today | Count: the Day sheet drawn | 14 | 0 ms | 0.0 ms |
| pad-today | Count: a Today row drawn | 327 | 0 ms | 0.0 ms |
| pad-today | Count: the Day sheet's activity drawn | 15 | 0 ms | 0.0 ms |
| pad-columns | Widgets: one habit's week | 30 | 91 ms | 35.6 ms |
| pad-columns | Widgets: the snapshot | 14 | 21 ms | 2.3 ms |
| pad-columns | Change: Siri's habit names | 13 | 2 ms | 0.3 ms |
| pad-columns | Reminders: plan every alert | 14 | 1 ms | 0.1 ms |
| pad-columns | Count: Today's list drawn | 103 | 0 ms | 0.0 ms |
| pad-columns | Count: a Today row drawn | 1881 | 0 ms | 0.0 ms |
| pad-places | Habit page: history | 34 | 112 ms | 10.8 ms |
| pad-places | Widgets: one habit's week | 17 | 111 ms | 81.3 ms |
| pad-places | Progress week: whole snapshot | 1 | 9 ms | 8.8 ms |
| pad-places | Progress week: cards | 1 | 8 ms | 7.9 ms |
| pad-places | Progress week: one card | 15 | 7 ms | 6.8 ms |
| pad-places | Widgets: the snapshot | 1 | 2 ms | 2.0 ms |
| pad-places | Reminders: plan every alert | 1 | 0 ms | 0.3 ms |
| pad-places | Progress week: one quit card | 2 | 0 ms | 0.1 ms |
| pad-places | Count: Today's list drawn | 41 | 0 ms | 0.0 ms |
| pad-places | Count: a Today row drawn | 240 | 0 ms | 0.0 ms |
| scroll-today | Widgets: one habit's week | 17 | 86 ms | 52.3 ms |
| scroll-today | Widgets: the snapshot | 1 | 2 ms | 2.2 ms |
| scroll-today | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| scroll-today | Count: Today's list drawn | 8 | 0 ms | 0.1 ms |
| scroll-today | Count: a Today row drawn | 12 | 0 ms | 0.0 ms |
| tap-today | Widgets: one habit's week | 33 | 118 ms | 46.8 ms |
| tap-today | Widgets: the snapshot | 17 | 22 ms | 2.3 ms |
| tap-today | Change: Siri's habit names | 58 | 4 ms | 0.2 ms |
| tap-today | Reminders: plan every alert | 58 | 4 ms | 0.1 ms |
| tap-today | Count: Today's list drawn | 98 | 0 ms | 0.0 ms |
| tap-today | Count: a Today row drawn | 630 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet drawn | 11 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's activity drawn | 11 | 0 ms | 0.0 ms |
| day-sheet | Habit page: history | 145 | 634 ms | 9.9 ms |
| day-sheet | Widgets: one habit's week | 18 | 113 ms | 77.0 ms |
| day-sheet | Change: Siri's habit names | 144 | 9 ms | 0.3 ms |
| day-sheet | Widgets: the snapshot | 2 | 2 ms | 0.9 ms |
| day-sheet | Reminders: plan every alert | 2 | 0 ms | 0.2 ms |
| day-sheet | Count: Today's list drawn | 13 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet drawn | 158 | 0 ms | 0.0 ms |
| day-sheet | Count: a Today row drawn | 198 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet's activity drawn | 200 | 0 ms | 0.0 ms |
| day-sheet | Entry editor: whole editor drawn | 188 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
