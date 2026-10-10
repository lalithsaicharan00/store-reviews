# claude/lucid-johnson-egrjup-ci2 @ ad48b96

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38094554630 · 2026-10-10 23:52 UTC
Commit: Merge main (the Plus screens) into claude/lucid-johnson-egrjup

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (OnboardingUITests,TodayUITests,PlusUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 241.635 (241.642) seconds
	 Executed 10 tests, with 0 failures (0 unexpected) in 439.330 (439.339) seconds
	 Executed 28 tests, with 0 failures (0 unexpected) in 944.071 (944.093) seconds
	 Executed 28 tests, with 0 failures (0 unexpected) in 944.071 (944.097) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 263.105 (263.110) seconds
Test Case '-[HabitsUITests.OnboardingUITests testCreateMyOwnHabitIsTheUsualNewFlow]' passed (124.788 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testDataOnThisDeviceComesFirst]' passed (22.895 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testFirstHabitAfterMidnightBeforeTheDayStartShowsOnToday]' passed (41.482 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testHabitsComeBackFromICloud]' passed (15.712 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testHelpAndTheWelcomeAgain]' passed (73.285 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testLargestTextReachesContinue]' passed (26.974 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNewPersonToFirstHabit]' passed (61.915 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNoWelcomeInOtherRuns]' passed (8.431 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testReturningWaysBack]' passed (24.852 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testSkipSetupLeadsToAHelpfulToday]' passed (38.997 seconds).
Test Case '-[HabitsUITests.PlusUITests testAskToBuyShowsWaiting]' passed (16.825 seconds).
Test Case '-[HabitsUITests.PlusUITests testBringingBackAnArchivedHabit]' passed (29.349 seconds).
Test Case '-[HabitsUITests.PlusUITests testBuyingPlusSavesTheSixthHabit]' passed (33.267 seconds).
Test Case '-[HabitsUITests.PlusUITests testMakeRoomArchivesOneAndGoesAhead]' passed (29.047 seconds).
Test Case '-[HabitsUITests.PlusUITests testOwnerUpgradesAndFamilyMemberPage]' passed (33.582 seconds).
Test Case '-[HabitsUITests.PlusUITests testPlusEndedIsToldOnce]' passed (12.181 seconds).
Test Case '-[HabitsUITests.PlusUITests testPlusPageAndRestoreWithNothingFound]' passed (17.199 seconds).
Test Case '-[HabitsUITests.PlusUITests testPricesThatFailShowTryAgain]' passed (33.007 seconds).
Test Case '-[HabitsUITests.PlusUITests testSecondDeviceSheetOpensThePlusPage]' passed (18.646 seconds).
Test Case '-[HabitsUITests.PlusUITests testSixthHabitSheetOffersBothPlansAndNoNotNow]' passed (18.533 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (19.800 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (38.665 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (18.266 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (23.400 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (15.416 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (103.869 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (14.295 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (29.395 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
