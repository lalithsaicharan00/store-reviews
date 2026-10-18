Written by Claude (Claude Code), 17 October 2026, for the user. Revised the same day, three times, until the user
said: "The two-question rule is clear. Let's keep this version."

# Milestones — Every Habit Type and Every Milestone

**The rule, decided (the user, 17 Oct 2026).** It's drawn in Figma: *Milestones: one simple rule* (`2266:2`), in
*Habit details*. Every habit gets two tracks, **in a row** and **in total**, plus **anniversaries**. Which lists a
habit climbs is decided by one of four buckets.

## 1. Pick the bucket: two questions

1. **Is the goal for a week, a month or a year?** ("3 times a week", "2 times a month", "twice a year".) If yes, that's
   the bucket. Stop.
2. **No, it has set days. How far apart are they?**

| How far apart | Bucket |
|---|---|
| under 7 days | **Days** |
| 7 to 27 days | **Weeks** |
| 28 days up to a year | **Months** |
| a year | **Years** |

So "3 times a week" is **Weeks** (question 1), and Mon/Wed/Fri is **Days** (its days are 2–3 days apart).

## 2. Each bucket's lists

| Bucket | Examples | In a row | In total |
|---|---|---|---|
| **Days** | every day · Mon/Wed/Fri · every 3 days · weekdays | 3, 7, 14, 30, 60, 90, 180, 365 days, then every year | 10, 25, 50, 100, 250, 500, 1,000 × the goal for one day, then every 500 |
| **Weeks** | 3 times a week · every Monday · every other Saturday · the 1st and 15th | 2, 4, 8, 13, 26, 52 weeks, then every 52 | 10, 25, 50, 100, 250 × the goal for one week |
| **Months** | 2 times a month · the 1st of the month · the first Saturday · every 4 weeks | 2, 3, 6, 9, 12 months, then every 12 | 5, 10, 25, 50, 100 × the goal for one month |
| **Years** | 2 times a year · a yearly date | — | — (anniversaries only) |

**How each track counts:**
- **In a row** counts its periods in a row with the goal met. Set-day habits count their planned days and say
  *times* ("6 times in a row").
- **In total** counts everything logged, even on a day the goal wasn't met. A missed day never takes anything away.
  The goal it multiplies is one period's (for set days, one planned day's).

**Examples of totals:**
- Stretch, once a day: 10, 25, 50, 100 times.
- Meds, 3 a day: 30, 75, 150 times.
- Water, 8 glasses: 80, 200, 400 glasses.
- Steps, 10,000: 100k, 250k, 500k.
- Meditate, 10 min: 100, 250, 500 minutes.
- Gym, 3 a week: 30, 75, 150 visits.
- Call family, 2 a month: 10, 20, 50 calls.
- Run 5 km on Mon/Wed/Fri: 50, 125, 250 km.
- Clean the fridge on the 1st: 5, 10, 25 times.

**The other kinds of habit:**
- **Cut down** counts days (or weeks) within the limit, never what was had.
- **Quit** counts days since a slip (plus 1 day at the start) and clean days in total.
- **A checklist** counts a day once all its steps are done.
- **A task** has none.

## 3. Anniversaries

Each year since the first log (for quit, since the quit), if the goal was met in the last 30 days. A Years habit gets
only these. On the day a run reaches a year, only the run's milestone is shown.

## 4. Pop-up, bar or just the row

### A · The normal rule: what each milestone gets

- **Pop-up:**
  - in a row at 1 month, 6 months and each year (Days 30, 180, 365 · Weeks 4, 26, 52 · Months 6, 12);
  - every anniversary;
  - the very first milestone anyone reaches in the app, whatever it is.
- **Bar:**
  - every other milestone, the first time it's reached (the other in-a-row numbers, and every total);
  - *your best run again*: a new run reaching your old best (14 or more), at most once a habit in 30 days.
- **Just the row:** a number reached before. A run that starts again doesn't give its numbers twice.
- **Habit page only:**
  - history added later (backfilled, imported, restored);
  - a second milestone for the same habit on the same day;
  - one undone and done again.

### B · The limits: these override the normal rule, every time

1. **Pop-ups: 1 a day, never more.** Once a day has had its pop-up, the next one goes down a level: to a bar, or to
   just the row if the day has no room left. And there are no more than 2 pop-ups in any 7 days.
2. **Bars: 2 a day, never more.** Once a day has had 2 bars, the next one is just the row.
3. **Big moments: 2 a day in total.** That's a pop-up and a bar, or 2 bars. After 2 big moments, everything that day
   is just the row.

### C · When it shows: at once (the user, 17 Oct 2026: "Simple rule. Don't complicate things")

As soon as a habit is marked done, its milestone shows. There's no waiting.

**It's first come, first served through the day:**
- The first habit done that has a pop-up gets the pop-up.
- One that has a bar gets the bar.
- Anything else plays the row animation.

**Once the day's limit is used** (a pop-up and a bar, or two bars), everything else that day is just the row.

**Done away from Today** (widget, watch, notification, a quit clock, a cut-down day's end): the band plays in its row
when the row is first seen, and a pop-up's band has See.

**Never on the same day:** in a row and in total share no number. Someone who never misses gets them in turn: 3, 7,
10, 14, 25, 30, 50, 60, 90, 100 days.

## 5. The milestone notification (quit and cut down only)

- **It's off by default.** A switch, *Tell me at milestones*, on a quit or cut-down habit's form turns it on. Android
  asks for permission the first time.
- **It comes for the pop-up milestones only:** 30 days, 180 days, a year and each year after.
- **Quit:** on the day, around midday.
- **Cut down:** the day after the day closed, around midday.
- **It's never at night.**
- **Tapping it** opens Today with that milestone's pop-up.

## Still to do

- **The designs match this rule** (18 Oct 2026): bars, pop-ups, the routine player, row animations, the habit page and
  the widget examples.
- **The shared rules' code** (`Core/rules/…/Milestones.kt`) changes to this when milestones are built: the spec, the
  Kotlin and the golden answers together (Rulebook T21).
