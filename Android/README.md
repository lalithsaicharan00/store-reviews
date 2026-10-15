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
    `app/account/` (the Plus account and Plus Family: `AccountCenter`, the server seam `AccountServer` with its
    stand-in, Sign in with Google through Credential Manager; see "Plus & Account" below),
    `app/backup/` (backup files, restore, Drive, `SyncSchedule`), `app/reminders/`, and `app/widgets/` (the six Glance
    widgets, the tap, the setup screen). Code marked `LOCKED (widget taps …)` follows
    [the iPhone's locked page](<../iOS/Docs/Widgets — Taps and Updates (Locked).md>): read it before changing a widget.

## Text: one set of styles, Google Sans Flex, always in sp

The user, 15 Oct 2026: "create the shared text styles for Android … so that nothing stays inconsistent … they should
not be absolute units … if someone has an increased font size they should reflect here." Rulebook **U36**.

- **Every piece of text uses a style from [`ui/theme/Type.kt`](<app/src/main/kotlin/com/oftenenough/app/ui/theme/Type.kt>)**
  (`AppType`): the Figma file's **Android / …** styles, Material 3's sizes (57, 45, 36, 32, 28, 24, 22, 16, 14, 12, 11)
  plus our 20, Regular and Medium ("Emphasized") only, line heights Material's, letter spacing 0. Material's own
  components get the same styles through `MaterialTheme.typography` (`AppType.material`). **Never** `fontSize = …`,
  `TextStyle(fontSize = …)` or `.copy(fontSize = …)` in a screen: pick the style for the job (each one's job is written
  above it). A truly new size goes into Figma first, then `Type.kt`.
- **Google Sans Flex everywhere** (`Fonts.kt`: bundled, never downloaded, optical size following the text size). Roboto
  is gone from the app's own screens. Not styled: the status bar, the keyboard, icon glyphs, the 🔥, and the home-screen
  widgets (Glance draws with the launcher's system font; their sizes follow the widget designs).
- **Always sp, never dp or px, for text.** sp follows the phone's Font size and Display size (Android 14+ also scales
  large text less than small, by itself). So a text's container never has a fixed height: rows and buttons take a
  minimum (`heightIn(min = …)`), and pages scroll, so 200 % text grows them instead of clipping. The one exception is
  a number drawn inside a fixed graphic (a milestone medal), which is sized to its shape.

## Plus & Account (Figma `1476:2`, built 15 Oct 2026)

≡ › **Plus & Account**: the page in its five states (Free; Plus, no account yet; Plus with an account; Plus Family, you
manage it; Plus from a family; and free with an account) and every flow from the Figma section: Get Plus and the Plus
Family upgrade, the purchase outcomes (bought, waiting for payment, not completed), the thank-you screens that offer the
account, Sign in (looking, Plus is back, no account found, couldn't connect), Restore from Google Play, Create an
account, Join a family (link or QR code via Google's code scanner) and every invite state, the invite sheets with a
real QR code, and every dialog (sign out, delete, remove, leave, cancel an invite). Code: `ui/plus/`, `app/account/`.

- **Icons are Figma's own:** Material Symbols Rounded, outlined (`ui/plus/Symbols.kt`, the Symbols' outlines; the older
  Material Icons draw some of them filled), and Material Icons Round in the hero cookies, as Figma sets them. Dialogs
  are drawn as Figma's (`PlusDialogFrame`: the icon at the start, only deleting the account in red). Checked against
  every frame on 15 Oct 2026 (Current Work 110).
- **The loading animation** (`ui/components/LoadingIndicator.kt`): Material 3 Expressive's contained loading
  indicator, drawn with `graphics-shapes`, the library Material's own uses (seven shapes morphing every 650 ms, two turns
  in 4.55 s, as Figma animates it). Material's `ContainedLoadingIndicator` isn't public in the stable Material 3 (1.4.0);
  swap to it when it is.
- **What's real and what's a stand-in until the user's set-up exists** (Current Work 110):

  | Piece | Today | Needs |
  |---|---|---|
  | The account server (D1 accounts, families, invites) | **The Worker** (`account-server/`, built 16 Oct 2026): `HttpAccountServer`. Debug builds with the Google client talk to dev, release builds to production (both live; production released 16 Oct 2026). The UI tests and builds without the client use `StandInAccountServer`, with the same rules (`PlusAccountTest`). `-PaccountServer=standin\|dev\|production` overrides | Production's first release |
  | Sign in with Google | Real (`GoogleSignInProvider`, Credential Manager, a fresh nonce per sign-in), when the build has the client ID (`googleWebClientId`); the Worker checks Google's token | Checking once on a real phone with a real Google account |
  | Checking purchases with Google Play | The Worker asks the Play Developer API as the service account | The service account's JSON key in production (`account-server/README.md`) |
  | Sign in with Apple | Stand-in only | The Worker's web sign-in page (Apple's sign-in on Android is a web flow) |
  | Buying, restoring | `FakePlusStore` (debug, tests) | The Play Console app and its three products; then `PlusStore` over Play Billing |
  | Invite links opening the app | The intent filter for `https://oftenenough.com/join/…` | `/.well-known/assetlinks.json` on the website with the app's signing SHA-256 |
  | "Priya joined your family" on the owner's phone (Figma 5.2.1) | Not built: the owner sees it in Your family on the next open | Push (Firebase Cloud Messaging) from the Worker |
  | A new device on a different cloud account stops before syncing (D16) | Not built | The Worker's record of the cloud account |

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
`MSYS_NO_PATHCONV=1`, which must **not** be set for Gradle. Java is Android Studio's own (`…/Android Studio/jbr`); on 15 Oct 2026 that folder was incomplete, and the JDK in `C:/Program Files/Java/jdk-26.0.1` built everything (`JAVA_HOME`).
Scratch files, logs and screenshots go in `Research/Temp/` (ignored by git), never the system's temp folder.

