# Design Rules — Don't Regress

Written by Claude (Claude Code), 28 September 2026. **The rules for every change are in [the Rulebook](../RULEBOOK.md)
(3 Oct 2026); read it first.** This file keeps each screen's decisions: read a screen's section before changing that
screen. Every rule below exists because an agent broke it once and the user had to catch it. Each rule links to the research behind it. If a rule has to change, change it here too, with the reason.

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
- **Cut down has no Time of Day** (the user, 5 Oct 2026): its sentence ends without ", anytime", and one footer line under Group and Reminders says "It shows on Today under Quit or Cut Down. Log it only when it happens." A limit saved earlier keeps its time of day, unused. Report: [Limit Habits on Today](<../Research/Research Reports/Day Structure and Organization/Limit Habits on Today — Apart From What You Must Do.md>).
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

- **Superseded 3 Oct 2026 (the user): a note is written in its own sheet** (`NoteSheet`, from Today via `store.noteTarget`): Cancel, Save, Delete Note once one exists; it names the habit and day. Never typed in the row or in a bar over Today (the earlier `NoteBar`, kept only in the player). Once a habit has a note for the day, every way in says **Edit Note**. The row doesn't show the note's text (rows stay at three lines); the Day sheet and the habit page's Notes do.
- *Older, superseded the same day (29 Sep): the note was typed in a note bar docked above the keyboard (`NoteBar`).*
- *Superseded (see above):* **A habit's note is written in the row, in place** (Way of Life, the most-praised note in the corpus): after logging, the row offers **Add note**; the field opens in the row; tap a note to change it. Never a pop-up after each tick (the top complaint), never only behind a menu (the other). The just-logged row stays put while it offers the note. **Every other way in opens the same field:** swipe left → Note, long-press → Add Note, tap the note; any day, done or not. Days with a note get a dot in the calendar.
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
- *Superseded 3 Oct 2026 (U14):* tapping the habit row opens its **Day sheet**, which has Add Entry for typing an amount or time; + with no step opens Add Entry; touch and hold has Add Entry… and the named Undo ("Undo +1 glass").
- **Don't** make every + open the input, and **don't** make the input full screen. Units never read "1 glasses".

## Timing a habit

Source: [Timing a Habit — Start, See and Stop](<../Research/Research Reports/Habit Creation/Timing a Habit — Start, See and Stop.md>) and [Timers — What People Expect When They Tap ▶](<../Research/Research Reports/Habit Creation/Timers — What People Expect When They Tap ▶.md>) (4 Oct 2026).

