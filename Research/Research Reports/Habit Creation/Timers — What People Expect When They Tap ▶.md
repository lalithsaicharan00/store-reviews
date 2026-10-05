Written by Claude (Claude Code), 4 October 2026.

# Timers — What People Expect When They Tap ▶

**The user's question (4 Oct):**
- Today ▶ starts the timer inside the row. Then the timer goes into the Dynamic Island, and a bar stays at the bottom of
  Today above the day bar. It may follow the earlier research, but it doesn't feel intuitive: "to me it feels weird".
- When people tap ▶, do they expect a full-screen timer, or the row filling up? Do they expect the Dynamic Island, and
  how should it behave? Research it from the reviews, then build it and test it.

**Answer, in short:**
- People want **both**: to start with **one tap**, and a **big timer to look at** while they focus. What they reject is a
  timer screen they're **sent to and can't leave**, or a timer that's **forced** on them.
- So ▶ starts the timer at once **and opens it full screen**; a swipe down (or ⌄) puts it away and **the timer keeps
  running**: the row ticks, the bar at the bottom of Today shows it when the row is out of sight, and tapping that bar
  opens the timer again, like the iPhone's Now Playing bar. ≡ → Appearance → Timers turns the full screen off.
- The Dynamic Island and Lock Screen are **wanted** (about forty reviews ask for or praise them, two want them gone). They
  must appear only when the person leaves the app (iOS does this), **end the moment the timer stops**, stay in step with
  the app, and offer **Pause**, as the iPhone's own Clock timer does. An app switch turns them off, besides iOS's own.

