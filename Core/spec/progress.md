# Today and Progress: where habits show and how a day counts

Rules P-1…P-4. Sources: Rulebook U10 (Progress counts habits, not ticks; it must agree with Today's day bar), U13 (order
is the person's own; timed sections follow their times; Anytime and Quitting are placed by the person), U26 (a widget
only draws what the app worked out), "Time of Day and Reminders — What Users Want", Arrange Your Day (3 Oct 2026).
Code: `HabitRules.placements`, `timedSections`, `sectionForMinute`, `dayMinute`, `todayCards`, `cardMembers`,
`dayScore`, `todayScore`.

## P-1 — Where a habit shows on Today

- A **quit** habit has no row in the times of day (it's on the Quit or Cut Down card, with limits: `isQuitOrLimit`).
- A habit's **times of day** (`parts`) decide where it shows; an unknown ID means Anytime. Its times never move it.
- One time of day: one row there, holding all its times. Two or more: a row in each (in the sections' order), **one
  shared progress** (the goal is never split; the user, 28 Sep 2026). Each time goes to the row of its own time of day,
  or, outside them all, to the row whose time of day starts last before it (or the first).
- Times sort by the person's day: with a day start, times before it come after midnight (`dayMinute`: 1:00 with a 3 AM
  start is 25:00).
- A **timed section** ends where the next begins; the latest ends at its own end, or 24:00 plus the day start. A time
  before the first section counts as the first; after the last's end, as the last.

## P-2 — Today's cards

Top to bottom: the timed sections in time order, with **Anytime** and **Quit or Cut Down** where the person put them
(both at the top by default). A time of day added later goes just after the one before it in time. Each card holds every
habit and task placed there, in the person's own order (archived habits and one-time tasks already done aside; quit
habits and limits on the Quit or Cut Down card).

## P-3 — A day across habits

`dayScore(day, habits)` adds each habit's outcome (G-9): done adds to done and planned; part adds its share and to planned;
not done and open add to planned; neutral adds nothing. The **fraction** is `(done + part) ÷ planned` (at most 1); a
**full day** is every planned habit done (or, with Progress's Full Day option, 80% or 60% of them, counting only done).
Today's **day bar** ("done of planned") is the score of every habit and task that isn't archived (`todayScore`). The
calendar sheet and Progress use the same score, so they always agree.

## P-4 — The screens built on these rules

Progress (Week, Month, Year, the week cards, the year's dots), the habit page (its overall record, Over Time, the
weekday chart, a quit habit's statistics) and the widgets' snapshot are built from the rules above in the iPhone's Swift
(`HabitStore+Progress`, `+WeekCards`, `+HabitPage`, `+OverTime`, `+Phase2`, `+Widgets`), with its words. The golden
cases record them whole (`full` in Core/fixtures), so moving the rules underneath can be checked to change nothing
people see (Current Work 92, checkpoint 2).
