# Running a Routine on the Watch — Can It Be Done?

Written by Claude (Claude Code), 10 October 2026. Step 1 of the user's Watch plan (Current Work 82): "first of all, we
need to understand: is it possible to create… focused routines on watch or not? So yeah, check from the routinary or
other routine based". It adds to [Apple Watch App — What People Want, What Breaks, and How Ours Works](<Apple Watch App — What People Want, What Breaks, and How Ours Works.md>).

**Evidence:**
- All 182 reviews about Routinery's Watch app in our App Store corpus, re-read for this question and grouped below.
  The IDs are in the appendix, and every English quote is checked word for word (`Apple Watch Evidence/check_quotes.py`).
- The other routine apps' Watch reviews.
- Routinery's App Store listing.
- Apple's watchOS documentation.

---

## 1. The answer

**Yes. A focused routine can run on the Watch, and people love it when it works.** Routinery has done it since its
Watch app came out in November 2020: start a routine on the Watch, see the current step and its countdown, then
complete, skip, pause or add time. Its listing today: "Start on the phone, carry on from watch, tablet, or Mac."
People run whole mornings from the wrist with the phone left behind: "Now I can ditch my phone and actually focus on
completing my habit" (`12936726099`, 5★).

**But it's the hardest thing to get right on the Watch.** In Routinery's 182 Watch reviews, 57% report sync failure or
a Watch app that doesn't work. The failures have three causes we can design out:

1. The routine lived in the running app, so it died when watchOS suspended the app.
2. The Watch and the phone each ran their own copy of the session.
3. The Watch had fewer actions than the phone.

**So we can, and should, run routines on our Watch app in version 1.** Our player is already built in a way that
avoids the first two causes (§4). This changes decision 1 of the Watch report: routines move from version 2 into
version 1.

---

## 2. What Routinery's Watch app does, and what goes wrong

| What people report | Reviews | Mean ★ |
|---|---:|---:|
| **Praise for running routines from the Watch** | 13 | 4.85 |
| The routine ends or resets by itself on the Watch (wrist down, screen off, after a while) | 15 | 3.47 |
| No alert when the wrist is down or a step ends | 8 | 3.12 |
| The Watch and the iPhone disagree about the running routine | 24 | 3.54 |
| Must open the iPhone first, or stuck on "open the app on your iPhone" | 13 | 3.46 |
| Actions on the phone missing on the Watch | 12 | 4.08 |
| Wants the current step and time left on the watch face | 9 | 4.56 |

Counts are at least these (a review was counted only where it says so plainly); several overlap.

**Why it breaks, from the reviews and Apple's rules:**

