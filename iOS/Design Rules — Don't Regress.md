# Design Rules — Don't Regress

Written by Claude (Claude Code), 28 September 2026. **Read this before changing any screen in the app.** Every rule below exists because an agent broke it once and the user had to catch it. Each rule links to the research behind it. If a rule has to change, change it here too, with the reason.

## How to work

| Rule | What went wrong |
|---|---|
| **Research first, then build; write down every point the user makes before starting** (a checklist file in `iOS/Docs/Checklists/`) | Points were dropped between turns |
| **Reports in plain English**, opening with "Written by …, date", and added to `Research/Research Reports/README.md` | A draft was written in mixed Telugu and English, with no index entry |
| **Never type a review ID from memory.** Copy it from a hit file and run `Research/Temp/goals/verify_ids.py <report>` before finishing | IDs were invented or truncated twice |
| **Never copy a competitor because it does something.** Say "users show…" (reviews) or "reasoned from first principles" | Decisions justified as "Habitify does X" |
| **A new feature must not remove an old one.** Before replacing a view, list what it showed and keep each item, or say why it goes | Adding ▶ to section headers deleted "N left" |
| **When labels change, update the UI tests that tap them** (`HabitsUITests/`) in the same change | `NewFlowUITests` kept looking for "A good habit" and the old stepper |
| **Check on screen, not only in code.** Screenshots via a UI test, at the real iPhone size, with the keyboard up where there's typing | The Unit row was hidden under the number keyboard; the read-back looked like a field |
| **Never `.fixedSize()` a text field.** Give it a min and max width. A field sized to its placeholder clips what's typed | "Typed amount doesn't show" (reported 28 Sep, Cut down's number row) |
| **Every typing field stays above the keyboard.** Put related fields on one row ("3 h 0 min"), and use Next/Done on the number pad, which has no return key | The Minutes field was hidden under the keyboard |
| **Never put `.toolbar`, `.onChange` or `.task` on a Form `Section`.** A Section repeats its modifiers once per row inside it. Put them on one row that's always there, or on the whole screen | Four Next buttons on the time keyboard (reported 28 Sep) |
| **A focus state doesn't reach a pushed screen.** A pushed screen that needs focus (Items, for example) keeps its own `@FocusState` | Add Item didn't put the cursor in the new item |
| **Test typing the way a person does:** tap the number keys one at a time and check the field after each (`GoalFlowUITests.testTypingKeyByKey`) | `typeText` passed while a person saw nothing |
| **Run UI tests on the real iPhone before saying done:** `Research/Temp/ios-device-all.sh` (all) or `ios-device-test.sh <Class>` | Simulator-only checks missed keyboard overlap |
| **Commit only when asked.** Never touch another agent's untracked files; leave them and say so | Two agents worked in the repo at once |

## New flow (+) copy

Source: [Habit Flow Copy — Deep Research Report](<../Research/Research Reports/Habit Creation/Habit Flow Copy — Deep Research Report.md>), whose opening table lists the first copy's mistakes.

- **Screen 1 names the user's intent**, with no examples: *What do you want to do?* → Build or maintain · Quit or cut down · Add a task. **Never "good habit" / "bad habit"**, and never "create a bad habit".
- **A phrase being frequent in reviews doesn't make it a good label.** Label the intent and the interaction.
- **An example is a real habit that can only be recorded one way:** Make your bed · Drink 8 glasses of water · Meditate for 10 minutes · Clean kitchen — dishes, sink, floor.
  - Avoid activities that are tracked several ways (reading: pages *and* minutes; walking: steps, minutes, times).
  - Never write an example as an instruction ("Record minutes spent reading").
- "Track an amount", not "Count it". Tasks: "No **habit** progress, streaks or stats."
- Icons on the choice rows are **monochrome** SF Symbols, one meaning each. Nothing that already means something in iOS or this app: `arrow.up.right` means "open a link", `minus.circle` means remove, `checklist` is the All habits button.

## Goal screen

