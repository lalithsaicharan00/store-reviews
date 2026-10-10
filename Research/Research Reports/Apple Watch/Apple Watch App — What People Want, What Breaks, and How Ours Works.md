# Apple Watch App — What People Want, What Breaks, and How Ours Works

Written by Claude (Claude Code), 10 October 2026. Roadmap #65 (Apple Watch app, Plus; Feature Ledger C022). Written for
the no-server world (Rulebook D16): sync through the person's own iCloud ([Architecture 11](<../../../Architecture/11. iCloud Sync with CloudKit.md>)).
It replaces the server-based Watch design in [Architecture 07 §4](<../../../Architecture/07. Other Surfaces.md>).

**Evidence:** all 337,331 App Store reviews of the 74 habit and routine apps were scanned for any mention of a watch, in
English and eight other languages. All 3,051 matches were read one by one and coded by hand. The full per-review index and the scripts are in
[`Apple Watch Evidence/`](<Apple Watch Evidence/Apple Watch — Review Index.md>). Every English quote was checked word
for word against its review (`check_quotes.py`); translated quotes are marked.

---

## 1. The answer

**People want a Watch app so they can log without picking up the phone, and see their day on the watch face. What
they get, again and again, is a Watch app that doesn't open or doesn't agree with the phone.**

- **Demand is wide.** 764 reviews in 46 apps ask for a Watch app (mean 4.38★: people who like the app and want it on
  their wrist). 264 say why: logging from the wrist, or using the Watch *instead of* the phone (to avoid distraction,
  at school, while the phone charges).
- **Failure is the norm.** In the 17 apps that have a Watch app, **42.1% of reviews about it report sync failure or a
  Watch app that won't work** (886 of 2,105, mean 2.97★), against 35.8% praise (4.76★). This hasn't improved: 45–51%
  of such reviews in every three-year period since 2018.
- **The watch face matters as much as the app.** 415 reviews are about complications or seeing progress at a glance.
  When a complication shows the wrong thing (stale, "All completed" when nothing is, blank), the rating falls to 2.74★.

**So our Watch app is built around two promises: it always opens straight to today's habits from its own database,
and a tap on either device shows on the other.** Everything else (timers, amounts, undo, reminders) follows the
iPhone's own rules (U14, U16), because people complain when the Watch behaves differently.

**How:** an independent watchOS app (Plus) with its own copy of the database, built from the same Kotlin core.
Changes travel two ways at once: straight to the iPhone over WatchConnectivity when it's nearby (fast, no internet),
and to iCloud through its own `CKSyncEngine` when it isn't. The core's merge counts a change once however many ways it
arrives. Verified: Room 3.0.3 and SQLite 2.7.1, the core's database libraries, are published for watchOS (§6).

---

## 2. What was read

| | |
|---|---|
| Scanned | 337,331 App Store reviews, 74 habit and routine apps, 2015–2026 |
| Matched a watch | 3,051 (scan in `watch_scan.py`: "Apple Watch", "complication", "wrist", "my watch", and the same in Japanese, Korean, Chinese, Spanish, French, German, Portuguese, Italian…) |
| About a Watch app | 2,793 (the rest: 182 not about one, e.g. "watch a video"; 146 about Health data only) |
| Apps | 49 with at least one; 17 have a Watch app with ten or more reviews about it |
| Coding | 26 codes (index §), several per review; each review read in full in its own language |

**Limits, said plainly:**

- **App Store only.** 1,391 Play Store reviews mention a watch (Wear OS, Galaxy Watch, Fitbit, Garmin). They weren't
  coded: Wear OS comes after Android launches (D16).
- **Not a survey.** Reviews over-represent strong feelings. Percentages are of reviews that mention a watch, not of
  Watch owners.
- **One app dominates.** Streaks has 623 of the 2,793 (22%). Every finding below holds without it (per-app table §3.2).
- **The trend is soft.** Older reviews in the corpus may not be a full record of their years (collection limits).
  "Not improving since 2018" means only that the share hasn't fallen, not that it's measured exactly.

---

## 3. What people show

### 3.1 The whole picture

