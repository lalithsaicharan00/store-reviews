# Habits & Tasks — iPhone — 17 November 2026

Written by Claude (Claude Code), 17 November 2026, from the user's request: "next work this … it's the same process like
how you have worked for all of the other things till now" (Figma `IOS-app`, page 985:380), with the same approach as
Today, Day details and the routine player: each page component becomes an ordinary SwiftUI screen, iOS draws what it
owns (menus, alerts, the search field, sheets, the calendar), no component unless one is needed, and what the design
dropped is removed.

## The user's points

- [x] **Habits page (986:150825).** Habits | Tasks (Large segmented) pinned under the bar; ☰, then search and + sharing
  one glass capsule, no title. A card per habit under its routine's heading, with Edit on a routine's heading (Edit
  Routine); Quitting and Paused after; Archived and What the squares mean at the end. Week · Month · Year as a
  drop-down and ‹ the period › in the bottom bar; Back to This Week floats above it on another period. A habit just
  made scrolls into view (Habit added).
- [x] **Archived Habits (988:7736) and Archived Tasks (1001:178)**, one page: an intro line, newest first, "Archived 12
  Oct", ⋯ with Restore and Delete in red; Restore shows "… restored · Undo"; Delete asks with Cancel and Delete only
  (D9); empty: "No Archived Habits/Tasks".
- [x] **Search (991:8050).** iOS's own search field, active from the start; habits first, then tasks, each under a
  count; a row opens its page; no match: "No Results for “yoga”" and Add “yoga”, which opens Create New with the
  name filled in, and the page scrolls to what was made.
- [x] **Tasks page (999:1061).** One-time | Repeating in the bottom bar (216 wide, centred), nothing beside it.
  One-time: Today (a task carried from an earlier day says "Planned for …"; one done today stays at the end, dimmed,
  "Done 9:12 AM"), Tomorrow, the next days by name, then by month; within a day the person's own order (U13).
  Repeating: Every day, Every few days, Every week, Every month, Every few months or longer, each row with what comes
  next ("Every 3 days · Next Sun 25 Oct", "8:00 AM · Next today", "Done today"). A row is the icon, name, one line and
  ⋯; a tap opens the task; nothing is ticked here (U38). Completed and Archived close the list.
- [x] **The row's ⋯ (Menu open).** Edit Task; Do Today and Pick a Day… for a one-time task not done (Mark as Not Done
  once it's done); Duplicate; Archive; Delete in red, asking first with Cancel and Delete only.
- [x] **Banners (Moved to Today, Moved to another day).** "Fix the bike light is on Today · Show" (Show goes to
  Today), "Moved to Fri 30 Oct · Undo", floating 8 above the bottom bar.
- [x] **Empty states.** "No Tasks Yet" and "No Repeating Tasks", each with New Task, the one prominent button at
  `.controlSize(.large)`.
- [x] **Task added.** A task made from + or Search shows its tab and scrolls into view.
- [x] **Completed Tasks (1002:230).** An intro line; one section per day it was done, newest first; "Done 9:12 AM",
  "· planned for Wed" when done on another day, "· every day" for a repeating one; ⋯ with Mark as Not Done and Delete;
  Mark as Not Done shows "… is open again · Undo"; the bar's ⋯ has Delete All Completed, asking first; empty: "Nothing
  Completed Yet".

## Removed (code only)

- The old All Habits list (`AllHabitsView`): its Select mode, swipe actions, Archive Instead and its own Tasks list. A
  Shortcut that opens a habit now opens it over Habits & Tasks, and the speed runs' "All Habits" opens Habits & Tasks
  (`.tasks` opens it on Tasks).

## Not built, and why

- **No date tasks** (the No date heading and "They stay here …"): the iPhone's task has no "no date" yet. That's model
  work, after the UI (the user, 17 Nov 2026: UI first, then logic).
- **Undo after Delete All Completed** ("6 completed tasks deleted · Undo"): a delete is a tombstone that can't be
  brought back yet, so the banner says what went, without Undo; the question before it says it can't be undone.
- **Do Today and Pick a Day… for repeating tasks**: a repeating task's occurrence can only move forward from today
  (`rescheduleRange`), so its ⋯ has neither; Day details keeps Another Day… for today's occurrence.
- **Routine added banner** on Habits: it needs New Routine in Create New, which is that page's work.
- **A PerfDriver scenario of its own** (T4): the `menu-pages` speed scenario opens `.tasks`, which is now this page;
  the speed run itself waits for the design phase to end.

## Checked

- Built for the iPhone 17 Simulator (iOS 26) and looked at each state beside its Figma frame: Habits (Week, another
  week, Month), Archived Habits (list, ⋯, restored banner, empty), Search (results, no match, Add “yoga”), Tasks
  (One-time with `-tasks-page-fixture`, the end of the list, Repeating, ⋯ open, Moved to Today with its banner, Pick a
  Day…, No Tasks Yet) and Completed Tasks.
- UI tests updated and added (HabitsPageUITests, TasksUITests with the new `testTasksPage`, PlusUITests, TodayUITests,
  PerformanceUITests and the others that opened the old list); `build-for-testing` passes; `check_rules.sh` passes.
  The UI tests haven't been run (design phase: no CI).
