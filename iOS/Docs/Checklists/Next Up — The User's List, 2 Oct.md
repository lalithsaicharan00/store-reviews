# Next Up — The User's List, 2 Oct

Written by Claude (Claude Code), 2 October 2026, from the user's own list: "These are the things that I want to
update, but not exactly right now. We will update them one after the other." Work them **in order, one at a time**;
tick each when it's done and link what was built or written. Every item follows
[the Rulebook](<../../../RULEBOOK.md>), and a screen's section in `Design Rules — Don't Regress.md`.

## Now

- [ ] **1. Progress page: a big visual overhaul of Week, Month and Year.** Not the data (it's right and complete) but
  how it's presented: today it reads "okay, not good", too dense, rows squeezed. **Week first** (overview card →
  habit cards → quit section), then Month, then Year.
  - The user's Week points: rows too tight (top and bottom padding); the icon centred against 2–4 lines of text
    looks wrong; the day marks (dotted circle, ring, part ring…) don't explain themselves; the overview should be
    genuinely attractive. The top (range tabs, period ‹ ›, group chips, View Options) stays as it is.
  - Status: research prompt given to a research agent (branch `claude/progress-week-research`, report
    `Research/Research Reports/Progress and Statistics/Progress Week — Visual Options.md`, checklist
    `Progress Week — Visual Redesign.md`). Then the user picks an option and an implementation agent builds it.

## Next, one after the other

- [ ] **2. The habit page needs a serious visual revamp** (the page a habit opens to from Progress or Habits). Again
  not the data: how everything is presented.
- [ ] **3. Account out of Backup & Export.** Backup & Export holds only backup and export (the backup account it
  uses can stay there). Making an account, signing in and deleting the account are not backup things.
  - Account up front: the ≡ sidebar shows the account state, at the bottom or wherever fits, e.g. "No account"
    with a clear "Create an account". Research where it goes and what it says.
- [ ] **4. Editing past entries: research.** People must be able to edit entries of past days, not only today's,
  including from Habits → a habit's page. The user's idea: tabs inside each habit's page (to be researched, not
  decided). Start from what exists: `Docs/Checklists/Easy Undo and Fixing Progress.md` (research done 30 Sep, its
  build waiting) and the Day sheet, which already edits one day's entries; find how reachable past days are.
- [x] **5. The Filter becomes the place to arrange Today.** *Built 3 Oct 2026 on `claude/today-edit-mode`, tests
  running; the user changed the plan after research (report 27): Filter only shows less, and Edit on Today becomes
  "Arrange Your Day". Build checklist: `Today — Arrange Your Day (item 5 build).md`.* Original point: From Filter (beside +) people should also edit the times
  of day (sections), groups, and the order of habits: whatever arranging Today needs. Existing research:
  `Research/Research Reports/Home Screen and Visual Design/Today Screen Top Area/17. The View Sheet — Filter, Edit
  and Add in One Place.md`; check it against what's built.
- [x] **6. The bottom of Today: "Note for the day" and "Edit times of day" share one row** *(Done with item 5, 3 Oct:
  "Edit Times of Day" left the bottom; "Note for the Day" is alone there for now, and item 12 decides where it goes.)*, and "Edit times of day"
  gets squeezed onto two lines. One option per row, or another layout that never wraps.
- [ ] **7. Today's subtext: decide what each habit row says under its name.** Right now it feels random. Needs
  research and one rule per kind of habit (check-off, weekly goal, amount, timed, limit, quit, task).
- [ ] **8. Swipe actions on Today's rows: research.** Swiping a row left offers only Add note. The frequent actions
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

## Future (after release; not to start now)

- [ ] **Dedicated trackers** (added 3 Oct 2026): ready-made trackers with their own screens and stats, which can't be
  made from +. Examples to research: sleep, and other trackers that are popular with people; Daily Reflection (item
  12) is the first.
- [ ] **Guided habits:** habits that come with guidance, added the same way.
- [ ] **A Library** to add dedicated trackers and guided habits from (or wherever research says they belong). Only
  after release.

## Done from this list

(Nothing yet.)
