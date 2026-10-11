# claude/pensive-gates-3n4ie8-ci2 @ b0991b2

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38162641513 · 2026-10-11 18:48 UTC
Commit: Current Work 86: Today is hidden from VoiceOver under a page through UIKit's own flag on its navigation container

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (IPadUITests,WidgetUITests/testExtraLargeTodayOnTheIPad): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 15 tests, with 2 failures (0 unexpected) in 906.453 (906.477) seconds
	 Executed 16 tests, with 2 failures (0 unexpected) in 950.257 (950.285) seconds
	 Executed 16 tests, with 2 failures (0 unexpected) in 950.257 (950.294) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/IPadUITests.swift:336: error: -[HabitsUITests.IPadUITests testSettingsPagesBesideTheSidebar] : Failed to not hittable: Button, {{400.0, 584.5}, {631.0, 37.5}}, label: 'Morning, Starts 6 AM, All done'
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/IPadUITests.swift:412: error: -[HabitsUITests.IPadUITests testColumnsViewAndKeyboardCommands] : XCTAssertTrue failed - ⌘→: Often Enough | pad-sidebar | sidebar-hide | Hide Sidebar | menu-today | Today, 9 left | sun.max | Brightness Higher | Today | sidebar-today-left | 9 left | menu-progress | Progress | chart.bar.xaxis | menu-habits | Habits, 17 | checklist | Habits | 17 | menu-tasks | Tasks, 0 | list.bullet | List | Tasks | 0 | menu-timesOfDay | Times of Day | rectangle.split.3x1 | Column View | menu-dayAndWeek | Day and Week | calendar | Calendar | menu-reminders | Reminders | bell | Notifications | menu-appearance | Appearance | circle.lefthalf.filled | menu-backup | iCloud & Backup | icloud | Icloud | menu-privacy | Privacy & Security | hand.raised | Block | menu-plus | Plus | plus.circle | Add | Vertical scroll bar, 2 pages | _TtGC7SwiftUI32NavigationStackHosting | chevron.left | Previous day | Tue, Oct 13, 0 of 14 done. Open calendar | Tue, Oct 13 | chevron.down | Go Down
Test Case '-[HabitsUITests.IPadUITests testAddLogInsidePopoverSurvivesRotationAndOutsideTaps]' passed (151.458 seconds).
Test Case '-[HabitsUITests.IPadUITests testArrangeTimerAndPlayerFullScreen]' passed (32.067 seconds).
Test Case '-[HabitsUITests.IPadUITests testColumnsViewAndKeyboardCommands]' failed (100.768 seconds).
Test Case '-[HabitsUITests.IPadUITests testDayDetailsPopoverLogsAndAllLogs]' passed (64.151 seconds).
Test Case '-[HabitsUITests.IPadUITests testHabitsListAndPageSideBySide]' passed (40.732 seconds).
Test Case '-[HabitsUITests.IPadUITests testNarrowWindowIsTheIPhoneApp]' passed (29.616 seconds).
Test Case '-[HabitsUITests.IPadUITests testNarrowWindowMidEditKeepsTheTypedAmount]' passed (84.833 seconds).
Test Case '-[HabitsUITests.IPadUITests testPlusEndedIsAFormSheet]' passed (16.348 seconds).
Test Case '-[HabitsUITests.IPadUITests testPlusOnTheIPad]' passed (37.389 seconds).
Test Case '-[HabitsUITests.IPadUITests testProgressTwoAcrossWithRangeAtTheTop]' passed (33.142 seconds).
Test Case '-[HabitsUITests.IPadUITests testSecondDeviceSheetOnTheIPad]' passed (34.563 seconds).
Test Case '-[HabitsUITests.IPadUITests testSettingsPagesBesideTheSidebar]' failed (133.139 seconds).
Test Case '-[HabitsUITests.IPadUITests testSheetsAndPopovers]' passed (36.092 seconds).
Test Case '-[HabitsUITests.IPadUITests testSidebarTodayColumnAndDayControl]' passed (99.704 seconds).
Test Case '-[HabitsUITests.IPadUITests testWelcomeAndEmptyToday]' passed (12.451 seconds).
Test Case '-[HabitsUITests.WidgetUITests testExtraLargeTodayOnTheIPad]' passed (43.804 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
