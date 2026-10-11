# claude/pensive-gates-3n4ie8-ci2 @ 0fcfa8f

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38159789736 · 2026-10-11 18:06 UTC
Commit: Current Work 86: Today's rows and headers hide themselves from VoiceOver while a page covers Today; the iPhone's list is main's again

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (IPadUITests,WidgetUITests/testExtraLargeTodayOnTheIPad): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 15 tests, with 2 failures (0 unexpected) in 841.378 (841.415) seconds
	 Executed 16 tests, with 2 failures (0 unexpected) in 879.904 (879.946) seconds
	 Executed 16 tests, with 2 failures (0 unexpected) in 879.904 (879.948) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/IPadUITests.swift:335: error: -[HabitsUITests.IPadUITests testSettingsPagesBesideTheSidebar] : Failed to not hittable: Button, {{400.0, 584.5}, {631.0, 37.5}}, label: 'Morning, Starts 6 AM, All done'
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/IPadUITests.swift:48: error: -[HabitsUITests.IPadUITests testAddLogInsidePopoverSurvivesRotationAndOutsideTaps] : XCTAssertTrue failed - Today: Often Enough | pad-sidebar | sidebar-hide | Hide Sidebar | menu-today | Today, 9 left | sun.max | Brightness Higher | Today | sidebar-today-left | 9 left | menu-progress | Progress | chart.bar.xaxis | menu-habits | Habits, 17 | checklist | Habits | 17 | menu-tasks | Tasks, 0 | list.bullet | List | Tasks | 0 | menu-timesOfDay | Times of Day | rectangle.split.3x1 | Column View | menu-dayAndWeek | Day and Week | calendar | Calendar | menu-reminders | Reminders | bell | Notifications | menu-appearance | Appearance | circle.lefthalf.filled | menu-backup | iCloud & Backup | icloud | Icloud | menu-privacy | Privacy & Security | hand.raised | Block | menu-plus | Plus | plus.circle | Add | Vertical scroll bar, 2 pages | _TtGC7SwiftUI32NavigationStackHosting | chevron.left | Previous day | Today, 6 of 15 done. Open calendar | chevron.down | Go Down | 6/15
Test Case '-[HabitsUITests.IPadUITests testAddLogInsidePopoverSurvivesRotationAndOutsideTaps]' failed (178.061 seconds).
Test Case '-[HabitsUITests.IPadUITests testArrangeTimerAndPlayerFullScreen]' passed (35.475 seconds).
Test Case '-[HabitsUITests.IPadUITests testColumnsViewAndKeyboardCommands]' passed (76.402 seconds).
Test Case '-[HabitsUITests.IPadUITests testDayDetailsPopoverLogsAndAllLogs]' passed (50.446 seconds).
Test Case '-[HabitsUITests.IPadUITests testHabitsListAndPageSideBySide]' passed (45.466 seconds).
Test Case '-[HabitsUITests.IPadUITests testNarrowWindowIsTheIPhoneApp]' passed (35.596 seconds).
Test Case '-[HabitsUITests.IPadUITests testNarrowWindowMidEditKeepsTheTypedAmount]' passed (85.275 seconds).
Test Case '-[HabitsUITests.IPadUITests testPlusEndedIsAFormSheet]' passed (18.894 seconds).
Test Case '-[HabitsUITests.IPadUITests testPlusOnTheIPad]' passed (36.522 seconds).
Test Case '-[HabitsUITests.IPadUITests testProgressTwoAcrossWithRangeAtTheTop]' passed (31.610 seconds).
Test Case '-[HabitsUITests.IPadUITests testSecondDeviceSheetOnTheIPad]' passed (31.239 seconds).
Test Case '-[HabitsUITests.IPadUITests testSettingsPagesBesideTheSidebar]' failed (111.601 seconds).
Test Case '-[HabitsUITests.IPadUITests testSheetsAndPopovers]' passed (31.587 seconds).
Test Case '-[HabitsUITests.IPadUITests testSidebarTodayColumnAndDayControl]' passed (62.944 seconds).
Test Case '-[HabitsUITests.IPadUITests testWelcomeAndEmptyToday]' passed (10.259 seconds).
Test Case '-[HabitsUITests.WidgetUITests testExtraLargeTodayOnTheIPad]' passed (38.526 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
