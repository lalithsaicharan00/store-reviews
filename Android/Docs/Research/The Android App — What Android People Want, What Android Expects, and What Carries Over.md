# The Android App — What Android People Want, What Android Expects, and What Carries Over

Written by Claude (Claude Code), 12 October 2026, at the user's request: "go ahead with the Android research report."
It answers four questions: what Android people want from a habit app (beyond Plus, which the [Android Plus
report](<Android Plus — What Android People Pay For, and Keeping Both Apps the Same.md>) settled); what Android itself
expects of an app in 2026; what carries over from the iPhone app and what has to change; and what the user needs to
decide before the Android designs start. Evidence: [Android App Evidence](<Android App Evidence/>).

## 1. The answer in short

- **Android people want what iPhone people want,** with one big exception. Sync, widgets, dark mode, no ads, free
  basics, simplicity: the same themes, at about the same rates once Play's shorter reviews are allowed for (§3).
- **The exception is reminders that don't arrive.** It's the one theme far more common on Play: 5.9 times as often per
  review (15 times per word), and 9.5 times as often in 1–2★ reviews. Of 40 read by hand, 36 were real reminder
  failures: they never came (22), stopped after days or an update (7), came only when the app was opened (4), or came
  silently (4); some had already granted every permission or switched off battery saving (§4). On Android, **a
  reminder that arrives is a feature people notice**, and the app has to be built and tested for it.
