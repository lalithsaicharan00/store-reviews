# Routinery: the Routine Player, What Helps and What Users Dislike

Written by Claude (Claude Code), 28 November 2026, at the user's request.

**What this is.** What Routinery's store reviews say about its **routine player**, the full-screen view that runs a
routine one step at a time with a timer on each step. It covers what genuinely helps people and what they dislike,
with numbers, and **why** in each case. There are 27 findings: 9 that help and 18 that hurt.

**How it was done.** From Routinery's labels alone, as research for a new product or a full rebuild. I took every
`liked`, `chose_for` and `problems` label about running a routine and read them. Problem themes are hand-made lists of
reviews, built by reading every candidate label. Help themes are word patterns over `liked` and `chose_for`, with
every false match I found by reading taken out (for example "pause" in "pause and breathe", or "over time" meaning
"gradually"). The watch themes are patterns over `problems`, read in samples. Everything is in
[`Tools/player_themes.py`](<Tools/player_themes.py>), and [`Tools/player_themes.json`](<Tools/player_themes.json>)
lists every review behind every number.

**Source.** The checked labels for all **9,644 Routinery reviews** (App Store and Google Play, April 2019 to 7
September 2026) in `Review Labels/Routinery/<YEAR>/labels.jsonl`. Each label was made by reading one review in its own
language, and carries an exact quote. Quotes below are people's own words, with a translation where needed. Review
IDs are shortened to their first 8 characters (App Store IDs are numbers and are given in full). "Votes" are the
review's helpful votes on the store.

**How to read the numbers.** Each count is **distinct reviews**, with the reviews' average star rating. Treat counts
as minimums: a review only counts if it clearly names the thing. Counts under about 10 are weak signals.

---

## The short answer

- **615 reviews (6.4%) praise something in the player, averaging 4.71★.** **566 (5.9%) complain about the phone
  player, averaging 3.72★**, or 657 at 3.64★ counting watch problems during a run.
- **People love being told what to do next and when they'll finish.** A countdown on each step (325 reviews) and
  seeing one step at a time (97) are the top two helps. Seeing how long each step really took is the best rated
  (4.89★).
- **They leave when a run is lost, the phone runs hot, or a tap can't be taken back.** The lowest-rated themes are a
  lost or reset run (2.56★), battery drain (2.97★), and bugs during a run (about 3.3★).
- **Guidance with ways out works; anything rigid draws complaints.** Being guided step by step is loved, but only
  alongside skip, pause, add time, "come back later" and no guilt. Complaints come from the rigid parts: a timer you
  can't turn off, a fixed order, a skip that's final, no undo.
- **The voice is both a top help and a top complaint.** It is loved hands-free (65 reviews) and disliked as robotic,
  loud or impossible to silence (42).

| # | Finding | Reviews | ★ |
|---|---|---|---|
| **Helps** | | | |
| 1 | A countdown for each step | 325 | 4.71 |
| 2 | One step at a time, so there's nothing to decide | 97 | 4.68 |
| 3 | A voice reads out the step that's ending and the next one | 65 | 4.54 |
| 4 | A live finish time | 58 | 4.74 |
| 5 | Skip a step | 56 | 4.73 |
| 6 | Seeing how long each step really took | 56 | **4.89** |
| 7 | Pause | 46 | 4.67 |
| 8 | Kind, no-guilt wording | 29 | 4.83 |
| 9 | Smaller helps (add time, overtime, auto-advance, reorder…) | 5–21 each | 4.6–5.0 |
| **Dislikes: tapping and control** | | | |
| 10 | A mistaken Done, Skip or swipe can't be undone | 32 | 4.06 |
| 11 | Buttons placed where they get hit by mistake | 9 | 3.89 |
| 12 | A skipped step is gone for good; steps must be done in order | 33 | 4.06 |
| 13 | Can't change the routine while it's running | 28 | 4.11 |
| 14 | Can't do two things at once | 9 | 4.00 |
| 15 | No breathing room between steps | 6 | 4.00 |
| **Dislikes: the timer itself** | | | |
| 16 | The timer is required; they want plain tick-off steps | 36 | 3.78 |
| 17 | The timer causes stress | 17 | 3.65 |
| **Dislikes: alerts and voice** | | | |
| 18 | No alert, or an unreliable one, when a step's time is up | 56 | 3.59 |
| 19 | A robotic, loud or unwanted voice | 42 | 3.81 |
| 20 | Nagging alerts | 15 | 3.40 |
| 21 | Can't control the alert sound | 12 | 3.75 |
| 22 | It stops their music or podcast | 11 | 3.73 |
| **Dislikes: seeing the run outside the app** | | | |
| 23 | Can't see the running step outside the app | 37 | 4.35 |
| **Dislikes: reliability** | | | |
| 24 | A running routine is lost, reset or ends by itself | 25 | **2.56** |
| 25 | Battery drain and heat | 70 | 2.97 |
| 26 | Other bugs during a run | 7–20 each | 3.1–4.0 |
| 27 | Running a routine on a watch | 111 | 3.19 |

---

## Part 1: What genuinely helps

### 1. A countdown for each step: 325 reviews, 4.71★

The single most praised thing in the player. **What it is:** every step in a running routine has its own countdown.

**Why it helps:**
- The time limit gets people moving and stops dawdling.
- Several people with ADHD say a list alone never worked, but a list with a clock running does.
- Some expected the timer to be stressful and found it calming instead.

Examples: `88825831` (65 votes), `cde808b4` (43 votes), `da04d948` (34 votes). Theme `timer`.

### 2. One step at a time, so there's nothing to decide: 97 reviews, 4.68★

**What it is:** once a routine starts, the player shows only the current step and walks the person from one step to
the next.

**Why it helps:**
- They press start and the app tells them what to do next: no remembering, no deciding.
- Seeing the whole list felt overwhelming; seeing only the current step removes that.

> "As a person with ADHD this is the single most helpful app I have ever tried. The netflix-style automation to the
> next task is what really makes it work for me. No time to get distracted or experience decision overload" (`4bcc9756`, 39 votes)

Examples: `da04d948` (34 votes), `12d906e9` (27 votes), `08205e79`. Theme `guided`.

### 3. A voice reads out the step that's ending and the next one: 65 reviews, 4.54★

**What it is:** a spoken announcement when a step ends, naming the next step. A one-minute warning before a step ends
is also liked.

**Why it helps:**
- They can follow the routine without looking at or holding the phone (7 reviews say exactly this; theme
  `hands_free`).
- The voice pulls them back after they drift off.

The voice is also one of the top complaints (finding 19), so the same feature helps some people and drives others
away.

