# claude/lucid-johnson-egrjup-ci2 @ 052be04

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38098090841 · 2026-10-11 00:48 UTC
Commit: iCloud & Backup: one file picker in the stack; Import a Backup File opens Restore with its picker

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (BackupUITests/testTheICloudPageFromAnEmptyToday,BackupUITests/testRestoreListsICloudAndAFile,ICloudUITests/testTheICloudPageInEveryState): success
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 0 failures (0 unexpected) in 52.294 (52.297) seconds
	 Executed 3 tests, with 0 failures (0 unexpected) in 242.187 (242.194) seconds
	 Executed 3 tests, with 0 failures (0 unexpected) in 242.187 (242.195) seconds
Test Case '-[HabitsUITests.BackupUITests testRestoreListsICloudAndAFile]' passed (39.209 seconds).
Test Case '-[HabitsUITests.BackupUITests testTheICloudPageFromAnEmptyToday]' passed (13.085 seconds).
Test Case '-[HabitsUITests.ICloudUITests testTheICloudPageInEveryState]' passed (189.893 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| iCloud & Backup: scrolling | 0.0 | 0 ms | 0 | 2.5 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.6%  closure #1 in AppModel.ensureLoaded() |
| Today: scrolling during a big iCloud fetch | 0.0 | 0 ms | 0 | 4.5 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  closure #1 in AppModel.ensureLoaded()<br>0.4%  partial apply for closure #1 in AppModel.ensureLoaded() |
| Today: +1 during a big iCloud fetch | 17.6 | 284 ms | 1 | 4.5 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  closure #1 in AppModel.ensureLoaded()<br>0.4%  partial apply for closure #1 in AppModel.ensureLoaded() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- iCloud & Backup (first): longest stall 474 ms
- iCloud & Backup (again): longest stall 144 ms
- iCloud & Backup → Restore From a Backup: longest stall 204 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| icloud-page | Widgets: one habit's week | 17 | 116 ms | 55.8 ms |
| icloud-page | Widgets: the snapshot | 1 | 3 ms | 3.0 ms |
| icloud-page | Reminders: plan every alert | 1 | 1 ms | 0.9 ms |
| icloud-page | Count: Today's list drawn | 13 | 1 ms | 0.7 ms |
| icloud-page | Count: a Today row drawn | 30 | 1 ms | 0.5 ms |
| today-big-fetch | Widgets: one habit's week | 102 | 228 ms | 51.3 ms |
| today-big-fetch | Widgets: the snapshot | 6 | 6 ms | 1.8 ms |
| today-big-fetch | Reminders: plan every alert | 14 | 4 ms | 3.0 ms |
| today-big-fetch | Change: Siri's habit names | 53 | 4 ms | 0.2 ms |
| today-big-fetch | Count: a Today row drawn | 189 | 1 ms | 0.6 ms |
| today-big-fetch | Count: Today's list drawn | 18 | 0 ms | 0.5 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