- **Widgets matter as much as on the iPhone, and break in the same ways:** stale, taps that do nothing, gone after a
  restart (§5). The locked widget principles (U28) carry over unchanged; Android makes the tap simpler (the action
  runs in the app's own process).
- **What Android's best-rated habit apps are praised for** is simplicity (28 of 72 five-star reviews, all six apps),
  motivation, free basics, statistics and flexible schedules; and on HabitNow, a one-time price instead of a
  subscription (7 of 12) (§8). That's our design already.
- **Android sets rules our first release must meet:** target API 36 (Play, from 31 Aug 2026), so edge-to-edge,
  predictive back and full-window layouts on tablets are compulsory; notifications are off until the person allows
  them; exact-time reminders need a permission the person grants in Settings; full-screen alarms are only for alarm
  and calling apps (§9).
- **Twelve decisions for the user** (§11): the biggest are how reminders ask for exact timing (D1), how the app shows a
  reminder problem (D2), the "Alarm" style on Android (D3), wallpaper colours versus our monochrome chrome (D5),
  the themed icon (D6), and whether tablets and foldables come at launch (D9).

## 2. How this was done

| Step | What | Size |
|---|---|---|
| Theme scan | 31 themes, the same patterns on both stores, English only (Play's `language` field; App Store text with common English words), per 10,000 reviews, split 1–2★ / 4–5★ | Play 336,635 reviews; App Store 196,488 |
| Hand-read | 8 themes, 40 Play reviews each (40+ characters, seed 20261012), coded one by one | 320 reviews |
| Praise | 5★ English reviews (120+ characters, 2023 or later) of the six habit trackers with the most English Play reviews: Loop (P3), HabitNow (P2), Habit Tracker (P24), Habit Diary (P10), Goal & Habit Tracker Calendar (P65), 21 Days Challenge (P125); 12 each | 72 reviews |
| Platform | Google's own developer pages, read 12 Oct 2026; two press reports and one community site, labelled | [web notes](<Android App Evidence/web_notes.md>) |

**Read the numbers with these in mind.**

- **Play reviews are much shorter:** 94 characters on average against the App Store's 244 (medians 48 and 172). A
  theme mentioned at the same rate per word shows up about 2.6 times less per review on Play. So a Play ÷ App ratio
  near 0.4 means "as common"; near 1.0 means "about 2.6 times as common".
- The scan counts words, not causes. Hand-reading shows how much is on topic: from 40 of 40 (widgets wanted,
  free/no ads) down to 15 of 40 (battery: the pattern's "doze" also matched "dozen", 25 off-topic).
- The "habit" corpus on Play includes to-do and routine apps (To Do List P126, Tasks P84, Fabulous P12, Me+ P4);
  they're kept because people use them for the same jobs, but the praise sample uses only habit trackers.
- Play's language tag is sometimes wrong: one "English" review in the praise sample is Uzbek (P10#8686, coded GENERIC).
- Citations are `P<app>#<line>`: the 0-based line in that app's `Play Store Reviews/<N>. …/reviews.jsonl`.

## 3. The two stores side by side

Per 10,000 English reviews ([themes.md](<Android App Evidence/themes.md>)); "per word" multiplies the ratio by 2.6.

| Theme | Play | App Store | Play ÷ App | Per word | Reading |
|---|---|---|---|---|---|
| Reminders don't work | 31 | 5 | 5.9 | ~15× | **Android's own problem** (§4) |
| Back button / status bar / edge-to-edge | 3 | 2 | 1.6 | ~4× | Small but Android-shaped (§7) |
| Widget wanted | 38 | 33 | 1.2 | ~3× | More wanted on Android (§5) |
| Free / no ads / open source | 79 | 72 | 1.1 | ~3× | Praised more on Android (§8) |
| Widget broken | 23 | 26 | 0.9 | ~2.3× | Same failures (§5) |
| Sync across devices | 106 | 122 | 0.9 | ~2.3× | As wanted (the Plus report) |
| Dark mode / themes | 38 | 51 | 0.8 | ~2× | (§6) |
| Battery / background | 9 | 12 | 0.7 | — | Mostly noise in the pattern; real cases in §4 |
| Statistics | 109 | 164 | 0.7 | ~1.7× | As wanted |
| Backup / restore | 112 | 183 | 0.6 | ~1.6× | As wanted |
| Paywall / subscription | 450 | 1,007 | 0.45 | ~1.2× | As common |
| Quit a bad habit | 43 | 218 | 0.20 | ~0.5× | Less talked about on Play |
| Gamification | 68 | 374 | 0.18 | ~0.5× | Less (the App Store set has more game-like apps) |
| Shortcut / launcher / app icon | 3 | 21 | 0.16 | ~0.4× | On the App Store probably mostly Siri Shortcuts (not checked) |

**Reading:** nothing here says Android people want a different app. They mention almost everything at least as often
per word. The one outlier is reminders.

## 4. Reminders: the thing Android gets wrong

**Users show** ([tally](<Android App Evidence/theme_tally.md>), 40 read, 36 on topic):

| What happened | n | Examples |
|---|---|---|
| The reminder never came, or only sometimes | 22 | P8#5318, P24#2039, P126#43611 |
| Worked, then stopped (after days, an update, a new Android version) | 7 | P3#4973, P84#8465, P2#2258 |
| Came only when the app was opened (the system had stopped the app) | 4 | P2#11428, P33#1187, P18#722 |
| Came without the sound or vibration that was set | 4 | P111#5024, P84#17354, P24#9791 |
| Names a phone maker or Android version | 3 | P2#2258, P24#1551, P8#6329 |
| Already granted every permission, still failed | 2 | P33#564, P126#63491 |

From the battery theme (15 on topic): 6 had **already switched off battery optimisation and still got nothing**
(P5#1214, P2#11310, P2#11990); 2 wanted the app to **guide them** to the right setting (P24#10984, P2#11262); 1 was
angry that an app **demanded** unrestricted battery (P38#1080); 3 said an app **drained** the battery (P126#70351).

**Why (Google's pages, [web notes](<Android App Evidence/web_notes.md>)):**

- Since Android 13, **notifications are off until the person allows them**.
- An exact-time reminder needs **"Alarms & reminders"** (`SCHEDULE_EXACT_ALARM`), which **Android 14 denies by default**
  for new installs; the person grants it in Settings and can take it back (which cancels every exact alarm).
  `USE_EXACT_ALARM`, granted on install, is only for alarm-clock and calendar apps; Play refuses others.
- Without it, a reminder fires **"within one hour"** of its time, or in a window of at least 10 minutes.
- **Doze** holds ordinary alarms and background work (WorkManager too) until occasional maintenance windows.
- **Phone makers add their own killers:** Huawei, Xiaomi, OnePlus and Samsung score worst on dontkillmyapp.com; Pixel 0.
- **Play forbids** asking for a direct battery-optimisation exemption unless Doze breaks the app's core function (chat
  without FCM, safety, task automation, device companions). A habit app may only open the general battery settings.

**What that means for us (reasoned from the above):** reminders on Android need their own work, the same promise as
the iPhone's (Pending to Implement §6: serialized scheduling, visible errors):

1. **Ask in context, in two steps**, when the person turns on their first reminder: notifications, then Alarms &
   reminders (Google's guidance: ask after a user action, never at first launch).
2. **Use exact alarms when allowed** (`setExactAndAllowWhileIdle`, fires in Doze); without them, a 10-minute window,
   and **say so** on the Reminders page ("Reminders may come up to 10 minutes late. Allow exact times").
3. **Re-plan on everything that drops alarms:** restart, app update, time or time-zone change, the permission
   changing, and every return to the app.
4. **Notice a reminder that didn't arrive.** The app knows when each was due; when it's next opened and a reminder
   that should have shown was never delivered, it can say so once, plainly, with the fix for that phone (D2). Reasoned from first principles:
   reviewers can't tell the phone's doing from the app's, and blame the app (P33#564 had granted everything).
5. **Never ask for the battery exemption directly** (Play policy); show the phone maker's own steps only when a
   reminder actually failed on that phone.
6. **Test on the phones that kill apps:** a Samsung and a Xiaomi at least, not only a Pixel or an emulator.

## 5. Widgets

**Users show** (80 read, 79 on topic):

- **Half of the "widget wanted" reviews are apps that have none** (20 of 40: P12#25712, P111#10890). Among those that
  have some: one widget with **all of today's habits** that can be ticked (5 + 4: P3#9857, P3#5496, P3#10644);
  **statistics or calendar** widgets (P3#6209, P2#7983, P65#2194); the **look** (transparency, colours that match the
  home screen: P126#30502, P84#31487).
- **Broken widgets:** **stale**, not updating until the app opens (8: P8#1326, P126#26680, P8#1410); **don't work**
  (7: P9#880, P31#437); **taps do nothing** (P24#1714, P3#5497, on a Galaxy S22); **can't be added** (P3#2583);
  **gone after a restart** (P126#64916); people **paid for widgets that didn't work** (P9#880, P4#17482).
- Two wanted the widget to **open the app** when tapped, not only log (P3#5501, P24#14433).

**Android:** Glance widgets (Kotlin, Compose-style); check boxes and switches are native from Android 12; a widget's
action runs in the app's own process (so the iPhone's "save in the widget, hand over to the app" dance, S18, isn't
needed); dynamic colour from Android 12. A widget can't open a screen through a background step (use a direct
activity launch).

**What carries over:** every U26/U28 principle: the tap changes the card at once, the change is saved before anything
else, widgets redraw after every change in the app or from sync, a removed habit says so. The timings (S17, S18) are
the iPhone's and get measured again on Android.

## 6. The look: Material 3, dark mode, colours, icon

**Users show** (40 read, 35 on topic): dark mode praised (10) and wanted (8), more themes wanted (9), **following the
phone's dark setting** (P126#41021, P2#7612), widgets that match (3), dark mode **behind a paywall** resented
(P49#1903, P2#2464: "an accessibility need"). The home-screen sample adds the **icon**: odd shapes and white borders
on Android launchers annoy people (P9#845, P3#7874, P9#1073).

**Android:** Material 3 is the native look (U1's equivalent). **Dynamic colour** (Android 12+) themes an app from the
wallpaper; it's optional, and brand colours can stay fixed. **Themed icons:** on Android 16 QPR2 the system tints any
app icon when the person turns icon theming on, even with no monochrome layer, and apps can't opt out (press reports,
Aug–Dec 2025).

**Conflicts with decided rules:** dynamic colour would tint the chrome, against U2 (colour belongs to the habits; the
chrome is monochrome) → D5. A themed icon is single-colour, against U29 (the tonal logo never in single ink) → D6.

## 7. Back, edge-to-edge, navigation

**Users show** (40 read, 29 on topic): back **exits the app** when people expected one step back (6: P24#3984,
P122#2706 on a Pixel); back **throws away typing** (4: P126#45981, P87#73 lost a long journal entry); content under the
status or navigation bar (5: P122#9087, P3#1698); a permanent **alarm-clock icon** in the status bar (4: P126#68812:
that's what `setAlarmClock` shows); a hamburger menu people wanted as bottom navigation (P111#2283).

**Android:** targeting API 36, **edge-to-edge can't be switched off** and **predictive back is on**: the system
animates back to the previous screen or the home screen, and the app only steps in when something must be protected.

**For us:** back always goes one step (the sheet, the page, then home); **back never loses typed text** (it asks, the
same as ✕ on Add screens, U18); no "press back twice to exit"; content drawn under the bars with proper insets.

## 8. What Android's best-rated habit apps are praised for

72 five-star reviews, six apps ([tally](<Android App Evidence/praise_tally.md>)):

| Praised for | n | Apps | Examples |
|---|---|---|---|
| Simple, minimal, easy | 28 | 6 | P3#2720 (opens instantly, tick in under 10 s), P65#3419 |
| Motivation (streaks, quotes, challenges) | 15 | 4 | P24#1449, P125#3877 |
| Free | 12 | 4 | P3#3284, P10#7234 |
| Statistics, a visual record | 11 | 5 | P3#4046, P2#3825 |
| Flexible kinds and schedules | 9 | 5 | P3#3949, P2#5811 |
| Reminders that work (and daily messages) | 8 | 3 | P2#6906, P125#6076 |
| No ads | 7 | 3 | P3#2128 (no ads, no sharing of data) |
| One-time price, not a subscription | 7 | 1 | P2#5841, P2#2119 |
| Backup, data survived a reinstall | 4 | 4 | P65#2221, P2#2119 |

Requests inside the praise are things our app already does or has decided: several reminders a day (P3#4161), N times
a week without fixed days (P65#2834), a note on a past day (P10#5741), schedules that keep the past (P2#3436), help
restoring a backup on a new phone (P65#2552, P125#5272). From the wider scan: the free/no-ads theme is 3 times as
common per word on Play, and no-ads (34 of 40), simple (15) and free (15) dominate it; offline, no account and privacy
appear too (P3#1753, P68#23). **Reading:** our free plan with no ads, no account and full backup is exactly what the
best-rated Android apps are loved for; Android people will notice it.

## 9. What Android requires of our first release

| Rule | Since | What it means for us |
|---|---|---|
| Target **API 36** for new apps and updates | Play, 31 Aug 2026 | Everything below applies at launch |
| **Edge-to-edge**, no opt-out | API 35/36 | Draw under the bars; insets everywhere |
| **Predictive back** on by default; `onBackPressed` not called | API 36 | Back handled only where typing must be kept |
| **Full-window on screens ≥ 600dp**: orientation and aspect locks ignored | API 36 | Tablets and foldables get a full-width app, wanted or not (D9) |
| **Notifications off** until allowed | Android 13 | Ask when the first reminder is turned on |
| **Exact alarms** denied by default; `USE_EXACT_ALARM` only for alarm/calendar apps | Android 14 | D1 |
| **Full-screen intents** only for calling and alarm apps | Android 14 | D3 |
| No direct **battery-exemption** request for a habit app | Play policy | §4 point 5 |
| **Auto Backup:** 25 MB, the person's Drive, daily, restored before first launch; Android 16 QPR2 adds **transfer from an iPhone** | Android 6 / 16 QPR2 | The whole app's backup for free; D11 |
| **Live Updates** for an ongoing, user-started, time-bound activity | Android 16 | The timer's equivalent of the Live Activity |
| **Health Connect** replaces Google Fit (Fit APIs end in 2026) | — | Only if the iPhone gets Health too (parity) |

## 10. What carries over from the iPhone

**Same** means the same behaviour and words through the shared core (Current Work 92) and Material components.

| iPhone | Android | |
|---|---|---|
| Today: time-of-day cards, rows, round button, fill, streaks, Skip, done rows sinking (U4, U13, U14) | Same; Material list rows | Same |
| ✓ toggles, + adds, swipes reveal and never act, long-press menu (U14) | Same (long-press is just as native on Android) | Same |
| Day bar at the bottom (U23) | Material bottom app bar | Same, native component |
| ≡ side menu | Material navigation drawer (it's Android's own pattern) | Same, native component |
| Sheets: Day details, Add screens with ✕ and the button at the bottom (U17–U22) | Material bottom sheets, full-screen dialogs | Same layout, native components |
| SF Pro, SF Symbols, Dynamic Type, VoiceOver | The system font, Material Symbols, font scale to 200%, TalkBack | Native equivalents |
| Light / Dark / Automatic | Same, following the phone | Same |
| Haptics, sound when done | Same (system haptics) | Same |
| Reminders: notification, Remind Again, Done / +1 | Same, plus the permission steps and checks of §4 | **Changes** (D1, D2) |
| Alarm style (AlarmKit: rings on silent, full screen) | `setAlarmClock` with an alarm-channel sound; full screen not allowed for us | **Changes** (D3) |
| Widgets (U25, U26, U28) | Glance; same principles; Android's own sizes | Same principles, re-measured |
| Live Activity for a running timer | Live Update on Android 16; an ongoing notification with a clock before it | Native equivalent (D4) |
| Lock with Face ID (App Lock) | BiometricPrompt: face, fingerprint or the screen lock | Same |
| iCloud sync, dated backups (D4) | Google Drive sync (A4), Auto Backup | Decided (A4) |
| Export / Import CSV and SQLite (D5, D15) | Same through Android's file picker | Same |
| Plus with StoreKit; Plus Family | Play Billing; Play can't share an in-app purchase with a family | Open (README) |
| iPad layout (U35) | Tablets and foldables, full-window forced on ≥ 600dp | D9 |
| Apple Watch (U30–U34) | Wear OS: not at launch (A3) | Later |
| Widgets' and intents' Shortcuts | App shortcuts (long-press the icon), a Quick Settings tile | D8 |
| Speed rules (S1–S18) | The same targets, measured with Android's own tools (Macrobenchmark, JankStats) on GitHub's Linux runners | Rules restated for Android when building |

## 11. Decisions for the user

**Decided by the user, 12 Oct 2026** ([Android README](<../README.md>) A11–A12): every recommendation below as written,
except **D11**, which becomes a transfer through a small server on Cloudflare's free plan, built last (encrypted on the
phone, deleted once picked up).

| # | Question | Recommendation | Why |
|---|---|---|---|
| D1 | How do reminders get exact times? | Ask for **Alarms & reminders** in context, right after notifications, when the first reminder is turned on; without it, a 10-minute window, said on the Reminders page. Don't declare `USE_EXACT_ALARM` | §4; Play refuses it for non-alarm apps |
| D2 | How does the app show a reminder problem? | A **reminder check** on the Reminders page (notifications off, exact times off, battery restricted) with one tap to each setting; and **once**, after a due reminder didn't arrive, a plain line that says so with that phone's fix. Never blaming the person (A6's tone) | 22 of 36 "never came"; people blame the app for what the phone did |
| D3 | The "Alarm" reminder style on Android | Keep it, as `setAlarmClock` with a ringing alarm-channel sound and actions; no full screen (not allowed for us). Say in the picker what it does. Accept the status-bar alarm icon while an alarm is set | §9; 4 reviews dislike a permanent alarm icon: only alarm-style reminders show it |
| D4 | The running timer outside the app | Android 16 Live Update with a counting clock; an ongoing notification on older Android | The Live Activity's equivalent; fits Google's "user-started, time-bound" |
| D5 | Wallpaper colours (dynamic colour) | **Off by default**, keeping U2 (monochrome chrome, colour for habits); optionally an Appearance switch later | U2; dynamic colour is optional in Google's guidance |
| D6 | Themed (single-colour) icon | Supply **our own monochrome layer** drawn from the tonal mark, so a phone that themes icons shows our shape, not an automatic tint; the colour icon stays the default | Android 16 QPR2 tints it anyway; U29 needs the user's say-so |
| D7 | Back | One step at a time; never loses typing (asks first); no "press twice to exit" | §7; API 36's predictive back |
| D8 | Launcher extras | Long-press shortcuts (New habit, Start the next routine, Today); **no badge count** on the icon (a count of what's left reads as "due", U3); a Quick Settings tile later | 7 shortcut requests in 40; U3 |
| D9 | Tablets and foldables at launch | Yes, with the iPad's decided layout (U35's rules, translated): API 36 makes the app full-window there anyway | §9; the iPad design exists |
| D10 | Free plan on Android | The same free plan, with no ads ever, and dark mode and widgets free | §6, §8; dark mode behind a paywall is resented |
| D11 | Moving from an iPhone to Android | Export / Import stays the way (D15); check Android 16 QPR2's iPhone transfer later, as an extra | New and Pixel-first; needs our bundle and team IDs |
| D12 | Which phones we test on | A Pixel, a Samsung and a Xiaomi (real devices) for reminders and widgets; emulators for the rest on GitHub | §4, §5: the failures name these makers |

## 12. What this report doesn't cover

- Pricing and Plus (settled in the [Android Plus report](<Android Plus — What Android People Pay For, and Keeping Both Apps the Same.md>)), sync (the sync reports), Wear OS (later).
- Only English reviews were counted or read; the Play corpus holds many reviews in other languages, which this leaves
  out.
- Google's pages were read on one day; Android changes every year (API 37 next). Recheck §9 before release.