Examples: `ac038f92` (37 votes), `9655374699` (27 votes), `a65e89ce` (21 votes). Theme `voice`.

### 4. A live finish time: 58 reviews, 4.74★

**What it is:** the player shows when the whole routine will finish ("all ends by"), and updates it as each step runs
long or finishes early.

**Why it helps:**
- It works like a car's arrival time: if a step runs long, the finish time moves later, so they always know whether
  they'll be late.
- They can hurry, or drop a step, before it's too late.

9 more reviews want more of it (theme `eta_wants_more`), such as the total time left.

Examples: `a437f65c` (24 votes), `f24c7634` (23 votes), `cb4afd9e` (20 votes). Theme `eta`.

### 5. Skip a step: 56 reviews, 4.73★

**What it is:** a Skip control on the current step.

**Why it helps:**
- Real mornings don't go to plan. Being able to skip keeps people using the routine instead of abandoning it for the
  day.
- Skipping without being punished matters (finding 8).

What people dislike is that a skipped step is gone for good (finding 12): they want "skip for now, come back at the
end".

Examples: `bffd69e3` (41 votes), `6e1f227e` (30 votes), `91c188ec` (29 votes). Theme `skip`.

### 6. Seeing how long each step really took: 56 reviews, 4.89★

**The highest rating of any theme.** **What it is:** the app records the real time each step took (including paused
time) and shows it during or after the run.

**Why it helps:**
- People learn their real times ("I wasn't giving myself enough time") and fix their routine.
- Their sense of time gets better outside the app too.

Related asks: show paused time on the summary page (`514b6c5f`, 37 votes); 7 more reviews ask to keep the end-of-run
summary so they can look at it again later (theme `end_screen`).

Examples: `514b6c5f` (37 votes), `c03bda07` (34 votes), `02f9a984` (31 votes). Theme `records`.

### 7. Pause: 46 reviews, 4.67★

**What it is:** pause the current step and resume later without losing progress.

**Why it helps:**
- Children, phone calls and interruptions happen; pausing keeps progress instead of throwing it away.
- Some like that paused time is counted separately.

Two things go wrong around it: when paused, the big button becomes Complete or Next instead of Resume (finding 11),
and reminders while paused can come every minute (finding 20).

Examples: `7be9312c` (51 votes), `bffd69e3` (41 votes), `514b6c5f` (37 votes). Theme `pause`.

### 8. Kind, no-guilt wording: 29 reviews, 4.83★

**What it is:** nothing penalises running over or skipping. An overtime message says it's still okay. Pausing or adding
time doesn't feel like failing.

**Why it helps:**
- Reviewers say this kindness is why they keep using the app; shame makes them avoid routines.
- The opposite hurts: a "still waiting :)" reminder while paused was called passive-aggressive (finding 20), and one
  reviewer asks to drop the red colour on overtime (finding 17).

Examples: `6a348e54` (43 votes), `3446e9ae` (43 votes), `96db7d4c` (30 votes). Theme `kind_tone`.

### 9. Smaller helps

Smaller themes; counts under about 10 are weak signals.

