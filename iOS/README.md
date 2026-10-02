# iOS

The iPhone app (SwiftUI, native components only). Apple Watch and widget extensions will live here too.

**Before changing a screen, read [Design Rules — Don't Regress](<Design Rules — Don't Regress.md>).**

- **Docs:** the app's own specs (`Docs/Specs/`) and the user's checklists (`Docs/Checklists/`), indexed in [Docs/README.md](<Docs/README.md>). Store-review research stays in `../Research/Research Reports/`.
- **Project:** `Habits.xcodeproj` (targets `Habits` and `HabitsUITests`). Source folders are synchronized, so new files need no project edits. Work order: [Build Plan.md](<Build Plan.md>).
- **Shared core:** `../Core` (Kotlin Multiplatform), built by the target's "Build Kotlin Core" phase (`embedAndSignAppleFrameworkForXcode`; uses Android Studio's JDK if `JAVA_HOME` is unset). It owns local storage today: SQLite through Room 3 ([decision](<../Architecture/Local Database Decision.md>)). The day, streak and progress rules still live in `Habits/Model/HabitStore.swift` and move into Core next ([decision](<../Architecture/Shared Core Decision.md>)).
- **Data on the phone:** `Application Support/Data/habits.db`; local copies in `Application Support/Backups/` (a daily copy, and one before every schema upgrade).
- **Minimum iOS 18**, built with the iOS 26 SDK; iOS 26 adds Liquid Glass (see Backlog C1).
- **Signing:** the paid Apple Developer account, team `MHTC4C9P8F` (2 Oct 2026; before that a free Personal Team). The app's
  entitlements (`Habits.entitlements`): the App Group `group.com.oftenenough.app`, Sign in with Apple, and iCloud Documents
  in `iCloud.com.oftenenough.app`. Xcode's automatic signing registers them on the first install to a phone. From the command line:
  `xcodebuild -project Habits.xcodeproj -scheme Habits -destination 'id=<device>' -derivedDataPath build-device
  -allowProvisioningUpdates -allowProvisioningDeviceRegistration build`, then `xcrun devicectl device install app`
  (first done 2 Oct 2026 on the iPhone 16, iOS 26.6: the App IDs, App Group and iCloud container were created then).
- **Test device:** iPhone 16 (Developer Mode on). Run the UI tests on it with `Research/Temp/ios-device-test.sh <TestClass> <folder>` (scratch script; screenshots land in `Research/Temp/ios-shots/`).
- **Debug builds** save the demo habits from the design into an empty database once, and act as Plus. Launch arguments: `-empty` (no demo), `-free` (free limit), `-uitest` (in-memory database, for UI tests), `-longtext` (demo names, units and sections at their length limits), `-placementcheck` (runs the placement-rule checks instead of Today). Release builds start empty and free.
- **Info.plist:** generated from build settings, plus `Habits-Info.plist` for the keys that can't be settings (background refresh, AlarmKit usage text).
