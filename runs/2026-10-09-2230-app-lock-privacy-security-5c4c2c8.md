# app-lock-privacy-security @ 5c4c2c8

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37995164396 · 2026-10-09 22:30 UTC
Commit: Current Work 58.13: the SE test's App Lock row has its own name (it hid the test's row helper)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (AppLockUITests,WidgetUITests,AnalyticsUITests,TodayUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 16 tests, with 0 failures (0 unexpected) in 824.671 (824.683) seconds
	 Executed 34 tests, with 0 failures (0 unexpected) in 1497.503 (1497.535) seconds
	 Executed 34 tests, with 0 failures (0 unexpected) in 1497.503 (1497.537) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 62.006 (62.010) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 305.578 (305.584) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 305.249 (305.256) seconds
Test Case '-[HabitsUITests.AnalyticsUITests testDurableContentFreeTracking]' passed (23.262 seconds).
Test Case '-[HabitsUITests.AnalyticsUITests testFailedPersistenceNeverCounts]' passed (9.950 seconds).
Test Case '-[HabitsUITests.AnalyticsUITests testUsageConsentIsOptionalAndSeparate]' passed (18.626 seconds).
Test Case '-[HabitsUITests.AnalyticsUITests testWelcomeConsentIsOptional]' passed (10.168 seconds).
Test Case '-[HabitsUITests.AppLockUITests testALinkOpensBehindTheCoverAndShowsAfterUnlock]' passed (27.133 seconds).
Test Case '-[HabitsUITests.AppLockUITests testAskAgainImmediatelyAndAfterAMinute]' passed (47.362 seconds).
Test Case '-[HabitsUITests.AppLockUITests testCancelLeavesUnlockAndTypedTextIsKept]' passed (41.915 seconds).
Test Case '-[HabitsUITests.AppLockUITests testCancellingSetUpAtEachStepChangesNothing]' passed (71.152 seconds).
Test Case '-[HabitsUITests.AppLockUITests testChooseCodeThenUnlockWithIt]' passed (98.147 seconds).
Test Case '-[HabitsUITests.AppLockUITests testFaceIDChangedAsksForTheCodeAndThenAsks]' passed (107.875 seconds).
Test Case '-[HabitsUITests.AppLockUITests testForgotCodeTwentyFourHourReset]' passed (64.687 seconds).
Test Case '-[HabitsUITests.AppLockUITests testForgotCodeWithFaceID]' passed (36.970 seconds).
Test Case '-[HabitsUITests.AppLockUITests testLockOnAndOffAndHideNamesFollows]' passed (92.156 seconds).
Test Case '-[HabitsUITests.AppLockUITests testLockRulesAndHiddenNamesEverywhere]' passed (7.419 seconds).
Test Case '-[HabitsUITests.AppLockUITests testNoFaceIDTurnsOnWithThePasscode]' passed (26.164 seconds).
Test Case '-[HabitsUITests.AppLockUITests testNoPasscodeShowsWhy]' passed (20.511 seconds).
Test Case '-[HabitsUITests.AppLockUITests testReminderSaysIsSavedWithTheHabit]' passed (47.521 seconds).
Test Case '-[HabitsUITests.AppLockUITests testSwitchingModesBothWays]' passed (72.889 seconds).
Test Case '-[HabitsUITests.AppLockUITests testWidgetChooseLinkOpensHelp]' passed (17.761 seconds).
Test Case '-[HabitsUITests.AppLockUITests testWrongCodesWaitThenTheRightCodeOpens]' passed (45.010 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (22.670 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (46.433 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (27.071 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (26.823 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (15.853 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (119.023 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (13.629 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (33.747 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' passed (185.598 seconds).
Test Case '-[HabitsUITests.WidgetUITests testGuideAndPrivacyAreFree]' passed (38.122 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLargerTextCountersAndCutDownAreReadable]' passed (30.332 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLongNamesAndUnitsKeepQuickActionVisible]' passed (21.728 seconds).
Test Case '-[HabitsUITests.WidgetUITests testReliabilityUnderBurstsRetriesAndRollover]' passed (21.433 seconds).
Test Case '-[HabitsUITests.WidgetUITests testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks]' passed (8.366 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
