# New Habit Round 4 — Checklists, Streaks and Times a Day

> **Written by Claude (Claude Code)**, 27 September 2026. Round 4 items 20–30 ([iOS/Product Roadmap.md](<../../../iOS/Product Roadmap.md>)). Updates [New Habit Words and Units](<New Habit Words and Units.md>). Authorship of every report is listed in the [Research Reports index](<../README.md>).

**The questions.**
1. What should a checklist's example be, and what are the things inside it called? ("Parts" felt wrong; skincare isn't for everyone.)
2. How should a streak show for each frequency, so the number is never mistaken for days?
3. Does "Times each day" on Check it off add anything, and how should one habit show more than once a day?
4. Do people need weekly or monthly goals?

**Basis.**
- A fresh screen of 1,048,400 English habit-app reviews (App Store + Play). Script: `Habit Creation Evidence/round4_scan.py`; hits in `round4_hits.json`.
- The hand-coded Day Structure study: 153 reviews that want one habit in several sections, sub-typed one by one ([Day Structure Explained](<../Day Structure and Organization/Habit Tracker — Day Structure Explained in Plain English.md>) §1.3).
- Samples read by hand: 55 streak reviews, 35 weekly/monthly-goal reviews, 32 checklist-use reviews.
- Every quote below was checked against the review at that index.

---

## The short answer

| Question | Decision | Basis |
|---|---|---|
| Checklist example | **"Example: Push-ups, squats, plank"**; name hint "e.g. Workout" | Users show: exercise is the top use |
| Things inside a checklist | **Items** ("Add Item"); the list starts empty | Users show: "items" goes with "checklist" |
| Streak number | **Every Day: "🔥 6". Other set schedules: "🔥 6×". Weekly, monthly, yearly rules: "🔥 3 wk", "🔥 2 mo", "🔥 1 yr".** Tapping it explains it in a sentence | Users show, plus first principles |
| Times each day | **Removed.** Check it off can sit in several day sections instead; it shows in each, with its own tick | Users show (Day Structure study) |
| Weekly and monthly goals | **Count an amount, Time it and Set a limit** can be a weekly or monthly total, on any days | Users show |

---

## 1. Checklists

**What people use them for** (reviews that mention a checklist or subtasks, strict patterns):

| Use | Reviews |
|---|---|
| Exercise, workouts, stretching, yoga | 109 |
| Cleaning and chores | 72 |
| Morning or night routine | 46 |
| Medication | 27 |
| Skincare | 7 |

- People want the steps of an activity: “I wish when I had a task like “clean my room” I could add steps to it” (`A10#22185`); “there should be a checklist for the different yoga positions” (`A4#19971`).
- Exercise is the top use and is recognised by everyone, so the example is a workout. Skincare is rare (7) and not universal.
- Routines stay with day sections and Start, as decided in round 2.

**What the things inside are called** (in 2,155 reviews that say "checklist"): items 144, subtasks 24, steps 23. So: **"Items"**, "Add Item", and "e.g. Push-ups" as the first item's hint. The list starts empty; Add is enabled once one item is typed.

## 2. Streaks

**What users show:**
- A weekly habit should keep its streak while each week's target is met: “It would be nice if the streak was only lost at the end of a week in which the goal was not met” (`A23#207`). Praise for exactly that: “doesnt not break your streak when you dont do a day as long as you reach you weekly number” (`P24#19536`).
- Counting days the habit isn't due confuses: “the tally counts intervening non-task days in the streak total, which doesn’t quite make sense to me” (`A23#4956`).

**Already true in the app:** set schedules count due days, and week, month and year rules count periods.

**What was missing** (reasoned from first principles): the number looked the same for all of them. "🔥 3" on a weekly habit reads as 3 days. So the unit is now on the number:

| Frequency | Shown | Tapping it says |
|---|---|---|
| Every Day | 🔥 6 | Done 6 days in a row |
| Certain days, every few days/weeks, dates of the month | 🔥 6× | Done the last 6 times it was due, in a row |
| A few times a week / weekly total | 🔥 3 wk | Goal met 3 weeks in a row |
| A few times a month / monthly total | 🔥 2 mo | Goal met 2 months in a row |
| A few times a year | 🔥 1 yr | Goal met 1 year in a row |

Only Every Day keeps a bare number, because there it really is days. VoiceOver reads the sentence.

## 3. Times each day

**"Times each day" duplicated Count an amount.** Take vitamins twice a day is either one row counting to 2 (an amount), or two separate moments. The Day Structure study hand-coded 153 reviews asking for a habit more than once a day:
- half (79) want the same habit shown in several chosen sections, each with its own tick (teeth morning and night, meds three times a day);
- a fifth (35) want a count, which is Count an amount;
- a fifth (32) want several reminders, almost always one per time the habit is done.

**So:**
- **The "Times each day" stepper is gone.**
- **The Day Section menu on Check it off takes several sections** (for example Morning and Evening). The menu stays open while you choose. The footer says "Done 2 times a day: it shows in Morning, Evening, each with its own tick."
- **On Today** the habit is a row in each chosen section. Ticking the Morning row finishes only Morning. The day counts as done when every section's tick is.
- **Reminders stay as they were:** add one per time.
- **Why not reminders alone?** A reminder is optional and invisible on Today. Placing the habit in each section shows it where it's done, which half the reviewers asked for.

The database records which section each tick was for (schema 3 adds `entry.slot`, add-only, with a migration test). Older ticks without a section still count.

## 4. Weekly and monthly totals

- People want a total, not a daily goal: “I want to track a weekly habit of reading at least 3 hours per week” (`A55#1466`); limits too: “no more than 10 cigarettes per week” (`P24#572`).
- **So** Count an amount, Time it and Set a limit offer **A Weekly Total** and **A Monthly Total**, on any days. Today shows "90/180 min this week"; the goal header reads "Weekly goal" or "Weekly limit".
- Check it off and checklists keep **A Few Times a Week / Month / Year**, which counts ticks or finished days.

## 5. Telling the frequencies apart

"Every Few Days" and "A Few Times a Week" were easy to mix up. Reasoned from first principles:
- The menu has two named groups: **On a set schedule** and **On any days you like**.
- The sentence under the row starts with the kind: "A set schedule: due every 3 days, counting from today…" versus "Any days you like: tick it 3 times in the week…".

## 6. Layout changes in this round

- Folded section names show at most 8 letters, then "…"; the icons get the rest.
- Habit names on Today stay on one line: 15 characters, then "…". VoiceOver reads the full name.
- Habit rows have the same spacing as the Quitting rows.
- The New list rows have a little more padding; all seven still fit on an iPhone SE.
- The icon sheet shows icons only (colour is on the form).
