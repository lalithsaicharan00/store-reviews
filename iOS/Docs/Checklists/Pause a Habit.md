# Pause a Habit

Written by Claude (Claude Code), 29 September 2026. Build Plan #55.

**Context (the user's words, tidied):** the next feature is pausing a habit. Research first how pausing should work across the whole app, then build it. Agreed order: pause research → a simple habit page (home for notes, Edit, Pause; later archive and delete) → build pause, with long-press → Pause as a shortcut.

| # | Point | Done |
|---|---|---|
| P1 | Research: what people want when they pause (why they pause; one habit or all; until a date or until resumed) | [x] One habit at a time (88 reviews in 31 apps; only 4 want one switch for all); mostly travel (93) and illness (29); until a date by default, or until turned back on; no length limits |
| P2 | Research: what happens to the streak while paused (freeze, keep, restart) | [x] Kept: a paused day is a skipped day (neutral). A week or month with a paused day can't break the streak |
| P3 | Research: reminders, Today, the calendar, the player and stats while paused | [x] Leaves Today into a folded Paused card at the bottom; reminders stop; out of routines; left out of stats; a quiet mark in the calendar. Quit habits: pausing ends the run (not a slip) — **needs the user's call** |
| P4 | Research: how pause differs from Skip today and from archive | [x] Skip = one day; pause = a stretch; archive = for good (#56) |
| P5 | Research: what goes wrong with pause in other apps (complaints) | [x] Streak reset or paused days asked about on resume (11 reviews, ★2.82), reminders kept firing, length limits, all-or-nothing, hidden with no way back |
| P6 | Report in `Research/Research Reports/`, added to its README | [x] [Pausing a Habit — What People Need](<../../../Research/Research Reports/Day Structure and Organization/Pausing a Habit — What People Need.md>) |
| P7 | Habit page | [ ] Pending (the user, 29 Sep): not built yet; Pause goes on it when it is |
| P8 | Build pause (habit page + long-press → Pause) | [x] Long-press → Pause… on habit and quit rows (Resume / Cancel Pause when paused or planned); pause sheet (1 week, 2 weeks, a date, until turned back on; Starts for build habits, past or future); folded Paused card at the bottom of Today with Resume; paused days neutral via `isDue`, so reminders, routines and the day count skip them; a week or month with a paused day can't break the streak. Quit (the user agreed, 29 Sep): pausing ends the run, kept as a run; resuming starts a new one. Built and installed on the iPhone 16; not tested by hand yet |
| P9 | Not built: a per-habit paused mark in the calendar (no per-habit history screen yet), Pause in the player's Habit options, pausing several at once (comes with All Habits #56) | [ ] |