Sources: [Goals — Periods, Entry and What + Adds](<../Research/Research Reports/Habit Creation/Goals — Periods, Entry and What + Adds.md>), [Goal Screen Round 2](<../Research/Research Reports/Habit Creation/Goal Screen Round 2 — Icons, Periods, Units and Copy.md>).

- **Goal counts over is a labelled menu:** A day · A week · A month · A year. The period says when quantities start again; it is not recurrence. Daily form-row values omit "a day"; period goals retain it. This supersedes the earlier unlabeled Daily/Weekly segments based on the supplied [Schedule and Goal research](<../Research/Research Reports/Habit Creation/Schedule and Goal — One Coherent System.md>).
- **Typed numbers, not wheels** for counts. Time: wheels plus a Type option. **No caps.** A number field **selects its value when tapped**, so typing replaces it.
- **No "Each tap adds" question.**
  - + adds 1 when the goal is whole and ≤ 10, or the unit happens one at a time (books, glasses…).
  - Otherwise + asks how much.
  - The Goal screen says which, before saving.
- **The goal is read back big at the top** ("8 glasses" / "a day"), never as a Form row at the bottom: a row looks editable, and the keyboard hides it. Keep the amount and unit above the number keyboard.
- **The unit is optional** (Track an amount): the read-back shows the number the moment it's typed ("8" / "a day"); a unit only adds its word; "No Unit" is a choice; Today shows "3/8". Never make the goal wait for a unit (reported 28 Sep).
- **Check it off stays Check it off, whatever the unit.** ✓ counts one; the unit only names it ("3/8 glasses"); whole numbers only; units that happen one at a time only.
- **Copy never says** due, overdue, missed, failed, minimum or "First period" (overdue and red labels stress people; ADHD reviewers praise shame-free apps). Say what **counts** and when it **starts fresh**, and name the user's own week start.
- **Units** are grouped by what people track (Drinking, Walking and running, Reading and writing, Exercise, Everyday, Money), with metric or imperial first by region. Making your own unit is a green ⊕ **Create Your Own Unit** row, the same pattern as Add Reminder.

## Schedule and Goal: one success clock

> **Round 3 proposal (28 Sep 2026, not built yet; replaces Round 2):** [Creating a Habit — Round 3, The User's Own Words](<../Research/Research Reports/Habit Creation/Creating a Habit — Round 3, The User's Own Words.md>). One form that reads back the habit as a sentence (Habit · How much · How often); Schedule and Goal become one **How often** list; the type screen goes; **+ always says what it adds**, replacing `CountLogging.quickIncrement`; "times" counts every time and "days" counts days. If it is approved, its §6 lists the rules in this file that change (Goal screen, Logging a count, Flexible schedules). Until then the rules below describe what is built. Ask the user before building.
>
> **Round 2 proposal (28 Sep 2026, superseded by Round 3, never built):** [Schedule and Goal — Round 2, Making It Intuitive](<../Research/Research Reports/Habit Creation/Schedule and Goal — Round 2, Making It Intuitive.md>) settles this section in one rule: **Schedule says which days the habit is on your list; the Goal says what counts and over what period; Schedule never counts.** It removes "A number of days" from Schedule and every confirmation alert, and keeps weekly, monthly and yearly goals for every type, Check it off included. Ask the user before building either version.

Source: [Schedule and Goal — One Coherent System](<../Research/Research Reports/Habit Creation/Schedule and Goal — One Coherent System.md>), supplied by the user and archived 28 September 2026. This supersedes conflicting earlier Repeat/Goal guidance.

