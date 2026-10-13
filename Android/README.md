# The Android App — Build, Test, Run

Written by Claude (Claude Code), 13 October 2026, while building the app (Current Work 107). The decisions, research
and designs are in [`Docs/`](<Docs/README.md>); what's built and measured so far is in
[Android App — Build Results](<Docs/Android App — Build Results.md>).

**Continuing this work? Start at [Android App — Build Results](<Docs/Android App — Build Results.md>)** (what's built,
measured and still to do, checkpoint by checkpoint). The earlier [handoff](<Docs/Android App — Handoff for the Next Agent.md>)
is history: everything it parked in `Android/WIP/` is built and that folder is gone.

## What it is

Often Enough for Android: Jetpack Compose, Material 3 (Expressive, as on Android 16), one activity, `com.oftenenough.app`,
minSdk 26, target 37. It runs on the shared core in [`../Core`](<../Core/>), the same rules and database as the iPhone:

- **`Core/`** (a composite build, `includeBuild("../Core")`): the Room 3 database (`HabitRepository`), Google Drive sync
  (`Core/sync`) and the habit rules (`Core/rules`). Its Android target is switched on only when Android builds it
  (`core.android=true` in `gradle.properties`), so `Core`'s own CI (`core-tests.yml`) is unchanged.
- **`app/src/main/kotlin/com/oftenenough/app/`**
  - `data/RulesGateway.kt`: **the one place that calls `app.habits.rules`** (`LiveRules`, `RulesInput`, `Rows`). Screens
    never import the rules; when the rules' API changes, only this file does.
  - `data/HabitStore.kt`: the app's state. A tap changes the screen at once and the write follows in order (S7);
    history is worked out once and remembered (S5); each habit has its own revision so a log redraws its own row (S6).
  - `data/Model.kt`, `Records.kt`, `SwiftJson.kt`: the habits and logs, stored exactly as the iPhone stores them
    (the same settings keys and JSON), so a backup moves between the two.
  - `data/Words.kt`, `StoreWords.kt`, `HowOften.kt`, `FormWords.kt`, `SectionPlan.kt`: the iPhone's words and form rules,
    ported from Swift with tests and marked `// MOVE TO CORE` (listed in the results file).
  - `ui/`: every screen (Today, Day details, logs and notes, the New Habit form, Habit details, Progress, the routine
    player and timer, the Habits and Tasks lists, Filter and groups, Arrange your day, Pause, every settings page);
    `ui/theme` (light and dark), `ui/components` (segmented lists, the cookie shape, the wavy progress).
    `ui/AppRoot.kt` is the navigation, and the frame for tablets (a sidebar from 840 dp; the phone never changes).
  - `app/`: `AppGraph` (one store per process), `AppLock`, `Plus` (the store seam: a fake store until Play Billing),
    `app/backup/` (backup files, restore, Drive, `SyncSchedule`), `app/reminders/`, and `app/widgets/` (the six Glance
    widgets, the tap, the setup screen). Code marked `LOCKED (widget taps …)` follows
    [the iPhone's locked page](<../iOS/Docs/Widgets — Taps and Updates (Locked).md>): read it before changing a widget.

## Build

**On the user's Windows PC, build and test there first** (its Android SDK and emulators are faster than waiting for
CI; the user, 13 Oct 2026); GitHub Actions is for more emulators side by side and for the API 35 check. A cloud session
reaches neither the SDK nor Google's Maven, so there every build runs on GitHub Actions (`.github/workflows/android.yml`,
Rulebook T1, T22). With Android Studio or the SDK installed:

```sh
cd Android
./gradlew :app:assembleDebug          # the app, app/build/outputs/apk/debug/app-debug.apk
./gradlew :app:testDebugUnitTest      # unit tests (the iPhone's words, the form's rules, the stored formats)
./gradlew :app:lintDebug
./gradlew :app:connectedDebugAndroidTest   # UI tests on a running emulator or phone
```

Install on a phone: `adb install -r app/build/outputs/apk/debug/app-debug.apk`, or download the `android-debug`
artifact from any green run of the **Android** workflow.

**On that PC (Git Bash), three things cost time once** (Rulebook T22): Gradle's Java needs
`JAVA_TOOL_OPTIONS=-Djava.net.preferIPv4Stack=true` (its downloads timed out while curl worked); `local.properties`
is `sdk.dir=C\:/Users/<you>/AppData/Local/Android/Sdk` (forward slashes); and `adb shell` paths need
`MSYS_NO_PATHCONV=1`, which must **not** be set for Gradle. Java is Android Studio's own (`…/Android Studio/jbr`).
Scratch files, logs and screenshots go in `Research/Temp/` (ignored by git), never the system's temp folder.

## Tests

| Where | Class | What |
|---|---|---|
| JVM (`testDebugUnitTest`, 52) | `WordsTest`, `SwiftJsonTest`, `FormRulesTest`, `DataExportTest`, `ReminderPlanTest`, `LocalDriveTest`, `PlayerWordsTest`, `ProgressWordsTest`, `PauseWordsTest`, `ReminderWordsTest`, `AppLockTest`, `ArrangeTest` | The iPhone's words and rules, the stored formats, the stand-in Drive, App lock's rules |
| Emulator | `TodayTest` (11) | The welcome, an empty Today, logging and undo for every kind |
| Emulator | `ScreensTest` (13) | Habit details, Progress, a routine, Pause, the Habits list, groups and Filter, Arrange, Help, Plus, App lock, a row's menu, the icon's shortcuts |
| Emulator | `WidgetDataTest` (8) | The widgets' snapshot, the "after" cards, a tap saved once |
| Emulator | `DataSafetyTest` (5) | Backup and restore round trip, undo, Merge, an empty or broken file, taps saved in order |
| Emulator | `TabletTest` (3) | The sidebar and centred column at 1280 × 800 dp (it sets the display and puts it back) |
| Emulator | `SpeedTest` (1) | Frame times with 30 habits and two years of history, beside a control; numbers in the log as `Speed: …` |

A speed check never goes through the Compose test rule: it drives frames from the test's own clock and adds 100–250 ms
of waiting to every frame (found 13 Oct 2026). `SpeedTest` uses UI Automator's real touches and Android's own frame
numbers.

## CI

- **Every push that changes `Android/**`** builds the app, runs the unit tests and lint (job `build`, ~5 minutes).
- **UI tests on the emulator** (job `instrumented`, Pixel 6, API 35): put `[android-ci]` in the commit message, or run
  the workflow by hand (`instrumented`, and `classes` to pick test classes). Follow T10: ordinary pushes stay untagged.
- **Debug signing:** a stable debug key lives only in the GitHub secrets `ANDROID_DEBUG_KEYSTORE_BASE64` and
  `ANDROID_DEBUG_KEYSTORE_PASSWORD` (D11); without them the build uses the SDK's own debug key.

## Test launches

A test launch never touches the person's data (D8): `MainActivity` with the extra `uitest=true` gets an in-memory
database and its own preferences. Other extras: `clockHour` (the store's clock runs from that hour, :30; T11),
`demo` (`today`: the designs' habits; `year`: a year of history; `many`: 30 habits over two years) and `onboarding`
(show the welcome). From a shell:

```sh
adb shell am start -n com.oftenenough.app/.app.MainActivity --ez uitest true --ei clockHour 10 --es demo today
```
