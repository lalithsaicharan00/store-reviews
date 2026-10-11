# apple-watch-ci2 @ f8081ff

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38132384471 · 2026-10-11 14:01 UTC
Commit: Apple Watch: compile BackupFeatures for SHA256Hex, which iCloud's transport uses

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (ICloudUITests,WidgetUITests): cancelled
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
Test Case '-[HabitsUITests.ICloudUITests testADifferentAppleAccountAsksFirst]' passed (51.473 seconds).
Test Case '-[HabitsUITests.ICloudUITests testRemovedFromICloudAsksFirst]' passed (21.616 seconds).
Test Case '-[HabitsUITests.ICloudUITests testSyncAgainstTheFakeICloud]' passed (157.861 seconds).
Test Case '-[HabitsUITests.ICloudUITests testTheExtremeAccount]' passed (1686.920 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
