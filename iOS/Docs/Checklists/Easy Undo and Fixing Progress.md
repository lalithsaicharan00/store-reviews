# Easy Undo and Fixing Progress

Written by Claude (Claude Code), 30 September 2026. Build Plan #57.

**Context (the user's words, tidied):** next is easy undo after checking or logging. A snackbar is fine, but there should be several ways to undo. The routine player already shows an undo message; other places don't. Undo doesn't need to be generic: whatever was logged can be undone, and if it was logged by hand it can be changed again. Once someone has logged and moved away from the screen, they need a way to edit that log or today's progress. Research first: how undo should work, where people expect it, whether the habit page needs something (a way to change today's progress? a dedicated space near the top?), all for the best experience. Report back before building.

Research: [Undo and Fixing Progress — What People Expect](<../../../Research/Research Reports/Day Structure and Organization/Undo and Fixing Progress — What People Expect.md>).

| # | Point | State |
|---|---|---|
| U1 | Research how undo should work and where people expect it | [x] 2,677 reviews read, 1,084 on topic |
| U2 | Is a snackbar enough, or several ways? | [x] Several ways; no floating snackbar on Today, an inline Undo on the logged row instead |
| U3 | Undo per log, not generic | [x] Undo removes the exact entry and everything it caused |
| U4 | A way to fix a log after leaving the screen | [x] One Day sheet (entries, add/change/delete, done/not, skip) |
| U5 | Anything on the habit page? A dedicated space up front? | [x] A small "Today" row near the top and a tap on any calendar day, both open the Day sheet; not a large section |
| U6 | Build it | [ ] Waiting for the user's go-ahead |
