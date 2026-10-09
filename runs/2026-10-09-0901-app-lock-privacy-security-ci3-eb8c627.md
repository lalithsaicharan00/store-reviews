# app-lock-privacy-security-ci3 @ eb8c627

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37903473973 · 2026-10-09 09:01 UTC
Commit: Current Work 58: the cover closes its own sheets when it goes; tests wait for the screen they act on (run 37896905498)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (NewHabitUITests,WidgetUITests,TodayUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 20 tests, with 0 failures (0 unexpected) in 1269.052 (1269.071) seconds
	 Executed 34 tests, with 0 failures (0 unexpected) in 1855.758 (1855.793) seconds
	 Executed 34 tests, with 0 failures (0 unexpected) in 1855.758 (1855.798) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 289.211 (289.214) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 297.496 (297.502) seconds
Test Case '-[HabitsUITests.NewHabitUITests testAmountWithReminderRemoved]' passed (241.279 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAnytimeNeverCombines]' passed (57.967 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCertainDaysReadAsARange]' passed (45.315 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testChecklist]' passed (54.919 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffInTwoTimesOfDay]' passed (99.566 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffThreeTimesAWeek]' passed (46.361 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCopyChecks]' passed (13.991 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCustomUnit]' passed (53.225 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testDatesOfTheMonth]' passed (65.069 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testIconSheetClosesOnPick]' passed (33.489 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeAWeeklyTotal]' passed (55.935 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeTimeAndStaysEditable]' passed (75.516 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testNewTimeOfDayFromTheForm]' passed (54.486 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testOneTimeTask]' passed (28.804 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testQuitDiscard]' passed (31.081 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testReadTwoChaptersAWeek]' passed (69.282 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRemindMeOffHidesTheRest]' passed (49.666 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRunFiveMilesAndWalkTenThousandSteps]' passed (105.134 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTimeUnit]' passed (47.265 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTwoCertainDays]' passed (40.701 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (22.162 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (41.885 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (21.715 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (26.997 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (17.817 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (116.570 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (14.036 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (36.313 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' passed (174.207 seconds).
Test Case '-[HabitsUITests.WidgetUITests testGuideAndPrivacyAreFree]' passed (38.304 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLargerTextCountersAndCutDownAreReadable]' passed (31.440 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLongNamesAndUnitsKeepQuickActionVisible]' passed (20.688 seconds).
Test Case '-[HabitsUITests.WidgetUITests testReliabilityUnderBurstsRetriesAndRollover]' passed (15.411 seconds).
Test Case '-[HabitsUITests.WidgetUITests testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks]' passed (9.161 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
