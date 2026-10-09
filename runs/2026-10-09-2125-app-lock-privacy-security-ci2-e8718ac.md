# app-lock-privacy-security-ci2 @ e8718ac

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37993000630 · 2026-10-09 21:25 UTC
Commit: Current Work 76 and 75: sidebar, Account, Backup & Export, Move and Restore redesigned; one backup place; backed up as you go

- Core storage and migrations: success
- Build: failure
- Release build: skipped
- Same-build speed baseline: skipped
- UI tests (BackupUITests,SyncUITests,OnboardingBackupScreenshotUITests,OnboardingUITests): skipped
- Speed tests: skipped
- Speed tests through XCTest: skipped

## Build errors
```
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Backup/BackupCenter.swift:435:48: error: 'async' call in an autoclosure that does not support concurrency
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Backup/GoogleDrive.swift:185:24: error: static property 'query' is not concurrency-safe because non-'Sendable' type '[String : Any]' may have shared mutable state
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
