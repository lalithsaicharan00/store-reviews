# claude/lucid-johnson-egrjup-ci6 @ ad48b96

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38094560760 · 2026-10-11 00:16 UTC
Commit: Merge main (the Plus screens) into claude/lucid-johnson-egrjup

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
| iCloud & Backup: scrolling | 0.0 | 0 ms | 0 | 4.5 % (separate profile) | 0.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  closure #1 in AppModel.ensureLoaded()<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded() |
| iCloud & Backup (synced): scrolling | 0.7 | 23 ms | 0 | 1.8 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| iCloud & Backup (waiting): scrolling | 0.0 | 0 ms | 0 | 1.8 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| iCloud & Backup (full): scrolling | 0.3 | 22 ms | 0 | 1.8 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| iCloud & Backup (off): scrolling | 0.0 | 0 ms | 0 | 1.8 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| iCloud & Backup (bringing): scrolling | 1.8 | 40 ms | 0 | 1.8 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| iCloud & Backup (free-other): scrolling | 0.5 | 25 ms | 0 | 1.8 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| iCloud & Backup (plus): scrolling | 5.3 | 50 ms | 0 | 1.8 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| iCloud & Backup (removed): scrolling | 0.0 | 0 ms | 0 | 1.8 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| iCloud & Backup (other-account): scrolling | 0.0 | 0 ms | 0 | 1.8 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| iCloud & Backup (held): scrolling | 0.0 | 0 ms | 0 | 1.8 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Today: scrolling during a big iCloud fetch | 0.0 | 0 ms | 0 | 1.1 % (separate profile) | 0.1%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  partial apply for closure #1 in AppModel.ensureLoaded() |
| Today: +1 during a big iCloud fetch | 15.2 | 250 ms | 1 | 1.1 % (separate profile) | 0.1%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  partial apply for closure #1 in AppModel.ensureLoaded() |
| Today: scrolling | 0.0 | 0 ms | 0 | 1.6 % (separate profile) | 0.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.2%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 and day ‹ › | 13.2 | 48 ms | 0 | 5.9 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.4%  closure #1 in HabitStore.queueEntryChange() |
| Today: +1 alone | 0.0 | 0 ms | 0 | 5.9 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.4%  closure #1 in HabitStore.queueEntryChange() |
| Today: day ‹ › alone | 13.0 | 34 ms | 0 | 5.9 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.4%  closure #1 in HabitStore.queueEntryChange() |
| Today: Day sheet scrolling | 0.0 | 0 ms | 0 | 5.9 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.4%  closure #1 in HabitStore.queueEntryChange() |
| Timer screen: a running clock | 0.0 | 0 ms | 0 | 5.9 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.4%  closure #1 in HabitStore.queueEntryChange() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- iCloud & Backup (first): longest stall 743 ms
- iCloud & Backup (again): longest stall 169 ms
- iCloud & Backup → Restore From a Backup: longest stall 13976 ms
- iCloud & Backup (synced): longest stall 433 ms
- iCloud & Backup (waiting): longest stall 244 ms
- iCloud & Backup (full): longest stall 250 ms
- iCloud & Backup (off): longest stall 190 ms
- iCloud & Backup (bringing): longest stall 234 ms
- iCloud & Backup (free-other): longest stall 158 ms
- iCloud & Backup (plus): longest stall 208 ms
- iCloud & Backup (removed): longest stall 0 ms
- iCloud & Backup (other-account): longest stall 0 ms
- iCloud & Backup (held): longest stall 292 ms
- Today: a row's Day sheet (first): longest stall 585 ms
- Today: a row's Day sheet (again): longest stall 154 ms
- Today: the note sheet: longest stall 1405 ms
- Today: the timer screen: longest stall 776 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| icloud-page | Widgets: one habit's week | 17 | 123 ms | 84.5 ms |
| icloud-page | Widgets: the snapshot | 1 | 1 ms | 1.3 ms |
| icloud-page | Count: Today's list drawn | 14 | 1 ms | 0.8 ms |
| icloud-page | Reminders: plan every alert | 1 | 0 ms | 0.3 ms |
| icloud-page | Count: a Today row drawn | 33 | 0 ms | 0.0 ms |
| icloud-states | Widgets: one habit's week | 17 | 100 ms | 49.0 ms |
| icloud-states | Widgets: the snapshot | 1 | 3 ms | 2.9 ms |
| icloud-states | Reminders: plan every alert | 1 | 0 ms | 0.4 ms |
| icloud-states | Count: Today's list drawn | 51 | 0 ms | 0.1 ms |
| icloud-states | Count: a Today row drawn | 192 | 0 ms | 0.0 ms |
| today-big-fetch | Widgets: one habit's week | 102 | 212 ms | 71.7 ms |
| today-big-fetch | Widgets: the snapshot | 6 | 8 ms | 2.7 ms |
| today-big-fetch | Change: Siri's habit names | 52 | 4 ms | 0.2 ms |
| today-big-fetch | Reminders: plan every alert | 10 | 1 ms | 0.2 ms |
| today-big-fetch | Count: Today's list drawn | 14 | 0 ms | 0.1 ms |
| today-big-fetch | Count: a Today row drawn | 180 | 0 ms | 0.0 ms |
| scroll-today | Widgets: one habit's week | 17 | 77 ms | 28.0 ms |
| scroll-today | Widgets: the snapshot | 1 | 3 ms | 2.8 ms |
| scroll-today | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| scroll-today | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| scroll-today | Count: a Today row drawn | 9 | 0 ms | 0.0 ms |
| tap-today | Widgets: one habit's week | 34 | 104 ms | 34.0 ms |
| tap-today | Widgets: the snapshot | 18 | 22 ms | 4.2 ms |
| tap-today | Change: Siri's habit names | 58 | 3 ms | 0.1 ms |
| tap-today | Reminders: plan every alert | 59 | 3 ms | 0.1 ms |
| tap-today | Count: Today's list drawn | 93 | 0 ms | 0.0 ms |
| tap-today | Count: a Today row drawn | 398 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet drawn | 15 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's activity drawn | 15 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
