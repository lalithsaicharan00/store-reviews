# Progress Page — Research

Written by Claude (Claude Code), 30 September 2026. Build Plan #60 (Progress and statistics screens). Research only: nothing is built in this round.

**Context (the user's words, tidied):** research the Progress page before building it. Go through all the reviews and the Feature Ledger's cards and find what users expect and need. The result must be a very detailed, ready-to-implement report.

**Report:** [The Progress Page — What People Need, and How to Build It](<../../../Research/Research Reports/Progress and Statistics/The Progress Page — What People Need, and How to Build It.md>). Section numbers (§) below are that report's.

| # | Point | Done |
|---|---|---|
| P1 | Go through **all the reviews** (every corpus), not a sample, for what people expect and need from progress and stats | [x] Every corpus screened (1,487,223 reviews); all 14,726 matches in habit apps read and hand-coded, 11,870 on topic (§2, §3) |
| P2 | Go through **every Feature Ledger card** on progress and stats, and don't miss any: each relevant card is something to implement or to answer | [x] 1,604 cards read; all 254 canonical points they belong to mapped: 96 answered, 158 named as belonging elsewhere (§24) |
| P3 | Which apps' progress and stats get **praised**, and what exactly users like about them, down to minute details | [x] §4, plus `per_app.md` for every app |
| P4 | What generates **complaints**, so we avoid it | [x] §3.2 and §5 |
| P5 | Take what's praised, but **in our own way**, never a straight copy | [x] "Our way" column in §4 (round year dots with labels, a 30-day rate instead of an opaque score, day rings, count bar instead of a pie) |
| P6 | **Overall structure** of the Progress page: e.g. a list first, and tapping a habit opens more detail, or something else. Decide from the evidence | [x] Overview first, then a row per habit; tap a row to open the habit's own page (§6) |
| P7 | **Do we need an overview** (all habits together) at all, and what goes in it | [x] Yes: the top ask (697 reviews, 63 apps). Day rings for the week, month or year, plus three plain numbers (§7.2) |
| P8 | **Per habit:** exactly which stats, charts and numbers, for each habit | [x] §8 (habit page sections) and §9 |
| P9 | **Per habit type**, and how they differ: Check it off, Track an amount, Time it, Checklist, weekly/monthly totals and other frequencies | [x] Ten shapes, each with its row text, numbers and charts (§9) |
| P10 | **Quit habits:** the live time-since clock, runs, slips, and how their progress is shown | [x] §10. Needs a "Log a Slip" event first (§10.4) |
| P11 | **Cut-down habits:** their own progress (limit per day, week or month) | [x] §11: lower is better, judged when the day ends, never celebrated at the limit |
| P12 | **Tasks** have no progress: confirm they stay out | [x] Confirmed, and supported by reviews (§12) |
| P13 | **Groups** (planned, not built): do we need group stats? Plan the page now so groups slot in later without rework | [x] Yes, later. Every calculation takes a list of habits; chips, group summaries and a groups bar come when groups ship (§15) |
| P14 | How the page relates to the existing **habit page** (streak, best, done this month, month calendar), with no double work | [x] The habit page is the detail view; nothing on it is moved or removed, and sections are added (§6.2, §8) |
| P15 | Every detail: layout, copy, empty states, edge cases (skips, pauses, goal history, archived habits), so it's ready to build | [x] §7, §13, §16–§21, §25 (golden cases) |
| P16 | A very thorough, in-depth report, added to the Research Reports index | [x] Added under "Progress and Statistics" in `Research/Research Reports/README.md` |