| Theme | Reviews | Share of 2,793 | Mean ★ | Apps |
|---|---:|---:|---:|---:|
| Wants a Watch app | 764 | 27.4% | 4.38 | 46 |
| Praises a Watch app | 784 | 28.1% | 4.76 | 25 |
| Watch app broken: won't open, blank, loads for ever, crashes | 506 | 18.1% | 2.77 | 21 |
| Watch and iPhone out of sync | 486 | 17.4% | 3.06 | 19 |
| Complication / watch-face widget | 365 | 13.1% | 3.76 | 29 |
| Reminders on the Watch | 229 | 8.2% | 3.59 | 33 |
| Paid for it, or would pay | 224 | 8.0% | 3.05 | 32 |
| Logging from the wrist is the point | 206 | 7.4% | 4.39 | 33 |
| Slow or awkward on the Watch | 174 | 6.2% | 3.55 | 17 |
| Incomplete (habit types or actions missing) | 128 | 4.6% | 3.69 | 17 |
| Glance: progress on the watch face | 105 | 3.8% | 4.51 | 21 |
| Timer on the Watch | 92 | 3.3% | 3.91 | 12 |
| Works without the phone, or wants to | 80 | 2.9% | 4.17 | 23 |
| A routine on Watch and iPhone falls out of step | 59 | 2.1% | 3.29 | 2 |
| Amounts and numbers | 38 | 1.4% | 3.79 | 9 |
| Counted twice | 19 | 0.7% | 2.26 | 5 |
| Can't undo / accidental tap | 17 | 0.6% | 2.94 | 3 |
| Data lost through the Watch | 16 | 0.6% | 2.06 | 7 |
| Wrong day on the Watch | 13 | 0.5% | 3.38 | 8 |
| Sign-in needed on the Watch | 8 | 0.3% | 2.88 | 3 |
| Same gesture, different action on Watch and iPhone | 8 | 0.3% | 4.50 | 1 |
| Objects to the Watch being paid | 6 | 0.2% | 2.83 | 2 |
| Adding a new item by voice | 6 | 0.2% | 4.17 | 3 |
| A Watch timer counted as exercise | 3 | 0.1% | 2.67 | 1 |

### 3.2 What breaks, app by app

Reviews about each app's Watch app (themes overlap, so rows don't add up):

| App | About its Watch app | Praise | Sync failure or broken |
|---|---:|---:|---:|
| Streaks | 623 | 50% | 34% |
| Habit Tracker (Goal Tracker) | 292 | 41% | 42% |
| Productive | 230 | 31% | 44% |
| Routinery (Routine Planner) | 182 | 13% | 57% |
| Habitify | 132 | 28% | 55% |
| Today Habit Tracker | 118 | 14% | 45% |
| HabitMinder | 102 | 37% | 40% |
| Do Habits | 76 | 17% | 67% |
| Fabulous | 68 | 12% | 60% |
| Awesome Habits | 50 | 78% | 28% |
| Strides | 41 | 59% | 15% |

By period, in the 17 apps with a Watch app: 2015–17 15% sync failure or broken, 2018–20 45%, 2021–23 51%,
2024–26 47%.

### 3.3 Why people want one: the wrist instead of the phone

Users show the Watch is wanted for **logging and glancing without the phone**, not for a second copy of the app:

- "Sometimes I keep my phone out of reach to avoid distractions" (`11458708619`, Habit Tracker, 4★).
- Translated: to cut off the phone's distractions, they want to log only on the watch (`14269287686`, ShineDay, 5★).
- Translated: students at school can only check in on the watch (`8509098000`, ShineDay, 5★).
- "the Apple Watch app doesn’t work without the phone around" (`12717025537`, Productive, 4★): they'd pay for it.

ShineDay alone has 163 requests (it has no Watch app); one person switched to another app for its Watch app, and one
wrote "I bought a Apple Watch for this app." (`12014746702`, 5★).

### 3.4 What breaks: the two big failures

**The Watch app won't open or shows nothing (506, 2.77★).** Black screens, endless "Loading", "open the app on your
iPhone", "it just says ”internet is required on your iphone” and does nothing" (`6733678418`, Fabulous, 1★). One
pattern deserves its own rule: an empty Watch telling people with habits to make one, "Please add a habit in iPhone
app first." (`12520956951`, Habit Tracker, 2★); five reviews of that one app report it. The Watch decided "no habits"
before it had heard from the phone.

