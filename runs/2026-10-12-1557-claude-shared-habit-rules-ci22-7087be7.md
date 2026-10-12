# claude/shared-habit-rules-ci22 @ 7087be7

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38261607158 · 2026-10-12 15:57 UTC
Commit: Merge remote-tracking branch 'origin/main' into claude/shared-habit-rules-switch

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (WeekCardsUITests,TodayRowSheetUITests,RemindersUITests,SectionHeaderUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 497.147 (497.157) seconds
	 Executed 21 tests, with 1 failure (0 unexpected) in 992.280 (992.309) seconds
	 Executed 21 tests, with 1 failure (0 unexpected) in 992.280 (992.312) seconds
	 Executed 4 tests, with 1 failure (0 unexpected) in 221.494 (221.500) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 239.120 (239.128) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/RemindersUITests.swift:14: error: -[HabitsUITests.RemindersUITests testPlanningActionsPermissionsFailuresAndClockChanges] : XCTAssertTrue failed - The reminder checks did not finish
Test Case '-[HabitsUITests.RemindersUITests testDeniedPermissionOffersSettingsAndEmptyState]' passed (27.542 seconds).
Test Case '-[HabitsUITests.RemindersUITests testPlanningActionsPermissionsFailuresAndClockChanges]' failed (121.773 seconds).
Test Case '-[HabitsUITests.RemindersUITests testRealEmptyPageHasNoUnexpectedAlarmErrorOrPermissionPrompt]' passed (51.739 seconds).
Test Case '-[HabitsUITests.RemindersUITests testSavedRemindersOpenEditableTaskWithoutPermissionPrompt]' passed (20.441 seconds).
Test Case '-[HabitsUITests.SectionHeaderUITests testHeaders]' passed (34.518 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testLongPressMenu]' passed (31.158 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testRowOpensDaySheetForEveryKind]' passed (46.969 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetActionsAndDeleteInTheMenu]' passed (47.373 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetFollowsTheDayShown]' passed (28.411 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSwipeActions]' passed (42.496 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testTickTogglesAndPlusAdds]' passed (42.714 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testHabitPageDark]' passed (48.729 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCards]' passed (44.254 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCardsDark]' passed (27.252 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testSquaresKeyFoldedOnceIsFoldedEverywhere]' passed (47.472 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsDark]' passed (66.455 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsLight]' passed (74.115 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsWithGroups]' passed (25.102 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCards]' passed (72.362 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCardsDark]' passed (35.003 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearScrollAndHabitPage]' passed (56.403 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
