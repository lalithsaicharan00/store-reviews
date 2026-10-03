# Today — Arrange Your Day (item 5 build)

Written by Claude (Claude Code), 3 October 2026, from the user's message of 3 Oct that followed
[report 27](<../../../Research/Research Reports/Home Screen and Visual Design/Today Screen Top Area/27. Arranging and Filtering Today — What People Expect.md>).
Every point the user made, before any code (Rulebook W1). Ticked as each one is built. Branch `claude/today-edit-mode`.

**The rule for this build:** "Don't change anything drastically apart from what I told you." Today's normal layout stays
as it is (folding sections, icons and "N left" when folded, no heading); only the points below change.

## Today, normal mode

- [x] **Remove "Edit Times of Day"** from the bottom of Today's list. **Keep "Note for the Day".**
- [x] **An Edit button** (the word "Edit"). Decided from Apple's toolbar guidance ("Keep actions with text labels
  separate"; "Edit" is the one action that should be a word): **Edit in its own capsule, Filter and + together in
  another.** ≡ stays on the left.
- [x] **A subtitle under each timed section's name** (Morning, Afternoon, Evening and the person's own; not Anytime or
  Quitting), folded or open: **only the start time, short: "Starts 6 AM".**
  - [x] It takes no room from the folded icons or "N left": it sits on its own line under the name.
- [x] **Nothing else in Today's layout changes.** No heading in normal mode.
- [x] **The tip appears at the right moment, never at random:** one tip on Edit, only once the person has two or more
  habits in one time of day and has opened Today on three different days; never in test launches; gone for good once
  Edit is used.

## Edit mode ("Arrange Your Day")

- [x] **A heading, not "Edit Today":** "Arrange Your Day", with a plain-English line under it saying what can be done.
- [x] **Every habit in each time of day, not only today's**, Anytime and Quitting included; it says clearly that all
  habits are shown.
- [x] **Anytime and Quitting can't be renamed or retimed**, but the habits inside them can be put in order.
- [x] **Order of the sections:**
  - [x] Timed sections (Morning, Afternoon, Evening, the person's own) follow their times, automatically.
  - [x] **Only Quitting and Anytime move:** up, down, to the very top, to the very bottom, or in between anything.
  - [x] It says that habits can be put in order inside a section, and Anytime and Quitting moved up and down.
- [x] **A ··· menu on each section**, short clear names:
  - [x] Rename (timed only)
  - [x] Change Time (timed only)
  - [x] Sort by Reminder Time
  - [x] Sort A to Z
  - [x] Delete (timed only; its habits move to Anytime, and it says so)
  - [x] Move Up / Move Down / Move to Top / Move to Bottom (Anytime and Quitting only)

## A new section, and splitting

- [x] **A new section whose time falls across existing ones splits them.**
  - [x] Morning 9 AM–12 PM, new Mid Morning 11 AM–2 PM: Morning becomes 9–11 AM.
  - [x] Across Morning (9–12) and Afternoon (12–5): Morning 9–11, Mid Morning 11–2, Afternoon 2–5.
- [x] **Confirm before splitting, showing how it will look**, with every affected section's new times (Morning
  9–11 AM, Mid Morning 11 AM–2 PM, Afternoon 2–5 PM).
- [x] **The logic is checked in both directions** (a new section starting inside the one before, ending inside the one
  after, before the first, after the last, inside one section, covering a whole one), in an automated check.
- [x] Changing an existing section's time follows the same rules and the same confirmation.

## Order

- [x] **A new habit always goes to the end of its section**, reminders or not. Reminder times no longer reorder Today.

## Groups and the filter

- [x] **Groups can be made in two places, the habit form included:** the form always shows the Group row, even before
  any group exists, with New Group in it.
- [x] **The filter shows: All Habits, the groups, New Group up front, and Edit Groups.**
- [x] **"Hide completed" is explicit: two switches, "Hide Completed Habits" and "Hide Completed Tasks".**

## Tasks

- [x] **Decide where tasks sit in a section, and whether they can be put in order**, from research. The user's guess:
  habits first, then tasks; only habits reordered. Research decides; build what it says.
  - **Research said otherwise** (report 27, section 6; 254 reviews hand-read): one order per time of day, habits and
    tasks together, and tasks dragged too. 0 of 52 asked for habits first or tasks first; 34 of 61 want to drag tasks.
    Built that way.

## Finishing (Rulebook)

- [x] Design Rules and the Rulebook updated where a product rule changed (the default order; the Group row; Anytime
  and Quitting moving; the bottom of Today).
- [x] A `PerfDriver` scenario for Arrange Your Day (T4).
- [x] UI tests updated for every changed label (T3), and new ones for the arrange view, the split and the filter.
- [x] `check_rules.sh` passes; the touched tests and a speed run, once, at the end (T7). *3 Oct: every touched class
  passed (Arrange, Today, Groups, Long Text, Section Headers, Tasks, Placement, New Habit, Habit Creation, Form
  Walkthrough, New Flow); speed run in `PERFORMANCE-LESSONS.md`. The runs found a real bug, fixed: a fast-typed or
  pasted name showed more than the 24 letters kept (Rulebook U6).*
- [ ] Looked at on the real iPhone by the user (U9).