**The Watch and the iPhone don't agree (486, 3.06★).** Ticks on one device missing on the other, counts that differ,
complications behind the app. "You have to close the app on the apple watch and open again" (`10461378148`,
Habitify, 1★). Translated: the phone always overwrites the Watch's entries (`8343208608`, Streaks, 3★), a last-writer
-wins sync losing real logs. People who paid say so: 224 mention paying, and many paid *for* the Watch: "also because
it offers integration with Apple Watch" (`13660577110`, Habit Tracker, 2★).

**Smaller failures, each a rule below:**

- **Counted twice** (19, 2.26★). Translated: a 1/10 water log made while the Watch was disconnected synced twice,
  becoming 2/10 (`1480955144`, Streaks). Retries without a stable ID double the count.
- **Wrong day** (13). The Watch ignores the person's day start: "the habits there still reset at 12 am"
  (`8156774812`, Habit Tracker); or keeps yesterday after midnight: "It's not until I open the app on my iphone that
  the watch resets." (`6213582796`, Habitify).
- **Data lost** (16, 2.06★): restores and resets through the Watch, and the phone overwriting it.
- **Routines out of step** (59, 3.29★, nearly all Routinery). Translated: a routine finished on the Watch kept running
  as unfinished on the phone, which kept sending alarms (`9886812490`, 4★).
- **A reading timer counted as exercise** (3, HabitMinder): "my activity said an hour of exercise done"
  (`7641900979`, 2★). A Watch timer run as a workout session fills the Activity rings.

### 3.5 The watch face: glance first

415 reviews are about complications or seeing progress on the face (3.87★); praise for a working one is warm (4.51★
for glance), and the face is the reason some chose an app: "That first glance reminder throughout the day is really
helpful!!" (`1506836526`, Strides, 5★). For quit counters it's the whole point: "a constant reminder – every time I
look at my watch" (`11069921765`, Days Since, 5★).

When the face lies it's worse than nothing: 98 reviews report a complication that's blank, stale or wrong (2.74★).
"Complications constantly show “All completed” even when nothing is." (`6224557402`, Habitify, 3★). Another removed
the overview (how many left today) and kept only single-habit complications; people asked for it back.

### 3.6 Logging on a small screen

- **The same action must work the same way.** "you tap in watchOs and longhold in iOS to complete the circle"
  (`7067662905`, Streaks, 4★); 8 reviews, all one app, all asking for one model.
- **Taps are easy to make by mistake; undo must be there.** "Too easy to accidentally completing on Apple Watch."
  (`9318566072`, Streaks, 4★); 17 can't undo on the Watch.
- **Amounts: one tap for the usual amount.** "very painful to add a count by typing the number in the tiny number pad"
  (`4717399926`, Habit Tracker, 4★). And never a big button that finishes the day: "a tiny button while the big green
  check button is for completing all cups" (`10096953628`, Habit Tracker, 4★).
- **Timers on the Watch** (92): start, see the time left, stop; the most requested missing action in apps that have
  a Watch app.
- **Only today's habits.** One app's Watch shows "including habits that aren’t scheduled for tod[ay]"
  (`10832845541`, Habit Tracker, 4★).
- **No sign-in on the Watch** (8, 2.88★): Watch apps that asked for an account separately never worked for them.

### 3.7 Paying for it

The Watch sells: 224 reviews mention paying, most paid for it or say they would. Few object to it being paid (6, of
which 5 are one quit-counter app: "in order to access it on my apple watch I’d have to pay", `12134334067`, 5★). The
risk isn't the price, it's paying for something that doesn't work: the 109 that paid and found it broken or out of sync
average 2.33★, against 2.86★ for broken Watch apps where paying isn't mentioned.
This supports the existing decision: **the Watch is Plus** (Architecture 07), and it ships only when it's reliable.

---

## 4. Apple's facts we design around

Checked against Apple's documentation and WWDC sessions, October 2026.

