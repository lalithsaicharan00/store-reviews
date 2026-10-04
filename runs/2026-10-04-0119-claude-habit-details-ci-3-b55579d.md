# claude/habit-details-ci-3 @ b55579d

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37164551272 · 2026-10-04 01:19 UTC
Commit: Today rows: only named accessibility actions on a row's container (a default action or hint merged the texts, so names stopped reading as text); HabitCreation expects +1 for twice a day (U14)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (HabitScenarioUITests,HabitCreationUITests,NewHabitUITests,PersistenceUITests): cancelled
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 6 tests, with 0 failures (0 unexpected) in 1095.273 (1095.284) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 1210.351 (1210.357) seconds
Test Case '-[HabitsUITests.HabitCreationUITests testBigNumbers]' passed (136.251 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testDailyShapes]' passed (144.390 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testMonthAndYearShapes]' passed (283.431 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testOtherTypes]' passed (194.142 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testSetDayShapes]' passed (168.983 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testWeeklyShapes]' passed (168.077 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testCountsAndAmounts]' passed (202.976 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testCutDown]' passed (42.472 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testDaySets]' passed (216.198 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testDaySetsNamedAndAll]' passed (164.412 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testEachTypeStartsWithDefaults]' passed (212.782 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testLongest]' passed (61.252 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testMonthDateSets]' passed (263.765 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testStartsAndEnds]' passed (46.494 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAmountWithReminderRemoved]' passed (109.355 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAnytimeNeverCombines]' passed (39.274 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCertainDaysReadAsARange]' passed (50.310 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testChecklist]' passed (147.644 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
