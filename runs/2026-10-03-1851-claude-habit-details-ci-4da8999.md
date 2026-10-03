# claude/habit-details-ci @ 4da8999

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37143342313 · 2026-10-03 18:51 UTC
Commit: Add Entry closes at once and the write follows (Rulebook S7): waiting for the database kept it open behind the year demo's writes (HabitPageUITests testHistoryFlows on CI)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (HabitPageUITests,GoalFlowUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 12 tests, with 0 failures (0 unexpected) in 1400.197 (1400.226) seconds
	 Executed 12 tests, with 0 failures (0 unexpected) in 1400.197 (1400.234) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 576.719 (576.729) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 823.478 (823.491) seconds
Test Case '-[HabitsUITests.GoalFlowUITests testButtonAddsItsStepAndRowOpensAddAmount]' passed (129.821 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testHowOftenChoicesSayTheAmount]' passed (84.671 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testNumberShowsWithoutAUnit]' passed (160.487 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testOwnStep]' passed (83.432 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testTypingKeyByKey]' passed (82.098 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testUnitScreen]' passed (36.209 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testHistoryFlows]' passed (80.669 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFlows]' passed (41.300 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDailyTypes]' passed (298.010 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDark]' passed (121.440 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesPeriodLimitQuit]' passed (234.674 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testYearInPixels]' passed (47.385 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
