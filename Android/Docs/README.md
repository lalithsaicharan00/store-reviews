# Android — Start Here

Written by Claude (Claude Code), 11 October 2026, at the user's request: "document everything that we have discussed …
regarding the Android and the decision on working on Google Drive." Everything about the Android app is in this
folder: the decisions (with the user's words and dates), the research, the sync design, and what comes next. Status
lives in the [Current Work Checklist](<../../iOS/Docs/Checklists/Current Work Checklist.md>) items **89** (Android),
**90** (refunds), **91** (the sync line on Today) and **77** (Google Drive on Apple devices).

**The principle (the user, 11 Oct 2026):** "the same thing what we have for iPhone should also work for Android, or
whatever we are designing for Android should work for iPhone as well, the same way." One shared core, the same Plus,
the same words; differences only where a platform forces them.

**Building the app (Current Work 107):** the task is the [build prompt](<Build Prompt — Android App (Delete When Done).md>);
the work so far is on `claude/android-app`, handed over 13 Oct 2026: start at [Android App — Handoff for the Next Agent](<Android App — Handoff for the Next Agent.md>).

## Read in this order

1. [Android Plus — What Android People Pay For, and Keeping Both Apps the Same](<Research/Android Plus — What Android People Pay For, and Keeping Both Apps the Same.md>):
   1,500 reviews read by hand on both stores; Plus is the same on both, minus the Watch.
2. [How Sync Works — iCloud and Google Drive, One Core](<How Sync Works — iCloud and Google Drive, One Core.md>):
   the shared merge rules, a sync round on each carrier, and how it avoids what breaks other apps.
3. [Google Drive Sync — Download, Merge, Upload, and the Version Chain](<Research/Google Drive Sync — Download, Merge, Upload, and the Version Chain.md>):
   the user's "download first, then upload" idea, made safe; what Google Drive can and can't guarantee.
4. [Sync Status Across Devices — When It Shows, Where, and the Complaints Behind It](<Research/Sync Status Across Devices — When It Shows, Where, and the Complaints Behind It.md>):
   how a device knows another went quiet, the line on Today, the Watch, the 197 sync complaints and what can't be solved.
5. [Google Drive Sync — Prototype Results](<Research/Google Drive Sync — Prototype Results.md>): what was built, the
   real-Drive proof, the numbers, and what stages 3 and 4 must still check.
6. [The Android App — What Android People Want, What Android Expects, and What Carries Over](<Research/The Android App — What Android People Want, What Android Expects, and What Carries Over.md>): what Android people want beyond Plus (reminders that arrive above all), what
   Android requires in 2026, what carries over from the iPhone, and **twelve decisions for the user** (§11).
7. [Android Plus Evidence](<Research/Android Plus Evidence/>) and [Android App Evidence](<Research/Android App Evidence/>):
   every script, sample, hand coding, tally and web source.

Earlier work this builds on: [Plus, Price and the Server — How We Decided](<../../Research/Research Reports/Business Model and Monetization/Plus, Price and the Server — How We Decided/README.md>)
(no server for habits; the first Android and Google Drive reports), [Architecture 11](<../../Architecture/11. iCloud Sync with CloudKit.md>)
(iCloud sync as built), Rulebook D16.

## Decisions (11 October 2026)

| # | Decision | The user's words |
|---|---|---|
| A1 | **Order of platforms:** the Watch and iPad are in progress; Android next; the Mac last, designed from the iPad (only the Mac's own parts: menu-bar item, shortcuts, menus, windows) | "the only thing that is left is creating an app for mac"; then "let's go to the Android" |
| A2 | **The Mac includes the Google Drive option** | "in the Mac also we need to include the Google Drive option … we do need to include it" |
| A3 | **Android Plus = iPhone Plus, at the same price, ~~minus the Watch~~ (A14: Wear OS too)**; one shared design for both platforms | "the same thing what we have for iPhone should also work for Android" |
| A4 | **Android sync through the person's Google Drive by download → merge → upload** (never replace), with the shared merge rules, one file per year, and the version chain so no device can overwrite another; proven by a two-device prototype first | The user's idea: "it downloads the backup, then it changes and then it uploads it back"; "what if we build that protection ourselves?" |
| A5 | **No relay server** for faster Android-to-Android sync: sync on open, about once a minute while the app is on screen, and in the background | "let's not use relay server. It's not necessary cost and unnecessary relay" |
| A6 | **Offline is said, not hidden:** the app works offline and says so; nobody expects sync without internet | "without internet the app will work but we clearly display that there is no internet and changes might not sync" |
| A7 | **A quiet sync line at the end of Today's list, only when there's something to say** (changes waiting, another device gone quiet, just caught up), on iPhone, iPad, the Watch's list and Android; never blaming the person (Current Work 91; Design Rules' iCloud page updated) | "we are not blaming the user but we are just telling them the information … show when it is necessary"; "I'll vote for iPhone also … Android, you need to do it" |
| A8 | **When iCloud or Google Drive can't be used after someone bought Plus: offer a refund** (and another account if they have one) instead of checking before purchase (Current Work 90) | "if it is not working, then we will just refund it … if you have any other iCloud, connect to it; same thing for Google Drive" |
| A10 | **Google Drive sync is offered on iPhone, iPad and Mac too**, as an alternative to iCloud, with the same code as Android; iCloud stays the default; one sync place at a time; built after the prototype passes (stage 4; a new iOS client is needed: the old one was deleted, Current Work 84) | "we are obviously including it for iOS" |
| A9 | **Work starts with Google Drive sync in the shared core** (the biggest unknown; it decides Android Plus; built and mostly tested on GitHub's Linux machines with a stand-in Drive), alongside the Android research report | "the decision on working on Google Drive" |
| A11 | **The Android app report's twelve questions, decided 12 Oct 2026** ([report §11](<Research/The Android App — What Android People Want, What Android Expects, and What Carries Over.md>)): **as recommended** for D1 (exact reminder times asked for when the first reminder is turned on; otherwise up to 10 minutes late, said on the Reminders page), D2 (the reminder check, and one plain line after a reminder that didn't arrive), D3 (Alarm style rings, no full screen), D4 (a running timer as Android 16's Live Update), D7 (back one step, never loses typing), D8 (long-press shortcuts, no badge), D9 (tablets and foldables at launch, the iPad's layout), D10 (the same free plan, no ads), D12 (a Pixel, a Samsung and a Xiaomi); **D5: no wallpaper colours**; **D6: nothing for the themed icon for now** (the phone tints it for people who chose that look; draw our own only if it looks bad on a real phone) | "reminders problem. Okay. Alarm style. Okay. Running the timer outside … will also work"; "wallpaper colors … it's just a nonsense"; "remaining everything else … we don't need to think about them much" |
| A12 | **Moving to another phone (D11): a transfer through a small server on Cloudflare's free plan, built last**, once everything else is done. It changes D15 (Export and Import only) when it's built; to keep D16's promise (we never see anyone's habits), the phone encrypts the transfer before it leaves and the server deletes it once picked up or after a short time | "we can keep this … server based because this can be covered under cloudflare free plan … we will do this at last" |
| A13 | **Which widgets are free, the same as on iPhone and iPad** (12 Oct 2026): free are the small one-habit widgets, the Tasks widgets (Medium, Large) and the Lock Screen-style glance widgets; Plus are the Today list widget (Medium, Large) and This week ([Architecture 02 §3.1](<../../Architecture/02. Billing and Entitlements.md>), Current Work 93) | "the small widgets variants that we have, it will be free for habits … the today medium widget, today large, as well as the weekly widget … these three variants will be paid" |
| A14 | **Android Plus adds a Wear OS watch and a Windows app** (12 Oct 2026; replaces A3's "minus the Watch" and the Plus report's §6 advice to leave Wear OS out). Plus unlocks: unlimited habits, more widgets (A13), a tablet, a Wear OS watch and a Windows app, all synced through Google Drive. Both apps are still to be researched and built; the Plus screen names them (Figma "Settings: Plus") | "plus will unlock … unlimited habits, you can use it on desktop, Windows app, clearly mentioned there … and Wear OS support, watch, and more widgets"; "syncing through Google Drive, that's it" |

