Written by Claude (Claude Code), 19 November 2026.

# Detail pages — iPhone — 19 November 2026

The user, 19 Nov 2026 (Figma section 1020:1409): build the detail pages from Figma's page components, as a real
production app would, not a copy of how Figma keeps them as components; match the design closely; check each one by
hand on the Simulator. Then: "What the squares mean" is closed by default everywhere, and stays open only while on that
page.

Branch `ios-update`. Each item was checked on the iPhone 17 Simulator (iOS 26) against a Figma screenshot of the same
variant. Not yet on the real iPhone (U9).

## Habit details (1020:4052)

- [x] **Progress, the default tab** (1020:2733): Progress | History (Notes is no tab of its own: notes show in History),
  opens on Progress. Header: the 56 icon, the name in Title 2 Bold, "8 glasses a day | Anytime". ⋯ is a plain ellipsis.
  The name moves into the bar once the header scrolls under it.
- [x] **Scrolled** (1024:1981), **with a description** (1026:1947) and **description open** (1027:1948).
- [x] **New habit** (1031:2743): nothing logged yet shows No Progress Yet, the week ("Your first week", "Started today")
  with no comparison, and the key.
- [ ] **Loading** (1030:1948): **not built, on purpose.** The page's numbers are worked out before its first frame,
  so a placeholder would never show. Build it if the page's data ever loads later than that.
- [x] **Progress, full length** (1020:1410), **free plan** (1226:383496: the same, every feature is free). Current
  streak "Since 28 Oct", a best run still going "28 Oct – today", See All N as plain text.
- [x] **The key, Month, September, Year in Pixels** (1142:253823, 255177, 260528, 261882, 1148:50333). The month chart
  marks the goal and half of it, labels its first and last day, and shows days short of the goal at half strength; no
  comparison when there's nothing before.
- [x] **"What the squares mean" closed by default everywhere; open only while on that page** (the user, 19 Nov).
  Each visit to a page has its own (`HeatKeyVisit`); leaving the page closes it.
- [x] **History** (1046:7304), **scrolled** (1048:9864), **with notes** (1049:8564), **empty** (1055:8963). A search
  capsule, With Notes (only when there are notes) and Go to Date…; months as cards, rows 72 with the note under; Add
  floats bottom right. Scrolled rows stop under the pinned tabs (`scrollEdgeEffectStyle(.hard)`).
- [x] **History: gone to a date, mid September, started earlier, archived, early September.** Go to Date and Add share
  one popover calendar (`DayCalendar`); Go to Date scrolls the month, then the row, and lights it for a moment. Archived:
  the notice with Restore, no Add, days still open.
- [x] **The habit page's delete asks with Cancel and Delete only** (D9).

## Streaks (1034:74), All milestones (1036:235), How milestones work (1142:29063)

- [x] **Streaks** (1034:8): earlier runs' bars in the habit's Gradient Top (Fill was too pale), card radius 26.
- [x] **All milestones** (1036:98) and **Quitting** (1156:99273): the intro line is an ordinary row 8 under the bar,
  not a faded section header; tracks "In a row", "In total", "Days clean in a row".
- [x] **How Milestones Work** (1142:29038) and **Quitting and cutting down** (1156:99544): a row at the end of All
  Milestones (a grey ?, a chevron) opens it, in Figma's words.
- [ ] **Milestone rules, not built (logic phase):** the Anniversaries track, totals in the habit's unit ("Glasses in
  total", "400 glasses"), a quit habit's "clean days in total", and rows saying "days clean" (they still say "since a
  slip"). How Milestones Work describes the decided rules, so the iPhone's rules must catch up with it.

## Notes search (1053:9079)

- [x] **Start, Results, No match** (1053:8666, 8673, 8692): a full-screen cover with iOS's own search field, active from
  the start; results follow the words 0.3 s after typing pauses (scenario `notes-search`: typing 43 → 0 ms/s).
- [x] **Crash found and fixed:** closing the cover with the keyboard up crashed UIKit's keyboard layout guide. The
  search ends first, and the chosen day opens from the cover's `onDismiss`.

## Task details (1136:9271)

- [x] **One-time, not done yet** (1136:9248): the header ("One-time · Tue, 24 Nov, Morning"), the Planned card notice
  ("It shows on Today that day; tick it there."), Nothing Done Yet right under it, Add Note floating.
- [x] **One-time, done** (1137:9602): "One-time · done today", one Done card that folds, the day with "Done at 9:12 AM"
  and its note; the day opens Day details.
- [x] **Repeating** (1138:9539): a card per year ("2026", "Done 4 times" / "Done once"), newest first; Add Note asks
  for the day in History's calendar first.
- [x] **Menu open** (1138:10333): Edit Task, Move to Another Day…, Duplicate, Archive, Delete. A done one-time task has
  Mark as Not Done where Move is (U38). Delete asks with Cancel and Delete only. Archived: the notice with Restore, no
  Add Note.
- [x] Checked by hand: Move to Another Day… (26 Nov, the banner "Moved to Thu, 26 Nov"), Mark as Not Done, Archive and
  Restore, Delete's alert, folding, Add Note on a chosen day, a day opening Day details.
- Differences from Figma, kept: dates read "Tue, 24 Nov" (the app's `DayWords.short`, used everywhere), and a
  repeating task's line is the app's own schedule words, as on the Tasks page ("On the 19th, every other month · Next
  Sat, 19 Dec"; Figma "Every 2 months · Next Wed 9 Dec").
- [ ] **A repeating task's Move to Another Day… shows only on a day it's due:** the store moves only today's
  occurrence, as Today does (`canReschedule`). Moving a later one is logic work.

## Tests and checks

- UI tests: `TasksUITests.testTaskDetailsStates` (new), `HabitPageUITests.testMilestonesNoneOneMany`, History's
  `testHistoryFlows` and `testHistoryDaysOpenDayDetails` updated; Notes tab tests moved to History.
- Debug launches for checking by hand: `-open-habit <name>`, `-new-habit`, `-habit-archived`, `-task-demo`.
- `check_rules.sh` passes; `build-for-testing` succeeds. CI not run (design phase).

## Out of scope, seen on the way

- Day details still lets an archived habit log, and its own delete dialog still offers Archive Instead (D9).
