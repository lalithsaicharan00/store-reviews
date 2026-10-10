# habit-progress-milestones @ 3ef060e

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38039010621 · 2026-10-10 09:35 UTC
Commit: Habit Progress: Overall record boxes, milestones as medals, All milestones page

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (ProgressUITests,HabitPageUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 16 tests, with 2 failures (0 unexpected) in 1638.436 (1638.458) seconds
	 Executed 25 tests, with 2 failures (0 unexpected) in 1889.934 (1889.965) seconds
	 Executed 25 tests, with 2 failures (0 unexpected) in 1889.934 (1889.966) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 251.498 (251.504) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitPageUITests.swift:54: error: -[HabitsUITests.HabitPageUITests testProgressRedesignPictures] : XCTAssertTrue failed - Call family's page
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitPageUITests.swift:69: error: -[HabitsUITests.HabitPageUITests testProgressRedesignPictures] : Failed to tap "Progress" Button: No matches found for Descendants matching type SegmentedControl from input {(
Test Case '-[HabitsUITests.HabitPageUITests testHistoryFlows]' passed (55.447 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testMilestonesNoneOneMany]' passed (115.728 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFlows]' passed (41.675 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFoldByMonthLikeHistory]' passed (36.878 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNoteViewEditAndDelete]' passed (50.650 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testOverallRecordBoxes]' passed (22.075 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPeriodCardSpacing]' passed (184.608 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDailyTypes]' passed (290.548 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDark]' passed (121.645 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesPeriodLimitQuit]' passed (228.950 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testProgressRedesignPictures]' failed (131.392 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testSquaresKeyFoldedOnceIsFoldedEverywhere]' passed (70.304 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testStreaksOnTheProgressTab]' passed (72.436 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testWeeklyGoalProgress]' passed (35.186 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testYearInPixels]' passed (38.557 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testYearInPixelsDayNumbers]' passed (142.358 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (12.093 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndMilestones]' passed (34.260 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (65.049 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (44.211 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (26.400 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (17.477 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (7.739 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtProgress]' passed (24.544 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (19.726 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