## Tests

| Where | Class | What |
|---|---|---|
| JVM (`testDebugUnitTest`, 52) | `WordsTest`, `SwiftJsonTest`, `FormRulesTest`, `DataExportTest`, `ReminderPlanTest`, `LocalDriveTest`, `PlayerWordsTest`, `ProgressWordsTest`, `PauseWordsTest`, `ReminderWordsTest`, `AppLockTest`, `ArrangeTest` | The iPhone's words and rules, the stored formats, the stand-in Drive, App lock's rules |
| Emulator | `TodayTest` (11) | The welcome, an empty Today, logging and undo for every kind |
| JVM | `HttpAccountServerTest` (11) | The app's client for the account Worker against a local stand-in: what it sends (the session, the nonce, the purchase), and how it reads every answer, failures included |
| Emulator | `AccountServerLiveTest` (2) | The app against the live dev Worker: its client through a whole family, and the screens (buy Plus Family, sign in, invite, someone joins, remove, delete). Needs dev's test secret (`account-server/README.md`) |
| JVM | `PlusAccountTest` (10) | The account's rules on the server's stand-in: one account each, six in a family, an invite once for 7 days, leaving, deleting, offline, the account file |
| Emulator | `PlusAccountScreensTest` (10) | Plus & Account: buying Plus and Plus Family, pending and failed payments, restore, sign in (found, none, offline), an invite link joining and leaving, ended and used invites, deleting the account |
| Emulator | `PlusAccountFramesTest` (6) | Every frame of Figma `1476:2`, reached through its own flow, its words checked and a picture saved as the frame's number (`files/plus-shots/<shots argument>/`), for the side-by-side check against Figma; run it in light, dark and at 200 % text (`-Pandroid.testInstrumentationRunnerArguments.shots=dark`, and keep the pictures with `-Pandroid.injected.androidTest.leaveApksInstalledAfterRun=true`) |
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
