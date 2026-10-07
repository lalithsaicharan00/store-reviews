# day-details-logs-notes-redesign-ci-d @ d847158

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37609532146 · 2026-10-07 11:47 UTC
Commit: Day details redesign: Core sync test for an edited log time; checklist, Design Rules and branch notes

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (HabitCreationUITests,NewHabitUITests,HabitScenarioUITests,TodayUITests,CompletionFeedbackUITests,ScheduleUITests): cancelled
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 6 tests, with 2 failures (0 unexpected) in 1150.581 (1150.589) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 979.343 (979.351) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitCreationUITests.swift:115: error: -[HabitsUITests.HabitCreationUITests testBigNumbers] : Failed to get matching snapshot: No matches found for Elements matching predicate '"habit-sentence" IN identifiers' from input {(
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitCreationUITests.swift:115: error: -[HabitsUITests.HabitCreationUITests testOtherTypes] : XCTAssertEqual failed: ("Replace brush 3 weeks after it's done, anytime") is not equal to ("Replace brush 3 months after it's done, anytime") - Text preview for X2-task-after-done
Test Case '-[HabitsUITests.CompletionFeedbackUITests testCompletionPlaysOnceWhenAHabitBecomesCompleteAndNeverForQuitOrLimits]' passed (20.178 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testBigNumbers]' failed (160.636 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testDailyShapes]' passed (147.443 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testMonthAndYearShapes]' passed (265.164 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testOtherTypes]' failed (194.461 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testSetDayShapes]' passed (242.267 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testWeeklyShapes]' passed (140.609 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testCountsAndAmounts]' passed (166.730 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testCutDown]' passed (43.617 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testDaySets]' passed (202.873 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testDaySetsNamedAndAll]' passed (152.275 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testEachTypeStartsWithDefaults]' passed (78.937 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testLongest]' passed (49.120 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testMonthDateSets]' passed (241.081 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testStartsAndEnds]' passed (44.711 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAmountWithReminderRemoved]' passed (90.571 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAnytimeNeverCombines]' passed (37.462 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCertainDaysReadAsARange]' passed (34.713 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testChecklist]' passed (46.406 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffInTwoTimesOfDay]' passed (192.018 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