- **▶ starts the timer at once, for any goal length, and opens it full screen** (`TimerScreen`; the user, 4 Oct 2026: "it just runs in the row… it isn't intuitive"; supersedes 28 Sep's "never full screen for one habit"). **Never a trap:** ⌄ or a swipe down puts it away and the timer keeps running; closing never stops it or loses time. Users show both: a big timer to focus on is asked for (≈12), a timer screen you can't leave is a complaint (5). ≡ → Appearance → Timers → Open Timer Full Screen (on by default) turns it off; ▶ then starts it in the row only.
- **A running timer must be visible**:
  - The row's line is a live clock, redrawn every second: "7:42/20 min" (`goalLine(running:)`).
  - When the row is off screen or folded, a timer bar sits at the bottom of Today (`TimerBar`), like the iPhone's Now Playing bar: **tapping it opens the timer** full screen; ⏸ stops it.
  - Outside the app, a Live Activity shows it (`TimerPresence`; the `HabitsLiveActivity` extension), with **Pause** (`StopTimerIntent`: stops and saves, never starts) and a tap that opens that habit's timer (`oftenenough://timer/<id>`). ≡ → Appearance → Timers → Show on Lock Screen (on by default) turns it off, besides iOS's own switch.
  - Never show only ▶ turning into ⏸.
- **Keep the `TimelineView` inside the timed row itself.** A `TimelineView` higher up doesn't reliably redraw child rows whose inputs didn't change. And whole minutes hide a running timer for its first minute. Together these caused the "nothing moves" report (28 Sep).
- **One notification when the goal is reached, never repeats or per-second pings.** The timer keeps counting past the goal.
- **The Live Activity ends the moment the timer stops.** One left behind looks like time still counting.
- **Time is counted from the saved start time, never by ticking.** So it survives closing the app and restarting the phone.
- **A timer is never the only way.** The Day sheet (a tap on the row) has Start Timer and Add Entry for typing time. ⏸ saves what was done; sessions add up.
- The clock counts up, with the goal beside it. The row's fill shows what's left.

## Today section headers

Source: [Section Header — Start Button, Left Count and Icons](<../Research/Research Reports/Home Screen and Visual Design/Today Screen Top Area/Section Header — Start Button, Left Count and Icons.md>).

- **"N left" is always shown**, open or folded. It's what people open the app to see. **Never replace it with a button.** Done is a ✓ (VoiceOver says "All done").
- **Start:**
  - "▶ Start" in open sections.
  - Folded, ▶ appears **only on the Now section**.
  - **The Now button is primary** (filled ink); others are grey.
  - Start is today only, never on Quit or Cut Down.
- Space order: status and Start never shrink; the name gives way first; the icons take the rest and end in "+N".
- **Folded icons sit beside the whole name block, centred on the header** (the name and its "Starts 6 AM" line), never on the name's own line, with a clear gap of about 14 points that grows with the text size (`PartHeader.iconGap`, capped at 24). The user, 4 Oct 2026 (Current Work 38).

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
- **Limits are never in a routine** (5 Oct 2026; supersedes "Cut-down items are check-ins"): they sit under Quit or Cut Down, outside every time of day (see "Limit habits on Today" below). Quit streaks stay outside the player too. The player's limit handling remains only as a safety net.
- Queue reordering and reviewed-limit state belong to the current session. Habit progress and timers persist; do not imply persisted routine history or a saved session cursor.

## Routine (focus) player

Sources: [Focus Player — How It Should Behave](<../Research/Research Reports/Day Structure and Organization/Focus Player — How It Should Behave.md>) and the user's hands-on review (29 Sep). Checklist: `Docs/Checklists/Focus Player — Manual Bug Hunt Checklist.md`.

- **A playlist of habits:** swipe, ‹, or tap Up next to move. Moving on never marks anything done and never asks to confirm. Segments at the top show done / current / left.
- **Compact routine header:** routine name, position (`Morning · 2/10`) and a chevron are one tappable queue button. Keep progress segments below it; no separate Habit N of M / View routine row. The top ⋯ remains routine-only.
- *Superseded 7 Oct 2026 (U23): the middle item is **Day details**, the same sheet a row opens on Today, full height; the
  options sheet and its Show clock switch are gone (a time habit always shows its clock).* **Bottom navigation is two chevrons with Habit options between them** (Task options for tasks). This supersedes the earlier inline Skip today and Log manually row. The button opens a native bottom sheet titled with the current habit, containing manual logging first where applicable, skip/undo skip, session undo and clock visibility. Sheet dismissal completes before presenting manual entry.
- **Keep the primary action visible.** Timer Start/Pause/Resume, quick logging, checks and checklist steps stay direct. If typing is the configured logging method, Log manually remains primary. Manual time entry remains available from the options sheet and clock tap; the decision does not claim manual logging is universally rare. Research: `Docs/Checklists/Focus Player — Header and Habit Options.md`.
- **"Log time manually" / "Log amount manually"**, never "Add Time" (reads as adding extra time).
- **Skip today** (day-by-day habits and tasks; not limits or weekly/monthly totals): a skipped day is not one of its days (`isDue` false), so it's hidden on Today and neutral in the streak, the ring and every percentage (Feature Ledger C016). Undo from the message, or "Undo skip" on its page. Pausing a habit for several days is not built yet.
- **Circular focus hierarchy for every type** (supersedes the earlier linear bar and side-by-side period badge, user review, 29 Sep evening): habit title immediately above a smaller central circle (272 points; checklist 236 points); a circular progress ring containing the small icon, current/target (`2 / 3`, `7:42 / 20 min`), with units and maximum limits. The later spacing/goal-context rule below moves period context above the circle and flexible day-count details into Habit options. No repeated schedule sentence. Checklist rows stay below the ring. Checklist: `Docs/Checklists/Focus Player — Circular Hierarchy.md`.
- **Spacing and goal context** (29 Sep, follow-up): progress segments have a 24-point top gap scaled with Dynamic Type (capped at 36); the centred CTA uses a 240-point baseline width (capped at 320) and a similarly scaled gap above bottom navigation. No Tick each step instruction or reserved CTA row for unfinished checklists. One goal-context line sits below the habit title, above the circle: Today for daily quantities, This week/month/year for period totals, the saved plan (e.g. 20 min on 3 days a week) for flexible goals. This supersedes period labels and flexible day-count text inside the circle. Flexible day-count progress lives in Habit options; the ring still tracks today's quantity. Reasons: `Docs/Checklists/Focus Player — Spacing and Goal Clarity.md`.
- **The bottom row is a bottom navigation, and nothing moves** (the user, 4 Oct 2026; supersedes the 24-point gap and "no reserved CTA row" above). ‹ · Habit options · › sit 40 points above the screen's bottom edge (or 8 above the home indicator if that's more: `RoutinePlayer.bottomClearance`), with a 32-point gap (scaled, capped at 44) above them to the main button. The main button's slot is always kept: an unfinished checklist leaves it empty (its steps are the action), so the button and the row never shift. The Undo under the circle keeps its place while there's nothing to undo, so the circle never jumps. The main button's label is one line. A note is written in `NoteSheet` (as from Today), never in a bar that takes the bottom row's place; `NoteBar` is gone. The distance is read once from the window's home indicator, never from a `GeometryReader`: its safe area grew when a sheet showed the keyboard, the pager shrank and jumped back to the first habit, and the open Log Amount sheet switched to that habit (CI, 4 Oct 2026). The manual-entry sheet keeps the habit it opened for. Test: `FocusPlayerUITests.testBottomRowStaysPutAndOptionsShowEverything`. Checklist: `Docs/Checklists/Routine Player — Bottom Row, Options Sheet and Switches.md`.
- **Habit options fits its list** (4 Oct 2026): the sheet is as tall as its options (measured from the list), so Edit Habit is never below the fold; a list taller than the screen opens large and scrolls. A half-height sheet that hides actions until you scroll isn't how iOS's own action sheets behave (Mail's, Photos' ⋯): they show every action. Its Show clock switch is the iPhone's green (`.toggleStyle(.appSwitch)`).
- **The bottom row is the native bottom bar, as on Today** (the user, 5 Oct 2026; supersedes the custom row 40 points up and the reserved button slot in the bullet above, which left a block a fifth of the screen tall and cut off a checklist's steps: Current Work 51). ‹ · Habit options · › are `ToolbarItem(placement: .bottomBar)` items exactly like Today's ‹ · Today · › (their own Liquid Glass items on iOS 26; Habit options in `.status` before iOS 26). The bar stays on the finish page (› disabled there), so the pages never change height. The main button floats over the bottom of the page, a scaled 24-point gap (capped at 32) above the bar; each page keeps that much room at its end, so its last step scrolls clear of it. Still nothing moves: the button's slot is kept (empty for an unfinished checklist), and the save message sits above it. Test: `FocusPlayerUITests.testBottomRowStaysPutAndOptionsShowEverything` (also checks an unfinished checklist's last step shows above the bar without scrolling).
- **Fast ‹ ›: the player never follows a page the pager slides past, and a tap during a slide jumps** (Current Work 50, 5 Oct 2026). The user tapped › fast to the end and ‹ straight back, and the habits slid back and forth. Measured on GitHub's simulator (`FocusPlayerUITests.testFastNavigationNeverSlidesBack`: the app taps itself every 0.15/0.1/0.05 s through 13 habits, and › to the end then ‹ with no pause; `PagerProbe` reads the pager's on-screen position every frame and counts the player going the wrong way): while its own slide runs, the page `TabView` reports pages it passes as if chosen, and obeying them sent the player back (6 steps back and pages sliding back 0.21–0.70 of a page in one run; timing-dependent, other runs were clean); and pages that slide behind fast taps must turn round when ‹ follows ›. So: during the player's own slide (`PagerSlide`, 0.35 s) page reports are not choices (the pager is put back on the player's habit), and a tap during a slide jumps straight to its habit; one tap still slides. Swipes outside a slide choose as before. Tried and rejected: a paging `ScrollView` (`ScrollPosition`) drew non-neighbouring habits on top of each other mid-slide in its recording; one-slide-at-a-time made the pages trail further. Recordings were checked frame by frame, decoded straight through (seeking into a recording gives half-decoded frames that look like this very glitch). Speed: the `player` scenario's "fast ‹ ›".
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
  **Widgets may use 20-pt squares** (the user, 6 Oct 2026: they can't be tapped, so the only test is whether they're reliably legible; if yes, 20 pt is fine). Measured on the weekly Medium widget: every sign is at least 3:1 against its square (white ✓ 3.11–3.73:1 on goal met; ✕ ⏩ ⏸ 3.9:1 in light, 4.86:1 in dark). The signs scale with the square: ✓ 10 pt / 2-pt line, ✕ 8 pt / 1.7, ⏩ ⏸ 9 pt. The dashed and today outlines use #86868B in light mode, 3.25:1 on the grey week card. Still to check on the iPhone (U9): ⏩ against ⏸ at 9 pt, and tinted/clear Home Screens, where colour steps flatten and only signs remain. In the app itself the 24-pt minimum stands. Grey squares need a background darker than their own grey: in dark mode put them on #1C1C1E, never #2C2C2E (the same colour as the dark grey square, so not-done and still-to-come squares vanish; found 6 Oct 2026 on the accepted dark widget card).
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
- **The key is a collapsible section (`HeatKeySection`)** at the top of Progress and as its own section on the habit's page, above its first squares (the user, 3 Oct 2026). **One key for the whole app: open everywhere until the person folds it once, anywhere; from then on folded everywhere** (every Progress range, every habit's page, every later visit), and a tap opens it (the user, 6 Oct 2026, Current Work 57: "it's the same content, why do I need to close it multiple times?"; supersedes 5 Oct's "open on the first visit to each place", Current Work 25, which made people fold it per range and per habit). Opening it by hand opens it for that page's visit only; folding it is what's remembered (`HeatKeyMemory`, `heatKey.folded`, written once). Within a visit it never folds on its own: switching ranges, dates or tabs, or scrolling it away, is the same visit (`HeatKeyVisit`, one per page; Week, Month and Year share it). Test launches start never folded. **An accordion: its chevron points down while folded and up while open, never right** (a right chevron beside the dates' ‹ › reads as a page to go to). It has three rows: **Progress** (1–33 %, 34–66 %, 67–99 %, goal met 100 %, more), shown in green with "each habit uses its own colour"; **Planned that day** (not done, skipped, paused); **Other days** (still to come, not scheduled, today). The real squares.
- **Week and Month cards are worked out in the store** (`progressSnapshot(…, weekCards: true)`), never in a body. Year's layout (`YearLayout`) is made once per snapshot and shared by every card.

