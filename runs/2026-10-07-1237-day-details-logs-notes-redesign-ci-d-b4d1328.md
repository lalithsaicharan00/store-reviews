# day-details-logs-notes-redesign-ci-d @ b4d1328

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37616762929 · 2026-10-07 12:37 UTC
Commit: Rulebook U27 (go back before deleting what a row opened) and T15 (check small screens on the SE simulator; verify saves in the same launch)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (HabitScenarioUITests,TodayUITests,CompletionFeedbackUITests,ScheduleUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 23 tests, with 0 failures (0 unexpected) in 1635.826 (1635.856) seconds
	 Executed 23 tests, with 0 failures (0 unexpected) in 1635.826 (1635.858) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 200.116 (200.120) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 1127.888 (1127.896) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 281.413 (281.424) seconds
Test Case '-[HabitsUITests.CompletionFeedbackUITests testCompletionPlaysOnceWhenAHabitBecomesCompleteAndNeverForQuitOrLimits]' passed (26.409 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testCountsAndAmounts]' passed (301.120 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testCutDown]' passed (45.121 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testDaySets]' passed (216.235 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testDaySetsNamedAndAll]' passed (153.316 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testEachTypeStartsWithDefaults]' passed (77.466 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testLongest]' passed (50.322 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testMonthDateSets]' passed (245.579 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testStartsAndEnds]' passed (38.729 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testCalendarAndPersistenceRules]' passed (6.761 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testEveryFewDaysAndWeeks]' passed (35.035 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testLargeTextHowOften]' passed (32.530 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testMonthDatesAndShortMonths]' passed (42.803 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testTaskAfterCompletion]' passed (27.359 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testYearlyDateAndLeapDay]' passed (55.629 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (19.778 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (38.185 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (18.710 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (22.945 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (11.575 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (113.538 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (22.137 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (34.546 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
