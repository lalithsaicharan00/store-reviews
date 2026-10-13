# claude/shared-habit-rules-ci44 @ 41045ec

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38329441779 · 2026-10-13 04:51 UTC
Commit: Current Work 92 (checkpoint 2): the shared rules are given their inputs without SwiftUI seeing it; the Watch keeps its Swift rules

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (WeekCardsUITests,TodayRowSheetUITests,RemindersUITests,SectionHeaderUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 504.003 (504.013) seconds
	 Executed 21 tests, with 0 failures (0 unexpected) in 904.249 (904.271) seconds
	 Executed 21 tests, with 0 failures (0 unexpected) in 904.249 (904.272) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 105.352 (105.356) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 266.932 (266.936) seconds
Test Case '-[HabitsUITests.RemindersUITests testDeniedPermissionOffersSettingsAndEmptyState]' passed (17.682 seconds).
Test Case '-[HabitsUITests.RemindersUITests testPlanningActionsPermissionsFailuresAndClockChanges]' passed (56.165 seconds).
Test Case '-[HabitsUITests.RemindersUITests testRealEmptyPageHasNoUnexpectedAlarmErrorOrPermissionPrompt]' passed (14.243 seconds).
Test Case '-[HabitsUITests.RemindersUITests testSavedRemindersOpenEditableTaskWithoutPermissionPrompt]' passed (17.262 seconds).
Test Case '-[HabitsUITests.SectionHeaderUITests testHeaders]' passed (27.963 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testLongPressMenu]' passed (29.986 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testRowOpensDaySheetForEveryKind]' passed (54.145 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetActionsAndDeleteInTheMenu]' passed (52.149 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetFollowsTheDayShown]' passed (27.732 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSwipeActions]' passed (47.532 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testTickTogglesAndPlusAdds]' passed (55.387 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testHabitPageDark]' passed (52.250 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCards]' passed (41.469 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCardsDark]' passed (25.458 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testSquaresKeyFoldedOnceIsFoldedEverywhere]' passed (47.425 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsDark]' passed (71.017 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsLight]' passed (75.007 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsWithGroups]' passed (23.649 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCards]' passed (69.956 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCardsDark]' passed (38.960 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearScrollAndHabitPage]' passed (58.813 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
