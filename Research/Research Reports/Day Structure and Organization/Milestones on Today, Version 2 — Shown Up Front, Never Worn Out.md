Written by Claude (Claude Code), 17 October 2026.

# Milestones on Today, Version 2 — Shown Up Front, Never Worn Out

**The user's request (17 Oct):**

- A line in the row "doesn't feel anything". The whole point of a milestone is to showcase it, not hide it, and a
  pop-up "looks good" and makes people feel good.
- But a new person who adds five habits the same day reaches *3 days in a row* on all five together. A pop-up for the
  first is fine, the second maybe, and by the third they're annoyed. The same holds for everyday users.
- The user's own idea: something the size of a snackbar, rising the way a snackbar does, when several come at once,
  and a pop-up when there is only one.
- The request was to research it in depth, from first principles, with UX, UI and emotional design principles and
  credible sources, then draw it as a new version beside the old frames.

This report builds on [Milestones on Today — When, How and What Not to Do](<Milestones on Today — When, How and What Not to Do.md>)
(the first version and its two follow-ups) and uses the same evidence folder.

## The answer, in short

**Celebrate in proportion, at the right moment, and only once.** A milestone has three layers:

1. **At the tap, always:**
   - the ✓ fills, as now;
   - one *confirm* vibration;
   - a small medal pops into the row's subtitle with the words, *3 days in a row*.

   It's instant, and it never interrupts anything.
2. **The pop-up, for new heights:**
   - It's for the first time a habit ever reaches a length, and for every *in total* milestone.
   - It opens by itself when the person stops tapping, never between taps.
   - It's never shown when the app opens.
   - There's at most one per visit to the app.
3. **The milestone bar** is the size of a snackbar and rises the way one does, just above the day bar. It covers what
   the pop-up shouldn't:
   - **Several coming in:** when today has more than one habit one log from a milestone, the bar appears at the first
     one and counts up in place (*2 milestones today*). When the taps stop, it **grows into one pop-up** that holds
     them all, with the same length on several habits as one line: *All 5 habits · 3 days in a row*.
   - **A length reached again** after a break (*7 days in a row again*): the bar alone, about 4 seconds, with **See**.
   - **Another new height after the visit's pop-up:** the bar alone, with **See**.

So the person always gets something they can see and feel at the tap. They get a real moment for anything new, and
never more than one pop-up in a visit, however many habits they tick.

The 0.6 s burst around the button (version 1) is dropped: with the medal popping in and the bar or pop-up, it was a
third movement for one tap.

## Where the evidence comes from

- **Reviews:** 32 quotes from the corpus, verified (`Milestones on Today Evidence/verify.py`, 0 mismatches). The full
  tables are in the version 1 report.
- **A simulation** of the app's own milestone ladders (`simulate_pileups.py`).
- **Published research and platform guidance**, cited where used below. Where only a secondary summary was found, it
  says so.

## First principles: what a milestone is for

A milestone has four jobs. Each one points to a part of the design.

