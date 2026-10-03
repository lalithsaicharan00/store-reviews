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

## Speed: moved to [`PERFORMANCE.md`](PERFORMANCE.md) (30 Sep 2026)

**The bug (29 Sep 2026):** in the routine player, Pause, ‹ ›, and "Anytime ⌄" lagged, and Pause showed a strange fade. The buttons were native; the cause was **redrawing**. Today, hidden behind the full-screen player, sat inside one `TimelineView` that ticked every second while any timer ran, so every row, streak and the toolbar were recalculated every second and on every tap. Taps waited behind that work, and the pressed (half-faded) button stayed on screen until they were handled. Measured with `sample`: main thread ~22% busy before, ~2% after. Full write-up: `Docs/Checklists/Focus Player — Speed and Responsiveness.md`.

These rules apply to **every screen**, not just the player:

| Rule | Why |
|---|---|
| **Never put a ticking `TimelineView` (or timer) around a whole screen or list.** Only the small view that shows the time ticks (the clock, a running row, the timer bar). The screen itself redraws once a minute, or at the exact moment something changes (e.g. `TodaySchedule`: at a timer's goal time) | A whole-screen tick recalculated every row every second |
| **A screen that's covered stops drawing.** Under a full-screen cover (or anything that hides it), show a plain background until it's uncovered, and bring the person back to where they were | Today redrew behind the player on every tap |
| **Never switch a view between a `TimelineView` and a plain view** (e.g. running vs paused). Keep one `TimelineView` and change its schedule (paused = a schedule that never ticks) | SwiftUI rebuilt the circle on Pause, so its text faded in again |
| **No `TimelineView` around a list at all, even one that ticks once a minute.** Keep the time in `@State` and move it on with a `.task` that sleeps until the next moment (Today's `tick()`) | SwiftUI marks everything inside a `TimelineView` as changed on every frame while the list scrolls: scrolling Today kept the main thread 55% busy (30 Sep) |
| **State that changes while scrolling (rows on screen, scroll position) never lives in the screen's own `@State`.** Put it in a small `@Observable` object that only the view needing it reads (`VisibleRows` → `HiddenTimerBars`) | Each row's `onAppear` rebuilt every section of Today, with every streak (30 Sep) |
| **Counts read one habit's entries, never the whole list** (`HabitStore.entries(of:)`, grouped by habit) | A streak checked every past day against every entry ever logged |
| **Never anchor a `TimelineView` at `.now` or `.distantPast`.** Use a fixed date (the timer's start, or one set once) | `.now` makes a new schedule on every redraw; `.distantPast` replays missed ticks and froze the app (28 Sep) |
| **A line that comes and goes keeps its space** (hide it with opacity, don't remove it), so nothing else jumps | "Paused" appearing pushed the icon and clock up |
| **Heavy numbers (streaks, period counts) are never worked out every second.** Work them out when the data changes | `streak` and `isDayMet` for every row were the top cost |
| **Measure speed on GitHub, not the MacBook** (the user's battery, 30 Sep): push with `[ios-perf]`; the app drives itself with no XCTest attached (`PerfDriver`, `Tools/perf/measure_perf_driver.sh`, rules in `PERFORMANCE.md`), and the table lands in `ci-results/latest.md`. `[ios-perf-xctest]` runs the older XCTest speed tests (`PerformanceUITests`, `Tools/perf/measure_perf.sh`), kept only for screens with no `PerfDriver` scenario yet (Progress, Groups, Backup, Tasks, Reminders); XCTest's own screen reading inflates those numbers, so compare them only with each other | The 30 Sep lag showed as redraw 47 % → 3 % after the fix; XCTest's screen reading was up to 79 % of the main thread (merge, 1 Oct 2026) |
| **A screen whose rows change size a lot at once (Progress's Week ↔ Month) is a `ScrollView` of grouped cards with a `LazyVStack`, not a `List`.** Never put a lazy grid inside a `List` row, and give strips fixed sizes | Switching Progress to Month sent the `List`'s collection view into an endless self-sizing loop: it crashed with a layout assertion, then hung (CI, 30 Sep 2026) |
| **Check speed by measuring, not by screenshots.** On the simulator, run `sample <pid> 15 1 -file out.txt` while tapping by hand, and look at how busy the main thread is and which of the app's functions show up. The simulator tool's screenshots lag the tap, so they can't time anything | Screenshots made fixed taps look slow, and slow ones look fine |

More speed rules (what's remembered, taps before writes, the optimised phone build, the app-driven speed runs) are in [`PERFORMANCE.md`](PERFORMANCE.md), from the undo and speed work of 30 Sep. Both apply to the whole app.

## New flow (+) copy

Source: [Habit Flow Copy — Deep Research Report](<../Research/Research Reports/Habit Creation/Habit Flow Copy — Deep Research Report.md>), whose opening table lists the first copy's mistakes.

- **Screen 1 names the user's intent**, with no examples: *What do you want to do?* → Build or maintain · Quit or cut down · Add a task. **Never "good habit" / "bad habit"**, and never "create a bad habit".
- **A phrase being frequent in reviews doesn't make it a good label.** Label the intent and the interaction.
- **An example is a real habit that can only be recorded one way:** Make your bed · Drink 8 glasses of water · Meditate for 10 minutes · Clean kitchen — dishes, sink, floor.
  - Avoid activities that are tracked several ways (reading: pages *and* minutes; walking: steps, minutes, times).
  - Never write an example as an instruction ("Record minutes spent reading").
- "Track an amount", not "Count it". Tasks: "No **habit** progress, streaks or stats."
- Icons on the choice rows are **monochrome** SF Symbols, one meaning each. Nothing that already means something in iOS or this app: `arrow.up.right` means "open a link", `minus.circle` means remove, `checklist` is the All habits button.

## New Habit form (Round 3 built 29 Sep 2026; Round 4 layout the same day)

Source: [Creating a Habit — Round 3, The User's Own Words](<../Research/Research Reports/Habit Creation/Creating a Habit — Round 3, The User's Own Words.md>), from [How People Describe a Habit](<../Research/Research Reports/Habit Creation/How People Describe a Habit — 4,407 Descriptions From Reviews.md>). Checklists: `Docs/Checklists/Round 3 Build — Copy, Days, Dates and Limits Checklist.md` and `Docs/Checklists/New Habit Form — Round 4, Artifact Layout and Smart Defaults Checklist.md`.

- **Keep the type screen** (the user, 29 Sep): New → Build or maintain → *How do you want to track it?* (Check it off · Track an amount · Time it · Checklist) → the form. *Round 3 removed it; the user brought it back.* The form shows only the rows that type needs.
- **Two steps, not one screen** (tried on the phone 29 Sep and rejected: switching How much inside one form kept changing the rows). Check it off has no How much and no Steps; Track an amount has How much; Time it has How long; only Checklist has Steps.
- **Two previews at the very top, together:** a centred "Preview" label over the habit drawn by Today's own row (`HabitRow`, taps off), and the text preview right under the card (its footer, no gap). Before a name the text reads "Enter a habit name to see the preview."; with a name, the whole sentence.
- **Screens the form opens** head with just the rhythm until there's a name ("Every day", "3 times a week", "8 glasses a day"), then the whole sentence with the name and time of day.
- **One sentence says the whole habit, including the parts of the day:** "Read twice a day, morning and afternoon", "Walk 10,000 steps a day, anytime". It heads the form **and every screen the form opens** (How much / How long, How often, Steps, Time of Day, Reminders, Starts, Ends), so each choice is read where it's made. *The Today-row preview was removed once on 29 Sep, then brought back above the text by the user the same day.*
- **Reminders are off by default** (the user, 29 Sep; replaces "on by default with one reminder", 28 Sep). Turning them on brings one per chosen time of day.
- **The sentence is built from the same saved habit Today shows** (`HabitCopy.sentence`, plus the parts of the day).
- **On every screen the form opens, the sentence is pinned at the top** (`stickySentence`: a bar that stays while the choices scroll; the user, 29 Sep).
- **Layout (the Round 3 mockup's form board):** previews · name, Icon | Colour · How much (Track an amount), How long (Time it), Steps (Checklist only), Limit (Cut down) · Each + adds (amounts only) · How often · then Time of Day and Reminders · then Starts and Ends. No explanation lines under the rows.
- **A weekday of the month is one phrase row: "The [first ▾] [Saturday ▾] of the month."** The first menu is which one of that weekday in the month (first to fifth, or last: a weekday comes 4 or 5 times a month); the second is the weekday, all seven. Two separate rows, "Which" (six options) and "Day", looked like a mistake (29 Sep).
- **Reminders open their own screen**; the row says when ("9:00 AM", "Off").
- **Starts reads "Today"** (or "Tomorrow", "Wed 1 Oct") and **Ends reads "Never"**; each opens its own screen with a calendar.
- **Defaults only where one value fits most people:** How often = Every day, Time of Day = Anytime, Starts = Today, Ends = Never, Reminders = Off. **Amounts start empty** and are simply left out until typed: the text reads "Drink water every day, anytime" and the card has no line (**no "—" anywhere**, the user, 29 Sep, so every type reads the same); the card's name shows "Your habit" until one is typed; what the name suggests ("Walk" → 10,000 steps) is only the field's hint. No line under the text preview (removed by the user, 29 Sep). Evidence: the Round 4 checklist's quick research.
- **How often screen (29 Sep, round 2):** the sentence at the top and nothing under it (no "Tick ✓…" or "Each ✓ counts one" lines; the form's "On Today, tap ✓…" footer is gone too). One section per kind of rhythm: *Daily* (Every day · Several times a day) · *A number of times* (week/month/year; **times only**: the user removed Days on 29 Sep, "3 times a week" means within the week, done 3 times) · *Days of the week* · *Every few days, weeks or months* · *On a date*. A choice's own settings show right under it only while it's chosen; **they're indented (`.nested()`) only in sections with several choices** (Daily; Every few days, weeks or months). One-choice sections (A number of times, Days of the week, On a date) have no indent. Unchosen choices name their kind ("Several times a day", "Every few weeks"); chosen ones say exactly what ("Twice a day", "Every other week").
- **Every few weeks needs no days** (`.everyNWeeks`, counted from the start date); "On set days" is an optional switch (5 of 43 week intervals in the descriptions name a weekday). **Every few months** is there too (11–21 statements: oil change, meds every 3 or 6 months). Each shows its next date.
- **How often is one list of sentence endings with the person's amount in them** ("2 chapters a week", "5 km on 3 days a week", "every Monday and Wednesday"). No pop-ups, no confirmations, nothing greyed out: every choice is a whole sentence. Schedule and Goal are no longer two rows.
- **Just do it counts every ✓ toward "N times a week"** (`.perWeek(n)`); there's no "N different days" choice (removed 29 Sep: to people times and days are the same). An amount on N days a week still counts the days it's reached ("5 km on 3 days a week").
- **An amount with "a week / a month / a year" is a total**; with "N days" it's each of those days. The sentence says which.
- **Not built, on purpose:** the "say it" fill-in (typing "Run 5 km 3 times a week" into the name: it fights the 24-character name limit, and review evidence for it in habit apps is 5 reviews); an amount "each time, N times a day" (it needs a new stored field). Both are in the Round 3 report.
- **Kept from before:** typed numbers select on focus; time is wheels plus Type; the unit is optional; units grouped by what people track, with ⊕ Create Your Own Unit (no time unit: Time it is its own type); copy never says due, overdue, missed, failed or minimum; Cut down's limit is a day, a week or a month (its How often has no set days).
- **Set days, kept from the Schedule rules** ([Schedule and Goal — One Coherent System](<../Research/Research Reports/Habit Creation/Schedule and Goal — One Coherent System.md>)):
  - Certain days start with the start date's weekday and keep at least one chosen; all seven become Every day. Full VoiceOver day names, 44-point targets, a vertical layout at large text sizes.
  - The start date anchors "every few days or weeks" (shown as "Counted from"), and the next date is shown ("Coming up: Thu 2 Oct").
  - Monthly and yearly dates say what short months and 29 February do, and let the person choose (use the last day, or skip).
  - Tasks can repeat "after it's done"; habits can't (fixed rhythms only).
- **Tasks use the same How often screen as habits** (`HowOftenEditor(task: true)`, 29 Sep), with the same pinned sentence and the same Preview card and text on the form ("Pay rent tomorrow" for a one-time task). Kept: Every day · Days of the week · Every few days, weeks or months · On a date · **After it's done** (its own last section; about 59 reviews ask to repeat from completion, many from Reminders users). Left out: Several times a day and A number of times, since a task is ticked once each time it's due. Reminders is a row that opens its own screen, as for habits.
  - Research recommendations are not usability results: no participant study has been run.

## Editing a habit (built 29 Sep 2026)

- **Edit lives in the row's long-press menu** ("Edit Habit", first item) and in the player's Habit options. A tap on a row logs; never make it open Edit.
- **The edit form is the New Habit form** (`HabitForm(editing:)`), showing only what can change: the type is fixed and never shown. Save stays grey until something changes; Cancel asks before discarding.
- **Past days keep their result.** Anything that judges a day (goal, how often, unit, steps) must go through `store.rule(habit, on: day)`; never read `habit.goal` or `habit.frequency` directly for a past day.
- **One line above Save says what happens:** "Changes apply from today. Your history stays as it was." or, when the kind of period changes, "Your streak restarts. Your history stays."

## Notes (built 29 Sep 2026)

- **Superseded the same day: the note is typed in a note bar docked above the keyboard** (`NoteBar`), naming the habit and day, never in the row and never on a full screen. The row stays highlighted above it. The line below describes the offer, which stays.
- **A habit's note is written in the row, in place** (Way of Life, the most-praised note in the corpus): after logging, the row offers **Add note**; the field opens in the row; tap a note to change it. Never a pop-up after each tick (the top complaint), never only behind a menu (the other). The just-logged row stays put while it offers the note. **Every other way in opens the same field:** swipe left → Note, long-press → Add Note, tap the note; any day, done or not. Days with a note get a dot in the calendar.
- **Three kinds, never mixed:** a habit's note for one day (in the row, or long-press → Add Note), a habit's standing description (in the form; shown in the player), and a note for the whole day (bottom of Today → Note for the Day; shown as a card at the top).
- **Never prompt for a note**, after a check-in, a skip or anything else. Users show a forced "why did you skip?" is disliked (report, `c8bde985…`).
- **A note never changes progress**, and can be added on any past day, done or not.
- **Note sheets are solid** (`presentationBackground`), like the calendar sheet.

## Pausing a habit (built 29 Sep 2026)

Source: [Pausing a Habit — What People Need](<../Research/Research Reports/Day Structure and Organization/Pausing a Habit — What People Need.md>).

- **A paused day is a skipped day** (`HabitStore.isPaused`, checked in `isDue`): off Today, no reminders, not in routines, neutral in the streak and every count. Never mark a paused day missed, and never ask about it on resume (the top complaint in other apps).
- **A week, month or year with a paused day can't break the streak;** it still counts if met.
- **Per habit, any length:** 1 week, 2 weeks, a date (comes back on its own) or until turned back on. No minimum or maximum. No app-wide vacation switch.
- **Paused habits go to a folded Paused card at the bottom of Today** with Resume, never just hidden.
- **Quit habits:** pausing ends the current run (kept as a run, not a slip), and resuming starts a new run (the user, 29 Sep). The clock never carries on across a pause.
- **Pause is free and never suggested.** No streak freeze to earn or buy.

## Habit copy: say it the way people do (built 29 Sep 2026)

The user's rule: **the copy is the value.** Whatever is picked must read the way a person says it, on the form and on Today.

- **One home: `Habits/Model/HabitCopy.swift`.** The read-back, the How often row, Today's line, a task's How often and the reminders all use it. Never build a habit sentence anywhere else.
- **Days of the week** (in the user's week order): 7 → "every day"; Mon–Fri → "on weekdays"; Sat+Sun → "on weekends"; 6 → "every day except Sunday"; **one unbroken run of 3 or more → a range, "every Sunday to Thursday"** (also across the week's end: "every Friday to Monday"); 5 that aren't one run → "every day except Thursday and Saturday"; otherwise every day named: "every Monday, Wednesday and Friday". Today uses short names: "Every Mon and Wed".
- **Dates of the month:** "on the 1st and 15th of every month"; runs of 3+ → "the 1st to 5th"; with a range, each part gets "the" ("the 1st to 3rd and the 15th"); the 31st with "use the last day" → "on the last day of every month"; odd or even dates by name; more than 6 separate dates → "on 7 dates each month" (the grid shows them); 28 or more → "every day except the 31st"; all 31 → "every day".
- **Numbers in sentences are whole and grouped** ("10,000 steps", "2,000 ml"); "k" only on Today's progress line. A count of one is never plural ("1 glass", "1 push-up"). A name that is the unit isn't said twice ("100 push-ups a day").
- **To change the copy:** change `iOS/Tools/copy_oracle/copy_oracle.py` and `HabitCopy.swift` the same way, read the print-outs, regenerate `CopyCheckCases.swift`, and run `NewHabitUITests/testCopyChecks` (the `-copycheck` launch shows "Copy: all checks passed" or the phrases that differ). The oracle's print-outs are the review sheet.

## Logging a count

Source: [Logging a Count — One Tap or Type](<../Research/Research Reports/Habit Creation/Logging a Count — One Tap or Type.md>), updated by Round 3 §2.7.

- **What + does is the person's choice on the form, in its own section "When you tap +"** (Track an amount only; 29 Sep): **Add a set amount** (default; "Each tap adds [1] glass" under it) or **Type the amount each time** (saved as a step of 0; Today shows a plain "+" that opens Add Amount with the number pad; the reminder has no "+" action). Evidence: 13 Loop reviews want one tap; "tapping +1 80 times for an 80m run is exhausting"; Round 3 §1.3 (19 type the odd amount, 13 want their own step). Visible and chosen, so it's no hidden rule.
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
- **"Back to Today" in two places, only while the open day isn't today** (the user, 29 Sep): **primary** (filled) just above the day bar on Today, and **secondary** (bordered) pinned at the bottom of the calendar sheet. **Both keep their space on today** (invisible, not removed), so nothing shifts as ‹ › change the day. No always-on Today button at the top.

## Full-screen routine player (29 Sep 2026)

Source: [Full-screen Focus Player — One Thing at a Time](<../Research/Research Reports/Day Structure and Organization/Full-screen Focus Player — One Thing at a Time.md>). The user requested this redesign on 29 Sep, superseding the earlier instruction to defer its UI tests. Validation is recorded in the [player checklist](<Docs/Checklists/Full-screen Routine Focus Player.md>).

- **Section Start opens full screen**, centered on one habit. Keep native controls, the routine position, a next-item preview, Back, Skip and a reachable queue.
- **No invented routine countdown.** Untimed items stay untimed; timed items use one existing count-up habit clock. Pause saves time; reaching the goal does not automatically advance. Next, Skip and Close save before leaving.
- **Completion stays visible until Next.** A repeated check adds one; a count adds its saved increment; a checklist keeps its existing steps. Keep manual logging and exact-entry Undo available.
- **Cut-down items are check-ins.** Include them even when under their limit. Continue never logs consumption or marks the whole day successful. Quit streaks stay outside the player.
- Queue reordering and reviewed-limit state belong to the current session. Habit progress and timers persist; do not imply persisted routine history or a saved session cursor.

## Routine (focus) player

Sources: [Focus Player — How It Should Behave](<../Research/Research Reports/Day Structure and Organization/Focus Player — How It Should Behave.md>) and the user's hands-on review (29 Sep). Checklist: `Docs/Checklists/Focus Player — Manual Bug Hunt Checklist.md`.

- **A playlist of habits:** swipe, ‹, or tap Up next to move. Moving on never marks anything done and never asks to confirm. Segments at the top show done / current / left.
- **Compact routine header:** routine name, position (`Morning · 2/10`) and a chevron are one tappable queue button. Keep progress segments below it; no separate Habit N of M / View routine row. The top ⋯ remains routine-only.
- **Bottom navigation is two chevrons with Habit options between them** (Task options for tasks). This supersedes the earlier inline Skip today and Log manually row. The button opens a native bottom sheet titled with the current habit, containing manual logging first where applicable, skip/undo skip, session undo and clock visibility. Sheet dismissal completes before presenting manual entry.
- **Keep the primary action visible.** Timer Start/Pause/Resume, quick logging, checks and checklist steps stay direct. If typing is the configured logging method, Log manually remains primary. Manual time entry remains available from the options sheet and clock tap; the decision does not claim manual logging is universally rare. Research: `Docs/Checklists/Focus Player — Header and Habit Options.md`.
- **"Log time manually" / "Log amount manually"**, never "Add Time" (reads as adding extra time).
- **Skip today** (day-by-day habits and tasks; not limits or weekly/monthly totals): a skipped day is not one of its days (`isDue` false), so it's hidden on Today and neutral in the streak, the ring and every percentage (Feature Ledger C016). Undo from the message, or "Undo skip" on its page. Pausing a habit for several days is not built yet.
- **Circular focus hierarchy for every type** (supersedes the earlier linear bar and side-by-side period badge, user review, 29 Sep evening): habit title immediately above a smaller central circle (272 points; checklist 236 points); a circular progress ring containing the small icon, current/target (`2 / 3`, `7:42 / 20 min`), with units and maximum limits. The later spacing/goal-context rule below moves period context above the circle and flexible day-count details into Habit options. No repeated schedule sentence. Checklist rows stay below the ring. Checklist: `Docs/Checklists/Focus Player — Circular Hierarchy.md`.
- **Spacing and goal context** (29 Sep, follow-up): progress segments have a 24-point top gap scaled with Dynamic Type (capped at 36); the centred CTA uses a 240-point baseline width (capped at 320) and a similarly scaled gap above bottom navigation. No Tick each step instruction or reserved CTA row for unfinished checklists. One goal-context line sits below the habit title, above the circle: Today for daily quantities, This week/month/year for period totals, the saved plan (e.g. 20 min on 3 days a week) for flexible goals. This supersedes period labels and flexible day-count text inside the circle. Flexible day-count progress lives in Habit options; the ring still tracks today's quantity. Reasons: `Docs/Checklists/Focus Player — Spacing and Goal Clarity.md`.
- **Next, previous and queue navigation never wait for storage.** Stop the old timer, change the page and start the new timer immediately; the store serializes persistence. Save errors still surface in the player.
- **Pause/Resume is instant and never blocked by a save**: the store changes its state at once and queues the write. Only the clock ticks (its own `TimelineView`, only while running); a timeline around the whole player made the buttons flicker. The main button never animates its label.
- **Nothing redraws behind the player, and nothing big redraws every second** (29 Sep; the app-wide rules are in `PERFORMANCE.md`). Today draws a plain background while the player covers it (`playerCovering`) and returns at the routine's section. Today's list redraws once a minute and at each running timer's goal time (`TodaySchedule`), never every second: a running row and the timer bar tick themselves. A `TimelineView` never switches on and off with Pause (that rebuilt the circle and faded its text) and is never anchored at `.now` (a new schedule on every redraw). A status line that comes and goes keeps its space (the "Paused" line is hidden, not removed). Measured: the main thread was busy ~22% of the time with a timer running, ~2% after.
- **No permission prompt over the player** (`TimerPresence.playerOpen`); the prompt only follows a ▶ tap on Today. The screen stays awake while a timer runs in the player.

## Progress and quit habits (built 30 Sep 2026)

Report: [The Progress Page — What People Need, and How to Build It](<../Research/Research Reports/Progress and Statistics/The Progress Page — What People Need, and How to Build It.md>). Checklist: `Docs/Checklists/Progress Page — Build.md`.

- **Progress only reads.** Nothing on it logs; the Day sheet's "Show on Today" goes to Today for that.
- **Every number comes from `HabitStore`** (`dayScore`, `outcome`, `progressSnapshot`, `overTime`, `quitHistory`), worked out once per change (`dataVersion`), never while drawing. Every past day goes through `rule(habit, on:)`.
- **Nothing counts against anyone:** skipped, paused, archived and not-its-day days are neutral; a weekly goal's empty day is never "not done"; a limit is judged only when its day or period is over. Never red, never "missed", "failed", "relapse" or "reset".
- **A weekly or monthly goal is done for the day once something is logged that day** (Today's "N left", reminders, the player's segments, the day bar); each ✓ still adds toward the goal.
- **A slip is an event with its own moment** ("Log a Slip…", with Undo). Editing "Started" is only for fixing a wrong start. A slip never erases the record: runs, clean days and slips are all kept.
- **The overview counts habits, not ticks**, so it agrees with the day bar; part credit only fills rings.

## Progress Week: habit cards (2 Oct 2026)

Report: [Weekly Habit Cards — What Each Card Shows](<../Research/Research Reports/Progress and Statistics/Weekly Habit Cards — What Each Card Shows.md>). Checklist: `Docs/Checklists/Progress Week — Habit Cards Build.md`.

- **No combined numbers on Week, and no day rings anywhere but Today's bottom bar** (the user, 2 Oct): no overview, no done-of-planned rings (Progress or the calendar sheet), no group numbers or Groups card. A blended number isn't a fact once a habit is weekly, monthly, every few days or a quit habit.
- **A card says each fact once:** the goal in words, a headline on the goal's own clock, at most one different fact, and the strip with each day's own value. No percentages, no "Today ·" line.
- **Names on one line** with "…"; the goal line too.
- **Only the dates bar sticks** (one 44-pt row): tabs, chips and the key scroll away. Don't pin more; every pinned point is taken from the cards.
- **Spacing is `WeekSpacing`'s scale (2, 4, 8, 16, 24)**, space inside a group smaller than around it. Don't add one-off paddings.
- **Icons use `HabitColor.mark`: every colour at one lightness (OKLCH 0.64).** Never deepen a colour by mixing in black.
- **Week, Month, Year and the habit's page are one heat map** (the user, 2–3 Oct 2026; report [Day Marks — Heat Map, Rule and Palette](<../Research/Research Reports/Progress and Statistics/Day Marks — Heat Map, Rule and Palette.md>): heat maps are the most praised day view in 1.2 million reviews, every language). One rounded **square** per day everywhere (never circles or rings), only the size changes (`HeatSize`): Week 40 pt, Month 32 pt, Year 24 pt. **No dates or numbers inside a square**: the colour says how much, the sign says what happened. The habit page's month puts the date *under* each square (it's where a day is picked). Every square is drawn by `HeatDraw` (batched paths in one `Canvas`), so a square looks the same at every size.
- **Never shrink a square below 24 pt to fit** (the user, 3 Oct 2026: "if they can't read it, there is no meaning to it"). Signs must be easy to read and scan at every size, Year included. Year scrolls sideways instead (about three months on a phone), opens on the latest weeks, and keeps its weekday letters fixed on the left (`HeatYear`).
- **One rule for every habit type: colour strength = how much of what that day asked for was done** (`HeatCell`, worked out in the store, never in a view):
  - three lighter steps, **no sign** = 1–33 %, 34–66 %, 67–99 % (✓ means done; a part day never gets one);
  - the habit's colour with a white ✓ = goal met (100 %);
  - the darkest step with **the same ✓** = more than the goal. Every sign is one size and weight everywhere (`HeatDraw.sign`), in every view and on every step: only the colour deepens (the user, 3 Oct 2026). **The ✓ is one colour on both ✓ steps in a mode**, never black on one and white on the other: white in light mode, a deep shade of the habit's own colour in dark mode;
  - **grey = the day was due**: grey with ✕ = not done (once the day is over), grey with ⏩ = skipped, grey with ⏸ = paused;
  - plain grey = due but not over yet (today before anything is logged, due days still to come);
  - dashed outline = nothing asked that day (not scheduled, a week goal's other days). **The only dashed square**;
  - a thin light-grey square outline = today (never a heavy ring);
  - nothing = before the start.

  A week or month total colours a day by its share of a fair day (70 km a week: 10 km fills a day). A limit kept = full colour with ✓, over = grey ✕, today = plain grey until the day is over. Quit: clean = colour ✓, slip = grey ✕. Streaks are a number in the headline, never the colour.
- **The palette is `HeatPalette`** (grey + 5 steps for every habit colour, light and dark): each step at one OKLCH lightness for every hue, so every colour's steps look equally strong; neighbours ≥ 0.07 apart in OKLab (≥ 0.043 under colour-vision deficiencies). Regenerate with `Day Marks Evidence/scripts/make.py` (in the report's folder); never pick shades by eye. Light mode darkens toward "more"; dark mode brightens. **Sign contrast, measured on all 13 colours (WCAG 1.4.11, 3:1):** light mode's white ✓ ≥ 3.11:1 (goal) and ≥ 5.14:1 (more); dark mode's ✓ is the habit's hue at OKLCH 0.24 / chroma 0.05, ≥ 4.41:1 (goal) and ≥ 7.27:1 (more). White can't serve dark mode: on its brightest step, "more", it is 2:1. ✕, ⏩, ⏸ grey ≥ 4.4:1; dashed outline ≥ 3.2:1 on the card.
- **The key is a collapsible section (`HeatKeySection`)** at the top of Progress and as its own section on the habit's page, above its first squares (the user, 3 Oct 2026): open until the person folds it; the choice is kept (`heatKey.open`) and shared by both. It has three rows: **Progress** (1–33 %, 34–66 %, 67–99 %, goal met 100 %, more), shown in green with "each habit uses its own colour"; **Due that day** (not done, skipped, paused); **Other days** (still to come, not scheduled, today). The real squares.
- **Week and Month cards are worked out in the store** (`progressSnapshot(…, weekCards: true)`), never in a body. Year's layout (`YearLayout`) is made once per snapshot and shared by every card.

## Groups (built 30 Sep 2026)

Plan: [Groups — What to Build](<Docs/Specs/Groups — What to Build.md>), from 2,228 group reviews (Day Structure report, Part 2) and the Today top-area reports. Checklist: `Docs/Checklists/Groups.md`.

- **Optional, never forced, invisible until the first one.** No preset groups; the habit form's Group row appears only once a group exists. Forced categorisation drove people away.
- **A filter, not tabs and not headings on Today.** Day sections already head the list; group headings under them would be two levels. One group at a time; one group per habit.
- **Never hide a habit without saying so.** All shows everything, habits with no group are in All, the Filter icon fills and a "● Health ✕" chip heads the list while a group is chosen. Anything that would leave a row out of sight (a timer bar, a notification, a habit added to another group) shows All first.
- **One editor however many ways in** (`GroupForm`, `GroupsView`): Filter's Edit, an empty chip and the picker's New Group all open it. The ≡ menu doesn't repeat Filter.
- **One order everywhere:** A to Z until the person drags; then "Your order" with Sort A to Z. Progress's bars follow it and are never ranked by rate.
- **Chip numbers are habits shown on the day open**, empty groups "–" and last. Counts are worked out only while the Filter sheet is open.
- **Group numbers take a list of habits** (`dayScore(on:habits:)`, `progressSnapshot(…group:)`); day scores are cached per group. Today and Progress remember their own choice.

## Ticking off, folding and settings (1 Oct 2026)

Source: [Ticking Off, Folding and Small Settings — What People Need](<../Research/Research Reports/Home Screen and Visual Design/Ticking Off, Folding and Small Settings — What People Need.md>). Checklist: `Docs/Checklists/Animations and Settings.md`.

- **Nothing on Today moves in the middle of a run of taps.** Every log (✓, +, a timer stopped, a step, a sheet closed after logging, an undo) calls `TodayLayout.hold` before changing data. Order and folds stay as shown until 1.5 s after the last log; then done rows sink and finished parts fold together (`Motion.settle`). Never sort or fold straight from a tap. The row offering "Add note" still keeps its place (Notes rule).
- **Feedback comes from the tap, never from a redraw** (`TickFeedback`): no `sensoryFeedback(trigger: done)` on a row or button, since changing the day flips `done` and buzzed. Haptics on by default, sound off; both switchable in ≡ → Appearance. No confetti or celebration screens.
- **Tick motion is a transform on the 34-pt button and the row fill** (`keyframeAnimator` scale, `ProgressFill` scaled from the leading edge). Don't animate a row's layout, and never block the next tap.
- **Each time of day is its own view (`PartSection`) reading only its own `FoldBox`.** Folding one part must not redraw Today's other rows. Don't put fold state back into `TodayView`'s `@State`, and don't pass a fresh `Binding` into `HabitRow` (it made every row redraw on every Today redraw).
- **Reduce Motion:** no pop, sweep or slide; folds and settles fade (`Motion`).
- **Day start and week start apply everywhere or not at all.** Read the day through `store.today()` / `store.calendar`; never subtract hours from a moment (it was an hour off on daylight-saving nights). Changing either clears Progress's cached scores.
- **No setting for 12/24-hour time, daylight saving or time zones.** Times use the iPhone's format (`DaySection.clock`, `.formatted`); logs keep their `LocalDay`. A second clock switch could disagree with the iPhone's.
- **The theme is set on the window** (`Theme.apply`), so sheets and alerts follow it at once.

## Words the app never uses

- **"Due", "overdue"** anywhere (the user, 29 Sep; copy rule from before). Tasks are "For today" or "Planned for Wed 1 Oct"; habits happen "on its days".
- **"Add Time" / "Add Amount"** for logging by hand: say "Log time manually" / "Log amount manually" (sheet titles "Log Time" / "Log Amount").

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

- **29 Sep 2026, Round 3 + Round 4:** builds on the Mac. Tests updated to the type screen, Reminders screen and suggested amounts; `HabitScenarioUITests` adds the user's day and date edge cases.

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

## ≡ Menu — FINAL (the user, 30 Sep 2026)

**Decided and final. Don't reopen it.** The top-left button is a ≡ menu that slides in from the left over Today. Everything that isn't used every day lives there: **Progress, Habits (All Habits) and Tasks leave Today's top bar**, and every setting goes in too. The user overrode Round 3's suggestions to keep Progress in the top bar and to open ≡ as a sheet. Research: [Navigation, Round 3](<../Research/Research Reports/Home Screen and Visual Design/Navigation Pattern/Navigation, Round 3 — The Menu, Filter and Two Ways In.md>). Checklist: [Sidebar Menu](<Docs/Checklists/Sidebar Menu.md>). Code: `Habits/Menu/`. *Supersedes: the avatar at the top left, the Progress and All habits (☑︎ `checklist`) top-bar buttons, and Round 2's avatar-and-icons top bar.*

- **Today's top bar is ≡ · Filter · +.** Filter's icon is `line.3.horizontal.decrease.circle`, never the bare three lines, which look like ≡.
- **Menu order, most used first:** Today · Progress · Habits · Tasks | Times of Day · Reminders · Appearance | Backup & Export · Privacy | Plus | Help & Feedback · About. Row names are the pages' titles. Icons are monochrome (colour is for habits only).
- **Every row pushes its page onto Today's own navigation stack** (`MenuModel.path`), so Back and the edge swipe return to Today. A page that isn't built opens a "coming" page that says what it will hold; wire the real page in `MenuPage`.
- **One screen per thing, however many ways in:** ≡ → Times of Day and Today's "Edit Times of Day" show the same `TimesOfDayList`; Habits and Tasks are one `AllHabitsView(kind:)`.
- **Open:** ≡, or a swipe from Today's left edge (only on Today itself: on a pushed page that swipe is Back). **Close:** tap the dimmed Today, drag the menu left, choose a row, or VoiceOver's escape. Reduce Motion fades it instead of sliding.
- **Speed:** Today never reads `MenuModel.isOpen` or `drag`, so the menu opening, closing or following a finger never redraws Today. Keep it that way; `PerformanceUITests.testMenuOpenClose` measures it.

## Sidebar data, tasks and reminders — 30 September 2026

- Backup/export/restore are available to free users. Delete App removes the sandbox; explain free external backup and Offload clearly. Never promise local-only uninstall retention. Restore must preserve current edits and tombstones; validate before changing the destination.
- Tasks lists every saved task, including future/completed/repeating/archived. Tasks do not consume the free habit cap, and unarchiving a task remains free. Use the same native task form; opening an old task must keep its original date.
- Reminders is a native settings Form over existing rules, with permission recovery and item editing. Opening it does not request authorization. Serialize reconciliation; use saved action event IDs, current target validation and wall-clock dates. Stop outdated alarms, retry/report scheduling errors, and reserve the shared notification budget for timers.
- The latest queued alert date is not a guarantee for every item. Explain nearest-first capacity and iOS background limits. Physical-device delivery remains a separate check. Reliability details supersede §6 of Pending to Implement.md in its sidebar addendum.
- ~~Keep Help & Feedback and About blank, as requested by the user.~~ *Superseded 1 Oct 2026: the user asked for the help content; see "Onboarding, empty Today and Help" below.*

## Onboarding, empty Today and Help (built 1 Oct 2026)

Research: [Onboarding — The Name, What's Free, and a First Habit](<../Research/Research Reports/Habit Creation/Onboarding — The Name, What's Free, and a First Habit.md>). Checklist: `Docs/Checklists/Onboarding and Help.md`.

- **Four screens, once, on a fresh install, every one skippable:** Often Enough (the name) · Free, with no account · Your days and weeks · What's one habit to start with? Skip (screens 1–3), Not Now (screen 4) and Restore from a Backup File (screen 1) each end it in one tap. **Never add a question the app can't act on**, a goals survey, a score, a pledge, a sign-up, a permission request or a paywall to it (C111, C283, C160, C209).
- **The name screen says only what the app does:** you choose how often; streaks count your goal (3 times a week, every week, is a streak; unplanned days never break it); skipped and paused days never count against you. **Never claim a missed day doesn't matter**: a daily habit's streak does end on a missed, unskipped day.
- **What's free is said before any effort** (C236): up to 5 habits free forever, no account, no ads, data on this iPhone with how to back it up, and Plus as "one payment, not a subscription" (C305), with no buy button. **List only what this build has** (C218): add widgets to the free line when they're merged.
- **An idea only fills in the form** (name, type, how often); nothing is saved until Add, and amounts stay empty (C292, C203). Never preselect or auto-add a habit.
- **Not shown** in UI or speed tests (`-uitest`, `-dbname`) unless `-onboarding`, nor to anyone who already has habits, nor over a storage problem.
- **The empty Today is never a dead end and never says "every day":** New Habit, Start From an Idea, Restore from a Backup File, How It Works.
- **Help & Feedback:** Contact Us and Show the Welcome Again first, then How It Works, searchable. **Every answer names the exact button**; when a way in or a label changes, change its answer in `HelpTopics` in the same change. Contact Us sends no habit data. About lists the open-source libraries with their licences; no links to pages that don't exist yet.
