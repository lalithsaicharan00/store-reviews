# claude/pensive-gates-3n4ie8-ci13 @ fee7a39

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38149953441 · 2026-10-11 16:42 UTC
Commit: Current Work 86: as List / as Columns are buttons that fire from the menu bar; a page beside the sidebar is modal to VoiceOver

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (IPadUITests,WidgetUITests/testExtraLargeTodayOnTheIPad,IPadWidgetSystemUITests,ICloudUITests/testSyncAgainstTheFakeICloud): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 15 tests, with 2 failures (0 unexpected) in 724.973 (724.995) seconds
	 Executed 18 tests, with 4 failures (0 unexpected) in 1213.592 (1213.630) seconds
	 Executed 18 tests, with 4 failures (0 unexpected) in 1213.592 (1213.636) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/IPadUITests.swift:137: error: -[HabitsUITests.IPadUITests testSidebarTodayColumnAndDayControl] : XCTAssertLessThanOrEqual failed: ("740.0") is greater than ("720.0") - The column is ≈ 700 pt: header 498,413 526×20, cell 478,386 740×74
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/IPadUITests.swift:73: error: -[HabitsUITests.IPadUITests testColumnsViewAndKeyboardCommands] : XCTAssertTrue failed - ⌘2 shows Columns: Often Enough | pad-sidebar | sidebar-hide | Hide Sidebar | menu-today | Today, 9 left | sun.max | Brightness Higher | Today | sidebar-today-left | 9 left | menu-progress | Progress | chart.bar.xaxis | menu-habits | Habits, 17 | checklist | Habits | 17 | menu-tasks | Tasks, 0 | list.bullet | List | Tasks | 0 | menu-timesOfDay | Times of Day | rectangle.split.3x1 | Column View | menu-dayAndWeek | Day and Week | calendar | Calendar | menu-reminders | Reminders | bell | Notifications | menu-appearance | Appearance | circle.lefthalf.filled | menu-backup | iCloud & Backup | icloud | Icloud | menu-privacy | Privacy & Security | hand.raised | Block | menu-plus | Plus | plus.circle | Add | menu-help | Help & Feedback | questionmark.circle | menu-about | About | info.circle | Info | Vertical scroll bar, 1 page
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/IPadWidgetSystemUITests.swift:61: error: -[HabitsUITests.IPadWidgetSystemUITests testExtraLargeTodayOnTheHomeScreen] : Failed to swipe left Application 'com.apple.springboard': Timed out while evaluating UI query.
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/WidgetUITests.swift:179: error: -[HabitsUITests.WidgetUITests testExtraLargeTodayOnTheIPad] : Failed to get list of active applications: Accessibility error kAXErrorIPCTimeout from AXUIElementCopyMultipleAttributeValues for 1102
Test Case '-[HabitsUITests.ICloudUITests testSyncAgainstTheFakeICloud]' passed (167.506 seconds).
Test Case '-[HabitsUITests.IPadUITests testAddLogInsidePopoverSurvivesRotationAndOutsideTaps]' passed (60.027 seconds).
Test Case '-[HabitsUITests.IPadUITests testArrangeTimerAndPlayerFullScreen]' passed (30.250 seconds).
Test Case '-[HabitsUITests.IPadUITests testColumnsViewAndKeyboardCommands]' failed (71.287 seconds).
Test Case '-[HabitsUITests.IPadUITests testDayDetailsPopoverLogsAndAllLogs]' passed (52.294 seconds).
Test Case '-[HabitsUITests.IPadUITests testHabitsListAndPageSideBySide]' passed (39.717 seconds).
Test Case '-[HabitsUITests.IPadUITests testNarrowWindowIsTheIPhoneApp]' passed (34.097 seconds).
Test Case '-[HabitsUITests.IPadUITests testNarrowWindowMidEditKeepsTheTypedAmount]' passed (86.792 seconds).
Test Case '-[HabitsUITests.IPadUITests testPlusEndedIsAFormSheet]' passed (17.933 seconds).
Test Case '-[HabitsUITests.IPadUITests testPlusOnTheIPad]' passed (30.379 seconds).
Test Case '-[HabitsUITests.IPadUITests testProgressTwoAcrossWithRangeAtTheTop]' passed (34.638 seconds).
Test Case '-[HabitsUITests.IPadUITests testSecondDeviceSheetOnTheIPad]' passed (24.709 seconds).
Test Case '-[HabitsUITests.IPadUITests testSettingsPagesBesideTheSidebar]' passed (122.234 seconds).
Test Case '-[HabitsUITests.IPadUITests testSheetsAndPopovers]' passed (33.969 seconds).
Test Case '-[HabitsUITests.IPadUITests testSidebarTodayColumnAndDayControl]' failed (74.566 seconds).
Test Case '-[HabitsUITests.IPadUITests testWelcomeAndEmptyToday]' passed (12.081 seconds).
Test Case '-[HabitsUITests.IPadWidgetSystemUITests testExtraLargeTodayOnTheHomeScreen]' failed (260.653 seconds).
Test Case '-[HabitsUITests.WidgetUITests testExtraLargeTodayOnTheIPad]' failed (60.460 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
