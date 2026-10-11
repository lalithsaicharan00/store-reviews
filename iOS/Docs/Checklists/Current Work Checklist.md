# Current Work Checklist

Written by Claude (Claude Code), 2 October 2026, from the user's own list.
Renamed and organized by Codex, 4 October 2026. Formerly “Next Up — The User's List, 2 Oct”.

This is the working checklist for recent feedback, existing issues and agreed improvements. The wider feature
roadmap and original implementation rounds are in [Product Roadmap](<../../Product Roadmap.md>).

**Current priority (the user, 4 October 2026):** find and fix issues in existing functionality now. Keep later
feature work planned until the user starts it. The issues below are recorded reports or validation gaps; an unchecked
box is not proof that a bug still reproduces on the current build.

**Documentation commit and push authorized (the user, 4 October 2026):** commit the collected documentation and
push it to `main`. This supersedes the earlier local-only and remote-sync holds for these changes. Use ordinary
documentation commit messages without test/performance trigger tags or the widget cancellation tag while the
existing tests run. Recording an issue does not authorize implementing it or starting another test run.

## How to maintain this checklist

- Add recent feedback and newly found issues here. Keep original item numbers stable so linked specs and evidence
  still resolve; give new items the next unused number (currently 82).
- Record the symptom, expected behavior and evidence for an issue; reproduce it on the current code before fixing.
  Record implementation progress separately from testing and the user's device review.
- Tick an item when it's built and its tests have passed on GitHub (the user, 5 Oct 2026: "implementation and testing
  on GitHub; checking on the iPhone is a different thing"), with the date and the commit or run. Move its whole entry
  to Completed; note the iPhone check (U9) on it while it's still open, and retain decisions and remaining checks.
- An item that spans both documents has one current status here; link to it from Product Roadmap rather than
  maintaining two competing statuses. Broader capabilities not covered here remain maintained in the roadmap.
