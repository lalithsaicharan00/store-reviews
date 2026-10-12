# The habit rules — specification

Written by Claude (Claude Code), 12 October 2026, for Current Work item 92: the rules that decide which day a log belongs
to, which days a habit is due, what its goal is and whether it was met, streaks and runs, and how a day counts across
habits. One copy, in the shared Kotlin core (`Core/rules/`, package `app.habits.rules`), for iPhone, iPad, Apple Watch,
Mac and Android ([Shared Core Decision](<../../Architecture/Shared Core Decision.md>)).

**These pages describe what the iPhone did on 12 October 2026, exactly.** The golden cases (`Core/fixtures/`) were
recorded by running the iPhone's own code (`GoldenRecorder.swift`) and the Kotlin rules must give the same answer to
every one (`GoldenTest`). Where the iPhone's behaviour looks wrong it is written down under **Differences found**, and it
is not changed here: a change to a number people see is a product decision (Rulebook: "a product rule changes only with
the user's say-so").

| Page | Rules |
|---|---|
| [day.md](day.md) | DAY-1…DAY-11: which day a moment belongs to, the day start, daylight saving, a log's own day, day bounds, weeks, months, years, leap days, a habit's first day |
| [schedules.md](schedules.md) | S-1…S-7: which days a habit is due: every schedule, tasks, start and end dates, goal history, skips, pauses, archives |
| [goals.md](goals.md) | G-1…G-9: the day's goal and progress, totals over a week, month or year, done, satisfied, the round button, a day's outcome and its mark |
| [streaks.md](streaks.md) | ST-1…ST-7: streaks, runs and the best streak for every kind of goal, quit runs, the Apple Watch's 400 days, milestones |
| [progress.md](progress.md) | P-1…P-4: where a habit shows on Today, Today's cards, a day across habits, and what the screens built on these rules read |
| [differences.md](differences.md) | What the iPhone does that looks wrong or surprising, kept as it is until the user decides |

## Words used on every page

- **Day**: the person's own date ("2026-09-25"), independent of time zone. In the core a day is a number: days since
  1 January 1970 (`Day.of`). Weekdays are numbered 1 = Sunday … 7 = Saturday, as Apple's `Calendar` numbers them.
- **Moment**: a point in time, epoch milliseconds.
- **Now**: an input. No rule reads a clock; `HabitRules` is given one (`clock`), and every rule that needs "now" takes
  it from there (the iPhone's store does the same since 12 October 2026: `isDue`, `dayProgress`, `progress`,
  `periodTotal` and `quitRuns` used to read the wall clock directly; the app's clock *is* the wall clock, so nothing
  people see changed).
- **Rule of a day**: the goal, schedule, kind, unit and checklist steps a habit was judged by on that day (S-6).
- **Due**: one of the habit's days. **Planned**: due, ignoring a skip (a skipped day stays on Today as a neutral row).
- **Period**: a day, or the week, month or year holding it.

## Reading saved data

The rules read the database's own rows, field for field as `Core`'s records name them (`Rows.load`):

- **Habits** in order of `position`, then `created_at`; a habit whose `kind` or `frequency` this version can't read is
  left out (the iPhone does the same; it also leaves out a habit with an unknown `color`, which the rules don't read).
  Tombstones (`deleted_at`) are left out.
- **Steps** by `position`; **times** (`reminder` rows) by hour and minute; **logs** by `created_at`, only for habits
  that are read.
- `frequency`: `daily`, `weekdays:2,4,6`, `every:3`, `weeks:2`, `dates:1,15`, `week:3`, `month:4`, `year:6`, or `v2:`
  and base64 of Swift's JSON for `Frequency` (`{"flexible":{"_0":"week","_1":3}}`, `{"calendar":{"_0":{…}}}`,
  `{"afterCompletion":{"_0":2,"_1":"week"}}`). A calendar rule must carry every field, or Swift's decoder (and so the
  rules) can't read the habit.
- **Settings** (`setting` rows): `day_end_hour` (0…12), `week_start` (1…7; missing: the phone's region), `day_sections`
  and `today_order` (JSON), and per habit `skip.<id>` (days, comma-separated), `move.<id>` (`from>to`, comma-separated),
  `pause.<id>` (JSON `[{"from":{"year","month","day"},"through":…,"pausedAt":s,"resumedAt":s}]`, moments in seconds
  since 1 January 2001, Swift's `Date`), `rules.<id>` (goal history, JSON `[{"until":…,"goal","frequency","kind",
  "checkUnit","steps":[{"id","name"}]}]`), `archived.<id>` (a day), `timer.<id>` (`ms` or `ms|section`).
- An archived habit with no `archived.<id>` stopped the day after its last log, or on its first day with none.
