# day-details-logs-notes-redesign-ci-e @ aa6ee1e

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37624451923 · 2026-10-07 13:44 UTC
Commit: Day details on the iPhone SE: 44-pt buttons and rows, the first and logs gaps as designed

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (HabitScenarioUITests,TodayUITests,CompletionFeedbackUITests,ScheduleUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 23 tests, with 0 failures (0 unexpected) in 1843.988 (1844.011) seconds
	 Executed 23 tests, with 0 failures (0 unexpected) in 1843.988 (1844.013) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 236.637 (236.642) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 1303.467 (1303.474) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 285.113 (285.119) seconds
Test Case '-[HabitsUITests.CompletionFeedbackUITests testCompletionPlaysOnceWhenAHabitBecomesCompleteAndNeverForQuitOrLimits]' passed (18.770 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testCountsAndAmounts]' passed (346.896 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testCutDown]' passed (51.369 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testDaySets]' passed (254.370 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testDaySetsNamedAndAll]' passed (170.274 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testEachTypeStartsWithDefaults]' passed (86.671 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testLongest]' passed (55.686 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testMonthDateSets]' passed (287.098 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testStartsAndEnds]' passed (51.103 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testCalendarAndPersistenceRules]' passed (6.797 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testEveryFewDaysAndWeeks]' passed (42.354 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testLargeTextHowOften]' passed (36.150 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testMonthDatesAndShortMonths]' passed (43.942 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testTaskAfterCompletion]' passed (37.727 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testYearlyDateAndLeapDay]' passed (69.667 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (23.095 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (42.245 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (21.553 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (24.872 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (14.463 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (107.025 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (14.559 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (37.301 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