- **Schedule owns calendar days; Goal owns quantity.** Keep both form rows visible. A longer Goal shows Schedule as "Any day this week/month/year".
- **Never silently replace a schedule.** Confirm before moving a daily goal to an aggregate period; retain its inactive Schedule draft. Returning to daily offers restoration or Every day. Editing Schedule from a period goal confirms the move back to daily.
- **Flexible schedules count different dates, never taps.** Check, amount, time and checklist all support N days/week/month/year. A day qualifies only after reaching its daily goal. More logs on that date never earn a second day. Extra qualifying days remain loggable after the quota.
- **One check-off per week/month/year canonicalises to one flexible day**, with explicit confirmation. Higher period counts can count multiple logs on the same date. Never reinterpret an existing saved period count as a distinct-day quota.
- **Four main choices:** Every day, Specific days, Every…, A number of days. Parameters expand immediately after the selected choice. Keep the read-back and explanation above them.
- **Specific days starts with the Starts-date weekday.** Keep at least one selected; selecting all seven canonicalises to Every day. Full VoiceOver weekday labels, 44-point targets, large-text vertical layout, and a visible checkmark distinguish selection.
- **Starts is the recurrence anchor.** Show it and the next generated occurrence for interval rules. Every-N-weeks stores its anchor week start, so changing display week start cannot shift it. Flexible weekly quotas and aggregate Goals use the current user preference.
- **Monthly/yearly recurrence is explicit:** selected dates, last day, ordinal weekday, month/year intervals; shorter-month and leap-day fallback/skip policies are visible. Off-days stay neutral. Schedule copy does not explain streaks or deadlines.
- **Cut down has Limit, not Goal or Schedule.** Its day/week/month period belongs to Limit. Today says "logged · limit", never a target to reach.
- **Tasks can repeat after actual completion.** Fixed recurrence remains available; completion-relative recurrence is not offered for habits.
- **Research recommendations are not usability results.** The proposed participant study remains unperformed; simulator tests do not establish comprehension rates.

## Logging a count

Source: [Logging a Count — One Tap or Type](<../Research/Research Reports/Habit Creation/Logging a Count — One Tap or Type.md>).

- **The button says what it does:** "+1" adds one (quick counts); "+" opens Add Amount. Never two habits with the same-looking button that behave differently.
- **Tapping the habit row always opens Add Amount / Add Time** for count and timed habits.
- **Don't** make every + open the input, and **don't** make the input full screen: those are Loop users' top complaints. Add Amount is a sheet, with the number pad up and "Add … again" (the last amount) as one tap. Units never read "1 glasses".

## Timing a habit

Source: [Timing a Habit — Start, See and Stop](<../Research/Research Reports/Habit Creation/Timing a Habit — Start, See and Stop.md>).

- **▶ starts the timer in place, for any goal length.** Never open a full-screen timer for one habit: full screen belongs only to the routine player (Start on a section). Being sent to a timer screen is a top complaint.
- **A running timer must be visible**:
  - The row's line is a live clock, redrawn every second: "7:42/20 min" (`goalLine(running:)`).
  - When the row is off screen or folded, a timer bar sits at the bottom of Today (`TimerBar`).
  - Outside the app, a Live Activity shows it (`TimerPresence`; the `HabitsLiveActivity` extension).
  - Never show only ▶ turning into ⏸.
- **Keep the `TimelineView` inside the timed row itself.** A `TimelineView` higher up doesn't reliably redraw child rows whose inputs didn't change. And whole minutes hide a running timer for its first minute. Together these caused the "nothing moves" report (28 Sep).
- **One notification when the goal is reached, never repeats or per-second pings.** The timer keeps counting past the goal.
- **The Live Activity ends the moment the timer stops.** One left behind looks like time still counting.
- **Time is counted from the saved start time, never by ticking.** So it survives closing the app and restarting the phone.
- **A timer is never the only way.** Tapping the row opens Add Time. ⏸ saves what was done; sessions add up.
- The clock counts up, with the goal beside it. The row's fill shows what's left.

## Today section headers

Source: [Section Header — Start Button, Left Count and Icons](<../Research/Research Reports/Home Screen and Visual Design/Today Screen Top Area/Section Header — Start Button, Left Count and Icons.md>).

- **"N left" is always shown**, open or folded. It's what people open the app to see. **Never replace it with a button.** Done is a ✓ (VoiceOver says "All done").
- **Start:**
  - "▶ Start" in open sections.
  - Folded, ▶ appears **only on the Now section**.
  - **The Now button is primary** (filled ink); others are grey.
  - Start is today only, never on Quitting.
- Space order: status and Start never shrink; the name gives way first; the icons take the rest and end in "+N".