| Help | Reviews | ★ | Why |
|---|---|---|---|
| Add time to the current step | 21 | 4.71 | A step ran long; adding a few minutes keeps the routine going without guilt |
| Overtime keeps counting after zero | 20 | 4.80 | Shows how long the step really took and whether they'll be late |
| Optional auto-advance to the next step | 20 | 4.85 | No gap to get distracted in ("netflix-style", `4bcc9756`, 39 votes) |
| …or that it's a per-step choice, or doesn't move on by itself | 5 | 5.00 | Some steps need a person to say they're done |
| Reorder steps during the run | 17 | 4.76 | Some days need a different order |
| Reminders while paused | 15 | 4.73 | A gentle nudge back after an interruption (but see finding 20) |
| A chime or alert when time's up | 13 | 4.77 | They know to move on without watching the screen |
| Visual timer | 12 | 4.67 | Time passing is visible at a glance |
| White noise during steps | 12 | 4.58 | Helps focus and winding down |
| Praise or a time recap at the end | 8 | 4.88 | A "well done" feels like being praised for getting through it |
| Lock screen or Dynamic Island | 2 | 5.00 | Seeing the step without opening the app (most say it's missing: finding 23) |

Themes `add_time`, `overtime`, `auto_next`, `manual_next_choice`, `reorder_mid`, `pause_reminder`, `time_up_cue`,
`visual_timer`, `white_noise`, `end_praise`, `lock_island`.

---

## Part 2: What users dislike

### Tapping and control

#### 10. A mistaken Done, Skip or swipe can't be undone: 32 reviews, 4.06★

Seen every year from 2020 to 2026. **What it is:** a stray tap (often while walking around) marks a step Done, skips
it, or a swipe ends it, and there's no way back.

**Why it hurts:** getting back means restarting the whole routine, and the time recorded for that step is now wrong.

> "Not misclick friendly. Whenever I'm walking around my house I accidentally press "done" So I can't re do that
> habit." (`12069182383`)

Examples: `9691e9eb` (19 votes), `00810516` (13 votes), `5432864399`. Theme `undo`.

#### 11. Buttons placed where they get hit by mistake: 9 reviews, 3.89★

A small count, but specific and repeated. **What it is:**
- Done sits right next to Pause, so people hit Done when they meant Pause or Play.
- When paused, the big middle button becomes Complete or Next instead of Resume.
- The play icon looks like a next icon.

**Why it hurts:** the most common action after a pause is Resume, but the layout invites the one tap that can't be
undone (finding 10). One person asks for a bigger Resume button, or to tap anywhere to resume (`e33ffa7a`).

Examples: `514b6c5f` (37 votes), `e33ffa7a` (14 votes), `5e719aa3`, `5432864399`. Theme `button_placement`.

#### 12. A skipped step is gone for good, and steps must be done in order: 33 reviews, 4.06★

23 of the 33 are from 2020–21, before Routinery added "move to end". **What it is:** once skipped, a step can't be
brought back, checked off later, or moved to the end; steps can only be done in the set order.

**Why it hurts:**
- People want to skip "for now" and come back at the end.
- The top-voted review here skipped make-up on impulse, changed their mind a minute later, and couldn't get the step
  back (`ba5e72ed`, 104 votes, in French: *"c'est dommage de ne pas pouvoir revenir en arrière une fois que avoir passer
  une étape"*, "it's a shame you can't go back once you've passed a step").
- A step done later, out of order, still counts as skipped.

3 more reviews can't find a Skip button at all, only Pause and Done (theme `no_skip_button`).

Examples: `ba5e72ed` (104 votes), `273e3c74` (35 votes), `d2f22a01` (13 votes). Theme `skipped_gone_order`.

#### 13. Can't change the routine while it's running: 28 reviews, 4.11★

17 of the 28 are from 2020–21; reordering during a run was praised later (finding 9). **What it is:** while a routine
runs, people can't reorder steps, add a step, or change a step's time (for this run or for good). Updates took some of
this away: in 2022 one reviewer lost the quick +1/+5/+10 minute buttons (`85a1ae2e`), and in 2024 another lost moving
tasks and changing an upcoming step's time, and dropped from 5 stars:

> "I'm very disappointed with the most recent update. They removed features that let you adapt to current
> circumstances while a routine was in progress" (`8a721672`)

**Why it hurts:** some days need a different order. One person swaps steps in their head and still taps Done in
sequence (`9d57f40d`, 31 votes, in German).

6 more reviews want to read or add step notes during the run, not only after it (theme `notes_mid_run`).

Examples: `98ba99fa` (50 votes), `9d57f40d` (31 votes), `5bf51d5f` (30 votes). Theme `edit_mid_run`.

#### 14. Can't do two things at once: 9 reviews, 4.0★

**What it is:** the player runs one thing at a time. Two wishes come up:
- Two steps at once inside one routine ("the ability to multitask", `fe93abb1`; one person wants timed screen time
  running while doing chores, `7806175559`).
- Two routines side by side, or leaving a running routine to start another; today a routine has to be finished or
  reset first (`4a947197`, in Korean).

**Why it hurts:** real routines overlap, and other people don't follow the same order (a 7-year-old joining a parent's
routine "messed up my sequence", `bc79b387`). People work around it by writing several habits into one step.

Examples: `fe93abb1`, `bc79b387`, `82cd0403`, `fc85df9f`. Theme `parallel`.

#### 15. No breathing room between steps: 6 reviews, 4.0★

**What it is:** when a step ends, the next starts at once. People ask for a short transition (30 seconds to 2 minutes)
to get from one task to the next.

**Why it hurts:**
- Moving between tasks takes real time, so the next step's clock is already running down.
- A reviewer with ADHD says switching is the hard part: it "stresses me out having the time run out and immediately
  going to something else with no transition time" (`13714159491`).
- A designer deleted the app after two weeks because switching felt "forced and choppy" (`7174563257`).
- Without transition time the finish time keeps slipping by a few minutes, which is its own stress (`7294333740`, in
  Korean).

Examples: `971415d6`, `7174563257`, `13714159491`, `7294333740`. Theme `no_breathing_room`.

### The timer itself

#### 16. The timer is required; they want plain tick-off steps: 36 reviews, 3.78★

**What it is:** every step must have a timer. People want steps they can simply tick off, with no clock.

> "an option which lets you run through the routine without having a timer on everything but just press next"
> (`11972917376`)

**Why it hurts:** some steps don't have a sensible length, and a clock on them makes the routine feel rigid. Most of
these reviewers like the app and ask for a choice, rather than leaving.

Examples: `3e02fac5`, `17297b1b`, `81540359`. Theme `timer_forced`.

#### 17. The timer causes stress: 17 reviews, 3.65★

**What it is:** the countdown that helps most people (finding 1) makes some people race the clock, and overtime can
feel punitive.

> "The timer stresses me out so much" (`13127830013`)
> "The timers create pressure instead of structure" (`13373809432`)
> *"se ponen en rojo y me estresa"*, "they turn red and it stresses me" (`8839466844`, in Spanish)

**Why it hurts:** a routine meant to calm the morning turns into a test. One reviewer asks to drop the red colour on
overtime (`81ca585c`). 3 more ask to hide the numbers or the overtime display (theme `hide_numbers`).

Examples: `194d970f`, `b3c1a9c5`, `9677875961`. Theme `timer_stress`.

### Alerts and voice

#### 18. No alert, or an unreliable one, when a step's time is up: 56 reviews, 3.59★

45 of the 56 are from Google Play, which points to Android's background limits. **What it is:** when a step's time
runs out there's no sound or vibration, or it only comes sometimes.

**Why it hurts:** people put the phone down to do the step. Without the alert the step runs over, or moves on, without
them knowing, and the routine's timing falls apart.

Examples: `6a5b871e` (35 votes), `810b5737` (24 votes), `c325d70f` (19 votes). Theme `no_time_up_alert`.

#### 19. A robotic, loud or unwanted voice: 42 reviews, 3.81★

16 of the 42 are from 2023, after a voice change. **What it is:** the voice that reads steps (finding 3) sounds robotic
or too loud, or speaks when they don't want it to.

> "you cannot turn off that god awful voice when the task timer is over" (`13127830013`)

**Why it hurts:**
- 16 reviews can't turn it off, or it speaks anyway: phone on silent, volume down, a partner still asleep (theme
  `voice_cant_off`).
- 15 want more voice choices (theme `voice_wants`).
- 11 say the voice broke: stopped speaking or glitched (theme `voice_broken`).

Examples: `3d4b18ef` (28 votes), `be4c5439` (19 votes), `11188300937`. Theme `voice_dislike`.

#### 20. Nagging alerts: 15 reviews, 3.4★

**What it is:** while a routine is paused or over time, the app sends alerts as often as every minute.

> "the notifications are really passive aggressive … telling me it'd been a few minutes and it was "still waiting :)""
> (`6727944992`)
> "Routines are timed, which would be more motivating if you could pause without getting 5 texts in 5 minutes. No
> setting to turn this function off either, so I never use it." (`be853b23`)

**Why it hurts:** it reads as nagging, and nagging leads people to avoid the routine. A gentle pause reminder is liked
by others (finding 9), so the problem is frequency and tone, not the reminder itself.

Examples: `6727944992`, `be853b23`, `13714159491`. Theme `nagging_alerts`.

#### 21. Can't control the alert sound: 12 reviews, 3.75★

**What it is:** people can't choose how the step alert sounds. They ask for a plain tone instead of the voice, their
own sounds, and no double vibration.

**Why it hurts:** the alert plays many times in every routine, so a sound they dislike, or one that doesn't suit where
they are, wears on them every day.

Examples: `21d53eb0`, `498be657`. Theme `alert_sound_control`.

#### 22. It stops their music or podcast: 11 reviews, 3.73★

**What it is:** running a routine, or its alerts and voice, stops or interrupts the music or podcast they were
listening to.

**Why it hurts:** many people do their routine with audio on, and losing it at every step makes them choose between
the app and their music. Another 11 reviews want to play their own music during a routine (theme `wants_music`).

