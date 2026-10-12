# Goals and completion

Rules G-1…G-9. Sources: Rulebook U10 (Progress counts habits, not ticks), U14 (the round button fills, and the sound
plays, only when the goal is met; ✓ toggles a once-a-day tick, + adds and never takes back), U25 (a week or month goal
fills toward that period's goal; limits stay neutral), Build Plan #60a–#60b, Current Work 54. Code: `HabitRules.dayGoal`,
`dayProgress`, `isDayMet`, `isTotal`, `loggedTotal`, `periodTotal`, `periodCount`, `progress`, `goal`, `isDone`,
`flexibleProgress`, `isComplete`, `isSatisfied`, `isPeriodMet`, `countsUp`, `dayFraction`, `outcome`, `dayMark`.

Each answer reads the rule of its day (S-6).

## G-1 — The day's goal

| Kind | Day's goal |
|---|---|
| Check | its goal (1, or N for "N times a day"; N for "N times a week" too: see G-6) |
| Amount, time | the amount, the minutes |
| Checklist | the number of its steps (at least 1) |
| Task | 1 |

## G-2 — What was logged on a day

- The sum of the day's logs (check ticks count 1 each; amounts and minutes their value).
- A **checklist**: how many of its current steps were ticked that day (a step ticked twice counts once; steps no longer on
  the list don't count).
- A **one-time task**: 1 once it has any log, on any day; a **repeating task**: 1 on a day with a log.
- A **running timer** adds the minutes since it started, to today only (DAY-1 of "now").

## G-3 — The day's goal met

At least: logged ≥ goal. **At most** (a limit, "no more than 2 coffees"): logged ≤ goal, so an empty day is within it.

## G-4 — Totals over a period

An amount or time on a week, month or year rule ("100 pages a week") is a **total** for the whole period.

## G-5 — Counting a period

- A **check counted N times a week, month or year**: every tick in the period counts, even two on one day.
- Anything else on a period (N days a week, a checklist on N days): the days in the period, from the habit's first day
  through its end date, on which the day's goal was met.

## G-6 — What a row shows

`progress` is what a Today row and widget show next to the goal (`goal`):

| Rule | Progress | Goal |
|---|---|---|
| Total a week / month / year | the period's total (with a running timer) | the total |
| N times a week / month / year | the period's ticks | N |
| N days a week / month / year | the day's own amount | the day's goal |
| Anything day by day | the day's amount | the day's goal |

## G-7 — Done, complete, satisfied

- **Done** (`isDone`): a task once it has a log (G-2); a period total within or past its goal (at most / at least); a
  period count at its goal; otherwise the day's goal met. Never for a quit habit.
- **Flexible progress**: met days so far in the period ("2 of 3 days"), for N-days rules only.
- **Period met**: the N days reached, for N-days rules; otherwise done.
- **Complete**: done, or an N-days rule whose period is met.
- **Satisfied** (done for the day on Today, the player and reminders): complete, or — for a week, month or year count or
  total that isn't a limit — anything logged that day ("Gym 3 times a week" is done for today once today has a tick).

## G-8 — The round button

A **check** habit's button **counts up** (each tap adds one, Undo takes one back) when it is ticked several times a day
or N times a week, month or year; otherwise ✓ toggles the day. The button fills (and the completion plays) only when the
goal is met: today's for several a day, the period's for a week or month goal (U14).

## G-9 — How one habit's day counts, and its mark

**Outcome** (`outcome`, for the rings, the day bar and Progress):

| Situation | Outcome |
|---|---|
| Quit habit, before its first day, or not due (S-1…S-5) | neutral |
| Task | done once done; before today not done; else open |
| Week, month or year count or total | a limit: neutral; something logged that day: done; today and the period not met: open; else neutral |
| N days a period | something logged: done if the day's goal is met, else part (the share reached); today and the period not met: open; else neutral |
| Daily limit | before today: done within the limit, not done over it; today or later: neutral |
| Anything else | goal met: done; a later day: open; something logged: part; today: open; earlier: not done |

The **share** of a day's goal is `logged ÷ goal`, between 0 and 1 (0 for a goal of 0).

**Mark** (`dayMark`, a habit's own calendar; never a harsh mark for a miss, U3): before its first day *before*; paused
*paused*; skipped *skipped*; a later day *upcoming* when due, else *not its day*. Then for a period rule (a count, a total
or N days): something logged is *done* (a limit's logged day is *some*; an N-days day short of its goal is *some*),
nothing logged is *open* today when due, else *not its day*. For day-by-day rules: not due *not its day*; a daily limit
today *some* or *open*, earlier *done* within it, *missed* over; otherwise *done*, *some* (something logged), *open*
(today) or *missed*.
