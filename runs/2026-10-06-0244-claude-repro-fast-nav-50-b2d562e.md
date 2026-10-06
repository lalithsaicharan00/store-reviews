# claude/repro-fast-nav-50 @ b2d562e

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37400562949 · 2026-10-06 02:43 UTC
Commit: FocusPlayerUITests: the slow-write navigation test injects 4 s writes and allows 3 s (a wait still fails); › is now a Liquid Glass bar button whose press animation XCUITest waits out (~0.9 s, run 37387468173)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (HabitCreationUITests,HabitScenarioUITests,PlacementUITests,CompletionFeedbackUITests,SectionHeaderUITests,SyncUITests,AnalyticsUITests,RemindersUITests,FormWalkthroughUITests): cancelled
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 0 failures (0 unexpected) in 219.261 (219.265) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 64.856 (64.861) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 1372.323 (1372.327) seconds
Test Case '-[HabitsUITests.AnalyticsUITests testDurableContentFreeTracking]' passed (25.293 seconds).
Test Case '-[HabitsUITests.AnalyticsUITests testFailedPersistenceNeverCounts]' passed (8.585 seconds).
Test Case '-[HabitsUITests.AnalyticsUITests testUsageConsentIsOptionalAndSeparate]' passed (16.071 seconds).
Test Case '-[HabitsUITests.AnalyticsUITests testWelcomeConsentIsOptional]' passed (14.907 seconds).
Test Case '-[HabitsUITests.CompletionFeedbackUITests testCompletionPlaysOnceWhenAHabitBecomesCompleteAndNeverForQuitOrLimits]' passed (9.890 seconds).
Test Case '-[HabitsUITests.FormWalkthroughUITests testAmountPicksSeveralParts]' passed (148.322 seconds).
Test Case '-[HabitsUITests.FormWalkthroughUITests testCheckOffMorningAndEveningWithReminders]' passed (70.940 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testBigNumbers]' passed (76.253 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testDailyShapes]' passed (548.107 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testMonthAndYearShapes]' passed (270.731 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testOtherTypes]' passed (191.866 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testSetDayShapes]' passed (155.526 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testWeeklyShapes]' passed (129.840 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testCountsAndAmounts]' passed (167.713 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testCutDown]' passed (39.065 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testDaySets]' passed (180.759 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testDaySetsNamedAndAll]' passed (164.564 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testEachTypeStartsWithDefaults]' passed (89.400 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testLongest]' passed (49.680 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testMonthDateSets]' passed (269.998 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