Examples: `ebd77d40`, `79742061`, `98ba99fa`. Theme `stops_music`.

### Seeing the run outside the app

#### 23. Can't see the running step outside the app: 37 reviews, 4.35★

Mostly happy users asking for it. **What it is:** no way to see the current step and its countdown without opening the
app: on the lock screen, as a Live Activity or in the Dynamic Island, as a fixed notification or a floating timer.

**Why it hurts:** people leave the app during a step (to read, message or check something) and lose track of time.
Another 24 reviews (3.46★) say it exists but is broken: the wrong time, it doesn't move to the next step, buttons that
don't work (theme `outside_app_broken`).

Examples: `99617b3b` (68 votes), `4a597709` (19 votes), `0970d292`. Theme `outside_app_missing`.

### Reliability

#### 24. A running routine is lost, reset or ends by itself: 25 reviews, 2.56★

**The lowest rating of any player theme.** **What it is:** a routine in progress disappears, starts over, or ends on its
own. The causes people name: switching to another app, the screen turning off, tapping a notification.

**Why it hurts:** the run, its progress and its timings are gone partway through the morning. It breaks trust in the
one thing the player has to do.

Examples: `ad8e1b17`, `8ca0edf5`, `5a338414`. Theme `run_lost`.

#### 25. Battery drain and heat: 70 reviews, 2.97★

16 tie it directly to the running timer (2.50★, theme `battery_while_running`). It peaked in 2023 (26 reviews).
**What it is:** the app drains the battery and heats the phone, especially while a routine runs.

**Why it hurts:** routines can run for an hour or more, and a phone that loses much of its charge before the day
starts is a reason to stop using the app. One reviewer, otherwise a big fan, says "Battery is drained unreasonably fast
when the timer is running" and lost 30–40% in a 2-hour routine (`11188300937`).

Theme `battery`.

#### 26. Other bugs during a run

| Bug | Reviews | ★ | Example |
|---|---|---|---|
| Taps don't register or the screen freezes | 20 | 3.35 | |
| Auto-advance doesn't move on, or skips an extra step | 20 | 3.35 | `963e9573` (51 votes) |
| The live finish time is wrong | 20 | 3.40 | 14 came from one 2025 timer update, fixed after people contacted support (`ab9c6988`) |
| The timer stops, or keeps running when it shouldn't | 19 | 3.32 | `c6d7d584` (33 votes) |
| Skip marks the wrong steps | 10 | 3.10 | |
| The routine opens on its last step | 7 | 4.00 | all App Store |

**Why it hurts:** each one breaks the player's basic promise, the right step with the right time, and people notice at
the busiest moment of their day.

Themes `taps_freeze`, `autonext_broken`, `eta_wrong`, `timer_state_wrong`, `skip_bugs`, `starts_last_step`.

#### 27. Running a routine on a watch: 111 reviews, 3.19★

73 of the 111 are from the App Store (Apple Watch). **What it is:** problems running a routine from a smartwatch: the
watch app gets stuck, a routine started on the watch ends on its own, auto-advance stops, timers and finished steps
don't sync between watch and phone, overlapping alerts.

**Why it hurts:** people use the watch so they can leave the phone behind. When the watch shows the wrong step or time,
the phone ends up back in their hand.

Another 68 reviews (4.56★) simply ask for a watch app, or for more on it (theme `watch_wanted`). Both watch themes are
word patterns over `problems` and were checked in samples, not read one by one like the phone themes.

Examples: `12442067714`, `8483895502`, `11819860723`. Theme `watch_running`.

---

## The patterns behind it

- **Guidance with ways out works.** Being guided step by step is loved (findings 1, 2, 4), but only alongside skip,
  pause, add time, "come back later" and no guilt (5, 7, 8, 9). Every rigid part draws complaints: a required timer
  (16), a fixed order and a final skip (12), no edits mid-run (13), no undo (10).
- **The same feature helps one group and hurts another.** The countdown is the top help (325) and a source of stress
  (17); the voice is loved (65) and disliked (42); reminders while paused are liked (15) and called nagging (15). In
  each case people ask for a choice, not for removal.
- **Sound needs a choice of voice, tone or vibration**, and a real off switch (19, 21, 22).
- **The worst ratings come from losing trust in a run,** not from missing features: lost runs (2.56★), battery
  (2.97★), bugs during a run (about 3.3★), the watch (3.19★).
- **Mistaken taps are a layout problem first.** Done next to Pause, and Complete in Resume's place when paused (11),
  feed the undo complaints (10).

## Limits

- **Counts are minimums.** A review counts only if its label clearly names the thing; most reviews talk about the app
  as a whole.
- **Help themes are patterns**, cleaned by reading, so a few true helps worded unusually are missed. **Problem themes
  were read one by one**, apart from the watch themes, which were checked in samples.
- **Small themes are weak signals** (under about 10 reviews: findings 11, 14, 15 and several rows of 9 and 26).
- **Themes overlap.** One review can be in several themes, so the counts don't add up to the totals.
- **Store mix matters.** Some themes lean heavily on one store (finding 18: 45 of 56 Google Play; finding 27: 73 of
  111 App Store), so they may describe one platform's player more than the other's.
- **Time matters.** Some complaints were fixed (finding 12 mostly before "move to end"; the 2025 finish-time bug in
  26), and others were caused by updates (13, 19).

## Appendix: every review behind every theme

Generated by `python3 -I Tools/player_themes.py appendix`. App Store IDs are shown in full.

