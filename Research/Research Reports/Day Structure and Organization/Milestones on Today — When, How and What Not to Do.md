Written by Claude (Claude Code), 17 October 2026.

# Milestones on Today — When, How and What Not to Do

**The user's request (17 Oct):** a milestone is a big thing, so Today should celebrate it a little, but not too much.
The person may not be there when it happens, so we need rules for presenting it when they come back, and for when to
show it and when not to. Android first; the logic is the same on the iPhone (`iOS/Habits/Model/Milestones.swift`).

It builds on:
- [Milestones — Marking Progress Without Noise](<Milestones — Marking Progress Without Noise.md>) (30 Sep): a line,
  never a pop-up, confetti or notification;
- [Milestones That Feel Earned — Awards, Not Squares](<Milestones That Feel Earned — Awards, Not Squares.md>) (11
  Oct): the medal, and the record on the habit page;
- the 1.2.9 decision: the milestone goes in the row's subtitle for the rest of the day.

## Answer, in short

**One small moment where the person already is, one record they can always find, and a short note on return when
they weren't there.**

1. **At the tap that reaches it** (a streak, or *in total*):
   - the round button fills as usual, and a short burst of the habit's colour comes from it (0.6 s) with one
     *success* haptic;
   - the subtitle reads *60 days in a row* next to a small medal for the rest of the day;
   - Undo · Note sit under it as after any log.
   - There is no sound by default, nothing to dismiss, and the next tap is never blocked.
2. **Tap the milestone line, and the moment opens if they want it:** a sheet with the medal (it scales in once), *60
   days in a row · Meds · today*, the next milestone (*75 days · 15 to go*) and *See all milestones*. That's where the
   bigger celebration lives: chosen, never pushed.
3. **Reached while away:** a quit habit's time since the last slip, or a log made on the widget or Watch. The next time
   Today opens, one card sits above *How was today?*: *Smoking · 30 days without a slip · Reached Tuesday*, with **See**
   and **✕**. If several were reached, one card lists up to three, then *and 2 more*. It's shown until ✕, or until
   the end of the next day it's seen.
4. **Never:**
   - a pop-up, full screen, confetti over the list, or sound by default;
   - a notification by default;
   - the same milestone shown twice in one run;
   - a celebration for anything restored, imported or merged;
   - guilt on coming back (*you lost your streak*, sad faces).

## What users show

Built on the 30 Sep counts (1,238,784 reviews scanned, samples read by hand):
- **Liking milestones or celebration:** 643 reviews, 4.64★.
- **Asking for them:** 245 reviews.
- **Celebration that annoys, blocks or can't be turned off:** 40 reviews, 2.95★.

A fresh scan (`Milestones on Today Evidence/scan.py`: 233 reviews matched on milestones reached while away and 934 on
how much celebration; the relevant ones were read by hand) adds:

| Theme | Reviews | What they say |
|---|---|---|
| **Too much celebration** | 3 | *"The 'celebrations' are too much"* (Finch, A10#3472, a deal-breaker); an *"option to turn off rewards or milestones"* (A10#26408); the same congratulation repeated (A10#30825) |
| **Subtle is liked** | 2 | *"subtle celebrations that encourage the user"* (A1#53209); confetti only when *everything* is done (A1#544) |
| **Tell me when I wasn't there** (quit and day-count apps) | 4 | *"i would hope for milestone notifications"* (Days Since, A3#68); *"notifications when you reach milestones (like 1 week, 2 weeks, 1 month…)"* (A3#410); *"add notifications & badges when we hit 1 week, 1m, 3m"* (Streaks, A23#1900) |
| **A late log still wants the moment** | 1 | *"I go in the next day but there is no celebration"* (Finch, A10#40462) |
| **No guilt on return** | 1 | *"an image of my bird with big sad eyes"* (A10#37044) |

`verify.py` checks all 11 quotes (0 mismatches; 20 with the section added below). The counts are directional.

## The rules

| | Rule | Why |
|---|---|---|
| **When: by a tap** | At the tap that reaches it, on that row. Streaks (by days, times, weeks, months or years) and *in total*. Undo takes the milestone back too. Everything done for today stays the day bar's, with no burst (Today 1.8: nothing celebrates, nothing moves) | Words where the eye already is (30 Sep). The tap is the moment |
| **When: late logging** | Logging a past day that completes a milestone shows it on that row, on that day's view, the same way | A10#40462 |
| **When: while away** | Quit habits' time since the last slip, and anything logged on the widget, Watch or a notification, appears **once** on the next Today, in one card | People ask to be told (4), and never as guilt |
| **How much** | One burst of the habit's colour from the round button (0.6 s), one haptic, a medal beside the words. No sound unless the person turns sounds on | Subtle is liked; *too much* is a deal-breaker |
| **The bigger moment** | Only when asked for: tapping the line or the card's See opens a sheet where the medal scales in once | Earned without being pushed (11 Oct awards report) |
| **How long** | Row: the rest of the day (1.2.9). Card: until ✕, or the end of the next day it was seen. Habit page: forever | It can't be missed, and it doesn't linger |
| **Once** | A milestone is shown once per run. A new run reaching 7 again is marked again, as a new run | No repeated congratulations (A10#30825) |
| **Several at once** | One burst per visit (below). A tap reaching two (a streak and *in total*) shows the bigger one; the sheet shows both | No queue of animations (*"multiple animations back-to-back"*, 30 Sep) |
| **Old ones** | Reached more than 7 days ago while away: no card, only the record on the habit page | Coming back after weeks shouldn't open with a list |
| **Never celebrated** | Anything restored from a backup, imported, moved from another phone or merged by sync from data made before | It wasn't a moment the person had |
| **Settings** | Streak milestones follow *Show streaks*. A *Milestones* switch (on) can hide the moment, never the record | An option to turn it off (A10#26408) |
| **Notifications** | None by default. Proposed and waiting for the user: an opt-in *Tell me at milestones* for quit habits | Quit apps' users ask (4); notifications as nags are a guilt mechanic (C157) |
| **Words** | Plain and adult: *30 days without a slip*, *60 days in a row*, *Goal met 25 times*. No *Amazing!*, mascots or exclamation marks | C095; childish is a complaint |

## Added the same day: several habits reach a milestone

**The user's question (17 Oct):** *"when multiple habits reach the same milestone, then what? Showing the celebration for
each would also be very annoying."*

**Answer: one burst per visit. Every other milestone is quiet: true words and a medal, nothing more.**

**What users show.** `scan_repeats.py` read every App Store and Play Store review where a celebration, animation or
pop-up sits near "every time", "each", "multiple", "back to back" and the like. It found 484 matches; the 283 that read
as complaints or multiples were read by hand, and 9 quotes are verified.

- **A celebration on every item is one of the clearest complaints** (17 reviews, 7 of them quoted). Examples:
  - *"if you've just habit stacked and want to check off 4 habits you're just sitting there waiting"* (A16#29);
  - *"way way way too much celebration for EVERY TASK"* (P12#7953);
  - *"I don't need a congratulations every time I tick off a task"* (A24#30124);
  - *"too many animations and pop-ups every time I renew my streak"* (P4#6495).
- **Small, instant feedback on every tap is liked** (2): *"the almost visceral satisfaction of checking off each habit
  because of the combination of graphic change and sound"* (A55#1878).

What people mind is a big moment repeated, or one they have to wait through, not the tap's own fill.

| Case | What happens |
|---|---|
| **Two or more habits in one visit** (opening Today until the app leaves the screen) | The first milestone gets the burst and the haptic. Every later one in that visit is quiet: the row fills as any log does, and the medal and words go in its subtitle (MS.1.2). |
| **The same milestone on several habits** (habits started together reach 30 days on the same day) | Each row says it, because it's true for each, but there is only one burst. While away, they share **one line** with their medals side by side: *30 days in a row · Meds, Stretch and Read* (MS.4.4). |
| **A routine** (the player) | No burst on any step: the step's page says it in words. The end of the routine lists what was reached, once (*Reached in this routine*, MS.7). |
| **One tap reaching two** (a streak and *in total*) | The bigger one shows on the row; the sheet shows both (MS.2). |
| **The day's last habit** | Everything done for today stays the day bar's, with no burst (Today 1.8). A milestone reached by that same tap is the visit's burst only if none came before. |

**Why the first and not the biggest:** people expect the same thing every time (predictability). A rule that saves the
burst for a bigger milestone later in the visit would leave the first one looking unfinished, and can't know what comes
next. If a year (365 days) lands later in a visit, it's still in words, in the medal, and in its sheet: the record
never shrinks, only the motion. This choice is reasoned from first principles; no review compares the two.

## Second follow-up, the same day: show it up front, without piling up (proposed, waiting for the user)

**The user's points (17 Oct):**
- A line in the row doesn't feel like anything: *"the whole point of the milestone is to showcase that milestone, not
  to hide it"*. Showing it up front, in a sheet with a close button, *"makes them feel good"*.
- The ✓ filling is good and stays.
- But a new person adds five habits on the same day and reaches *3 days in a row* on all five together. A sheet for
  the first is fine and for the second maybe, but by the third, people get annoyed. The same holds for everyday users.

This section looks at **when and how often** the sheet shows. The sheet's own design is out of scope for now.

### What users show

`scan_showing.py` read every App Store and Play Store review about a milestone shown up front, a milestone earned
again, and early wins (51, 46 and 279 matches, read by hand); 15 more quotes are verified (32 in all, 0 mismatches).

| Theme | Reviews | What they say |
|---|---|---|
| **An early congratulation lands with new people** | 4 | *"Easy success with a congratulations, which of course gives you inspiration to build on"* (3 days, A24#42472); *"when i made a one-week streak … the app congratulated me and built more excitement"* (P24#3675); *"when I saw the celebration part. I just had to have it"* (a first-day user, A1#54885) |
| **People want more than a quiet record** | 2 | *"it'd be much more rewarding if there were 'congratulations' or something to show off when you hit milestones"* (A3#3120); *"celebrate long streaks"* (A53#713) |
| **A medal for a new personal best is loved** (Hevy, a gym app) | 2 | *"Every time a pr is hit, you recieve a little medal which is very rewarding"* (P122#7594) |
| **A summary after the session is loved** (Hevy) | 2 | *"the summaries and celebratory analytics after finishing a workout are super encouraging"* (P122#18737) |
| **The same thing on every opening is disliked** | 2 | a streak *"pop-up EVERY morning when I open the app"* (A13#12473); *"a 10 second animation every morning"* (P12#9299) |
| **One on every item is hated** (first follow-up) | 17 | *"way way way too much celebration for EVERY TASK"* (P12#7953) |
| **The same congratulation again** | 1 | *"congratulations on your FIRST milestone, but I've got it like 10 times already"* (A10#30825) |

**Other apps (checked, not copied):**
- **Duolingo** shows its streak screen once, after the lesson ends, with a bigger animation on milestone days. It
  reports that the animation raised the chance a brand-new learner was still active 7 days later by 1.7%
  ([Duolingo blog](https://blog.duolingo.com/streak-milestone-design-animation)).
- **Hevy** gathers a workout's new personal records on the screen after Finish, never one at a time during the workout
  ([Hevy](https://www.hevyapp.com/features/workout-log/)). Its reviews above say people like both.
- **Material Design** calls dialogs *"purposefully interruptive"*, to be used sparingly
  ([Material 2](https://m2.material.io/components/dialogs)).

So you're right: people want to *see* the milestone, and new people most of all. What goes wrong is the same moment
over and over, or one that interrupts a run of taps.

### How often it would show

`simulate_pileups.py` runs the app's real ladders (3, 7, 10, 14, 30 … days; 10, 25, 50 … in total) over simulated
people, 2,000 runs each:

| Person | A sheet for **every** milestone reached | Only the **first time** a habit reaches each length (a new best) |
|---|---|---|
| New: 5 daily habits added the same day, done 90% of days in week 1 and 80% after; 90 days | 90 milestones, on **58 of 90 days**; 2+ on 24 days, 3+ on 7 | 31, on **21 days**; 2+ on 6, 3+ on 2 |
| Established: 8 habits added over 6 months, done 85% of days; a year | 438, on **225 days**; 2+ on 134, 3+ on 56 | 66, on **43 days**; 2+ on 14, 3+ on 5 |
| Very consistent: the same, done 95%; a year | 364, on 202 days | 78, on 42 days; 2+ on 15, 3+ on 8 |

Two things the counts show:

1. **Most milestones are the same small ones reached again.** Every time a streak breaks, *3 days* and *7 days* come
   round again. A sheet for each would show on two days out of three, all year, which is the "every time" complaint.
   Counting only a habit's new bests cuts it by about **six times**, to about one day in eight or nine.
2. **Pile-ups are real but bunched.** For the new person, the days with three or more are day 3 and day 7, when
   habits added together reach the same length together. For everyone else, about 5–8 days a year.

A daily habit that's never missed reaches *10 / 50 / 100 / 250 times in total* on the same day as the same number
*in a row*. Two moments for one tap would be one too many.

### The proposal

| Rule | What happens | Why |
|---|---|---|
| **1. The ✓ and the row, always** | The tap fills the ✓ as today. The row's subtitle says *60 days in a row* with the medal, for every milestone, new or again | The user likes the ✓; the words are true every time |
| **2. A sheet up front, for new heights** | The sheet opens by itself the first time a habit reaches a length (a new best), and for every *in total* milestone. A length reached again after a break (*7 days in a row* for the fourth time) stays on the row, with no sheet | Hevy's medal for a new best is loved; the same congratulation again is a complaint; this cuts the sheets by about six times |
| **3. Wait for the taps to stop** | The sheet never opens between taps. It waits until the person stops logging (a few seconds with no new log, to be tuned on a phone), then shows everything reached in that run at once | Duolingo and Hevy celebrate after the session; dialogs are interruptive; *"sitting there waiting"* between habits is the complaint |
| **4. One sheet, grouped** | Several milestones make **one sheet**. The same length on several habits is **one line** with their medals side by side: *3 days in a row · Meds, Stretch, Read, Water and Journal*. When it's every habit the person has, it says so: *All 5 habits, 3 days in a row*. Different milestones are listed under it | The new person's day 3 becomes one strong moment instead of five weak ones |
| **5. One sheet per visit** | Once a sheet has been closed, anything else reached in the same visit (until the app leaves the screen) stays on its row. A later visit, such as the evening, can show one again | The first is welcome, the second maybe, the third annoys (the user); new bests fall on only about 43 days a year anyway |
| **6. Never on opening** | A milestone reached while away (a quit habit's days, a widget or watch log) is the card on Today, with **See** to open the sheet, never a sheet that opens by itself when the app starts. A sheet still waiting when the person leaves the app becomes that card | A pop-up *"EVERY morning when I open the app"* is disliked |
| **7. One tap, one moment** | A tap that reaches a streak and an *in total* milestone together shows the streak (*10 days in a row*), with the total inside the sheet | Two moments for one tap |
| **8. Undo** | Undoing the log that reached it takes it out of the waiting sheet. If the sheet has already shown, the record goes with the log | No milestone for something not done |

**What this changes from the earlier sections** (only once the user agrees):
- The automatic sheet replaces "the bigger moment only when asked for".
- Rule 2 replaces "once per run", which marked a length again after every break.
- Rules 3 and 5 replace "one burst per visit".

**What it keeps:**
- no confetti over the list, no sound by default and no notification by default;
- the card for milestones reached while away;
- the same milestone on several habits grouped as one line;
- the routine's end listing its milestones.

**What a new person sees in the first week** (5 habits, all done):
- **Day 3:** one sheet after the last tap, *All 5 habits, 3 days in a row*.
- **Day 7:** one sheet, *All 5 habits, 7 days in a row*.
- **Days 10 and 14:** the same again.
- **Every other day:** the ✓, nothing more.

If one habit falls behind and catches up later, its own new best gets its own sheet on that day.

## Limits

- The new counts are small; the 30 Sep counts carry most of the weight.
- The burst and the medal scale-in are reasoned, not tested. Check the feel on a phone (U9).
- The simulation assumes daily habits and steady odds; real people vary more, so read its counts as orders of size.
- "A few seconds with no new log" needs tuning on a phone: too short and the sheet lands between taps, too long and the moment is lost.
