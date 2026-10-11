# claude/pensive-gates-3n4ie8-ci2 @ a1eed4b

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38141959437 · 2026-10-11 15:02 UTC
Commit: Current Work 86: Day details keeps Add log and its typed amount as the window narrows; Plus's Buy keeps to its column

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (IPadUITests,WidgetUITests/testExtraLargeTodayOnTheIPad,WidgetUITests/testEveryFamilyAndLayoutAtIPhoneSizes,IPadWidgetSystemUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 15 tests, with 4 failures (0 unexpected) in 788.187 (788.262) seconds
	 Executed 18 tests, with 6 failures (0 unexpected) in 1080.592 (1080.673) seconds
	 Executed 18 tests, with 6 failures (0 unexpected) in 1080.592 (1080.674) seconds
	 Executed 2 tests, with 1 failure (0 unexpected) in 211.511 (211.513) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/IPadUITests.swift:137: error: -[HabitsUITests.IPadUITests testSidebarTodayColumnAndDayControl] : XCTAssertGreaterThanOrEqual failed: ("272.0") is less than ("600.0") - …and uses the room: cell 24,125 272×50
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/IPadUITests.swift:139: error: -[HabitsUITests.IPadUITests testSidebarTodayColumnAndDayControl] : XCTAssertLessThan failed: ("586.0") is not less than ("30.0") - …centred: cell 24,125 272×50, room (312.0, 1180.0)
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/IPadUITests.swift:332: error: -[HabitsUITests.IPadUITests testSettingsPagesBesideTheSidebar] : Failed to not hittable: Button, {{400.0, 584.5}, {631.0, 37.5}}, label: 'Morning, Starts 6 AM, All done'
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/IPadUITests.swift:73: error: -[HabitsUITests.IPadUITests testColumnsViewAndKeyboardCommands] : XCTAssertTrue failed - ⌘2 shows Columns: Often Enough | pad-sidebar | sidebar-hide | Hide Sidebar | menu-today | Today, 9 left | sun.max | Brightness Higher | Today | sidebar-today-left | 9 left | menu-progress | Progress | chart.bar.xaxis | menu-habits | Habits, 17 | checklist | Habits | 17 | menu-tasks | Tasks, 0 | list.bullet | List | Tasks | 0 | menu-timesOfDay | Times of Day | rectangle.split.3x1 | Column View | menu-dayAndWeek | Day and Week | calendar | Calendar | menu-reminders | Reminders | bell | Notifications | menu-appearance | Appearance | circle.lefthalf.filled | menu-backup | iCloud & Backup | icloud | Icloud | menu-privacy | Privacy & Security | hand.raised | Block | menu-plus | Plus | plus.circle | Add | Vertical scroll bar, 2 pages | _TtGC7SwiftUI32NavigationStackHosting | chevron.left | Previous day | Today, 6 of 15 done. Open calendar | chevron.down | Go Down | 6/15
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/IPadWidgetSystemUITests.swift:64: error: -[HabitsUITests.IPadWidgetSystemUITests testExtraLargeTodayOnTheHomeScreen] : XCTAssertTrue failed - Today in Extra Large in the iPad's gallery: Attributes: Application, 0x11b2e9a40, pid: 37226, label: ' '
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/WidgetUITests.swift:205: error: -[HabitsUITests.WidgetUITests testExtraLargeTodayOnTheIPad] : XCTAssertTrue failed - Add 1 | Add 1 | Mark done | Today | 0 of 5 done | Widget cut down, 0 of 3 cups · Daily limit, +1 | Quitting, 40 days and 3 hr, 1 min | Record a slip | Widget water, Anytime · 0 of 8 glasses, +1 | Widget check, Morning · Not yet | 0 of 10 min | Start timer | 0 of 8k steps | Log an amount | 0 of 3 steps | Open steps | cup.and.saucer.fill | 0 of 3 cups · Daily limit | +1 | Block | Quitting | 40 days and 3 hr, 1 min | Water Drop | 0 of 8 glasses | +1 | Bookmark | Not yet | Selected | Timer | 0 of 10 min | Walk | 0 of 8k steps | List | 0 of 3 steps
Test Case '-[HabitsUITests.IPadUITests testAddLogInsidePopoverSurvivesRotationAndOutsideTaps]' passed (115.157 seconds).
Test Case '-[HabitsUITests.IPadUITests testArrangeTimerAndPlayerFullScreen]' passed (32.680 seconds).
Test Case '-[HabitsUITests.IPadUITests testColumnsViewAndKeyboardCommands]' failed (71.081 seconds).
Test Case '-[HabitsUITests.IPadUITests testDayDetailsPopoverLogsAndAllLogs]' passed (53.882 seconds).
Test Case '-[HabitsUITests.IPadUITests testHabitsListAndPageSideBySide]' passed (44.234 seconds).
Test Case '-[HabitsUITests.IPadUITests testNarrowWindowIsTheIPhoneApp]' passed (31.657 seconds).
Test Case '-[HabitsUITests.IPadUITests testNarrowWindowMidEditKeepsTheTypedAmount]' passed (85.084 seconds).
Test Case '-[HabitsUITests.IPadUITests testPlusEndedIsAFormSheet]' passed (19.149 seconds).
Test Case '-[HabitsUITests.IPadUITests testPlusOnTheIPad]' passed (39.339 seconds).
Test Case '-[HabitsUITests.IPadUITests testProgressTwoAcrossWithRangeAtTheTop]' passed (35.743 seconds).
Test Case '-[HabitsUITests.IPadUITests testSecondDeviceSheetOnTheIPad]' passed (34.726 seconds).
Test Case '-[HabitsUITests.IPadUITests testSettingsPagesBesideTheSidebar]' failed (107.043 seconds).
Test Case '-[HabitsUITests.IPadUITests testSheetsAndPopovers]' passed (36.976 seconds).
Test Case '-[HabitsUITests.IPadUITests testSidebarTodayColumnAndDayControl]' failed (69.652 seconds).
Test Case '-[HabitsUITests.IPadUITests testWelcomeAndEmptyToday]' passed (11.782 seconds).
Test Case '-[HabitsUITests.IPadWidgetSystemUITests testExtraLargeTodayOnTheHomeScreen]' failed (80.894 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' passed (176.156 seconds).
Test Case '-[HabitsUITests.WidgetUITests testExtraLargeTodayOnTheIPad]' failed (35.355 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
