# claude/habit-details-ci-3 @ c751e33

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37161183822 · 2026-10-04 00:15 UTC
Commit: Today's rows, one shape: one line under every name (what today asks: how far along, or how often, then the time; tasks say Task; quit rows their best run), after-log Undo and Add/Edit Note as small capsules on one line, notes in their own sheet with Save, a task's row opens a task sheet (Done, date, Do Tomorrow), done habits move down again

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (HabitScenarioUITests,NewHabitUITests,PersistenceUITests,HabitCreationUITests,HabitPageUITests): cancelled
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 6 tests, with 0 failures (0 unexpected) in 713.976 (713.982) seconds
	 Executed 6 tests, with 2 failures (0 unexpected) in 1267.150 (1267.157) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitCreationUITests.swift:126: error: -[HabitsUITests.HabitCreationUITests testDailyShapes] : XCTAssertTrue failed - Today shows Mark Brush teeth done for F03-twice-a-day
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitCreationUITests.swift:299: error: -[HabitsUITests.HabitCreationUITests testBigNumbers] : XCTAssertTrue failed - 1,000 reads 1k on Today
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitScenarioUITests.swift:142: error: -[HabitsUITests.HabitScenarioUITests testCountsAndAmounts] : failed - Today line "0/3 this week" not found. Texts: 1 left | Anytime | Start | Note for the Day | Today | 0/1
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitScenarioUITests.swift:142: error: -[HabitsUITests.HabitScenarioUITests testDaySets] : failed - Today line "Every day except Mon" not found. Texts: 1 left | Anytime | Start | Note for the Day | Today | 0/1
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitScenarioUITests.swift:142: error: -[HabitsUITests.HabitScenarioUITests testDaySets] : failed - Today line "Every day except Tue and Fri" not found. Texts: 4 left | Anytime | Start | Note for the Day | Today | 0/4
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitScenarioUITests.swift:142: error: -[HabitsUITests.HabitScenarioUITests testDaySets] : failed - Today line "Every Fri to Sun" not found. Texts: 3 left | Anytime | Start | Note for the Day | Today | 0/3
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitScenarioUITests.swift:142: error: -[HabitsUITests.HabitScenarioUITests testDaySets] : failed - Today line "Every Sun to Thu" not found. Texts: 2 left | Anytime | Start | Note for the Day | Today | 0/2
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitScenarioUITests.swift:142: error: -[HabitsUITests.HabitScenarioUITests testDaySetsNamedAndAll] : failed - Today line "On weekends" not found. Texts: 1 left | Anytime | Start | Note for the Day | Today | 0/1
Test Case '-[HabitsUITests.HabitCreationUITests testBigNumbers]' failed (126.338 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testDailyShapes]' failed (148.257 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testMonthAndYearShapes]' passed (475.210 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testOtherTypes]' passed (201.247 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testSetDayShapes]' passed (159.802 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testWeeklyShapes]' passed (156.296 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testHistoryFlows]' passed (55.124 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFlows]' passed (38.659 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDailyTypes]' passed (262.766 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDark]' passed (108.560 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesPeriodLimitQuit]' passed (211.737 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testYearInPixels]' passed (37.129 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testCountsAndAmounts]' failed (183.918 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testCutDown]' passed (39.567 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testDaySets]' failed (195.533 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testDaySetsNamedAndAll]' failed (130.403 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testEachTypeStartsWithDefaults]' passed (96.772 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testLongest]' passed (93.077 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