**Recorded corrections** (so no agent repeats them): an early summary said Android people don't pay for sync; measured
side by side they do, at least as much as on the iPhone (report §3–4). Day details was first proposed for the "last
synced" note; the user doubted it and it moved to the end of Today's list, the native place (Mail, Photos).

## Results: Google Drive sync, stages 1–2 (11 October 2026)

**Verdict: Go with changes** ([Prototype Results](<Research/Google Drive Sync — Prototype Results.md>)). Built in the
shared core (`Core/`: `DriveSync`, `DriveStore`, `GoogleDrive`), tested against a stand-in Drive on every push
(2,000 seeded runs of 2–4 devices converge), then on the real Google Drive with the test account:

- **A4, the version chain, holds on the real Drive:** separate processes saving under the same reserved ID at the same
  moment, IDs reserved by either: exactly one save succeeded and every other was refused with 409, **420 of 420**
  (two and six devices). A half-written upload never blocks the chain or overwrites it.
- Full rounds with three to six devices on the real Drive ended identical every time (offline, simultaneous saves,
  cut-off uploads, a reinstall, the brake). An idle round is one call (~0.25 s).
- Found and fixed: Drive refuses a deleted file's ID with 400, not 409 (now "taken"); the never-shrink guard fired
  against a damaged version a device couldn't read.
