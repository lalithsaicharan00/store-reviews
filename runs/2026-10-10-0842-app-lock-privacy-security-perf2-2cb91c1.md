# app-lock-privacy-security-perf2 @ 2cb91c1

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38037591549 · 2026-10-10 08:42 UTC
Commit: Merge remote-tracking branch 'origin/app-lock-privacy-security' into app-lock-privacy-security

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
| Backup & Export (no account): scrolling | 0.0 | 0 ms | 0 | 13.6 % (separate profile) | 0.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| Backup & Export (free): scrolling | 0.0 | 0 ms | 0 | 13.6 % (separate profile) | 0.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| Backup & Export (Plus): scrolling | 0.0 | 0 ms | 0 | 13.6 % (separate profile) | 0.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| Account: scrolling | 0.0 | 0 ms | 0 | 6.8 % (separate profile) | 0.3%  thunk for @escaping @callee_guaranteed (@guaranteed CFRunLoopObserverRef?, @unowned CFRunLoopActivity) -> ()<br>0.2%  partial apply for closure #1 in MainThreadMeter.().init()<br>0.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A) |
| Backup & Export: scrolling | 0.0 | 0 ms | 0 | 8.0 % (separate profile) | 0.1%  TodayView.observedNavigation.getter<br>0.1%  closure #1 in TodayView.navigation.getter<br>0.1%  __swift_instantiateConcreteTypeFromMangledNameV2<br>0.1%  AppModel.shared.unsafeMutableAddressor |
| Menu: open and close | 30.3 | 68 ms | 0 | 0.0 % (separate profile) | 0.0%  TodayView.observedNavigation.getter |
| Today: +1 and day ‹ › | 16.3 | 46 ms | 0 | 9.0 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.4%  closure #1 in HabitStore.queueEntryChange() |
| Today: +1 alone | 0.0 | 0 ms | 0 | 9.0 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.4%  closure #1 in HabitStore.queueEntryChange() |
| Today: day ‹ › alone | 15.5 | 40 ms | 0 | 9.0 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.4%  closure #1 in HabitStore.queueEntryChange() |
| Today: Day sheet scrolling | 0.0 | 0 ms | 0 | 9.0 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.4%  closure #1 in HabitStore.queueEntryChange() |
| Timer screen: a running clock | 0.0 | 0 ms | 0 | 9.0 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.4%  closure #1 in HabitStore.queueEntryChange() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Backup & Export (no account): longest stall 422 ms
- Account (no account): longest stall 108 ms
- Backup & Export (free): longest stall 96 ms
- Account (free): longest stall 198 ms
- Backup & Export (Plus): longest stall 133 ms
- Account (Plus): longest stall 156 ms
- Account (first): longest stall 223 ms
- Account (again): longest stall 128 ms
- Backup & Export → Your Account: longest stall 86 ms
- Backup & Export (first): longest stall 276 ms
- Backup & Export (again): longest stall 122 ms
- Backup & Export → Restore From a Backup: longest stall 98 ms
- Today: a row's Day sheet (first): longest stall 400 ms
- Today: a row's Day sheet (again): longest stall 219 ms
- Today: the note sheet: longest stall 1538 ms
- Today: the timer screen: longest stall 730 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| backup-states | Widgets: one habit's week | 17 | 76 ms | 50.1 ms |
| backup-states | Widgets: the snapshot | 1 | 2 ms | 1.9 ms |
| backup-states | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| backup-states | Count: Today's list drawn | 32 | 0 ms | 0.0 ms |
| backup-states | Count: a Today row drawn | 78 | 0 ms | 0.0 ms |
| account | Widgets: one habit's week | 17 | 72 ms | 46.0 ms |
| account | Widgets: the snapshot | 1 | 2 ms | 1.6 ms |
| account | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| account | Count: Today's list drawn | 16 | 0 ms | 0.0 ms |
| account | Count: a Today row drawn | 42 | 0 ms | 0.0 ms |
| backup-page | Widgets: one habit's week | 17 | 59 ms | 32.3 ms |
| backup-page | Widgets: the snapshot | 1 | 1 ms | 1.4 ms |
| backup-page | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| backup-page | Count: Today's list drawn | 13 | 0 ms | 0.0 ms |
| backup-page | Count: a Today row drawn | 30 | 0 ms | 0.0 ms |
| menu | Widgets: one habit's week | 17 | 60 ms | 33.0 ms |
| menu | Widgets: the snapshot | 1 | 1 ms | 0.8 ms |
| menu | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| menu | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| menu | Count: a Today row drawn | 9 | 0 ms | 0.0 ms |
| tap-today | Widgets: one habit's week | 34 | 103 ms | 40.6 ms |
| tap-today | Widgets: the snapshot | 18 | 18 ms | 2.8 ms |
| tap-today | Change: Siri's habit names | 58 | 4 ms | 0.3 ms |
| tap-today | Reminders: plan every alert | 59 | 3 ms | 0.1 ms |
| tap-today | Count: Today's list drawn | 92 | 0 ms | 0.0 ms |
| tap-today | Count: a Today row drawn | 398 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet drawn | 10 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's activity drawn | 10 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
