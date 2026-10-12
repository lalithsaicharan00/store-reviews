# claude/shared-habit-rules-ci7 @ b122a95

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38229463822 · 2026-10-12 11:04 UTC
Commit: Current Work 92 (checkpoint 2): a log made before the shared rules' copy is built isn't lost

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (WeekCardsUITests,TodayRowSheetUITests,RemindersUITests,SectionHeaderUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 517.755 (517.767) seconds
	 Executed 21 tests, with 0 failures (0 unexpected) in 936.455 (936.483) seconds
	 Executed 21 tests, with 0 failures (0 unexpected) in 936.455 (936.486) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 153.749 (153.755) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 234.499 (234.504) seconds
Test Case '-[HabitsUITests.RemindersUITests testDeniedPermissionOffersSettingsAndEmptyState]' passed (26.417 seconds).
Test Case '-[HabitsUITests.RemindersUITests testPlanningActionsPermissionsFailuresAndClockChanges]' passed (84.514 seconds).
Test Case '-[HabitsUITests.RemindersUITests testRealEmptyPageHasNoUnexpectedAlarmErrorOrPermissionPrompt]' passed (19.960 seconds).
Test Case '-[HabitsUITests.RemindersUITests testSavedRemindersOpenEditableTaskWithoutPermissionPrompt]' passed (22.858 seconds).
Test Case '-[HabitsUITests.SectionHeaderUITests testHeaders]' passed (30.452 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testLongPressMenu]' passed (22.073 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testRowOpensDaySheetForEveryKind]' passed (50.175 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetActionsAndDeleteInTheMenu]' passed (48.137 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetFollowsTheDayShown]' passed (33.903 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSwipeActions]' passed (37.011 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testTickTogglesAndPlusAdds]' passed (43.200 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testHabitPageDark]' passed (51.210 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCards]' passed (44.254 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCardsDark]' passed (27.547 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testSquaresKeyFoldedOnceIsFoldedEverywhere]' passed (50.632 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsDark]' passed (69.597 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsLight]' passed (80.484 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsWithGroups]' passed (24.872 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCards]' passed (72.461 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCardsDark]' passed (37.316 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearScrollAndHabitPage]' passed (59.384 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
