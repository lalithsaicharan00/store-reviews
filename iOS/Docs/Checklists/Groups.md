# Groups

Written by Claude (Claude Code), 30 September 2026. Branch: `progress-page-research`. Plan: [Groups — What to Build](<../Specs/Groups — What to Build.md>).

**Context (the user's words, tidied):** build the groups feature. Research how groups should work; there are probably research reports already, and if not, research what people expect, praise and complain about, where in the app groups belong, and whether they're in several places and how. Write a detailed plan, then build it. Schedule a message 3 hours 27 minutes out to carry on. Then build the group stats on Progress. Make everything fast.

| # | Point | Done |
|---|---|---|
| U1 | Research how groups should work: use the existing reports first, new research only if something is missing | [x] The reports already cover it (2,228 group reviews hand-coded, plus the Filter, counts, order and navigation reports); put together in the plan's §1–2, no new mining needed |
| U2 | What people expect, what they praise, what they complain about | [x] Plan §1: 933 asks, 668 praise, 474 friction (can't edit 110, colours 83, order 70, caps 70, bugs 66, forced presets 48), the two risks, filter vs tabs vs headings, group stats |
| U3 | Where groups live in the app; if in several places, how each place works | [x] Plan §2: Today's Filter (home), filtered Today, the one editor, the habit form, Habits by group, Progress; not the ≡ menu |
| U4 | A detailed plan, written before building | [x] [Groups — What to Build](<../Specs/Groups — What to Build.md>) |
| U5 | Build groups in the app once the plan is done | [x] `Habits/Groups/`, `HabitStore+Groups.swift`, Today, the habit form, Habits; commit 54ad3f4 |
| U6 | A message scheduled 3 h 27 min out to carry on | [x] Scheduled 30 Sep (Routine `trig_01UhQmW97bQ6VEEiHrdsEXap`, fires 1 Oct 02:52 UTC) |
| U7 | Group stats on Progress | [x] Chips, the Groups card, habits under their group, the Day sheet per group; golden case G18 |
| U8 | Everything fast (measured on GitHub) | [ ] |
