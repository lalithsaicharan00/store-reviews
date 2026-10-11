# claude/lucid-johnson-egrjup-ci2 @ 2e77590

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38102266531 · 2026-10-11 02:32 UTC
Commit: Backup page (no database): "check-ins", as everywhere else (item 22's words)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (DayDetailsUITests,DayDetailsScreenshotUITests,GroupsUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 549.580 (549.589) seconds
	 Executed 15 tests, with 0 failures (0 unexpected) in 945.260 (945.269) seconds
	 Executed 21 tests, with 0 failures (0 unexpected) in 833.503 (833.523) seconds
	 Executed 46 tests, with 0 failures (0 unexpected) in 2328.343 (2328.383) seconds
	 Executed 46 tests, with 0 failures (0 unexpected) in 2328.343 (2328.384) seconds
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test01_amount]' passed (87.028 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test02_noUnitWeek]' passed (60.887 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test03_currencyMonth]' passed (46.159 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test04_limit]' passed (43.660 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test05_time]' passed (43.860 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test06_timerRunningAndEarlierDay]' passed (42.962 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test07_fractionalTimer]' passed (23.725 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test08_onceADay]' passed (33.294 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test09_severalADay]' passed (37.661 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test10_weekGoal]' passed (25.576 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test11_monthGoal]' passed (29.565 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test12_daysAWeek]' passed (22.824 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test12b_olderMultiCheckLog]' passed (17.684 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test13_checklist]' passed (29.403 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test14_quit]' passed (58.774 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test15_task]' passed (23.173 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test16_dayStates]' passed (62.776 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test17_notes]' passed (51.692 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test18_deleteConfirmations]' passed (53.730 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test19_lightMode]' passed (20.415 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test20_managementMenu]' passed (18.655 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testCurrencyAndNoUnitAmounts]' passed (27.605 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindDark]' passed (75.700 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindsAddScreen]' passed (223.486 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindShowsItsOwnDay]' passed (96.856 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testHistoryDaysOpenDayDetails]' passed (171.154 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testLogsRuleAndAllLogs]' passed (30.893 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testLogViewThenEditThenDelete]' passed (38.954 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testMarkADayDoneOnlyOnce]' passed (24.337 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testOlderMultiCheckLogStillCorrects]' passed (20.218 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testPastDayLogKeepsItsDayAndChosenTime]' passed (18.846 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testQuitSlipAddViewEditAndDelete]' passed (31.352 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testSkippedDayKeepsLogsAndNote]' passed (37.505 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTasksReschedule]' passed (70.216 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTickSteps]' passed (20.488 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTimeLogAddViewAndEdit]' passed (57.649 seconds).
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (36.872 seconds).
Test Case '-[HabitsUITests.GroupsUITests testDeletingAGroupKeepsItsHabits]' passed (48.333 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (74.919 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' passed (51.947 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupDragDropsReliably]' passed (110.960 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (63.910 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupOrderIsThePersonsOwn]' passed (43.393 seconds).
Test Case '-[HabitsUITests.GroupsUITests testNamesAreUniqueAndAGroupCanPause]' passed (47.887 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (36.292 seconds).
Test Case '-[HabitsUITests.GroupsUITests testTodayAndProgressKeepTheirOwnChoiceAndStartPlaysWhatsShown]' passed (35.067 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
