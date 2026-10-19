# Streaks, runs and quit runs

Rules ST-1…ST-7. Sources: Rulebook D6 (streaks are computed from records, never stored), U3, U34 (the Watch's 400 days),
spec "Habit Progress — Overall Record, Streaks and Milestones" §4, report §16.5–16.8, Build Plan #60b, #60d. Code:
`HabitRules.streak`, `runBefore`, `runs`, `bestStreak`, `slips`, `quitHistory`, `quitRuns`, `resumeMoment`.

Quit habits and tasks have no streak (0) and no runs.

## ST-1 — The current streak

The streak on a day is **the current period, if met, plus the run before it**:

- The current period (the day itself, or the week, month or year holding it) adds 1 **only once it is met**, so an
  unfinished today never breaks a streak.
- A **limit's** current period adds 1 only once it is over (its day before today, its week or month once past).

Its unit follows the goal: days (every day), times (other day schedules), weeks, months or years.

## ST-2 — The run before, day by day

Walking back from the day before: a **due** day that was met adds 1; a due day not met ends the run; a day that isn't due
(not its day, skipped, paused, archived) is neutral and skipped over. The walk stops at the habit's first day, and where
the rule of a day (S-6) is judged in a different kind of period (a change from daily to weekly starts the streak again).

Example: done 1–5 and 8–24 Sep, 25 Sep (today) not yet: the streak today is 17 (8–24); 6 Sep, a due day not done, ends it.

## ST-3 — The run before, period by period

For a week, month or year goal: walking back period by period from the one before the current one, a met period adds 1;
an unmet one ends the run **unless a pause touched it**. The walk stops at the habit's first day and at a change of
period kind.

## ST-4 — Runs and the best streak

Every run, oldest first, from the habit's first day to today, walked the same way as ST-1–ST-3 (in today's kind of
period): a run is its first and last day and its length. Today adds once it's done and never ends a run; a limit's day or
period counts only once it's over, and the one running now never ends a run. The last run is **current** when nothing
has ended it; then its length is the streak. The **best streak** is the longest run, so the best, the run list and the
current streak always agree.

## ST-5 — Quit runs

A quit habit's **slips** are moments: each log's own time (up to now), and a later "Started" date counted as one more.
Its **runs**: from its start (the earlier of when it was made and "Started") each slip ends a run and starts the next; a
**pause** ends the run it interrupts (kept as a run, not a slip) and turning it back on starts a new one — by hand at that
moment, or when the day after the pause's last day begins (DAY-11). While paused there is no current run. The
**current run** is the one going on now (0 while paused) and the **best** is the longest, in seconds.

## ST-6 — The Apple Watch's 400 days

The Watch reads only its last 400 days of logs (every log of a quit habit or a task), so a count that needs older logs
is not shown rather than shown smaller (U34, WA11): the golden cases record the Watch's streak, best and whether the
habit has logs before the window.

## ST-7 — Milestones

Lengths worth marking, from the streak (never stored): days and times 3, 7, 10, 14, 30, 50, 75, 100, 150, 200, 250,
365, 500, 730, 1,000, then every 365 after 730; weeks 2, 3, 4, 6, 8, 10, 12, 16, 20, 26, 39, 52, 78, 104, then every
52; months 2, 3, 4, 5, 6, 9, 12, 15, 18, 24, 30, 36, then every 12; years every year. Goals met in total: 10, 25, 50, 100,
250, 500, 1,000, 2,500, 5,000 (month goals add 3 and 6 first, year goals 2 and 5). Code: `Milestones`.

## ST-8 — Milestones, the decided rule (17 Oct 2026)

Replaces ST-7's lists once the iPhone and the habit page use it; until then ST-7 and its golden answers stay. The user's
decision, Figma *Milestones: one simple rule* (`2266:2`), [Android/Docs/Milestones](<../../Android/Docs/Milestones — Every Habit Type and Every Milestone.md>).
Code: `MilestoneRule` (tests: `MilestoneRuleTest`).

- **The bucket, by two questions.** A goal for a week, a month or a year (3 times a week, Flexible) is that bucket. Set days
  go by the longest gap between them: under 7 days Days, 7–27 Weeks, 28 days up to a year Months, a year Years (a month
  counts 30 days).
- **In a row** (the streak, ST-1, in its own unit): Days 3, 7, 14, 30, 60, 90, 180, 365, then every 365; Weeks 2, 4, 8,
  13, 26, 52, then every 52; Months 2, 3, 6, 9, 12, then every 12; Years none.
- **Pop-up lengths** (landmarks): Days 30, 180, 365 and each year; Weeks 4, 26, 52 and each year; Months 6, 12 and each year.
- **In total**, as times the goal for one period (set days: one day's goal): Days 10, 25, 50, 100, 250, 500, 1,000, then
  every 500; Weeks 10, 25, 50, 100, 250; Months 5, 10, 25, 50, 100. Everything logged counts, met or not; a fall (undo)
  crosses nothing; when one log crosses two, the higher one.
- **Anniversaries:** each year on the date of the first log (quit: the quit), 29 February on 28 February in other years.
