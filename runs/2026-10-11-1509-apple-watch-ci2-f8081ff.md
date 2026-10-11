# apple-watch-ci2 @ f8081ff

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38145611296 · 2026-10-11 15:09 UTC
Commit: Apple Watch: compile BackupFeatures for SHA256Hex, which iCloud's transport uses

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (ICloudUITests/testTheICloudPageInEveryState,ICloudUITests/testTodaysCardWhenICloudNeedsYou,ICloudUITests/testTheSecondDeviceSheet,WidgetUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 3 tests, with 1 failure (0 unexpected) in 173.724 (173.727) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 319.530 (319.540) seconds
	 Executed 9 tests, with 1 failure (0 unexpected) in 493.255 (493.269) seconds
	 Executed 9 tests, with 1 failure (0 unexpected) in 493.255 (493.272) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ICloudUITests.swift:176: error: -[HabitsUITests.ICloudUITests testTheICloudPageInEveryState] : XCTAssertTrue failed
Test Case '-[HabitsUITests.ICloudUITests testTheICloudPageInEveryState]' failed (100.893 seconds).
Test Case '-[HabitsUITests.ICloudUITests testTheSecondDeviceSheet]' passed (38.964 seconds).
Test Case '-[HabitsUITests.ICloudUITests testTodaysCardWhenICloudNeedsYou]' passed (33.866 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' passed (194.532 seconds).
Test Case '-[HabitsUITests.WidgetUITests testGuideAndPrivacyAreFree]' passed (38.639 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLargerTextCountersAndCutDownAreReadable]' passed (35.469 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLongNamesAndUnitsKeepQuickActionVisible]' passed (19.278 seconds).
Test Case '-[HabitsUITests.WidgetUITests testReliabilityUnderBurstsRetriesAndRollover]' passed (21.782 seconds).
Test Case '-[HabitsUITests.WidgetUITests testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks]' passed (9.831 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