- **watchOS suspends an app when the wrist goes down.** Apple: "An app running on Apple Watch normally transitions to
  the background and becomes suspended when the user lowers their wrist"
  ([extended runtime sessions](https://developer.apple.com/documentation/watchkit/using-extended-runtime-sessions)).
  A routine whose timer runs inside the app stops with it: "on the apple watch it turns off the moment you leave the
  app or the screen gets dimmer." (`11427409205`, 3★). Translated: once the screen went off, no alert came when the
  time ran over, so they forgot the timer was running (`13786020408`, 2★).
- **Two copies of one session.** "When I pause the routine on my watch, the phone app will continue counting down."
  (`8283285093`, 4★); "If I start from the watch, it almost never records that on the phone." (`10179113941`, 2★).
  The phone then sends alarms for steps already done on the Watch.
- **The Watch depends on the phone.** "I really don’t like having to pull up the app on my phone first in order to
  use it on my watch." (`10924800327`, 4★).
- **Fewer actions.** "On the Watch, there’s no option to move a task to the end, only complete or skip."
  (`12442067714`, 3★). Other reviews ask for going back, auto-next, the step's notes, and seeing what's next.
- **The face doesn't show the routine.** "would love a watch face complication showing my current habit and time
  remaining." (`6777298636`, 5★).

## 3. Other routine apps

- **Fabulous** plays routines on the Watch. Its reviews report the same failures: a routine missing on the Watch, and
  progress that doesn't sync while a routine plays (`4613729578`, `9389650647`, `6168986562`).
- **MyRoutine** lists routines on the Watch but has no timer there. Translated: people do their morning routine with
  only the Watch, and have to keep the iPhone nearby to see the time left (`13435011015`, `13431240197`, Nov 2025).
- **Productive** groups habits by time of day; on the Watch they're checked off, not played.
- **Tiimo and Brili** are named by Routinery users as earlier apps whose Watch use was unreliable. They aren't in our
  corpus, so there's no evidence of our own on them.

## 4. What watchOS allows, and how our design avoids the failures

| Apple's rule | What it means | Our answer |
|---|---|---|
| An app is suspended when the wrist goes down | Nothing can depend on our code running | **The routine lives in data, not in the running app** (R2) |
| Local notifications fire while the app is suspended | A step's end can always alert | **Each running timer's end is a scheduled notification** (R3) |
| Extended runtime sessions keep an app running, but only for matching uses: self care (frontmost, 10 min), mindfulness (frontmost, 1 h), physical therapy (background, 1 h), smart alarm; "select a session type based on the app’s intended use" | Not a general way to keep a routine alive; a 30-minute morning routine outlives self care | **Not needed for correctness**; whether a session adds anything is checked on the user's Series 10 (§6) |
| A workout session (`HKWorkoutSession`) runs as long as needed, but records a workout and fills the Activity rings | The reading-timer problem in the main report | **Never a workout** (WA10) |
| A watchOS app can't start a Live Activity (developer reports; ActivityKit isn't usable there) | A timer started on the Watch can't appear as one | The Watch's own complication shows it (R7) |
| The iPhone's Live Activity appears in the Watch's Smart Stack; `WKSupportsLiveActivityLaunchAttributeTypes` lets a tap on it open the Watch app | A timer started on the phone already shows on the wrist | A tap opens our Watch player at that habit (R8) |
| "Return to App" (stay on an app instead of the clock) applies to Apple's own apps (Timers, Workout, Music…) | Our app returns to the clock after the person's setting (2 minutes by default) | Reopening resumes exactly where it was (R2) |

**Why our player avoids most of Routinery's failures:**

- **There's no shared "session" to fall out of step.** Our routine player walks through a section's habits (Morning ·
  2/10), and each habit has its own main action. Only two things are shared:
  - its timer, a synced record with a start time (S4, WA10);
  - its logs.

  Both already sync like any other change.
- **The player's place is each device's own.** Moving ‹ › never logs or skips anything (Routine Player decisions), so
  the place doesn't need to sync. The Watch can be on habit 3 while the phone shows habit 5, and nothing is wrong.
  Routinery's failures come from syncing a single session state: whose step is current, paused or finished.
- **Nothing advances by itself.** Our player doesn't auto-advance, so a suspended Watch can't "miss" moving to the next
  step.

## 5. Rules for a routine on the Watch (for step 2's designs)

| # | Rule | Why |
|---|---|---|
| R1 | **The Watch runs the same player as the iPhone:** the section's habits one at a time, each with its main action (Start/Pause timer, +step, Mark done), ‹ › to move, and the habit's Day details for Skip, Undo and logging by hand. A routine starts from the Watch alone | Missing actions (12); "must open the iPhone first" (13) |
| R2 | **The routine lives in data, never only in the running app.** Timers are start times in the database; the player's place is saved on the device. Wrist down, suspension, the app being closed or the Watch restarting lose nothing: reopening shows the same habit and the right time | Routines that end or reset by themselves (15) |
| R3 | **A timer's end is a scheduled notification** (with a haptic), made by the device that started it, cancelled when the timer stops on either device. So it alerts with the wrist down, and never twice | No alert with the wrist down (8) |
| R4 | **Started on one, controlled on the other.** A timer started on the iPhone can be paused on the Watch and the other way round. The change goes over WatchConnectivity at once when both are near, and through iCloud otherwise | Pause on the Watch while the phone counts on (24 disagree) |
| R5 | **Moving ‹ › never logs or skips** (as on the iPhone), and **nothing advances by itself** | Auto-next that silently failed; accidental "next" |
| R6 | **No workout session**, and no extended runtime session unless the Series 10 check shows a real gain | Activity rings; Apple's "intended use" rule |
| R7 | **While a routine runs, the face shows it:** the current habit and its time left (complication and Smart Stack), from the Watch's own snapshot | 9 asked for exactly this |
| R8 | **A tap on the iPhone's timer Live Activity on the Watch opens our Watch player at that habit** | The phone-started timer already shows there; it should lead somewhere useful |
| R9 | **The finish:** the last › opens the same summary as the iPhone ("Morning done"), and the routine's logs are already saved, since every action saved as it happened | Routines "finished" on the Watch but not recorded |

## 6. To check on the user's Apple Watch (Series 10, watchOS 26)

- A 30-minute routine started on the Watch with the iPhone in another room: wrist down for 10 minutes, then raised.
  Does it show the right habit and time?
- A timer started on the iPhone, paused on the Watch, resumed on the iPhone.
- The end-of-timer alert with the wrist down and with the screen off.
- Whether a self-care extended runtime session makes any visible difference (it shouldn't be needed).

## 7. What changes

- **Decision 1** of the Watch report now reads: version 1 includes the routine player on the Watch (R1–R9).
- **Step 2** (the designs, now in `Designs/`) includes the Watch routine player, its finish summary, and the face while a routine runs.

## Sources

- Routinery: [App Store listing](https://apps.apple.com/us/app/routine-planner-habit-tracker/id1450486923) (version 3.30.2,
  "Requires watchOS 9.6 or later"); its 182 Watch reviews in our corpus (appendix).
- Apple: [Using extended runtime sessions](https://developer.apple.com/documentation/watchkit/using-extended-runtime-sessions);
  [WKSupportsLiveActivityLaunchAttributeTypes](https://developer.apple.com/documentation/bundleresources/information-property-list/wksupportsliveactivitylaunchattributetypes);
  [Turn on and wake Apple Watch (Return to Clock)](https://support.apple.com/guide/watch/apd748b87e2a/watchos);
  [WWDC24 What's new in watchOS 11](https://developer.apple.com/videos/play/wwdc2024/10205/).
- Developer reports: [starting a Live Activity on watchOS](https://developer.apple.com/forums/thread/757685).
- Our player: [Routine Player — Design Decisions](<../../../../iOS/Docs/Specs/Routine Player — Design Decisions.md>).

## Appendix — Routinery's Watch reviews by finding

Stars and review ID. Made with `Research/Temp/watch` (rows of `watch_app.json`), checked to be Routinery's.

**Ends or resets by itself (15):** 3★ `11427409205`; 4★ `13207218323`; 3★ `11819860723`; 5★ `11314153569`; 2★ `12973553692`; 3★ `13259002296`; 3★ `12442067714`; 4★ `8489824934`; 5★ `8490774445`; 3★ `7805591322`; 3★ `11283605490`; 3★ `7904305007`; 5★ `6910114072`; 4★ `9183771774`; 2★ `9267380614`

**No alert when the wrist is down or a step ends (8):** 2★ `13786020408`; 5★ `13890701524`; 1★ `10881832037`; 1★ `8612200478`; 5★ `6748956045`; 3★ `8561307198`; 4★ `6832936425`; 4★ `8765909690`

**Watch and iphone disagree about the running routine (24):** 4★ `13390488694`; 4★ `9886812490`; 2★ `8413763372`; 5★ `7150670668`; 2★ `10179113941`; 4★ `11013911389`; 5★ `8627876488`; 5★ `11041542289`; 1★ `8941948970`; 2★ `10005584335`; 4★ `8096972526`; 4★ `8007313621`; 5★ `7438030554`; 4★ `8283285093`; 4★ `9903943394`; 4★ `10958250404`; 3★ `9272132912`; 2★ `9816248262`; 4★ `10339767091`; 5★ `9607295246`; 4★ `9295801705`; 4★ `13114850394`; 1★ `9940670492`; 3★ `8262033183`

**Must open the iphone first, or stuck on open the app on your iphone (13):** 4★ `10924800327`; 2★ `9537877519`; 4★ `8394614510`; 4★ `12417804176`; 3★ `8227531164`; 4★ `13468052562`; 4★ `8737737503`; 2★ `8728078244`; 3★ `7530054088`; 5★ `7761010928`; 4★ `7268334304`; 3★ `12993749401`; 3★ `7266678836`

**Actions missing on the Watch (12):** 4★ `12731101835`; 3★ `12442067714`; 5★ `8745613875`; 5★ `11799088054`; 3★ `12576028400`; 4★ `13468052562`; 5★ `7724163299`; 4★ `7872735468`; 4★ `8368846355`; 5★ `8237359683`; 2★ `11149362699`; 5★ `7843095633`

**Wants the current step and time left on the face (9):** 4★ `12240973409`; 5★ `6777298636`; 5★ `9186323926`; 5★ `6910114072`; 5★ `6719447014`; 5★ `6669295549`; 3★ `11900632508`; 5★ `12919718433`; 4★ `8096972526`

**Praise for running routines from the Watch (13):** 5★ `12936726099`; 5★ `12376007931`; 5★ `10036626729`; 5★ `10141244395`; 4★ `8202746698`; 5★ `8821459512`; 5★ `7088596981`; 5★ `6643752216`; 5★ `8998779019`; 5★ `8177366256`; 5★ `13650428133`; 5★ `14408847759`; 4★ `8483895502`
