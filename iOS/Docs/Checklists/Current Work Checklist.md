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
  still resolve; give new items the next unused number (currently 43).
- Record the symptom, expected behavior and evidence for an issue; reproduce it on the current code before fixing.
  Record implementation progress separately from testing and the user's device review.
- Tick an item only when its required validation is complete, with the date and relevant commit, test or device
  evidence. Move its whole entry to Completed; retain decisions, partial completion and remaining checks.
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
  Implementation and device validation remain pending. **Built 4 October on branch `details-page-update`; see item 42.**
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

- [ ] **25. “What the squares mean”: expand automatically only on the first visit to each explanation context.**
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

- [ ] **26. History: fix the unreadable Add Entry button.** Added 4 October 2026; a readability issue independent of
  the action-placement research in item 27.
  - The user observes a white/light-gray button background with white text, making Add Entry illegible. Verify the
    current rendered appearance and fix the contrast in the actual button states.
  - Check light and dark mode and the real iPhone; the label must stay readable. Preserve the action's function.
    Moving the button to another location alone does not fix its text/background contrast.
  - Add Entry is appropriate in History; the user explicitly distinguishes this from the Today sheet problem in
    item 22. Do not solve this by removing History's Add Entry action.

- [ ] **33. Routine player: Habit options hides its last actions.** Documented on 4 October 2026 by the other
  agent on `claude/weekly-overview-stats-ly55gk` (`e657641`); formerly item 22 on that branch.
  - For Read, the sheet shows Log time manually, Skip today, Undo, Show clock and Add Note, but Edit Habit is only
    reachable after scrolling. Review whether the sheet should fit the complete options list; preserve every action.
  - The source branch reports a fix. It is not yet merged into main; verify the applicable build and required
    checks before marking this complete. Detailed requirement: routine-player checklist P5.
  - **Built, tested, merged (4 Oct 2026, the player's branch at `b6bd7d1`, then `main`):** FocusPlayer (13, including
    `testBottomRowStaysPutAndOptionsShowEverything`), Schedule, RoutineCalendar and Groups passed (31 tests), plus the
    classes that use switches elsewhere before `main` moved. Speed: the player's ‹ › 14.8 ms/s, no freeze. **Only the
    user's look on the iPhone (U9) is left;** tick it then and move it to Completed.

- [ ] **34. Routine player: Show clock switch is white/unreadable in dark mode.** Documented on 4 October 2026 by
  the other agent on `claude/weekly-overview-stats-ly55gk` (`e657641`); formerly item 23 on that branch.
  - Switches should use the system green style; selection checks use system blue. The branch reports a shared
    switch style and a correction to the group's habit picker selection controls; integration and verification on
    main remain pending. Detailed requirements: routine-player checklist P6–P7.
  - Keep this separate from item 22's Today-sheet green-checkmark concern: these are different controls and reports.
  - **Built, tested, merged (4 Oct 2026, the player's branch at `b6bd7d1`, then `main`):** FocusPlayer (13, including
    `testBottomRowStaysPutAndOptionsShowEverything`), Schedule, RoutineCalendar and Groups passed (31 tests), plus the
    classes that use switches elsewhere before `main` moved. Speed: the player's ‹ › 14.8 ms/s, no freeze. **Only the
    user's look on the iPhone (U9) is left;** tick it then and move it to Completed.

- [ ] **35. Today's swipe actions: an over-long swipe adds a note; reaching all three buttons takes care.** Added
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

- [ ] **37. Time limits ("Social media: 30 min max"): can't be edited, and should they exist? Decide, then add or
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

- [ ] **38. Today: a folded time of day's habit icons sit on the title's line, too close to it.** Added 4 October 2026,
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

- [ ] **11. Bug: the app sometimes stops responding for ~74 s right after launching signed in** (added 2 Oct, from the
  test runs). `BackupUITests.testDeletingTheAccountAndErasingThisPhone` launches with a test sign-in to the dev server;
  in 4 of 13 runs (1–2 Oct) the app didn't respond for about 74 s right after launch, before the test's first step
  (opening the ≡ menu), and the test failed; it passes on a rerun. Not caused by a test step: it happens before any.
  Suspects to check: something blocking the main thread during the sign-in at launch (the keychain, a network call
  waited on, the first backup or sync). Logs: run 36995529935 (`ios-logs` artifact, the test's lines at
  t = 24.86 s → 98.74 s). Find the cause, fix it, and make the test show where the time goes if it happens again.

- [ ] **17. Bug: the routine player's bottom spacing is wrong.** (added 3 Oct 2026) Fix the spacing at the bottom of
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

- [ ] **16. Timers and the Dynamic Island / Live Activity.** (added 3 Oct 2026) Starting a timer sometimes goes
  straight into the Dynamic Island. Keep it, but make it behave the way people expect, reliably, and add a way to
  turn it off. Research when it should appear, then fix.

- [ ] **18. Completion feedback for every kind of habit.** (added 3 Oct 2026) A check-off plays the sound (and haptic)
  when it's done, which is nice; timed habits, amounts, checklists and others don't. Decide when each kind counts
  as "done" for feedback (goal reached, timer reaches its goal, last step ticked) and make it consistent.

- [ ] **10. Groups: test them properly.** Making a group seems to work, but groups and their statistics (group
  chips on Progress, group numbers, the Filter's group choice, editing and ordering groups) were never really
  tested, on the simulator or the iPhone.

- [ ] **42. Build Day details and the one-log editor from the 4 October handoff.** Added 4 October 2026, from the
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
    - [ ] `DayDetailsUITests.testHistoryDaysOpenDayDetails`: an earlier day from History for an amount, time, check,
      checklist and weekly habit, with screenshots.
    - [x] Tested on GitHub Actions run `37220482604` (`5363659`), 4 Oct 2026: Core storage and migrations, build, Release build and 28/28 UI tests passed (DayDetails incl. `testTasksReschedule`, TodayRowLayout, TodayRowSheet, Undo, and the three task screenshot states). Screenshots: a weekly task's calendar offers only the days before next week's occurrence; a daily task and a done task show no Reschedule.
  - Not done, by design: a slip's **date** stays read-only until the store, repository and sync can move one record
    to another day atomically (D7; handoff). The bottom ‹ day › pager is gone (handoff; past days open from Today or
    History). A multi-check habit lost its whole-day Done switch (research matrix "Avoid"); History's Add Entry
    still adds several checks at once (U5).

## Planned improvements — build later

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
  - **Native implementation, 4 October:** built on branch `details-page-update` with item 22; tracked point by point in item 42.

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

- [ ] **9. Widgets: choose the habit, one widget per habit, and a visual overhaul.** Widgets work (free and Plus
  kinds), but adding a widget always shows one particular habit: there's no way to pick which habit, switch to
  another, or have, say, 4 of 6 habits on the Home Screen, one widget each. Make each widget configurable (pick the
  habit, or the habits for a bigger widget), and improve how widgets look: "right now they are not good". A widgets
  agent is starting on its own branch (2 Oct).

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

- [ ] **14. Cut-down habits (limits): where do they belong?** (added 3 Oct 2026) Keeping them inside the times of day
  feels weird. The user's thought: show them in the Quitting section instead. Research how people think of a limit
  ("cut down on coffee") next to quitting and next to build habits, then decide.

- [ ] **15. Timed habits: what should tapping ▶ do?** (added 3 Oct 2026) Today ▶ starts an inline timer on the row.
  Research whether that's what people expect, or whether ▶ should open a full-screen timer, or both (and which is
  the default).

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

Completed work retains its original evidence and any outstanding user review.

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
