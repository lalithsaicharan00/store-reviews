# The day

Rules DAY-1…DAY-11. Sources: Rulebook D7 ("a day is the local calendar day at the moment of logging … never subtract hours
from a moment"; "Today is `store.today()`"), Architecture 05 §4.1–4.3, Build Plan #61. Code: `HabitRules.today`,
`dayBounds`, `period`, `startDay`, `quitStartDay`, `dayStart`, `dayStartMoment`; `Day`; `Zone`.

## DAY-1 — Which day a moment belongs to

A moment belongs to its **calendar date on the phone's clock**, in the phone's current time zone. With a day start
(DAY-2), a moment whose clock hour is before the start hour belongs to the day before.

| Moment (London) | Day start | Day |
|---|---|---|
| Fri 25 Sep 2026 00:00 | midnight | Fri 25 Sep |
| Fri 25 Sep 2026 23:59 | midnight | Fri 25 Sep |
| Sat 26 Sep 2026 02:59 | 3 AM | Fri 25 Sep |
| Sat 26 Sep 2026 03:00 | 3 AM | Sat 26 Sep |

**Today** is the day "now" belongs to (`today()`); nothing else is ever "today" (D7).

## DAY-2 — The day start

The hour a new day starts, 0 (midnight) to 12 (noon); values outside are clamped. Logs already saved keep their day;
everything else follows the new hour at once, past days included (Progress, streaks, the player, reminders).

## DAY-3 — Daylight saving, both ways

The day starts **when the clock says** the start hour, never "midnight plus N hours". On the night the clocks go forward
past the start hour, the day starts at the first moment that exists after it; when an hour happens twice, at its first
occurrence.

- New York, 8 Mar 2026, clocks go from 2:00 to 3:00. With a 2 AM day start, Sunday starts at 3:00 EDT (= 07:00 UTC);
  1:59 EST still belongs to Saturday.
- London, 25 Oct 2026, 1:00–2:00 happens twice. With a 1 AM day start, Sunday starts at the first 1:00 (BST);
  the second 1:00–1:59 (GMT) is Sunday too.
- Lord Howe Island (half-hour change), 4 Oct 2026, 2:00 → 2:30: with a 2 AM start, Sunday starts at 2:30.

## DAY-4 — A log keeps its day

A log is saved with the day it counts for and the time zone it was made in, and **its day never moves**: travelling,
changing the day start or the time zone afterwards changes nothing (Architecture 05 §4.1). Every rule reads the saved day,
never the log's moment, except quit habits (ST-5), whose slips are moments.

Example: logged at 23:00 in Tokyo for the 23rd, then read in Los Angeles: still the 23rd.

## DAY-5 — A day's bounds

A day runs from its start (DAY-3: the start hour on the clock that day) to one second before the next day's start. A log's
time is kept within its own day (`dayBounds`, the editor's time picker; U19). The bounds are worked out in the zone given
(the log's own for a saved log).

| Day | Zone | Start | Last moment |
|---|---|---|---|
| Sun 29 Mar 2026 | London, midnight start | 00:00 GMT | Sun 23:59:59 BST (a 23-hour day) |
| Sun 8 Mar 2026 | New York, 2 AM start | 03:00 EDT | Mon 01:59:59 EDT |

## DAY-6 — Weeks, months and years

- A **week** starts on the person's week start (1 = Sunday … 7 = Saturday; "Automatic" follows the phone's region) and
  holds seven days: the week holding a day starts `(weekday − weekStart + 7) mod 7` days before it.
- A **month** and a **year** are the calendar's.
- Changing the week start re-counts every week, past weeks too (week goals, week streaks, Progress).

Example: weeks from Monday, Sun 27 Sep 2026 is in the week Mon 21 – Sun 27; from Sunday, in Sun 27 – Sat 3 Oct.

## DAY-7 — Weekdays

1 = Sunday … 7 = Saturday. 1 January 1970 was a Thursday (5).

## DAY-8 — The Gregorian calendar

Days are Gregorian: leap years every 4 years except centuries not divisible by 400. 29 February 2028 exists, 2027 doesn't.
A date "the 31st" falls on the month's last day in a shorter month where a rule says so (S-2, S-3).

## DAY-9 — A habit's first day

A habit counts from its **start date** if it has one (past or future), otherwise from **the calendar date it was made**
on the phone's clock, *not* moved by the day start: a habit made at 1:00 with a 3 AM day start starts on the calendar date
(the day after the person's "today"). The New Habit form now always saves a start date from `store.today()` (Rulebook D7,
6 Oct 2026), so this only matters for habits made before that.

## DAY-10 — A quit habit's first day

The day (DAY-1) of the earlier of when it was made and its "Started" moment.

## DAY-11 — When a day begins, as a moment

- **`dayStart`**: on the clock (DAY-3). A pause that ended by itself gives a quit habit back at the start of the day
  after its last day (ST-5).
- **`dayStartMoment`**: midnight plus the day-start hours, *not* on the clock. Used only by the quit habit's statistics
  on its page (how much of a run fell in a period). On a night the clocks change between midnight and the start hour it
  is an hour off DAY-3; see [differences.md](differences.md) #3.
