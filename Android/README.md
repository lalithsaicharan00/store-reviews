# The Android App — Build, Test, Run

Written by Claude (Claude Code), 13 October 2026, while building the app (Current Work 107). The decisions, research
and designs are in [`Docs/`](<Docs/README.md>); what's built and measured so far is in
[Android App — Build Results](<Docs/Android App — Build Results.md>).

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
  - `ui/`: Today, Day details, logs and notes, the New Habit form, the drawer, settings; `ui/theme` (light and dark),
    `ui/components` (segmented lists, the cookie shape, the wavy progress).

## Build

The SDK and Google's Maven aren't reachable from the cloud sessions, so **every build runs on GitHub Actions**
(`.github/workflows/android.yml`, Rulebook T1). On your own computer, with Android Studio or the SDK installed:

```sh
cd Android
./gradlew :app:assembleDebug          # the app, app/build/outputs/apk/debug/app-debug.apk
./gradlew :app:testDebugUnitTest      # unit tests (the iPhone's words, the form's rules, the stored formats)
./gradlew :app:lintDebug
./gradlew :app:connectedDebugAndroidTest   # UI tests on a running emulator or phone
```

Install on a phone: `adb install -r app/build/outputs/apk/debug/app-debug.apk`, or download the `android-debug`
artifact from any green run of the **Android** workflow.

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