## Text lengths

Source: [Name, Unit and Time of Day Lengths](<../Research/Research Reports/Habit Creation/Name, Unit and Time of Day Lengths.md>).

- **Limits:** names **24**, checklist items **24**, times of day **16**, units **12** (`TextLimit`). Don't raise them to "just in case" sizes: 100 is how pasted paragraphs broke layouts. Don't cut below 20 either: reviewers complain about 20.
- Show "N characters left" only in the last 5. Never truncate text that's already saved.

## Calendar and Back to Today

Source: [Back to Today — When and Where](<../Research/Research Reports/Home Screen and Visual Design/Today Screen Top Area/Back to Today — When and Where.md>).

- **Every shape in the calendar is round.** The open day is a filled circle inside its ring, never a square.
- **"Back to Today" shows only while another day is open.** It sits at the **bottom**: above the day bar on Today, and pinned at the bottom of the calendar sheet. There's no always-on Today button at the top.

## Not designed yet: don't test

- **The routine player** (the full-screen view that Start opens) isn't designed properly yet (the user, 28 Sep). Don't write new tests for it or judge its layout. Existing routine tests check only the underlying logic (skip, finish, resume). Redesign it before testing its UI.

## Where the rest is

- Everything decided about creating and editing a habit: [New Habit Goal and Time of Day.md](<Docs/Specs/New Habit Goal and Time of Day.md>).
- Today's other rules: [Today Improvements.md](<Docs/Specs/Today Improvements.md>) (partly superseded; see its notes).
- User checklists behind each round: `iOS/Docs/Checklists/Goal and Choice Screens — Round 2 Checklist.md`, `iOS/Docs/Checklists/Section Header — Start and Left Checklist.md`.

## Tests retired on 28 Sep, and why (don't bring them back)

These UI-test checks described behaviour the spec replaced. They were rewritten to the current rules, not deleted silently:

| Old check | Replaced by |
|---|---|
| A habit in two parts of the day gets a separate tick in each (`slot` ticks) | The same row in each part, **one shared progress** (spec §5); `PlacementCheck` and `NewHabitUITests.testCheckOffInTwoTimesOfDay` check it |
| An amount or weekly habit shows as one row even with two parts | It shows in each chosen part, like every type |
| Reminder times place a habit ("set by the times"); removing the last time keeps its section | Reminders never move a habit; Time of Day alone places it |
| A folded section keeps ▶ | ▶ only on the folded **Now** section; open sections show "▶ Start" |
| The first screen lists every type ("Count an amount", "Set a limit", "To-do") | Two questions: Build or maintain / Quit or cut down / Add a task, then the type |
| Goal stepper, "Each tap adds", "Add 1k to Walk" | Typed goal; the automatic + rule (Walk's 8,000 steps asks how much) |

## Test status (28 Sep 2026, iPhone 16, iOS 26.6)

- **UI tests (`HabitsUITests`): all 40 pass on the phone.**
  - Full runs: 16/42 passed at first, then 29/40 after the stale tests were rewritten.
  - After that, only the failing tests were rerun until each passed; passing tests weren't rerun.
  - Every failure now saves a screenshot of the moment (`override func record` in each test class).
- **Core (`Core`, `./gradlew jvmTest`): 11/11 pass** (migrations and the repository).
- **App bugs found and fixed by this run:**
  - four Next buttons on the time keyboard;
  - Minutes hidden under the keyboard (now one row, "3 h 0 min", with Next);
  - Add Item didn't focus the new item;
  - saving a New Time of Day skipped the list;
  - Cut down's number field could clip typed digits.
- **Why most failures were in the tests:** they still expected round-2 to round-5 screens; see "Tests retired" above. Two tests also matched text too loosely: "Quit" matched the Quitting header, and a row's line also carries its reminder time ("0/2 items · 9:00 AM").
- **Run them:** `Research/Temp/ios-device-all.sh` (all) or `Research/Temp/ios-device-some.sh <outdir> <Class/test> …` (some). Keep the phone unlocked and connected.
