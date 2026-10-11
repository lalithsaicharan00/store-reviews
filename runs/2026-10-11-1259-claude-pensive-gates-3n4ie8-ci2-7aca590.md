# claude/pensive-gates-3n4ie8-ci2 @ 7aca590

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38131431056 · 2026-10-11 12:59 UTC
Commit: Current Work 86: container ids keep their rows' own (T9), the sidebar command names itself, onboarding's column, iPad widget sizes in the render check, the iPad's Design Rules and README

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (IPadUITests,WidgetUITests/testExtraLargeTodayOnTheIPad,WidgetUITests/testEveryFamilyAndLayoutAtIPhoneSizes,ICloudUITests/testSyncAgainstTheFakeICloud): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 15 tests, with 10 failures (0 unexpected) in 668.593 (668.642) seconds
	 Executed 18 tests, with 12 failures (0 unexpected) in 1115.327 (1115.383) seconds
	 Executed 18 tests, with 12 failures (0 unexpected) in 1115.327 (1115.384) seconds
	 Executed 2 tests, with 2 failures (0 unexpected) in 218.327 (218.329) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/IPadUITests.swift:101: error: -[HabitsUITests.IPadUITests testSidebarTodayColumnAndDayControl] : XCTAssertTrue failed - Sidebar row menu-about: Often Enough | pad-sidebar | sidebar-hide | Hide Sidebar | menu-today | Today, 9 left | sun.max | Brightness Higher | Today | sidebar-today-left | 9 left | menu-progress | Progress | chart.bar.xaxis | menu-habits | Habits, 17 | checklist | Habits | 17 | menu-tasks | Tasks, 0 | list.bullet | List | Tasks | 0 | menu-timesOfDay | Times of Day | rectangle.split.3x1 | Column View | menu-dayAndWeek | Day and Week | calendar | Calendar | menu-reminders | Reminders | bell | Notifications | menu-appearance | Appearance | circle.lefthalf.filled | menu-backup | iCloud & Backup | icloud | Icloud | menu-privacy | Privacy & Security | hand.raised | Block | menu-plus | Plus | plus.circle | Add | Vertical scroll bar, 2 pages | _TtGC7SwiftUI32NavigationStackHosting | chevron.left | Previous day | Today, 6 of 15 done. Open calendar | chevron.down | Go Down | 6/15
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/IPadUITests.swift:101: error: -[HabitsUITests.IPadUITests testSidebarTodayColumnAndDayControl] : XCTAssertTrue failed - Sidebar row menu-help: Often Enough | pad-sidebar | sidebar-hide | Hide Sidebar | menu-today | Today, 9 left | sun.max | Brightness Higher | Today | sidebar-today-left | 9 left | menu-progress | Progress | chart.bar.xaxis | menu-habits | Habits, 17 | checklist | Habits | 17 | menu-tasks | Tasks, 0 | list.bullet | List | Tasks | 0 | menu-timesOfDay | Times of Day | rectangle.split.3x1 | Column View | menu-dayAndWeek | Day and Week | calendar | Calendar | menu-reminders | Reminders | bell | Notifications | menu-appearance | Appearance | circle.lefthalf.filled | menu-backup | iCloud & Backup | icloud | Icloud | menu-privacy | Privacy & Security | hand.raised | Block | menu-plus | Plus | plus.circle | Add | Vertical scroll bar, 2 pages | _TtGC7SwiftUI32NavigationStackHosting | chevron.left | Previous day | Today, 6 of 15 done. Open calendar | chevron.down | Go Down | 6/15
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/IPadUITests.swift:105: error: -[HabitsUITests.IPadUITests testSidebarTodayColumnAndDayControl] : Failed to get matching snapshot: No matches found for Elements matching predicate '"menu-help" IN identifiers' from input {(
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/IPadUITests.swift:221: error: -[HabitsUITests.IPadUITests testNarrowWindowMidEditKeepsTheTypedAmount] : XCTAssertTrue failed - Narrow: Add log still open: Often Enough | _TtGC7SwiftUI29PresentationHosting | sidebar-button | Show Sidebar | arrange-button | Edit | filter-button | Filter | New Habit | AdditionalDimmingOverlay | Quit or Cut Down, 2 habits | Quit or Cut Down | chevron.right | Fold Quit or Cut Down | nosign | Stop | Smoking | habit-line | Best 45 days | 12d 11:23:47 | wineglass | Alcohol | Best 47 days | 47d 00:00:47 | Anytime, 2 left | Anytime | 2 left | start-Anytime | Start Anytime routine | play.fill | Play | Start | Fold Anytime | book.fill | Bookmark | Read | 12 min/20 min | Streak: Done 6 days in a row | 🔥 | 6 | Start Read timer | phone.fill | Call | Call family | 0/3 this week | Streak: Goal met 4 weeks in a row | 4 wk | checkmark | Add 1 to Call family | drop.fill | Water Drop | Water | 8/8 glasses | Streak: Done 23 days in a row | 23 | Add 1 glass to Water | Morning, Starts 6 AM, All done | Morning | Starts 6 AM | figure.flexibility
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/IPadUITests.swift:222: error: -[HabitsUITests.IPadUITests testNarrowWindowMidEditKeepsTheTypedAmount] : Failed to get matching snapshot: No matches found for first query match sequence: `Descendants matching type TextField` -> `Elements matching predicate '"record-amount" IN identifiers'`, given input App element pid: 61823
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/IPadUITests.swift:378: error: -[HabitsUITests.IPadUITests testColumnsViewAndKeyboardCommands] : XCTAssertTrue failed - ⌘2 shows Columns: Often Enough | pad-sidebar | sidebar-hide | Hide Sidebar | menu-today | Today, 9 left | sun.max | Brightness Higher | Today | sidebar-today-left | 9 left | menu-progress | Progress | chart.bar.xaxis | menu-habits | Habits, 17 | checklist | Habits | 17 | menu-tasks | Tasks, 0 | list.bullet | List | Tasks | 0 | menu-timesOfDay | Times of Day | rectangle.split.3x1 | Column View | menu-dayAndWeek | Day and Week | calendar | Calendar | menu-reminders | Reminders | bell | Notifications | menu-appearance | Appearance | circle.lefthalf.filled | menu-backup | iCloud & Backup | icloud | Icloud | menu-privacy | Privacy & Security | hand.raised | Block | menu-plus | Plus | plus.circle | Add | Vertical scroll bar, 2 pages | _TtGC7SwiftUI32NavigationStackHosting | chevron.left | Previous day | Today, 6 of 15 done. Open calendar | chevron.down | Go Down | 6/15
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/IPadUITests.swift:380: error: -[HabitsUITests.IPadUITests testColumnsViewAndKeyboardCommands] : XCTAssertGreaterThanOrEqual failed: ("0") is less than ("2") - Often Enough | pad-sidebar | sidebar-hide | Hide Sidebar | menu-today | Today, 9 left | sun.max | Brightness Higher | Today | sidebar-today-left | 9 left | menu-progress | Progress | chart.bar.xaxis | menu-habits | Habits, 17 | checklist | Habits | 17 | menu-tasks | Tasks, 0 | list.bullet | List | Tasks | 0 | menu-timesOfDay | Times of Day | rectangle.split.3x1 | Column View | menu-dayAndWeek | Day and Week | calendar | Calendar | menu-reminders | Reminders | bell | Notifications | menu-appearance | Appearance | circle.lefthalf.filled | menu-backup | iCloud & Backup | icloud | Icloud | menu-privacy | Privacy & Security | hand.raised | Block | menu-plus | Plus | plus.circle | Add | Vertical scroll bar, 2 pages | _TtGC7SwiftUI32NavigationStackHosting | chevron.left | Previous day | Today, 6 of 15 done. Open calendar | chevron.down | Go Down | 6/15
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/IPadUITests.swift:439: error: -[HabitsUITests.IPadUITests testPlusOnTheIPad] : XCTAssertLessThanOrEqual failed: ("828.0") is greater than ("560.0") - Plus reads in a 540-pt column: 336,704 828×64
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/IPadUITests.swift:78: error: -[HabitsUITests.IPadUITests testColumnsViewAndKeyboardCommands] : Failed to tap "Stretch" StaticText: No matches found for first query match sequence: `Descendants matching type StaticText` -> `Elements matching predicate '"Stretch" IN identifiers'`, given input App element pid: 55606
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/IPadUITests.swift:90: error: -[HabitsUITests.IPadUITests testSettingsPagesBesideTheSidebar] : Failed to tap "menu-help" Button: No matches found for first query match sequence: `Descendants matching type Button` -> `Elements matching predicate '"menu-help" IN identifiers'`, given input App element pid: 68462
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/WidgetUITests.swift:164: error: -[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes] : Asynchronous wait failed: Exceeded timeout of 5 seconds, with unfulfilled expectations: "Expect predicate `value == "1"` for object "widget-dark" Switch".
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/WidgetUITests.swift:199: error: -[HabitsUITests.WidgetUITests testExtraLargeTodayOnTheIPad] : XCTAssertTrue failed - Add 1 | Add 1 | Mark done | Today | 0 of 5 done | Widget cut down, 0 of 3 cups · Daily limit, +1 | Quitting, 40 days and 58 min, 34 sec | Record a slip | Widget water, Anytime · 0 of 8 glasses, +1 | Widget check, Morning · Not yet | 0 of 10 min | Start timer | 0 of 8k steps | Log an amount | 0 of 3 steps | Open steps | cup.and.saucer.fill | 0 of 3 cups · Daily limit | +1 | Block | Quitting | 40 days and 58 min, 36 sec | Water Drop | 0 of 8 glasses | +1 | Bookmark | Not yet | Selected | Timer | 0 of 10 min | Walk | 0 of 8k steps | List | 0 of 3 steps
Test Case '-[HabitsUITests.ICloudUITests testSyncAgainstTheFakeICloud]' passed (228.407 seconds).
Test Case '-[HabitsUITests.IPadUITests testAddLogInsidePopoverSurvivesRotationAndOutsideTaps]' passed (61.933 seconds).
Test Case '-[HabitsUITests.IPadUITests testArrangeTimerAndPlayerFullScreen]' passed (26.771 seconds).
Test Case '-[HabitsUITests.IPadUITests testColumnsViewAndKeyboardCommands]' failed (34.932 seconds).
Test Case '-[HabitsUITests.IPadUITests testDayDetailsPopoverLogsAndAllLogs]' passed (34.540 seconds).
Test Case '-[HabitsUITests.IPadUITests testHabitsListAndPageSideBySide]' passed (34.997 seconds).
Test Case '-[HabitsUITests.IPadUITests testNarrowWindowIsTheIPhoneApp]' passed (131.434 seconds).
Test Case '-[HabitsUITests.IPadUITests testNarrowWindowMidEditKeepsTheTypedAmount]' failed (73.039 seconds).
Test Case '-[HabitsUITests.IPadUITests testPlusEndedIsAFormSheet]' passed (48.443 seconds).
Test Case '-[HabitsUITests.IPadUITests testPlusOnTheIPad]' failed (55.700 seconds).
Test Case '-[HabitsUITests.IPadUITests testProgressTwoAcrossWithRangeAtTheTop]' passed (30.033 seconds).
Test Case '-[HabitsUITests.IPadUITests testSecondDeviceSheetOnTheIPad]' passed (32.099 seconds).
Test Case '-[HabitsUITests.IPadUITests testSettingsPagesBesideTheSidebar]' failed (42.065 seconds).
Test Case '-[HabitsUITests.IPadUITests testSheetsAndPopovers]' passed (31.085 seconds).
Test Case '-[HabitsUITests.IPadUITests testSidebarTodayColumnAndDayControl]' failed (20.848 seconds).
Test Case '-[HabitsUITests.IPadUITests testWelcomeAndEmptyToday]' passed (10.674 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' failed (180.734 seconds).
Test Case '-[HabitsUITests.WidgetUITests testExtraLargeTodayOnTheIPad]' failed (37.593 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```
