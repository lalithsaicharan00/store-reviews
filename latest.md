# claude/shared-habit-rules-ci32 @ fc19872

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38318004850 · 2026-10-13 00:23 UTC
Commit: Current Work 92 (checkpoint 2): the shared rules are given habits and settings again only when one they read changed; history asks once a month

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (WeekCardsUITests,TodayRowSheetUITests,RemindersUITests,SectionHeaderUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 482.807 (482.814) seconds
	 Executed 21 tests, with 1 failure (0 unexpected) in 910.149 (910.169) seconds
	 Executed 21 tests, with 1 failure (0 unexpected) in 910.149 (910.172) seconds
	 Executed 4 tests, with 1 failure (0 unexpected) in 172.849 (172.851) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 226.646 (226.652) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/RemindersUITests.swift:14: error: -[HabitsUITests.RemindersUITests testPlanningActionsPermissionsFailuresAndClockChanges] : XCTAssertTrue failed - The reminder checks did not finish
Test Case '-[HabitsUITests.RemindersUITests testDeniedPermissionOffersSettingsAndEmptyState]' passed (24.156 seconds).
Test Case '-[HabitsUITests.RemindersUITests testPlanningActionsPermissionsFailuresAndClockChanges]' failed (105.930 seconds).
Test Case '-[HabitsUITests.RemindersUITests testRealEmptyPageHasNoUnexpectedAlarmErrorOrPermissionPrompt]' passed (22.755 seconds).
Test Case '-[HabitsUITests.RemindersUITests testSavedRemindersOpenEditableTaskWithoutPermissionPrompt]' passed (20.007 seconds).
Test Case '-[HabitsUITests.SectionHeaderUITests testHeaders]' passed (27.848 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testLongPressMenu]' passed (30.757 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testRowOpensDaySheetForEveryKind]' passed (56.487 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetActionsAndDeleteInTheMenu]' passed (42.955 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetFollowsTheDayShown]' passed (24.625 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSwipeActions]' passed (31.891 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testTickTogglesAndPlusAdds]' passed (39.932 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testHabitPageDark]' passed (49.242 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCards]' passed (41.337 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCardsDark]' passed (24.719 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testSquaresKeyFoldedOnceIsFoldedEverywhere]' passed (44.977 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsDark]' passed (65.987 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsLight]' passed (72.984 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsWithGroups]' passed (22.299 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCards]' passed (68.934 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCardsDark]' passed (34.001 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearScrollAndHabitPage]' passed (58.327 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
