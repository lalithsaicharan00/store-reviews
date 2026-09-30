# Progress Page — Build

Written by Claude (Claude Code), 30 September 2026. Build Plan #60. Branch: `progress-page-research`, which includes the `sidebar` branch. Spec: [Progress — What to Build, in Order](<../Specs/Progress — What to Build, in Order.md>).

**Context (the user's words, tidied):** start with #60 and build the Progress page. Make sure it's fast. Check thoroughly for bugs and anything else wrong.

| # | Point | Done |
|---|---|---|
| B1 | Start with #60, in the order the spec sets: the fixes that come first, then the Progress page | [x] 60a, 60b and 60c first (`HabitStore`: `isSatisfied`/`isComplete`, `dayScore`, `dayMark`, `streak`, `runs`, `archivedOn`), then 60e. 60d (Log a Slip) is left for Phase 2, as the spec allows |
| B2 | Build the Progress page, opened from the ≡ menu's Progress row | [x] `ProgressScreen` in `MenuPage`: Week and Month, day rings, three numbers, last-period line, habit rows with strips, Quitting and Archived, Day sheet with Show on Today, How It's Counted, view options, empty state. Habit page: total line, tap-a-day popover, Over Time |
| B3 | Make it fast: numbers worked out once per change, never while drawing, measured by the speed tests | [x] in code: one snapshot per data change (`dataVersion`), cached per period; strips drawn with `Canvas`. Speed tests `testProgress` and `testProgressHabitPage` (30 habits, two years) added; results: see below |
| B4 | Check thoroughly for bugs and anything else wrong: golden cases, UI tests on GitHub, reading the code again | [ ] `-progresscheck` (G1–G17 and the fixes) and `ProgressUITests` written and added to `[ios-ci]`; results: see below |

## Decisions made while building

- **The overview counts habits, not times** (report §16.4 updated): it must agree with Today's day bar, which counts habits. A habit done 1 of 3 times fills the ring part of the way; its own row counts times.
- **Two meanings of "done" in the routine player:** its segments and queue use *done for today* (a weekly habit ticked once today), its main button uses *nothing more to do* (so "Log one" stays for a weekly habit at 1 of 3).
- **The archive date is stored in the settings table** (`archived.<id>`), so no database change was needed. Habits archived earlier get the day after their last log.
- **Past days of a weekly goal with nothing logged are blank**, not "not done yet", in the habit's calendar and Progress's strips.
- **Year on Progress, Runs, By Weekday and quit sections are Phase 2** (#60f), as planned.

## Results

Filled in after the GitHub runs.
