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
  - **Week built, 2 Oct** (branch `claude/progress-week-cards`, not compiled yet): the user chose cards, removed the
    overview, the rings (Progress and Today's calendar sheet) and the group numbers. See
    [Progress Week — Habit Cards Build](<Progress Week — Habit Cards Build.md>). Month and Year next.

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
- [ ] **5. The Filter becomes the place to arrange Today.** From Filter (beside +) people should also edit the times
  of day (sections), groups, and the order of habits: whatever arranging Today needs. Existing research:
  `Research/Research Reports/Home Screen and Visual Design/Today Screen Top Area/17. The View Sheet — Filter, Edit
  and Add in One Place.md`; check it against what's built.
- [ ] **6. The bottom of Today: "Note for the day" and "Edit times of day" share one row**, and "Edit times of day"
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

## Done from this list

(Nothing yet.)
