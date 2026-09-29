# Build Loop — Habit Page to Statistics

Written by Claude (Claude Code), 29 September 2026. The user's points for this round, and each loop as it's done.

**Context (the user's words, tidied):** All Habits (#56) is built. Keep building the rest, one thing at a time, in a loop: pick the next most important thing, decide whether it needs research (the Feature Ledger's cards first), and before writing the UI research how people expect it to work and where they expect it, as was done for notes. Order: the individual habit page, then Edit if it isn't finished, then statistics, with a lot of research on which statistics people want, how and where. Decide by importance, from the reviews: what people love is what gets built. Don't ask about each step; keep going until statistics are done.

| # | Point | Done |
|---|---|---|
| U1 | Work in a loop, one feature at a time, in order of importance | [x] Loops below |
| U2 | Before each build, check the ledger cards; research how and where people expect it | [x] Each loop links its research |
| U3 | Habit page first | [x] Loop 1 |
| U4 | Edit Habit, if not finished | [ ] Loop 2 |
| U5 | Statistics: deep research on what people want, how and where, then build | [ ] Loop 4 |
| U6 | Don't ask the user at each step | [x] |

## Loop 1 — Habit page: fill in a past day, open the page from Today

Research: [Filling In a Past Day From the Habit Page](<../../../Research/Research Reports/Day Structure and Organization/Filling In a Past Day From the Habit Page.md>) (108 read). Why first: the page's calendar showed history but a tap did nothing, and back-dating is a Strong/Certain ledger point (C010, 34 apps; C262).

| # | Point | Done |
|---|---|---|
| L1.1 | Tap a day in the habit page's calendar → a sheet for that day (never a tap that changes the day by itself) | [x] `HabitDaySheet` |
| L1.2 | The sheet says what the day was ("Done", "5,200 of 8,000 steps", "Skipped"), and the whole week or month for period goals | [x] |
| L1.3 | Changes with the habit's own control: Mark as Done / Not Done; times for "3 times a day"; Log Amount / Time Manually with each entry deletable; checklist steps | [x] |
| L1.4 | Skip This Day / Undo Skip and the day's note on the sheet (the note is written in the page's note bar) | [x] |
| L1.5 | Only days that can honestly change are tappable: first day to today, its days, not paused | [x] `HabitStore.canChange` |
| L1.6 | View Habit in the long-press menu on Today (habit, quit and paused rows), after Edit Habit; a tap still logs | [x] |
| L1.7 | UI test | [x] `HabitPageUITests` (written; not run: no Mac in this session) |
