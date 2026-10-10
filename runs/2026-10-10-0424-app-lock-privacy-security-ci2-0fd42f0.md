# app-lock-privacy-security-ci2 @ 0fd42f0

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38020814041 · 2026-10-10 04:24 UTC
Commit: Current Work 73.1: an idea's form leaves by Back without "Discard Changes?" until something is typed (U18; run 37999286664)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (OnboardingBackupScreenshotUITests,OnboardingUITests,NewHabitUITests,NewFlowUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 20 tests, with 0 failures (0 unexpected) in 1141.802 (1141.816) seconds
	 Executed 35 tests, with 0 failures (0 unexpected) in 1923.197 (1923.235) seconds
	 Executed 35 tests, with 0 failures (0 unexpected) in 1923.197 (1923.238) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 224.805 (224.810) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 330.530 (330.536) seconds
Test Case '-[HabitsUITests.NewFlowUITests testFlow]' passed (226.061 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAmountWithReminderRemoved]' passed (144.026 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAnytimeNeverCombines]' passed (54.247 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCertainDaysReadAsARange]' passed (47.063 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testChecklist]' passed (64.591 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffInTwoTimesOfDay]' passed (97.043 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffThreeTimesAWeek]' passed (45.424 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCopyChecks]' passed (14.223 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCustomUnit]' passed (46.889 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testDatesOfTheMonth]' passed (58.259 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testIconSheetClosesOnPick]' passed (33.439 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeAWeeklyTotal]' passed (48.072 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeTimeAndStaysEditable]' passed (69.203 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testNewTimeOfDayFromTheForm]' passed (55.545 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testOneTimeTask]' passed (32.375 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testQuitDiscard]' passed (31.263 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testReadTwoChaptersAWeek]' passed (64.655 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRemindMeOffHidesTheRest]' passed (50.935 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRunFiveMilesAndWalkTenThousandSteps]' passed (104.638 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTimeUnit]' passed (43.493 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTwoCertainDays]' passed (36.417 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testA_Welcome]' passed (71.607 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testB_WelcomeBack]' passed (43.095 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testC_WelcomeReplay]' passed (28.810 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testD_BackupAndExport]' passed (59.046 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testE_PlusAndPrivacy]' passed (22.247 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testCreateMyOwnHabitIsTheUsualNewFlow]' passed (51.555 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testDataOnThisDeviceComesFirst]' passed (18.707 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testFirstHabitAfterMidnightBeforeTheDayStartShowsOnToday]' passed (35.591 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testHelpAndTheWelcomeAgain]' passed (61.496 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testLargestTextReachesContinue]' passed (25.004 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNewPersonToFirstHabit]' passed (54.647 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNoWelcomeInOtherRuns]' passed (6.850 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testReturningWaysBack]' passed (44.354 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testSkipSetupLeadsToAHelpfulToday]' passed (32.326 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
