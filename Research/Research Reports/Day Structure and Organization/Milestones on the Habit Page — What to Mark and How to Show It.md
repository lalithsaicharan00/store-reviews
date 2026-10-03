# Milestones on the Habit Page — What to Mark and How to Show It

Written by Claude (Claude Code), 3 October 2026, at the user's request: "improve this milestones … it should look good
… not a gamified way … A milestone just text, it doesn't feel like a milestone … presented like the ones that you
achieved and as well as the ones that is about to come … do some research about milestones as well, like what
milestones we need to have in the first launch."

It builds on [Milestones — Marking Progress Without Noise](<Milestones — Marking Progress Without Noise.md>) (30 Sep:
a milestone is a line beside the Undo, never a pop-up; worked out from the history, never stored) and on the Habit
Details research's milestone summary (`Habit Details Research/`, Progress revised: current and next progress visible,
reached history kept). Evidence: [`Milestone Ladder Evidence/`](<Milestone Ladder Evidence/>) (`scan.py`, output
`milestone_scan.json`).

## Answer

1. **Two tracks, each a row of milestones you can see:**
   - **In a row:** 3, 7, 14, 30, 50, 100, 200, 365, 500 and 1,000 days (then every year); weeks 2, 4, 8, 12, 26, 52;
     months 3, 6, 12. Quit habits keep their time since the last slip, as the app already counts it: 1, 3, 7, 14,
     30, 60, 90 and 180 days, then every year.
   - **In total:** the goal met 10, 25, 50, 100, 250, 500 and 1,000 times (days, weeks or months, in the habit's own
     unit). A break never takes these away.
2. **Shown as the app's own squares,** not badges: a reached milestone is a filled square in the habit's colour with its
   number and the date it was reached; the next one is outlined, filling with progress, with "9 to go"; later ones are
   plain grey. Above the row, one line in words: "Next: 30 days in a row · 9 to go".
3. **One card on the habit's Progress tab,** under the overall record. No confetti, no characters, no exclamation
   marks; the Undo-bar line from 30 Sep stays the only moment a milestone is announced.

## What the reviews say

A fresh scan of all 1,238,784 store reviews, every language, for reviews that mention streaks, milestones, badges,
trophies or achievements (10,054 reviews), counting the numbers written next to "days", "weeks", "months" or "years".
Counts are keyword floors; I read samples by hand.

| Number people write in streak talk | Reviews | Number | Reviews |
|---|---|---|---|
| 3 days | 135 | 2 years | 51 |
| 7 days | 97 | 3 months | 40 |
| 30 days | 86 | 2 weeks | 36 |
| 5 days | 78 | 90 days | 30 |
| 2 days | 70 | 6 months | 29 |
| 100 days | 59 | 200 days | 26 |
| 10 days | 42 | 1 year / 365 days | 25 / 13 |
| 14 days | 21 | 50 days | 19 |
| 21 days | 22 | 500 days | 10 |

- **The first days matter most.** 3 days (135) and 7 days (97) are the most written streak lengths, ahead of 30 (86)
  and 100 (59). Our 30 Sep ladder began at 7: someone starting out waited a week for anything. Adding **3** and **14**
  gives a first marker in the first week and another before the month.
- **Round markers further out are real too:** 50, 100, 200, 365 and 500 days all appear. 21 and 66 days appear as
  "habit-forming" numbers (22 and 3 reviews in milestone talk); there is no evidence they form a habit, so they're
  left out (the Habit Details research excludes habit-formation claims).
- **People want markers to work toward.** Users show: "Adding badges to earn for certain landmark streaks would create
  extra motivation. A badge for 5 days, 10 days" (Streaks, 5★, `1523739770`); "A little trophy case" (Streaks, 4★,
  `1303958312`); "keep track of all my milestones in one place" (Days Since, 5★, `14506145493`).
- **Losing everything to one missed day discourages.** Users show: "discouraging to lose my entire streak for missing
  just one day" (Finch, 5★, `12224721380`); a tracker should keep "personal best (longest streak) and total
  completions" (Way of Life, 5★, `1065171792`). Hence the **In total** track, which a break can't reset.
- **Reached milestones must stay.** Users show: "Why are long term goals & milestones disappearing" (Finch, 4★,
  `14299934656`).
- **Seeing them as a calendar of marks is itself rewarding.** Users show: "Seeing a full month of checkmarks … It's
  like having a visual trophy case" (Habio, 5★, `11798929798`). This is why milestones reuse the heat map's squares.
- **Gamified celebration still divides people.** 102 reviews in milestone talk use "childish", "gamified", "cheesy",
  "annoying" or "confetti" (mean 3.32★, against 4.05★ for reviews about seeing what's next). Users show: "it feels very
  child-like … We should be able to turn this forced encouragement off" (Me+, 4★, `12010228356`). So: no badges with
  characters, no levels, no pop-ups.
- **Sharing a milestone is liked** (6 reviews, 4.83★: "nice, clean design to share milestones", Days Since, 5★,
  `13147527588`). Not built now; noted for later.

## Reasoned from first principles

- **A milestone should look like the thing it marks.** The heat map is a day as a square; a milestone is a run of
  squares, so a bigger square with its number reads as "this many squares". It needs no new visual language and stays
  native: rounded rectangles, SF type, the habit's colour.
- **Reached, next and later at a glance.** Filled = reached (with its date, so it's a record), outlined and filling =
  the one you're working toward, grey = later. The row scrolls sideways and opens on the next one, like the year.
- **One line of words over the shapes** says the only thing that changes week to week: what's next and how far.
- **The In total track answers the review complaint directly:** a break starts the run again but never takes away
  "50 times in total".
- **Units are the goal's own:** days for daily goals, weeks for weekly goals, months for monthly ones; quit habits use
  time since the last slip. Never days for a weekly goal.
- **Dates come from the history:** a milestone's date is the day the run (or the total) reached it, worked out from the
  records, so editing an entry moves or removes it honestly.

## Limits

Keyword counts are floors and include some noise ("badge" also means the app icon's red count; those were excluded
from the quotes, which were read in full). The numbers count how often people write a length, not which ladder works
best; the ladder is a product choice. Not yet tried with people or on a device.
