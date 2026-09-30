# App Speed — Round 2 (the whole app)

Written by Claude (Claude Code), 30 September 2026.

**Context (the user's words, tidied):** the app lagged a lot on the user's iPhone. Scrolling Today was already fixed.
Fix every remaining speed problem so the app runs smoothly and cleanly on the phone. Test on GitHub Actions, in a
loop, until everything is fixed. Find out why the same mistakes kept coming back and write the speed rules somewhere
every session follows first, not only in the design documents.

## Every point the user made

| # | Point | Done |
|---|---|---|
| P1 | Fix all remaining speed problems; the app must be smooth on the iPhone | See "What changed" and the measurements below |
| P2 | Test with GitHub Actions, in a loop until everything is fixed | Runs listed below |
| P3 | Find the reason the mistakes kept repeating | [x] `iOS/PERFORMANCE.md`, "Why the mistakes kept coming back" |
| P4 | Write the speed rules where every session follows them first, not only in docs or design rules | [x] `iOS/PERFORMANCE.md`, imported at the top of the root `CLAUDE.md` (loaded into every session), plus `Tools/perf/check_rules.sh`, which fails on the checkable mistakes locally and in CI |

## What was wrong (read from the code and the 30 Sep speed run)

1. **The phone ran an unoptimised build.** The user installs the Debug configuration from Xcode: Swift at `-Onone`
   and a debug Kotlin core.
2. **One tap recalculated every streak.** Each row worked out its streak in `body` by stepping back through up to a
   year of days, with three `Calendar` calls and a rebuilt list of placements per day; any tap redrew every row.
   After each tap the entry indexes were also rebuilt from every entry.
3. **Taps waited for storage.** A check or +1 appeared only after a durable SQLite write through the Kotlin core.
4. **The habit page never opened** from All Habits (a value link in a list with a selection only selects the row).
5. **The speed figures weren't trustworthy**: `sample`'s busy % included the UI test's own work (one read −37 %).

## What changed

1. Debug builds Swift with `-O` and the Kotlin core as release (`project.pbxproj`).
2. `HabitStore` remembers streaks, best streaks, the calendar's day totals, placements and start days until their
   data changes (per habit for entries); keeps its calendar; updates entry indexes in place. `LocalDay` steps days
   with plain arithmetic in the Gregorian calendar (checked against Python's calendar for 1800–2300).
3. Logging taps change memory first and write right after, as the timer already did; a failed write reloads.
4. All Habits links to the page directly.
5. `MainThreadMeter` records the app's own main-thread stalls in speed-test runs; the tests tap by position (no
   screen searches while measuring) and now also cover the New Habit form and the routine player.

## Measurements

Filled in from `ci-results` after each run.
