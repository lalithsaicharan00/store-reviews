# Routine Player — iPhone — 17 November 2026

Written by Claude (Claude Code), 17 November 2026, from the user's request: "Then next we need to do the same thing with
the routine player … These are the screens for routine player" (Figma `IOS-app`, section 903:102), with the same approach
as Day details: build what iOS gives natively, no component unless one is needed, and remove what the design dropped.

## The user's points

- [x] **Same concept as Day details: built for production, the way iOS does it.** Your Routine and Change Order are a
  native sheet (`List`, `.onMove`, edit mode); ⋯ is a native `Menu`; ✕ and ⋯ are the system's glass bar buttons; Day
  Details opens the same `DaySheet` a row on Today opens; Add Log and the note open their own sheets, as from Today.
- [x] **Header (Figma's Top app bar).** The routine's name with ⌄ and "1 of 3" under it, as the title menu that opens
  Your Routine; ✕ Close; ⋯ with Go to First Unfinished, Change Order, End Routine. The progress segments are gone.
- [x] **Habit page.** The habit's icon in a 112 circle of its colour, the name (Title 2 Semibold), the description, Day
  Details (Small Bordered, calendar symbol, in the page, never in the bar), the value ("Not done" / "Done" for a
  once-a-day check, "3 of 8 glasses" for a count, "… this week" over a week) and a bar in the habit's colour, with a kept
  32-point place under it for the milestone ribbon or the status (Goal met, Skipped for today, the limit's words).
- [x] **Time habit.** The ring with the icon, the clock and "of 20 min" inside, no icon circle above; at accessibility
  sizes the icon circle, the clock's words and a bar (Figma's 200% text).
- [x] **Checklist.** The same identity smaller (72) in a card with a 12-point capsule bar and "1 of 3 steps", then the
  steps as rows with Reminders' circles; a ticked step steps back to Secondary Label. No main button until every step is
  done; then Next or Finish.
- [x] **Bottom bar.** ‹ and › as 48 glass circles either side of one Prominent Ink capsule: Mark Done, Add a Check, +1,
  Log, ▶/⏸ as the symbol alone (VoiceOver keeps Start, Pause, Resume), Next, Finish. 17 Regular, as every native button.
- [x] **Saved · Undo · Add Note floats just above the bottom bar** (the Banner), so nothing under it moves.
- [x] **End page.** An Ink circle with ✓ (all done) or ⋯ (some left); "Morning is done" or "1 of 3 done"; what waits on
  Today; Reached in this routine (milestones met during the run), Left for later (a tap goes back to it), Done; one
  full-width Done that closes the player.
- [x] **Your Routine sheet.** One Medium height, so no handle; ✕, Your Routine, Edit; each habit with how far it got and
  "Here now" ▶ for the current one; Edit turns it into Change Order with drag handles and Done.

## Removed (code only)

- The progress segments, the floating main button over the page, the "Day details" text item in the bottom bar.
- The page's own Skip and its "Skipped · Undo" (skipping is Day Details' Skip Today), and the Undo that stayed under the
  ring after the banner went (Undo is in the banner and in Day Details).
- The old summary ("Routine finished", Return to unfinished, Review routine) and the period line under the value.

## Checked

- Built for the iPhone 17 Simulator (iOS 26) and looked at each state beside its Figma frame: a count (906:91035), Goal
  met with Saved · Undo · Add Note, a checklist (906:91379), a running timer, the end page with some left (906:91673),
  ⋯'s menu, Your Routine and Change Order, and accessibility text size M.
- UI tests updated for the new words and places (FocusPlayerUITests, RoutineCalendarUITests, UndoUITests);
  `build-for-testing` passes; `check_rules.sh` passes. The UI tests haven't been run (design phase: no CI).