## Groups (built 30 Sep 2026)

Plan: [Groups — What to Build](<Docs/Specs/Groups — What to Build.md>), from 2,228 group reviews (Day Structure report, Part 2) and the Today top-area reports. Checklist: `Docs/Checklists/Groups.md`.

- **Optional, never forced.** No preset groups. *Changed 3 Oct 2026 (the user):* the habit form always shows its Group row (None by default, with New Group), so a group can be made there as well as from the Filter. Forced categorisation drove people away: never require one.
- **A filter, not tabs and not headings on Today.** Day sections already head the list; group headings under them would be two levels. One group at a time; one group per habit.
- **Never hide a habit without saying so.** All shows everything, habits with no group are in All, the Filter icon fills and a "● Health ✕" chip heads the list while a group is chosen. Anything that would leave a row out of sight (a timer bar, a notification, a habit added to another group) shows All first.
- **One editor however many ways in** (`GroupForm`, `GroupsView`): Filter's Edit, an empty chip and the picker's New Group all open it. The ≡ menu doesn't repeat Filter.
- **Groups' order:** A to Z until the person drags; then "Your order" with Sort A to Z. Progress's bars follow it and are never ranked by rate. (Habits' order is in "Arrange Your Day" below.)
- **The Filter only shows less** (report 27): Show (All Habits or one group), New Group and Edit Groups always in sight, then Hide Completed Habits and Hide Completed Tasks as two separate switches. While anything is hidden the Filter icon fills and a chip heads Today ("Completed hidden ✕"), one tap back. Hidden done rows leave only when Today settles (`TodayLayout.hold`), never under a finger.
- **Chip numbers are habits shown on the day open**, empty groups "–" and last. Counts are worked out only while the Filter sheet is open.
- **Group numbers take a list of habits** (`dayScore(on:habits:)`, `progressSnapshot(…group:)`); day scores are cached per group. Today and Progress remember their own choice.

## Habit details: Notes in month cards (built 5 Oct 2026)

- **History's Add Entry and Go to Date, and Notes' Add Note, are secondary actions** (the user, 5 Oct 2026, Current Work 26): one shared style (`pageAction()`): native bordered buttons at their own width, regular size, subheadline, ink text on a light ink tint, the same in both tabs. Never the filled style on ink (white text on dark mode's off-white ink was unreadable), never full-width and large.
- **Notes: search across the full width, Add Note on its own row under it** (the user, 5 Oct 2026: Add Note was bigger than a cramped search beside it). An inline search above the list, not a search page: it only filters this habit's notes, and the months stay in view (the 4 Oct handoff; Apple's search-field guidance). No search field while there are no notes.

- **Notes come in a card per month, shaped as History's** (the user, 5 Oct 2026, Current Work 46): the month's name and "N notes", folding from its header with History's chevron, the newest two open; a row per day's note, dated as History dates its days ("Sat 4 Today"), its first two lines, opening the note. A search opens every month it finds. `NoteMonthCard` in `HabitNotesTab.swift`; `HabitPageUITests.testNotesFoldByMonthLikeHistory`.

## Habit details: Progress tab cards (8 Oct 2026)

- **A period card's title keeps the card's whole top padding** (Current Work 31): Week, Month and Year in Pixels put their
  ‹ › (44-pt targets) beside the title without pulling the header up (a `-8` vertical padding put "Week" against the
  card's top edge). 16 pt all round, 16 between the card's parts, smaller only inside a part (the headline and its
  detail 4; a chart's title and chart 8). Year in Pixels keeps 12 at the sides so twelve month columns fit the iPhone
  SE, and 16 above and below. Pictures: `HabitPageUITests.testPeriodCardSpacing`.
- **Current streak and Best streak open the Milestones card's "In a row" track** (Current Work 23, 8 Oct 2026; the 5 Oct
  placement research): early in this habit's Progress tab, never in the header over History and Notes; in the goal's own
  unit (days, weeks, months, or times for a selected-days habit), from the same runs as Today's streak; Show Streaks off
  hides them and keeps "In total". A quit habit's current and best run stay in its Overall record. No new card.
  `testStreaksOnTheProgressTab`.
- **Year in Pixels shows every day number, 1 to 31** (Current Work 32), right-aligned 4 pt before its row; the labels
  stop growing at the xLarge text size, where "31" still fits. Pictures: `testYearInPixelsDayNumbers`.

## Limit habits on Today: Quit or Cut Down (built 5 Oct 2026)

Source: [Limit Habits on Today — Apart From What You Must Do](<../Research/Research Reports/Day Structure and Organization/Limit Habits on Today — Apart From What You Must Do.md>). The user's words: "it signals like you have to log something… you log it only if you do it."

- **Limits (cut-down habits) never sit in a time of day.** They share one card with quit habits, **"Quit or Cut Down"** (the + flow's own words, so a limit isn't read as something to quit), in the person's own order (`Habit.isQuitOrLimit`, `HabitStore.cardMembers`).
- **The card has no "N left" and no Start**, folds like any card, and moves among the cards in Arrange Your Day. Folded, its whole name shows (`PartHeader.foldsTitle`), ending in "…" only at the largest text sizes.
- **A limit keeps its ordinary row** (+, ▶ for a time limit, the Day sheet, swipes, the menu) and shows on any day it applies; quit counters stay today only.
- **Never put a limit back in a time of day or a routine**, and never give the card a status or Start: in a list of things to do, a limit reads as one more thing to do (users show workarounds: rewording, ticking at night, snoozing reminders).
- **Tests replaced, not dropped:** `FocusPlayerUITests.testLimitCheckInNeverLogsConsumptionOrCompletesTheDay` became `testLimitIsNotInTheRoutineAndWaitsUnderQuitOrCutDown`, and `testSectionWithOnlyALimitStillHasStart` became `testOnlyALimitShowsUnderQuitOrCutDownWithoutStart`: they checked limits inside a routine, which no longer happens. The manual-log check moved from the limit to Drink water.

## Arrange Your Day: Edit on Today (built 3 Oct 2026)

Research: [27. Arranging and Filtering Today](<../Research/Research Reports/Home Screen and Visual Design/Today Screen Top Area/27. Arranging and Filtering Today — What People Expect.md>). The user's points: [checklist](<Docs/Checklists/Today — Arrange Your Day (item 5 build).md>).

- **Today's normal layout doesn't change beyond these points** (the user: "don't change anything drastically"). No heading on Today. The bottom keeps only "Note for the Day"; "Edit Times of Day" is gone from it.
- **Each timed section says when it starts, under its name: "Starts 6 AM"** (start only; ":00" dropped on the hour), folded or open, on its own line so it never takes room from the folded icons or "N left". Anytime, Quit or Cut Down and Paused have none.
- **Edit turns Today into "Arrange Your Day"** (never "Edit Today"), with one plain line saying what can be done. It lists **every habit** in each card, not only today's (one-time tasks already done are left out), Anytime and Quit or Cut Down included.
- **Habits' order is the person's own.** A new habit or task goes to the end of its section; reminder times never reorder Today. Habits and tasks share one order in each section, and both can be dragged (tasks research, report 27). Sorting is a one-off action (··· → By Reminder Time / A to Z); dragging carries on from it. *Supersedes "timed rows by their earliest time".*
- **Timed sections follow their times; only Anytime and Quit or Cut Down move** (··· → Move Up / Down / to Top / to Bottom). Paused stays last.
- **Each card's ··· menu, short names:** Rename, Change Time (timed only), Sort habits, Move (Anytime and Quit or Cut Down only), Delete (timed only; its habits move to Anytime, and the dialog says so).
- **New or changed times split what they overlap** (`SectionPlan`): the form shows "Your day" with every section's new times, and a dialog lists them before anything is split. Covering a whole section is refused; nothing is ever deleted by a split. `ArrangeCheck` (`-arrangecheck`) covers every direction.
- **One tip, on Edit, at the right moment** (`ArrangeTip`): only once some section has two or more habits and Today has been opened on three different days; once; gone when Edit is used; never in test launches.

## A row's shape: the line under the name, after-log buttons, spacing (3 Oct 2026)

Source: [Today's Rows — The Line Under the Name, Notes and Spacing](<../Research/Research Reports/Day Structure and Organization/Today's Rows — The Line Under the Name, Notes and Spacing.md>). Checklist: `Docs/Checklists/Today — Row Layout, Subtext, Notes and the Task Sheet.md`.

- **Every habit and task row has exactly one line under its name, saying what today asks of it** (`HabitRow.rowLine`): counted habits say how much and how far along (`3/8 glasses`, `1/3 times`, `2/3 this week`, `1/4 steps`, `1/2 cups max`); a single tick says how often (`Every day`, `Every Mon, Wed and Fri`); then the time (`· 7:00 AM`). A task's line starts with **Task**. A skipped day says `Skipped today`. Never a second line (no rhythm line, no flexible line, no note line): fold any new fact into this one or leave it to the Day sheet.
- **A skipped habit stays on Today** as a neutral row whose line says `Skipped today`; it counts as finished (not "left") and settles with the done rows; Undo Skip is on its swipe, menu and Day sheet. It used to vanish from Today, leaving Undo Skip nowhere to be found (`isDue(countingSkips: false)`, 4 Oct 2026).
- **A checklist's step rows have no line**; they start where names start (`RowSpace.textLeading`).
- **A quit row has the same shape:** its line is the best run (`Best 12 days`; "Since …" when Show Streaks is off), the live count is on the right where other rows have their button. **No "Slipped" button under it**: Log Slip is on its swipe, its menu and its Day sheet.
- **After a log, one line of small capsule buttons under the text** (`RowAfterLog`; `QuitAfterSlip` after a slip): the named Undo, then Add Note or Edit Note, and a milestone if the tap reached one. `.bordered`, `.capsule`, `.small`, monochrome, **16 pt apart** so Undo and Add Note aren't tapped by mistake (the user, 6 Oct 2026, Current Work 55; was 8); one line each, never wrapped: a milestone shortens with "…", and at the accessibility text sizes the buttons show only their icons. **Never `ViewThatFits` here**: it measured three layouts each time the line appeared and doubled the cost of changing days (4 Oct 2026). Only while the offer lasts.
- **One set of spacing numbers** (`RowSpace`): 2 between a name and its line, 12 between icon and text, 6 from the band to the after-log buttons, 8 between those buttons. Icon, text pair, streak and button are **centred** on the 44-pt band (`RowBand`), so icons line up down the list whatever the row holds.
- **Names use the row's width**, ending in "…" only when they run out (never cut at a fixed 15 characters in a row).
- **Every row's tap opens its Day sheet, tasks included.** A task's sheet holds Done, its date and **Do Tomorrow** (a one-time task), the note and Edit Task; Archive and Delete in ⋯; no day paging for a one-time task.
- **Accessibility:** the row's open is a *named* accessibility action ("Show Day"), never a button trait, default action or hint on the row's container: each merged the row's texts into one element, so names stopped reading (and tests stopped finding them) as text (CI, 3 Oct 2026).

## A row's tap, swipes, menu and Day sheet (3 Oct 2026)

Source: [Today's Rows — Tap, Swipe, the Day Sheet and Delete](<../Research/Research Reports/Day Structure and Organization/Today's Rows — Tap, Swipe, the Day Sheet and Delete.md>). Checklist: `Docs/Checklists/Today — Row Sheet, Swipe Actions, Order and Tap Again.md`. Rulebook U14.

- **Tap the row → its Day sheet** for the day Today shows (`store.dayTarget`, one sheet on Today, never one per row). Tasks keep only their tick. The round button never opens anything but Add Entry (+ with no step).
- **The round button: ✓ toggles that day's tick** (`isTicked`: a once-a-day check, or a day of "N days a week"); **every check habit keeps its ✓**: a check counted several times a day, **or N times a week, month or year** (`countsUp`) shows ✓ too, and each tap adds one check and never takes one back (the user, 7 Oct 2026, Current Work 64: "the user has chosen a check-based habit… you are turning it into an amount habit"; the +1 of 3–6 Oct is superseded, on Today and in widgets); **+ adds** for amounts; ▶/⏸; ⌄ for a checklist's steps. A tap never takes back part of a count. **The button fills only when the habit's goal is met: for a week, month or year count, when the period is met, never after one tap today** (the user, 6 Oct 2026, Current Work 54: "how are you going to decide it's complete for today? They might call two times this day"). It still counts as done for the day once logged (it sinks, leaves "N left", stops reminders: Build Plan #60a).
- **Swipes reveal labelled buttons and never act by themselves** (4 Oct 2026, report "Swipe Actions — Reveal, Never Act"; supersedes the full-swipe Note): no full swipe on either side; two buttons at most. Left: Skip / Undo Skip at the edge, then Note (a quit row: Log Slip, then Note; a task: Note). Right: "Undo +1 glass" (the day's last entry, named). Pause / Resume is in the long-press menu and the Day sheet. Nothing destructive on a swipe.
- **Touch and hold = the sheet's actions:** Open Habit Page (pushed on Today's stack, `HabitPageRoute`), Edit Habit, Add Entry…, Note, Skip, Pause…, the named Undo, All Notes. No Delete, no "Edit Today's Progress…" (the tap does it).
- **The Day sheet's 3 Oct implementation baseline, superseded by the 4 Oct design proposal below:** icon, name and plan → Result → the habit's own control (Done switch, Add 1, +step, Start Timer, steps, Log a Slip) and Add Entry → that day's entries → Today/This Day (Skip, Note) → Habit (Open Habit Page from Today, Edit, Pause). The implementation still has the bottom ‹ date › bar. **Archive and Delete only in the ⋯ menu**, Delete confirmed with "Archive Instead".
- **Undo names what it takes back** (`Entry.undoLabel`): "Undo +1 glass", "Undo 20 min", "Undo +1", "Undo Done", "Undo Slip", "Undo Cleanser".

**4 Oct 2026 Day-sheet redesign: built on branch `details-page-update` (4 Oct 2026, `DaySheet.swift` + `DayActivity.swift`); CI and the iPhone check are pending.** As built: native `Form` sections throughout. The identity row is a `NavigationLink` from Today (no link for a task or from the habit page). A "This day" section holds the status (`day-result`). Full-width native-size buttons sit in a clear row, prominent ink only for Mark done / Add 1 glass / Add a check / Start timer / Pause timer, bordered for everything else. The logs are a headed section with one row per log ("Today's logs", "Checks today", "Slips today", "Logs for Sat, 3 Oct") and appear only when there are some. A single check's row has its own Undo; a log with a value opens Edit Log. Then a "Note for this day" row opens `NoteSheet`, and Skip / Undo skip sits in the same place. ⋯ holds View Habit, Edit, Pause, then Archive and Delete. Undo done / Undo today's check are bordered, not prominent: they correct and aren't the goal's next step (U16). A multi-check habit has no whole-day Done switch any more (the research matrix lists it under Avoid); History's Add Entry still adds several checks at once. Spacing uses `listSectionSpacing` with `@ScaledMetric` gaps (28 outside the activity, 10 inside, 24 note→Skip); check the rhythm on the iPhone. **Tasks (the user, 4 Oct 2026):** no date row and no "Planned for" row (the line under the name says when); a **Reschedule** section with Do Tomorrow and Another Day… (a graphical calendar of only the allowed days). A repeating task moves only today's occurrence, to a day before its next one; a daily task and a done task show no Reschedule; no Skip for tasks. Skip stays at the end of a habit's sheet, not pinned (the user's call; a pinned bar is the fallback if it proves hard to find). Original proposal text: Source: [The Habit Day Sheet — Wording, Hierarchy and Actions](<../Research/Research Reports/Day Structure and Organization/Day Details and Entry Editor Handoff/The Habit Day Sheet — Wording, Hierarchy and Actions.md>) and [21 Markdown-renderable wireframes](<../Research/Research Reports/Day Structure and Organization/Day Details and Entry Editor Handoff/Day Details Wireframes.md>) ([editable Figma variants](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=370-2031)). The selected day is the short toolbar title, with no bottom pager; the habit identity opens its page. The trailing dismissal control is the native `xmark` Close icon in a 44 pt target, balanced by an equally sized ⋯ target; it retains the spoken name **Close** (U18). The selected-day status, its native-size logging controls and any editable logs form one activity group. A day-note field follows; Skip/Undo skip is its own button in a stable position. While skipped, new-log controls remain visible but disabled, and saved logs and note remain visible (U15). Positive-goal actions can be prominent; limit/slip logging stays bordered (U16). These Figma pop-ups represent layout and behavior, **not final iOS visuals**: implement native SwiftUI controls, symbols, menu, note preview and accessibility (U1).

**Spacing in this proposal (U17):** use smaller inter-element gaps inside one job—10 pt status to its control, 8 pt quick to manual and log heading to records, 18 pt logging controls to the logs subgroup. Give the whole day-activity group 28 pt *outside* space above and below it; leave 24 pt between the note and Skip/Undo skip. These are prototype relationships, not added card padding or fixed SwiftUI constants. Recheck on the real iPhone with Dynamic Type before implementation is called done (U1/U9).

**4 Oct 2026 single-record editor: built on branch `details-page-update` (`EntryEditView`, titled Edit Log / Edit Slip); CI and the iPhone check are pending.** As built: the system back chevron with no title; Back with changes asks Discard Changes / Keep Editing. The identity row comes first, with day · source as its footer. Then the value section: an amount with its unit, a multi-check count, three Hours / Minutes / Seconds rows with Next/Done and fractional seconds, or a slip's read-only Date, editable Time and its time zone. Problems are stated in the footer, never clamped. **Delete this log / slip is a red-text destructive row in its own last section, not a red-filled button** (Apple HIG Buttons: destructive actions are red text in a plain style, never the prominent button; [research note](<../Research/Research Reports/Day Structure and Organization/Day Details and Entry Editor Handoff/Editing One Habit Log — Scope, Fields and Recovery.md#delete-button-style-in-the-native-build-4-october-implementation>)), and it asks first in a native alert. A slip's date stays read-only until the atomic cross-day move exists. Original proposal text: Source: [Editing One Habit Log — Scope, Fields and Recovery](<../Research/Research Reports/Day Structure and Organization/Day Details and Entry Editor Handoff/Editing One Habit Log — Scope, Fields and Recovery.md>) and [ten Markdown-renderable wireframes](<../Research/Research Reports/Day Structure and Organization/Day Details and Entry Editor Handoff/Entry Editor Wireframes.md>) ([editable Figma states](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=408-2071)). Amount and duration logs open **Edit log**, a multi-check record opens it only when its saved value can meaningfully change, and a quit slip opens **Edit slip** to correct **when it happened: date and time**. A single check, checklist step and task correct directly in the Day sheet, without a generic “Times 1” form. Duration hours/minutes/seconds are visible together: tap a value to select and type it with the native number or decimal pad, use Next/Done across the fields, and preserve fractional seconds. A slip uses compact native Date and Time pickers in the saved time zone. Keep the chosen log's value and unit first, tracked day/source as compact context, native Back/Save in the toolbar, and a full-width native **Delete this log/slip** button near the bottom safe area with no divider above it. Tapping Delete must open a native alert naming the one record and offering Cancel and a destructive confirmation; initial tap changes no data while no durable deletion Undo exists. Preserve other logs, the note and skip flag. A changed slip date requires an atomic update of timestamp **and** tracking day under the same record ID, with day-bucket and quit-run recalculation; return to the destination Day sheet, leaving the old day's note there. Until that storage path is implemented, do not expose a date picker that appears to save. Route the affected Day-sheet rows without dead chevrons and validate on the iPhone with large text, light/dark and VoiceOver. Build every visual control natively; Figma glyphs and dimensions are representations, not the final design (U1).

**7 Oct 2026 redesign: built and tested on GitHub, in `main` since 7 Oct 2026 (branch `day-details-logs-notes-redesign`;
runs in Current Work 59; the iPhone check, U9, still to do): Day details, All logs, Add / Log / Edit log, slips, Add a check,
Mark a day done, Tick steps, Add note / Note / Edit note.** As built: `AddLogView` (one Add screen for every kind, from
Day details, History, a Today row and its menu, a widget, the timer screen and the routine player), `LogRecordView`
(Log / Slip view, Delete | Edit, then Edit log / Edit slip), `AllLogsView`, `DayActivity` (the This day card, the logs
rule), `DaySpacing` (gaps between the SE minimum and the maximum, from the sheet's height and the text size),
`NoteSheet.swift` (`AddNoteView`, `NoteView`), the shared pieces in `RecordParts.swift`. The store stamps a log with its
chosen time inside its own day and allows same-day time edits for every log (`logTime`, `sameClockTime`, `editEntry`). Before changing any of these screens, read
[Day Details, Logs and Notes — 7 October Redesign](<../Research/Research Reports/Day Structure and Organization/Day Details, Logs and Notes — 7 October Redesign/README.md>):
one folder with the pages to update and the code behind each, images of every screen, and the design decisions; its
"Read this first" above all. In short: **Water (an amount habit) is designed at all three sizes; every
other kind, the day states, notes and the confirmation pop-ups at the 6.1-inch size only, with one button-word rule
per kind (its section 8)**; the Figma frames show the **overall layout, not exact spacing** (their toolbar almost touches the
top, for one); build native and **adapt to the screen's height**, designed for the iPhone SE first (one line of note
there; with three logs or fewer show them all and no "All logs" row; gaps between a minimum and a maximum). A record
opens as a **view** (Log, Slip, Note) with **Delete | Edit** at the bottom; **Edit** opens edit mode with **Save**;
Add screens have ✕, a Time row and one filled button at the bottom above the keyboard. Its section 0 lists every point
the user made. The Rulebook carries it (U16–U19, U21–U23, rewritten 7 Oct 2026); the routine player's Habit options becomes Day
details (U23). Checklist: Current
Work 59, 60, 61, 62.

## Ticking off, folding and settings (1 Oct 2026)

Source: [Ticking Off, Folding and Small Settings — What People Need](<../Research/Research Reports/Home Screen and Visual Design/Ticking Off, Folding and Small Settings — What People Need.md>). Checklist: `Docs/Checklists/Animations and Settings.md`.

- **Nothing on Today moves in the middle of a run of taps.** Every log (✓, +, a timer stopped, a step, a sheet closed after logging, an undo) calls `TodayLayout.hold` before changing data. Order and folds stay as shown until 1.5 s after the last log; then finished parts fold and done rows sink together (`Motion.settle`). **By default done habits move below the rest** (the user's final call, 3 Oct 2026, reversing that morning's "stay in place"; Rulebook U13); Appearance → Done Habits → Stay in Place keeps them where they are. Never sort or fold straight from a tap. The row offering "Add note" still keeps its place (Notes rule).
- **Feedback comes from the log, never from a redraw** (`TickFeedback`): no `sensoryFeedback(trigger: done)` on a row or button, since changing the day flips `done` and buzzed. Haptics on by default, sound off; both switchable in ≡ → Appearance. No confetti or celebration screens.
- **The completion (success haptic and the chime) plays once, at the moment a habit becomes complete** (the user, 5 Oct 2026, Current Work 18): the last of a checklist's steps; the log that crosses an amount's goal, even past it (9 → 11 of 10), and nothing for logs after; typed time or an amount when Log is tapped, if it crossed; an edit that crosses, on Save; a running timer the moment its clock reaches the goal, or, if the app was away then, when it's stopped; a period goal on the log that meets the week or month. Every other log is a light tap. **Never for quit habits (Log Slip) or limits**: reaching a number there isn't something to celebrate. The store decides for every log, whatever screen it came from (`HabitStore+Feedback`, `onLog`); views give only undo's and a timer start's taps. In the app only: a log from Siri, a widget or a notification is silent. Checked by `FeedbackCheck` (`CompletionFeedbackUITests`).
- **Tick motion is a transform on the 34-pt button and the row fill** (`keyframeAnimator` scale, `ProgressFill` scaled from the leading edge). Don't animate a row's layout, and never block the next tap.
- **Each time of day is its own view (`PartSection`) reading only its own `FoldBox`.** Folding one part must not redraw Today's other rows. Don't put fold state back into `TodayView`'s `@State`, and don't pass a fresh `Binding` into `HabitRow` (it made every row redraw on every Today redraw).
- **Reduce Motion:** no pop, sweep or slide; folds and settles fade (`Motion`).
- **Day start and week start apply everywhere or not at all.** Read the day through `store.today()` / `store.calendar`; never subtract hours from a moment (it was an hour off on daylight-saving nights). Changing either clears Progress's cached scores.
- **No setting for 12/24-hour time, daylight saving or time zones.** Times use the iPhone's format (`DaySection.clock`, `.formatted`); logs keep their `LocalDay`. A second clock switch could disagree with the iPhone's.
- **The theme is set on the window** (`Theme.apply`), so sheets and alerts follow it at once.

## Checked on the iPhone (2 Oct 2026)

The first signed build on the user's iPhone 16 (iOS 26.6) found three bugs GitHub's simulator never showed. **Check
every visual or layout change on the real iPhone before calling it done.**

- **Switches are the iPhone's green; Select's circles its blue.** *4 Oct 2026:* `SwitchToggleStyle(tint:)` lost to a nearer `.tint(.ink)` (the player's Show clock was near-white); every switch now uses `.toggleStyle(.appSwitch)` (`AppSwitchStyle`, the tint set on the switch itself), and `check_rules.sh` fails on any other switch style. A group's habit picker uses the same blue circles as Select. The app's ink tint is near-white in dark mode, where
  an "on" switch and a selected row's check couldn't be read. `HabitsApp` sets
  `.toggleStyle(SwitchToggleStyle(tint: Color(.systemGreen)))` on the root; lists in edit mode tint
  `Color(.systemBlue)` (`AllHabitsView`).
- **A `Toggle` inside a `Menu` sets `.toggleStyle(.automatic)`** (`ProgressScreen`'s View Options). The root's switch
  style reached the menu's toggles and they stopped responding: Show Percentages could no longer be turned off
  (`testHidePercentages`, 2 Oct). A toggle in a list or form stays a green switch.
- **Never a lazy grid inside a `List` or `Form` row.** Opening any habit's page crashed the app on the phone (the
  list re-laid out its cells 100 deep and asserted). Plain `Grid`s now; `check_rules.sh` fails on a lazy grid outside
  the files that host one in a `ScrollView` (`PERFORMANCE-LESSONS.md` L19).
- **A test launch never touches the person's data** (`-uitest`: its own signed-out store, backup state and folder, no
  iCloud). Rule 16 in the Data Safety report; keep it for anything new that stores or sends data.

## Widgets: taps and updates — LOCKED (8 Oct 2026)

The user checked every part on the iPhone and asked for it to be locked. The full record, decision by decision, is
[Widgets — Taps and Updates (Locked)](<Docs/Widgets — Taps and Updates (Locked).md>) (Rulebook U28). Don't regress:

- **A tap changes the whole card at once** (button, number, bar, row fill, the list's "N of M done"), like Reminders: the
  ✓/+ is a switch over the card whose "after" is the app's own next state. Only the round button takes the touch.
- **The tap runs in the widget's process, then hands over to the app in the background**, which saves, syncs and backs
  up. Never an app-process intent for a tap that should show at once (iOS waits ~3 s). Never a tap kept only on the
  phone until the app opens.
- **Every tap counts:** quick + taps move on (24 → 25 → 26 → 27); a ✓ tapped twice ends unticked; taps on different
  habits are all saved, in order.
- **Timers start and stop on the widget** and in the Dynamic Island; the app doesn't open.
- **Steps (checklist) → Day details, ↗; quit → Record a slip, ↗; a number to type → the log sheet, a plain +.** A widget
  link replaces whatever the app had open; an older one never comes back.
- **Logging in the app then going straight home shows on the widget within ~1 s** (publish 0.5 s after a change, and
  at once when the app starts to leave).
- **Check habits keep ✓; week and month goals fill toward their period**, as on Today.
- **Never:** `invalidatableContent` on buttons, nested switches, numbers worked out in the widget, a week of timeline
  entries.

## Words the app never uses

- **"Due", "overdue"** anywhere (the user, 29 Sep; copy rule from before). Tasks are "For today" or "Planned for Wed 1 Oct"; habits happen "on its days".
- **"Add Time" / "Add Amount"** for logging by hand. *7 Oct 2026:* beside a quick button or the timer, "Log manually"; alone,
  "Log amount" / "Log time"; the screen is "Add log" (its kind's title: Add a check, Mark a day done, Tick steps, Add slip).
- **"Entry" / "Add Entry" / "Edit Entry"** (7 Oct 2026): it's a **log** (Add log, Log, Edit log, Delete log).
- **"Habit options" / "Task options"** in the routine player (7 Oct 2026): it's **Day details**.

## Habit details: 4 October research handoff (design proposal, not built)

The [revised Final UX Pass](<../Research/Research Reports/Habit Details Research/Final UX Pass/README.md>) and its [22 individual mockups](<../Research/Research Reports/Habit Details Research/Final UX Pass/Wireframes.md>) are the current design handoff for the habit-details header, History actions, record creation and Notes. The latest [consistency revision](<../Research/Research Reports/Habit Details Research/Final UX Pass/Consistency Revision.md>) is a proposal awaiting user review. It removes the first pass's History/Notes sticky bottom bars, name-generated CTA copy and alternate Day-details screens. It preserves the History month/day chronology, Progress design, accepted Day-details sheet and single-record editor. Rulebook U20/U21/U22 records the cross-surface model.

The navigation title names **Habit details**; icon/name/goal and time section center beneath it, followed by the tabs. **5 October placement revision:** [streak-placement research](<../Research/Research Reports/Habit Details Research/Final UX Pass/Streak Placement — Shared Header or Progress.md>) places Current/Best visibly in the individual habit's early Progress summary, and quit Current/Best run in its open Overall record. The shared header omits the duplicated pair; keep Today's quick streak/live-counter access, Show Streaks and factual Quitting since context. The 4 Oct common-header pair is superseded because main-list visibility reviews do not establish relevance above History or Notes. A task has no streak or habit Progress tab. History keeps **Open day…** and a native-size, short **type-based** record action within its own scroll content. Open day… opens the exact old or empty date in Day details. A new-record form uses the accepted editor's identity/toolbar grammar; its date picker returns to the unsaved form. Binary, checklist and skipped dates use the accepted Day-details controls. Notes keeps full-width Search first and a separate leading Add note text-action row below it, before the dated rows. The note reader's **Open day details** uses the note's date; **Edit note** sits near its content. Confirmed **Delete note** exists in reader More and at the bottom of the existing-note editor; new-note creation has no Delete. All chrome uses monochrome semantic ink; new forms reuse the accepted bounded number/count and tap-to-type H/M/S fields, compact dates and multiline notes. New-note dates can be selected; existing-note dates stay fixed. Build these natively and verify on a real iPhone before treating the proposal as implemented (U1/U2/U9/U19/U20/U21/U22).

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
| + adds 1 or asks how much, by goal size ("Add amount to Walk") (29 Sep) | + adds its saved step ("Add 1,000 steps to Walk"); the row opens its Day sheet (3 Oct) |
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

- **Today's top bar is ≡ · Edit · (Filter +)** (3 Oct 2026). Edit is a word in its own capsule (Apple: keep text-labelled actions apart from symbol ones); Filter and + share one. While arranging: only Done. Filter's icon is `line.3.horizontal.decrease.circle`, never the bare three lines, which look like ≡.
- **Menu order, most used first:** Today · Progress · Habits · Tasks | Times of Day · Reminders · Appearance | Backup & Export · Privacy | Plus | Help & Feedback · About. Row names are the pages' titles. Icons are monochrome (colour is for habits only).
- **Every row pushes its page onto Today's own navigation stack** (`MenuModel.path`), so Back and the edge swipe return to Today. A page that isn't built opens a "coming" page that says what it will hold; wire the real page in `MenuPage`.
- **One screen per thing, however many ways in:** ≡ → Times of Day (`TimesOfDayList`) and Today's Edit (`ArrangeDayView`) open the same `SectionEditor` for a time of day; Habits and Tasks are one `AllHabitsView(kind:)`.
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
