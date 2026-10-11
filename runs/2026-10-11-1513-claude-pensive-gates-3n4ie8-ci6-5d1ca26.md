# claude/pensive-gates-3n4ie8-ci6 @ 5d1ca26

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38144971935 · 2026-10-11 15:13 UTC
Commit: Current Work 86: each Columns list holds its own height, so a column that changes redraws only itself

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (OnboardingBackupScreenshotUITests/testA_Welcome,OnboardingUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 383.257 (383.264) seconds
	 Executed 11 tests, with 0 failures (0 unexpected) in 524.898 (524.908) seconds
	 Executed 11 tests, with 0 failures (0 unexpected) in 524.898 (524.910) seconds
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testA_Welcome]' passed (141.641 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testCreateMyOwnHabitIsTheUsualNewFlow]' passed (66.153 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testDataOnThisDeviceComesFirst]' passed (20.136 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testFirstHabitAfterMidnightBeforeTheDayStartShowsOnToday]' passed (47.423 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testHabitsComeBackFromICloud]' passed (18.352 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testHelpAndTheWelcomeAgain]' passed (73.813 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testLargestTextReachesContinue]' passed (27.490 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNewPersonToFirstHabit]' passed (58.069 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNoWelcomeInOtherRuns]' passed (7.716 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testReturningWaysBack]' passed (24.011 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testSkipSetupLeadsToAHelpfulToday]' passed (40.095 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
