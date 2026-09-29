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

## New Habit form (Round 3, built 29 Sep 2026)

Source: [Creating a Habit — Round 3, The User's Own Words](<../Research/Research Reports/Habit Creation/Creating a Habit — Round 3, The User's Own Words.md>), from [How People Describe a Habit](<../Research/Research Reports/Habit Creation/How People Describe a Habit — 4,407 Descriptions From Reviews.md>). Checklist: `Docs/Checklists/Round 3 Build — Copy, Days, Dates and Limits Checklist.md`.

- **Build or maintain opens one form. There is no type screen** (Check it off · Track an amount · Time it · Checklist are gone). How much decides it: no amount → ✓; the Time unit (hours and minutes) → ▶; any other unit → +; Steps → a checklist.
- **The habit is read back as a sentence, big, at the top** ("Read 2 chapters a week", "Gym every Monday and Wednesday"), with its time of day under it. It's built from the same saved habit Today shows (`HabitCopy.sentence`).
- **Rows:** Habit (name, icon, colour) · How much (or Limit for Cut down) · Each + adds (amounts only) · How often · Steps (Just do it only) · Time of Day · Dates · Reminders. The line under How often says what Today will show and what one tap does.
- **How often is one list of sentence endings with the person's amount in them** ("2 chapters a week", "5 km on 3 days a week", "every Monday and Wednesday"). No pop-ups, no confirmations, nothing greyed out: every choice is a whole sentence. Schedule and Goal are no longer two rows.
- **"Times" counts every ✓; "days" counts different days.** "3 times a week" (`.perWeek(3)`): two walks on Sunday count 2. "3 days a week" (`.flexible(.week, 3)`): they count 1. An amount on some days counts the days it's reached ("5 km on 3 days a week"). *Supersedes "Flexible schedules count different dates, never taps".*
- **An amount with "a week / a month / a year" is a total**; with "N days" it's each of those days. The sentence says which.
- **Not built, on purpose:** the "say it" fill-in (typing "Run 5 km 3 times a week" into the name: it fights the 24-character name limit, and review evidence for it in habit apps is 5 reviews); an amount "each time, N times a day" (it needs a new stored field). Both are in the Round 3 report.
- **Kept from before:** typed numbers select on focus; time is wheels plus Type; the unit is optional; units grouped by what people track, with ⊕ Create Your Own Unit, and **time first** ("Hours and minutes", the most common amount); copy never says due, overdue, missed, failed or minimum; Cut down's limit is a day, a week or a month.
- **Set days, kept from the Schedule rules** ([Schedule and Goal — One Coherent System](<../Research/Research Reports/Habit Creation/Schedule and Goal — One Coherent System.md>)):
  - Certain days start with the start date's weekday and keep at least one chosen; all seven become Every day. Full VoiceOver day names, 44-point targets, a vertical layout at large text sizes.
  - The start date anchors "every few days or weeks" (shown as "Counted from"), and the next date is shown ("Coming up: Thu 2 Oct").
  - Monthly and yearly dates say what short months and 29 February do, and let the person choose (use the last day, or skip).
  - Tasks can repeat "after it's done"; habits can't (fixed rhythms only).
  - Research recommendations are not usability results: no participant study has been run.

## Habit copy: say it the way people do (built 29 Sep 2026)

The user's rule: **the copy is the value.** Whatever is picked must read the way a person says it, on the form and on Today.

- **One home: `Habits/Model/HabitCopy.swift`.** The read-back, the How often row, Today's line, a task's How often and the reminders all use it. Never build a habit sentence anywhere else.
- **Days of the week** (in the user's week order): 7 → "every day"; Mon–Fri → "on weekdays"; Sat+Sun → "on weekends"; 6 → "every day except Sunday"; **one unbroken run of 3 or more → a range, "every Sunday to Thursday"** (also across the week's end: "every Friday to Monday"); 5 that aren't one run → "every day except Thursday and Saturday"; otherwise every day named: "every Monday, Wednesday and Friday". Today uses short names: "Every Mon and Wed".
- **Dates of the month:** "on the 1st and 15th of every month"; runs of 3+ → "the 1st to 5th"; with a range, each part gets "the" ("the 1st to 3rd and the 15th"); the 31st with "use the last day" → "on the last day of every month"; odd or even dates by name; more than 6 separate dates → "on 7 dates each month" (the grid shows them); 28 or more → "every day except the 31st"; all 31 → "every day".
- **Numbers in sentences are whole and grouped** ("10,000 steps", "2,000 ml"); "k" only on Today's progress line. A count of one is never plural ("1 glass", "1 push-up"). A name that is the unit isn't said twice ("100 push-ups a day").
- **To change the copy:** change `iOS/Tools/copy_oracle/copy_oracle.py` and `HabitCopy.swift` the same way, read the print-outs, regenerate `CopyCheckCases.swift`, and run `NewHabitUITests/testCopyChecks` (the `-copycheck` launch shows "Copy: all checks passed" or the phrases that differ). The oracle's print-outs are the review sheet.

