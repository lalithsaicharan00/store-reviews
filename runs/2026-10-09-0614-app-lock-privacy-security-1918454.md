# app-lock-privacy-security @ 1918454

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37889767163 · 2026-10-09 06:14 UTC
Commit: Design Rules: the lock cover's own window; locking ends typing (Current Work 58)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (AppLockUITests,WidgetUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 12 tests, with 1 failure (0 unexpected) in 562.197 (562.218) seconds
	 Executed 18 tests, with 1 failure (0 unexpected) in 873.524 (873.552) seconds
	 Executed 18 tests, with 1 failure (0 unexpected) in 873.524 (873.555) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 311.326 (311.332) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/AppLockUITests.swift:426: error: -[HabitsUITests.AppLockUITests testReminderSaysIsSavedWithTheHabit] : XCTAssertEqual failed: ("Optional("Evening check-in")") is not equal to ("Optional("Evening check-in, the lo")") - Cut at 24 characters
Test Case '-[HabitsUITests.AppLockUITests testALinkOpensBehindTheCoverAndShowsAfterUnlock]' passed (47.955 seconds).
Test Case '-[HabitsUITests.AppLockUITests testAskAgainImmediatelyAndAfterAMinute]' passed (50.690 seconds).
Test Case '-[HabitsUITests.AppLockUITests testCancelLeavesUnlockAndTypedTextIsKept]' passed (41.258 seconds).
Test Case '-[HabitsUITests.AppLockUITests testChooseCodeThenUnlockWithIt]' passed (76.644 seconds).
Test Case '-[HabitsUITests.AppLockUITests testFaceIDChangedAsksForTheCodeAndThenAsks]' passed (96.674 seconds).
Test Case '-[HabitsUITests.AppLockUITests testForgotCodeTwentyFourHourReset]' passed (56.403 seconds).
Test Case '-[HabitsUITests.AppLockUITests testForgotCodeWithFaceID]' passed (32.398 seconds).
Test Case '-[HabitsUITests.AppLockUITests testLockOnAndOffAndHideNamesFollows]' passed (62.457 seconds).
Test Case '-[HabitsUITests.AppLockUITests testLockRulesAndHiddenNamesEverywhere]' passed (5.604 seconds).
Test Case '-[HabitsUITests.AppLockUITests testReminderSaysIsSavedWithTheHabit]' failed (31.568 seconds).
Test Case '-[HabitsUITests.AppLockUITests testWidgetChooseLinkOpensHelp]' passed (18.202 seconds).
Test Case '-[HabitsUITests.AppLockUITests testWrongCodesWaitThenTheRightCodeOpens]' passed (42.345 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' passed (186.717 seconds).
Test Case '-[HabitsUITests.WidgetUITests testGuideAndPrivacyAreFree]' passed (38.320 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLargerTextCountersAndCutDownAreReadable]' passed (33.672 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLongNamesAndUnitsKeepQuickActionVisible]' passed (21.678 seconds).
Test Case '-[HabitsUITests.WidgetUITests testReliabilityUnderBurstsRetriesAndRollover]' passed (21.171 seconds).
Test Case '-[HabitsUITests.WidgetUITests testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks]' passed (9.767 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
