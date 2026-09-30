# Progress Page — Build

Written by Claude (Claude Code), 30 September 2026. Build Plan #60. Branch: `progress-page-research`, which includes the `sidebar` branch. Spec: [Progress — What to Build, in Order](<../Specs/Progress — What to Build, in Order.md>).

**Context (the user's words, tidied):** start with #60 and build the Progress page. Make sure it's fast. Check thoroughly for bugs and anything else wrong.

| # | Point | Done |
|---|---|---|
| B1 | Start with #60, in the order the spec sets: the fixes that come first, then the Progress page | [x] 60a, 60b and 60c first (`HabitStore`: `isSatisfied`/`isComplete`, `dayScore`, `dayMark`, `streak`, `runs`, `archivedOn`), then 60e. 60d (Log a Slip) is left for Phase 2, as the spec allows |
| B2 | Build the Progress page, opened from the ≡ menu's Progress row | [x] `ProgressScreen` in `MenuPage`: Week and Month, day rings, three numbers, last-period line, habit rows with strips, Quitting and Archived, Day sheet with Show on Today, How It's Counted, view options, empty state. Habit page: total line, tap-a-day popover, Over Time |
| B3 | Make it fast: numbers worked out once per change, never while drawing, measured by the speed tests | [x] One snapshot per data change (`dataVersion`), cached per period; strips as fixed-size shapes, year grids as a few paths. Measured on GitHub with 30 habits and two years: Progress 16.8% main-thread busy and 2.5% redraw while switching and scrolling (Today's taps: 19.6%), opening as fast as the other screens (run 46, results below) |
| B4 | Check thoroughly for bugs and anything else wrong: golden cases, UI tests on GitHub, reading the code again | [x] `-progresscheck` (G1–G17 and the fixes) and `ProgressUITests` green on GitHub; the other classes run once, and their failures checked against the same tests on `sidebar` (below) |

## Decisions made while building

- **The overview counts habits, not times** (report §16.4 updated): it must agree with Today's day bar, which counts habits. A habit done 1 of 3 times fills the ring part of the way; its own row counts times.
- **Two meanings of "done" in the routine player:** its segments and queue use *done for today* (a weekly habit ticked once today), its main button uses *nothing more to do* (so "Log one" stays for a weekly habit at 1 of 3).
- **The archive date is stored in the settings table** (`archived.<id>`), so no database change was needed. Habits archived earlier get the day after their last log.
- **Past days of a weekly goal with nothing logged are blank**, not "not done yet", in the habit's calendar and Progress's strips.
- **Year on Progress, Runs, By Weekday and quit sections are Phase 2** (#60f), as planned.

## Results (GitHub, 30 Sep 2026)

| Run | What | Result |
|---|---|---|
| a04c246 | First build: Today, Timer, Progress | Builds. Month crashed the app; golden dates off by one (26 Sep 2026 is a Saturday) |
| 950c36f | Canvas strip replaced; crash reports added to CI | The crash report showed a `UICollectionView` layout assertion, not the Canvas |
| b125ce1 | Plain month grid | The list hung instead of crashing |
| 9b3a765 | Progress on grouped cards, not a `List` | **All 12 green** (Today 3, Timer 2, Progress 7) |
| 111da4d | Progress again, plus routine, calendar, focus player, section headers, schedule, persistence, placement; speed | Progress 7/7, section headers, persistence, placement green; speed tests fine. Focus player (8), routine and calendar (5) and one schedule test failed: tests written for the old player (they look for an "Anytime routine" title and a "Close" button the player no longer has); being checked against `sidebar`, which has none of this work |

**Bugs found and fixed while building:** the Month crash and hang (a `List` re-measuring rows forever; Progress now uses grouped cards on a scroll view, and the Design Rules say so); the golden cases' weekday; G1's tick days after the date shift.