## Logging a count

Source: [Logging a Count — One Tap or Type](<../Research/Research Reports/Habit Creation/Logging a Count — One Tap or Type.md>), updated by Round 3 §2.7.

- **+ always adds the step saved with the habit and says it** ("+1", "+250", "+1k" on the button; "Add 250 ml to Water" for VoiceOver). *Supersedes "No 'Each tap adds' question" and "+1 adds one; + opens Add Amount": `CountLogging` and its goal-size rule are gone.*
- **The step is a row on the form, "Each + adds", filled in for the person, never a question.** Suggested: the amount itself when it's per day on some days; a glass for drinks (250 ml, 8 oz, 0.25 L); 1 for whole counts up to 20; 1 km or mile; otherwise a round tenth of the goal (10,000 steps → 1,000). The person's own step is kept.
- **Tapping the habit row always opens Add Amount / Add Time** for amounts and timed habits (unchanged), with "Add … again" and Undo Last Entry on touch-and-hold.
- **Don't** make every + open the input, and **don't** make the input full screen. Units never read "1 glasses".

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
- **Checked again 29 Sep** (the user: "around 20 for names, 12 for units, or whatever is best"): **kept at 24 and 12.** With Round 3 the goal and rhythm leave the name, so names get shorter anyway; 87% of quoted names fit 20 even with goals written in, and 20 is the one limit reviewers complained about. The longest sentence, a 24-character name with a 12-character unit, is covered by `CopyCheck` and `LongTextUITests`.

## Calendar and Back to Today

Source: [Back to Today — When and Where](<../Research/Research Reports/Home Screen and Visual Design/Today Screen Top Area/Back to Today — When and Where.md>).

- **Every shape in the calendar is round.** The open day is a filled circle inside its ring, never a square.
- **"Back to Today" shows only while another day is open.** It sits at the **bottom**: above the day bar on Today, and pinned at the bottom of the calendar sheet. There's no always-on Today button at the top.

## Not designed yet: don't test

- **The routine player** (the full-screen view that Start opens) isn't designed properly yet (the user, 28 Sep). Don't write new tests for it or judge its layout. Existing routine tests check only the underlying logic (skip, finish, resume). Redesign it before testing its UI.

## Where the rest is

- Everything decided about creating and editing a habit: [New Habit Goal and Time of Day.md](<Docs/Specs/New Habit Goal and Time of Day.md>) (its §1 screen 2 and §3 are replaced by Round 3, above).
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
| The type screen (Check it off · Track an amount · Time it · Checklist); the Goal and Schedule screens; "Goal counts over", "A number of days", the "Use 1 day a week?" and "Use Any Day?" alerts (29 Sep) | One form: How much and How often (`GoalFlowUITests`, `ScheduleUITests` and `NewHabitUITests` rewritten to it) |
| + adds 1 or asks how much, by goal size ("Add amount to Walk") (29 Sep) | + adds its saved step ("Add 1,000 steps to Walk"); the row opens Add Amount |
| "Items", "Add Item" for a checklist (29 Sep) | "Steps", "Add Step"; Today reads "0/2 steps" |

## Test status

- **29 Sep 2026: Round 3 is built but not yet compiled or run.** The cloud session that built it has no Swift toolchain (download.swift.org is blocked there). The copy rules were checked in Python against every case (`iOS/Tools/copy_oracle`), and the Swift files were parsed for syntax; the first step on a Mac is to build, then run `NewHabitUITests/testCopyChecks` and the rewritten `NewHabitUITests`, `GoalFlowUITests` and `ScheduleUITests`.

### 28 Sep 2026, iPhone 16, iOS 26.6

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
