# iOS Docs — what was decided and built for the app

Written by Claude (Claude Code), 28 September 2026.

These are the iPhone app's own documents: the specs it was built from and the user's point-by-point checklists for each round. They are kept apart from the store-review research in [`Research/Research Reports/`](<../../Research/Research Reports/README.md>), which is evidence. Everything here was implemented in the app, or is waiting to be.

## How to use these without reading them all

1. **Always read [Design Rules — Don't Regress](<../Design Rules — Don't Regress.md>) first.** It is the short version of everything below: each rule the app must keep, and the research behind it. For most changes it is enough.
2. **Before changing a screen, open only the spec for that screen** (table below). Read a research report only when a rule's reason is unclear or you need to change the rule.
3. **When the user asks for a change**, write every point they made into a new checklist in `Checklists/` before starting, and tick it as you go.
4. **When a decision changes**, update the spec and the matching line in Design Rules together, and mark the old text as superseded. Don't delete it.

## Specs (build from these)

| Spec | Status | Open it when you change |
|---|---|---|
| [New Habit Goal and Time of Day](<Specs/New Habit Goal and Time of Day.md>) | **Current.** Its Schedule and Goal parts are superseded where they conflict with Design Rules' "Schedule and Goal" section | The New Habit form, Goal screen, Time of Day, units, checklists |
| [Pending to Implement](<Specs/Pending to Implement.md>) | **Partly superseded.** Only §6 still applies (reminder scheduling, alarms, notification actions) | Reminders, alarms, Remind Again |
| [Today Improvements](<Specs/Today Improvements.md>) | **Partly superseded** by the Section Header research (28 Sep) | Today's sections, routine play, the day bar |

The work order for the whole app is [Build Plan](<../Build Plan.md>).

## Checklists (the user's points, round by round)

| Checklist | State |
|---|---|
| [Goal and Choice Screens — Round 2](<Checklists/Goal and Choice Screens — Round 2 Checklist.md>) | Done |
| [Section Header — Start and Left](<Checklists/Section Header — Start and Left Checklist.md>) | Done |
| [Schedule and Goal — Implementation](<Checklists/Schedule and Goal — Implementation Checklist.md>) | Done (by Codex, simulator only) |
| [Schedule and Goal — Round 2, Make It Intuitive](<Checklists/Schedule and Goal — Round 2 Checklist.md>) | Research done; superseded by Round 3 |
| [Creating a Habit — Round 3, The User's Own Words](<Checklists/Creating a Habit — Round 3, The User's Own Words Checklist.md>) | Research and design done; built 29 Sep |
| [Round 3 Build — Copy, Days, Dates and Limits](<Checklists/Round 3 Build — Copy, Days, Dates and Limits Checklist.md>) | Built 29 Sep; not yet compiled or run on a phone |
