# Watch: apple-watch @ 83e88fa

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38093315506 · 2026-10-10 23:02 UTC
Commit: Apple Watch, step 2: the Watch app, its widget extension and UI test targets; Today, Day details, routine, Plus

- Core tests: success
- Watch build: failure
- iPhone build with the Watch app: skipped
- Watch UI tests (WatchLaunchTests): skipped
- Screenshots: skipped
- Speed: skipped

## Errors in watch-build.log
```
Habits/Model/HabitStore+Widgets.swift:102:69: error: type 'Preferences' has no member 'timerScreen'
Habits/Model/HabitStore+Widgets.swift:69:78: error: type 'Preferences' has no member 'timerScreen'
```

## Core tests
```
BackupTest: 20 tests, 0 failures, 0 errors, 3.18 s
DurabilityTest: 11 tests, 0 failures, 0 errors, 14.147 s
HabitRepositoryTest: 13 tests, 0 failures, 0 errors, 0.108 s
LiveSyncTest: 1 tests, 0 failures, 0 errors, 0.09 s
MigrationTest: 12 tests, 0 failures, 0 errors, 0.226 s
PeerSyncTest: 17 tests, 0 failures, 0 errors, 102.399 s
  peer property test: 3000 seeded runs converged
  first fill: 375000 logs (15 years) in 76 parts, biggest part 73 KB, total 5 MB, 22.5 s (made in 13.3 s); Watch database 118 MB; peak heap 94 MB
SyncTest: 13 tests, 0 failures, 0 errors, 1.503 s
  random sync: {entries=25, undone=13, deletedHabits=2, names=3, fieldClocks=16}
```
