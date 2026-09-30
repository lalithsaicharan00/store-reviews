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
| 72cf684 | Phases 2 and 3 (after a one-line build fix) | **All 15 green** (Progress 10: Year, Log a Slip, habit page Year and Runs added); speed: Progress 22% busy while switching Week, Month and Year non-stop, 8.5% of it building Year's numbers |
| aa1442d | Day scores kept per data change | Speed fine; one Day sheet test hit a screenshot timeout on a slow runner (it passed on every other run) |
| 15e5746 | Week-title formatter made once | **All 15 green**; the interval formatter was still 7% of Progress's time |
| 555aa29 | The player's circle keeps its children's identifiers; one routine test taps the main Finish button | Focus player 5 of 12 and routine/calendar 3 of 7 pass (2 more than before). The rest are the old-player tests: they now find the progress number but then match it on the neighbouring pages the player keeps loaded, or look for an old title or a time-of-day section |
| aa4e230 | Week titles from month names, no formatter | **All 15 green**; Progress **8.2% busy, 1.4% redraw** while switching Week, Month and Year non-stop (was 30%), lighter than tapping on Today (19%) |

**Phases 2 and 3 (the user, 30 Sep: "if Phase 1 is completed then continue to Phase 2 and then Phase 3"):** built and green on GitHub. Log a Slip (#60d), quit history and sections, Year on Progress and the habit page, Runs, By Weekday, the 30-day rate; Full Day at 100/80/60%, money saved, the shareable year picture. Group stats wait for groups, which aren't built.

**Tests written for the old routine player** (in `FocusPlayerUITests`, `RoutineCalendarUITests` and one in `ScheduleUITests`) fail on this branch. They look for a title and buttons the player hasn't had since 29 Sep, so they aren't caused by this work; the one place 60a touches them (a weekly habit ticked today is done for the day) is fixed in the player's fixture. Bringing those tests up to the current player is its own task: query the current page only (the player keeps its neighbours loaded, so each identifier is on screen two or three times), drop the old "Anytime routine" title and "Skip for now" checks, and don't depend on which time of day is Now. One real app bug they exposed is fixed: the circle's identifier hid the progress number's (`focus-quantity`) from accessibility.

**Bugs found and fixed while building:** the Month crash and hang (a `List` re-measuring rows forever; Progress now uses grouped cards on a scroll view, and the Design Rules say so); the golden cases' weekday; G1's tick days after the date shift.
