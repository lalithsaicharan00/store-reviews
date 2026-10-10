# claude/lucid-johnson-egrjup @ 0b7f673

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38082671043 · 2026-10-10 20:31 UTC
Commit: Merge main into claude/lucid-johnson-egrjup

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (ICloudUITests/testSyncAgainstTheFakeICloud,ICloudUITests/testTheICloudPageInEveryState,BackupUITests/testBackupIntegrityChecks,ICloudUITests/testTheSecondDeviceSheet,ICloudUITests/testRemovedFromICloudAsksFirst,ICloudUITests/testADifferentAppleAccountAsksFirst,ICloudUITests/testTodaysCardWhenICloudNeedsYou): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 6 tests, with 2 failures (0 unexpected) in 242.997 (243.002) seconds
	 Executed 7 tests, with 3 failures (0 unexpected) in 314.260 (314.266) seconds
	 Executed 7 tests, with 3 failures (0 unexpected) in 314.260 (314.267) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/BackupUITests.swift:22: error: -[HabitsUITests.BackupUITests testBackupIntegrityChecks] : XCTAssertTrue failed - Attributes: Application, 0x10525f5c0, pid: 31338, label: 'Often Enough'
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ICloudUITests.swift:73: error: -[HabitsUITests.ICloudUITests testTheICloudPageInEveryState] : XCTAssertTrue failed - held: export one tap away
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ICloudUITests.swift:85: error: -[HabitsUITests.ICloudUITests testTodaysCardWhenICloudNeedsYou] : Failed to get matching snapshot: Find single matching element. Multiple matching elements found for <XCUIElementQuery: 0x10883c3c0>.
Test Case '-[HabitsUITests.BackupUITests testBackupIntegrityChecks]' failed (71.262 seconds).
Test Case '-[HabitsUITests.ICloudUITests testADifferentAppleAccountAsksFirst]' passed (21.422 seconds).
Test Case '-[HabitsUITests.ICloudUITests testRemovedFromICloudAsksFirst]' passed (17.162 seconds).
Test Case '-[HabitsUITests.ICloudUITests testSyncAgainstTheFakeICloud]' passed (79.013 seconds).
Test Case '-[HabitsUITests.ICloudUITests testTheICloudPageInEveryState]' failed (97.144 seconds).
Test Case '-[HabitsUITests.ICloudUITests testTheSecondDeviceSheet]' passed (17.979 seconds).
Test Case '-[HabitsUITests.ICloudUITests testTodaysCardWhenICloudNeedsYou]' failed (10.279 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
