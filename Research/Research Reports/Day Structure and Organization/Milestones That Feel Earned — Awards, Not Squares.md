# Milestones That Feel Earned — Awards, Not Squares

Written by Claude (Claude Code), 11 October 2026, at the user's request: milestones on a habit's Progress tab feel like
"just another record … a bunch of squares filling up". They should feel like a reward, or a surprise, without being
gamified, and work for every habit type. Should every milestone be visible up front, since they're predictable?

It builds on [Milestones on the Habit Page — What to Mark and How to Show It](<Milestones on the Habit Page — What to Mark and How to Show It.md>)
(3 Oct: the ladder 3, 7, 14, 30 … and the In total track, kept unchanged here) and
[Milestones — Marking Progress Without Noise](<Milestones — Marking Progress Without Noise.md>) (30 Sep: no pop-ups,
confetti or notifications; the Undo-bar line announces a milestone). Evidence: [`Milestone Feel Evidence/`](<Milestone Feel Evidence/>)
(`scan.py`, output `milestone_feel_scan.json`).

## Answer

1. **Show reached milestones as awards, not squares.** A reached milestone is a round medal in the habit's colour, with
   its number, a fine inner ring and a soft shadow, on a lightly tinted plate: "3 days in a row · Reached 28 Sep". It
   is the only thing on the card that looks earned. No characters, levels, points or confetti.
2. **Show only the next milestone of each track, not the whole ladder.** "Next: 7 days in a row · 7 to go" and
   "10 times in total · 3 to go · 7 so far", each with a ring filling toward it. Later milestones (14, 30 … 5,000) are
   not drawn: each appears as the next one when the one before it is reached.
3. **Not hidden, not a surprise either.** Nobody asks for hidden milestones, and a fixed ladder can't stay a surprise.
   The reward moment is when one is reached: the Undo-bar line (30 Sep decision) and, the first time the Progress tab
   opens afterwards, the new medal arriving once (a gentle scale-in with a light haptic), then still.
4. **Every reached milestone stays,** newest first: the latest is large; earlier ones sit in a row of small medals under
   it ("the trophy shelf"), each with its date.

## What the reviews say

A fresh scan of all 1,238,784 store reviews (App Store and Play Store, every language) for reviews that mention
milestones, badges, trophies, achievements, awards, medals or rewards: 5,525 reviews. Because "reward" mostly means a
pet app's coins and outfits, a **strict pass** keeps only the named milestone words and leaves out apps whose reward is
a pet, plant or game: 1,397 reviews. Counts are keyword floors; I read the samples by hand, and the counts below are the
strict pass unless marked.

| Theme (strict pass) | Reviews | Apps | Mean ★ |
|---|---|---|---|
| Feels earned / proud / a sense of achievement | 109 | 32 | 4.74 |
| Wants to see what's next / a goal ahead | 52 | 22 | 4.04 |
| Wants something to unlock / earn | 23 | 14 | 3.43 |
| A collection / trophy case / all in one place | 15 | 10 | 3.93 |
| Lost / reset / disappeared | 15 | 8 | 3.00 |
| Date reached kept | 12 | 6 | 4.42 |
| Surprise / unexpected (almost all "pleasantly surprised by the app") | 10 | 8 | 4.10 |
| Hidden / secret milestones | 1 | 1 | 5.00 |

- **Earning something is what people want; seeing a number isn't enough.** Users show: "Adding badges to earn for
  certain landmark streaks" to fill a "trophy shelf" (Streaks, 5★, `1523739770`); "lacks rewards and unlockables"
  (Habit Tracker, 1★, `11435086274`); one expected the app "to provide some sort of sense of achievements"
  (Streaks, 3★, `1394831903`). A dated record that looks like any other row doesn't answer this.
- **A small, real marker works.** Users show liking "the little gold medals when you hit a new PR" (Hevy, 5★,
  `160a0fd2-8d03-450f-a72b-2f01742decc2`) and wanting rewards ("sounds + little animations") for milestones
  (TheFor, 4★, `40773031-9f48-404b-87a0-8da6de47ed72`); one wished for a "congratulations" at milestones
  (Days Since, 3★, `7788890241`).
- **People look at the next one, not the whole ladder.** Users show: "helped me stay focused on the next goal"
  (Days Since, 5★, `12293148259`); "I wanted to get to my next milestone", praising the app as "not in my face with
  graphics" (Days Since, 5★, `11645363660`). No review asks to see every future milestone.
- **Nobody asks for hidden or surprise milestones.** The strict pass finds one review mentioning anything hidden, and it
  isn't about milestones; the "surprise" reviews are about the app being better than expected. The full pass's 6
  "hidden / secret / mystery" reviews are pet- and game-app gifts or not about rewards at all.
- **Earned ones must stay, and keep their date.** Lost achievements after a reset or reinstall drive 3.0★ (15 reviews);
  people keep "all my milestones in one place" (Days Since, 5★, `14506145493`).
- **Too much is still disliked.** One user doesn't care about being told of 50 completed tasks and wants to turn it off
  (Productive, 3★, `6967636117`); another found the badges "confusing" and overstimulating (Fabulous, 3★,
  `11445769342`). The "childish / gamified / annoying" pass (66) is mostly about upsell nagging, so its count isn't
  used; the 3 Oct report's 102 milestone-talk complaints still stand.

## Reasoned from first principles

- **Why squares feel like a record:** the reached milestone, the next one and the later ones are the same shape, so
  nothing looks earned; it reads like the year grid. An award needs a shape of its own that only appears once it's
  earned. A medal (a circle with an inner ring) is the plainest thing people read as "awarded", needs no art, scales to
  any number and unit, and stays native: a circle, SF type, the habit's colour.
- **Why only the next one:** a long row of grey future squares reads as a to-do list of locked items, and far targets
  (2,500, 5,000 times) look unreachable. One target per track keeps attention where effort pays (people speed up as a
  goal gets near: the goal-gradient effect, Kivetz, Urminsky and Zheng, 2006). The ladder is predictable anyway, so
  nothing is lost by not drawing it; it's never secret, only not listed.
- **Why not a surprise:** a surprise reward works only when it can't be predicted; a fixed ladder can't stay a
  surprise, and making rewards unpredictable on purpose is a slot-machine technique the app doesn't use. What can be
  new is the moment: the first time you see the medal.
- **Works for every habit type:** the medal shows a number; the words under it carry the unit ("days in a row",
  "weeks in a row", "times in total", "days since a slip" for quit habits). Nothing depends on what the habit is.
- **Honest colour:** colour only on what was earned (the medal and its plate) and on progress (the ring), as U2.
  Nothing counts against anyone (U3): a broken run starts the ring again; reached medals never go.

## Limits

Keyword counts are floors and include noise (the app-icon "badge" and upsell "badgering" were excluded or read past).
The medal and next-only design is a product choice informed by these reviews and first principles; it hasn't been tried
with people or on a device.
