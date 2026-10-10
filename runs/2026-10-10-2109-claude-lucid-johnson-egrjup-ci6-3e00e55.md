# claude/lucid-johnson-egrjup-ci6 @ 3e00e55

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38083501204 · 2026-10-10 21:09 UTC
Commit: iCloud sync: Design Rules' iCloud page, What's Built, and what's left for the user in item 81

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
| iCloud & Backup: scrolling | 0.0 | 0 ms | 0 | 1.0 % (separate profile) | 0.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  closure #1 in AppModel.ensureLoaded()<br>0.2%  partial apply for closure #1 in AppModel.ensureLoaded() |
| iCloud & Backup (synced): scrolling | 0.8 | 29 ms | 0 | 14.8 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.6%  closure #1 in AppModel.ensureLoaded() |
| iCloud & Backup (waiting): scrolling | 0.1 | 19 ms | 0 | 14.8 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.6%  closure #1 in AppModel.ensureLoaded() |
| iCloud & Backup (full): scrolling | 0.0 | 0 ms | 0 | 14.8 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.6%  closure #1 in AppModel.ensureLoaded() |
| iCloud & Backup (off): scrolling | 0.0 | 0 ms | 0 | 14.8 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.6%  closure #1 in AppModel.ensureLoaded() |
| iCloud & Backup (bringing): scrolling | 0.0 | 0 ms | 0 | 14.8 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.6%  closure #1 in AppModel.ensureLoaded() |
| iCloud & Backup (free-other): scrolling | 0.4 | 22 ms | 0 | 14.8 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.6%  closure #1 in AppModel.ensureLoaded() |
| iCloud & Backup (plus): scrolling | 2.3 | 31 ms | 0 | 14.8 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.6%  closure #1 in AppModel.ensureLoaded() |
| iCloud & Backup (removed): scrolling | 0.0 | 0 ms | 0 | 14.8 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.6%  closure #1 in AppModel.ensureLoaded() |
| iCloud & Backup (other-account): scrolling | 0.0 | 0 ms | 0 | 14.8 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.6%  closure #1 in AppModel.ensureLoaded() |
| iCloud & Backup (held): scrolling | 0.0 | 0 ms | 0 | 14.8 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.6%  closure #1 in AppModel.ensureLoaded() |
| Today: scrolling during a big iCloud fetch | 9.2 | 65 ms | 0 | 7.6 % (separate profile) | 1.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.8%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 during a big iCloud fetch | 73.5 | 178 ms | 8 | 7.6 % (separate profile) | 1.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.8%  closure #1 in AppModel.ensureLoaded() |
| Today: scrolling | 10.3 | 45 ms | 0 | 6.3 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.5%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 and day ‹ › | 45.3 | 142 ms | 1 | 7.7 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.5%  closure #1 in HabitStore.queueEntryChange() |
| Today: +1 alone | 7.0 | 117 ms | 1 | 7.7 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.5%  closure #1 in HabitStore.queueEntryChange() |
| Today: day ‹ › alone | 61.7 | 90 ms | 0 | 7.7 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.5%  closure #1 in HabitStore.queueEntryChange() |
| Today: Day sheet scrolling | 0.0 | 0 ms | 0 | 7.7 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.5%  closure #1 in HabitStore.queueEntryChange() |
| Timer screen: a running clock | 14.1 | 81 ms | 0 | 7.7 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.5%  closure #1 in HabitStore.queueEntryChange() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- iCloud & Backup (first): longest stall 1150 ms
- iCloud & Backup (again): longest stall 291 ms
- iCloud & Backup → Restore From a Backup: longest stall 45915 ms
- iCloud & Backup (synced): longest stall 556 ms
- iCloud & Backup (waiting): longest stall 403 ms
- iCloud & Backup (full): longest stall 225 ms
- iCloud & Backup (off): longest stall 228 ms
- iCloud & Backup (bringing): longest stall 204 ms
- iCloud & Backup (free-other): longest stall 273 ms
- iCloud & Backup (plus): longest stall 431 ms
- iCloud & Backup (removed): longest stall 0 ms
- iCloud & Backup (other-account): longest stall 364 ms
- iCloud & Backup (held): longest stall 264 ms
- Today: a row's Day sheet (first): longest stall 668 ms
- Today: a row's Day sheet (again): longest stall 269 ms
- Today: the note sheet: longest stall 2308 ms
- Today: the timer screen: longest stall 1340 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| icloud-page | Widgets: one habit's week | 17 | 110 ms | 53.4 ms |
| icloud-page | Widgets: the snapshot | 1 | 2 ms | 2.3 ms |
| icloud-page | Reminders: plan every alert | 1 | 1 ms | 0.9 ms |
| icloud-page | Count: Today's list drawn | 13 | 0 ms | 0.3 ms |
| icloud-page | Count: a Today row drawn | 78 | 0 ms | 0.0 ms |
| icloud-states | Widgets: one habit's week | 17 | 77 ms | 49.5 ms |
| icloud-states | Widgets: the snapshot | 1 | 2 ms | 2.1 ms |
| icloud-states | Count: Today's list drawn | 35 | 0 ms | 0.0 ms |
| icloud-states | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| icloud-states | Count: a Today row drawn | 295 | 0 ms | 0.0 ms |
| today-big-fetch | Widgets: one habit's week | 34 | 94 ms | 39.5 ms |
| today-big-fetch | Change: Siri's habit names | 234 | 20 ms | 5.1 ms |
| today-big-fetch | Reminders: plan every alert | 110 | 7 ms | 0.2 ms |
| today-big-fetch | Widgets: the snapshot | 2 | 3 ms | 1.9 ms |
| today-big-fetch | Count: Today's list drawn | 108 | 0 ms | 0.0 ms |
| today-big-fetch | Count: a Today row drawn | 2490 | 0 ms | 0.1 ms |
| scroll-today | Widgets: one habit's week | 17 | 57 ms | 34.9 ms |
| scroll-today | Widgets: the snapshot | 1 | 1 ms | 0.8 ms |
| scroll-today | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| scroll-today | Count: Today's list drawn | 7 | 0 ms | 0.0 ms |
| scroll-today | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| tap-today | Widgets: one habit's week | 33 | 145 ms | 50.0 ms |
| tap-today | Widgets: the snapshot | 17 | 24 ms | 4.0 ms |
| tap-today | Reminders: plan every alert | 57 | 4 ms | 0.2 ms |
| tap-today | Change: Siri's habit names | 57 | 4 ms | 0.2 ms |
| tap-today | Count: Today's list drawn | 92 | 0 ms | 0.0 ms |
| tap-today | Count: a Today row drawn | 742 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet drawn | 15 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's activity drawn | 15 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
