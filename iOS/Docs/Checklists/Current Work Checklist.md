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
  still resolve; give new items the next unused number (currently 33).
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
  user's observation; implementation, current-code verification and validation are pending.
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

- [ ] **11. Bug: the app sometimes stops responding for ~74 s right after launching signed in** (added 2 Oct, from the
  test runs). `BackupUITests.testDeletingTheAccountAndErasingThisPhone` launches with a test sign-in to the dev server;
  in 4 of 13 runs (1–2 Oct) the app didn't respond for about 74 s right after launch, before the test's first step
  (opening the ≡ menu), and the test failed; it passes on a rerun. Not caused by a test step: it happens before any.
  Suspects to check: something blocking the main thread during the sign-in at launch (the keychain, a network call
  waited on, the first backup or sync). Logs: run 36995529935 (`ios-logs` artifact, the test's lines at
  t = 24.86 s → 98.74 s). Find the cause, fix it, and make the test show where the time goes if it happens again.

- [ ] **17. Bug: the routine player's bottom spacing is wrong.** (added 3 Oct 2026) Fix the spacing at the bottom of
  the routine (focus) player's screen; check on the iPhone (U9).

- [ ] **16. Timers and the Dynamic Island / Live Activity.** (added 3 Oct 2026) Starting a timer sometimes goes
  straight into the Dynamic Island. Keep it, but make it behave the way people expect, reliably, and add a way to
  turn it off. Research when it should appear, then fix.

- [ ] **18. Completion feedback for every kind of habit.** (added 3 Oct 2026) A check-off plays the sound (and haptic)
  when it's done, which is nice; timed habits, amounts, checklists and others don't. Decide when each kind counts
  as "done" for feedback (goal reached, timer reaches its goal, last step ticked) and make it consistent.

- [ ] **10. Groups: test them properly.** Making a group seems to work, but groups and their statistics (group
  chips on Progress, group numbers, the Filter's group choice, editing and ordering groups) were never really
  tested, on the simulator or the iPhone.

## Planned improvements — build later

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
