# details-page-update @ f14ec5e

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37318180981 · 2026-10-05 14:11 UTC
Commit: Merge main (widget research docs) into details-page-update

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (TodayRowSheetUITests,WidgetUITests,WidgetSystemUITests,HabitPageUITests/testSquaresKeyOpensOnlyOnTheFirstVisitToEachHabit,HabitCreationUITests/testOtherTypes,FocusPlayerUITests/testBottomRowStaysPutAndOptionsShowEverything): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 16 tests, with 4 failures (0 unexpected) in 1019.237 (1019.267) seconds
	 Executed 16 tests, with 4 failures (0 unexpected) in 1019.237 (1019.269) seconds
	 Executed 2 tests, with 1 failure (0 unexpected) in 238.362 (238.367) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 178.970 (178.975) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 228.741 (228.749) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitCreationUITests.swift:288: error: -[HabitsUITests.HabitCreationUITests testOtherTypes] : XCTAssertEqual failed: ("Book denti today") is not equal to ("Book dentist today")
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitPageUITests.swift:215: error: -[HabitsUITests.HabitPageUITests testSquaresKeyOpensOnlyOnTheFirstVisitToEachHabit] : XCTAssertFalse failed - Next visit: folded
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitPageUITests.swift:218: error: -[HabitsUITests.HabitPageUITests testSquaresKeyOpensOnlyOnTheFirstVisitToEachHabit] : XCTAssertTrue failed - A tap opens it
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/WidgetSystemUITests.swift:129: error: -[HabitsUITests.WidgetSystemUITests testLockScreenWidgetPickerAvailability] : Failed to get matching snapshots: Lost connection to the application (pid 49916). (Underlying Error: Couldn’t communicate with a helper application. Try your operation again. If that fails, quit and relaunch the application and try again. The connection to service created from an endpoint was invalidated: Failed to check-in, peer may have been unloaded: mach_error=10000003.)
Test Case '-[HabitsUITests.FocusPlayerUITests testBottomRowStaysPutAndOptionsShowEverything]' passed (60.739 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testOtherTypes]' failed (242.847 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testSquaresKeyOpensOnlyOnTheFirstVisitToEachHabit]' failed (69.578 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testLongPressMenu]' passed (29.203 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testRowOpensDaySheetForEveryKind]' passed (60.703 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetActionsAndDeleteInTheMenu]' passed (46.211 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetFollowsTheDayShown]' passed (28.867 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSwipeActions]' passed (39.015 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testTickTogglesAndPlusAdds]' passed (24.742 seconds).
Test Case '-[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence]' passed (171.908 seconds).
Test Case '-[HabitsUITests.WidgetSystemUITests testLockScreenWidgetPickerAvailability]' failed (66.454 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' passed (118.173 seconds).
Test Case '-[HabitsUITests.WidgetUITests testGuideAndPrivacyAreFree]' passed (22.403 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLargerTextCountersAndCutDownAreReadable]' passed (20.242 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLongNamesAndUnitsKeepQuickActionVisible]' passed (10.473 seconds).
Test Case '-[HabitsUITests.WidgetUITests testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks]' passed (7.679 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
