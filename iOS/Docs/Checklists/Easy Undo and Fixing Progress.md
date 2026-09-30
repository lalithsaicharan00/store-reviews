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
| U6 | Routine player: does it need more undo options or confirmations? | [x] No confirmations; everything else already exists. Only change: a small visible "Undo" under a habit this routine completed (30 Sep, agreed with the user) |
| U7 | Build it | [x] Native Day sheet, shared entries, Today/calendar entry points, inline Undo, routine Undo and slip editing implemented |

Implementation by Codex, 30 September 2026. The user requested native iOS controls, all changes on
`claude/undo-research`, and performance as the highest priority. No local builds, tests or simulator runs.
`perf-smooth-app` is merged into this branch, including its rules, caches and optimised build settings.
The new forms use the indexed habit/day entries. Entry corrections retain the ID, tracking day and source;
SQLite updates only a live row, so editing never revives a deleted entry. Schema 6 adds a nullable source,
leaving older logs honestly labelled “Source not recorded”.

Validation is through the macOS Actions workflow: existing Today/Timer tests, UndoUITests, Core migration/storage
tests, and the self-driven performance scenarios (including Day sheet, Log sheet, entry editing and exact undo).
Results will be recorded here after CI completes.