| Fact | What it means for us |
|---|---|
| A watchOS app can run on its own, installed without the iPhone app, and reach the internet through the iPhone, known Wi-Fi or cellular ([Keeping your watchOS content up to date](https://developer.apple.com/documentation/watchos-apps/keeping-your-watchos-app-s-content-up-to-date)) | The Watch has its own database and works with the phone away |
| Apple: WatchConnectivity "isn't always available… use it as an opportunistic optimization, rather than the primary means"; CloudKit subscriptions and notifications work on watchOS 6+, "a potential replacement for Watch Connectivity" (same page) | iCloud is the Watch's main path; WatchConnectivity is the fast path when the phone is near |
| `CKSyncEngine` is available on watchOS 10+ ([docs](https://developer.apple.com/documentation/cloudkit/cksyncengine-4b4w9)); its schedule depends on system conditions | The same sync code runs on the Watch; we never rely on it being quick |
| Background refresh: "approximately four tasks per hour for each app with a complication on the active watch face", shared by all its complications ([WKApplicationRefreshBackgroundTask](https://developer.apple.com/documentation/watchkit/wkapplicationrefreshbackgroundtask)) | A complication on the face can fetch about every 15 minutes, no more |
| `transferCurrentComplicationUserInfo`: 50 a day when the complication is on the active face, 0 otherwise; after that, transfers fall back to ordinary queued `transferUserInfo` ([remainingComplicationUserInfoTransfers](https://developer.apple.com/documentation/watchconnectivity/wcsession/remainingcomplicationuserinfotransfers)) | The phone can update the face promptly about 50 times a day; we bundle changes |
| Widget push updates need APNs from a server ([WWDC25: What's new in watchOS 26](https://developer.apple.com/videos/play/wwdc2025/334/)) | Not available to us (D16, no server). We don't need them |
| Developer reports: CloudKit sync on the Watch can stall for hours away from the charger (watchOS 10, Core Data's CloudKit container; fixed for that developer by a single-target Watch app) ([forum](https://developer.apple.com/forums/thread/737661)); silent pushes reached a Watch app only in the foreground ([forum](https://developer.apple.com/forums/thread/729466)) | Unofficial, but the reason the phone path exists: a nearby phone never waits on the Watch's own iCloud |
| watchOS 11: `Button`/`Toggle` in every watchOS widget family through App Intents; `requestConfirmation(conditions: .lowConfidenceSource)` asks first when a tap may be accidental; `AccessoryWidgetGroup` (up to three items in a rectangular widget); Double Tap with `.handGestureShortcut(.primaryAction)`, one per screen; the iPhone's Live Activities appear in the Smart Stack with no Watch code, or with a custom layout via `.supplementalActivityFamilies([.small])` ([WWDC24: What's new in watchOS 11](https://developer.apple.com/videos/play/wwdc2024/10205/)) | Complications can log; accidental taps can be guarded; our timer's Live Activity already reaches the Watch |
| watchOS 26: Series 9 and later and Ultra 2 run arm64 (older watches arm64_32), build with Standard Architectures; controls (Control Center, Smart Stack, Action button); widgets the person configures (WWDC25, same session) | The core is built for both Watch architectures (§6) |
| watchOS 11 runs on Series 6, SE (2nd gen), Ultra and later; Series 4, 5 and the first SE stay on watchOS 10 ([Tom's Guide](https://tomsguide.com/wellness/smartwatches/watchos-11-compatibility-see-if-your-apple-watch-is-update-eligible)). Our iPhone app needs iOS 18, the release that came with watchOS 11 | **watchOS 11 as our minimum** leaves out Series 4, 5 and the first SE (decision 2, §9) |

---

## 5. The design

### 5.1 What people want to see on the Watch (W6)

**The answer from the reviews: what's left today, and one tap to log it.** So the Watch app opens to **Today**: the
habits due today, not done first, in Today's order (U13), each with its round button. Progress at the top in Today's
words ("3 left", U10: habits, not ticks). Nothing else on the first screen: no statistics, no onboarding, no account.

### 5.2 Rules for the Watch app

Each rule comes from a failure in §3 ("users show") or from Apple's limits; numbered **WA** to add to the Rulebook
when built.

| # | Rule | Why |
|---|---|---|
| WA1 | **Opens to today's habits from its own database, at once.** Never waits for the phone, the network or iCloud to show anything; never says "open the app on your iPhone" | 506 broken-app reviews (2.77★): blank, loading, "internet is required on your iphone" |
| WA2 | **Never says "no habits" until it has heard back.** A Watch that hasn't yet received anything shows "Getting your habits from your iPhone…" with what it's waiting for, as Restore does with iCloud (D4) | Five "Please add a habit in iPhone app first" reports, with habits on the phone |
| WA3 | **A tap shows at once and is saved on the Watch first** (S7); it reaches the phone and iCloud after, by two paths (§5.3). A failed send is retried from the outbox, never dropped | Ticks missing on the other device (486, 3.06★) |
| WA4 | **Every change carries the ID made on the Watch and merges with `SyncRules`**, so a change that arrives twice (both paths, or a retry) counts once, and the phone never overwrites the Watch (field-by-field merge, not last device wins) | Counted twice (19, 2.26★); "the phone always overwrites the Watch" |
| WA5 | **The day is the person's day.** The Watch uses the same day start and week start (synced settings) and the core's `today()`. The face and the list move to the new day at its start on their own (a timeline entry at the next day start, as S17) | Wrong day (13): reset at midnight despite a 3 AM day start; yesterday's count until the phone opens |
| WA6 | **The same gestures as the iPhone (U14):** tap the round control to act; tap the row to open the habit's day. ✓ toggles today; + adds one step and never takes back; the button fills only when the goal is met | "tap in watchOS and long-hold in iOS" |
| WA7 | **Undo is always one tap away and names what it takes back** ("Undo +1 glass", U14): on the row after a tap, and on the habit's day page | Accidental taps; 17 couldn't undo on the Watch |
| WA8 | **Amounts: the + step in one tap** (the same "+250" as Today, U16); another amount with the Digital Crown on the habit page; the number pad only as a fallback. No button ever completes a whole day's amount at once | "very painful… the tiny number pad"; the big check that completes all cups |
| WA9 | **Only today's habits,** and only what Today shows (no tasks in the habit list, U26) | Watch lists showing habits not due today |
| WA10 | **Timers run from their start time, never as a workout.** ▶ on the Watch or iPhone starts the same timer (one synced row with its start); either device stops it; the clock is drawn from the start time (S3, S4), so both always agree. No `HKWorkoutSession` for habit timers | 92 timer requests; Activity rings filled by reading; routines out of step |
| WA11 | **The face never lies.** A complication shows today's state from the Watch's own database; when it isn't sure (an older day's data), it shows the habit without a count, never "all done". It reloads on every change on the Watch and every change received | 98 broken/stale complications (2.74★), "All completed" when nothing is |
| WA12 | **No sign-in on the Watch.** iCloud is the person's Apple Account and Plus comes from StoreKit; nothing to type | Sign-in on the Watch never worked for 8 people |
| WA13 | **Notification buttons count, wherever they're pressed.** Done or +1 on a reminder on the Watch saves the same change, with the same ID, as on the iPhone (D13) | Reminders on the Watch that could only remind |

### 5.3 How changes travel (with iCloud, no server)

```
   Apple Watch (Plus)                     iPhone (the person's main device)          iCloud (their own)
 ┌────────────────────────┐   WatchConnectivity   ┌────────────────────────┐   CKSyncEngine   ┌──────────────┐
 │ Room DB (same core)     │ ◀── transferUserInfo ─▶ │ Room DB (the truth)     │ ◀──────────────▶ │ zone Habits  │
 │ outbox, its device ID   │     (queued, survives   │ outbox                  │                  │              │
 │                         │      restarts)          │                         │                  │              │
 │                         │ ◀── complication ────── │ (50 a day, face only)   │                  │              │
 └───────────┬─────────────┘     transfer            └────────────────────────┘                  │              │
             └───────────────────────── CKSyncEngine (when the phone is away) ──────────────────▶ └──────────────┘
```

- **The Watch is its own device** in the sync (Architecture 11): its own Room database through the shared core, its own
  outbox and device ID. It isn't a remote screen for the phone (that's what fails in §3.4).
- **Two paths at once, both ordinary sync:**
  1. **Phone nearby:** each Watch change goes to the iPhone with `transferUserInfo` (queued by the system, delivered in
     the background, survives restarts). The phone merges it and sends it to iCloud with everything else. Changes made
     on the phone, or fetched from iCloud, come back to the Watch the same way; while our complication is on the face
     the phone uses its 50 daily complication transfers for them, bundled 0.5 s after the last change (S16).
  2. **Phone away (Wi-Fi or cellular):** the Watch runs its own `CKSyncEngine` and sends its outbox to iCloud itself,
     and fetches on open, on a background refresh (about four an hour with a complication on the face) and on a push.
- **A change leaves the Watch's outbox only when it's in iCloud:** either the Watch's engine saved it, or a fetch shows
  iCloud already has it (its clock is at least the change's). Arriving at the phone first isn't enough: the phone could
  be lost before it sends.
- **Duplicates are harmless by design:** the same change by both paths merges once (WA4); the same record written by
  phone and Watch is an ordinary CloudKit conflict that `SyncRules.mergeRecord` resolves (Architecture 11 §7).
- **The Watch app is one target** (the modern single-target watchOS app), the form that fixed the one stall report.
- **Plus only.** Plus devices all sync (Architecture 11 §12), so the Watch never competes with the free plan's one
  syncing device. If Plus ends, the Watch first sends its outbox (as the free plan's handover does), then shows
  "Apple Watch is part of Plus" with everything kept on the phone (D10).

### 5.4 The watch face and Smart Stack

- **Complications (WidgetKit, every accessory family):** circular "3 left" ring (today's habits); one habit's ring;
  rectangular: the next up to three habits with their round buttons (`AccessoryWidgetGroup`); inline "3 left today".
  Quit habits show their current run ("12 days"), the face being the place people want it (§3.5).
- **Logging from the face:** the round buttons are App Intent buttons (watchOS 11), with
  `requestConfirmation(conditions: .lowConfidenceSource)` so the system asks first when a tap looks accidental.
  Tapping anything else opens that habit in the app.
- **Freshness:** reloaded by the Watch on every change and every received change; a timeline entry at the next day
  start (WA5); a background refresh fetch about four times an hour. No widget push (it needs a server).
- **Smart Stack:** the same widgets; the iPhone's timer Live Activity already appears there with no Watch code
  (watchOS 11). A custom small layout for it is decision 3.
- **Speed:** a complication reads a small snapshot the Watch writes after each change (as the iPhone's widgets do, U26),
  never the database itself.

### 5.5 The Watch app's screens (version 1)

1. **Today:** progress line, the list, round buttons, the after-tap Undo line. Double Tap scrolls (automatic; no
   primary action on the list).
2. **A habit's day:** its progress for today, the main action (✓, +step, ▶) as the Double Tap primary action, the
   Digital Crown for another amount, today's logs (each with Undo), Skip today last (U17).
3. **Timer:** the running clock from its start time, ⏸ / ■, time left to the goal; an end alert as a local notification.
4. **Not Plus:** "Apple Watch is part of Plus", what it does in one line, [Open on iPhone]. No purchase on the Watch.

**Not in version 1** (asked for, but rarely, or risky): running a routine on the Watch (59 out-of-step reviews show
it's the hardest to get right: version 2, with one device running a routine at a time), adding habits by voice (6),
history and statistics, controls (watchOS 26), Siri on the Watch.

---

## 6. The shared core on the Watch (checked)

- **The core's database libraries publish watchOS builds.** Google's Maven metadata, read 10 Oct 2026:
  `androidx.room3:room3-runtime:3.0.3` and `androidx.sqlite:sqlite-bundled:2.7.1` both ship `watchos_arm64`,
  `watchos_device_arm64` and `watchos_simulator_arm64` (and `watchos_arm32`).
- **Kotlin 2.4.20** (our version): `watchosArm64` (arm64_32, Series 4–8, SE) and `watchosSimulatorArm64` are Tier 2;
  `watchosDeviceArm64` (arm64, Series 9 and later, Ultra 2 on watchOS 26) is Tier 3 (built, not tested by
  JetBrains' CI); `watchosArm32` is deprecated ([Kotlin/Native targets](https://kotlinlang.org/docs/native-target-support.html)).
  So: add the three targets to `Core/build.gradle.kts`, run the core's tests on the Watch simulator, and check the
  arm64 build on a Series 9 or later before release.
- **Why the core, not a Swift copy:** the day, streak and goal rules must be the same code on both devices, or the Watch
  and the phone disagree (§3.4).
- **Health:** the Watch never imports Health data; only the one importing device does (Architecture 07).

## 7. Testing, and what needs a real Watch

- **GitHub's simulator:** the Watch app's screens, logging, undo, day start, complications' content, the core on
  watchOS, and sync against the fake iCloud of Architecture 11 (`CloudTransport`), including both paths delivering the
  same change (counted once) and the phone away.
- **Not on the simulator:** WatchConnectivity complication transfers (Apple: the Simulator doesn't support them),
  real iCloud, background refresh budgets, notification buttons pressed on the Watch, Double Tap. These need the user's
  iPhone and Apple Watch on one Apple Account.
- **On the devices, before calling it done:** log on the Watch with the phone in another room (Wi-Fi), in airplane mode
  then back, and with the phone off; log the same habit on both within a second; cross a 3 AM day start; leave a
  complication on the face overnight; a timer started on one and stopped on the other.
- **Speed (S2):** the time from tapping the app to a usable list, and from a tap to the filled button, measured on the
  Watch.

## 8. Build order

1. The core on watchOS (targets, tests on the Watch simulator).
2. The Watch app with its own database, Today and the habit day, logging and undo (no sync yet).
3. WatchConnectivity both ways, with the counted-once tests.
4. `CKSyncEngine` on the Watch (after Architecture 11's iPhone work: same `CloudSync` layer).
5. Complications and Smart Stack widgets, then logging from them.
6. Timers, notification buttons, the Plus gate.
7. Device checks (§7), then the user tries it.

## 9. Decisions for the user

1. **Version 1's scope** as in §5.5 (Today, a habit's day, timers, complications; routines on the Watch in version 2).
   Recommended.
2. **Minimum watchOS 11** (interactive complications, Double Tap, Live Activities in the Smart Stack). It leaves out
   Series 4, 5 and the first SE (2018–2020 watches), which can't update past watchOS 10; supporting them would mean
   complications that can't log and no Double Tap. Recommended.
3. **A custom Smart Stack layout for the timer Live Activity** (`.supplementalActivityFamilies([.small])`). The mirrored
   one appears anyway; a custom one fits the small screen. It changes the Live Activity, which is under the widget lock
   (U28), so only with the user's say-so.
4. **Device checks need an Apple Watch on the user's Apple Account** (Series 6 / SE 2nd gen or later; ideally also a
   Series 9 or later for the arm64 build).

## 10. What changes elsewhere

- **Architecture 07 §4** (server-based Watch) is replaced by this design; a banner there points here.
- **Roadmap #65** points here; **Current Work 82** tracks it.
- **Rulebook:** WA1–WA13 are added to the U rules when the Watch app is built (not before: rules describe what's built).

## Sources

- Reviews: [Apple Watch — Review Index](<Apple Watch Evidence/Apple Watch — Review Index.md>); `codes.py` (the hand-coded
  map), `watch_scan.py`, `tally.py`, `stats2.py`, `trend.py`, `check_quotes.py`, `make_index.py` (the working copy of the
  scan output is `Research/Temp/watch/watch_app.json`).
- Apple: [Keeping your watchOS content up to date](https://developer.apple.com/documentation/watchos-apps/keeping-your-watchos-app-s-content-up-to-date);
  [CKSyncEngine](https://developer.apple.com/documentation/cloudkit/cksyncengine-4b4w9);
  [WKApplicationRefreshBackgroundTask](https://developer.apple.com/documentation/watchkit/wkapplicationrefreshbackgroundtask);
  [remainingComplicationUserInfoTransfers](https://developer.apple.com/documentation/watchconnectivity/wcsession/remainingcomplicationuserinfotransfers);
  [transferCurrentComplicationUserInfo](https://developer.apple.com/documentation/watchconnectivity/wcsession/transfercurrentcomplicationuserinfo(_:));
  [WWDC24 What's new in watchOS 11](https://developer.apple.com/videos/play/wwdc2024/10205/);
  [WWDC25 What's new in watchOS 26](https://developer.apple.com/videos/play/wwdc2025/334/);
  [Enabling Double Tap](https://developer.apple.com/documentation/watchos-apps/enabling-double-tap);
  watchOS 11 devices: [Tom's Guide](https://tomsguide.com/wellness/smartwatches/watchos-11-compatibility-see-if-your-apple-watch-is-update-eligible).
- Developer reports (unofficial): [CloudKit sync on watchOS 10](https://developer.apple.com/forums/thread/737661);
  [updating a complication from CloudKit](https://developer.apple.com/forums/thread/729466).
- Kotlin: [Kotlin/Native target support](https://kotlinlang.org/docs/native-target-support.html); Google Maven
  metadata for `room3-runtime` 3.0.3 and `sqlite-bundled` 2.7.1 (`dl.google.com/android/maven2`).
