# Routine Player — Bottom Row, Options Sheet and Switches

Written by Claude (Claude Code), 4 October 2026, from the user's own words. Current Work Checklist item 17 (the
player's bottom spacing), with two new bugs found the same day (items 33 and 34; 22 and 23 on the branch before the
list was renamed). Follows [the Rulebook](<../../../RULEBOOK.md>) and the player's
sections in `Design Rules — Don't Regress.md`.

**Superseded in part, 5 Oct 2026 (the user, Current Work 51):** P1–P3's custom row 40 points up, with the main
button's slot reserved under the pages, still left "a huge block" and cut off a checklist's steps. The row is now the
native bottom bar, as on Today, and the main button floats over the bottom of the page; P4 (nothing moves) still holds.
See Design Rules' routine player section.

**The user's words, tidied:** "The spacing feels uneven sometimes. Habit options and the chevrons: we should treat it
like a bottom navigation. Sometimes it isn't behaving like one; below it a lot of space is reserved. It should be at
the bottom, with a good amount of spacing from the bottom of the screen and ample space around it (a reference unit
like 40, or more), because tight spacing around the chevrons and Habit options means misclicks. More importantly the
layout should be reliable: no layout shift. The main button and the bottom row must never move depending on the
content, the circle or anything else that changes on the screen."

| # | Point | Done |
|---|---|---|
| P1 | **The bottom row is a bottom navigation:** ‹, Habit options and › pinned to the bottom of the screen, never floating up or leaving a band of empty space under it | [x] Pinned under the pages; nothing else takes its place (a note opens `NoteSheet`, the bar is gone) |
| P2 | **A fixed, generous distance from the screen's bottom edge** (about 40 points, more than the home indicator needs) | [x] 40 points from the edge, or 8 above the home indicator if more: measured 42 on GitHub's iPhone (`b6bd7d1`) |
| P3 | **Ample space around the row** so the chevrons, Habit options and the main button aren't misclicked | [x] 32 points (scaled, up to 44) between the main button and the row: measured 33 |
| P4 | **No layout shift:** the main button and the bottom row stay in the same place whatever the habit's state (an unfinished checklist, a finished habit with its Undo, a skipped day, a running timer, a save message, writing a note) | [x] The main button's slot and the Undo's place are always kept; `testBottomRowStaysPutAndOptionsShowEverything` checks both positions after a log, an unfinished and a finished checklist, a running and a paused timer, and the options sheet |
| P5 | **Habit options showed only part of its list** (Read: Log time manually, Skip today, Undo 1 min, Show clock, Add Note… and Edit Habit was below the fold until you scrolled). If that isn't what people expect, fix it | [x] Not how iOS's own action sheets behave (they show every action): the sheet now fits its list; the test checks Edit Habit shows without scrolling |
| P6 | **The Show clock switch was white in dark mode** (unreadable). Switches are the iPhone's green everywhere (Rulebook U2) | [x] `AppSwitchStyle` puts the green on the switch itself; `check_rules.sh` fails on any other switch style |
| P7 | **Check marks:** selection checks are the iPhone's blue (already so in Habits' Select); make the rest match | [x] A group's habit picker uses Select's blue circles; single-choice ticks stay monochrome (U2), readable in dark mode |
| P8 | Current Work Checklist: item 1 (Progress: Week, Month and Year) is done, the previous agent didn't tick it. Add these bugs to the list and tick them when done | [x] Item 1 moved to Completed (the user, 4 Oct); bugs added (33, 34) with 17; those three stay open only for your iPhone look |

**Tests (4 Oct 2026, `b6bd7d1`):** FocusPlayer (13, with the new layout test), Schedule, RoutineCalendar (7) and Groups
(5) all passed, 31 tests. Speed, the player's ‹ ›: 14.8 ms/s, no freeze (`main` 66.0 in an earlier window); opening
the player 436 ms then 114 ms (`main` 1,222 then 263). **Still yours:** a look on the iPhone (U9), above all the bottom
spacing and the green switch in dark mode.

**Found on the way:** the player's "Log one" for a 3-times-a-week habit used the ✓ toggle, so a second press took the
first back (since 3 Oct's U14); it now adds one. `ScheduleUITests` caught it on `main`.
