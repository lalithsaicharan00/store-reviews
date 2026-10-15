# Build Prompt — The Android App (Delete When Done)

Written by Claude (Claude Code), 13 October 2026, for a cloud session, at the user's request: "create the app … take
care of the UI, wiring, everything, all of that, widgets, start to end." Current Work item **107**. Delete this file in
the final merge, as the earlier build prompts were.

---

You are building **Often Enough for Android**: the whole app, from the first launch to the widgets, native Material 3
Expressive in Jetpack Compose, on the shared Kotlin core. The iPhone app is built and is the reference for every rule,
word and behaviour; the Android designs are finished and exported as images. Do the whole job on one branch, in the
checkpoints below, and report at each.

## 0. Branch, commits, CI, and the other agent

- **Branch:** `claude/android-app`, from the latest `main`. Extra branches for test batches side by side (T1, T10):
  `claude/android-app-ci2`, `-ci3` …, `-perf`, `-perf2` …, `-main-check`. List every one in
  `iOS/Docs/Checklists/Merging the Branches.md` and mark it safe to delete when done (W3; you can't delete branches).
- Commit and push as you go (this task says to, W4), untagged (T10). `main` moves only to commits whose tests passed,
  and **only with the user's go-ahead**: when the work is done, report and let the user decide the merge.
- **Another agent is working on the shared rules right now. Don't disturb it.**
  - `claude/shared-habit-rules` is **fully in `main`**: `Core/rules` (`app.habits.rules`: which day a log belongs to,
    schedules, goals, streaks, quit runs, a day across habits, where habits show on Today), `Core/spec/`,
    `Core/fixtures/` (2,063 golden cases proven against the iPhone). **Build on it.**
  - `claude/shared-habit-rules-switch` (checkpoint 2: the iPhone, iPad and Apple Watch on the shared rules) **is in
    `main` too** (13 Oct 2026). `RulesInput` and `Rows` didn't change; `LiveRules` gained calls the apps use for speed:
    `days` (a strip of days in one call), `row` (a Today row's numbers in one call) and `dayScores` (Rulebook S20).
    Its `-ci*`, `-perf*`, `-wperf*`, `-bench*`, `-fixtures*` branches are old test runs, safe to delete.
  - So **every call into the rules goes through one Android-side adapter** (for example `RulesGateway` in
    `Android/app/.../data/`): screens and view models never import `app.habits.rules` directly. When the switch branch
    merges, you (or the next agent) rebase `claude/android-app` on `main` and change only the adapter. Check
    `git log origin/main` for the merge before each checkpoint; when it lands, rebase and adapt then.
  - Where a rule Android needs isn't in `Core/rules` yet (check `Core/spec/README.md` and `Core/spec/differences.md`;
    the iPhone's words, Progress, the habit page and widget snapshots stay Swift for now), write it **in the adapter
    layer, ported from the Swift, with a test and a `// MOVE TO CORE` note**, never as a second permanent copy
    ([Shared Core Decision](<../../Architecture/Shared Core Decision.md>)). List each one in your results file.
  - **Changes to `Core/`:** only what Android needs to build: add the Android target (`androidTarget()`, Room 3's Android
    artifacts) to `Core/build.gradle.kts` and `Core/rules/build.gradle.kts`, in **one small, additive commit**. Don't
    edit `Core/rules/src`, `Core/spec`, `Core/fixtures` or `Core/schemas` (the other agent owns them right now; propose
    changes in your results file instead). `core-tests.yml` must stay green.
- **CI:** add `.github/workflows/android.yml` on `ubuntu-latest` (minutes are free; the repository is public): build,
  lint, unit tests on every push that changes `Android/**` or Core's build files; instrumented Compose UI tests,
  widget tests and benchmarks on an emulator (`reactivecircus/android-emulator-runner`, KVM enabled) on
  `workflow_dispatch` and on commits tagged `[android-ci]` / `[android-perf]` (tags only when deliberately starting
  them, T10). A dispatched workflow must exist on `main` before it can run on a branch (T19): put the workflow file
  alone on `main` first, with the user's go-ahead, or run the tagged-push path. Keep a run under 60 minutes (T1).
  **Watch every run you start with a background watcher** until it completes, read every failure before changing
  anything, rerun once only to confirm, never loosen or skip a test (T1, T2).
- If this environment can't reach `dl.google.com` or `maven.google.com` (Gradle needs them), build on GitHub
  instead, and tell the user once that they can allow those hosts in the environment's network settings.
- **No iPhone code changes** in this work. **No secrets in the repository or chat** (D11): the Google OAuth client,
  signing keys and Play Billing keys come from the user; use placeholders and `local.properties`/GitHub secrets.

## 1. Read first (in this order)

1. `RULEBOOK.md` in full and `CLAUDE.md`. Every rule applies on Android in spirit: **S** (speed), **D** (data safety),
   **U** (behaviour and words), **T** (testing), **W** (how we work). Above all: S2, S3, S5–S8, S16–S18; D1, D2, D4–D8,
   D10, D12, D13, D16, D17; U2–U4, U6, U10, U11, U13–U19, U22, U25–U28; T1, T2, T7, T10–T12, T14, T19.
2. **`Android/Docs/README.md`** (decisions A1–A14 with the user's words; what's still open).
3. **`Android/Docs/Designs/README.md`: every Android screen as an image** (162 frames, 25 sections, onboarding to
   widgets, in the order a person meets them) and the design language. **There is no Figma in the cloud: this page is
   the design.** Then **`Android/Docs/Android Designs — Handoff.md`**: the reason behind every screen (decisions made
   while designing, the user's words). If an image and the handoff disagree, the handoff's text wins; ask the user if
   it matters.
4. `Android/Docs/Research/The Android App — What Android People Want, What Android Expects, and What Carries Over.md`
   (§11: decisions D1–D12, decided in A11: exact reminder times, the reminder check, Alarm style, the running timer as
   Android 16's Live Update, back never loses typing, long-press shortcuts, tablets and foldables at launch, the same
   free plan with no ads, Pixel + Samsung + Xiaomi as test phones; no wallpaper colours, no themed icon for now).
5. Sync and backup: `Android/Docs/How Sync Works — iCloud and Google Drive, One Core.md`,
   `Android/Docs/Research/Google Drive Sync — Download, Merge, Upload, and the Version Chain.md`,
   `Android/Docs/Research/Google Drive Sync — Prototype Results.md` (stage 3, two Android devices, is yours),
   `Android/Docs/Research/Sync Status Across Devices — When It Shows, Where, and the Complaints Behind It.md` (A7),
   `Core/Backup File Format.md`, `Core/README.md`, `Core/spec/`.
6. `Android/Docs/Research/Android Plus — What Android People Pay For, and Keeping Both Apps the Same.md`, A13–A14 and
   `Architecture/02. Billing and Entitlements.md` (free: 5 habits, the small one-habit widgets and the Tasks widgets;
   Plus: unlimited habits, Today and This week widgets, more devices; Plus $24.99, Plus Family $59.99, one-time).
7. Widgets: **`iOS/Docs/Widgets — Taps and Updates (Locked).md`** (W1–W17: the user's measured, approved behaviour;
   on Android keep every principle: the whole card changes at once on a tap, every tap is written before anything
   else and saved in order, idempotently, then synced; never a tap kept only until the app opens), the widget lessons
   in `iOS/PERFORMANCE-LESSONS.md` (L23–L26), U25–U28, and Current Work items 64–66 and 93.
8. The iPhone app as the reference for logic and words (`iOS/Habits/`): `Model/HabitStore*.swift` (Today, logging,
   undo, progress, widgets' snapshot), `Model/HabitCopy.swift` and `Words.swift` (every sentence), `Today/`,
   `AddHabit/`, `Onboarding/`, `Backup/`, `Plus/`, `Menu/`, `Settings/`, `Help/`; and
   `iOS/Design Rules — Don't Regress.md` for every screen's decided behaviour. **When in doubt about any logic, read
   the iPhone's code and do what it does**; when Android must differ, the designs and the handoff say so.
9. `Brand/Logo Guide.md` and `Brand/Assets/` (the Android adaptive icon's light and dark foreground and background,
   1536 px, already exported; the light tonal mark for About and Plus).

## 2. What to build: everything, start to end

The scope is every section of `Android/Docs/Designs/README.md`, wired to real data:

1. **The app shell:** `Android/` as a Gradle project (`com.oftenenough.app`, U8), Kotlin, Jetpack Compose with Material 3
   (Expressive components where the designs use them), minimum SDK chosen from the research (state it), target the
   latest SDK; single activity, Navigation Compose, edge to edge, predictive back (back never loses typing, D7 in the
   report). Material Symbols Rounded icons. Roboto.
2. **Data:** `Core`'s `HabitRepository` on Room 3 (the only way to read and write), its migrations (D2: tested from every
   past schema, a copy kept first, never reset on error), all database work on the background dispatcher (S16), a
   tap shows at once and the write follows (S7). Test launches use their own in-memory database and never touch the
   person's (D8).
3. **Onboarding** (sections 01–02) and the **empty Today** states (section 03).
4. **Today** (section 03), **Day details** (04), **logs, slips and notes** (05–06), **New and the habit form with all its
   pages**, including the contextual "Add a 6th habit" (07–08), the **drawer** (09), the **routine player and timer**
   (10; the running timer as Android 16's **Live Update** notification, A11 D4), **Habit details** (11), **Progress**
   (12), every **settings** page (13–22): Times of Day, Day and Week, **Reminders** (exact alarms when the first
   reminder is turned on, the reminder check, Alarm style; A11 D1–D3), Appearance, **Google Drive & Backup** and the
   **restore flow** (17–18), **Privacy & Security and App lock** (BiometricPrompt or an app passcode, 19), **Plus**
   (20), Help & Feedback (21), About (22).
5. **Backup and sync** (D16, A4–A7): Android's own Auto Backup; a daily backup file in the person's Google Drive
   (`drive.appdata`), free, never replacing a copy that has habits with an empty or much smaller one (D4); restore
   with preview and a 30-day undo (D5); **Plus: sync between devices through Google Drive** with `Core`'s `DriveSync`
   (download → merge → upload, the version chain, no relay server; sync on open, about once a minute on screen, and in
   the background with WorkManager); the quiet sync line at the end of Today (A7); the mass-change brake (D17); offline
   said, not hidden (A6). Prove it on two emulators (stage 3 in the Prototype Results).
6. **Plus with Google Play Billing:** Plus and Plus Family as one-time purchases, Restore purchases on the buy screen
   only, the free limit of 5 habits, never holding data hostage (D10). How Play delivers Plus Family is an open
   question in the README: research it, propose, and ask the user before building anything irreversible. The
   cross-store entitlement record is later (D16): leave a clean seam for it.
7. **Widgets with Glance** (sections 23–25): One habit 2×2, Today 4×2 and 4×4 (the day or one section), This week 4×2,
   Tasks 4×2 and 4×4; **fixed sizes, no resizing in the first version**; interactive (✓, +1, ▶/⏸ and the page arrows
   act on the home screen without opening the app; the rest of a row opens Day details); the setup screen
   (configuration activity, `reconfigurable`, `configuration_optional`), every state in section 25, free versus Plus
   (A13; a Plus widget without Plus never blocks and never shows blank); **always up to date** (refresh after every
   change in the app, after sync, at the day's start, and from the widget's own taps). A widget only draws what the app
   worked out (U26).
8. **Notifications:** reminders with Done / +1 actions that save from the notification on a locked phone and never
   crash the app (D13), the Live Update timer.
9. **Dark mode** (the user, 13 Oct 2026): every screen in dark, from Material 3's dark roles with the same structure;
   the design document's old dark Today is colour inspiration only (a very old design).
10. **Tablets and foldables** (A11 D9): adaptive layouts from the iPad's (U35, `iOS/Docs/iPad/README.md`) after the
    phone is done; nothing on the phone changes for it.
11. **Not now:** the Wear OS and Windows apps (A14; the Plus screen already lists them), lock-screen widgets (paused),
    moving phones through a server (A12, built last).

## 3. Quality: what "done" means

- **Speed (S rules):** a year of history (and `Core`'s 15-year extreme account) must scroll Today, Progress and the
  habit page with no jank; no frame over 100 ms; opening a screen adds under 50 ms; a tap shows on the same frame.
  Only the smallest composable that shows a clock recomposes each second (S3); stable `LazyColumn` keys; no sorting,
  filtering or formatting in composition (S8); history worked out once and remembered (S5). Measure, never judge by
  eye (S2): Macrobenchmark (startup, Today scroll, open Day details, typing in a form) and `JankStats` in instrumented
  tests, each run alongside a control (a blank screen), on the emulator in CI; ship a Baseline Profile. The user checks
  on real phones at the end (T5).
- **Data safety:** migration tests from every schema; backup → restore round trips (every export can be imported);
  the shrink guard; a process killed mid-write loses nothing; widget and notification taps saved in order exactly once.
- **Sync:** the stand-in Drive tests in `Core` stay green; two-emulator end-to-end tests (offline edits on both,
  conflicts, deletes, a reinstall gets everything back, D14); the real-Drive check (`drive-real.yml`, by hand, the
  user's test account; "NOT CONNECTED" means ask the user to renew the token).
- **Widgets:** a tap's whole-card change is visible fast and the saved state matches the app; measure tap → visible
  on the emulator, and list what must be checked on a real Pixel and Samsung.
- **UI tests** for the main flows (onboarding both ways, add each habit kind, log and undo each kind, Day details,
  notes, settings, restore, Plus without buying, app lock), at a set clock for anything time-of-day (T11), one-line
  failure messages that say what was on screen (T14).
- **Words:** the iPhone's words (U11; "log", never "entry"; never "missed", "failed", "due", "Midnight" or
  "Automatic"; U3).
- **Bugs already found on the iPhone, so Android never has them** (Current Work): 94 (skipping a running timer's day
  leaves "Stop and save" on), 95 ("entries"), 97 (Edit time of day's wrong end time), 98 (a new time of day must not
  split another), 99 (12:00 AM and Sunday), 101 (no account promises), 102 (Help's words), 104 (‹ and ✕ together),
  106 (a day with nothing planned says so); and every widget lesson in the Locked page and L23–L26.

## 4. Checkpoints (report to the user at each, then continue)

1. **Skeleton:** the Gradle project, Core on Android, the adapter, the database, CI green; onboarding, Today (empty and
   with habits), the day bar, logging and undo for every kind.
2. **Every screen:** Day details, logs, notes, New and the form, the player and timer, Habit details, Progress, the
   drawer and every settings page, wired; dark mode.
3. **Data out of the phone:** backup, restore with undo, Google Drive sync (two emulators), Plus with Play Billing,
   App lock, reminders and notifications.
4. **Widgets:** every widget, state, setup and change, interactive and up to date.
5. **Proof:** the speed, data, sync and widget tests above, green on CI, with the numbers; tablets and foldables.

At each checkpoint: update **Current Work item 107** (tick what's built and tested, W1), write the numbers and what
you learned in **`Android/Docs/Android App — Build Results.md`** (a new file: what's built, what's ported temporarily
outside the core and why, what needs the user: the Android OAuth client with the debug and release SHA-1 for
`com.oftenenough.app`, a Play Console app for Billing, real-phone checks), and add any new rule to the Rulebook the
same day (W5). Write `Android/README.md`: how to build, test and run it.

## 5. When you need the user

**The user will provide the Google credentials later (13 Oct 2026: "I will provide it in the morning … ask it to wait
for them").** Don't stop for them, and don't invent or create any yourself:

- **Still to come from the user:** the **Android OAuth client** (package `com.oftenenough.app`, scope `drive.appdata`)
  and the **Play Console app** (payments profile, the products, license testers). Until they arrive, build everything
  else. Put Google sign-in and Drive behind interfaces with `Core`'s stand-in Drive for tests and debug builds, and
  Play Billing behind a `PlusStore`-style interface with a fake store, so every screen, flow and test works without
  them. Before checkpoint 3's real sign-in and real purchases, **ask the user for them and wait**: keep working on
  checkpoint 4 (widgets) and 5 (proof) meanwhile.
- **What you prepare for the user:** a stable **debug signing key** for CI (generate it, keep it only as a GitHub
  secret, never in the repository, D11) and **its SHA-1**, so they can register the OAuth client; a release build
  config that reads the upload key from secrets; and, when Billing is wired, a signed `.aab` with the Play Billing
  Library for them to upload to **Internal testing** (Play only lets them create products after such an upload).
- **Product IDs, the same as the iPhone's** (`iOS/Habits/Plus/PlusProduct.swift`): `com.oftenenough.app.plus`
  ($24.99), `com.oftenenough.app.plusfamily` ($59.99), and `com.oftenenough.app.plusfamily.upgrade` (Plus → Plus
  Family, the difference). Tell the user these exact IDs when you ask.

Otherwise ask only for what you can't decide from the documents: a product decision they don't make (how Play
delivers Plus Family), or anything irreversible. Keep going, and keep a list of questions in the results file for the
next checkpoint report.