| Job | What it needs | Principle |
|---|---|---|
| **1. Wire the habit** | A good feeling *right after* the behaviour | Fogg's Tiny Habits: celebration that comes immediately after the behaviour is what wires it in ([TED Ideas, Fogg](https://ideas.ted.com/how-you-can-use-the-power-of-celebration-to-make-new-habits-stick/)) |
| **2. Make progress felt** | The person sees that the days added up to something | The progress principle: small wins carry outsized weight for motivation ([Amabile & Kramer, *The Progress Principle*, HBR Press 2011](https://www.goodreads.com/book/show/14596646)) |
| **3. Be remembered** | One moment strong enough to remember, ideally at the end | The peak–end rule: an experience is remembered mostly by its most intense moment and its end ([Fredrickson & Kahneman 1993; Kahneman et al. 1993](https://en.wikipedia.org/wiki/Peak%E2%80%93end_rule)) |
| **4. Stay meaningful for years** | Not so frequent it becomes background | Habituation: a reward that's expected stops registering; the brain responds to the gap between what's expected and what happens (Schultz, Dayan & Montague, *Science* 1997; [Rutledge et al., *PNAS* 2014](https://digitalwellbeing.org/wp-content/uploads/2014/08/PNAS-2014-Rutledge-1407535111.pdf)) |

**Two constraints:**

- **Never get in the way of the task.** Interruptions delivered at a breakpoint between tasks cost less, in
  frustration and in reaction time, than immediate ones ([Iqbal & Bailey, CHI 2008](https://www.interruptions.net/literature/Iqbal-CHI08.pdf)).
  Material Design calls dialogs "purposefully interruptive" and says to use them sparingly
  ([Material 2, Dialogs](https://m2.material.io/components/dialogs)). Logging five habits is one task, so the end of
  the run is the breakpoint.
- **Never punish a break.** People disengage once a streak is broken, and messages that dwell on the failure don't
  bring them back ([Silverman & Barasch, *Journal of Consumer Research* 2023](https://www.colorado.edu/business/faculty-research/2023/04/19/or-track-how-broken-streaks-affect-consumer-decisions);
  the second part is from the authors' press interview). So reaching a length again is acknowledged, lightly and
  honestly (*7 days in a row again*), never as a loss. The app's own rule U3 says the same.

**Emotional design** (Don Norman's three levels, [*Emotional Design*, 2004](https://en.wikipedia.org/wiki/Emotional_Design)):

- **Visceral** (how it looks and feels): the ✓ fill, the medal popping in, the vibration.
- **Behavioural** (does it help me do what I'm doing): nothing blocks the next tap; the pop-up waits for the end.
- **Reflective** (what it means to me): the pop-up, with *All 5 habits*, the date, the next milestone, and the record
  on the habit's page forever.

A design that works on only one level fails. The row line alone (version 1) was only behavioural, which is why it
"doesn't feel anything".

**Rewards and motivation.** In a meta-analysis of 128 experiments, *expected, tangible* rewards for doing a task
lowered people's own interest in it, while *positive feedback* didn't ([Deci, Koestner & Ryan 1999](https://depts.washington.edu/techdocs/papers/deciExtrinsicRewardsAndIntrinsicMotivation99.pdf)).
So a milestone stays *information about the person's own progress*, in their own habit's colour, and never becomes a
prize, a point or a currency. It also isn't announced in advance as something to chase.

## What users show (from the corpus)

| Theme | Reviews | The point |
|---|---|---|
| An early congratulation lands with new people | 4 | *"Easy success with a congratulations, which of course gives you inspiration to build on"* (3 days, A24#42472) |
| People want more than a quiet record | 2 | *"much more rewarding if there were 'congratulations' or something to show off when you hit milestones"* (A3#3120) |
| A medal for a new personal best is loved (Hevy) | 2 | *"Every time a pr is hit, you recieve a little medal which is very rewarding"* (P122#7594) |
| A summary at the end of the session is loved (Hevy) | 2 | *"the summaries and celebratory analytics after finishing a workout are super encouraging"* (P122#18737) |
| One on every item is hated | 17 | *"way way way too much celebration for EVERY TASK"* (P12#7953); *"check off 4 habits you're just sitting there waiting"* (A16#29) |
| The same congratulation again | 1 | *"congratulations on your FIRST milestone, but I've got it like 10 times already"* (A10#30825) |
| Something every time the app opens | 2 | *"pop-up EVERY morning when I open the app"* (A13#12473) |
| Small feedback on every tap is liked | 2 | *"the almost visceral satisfaction of checking off each habit"* (A55#1878) |

**What other apps do** (checked, not copied):

- **Duolingo** shows its streak screen once, after the lesson, with a bigger animation on milestone days, and reports
  +1.7% of new learners still active a week later ([Duolingo blog](https://blog.duolingo.com/streak-milestone-design-animation)).
- **Hevy** gathers a workout's new records on the screen after Finish ([Hevy](https://www.hevyapp.com/features/workout-log/)).

Both celebrate **after** the activity, **all at once**, and for **something new**. Hevy's records are new bests by
definition.

## How often each layer would show

Results of `simulate_pileups.py`: the app's real ladders, 2,000 simulated people per case.

| Person | Any milestone (row) | New heights only (pop-up candidates) | Days with 3 or more new heights |
|---|---|---|---|
| New: 5 habits added the same day, done 90% in week 1 and 80% after; first 90 days | on 58 days | on 21 days | 2 (day 3 and day 7) |
| Established: 8 habits added over 6 months, done 85%; a year | on 225 days | on 43 days (about 1 in 8) | 5 |

So:

- The pop-up, limited to new heights, comes about **once every week or so**. That's rare enough to stay special
  (job 4) and often enough to be felt (job 2).
- The bar for lengths reached again covers the other days, lightly.
- Pile-ups of new heights are concentrated in a new person's first week, which is exactly when encouragement matters
  most. That's why they become **one** strong grouped moment rather than being thinned out.

## How the app knows: today's list

A milestone isn't a surprise to the app; it's worked out from each habit's streak and total.

- **When the day starts**, the app knows which habits are **one log away** from a milestone. Meds at 2 days in a row
  will reach 3 if logged today. On most days the list is empty, and nothing changes.
- **At the tap**, the app knows whether this is the only habit on today's list or whether others are still to come.
- **The end of a run** is the first of these:
  - every habit on the list is done; or
  - nothing has been touched for a short while (about 2–3 seconds; scrolling counts as touching, so the pop-up never
    lands while the person is looking for the next row).

## Every case

| Case | At the tap | When the taps stop |
|---|---|---|
| **One new height** (Meds reaches 60 days) | ✓, vibration, medal and words on the row | The pop-up (V2.2) |
| **Several new heights in a run** (day 3, five habits) | ✓, vibration, words; the **bar** rises at the first and counts up in place (V2.3, V2.4) | The bar **grows into one pop-up** holding them all (Material's container transform: the same surface grows, so the eye follows it). The same length on several habits is one line; *All N habits* when it's every habit on the list (V2.5) |
| **A length reached again** after a break | ✓, vibration, words, and the bar: *7 days in a row again · Stretch*, with **See** | The bar leaves about 4 seconds after the last touch; no pop-up (V2.6) |
| **Another new height after the visit's pop-up** | ✓, vibration, words, the bar with **See** | No second pop-up (V2.7) |
| **The person leaves before the end** | n/a | What was waiting becomes the card on the next Today (version 1, MS.4) |
| **Reached away from the app** (quit habit, widget, watch) | n/a | The card on Today, with **See**; never a pop-up when the app opens |
| **Undo** | The milestone leaves the bar's count; if none are left, the bar goes | n/a |
| **A streak and a total on the same tap** (10 days and 10 times) | One milestone: the streak | The total is inside the pop-up |

## The surfaces

**The milestone bar** is custom, not a stock snackbar, but follows a snackbar's size and motion:

- **Size, position and motion:** 328 × 56 dp, a dark inverse surface with 16 dp corners, just above the floating day
  bar. It rises 250 ms.
- **Contents:**
  - the medal (or overlapping medals) in the habit's colour;
  - the words in one or two lines;
  - **See** as a text button (actions always carry words).
- **Behaviour:**
  - It never stacks: one bar at a time, updated in place, as Material asks of snackbars
    ([Material, Snackbars](https://material.io/components/snackbars)).
  - It stays while the person is touching the screen, then at least 4 seconds. Material's range is 4–10 s.
  - It respects Android's *Time to take action* accessibility setting, because auto-dismissing messages are a known
    accessibility problem ([Primer, Accessible notifications](https://primer.style/accessibility/toasts/);
    [WCAG 2.2.1](https://www.w3.org/WAI/WCAG22/Understanding/timing-adjustable.html)).

**The pop-up** is the existing milestone sheet (MS.2); its own design is not part of this round. The grouped version
puts the medals side by side over one title.

**The vibration** is Android's `CONFIRM` constant, once per milestone tap, replacing the ordinary tap's click. Android
asks for haptics to be sparing, clear and consistent ([Android haptics design principles](https://developer.android.com/develop/ui/views/haptics/haptics-principles)).

**Reduced motion:** with *Remove animations* on, the medal, the bar and the pop-up appear without movement
([WCAG 2.3.3](https://wcag.dock.codes/documentation/wcag233)).

**TalkBack** announces the milestone at the tap (*Milestone: 3 days in a row, Meds*). The pop-up takes focus as any
dialog does, and the bar can be reached until it leaves.

## What this changes from version 1

| Version 1 | Version 2 |
|---|---|
| A line in the row; the sheet only when asked for | The row, plus the pop-up by itself for new heights |
| A 0.6 s burst around the button, once per visit | No burst; the medal pops into the row |
| Every length marked again after each break, the same way | A length reached again gets the bar only (*7 days in a row again*) |
| Several at once: one burst, the rest quiet | Several at once: the bar counts them, then one grouped pop-up |

Version 1's frames stay in the section for comparison (MS.1–MS.7); version 2's are V2.1–V2.8.

## Version 3, the same day: the milestone bar redesigned (the user's direction)

The user kept the roles: **a pop-up for something special, the bar when several come**. Which milestones count, and
how often, for each kind of habit is a separate piece of work (Current Work 127). On the bar, the user decided:

- **The habit's own colour, as a gradient, with something moving inside it**, so that even a bar feels special. The
  black bar didn't.
- **One bar per milestone.** When the next habit reaches one, the first bar leaves and that habit's own bar rises.
  There's no "2 milestones today", and no grouped pop-up at the end: *"if the user wants to see, they can click on
  See"*.
- **It floats and never stops anything.** It stays 4–5 seconds, goes as soon as the person touches anything else on
  the screen, and can be dismissed. **See** opens the pop-up.

**Drawn (V3.1–V3.6):**

- **The bar:**
  - 328 × 64 dp, 20 dp corners, the habit's colour as a gradient (deeper on the left, lighter on the right) with a
    shadow in the same colour;
  - the medal in white, with the number in the habit's colour;
  - three sparkles;
  - the words, a white **See** pill and ✕ **Dismiss**;
  - a thin line along the bottom for the time left.
- **A light habit colour** (yellow) takes dark text and a dark See, so the words always pass contrast.
- **Motion, about 1.2 s and then still:**
  - it rises in 250 ms;
  - the medal pops (0.6 → 1) and the sparkles twinkle once;
  - a sheen sweeps across once;
  - it leaves in 200 ms.

  With *Remove animations* on, it simply appears and leaves.
- **It stays 5 seconds.** That's the low end of Material's 4–10 s for a message with an action, enough for the motion
  and a read. It stays longer if Android's *Time to take action* asks for more.
- **It goes on:** the end of the time, any touch elsewhere, a sideways swipe, ✕, or the next milestone's bar.

**Then (the user):**
- The bar grew to 72 dp so the time line sits above the edge instead of on it.
- The motion is built in Figma Motion as V3.7: one frame where a bar arrives, the next habit's bar replaces it, and
  it leaves. The timings are in the handoff.

**This replaces, from version 2:** the black bar, the bar that counted, and the bar growing into a grouped pop-up.

**It keeps:**
- the pop-up by itself for a milestone that comes alone, once the taps stop;
- every tap's ✓, vibration and medal on the row;
- *again* for a length reached again;
- nothing ever shown when the app opens.

## Limits

- Several sources were reached through secondary summaries (the peak–end details, NN/g, Deci et al.'s verbal-reward
  finding); the primary papers are cited for checking.
- The timings (the pause before the pop-up, the bar's 4 seconds) are starting points and need trying on a phone (U9).
- The simulation assumes daily habits with steady odds; read its counts as orders of size.
