# Tasks Widget — Large and Medium

Written by Claude (Claude Code), 6 October 2026. Design follow-up under Current Work item 9; app implementation
remains separate.

The user's points:

- [x] Record the monthly and icon-only widget decisions (see "Weekly Medium Widget — One Habit", Widget decisions).
- [x] Read how tasks work in the code: `HabitKind.task` is done once on a day, with no streak or stats; `dueDay` or a
  repeat after completion; an optional `dueMinute`; a Today section; its own icon and colour. Today's line is "Task",
  "Task · 5:00 PM" or "Task · From Sat 3 Oct" (`taskLine`). The current Today widget already has "Tasks today".
- [x] A widget for tasks, following the Large and Medium Today lists. Tasks show only a check, an icon and the section
  of the day they belong to: no statistics.
- [x] Build four review cards only: Large with five tasks, Large with six, Medium with two, Medium with three.
- [x] The user picks the capacities: Large five, Medium two (same as the Today lists).

## Final — 6 October

- [x] Paging: Large pages above five (‹ 1/2 › beside the title and count); Medium pages above two (the count and
  ‹ 1/3 › on the compact header). The last page keeps its rows at the top.
- [x] All variations. Large: five, four (58-pt rows), six on 2 pages, twelve on 3 pages, all done, a Morning section,
  long names, no tasks, content hidden. Medium: two, one (58-pt row), five on 3 pages, all done, a Morning section,
  long name, no tasks, content hidden. Dark samples use a 0.26 done tint, as the Today lists do.
- [x] Delete the monthly Medium and Large test cards and the four task test cards. No temporary frames are left.

Figma: section `687:7558`, which holds the review board `688:7901`. Component sets: `Tasks widget / Large` `687:8158`
(12) and `Tasks widget / Medium` `688:7900` (10).
