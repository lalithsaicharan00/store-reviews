# Schedules: which days a habit is due

Rules S-1…S-7. Sources: Rulebook D6 (schedules change from an effective date and keep their past), U3 (skipped, paused and
not-its-day days are neutral), Feature Ledger C016 ("a skipped day is not a missed day"), the pause report (29 Sep 2026),
Build Plan #60c (archive). Code: `HabitRules.isDue`, `matches`, `add`, `rule`.

`isDue(habit, day)` answers in this order; the first rule that decides wins.

## S-1 — Never due

1. A **skipped** day (asked with `countingSkips`; Today asks without, to keep the row as a neutral "Skipped").
2. A **paused** day: from a pause's first day through its last (no last day: until turned back on).
3. An **archived** habit, from its archive day on (spec/README "Reading saved data").
4. After its **end date** (quit habits have none that counts).
5. A **quit** habit: never due; it has no days to do.
6. Before its **first day** (DAY-9). (A task with a due day is decided by S-5 first.)

## S-2 — Fixed schedules

| Schedule | Due |
|---|---|
| Every day | every day |
| Weekdays {2, 4, 6} | Mon, Wed, Fri |
| Every N days | the first day and every Nth day after (`(day − first) mod N = 0`); N ≤ 1 every day |
| Every N weeks | the first day's weekday, every N weeks from the first day |
| Dates {1, 15, 31} | those dates; a date past the month's end falls on its last day (30 Sep, 28 Feb) |
| N times a week / month / year, N days a week / month / year | every day (any day can count) |

## S-3 — Calendar rules

Counted from the habit's first day ("start").

- **Every N days**: `(day − start) mod N = 0`.
- **Every N weeks on chosen weekdays**: the rule keeps the week start it was made with (`anchorWeekStart`), so a later
  change to the week start never moves its days. The week holding the start is week 0; a day is due when its week number
  (`(day − first day of the start's week) div 7`) is a multiple of N and its weekday is chosen.
- **Every N months**: months since the start's month a multiple of N, and
  - *Dates*: one of the dates, or the month's last day when a chosen date is past it and "use the last day" is on;
  - *Last day*: the month's last day;
  - *Weekday*: the chosen weekday, and either its Nth in the month (`(date − 1) div 7 + 1`) or, for "last", within the
    last seven days.
- **Every N years**: years since the start's year a multiple of N, the chosen month, and the chosen date (or the month's
  last day when it is shorter and "use the last day" is on; otherwise that year has none: 29 Feb in 2027).

## S-4 — After it's done

A habit or task that comes back a while after it's done (`afterCompletion(n, unit)`): due on every day it was done, and
from its first day until the first time it's done; after that, from `n` units after the last day it was done (up to the
day asked) onwards. A month later from 31 Jan is 28 Feb (29 in a leap year); a year later from 29 Feb is 28 Feb.

## S-5 — Tasks

- A **one-time task** is due on its day; still not done, it is also due **today** (it moves forward), never on the days
  in between.
- A **repeating task** follows its schedule like a habit. One occurrence can be **moved** (Reschedule): it is due on the
  new day and not on the old one (`move.<id>`); asked "by its own schedule" (`followingMoves` false) the moves are
  ignored.

## S-6 — Goal history

An edit that changes what judges a day (goal, how often, kind, unit, checklist steps) keeps the old rule **up to and
including the day before the edit** (`rules.<id>`, oldest first). Every rule of a day reads the rule in force that day:
the first saved rule whose last day is on or after it, else today's. Renaming a step or changing what + adds doesn't make
a new rule.

Example: "Read 3 times a day" was "once a day" until 14 Sep: 10 Sep needs one tick, 20 Sep three.

## S-7 — Skips, pauses and archives are neutral

A skipped, paused or archived day is simply not one of the habit's days: off Today (a skipped one stays as a neutral row),
no reminder, and neutral in the streak (ST-2), the ring and every percentage (P-3). A pause is kept after it ends, so past
paused days stay neutral. A week or month with a paused day can't end a period streak (ST-3).
