# claude/lucid-johnson-egrjup-ci4 @ f556de9

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38087088220 · 2026-10-10 21:56 UTC
Commit: iCloud sync: the database's iCloud work runs off the main thread; the screen re-reads once a fetch's pages stop

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (ICloudUITests/testSyncAgainstTheFakeICloud,ICloudUITests/testTheSecondDeviceSheet,ICloudUITests/testRemovedFromICloudAsksFirst,ICloudUITests/testADifferentAppleAccountAsksFirst,OnboardingUITests,WidgetUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 1 failure (0 unexpected) in 343.750 (343.758) seconds
	 Executed 20 tests, with 1 failure (0 unexpected) in 901.958 (901.990) seconds
	 Executed 20 tests, with 1 failure (0 unexpected) in 901.958 (901.999) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 257.041 (257.056) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 301.166 (301.173) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/OnboardingUITests.swift:141: error: -[HabitsUITests.OnboardingUITests testNewPersonToFirstHabit] : XCTAssertTrue failed - The new day start is shown
Test Case '-[HabitsUITests.ICloudUITests testADifferentAppleAccountAsksFirst]' passed (61.214 seconds).
Test Case '-[HabitsUITests.ICloudUITests testRemovedFromICloudAsksFirst]' passed (23.416 seconds).
Test Case '-[HabitsUITests.ICloudUITests testSyncAgainstTheFakeICloud]' passed (149.094 seconds).
Test Case '-[HabitsUITests.ICloudUITests testTheSecondDeviceSheet]' passed (23.316 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testCreateMyOwnHabitIsTheUsualNewFlow]' passed (54.333 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testDataOnThisDeviceComesFirst]' passed (29.035 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testFirstHabitAfterMidnightBeforeTheDayStartShowsOnToday]' passed (48.343 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testHabitsComeBackFromICloud]' passed (13.908 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testHelpAndTheWelcomeAgain]' passed (61.338 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testLargestTextReachesContinue]' passed (24.631 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNewPersonToFirstHabit]' failed (43.037 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNoWelcomeInOtherRuns]' passed (7.682 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testReturningWaysBack]' passed (22.731 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testSkipSetupLeadsToAHelpfulToday]' passed (38.712 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' passed (192.180 seconds).
Test Case '-[HabitsUITests.WidgetUITests testGuideAndPrivacyAreFree]' passed (40.358 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLargerTextCountersAndCutDownAreReadable]' passed (28.964 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLongNamesAndUnitsKeepQuickActionVisible]' passed (15.216 seconds).
Test Case '-[HabitsUITests.WidgetUITests testReliabilityUnderBurstsRetriesAndRollover]' passed (15.401 seconds).
Test Case '-[HabitsUITests.WidgetUITests testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks]' passed (9.047 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
