# Watch: apple-watch @ 07c80b7

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38126558505 · 2026-10-11 09:12 UTC
Commit: Apple Watch: iCloud on the Watch, sending only its own changes (Architecture 12 §3.2)

- Core tests: success
- Watch build: failure
- iPhone build with the Watch app: skipped
- Watch UI tests (none): skipped
- Screenshots: skipped
- Speed: skipped
- Paired simulators: skipped

## Errors in watch-build.log
```
Habits/Cloud/CloudKitTransport.swift:41:75: error: cannot find 'SHA256Hex' in scope
```

## Core tests
```
BackupTest: 20 tests, 0 failures, 0 errors, 4.019 s
CloudStoreTest: 16 tests, 0 failures, 0 errors, 150.688 s
DurabilityTest: 11 tests, 0 failures, 0 errors, 15.739 s
HabitRepositoryTest: 13 tests, 0 failures, 0 errors, 0.129 s
LiveSyncTest: 1 tests, 0 failures, 0 errors, 0.13 s
MigrationTest: 16 tests, 0 failures, 0 errors, 0.444 s
PeerSyncTest: 20 tests, 0 failures, 0 errors, 119.207 s
  peer property test: 3000 seeded runs converged
  first fill: 375000 logs (15 years) in 76 parts, biggest part 73 KB, total 5 MB, 25.5 s (made in 15.1 s); Watch database 118 MB; peak heap 87 MB
SyncTest: 13 tests, 0 failures, 0 errors, 1.833 s
  random sync: {entries=25, undone=13, deletedHabits=2, names=3, fieldClocks=16}
```
