# Android App — Build Results

Written by Claude (Claude Code), 13 October 2026, building the Android app on `claude/android-app` (Current Work 107,
[the build prompt](<Build Prompt — Android App (Delete When Done).md>)). One section per checkpoint: what's built, what
was measured, what's ported outside the core for now, and what needs the user. How to build and run it:
[`Android/README.md`](<../README.md>).

**Handed over 13 October 2026:** the user stopped this session for another agent to continue. Where everything
stands, the parked work in `Android/WIP/` and what's next: [Android App — Handoff for the Next Agent](<Android App — Handoff for the Next Agent.md>).

## Checkpoint 1 — Skeleton (13 October 2026)

### Built

- **The Gradle project** (`Android/`): AGP 9.4.1, Gradle 9.8.1, Kotlin 2.4.20, Compose BOM 2026.09.00 (Material 3
  1.4), Room 3.0.3, compileSdk/targetSdk 37, minSdk 26. Versions were read from Google's Maven by a probe run on
  GitHub (Google's Maven isn't reachable from the cloud session).
- **The core on Android:** one additive commit to `Core/` (`a508f0a`): the Android target and Room 3's Android
  compiler, switched on only when Android builds the core (`core.android=true`); `Core`'s own CI stayed green. No
  change to `Core/rules/src`, `Core/spec`, `Core/fixtures` or `Core/schemas`.
