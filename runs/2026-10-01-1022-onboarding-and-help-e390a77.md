# onboarding-and-help @ e390a77

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36845025236 · 2026-10-01 10:22 UTC
Commit: Onboarding: Make Your Own always in view; list pages' headings as clear rows; tests set an amount and leave search

- Core storage and migrations: success
- Build: success
- UI tests (OnboardingUITests,HabitCreationUITests,NewFlowUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 13 tests, with 1 failure (0 unexpected) in 1334.571 (1334.596) seconds
	 Executed 13 tests, with 1 failure (0 unexpected) in 1334.571 (1334.605) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 1057.720 (1057.731) seconds
	 Executed 6 tests, with 1 failure (0 unexpected) in 172.737 (172.743) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/OnboardingUITests.swift:230: error: -[HabitsUITests.OnboardingUITests testNotNowAndHelp] : XCTAssertTrue failed - Done returns to Help
Test Case '-[HabitsUITests.HabitCreationUITests testBigNumbers]' passed (183.275 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testDailyShapes]' passed (127.180 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testMonthAndYearShapes]' passed (272.848 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testOtherTypes]' passed (171.280 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testSetDayShapes]' passed (158.217 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testWeeklyShapes]' passed (144.920 seconds).
Test Case '-[HabitsUITests.NewFlowUITests testFlow]' passed (104.114 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testLargestTextReachesContinue]' passed (18.445 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNotNowAndHelp]' failed (55.878 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNoWelcomeInOtherRuns]' passed (6.421 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testRestoreFromTheWelcome]' passed (8.885 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testSkipLeadsToAHelpfulToday]' passed (36.327 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testWelcomeToFirstHabit]' passed (46.781 seconds).
```
