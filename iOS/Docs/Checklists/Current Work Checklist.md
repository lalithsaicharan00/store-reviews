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
  still resolve; give new items the next unused number (currently 74).
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

- [ ] **23. Restore streaks on the habit details page.** Added 4 October 2026; a standalone task, not a subtask of
  the header, Overall Record or milestone redesign.
  - The user reports streaks used to be visible on this page and were removed during the redesign. Check the earlier
    presentation and current code, then restore a clear, visible streak presentation.
  - Preserve the correct meaning for each supported habit and frequency; do not silently label weekly/monthly
    success as a daily streak. Record what was restored and verify its values against the existing streak logic.
  - This remains open even if another design item touches the same screen. Documentation does not confirm the
    regression has been reproduced or fixed.
  - **5 Oct placement research (item 48):** Current/Best belong visibly in the early individual habit Progress summary, not the common header above History/Notes; retain Today's quick streak access, correct units and Show Streaks. The six existing design studies now reflect that recommendation. This does not close the native implementation/correctness check in item 23.

- [ ] **25. “What the squares mean”: expand automatically only on the first visit to each explanation context.**
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

- [ ] **26. History: fix the unreadable Add Entry button.** Added 4 October 2026; a readability issue independent of
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

- [ ] **18. Completion feedback for every kind of habit.** (added 3 Oct 2026) A check-off plays the sound (and haptic)
  when it's done, which is nice; timed habits, amounts, checklists and others don't. Decide when each kind counts
  as "done" for feedback (goal reached, timer reaches its goal, last step ticked) and make it consistent.
  - **The user's words, 5 Oct, tidied:** "Overall completion only: the 4th of 4 steps; the log that crosses an amount
    of 10, even to 11; the same for time, typed time included. Never for quit habits or Log Slip."
  - **Built, 5 Oct 2026** (branch `claude/timer-swipe-limits-and-fixes`; checklist [Completion Sound, Squares Key and Notes Months — 5 Oct](<Completion Sound, Squares Key and Notes Months — 5 Oct.md>)): the store
    decides for every log from any screen; once, on the log that makes the habit complete; a running timer at its
    goal; never for quit habits or limits. Tests: pending (`CompletionFeedbackUITests`).

- [ ] **53. `GroupsUITests.testGroupOrderIsThePersonsOwn` fails on `main` now and then (three nights in a row): the dragged group doesn't move.**
  Added 6 October 2026 by Claude (Claude Code); found by the full test for items 50–52, not by the user. Not caused by
  that branch: `main` itself (`f0e52f4`) fails it the same way (run `37400560919`).
  - **Evidence:** the same test code (with 5 Oct's held drag, `6c749f8`) passed on `main` at 12:31 UTC (run
    `37298794001`) and failed at 00:40, 01:24 and 02:03 UTC (runs `37390751325`, `37395447112`, `37400560919`); before
    the held drag it also failed once at 05:07 UTC. The screenshot after the drag shows Groups still A to Z ("A to Z.
    Drag a group…"), so the list never took the drop, or `moveGroups` didn't save it.
  - **Then passed** at ~04:00 UTC on the same branch (run `37410173465`), so it's intermittent, not only at night.
  - **To do:** find what makes the drop miss (machine speed, the drag's timing); don't loosen the test (T2).

- [ ] **49. Speed: Today, the habit form and Progress got slower on `main`.** Found 5 October 2026 by the full test of
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

- [ ] **28. Notes: research the Add Note button's placement.** Added 4 October 2026; separate from History actions.
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

- [ ] **29. Redesign the Overall Record card.** Added 4 October 2026.
  - The Overall Record card in the habit details Progress tab does not look good to the user; improve its visual
    hierarchy and presentation. Record any applicable equivalent in the main Progress page when assessing scope.
  - Make the information feel deliberately designed, with clear grouping, spacing and readable numbers/labels.
    Preserve the useful record/statistics content and correctness for each habit type.
  - This is independent of restoring streaks (item 23), Milestones (item 30) and period-card padding (item 31).

- [ ] **30. Improve the Milestones design — later work.** Added 4 October 2026; explicitly noted by the user as
  something to work on later, but definitely needed.
  - The current Milestones presentation looks basic and dull. Improve the card/section design and hierarchy so
    milestones feel meaningful and visually considered, consistent with the app's style.
  - Preserve the existing achieved/upcoming milestone information and its meaning; do not treat the visual
    criticism as a request to change milestone rules. Review any relevant Milestones presentation in Progress and
    the habit details Progress tab.
  - Keep this a separate open task. Do not mark it done because Overall Record or Week/Month/Year spacing was fixed.

- [ ] **31. Improve Week, Month and Year card padding and spacing.** Added 4 October 2026; review the main Progress
  page and the habit details Progress tab wherever these period cards appear.
  - **Week:** the “Week” heading is almost against the card's top edge; the top padding is too small and looks poor.
    Increase the breathing room above the heading and improve spacing between the card's internal elements.
  - **Month:** the same top-edge/padding concern applies. Review both heading inset and the spacing of the content.
  - **Year / Year in Pixels:** improve spacing and hierarchy here too, so the card/grid and its labels feel balanced.
  - Apply consistent spacing rules across the period cards, adapted to their content. Check card boundaries,
    heading-to-content gaps and internal alignment, not only one top padding value. Preserve statistics and square
    meanings. Verify on the iPhone, including larger text and light/dark mode.
  - Keep the accordion behavior (item 25), all-date labels (item 32), Overall Record and Milestones separately tracked.

- [ ] **32. Year in Pixels: show every day-number label from 1 through 31.** Added 4 October 2026.
  - Currently only selected numbers such as 1, 5, 10, 15, 20, 25 and 30 are shown. The user wants all day numbers
    visible: 1, 2, 3 … 31, including the currently omitted dates and 31 itself.
  - Keep the labels aligned with the correct day rows/squares and readable. Coordinate the layout with the spacing
    work in item 31; do not satisfy it by crowding or overlapping labels.
  - Preserve the correct treatment of shorter months and leap years; showing row labels 1–31 does not make an
    invalid date a recorded day. Review every relevant Year in Pixels instance in Progress and habit details.
  - Verify all 31 labels are present and that existing values, square meanings and accessibility remain correct.

- [ ] **3. Account out of Backup & Export.** Backup & Export holds only backup and export (the backup account it
  uses can stay there). Making an account, signing in and deleting the account are not backup things.
  - Account up front: the ≡ sidebar shows the account state, at the bottom or wherever fits, e.g. "No account"
    with a clear "Create an account". Research where it goes and what it says.

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

## Completed

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
