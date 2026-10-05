# claude/timer-swipe-limits-and-fixes @ a9b9a23

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37268101680 · 2026-10-05 06:23 UTC
Commit: Notes: search across the full width, Add Note under it in History's button style (Current Work 26, 28)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (CompletionFeedbackUITests,FocusPlayerUITests,GroupsUITests,NewHabitUITests,TodayUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 13 tests, with 0 failures (0 unexpected) in 349.939 (349.949) seconds
	 Executed 20 tests, with 0 failures (0 unexpected) in 1173.042 (1173.062) seconds
	 Executed 51 tests, with 0 failures (0 unexpected) in 2339.548 (2339.602) seconds
	 Executed 51 tests, with 0 failures (0 unexpected) in 2339.548 (2339.604) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 334.692 (334.701) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 459.340 (459.349) seconds
Test Case '-[HabitsUITests.CompletionFeedbackUITests testCompletionPlaysOnceWhenAHabitBecomesCompleteAndNeverForQuitOrLimits]' passed (22.535 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testBottomRowStaysPutAndOptionsShowEverything]' passed (46.259 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testChecklistPreservesPriorStepsAndQueueCanRevisit]' passed (21.394 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCompactProgressAcrossPeriodsAndTypes]' passed (72.109 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCountCheckAndUndoStayOnTheCurrentHabit]' passed (24.242 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLargeTextKeepsActionsAndChecklistReachable]' passed (17.897 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLimitIsNotInTheRoutineAndWaitsUnderQuitOrCutDown]' passed (23.453 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testManualTimePausesAndClockCanBeHidden]' passed (25.686 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testNavigationDoesNotWaitForSlowTimerWrites]' passed (14.689 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testOnlyALimitShowsUnderQuitOrCutDownWithoutStart]' passed (9.227 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSavedFocusProgressSurvivesTermination]' passed (19.263 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerDayBoundaryAndExactUndoPersistence]' passed (6.221 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerGoalDoesNotAutoAdvanceAndManualLogIsReachable]' passed (36.084 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerPauseBackgroundAndSkipPreserveTime]' passed (33.414 seconds).
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (33.375 seconds).
Test Case '-[HabitsUITests.GroupsUITests testDeletingAGroupKeepsItsHabits]' passed (46.360 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (84.299 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' passed (51.402 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (67.740 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupOrderIsThePersonsOwn]' passed (43.563 seconds).
Test Case '-[HabitsUITests.GroupsUITests testNamesAreUniqueAndAGroupCanPause]' passed (51.170 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (41.400 seconds).
Test Case '-[HabitsUITests.GroupsUITests testTodayAndProgressKeepTheirOwnChoiceAndStartPlaysWhatsShown]' passed (40.032 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAmountWithReminderRemoved]' passed (115.743 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAnytimeNeverCombines]' passed (54.852 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCertainDaysReadAsARange]' passed (42.585 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testChecklist]' passed (68.945 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffInTwoTimesOfDay]' passed (101.806 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffThreeTimesAWeek]' passed (45.357 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCopyChecks]' passed (14.354 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCustomUnit]' passed (55.596 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testDatesOfTheMonth]' passed (56.931 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testIconSheetClosesOnPick]' passed (45.416 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeAWeeklyTotal]' passed (52.491 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeTimeAndStaysEditable]' passed (83.992 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testNewTimeOfDayFromTheForm]' passed (70.482 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testOneTimeTask]' passed (28.879 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testQuitDiscard]' passed (33.834 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testReadTwoChaptersAWeek]' passed (69.562 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRemindMeOffHidesTheRest]' passed (42.563 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRunFiveMilesAndWalkTenThousandSteps]' passed (108.433 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTimeUnit]' passed (43.354 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTwoCertainDays]' passed (37.866 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (19.838 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (99.657 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (22.164 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (26.597 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (14.519 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (103.532 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (13.224 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (35.160 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