- Follow [the Rulebook](<../../../RULEBOOK.md>) and the screen's section in `Design Rules — Don't Regress.md`.
  Research or product decisions already required by an item remain required.

The original request was to update these items “one after the other,” rather than all at once. Planned improvements
retain their original order; the issues and validation section comes first under the user's latest priority.

## Issues and validation — current priority

Item 22 is the user's first issue in the current feedback round and is listed first. Items 11 and 17 are reported
bugs. Item 16 combines reliability work with a product decision; item 18 is a consistency gap; item 10 is validation
work. Preserve those distinctions when recording findings. New feedback items 23–32 (4 October) are recorded
below as independent tasks: functional/readability issues here, layout and research work under Planned improvements.
Their placement records scope and priority; implementation has not started.

- [ ] **83. Widgets faster, widget and App Lock issues fixed, and the widget lock opened for speed work** (added 11
  October 2026, from the user, during item 81: "work on widgets as well, improve performance, but preserve overall
  like switch based widgets, and syncing and all of that, because data should be handled robustly and should never be
  lost; and fix widgets related issues and app lock related issues as well; once these are complete mark them as
  complete in the checklist; and also update the locked documentation of widgets so that for performance and
  improvement agents can work on it, but [keep] the near-instant switch-based widget UI updating, and they give top
  data robustness and syncing reliability, so no matter what, data is never lost").
  - [ ] **Widget speed:** "Widgets: one habit's week" took up to 831 ms on the main thread with 20,000 extra logs (item
    81's speed run; 50–120 ms with a year's demo history). Make it fast without changing what a widget shows, how a
    tap shows (the switch, W1–W3) or how it's saved and synced (W4, W5, W18).
  - [ ] **Widget issues:** items 64, 65 and 66 have only their tests on GitHub left (`WidgetUITests`,
    `WidgetSystemUITests`, `TodayUITests`, `TodayRowLayoutUITests`, `RoutineCalendarUITests`, `TimerUITests`): run
    them, fix what fails.
  - [ ] **App Lock issues:** item 58.13 has its tests on GitHub left (`AppLockUITests`, `SmallScreenUITests` on the SE);
    `SmallScreenUITests.testPrivacyCodeSheetsAndReminderSaysFit` fails on `main` too (run `38085507312`): find why and
    fix it.
  - [ ] **The widget lock opened for speed work** (the user's say-so): update
    [Widgets — Taps and Updates (Locked)](<../Widgets — Taps and Updates (Locked).md>), Rulebook U28 and the code's
    `LOCKED` notes: agents may improve widget performance and fix bugs, as long as the switch-based instant update, the
    hand-over saving, idempotent taps, the waiting-taps safety net and syncing without opening the app all stay exactly
    as they are, checked the same way. W18 also names the server sync (`SyncService`), now iCloud (`CloudSync`).

### The cloud session's list (the user, 8 Oct 2026)

Written by Claude (Claude Code), 8 October 2026, from the user's request. Branch `claude/exciting-mccarthy-g6vlu5`
(the session's branch; made from `main` at `e3afd6c`). **One item at a time, in this order;** an item is finished
when it's built, its tests have passed on GitHub and it's ticked here with the date and the run ID. When all are done:
merge `main` in, run every touched test class plus a speed run once more, then merge into `main` (the user approved
that merge). The other agent works on its own branches (`sync-*`); never touch those or their runs (W3, T10).

**Final check and merge (9 Oct 2026):** `main` (the other agent's 67–72 and 58) merged in; every touched class passed
on the merged code: runs `37883781450` (34/34), `37892533149` (15/15), `37892535525` (25/25); speed `37883786912` (every
scenario: Today scrolling 0.0 ms/s, +1 0.4, day ‹ › 9.5, habit form typing 11.3, Progress period ‹ › 82.6 with no freeze)
and `37892538257` (Add note typing 0.0, Edit note 0.7); habit page side by side with `main` `37889969212` (Progress
scrolling median 5.9 against 9.1). Found on the way and fixed: Add note's keyboard that never came on a slow simulator
(asked again until iOS shows it). Merged into `main` by fast-forward.

**iPhone checks still to do (U9):** 49 the speed numbers on the phone (`measure_perf_device.sh`; day ‹ ›, habit form
typing and Progress's period switch are above the targets on every build); 18 the completion sound and haptic for each
kind; 26 and 28 History's and Notes' buttons, light and dark; 74 run any UI test on the phone, then open the app: your own
habits on the widgets, your Today settings unchanged; 32 Year in Pixels' day numbers, larger text and dark; 31 the
Progress tab cards' spacing, larger text and dark; 23 the streak pair; 53 a first drag in Groups after opening the app;
and the Add note keyboard coming up by itself.

- [x] 1. **Item 49**: the speed regression. *Done 8 Oct: nothing had got slower side by side (runs `37774018835`,
  `37788595991`, `37797217908`, `37804587883`); iPhone speed check still to do.* Bisect the timer/swipe/limits/completion-sound merge with speed runs
  (`scroll-today`, `tap-today`, `new-habit`, `progress`), variants side by side in one run (S2); fix it; numbers
  back under the targets; numbers in `iOS/PERFORMANCE-LESSONS.md`. The iPhone speed check stays to do.
- [ ] 2. **Item 53**: `GroupsUITests.testGroupOrderIsThePersonsOwn`: why the drop sometimes misses; fix the cause,
  never loosen the test (T2). *Mitigated, not closed (9 Oct): only a launch's first drag misses, rarely; the drop is
  cancelled on release. Fixed what was found (drop point, S7, a 2 s hold); cause not proven. Runs `37812076363`,
  `37817858014`, `37821382415`, `37865611952`, `37869406687`.*
- [x] 3. **Items 18, 25, 26, 28**: run their pending tests (`CompletionFeedbackUITests`, `HabitPageUITests`
  `testHistoryFlows` and `testNotesFlows`, the squares-key tests; 25 is superseded by 57), fix failures, tick each.
  *Done 8 Oct: all 11 passed first time, run `37826155392`; iPhone checks for 18, 26, 28 still to do.*
- [x] 4. **Item 74** (new): a `-uitest` launch on a real iPhone must not write the widgets' shared file or the
  person's settings (D8). Prove it with a test. *Done 8 Oct: run `37831649390` (24/24); iPhone check still to do.*
- [x] 5. **Item 32**: Year in Pixels shows every day number 1–31, in Progress and on the habit page; simulator
  screenshots in the run; the iPhone look stays to do (U9). *Done 8 Oct: run `37847053285`; iPhone look still to do.*
- [x] 6. **Item 31**: Week, Month and Year card padding and spacing (Progress and the habit page's Progress tab);
  screenshots; the iPhone look stays to do. *Done 8 Oct: runs `37853078424`, `37858625841`; iPhone look still to do.*
- [x] 7. **Item 23**: streaks back on the habit page, in its Progress tab; screenshots; the iPhone look stays to do.
  *Done 9 Oct: run `37860896648` (13/13); iPhone look still to do.*

- [ ] **22. Today row sheet: make logging and wording natural for each habit type, especially check-based habits
  and tasks.** Added 4 October 2026; **issue 1 of the user's current feedback round**. Status: documented from the
  user's observation; current-code and screenshot audit plus research proposal recorded on 4 October in
  [The Habit Day Sheet — Wording, Hierarchy and Actions](<../../../Research/Research Reports/Day Structure and Organization/Day Details and Entry Editor Handoff/The Habit Day Sheet — Wording, Hierarchy and Actions.md>).
  Implementation and device validation remain pending. **Built 4 October on branch `details-page-update`; see item 47.**
  - **Research and Figma mockups revised, 4 October:** [21 editable variants](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=370-2031) cover the main tracking types, past day, monthly goal, skipped binary and amount days (including saved logs/note), paused state, limit over threshold, running timer, slip correction and light mode. The user's latest placement and Skip feedback is represented; implementation and device validation remain pending.
  - **Latest user review incorporated, 4 October:** use native regular-size logging controls. Where quick and manual logging coexist, keep equal height and width, but use style for priority: prominent quick actions for positive goals (Mark done, Add 1 glass, Start timer), bordered logging on limits and for slips (U16). The day note is a full-width labelled text-area-like preview after activity, opens the separate note editor, and remains usable while skipped. Skip is a full-width bordered button below it, not a navigation row. **The same button changes to Undo skip in the same position**; primary/manual new-log controls remain visible but disabled, and saved logs and notes remain visible (U15). Remove the bottom date pager from this proposal because the earlier report supplied a consistency inference, not evidence of intra-sheet paging; selected date remains in the toolbar, and Today/habit calendar still open past-day sheets (U5). Figma and the research report now reflect this; code and device validation remain pending. Current `DaySheet.swift` still allows its generic Add Entry path while skipped, so implementation must disable that path too.
  - **Spacing review incorporated, 4 October:** all 21 Figma states now group the selected-day status, its logging control(s) and any saved logs with smaller internal gaps, then give that whole activity larger top and bottom margins. The note field and Skip/Undo skip have a larger gap because they perform different jobs. The [research report](<../../../Research/Research Reports/Day Structure and Organization/Day Details and Entry Editor Handoff/The Habit Day Sheet — Wording, Hierarchy and Actions.md#spacing-and-grouping-4-october>) records the Figma spacing rhythm and the proximity/layout guidance behind it. These are gaps between elements, not extra card padding; adapt them to native SwiftUI and Dynamic Type when implementing (U1/U9/U17).
  - **Close-control review, 4 October:** the [21 Figma variants](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=370-2031) now use an icon-only `xmark` proxy instead of the word Close. Both trailing Close and leading ⋯ have 44 pt hit regions, keeping the day title centred. In the iOS implementation use the standard SF Symbol `xmark` with accessible name **Close**; keep Cancel/Save/Done text for editors with draft or completion semantics (U1/U18). The [research report](<../../../Research/Research Reports/Day Structure and Organization/Day Details and Entry Editor Handoff/The Habit Day Sheet — Wording, Hierarchy and Actions.md#close-icon-in-the-day-sheet-4-october>) records the Apple toolbar/sheet rationale. App code and device validation remain pending.
  - **4 October design brief:** rename the sheet's visible header to the selected day; remove the duplicate habit name;
    make current state and correction visually dominant; compare centered versus leading-aligned habit identity;
    make the identity/chevron an explicit path to the habit page; show note text when one exists; group Edit,
    Pause/Resume, Archive and Delete in the native ⋯ menu with destructive actions last. Mock up all major habit
    types, selected past days, skipped/paused states and the menu before implementation. Research supports using
    checks/steps for completion and logs for amount/time; validate the proposed copy with users.
  - **Where it happens:** Home → Today → tap the body of a habit or task row → the bottom-up sheet. It brings together
    that day's progress and the row's options. The recent implementation uses a shared presentation across habit
    types to maintain one mental model (completed item 13). The user's concern is that the same entry-oriented
    wording and controls do not make sense for every type, even though a coherent sheet is still wanted.
  - **Single daily check / binary habit:** presenting “Today's entries” and “Add entry” feels unnecessary and
    confusing when the person's action is simply checking whether they did the habit. The user questions whether
    any entry-oriented presentation should be visible for a once-a-day check at all. Design around the action and
    state the person understands; do not expose the storage model as an explanation of checking something off.
  - **Tasks:** the same concern applies to tasks completed with a checkmark. Make their completion state and action
    understandable without making the person think they are adding a tracking entry. Preserve the relevant task
    options already available in the sheet.
  - **Check-based habits with repeated or period goals:** explicitly cover multiple checks per day, weekly goals
    and monthly goals. Even when several completions exist, calling them “entries” still feels strange to the user.
    Find intuitive wording and controls that communicate what a check adds and what undo changes. Do not assume
    that having multiple records makes the generic entry terminology appropriate.
  - **Quantity-based tracking:** adding an individual record does make sense for quantities. Preserve the ability
    to log amounts and inspect or correct individual logs. Differentiate this legitimate logging model from binary
    completion; avoid removing useful logging controls merely to make every sheet look identical.
  - **History versus Today (clarified by the user, 4 October):** adding an entry from a habit's History tab does
    make sense. The concern about unnecessary entry controls is specifically the Today sheet for check-based /
    checklist-based tracking. Review both binary checks and multi-step checklists as applicable; do not remove the
    History action as a blanket fix for the Today wording problem. History action readability and placement are
    separate items 26 and 27.
  - **Wording:** review “Add entry,” “Today's entries,” and related headings and actions throughout this sheet.
    “Add entry” itself is confusing, not only its placement on a check-based habit. Choose words that make the
    action clear for each type. No replacement wording has been chosen by the user yet. If the person is viewing a
    past day, the sheet must describe that selected day rather than imply it always contains today's records.
  - **Green checkmark:** the checkmark inside the sheet is currently green in the user's observation, and the user
    wants that corrected. Another agent has already been asked to work on it. First verify whether its fix is
    present in the current code/build; if it is, retain and validate it rather than duplicate the work. If it is
    absent, correct it as part of this issue. The intended replacement appearance is not specified in this request;
    check the relevant design decision and the other fix before choosing one. This observation concerns the sheet's
    checkmark, not a request to change all system switches or selection controls.
  - **Overall goal:** a sheet that is easy to log in, intuitive and easy to understand. Keep a familiar, coherent
    interaction model while adapting the content, words and primary action to what each habit actually tracks.
    Review the whole sheet rather than treating this as a single label replacement. Keep relevant editing, undo,
    notes and habit-management options reachable; preserve recorded progress and the existing completion rules.
  - **Validation before completion:** review the following cases on the implemented build; record evidence rather
    than ticking this item after a text-only edit. Update affected UI tests with the final labels under Rulebook T3,
    run the required checks when this work is authorized, and review the changed sheet on the real iPhone (U9).

    | Case | What must be understandable |
    |---|---|
    | Once-a-day binary habit, incomplete and complete | Current state, check-off action and undo without unnecessary entry terminology |
    | Task, incomplete and complete | Task completion and relevant options without confusing tracking-entry controls |
    | Multiple checks per day | Each check, progress toward the goal and the effect of undo |
    | Weekly or monthly check goal | The selected day's checks and their relationship to the period goal |
    | Quantity-based habit with several logs | Adding an amount and inspecting, editing or undoing an individual log |
    | Other habit types supported by the shared sheet | Appropriate actions and wording, with existing behavior retained |
    | A past day; green-checkmark fix; light and dark appearance | Correct day context and the intended checkmark appearance |

  - **Related work:** this refines completed item 13 rather than reopening its implementation as if it never
    happened. Detailed previous requirements and decisions are in
    [Today — Row Sheet, Swipe Actions, Order and Tap Again](<Today — Row Sheet, Swipe Actions, Order and Tap Again.md>)
    and [Today — Row Layout, Subtext, Notes and the Task Sheet](<Today — Row Layout, Subtext, Notes and the Task Sheet.md>).

- [ ] **53. `GroupsUITests.testGroupOrderIsThePersonsOwn` fails on `main` now and then (three nights in a row): the dragged group doesn't move.**
  Added 6 October 2026 by Claude (Claude Code); found by the full test for items 50–52, not by the user. Not caused by
  that branch: `main` itself (`f0e52f4`) fails it the same way (run `37400560919`).
  - **Evidence:** the same test code (with 5 Oct's held drag, `6c749f8`) passed on `main` at 12:31 UTC (run
    `37298794001`) and failed at 00:40, 01:24 and 02:03 UTC (runs `37390751325`, `37395447112`, `37400560919`); before
    the held drag it also failed once at 05:07 UTC. The screenshot after the drag shows Groups still A to Z ("A to Z.
    Drag a group…"), so the list never took the drop, or `moveGroups` didn't save it.
  - **Then passed** at ~04:00 UTC on the same branch (run `37410173465`), so it's intermittent, not only at night.
  - **To do:** find what makes the drop miss (machine speed, the drag's timing); don't loosen the test (T2).
  - **8 Oct 2026 (cloud session): what the recordings show.** The failing run's screen recording (`37400560919`, 6 Oct,
    02:01 UTC) shows Home lifted and dragged up, Health making room, then, as the drag reached the test's target (5 % down
    the Health row, 3.5 pt under the section's top), the lifted row riding over the section header, the gap closing,
    and Home going back on release: the list never called `onMove` (the hierarchy after: A to Z, footer "A to Z"). With
    the target moved inside the rows (Health's upper third), one more run failed (`37812076363`, 17:22 UTC): its
    recording shows Health making room and the drop held there for the 0.6 s, and still undone on release. The
    machines were slow (XCUITest needed 8–16 s to synthesise the drag; 30 s per accessibility query in one run).
  - **Changed, 8–9 Oct:** (1) the test drops inside the rows, never at a section's edge (the first recording); (2)
    `moveGroups` changes the list before `onMove` returns and writes after, as every tap does (S7; before, the row
    snapped back under the finger and jumped when the write landed); (3) both drag tests hold the drop 2 s before
    letting go (the assertion is unchanged). Tried and taken back: leaving drags to the Filter sheet's content
    (`presentationContentInteraction(.scrolls)` on a group screen): the miss came back with it (run `37865611952`).
  - **What the runs show:** `GroupsUITests` 10/10 (run `37821382415`, 16 repeated drags, 0 missed); then, after
    `main` was merged in, the probe caught it once (`37865611952`: **1 of 6, the first drag after the launch**; drags 2–6
    took). Every failure so far is a launch's first drag, on a slow machine: its recording shows the row lifted, moved
    above Health, Health making room, the row held, and undone on release, so the list never called `onMove`. Likely
    cause, **not proven**: the first lift of a launch pays a one-time cost (the first drag preview and haptic), and
    XCUITest's moves and release then arrive together, with no hold. `testGroupDragDropsReliably` now repeats exactly
    that case (a new launch, the first drag) four times; run `37869406687` measured 0.6 s and 2 s holds side by side:
    0 of 4 missed either way, and `testGroupOrderIsThePersonsOwn` passed. The miss is rarer than 1 in 10 first drags.
  - [ ] **Mitigated 9 Oct 2026, cause not proven** (cloud session). Leave open: if the probe or the nightly test misses
    again, compare holds with `[0.6, 2.0]` in the probe and record a launch's first lift (`sample` or a
    `perfTimed` around the first edit-mode drag) on the same machine. iPhone check: a person's first drag in Groups
    after opening the app stays where it's dropped.

- [ ] **47. Build Day details and the one-log editor from the 4 October handoff.** Added 4 October 2026, from the
  user; branch **`details-page-update`** (the user asked for a meaningfully named branch to test from). Implements
  items 22 and 36. Each point the user made:
  - [x] Follow the mockups for every habit type: once-a-day, weekly/monthly, several-a-day checks, checklist, amount
    goal and limit, time goal, a running timer, quit (no slip / with slips), task (not done / note / done), skipped,
    paused and past days. `DaySheet.swift`, `DayActivity.swift`.
  - [x] Native components everywhere, keeping the layout and idea: `Form` sections, `NavigationLink` rows, `Menu`,
    SF Symbol `xmark` Close, native-size `.borderedProminent` / `.bordered` buttons, native alert and dialog.
  - [x] Spacing: related things close (status → its buttons 10, quick → manual 8), unrelated further (28 around the day's
    activity, 24 note → Skip), with `@ScaledMetric` for Dynamic Type (U17). *Check the rhythm on the iPhone.*
  - [x] Skip at the bottom, only where the habit can be skipped (not a limit, quit, week/month total or task); Undo
    skip in the same place (U15).
  - [x] Logs as a native section: a heading, then one row per log, shown only when there are logs.
  - [x] Research the editor's Delete: decided on a red-text destructive row with no red fill, in its own last section,
    still confirmed by an alert ([note](<../../../Research/Research Reports/Day Structure and Organization/Day Details and Entry Editor Handoff/Editing One Habit Log — Scope, Fields and Recovery.md#delete-button-style-in-the-native-build-4-october-implementation>); U19 updated).
  - [x] Editor Back: the system chevron with no title (`toolbarRole(.editor)`); with changes it asks before discarding.
  - [x] Buttons look native and right: prominent only for a positive goal's next step (Mark done, Add 1 glass, Add a
    check, Start timer); bordered for manual logging, limits, slips, Undo and Skip (U16).
  - [x] UI tests updated for the changed labels (T3: `TodayRowSheetUITests`, `TodayRowLayoutUITests`, `UndoUITests`,
    `HabitPageUITests`, `GoalFlowUITests`), plus new `DayDetailsUITests` covering every kind, skip with logs and note,
    Edit Log discard/delete, a multi-check record, a quit slip's edit and delete, and dark-mode screenshots.
  - [x] Test on GitHub Actions (T7/T10), 4 Oct 2026. Run `37202400309` (`4ebea87`): build and Release passed; 33/36
    UI tests passed; 3 test-step failures fixed. The speed run found Edit Log typing at 26–40 ms/s against 1–11 before,
    because a "changed" flag redrew the editor each keystroke; it was made sticky, and run `37205960716` (`b5492ee`)
    measured 5.7–7.4 ms/s, with 48/49 UI tests passing (one launch wait too short: the failure screenshot showed the
    sheet open). Run `37209334247` (`91e0e29`): all 31 screenshot states and DayDetails, HabitPage and GoalFlow
    tests passed. It hit the 60-minute job limit during TodayRowLayoutUITests (2 of 4 run, both passed);
    TodayRowSheetUITests and UndoUITests passed on `b5492ee`/`4ebea87`, and the last commit only changed the
    editor's unit word and the Day-details source label. "Day sheet: add, edit and exact undo" varies run to run
    (118–360 ms/s here; 130–250 on the earlier `habit-details-perf` runs); keep watching it on the phone.
  - [x] Screenshots of all 31 wireframe states as built, side by side with the wireframes (`DayDetailsScreenshotUITests`,
    `DayDetailsFixture`).
  - [ ] The real iPhone in light/dark, large text and VoiceOver; check the spacing rhythm (U9/U17).
  - **Follow-up from the screenshot review (the user, 4 Oct 2026):**
    - [x] Skip stays where it is, at the end of the sheet, not pinned: "users will find it". A pinned bar
      ([mockup](https://claude.ai/artifact/YYbW4XnXabBxVPjeaH5Gys)) was proposed and set aside for now; revisit if the
      iPhone check shows Skip lost below long sheets (state 21).
    - [x] Task sheet: the Date row (and the done task's "Planned for" row) is gone; the line under the name says when.
      A **Reschedule** section holds Do Tomorrow and Another Day…; the calendar shows only the days it can move to,
      with no explanatory text.
    - [x] Repeating tasks reschedule too, under one rule: only today's occurrence, and only to a day before its next
      occurrence. A daily task has no Reschedule (tomorrow is its next one). Stored per task as `move.<id>` settings
      like skips (synced and backed up; added to the core's merge-restore list). `HabitStore.moveOccurrence`,
      `rescheduleRange`, `canReschedule`; `isDue` follows moves.
    - [x] No Skip for tasks.
  - **Habit page (the user, 5 Oct 2026): "within the habit details, History, click on any day: the same thing for that day."**
    - [x] Already the same sheet: History, the Progress tab's days and Notes all open `DaySheet` for that day (no link
      back to the page; a past day's wording; no timer; Reschedule only for today's task occurrence).
    - [x] Logs with no recorded source show only their time ("Source not recorded" on every old log was noise).
    - [x] `DayDetailsUITests.testHistoryDaysOpenDayDetails`: an earlier day from History for an amount, time, check,
      checklist and weekly habit, with screenshots. Run `37266637759` (`228e73d`), 5 Oct 2026: build, Release and 10/10
      UI tests passed (with `HabitPageUITests.testHistoryFlows` and `UndoUITests`).
    - Noticed: a past week's day says "3 of 3 checks this week" (Call family on Tue, Sep 29); "that week" would be
      clearer for a day outside the current week. Not changed yet.
    - [x] Tested on GitHub Actions run `37220482604` (`5363659`), 4 Oct 2026: Core storage and migrations, build, Release build and 28/28 UI tests passed (DayDetails incl. `testTasksReschedule`, TodayRowLayout, TodayRowSheet, Undo, and the three task screenshot states). Screenshots: a weekly task's calendar offers only the days before next week's occurrence; a daily task and a done task show no Reschedule.
  - **Found by the merge test (run `37281527130`, 5 Oct 2026):** after typing in Edit Log, iOS 26 showed two back chevrons (the system's, which should have hidden, and the editor's), and Back's discard dialog sometimes didn't appear. Fixed: one chevron, always the editor's own; the question is an alert. Rulebook U19 updated.
  - **Merged into `main` 5 Oct 2026** (the user's go-ahead; fast-forward after merging `main`'s habit-details research in). Numbered 42 on the branch; renumbered 47 because `main` had used 42–46 meanwhile. Open: the iPhone check.
  - Not done, by design: a slip's **date** stays read-only until the store, repository and sync can move one record
    to another day atomically (D7; handoff). The bottom ‹ day › pager is gone (handoff; past days open from Today or
    History). A multi-check habit lost its whole-day Done switch (research matrix "Avoid"); History's Add Entry
    still adds several checks at once (U5).

- [ ] **64. Check habits with a week or month goal (and several a day) show +1 instead of ✓.** Added 7 October 2026, from
  the user: "the user has chosen a check-based habit specifically… you are turning it into an amount or quantity-based
  habit." Item 54 (6 Oct) had turned them into +1 counters to stop the sound and the fill after one tap.
  - **The user's rule:** a check habit's button is ✓ wherever it shows. Each tap adds one check and never takes one back;
    the Undo under the row and History take one back. A week or month goal has no daily goal: the button fills and the
    completion sound plays only when the period's goal is met; several a day, when today's goal is met.
  - [x] Built 7 Oct 2026 (Claude, `main` working tree, not yet committed): Today's round button draws ✓ for `countsUp`
    check habits (`TodayRows.swift`); widgets draw ✓ for a check habit's add button (`WidgetActionButton`). The sound
    already played only on the log that completes the goal (`HabitStore+Feedback.swift`); VoiceOver still says
    "Add 1 to …" (what a tap does), so no UI test labels changed. Rulebook U14 and Design Rules updated.
  - [x] On the iPhone, 7 Oct 2026: the user: "the check is working perfectly." `TodayUITests` on the iPhone: 7 of 8
    passed; `testDayWeekAndAppearance` failed only because this phone has the sound switched on (test launches share
    the person's settings on a real iPhone; not this change).
  - [ ] Tests on GitHub (T1/T7/T10): `TodayUITests`, `TodayRowLayoutUITests`, `WidgetUITests`, `RoutineCalendarUITests`.

- [ ] **65. Widgets respond very slowly; a tap sometimes opens the app; Medium rows flicker.** Added 7 October 2026, from
  the user: "majority of the widgets… when I click on the main action buttons they were not even responding… even when
  it does respond, after a very long time." Then: "all items are flickering in the medium widget… in the small widget
  the interactivity is gone, it is directly opening." Asked for Apple's guidance first, and for testing on the iPhone.
  - **Research (Apple docs):** a widget button's intent runs in the widget extension by default; `LiveActivityIntent`
    runs it in the app's process; after `perform()` returns the system reloads the timeline (not counted against the
    budget); WidgetKit budgets 40–70 reloads a day; entries at least ~5 minutes apart; ~30 MB extension memory;
    `invalidatableContent` marks views awaiting new data. Apple forum: taps can skip a widget button's intent and open
    the app (no Apple answer). `IntentExecutionTargets` (choosing the process) is iOS 27 only.
  - **Measured on the iPhone** (opt-in `-widget-timing on` log; L23): the app side was quick (cold 0.8 s, warm 0.3 s),
    but each reload drew a week of timeline entries (8–22 per widget, ~0.75 s per Medium reload, twice per tap).
    Stand-in intents (debug `-widget-probe live|extension`, no data change) ran in the right process and never opened
    the app in 12 taps each, so the intent kind isn't the cause; a tap during a long redraw is the likely one.
  - [x] Built 7 Oct 2026 (Claude, not yet committed): timelines hold the next 3 hours and the next day's start (2–4
    entries); a running timer's fill every 5 minutes; a widget tap reloads at once; `invalidatableContent` (added and
    then removed the same day: it dimmed every row on any tap) is gone. `WidgetCheck` updated for the shorter timeline.
    Rulebook S17.
  - [x] On the iPhone, 7 Oct 2026: `WidgetUITests` 6/6 passed. Same-run page flips: week-long 0.9 / 1.4 s, short
    0.7–0.8 s. Real taps: app closed → Small redrawn +0.52 s, Medium +0.76 s; app in the background +0.11 s / +0.20 s.
  - [x] The user's check on the iPhone (U9): superseded and approved through item 66 (8 Oct 2026).
  - [ ] Tests on GitHub (T1/T7/T10): `WidgetUITests`, `WidgetSystemUITests`.
  - Found, not fixed (separate task): a `-uitest` launch on a real iPhone publishes its demo habits into the widgets'
    shared file, and resets some of the person's own settings (Hide Completed, done order); D8.

- [ ] **66. Widgets: the tap shows at once; the app saves, syncs and backs up behind it; nothing is lost.** Added 7 October
  2026, from the user, after item 65's measurements (a ✓/+1 tap took 3.9–4.5 s to show on the iPhone: iOS waits ~3 s
  after an app-process intent before showing the reload; widget-process intents showed in ~0.2 s).
  - [x] **Visual first, at once:** the widget changes the moment it's tapped. Built as iOS switches (`Toggle`, which iOS
    flips before any code runs: Apple, WWDC23 "Bring widgets to life"), drawn exactly like the app's round button.
    Built 8 Oct 2026: on the iPhone the button changed 0.67–0.69 s after the test's tap began (its own tap is ~0.54 s);
    a ✓ fills with the habit's colour, a + shows the habit's light tint, or its colour when that tap meets the goal.
  - [x] **Data second, reliably, in the background:** each tap is saved by the app (it runs in the background), then
    synced and backed up, even if the app is never opened. Never "saved on the phone until the app next opens" (the
    user: "a deal-breaking thing… then it's just a showcase"). Kept: the intent runs in the app (`LiveActivityIntent`);
    the numbers follow ~4 s later (iOS's wait after an app-process intent, L24).
  - [x] **Repeated taps:** every tap counts; none is dropped (today a second tap before the widget refreshes carries the
    same ID and is discarded as a duplicate). The display may catch up later; the data may not be lost. Built: a + gets
    a new ID per tap; a ✓ flips what's saved, taps saved strictly in order (iOS resent the first tap's value on a quick
    second tap). On the iPhone: Meds ✓ twice fast → Not checked; Water + three times fast → 3 of 8 glasses.
  - [x] **Moving on:** a tap on another habit while the first is still saving is registered too (taps are queued in
    `AppModel.logFromWidget`; the phone's log showed all five of a mixed run saved in order).
  - [x] **What opens the app, straight on the right screen:** steps (checklist) → that day's Day details; timer → the
    timer; a number to type (an amount with no saved step) → the log sheet. Check habits, tasks and amounts with a saved
    step log from the widget. A timer always opens its timer now (started if it wasn't running).
  - [x] **Bug:** with a timer open in the app, tapping a checklist on the widget left the timer showing. Whatever was
    open is replaced by the screen the widget asked for (`TodayView.replacingPresented`: everything closes without
    animation, then the new screen opens). On the iPhone: timer → Skincare's Day details → Read pages' Add log → timer.
  - **The user's review, 8 Oct:** the button changed first and the card a few seconds later ("everything on the card
    should be updated immediately, like Reminders"); a second quick + or several-a-day ✓ looked like an undo; timers
    must start on the widget and the Dynamic Island, not open the app. Rebuilt the same day:
    - [x] The whole card is one switch (Small, list rows with the header's "N of M done", the weekly card, the Lock
      Screen circle); its "after" is the app's own next state. On the iPhone, 0.3 s after a tap: Meds "Checked" with its
      bar; Water 6 → 7 of 8 with its bar; a list row "Done" with the header 1 → 2 of 23.
    - [x] The tap runs in the widget's process and hands over to the app in the background (`WidgetTapIntent` →
      `WidgetSaveIntent`; waiting taps in `WidgetTaps`). Water + three quick taps: 24 → 25 → 26 → 27 on screen; the
      phone's log: widget part ~30 ms, the app's save started ~40 ms later and finished ~90 ms after; app never opened.
      A ✓ tapped twice fast: Done, then Not yet, saved as Not yet.
    - [x] Timers: ▶ becomes ⏸ at once and the timer runs (Live Activity) without opening the app; ⏸ stops it.
  - **More of the user's checks, 8 Oct:** Call family's week-goal row didn't fill (now fills toward the week, as Today;
    the earlier "no fill" rule was a misreading, corrected everywhere); a number to type showed ↗ (now a plain +); an
    older widget's log sheet came back after a newer screen closed (`replacingPresented` now clears it); logging in the
    app then going straight home left the widget stale (publish 0.5 s after a change, and at once on leaving). All fixed
    and checked on the Home Screen.
  - [x] The user's check on the iPhone (U9), 8 Oct 2026: "everything is perfect … lock it down." Locked in
    [Widgets — Taps and Updates (Locked)](<../Widgets — Taps and Updates (Locked).md>) (Rulebook U28), with README,
    Design Rules and `LOCKED` comments in the code.
  - [ ] Tests on GitHub (T1/T7/T10): `WidgetUITests`, `WidgetSystemUITests`, `TodayUITests`, `TimerUITests`; the in-app
    widget checks. Expect label changes for T3: a card is one button named for its action, with the state as its value.
    **Found 8 Oct by item 67's runs:** `WidgetSystemUITests.testHomeScreenInstallTapAndColdPersistence` fails on `main`
    (run 37746030895): "The widget didn't show the committed log. Widget: . App: … intent not dispatched". The test
    still reads the older `WidgetLogIntent` diagnostics and the shown labels came back empty; `WidgetUITests` (6/6)
    and the other widget tests passed.
    **Fixed 8 Oct (cloud session, test only; no widget behaviour changed):** it tapped the row's middle, which opens Day
    details (locked W2), now the +1 by position; its fixture could be left without its "sample set added" mark, so the
    cold save added the Debug samples; a gallery swipe the hosted simulator didn't take is made again once confirmed
    not taken; a first touch the simulator didn't deliver is tapped once more (exactly one log is still required).
    `WidgetSystemUITests` and `WidgetUITests` passed in run 37784250768 (`27ce48c`); `TodayUITests` wasn't in that run.
  - Research for the user's question "do people expect widgets to respond instantly?": our widget study (7,818 coded
    reviews) has ticking from the widget among the most valued themes (695 reviews, 97 apps in the 30 Sep scan) and
    broken or not-updating widgets at 15.7% of widget reviews (3.27★). Speed scan (8 Oct): 431 keyword candidates
    (widget + a speed word), 343 with the words close together, all 343 read by hand: 19 complain of the delay between
    tapping a widget and seeing it change, 18 more call widgets slow or delayed, 42 say taps stopped responding, 6 that a
    tap opened the app instead; 8 praise instant ticking (`Research/Temp/widget-speed/classification.py`).

- **Hand-over, 8 Oct 2026 evening (the user: "create a new branch and push everything … we will run it in the
  cloud"):** items 67–72 are on branch `sync-reliability-cloud` (same commits as `sync-outside-app`). Still to do,
  from the cloud: (1) the final `[ios-ci] [ios-sync]` run on this branch (the evening runs were cancelled by the user);
  (2) `TimerUITests.testScreenCanBeTurnedOff` failed once in run 37763470033 ("Stop Read timer" didn't appear within
  3 s) after passing twice: rerun once (T2), and if it fails again find the cause; (3)
  `WidgetSystemUITests.testHomeScreenInstallTapAndColdPersistence` fails on `main` too (item 66); (4) the user's first
  nightly server snapshot, due 9 Oct 02:00 UTC in R2 `often-enough-backups-dev` under `snapshots/<account>/` (needs
  Cloudflare access); (5) merge into `main` only after the tests pass and the user says so (W3). iPhone checks can't
  run in the cloud.
  - **Cloud session, 8 Oct 2026 (Claude):** (2) is a real race, not a flake (T2). The failing build (`3e7f758`) had no
    Keychain read at launch (that came in `1575150`), so that suspect is cleared. The failure screenshot shows Read
    still on ▶ after the tap: `seedDemo` showed the demo rows before saving them, then reloaded; a ▶ in that window
    started the timer on screen and the reload took it away before its own save. Fixed (`3c24675`): nothing shows until
    it's saved. The same gap in the app proper, fixed too: a tap made while a sync reload runs is reloaded again after
    its own write (`reloadAfterSync`, Rulebook S7). (3) was the test: the card's switch covers the row but only the
    round button takes the touch (locked W2), and `tap()` hit the row's middle, which opened Day details (the failure
    screenshot: the app on "Widget cut down", 0 cups). The test now taps the +1 by position (locked doc §6); no widget
    behaviour changed. `-widget-system-verify` now says how many taps wait in the shared file instead of the retired
    `WidgetLogIntent` diagnostic. CI: run 37767538992 died before any test in "Pick a simulator" (Apple's first-boot
    data migration, 8.2 min against the step's 8; it took 2–5 min on 7 Oct and up to 7.8 this morning); the step now
    has 15. (4) This session can read R2 (`often-enough-backups-dev`: the 7 Oct snapshot of another account is there);
    a check is set for 9 Oct 02:20 UTC. Test run: 37769869356 (`8ea0d9d`).

- [x] **67. A change made outside the app reaches the server as soon as possible, without opening the app.** Added 8
  October 2026, from the user: "once someone completes a widget, it should store that data on this device, and later
  sync it to the server … as soon as possible." The user approved changing the widgets' sync timing (U28).
  - **Found (Claude, 8 Oct, from the code):** a widget tap is saved on the phone reliably (`WidgetTapIntent` →
    `widget-taps.json` → `WidgetSaveIntent` → `AppModel.saveWidgetTaps` → database). Sync is only *scheduled*:
    `SyncService.scheduleSoon()` waits 3 s, and nothing asks iOS for background time, so iOS can suspend the app
    before it sends; the change then waits in the outbox until the app is next opened. The same gap: a notification's
    Done/+1, the Live Activity's Pause, the widget timer, and an in-app log made just before leaving the app. The
    12-hourly background refresh doesn't sync. Only Plus syncs.
  - **Agreed approach:** in `SyncService`, send at once when the app isn't in front (3 s quiet only while it is), and
    hold a `beginBackgroundTask` from scheduling until the sync finishes (or fails; the outbox keeps it). No intent
    waits for the network; the widget stays exactly as fast (W1–W17 unchanged). Locked doc gets a W18.
  - **The user's points, 8 Oct (branch `sync-outside-app`; "test it thoroughly, for a production system"):**
    - [x] In the app: a tick reaches the server's database.
    - [x] Widgets, the most important: a tick on a Home Screen or Lock Screen widget reaches the app and then the
      server, without the app being opened.
    - [x] Nothing is ever lost for a Plus user: every change reaches the server.
    - [x] Not a request per tap: a run of taps is sent together, production-style, so nobody can run into (or abuse)
      the server's limits (`SYNC_LIMIT`, 60 a minute per account).
    - [x] Nightly backups work (Plus: the server's 02:00 UTC snapshot of a changed account; Architecture 06 §9): see the
      nightly backup point below (9 Oct).
    - [x] The widgets look and respond exactly as before: their visual feedback (the switches) isn't changed or
      slowed ("people don't care how it works in the background, but it should be reliable").
  - [x] Built 8 Oct 2026 (Claude, branch `sync-outside-app`): `SyncService` holds `beginBackgroundTask` until the
    server has a change; 2 s of quiet in the background, 3 s in front, at most 10 s; no empty requests; one sync at a
    time; no launch pull for a background launch; a failed sync asks for a background refresh (~15 min), which syncs.
    Debug: sync marks in the timing log, `-sync-verify`, `-sync-old-timing`, `-sync-fail`, `SyncDeviceTests`.
  - [x] On the iPhone, 8 Oct (dev server logs + the phone's log; PERFORMANCE-LESSONS L25). Old timing: five widget
    taps saved, never sent. New: a widget tap → one request ~3 s later; five quick taps → one request with 5; ten quick
    in-app taps → one with 10; tap then Home → sent within ~1 s; widget timer ▶/⏸ → sent ~2 s later; Lock Screen widget
    taps (phone locked) → one request with both, 3 s later; with sync failing, six taps waited and all went once it
    worked; `-sync-verify` MATCH every time (final: 711/711 logs, 30/30 habits, 0 waiting, 0 kept aside).
  - [x] Widget visuals unchanged: `testQuickPlusAndTimer` Water 58 → 59 → 60 → 61 at 0.3 s, ▶ → ⏸ at 0.3 s.
    (`testWholeCardChangesAtOnce` couldn't start: Meds was already ticked today.)
  - [x] **Bug found and fixed: the Live Activity's Pause didn't work on the Lock Screen.** `StopTimerIntent` had no
    `authenticationPolicy`, so iOS asked for Face ID and then opened the app on the timer instead of pausing. Now
    `.alwaysAllowed`, like every widget button. The user's check, 8 Oct 13:01: Pause stopped the timer without
    unlocking, and the session reached the server 2 s later.
  - **Found, not changed (locked, W7):** on the Lock Screen *widget*, ⏸ asks for Face ID before pausing (then pauses
    and syncs). Ticking on the Lock Screen widget needs no unlock (it runs in the widget's process); timer intents run
    in the app's process. Ask the user before touching it.
  - [x] A notification's Done/+1 on the iPhone: same path (`logFromReminder` → store change → `scheduleSoon`). Seen
    with item 70: each tap reached the server ~2.5 s later once the crash was fixed; the user's locked-phone check
    (15:32–15:35) synced 2 s later.
  - [x] Nightly backup: the user's account changed today, so its first snapshot is due 9 Oct 02:00 UTC (07:30 IST) in
    `often-enough-backups-dev` under `snapshots/<account>/`. The mechanism wrote one on 7 Oct 02:00 UTC. The cloud
    session can read the bucket (8 Oct) and checks it at 9 Oct 02:20 UTC; recorded under item 71. **9 Oct:** the first nightly snapshot of the user's account is in R2: `snapshots/72f6ea46-…/2026-10-09.json.gz`, 128,747 bytes, written 9 Oct 02:00:04 UTC. Read back by the cloud session (D4): it opens (format 1, taken 02:00:03 UTC, cursor 2145) and holds 1,451 records (1,339 log rows, 66 habit rows, 20 settings, 14 steps, 12 reminder times). The server keeps every row the account ever had, so these are more than the phone's 31 habits and 720 logs (the 28 demo habits removed on 8 Oct, item 72, among them); not compared row by row.
  - [x] Tests on GitHub (T7/T10), `[ios-ci] [ios-sync]` (SyncUITests, BackupUITests, WidgetUITests,
    WidgetSystemUITests, TimerUITests). Run 37742196989 (`4b98582`): 39 passed, 3 failed; one was ours
    (`BackupUITests.testAFreeAccountBacksUpToTheServer`: dev's every-account-Plus switch made the test's free account
    Plus; narrowed to Apple/Google sign-ins, item 68). Final run 37746011302 (`893c622`): 20 passed, 1 skipped, 1 failed:
    `WidgetSystemUITests.testHomeScreenInstallTapAndColdPersistence` ("intent not dispatched"), which **fails the same
    way on `main`** (run 37746030895 on `98fa746` = `main` + an empty commit; T2). Not from this item: it belongs to
    item 66's GitHub tests.
  - [x] **Final, from the cloud (8 Oct):** run 37784250768 (`27ce48c`): Core storage and migrations, build, and every UI test
    passed (26 passed, 0 failed, 1 skipped: `testLockScreenWidgetPickerAvailability`, the hosted simulator's Lock
    Screen gallery, skipped in every run): SyncUITests, BackupUITests (8), WidgetUITests (6), WidgetSystemUITests,
    TimerUITests (5, `testScreenCanBeTurnedOff` included), RemindersUITests (4), PlacementUITests. Server: `npm test`
    139/139, typecheck clean. Speed run for the `HabitStore` change (S2): run 37788586127 (`91a6260`) passed; no change from this branch: a signed-out tap does the same work as on `main` (`scheduleSoon` returns when not Plus), and its numbers sit inside `main`'s own spread measured the same day (+1 alone 18.1 ms/s here, 5.8 and 25.2 on `main` in run 37774018835; day ‹ › 128 here, 68–79 there; +1 and day ‹ › 72 here, 124 there). The slower +1 since 4 Oct is `main`'s, under item 49's bisect.

- [ ] **68. REVERT LATER: every account on the dev server is Plus.** Added 8 October 2026, from the user: "make every
  account Plus, as of now … note it down somewhere safe that we need to revert it back later … first, syncing is
  important." Done by Claude the same day and deployed to dev (version `49c6052a`).
  - **What:** `EVERYONE_PLUS: "true"` in `server/wrangler.jsonc` (dev vars only); `everyonePlus` in `server/src/account.ts`
    makes every account with an Apple or Google sign-in Plus on dev (test and CI sign-ins keep the Plus they ask for, so free-account tests stay free: `BackupUITests.testAFreeAccountBacksUpToTheServer` failed in run 37742196989 until this was narrowed, 8 Oct). Production has `"false"` and the code
    ignores it there anyway. No purchase is written into any account, so nothing has to be cleaned up.
  - **Why:** buying Plus isn't built yet (Product Roadmap 64), and sync must be tested end to end now (item 67).
  - **To revert:** set `EVERYONE_PLUS` to `"false"` in `server/wrangler.jsonc`, `npm run deploy:dev`; accounts go
    back to their real purchases at their next sign-in or token refresh (access tokens last minutes). Then remove
    `everyonePlus` and its test once buying Plus works. **Revert before buying Plus (Roadmap 64) is tested**, or
    a broken purchase would look like it works.

- [x] **69. Lock Screen timers: pause without unlocking.** Added 8 October 2026, from the user's Lock Screen checks for
  item 67 ("if users expect it to work, then it should be that way").
  - Users show they want to pause a timer from the Lock Screen and the Dynamic Island (5 reviews; ≈41 want the timer
    there; report "Timers — What People Expect When They Tap ▶"); the iPhone's Clock timer pauses there without
    unlocking.
  - [x] **The Live Activity's Pause didn't work locked:** `StopTimerIntent` had no `authenticationPolicy`, so iOS asked
    for Face ID, then opened the app on the timer. Now `.alwaysAllowed`. The user, 8 Oct 13:01: Pause stopped the timer
    without unlocking; the session reached the server 2 s later.
  - [x] **The Lock Screen widget's ▶/⏸ asks for Face ID** (then works and syncs). Tried 8 Oct: running the tap in the
    widget's process and handing over (as ✓ does) made iOS refuse to start the Live Activity ("couldn't start
    (visibility)": only an intent run directly in the app may start one) and the button flicked back to ▶ at 0.3 s.
    Reverted the same day; the widget timer is exactly as approved (W7; checked: ⏸ at 0.3 s, Live Activity started).
    The no-unlock way to pause on the Lock Screen is the Live Activity's Pause. Leave the widget as it is unless iOS
    changes.
  - [x] Tests on GitHub (with item 70's run): TimerUITests 5/5 in run 37784250768 (`27ce48c`).

- [x] **70. Reminders, alarms and "Remind again" work reliably, on the iPhone.** Added 8 October 2026, from the user:
  "reminders are also important … alarms … for reliability, alarms should be full screen … if not done, remind me
  again … they all should work reliably. Test it thoroughly on the iPhone." Also: is logging from a long-press on the
  notification what people expect? Yes: users want to complete from the notification without opening the app (Feature
  Ledger C252, Strong, 7 apps); iOS shows a notification's buttons only on a long-press (or swipe → View).
  - Debug kit: `-reminder-live <name> <check|amount> <notification|alarm> <minutes ahead> <remind-again min>`,
    `-reminder-live-status`, `-reminder-live-cleanup` (`ReminderLiveTest`); `ReminderDeviceTests` waits on the Home
    Screen for the real banners and alarms and taps their buttons (`REMINDER_PLAN`).
  - [x] **Bug found and fixed: every reminder Done/+1 crashed the app** a moment after saving (since 28 Sep):
    `NotificationHandler`'s `nonisolated` async methods told iOS "finished" from a background thread and UIKit stopped
    the app (crash reports 14:54, 14:58, 14:59, 15:06; `NSInternalInconsistencyException` in
    `_performBlockAfterCATransactionCommitSynchronizes`). The log was saved but the sync was cut off, so the change
    waited until the app was opened. Now on the main actor; no crash since, and each tap reached the server ~2.5 s later.
  - [x] **Alarm Done on a locked phone:** `MarkHabitDoneIntent` had no `authenticationPolicy` (the same gap as the
    Live Activity's Pause); now `.alwaysAllowed`.
  - [x] On the iPhone, 8 Oct (Claude's tests, unlocked): reminders arrive on the minute (14:57:00, 14:58:00…); "Not done
    yet" repeats every interval while not done (an amount at 1 of 3 kept repeating); Done on a repeat stops the rest;
    +1 glass adds one; done habits' notifications are cleared from Notification Center. Alarm (unlocked): rang at
    15:13:00 in the Dynamic Island with ✓ and ✕; ✓ logged and synced 2 s later; the 15:15 repeat didn't ring.
  - [x] The user, phone locked, 8 Oct 15:32–15:35: the alarm rang full screen; Done logged without Face ID and synced;
    the notification's Done logged and synced 2 s later; the user's own task alarm Done synced too.
  - **Full screen:** iOS shows an alarm full screen on a locked phone and in the Dynamic Island while the phone is in use,
    as the Clock app's alarms do; apps can't change it.
  - [x] Tests on GitHub: `[ios-ci] [ios-sync]` now adds RemindersUITests and PlacementUITests (which runs the
    reminder planning checks): 4/4 and 1/1 in run 37784250768 (`27ce48c`).

- [ ] **71. VERY IMPORTANT, PENDING: test sync end to end on a second real device.** Added 8 October 2026, from the user:
  "in the main, as in very important thing, syncing … on one iPhone, you have tested it. In the other iPhone, like in
  other devices, we have to test it. So it is pending." Waiting for a second device (none available on 8 Oct).
  - GitHub (8 Oct): SyncUITests (two simulated phones, the real dev server) passed in run 37784250768 (`27ce48c`). Still open:
    the second real device below.
  - **Proven so far (8 Oct, items 67–70):** on the user's iPhone 16, every way of logging (app, Home Screen and Lock
    Screen widgets, timers, the Live Activity's Pause, reminder and alarm buttons) reaches the dev server within seconds
    without opening the app; failed syncs wait and go later; the account's export matched the phone exactly (720/720
    logs, 31/31 habits). Server → another device is proven only on GitHub's simulators (`SyncUITests.
    testChangesTravelBetweenThisPhoneAndAnotherDevice`, two simulated phones, one test account, the real dev server).
  - **To do on a second iPhone or iPad** (Debug build, the same Apple ID, Plus on dev, item 68):
    - [ ] Sign in on the second device: everything from the first appears (habits, logs, notes, order, settings).
    - [ ] Log on the first (app, widget, reminder) → it appears on the second, with the app open and from closed.
    - [ ] Log on the second → it appears on the first, and the first's widgets update.
    - [ ] The same habit changed on both while one is offline → both end the same, nothing lost (merge rules, D3).
    - [ ] Done on one device clears that habit's reminders and alarms on the other ("done means gone everywhere").
    - [ ] Delete and archive on one → the same on the other; undo works.
    - [ ] `-sync-verify` on both devices: each matches the server.
  - [x] **One device: the nightly server snapshot** (9 Oct 2026, checked 02:20 UTC): the first nightly snapshot of the user's account is in R2: `snapshots/72f6ea46-…/2026-10-09.json.gz`, 128,747 bytes, written 9 Oct 02:00:04 UTC. Read back by the cloud session (D4): it opens (format 1, taken 02:00:03 UTC, cursor 2145) and holds 1,451 records (1,339 log rows, 66 habit rows, 20 settings, 14 steps, 12 reminder times). The server keeps every row the account ever had, so these are more than the phone's 31 habits and 720 logs (the 28 demo habits removed on 8 Oct, item 72, among them); not compared row by row. Reinstall-and-restore:
    done, item 72.
  - **Later (the user, 8 Oct):** the app is iPhone-only for now; Android, Mac and desktop come after the iPhone app is
    complete, and sync is tested across all of them then.

- [x] **72. A reinstalled iPhone got none of its data back from the account. Fixed.** Added 8 October 2026, from the
  user's test: "let's uninstall the app … on a fresh install, does the data survive?" … "I used Apple sign in itself,
  but I didn't get any of the habits back. So I think that is a bug."
  - **Cause:** the device ID lives in the Keychain, which survives deleting the app, so the reinstalled phone was "the
    same device"; the server never sends a device its own changes, and every change in the account had been made on
    this phone. The sync said OK and brought nothing.
  - [x] **Fix (8 Oct, Claude):** signing in to an account on a database marks a **full download** (`sync.fullPull`,
    set in `SyncWriter.bind`); `syncRequest` sends `"full": true` until the last page has arrived; the server then
    sends the device's own ops too (`SyncRequest.full`). Tests: Core `SyncTest.theSamePhoneReinstalledGetsEverythingBack`
    (1,500 logs over two pages, then own ops skipped again); server `a reinstalled phone … gets its own ops back on a
    full download, over every page`. Server deployed to dev (version `5a3066a4`).
  - [x] **On the iPhone, 8 Oct:** a safety copy of the app's data was taken first (`Research/Temp/pre-uninstall-backup`,
    with a row-by-row dump); uninstall → install → sign out and sign in with Apple → "they did come back" (the user).
    Every row compared: habits 38/38, logs 929/929, steps 7/7, reminder times 12/12, settings 13/13; **0 missing, 0
    changed**. `-sync-verify`: 720/720 logs, 31/31 habits, 0 waiting.
  - **A slip during the test (Claude):** a debug launch without `-empty` on the still-empty reinstalled app let the Debug
    build's demo data (`seedDemo`, `addEveryTypeToAnytime`) in, and 28 demo habits and 405 logs synced into the account.
    The user's own data was checked untouched (every habit, log and setting), and the demo items were removed by ID
    (`-delete-listed-habits`). Now the Debug build never adds demo data while signed in. The App Store build never adds it.
  - [x] Tests on GitHub: the core and server tests run with `[ios-ci] [ios-sync]` (Core storage and migrations,
    SyncUITests): both passed in run 37784250768 (`27ce48c`); server tests 139/139 locally.

## Planned improvements — build later


- [ ] **73. Onboarding, and getting everything back for someone returning (build later).** Added 8 October 2026, from
  the user: "we need to improve the onboarding experience. As well as in the onboarding, who has already the account,
  … once you log in, everything should get back again. You don't have to … go to backup and sign out and sign in …
  Even if they are using just iCloud … we will work on it later." Found during item 72's reinstall test.
  - **The onboarding experience overall** needs improving (separate from the restore flow below; see
    [Onboarding and Help](<Onboarding and Help.md>)).
  - **Someone who already has an account:** the welcome screen offers only "Restore from a Backup File". Add a clear
    way to sign in there; once signed in, everything comes back by itself (the full download from item 72), with no
    trip to ≡ → Backup & Sync → Account.
  - **A reinstalled app that still looks signed in** (the Keychain keeps the session) must not need Sign Out and Sign In
    to restore: either restore automatically on launch or ask once, clearly. Today it stays empty until the person
    signs out and back in.
  - **Someone using only iCloud (no account):** on a new install, offer to bring back their habits from the iCloud
    backup just as simply (iCloud backup is waiting for the Apple Developer account, `BackupFeatures.iCloudBackup`).
  - Research what people expect before building (W2); relates to item 3 (account up front) and Rulebook D4/D5/D14.
  - **Started 9 October 2026, together with item 3** (the user: "The next thing we need to work on is onboarding, which
    is 73 + 3: onboarding returning users and moving the account out of the backup and export. This includes a sign-in
    on the welcome screen and a reinstall that restores by itself. Obviously, we have to do the research first.").
    Branch `app-lock-privacy-security` (the user, 9 Oct 2026: one branch, not a separate one). Designs go on the Figma page
    [onboarding](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=767-9100) (empty on 9 Oct).
    - [x] **Today's screens in Figma** (the user, 9 Oct: "take the current screenshots and paste them into Figma …
      properly arranged"): 28 screenshots from the iPhone 16 on the onboarding page, frame "Current screens — 9 Oct
      2026": the welcome, where it ends, Show the Welcome Again, ≡ → Backup & Export (signed out) and its sheets, Plus,
      Privacy. Taken by `OnboardingBackupScreenshotUITests` (a test launch, D8); files in
      `Research/Temp/ios-shots/onboarding-backup-current/`. Not yet captured: the signed-in screens (Your Account,
      Delete Account, Backup & Export with an account), which need a real account. Share sheets left out (they show
      the person's contacts).
    - **The user, 9 Oct 2026, on the screenshots** ([A01, the welcome's first page](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=770-15)):
      "we need improve the overall experience and onboarding so the flow should be in such a way that every type of
      user should feel seamless". Points, each to be answered by the research:
      - [x] There are different people: **new** users, and **returning / existing** users (an account backup, a
        backup file); think about the flow for each, and each must feel seamless. (Report §5: a path for each;
        Figma rows 1–3.)
      - [x] Today's first screen is for first-time users and doesn't make sense for existing users, yet it still shows
        an existing user's option ("Restore from a Backup File") to a first-timer. (Proposed: N1 replaces it with
        "I've used Often Enough before".)
      - [x] Getting back in must be easy for existing users: from the account or from a backup file. (R1–R7.)
      - [x] **The user's assumption, to test:** the first screen splits people into new and returning. **Holds**, with
        a refinement: recognise returning people automatically first (reinstall, new iPhone, iCloud marker), and
        split on the first screen only when nothing is known, with the new path as the main button. Decision 1.
      - [x] Research top-notch UX and flow for first-time and returning users; every screen clean and minimal; the
        main thing: it must never confuse anyone. (9 Oct 2026, Claude: [Onboarding for New and Returning People — Research and Proposed Flow](<../../../Research/Research Reports/Habit Creation/Onboarding for New and Returning People — Research and Proposed Flow.md>). 1,613 reviews read, 1,078
        on topic, 34 quotes verified; Apple's HIG and AuthenticationServices docs.)
      - [x] Propose a new flow from the research, and draw that flow in Figma (onboarding page): frame **"Proposed
        flow — 9 Oct 2026"** beside today's screens: the launch checks (A–D), new person (N1–N4), coming back
        (R1–R7), recognised by the app (B1, B2, C1, A1), the account in ≡ (S1–S5), and the six decisions.
      - [x] **The user, 9 Oct 2026, on the proposed flow** (N1 Welcome, R1 Get your habits back, 0 · the launch
        checks): "before these screens … instead of doing all these we should have one which asks only one thing
        which is are you existing user or new user, that screen should look good and very intuitive … it shouldn't
        feel weird for first time users and for existing users it shouldn't feel like friction or unneccessary so
        yeah do research and create wireframe screen". Done 9 Oct 2026: report §6a (796 returning reviews: people
        say "new phone", "reinstall", "log in", almost never "existing user"); Figma frame "First screen — new or
        coming back (9 Oct 2026)", F1 on iPhone 16 and SE: "I'm new here" / "I've used it before", one tap each.
      - [ ] **The user's decisions** (report §6): 1 the first screen; 2 a reinstall with the session (automatic or
        ask); 3 day and week start in onboarding or not; 4 three or four new-person pages; 5 the iCloud marker;
        6 the account at the top or bottom of ≡.
    - [x] Research: what people coming back expect at the welcome, after a reinstall, on a new phone, with only
      iCloud; where they look for their account (with item 3). Done 9 Oct 2026 (the report above).
    - [x] The user's decisions, then a design on the Figma page. **Settled by the user's own wireframes, 9 Oct 2026**:
      [Onboarding — Current wireframes](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=835-503)
      (35 screens, one row per path). They answer decisions 1 (one question first: "I'm new here" / "I've used it
      before"), 3 (day and week start stay, as their own page) and 4 (new people: What's included, three pages on
      what the app does, days and weeks, a first habit).
    - [ ] **73.1 Build the onboarding from the wireframes** (the user, 9 Oct 2026; committed on
      `app-lock-privacy-security`, at the user's request). **The mockups set the screens, the order and the copy; every control is
      the app's own** ("these are just mockups … you should sync everything with our app, like how we have it in our
      app"). The user's points:
      - [x] Before anything: bring the local repository up to date with `app-lock-privacy-security` and install that
        branch's latest build on the connected iPhone. Done 9 Oct 2026: this branch fast-forwarded to 773156b5, and
        that build installed on the iPhone 16 (`devicectl device install app`).
      - [x] **01 Welcome** (row 1): the first screen for anyone who has just installed. The app icon's place is a grey
        square for now (no icon yet). **The copy is final**: Often Enough · "Habits grow through repetition. You choose
        how often is enough." · "Have you used Often Enough before?" · I'm new here / I've used it before.
      - [x] **I'm new here** (row 2), in order: **02 What's included** in the free plan (up to 5 habits, unlimited
        tasks, widgets included, no account needed, iCloud backup); **Skip setup** on any of these pages goes straight
        to Today; **03** you can build habits, with the kinds of habit; **04** you can quit or cut down, with the kinds;
        **05** tasks, unlimited even on the free plan; **06** your days and weeks (day start, week start), with the
        small line "You can change this later in settings" put right grammatically; **07** your first habit. Built: the
        line reads "You can change these later in ≡ › Day and Week." (the app's place for them; it has no Settings page).
      - [x] **07 → a habit idea opens the form directly, filled in** (rows 3–4, e.g. Drink water → 08A): no "What do you
        want to do?" or "How do you want to track it?" first, as the idea already says how it's tracked.
      - [x] **07 → "Create on my own"** follows exactly the same flow as + in the app (What do you want to do? → Build or
        maintain / Quit or cut down / Add a task → the form). Full screen or a sheet: whichever is better. Built full
        screen: the same `NewItemChoices` pushed as the welcome's next page (a sheet over the full-screen welcome would
        be a second layer with its own Cancel; one stack keeps one Back).
      - [x] **Better words for "Create on my own"** (what does "my own" mean?), e.g. "Create my own habit". Built:
        **Create my own habit**.
      - [x] **I've used it before → R01 Welcome back**: Sign in to your account · Restore a backup · Move from another
        device · Start without restoring. **R01B**, the same screen when the app finds data already on this device:
        "We found data on this device. Continue with this data?" with Continue, then the other ways under it. Built:
        found = habits or tasks already on the iPhone ("17 habits. Continue with this data?"); also an account still
        signed in after a reinstall ("You're still signed in."), whose Continue brings the account's data back.
      - [x] **Sign in → R02 Sign back in** (Continue with Apple / Google; Restore a backup instead), then the loading
        screen while the account's data comes back (R03).
      - [x] **Restore a backup → R04** (iCloud, Google Drive, a backup file); **R05/R06** when a backup is already found
        in iCloud (or Google Drive): that backup first, the others under "Other backups". Built for iCloud and a backup
        file, then a review page ("Your backup.": what's in it, made on, when; Restore, or Replace/Merge when the iPhone
        has data). **Google Drive is left out on purpose:** nothing backs up to Google Drive yet, so there is nothing to
        find; it needs Google Drive backup first (and the Drive API turned on in the Google Cloud project).
      - [x] **Move from another device → R07 Enter transfer code**, like WhatsApp's chat transfer: the old phone
        prepares everything and shows a code; on the new phone you type the code and the data comes over from that
        phone. **Start without restoring** goes straight to Today. Built: the old iPhone's ≡ › Backup & Export › Move to
        a New iPhone › **Show a Transfer Code**; the new iPhone types it; the file comes over the local network (or
        peer-to-peer), encrypted with a key made from the code, nothing through the server, no account. **Checked
        between two simulators, 9 Oct:** the right code brought all 17 demo habits and their history onto an empty
        phone (sender: "Sent"); a wrong code said "That code doesn't match" within seconds and the old phone kept
        waiting; the right code then still worked. Not yet tried between two real iPhones (only one is here).
      - [x] **One loading screen, its words fitted to what's happening** (R08, R09): signing in with Apple or Google →
        "Getting your data" (from the account); from another device → "Getting your data" / from your other device;
        iCloud or Google Drive → e.g. "Restoring your backup"; a backup file → "Processing your data" / from your backup
        file; **the data already on this device → not "getting" (it's already here): "Setting up" or the like.** Short
        words, chosen for each case. Built: Getting your data (from your account / from your other device),
        Processing your data (from your backup file), Restoring your backup / your data, Setting things up (with the
        data already on this iPhone).
      - [ ] Implement everything thoroughly, then cross-check everything thoroughly. **Don't start the tests**: the user
        says what comes next. Built 9 Oct 2026; the app and UI tests compile, `check_rules.sh` passes, every page was
        looked at in the simulator (light, dark, the largest text). UI tests rewritten for the new flow
        (`OnboardingUITests`, `BackupUITests` Move, the screenshot test) and a speed scenario added (`onboarding`, T4),
        **none run yet**, as asked. Still to do: GitHub tests and a speed run when the user says, then the iPhone (U9):
        sign-in with a real account (Plus and free), an iCloud backup found, a backup file, a transfer between two
        iPhones, a real reinstall, and the iPhone SE layout (T15).
    - [ ] Build, test on GitHub, check on the iPhone (U9), including a real reinstall.

- [ ] **75. Free plan: iCloud on iPhone and iPad, and how fresh a free account's backup is (research first).** Added
  9 October 2026, from the user (research only; nothing is built until the user decides):
  - [x] Read the reports and explain how it works today: it's confusing. (Report §1: one table.)
  - [x] **iPhone and iPad without an account:** both back up to the same iCloud. Can the two copies collide or
    duplicate? On the free plan the two devices must **not** sync. Answered (§2): no collision (one file per device
    ID), no sync; but **a reinstall overwrites the iCloud copy with an empty one at first launch** (found in the code,
    matching the server's shrink-guard record of 8 Oct), no history in iCloud, and copies aren't named by device.
  - [x] **A free account backs up nightly, once a day.** Someone who made an account believes they're backed up, loses
    the phone, signs in on a new one and is missing the last day's progress. Is that fine? If not, how to solve it.
    Answered (§3): not fine; really "since the first open today", and the newest day carries the streak.
  - [x] **Should a free account back up everything as it happens** (server "sync" for that one device, using Workers),
    while devices still never sync with each other on the free plan (on purpose)? Free users have few habits and
    usually one device, so the requests are small. Answered (§4): yes, as you go, but as per-device copies, not
    through the sync engine (it would merge a free iPhone and iPad).
  - [x] **What we give and what we get:** a little profit given away, against goodwill and good reviews (data loss gets
    terrible reviews). The goal is as many conversions as possible: does this help or not? Will it cost extra? Being
    generous may be an edge, not only saving everywhere.
  - [x] **Use Cloudflare's own numbers:** how average users will use it and what it costs; the best possible result.
  - [x] If backing up everything isn't the answer, research and find the best solution instead.
  - [x] One report with the recommendation (W2). Done 9 Oct 2026: [Free Plan Backups — iPhone and iPad, and a
    Backup That's Never a Day Behind](<../../../Research/Research Reports/Data, Sync and Accounts/Free Plan Backups — iPhone and iPad, and a Backup That's Never a Day Behind.md>).
  - [x] **The user's decision** on the recommendation (§7): **decided 10 Oct 2026, option B, "backed up as you go"**
    for every free user, with or without an account (after asking whether it costs too much: about $0.45 a month per
    1,000 free accounts against $0.17 today; no-account copies cost nothing). As §7 says: an upload on leaving the app
    when something changed, at least 10 minutes after the last; after a widget, notification or Live Activity log; and
    at least once a day. Still one copy per device, the 7 weekday copies overwritten in place, never syncing (sync stays
    Plus). Make the backup file smaller first (§7 step 2), so it costs about 11 MB of mobile data a month, not 47.
  - [ ] Build, in §7's order: (1) **the iCloud reinstall overwrite**, a data-loss bug whatever else happens: never back
    up an empty database over a copy with habits; no backup before the welcome is finished; 7 weekday files and a
    before-shrink copy in iCloud; copies named by device; check with a real reinstall on the iPhone. (2) A smaller
    backup file, measured on the iPhone, still importable (D5). (3) Backed up as you go (`scheduleSoon`-style background
    time, D12), the server's per-copy limit raised to about 12 an hour. (4) After launch, check the real uploads a month
    against the model's 80.
  - [ ] **A fresh install finds its iCloud backup** (10 Oct 2026, from the user's question "will the data survive
    deleting the app, losing the phone, or on an iPad with the same iCloud?"). The copies live in the person's iCloud
    (the app's own iCloud Drive folder, not the iPhone's device backup), so they survive all three; but a reinstall,
    a new iPhone or an iPad starts with an empty folder that iCloud fills in, and the code took "nothing here yet" for
    "no backup", and could have written a new index over one still in iCloud (hiding the other six days). Built:
    files not brought down yet count as coming (`BackupFolder.place`), never written over (`.notReady`); Restore asks
    iCloud's own list (`ICloudLookup`, `NSMetadataQuery`) and keeps looking 20 s while nothing is found; the first
    backup of an install waits for that list; a copy its index doesn't name is still listed; the iCloud container is
    set up at launch. Logic checks in `BackupCheck`. Still to do: on the iPhone, delete the app
    and reinstall, and open it on a second device with the same Apple Account (U9). BackupUITests passed on GitHub
    (run 38026303087, 10 Oct 2026). Not covered by any code: a phone
    lost before iCloud finished uploading its newest copy (the user, 10 Oct: nothing to do there).

- [ ] **76. Sidebar, Account and Backup & Export: redesign** (added 10 October 2026, from the user, with five
  screenshots). The account must be easy to find in the sidebar without pushing anyone to make one; say clearly what an
  account gives (free: backed up as you go to the account, one device, no sync between devices; Plus: sync); without
  an account an iPhone backs up to iCloud by default, and people can choose Google Drive; improve Create Account and
  the signed-in Account page; Backup & Export shows export, moving to another device (phone or tablet) by transfer code
  or backup file, and restoring, matching onboarding. Use the research reports; a new Figma section.
  - [x] Designed 10 Oct 2026 (Figma 950:309, iPhone SE): [Account and Backup Redesign](<../Specs/Account and Backup Redesign/README.md>).
  - [ ] The user's review, and the points to confirm (spec §6: as-you-go backup for free, Google Drive on iOS, the
    transfer service, choosing one of 7 daily copies).
  - [x] 11 Oct 2026: free accounts now **sync, one device** (item 78), not "backed up as you go"; Backup & Export's
    list is the same in every state (iCloud · Google Drive · Your Account, the tick shows where).
  - [x] Decided with the user, 10 Oct 2026: **one backup place at a time** (iCloud or Google Drive without an account;
    the account when signed in; the free account's iCloud copy beside the account stops), and **Move to Another Device
    opens the transfer code directly** (no options screen). On creating an account or signing in, back up to the
    account at once and stop iCloud / Google Drive only after that copy is checked; Restore when signed in lists Your
    Account and Backup File only. Plus keeps Restore: any day in the last 90 days from the account, or a backup
    file; it replaces the habits on every device and says so first.
  - [ ] Remaining states and sizes, then a build spec; then build, tests on GitHub, iPhone check.

- [ ] **77. Without an account: iCloud and Google Drive backup, or only this phone? (research first).** Added 10 October
  2026, from the user: big companies' apps mostly don't offer "back up to Google Drive / iCloud"; on the free plan
  without an account, should we keep the iCloud and Google Drive backup being built on `app-lock-privacy-security`, or
  remove it so data stays only on the device and a (free) account backs up and syncs one device?
  - [x] Go through the reviews thoroughly and report. Done 10 Oct 2026: [Without an Account — iCloud and Google Drive
    Backup, or Only This Phone](<../../../Research/Research Reports/Data, Sync and Accounts/Without an Account — iCloud and Google Drive Backup, or Only This Phone.md>)
    (all 2,505 third-party matches read, 363 from the big companies' own apps). Recommendation: keep the automatic iCloud
    copy without an account on iPhone; take Google Drive off iPhone (it's Android's place); the account only once
    signed in (as built).
  - [ ] The user's decision. Until then the branch keeps iCloud on and Google Drive hidden behind its flag.

- [ ] **78. Free accounts sync one device at a time (plan, then build).** Added 11 October 2026, from the user, after
  checking Cloudflare's prices: instead of uploading the whole backup file ("backed up as you go"), a free account
  syncs like Plus, but with one active device; signing in on another device moves the habits there. Plus syncs across
  devices.
  - [x] One document with everything: what changes on the server and in the app, costs (re-checked with Cloudflare),
    data safety, tests, rollout. Done 11 Oct 2026: [Free Sync — One Device at a Time](<../Specs/Free Sync — One Device at a Time/README.md>).
  - [x] Phone + iPad on free? Checked from reviews (device sync is the top reason people pay; almost no complaints that
    it's paid): **no, free stays one device** (the user, 11 Oct 2026).
  - [x] Signing in on another device **signs the first one out** (it keeps its habits), said first on the new device and
    once on the old one; no "signed in but not syncing" state (the user, 11 Oct 2026).
  - [x] The UI: iCloud, Google Drive and Your Account at the same level on Backup & Export in every state; without an
    account the account row says what it gives ("Create one to sync your habits", opening Create Account), without
    pushing; free says it syncs one device, Plus says it syncs across devices. The new device's sheet and the old
    device's notice (Figma 950:309, screens 4, 4b, 4c, 7, 8; 2, 3, 3b reworded).
  - [x] Updated the Rulebook (D4), Free Plan Backups (75), the Account and Backup spec (76).
  - [x] **Server built and on dev** (10 Oct 2026, commit `20a05468`; S1–S8): one signed-in device per free account
    (409 `other_device_signed_in`, `replace`, 401 `session_ended` `signed_in_elsewhere` only to that device's token; the
    website never counts; a refund keeps the most recently seen device), `POST /v1/sync` open to free, snapshots kept
    and listed 7 days on free / 90 on Plus, the daily report's sync counts, older builds' backup files still accepted.
    `npm test` 161/161, typecheck clean, deployed to **dev only** (production waits for the user's go-ahead, T6).
  - [x] **Live checks on dev with two devices** (`.github/workflows/server-dev-checks.yml`, the run's own GitHub
    identity): run **38028154237**, 13/13: first sign-in, the second device asked first with the first's name, Continue
    moves it, the first device's sync and refresh told where it went, the new device's first download has everything
    (D14), signing back in merges both devices' changes (D3), the daily copies listed, Plus never limited.
  - [x] **Measured on dev** (the plan's two estimates, Free Sync §2.1): **5 rows written per new record, 4 per edit**
    (estimate 4); **about 1,390 bytes stored per new log** (estimate ~300), because the op log keeps every change as
    well as the merged record. Storage, not rows, is the cost to watch: see Free Sync §2.1's update.
  - [x] **App built** (commit `35c16841`; A1–A8): sync for every signed-in account, "Use on This iPhone?" (7), "Signed
    out on this iPhone" (8), Backup & Export's same list in every state (4, 4b, 4c, 4e), Account's Last Synced,
    Restore's 7 / 90 days, Help topics, analytics. Google Drive stays hidden behind its flag (not working yet).
  - [x] Tests on GitHub (10 Oct 2026): Backup, Onboarding, the screenshots, Sync and Analytics, with BackupUITests'
    two-device free account end to end through dev, in runs **38037588319** (7 failures: 6 tests out of date and the
    closed sidebar reported as an "alert", fixed in `8b453f03`) and **38039875406** (all of them passed but the share
    sheet's ✕ tapped too early, fixed in `d0ee0bd1`, BackupUITests re-run); the SE (SmallScreenUITests) **38037590271**;
    speed **38037591549** (Backup & Export and Account: 0 ms/s hitches, no freezes); the screens behind the ≡ menu
    (Today, Groups, App Lock, App Reliability, Test Launch Isolation, Persistence: 78/78) **38039877414**.
  - [ ] **iPhone checks pending (U9):** two real devices on one free account (sign in on the second: the first is
    signed out and keeps everything; sign back in on the first: changes made on both merge); a widget or notification
    change syncing in the background on a free account (D12, `SyncDeviceTests`); a locked iPhone (D13); mobile data used
    in a week. **On dev, every Apple or Google account is Plus while `EVERYONE_PLUS` is "true" (item 68): free
    behaviour on a real iPhone needs it set to "false" first, which is the user's call.**

- [ ] **79. Move to Another Device through the server** (added 10 October 2026, from the user: "it should be server
  based rather than depending on the mobile phone … like WhatsApp", mainly for people without an account; "if it won't
  cost a lot, then implement it"). Replaces the local-network transfer of item 73.1.
  - [x] Cost: one upload and one download per move (R2 class A + B, $4.50 and $0.36 a million), the file kept minutes;
    100,000 moves a month fit inside the included amounts: about $0.
  - [x] Server: `server/src/transfer.ts` (`PUT/GET/DELETE /v1/transfer/<id>`, `/received`, `/status`): no account, the
    file end-to-end encrypted (the server sees an ID and ciphertext only), deleted on receipt, an hour at most, 25 MB,
    limited per IP, pruned daily. `npm test` (8 transfer tests), dev deployed, live check up / down / gone (run
    38028154237).
  - [x] App: `DeviceTransfer.swift` seals the backup file with AES-256-GCM, key and ID both from PBKDF2 of the code; no
    local network and no Local Network permission any more; any network, any distance; iPhone ⇄ Android-ready (the same
    recipe, Architecture 04).
  - [x] Tests on GitHub: OnboardingUITests moves the demo habits between two launches through dev and refuses a wrong
    code, BackupUITests shows the code reaching the server, BackupCheck's seal / open checks: run **38039875406**.
  - [ ] **iPhone check pending (U9):** two real iPhones on different networks (one on mobile data).

- [ ] **80. Buying Plus: the App Store purchase, checked by the server and kept with the account (research first).**
  Added 10 October 2026, from the user (Product Roadmap 64; "the Plus screen exists but it isn't connected"):
  - [x] People can buy Plus from the App Store, in the app. *Built 10 Oct 2026 (the Plus screens, StoreKit 2, branch
    `claude/awesome-newton-pmu4y7`): the 6th-habit sheet (Plus and Plus Family side by side, Make Room), ≡ › Plus
    (prices that don't load, purchases turned off, Ask to Buy, Restore Purchases), Your Plus (owner, family member, a
    new device), the upgrade to Plus Family, Plus is yours, Plus has ended and the second-device sheet. Plus is
    `HabitStore.isPlus` (the account's or Debug's) OR an App Store entitlement. Tests: PlusUITests 10/10 (runs
    38067172071, 38068020591, which found and fixed a crash in Plus has ended), Today, Persistence, Onboarding and
    Backup 42/42 (38063952336), NewFlowUITests (38068020591), LongTextUITests 3/3 on the merged head (38084157868), the SE (SmallScreenUITests.testPlusSheetAndPageFit,
    38063954222); speed: choosing a plan 0 ms/s on the page and the sheet (38063956093), habit form typing side by
    side with main 21.2 against 21.9 ms/s over six rounds (38067941263). iPhone check (U9) still to do; the three
    products must be created in App Store Connect before a real sandbox purchase.*
  - [ ] As the plan says, the purchase is verified on the server (Cloudflare) and stored against the person once they
    buy it.
  - [ ] The user's assumption, to test: buying Plus mandatorily links an account; without an account, no Plus.
    **Research first whether the account should be mandatory**; if the research says so, implement it that way.
  - [ ] Take care of entitlement problems overall (restore, refunds, a second device, reinstalls, family sharing,
    an account that changes, offline, revoked or expired purchases). *Partly, 10 Oct 2026, on the App Store side:
    Restore Purchases (`AppStore.sync()`) with a real result, refunds and a family that stopped sharing ("Plus has
    ended", once; nothing hidden), a new device or reinstall (StoreKit already says Plus), family sharing
    (`ownershipType`), Ask to Buy, offline prices. The account and server parts wait for the iCloud work (D16).*
  - [ ] Research first (W2); then the plan; then build. The Apple Watch app and the iPad layout come after (Roadmap 65,
    66). Revert dev's "every account is Plus" (item 68) before testing a real purchase.
  - [x] Research done 10 Oct 2026: [Buying Plus — Should an Account Be Required?](<../../../Research/Research Reports/Business Model and Monetization/Buying Plus — Should an Account Be Required.md>).
    342 reviews read (paid but locked out by a failing login 46, 1.96★; forced account 37, 1.62★; no-account praise 24,
    4.83★); Apple 5.1.1(v) and App Review's purchase wording. Recommendation: no account wall; signed-in buyers buy into
    their account; signed-out buyers get "keep Plus with your account" right after paying (Not now kept); Plus is the
    App Store purchase **or** the account's record, removed only by a confirmed refund. Every entitlement case (§5) and
    what's left to build (§6). The server already verifies and records purchases and handles refunds.
  - [ ] The user's decision: optional account (recommended) or required; and the price.
  - **The user, 10 Oct 2026:** the account comes only after buying, never before; the question is whether it's
    mandatory then. Their worry: without an account, is Plus recognised on another device later? Answered: on any Apple
    device with the same Apple Account, yes, from the App Store itself (StoreKit 2), and the purchase can be attached
    to an account whenever they sign in; another Apple ID, Android, the web and sync need the account. Buyers without
    an account are welcome (they cost no server).
  - [ ] **Designs first** (the user, 10 Oct 2026): on the Figma page `onboarding` (767:9100), a new section beside the
    others with the overall flow. Before drawing screens, work out every screen and page needed: the Plus page (never
    finished), buying, after buying, Plus Family, and the rest. *Done 10 Oct: Figma 1011:309, 36 screens in 8 groups.*
  - [x] **The user's question, 10 Oct 2026:** Plus is lifetime but server costs keep running; switch to yearly or
    monthly? If the app becomes a hit, can we end up unable to pay for many Plus users' servers? And does sync mean phone
    to phone, or phone, desktop and web? *Answered the same day:
    [Plus — One-Time or Subscription, and What Sync Costs Over the Years](<../../../Research/Research Reports/Business Model and Monetization/Plus, Price and the Server — How We Decided/Plus — One-Time or Subscription, and What Sync Costs Over the Years.md>):
    a typical Plus user costs ~$0.80 over 10 years against $12.74 from one sale; keep one-time, keep ~$2 a sale in
    reserve; sync covers every device on the account, any platform.* **Decided by the user, 10 Oct 2026: Plus stays
    one-time** (lifetime; never a subscription).
  - [x] **Groups 2–4: the remaining purchase screens** (the user, 10 Oct 2026: "let's create the remaining purchase
    screens"): the Plus page (Plus or Plus Family, prices that can't load, what an owner sees), buying (Apple's sheet,
    waiting for approval, purchases turned off, didn't go through), after paying (Plus is yours signed out / signed in,
    saved to your account, couldn't reach it, bought for another account, the next-launch step, Plus Family's sign-in).
    *Designed 10 Oct, Figma 1018:309: P3, P3b, P4, P5; B1–B4; A1–A7. Placeholder prices $14.99 / $29.99 / $15.00.*
  - [x] **The user, 10 Oct 2026: arrange the designs as flows, not groups** ("if something belongs to the same page,
    everything should be together … create it as flows, where they encounter Plus"; iPhone only, other platforms
    later). *Done: one section, Figma 1021:309, "Plus on iPhone — every flow": Flow 1 starting a 6th habit (New →
    the sheet → Apple's sheet → Plus is yours → saved to the account, with each step's other outcomes under it);
    Flow 2 ≡ › Plus (every state of the Plus page together); Flow 3 the other ways to the Plus page; Flow 4 Plus
    Family; Flow 5 once Plus is yours; other platforms as a note. The two grouped sections are gone; the older Plus
    page variant (count + "what Plus adds") was replaced by the page with Plus / Plus Family.*
  - [ ] The user's review of the flows; then what's left: Plus Family (your family, inviting, joining), Restore
    Purchases' result, when Plus ends (a refund), an iPad or new iPhone on the same Apple Account.
  - **The user's review of the flows, 10 Oct 2026:**
    - [x] Plus and Plus Family are both important: the 6th-habit sheet offers **both**, not only "Get Plus · $14.99"
      (people who need a family plan would think there isn't one). Family prices aren't final: say so on the designs.
    - [x] The 6th-habit sheet adds a simple way to make room for free: **archive a habit (keeps its progress) or
      delete one**, for people who don't want to upgrade.
    - [x] Keep the sheet's own habit icons (the person's existing habits): "that looks cool".
    - [x] **Drop the "At 5 of 5" New screen (1.2):** people go straight to the sheet.
    - [x] **The second-device sheet ("Use on This iPad?") is an important place to upgrade:** redesign it clean and
      clear, never feeling like an upsell; Plus there is a shortcut (its button opens the Plus page), and the content is
      presented neatly, not a block of text. Research how to do this well (the web).
    - [x] Design and complete every other Plus or upgrade screen the iPhone needs.
    - *Done 10 Oct 2026 in Figma 1021:309 (research: contextual prompts at the moment of need, keep the person's place,
      a free path as clear as the paid one, few choices, the full price shown; Apple's HIG "let people experience your
      app before making a purchase"). Flow 1: the 6th-habit sheet with Plus and Plus Family side by side and "Make room
      instead" (1.2–1.2b), Make Room (1.3a: Archive on each habit, Delete in ••• asking first, 1.3b); the 5-of-5 screen
      removed. Flow 3: the second-device sheet redesigned (Move to this iPad first, Keep both in sync with Plus beside
      it, See Plus). Flow 4: Your family, Invite, remove / cancel. Flow 5: Restore results, Upgrade to Plus Family.
      Flow 6 (new): joining with an invite (Have an invite?, the code, sign in, Join Maria's family?, you're in, leave,
      can't join). Flow 7 (new): when Plus ends (refund, another device, a family that ended). Flow 8 (new): a new
      device on the same Apple Account. Prices and Plus Family details marked not final.*
    - [ ] The user's review of these.
  - **The user, 10 Oct 2026 (in this order, one after the other):**
    - [x] **1. The price of Plus**, as overall value in dollars (not a US price): what we pay out (Apple's cut, tax,
      servers, fixed costs) and what we keep. Assume **every user is an extreme power user**: many habits, syncing very
      often, for 10, 15 or more years; free users too (their cost comes out of Plus, since they never pay). Write the
      assumptions down.
    - [x] **2. The price of Plus Family**, worked out the same way.
    - [x] **3. How many people Plus Family holds** (today the buyer + 5 = 6): research it; generous is fine, too
      generous isn't.
      *Done 10 Oct (1–3): [Plus and Plus Family — Price and Size from the Extreme Case](<../../../Research/Research Reports/Business Model and Monetization/Plus, Price and the Server — How We Decided/Plus and Plus Family — Price and Size from the Extreme Case.md>).*
  - **Decided by the user, 10 Oct 2026 (after reading 1–3):**
    - Plus list price **never below $24.99**; raise it if the evidence allows. **Nothing anywhere below $19.99**
      (regional, student or sale); the working floor is $20.99.
    - **Plus Family: $59.99 one-time, 5 people** (the buyer + 4).
    - **Free users must be cheap by design** (the report's §5); the prices hold only with it.
    - **Every sale profitable with a good margin**, never at break-even, with inflation counted; discounts real
      (never a raised price crossed out), never stacked.
  - The user, 10 Oct 2026, second pass:
    - [x] Check the earlier price research (where people start complaining; sync as the reason to pay), inflation,
      regional and student prices, and the margin. *Done 10 Oct, the same report §0–§8: as built, $24.99 loses money in
      the realistic-pessimistic case; with the server changes in §5 one sale costs $8.74; $29.99 keeps 52% at Apple
      30% (61% at 15%) and is recommended (the reviews' objection line is ~$30–35); regional and student prices up to
      30% off at $29.99, never below $20.99; Family discounts at most $10.*
    - [ ] The user's choice: Plus at **$29.99** (recommended) or $24.99; the student price and how students are
      verified (Apple offer codes work for one-time purchases since 2025).
    - [ ] **Build the cost changes before launch** (report §5): free accounts push-only, quiet free accounts archived
      to R2 after ~12 months and restored on sign-in, 7 daily copies; for every account push sync (hibernating
      WebSocket), only the last 2 years in the Durable Object, 3 rows a record, nightly copies as changes; the daily
      cost report and alerts.
    - [ ] Update the Plus screens in Figma (1021:309) to the final prices and "You + 4 people" once the Plus price is
      chosen.
  - **The user, 10 Oct 2026, third pass:** a one-time Plus with a server we pay for over many years keeps bringing us
    back to square one. Can we have no server, so each sale is profit, without losing entitlements or data safety,
    still thinking of every user as extreme and never taking away what people had? What sync do people want? Would
    they still buy?
    - [x] Research it. *Done 10 Oct: [Plus Without a Server](<../../../Research/Research Reports/Business Model and Monetization/Plus, Price and the Server — How We Decided/Plus Without a Server — Sync, Entitlements and Data Safety on Apple's Own Services.md>).
      Yes for Apple devices: CloudKit (CKSyncEngine) for sync and backup, StoreKit for Plus, Family Sharing for Plus
      Family (then 6 people); about 92% of a $24.99 sale kept. Not possible without a server: iPhone ⇄ Android, web,
      one purchase on both stores.*
    - [x] The user's choice: no server for launch (recommended) or the server with the cost changes. *Decided 10 Oct
      2026 for Apple: **no server; CloudKit (`CKSyncEngine`) is final.** Android still open.* If no server:
      rewrite D3, D4, D9, D12, D14, D15 and the Plus screens; set the server, accounts and invites aside.
  - **The user, 10 Oct 2026, fourth pass:** put everything from the price to here in one folder, with the prompts;
    is CloudKit part of the developer account, limited or charged; what about Android, and a Mac with an Android
    phone? An account only for Plus across stores is acceptable, on Cloudflare's free plan.
    - [x] One folder: [Plus, Price and the Server — How We Decided](<../../../Research/Research Reports/Business Model and Monetization/Plus, Price and the Server — How We Decided/README.md>)
      (decisions, open questions, the reports in order, the user's prompts word for word).
    - [x] CloudKit, Android and mixed devices researched: [Android and Mixed Devices Without a Server](<../../../Research/Research Reports/Business Model and Monetization/Plus, Price and the Server — How We Decided/Android and Mixed Devices Without a Server — and CloudKit's Limits.md>).
    - [ ] The user's choices: the Android plan, Google Drive as the sync place for mixed devices, the
      entitlement-only account; check Google Play's rules (purchases from another store; family sharing).
  - **The user, 10 Oct 2026, fifth pass:** "for Apple it has been finalized" (CloudKit, no server). Is Android sync
    through Google Drive practical, or only theoretical? Has anyone done it; is there a framework?
    - [x] Researched: [Android Sync Through Google Drive](<../../../Research/Research Reports/Business Model and Monetization/Plus, Price and the Server — How We Decided/Android Sync Through Google Drive — Practical or Only Theoretical.md>).
      *Practical for us (our merge is order-free, so Drive is only a mailbox); no framework exists; prove it with a
      two-device prototype before Plus promises it.*
    - [x] The user's choice: Android launches with the two free backups, Drive sync for Plus after the prototype
      passes; build the prototype now or after the Apple CloudKit work. *Decided 10 Oct 2026: the recommendation;
      the prototype after the CloudKit work.*
  - **Decided by the user, 10 Oct 2026, final (Rulebook D16):** no server holds anyone's habits. Apple first: iCloud
    (CloudKit, `CKSyncEngine`), StoreKit, Family Sharing for Plus Family (the buyer + 5). Then Android: Auto Backup and
    a daily Drive file free; Drive sync for Plus after the prototype. Full privacy: habits never reach us. Plus $24.99,
    Plus Family $59.99. An entitlement record (never habits) on Cloudflare's free plan when Android launches.
    - [ ] **Build CloudKit sync and backup on Apple** (replacing our server sync and accounts); rewrite D3, D4, D9,
      D12, D14, D15 and Architecture 02/05 as it lands. (New item number to be taken when started; W1.)
    - [x] **Update the Plus screens in Figma (1021:309) to the final decisions:** no account steps, Family Sharing
      instead of invites, $24.99 / $59.99, "full privacy" said plainly. *Done 10 Oct: every price $24.99 / $59.99 /
      $35.00 upgrade; 1.4 Plus is yours (no account, privacy line); 3.1 second device reworded for iCloud; 4.3 Plus
      Family shared through Family Sharing (buyer + 5); Flow 6 is now the family member's view; 7.1, 7.1b, 8.1 and the
      restore alert reworded; 17 account and invite screens moved to "Retired with the server", not to be built.*
    - [ ] Open: the ≡ menu still has an Account row (B1, B1b). With no account on Apple, what replaces it (for example
      "iCloud Sync & Backup")?
    - [ ] Then Android: the two backups; after the CloudKit work, the Drive sync prototype (six tests).
    - [x] **4. The 6th-habit sheet (1023:309) looks poor; improve it.** "Not now" doubles the ✕ on a sheet: remove it;
      "Or, for free" can become plain text, a small note, or go if it's unnecessary.
      *Done 10 Oct in Figma (1023:309, 1023:354, 1023:399): Not now and the "Or, for free" card gone; a short "Both plans
      include" list (unlimited habits, iPad and Apple Watch, sync) replaces the grey sentence; under Get Plus, a plain
      "Make room instead" text button with a small note (archive or delete). Shows the recommended, not final, prices.*
    - [x] **5. The second-device sheet (3.2):** should Plus ("Keep both in sync") go above "Move to this iPad"? A Plus
      button at the bottom is the easiest to tap by accident, and people would call that pushy: research the order,
      or redesign it.
      *Done 10 Oct: [Where the Plus Button Goes](<../../../Research/Research Reports/Business Model and Monetization/Where the Plus Button Goes — Accidental Taps and Pushy Placement.md>)
      (48 hand-read reviews of accidental paid taps, 1.60★, mostly a paid button where "go on" was expected). Figma
      1024:309: Plus card first with an outlined See Plus; Move to this iPad last with the only filled button.*
  - [ ] **Group 1, Ways in** (the user, 10 Oct 2026), in a new Figma section:
    - [x] The 6th habit, **in context, not a bare "upgrade"**: "you've reached the limit; get Plus to add a 6th habit,
      unlimited habits" (ledger C137 the moment of need, C236 announced before investing, C204 never lose work).
      *Designed 10 Oct, Figma 1013:309 row A: A1 the count before the limit, A2 at 5 of 5 (Plus tags on the habit
      rows), A3 "Add a 6th habit with Plus" (their 5 habits and an empty 6th), A4 from an idea ("Add Drink water with
      Plus", the form kept), A5 restoring ("Bring back Read with Plus").*
    - [x] ≡ › the Plus row, and the screen it opens; the same for no account and a free account (the count is
      app-wide; the account doesn't matter). *Row B: B1/B1b the row at 3 and 5 of 5, B2/B3 the Plus page (the count,
      what Plus adds, the price, Restore Purchases).*
    - [x] The other ways in (Account › Plan; a second device on a free account). *Row C: C1, C2.*
    - [x] Other platforms (the Apple Watch's way in) later: documented, not drawn. *Row C note.*
    - [ ] The user's review of group 1.

- [x] **81. Move sync and backup from our server to iCloud (CloudKit with `CKSyncEngine`), and simplify the app
  around it** (added 10 October 2026, from the user; Rulebook D16; **to work on later**, when the user says so).
  The user: "first let's set up the overall groundwork like CK sync engine … we have to move it from [Cloudflare] …
  delete the unnecessary code and improvise the application … we have to change the backup and restore page as well
  as account page, because now we are using CloudKit, I mean iCloud. So everything will be much simpler."
  - [x] **Research and a hand-off report first**, written like the Plus screens prompt, for another agent to build:
    *Done 10 Oct: [Architecture 11 — iCloud Sync with CloudKit](<../../../Architecture/11. iCloud Sync with CloudKit.md>):
    the phone stays the truth, the outbox until CloudKit confirms, deletes as fields never CloudKit deletions, dated
    backup files outside sync, a mass-change brake, every CloudKit limit and error, the free plan's handover, yearly
    compaction for extreme users, tests on a fake iCloud.* *Its four decisions made by the user, 10 Oct 2026: no encrypted
    fields (they can't be recovered after an account recovery); Google Drive backup kept as it is, nothing new built;
    the server folder tagged and removed after CloudKit ships and passes the device checks; the brake at 20% / 50 rows.*
    how `CKSyncEngine` maps onto our sync (records, `SyncRules` merge, tombstones, the outbox), what Apple setup is
    needed (the iCloud container, entitlements, CloudKit schema), migration from today's server and accounts, tests.
    The user will enable whatever is needed in the Apple Developer account and provide any data asked for.
  - [x] Can a cloud agent build it? Yes (10 Oct 2026): everything was built and tested on GitHub against `FakeCloud`; only the device checks below need the user. To answer in the report. Known so far: the code and most tests can be written and
    run on GitHub's simulator with a stand-in for iCloud; GitHub's simulator can't sign in to an Apple Account, so real
    iCloud sync is checked on the user's iPhone and an iPad (or a second iPhone).
  - [x] Replace the server's sync and backup with CloudKit; delete the code that's no longer needed (accounts, our
    sync, invites, moving with a code through the server), with D3, D4, D9, D12, D14, D15 and Architecture 02/05
    rewritten as it lands.
  - [x] **Redesign the Backup & Restore page and the Account page** for iCloud (no account on Apple); decide what
    replaces the ≡ menu's Account row.
  - [x] **Decided by the user, 10 Oct 2026:** free keeps **one syncing device at a time** (an iPad works on its own as
    the one device; the same habits on iPhone and iPad is Plus); **the "This week" widget becomes Plus** (Today,
    Tasks, One habit and Lock Screen stay free; the user's say-so for locked widgets, U28; check on the iPhone Home
    Screen when built). Still open: an optional quiet Plus line at a success moment.
  - [x] Apple setup, known so far: the iCloud container `iCloud.com.oftenenough.app` already exists (iCloud Drive
    backup); the build adds the CloudKit service and push notifications (silent pushes tell a device something
    changed), which automatic signing registers on the first iPhone build. The user, later: two devices on one Apple
    Account for testing, and "Deploy to Production" in the CloudKit Console before release (or a CloudKit management
    token so an agent can do it).
  - [x] The research must settle: the CloudKit record layout (per record or batched; Apple's limits for an extreme
    user's 25,000 records a year), `CKSyncEngine` with `SyncRules` (conflicts, deletes), which device is the free
    plan's one syncing device, data safety (iCloud sync isn't a backup: keep the daily file and "never replace with
    less"), what's deleted with the server, and what GitHub's simulator can test.
  - **The build (the user, 10 Oct 2026, to a cloud session):** "build iCloud sync with CloudKit as designed in
    Architecture 11, following the Rulebook. Data must never be lost: that comes first. Test against the fake iCloud on
    GitHub, fix any real bugs, and merge into main once tests pass." Steps 1–4 of Architecture 11 §21, on branch
    `claude/lucid-johnson-egrjup`:
    - [x] 81.1 Groundwork: `CloudTransport` (the real `CKSyncEngine` behind it, `FakeCloud` for tests),
      `SyncRules.mergeRecord`, the schema 9 migration (`sync_meta.ck_system`), `CloudSync` (§5–9).
    - [x] 81.2 Accounts, zones and the free plan's one syncing device (§10–12).
    - [x] 81.3 Safety: the fresh-install wait, the mass-change brake, the dated backup files, the clone check, sending
      after changes made outside the app (§13, §15).
    - [x] 81.4 The iCloud page (replacing Account and the sync parts of Backup & Export), the ≡ row "iCloud & Backup",
      and removing the server code of §17.
    - [x] 81.5 Tests: `FakeCloud` with every error and event, the property test, the extreme account, `jvmTest`
      (`mergeRecord`), the migration from every past schema, UI tests of every iCloud page state and the SE, speed
      scenarios; all on GitHub.
    - [x] 81.6 Rulebook D3, D4, D9, D12, D14, D15 rewritten for iCloud; "replaced by 11" notes in Architecture 01, 02,
      04, 05, 06; What's Built; Design Rules' iCloud page; merged into `main`; branches marked safe to delete.
    - **Done and tested on GitHub, 10–11 Oct 2026** (branch `claude/lucid-johnson-egrjup`, final code `052be04`; the
      runs on `ad48b96` and the fixes after them):
      - Core: `jvmTest` passes in every run (`CloudStoreTest`: `mergeRecord` ≡ the per-clock ops, confirming by outbox
        position, the brake both ways, the extreme account 375,000 records up and down; `MigrationTest`: schema 9 from
        every past schema).
      - Against the fake iCloud: `ICloudUITests` every guard and error of §3 and §7 and the property test
        (`testSyncAgainstTheFakeICloud`), the page in every state, Today's card, the two questions, the second-device
        sheet (runs `38094553071`, `38087945437`); the extreme account (`38094557875`: all checks passed; on the hosted
        simulator import 618 s, upload 1,087 s in 1,501 requests, fetch 474 s).
      - Every class it touches: Backup 7/7 (`38096927765`), Onboarding, Today and Plus 28/28 (`38094554630`), Widgets,
        Timers and Reminders 15/15 (`38094559336`), OnboardingBackupScreenshot (`38094553071`), the iPhone SE 11/12
        (`38094556445`; the 12th, `testPrivacyCodeSheetsAndReminderSaysFit`, fails the same way on `main`, run
        `38085507312`: App Lock, not this work).
      - Speed (`38094560760`): every iCloud page state scrolls at 0–5.3 ms/s with no freeze; Today during a 20,000-log
        fetch scrolls at 0.0 ms/s and +1 at 15.2 (one 250 ms freeze), the fetch and uploads done in 96 s; Today's own
        windows unchanged. Found and fixed on the way: `CloudStore` on the main thread (PERFORMANCE-LESSONS L31,
        Rulebook S16), re-reads per fetched page, two file pickers in one stack (Restore froze 14–46 s), weekly
        backup copies a day apart after New Year (the backup check). Opening the page and Restore,
        measured the same hour against `main`: first 523 ms (`main`'s Backup & Export 1,154), again 291 (348), Restore
        190 (298) (runs `38099547344`, `38099545468`); Restore once measured 2.5 s after the fix (hosted noise, three
        other runs ~0.2 s). "Widgets: one habit's week" (up to 831 ms with 20,000 extra logs) is item 83.
    - **Left for the user** (step 5 of §21; a cloud session can't do these):
      - [ ] The device checks of Architecture 11 §19 on the iPhone and an iPad (or a second iPhone) on one Apple
        Account: a change on one shows on the other; Airplane Mode, then back; a full iCloud; signing in to another
        Apple Account (the question, both answers); deleting the app's iCloud data in Settings (Back Up Again / Not
        Now); a reinstall gets everything back before Start without restoring; free: the second-device sheet, Move
        Here, the old device sending what it has; Delete My Data From iCloud; a widget tap, a notification's Done and
        the Live Activity reaching the other device without opening the app (D12, D13: also with the phone locked).
      - [ ] The first iPhone build from Xcode registers the CloudKit service and push notifications (automatic
        signing); the CloudKit Console then shows the container's Development schema (`Row`, `Active`, `Device`).
      - [ ] **Deploy the CloudKit schema to Production** in the CloudKit Console before the first TestFlight build
        (TestFlight and the App Store use Production; without it nothing syncs there), and switch
        `aps-environment` to `production` for that archive (Xcode does this for App Store distribution).
      - [ ] Once CloudKit has shipped and passed these checks: tag the server `server-final-2026-10` and remove
        `server/` (the user's decision, 10 Oct 2026; nothing in the app calls it any more).

- [ ] **82. The Apple Watch app (Plus)** (added 10 October 2026, from the user: "start the Watch app research"; roadmap
  #65; **to build later**, when the user says so, after item 81's iPhone CloudKit work).
  - [x] **Research and design:** *done 10 Oct: [Apple Watch App — What People Want, What Breaks, and How Ours Works](<../Apple Watch/Research/Apple Watch App — What People Want, What Breaks, and How Ours Works.md>).
    All 3,051 App Store reviews naming a watch read and coded; Apple's watchOS limits checked; the core's Room 3 and
    SQLite libraries confirmed for watchOS. Design: an independent Watch app with its own database, changes by
    WatchConnectivity and its own `CKSyncEngine` at once, counted once; rules WA1–WA13.*
  - [ ] The user's four decisions (report §9): version 1's scope (routines on the Watch in version 2); ~~minimum
    watchOS 11~~ *decided 11 Oct: watchOS 11 is fine (the user)*; a custom Smart Stack layout for the timer Live Activity (widget lock, U28); ~~an Apple Watch on the
    user's Apple Account for the device checks~~ *answered 10 Oct: the user has an Apple Watch Series 10 (GPS) on
    watchOS 26 (arm64, so it checks that build directly).*
  - **The user's plan, 10 Oct 2026, one step at a time** ("we will go step-by-step"; each step finished before the
    next):
    - [x] **Step 1. Can a focused routine run on the Watch?** Check Routinery and other routine apps: does their
      Watch app run timed routines (start, step timers, next/previous, finish), how well (reviews), and what watchOS
      allows. If yes, our Watch app runs focused routines too (moves routines from version 2 into version 1).
      *Done 10 Oct: yes. Routinery has run timed routines on the Watch since Nov 2020, and people love it when it
      works, but 57% of its 182 Watch reviews report sync failure or a broken app: routines that end when the wrist
      drops, two devices running different copies, fewer actions on the Watch. Our player (place per device, timers
      as synced start times, nothing auto-advances) avoids most of it; rules R1–R9 in [Running a Routine on the Watch](<../Apple Watch/Research/Running a Routine on the Watch — Can It Be Done.md>).
      The routine player moves into version 1.*
    - [x] **Step 2. Design every Watch screen in Figma**, with proper navigation. Pictures of every screen and their notes:
      [Apple Watch/Designs](<../Apple Watch/Designs/Design Notes.md>).
      *Done 10 Oct (section 1048:2 on the "watch" page, 46 mm): what's on the Watch vs only on the iPhone; the
      navigation rules (one stack from Today, two levels at most, the Crown scrolls and moves between a routine's
      habits, main action in the bottom bar); A Today (7 screens), B Day details for every kind (14: amount, another
      amount with the Crown, check, timer, running, Always On, checklist, quit, one log, delete, ⋯, skipped), D the
      routine player (6), E notifications and timer alerts (4), F watch face, interactive complications and Smart
      Stack (6), G the navigation map. Text is SF Pro in Figma (SF Compact isn't installed there).*
      *Revised 10 Oct after the user's review: one section per group (Decisions, A Today, B a habit's page, C routine,
      D notifications, E watch face, F map; B is Day details, the sheet a Today row opens, today only, renamed 10 Oct at the user's question; no notes on the Watch) with the notes in their own section; headers inside the rounded corners
      (title and time inset, buttons clear of the edges); dials centred; every time-of-day section has its own Start
      (filled in Now, grey elsewhere, none for Quitting), as on the iPhone.*
    - [x] **Step 3. The Plus screen on the Watch:** someone without Plus who opens the Watch app is told it's part of
      Plus and how to upgrade. *Done 10 Oct (Figma section "Watch · G · Plus on the Watch"): the Watch sells Plus itself
      (StoreKit's purchase works on watchOS 8+; Apple's own sheet, the side button to pay) with the App Store's price,
      Continue on iPhone (Handoff to ≡ › Plus) and Restore Purchases always on the page; Plus is yours; Ask to Buy
      waiting; couldn't reach the App Store; Plus ended (nothing deleted); our complication without Plus. Plus Family
      is chosen on the iPhone; reminders still reach the wrist free (watchOS mirrors the iPhone's notifications).*
    - [x] **Cross-check against the iPhone (the user, 10 Oct: "have we covered everything… like widgets… alarms").**
      *Done 10 Oct: Figma section "Watch · H · Added after the cross-check" (20 screens) and its notes. Added: limit
      habits (row, page, over the limit), a week-goal check, tasks on Today, skipped and paused, logging a slip and after,
      a milestone beside Undo, the streak in Day details, alarms (watchOS has no alarm API; Apple shows the iPhone's
      AlarmKit alarm on the paired Watch, buttons to check on the Series 10), Remind Again, grouped reminders, a timer
      reminder without Done, Siri on the Watch, controls and the Action button (proposed, after version 1), a failed
      save, the 42 mm Watch and larger text. Fixed to match the iPhone: Today's row lines ("3/8 glasses", "Every day")
      and the notification words ("Done", "Not done yet · …", "Reminder · 8:00" with buttons that still log).*
    - [x] **Manual logging on the Watch (the user, 10 Oct: "only if it is good UX").** *Done 10 Oct: yes for amounts and
      times. Figma B15–B18: hours and minutes wheels for time (Apple's Timers pattern, ends now); an amount that asks how
      much opens at the last value, decimals by the Crown; a number far away is said or typed with Apple's own input.
      "Log manually" with a pencil beside +1 and Start, "Log amount" as the main action when an amount always asks, as
      on the iPhone. Words fixed to the iPhone's: "Record a slip", "Add a check".*
    - [x] **Step 4. The Watch's database design.** *Done 10 Oct: [Architecture 12 — Apple Watch, Data and Sync](<../Apple Watch/Data and Sync (Architecture 12).md>).
      A full copy on the Watch in the same Room database; synced straight with the iPhone (WatchConnectivity: a checked
      backup file first, then ops both ways with acknowledgements) and with iCloud after item 81; the iPhone passes the
      Watch's changes on; a timer stopped on both devices logs once (entry ID from the habit and its start). GitHub's
      macOS 26 runner has the watchOS SDKs and Watch simulators, so it builds and tests there; the real Watch is for
      complication transfers, real iCloud, haptics, Double Tap, Always On and the final look (U9).*
  - [ ] **Build it (11 Oct 2026: handed to a cloud session):** [Build Prompt (Delete When Done)](<../Apple Watch/Build Prompt (Delete When Done).md>),
    on branch `apple-watch`: every screen, data and sync, complications, notifications, Plus; screenshot review on
    46 mm and 42 mm; data reliability, sync, storage and speed tests.
  - [ ] Build, in the report's order (§8): the core on watchOS; the app with its own database; WatchConnectivity;
    `CKSyncEngine` on the Watch; complications; timers, notification buttons and the Plus gate.
  - [ ] Tests on GitHub's simulator (§7), then the device checks on the user's iPhone and Watch (U9); add WA1–WA13 to
    the Rulebook once built.

- [ ] **36. The Edit Entry screen: improve its overall design.** Added 4 October 2026, from the user: "We need to try
  to improve it, the overall design and everything, so that it looks good."
  - **What it is:** the screen a single entry opens to, from the Day sheet's entries and the habit page's History
    (`EntryEditor` in `DayEntriesSection.swift`, title "Edit Entry"): the amount, time or slip time, a footer, Delete
    Entry, Save. It's a plain form today.
  - **To do:** look at it for every kind of habit (amount, time, check counted several times, checklist step, quit
    slip), list what each shows, then design it so it reads well and matches Add Entry ("same mental model for adding
    an entry", 3 Oct). Keep everything it does now (U5): editing one entry only, Delete Entry, the time zone line for
    slips. Research first if the design question is open (W2); check on the iPhone (U9).
  - **Research and wireframe handoff, 4 October:** the [report and ten Markdown-renderable states](<../../../Research/Research Reports/Day Structure and Organization/Day Details and Entry Editor Handoff/README.md>) document why a separate editor is useful for amount, duration, multi-check and quit-slip records, while a single check, checklist step or task is corrected in Day details. This preserves the one-record mental model without forcing the same field on unrelated types. The user's later review led to direct tap-to-type Hours/Minutes/decimal Seconds and native Date **and** Time pickers for a slip. The mockups represent hierarchy and behavior, **not final iOS visuals**; all controls must be native (U1/U19).
  - **Implementation gap:** a slip date change must atomically move the same record ID to its new tracked day, update `entry.day` and `createdAt`, day indexes, persisted/synced values, quit run and affected day summaries, then show the destination Day sheet. The current app rejects a cross-day slip edit, so keep its date read-only until that path works (D7/U19). Preserve other logs, note, skip flag, source and saved time zone; retain Delete-this-one-record with confirmation until durable Undo exists.
  - **Status:** research and Figma proposal completed; native app implementation, tests, speed checks and real-iPhone validation remain open (U9/S2/T3/T4).
  - **Native implementation, 4 October:** built on branch `details-page-update` with item 22; tracked point by point in item 47.

- [ ] **24. Habit details: redesign the area above History · Notes · Progress tabs.** Added 4 October 2026.
  - The requested scope is a modest layout change to the header/content above the tabs on every habit details page.
    The current arrangement needs a new layout; this request is not a redesign of all three tabs.
  - Work out a clean hierarchy, alignment and spacing for that area while preserving its existing useful
    information and actions. Check how the same layout adapts across habit types and longer content.
  - Keep restoring streaks (item 23) independently tracked; do not hide it inside this layout task. No final header
    layout or mockup was chosen in this request.

- [ ] **27. History: research where Add Entry and Go to Date should live.** Added 4 October 2026.
  - Today both buttons are at the very top of the History tab. Research whether to keep them there or move the
    actions to a persistent/sticky bottom area. The bottom placement is a proposal to evaluate, not a decided layout.
  - Compare discoverability, reachability, scrolling, native iPhone conventions and whether the controls cover
    history content. Preserve both adding an entry and navigating to a specific date.
  - Record the reasoning and design choice before implementation. The Add Entry contrast problem must be fixed
    independently (item 26), wherever the buttons end up.

- [ ] **29. Redesign the Overall Record card.** Added 4 October 2026.
  - [x] **11 Oct 2026, from the user (with screenshots of Read's Progress tab):** work on the habit's Progress tab one
    thing at a time. First: (1) bring the streaks back, visibly, in this tab (today they are only the small grey
    "Now 0 · best 6" inside Milestones); decide where, and whether it's just Current and Best or more; (2) decide
    whether Overall record needs improving, for every habit type (time: "2 h 43 min recorded", check: "50 times",
    checklist: "56 steps done" …); (3) designs in a new Figma section. Don't touch Week, Month and Year; Milestones
    comes after.
    - [x] One example drawn and approved by the user, 11 Oct (Read, time habit, iPhone SE); no frame per habit type,
      the build adapts the layout to each type's existing content:
      [Habit Progress — Overall Record and Streaks](<../Specs/Habit Progress — Overall Record and Streaks/README.md>).
  - [x] **11 Oct 2026, from the user (with screenshots of Read's Milestones):** Milestones feel like "just another
    record", a bunch of squares filling up; they should feel like a reward or a surprise, but not gamified, and work for
    every habit type. Research how milestones should be presented, including whether every milestone should be visible
    up front (they're predictable), then design one screen. Researched (report "Milestones That Feel Earned — Awards,
    Not Squares") and designed: medals for reached milestones, one Next ring per track, See all page (Figma frames 2–4).
  - [x] **11 Oct 2026, from the user:** do streaks and milestones work for weekly and monthly goals (any habit type:
    time, check, steps)? Check the code and its edge cases, say whether the design scales and how they're shown
    ("5 weeks in a row", "1 month"). Checked: spec §5–§6 (edge cases E1–E11); weekly example drawn (frame 5).
  - [ ] **Build it** from [Habit Progress — Overall Record, Streaks and Milestones](<../Specs/Habit Progress — Overall Record and Streaks/README.md>)
    (the user, 11 Oct 2026: document everything so another agent can build it; keep every milestone value up to 5,000;
    goal changes never take reached milestones away). Designed, approved and documented 11 Oct. **Started 10 Oct 2026
    by Claude on branch `habit-progress-milestones`** (from `app-lock-privacy-security`; W3). The user's build points:
    - [x] Overall record (§2, §5.1): title line + Since, headline, 2 × 2 boxes (Current streak 🔥 tinted, Best streak
      with its dates, Goal met X of Y · %, Best day); Best week / month / year and "This week: 2 of 3" for period goals;
      box 4 absent for check-once, checklist and limits (Goal met spans the row); Show Streaks off drops the streak
      boxes; quit keeps its own card; one column at accessibility sizes; fully visible on the SE.
    - [x] Milestones (§3): medals (habit-colour gradient, inner ring, white number) for reached only; the latest on a
      tinted plate; Earlier shelf newest first; one Next row per track with a ring (current ÷ target); See all N › to a
      new All milestones page; later milestones never drawn; the squares retired; first-seen scale-in + light haptic
      (none with Reduce Motion); VoiceOver labels (§3.3); light and dark.
    - [x] Ladders (§4): every existing value kept, the new in-a-row, quit and In total values added; Today's after-tap
      line uses the same ladders.
    - [x] Edge cases (§6), especially E1 (goal eras keep their medals), E2 (Goal met and In total only in today's
      unit), E3 (a period's date is the day its goal was met), E7 (reached once).
    - [x] Wording per type and goal period (§5.3).
    - [x] Tests on GitHub (10 Oct 2026): check_rules; ProgressCheck G19 updated and G21 (E1, E2, E3, E7, month and
      year totals, the ring, Best week, "This week: 2 of 3") and the old and new UI tests in ProgressUITests
      (**38039010621**, **38046477483** after the dates followed the phone's language); HabitPageUITests and
      WeekCardsUITests 26/26 with the light and dark pictures (**38042248151**); SmallScreenUITests on the SE 11/11
      (**38042249924**); speed scenario `habit-milestones` (**38039014037**, **38042251659**, **38044515941**,
      **38046476058**: the shelf and All milestones scroll at 0 ms/s of hitches; All milestones' first opening read
      50 s and 22.6 s in two launches with the main thread asleep in the profile, and 150–370 ms in the seven launches
      since, as a blank page pushed the same way). Side by side with `main` before the redesign, one job, four rounds (**38048447170**): Progress scrolling 8.3 ms/s against 9.9 before, switching tabs 37.7 against 41.6; History (not changed) 7.7 against 2.9 with the rounds disagreeing (3.0 against 7.1 in one): nothing slower by the S2 rule. Merged into `main` 10 Oct 2026 (the user's one-time decision, then
      each fix once its run passed).
    - [x] **The SE and "What the squares mean"** (the user, 10 Oct 2026): until the key is folded once, it pushes Overall
      record down and its last row is below the SE's screen; that's fine ("they will eventually fold it"). With the
      key folded the card fits (SmallScreenUITests checks that).
    - [ ] iPhone check (U9), light and dark mode: for the user.
  - [x] **11 Oct 2026, from the user:** more in-a-row milestones for every goal period (days, weeks, months; "not 50
    or 60, maybe 10, 15 if it makes sense"). Decided in the spec §4: about 15 per ladder, adding values only.
  - [x] **11 Oct 2026, from the user:** approve the In total additions too: month goals add 3 and 6, year goals 2 and 5,
    before 10 … 5,000 (spec §4.2).
  - The Overall Record card in the habit details Progress tab does not look good to the user; improve its visual
    hierarchy and presentation. Record any applicable equivalent in the main Progress page when assessing scope.
  - Make the information feel deliberately designed, with clear grouping, spacing and readable numbers/labels.
    Preserve the useful record/statistics content and correctness for each habit type.
  - This is independent of restoring streaks (item 23), Milestones (item 30) and period-card padding (item 31).

- [ ] **30. Improve the Milestones design — later work.** Added 4 October 2026; explicitly noted by the user as
  something to work on later, but definitely needed.
  - Designed 11 Oct 2026 with item 29: build it from the same spec,
    [Habit Progress — Overall Record, Streaks and Milestones](<../Specs/Habit Progress — Overall Record and Streaks/README.md>) §3–§6.
  - The current Milestones presentation looks basic and dull. Improve the card/section design and hierarchy so
    milestones feel meaningful and visually considered, consistent with the app's style.
  - Preserve the existing achieved/upcoming milestone information and its meaning; do not treat the visual
    criticism as a request to change milestone rules. Review any relevant Milestones presentation in Progress and
    the habit details Progress tab.
  - Keep this a separate open task. Do not mark it done because Overall Record or Week/Month/Year spacing was fixed.

- [ ] **3. Account out of Backup & Export.** Backup & Export holds only backup and export (the backup account it
  uses can stay there). Making an account, signing in and deleting the account are not backup things.
  - Account up front: the ≡ sidebar shows the account state, at the bottom or wherever fits, e.g. "No account"
    with a clear "Create an account". Research where it goes and what it says.
  - **Started 9 October 2026 with item 73** (one piece of work: the account up front, and signing in from the welcome).
    Research and decisions are tracked under item 73. Item 58 (another agent, branch `app-lock-privacy-security`) is
    also changing the ≡ sidebar (Privacy & Security, the Widgets page removed): coordinate before building.

- [ ] **58. App Lock and widget privacy: decide how they should work, then build** (added 6 October 2026, from the
  user; **next after the widgets**). Today the app's Face ID lock (`AppLock.swift`) or the switch Menu → Widgets →
  Hide widget content makes every widget show "Content hidden" until it is turned off; widgets can't ask for Face ID,
  and unlocking the app doesn't reveal them. The user's questions: how should it work for the widgets, and is it
  needed? Feature Ledger: C017 Passcode lock (Strong, 15 apps; "minor", noticed when missing, removed or paywalled) and
  C096 Privacy and discretion stack (a must-have; "category-critical for recovery users on family phones").
  - **Proposed (not decided):** keep App Lock free and off by default; mark the widgets `privacySensitive` so iOS hides
    them on the Lock Screen while the phone is locked; keep "Content hidden" (everything hidden) for people who turn on
    App Lock or Hide widget content. Settle "hide everything" against "counts only" (the 30 Sep App Lock report and the
    Lock Screen designs show counts only; the code hides everything).
  - Evidence and the widget side: [Implementation Spec §9](<../../../Research/Research Reports/Home Screen and Visual Design/Home Screen Cards and Widgets/Widgets/Implementation Spec — Every Widget.md#9-privacy-app-lock-and-whats-next>),
    [App Lock — Private Without Lock-outs](<../../../Research/Research Reports/Settings and Help/App Lock — Private Without Lock-outs.md>).
  - [x] **Research: what people expect (the user, 8 Oct 2026: "first, let's do research on what people expect and how
    it should work … on the iPhone").** Done 8 Oct 2026 by Claude:
    [App Lock and Widget Privacy — What People Expect](<../../../Research/Research Reports/Settings and Help/App Lock and Widget Privacy — What People Expect.md>).
    3,861 reviews read (2,205 on topic) plus Apple's documentation. Found gaps besides the widgets: reminders, Siri
    ("What's left" reads names, also on a locked phone) and the Live Activity name habits while App Lock is on; no UI
    test covers the lock.
  - [ ] **The user's decisions** (report §6): widgets while locked (discreet / hidden / a choice); separate code or the
    iPhone's own; when it locks; notifications, Siri and Live Activity while locked; locking some habits only.
    - [x] **1. Widgets while App Lock is on: Discreet** (the user, 9 Oct 2026). Hide habit names, task titles and
      section names (also in VoiceOver); keep icons, colours, fills, counts, "N of M done" and the ✓ / + / ▶ buttons, which
      keep logging; task widgets show "N tasks left"; anything that opens the app meets the lock first. Replaces today's
      "Content hidden". Definition per widget: report §6a. Widgets are locked (U28): this is the user's say-so for this change.
      **The user, 9 Oct 2026:** agents may change the widget code for this, but must preserve the near-instant logging
      (the card changes at once, work happens behind), data reliability (every tap saved once, in order) and syncing
      without opening the app (W1–W18, D12). Report §6b lists exactly what to keep and how to check it.
      **Also decided 9 Oct:** ≡ → Widgets' "Hide widget content" becomes "Hide names on widgets" (same discreet look,
      works without App Lock); App Lock turns it on and holds it on (greyed, "On while App Lock is on").
    - [x] **2. Separate code: offered as an option** (the user, 9 Oct 2026). Default stays the iPhone's Face ID and passcode;
      Privacy offers "Face ID and an Often Enough code": the phone's passcode never opens it; the code lives in this
      iPhone's Keychain only (survives reinstall, never syncs); Face ID resets a forgotten code; a changed Face ID / Touch ID
      set (someone added their face) stops Face ID until the code is typed; otherwise a **24-hour** delayed reset with the
      iPhone passcode, shown on the lock screen and cancellable; no hints or questions; nothing deleted. Report §6c.
      After a Face ID / Touch ID change, typing the code must not silently re-trust the new set (it may include someone
      else's face): ask "Use Face ID again" / "Keep Face ID off" and point to Settings → Face ID & Passcode (§6c, point 4).
    - [x] 3. When it locks (decided 9 Oct 2026): every time by default; Privacy offers Ask again: Immediately / After 1 minute / After 15 minutes; locking the iPhone always locks the app at once; nothing past 15 minutes; never asks while in front or after the iPhone's own interruptions; keeps the place and typed text; every way in waits for the unlock (report §6d).
    - [x] 4. Names outside the app (decided 9 Oct 2026): "Hide names on widgets" becomes **Hide names outside the app** (widgets, reminders, alarms, the timer's Live Activity, Siri); App Lock turns it on and holds it on; icons, numbers and Done / + stay (+ without a unit); reminders and alarms use a new optional per-habit **"Reminder says…"** field, else "Reminder · 8:00"; Siri answers without names and per-habit phrases/suggestions are withdrawn; `hiddenPreviewsBodyPlaceholder` "Reminder" (report §6e).
    - 5. Some habits only: **moved to Future** (the user, 9 Oct 2026); see "Lock only some habits" there.
  - [x] **How it's shown in the app: spec written** (the user, 9 Oct 2026: "it should be communicated in UI properly, like app asks separate code when Face ID is changed and about cooling period … everything should be in privacy and security tab and remove widgets tab"). [Privacy & Security — What to Build](<../Specs/Privacy & Security — What to Build.md>): ≡ → Privacy becomes **Privacy & Security**; the **Widgets** page is removed, its switch moves to Privacy & Security and its guide (kinds, adding, choosing a habit, the update problem with Try again) moves to Help → Widgets, where a widget's Choose a habit link now goes (U5); every message for the code, Face ID changed, the 24-hour reset, wrong codes, Ask Again, hidden names and Reminder Says.
  - [ ] Build, then check on the iPhone (U9): every door through the lock, drafts kept, Stolen Device Protection.
    Built by Claude on branch `app-lock-privacy-security` from 9 Oct 2026 (the prompt in the user's 8 Oct request). Each
    sub-point is ticked with its commit and GitHub run once built and tested on GitHub; the iPhone check is noted
    separately (W1).
    - [x] 58.1 Baseline speed run of `main` before any change (S2): Today, widgets, the menu, the habit form. Run
      37871921866 on `main` @ 4543c68 (9 Oct 2026; `ci-results` runs/2026-10-09-0243-main-4543c68.md).
    - [x] 58.2 Menu: Privacy becomes **Privacy & Security** (row, title, subtitle); the Widgets row and page go; each of
      its parts moves (spec §1, U5); a widget's Choose a habit link opens Help → Widgets → "Choose a habit for a widget";
      `widgets_settings` is no longer sent; Design Rules' menu line updated.
      **Done (tests on GitHub; iPhone check pending):** TodayUITests.testMenu and WidgetUITests (run 37903473973), AppLockUITests.testWidgetChooseLinkOpensHelp (run 37903470666).
    - [x] 58.3 App Lock: Unlock With (iPhone passcode / Often Enough code, Keychain this device only, salted slow hash);
      Face ID changed → code → "Use Face ID again?"; Forgot Code? (Face ID at once, else the 24-hour reset with Cancel
      Reset and its notification); wrong-code waits 1, 5, 15 min, 1 h; Ask Again (Immediately / 1 / 15 min); locking the
      iPhone locks the app at once; every way in waits for the unlock.
      **Done (tests on GitHub; iPhone check pending):** AppLockUITests 12/12 (run 37903470666), `-applockcheck`, the lock keypad and code sheets on the iPhone SE (run 37905189350). Testing found and fixed: the test Face ID panel's taps were lost (T16), "Use Face ID again?" never showed, the cover sat under sheets (now its own window; locking ends typing), and a sheet could outlive the cover.
    - [x] 58.4 Hide Names Outside the App (replaces Hide widget content, stored choice migrated; held on by App Lock):
      discreet widgets whose taps still log, once each, in order (U28 say-so for decisions 1 and 4 only); reminders
      ("Reminder says…" words / "Reminder · 8:00" / "3 reminders · 8:00" / "Still open · 8:00", "+1", placeholder
      "Reminder"); alarms; the timer's Live Activity; Siri and Shortcuts.
      **Done (tests on GitHub; iPhone check pending):** `-applockcheck` (widgets, reminders, alarms, Siri, Live Activity), WidgetUITests 6/6 and WidgetSystemUITests (runs 37903473973, 37903470666), RemindersUITests 4/4; widget taps still log once each, in order, with names hidden (WidgetReliabilityCheck); Timer, Undo, Sync and Backup unchanged (run 37896911637).
    - [x] 58.5 Reminder Says: a habit field in the form's Reminders screen; Core schema 8 (column added only if
      missing, D2), `MigrationTest` from every past version, sync, backup and import round trip (D5, D12, D14); server
      checked (T6).
      **Done (tests on GitHub; iPhone check pending):** Core 63/63 (MigrationTest from every version, BackupTest, SyncTest), server 140/140 and typecheck, AppLockUITests.testReminderSaysIsSavedWithTheHabit (run 37903470666), the field on the iPhone SE (run 37905189350).
    - [x] 58.6 Help & Feedback: the Widgets section and the Privacy & Security topics (spec §4).
      **Done (tests on GitHub):** AppLockUITests.testWidgetChooseLinkOpensHelp, WidgetUITests.testGuideAndPrivacyAreFree.
    - [x] 58.7 Tests: a new App Lock UI class (test-only lock with a fake authenticator, own Keychain service, D8);
      `-applockcheck`; widget tests rewritten for discreet cards (T3); PerfDriver scenarios for Privacy & Security and
      the keypad (T4); small screens (T15).
      **Done:** AppLockUITests (new), `-applockcheck`, widget tests for discreet cards, PerfDriver `privacy` and `lock-keypad`, SmallScreenUITests (3 new).
    - [x] 58.8 Regression set and a full speed run compared with 58.1.
      **Done:** every touched class green on GitHub (runs 37896908831, 37896911637, 37896915259, 37903470666, 37903473973, 37905189350); full speed run 37900900842 against 58.1, and the slower-looking Today scenarios run side by side with `main` (37892222401 / 37892225073): same work, no regression (PERFORMANCE-LESSONS, 9 Oct).
    - [x] 58.9 (the user, 9 Oct 2026, with a screenshot) Today's after-log line: a checklist step's Undo named the step
      ("Undo Bsbsbbsbsbsbdbsbdbbdbdbd") and pushed Add Note off the row. A step's Undo is now **"Undo Last Step"**
      (Today's line, swipe, touch-and-hold menu and the routine player; Day details' per-log Undo still names its step
      for VoiceOver); the line is offered the row's width, Add Note keeps its size and Undo shortens with … rather than
      pushing anything out, for every habit type (amounts with long units too); the quit row's Undo Slip line follows
      the same rules. Checked on the iPhone SE at the largest text size that shows words (`SmallScreenUITests.
      testAfterLogLineStaysInsideTheRow`).
      **Done (tests on GitHub; iPhone check pending):** SmallScreenUITests.testAfterLogLineStaysInsideTheRow on the iPhone SE at the largest text (run 37905189350: "Undo Last Step" and "Undo +1 tablespoon" whole, Add Note as its icon), TodayRowLayout/RoutineCalendar/FocusPlayer (run 37896908831).
    - [x] 58.10 (the user, 9 Oct 2026, with two screenshots) **Backup & Export redesigned from research.** Today it's
      one long list (status, Where "Your account (our server)", iCloud switch, Back Up Now, Restore…, Move to Another
      Device, Save a Backup File, Export a Spreadsheet, a paragraph, a Sync row that only says "On"), with no grouping or
      order, Restore lost in the middle, the jobs' differences unclear and text explaining the UI. The user's points:
      research how people think about backup, restore and export (reviews and the web), put the most important first,
      group by what people come to do, keep it native, **no paragraphs explaining the UI** ("if you're using a lot of text
      to explain things, the UI is bad"), never "our server", and a Sync row only if it can be changed (otherwise it
      goes). Explain how the nightly backup and iCloud fit, without text walls.
      **Done (tests on GitHub; iPhone check pending):** report "Backup & Export and Your Account — What People Look For" (897,899 reviews screened, 829 hand-coded); BackupUITests 10/10 (run 37923643875), with Sync, Today and Onboarding (run 37920022403); speed run 37900900842.
    - [x] 58.11 (the user, 9 Oct 2026) **Where the account lives.** Signing in, creating an account and signing out sit
      only inside Backup & Export. Research where people expect them (a menu row, the top of settings, Backup) and move
      or add them there; Backup keeps a link to what it needs from the account.
      **Done (tests on GitHub; iPhone check pending):** ≡ → Account (sign in, plan, Last Synced with Plus, devices, Sign Out, Delete Account); BackupUITests.testAccountInTheMenuAndMovingToANewIPhone and testDeletingTheAccountAndErasingThisPhone, SyncUITests on the dev server (runs 37908430043, 37920022403). The menu row was added at the user's request, changing the "final" menu.
    - [x] 58.12 (the user's review of the redesign, 9 Oct 2026) **Backup & Export, second pass.** (1) Without an account
      the habits are still backed up to iCloud, and the screen must say so, with iCloud's own state (full, off, a
      problem) shown clearly and tested. (2) Say why to make an account, simply: automatic backups every night, more
      reliable, stored safely and encrypted, and back on a new phone just by signing in; offer **Create Account**, not a
      bare "Sign In". (3) Never "Deleting the app deletes your habits" (wrong when there's an iCloud copy, and it makes
      people anxious): the honest limit of the free plan is **one device** (phone or tablet), with no sync between
      devices; moving to another device takes a backup file; syncing devices comes with Plus. Say it here or on the
      create-account screen. (4) Google Drive: Android has it; show it on iOS too if the research supports it.
      (5) No text walls. Research the plan facts first; claim only what's true (encryption, frequency).
      **Done (tests on GitHub; iPhone check pending):** iCloud shown without an account with its states (BackupUITests.testICloudWithoutAnAccount through `-test-icloud`, runs 37920022403, 37923643875), Create Account with four benefits, the one-device limit, no "deleting the app deletes your habits", Plus no longer claims an iCloud copy. Google Drive: not shown on iOS (no iOS Drive code; a separate build for the user to decide). The real iCloud needs the iPhone.
    - [ ] 58.13 (the user, 9 Oct 2026, with WhatsApp's App lock screenshots) **App Lock redesign.** Privacy &
      Security's App Lock block says what it's for and whether it's on; App Lock opens with one switch and shows its
      options only once it's on; turning it on first asks what opens the app if Face ID doesn't work, and explains
      the app passcode, a changed Face ID and the 24-hour wait in simple full sentences; one set of words ("the app",
      never "Often Enough"; "app passcode"); no Recommended badge; the security delay stays a fixed 24 hours.
      **Designed (Figma 935:309) and documented for building:** [App Lock Redesign — What to Build](<../Specs/App Lock Redesign/README.md>).
      To do: build it, tests on GitHub, iPhone check; then design the lock cover and recovery screens.
      - **The user's iPhone check, 10 Oct 2026** (with the Figma section 935:309): turning on Lock with Face ID asked
        for the iPhone passcode at once and turned App Lock on; no Set Up App Lock sheet (screen 3), no How your app
        passcode works (4), no passcode twice (5–6); the App Lock page then showed only the switch and Lock Again (not
        screen 7). The user expects exactly the Figma flow: Face ID first, then the iPhone passcode; the choice of a
        separate app passcode; how it works; the six digits twice; then on.
        - [x] Cause found: Face ID is switched off for the app in the iPhone's Settings (Face ID & Passcode → Other
          Apps: listed, off). The code took "Face ID not allowed for this app" for "this iPhone has no Face ID", so it
          took the passcode-only path (skip the sheet, hide If Face ID doesn't work). Branch `app-lock-face-id-off`.
        - [ ] Fix: an iPhone with Face ID set up always gets the Figma flow (3 → 7), whether or not the app is allowed to
          use it; while it isn't, the App Lock page says so and opens Settings; an app passcode set then lets Face ID
          back in with Use Face ID Again once it's allowed. *Built 10 Oct (`AppLock.Ability.biometricsAllowed`,
          `faceIDNotTrusted`, Allow Face ID in Settings; the Face ID permission text now says "the app"); installed on the
          iPhone 16 for the user's check; GitHub tests not run yet.*
        - [ ] A test for it (`-test-face denied`), tests on GitHub, then the user's iPhone check (U9).
      - **The user's model for App Lock, 10 Oct 2026** (after the check above; "first let's create those missing designs
        in the Figma … do some research, figure it out; if they are okay, then update the designs"). Each point:
        - [ ] Never show "Lock with Face ID" (or a switch that reads as on) when Face ID can't be used: say plainly why,
          for each case: **Face ID not allowed for the app in Settings** ("can't be turned on, it isn't allowed in
          Settings"), **Face ID not set up on this iPhone**, **no iPhone passcode at all**.
        - [ ] Never lock straight away with the iPhone passcode: always ask first.
        - [ ] **People choose their everyday way to unlock:** Face ID (the default), iPhone Passcode, or App Passcode.
        - [ ] **An app passcode is always created** (the answer "Always"), whichever way is chosen: with Face ID or the
          iPhone passcode it's the backup, asked whenever anything changes (Face ID changed, the passcode removed).
        - [ ] **App Passcode as the everyday way:** Face ID and the iPhone passcode play no part; forgot it → only a
          24-hour security delay, then a new one. No data is ever lost.
        - [ ] Face ID or iPhone passcode as the everyday way, and Face ID doesn't work or changed: the iPhone passcode
          can reset the app passcode; if the passcode doesn't work or isn't there, the 24-hour delay alone.
        - [ ] **An iPhone with no passcode:** App Lock still works, with the app passcode only (and the 24-hour delay).
        - [x] Research whether these assumptions hold (W2), say where they don't, then draw every missing scenario in
          Figma beside section 935:309 and update the spec. Building waits for the user. *Done 10 Oct 2026:
          [App Lock — Choosing How to Open the App](<../../../Research/Research Reports/Settings and Help/App Lock — Choosing How to Open the App.md>)
          (all seven hold; iOS can't ask for the passcode alone, and never reports a changed passcode; the Face ID
          way's iPhone-passcode reset keeps the 24-hour wait, for the user to confirm). Figma
          [1003:309](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=1003-309): 23 screens (A1–A8
          setup in every state, B1–B5 the page per way, C1–C6 the lock screen, D1–D4 Forgot). The spec points to it.*
        - [ ] The user's review of the Figma round, then rewrite the spec and build (replaces the 10 Oct quick fix's
          screens). **The user, 10 Oct 2026:** the 24-hour delay stays as the App Lock report says (it only makes sure
          the owner notices; nothing can stop everyone). "Implement all of this and then test it thoroughly on the
          iPhone": setting the passcodes, every option, the 24-hour delay; a thorough hunt for bugs and flaws, not
          random tapping.
          - [x] Built (10 Oct 2026, branch `app-lock-face-id-off`, not committed yet): the everyday way (Face ID,
            iPhone Passcode, App Passcode), the app passcode always made, every Face ID / passcode state (A1–A8, B1–B5,
            C1–C6, D1–D4). Found and fixed while building: a Face ID lock-out was shown as "turned off in Settings"; a new
            app passcode after a reset re-trusted Face ID by itself; a dimmed row faded its reason; the self-check made
            its widget snapshot in UTC (failed on an iPhone in India). Spec §0, Design Rules, Help updated.
          - [x] Tested on the iPhone (automated, the test Face ID stand-in): AppLockUITests **21/21** on the iPhone 16,
            final run 10 Oct 17:5x IST, after the layout fixes (every way, every state, switching ways, Change App
            Passcode, Forgot in each way, the 24-hour reset started / waiting at 23 h / cancelled / ready at 24 h,
            wrong-passcode waits, an older lock's upgrade, `-applockcheck`).
          - [ ] The user's own check with real Face ID and the iPhone passcode (U9): "Allow Face ID?", Face ID
            switched off in Settings, locking the iPhone, the reset notification.
          - [x] The passcode screens' layout (the user's report): the prompt and dots up, the keypad lower, the spare
            space shared evenly, keys 76 pt; the lock screen the same. Checked in iPhone screenshots.
          - [ ] Tests on GitHub (AppLockUITests, SmallScreenUITests on the SE).
          - [x] **The user's iPhone check, 10 Oct 2026: the "set a new passcode" screen** (Enter a six-digit passcode /
            Enter it again): the dots and keypad sit high with a lot of empty space below; the space isn't used, or
            something is too small. Fix the layout (after the test run), on every passcode screen (setup, Change,
            Forgot, the lock screen), checked on the iPhone 16 and the SE.
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

- [ ] **45. Screen Time: read a time limit from the iPhone instead of typing it.** Added 4 October 2026 from item 37's
  research ([Time Limits — Should Cut Down Allow Time](<../../../Research/Research Reports/Habit Creation/Time Limits — Should Cut Down Allow Time.md>)):
  about seven reviews want social media or screen time filled in automatically. Needs Apple's Screen Time API (Family
  Controls and Device Activity, with the person's permission), whose reports stay inside their own extension. Research
  what can be read and shown, then decide.

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

- [ ] **Lock only some habits** (from item 58, decision 5; moved here by the user, 9 Oct 2026). Lock single habits
  or a section instead of the whole app. Users show it strongly in notes apps (315 reviews want single notes locked) and
  weakly in habit apps (24, mostly diary sections):
  [App Lock and Widget Privacy — What People Expect](<../../../Research/Research Reports/Settings and Help/App Lock and Widget Privacy — What People Expect.md>) §6, point 5.
  Revisit if diaries or the Daily Reflection (item 12) arrive.

## Completed

- [x] **23. Restore streaks on the habit details page.** Added 4 October 2026; a standalone task, not a subtask of
  the header, Overall Record or milestone redesign.
  - The user reports streaks used to be visible on this page and were removed during the redesign. Check the earlier
    presentation and current code, then restore a clear, visible streak presentation.
  - Preserve the correct meaning for each supported habit and frequency; do not silently label weekly/monthly
    success as a daily streak. Record what was restored and verify its values against the existing streak logic.
  - This remains open even if another design item touches the same screen. Documentation does not confirm the
    regression has been reproduced or fixed.
  - **5 Oct placement research (item 48):** Current/Best belong visibly in the early individual habit Progress summary, not the common header above History/Notes; retain Today's quick streak access, correct units and Show Streaks. The six existing design studies now reflect that recommendation. This does not close the native implementation/correctness check in item 23.
  - **What was there (8 Oct):** the streak survived only as small grey text at the end of the Milestones card's "In a
    row" title ("Now 23 · best 23"): not a clear streak presentation.
  - **Built, 8 Oct 2026** (cloud session): the "In a row" track opens with **Current streak** and **Best streak** side by
    side (title 2 numbers, one VoiceOver element each), then "Next: 30 days in a row". The research's place (early in
    this habit's Progress, after Overall record; no new card, nothing in the header). Units follow the goal: days for a
    daily habit, weeks for a weekly goal, months, or times for a selected-days habit (the store's existing `streakUnit`).
    Values come from `runs(of:)`, the same walk as Today's `streak` and the best streak, so they agree. Show Streaks off
    hides the pair, "In total" stays; quit habits keep their run in Overall record; tasks have no Progress tab.
  - [x] **Tested on GitHub, 8–9 Oct 2026:** run `37860896648`, 13/13: `HabitPageUITests` (with the new
    `testStreaksOnTheProgressTab`: Water "23 days" / "23 days", Running "2 weeks" / "11 weeks", Show Streaks off shows
    none) and `ProgressUITests.testHabitPageYearAndMilestones`; pictures `hp-streaks-water|running|off` and the dark
    pages. Speed run of the habit page in the same run. **iPhone look (U9): still to do.**

- [x] **31. Improve Week, Month and Year card padding and spacing.** Added 4 October 2026; review the main Progress
  page and the habit details Progress tab wherever these period cards appear.
  - **Week:** the “Week” heading is almost against the card's top edge; the top padding is too small and looks poor.
    Increase the breathing room above the heading and improve spacing between the card's internal elements.
  - **Month:** the same top-edge/padding concern applies. Review both heading inset and the spacing of the content.
  - **Year / Year in Pixels:** improve spacing and hierarchy here too, so the card/grid and its labels feel balanced.
  - Apply consistent spacing rules across the period cards, adapted to their content. Check card boundaries,
    heading-to-content gaps and internal alignment, not only one top padding value. Preserve statistics and square
    meanings. Verify on the iPhone, including larger text and light/dark mode.
  - Keep the accordion behavior (item 25), all-date labels (item 32), Overall Record and Milestones separately tracked.
  - **What it was (8 Oct):** on the habit page's Progress tab, the period cards' header (`PeriodHeader`) had a `-8`
    vertical padding so its 44-pt ‹ › fitted: it pulled "Week", "Month" and "Year in Pixels" up against the card's top
    edge. Progress's own cards were already 16 all round (checked in the run's pictures), so they're unchanged.
  - **Built, 8 Oct 2026** (cloud session): the header keeps the card's whole 16-pt top padding (the ‹ › still reach the
    edge); every gap between a card's parts stays 16, smaller only inside a part (headline and detail 4, a chart's title
    and chart 8); Year in Pixels 12 at the sides (twelve columns on the SE), now 16 above and below. Design Rules,
    "Habit details: Progress tab cards".
  - [x] **Tested on GitHub, 8 Oct 2026:** run `37853078424`, `HabitPageUITests` 10/11 with the new
    `testPeriodCardSpacing` (pictures `hp-cards-light|dark|large-text-habit-progress-week|month|habit-year-grid`: each
    title about as far from the card's top as from its side, in all three); the 11th, `testNotesFlows`, never started
    (XCUITest couldn't terminate the previous test's app), and passed on the rerun, run `37858625841` (2/2). Speed in
    the same run: habit page Progress scrolling 0.1 ms/s, switching tabs 8.4. **iPhone look (U9), larger text and dark:
    still to do.**

- [x] **32. Year in Pixels: show every day-number label from 1 through 31.** Added 4 October 2026.
  - Currently only selected numbers such as 1, 5, 10, 15, 20, 25 and 30 are shown. The user wants all day numbers
    visible: 1, 2, 3 … 31, including the currently omitted dates and 31 itself.
  - Keep the labels aligned with the correct day rows/squares and readable. Coordinate the layout with the spacing
    work in item 31; do not satisfy it by crowding or overlapping labels.
  - Preserve the correct treatment of shorter months and leap years; showing row labels 1–31 does not make an
    invalid date a recorded day. Review every relevant Year in Pixels instance in Progress and habit details.
  - Verify all 31 labels are present and that existing values, square meanings and accessibility remain correct.
  - **Where it is (8 Oct):** Year in Pixels (month columns by day rows) is on the habit page's Progress tab
    (`HeatYearPixels`); Progress's own Year view is a different map (weeks by weekdays, one per habit) with no day rows.
  - **Built, 8 Oct 2026** (cloud session): every number 1–31, one per 27-pt row, right-aligned 4 pt before the squares
    (caption 2, monospaced digits); the labels stop growing at the xLarge text size, where "31" still fits the gutter
    and each month name its column (the squares never grow). Days a month doesn't have stay empty.
  - [x] **Tested on GitHub, 8 Oct 2026:** run `37847053285`, `HabitPageUITests` 10/10 with the new
    `testYearInPixelsDayNumbers` (pictures `hp-year-days-light|dark|large-text-1-top|2-middle|3-end` in the run's
    `ios-screenshots`: every number beside its row, readable, none overlapping). Speed run of the habit page in the same
    run (Progress scrolling 23.2 ms/s; 7.9 in run `37836789385` with the same change: machines vary, L29). Found and
    fixed on the way: a tab tap lost on a busy simulator (the test now checks the tab switched) and Add note's
    keyboard that never came when the sheet's slide outlasted 350 ms (it asks again until the field has it; Add note
    typing 8.6 ms/s). **iPhone look (U9): still to do.**

- [x] **74. A test launch on a real iPhone writes its demo habits into the widgets and resets the person's settings.**
  Added 8 October 2026 by Claude (Claude Code), from item 65's finding (the user listed it, 8 Oct). A `-uitest`
  launch on the iPhone publishes its demo habits into the widgets' shared file (the person's Home Screen widgets then
  show the demo habits) and resets some of the person's own settings (Hide Completed, done order), because test
  launches share `UserDefaults` and the App Group with the person's app. D8: a test launch never touches the person's
  data. Keep a test launch's widget snapshot and settings separate from the person's, and prove it with a test.
  - **Also found (8 Oct):** a test launch saves widget taps waiting in the shared file at start-up (`saveWidgetTaps`): on
    the iPhone it would have saved the person's waiting taps into its throwaway in-memory database, then removed them
    from the file. And `-dbname habits -reset-db` (WidgetSystemUITests) names the person's own database.
  - **Built, 8 Oct 2026** (cloud session): `WidgetDisk.directory` gives a `-uitest` launch an App Group folder of its own
    (`uitest/`), so its snapshot, waiting taps, timing log, paging and analytics files never touch the person's; the
    widget extension and ordinary launches are unchanged (no W1–W17 decision changed; noted in the locked widget doc).
    `TestLaunchIsolation` holds the person's `UserDefaults` aside on the first test launch in a row and puts them back,
    exactly, on the next ordinary launch, before anything reads them; test launches still reset their own (T8).
    `-reset-db` never deletes "habits" on a real iPhone. Rulebook D8.
  - [x] **Tested on GitHub, 8 Oct 2026:** run `37831649390`, 24/24: the new
    `TestLaunchIsolationUITests.testATestLaunchLeavesThePersonsWidgetsAndSettings` (an ordinary launch turns Hide
    Completed on; a `-uitest` launch starts with it off and logs; the next ordinary launch finds the same widget habits,
    by ID, and Hide Completed still on), with `WidgetUITests`, `ArrangeUITests`, `TodayUITests` and `PersistenceUITests`.
    The test wasn't run against the old build (it would publish over the person's file and reset the switch, by the
    code it replaced). **iPhone check:** run any UI test on the phone, then open the app: the Home Screen widgets show
    your own habits and your Today settings are as you left them.

- [x] **28. Notes: research the Add Note button's placement.** Added 4 October 2026; separate from History actions.
  - In the habit details Notes tab, Add Note is currently near the top beside the search field, in the upper area
    the user describes as just below the progress bar. Assess whether it should stay there or move to a sticky
    bottom action instead.
  - Research a native, discoverable and easy-to-reach arrangement that preserves search and note browsing. Check
    scrolling, safe-area spacing and keyboard behavior; a bottom action must not obscure notes or search results.
  - Record the recommended placement before implementing it. The user has asked for research rather than deciding
    that both History and Notes must use bottom controls.
  - **Built, 5 Oct 2026, with item 26** (branch `claude/timer-swipe-limits-and-fixes`): the 4 Oct handoff's
    recommendation (no sticky bottom bar; search across the full width, Add Note on its own row under it), at the
    user's request that Add Note match History's buttons. Tests: pending (`HabitPageUITests.testNotesFlows`).
  - [x] **Tested on GitHub** (run `37826155392`, 8 Oct 2026): `testNotesFlows`, `testNotesFoldByMonthLikeHistory` and `testNoteViewEditAndDelete`
    passed. iPhone check (U9): still to do.

- [x] **26. History: fix the unreadable Add Entry button.** Added 4 October 2026; a readability issue independent of
  the action-placement research in item 27.
  - The user observes a white/light-gray button background with white text, making Add Entry illegible. Verify the
    current rendered appearance and fix the contrast in the actual button states.
  - Check light and dark mode and the real iPhone; the label must stay readable. Preserve the action's function.
    Moving the button to another location alone does not fix its text/background contrast.
  - Add Entry is appropriate in History; the user explicitly distinguishes this from the Today sheet problem in
    item 22. Do not solve this by removing History's Add Entry action.
  - **The user's words, 5 Oct:** "Apart from being unreadable, they look a little big: they aren't primary actions,
    they're secondary. People use them rarely, but for those who do, they should be good."
  - **Built, 5 Oct 2026** (branch `claude/timer-swipe-limits-and-fixes`; checklist [Completion Sound, Squares Key and
    Notes Months — 5 Oct](<Completion Sound, Squares Key and Notes Months — 5 Oct.md>) §5): the cause was Add Entry's
    filled style, white text on dark mode's off-white ink. Add Entry and Go to Date are now native bordered buttons at
    their own width (ink text on a light ink tint, readable in both modes), regular size; Notes' Add Note the same.
    Then (the user, 5 Oct: "Add Note was bigger than a cramped search bar; do we need search there or a full-page
    search?"): Notes keeps an inline search, now across the full width, with Add Note on its own row under it, one
    shared button style with History. Tests: pending (`HabitPageUITests.testHistoryFlows`, `testNotesFlows`, the
    dark pictures).
  - [x] **Tested on GitHub** (run `37826155392`, 8 Oct 2026): `HabitPageUITests` 10/10, `testHistoryFlows`, `testNotesFlows` and
    `testPicturesDark` included. The dark and light pictures show Add log and Go to Date (the 7 Oct names, U21) as
    readable bordered buttons at their own width, and Add note on its own row. iPhone check (U9): still to do.

- [x] **25. “What the squares mean”: expand automatically only on the first visit to each explanation context.**
  **Superseded by item 57 (the user, 6 Oct 2026): one app-wide state, folded everywhere once folded anywhere.**
  Added 4 October 2026; a standalone behavior task covering both the habit details page and the main Progress page.
  - **First visit:** the accordion must already be open when the person first opens the particular habit's details
    page and reaches its explanation, so the meaning of the squares is visible without discovering an extra tap.
  - **Main Progress:** apply the same behavior to the first visit to Week, Month, Year, and any other relevant view
    with this explanation. Seeing Week's explanation must not incorrectly suppress a first-time explanation in
    Month or Year; seeing one habit's explanation must not consume another habit's first visit.
  - **Later visits:** once the person has seen that explanation, start it collapsed on subsequent visits. They can
    manually expand it whenever they want. Leaving it open once must not make it default to open forever.
  - Record first-view state across normal navigation and app relaunches. Switching dates/periods or rebuilding a
    view is not a new first visit. Do not automatically collapse it immediately during the first visit; the request
    is to change the default on the next visit.
  - Use the exact context of the explanation when implementing this: the applicable habit page or Progress view.
    Cover every instance of this accordion, and document the state scope so it does not repeat unexpectedly or
    stay closed for a context the person has never seen. Reset/reinstall and cross-device state policy was not
    specified by the user.
  - Verify first visit open → next visit closed → manual reopening works, independently for the relevant habits
    and Progress ranges. This task must remain separate from card padding and other visual redesigns.
  - **The user's words, 5 Oct:** "It should be open only for the very first time; everywhere else, closed."
  - **Built, 5 Oct 2026** (branch `claude/timer-swipe-limits-and-fixes`; checklist [Completion Sound, Squares Key and Notes Months — 5 Oct](<Completion Sound, Squares Key and Notes Months — 5 Oct.md>)): open by
    itself only on the first visit to each habit's page and each Progress range; folded on later visits, a tap opens
    it, never folds during a visit; kept across launches. Tests: pending.
  - [x] **Closed by item 57** (one app-wide state replaced the per-place rule); its tests passed on GitHub (run `37826155392`, 8 Oct 2026):
    `HabitPageUITests.testSquaresKeyFoldedOnceIsFoldedEverywhere` and `WeekCardsUITests.testSquaresKeyFoldedOnceIsFoldedEverywhere`.

- [x] **18. Completion feedback for every kind of habit.** (added 3 Oct 2026) A check-off plays the sound (and haptic)
  when it's done, which is nice; timed habits, amounts, checklists and others don't. Decide when each kind counts
  as "done" for feedback (goal reached, timer reaches its goal, last step ticked) and make it consistent.
  - **The user's words, 5 Oct, tidied:** "Overall completion only: the 4th of 4 steps; the log that crosses an amount
    of 10, even to 11; the same for time, typed time included. Never for quit habits or Log Slip."
  - **Built, 5 Oct 2026** (branch `claude/timer-swipe-limits-and-fixes`; checklist [Completion Sound, Squares Key and Notes Months — 5 Oct](<Completion Sound, Squares Key and Notes Months — 5 Oct.md>)): the store
    decides for every log from any screen; once, on the log that makes the habit complete; a running timer at its
    goal; never for quit habits or limits. Tests: pending (`CompletionFeedbackUITests`).
  - [x] **Tested on GitHub** (run `37826155392`, 8 Oct 2026, cloud session): `CompletionFeedbackUITests` passed on the current branch (`main` plus
    items 49 and 53). iPhone check (U9): hear and feel each kind complete once.

- [x] **49. Speed: Today, the habit form and Progress got slower on `main`.** Found 5 October 2026 by the full test of
  `main` the user asked for (speed run `37310572002` on `d403844`), against the last full speed run before the day's
  merges (`claude/habit-details-perf`, 4 Oct; hitch ms/s, targets under 5): Today scrolling 0 → 28; +1 alone 1–3 → 25;
  day ‹ › alone 30–63 → 116; habit form typing 8–9 → 45 (a 496 ms freeze); Progress period ‹ › 50–125 → 164; menu
  47–114 → 54. Hosted runs vary 2–3×, so repeated before blaming anything (S2).
  - **Not from the Day-details merge:** three runs each of `main` just before it (`3530e98`, the timer/swipe/limits
    branch) and after (`c09cdb9`): Today scrolling 18/64/44 vs 41/23/23, day ‹ › alone 119/99/92 vs 162/51/59, +1 alone
    4.4/1.6/1.8 vs 15.5/5.5/3.4, Day sheet scrolling 36/20/44 vs 14/7/8; habit form 32 vs 30, Progress 163 vs 165 (runs
    `37324688193`, `37330377255`, `37330449077` vs `37324703983`, `37330393173`, `37330464579`).
  - **So the change came with the timer/swipe/limits/completion-sound merge.** To do: bisect its commits with the
    scenarios above (Today `scroll-today`, `tap-today`; `new-habit`; `progress`), fix, and measure on the iPhone.
  - **8 Oct 2026 (cloud session): side by side in one job** (new `ios-perf-bisect.yml`, `Tools/perf/bisect_perf.sh`: each
    commit built in the same job, every scenario run on each in turn, two rounds, rotated order; run `37774018835`).
    Median hitch ms/s, base `396c40e` (4 Oct) / end of timer-swipe-limits `c9909e6` / `main` `e3afd6c`: Today scrolling
    12.6 / 27.6 / 11.3 (each variant's first round carries the first-scroll freeze; second rounds 5.2 / 7.7 / 4.9);
    habit form typing 14.2 / 18.8 / 15.8; Progress period ‹ › and range 107.5 / 128.5 / 93.1; day ‹ › alone 59.8 /
    87.8 / 73.5. **So scrolling, typing and Progress are not slower on `main` than on 4 Oct**: the 5 Oct numbers were
    separate runs on different machines (L22). **What is slower: the +1 tap** (+1 alone 1.5 / 3.4 / 15.5; +1 and day
    ‹ › 62.3 / 83.7 / 123.8), and it came after `c9909e6`. Next: bisect `c9909e6..e3afd6c` with `tap-today`.
  - **Second bisect** (run `37788595991`, `tap-today`, three rounds): base `396c40e` / `3530e98` (completion sound) /
    `a3d33bf` (6 Oct week goals) / `84d42ef` (7 Oct redesign) / `main`: +1 alone 3.6 / 2.6 / 1.1 / 1.2 / 1.1 (so the first
    run's 15.5 was one bad round); +1 and day ‹ › 54.5 / 53.1 / 55.4 / 57.0 / **115.6**; day ‹ › alone 59.4 / 65.5 / 62.9 /
    61.5 / 90.7. Only the last commit, `e3afd6c` (widget taps, 8 Oct), differs. Its timed work showed 14 widget
    publications inside the window (0 before): the locked delay went from 2 s to 0.5 s (W11), and a cycle of +1, ‹, ›
    takes 1.05 s.
  - **Third** (run `37797217908`, a speed-run switch `-perf-no-widget-publish` beside `main`): +1 and day ‹ › `84d42ef`
    52.0 / `main` 95.2 / `main` without publication 103.8. **So the publication isn't the cost.** The same binary with
    and without the switch also measured habit-form typing 57.5 against 22.6 and Progress paging 148 against 111 in
    scenarios where no publication happened at all: on that machine, identical work varied 2.5×. Two rounds aren't
    enough to judge a 2× difference; the next run takes four.
  - **Fourth, four rounds** (run `37804587883`, `tap-today`; a slower machine, every number ~2.5× the earlier runs):
    +1 and day ‹ › base 159.1 / `84d42ef` 159.2 / `main` 181.6 (`main`'s rounds 138–191, base's 139–174); day ‹ › alone
    141.0 / 145.8 / 128.8; +1 alone 6.8 / 11.3 / 8.7. **Nothing has got slower since 4 Oct.** The 5 Oct numbers compared
    runs on different hosted machines (lesson L29; Rulebook S2 now says a regression is called only from builds measured
    in turns in one job, four rounds or more).
  - [x] **Done 8 Oct 2026** (cloud session): no app code to undo; the bisect tool (`ios-perf-bisect.yml`,
    `Tools/perf/bisect_perf.sh`) and the speed-run switch `-perf-no-widget-publish` stay for the next time. Runs
    `37774018835`, `37788595991`, `37797217908`, `37804587883`. **Still above the targets on every build, 4 Oct's included**
    (not a regression; listed under "Open" in `PERFORMANCE-LESSONS.md`): Today's day ‹ ›, habit-form typing at a letter
    every 50–80 ms, Progress's period and range switch, Today's first scroll. **iPhone speed check: still to do**
    (`measure_perf_device.sh`; the phone has the final word, and on 2 Oct it measured the day switch with +1 at 40 ms/s and
    Progress's switch at 110).

- [x] **9. Widgets: choose the habit, one widget per habit, and a visual overhaul.** Widgets work (free and Plus
  kinds), but adding a widget always shows one particular habit: there's no way to pick which habit, switch to
  another, or have, say, 4 of 6 habits on the Home Screen, one widget each. Make each widget configurable (pick the
  habit, or the habits for a bigger widget), and improve how widgets look: "right now they are not good". A widgets
  agent is starting on its own branch (2 Oct).
  - **5 Oct research/design handoff:** [Start here — dedicated widget package](<../../../Research/Research Reports/Home Screen and Visual Design/Home Screen Cards and Widgets/Widgets/README.md>) includes the detailed study, implementation handoff, 181 verified originals, two annotated boards and 26 individual renders (28 PNGs); [detailed request/publication audit](<Widgets — Research and Figma Brief — 5 October 2026.md>). New [Free](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=509-3114) and [Plus](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=509-3116) Figma sections. The user requested documentation/images publication to main. **Proposal awaiting review; this item stays open.** Current source has an Edit Widget picker and independent UUID selection, so first reproduce the reported default/picker issue on the installed iPhone. Five unarchived habits is an at-a-time allowance, not weekly; tasks are unlimited. Proposed free named lists/individual/Lock widgets; Plus compact favourites and history. Historical aggregate attributed, missing full coding map disclosed. No app changes or CI dispatch; native build, accessibility, purchases, performance and iPhone acceptance remain pending (W1/U9).
  - **5 Oct daily-card follow-up:** [Daily Cards package](<../../../Research/Research Reports/Home Screen and Visual Design/Home Screen Cards and Widgets/Widgets/Daily Cards/README.md>) and [full request checklist](<Daily Widget — Layout and Actions — 5 October 2026.md>): one new [Today-only Figma section](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=537-2981), 29 base scenarios plus weekly/monthly scope examples, four timed-limit states and a paused quit example, 40 renders, 37 source-verified originals and exact CTA/timer/checklist contracts. Layout audit: 16-point equal insets, no sample progress-value overflow, targets at least 44 points. Existing snapshots can use period aggregates; binary uncheck, full timer intents and explicit input routes need implementation. Research/design proposal only; no app changes or CI dispatch, iPhone/native acceptance pending (U9/U25). Item 9 remains open.
  - **5 Oct user revision:** fully quit now shows one emphasized live elapsed line under its own name, with Best/Since context and only Record a slip. Limits have legible Daily limit / Limit reached / Over the limit captions; Social media max 20 minutes includes four timer states. Weekly/monthly subtitles show configured goals, with today’s contribution separately. [Focused Figma review](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=560-4241); [revision research](<../../../Research/Research Reports/Home Screen and Visual Design/Home Screen Cards and Widgets/Widgets/Daily Cards/Quit, Limits and Period Goals — Revision.md>). Refreshed main `f0e52f46` and latest 15 commits audited. App source unchanged; native live formatting, accessibility and iPhone acceptance remain open under U9/U25.

  - **5 Oct Today-list size/sections research:** [Today List handoff](<../../../Research/Research Reports/Home Screen and Visual Design/Home Screen Cards and Widgets/Widgets/Today List/README.md>) and [request checklist](<Today List Widget — Size and Sections — 5 October 2026.md>). Native fixed-window behavior, configurable lists and version-scoped first-party examples; nine re-read verified iOS originals. Recommends Large first, Medium companion, preserved app order, compact section context, All Today/one-section selection and explicit overflow. Current snapshot lacks section metadata, puts tasks after habits and shares paging for equal configurations. Recommendation awaiting review; no runtime/Figma changes or CI dispatch. Item 9 remains open (W1/W2/U9/U13).

  - **6 Oct accepted Large/CTA designs:** [Final Large Today package](<../../../Research/Research Reports/Home Screen and Visual Design/Home Screen Cards and Widgets/Widgets/Today List/Large Designs — 6 October 2026/README.md>) delivers progress-filled rows only, at most five items/page, 12-point separation, header paging above five and stable final-page positions. Plain/six-row drafts removed from the active section. Six/twelve/sixteen items use 5+1 / 5+5+2 / 5+5+5+1; optional section and honest ongoing counts retained. Sixteen scenario components, 18 review instances, 20 final PNGs; [Large checklist](<Large Today Widget — Plain and Filled Rows — 6 October 2026.md>). [CTA correction](<Widget CTA Colors — Match Today Rows — 6 October 2026.md>) updates both widget families to neutral system-fill/ink until completion, then habit main color/white, with 40 refreshed daily PNGs. Saved audits/image checks pass; real-device interaction, sizing/accessibility and implementation remain open. No native code, CI dispatch, commit or push in this phase (W1/U9/U25). **Item 9 remains open.**

  - **6 Oct Medium Today designs:** [Medium Today / selected-section package](<../../../Research/Research Reports/Home Screen and Visual Design/Home Screen Cards and Widgets/Widgets/Today List/Medium Designs — 6 October 2026/README.md>) and [request checklist](<Medium Today Widget — Today and Selected Section — 6 October 2026.md>). New [Figma section](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=622-6436): progress-filled rows, two items/page, 12-point row separation and compact header paging; Today, Morning/Anytime/Evening/custom/quit-section and recovery/large-text examples. Twenty-one scenario components, 24 reviews and 26 PNGs. Saved audit checks 35 rows and 77 header/action regions: no clipping or target overlap; completed fills and exact +500/pause/checklist actions verified. Larger text reduces capacity to one. Large/small designs preserved; native section configuration/routes, paging isolation, WidgetKit sizing/accessibility and iPhone acceptance remain open. No runtime changes, CI dispatch, commit or push in this phase (U9/U25/W1). **Item 9 remains open.**

  - **6 Oct final Small / consolidated publication:** [Widgets — start here](<../../../Research/Research Reports/Home Screen and Visual Design/Home Screen Cards and Widgets/Widgets/README.md>) now owns all widget reports, original evidence, current family handoffs and images. [Final Small correction](<../../../Research/Research Reports/Home Screen and Visual Design/Home Screen Cards and Widgets/Widgets/Daily Cards/Final Typography and Recovery — 6 October 2026.md>) applies SF Pro **12 pt Medium** supporting labels throughout and adds six explicit setup/recovery cards to the current list; 42 Small cards/48 PNGs, Large 20 PNGs, Medium 26 PNGs, original catalogue 28 PNGs. Final audits distinguish Figma/artifact delivery from native implementation. [Final request checklist](<Small Widgets — Final Typography and Consolidated Handoff — 6 October 2026.md>). The complete documentation/images package is authorized for main publication; native build/tests and iPhone acceptance remain pending. **Item 9 remains open** (W1/U9/U25).
  - **6 Oct, Claude: designs finished and documented.** Build from [Implementation Spec — Every Widget](<../../../Research/Research Reports/Home Screen and Visual Design/Home Screen Cards and Widgets/Widgets/Implementation Spec — Every Widget.md>): Small (one habit, today; weekly/monthly now fill toward the period; limits a plain grey bar with "max"), Large and Medium Today lists (Today or any section; 5 and 2 a page), the new Medium one habit this week, Tasks Large and Medium (5 and 2 a page), and the Lock Screen (one-habit circle, today rectangle, inline). The user, 6 Oct: build everything with **no Plus restrictions for now**, and test it thoroughly. Parked: monthly and icon-only widgets. Native build, tests and the iPhone check remain.
  - **Built and tested, 6 Oct 2026, Claude** (branch `claude/widget-implementation-testing-ki9pva`; [build, test and
    merge checklist](<Widgets — Build, Test and Merge — 6 October 2026.md>)): every widget in the spec. Small one
    habit; Medium and Large Today lists (Today or any section, 2 and 5 a page); Medium and Large task lists; the weekly
    Medium; Lock Screen circle, rectangle and line. Edit Widget chooses a habit or a section by stable ID; lists keep
    Today's card order and the person's order; ✓ toggles the day, +N adds one saved step, ▶/⏸ run the same timer as
    Today (and its Live Activity); amounts without a saved step, steps, slips and checklists open their screen
    directly. No Plus restrictions (the user, 6 Oct). Tested on GitHub: `WidgetCheck`, the widget and app reliability
    suites and 36 UI tests in run `37525264513` (36/36: Widget, AppReliability, Today, Timer, Undo, Persistence,
    Analytics); the real Home Screen install, cold +1 and paging in `37530191993`; speed in `37530191993` (every
    widget scenario 0.0 ms/s, no freezes; the launch publication's projection 75 ms against `main`'s 123 ms).
    **iPhone check (U9): open** — the real Edit Widget picker, Lock Screen vibrant rendering, tinted and clear Home
    Screens, 20-pt squares, and whether ▶ from a Small widget opens the timer (`OpenURLIntent`).

- [x] **59. Day details: logs push the note and Skip today off the screen.** Added 7 October 2026, from the user.
  - **Symptom:** tap any habit or task row on Today → Day details. With two or three logs under "Today's logs", the
    note and Skip today are pushed below the bottom of the sheet and can't be seen without scrolling.
  - **Not the answer:** a sticky Skip at the bottom. Skipping isn't an action to encourage (the user); U15 keeps Skip
    and Undo skip in one place.
  - **Asked for:** a layout and placement fix, proposed in Figma first: copy one page into a new section and show a
    layout that looks good and solves this. The 4 Oct mockups were only a guide; the app built them natively.
  - [x] Proposal in Figma (one page, for the user's review), 7 Oct:
    [Day details · note and Skip always on screen](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=715-2286).
    The logs get a ceiling of 3 rows (up to 3 logs as they are; 4 or more: the 2 newest, then "All N logs ›" to the
    full list); one line per log (amount, time on the right; the source moves into the log's editor). Nothing pinned;
    status, buttons, note and Skip keep their order and spacing (U15, U17).
    **v1 doesn't fit:** Skip ends at 763 pt; the app runs on iOS 18, so the smallest screen is the iPhone SE (4.7-inch,
    a large sheet ≈ 637 pt tall).
  - [x] **v2, the user's points (7 Oct):** the two logging buttons in one row (or three together); the note merged
    into "This day", shown in one or two lines; Skip today kept at the very bottom; native to iPhone users; research
    it; design for the SE's height. Built in the same Figma section, at 375 × 637 pt: one This day card with status,
    Add 1 glass | Log manually in one row (same size, style shows priority, U16) and the note (two lines, tap opens
    the editor); logs at most 3 rows; Skip last, bordered, not pinned. Worst case (4 logs, two-line note): Skip ends at
    591 of 637 pt. Three buttons with Skip rejected: it makes Skip an equal choice beside logging, and three labels
    don't fit 343 pt. Moving the note above the logs changes U17 and the Day-sheet study's "note after day activity":
    update both if the user approves.
  - [x] **Spacing pass (the user, 7 Oct: "everything fits but it's squished"; the note may be one line):** toolbar →
    habit 14, habit → This day 24, This day → its logs 20, logs → Skip 28; 14 padding inside cards, 14 from the status
    to its buttons; the note one line. Worst case: Skip ends at 611 of 637 pt (26 pt to spare on the SE).
  - [x] **Adaptive spacing (the user, 7 Oct: "set a minimum and maximum spacing so it adapts to any screen"; one size
    above the SE):** the SE frame is the minimum; an iPhone 12/13 mini frame (375 × 752 pt sheet, 34 pt home
    indicator) shows the maximum. Min → max: toolbar → habit 14 → 18, habit → This day 24 → 32, This day → logs
    20 → 28, logs → Skip 28 → 36, habit row padding 12 → 14, This day padding 14 → 16, status → buttons 14 → 18, note
    padding 12 → 14, note lines 1 → 2. Fixed: 8 between buttons, 8 heading → rows, rows and buttons 44, 16 margins.
    Spare height grows every gap by the same share of its range, never past the maximum, then gives the note its
    second line; anything left stays below Skip (top-aligned, nothing stretched). Larger text uses the spare height
    first. Mini worst case: Skip ends at 675 of 752 pt (43 pt above the home indicator's strip).
  - [x] **The All logs page (the user, 7 Oct):** pushed inside the sheet from "All N logs ›"; back chevron only, as
    on Edit Log. Every log of the day, newest first, one line each (amount, time); header "WATER · 4 LOGS", footer
    with the total and what a tap does. A tap opens Edit Log; a several-times-a-day check keeps its own Undo. Title
    follows the Day details heading ("Today's logs", "Checks today", "Slips today", "Logs for Sat 4 Oct"). No swipe to
    delete (U14), no add button, no Close.
  - [x] **Documented and arranged (the user, 7 Oct):** every point from this session (items 59 and 60) is in
    [Day Details, Logs and Notes — 7 October Redesign](<../../../Research/Research Reports/Day Structure and Organization/Day Details, Logs and Notes — 7 October Redesign/README.md>);
    the note frames are gone from Figma. A new section,
    [Water · one habit, every screen, three sizes](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=727-2288),
    has a row per screen (Day details, All logs, Add log, Edit log) and a column per size (SE minimum spacing; mini and
    6.1-inch maximum). Other habits wait until Water is settled.
  - [x] **For whoever builds it (the user, 7 Oct):** the document opens with "Read this first": one habit only (Water);
    the Figma frames are the overall layout, not exact spacing (their toolbar almost touches the top); build native
    and adapt to the screen's height (one line of note on the SE; with three logs or fewer show them all, no "All logs"
    row); the spacing numbers are relative guidance. Pointers added to Design Rules' Day sheet section, the iOS docs
    index and the handoff README.
  - [x] The user's decision (7 Oct): build it, the brief for items 59–63
  - **Built and tested on GitHub, 7 Oct 2026, Claude** (branch `day-details-logs-notes-redesign`, commits `4314265`…`c9fd46b`;
    `main` moved to it by fast-forward at the user's request, "once everything passes merge it into main"). Store
    checks (`UndoCheck.logTimes`) and Debug and Release builds: run `37607280545`. Every UI class it touches, on
    `aa6ee1e`: DayDetails, Undo, TodayRowLayout `37624437284`; DayDetailsScreenshot, HabitPage, TodayRowSheet
    `37624441217`; FocusPlayer, RoutineCalendar, Timer, GoalFlow, Progress `37624444958`; HabitCreation, NewHabit,
    SmallScreen `37624448992`; HabitScenario, Today, CompletionFeedback, Schedule `37624451923`. The iPhone SE simulator
    (SmallScreen through the workflow's new `device` input): `37621197950`, `37630915783`. On `3ed6dc1` (Add log and Edit
    log above the keyboard on every iPhone): SmallScreen on the default iPhone, DayDetails, Undo and the reruns below:
    `37630910873`, all passed but `testEveryKindsAddScreen`, whose slow swipe left the keyboard up on the 6.3-inch
    simulator (a test gesture: the footer hides while typing by design); a drag across the keyboard, `c9fd46b`, passed
    in `37639195688` (its summary push to `ci-results` hit a GitHub server error; the result is from the job's log). Core's sync test of an edited log time passed. **Five timing-sensitive failures, none in code this
    branch changed, each passed on `main` and on its one rerun here (T2):** FocusPlayer `testFastNavigationNeverSlidesBack`
    (`main` `37615468119`, rerun `37615472311`), HabitCreation `testBigNumbers` and `testOtherTypes` (cut off at 60
    minutes; `37616765534`), HabitCreation `testDailyShapes` and `testMonthAndYearShapes` and FocusPlayer
    `testTimerPauseBackgroundAndSkipPreserveTime` (`main` `37630921147`, rerun `37630910873`); the same tests had failed on
    other branches before (2 and 4 Oct).
  - **Speed (S2), run `37624454758` against the last full run of `main`'s code (`a3d33bf`, 6 Oct):** typing in Edit
    log 0.0 / 0.3 ms/s (was the entry editor's 4.5 / 8.6); typing in Add log 1.7 ms/s, 36 ms longest (the Log sheet's
    10.7, a 126 ms freeze); Day details' add, edit and undo 90.8 / 126.2 ms/s (148.7 / 185.5); scrolling Day details 0
    (16.9); opening the log editor 118 / 185 ms (930 / 486) and a note 1169 ms (3347). New: Add log typing 0.4 (Water) and
    5.1 (Read), Add note 3.4, Edit note 2.0, All logs scrolling 0.0, the player's Day details opening 652 ms. Slower:
    opening Add log 1027 ms (the Log sheet's 429) and Edit log's first keyboard 864 ms (303 ms the second time): the
    launch's first keyboard on the hosted simulator (L18), judged on the iPhone.
  - [ ] **The iPhone check (U9), still to do:** light and dark, the largest text sizes, VoiceOver, and the SE, mini and
    6.1-inch sizes; on the SE with the largest text and the keyboard up, the note box and Add log's number (they scroll;
    the bottom button stays above the keyboard). Speed on the phone (`measure_perf_device.sh`): opening Add log and the
    first keyboard.

- [x] **60. Add a log and Edit a log: one screen, the number first, the same everywhere.** Added 7 October 2026,
  from the user. Starts with an amount habit (Water).
  - **Symptom:** the user doesn't like the current Edit Entry screen (Figma "Entry", node 638-14677) or the 4 Oct
    proposal (638-14683). Things aren't shown in order of importance. The History "Add entry" screens (638-15299)
    differ again.
  - **Asked for:** two screens, Add and Edit, with the same mental model (some controls differ). The amount is the
    main highlight. Delete is red text only, never a red button background. "Log manually" on Day details and
    History's Add entry open the same Add screen: adding is the same everywhere in the app, and matches Day details.
    The date matters: from Today it is today by default (Today, 7 Oct, selected); from History the day must be clear
    and choosable.
  - [x] Proposal in Figma: Add log and Edit log for an amount habit, 7 Oct, at the SE sheet size:
    [Add log and Edit log](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=722-2288). Same order on
    both: the habit with its date row (Add: "Today" beside a native compact date picker; Edit: the log's own day and
    time, read-only), then the amount as the main thing (60 pt between − and +, one quick amount per step, tap to
    type), then the day before → after ("4 → 5 of 8 glasses"). Edit adds "Delete this log" in red text on an ordinary
    row, last, asking first. Add replaces both of today's adding screens (Add Entry; Log Amount / Log Time) from
    Today's rows, Day details, History, the timer screen and the routine player. For the user to decide: the
    keyboard starts closed (Add Entry opens it at once today). If approved, U22's "accepted controls" change.
  - [x] **Typing first (the user, 7 Oct):** Add opens only from "Log amount manually" and History's Add entry,
    where people come to type an exact amount, so typing is the main experience, not − / +. The steppers are gone:
    the big number is the text field itself (56 pt, unit beside it, "2 glasses"); Add opens focused with the decimal
    pad up, as Add Entry does today. On the SE the amount card ends at 380 pt, above the keyboard at 421. Edit has
    the same field, keyboard down until the number is tapped (then selected, so typing replaces it).
  - [x] **Less squished (the user, 7 Oct):** the amount card is the field itself (no field inside a card), with
    "AMOUNT" as a header above it; the number 48 pt (was 56); the unit under the number, where it never moves as
    digits are typed (beside a centred number it slid sideways); the "4 → 6 of 8 glasses" line removed (it confused
    more than it helped). Gaps: toolbar → habit 16, habit card → AMOUNT 28, card padding 24/22. On the SE with the
    keyboard up, the footer ends at 377 and the keyboard starts at 421.
  - [x] Documented with item 59 (same document) and placed in the same Figma section: Add log and Edit log at SE,
    mini and 6.1-inch. With the keyboard up, Add's footer ends at 377 / 391 / 391 against keyboard tops of
    421 / 461 / 492.
  - [x] The user's decision (7 Oct): every habit type built together (item 62)
  - [x] Built and tested with item 59 (below it); the iPhone check (U9) open there

- [x] **61. Notes: adding, reading, changing and deleting a note, the same way everywhere.** Added 7 October 2026,
  from the user.
  - **Symptom:** the current note screens (Figma 638-15116 reader; the 4 Oct proposals 638-15247, 638-15265,
    638-15280) have the same problems as the log screens: typing isn't the main thing, and the habit page's Add note
    needs a date that would look odd on its own.
  - **Asked for:** Add note (from the habit page it needs a date: which day the note is for), typing first; viewing
    the note; deleting it. The same mental model as Add log / Edit log. Decide whether the reader's "View Day" (open
    that day's Day details) is really needed: keep it if so, otherwise remove it. One size first.
  - [x] Proposal in Figma at the SE size, 7 Oct (Water section, rows 5 and 6): **Add note** in Add log's shape (habit
    and date card, NOTE text card focused with the keyboard up; footer ends at 372, keyboard starts at 377) and
    **Note**, one screen for reading and changing in Edit log's shape (tap the text to edit, Save turns on with a
    change, Delete note in red text, asking first). "View Day" kept, folded into the day row ("Sun, 4 Oct · 4 of 8
    glasses ›"), only when opened from the Notes tab. Replaces `NoteSheet`, `NoteEditorView` and `NoteReaderView`.
    Documented in section 7 of the 7 October Redesign's design decisions (item 59).
  - [x] The mini and 6.1-inch sizes (the user, 7 Oct), at maximum spacing, with the 336 pt text keyboard: the note
    box grows into the room (120 / 150 / 181 pt); Add note's footer ends 8 pt above the keyboard at every size; Note's
    Delete ends at 442 / 460 / 438.
  - [x] **No habit card on note screens (the user, 7 Oct):** a note is reached only from that habit's Day details or
    page, so the habit card is redundant; note is a note in every state; keep the date, inline; research it first.
    Research agreed (the editor's top complaint is room to write, 5 reviews; notes need their dates; Apple's Notes
    shows one small date line). Done on all 12 note frames in both sections: one date line (a picker from the Notes
    tab, plain text otherwise, "Sun, 4 Oct · 6 of 8 glasses ›" on the view), no NOTE heading, no footer. The box with
    the keyboard up grew from 91 / 96 / 127 to 203 / 242 / 273 pt (SE / mini / 6.1-inch). Delete note pop-up redrawn.
    Section 7 of the design document; points 36–37 in its section 0.
  - [x] **The same question for the log screens (the user, 7 Oct):** does Add log need the habit's icon, name and
    plan? Checked the entry points: Add log also opens straight from a Home Screen widget and from a Today row, and
    notes from Today and the routine player, where the habit isn't on screen (this corrected the note change's "only
    from Day details or the habit page"). So the card goes everywhere and the **name stays as a small subtitle under
    the title** ("Add log / Water"). Done on 39 frames in both sections (Add / view / Edit log, slips, Choose a day,
    notes, delete pop-ups). Day details keeps its habit row (the link to the habit page). Section 6; point 38.
  - [x] **Header study (the user, 7 Oct):** put the habit's icon with its name in the header, and the screen's name
    with it, for easier recognition; cut a long name with "…" (names are 24 characters at most). One screen first:
    Water section, beside row 3, "Header study": [icon] Water on the first line, "Add log" under it. If approved,
    apply it to every record screen.
    - The user, 7 Oct: **two lines in the header are not good.** Redone as one line: **[icon] Water · Add log** (the
      name semibold, "· Add log" lighter; a long name ends in "…" and the job stays whole; a 24-character example sits
      under the study). This also means the two-line "Add log / Water" title now on 39 frames goes: replace it with
      the one-line header everywhere once the user approves the study.
    - The user, 7 Oct (after the current app's Add Entry, which opens with a "Read pages · 0/20 pages" row above Date):
      keep the header plain and put the habit **as a row beside Date and Time**, icon and name. Study redone: header
      just **Add log**; the card's first row **Habit · [icon] Water**, then Date, then Time. Fits at 6.1-inch (content
      ends 406, Add at 434). If approved: the same on every record screen (Add / view / Edit, slips, Choose a day,
      notes), replacing the two-line titles.
    - [x] **Approved, "update it everywhere" (7 Oct):** all 39 record screens in both sections now have a one-line
      title and the habit beside the date and time: the first row of the card on Add / view / Edit log and slips, a
      one-row Habit card above Choose a day's calendar, and "[icon] Water … date" as one line on every note screen.
      Every screen re-measured: nothing reaches its bottom button. Section 6 of the design document; point 41.
  - **The user, 7 Oct, on completeness and checks:**
    - [x] Create the missing screens for every kind (no unit, month goal, limit, time week goal, checks, checklist…),
      so each can be checked: Add, Log (view), Edit where the kind has them. Added 14: Push-ups Edit; Savings Log and
      Edit; Coffee Log and Edit; Exercise Add, Log and Edit; Add a check (stretch breaks, week goal, month goal); Mark
      a day done (once a day, N days a week); Tick steps (checklist). Checks and the checklist have no Log or Edit
      (each check has its own Undo; steps tick on Day details).
    - [x] Checks break the mental model: only they open on a calendar; every other Add (even Add slip) has the date
      behind a compact picker. Make checks consistent with the rest; clarity through copy (title, footer, button), not
      a different layout. Improve Add slip too if useful. The calendar screens are gone: **Add a check**, **Mark a day
      done** and **Tick steps** have the same card (Habit, Date, Time) as every Add, a footer that says exactly what
      will happen ("Marks Tue 6 Oct as done at 9:40 PM"), and the button at the bottom. Add slip already had that shape;
      no change needed. Design document section 8, points 42–43.
    - [x] **Document why the header and the habit changed each time (the user, 7 Oct).** Checked: the notes section
      still said "a subtitle under the title" (stale) and points 38–40 read as current. Fixed, and section 6 now has a
      dated **decision log** of the eight steps (today's app → the habit card → ✕ and the bottom button → no card on
      notes → the name as a subtitle → icon and name on two lines → one line → the plain header with a Habit row),
      each with what the screen had, why it changed, who decided, and what replaced it. "Read this first" points to it.
  - [x] **Everything in one folder, with images, committed to `main` (the user, 7 Oct):**
    [Day Details, Logs and Notes — 7 October Redesign](<../../../Research/Research Reports/Day Structure and Organization/Day Details, Logs and Notes — 7 October Redesign/README.md>).
    Its README lists every app page to update and the code behind it (Today → Day details, tasks included; History →
    Day details titled by its date, "Today" only for today; All logs; Log → Edit log; one Add screen per kind replacing
    "Add Entry" and Log Amount / Log Time, including Log manually from Day details and the timer screen and routine
    player; slips; notes from Day details, Today, the routine player and the Notes tab; delete confirmations; the words
    to change), says to build with native components (the designs show layout, not pixels), and embeds the key images.
    74 PNGs (58 every-kind screens at 6.1-inch, 16 Water screens at SE and mini) and the design decisions document
    live beside it. Build, tests and the iPhone check are still to do.
  - [x] **Rulebook updated (the user, 7 Oct: "yes, update the rulebook and push it"):** U16 (+N quick buttons), U17
    (Day details on the SE, at most three log rows), U18 (✕, the bottom button, one-line titles), U19 (view first,
    then edit; times within the day; one check per add), U21 (per-kind add labels; History's day titled by its date),
    U22 (one Add / view / Edit shape everywhere), U23 (the player's Day details; Show clock removed).
  - [x] The user's decision (7 Oct): build it
  - [x] Built and tested with item 59 (its entry has the runs); the iPhone check (U9) open there

- [x] **62. The same screens for every kind of habit and task, one size, plus the delete confirmations.** Added
  7 October 2026, from the user, after Water (items 59–61).
  - **Asked for:** a new Figma section at one size only, the largest (6.1-inch). One row per kind: time, quantity,
    checklist, check, each with its variations (a week goal, a month goal, a limit, no unit…), tasks too; the 4 Oct
    board (638-13963) shows the kinds. Add the missing confirmation pop-ups for Delete log and Delete note (as
    638-15626; just a pop-up, nothing more).
  - **Button words must scale:** never written for one habit. A unit may or may not exist; a check habit counted
    several times a day is a check whatever else it says; a once-a-day check is different again. One rule per kind;
    if Water's "Add 1 glass" turns out wrong under that rule, change it.
  - [x] Proposal in Figma (6.1-inch), with the label rules written down, 7 Oct:
    [Every habit and task, one size](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=733-2288),
    18 rows, 40 frames: amount (daily; no unit + week goal; no quick step + month goal + currency; a limit), time
    (daily; timer running and an earlier day; week goal), check (once a day; several a day; week goal; month goal;
    N days a week), checklist, quit (with Add / Edit slip), task, day states (skipped, paused, yesterday), notes, and
    the confirmations (Delete log, Delete slip, Delete note, Discard changes). The rules, taken from `DayActivity` and
    `HabitStore`, are in section 8 of the 7 October Redesign's design decisions. Changes for the user to confirm: check habits
    always "Add a check" (today a unit gives "Add 1 glass"); "Log manually" beside a quick button, "Log amount" /
    "Log time" alone; "Stop and save" for "Pause timer and save time". Water's "Add 1 glass" fits the rule.
  - **The user's review, 7 Oct:**
    - [x] Amount quick button: "+20", not "Add 20 glasses" (a long unit makes it long; Today's button already shows
      "+1", "+250"). Everything else about amounts, limits and time stays. Done in both sections (8 buttons, Water
      included); VoiceOver keeps "Add 1 glass".
    - [x] Currency before the number: check the app and record the rule; don't break how amounts are written
      elsewhere for one screen. (Checked: `HabitCopy.amount` puts $ € £ ₹ first, every other unit after.) Recorded
      as "Amounts are written one way everywhere" in section 8 of the design document.
    - [x] Once-a-day check, Add from History: "THIS DAY · Done" is confusing; improve it. Now **Choose a day**: the
      habit, a month calendar (today and earlier), toolbar **Mark done**.
    - [x] Several-a-day check: each check is recorded on its own, one at a time; adding or editing several at once
      (typed) is wrong. Improve Add; drop the multi-check editor. (Checked: Today, Day details and widgets add one
      per tap; History's Add Entry has a 1–99 Times stepper that saves several as one log.) Now the same **Choose a
      day** screen with **Add a check** (one); the multi-check Edit log is gone; old multi-check logs keep working.
      Changes U19's multi-check line if approved.
    - [x] Remove the Discard changes pop-up from the design: the app already asks when leaving with changes (U19);
      keep that. Confirmations are for deleting only. Removed; the section now has 38 frames.
    - Also fixed: 6 Oct 2026 is a Tuesday; three frames and the document said "Mon 6 Oct".
  - **The user's next review, 7 Oct:**
    - [x] Time: a log's time matters, above all for a past day from History (today's app saves every log except a
      slip with the moment it was entered, so a past day's log shows today's clock time). Check reviews; add it if
      needed, for every kind. Reviews: 120 hand-read of 337,331 scanned; 11 (9 apps) want a log's time kept or set
      ("gym at 6 PM, check it off at 9 PM"), 5 want a past slip time. Added: Date and **Time** on every Add, the time
      changeable within the same day on every Edit, a Time row under Choose a day's calendar. Section 8, "The time of
      a log", of the design document.
    - [x] Don't confuse a time habit's duration with the log's time: the duration is **HOW LONG**, the clock row
      **Finished at**.
    - [x] "Cancel" is too big: now an icon-only **✕** (accessible name Cancel; still asks first with changes).
    - [x] The main button at the bottom, above the keyboard (easier to reach, read top to bottom): **Add**, **Save**,
      **Mark done**, **Add a check**, one filled button. Every Add / Edit / Choose a day / slip / note frame in the
      every-kind section; the delete pop-ups redrawn over them. Changes U18 if approved.
    - [x] The Water section's three-size Add / Edit / note frames showed the old toolbar: rebuilt 7 Oct (the user
      couldn't find the new note screens, which sat at the bottom of the every-kind section). The Water section now
      has eight rows at SE, mini and 6.1-inch: Day details, All logs, Add log, Log, Edit log, Add note, Note, Edit note.
      While typing, the footer hides where it would reach the button (SE, mini), the SE puts Date and Time in one row,
      and a note's box fills the room above Save.
  - **The user, 7 Oct, on editing:**
    - [x] No greyed-out Save on an edit screen: once a log is added, the jobs are view, edit or delete.
    - [x] An explicit **Edit** button (tapping the value to edit isn't obvious enough), beside **Delete**, in the bottom
      place where Add sits when adding. Tapping Edit opens the keyboard and shows Save.
    - [x] The screen opened from a row is for viewing first: name it "Log" (not "Edit log"); "Edit log" only in edit
      mode. The same view-then-edit step wherever one record opens: a log, a time session, a slip, a note.
      Done in Figma: Log (amount, time), Slip and Note views with Delete | Edit; edit modes Edit log (amount, time),
      Edit slip, Edit note with ✕ and Save above the keyboard; the delete pop-ups drawn over the views.
    - [x] Document every important point with its reasoning, so whoever builds it forgets nothing: the design
      document's new section 0 lists all 35 points in order with reasons and pointers; section 10 spells out each
      Rulebook change (U17, U18, U19, U22). Design Rules' pointer updated.
  - [x] The user's decision (7 Oct): build it
  - [x] Built and tested with item 59 (its entry has the runs); the iPhone check (U9) open there

- **Build notes for 59–63 (7 Oct 2026, branch `day-details-logs-notes-redesign`, now in `main`).** Built natively:
  the store stamps a log with its chosen time inside its own day, never later than now, and a past day's quick log at
  the same clock time on that day; every log's time can change within its day (`editEntry`); one check per add. One
  Add screen for every kind (`AddLogView`: Add log, Add a check, Mark a day done, Tick steps, Add slip) replaces Add
  Entry, Log Amount / Log Time and Log a Slip everywhere they opened. A log row opens Log / Slip (view) with
  Delete | Edit, then Edit log / Edit slip (`LogRecordView`); All logs (`AllLogsView`); Day details' This day card
  with the note inside, at most three log rows, spacing between the SE minimum and the maximum (`DaySpacing`); Add
  note / Note / Edit note (`NoteSheet.swift`); the routine player's Day details. First GitHub build passed (run
  37607280545, Debug and Release). Tests and the speed run: item 59.
  - **U5, what the retired screens showed (the user's decisions, 7 Oct):** dropped, with the user's OK: Log Amount /
    Log Time's "Log 1 glass again" (Day details' quick button covers it); Log a Slip's optional "What happened" note
    (notes are written from Day details); the timer screen's "Edit This Day's Progress…" link (Day details is one tap
    from the row, and in the player's bar); Add Entry's list of the day's entries under the form, and the Next / Done
    bar above the number pad. Kept: Add Entry's paused / skipped day explanations (now in the Add footer); the note
    reader's View Day (the Note view's date line); the routine player's options (all in Day details; the flexible goal's
    "0 of 3 days this week" now in Day details' status line); Show clock removed by the user's decision.

- [x] **63. Routine player: "Habit options" opens Day details.** Added 7 October 2026, from the user.
  - **Asked for:** the player's "Habit options" opens a separate pop-up; rewire it to the same Day details sheet a
    habit row opens on Today, full height, for today; rename the button to something fitting; remove "Show clock"
    ("a meaningless option: if you are tracking time you should see the clock").
  - Decided: the button is **Day details** (habits and tasks); the options sheet goes; everything it held is in Day
    details except Show clock, which is removed. Rulebook U23; redesign README page 8.
  - [x] Built and tested with item 59 (its entry has the runs): the player's Day details passed in FocusPlayer
    (`37624444958`) and its opening was measured (652 ms); the iPhone check (U9) open there

- [x] **54. A week or month goal's round button fills after one tap, though the goal isn't met.** Added 6 October 2026,
  from the user (Call family, 3 times a week: "the check mark should only fill when the habit is complete… they might
  call two times this day"; check monthly and the rest too).
  - **Cause:** a "N times a week/month/year" check's ✓ was that day's tick (`isTicked`), drawn filled once today had
    one and toggled by a second tap, though the New Habit form says every ✓ counts, even two on one day.
  - **Built, 6 Oct 2026** (branch `week-goal-button-squares-key`): a week, month or year count is now a +1 counter like a
    habit ticked several times a day (`countsUp`): each tap adds one, never takes one back (its named Undo does), and
    the button fills only when the period's goal is met. The Day sheet says "1 check today · 1 of 3 checks this week"
    with Add a check and each check's own Undo; Shortcuts and the player add one too (a second Shortcut call took the
    first back). Checked the rest: week/month/year amounts and times already filled only when the period was met; "N
    days a week" stays a ✓ (a day counts once); widgets already added one per tap. Still done *for the day* once
    logged (sinks, leaves "N left", stops reminders: #60a, the user's 30 Sep request). Rulebook U14 updated.
  - Tested on GitHub, 6 Oct 2026: runs `37432849062` (44/45; the one failure was a test still expecting the old Mark done, fixed in `a3d33bf`), `37438879527` (55/55 before the 60-minute limit), `37446300004` (28/28, the rest plus persistence, undo, backup, widgets); speed `37450877606` and re-measure `37456070731` (Today scrolling 0.0 ms/s, +1 alone 0.9; the first run's 79.7 was the machine: Menu, the timer clock and the control field slowed alike). iPhone check (U9): open.

- [x] **55. Today: Undo and Add Note under a logged row are too close; easy to tap the wrong one.** Added 6 October
  2026, from the user ("increase the gap").
  - **Built, 6 Oct 2026** (branch `week-goal-button-squares-key`): the after-log buttons (`RowAfterLog`, `QuitAfterSlip`)
    are 16 pt apart instead of 8. Tested on GitHub, 6 Oct 2026: runs `37432849062` (44/45; the one failure was a test still expecting the old Mark done, fixed in `a3d33bf`), `37438879527` (55/55 before the 60-minute limit), `37446300004` (28/28, the rest plus persistence, undo, backup, widgets); speed `37450877606` and re-measure `37456070731` (Today scrolling 0.0 ms/s, +1 alone 0.9; the first run's 79.7 was the machine: Menu, the timer clock and the control field slowed alike). iPhone check (U9): open.

- [x] **57. "What the squares mean": once folded anywhere, folded everywhere.** Added 6 October 2026, from the user;
  supersedes item 25's per-place rule ("once they close it… it shouldn't be opened ever again by default unless they
  open it"; "it's the same content, why do I need to close it multiple times?" — Week, Month, Year and every habit's
  page each asked to be folded again).
  - **Built, 6 Oct 2026** (branch `week-goal-button-squares-key`): one app-wide state (`HeatKeyMemory`,
    `heatKey.folded`): open everywhere until the person folds it once, anywhere; then folded on every range, habit
    page and later visit; a tap opens it for that page's visit. Never folds on its own within a visit; Week, Month and
    Year share the visit. Kept across launches; test launches start never folded (T8). 5 Oct's `heatKey.seen` is
    removed. Tested on GitHub, 6 Oct 2026: runs `37432849062` (44/45; the one failure was a test still expecting the old Mark done, fixed in `a3d33bf`), `37438879527` (55/55 before the 60-minute limit), `37446300004` (28/28, the rest plus persistence, undo, backup, widgets); speed `37450877606` and re-measure `37456070731` (Today scrolling 0.0 ms/s, +1 alone 0.9; the first run's 79.7 was the machine: Menu, the timer clock and the control field slowed alike). iPhone check (U9): open.

- [x] **56. Research: should a week goal be hideable from one day ("not today", not a skip)?** Added 6 October 2026, from
  the user ("only if it's a medium or strong signal; one to ten reviews is weak"). **Done, 6 Oct 2026: weak signal,
  not built.** Whole corpus screened (1,487,223), 545 read, 132 on topic: 2 reviews ask for exactly this, 16 for the
  opposite (show it every day until met). Putting a habit off to another day is a separate, medium signal (81), left
  for its own item if wanted. [Report](<../../../Research/Research Reports/Day Structure and Organization/Hiding a Weekly Goal From Today — Is It Needed.md>).

- [x] **50. Routine player: tapping › or ‹ fast makes the habits slide back and forth.** Added 5 October 2026 by
  Claude (Claude Code), from the user's iPhone. Branch `claude/dreamy-pasteur-3kgdxu`.
  - **The user's words, tidied:** "Normally it was fine. When I tapped the right chevron very quickly to the end, then
    the left chevron very quickly back to the start, the progress bar under the header updated correctly and reached
    the end, but the habits on screen felt like they moved back and forth instead of forward. It looked like a
    glitch."
  - **Expected:** however fast ‹ or › is tapped, the pages only ever slide the way they were sent and land on the
    habit the segments show.
  - **Reproduce first (S2):** `FocusPlayerUITests.testFastNavigationNeverSlidesBack` launches with
    `-focus-fast-nav-check`: the player taps itself every 0.1 s (XCUITest waits for each slide, so it can't) and each
    page reports its place on screen (`PagerProbe`, DEBUG only).
  - **Measured, 5 Oct 2026 (GitHub's simulator, 13-habit routine, a tap every 0.15/0.1/0.05 s):** the page
    `TabView`'s scroll position never goes back (0.00 pages at every speed, read from the pager's presentation layer
    every frame, runs `37359127449`, `37367189762`, `37379485559`). **Not reproduced on the simulator so far.**
    *Correction:* frames that seemed to show a habit drawn on the wrong side came from seeking into the screen
    recording with ffmpeg (half-decoded frames); decoded straight through, the same moments are clean. Recordings are
    now checked frame by frame, decoded straight through, by a script that flags two habits' circles in the same
    columns or habits out of the routine's order (it catches both on synthetic frames).
  - **Found, 5–6 Oct (run `37384134763`, a slower hosted machine):** the `TabView` failed the check: "› 150 ms: 6
    reversals, slid back 0.21" and "turn ‹ 50 ms: slid back 0.70". While its own slide runs, the page `TabView` reports
    pages it slides past as if chosen, and the player obeyed (it went back); and pages trailing fast taps had to turn
    round when ‹ followed ›. Timing-dependent: faster machines showed none. The check now includes the user's pattern,
    › to the end then ‹ with no pause.
  - **Fixed (`4ad0e18`):** during the player's own slide (`PagerSlide`, 0.35 s) page reports are not choices; a tap
    during a slide jumps straight to its habit; one tap still slides; swipes outside a slide choose as before. Fix run
    `37387468173`: 0.00 slid back and 0 reversals at every speed and in both turn-arounds.
  - **Tried and rejected:** a paging `ScrollView` (`ScrollPosition`): its recording showed non-neighbouring habits
    drawn over each other mid-slide; one-slide-at-a-time made the pages trail further. Recordings were checked frame by
    frame, decoded straight through (`Research/Temp/wrong_side.py`, not committed).
  - **Tests passed on GitHub (6 Oct, `b2d562e`/`64b6afe`):** FocusPlayer 15/15 (fast check, swipe, bottom bar),
    RoutineCalendar 7/7, Timer, Today, Undo; speed run `37410175611`: player ‹ › 11.9 ms/s, fast ‹ › 23.8, opening
    390/104 ms. **Still yours:** the iPhone (U9), above all fast ‹ › to the end and straight back.

- [x] **51. Routine player: the bottom row is a block, not a bottom navigation; a checklist's steps are cut off.** Added
  5 October 2026 by Claude (Claude Code), from the user's iPhone (Tidy desk, 3 steps). Branch
  `claude/dreamy-pasteur-3kgdxu`.
  - **The user's words, tidied:** "For checklist habits the screen covers everything. I've told the other agent many
    times: this should be an actual bottom navigation, not a huge block at the bottom. Look at Today's bottom
    navigation; I always wanted that there. See how much space below it is wasted; that's why we get problems like
    this."
  - **What the screenshot shows:** under the circle the checklist's card starts and is cut off; below it a black band
    (the empty main-button slot, a 32-point gap, the ‹ Habit options › row and 40 points under it) takes about a
    fifth of the screen.
  - **Expected:** ‹ · Habit options · › is the same native bottom bar as Today's ‹ · Today · › (its own Liquid Glass
    items on iOS 26), in the system's place at the bottom; the page uses the rest of the screen, so a checklist's
    steps show; still nothing moves (4 Oct's rule) when the main button comes and goes.
  - **Built (`72d8fe1`, kept through `4ad0e18`):** ‹ · Habit options · › are `ToolbarItem(placement: .bottomBar)`
    items like Today's (Habit options in `.status` before iOS 26); the main button floats over the page's bottom, a
    scaled 24-point gap above the bar, and each page keeps that room at its end. Screenshot on GitHub's iPhone 17 Pro:
    Clean kitchen's three steps all show. `testBottomRowStaysPutAndOptionsShowEverything` checks the bar is at the
    bottom, nothing moves, and an unfinished checklist's last step shows above the bar. `testNavigationDoesNotWait…`
    now injects 4 s writes and allows 3 s: the Liquid Glass ›'s press animation adds ~0.9 s of XCUITest waiting.
    **Still yours:** the iPhone (U9).

- [x] **52. A habit or task added between midnight and the day start didn't show on Today until the day start.**
  Added 6 October 2026 by Claude (Claude Code); found by the full test for items 50–51, not by the user. Branch
  `claude/dreamy-pasteur-3kgdxu`.
  - **What happened:** `OnboardingUITests.testWelcomeToFirstHabit` sets a 3 AM day start, adds Exercise and expects it
    on Today. It failed twice in a row, at 00:13 and 01:2x UTC (runs `37390754817`, `37395447112`), with Today empty
    (0/0); it passes on `main` in the daytime. The habit form took its start date (and a task's date) from the
    calendar, while Today shows the app's day, which before the day start is still yesterday: the habit started
    "tomorrow". Rulebook D7: day start applies everywhere or nowhere.
  - **Fix:** the form's start, end and task dates, the task picker's earliest day, "Start Today" and the
    Today/Tomorrow/Yesterday words come from the store's today (`trackingToday`, `NewHabitView`).
  - **Test, every run:** `OnboardingUITests.testFirstHabitAfterMidnightBeforeTheDayStartShowsOnToday` launches with
    `-clock-hour 1` (test launches only: the store's clock runs from 1:30 AM) and a 3 AM day start. Passed on GitHub
    (6 Oct, `64b6afe`, run `37405772056`) with Onboarding, NewHabit, Tasks; HabitCreation, HabitScenario, Placement,
    CompletionFeedback and FormWalkthrough passed on the same commit (run `37405769915`).

Completed work retains its original evidence and any outstanding user review.

- [x] **14. Cut-down habits (limits): where do they belong?** (added 3 Oct 2026) Keeping them inside the times of day
  feels weird. The user's thought: show them in the Quitting section instead. Research how people think of a limit
  ("cut down on coffee") next to quitting and next to build habits, then decide.
  - **The user's words, 5 Oct, tidied:** "In the other sections a cut-down habit signals you have to log something. You
    log it only if you do it. If they go only in the Quitting section, remove the time of day from the cut-down habit."
  - **Built, 5 Oct 2026** (branch `claude/timer-swipe-limits-and-fixes`; checklist [Timers, Swipes, Time Limits and
    Fixes — 4 Oct](<Timers, Swipes, Time Limits and Fixes — 4 Oct.md>) §5): limits join quit habits in one "Quit or Cut
    Down" card (no "N left", no Start, never in a routine); the Cut down form has no Time of Day. Report "Limit Habits on
    Today — Apart From What You Must Do". Tests: pending. Still yours: the iPhone (U9).
  - **Completed, 5 Oct 2026** (built and tested on GitHub: runs `37268101680` (NewHabit 20, FocusPlayer 13 incl. both limit tests, Today 8), `37272372742` (HabitScenario incl. testCutDown, HabitCreation's cut-down, LongText, RoutineCalendar) and `37276908176` (Today's speed: +1 and day ‹ › 77.7 ms/s, as before); merged into `main` 5 Oct). **iPhone check (U9) still yours**, separate from completion.

- [x] **46. Habit details: Notes in month cards that fold, like History.** Added 5 October 2026, from the user: "In
  History each month is a card that folds, open by default, a row per day. Notes need the same: a month card, each
  day's note a row in it. Right now notes are added very weirdly."
  - **Built, 5 Oct 2026** (branch `claude/timer-swipe-limits-and-fixes`; checklist [Completion Sound, Squares Key and Notes Months — 5 Oct](<Completion Sound, Squares Key and Notes Months — 5 Oct.md>)): a card per
    month with "N notes", folding like History's (newest two open), a row per day's note dated as History dates its
    days. Tests passed (below).
  - **Completed, 5 Oct 2026** (built and tested on GitHub: run `37276908176`, `HabitPageUITests.testNotesFoldByMonthLikeHistory`; merged into `main` 5 Oct). **iPhone check (U9) still yours**, separate from completion.

- [x] **10. Groups: test them properly.** Making a group seems to work, but groups and their statistics (group
  chips on Progress, group numbers, the Filter's group choice, editing and ordering groups) were never really
  tested, on the simulator or the iPhone.
  - **Built and tested, 4 Oct 2026** (branch `claude/timer-swipe-limits-and-fixes`; checklist [Timers, Swipes, Time
    Limits and Fixes — 4 Oct](<Timers, Swipes, Time Limits and Fixes — 4 Oct.md>)): four new GroupsUITests (order, deleting a full group, own choices and Start, names and Pause); 9/9 passed.
  - **Completed, 5 Oct 2026** (built and tested on GitHub; branch `claude/timer-swipe-limits-and-fixes`, not yet in `main`).

- [x] **11. Bug: the app sometimes stops responding for ~74 s right after launching signed in** (added 2 Oct, from the
  test runs). `BackupUITests.testDeletingTheAccountAndErasingThisPhone` launches with a test sign-in to the dev server;
  in 4 of 13 runs (1–2 Oct) the app didn't respond for about 74 s right after launch, before the test's first step
  (opening the ≡ menu), and the test failed; it passes on a rerun. Not caused by a test step: it happens before any.
  Suspects to check: something blocking the main thread during the sign-in at launch (the keychain, a network call
  waited on, the first backup or sync). Logs: run 36995529935 (`ios-logs` artifact, the test's lines at
  t = 24.86 s → 98.74 s). Find the cause, fix it, and make the test show where the time goes if it happens again.
  - **Built and tested, 4 Oct 2026** (branch `claude/timer-swipe-limits-and-fixes`; checklist [Timers, Swipes, Time
    Limits and Fixes — 4 Oct](<Timers, Swipes, Time Limits and Fixes — 4 Oct.md>)): Keychain calls moved off the main thread (the likely cause); launch steps timed into `app.log` in CI. Backup and Sync passed; confirmed only as runs keep passing.
  - **Completed, 5 Oct 2026** (built and tested on GitHub; branch `claude/timer-swipe-limits-and-fixes`, not yet in `main`; confirmed only as runs keep passing).

- [x] **15. Timed habits: what should tapping ▶ do?** (added 3 Oct 2026) Today ▶ starts an inline timer on the row.
  Research whether that's what people expect, or whether ▶ should open a full-screen timer, or both (and which is
  the default).
  - **Built and tested, 4 Oct 2026** (branch `claude/timer-swipe-limits-and-fixes`; checklist [Timers, Swipes, Time
    Limits and Fixes — 4 Oct](<Timers, Swipes, Time Limits and Fixes — 4 Oct.md>)): ▶ starts the timer and opens it full screen; a swipe puts it away while it keeps running; the bar opens it. Still yours: the iPhone (U9).
  - **Completed, 5 Oct 2026** (built and tested on GitHub; branch `claude/timer-swipe-limits-and-fixes`, not yet in `main`). **iPhone check (U9) still yours**, separate from completion (the user, 5 Oct 2026).

- [x] **16. Timers and the Dynamic Island / Live Activity.** (added 3 Oct 2026) Starting a timer sometimes goes
  straight into the Dynamic Island. Keep it, but make it behave the way people expect, reliably, and add a way to
  turn it off. Research when it should appear, then fix.
  - **Built and tested, 4 Oct 2026** (branch `claude/timer-swipe-limits-and-fixes`; checklist [Timers, Swipes, Time
    Limits and Fixes — 4 Oct](<Timers, Swipes, Time Limits and Fixes — 4 Oct.md>)): the Live Activity ends the moment the timer stops, has Pause and opens that timer; ≡ → Appearance → Timers turns it off. Report "Timers — What People Expect When They Tap ▶". Still yours: the iPhone (U9).
  - **Completed, 5 Oct 2026** (built and tested on GitHub; branch `claude/timer-swipe-limits-and-fixes`, not yet in `main`). **iPhone check (U9) still yours**, separate from completion (the user, 5 Oct 2026).

- [x] **17. Bug: the routine player's bottom spacing is wrong.** (added 3 Oct 2026) Fix the spacing at the bottom of
  the routine (focus) player's screen; check on the iPhone (U9).
  - **Details imported from `e657641`, 4 October:** treat ‹ · Habit options · › as bottom navigation, roughly
    40 points from the bottom edge with ample space against misclicks. The main button and navigation must not
    shift with habit state, circle/content changes, Undo, save messages or note entry. The branch reports an
    implementation; current-main integration and iPhone validation remain pending. Requirements:
    [Routine Player — Bottom Row, Options Sheet and Switches](<Routine Player — Bottom Row, Options Sheet and Switches.md>).
  - **Built, tested, merged (4 Oct 2026, the player's branch at `b6bd7d1`, then `main`):** FocusPlayer (13, including
    `testBottomRowStaysPutAndOptionsShowEverything`), Schedule, RoutineCalendar and Groups passed (31 tests), plus the
    classes that use switches elsewhere before `main` moved. Speed: the player's ‹ › 14.8 ms/s, no freeze. **Only the
    user's look on the iPhone (U9) is left;** tick it then and move it to Completed.
  - **Completed, 5 Oct 2026** (built and tested on GitHub; merged into `main` 4 Oct). **iPhone check (U9) still yours**, separate from completion (the user, 5 Oct 2026).

- [x] **33. Routine player: Habit options hides its last actions.** Documented on 4 October 2026 by the other
  agent on `claude/weekly-overview-stats-ly55gk` (`e657641`); formerly item 22 on that branch.
  - For Read, the sheet shows Log time manually, Skip today, Undo, Show clock and Add Note, but Edit Habit is only
    reachable after scrolling. Review whether the sheet should fit the complete options list; preserve every action.
  - The source branch reports a fix. It is not yet merged into main; verify the applicable build and required
    checks before marking this complete. Detailed requirement: routine-player checklist P5.
  - **Built, tested, merged (4 Oct 2026, the player's branch at `b6bd7d1`, then `main`):** FocusPlayer (13, including
    `testBottomRowStaysPutAndOptionsShowEverything`), Schedule, RoutineCalendar and Groups passed (31 tests), plus the
    classes that use switches elsewhere before `main` moved. Speed: the player's ‹ › 14.8 ms/s, no freeze. **Only the
    user's look on the iPhone (U9) is left;** tick it then and move it to Completed.
  - **Completed, 5 Oct 2026** (built and tested on GitHub; merged into `main` 4 Oct). **iPhone check (U9) still yours**, separate from completion (the user, 5 Oct 2026).

- [x] **34. Routine player: Show clock switch is white/unreadable in dark mode.** Documented on 4 October 2026 by
  the other agent on `claude/weekly-overview-stats-ly55gk` (`e657641`); formerly item 23 on that branch.
  - Switches should use the system green style; selection checks use system blue. The branch reports a shared
    switch style and a correction to the group's habit picker selection controls; integration and verification on
    main remain pending. Detailed requirements: routine-player checklist P6–P7.
  - Keep this separate from item 22's Today-sheet green-checkmark concern: these are different controls and reports.
  - **Built, tested, merged (4 Oct 2026, the player's branch at `b6bd7d1`, then `main`):** FocusPlayer (13, including
    `testBottomRowStaysPutAndOptionsShowEverything`), Schedule, RoutineCalendar and Groups passed (31 tests), plus the
    classes that use switches elsewhere before `main` moved. Speed: the player's ‹ › 14.8 ms/s, no freeze. **Only the
    user's look on the iPhone (U9) is left;** tick it then and move it to Completed.
  - **Completed, 5 Oct 2026** (built and tested on GitHub; merged into `main` 4 Oct). **iPhone check (U9) still yours**, separate from completion (the user, 5 Oct 2026).

- [x] **35. Today's swipe actions: an over-long swipe adds a note; reaching all three buttons takes care.** Added
  4 October 2026, from the user: research first, then fix.
  - **The user's words, tidied:** "If I slide too much, it directly adds a note for the habit. I have to do it very
    carefully just to get all three options inside the slide. Maybe, instead of Undo, we should have Skip on the slide
    left. We need research about how this will work and how it should work, and fix it."
  - **What's built (Rulebook U14, 3 Oct 2026; `TodayRows.swift`):** swipe left reveals Note, Skip and Pause, and a full
    swipe runs Note (`allowsFullSwipe: true`, chosen as the one harmless action); swipe right reveals a named Undo
    with no full swipe. So a long swipe left opens the note sheet instead of showing the three buttons.
  - **Research:** whether any action should run on a full swipe at all (and which); how many buttons a swipe should
    hold so all of them are easy to reach; which side gets Skip, Note, Pause and Undo (the user's idea: Skip on a
    swipe, where Undo is now; check what "instead of Undo" means with the user before deciding); what people expect
    from the iPhone's own lists (Mail, Reminders) and what reviews show about accidental swipes. Start from report
    "Today's Rows — Tap, Swipe, the Day Sheet and Delete" (the 3 Oct evidence: 35 accidental swipes, 14 "which way").
  - **Then:** the user decides; update U14 and Design Rules' row section with the date and reason, then the swipe
    code, `TodayRowSheetUITests`' swipe tests (T3) and a `PerfDriver` check if the swipe changes (T4). Check on the
    iPhone (U9).
  - **Built and tested, 4 Oct 2026** (branch `claude/timer-swipe-limits-and-fixes`; checklist [Timers, Swipes, Time
    Limits and Fixes — 4 Oct](<Timers, Swipes, Time Limits and Fixes — 4 Oct.md>)): a swipe only reveals, never acts; left Skip then Note, right a named Undo; Pause in the long-press menu (U14). Report "Swipe Actions — Reveal, Never Act". Still yours: the iPhone (U9).
  - **Completed, 5 Oct 2026** (built and tested on GitHub; branch `claude/timer-swipe-limits-and-fixes`, not yet in `main`). **iPhone check (U9) still yours**, separate from completion (the user, 5 Oct 2026).

- [x] **37. Time limits ("Social media: 30 min max"): can't be edited, and should they exist? Decide, then add or
  remove them properly.** Added 4 October 2026, from the user.
  - **The user's words, tidied:** "My iPhone still has data from the first versions, when we ran automated tests on it.
    There's a limit habit, Social media 30 minutes max. In Quit we have two things, stop completely and limit something,
    and in the units there's no minutes unit now, yet that habit still works. First problem: I can't change it. Second:
    should limits allow this? It's a genuine use case (social media 30 minutes max), but also a little confusing: it
    could be made as a timed build habit, yet it isn't building, it's cutting down. Today a limit can be a quantity but
    not a time. We shouldn't add something for one use case: check whether it's genuine, and if it is, add it; either
    add it or remove it, and finalise it."
  - **What the code has (to check against the phone):** a timed limit is still a valid habit (a Cut down whose unit is
    time, `HabitPlan.timeUnit`; Today and the player show "30 min max"; the `-uitest` demo makes "Social media" 30 min
    at most). The user found no time unit among the Limit's units, and couldn't change the habit. Reproduce on the
    current build first: open Edit Habit for a timed limit and see what's missing or stuck.
  - **Research (W2), before deciding:** do people want time limits (screen time, social media, gaming, TV) in a habit
    tracker, and do they see them as cutting down rather than building? How do they log them (a timer, typing the
    minutes, Screen Time)? Where would one sit: Quit → Limit with a time unit, or elsewhere? Say "users show…" with
    counts (Research rules). Also ties to item 14 (where limits belong).
  - **Then, either way, nothing half-done:** if kept, offer time properly when making and editing a limit (and its
    logging, timer and wording); if removed, existing timed limits must keep working and stay editable, and their data
    is never lost (D2, D6). The user decides from the research.
  - **Built and tested, 4 Oct 2026** (branch `claude/timer-swipe-limits-and-fixes`; checklist [Timers, Swipes, Time
    Limits and Fixes — 4 Oct](<Timers, Swipes, Time Limits and Fixes — 4 Oct.md>)): a Limit can be in minutes; an existing timed limit is editable and keeps minutes (D6). Report "Time Limits — Should Cut Down Allow Time"; Screen Time is item 45.
  - **Completed, 5 Oct 2026** (built and tested on GitHub; branch `claude/timer-swipe-limits-and-fixes`, not yet in `main`). **iPhone check (U9) still yours**, separate from completion (the user, 5 Oct 2026).

- [x] **38. Today: a folded time of day's habit icons sit on the title's line, too close to it.** Added 4 October 2026,
  from the user.
  - **The user's words, tidied:** "When a time of day section is closed, the icons we show are aligned with the title of
    that section; that isn't right. There should be a good amount of space between the title and the icons (something
    like 8, 12 or 16 points, as a relative unit, not exact pixels), and the icons should be centred vertically in the
    card, not to the title, because that looks weird."
  - **What's built (`TodayRows.swift`, the section header's `titleArea`):** the folded icons (`FoldedIcons`) are in the
    same row as the name, 10 points after it, so they line up with the name and not with the name plus its "Starts
    6 AM" line.
  - **To do:** put the icons beside the whole title block (name and its line), centred vertically on the header; give
    them a clear gap from the title that scales with Dynamic Type (`@ScaledMetric`, around 12 to 16 points); keep how
    many icons fit (`FoldedIcons.fitting` counts the gap) and the fade-in when folding. Read Design Rules' "Today
    section headers" first (U12); `SectionHeaderUITests` covers the header. Check on the iPhone (U9).
  - **Built and tested, 4 Oct 2026** (branch `claude/timer-swipe-limits-and-fixes`; checklist [Timers, Swipes, Time
    Limits and Fixes — 4 Oct](<Timers, Swipes, Time Limits and Fixes — 4 Oct.md>)): the icons sit beside the whole name block, centred, with a scaled gap (~14 pt). Still yours: the iPhone (U9).
  - **Completed, 5 Oct 2026** (built and tested on GitHub; branch `claude/timer-swipe-limits-and-fixes`, not yet in `main`). **iPhone check (U9) still yours**, separate from completion (the user, 5 Oct 2026).
- [x] **48. Research streak placement in Habit details.** Completed as a research/design-documentation follow-up, 5 October 2026; native implementation/device validation remain separate. Number 48 follows a live main/active-branch check: 45–47 are already used by other work.
  - [x] [Placement report](<../../../Research/Research Reports/Habit Details Research/Final UX Pass/Streak Placement — Shared Header or Progress.md>) verifies 18 complete originals, includes opposing preferences, and separates main-list visibility evidence from the placement reasoning. Recommend Current/Best visibly in the early individual habit Progress summary; keep the shared header for identity and applicable state, and retain Today's quick access. No measured preference or usage-rate claim.
  - [x] Remove duplicate pairs from six existing History/Notes/quit studies and close their 106 pt space while retaining the 24 pt identity-to-tabs outside gap. No new mockups; existing Progress already contains visible Current/Best. Preserve units, preferences, quit context, task exclusions and accepted controls (U1/U3/U5/U17/U20).
  - [x] Refresh the six own-design PNGs and export dates/hashes; update the active handoff, package/research indexes, dated supersession notices, Rulebook U20 and Design Rules. Items 42/44's common-header streak-pair placement is superseded by this follow-up.
  - Validation: Figma read-back reports zero remaining streak/run header facts in all six studies, zero new nodes, SF Pro and editable layers with no image-filled UI nodes. Both affected composition boards visually checked; nine Markdown files / 350 local links / all 22 PNG dimensions and hashes passed after integration with concurrent main changes; Git whitespace and speed-rules checks passed. No app code or personal data changed; no iOS test dispatch is needed for this research/export update.

- [x] **1. Progress page: a big visual overhaul of Week, Month and Year.** Not the data (it's right and complete) but
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
  - **Done (the user, 4 Oct 2026: "it is completed, month and year also completed; maybe the previous agent forgot to
    update it"):** Week, Month and Year are built and in `main` (Month and Year: one heat map, `dbe6287c` onward).
    New spacing feedback stays open as item 31.

- [x] **2. The habit page needs a serious visual revamp** (the page a habit opens to from Progress or Habits). Again
  not the data: how everything is presented.
  - **Done and merged into `main`, 3 Oct 2026 (18:55 UTC, `4da8999`)** after every UI test class passed: History ·
    Notes · Progress tabs, Add Entry, Year in Pixels, milestones as cards. Checklist: [Habit Details Page — Build](<Habit Details Page — Build.md>).
    Still yours: a look on the iPhone (U9), mainly the Year in Pixels (H22).

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

- [x] **39. Publish the Day-details and Entry-editor research/wireframe handoff to `main`.** Completed 4 October 2026.
  - Both reports, every later revision and its reason, the native implementation contract, all 21 Day-details and
    10 Entry-editor PNG wireframes are in the [dedicated handoff folder](<../../../Research/Research Reports/Day Structure and Organization/Day Details and Entry Editor Handoff/README.md>).
  - The reports and wireframe pages explicitly call these representative pop-ups, **not final visuals**. The ⋯ menu,
    `xmark` Close, buttons, note-for-this-day preview, pickers and keyboard must be native iOS controls (U1/U18).
  - Verified 11 local Markdown files and 31 PNGs, with all 31 images referenced; `git diff --check` and
    `iOS/Tools/perf/check_rules.sh` passed. Documentation commits `70522494` and `1bb612e6` were pushed to `main`
    without CI trigger tags (T10). Day-details and editor **app implementation** remain open as items 22/36.

- [x] **40. Decide task-note treatment and complete the task Day-details wireframes.** Completed 4 October 2026.
  - [Task-specific review and code audit](<../../../Research/Research Reports/Day Structure and Organization/Day Details and Entry Editor Handoff/Task Notes in Day Details — Evidence and Decision.md>) support keeping an optional, secondary note surface. The current note is keyed to task and selected day; moving a one-time task does not move the note (D7/U5).
  - The [Day-details wireframe page](<../../../Research/Research Reports/Day Structure and Organization/Day Details and Entry Editor Handoff/Day Details Wireframes.md>) now shows task undone/empty-note, undone/saved-note and done states. Figma's unused centered-header comparison and its PNG were removed; the leading-aligned identity is the sole proposed pattern. These remain representative mockups, not native implementation (U1/U9).
  - Verified the old Figma node is absent and the new saved-note node exists; all 31 Markdown image links and the new local report links resolve. `git diff --check` and `iOS/Tools/perf/check_rules.sh` passed. No iOS app code or device state was changed.

- [x] **41. Refine the single-record editor's Delete action.** Completed as a design/documentation update 4 October 2026; native iOS implementation remains item 36.
  - [x] **Delete this log / Delete this slip** is a bottom bordered destructive-button specimen in all 10 Figma editor states, separated from Save and the editable field. State 09's keyboard covers the bottom area until dismissed (U1/U19).
  - [x] Removed the unnecessary divider above Delete in every editor state; the alert's own native-style action separator remains.
  - [x] State 07 shows the confirmation pop-up reached on Delete: one selected log/day, Cancel, and a destructive Delete log action. The handoff specifies the corresponding slip alert and that initial tap changes no data (D6/U19).
  - [x] Re-exported all 10 Entry-editor PNGs and updated the handoff, research report, Design Rules and Rulebook U19. Figma read-back confirmed 10 bottom buttons, zero form dividers, one confirmation state, SF Pro text and editable layers. All 31 Markdown image references resolve, `git diff --check` and `iOS/Tools/perf/check_rules.sh` pass. Documentation publication to `main` follows Rulebook T10 without an iOS test tag.

- [x] **42. Habit details, History actions, Add Entry, Notes and note reader — research and Figma pass.** Completed as a design/research handoff 4 October 2026; native implementation and real-iPhone validation remain items 23, 24, 26, 27 and 28 (U1/U9/U20).
  - **Superseded in part by item 43 on 4 October:** the first bottom action placement, name-derived History labels and record forms were revised after user review. Read item 43 and the refreshed handoff for the current proposal.
  - [x] [Header research and mockups](<../../../Research/Research Reports/Habit Details Research/Final UX Pass/README.md>) name the page, center icon/name/wrapping goal and time section, and show current/best streak facts with correct units or quit-run language. Tasks and Show Streaks are handled explicitly.
  - [x] History keeps its chronological month rows. **Find a day** now explains its exact-date Day-details destination; the separate record action names the habit-specific fact and uses a safe-area bottom position. The handoff labels this placement as a reasoned design choice needing later user/device validation.
  - [x] The [20 screen studies](<../../../Research/Research Reports/Habit Details Research/Final UX Pass/Wireframes.md>) cover Today/past amount, duration, repeated check, daily check and checklist routes, at-most amount, quit slip and skipped conflict. A focused form adds one record; binary/checklist/task correction reuses the accepted Day-details controls; the single-record editor stays separate (U15/U16/U19).
  - [x] Notes mockups give search full width, separate Add note, and cover empty/search-no-result states, note editor, note reader, More-menu deletion and confirmation. **Open day details** names the note's exact date and day activity.
  - [x] “Day details” is the shared destination label and accessible route; the sheet keeps its existing selected-day visible title (Today/date) and Close control. The earlier Day-details wireframes did not need a layout change; the reasoning is in the handoff.
  - [x] Three editable [Figma boards](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=433-2071) contain 20 native-layer screen studies. Twenty local PNG exports render in Markdown; all local links in the changed documentation resolved in the link audit. Rulebook U20, Design Rules, the research package index and the report index now point to this pass. Documentation publication follows T10 without an iOS CI tag.

- [x] **43. Revise the habit-details mockups to match the accepted Day-details and entry-editor designs.** User review, 4 October 2026; design/documentation pass only (U20/U21).
  - **Visual revision rejected and superseded by item 44:** blue chrome and inconsistent input controls were still present. Do not treat this item as user acceptance of those visuals.
  - [x] Removed History/Notes page-wide sticky bottom actions. Each tab now owns native-size actions in its scrolling content.
  - [x] Replaced name-derived History labels with fixed type labels, including Log time, Add check and Record slip. History still supports Today and exact past dates.
  - [x] Changed direct-date copy to explain that Choose date opens that habit's Day details with saved records or an empty day. A separate record-form picker returns to the unsaved form.
  - [x] Moved Edit note beside the note content. Existing-note editing has a bottom Delete note button; reader More and editor Delete lead to the same confirmation. New-note creation has no Delete.
  - [x] Reused the accepted entry-editor habit card/top Save form structure and copied the accepted daily, checklist and skipped Day-details layouts instead of inventing alternative controls.
  - [x] Updated the three existing Figma boards, exported 22 local screen PNGs, and revised the research handoff, Wireframes, Rulebook, Design Rules and indexes. Native implementation and iPhone validation remain separate work.

- [x] **44. Correct the habit-details studies to use the accepted visual system throughout.** Completed as a design/research revision, 4 October 2026; the revised proposal awaits user review and native implementation. Item 43's blue chrome and inconsistent value/date/note fields were not accepted.
  - [x] Re-read the repeated brief and current screenshots at Figma 420:2107; preserve the requested centered icon/name/wrapping goal and current/best streak header.
  - [x] Research action scope, date access, note creation and consistency; distinguish review evidence from reasoned layout choices.
  - [x] Match Day details 370:2031 and entry editor 408:2071: monochrome chrome, native-size controls, SF Pro, the same input boundaries, identity cards and spacing relationships (U1/U2/U17/U19).
  - [x] Refine History date/add controls and Notes search/add controls without a tab-dependent sticky footer or a row of oversized primary buttons.
  - [x] Make add-record forms familiar to the accepted editor, including tap-to-type duration fields and clear date selection, Today/past routes, limit/slip emphasis and existing Day-details correction.
  - [x] Refine the individual note reader/editor, keeping Edit near the note, confirmed Delete for an existing note and a recognizable link to its exact Day details.
  - [x] Update Figma mockups and portable Markdown exports, document why this revision supersedes prior choices, and validate structure, fonts, colors, visuals and links.

  - Evidence/rationale: [Consistency Revision](<../../../Research/Research Reports/Habit Details Research/Final UX Pass/Consistency Revision.md>). Three existing Figma boards and all 22 PNG exports refreshed; shared controls, SF Pro, monochrome chrome and readable text verified. Eight Markdown files, 300 local links, 22 image embeds/PNG hashes, Git whitespace and speed-rules checks passed. Publication follows T10 without an iOS CI tag. No app code or iPhone state changed.
