# claude/pensive-gates-3n4ie8-ci3 @ 0fcfa8f

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38159794690 · 2026-10-11 18:29 UTC
Commit: Current Work 86: Today's rows and headers hide themselves from VoiceOver while a page covers Today; the iPhone's list is main's again

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (TodayUITests,DayDetailsUITests,UndoUITests,ArrangeUITests,GroupsUITests,TodayRowLayoutUITests): cancelled
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 479.799 (479.807) seconds
	 Executed 15 tests, with 0 failures (0 unexpected) in 1256.464 (1256.486) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 97.622 (97.629) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 286.454 (286.460) seconds
Test Case '-[HabitsUITests.ArrangeUITests testAddTimeOfDay]' passed (102.370 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testArrangeChecks]' passed (13.383 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testEditArrangesTheDay]' passed (81.197 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testGroupRowBeforeAnyGroup]' passed (47.068 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testHideCompleted]' passed (42.436 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testCurrencyAndNoUnitAmounts]' passed (35.776 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindDark]' passed (151.161 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindsAddScreen]' passed (356.921 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindShowsItsOwnDay]' passed (138.243 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testHistoryDaysOpenDayDetails]' passed (150.708 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testLogsRuleAndAllLogs]' passed (45.935 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testLogViewThenEditThenDelete]' passed (51.991 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testMarkADayDoneOnlyOnce]' passed (47.852 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testOlderMultiCheckLogStillCorrects]' passed (30.843 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testPastDayLogKeepsItsDayAndChosenTime]' passed (27.568 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testQuitSlipAddViewEditAndDelete]' passed (40.569 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testSkippedDayKeepsLogsAndNote]' passed (52.857 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTasksReschedule]' passed (66.855 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTickSteps]' passed (18.651 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTimeLogAddViewAndEdit]' passed (40.534 seconds).
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (37.687 seconds).
Test Case '-[HabitsUITests.GroupsUITests testDeletingAGroupKeepsItsHabits]' passed (38.489 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (61.914 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' passed (40.513 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupDragDropsReliably]' passed (100.122 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (52.877 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupOrderIsThePersonsOwn]' passed (40.080 seconds).
Test Case '-[HabitsUITests.GroupsUITests testNamesAreUniqueAndAGroupCanPause]' passed (41.066 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (31.768 seconds).
Test Case '-[HabitsUITests.GroupsUITests testTodayAndProgressKeepTheirOwnChoiceAndStartPlaysWhatsShown]' passed (35.282 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testAfterLogButtonsAndNoteSheet]' passed (30.358 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testOneLineUnderEveryName]' passed (18.628 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testQuitRowSwipeLogsASlip]' passed (17.472 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testTaskRowOpensItsSheet]' passed (31.164 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (27.316 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (44.723 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (23.841 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (27.601 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (15.432 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