- **The adapter** (`data/RulesGateway.kt`): the only file that imports `app.habits.rules`. It turns the app's habits
  and the iPhone's settings rows into `RulesInput`, keeps `LiveRules` current as logs change, and answers every rule
  the screens need (the day a log belongs to, due days, goals, progress, streaks, quit runs, where habits show on
  Today, the day bar's count). `claude/shared-habit-rules-switch` was never checked out, merged or touched; when it
  lands, only this file should change.
- **The database:** the core's `HabitRepository` (Room 3, bundled SQLite) in the app's files, opened once per process;
  a test launch gets an in-memory one (D8). Habits, logs and settings are stored exactly as the iPhone stores them
  (the same settings keys and Swift JSON: `SwiftJson.kt`, tested), so a backup moves between the two.
- **The store** (`data/HabitStore.kt`): a tap changes the screen at once and the write follows, in order (S7); history
  is worked out once and remembered (S5); each habit has its own revision, so a log redraws only its row (S6).
- **Screens:** the welcome both ways (new: three pages, Your days and weeks, Your first habit; coming back: Welcome
  back), Today (sections, every kind of row, Quit or cut down, paused habits, the empty states), the day bar (‹ day ›
  with its ring and count, Go to a day, Back to today), logging and undo for every kind (✓, +N, a week count, ▶/⏸,
  checklist steps, a slip, a task), the long-press menu, light and dark themes, the launcher icon (Brand's tonal mark).
- **CI** (`.github/workflows/android.yml`): every push that changes `Android/**` builds, runs the unit tests and lint;
  `[android-ci]` or a manual run adds the emulator's UI tests (Pixel 6, API 35).

### Tested

- Unit tests (JVM): the iPhone's words case for case (`WordsTest`), the stored formats (`SwiftJsonTest`), the form's
  rules (`FormRulesTest`). Green: run 38319381690 (build, unit tests, lint).
- UI tests on the emulator (`TodayTest`): the welcome both ways, an idea opening the form, logging and undo for a
  check, an amount, a week count, a checklist step, a timer, a quit habit and a task, and the day bar.
  Run 38342494305: 9 of 11 (the tests assumed habits the demo already shows done; fixed). Run 38343622250 (`451d8b1`):
  10 of 11; `aChecklistTicksAStep` tapped a step row composed past the list's edge. `be1b22e` scrolls to it first;
  its run (38369953627) was cancelled by the handoff push before the emulator ran. **Final result (13 Oct, `c7e281a`):
  11 of 11**, on the user's PC (Pixel 10 emulator, Android 16 / API 36, 31.8 s) and on CI's emulator (API 35, run
  38373182612). Two fixes were needed first, both in the tests:
  - **Android 16:** every test failed before its first tap (`NoSuchMethodException: InputManager.getInstance`): Compose's
    test rule brought an older Espresso that calls a method API 36 removed. `espresso-core:3.7.0` is now pinned for the
    instrumented tests. CI's API 35 emulator never showed it.
  - **The checklist test** (`aChecklistTicksAStep`): the tap worked (Skincare read "2/4 steps" with "Undo Last Step"),
    but the after-log line that appears under the row pushed Serum's step past the list's edge, so the check found no
    "Undo Serum". `be1b22e`'s scroll before the tap wasn't enough; a test's wait now scrolls the list to what it waits
    for.

### Found and fixed on the way

- A habit in two parts of the day (Morning and Evening) must tick each part on its own: the adapter dropped each
  placement's slot. Fixed before it shipped anywhere.
- The welcome navigated to its next page before the app's navigation existed (it would have thrown). The page now
  opens once it does.
- My first test of the sentence copied the iPhone's doc comment ("Coffee: at most 3 coffees a day"); the iPhone's code
  leaves out a name that only repeats the unit ("At most 3 coffees a day"). The Android code already matched the
  code; the test was corrected to the code, with the named case added.

## Checkpoint 2 — Every screen (in progress, 13 October 2026)

- **Habit details, Progress, the routine player and the timer** (parked in `Android/WIP/`): compiled as written; their
  word tests pass (`PlayerWordsTest` 6, `ProgressWordsTest` 7); routed (`habit/{id}`, ≡ › Progress, `routine/…`,
  `timer/{id}`). Each page that opens Day details holds its own sheet, so going back to it returns to the open sheet.
  Checked on the Pixel 10 emulator with the demo: History, Progress tab, Progress Week, the player on Morning.
- **Help & Feedback** (search at the top, Contact us, Show the welcome again, every topic opened in place) and
  **About** (the tonal mark, version, the name, privacy, acknowledgements, Open source licences). Help's answers are the
  iPhone's, rewritten to name Android's own controls and to say "log" (Current Work 102); two iPhone topics are left
  out because Android has no such option (Progress's View Options: Full Day, Show Streaks).
- **Pause** (one habit or several; the iPhone's PauseSheet as a page, its words tested), **the Habits and Tasks lists**
  (tap for the page; a long press chooses several for Pause, Archive or Delete, which asks first and offers Archive:
  never on a swipe, U14), **New straight to a task** from ≡ › Tasks' +.
- **Reminders** (design §15): the reminder check (notifications, exact times, battery, each with its fix), a reminder
  that didn't arrive (the reminder code now keeps the alarm it planned and notes one that fired over 10 minutes late or
  never; the reason names the phone's maker), habits with and without reminders.
- **Privacy & Security and App lock** (design §19): `MainActivity` is a `FragmentActivity` for Android's prompt; the
  phone's lock or a six-digit app passcode (a salted PBKDF2 hash only); wrong codes wait as on the iPhone (1, 5, 15
  minutes, then an hour, after 5 in a row); Forgot app passcode? through the phone's lock, or a 24-hour reset when the
  phone has none; Lock again; locking the phone locks the app. While locked the app is hidden from TalkBack and from
  the recents screenshot, and names are hidden outside the app. App lock, the reminder alarm's state and test launches'
  files are left out of Android's backup (`res/xml`), so after moving phones App lock is off and the habits are there.
- **Plus** (design §20): buy (the free habits line, the two plans, what Plus adds, Get Plus and Restore purchases
  pinned) and Plus is yours (the family upgrade for the difference), behind `PlusStore`: `FakePlusStore` in debug
  builds and tests, `NoPlusStore` in a release build until Play Billing is connected (checkpoint 3).
- **Today's Filter and groups**: all habits or one group (each with how many it shows on the day open), New group, Edit
  groups, hide completed habits and tasks; the group form (name, colour, its habits, Pause these habits, Delete group).
- **Arrange your day**: every habit in each time of day; drag the handle (TalkBack: Move up, Move down); each card's ⋮
  renames, retimes, sorts or deletes a time of day and moves Anytime and Quit or cut down.
- **Dark mode:** every screen toured on the Pixel 10 emulator with the system in dark (Material 3's dark roles). All
  readable; nothing missing.
- **Tests:** unit tests 48, all green (new: `PauseWordsTest`, `ReminderWordsTest`, `AppLockTest`, `ArrangeTest`);
  `ScreensTest` (10: Habit details and its tabs, Progress, a routine, Pause, archiving from Habits, a group filtering
  Today, Arrange's Move up, Help's search, Plus with the stand-in store, App lock with a passcode) 10 of 10 on the Pixel
  10 emulator (API 36, 47 s) and with `TodayTest` on CI's emulator (API 35, run 38381027895, `85b8cb5`); lint green.

### Found and fixed on the way (checkpoint 2)

- **Back with the menu open left the app.** Back now closes the drawer first.
- **A drag in Arrange your day did nothing:** the drag's end handler kept the drop position from the composition it was
  made in (always −1). It's now worked out from the live drag when the finger lifts.
- **UI Automator couldn't see a sheet's controls:** a bottom sheet is its own window, so the root's
  `testTagsAsResourceId` doesn't reach it; Day details and Filter set it too (Macrobenchmark needs this).
- **Messages from pages other than Today never showed** (their snackbar host was Today's): every other page now shows
  them at the bottom.

### Decisions to confirm with the user

- **Share usage** shows "Not available yet" like crash diagnostics, not the design's switch: the Android app sends
  nothing, so a switch would promise something that doesn't exist.
- **The Habits list** has no drag to reorder (Arrange your day does that) and no swipe actions (U14).

## Ported outside the core for now (`// MOVE TO CORE`)

Each is ported from the Swift with tests, and should move into `Core` when the shared rules grow to cover it:

| File | From the iPhone | What |
|---|---|---|
| `data/Words.kt` | `HabitCopy.swift`, `Words.swift`, `Format` | Numbers, amounts, minutes, how often in words, the habit's sentence, day names, clock times |
| `data/StoreWords.kt` | `HabitStore` words, `Entry` descriptions | Today's row lines, Day details' status, "Undo +1 glass", where a log came from |
| `data/HowOften.kt` | `HowOften.swift`, `HabitDefaults` | The form's How often choices, what each saves, the step + adds when the person doesn't say |
| `data/FormWords.kt` | `Outcome.swift` | The form's live sentences under Time of Day and Reminders |
| `data/SectionPlan.kt` | `SectionPlan.swift` | Adding or editing a time of day: each ends where the next begins, overlaps split |

## What needs the user

- **Google sign-in (Drive):** an **Android OAuth client** for package `com.oftenenough.app`, scope `drive.appdata`,
  with the debug and release SHA-1. Until it arrives, sign-in and Drive run on the core's stand-in Drive.
- **A stable debug key for CI** (D11: never in the repository or a chat). A cloud session can't create GitHub secrets,
  so on your computer, once:
  ```sh
  keytool -genkeypair -v -keystore oftenenough-debug.keystore -alias oftenenough-debug -keyalg RSA -keysize 2048 -validity 10000 -dname "CN=Often Enough Debug"
  base64 -i oftenenough-debug.keystore | gh secret set ANDROID_DEBUG_KEYSTORE_BASE64 -R lalithsaicharan00/store-reviews
  gh secret set ANDROID_DEBUG_KEYSTORE_PASSWORD -R lalithsaicharan00/store-reviews
  ```
  The next Android run prints its SHA-1 ("Debug key fingerprint"), for the OAuth client.
- **The Play Console app** for Play Billing: the products `com.oftenenough.app.plus` ($24.99),
  `com.oftenenough.app.plusfamily` ($59.99) and `com.oftenenough.app.plusfamily.upgrade` (the difference), and
  license testers. Until then Plus runs on a fake store.
- **Real phones** (Pixel, Samsung, Xiaomi; U9, T5): noted separately at the end.

## Questions for the next report

- How Plus Family should reach a family on Google Play (Play's Family Library only shares some purchases): to decide
  before anything irreversible in the Play Console.
