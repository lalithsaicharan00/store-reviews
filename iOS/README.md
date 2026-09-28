# iOS

The iPhone app (SwiftUI, native components only). Apple Watch and widget extensions will live here too.

- **Project:** `Habits.xcodeproj` (targets `Habits` and `HabitsUITests`). Source folders are synchronized, so new files need no project edits. Work order: [Build Plan.md](<Build Plan.md>).
- **Shared core:** `../Core` (Kotlin Multiplatform), built by the target's "Build Kotlin Core" phase (`embedAndSignAppleFrameworkForXcode`; uses Android Studio's JDK if `JAVA_HOME` is unset). It owns local storage today: SQLite through Room 3 ([decision](<../Architecture/Local Database Decision.md>)). The day, streak and progress rules still live in `Habits/Model/HabitStore.swift` and move into Core next ([decision](<../Architecture/Shared Core Decision.md>)).
- **Data on the phone:** `Application Support/Data/habits.db`; local copies in `Application Support/Backups/` (a daily copy, and one before every schema upgrade).
- **Minimum iOS 18**, built with the iOS 26 SDK; iOS 26 adds Liquid Glass (see Backlog C1).
- **Signing during development:** Personal Team `5RR56C2WTA` (free Apple ID). Switch to the paid developer account before TestFlight / release.
- **Test device:** iPhone 16 (Developer Mode on). Run the UI tests on it with `Research/Temp/ios-device-test.sh <TestClass> <folder>` (scratch script; screenshots land in `Research/Temp/ios-shots/`).
- **Debug builds** save the demo habits from the design into an empty database once, and act as Plus. Launch arguments: `-empty` (no demo), `-free` (free limit), `-uitest` (in-memory database, for UI tests), `-longtext` (demo names, units and sections at their length limits), `-placementcheck` (runs the placement-rule checks instead of Today). Release builds start empty and free.
- **Info.plist:** generated from build settings, plus `Habits-Info.plist` for the keys that can't be settings (background refresh, AlarmKit usage text).