| Side | Theme | Reviews | Review IDs (first 8 characters) |
|---|---|---|---|
| Dislike | `alert_sound_control` | 12 | 10191779042 11917606165 21d53eb0 29cf670f 498be657 5fbe93a1 9554803d b96b7728 c48a446a d469ad41 effc50a0 fda8ae2f |
| Dislike | `autonext_broken` | 20 | 07a387bf 09eb441a 10584591004 12397332591 12825861477 12f92e06 13259002296 13727332123 14191150102 24b5d083 3c165726 3d2935cb 66b64fe0 6a5b871e 7872735468 8765909690 963e9573 9861014690 d7ac46d9 dafcf1f2 |
| Dislike | `autonext_dislike` | 2 | 11233772767 7079196017 |
| Dislike | `battery` | 70 | 10062211570 10098317714 10135282986 10239716747 10256362801 10312334582 10317575337 104c9e5d 10542119017 10666322625 11125731785 11182114701 11188300937 11229354705 11515721909 11522558139 11695995725 12275536848 12737168935 12845278815 13091482216 13101387144 13195777384 13202769449 13219319750 13249089782 13323018578 13362713060 13376641175 13520796132 14073080620 14305701584 14305759207 14491246957 14493761177 15e15852 194d970f 2582006a 2a89a44e 3067dffe 31497d1c 4c4beb1e 7538451918 8447625826 8547905253 8676407171 8687747703 9064153061 92f3fa19 9472051623 9502486128 9529433434 9665650591 9691e9eb 9693496853 9759386345 9764474844 9842275773 98bc807b 9940458838 9958518584 9984000312 9d905c9b c0678f27 cea2de07 d086aaef e9a29ee1 f69e8cfd f6a0141a fad193e1 |
| Dislike | `battery_while_running` | 16 | 10317575337 11125731785 11188300937 11229354705 11515721909 12737168935 13323018578 13376641175 2582006a 3067dffe 4c4beb1e 7538451918 9064153061 9502486128 9759386345 9958518584 |
| Dislike | `button_placement` | 9 | 07a3077f 12069182383 514b6c5f 5432864399 5e719aa3 74440504 adc0878b e33ffa7a f6d545a7 |
| Dislike | `edit_mid_run` | 28 | 02da79c3 1211c43a 12120839005 13595999311 1b1b57bc 1bd93dae 4d1e42de 5bf51d5f 5ee16525 6190659183 6955478723 7671208684 76b63f72 7926ae3e 8447625826 85a1ae2e 8a721672 8c1d4e83 9316059449 9537508046 9691e9eb 9818758756 98ba99fa 9d57f40d a06c3af0 c36b3b8c cdce22d6 fdad6e0d |
| Dislike | `end_screen` | 7 | 01d2c8ea 12120839005 514b6c5f 5555227865 8d4fa3e2 9110824182 ef7158c0 |
| Dislike | `eta_wants_more` | 9 | 12682810733 5e118c4d 5e2d5c82 7294333740 8254740918 8ac54673 9392564396 9964657099 e94fc7f4 |
| Dislike | `eta_wrong` | 20 | 0d184902 10322814498 10404646842 12900466473 12911127629 12922089445 12924052329 12926698752 12926865871 12930985989 13323018578 4bbcfad2 6174662207 6e51d06f 8ca0edf5 9110824182 940604db ab9c6988 d889bda4 dd4d3dbc |
| Dislike | `hide_numbers` | 3 | 4f21117d 9677875961 a5aca58b |
| Dislike | `nagging_alerts` | 15 | 0f9b544c 10191473176 11233772767 13549051927 13714159491 14025543075 6052508429 6727944992 7625583895 8d4fa3e2 9709323898 9c7bb448 be853b23 befcafe9 e5935276 |
| Dislike | `no_breathing_room` | 6 | 13714159491 7174563257 7294333740 76273996 971415d6 d9537896 |
| Dislike | `no_skip_button` | 3 | 14073080620 23cf7bd6 fe87180c |
| Dislike | `no_time_up_alert` | 56 | 0ce079d3 11711220581 11862838916 11d706e4 13063734 13982523131 13dbb806 13ee861c 1571e873 163b85bc 1c4c6100 1d5fc5af 1f43da7e 2856f8c0 29492692 33e72579 37137185 3fcbde19 47b8e170 4e2e7cb4 510f685a 60cafafd 64950f79 68371e26 6967fdc9 6a5b871e 6c2f04ba 7351344794 7538016690 753ee870 7885385809 810b5737 8285258859 8355872368 8590021218 8791656213 9219301950 922d2b2d 9bf9a480 9cf9111e 9f2d3783 a9f639ff ad47e481 aea0fc3d ba3cf9e6 bb2689ff c1b4d6cf c325d70f c449c0d9 c8c13021 c923f3db d8d7fbbe e7f07cf2 f1c9e692 f2ea0c4c f68d6379 |
| Dislike | `notes_mid_run` | 6 | 032a0615 13604867040 13702441710 1ae62139 7eb05b53 f0beeb7c |
| Dislike | `outside_app_broken` | 24 | 0970d292 10306996160 10496004486 10696429419 11010718150 11606439146 12397332591 12825861477 12922089445 13323018578 13718473495 13727332123 14191150102 6a2985ba 8949797596 90160406 92107e27 9554803d a2b750b5 c545cb35 ce1ac27a e3a3e3e0 ede1d792 ee6c19d7 |
| Dislike | `outside_app_missing` | 37 | 03e5fd4e 05f4e616 12492516128 126d9e26 1336c86b 13756829761 14372695527 1ae62139 2388ba1a 269f000d 447111a1 4a597709 58677bfd 605796a8 6808956777 7596402847 794a53fa 9239813390 9270622470 945b911e 9502486128 9560577009 9810651911 9818758756 9914110069 9923645583 99617b3b 9c07f645 a198b84f b04e1051 ba0238dd bbf087f3 bf8493a8 c923f3db d469ad41 e39643c2 ebeb285f |
| Dislike | `overtime_missing` | 3 | 53180359 5555227865 5558415928 |
| Dislike | `parallel` | 9 | 0148580a 10710417118 4a947197 7806175559 7959641419 82cd0403 bc79b387 fc85df9f fe93abb1 |
| Dislike | `run_lost` | 25 | 10999826761 11400702751 11626919730 12973553692 13323018578 181d08f8 1e74cb7a 26d4b900 291c6a4a 2a443a10 37357318 4878bcb8 53f5bd6f 5a338414 6326429154 7858806506 7e645850 8ca0edf5 9183771774 9267380614 ad8e1b17 b805da86 c545cb35 d9755b1e e5be6e7a |
| Dislike | `skip_bugs` | 10 | 10033781646 13433400135 14016573870 14037582942 8b2b63db 9057847346 a77a46f1 b4616803 f326c5d8 faff8d9c |
| Dislike | `skipped_gone_order` | 33 | 044a642b 10191779042 10775080689 11799088054 12349076176 12442067714 12463642616 12731101835 14361903211 155d2496 273e3c74 2dd9c0ed 30fb4bae 32b498e8 3570c16c 3cb035d9 561d8e2e 5e719aa3 65692248 6938277128 7625074704 7625583895 7734088825 79e68fb2 7a611c18 7c8daf10 81540359 823c7e8d 8745613875 a07c27ce ba5e72ed d2f22a01 fda805eb |
| Dislike | `starts_last_step` | 7 | 7358636824 8948023303 9310254092 9512372663 9736016486 9765704843 9780720694 |
| Dislike | `stops_music` | 11 | 016b7d12 11760598486 13619865598 13792080672 5715799082 79742061 8452720381 8456239482 8466255751 8483895502 ebd77d40 |
| Dislike | `taps_freeze` | 20 | 10432199920 11338931644 11381916989 13388989196 1bdf5bb1 1e964c93 3da85b05 3f33b873 518fa263 52d2d9ce 6322696880 64db607d 74381b21 8447625826 84c55b5c 90e44f4f 9607295246 ac08896e cbb9e1be f3939cbb |
| Dislike | `timer_forced` | 36 | 10004061679 10507135013 10746011966 11015642151 11972917376 12160531567 12700460272 13073278557 13083172851 13442141220 17297b1b 3e02fac5 4d0a50a3 59fc3254 6474496213 6661289869 71402363 7246817204 7510768204 7538016690 7625583895 81540359 8605ed47 8791467148 8c142ba8 9010899661 a7e26036 a934f25c b05b9824 b3d27f6b cc7ef4fb cceb664f dd340cb5 e00924fe e9c2e95f f4320cd9 |
| Dislike | `timer_state_wrong` | 19 | 10520152450 13901529112 15e15852 223a0f24 5191cc78 6e1f227e 7cfb6a13 8851792332 90160406 9502486128 9711535882 b603151e c6d7d584 cf9b88b2 e2aa7070 f1c9e2fb f815b43f faff8d9c fb57d428 |
| Dislike | `timer_stress` | 17 | 0e50a358 11015642151 11972917376 12945c3c 12984600178 13127830013 13373809432 13714159491 14025409535 194d970f 7510768204 81ca585c 8839466844 8848686558 b3c1a9c5 e0bc2095 e824fae3 |
| Dislike | `undo` | 32 | 00810516 05f4e616 10033781646 10250165601 11217088616 11580842783 11ec4320 12069182383 13119858592 2e9605d1 302deabe 4ea799a3 5432864399 5e719aa3 7079196017 74440504 7843095633 7ac5d2ea 8094545941 8261526871 94ba5eb7 9691e9eb 9980992196 a1bb520b adc0878b b1934dbe bd1cc505 c0852f07 f6d545a7 fc00b12e fcaa917c ffffce59 |
| Dislike | `voice_broken` | 11 | 0c6f89f4 10432199920 12733221988 13437967339 1576d7bb 3d4b18ef 8406803990 8493158476 90160406 90b5d219 dafcf1f2 |
| Dislike | `voice_cant_off` | 16 | 10274817246 10318782344 10387643879 11233772767 12748991748 13127830013 3d4b18ef 64950f79 9332392150 9350028810 9514086047 9517038038 9554803d 9614812362 b96b7728 be4c5439 |
| Dislike | `voice_dislike` | 42 | 07d7e19f 10274817246 10318782344 10387643879 10496004486 10535041091 10542119017 11188300937 11339565872 11464035458 11470979660 11917606165 12134454558 12268510391 12748991748 13083692970 13127830013 13380272707 13568974603 13626272069 13730328976 13792080672 14305759207 23a4750f 3d4b18ef 5fbe93a1 64950f79 9332392150 9350028810 9447779146 9514086047 9517038038 9554803d 9614812362 9773230745 9827006215 9888292979 b1899f6e b91dacbf be4c5439 ce3bde19 cfd2ba54 |
| Dislike | `voice_wants` | 15 | 10472319642 10775080689 11339565872 11464035458 12551406740 12733221988 12929890417 13411638566 13730328976 1b280be1 9447779146 9773230745 b1899f6e d8fd3973 e46de97c |
| Dislike | `wants_autonext` | 19 | 11866462906 12900411902 13526313778 14073080620 14300d14 4f21117d 50424e8e 50495293 5898b151 5900262906 7119123744 7665780253 76c3ff8d 9759182851 bf8493a8 c325d70f d436eb5c daf863d0 ead62ba5 |
| Dislike | `wants_music` | 11 | 13634566945 185da7de 3215930a 54f7a1b9 6de0e983 7152899221 7b891566 92840693 98ba99fa 99af5017 dbd3fe27 |
| Dislike | `watch_running` | 111 | 10005584335 10141244395 10179113941 10339767091 10484636679 10881832037 10958250404 10999826761 11013911389 11149362699 11283605490 113e7fb7 11427409205 11760598486 11799088054 11819860723 12395802461 12442067714 12731101835 12922089445 12973553692 13088721915 13268140014 13786020408 13967822610 3a721dd4 3affaac9 3baca576 3c9d6b4e 41f87861 4af22a5f 4c4beb1e 4e1aa062 525ffc19 56e5934f 5c1d6032 5edb37b1 65dac954 65ee1ef6 6748956045 68adc66c 7015413113 7024964209 7228920838 7266678836 7268334304 7294747339 7510768204 7530054088 7753c730 7755142510 7761010928 7843095633 7886e56f 7904248902 7904305007 7949486236 795f1ea9 79f193bb 7ef80f06 8007313621 8096972526 8134330874 8193901599 8202746698 8227531164 8237359683 8283285093 8368846355 8394614510 8413763372 8431445074 8483895502 8489824934 8490774445 8545766795 8561307198 8612200478 8627876488 8646018507 8728078244 8737737503 8745613875 8765909690 8821459512 9169988322 9261465064 9267380614 9294576985 952f5bc0 9537877519 9607295246 9784372716 9860026137 9903943394 99983e06 999f953a 9bf9a480 9fa1bdc0 ad8e1b17 ba3cf9e6 bf277d0f c495254b cbb9fc5c d9a49cfb e96a7f4b edbd2c45 eee8650a f69e8cfd faff8d9c fff07b47 |
| Dislike | `watch_wanted` | 68 | 03e5fd4e 099d50df 10924800327 11041542289 11395184650 11537230841 11599308 11900632508 11960809011 12104237756 12240973409 12417804176 12569134199 12759884967 12919718433 12936726099 13114850394 200fdbae 2209877e 2253b23b 3a600ca5 3b951368 3dec427e 3f13d6cb 4339e7b2 44edd7ec 4e66efaf 51761d93 5452773407 5777997920 5972759879 6007431744 6259636065 6322696880 6376270348 6377877803 6455907749 6531471760 6550422708 6576034339 6597562009 6633721289 6669295549 6719447014 6777298636 6804411261 6910114072 6f55445d 7112eb31 747d14fc 75b05202 8311504661 8552969245 8605ed47 8e777efc 9027902c 9186323926 9b6494ef 9bdd7f99 b24ed63d c1dddf12 c22987e4 c9ae3740 deddd7ec e425cdef e9166b84 fb21ae7a fcb866a2 |
| Helps | `add_time` | 21 | 10191779042 12279005430 12d906e9 291a401d 2f2456a2 4cfb19e5 6376270348 76ab2646 7811113116 7a237333 8368846355 8b9f72e6 a4458585 a620908b b82daf99 c3aeaa55 d02cdf47 d0cf58c7 f14f2c99 f1c6cae1 f9ff8a52 |
| Helps | `auto_next` | 20 | 11200687380 11615230506 11866462906 12118266764 13666750916 13791057626 242e268c 2752d6a6 4bcc9756 53a91ed1 76c0c09a 84f1b5f5 9069402825 9283694208 9485098944 9b0ecedb a1bb520b cedceb29 cf91499e e384714a |
| Helps | `end_praise` | 8 | 12238910376 50a3a939 5888091009 70474a75 7959641419 8eec50d3 9228861293 9914706305 |
| Helps | `eta` | 58 | 03401fb6 10062211570 10192445505 10496004486 11464035458 11470979660 11623591586 11652664015 11866462906 120f92c4 12135036611 12465341685 12685058654 12995397048 13124196236 13487673204 13641280121 13643916764 13736785416 13791057626 14115048883 14302680603 3208425d 38282c51 409a257f 46212a41 540b4ba1 544c487d 5972759879 6461798867 6631164231 6663385367 7411426981 7819802935 7a237333 8483895502 8742542417 8744491391 90160406 9017685503 9084027536 9197464713 9310254092 9374d82c 9385197626 963c9f38 9861014690 9ebb4559 a437f65c a4458585 a6c99f58 b465d569 bcbaabdf cb4afd9e cb4b35c1 d597c10c dd75ccb0 f24c7634 |
| Helps | `guided` | 97 | 032a0615 05c2bdca 077c88f3 07c9f894 08205e79 0ca8100e 10158107203 10853808093 11016042720 11130087506 11392402930 11628855976 11666039010 12117615403 1211c43a 12145145463 12160531567 12280692985 12359395736 12608526884 12634975055 12693682297 12845166573 12d906e9 13056607567 13322087122 13347337501 13362713060 13376641175 13439696666 13446802332 13568974603 13624963931 13686048537 13924719573 14022461337 14047899312 14055829822 14323219647 14349165171 14497946151 2583c6aa 29ecdad9 2b83b233 2f9a753f 38282c51 3b525a68 3d73f841 416d9463 4721a81e 48922662 4af0fee6 56e4e3fa 5714466858 5777997920 5888091009 5a53035e 5c680902 6574461294 68518a83 6bd6986f 7046987901 7299003172 7959641419 818238f0 8355049588 8357131715 8404706978 8595119798 8601198745 8638966995 86d8f948 8924959436 9176327010 9228861293 9269522528 96db7d4c 9b0ecedb 9ee11e70 a620908b a8817ae5 aebdce26 b8f77b8e c0b258e9 c0ff81a5 ca702f16 cf0d1451 cf91499e d5d85143 d7b77215 da04d948 e14f7cd0 e5c86982 f367b502 f42defaf f78cbb85 fb61e04b |
| Helps | `hands_free` | 7 | 11464035458 11470979660 13624963931 13698824968 13786020408 9350028810 9914706305 |
| Helps | `kind_tone` | 29 | 09eae6d5 11002089805 11647019079 12077111002 12779342673 13224248600 13494157083 13763004001 14371526010 156994a3 1ad3bf3a 1f853deb 3446e9ae 4635bcf9 6510e341 6a348e54 6fcfa340 76ab2646 7934757220 7ab09bd7 8470259036 96db7d4c 98817a44 a78e1ce3 cc80ed79 d02cdf47 e2d58546 f708b88e f9ff8a52 |
| Helps | `lock_island` | 2 | 10968567775 9283694208 |
| Helps | `manual_next_choice` | 5 | 11314153569 11615230506 11866462906 9283694208 9485098944 |
| Helps | `overtime` | 20 | 11002089805 12118266764 12779342673 13323483749 13487673204 1f853deb 21e51d63 403c116f 433a8758 6a348e54 8357131715 8483895502 85a1ae2e 8742542417 885256bb 9485098944 963c9f38 b3c1a9c5 b701eefe eb1f4ee1 |
| Helps | `pause` | 46 | 03401fb6 10135282986 10191779042 10424843141 10766539547 11005764930 11837540247 12077111002 12159123609 12356300363 12798009953 13323483749 13661473607 14294512252 2f2456a2 3143d980 42142896 50729a50 514b6c5f 532ec35e 6461798867 6663385367 7be9312c 814268fb 8483895502 8e5dce11 9283694208 9326484636 9485098944 9501229583 9ce305c6 9d05ec76 a41475af a4458585 b82daf99 ba1e66aa bffd69e3 c03bda07 c3aeaa55 c6653a22 cb8e6da5 cc80ed79 e5ae26b7 ece835ac f932a829 f9ff8a52 |
| Helps | `pause_reminder` | 15 | 10135282986 12798009953 3143d980 42142896 532ec35e 6461798867 6663385367 8483895502 9283694208 9326484636 9485098944 9501229583 a4458585 ba1e66aa ece835ac |
| Helps | `records` | 56 | 02f9a984 07778d9d 12585389232 12670271698 12685058654 12931242244 13624660676 13641280121 13714159491 13791057626 13901529112 13916284914 14022461337 14104903936 1949d287 23ed6b45 2583c6aa 34b9f04a 3c5731c3 409a257f 501a073c 514b6c5f 5783613866 62f025e3 64fe5cfa 65ee1ef6 70474a75 7184762146 7719936293 7786048610 7959641419 7dfa2f61 829ce511 8bc3de94 9017685503 9175679730 9368936917 9487178679 9697210699 9839987217 b3085210 b3c1a9c5 ba1e66aa bae761eb c03bda07 c7a70d88 ca702f16 cf91499e e2f5828a e89ff8c7 e9f87297 f03b98f1 f1ceba9f f42defaf f5616b85 ff82be7c |
| Helps | `reorder_mid` | 17 | 11837540247 12221178563 12240973409 12952781662 13092402818 14446671247 42142896 57369711 7791420482 8795874884 8d0a000d 9044271883 9350028810 bcbaabdf d289f6a0 d597c10c ee98d8f9 |
| Helps | `skip` | 56 | 0394f127 04cbd21c 09eae6d5 0dbe7511 10135282986 11181014273 11639547896 12118266764 12137471978 12221178563 12240973409 12608526884 12731101835 12952781662 12d906e9 13031655072 13224248600 13323018578 13344868929 13487673204 13494157083 13587263881 13731653732 13763004001 14371526010 14408847759 14446671247 2f2456a2 3143d980 4635bcf9 57369711 6e1f227e 738a3c13 7550904694 7596402847 76ab2646 7ab09bd7 8368846355 8742542417 8af61873 8d0a000d 8e6f8443 9044271883 91c188ec 9247390765 9485098944 a604dee4 a620908b bcbaabdf bffd69e3 c06e8cda c3aeaa55 cb8e6da5 d0cf58c7 d289f6a0 de032b7b |
| Helps | `time_up_cue` | 13 | 05c2bdca 08205e79 10437166464 14022461337 38282c51 5426934162 56e4e3fa 628edd7a 8357131715 8494363410 e5f7a3ba eb1f4ee1 f42defaf |
| Helps | `timer` | 325 | 038499f7 04cbd21c 05334ec2 05b1d6f5 061af967 07c9f894 07eca013 0a1ecdbb 0f7b11aa 10060734054 10192445505 10227185907 10337926884 10602755925 10655581128 10778573851 10847884904 10853808093 10899850408 10968567775 11005764930 11130087506 11181014273 11327316211 11392777431 11602964529 11606439146 11615230506 11615292369 11617837700 11623591586 11626824220 11641777423 11659235892 11681419592 11689246686 11706427683 11757564794 11837540247 12117486767 12134454558 12141517341 12156939704 12159123609 12198081069 12220758031 12226439751 12235381706 12251430632 12270125990 12280692985 12402433163 12465341685 12523518770 12527620239 12585389232 12588332101 12608526884 12629436106 12634975055 12670271698 12710625570 12798009953 12824797642 12845166573 12892314949 12952781662 12979205113 13031655072 13083692970 13093885049 13120896321 13124786915 13141526963 13227701396 13322087122 13323483749 13336308503 13362713060 13378676683 13381742868 13437967339 13447111265 13459034679 13463871198 13487673204 13616783295 13625006474 13641280121 13650192274 13661473607 13682803052 13686048537 13709979098 13714159491 13728876549 13763004001 13814491431 13856956560 13860429738 13875347740 14034857048 14055829822 14073080620 14214126807 14217992933 14269209242 14294512252 14375560440 14408847759 14414547636 14446671247 14511056010 18aefb7d 192f4904 1976eb5f 1ac11d9c 1ad425a9 1bf17e22 20615ed8 241295c5 267238ea 270296bc 27f14311 28ee175a 2aaff9d8 2c7b6229 2c888bb2 2f01cef4 312cb9a6 31a21bf0 3208425d 325d7ddf 378b0ca9 37ea41a1 38282c51 3d3e5d7c 3d73f841 3f45a171 40242f2d 403c116f 409a257f 416d9463 423db4f1 433a8758 434ecc9a 43d7d4fb 45227277 4cfb19e5 501a073c 51378de0 514b6c5f 532ec35e 5337a639 53a91ed1 5415561492 56e4e3fa 57369711 5745603593 57bb6ada 584bf3d3 5888091009 59678a60 5a85d26b 5dea6e66 5e719aa3 5eef5b99 5fab98e0 61e60048 62f025e3 6391d079 64fe5cfa 665b0595 6667607092 6751bc00 6764888366 6766551722 68518a83 6879e0cd 6883027790 6942358183 6975210863 6af19106 6e1f227e 719b0fb1 7299003172 730eb443 7361132166 738a3c13 7394766374 7442828331 74a8649e 7596402847 76ab2646 7744495444 7771453021 789352f7 7916241573 7dc9ef04 7eb672de 802fc2d7 8038719402 8062662460 80770118 8204342733 8305241443 8309121204 8345044482 8355e3e5 8357131715 8381248159 8394614510 8430746918 8432d10b 844f84d4 8483895502 84d383f4 8595119798 860538b6 8605738567 861a6ed2 8791467148 885256bb 886ae010 88825831 88e32cb9 8913806895 8924342466 8959922464 8986565266 8a635e4e 8a806edc 8b9f72e6 8d301162 8d399c6a 9069402825 9197464713 91c188ec 9228861293 9283694208 92e024f8 9368936917 93925ec4 9479904289 9485098944 9501229583 9698937598 9914110069 99af5017 9bd7d55d 9c07f645 9cf08ce8 9d05ec76 9ee11e70 9eeedc5f 9f56a58e 9fc1e195 a1c21b91 a2ef6895 a32ff034 a3910ec6 a41475af a437f65c a5425d05 a78e1ce3 a8c9173c ae5ec522 af0366c0 afeb33a6 afeb8f9f b0565838 b465d569 b4dafa49 b81e7420 b93e9df6 ba1e363a ba91ea37 bae761eb bcbaabdf bffd69e3 c1c4dc36 c2a58f6f c8251047 cb4b35c1 cc63e6ec ccaa042e cce38e39 cde808b4 cf91499e d02cdf47 d289f6a0 d3f13808 d513280b d5c60d03 d7b77215 d7e79c8f d9537896 da04d948 dc6e3c57 ddc7b64d de159e48 defb4a55 df9bb846 e06afe2d e182501f e1a79e72 e2230360 e2681922 e5f7a3ba e683d984 e7af288d e98f9e00 e9f150a0 ece835ac ef40cba4 f210d734 f3bb784f f815b43f f8468cf7 f932a829 f9466555 f9d8c907 fbe8f3cb fdbf4151 ff82be7c |
| Helps | `visual_timer` | 12 | 10192445505 13459034679 31a21bf0 3208425d 423db4f1 8204342733 8483895502 8595119798 8791467148 8d399c6a 9698937598 e368e6b7 |
| Helps | `voice` | 65 | 10101103138 10191779042 10333293209 10337926884 10496004486 10535041091 11181014273 11464035458 11470979660 11602964529 11617837700 12117615403 12279005430 12280692985 12608526884 12634975055 12798009953 12952781662 13053113730 13224248600 13278570981 13376641175 13411638566 13416875663 13587263881 13624963931 13736785416 13938213739 13942902589 14022461337 14428195711 1b280be1 1c8338d7 21e51d63 31a21bf0 325d7ddf 3c18a7e1 403c116f 5311ff75 59c5af28 6376270348 66c160fc 7006b03f 8204342733 8439543990 85e2ed49 86d8f948 8744491391 8e5dce11 90160406 9197464713 9350028810 9415287454 9461969981 9485098944 9489801442 9655374699 9914110069 9914706305 a65e89ce ac038f92 c1c4dc36 cce38e39 e46de97c f4320cd9 |
| Helps | `white_noise` | 12 | 12325461214 12922822006 14305701584 14305759207 14375560440 3c18a7e1 8541532699 9461969981 9612211612 ac281ecb ce3bde19 dabb4377 |