This changes one decision of [Timing a Habit — Start, See and Stop](<Timing a Habit — Start, See and Stop.md>)
(28 Sep: "no full screen" for one habit's ▶). That report's reviews were about screens people were *sent to and trapped
in*; this round read the asks for a focus screen next to them, and the user's own use found the row-only timer unclear.

## How this was researched

- `Research/Temp/timer2/scan.py` read all **1,238,784** reviews (App Store and Play Store). **4,068** mention a timer
  (timer, stopwatch, countdown, pomodoro, time tracking, Live Activity, Dynamic Island).
- Four questions, each a search over those 4,068: the Dynamic Island / Lock Screen / status bar (**189**, of which **67**
  name the island, a Live Activity, the Lock Screen or the status bar), a full-screen or timer screen (**44**), a timer
  in the list or row (**25**) and a floating timer or bar (**23**). Every one of the 281 was read.
- Set aside: paywall "offer ends in" countdowns (9), Hevy's gym rest timers, and reviews that only mention a timer.
- Outside the reviews: how the iPhone's own Clock timer behaves, and Apple's guidance for Live Activities.

## What users show

| Theme | Reviews | What they say |
|---|---|---|
| **Want or praise the timer in the Dynamic Island / on the Lock Screen / in the status bar** | **≈41** | "the timer should be on Dynamic island like it is with clock app timer" (`12552714583`). Several paid for it |
| **A Live Activity left behind or showing the wrong thing** | 8 | Still there when paused or done (`13594271430`, `13759922947`), stuck at 0:00 "forever" (`10006395781`), random ones (`13155342823`) |
| **Out of step with the app, or unreliable** | 8 | "Island and in app timer not in sync" (`10258730446`), works "about once a week" (`9356552184`) |
| **Want to control it from there** (pause, stop) | 5 | "make it manipulatable through dynamic island or through the locked screen" (`12133136766`); "pause timer from lock screen" (`1d575e17…`) |
| **Want it gone, or an option to turn it off** | 2 | "give an option for the app to not constantly be on my dynamic island" (`12831822783`) |
| **Want or praise a big timer / focus screen for one task** | **≈12** | "Focus Mode… a built-in timer" (`13291175777`); "make the icon as big as the screen so we can focus on looking at the timer" (`6686258653`); "an option to use this timer in full screen… also… a mini capsule timer" (`fb36dee5…`) |
| **Praise a timer screen inside a routine** | ≈6 | RoutineFlow's "timer mode", Fabulous' full-screen routine timer |
| **A timer screen that traps, is forced, or clutters** | 5 | "takes me to a timer that I can't turn off" (`9302040f…`); "locks you onto the timer screen" (`9186134212`); "forcing us… in a full screen timer section" (`e0bc2095…`); "cluttered and distracting" (`7214908680`) |
| **Start with one tap, right there in the list** | 4 | "start a timer right there for a selected activity" (`8205259618`); "there's no one tap timer" (`06dab344…`) |
| **A filling bar helps** | 3 | "the visual of the timer progress bar… motivating" (`8aaf6dda…`); progress bars instead of alarms (`908338e3…`) |
| **See it while doing other things** (an in-app ribbon, a floating timer) | 6 | "browse the app with the timer running, maybe a ribbon… elapsed time" (`8175263159`); floating timers over other apps (Android) |

### 1. A big timer is wanted, as long as it lets you go

People ask for a timer they can look at: a focus mode, a timer "as big as the screen", a full-screen mode for study
sessions (TrackIt's is used and asked to be bigger). The complaints are never about the screen existing; they are about
being **sent** to one with no way out, or a timer you **must** run before you can tick the habit. One reviewer asks for
exactly the pair this app now has: full screen, and a small "capsule" when you leave it (`fb36dee5…`).

*Reasoned from that:* opening the timer when ▶ is tapped answers the user's "it just runs in the row"; a swipe down that
never stops it answers every "trapped" complaint; the row, the bar and Add Time stay, so a timer is never forced.

### 2. The Dynamic Island is expected; how it behaves decides whether it's loved

Roughly forty reviews ask for it, call it the reason they paid, or compare with the iPhone's Clock timer. The
complaints are all about behaviour: left behind after Pause or Done, stuck, out of step, random, or always there. The
iPhone's own Clock timer shows on the Lock Screen and in the Dynamic Island while it runs, with Pause and Cancel, and
iOS shows an app's Live Activity in the island only while that app isn't on screen. Apple's guidance: give people
control over a Live Activity, and remove it from the Dynamic Island as soon as it's no longer active.

### 3. The bar at the bottom of Today

Few reviews talk about an in-app bar (one asks for a "ribbon" with the elapsed time, others for a floating timer). On
its own the bar read as "stuck above the day bar". It now behaves like the iPhone's Now Playing bar: it shows only while
a timer runs and its row is out of sight, tapping it opens the timer, ⏸ stops it. *Reasoned from first principles and
the iPhone's own pattern.*

## Decision (built 4 Oct 2026, branch `claude/timer-swipe-limits-and-fixes`)

| Where | What happens | Basis |
|---|---|---|
| **▶ on a timed habit** | Starts the timer at once (one tap) **and opens it full screen** (`TimerScreen`): name, today's period, the routine player's clock circle, Pause/Resume, Log Time Manually | Users show it: a big timer is asked for (≈12), one tap (4); the user's own use |
| **Closing it** | ⌄ or a swipe down. The timer keeps running; nothing is lost | Users show it: trapped timer screens (5) |
| **The row** | Keeps its live clock and fill while it runs | Users show it: filling bars help (3) |
| **The bar at the bottom of Today** | Only while a timer runs and its row is out of sight; tapping it opens the timer; ⏸ stops it | Reasoned (Now Playing); a ribbon asked for |
| **Lock Screen and Dynamic Island** | As before when you leave the app, ending the moment the timer stops; now with **Pause** (stops and saves without opening the app) and a tap that opens that habit's timer | Users show it: ≈41 want it, 5 want control, 16 complain about leftovers or drift; the Clock timer |
| **Turning things off** | ≡ → Appearance → Timers: **Open Timer Full Screen** and **Show on Lock Screen** (both on by default); iOS's own Live Activities switch still works | Users show it: 2 want it gone; Apple: give people control |
| **Typing the time instead** | Still there: Log Time Manually on the timer, Add Entry in the Day sheet | 28 Sep: a timer is never the only way |

**Checked:** see `iOS/Docs/Checklists/Timers, Swipes, Time Limits and Fixes — 4 Oct.md` (tests, the speed run, and the
look on the iPhone that's still the user's).
