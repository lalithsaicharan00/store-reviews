# Next Up — The User's List, 2 Oct

Written by Claude (Claude Code), 2 October 2026, from the user's own list: "These are the things that I want to
update, but not exactly right now. We will update them one after the other." Work them **in order, one at a time**;
tick each when it's done and link what was built or written. Every item follows
[the Rulebook](<../../../RULEBOOK.md>), and a screen's section in `Design Rules — Don't Regress.md`.

## Now

- [x] **1. Progress page: a big visual overhaul of Week, Month and Year.** *Done (the user, 4 Oct 2026): Week, Month and
  Year are all built and in `main`; this tick was missed.* Not the data (it's right and complete) but
  how it's presented: today it reads "okay, not good", too dense, rows squeezed. **Week first** (overview card →
  habit cards → quit section), then Month, then Year.
  - The user's Week points: rows too tight (top and bottom padding); the icon centred against 2–4 lines of text
    looks wrong; the day marks (dotted circle, ring, part ring…) don't explain themselves; the overview should be
    genuinely attractive. The top (range tabs, period ‹ ›, group chips, View Options) stays as it is.
  - Status: research prompt given to a research agent (branch `claude/progress-week-research`, report
    `Research/Research Reports/Progress and Statistics/Progress Week — Visual Options.md`, checklist
    `Progress Week — Visual Redesign.md`). Then the user picks an option and an implementation agent builds it.
  - **Week built, 2 Oct** (branch `claude/progress-week-cards`, not compiled yet): the user chose cards, removed the
    overview, the rings (Progress and Today's calendar sheet) and the group numbers. See
    [Progress Week — Habit Cards Build](<Progress Week — Habit Cards Build.md>). Month and Year next.

## Next, one after the other

- [x] **2. The habit page needs a serious visual revamp** (the page a habit opens to from Progress or Habits). Again
  not the data: how everything is presented.
  - **Done and merged into `main`, 3 Oct 2026 (18:55 UTC, `4da8999`)** after every UI test class passed: History ·
    Notes · Progress tabs, Add Entry, Year in Pixels, milestones as cards. Checklist: [Habit Details Page — Build](<Habit Details Page — Build.md>).
    Still yours: a look on the iPhone (U9), mainly the Year in Pixels (H22).
- [ ] **3. Account out of Backup & Export.** Backup & Export holds only backup and export (the backup account it
  uses can stay there). Making an account, signing in and deleting the account are not backup things.
  - Account up front: the ≡ sidebar shows the account state, at the bottom or wherever fits, e.g. "No account"
    with a clear "Create an account". Research where it goes and what it says.
- [x] **4. Editing past entries: research.** People must be able to edit entries of past days, not only today's,
  including from Habits → a habit's page. The user's idea: tabs inside each habit's page (to be researched, not
  decided). Start from what exists: `Docs/Checklists/Easy Undo and Fixing Progress.md` (research done 30 Sep, its
  build waiting) and the Day sheet, which already edits one day's entries; find how reachable past days are.
  - *3 Oct:* mostly answered by item 2's habit page: its History tab lists every past day, each opens the Day sheet
    (Add Entry, edit any entry, the day before or after), and Go to Date reaches any day. Check what's left once it's merged.
  - *Done 3 Oct 2026:* merged into `main` with item 2. Every past day is reachable (History, Go to Date, the Day sheet's
    ‹ day ›) and every entry can be added, edited or taken back there. Nothing left.
- [x] **5. The Filter becomes the place to arrange Today.** *Built 3 Oct 2026 on `claude/today-edit-mode`, tests
  passed, merged to `main` 3 Oct; waiting for the user's look on the iPhone (U9); the user changed the plan after research (report 27): Filter only shows less, and Edit on Today becomes
  "Arrange Your Day". Build checklist: `Today — Arrange Your Day (item 5 build).md`.* Original point: From Filter (beside +) people should also edit the times
  of day (sections), groups, and the order of habits: whatever arranging Today needs. Existing research:
  `Research/Research Reports/Home Screen and Visual Design/Today Screen Top Area/17. The View Sheet — Filter, Edit
  and Add in One Place.md`; check it against what's built.
- [x] **6. The bottom of Today: "Note for the day" and "Edit times of day" share one row** *(Done with item 5, 3 Oct:
  "Edit Times of Day" left the bottom; "Note for the Day" is alone there for now, and item 12 decides where it goes.)*, and "Edit times of day"
  gets squeezed onto two lines. One option per row, or another layout that never wraps.
- [x] **7. Today's subtext: decide what each habit row says under its name.** Right now it feels random. Needs
  research and one rule per kind of habit (check-off, weekly goal, amount, timed, limit, quit, task).
  - *Added 3 Oct:* today it's inconsistent: some rows say "3/3 steps" or "3/3 cups", others "25 cups left today".
    Goals differ, but the wording must follow one mental model everywhere (Today, the sheets, widgets, the habit page).
  - *Done and merged into `main` 4 Oct 2026 (`396c40e`):* one line under every name saying what today asks (how far along when
    counted, how often when a single tick, then the time; tasks say "Task"; quit rows their best run). Report [Today's
    Rows — The Line Under the Name, Notes and Spacing](<../../../Research/Research Reports/Day Structure and Organization/Today's Rows — The Line Under the Name, Notes and Spacing.md>);
    checklist [Today — Row Layout, Subtext, Notes and the Task Sheet](<Today — Row Layout, Subtext, Notes and the Task Sheet.md>).
- [x] **8. Swipe actions on Today's rows: research.** Swiping a row left offers only Add note. The frequent actions
  - *Done and merged into `main` 4 Oct 2026:* swipe left Note/Skip/Pause (Log Slip on quit rows), swipe right a named Undo. See [Today — Row Sheet, Swipe Actions, Order and Tap Again](<Today — Row Sheet, Swipe Actions, Order and Tap Again.md>).
  (edit habit, skip, pause, …) should be there too, possibly using the right swipe as well. Research which actions,
  which side and in what order.
- [ ] **9. Widgets: choose the habit, one widget per habit, and a visual overhaul.** Widgets work (free and Plus
  kinds), but adding a widget always shows one particular habit: there's no way to pick which habit, switch to
  another, or have, say, 4 of 6 habits on the Home Screen, one widget each. Make each widget configurable (pick the
  habit, or the habits for a bigger widget), and improve how widgets look: "right now they are not good". A widgets
  agent is starting on its own branch (2 Oct).
- [ ] **10. Groups: test them properly.** Making a group seems to work, but groups and their statistics (group
  chips on Progress, group numbers, the Filter's group choice, editing and ordering groups) were never really
  tested, on the simulator or the iPhone.

- [ ] **11. Bug: the app sometimes stops responding for ~74 s right after launching signed in** (added 2 Oct, from the
  test runs). `BackupUITests.testDeletingTheAccountAndErasingThisPhone` launches with a test sign-in to the dev server;
  in 4 of 13 runs (1–2 Oct) the app didn't respond for about 74 s right after launch, before the test's first step
  (opening the ≡ menu), and the test failed; it passes on a rerun. Not caused by a test step: it happens before any.
  Suspects to check: something blocking the main thread during the sign-in at launch (the keychain, a network call
  waited on, the first backup or sync). Logs: run 36995529935 (`ios-logs` artifact, the test's lines at
  t = 24.86 s → 98.74 s). Find the cause, fix it, and make the test show where the time goes if it happens again.

- [ ] **12. Daily Reflection: research first, then build** (added 3 Oct 2026; maybe the next build, not decided). The
  first **dedicated tracker** (see "Future" below): a mood tracker combined with journaling, a separate thing from
  habits, with its own statistics, completely different from a habit's.
  - **Year in Pixels:** each day of the year one square, coloured by that day's mood (popular on Pinterest and
    YouTube). The main way the mood history is shown.
  - **Not made with +.** It isn't a habit; it's built into the app (how it's turned on is part of the research; a
    Library is a later idea, below).
  - **"Note for the Day" leaves the bottom of Today.** The daily note probably becomes part of Daily Reflection;
    where it goes, and what replaces it on Today, is decided by the research. Nothing changes until then.
  - **Research:** how people see mood tracking and Year in Pixels (reviews of mood and journaling apps, and of habit
    apps that have them), what a day's entry holds (a mood scale, a few words, tags?), where it lives (on Today, its
    own place in ≡, Progress?), how it's reminded, and its stats. Then a design for the user to decide, then build.

- [x] **13. Tapping any habit on Today opens the same sheet** (added 3 Oct 2026; after the Progress work, or alongside
  - *Done and merged into `main` 4 Oct 2026:* the row opens its Day sheet (every habit kind, and tasks too since the user's next request: Done, date, Do Tomorrow), one shape for all; Delete in its ⋯ menu. Same checklist.
  it as separate work). One mental model, whatever the kind of habit.
  - **Today it's inconsistent:** tapping a row's body opens a bottom sheet only for amounts and timed habits (the
    "Log amount / Log time manually" sheet, `HabitRow` `.onTapGesture` when `logsNumbers`). Check-offs, checklists,
    tasks and quit habits open nothing; their options are only in the touch-and-hold menu, which people may not find.
  - **The sheet, for every kind:** today's progress (and changing it), plus quick options: Edit Habit, Pause, Skip,
    Add Note, and a way to the habit's own page (details and history). The ✓, + and ▶ buttons keep logging in one
    tap; the sheet is for the row itself.
  - **Research before building:** what the sheet shows per kind (check-off, amount, timed, limit, checklist, task,
    quit), how it relates to the existing Day sheet ("Edit Today's Progress") and the log sheet so there's one sheet,
    not three, and which actions go in it (with item 8, swipe actions, so the two agree).

- [ ] **14. Cut-down habits (limits): where do they belong?** (added 3 Oct 2026) Keeping them inside the times of day
  feels weird. The user's thought: show them in the Quitting section instead. Research how people think of a limit
  ("cut down on coffee") next to quitting and next to build habits, then decide.
- [ ] **15. Timed habits: what should tapping ▶ do?** (added 3 Oct 2026) Today ▶ starts an inline timer on the row.
  Research whether that's what people expect, or whether ▶ should open a full-screen timer, or both (and which is
  the default).
- [ ] **16. Timers and the Dynamic Island / Live Activity.** (added 3 Oct 2026) Starting a timer sometimes goes
  straight into the Dynamic Island. Keep it, but make it behave the way people expect, reliably, and add a way to
  turn it off. Research when it should appear, then fix.
- [x] **17. Bug: the routine player's bottom spacing is wrong.** (added 3 Oct 2026) Fix the spacing at the bottom of
  the routine (focus) player's screen; check on the iPhone (U9).
  - *4 Oct 2026, the user's details:* treat ‹ · Habit options · › as a bottom navigation, about 40 points from the
    screen's bottom edge, ample room around it against misclicks, and **no layout shift** of the main button or the
    row whatever changes on the screen. Checklist: [Routine Player — Bottom Row, Options Sheet and Switches](<Routine Player — Bottom Row, Options Sheet and Switches.md>). Built on
    `claude/weekly-overview-stats-ly55gk`; tests passed 4 Oct (`b6bd7d1`). Still yours: a look on the iPhone (U9).
- [ ] **18. Completion feedback for every kind of habit.** (added 3 Oct 2026) A check-off plays the sound (and haptic)
  when it's done, which is nice; timed habits, amounts, checklists and others don't. Decide when each kind counts
  as "done" for feedback (goal reached, timer reaches its goal, last step ticked) and make it consistent.

- [ ] **19. Exportable progress reports, for the Progress page** (added 3 Oct 2026; build now if it fits, otherwise it moves to Future; the
  user decides later). A report of progress people can export and share (a PDF or image of a week, month or year),
  as the Progress research suggests. Different from Backup & Export's data file. Start from the Progress research:
  "Progress and Statistics — What People Want" (export and reports by email) and "The Progress Page — What People
  Need" (Export: ledger C020, Strong, 35 apps; it said export lives outside the Progress screen), then decide what a
  report holds and where it's made, after the Progress redesign is merged.

- [ ] **20. Each habit's Year in Pixels, exportable** (added 3 Oct 2026; build now if it fits, otherwise it moves to
  Future; the user decides later). On a habit's own page: its year as one square per day, coloured by how that day
  went, which people can export and share as an image. This is for **one habit**; item 19 is the Progress page's
  week, month and year reports, and item 12's Year in Pixels is for mood. Use the same pixel grid for both.

- [x] **21. Done habits sinking to the bottom of Today: discuss before changing** (added 3 Oct 2026). Today, ticking
  - *Done and merged 4 Oct 2026.* The user first chose "stay in place", then, the same day, **done habits move down** (final). Move to Bottom is the default again; Stay in Place stays in Appearance. Checklist "Today — Row Layout, Subtext, Notes and the Task Sheet" L1.
  a habit plays the sound and, once Today settles (1.5 s after the last tap, U4), moves the row below the rest of its
  time of day. But the order is now the person's own (Rulebook U13, from Arrange Your Day, `claude/today-edit-mode`,
  merged 3 Oct): a new habit goes to the end of its section and nothing reorders itself. Moving a done habit to the
  bottom works against that: the habit should most likely stay where the person put it.
  - **What exists:** ≡ → Appearance → Today → **Done Habits**: "Move to Bottom" (the default) or "Keep in Place"
    (`DoneOrder`, `PartSection.doneLast`). U13 currently allows it ("only done rows settle"), and Design Rules'
    Today section says "done rows sink". Hide Completed Habits (the Filter) is a separate thing and stays.
  - **To discuss with the user first** (a short discussion, not a research report): should done habits keep their
    place by default; does "Move to Bottom" stay as an option or go; how a done row then looks finished without
    moving (it's already tinted and ticked); and whether finished times of day still fold. Then update U13, Design
    Rules and the setting together, and the tests that expect done rows below (U4's hold stays either way).
  - The sound itself is item 18 (completion feedback for every kind of habit).

- [x] **22. Bug: Habit options in the routine player hid its last options** (added 4 Oct 2026). For Read it showed Log
  time manually, Skip today, Undo, Show clock and Add Note; Edit Habit was only there after scrolling. Same checklist as
  item 17 (P5): the sheet now fits its options.
- [x] **23. Bug: the routine player's Show clock switch was white in dark mode** (added 4 Oct 2026; the switches were
  meant to be green everywhere since 2 Oct). Same checklist (P6, P7): every switch now uses one green style, checked by
  `check_rules.sh`; a group's habit picker uses Select's blue circles.

## Future (after release; not to start now)

- [ ] **Dedicated trackers** (added 3 Oct 2026): ready-made trackers with their own screens and stats, which can't be
  made from +. Examples to research: sleep, and other trackers that are popular with people; Daily Reflection (item
  12) is the first.
- [ ] **Guided habits:** habits that come with guidance, added the same way.
- [ ] **Exportable progress reports** (the same as item 19): if it isn't built before release, it's built after.
- [ ] **Each habit's exportable Year in Pixels** (the same as item 20): if it isn't built before release, it's built
  after.
- [ ] **A Library** to add dedicated trackers and guided habits from (or wherever research says they belong). Only
  after release.

## Done from this list

(Nothing yet.)
