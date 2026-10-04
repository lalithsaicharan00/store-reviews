# Routine Player — Bottom Row, Options Sheet and Switches

Written by Claude (Claude Code), 4 October 2026, from the user's own words. Next Up item 17 (the player's bottom
spacing), with two new bugs found the same day. Follows [the Rulebook](<../../../RULEBOOK.md>) and the player's
sections in `Design Rules — Don't Regress.md`.

**The user's words, tidied:** "The spacing feels uneven sometimes. Habit options and the chevrons: we should treat it
like a bottom navigation. Sometimes it isn't behaving like one; below it a lot of space is reserved. It should be at
the bottom, with a good amount of spacing from the bottom of the screen and ample space around it (a reference unit
like 40, or more), because tight spacing around the chevrons and Habit options means misclicks. More importantly the
layout should be reliable: no layout shift. The main button and the bottom row must never move depending on the
content, the circle or anything else that changes on the screen."

| # | Point | Done |
|---|---|---|
| P1 | **The bottom row is a bottom navigation:** ‹, Habit options and › pinned to the bottom of the screen, never floating up or leaving a band of empty space under it | [ ] |
| P2 | **A fixed, generous distance from the screen's bottom edge** (about 40 points, more than the home indicator needs) | [ ] |
| P3 | **Ample space around the row** so the chevrons, Habit options and the main button aren't misclicked | [ ] |
| P4 | **No layout shift:** the main button and the bottom row stay in the same place whatever the habit's state (an unfinished checklist, a finished habit with its Undo, a skipped day, a running timer, a save message, writing a note) | [ ] |
| P5 | **Habit options showed only part of its list** (Read: Log time manually, Skip today, Undo 1 min, Show clock, Add Note… and Edit Habit was below the fold until you scrolled). If that isn't what people expect, fix it | [ ] |
| P6 | **The Show clock switch was white in dark mode** (unreadable). Switches are the iPhone's green everywhere (Rulebook U2) | [ ] |
| P7 | **Check marks:** selection checks are the iPhone's blue (already so in Habits' Select); make the rest match | [ ] |
| P8 | Next Up: item 1 (Progress: Week, Month and Year) is done, the previous agent didn't tick it. Add these bugs to the list and tick them when done | [ ] |