- **A9:** done. Stage 3 (two Android devices) and stage 4 (iPhone, iPad, Mac) have their lists in the report (§6–7).

## Still open

- **One purchase working on both stores from Android's launch** (the entitlement record, D16).
- **Plus Family on Android:** Google Play can't share an in-app purchase with a family. **The user, 12 Oct: Android has
  Plus Family too** ("we have family plans as well in the Android"); how Play delivers it is the open build question.
- **Designs still to make:** the same field edited on two offline devices ("Use This Instead"), a delete arriving from
  another device ("Archived on Pixel 8"), the same thing logged on two devices ("Keep Both / Remove One"), two devices
  that each created the same habit (combine), widgets refreshed the moment synced changes arrive.
- **The twelve decisions in the Android app report** (§11, D1–D12: exact-time reminders, the reminder check, the
  Alarm style, the timer outside the app, wallpaper colours, the themed icon, back, launcher extras, tablets and
  foldables, the free plan, moving from an iPhone, test phones); then Figma designs, small screens first.
- **Moving the day, schedule, streak and progress rules into the shared core** (they're in the iPhone's Swift today), so
  Android shows the same numbers; with speed runs on the iPhone, after the iPad and Watch branches merge.

## What comes next

1. ~~**Google Drive sync in the shared core**~~ done, 11 Oct 2026: [Prototype Results](<Research/Google Drive Sync — Prototype Results.md>)
   (Go with changes). Next for it: stage 3 on two Android devices, after the Android designs.
2. ~~The Android research report~~ done, 12 Oct 2026 ([The Android App — What Android People Want, What Android Expects, and What Carries Over](<Research/The Android App — What Android People Want, What Android Expects, and What Carries Over.md>)): the user decides §11; and
   Current Work 91 on the iPhone.
3. **The Android designs, in Figma** (started 12 Oct 2026: Today, Day details and the log screens): continue from
   [Android Designs — Handoff](<Android Designs — Handoff.md>), using the built iPhone app as the reference.
4. ~~The shared rules into the core~~ checkpoint 1 done, 12 Oct 2026 (Current Work 92): which day a log belongs to,
   schedules, goals, streaks, quit runs, a day across habits and where habits show on Today are in `Core/rules`
   (`app.habits.rules`), written down in [`Core/spec/`](<../../Core/spec/README.md>) and proven against the iPhone's own
   answers (2,063 golden cases, 8.3 million answers, `Core/fixtures/`). **Android is unblocked:** build the app on
   `HabitRules` (from `Rows.load`, or `RulesInput` / `LiveRules` over the database's records). The iPhone's words and
   screens built on these rules (Progress, the habit page, widgets) stay Swift; Android writes its own.
   Then the Android designs, and the Android app with Drive sync plugged in.
5. ~~**The Android designs**~~ done, 12–13 Oct 2026: every screen as an image in
   [Android Designs — Every Screen](<Designs/README.md>) (162 frames, onboarding to widgets), the reasons in the
   [handoff](<Android Designs — Handoff.md>).
6. **Build the Android app** (Current Work 107): a cloud session with
   [Build Prompt — Android App (Delete When Done)](<Build Prompt — Android App (Delete When Done).md>), on
   `claude/android-app`.

**Done by the user, 11 Oct 2026:** a Web OAuth client "Drive sync tests" (`drive.appdata`; redirect
`https://developers.google.com/oauthplayground`), a test Google account added as a test user, and three GitHub
secrets: `GDRIVE_TEST_CLIENT_ID`, `GDRIVE_TEST_CLIENT_SECRET`, `GDRIVE_TEST_REFRESH_TOKEN` (the token can expire after
about 7 days in Testing mode; renew it in the OAuth Playground). **Still needed later:** an Android OAuth client and
two Android devices or emulators (stage 3); a new iOS client (stage 4).
