# claude/pensive-gates-3n4ie8-ci2 @ 460ebe9

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38154444009 · 2026-10-11 16:46 UTC
Commit: Current Work 86: as List / as Columns move into the sidebar's menu group; Today's rows are hidden from VoiceOver under a page

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (IPadUITests,WidgetUITests/testExtraLargeTodayOnTheIPad,IPadWidgetSystemUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 15 tests, with 1 failure (0 unexpected) in 658.671 (658.703) seconds
	 Executed 17 tests, with 3 failures (0 unexpected) in 1053.916 (1053.966) seconds
	 Executed 17 tests, with 3 failures (0 unexpected) in 1053.916 (1053.969) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/IPadUITests.swift:335: error: -[HabitsUITests.IPadUITests testSettingsPagesBesideTheSidebar] : Failed to not hittable: Button, {{400.0, 584.5}, {631.0, 37.5}}, label: 'Morning, Starts 6 AM, All done'
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/IPadWidgetSystemUITests.swift:61: error: -[HabitsUITests.IPadWidgetSystemUITests testExtraLargeTodayOnTheHomeScreen] : Failed to get list of active applications: Accessibility error kAXErrorIPCTimeout from AXUIElementCopyMultipleAttributeValues for 1102
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/WidgetUITests.swift:179: error: -[HabitsUITests.WidgetUITests testExtraLargeTodayOnTheIPad] : Failed to get list of active applications: Accessibility error kAXErrorIPCTimeout from AXUIElementCopyMultipleAttributeValues for 1102
Test Case '-[HabitsUITests.IPadUITests testAddLogInsidePopoverSurvivesRotationAndOutsideTaps]' passed (91.148 seconds).
Test Case '-[HabitsUITests.IPadUITests testArrangeTimerAndPlayerFullScreen]' passed (26.484 seconds).
Test Case '-[HabitsUITests.IPadUITests testColumnsViewAndKeyboardCommands]' passed (61.073 seconds).
Test Case '-[HabitsUITests.IPadUITests testDayDetailsPopoverLogsAndAllLogs]' passed (37.873 seconds).
Test Case '-[HabitsUITests.IPadUITests testHabitsListAndPageSideBySide]' passed (40.269 seconds).
Test Case '-[HabitsUITests.IPadUITests testNarrowWindowIsTheIPhoneApp]' passed (45.052 seconds).
Test Case '-[HabitsUITests.IPadUITests testNarrowWindowMidEditKeepsTheTypedAmount]' passed (84.363 seconds).
Test Case '-[HabitsUITests.IPadUITests testPlusEndedIsAFormSheet]' passed (16.757 seconds).
Test Case '-[HabitsUITests.IPadUITests testPlusOnTheIPad]' passed (27.741 seconds).
Test Case '-[HabitsUITests.IPadUITests testProgressTwoAcrossWithRangeAtTheTop]' passed (25.881 seconds).
Test Case '-[HabitsUITests.IPadUITests testSecondDeviceSheetOnTheIPad]' passed (23.367 seconds).
Test Case '-[HabitsUITests.IPadUITests testSettingsPagesBesideTheSidebar]' failed (78.427 seconds).
Test Case '-[HabitsUITests.IPadUITests testSheetsAndPopovers]' passed (28.759 seconds).
Test Case '-[HabitsUITests.IPadUITests testSidebarTodayColumnAndDayControl]' passed (61.528 seconds).
Test Case '-[HabitsUITests.IPadUITests testWelcomeAndEmptyToday]' passed (9.949 seconds).
Test Case '-[HabitsUITests.IPadWidgetSystemUITests testExtraLargeTodayOnTheHomeScreen]' failed (334.890 seconds).
Test Case '-[HabitsUITests.WidgetUITests testExtraLargeTodayOnTheIPad]' failed (60.355 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
