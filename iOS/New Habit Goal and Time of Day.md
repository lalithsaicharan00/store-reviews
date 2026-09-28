# New Habit — the Complete Decided Spec

Written by Claude (Claude Code), 27 September 2026, from the user's decisions the same day. **This is the one place for everything decided about creating and editing a habit.** Build from this file.

- **Evidence:** [Time of Day and Reminders — What Users Want](<../Research/Research Reports/Habit Creation/Time of Day and Reminders — What Users Want.md>) (main report plus addenda 1–5).
- **Still valid from the older spec:** [Pending to Implement.md](<Pending to Implement.md>) §6. Reminder scheduling (per-row suppression, same-minute grouping, Remind Again), the AlarmKit alarm and the notification actions are already built and apply unchanged. Everything else there about placement is replaced by this file.
- **Mockup:** shown in chat on 27 Sep (the chooser plus the New habit form with a Goal row and the Time of Day menu).

## Decisions at a glance

| # | Decision |
|---|---|
| 1 | Creating starts with two questions, one per screen: **What do you want to create?** (a good habit, a bad habit, a task), then **How do you want to track it?** or **What do you want to do?**. Then one form. Everything is pushed; no icons |
| 2 | Check it off, Count an amount and Time it are **one "New habit"** with a **Goal row**: a number and a unit, per day |
| 3 | **Times** is a tick at any number (1 time = plain tick, no "0/1"); **any other unit** is a counter; **minutes** is timed |
| 4 | The time unit is called **minutes** (with a timer), set with an hours-and-minutes wheel, shown as "1 h 25 min". No separate hours unit |
| 5 | **Numbers:** whole stays whole; decimals up to 2 places; totals follow the same rule; **1,000 and up uses "k"**; time never uses decimals or "k" |
| 6 | **"Time of Day"** replaces "Day Section" everywhere. A menu: parts of the day, then **"or"**, then **Anytime** (GOV.UK exclusive-checkbox pattern). Anytime is the default |
| 7 | The **daily goal and the time of day are independent**: the goal is how much; the time of day is only where it's displayed. Picking parts never changes the goal. Parts are **always multi-select**; only Anytime is single. Several parts show **the same row in each, with one shared progress**, for every type (no per-part ticks, no splitting) |
| 8 | **Reminders** are separate: Remind Me is off by default and never moves the habit. Each reminder stays inside its time of day. Tasks have no progress or stats |
| 9 | **Editing** shows only what can change (as HabitNow does). **How it's tracked** (Done or not / A number / Time / Checklist, and Build / Break / Once) **is fixed and not shown.** Changes apply from today; past days keep their results; if the kind of period changes, the streak restarts |
| 10 | **Progress:** did-I-do-it stats run straight through changes; how-much stats start at the change, with a marker. Nothing is ever invented |
| 11 | **Start date** (default Today; any past or future date) and **end date** (default Never; never before the start date), in their own Dates section above Reminders |

---

## 1. The New flow (built 27 Sep, round 6)

**Structure, decided from evidence:** two question screens, then **one** form.
- The two questions change what the form contains, so each gets a screen of its own, with one question and at most four answers.
- Everything else has sensible defaults and is shown together on one form, so people can see it all and tap Add early.
- The same form is reused for editing.
- A step-by-step wizard for every field (HabitNow's page dots) adds a screen per decision. Its one complaint was "too many clicks" (addendum 5), and nothing in the reviews asks for one question per field. *Reasoned from first principles.*

**Consistency rule:** everything is pushed in one navigation stack inside the New sheet.
- Choices inside the form are **menus** (How Often, Time of Day, Unit, Repeat, Remind Me With, Remind Again).
- Anything that needs a page (icon, unit list, a new time of day) is **pushed**.
- There are no sheets or pop-ups inside the flow. The only dialog is "Discard this?" on Cancel.
- **No icons** on the choice screens: the words carry them (the user's rule: no coloured icons).

**Wording** comes from the reviews (246,230 English habit-app reviews, `Temp/timeofday/plain_words.py`; Reddit was blocked, so it isn't used):
- "good habit" 4,389 · "new habit" 3,816 · "build a habit" 2,471
- "bad habit" 2,411 · "quit" 1,455 · "break a habit" 481
- "task" 19,440 · "to-do" 3,568
- "check off" 2,302 · "tick off" 536 · "yes or no" 358
- "count" 2,491 · "how many" 1,613 · "how much" 1,869
- "minutes" 2,480 · "timer" 1,914 · "how long" 795
- "checklist" 1,317

**Screen 1: "What do you want to create?"**

| Row | Line under it | Example |
|---|---|---|
| **A good habit** | Something you want to do regularly. | Read every day |
| **A bad habit** | Something you want to stop, or do less. | Smoking, coffee |
| **A task** | Something to get done, once or on repeat. Tasks don't have progress or stats. | Pay the rent |

**Screen 2 after a good habit: "How do you want to track it?"**

| Row | Line | Example |
|---|---|---|
| **Check it off** | Done or not done. | Take vitamins |
| **Count it** | How many or how much. | Drink 8 glasses of water |
| **Time it** | How long, with a timer. | Read for 20 minutes |
| **Checklist** | A short list to tick off. | Push-ups, squats, plank |

**Screen 2 after a bad habit: "What do you want to do?"**

| Row | Line | Example |
|---|---|---|
| **Quit** | Stop completely. It counts the time since. | Smoking |
| **Cut down** | Do it less, with a daily limit. | At most 2 coffees a day |

**A task** opens its form directly:
- **Repeat:** Never (a date) or On a schedule (How Often, set schedules only).
- **Time:** optional.
- **Always says:** "Tasks don't have progress or stats." A task has no streak, no statistics and no progress (the user's decision).
- A repeating task is due on its schedule and is done per day.

**Free plan:** the habit limit is checked when a good or bad habit's form would open. Tasks are always free.

## 2. The New habit form (compact; built 28 Sep)

The user's layout (28 Sep), in native components:

| Group | Rows |
|---|---|
| 1 | **Name** on its own row. **Icon · Colour** side by side below it; each opens a pop-up (the icon picker; a colour grid that closes on pick) |
| 2 | **Repeat** (value e.g. "Every Day") · **Time of Day** (e.g. "Morning, Afternoon"). Each opens its **own full screen** |
| 3 | **Goal** (e.g. "4 times a day"; "Items" for a checklist). Opens its own full screen |
| 4 | **Dates:** Starts (Today) and Ends (Never), §2b. Its own section, above Reminders (the user's change, 28 Sep) |
| 5 | **Reminders:** a **Remind Me** switch first (on by default). Only while it's on: the reminder rows (one by default, removable with ⊖, then **Add Another Reminder**), and right below them, with compact spacing, **Remind Me With** (a notification or an alarm) and **If Not Done, Remind Again**. The live sentence is the footer |

- **Full screens** (pushed):
  - **Repeat:** every How Often option shown at once, as checkmark rows in two groups ("On a set schedule", "On any days you like"), then the chosen one's details. The start and end dates are not here.
  - **Time of Day:** checkmark rows under "Pick one or more", then "Or" Anytime, then New Time of Day, and the live sentence.
  - **Goal:** the type's goal controls.
- **Pop-ups** are used only for icon and colour (the user's choice). No coloured icons on rows; values sit on the right, as in Settings.
- **Switches are system green** when on. The app's accent colour is white in dark mode, which made an on switch look off. Checked on the iPhone in dark and light mode.
- **A reminder is on by default** (the user's decision, 28 Sep). *This departs from the evidence:* the main report found forced reminders draw 1★ reviews (§2.2). It's acceptable because one tap on ⊖ removes it, and notification permission is asked only when the habit is saved with a reminder.
- **Quit:** name, icon and colour, and its "Started" date. **Task:** its date or repeat, Time of Day and reminders.

## 2b. Start date and end date (decided by the user, 28 Sep)

A **Dates** section of its own on the form, above Reminders (the user's change, 28 Sep; first placed on the Repeat screen):

| Row | Default | Choices |
|---|---|---|
| **Starts** | **Today** | Any date, past or future |
| **Ends** | **Never** | Never, or On a date |

- **Past start:** the habit counts from that date. Its earlier days appear, so they can be ticked, and a streak kept elsewhere can be brought in.
- **Future start:** the habit stays off Today until that date. The How Often footer's "First due …" names it.
- **The end date can never be before the start date.** The date picker only offers dates from the start date onward (start 28 Sep → the earliest end is 28 Sep, never 27 Sep). If the start date is moved later than a chosen end date, the end date moves with it, to the new start date.
- **After the end date:** the habit leaves Today, its reminders stop, and its history, streak and stats are kept.
- **Applies to** every habit type that has How Often (good and bad habits except Quit, which has its own "Started" date), and to repeating tasks. A one-time task has only its date.
- **Evidence:**
  - End date: about 98 reviews in 32 apps, plus 34 mentions of fixed-length challenges (21-day, 30-day, 75 Hard). For example "not all of my goals are never-ending… '10 weeks' or '3 months'"; "the start-end date feature is amazing" (75 Hard).
  - Past start: Ledger C010 (Strong, 34 apps), e.g. "can't manually add previous streaks… an absolute deal breaker".
  - Future start: weak (11 reviews), but cheap.
  - Scan: `Research/Temp/timeofday/dates_scan.py`, 28 Sep.
- **Built 28 Sep** (Core schema 5, migration test 4→5 passes). **Storage:** `habit.createdAt` stays the moment it was made. Add `starts_on` (a day) and `ends_on` (a day, optional) to the habit in an add-only schema change. The day rules use `starts_on` in place of the created day, and hide the habit after `ends_on`.

## 3. Goal: a number and a unit, per day

One row: `Each day   [−] 1 [+]   times ⌃⌄`. The default is **1 time**.

| Goal | What it is | On Today |
|---|---|---|
| **1 time** | A plain tick | The name and a ✓ button. **No "0/1".** |
| **2 or more times** | Still a tick habit: each tap is one tick | "1/3" and a ✓ button; a partial day shows as partial |
| **Any other unit** | A counter | "3/8 glasses" and a + button that adds one step |
| **minutes** | Timed | "12 min/20 min" and ▶ for the timer |

- **The rule users see** in the Goal footer: "Leave it at 1 time for a simple tick. Change the unit to count something." The number of times never makes a counter; only the unit does.
- **Units:**
  - times;
  - minutes, labelled "with a timer";
  - glasses, cups, pages, steps, reps, km, miles, litres, ml, kg, $;
  - your own.
  Minutes sets its goal with an hours-and-minutes wheel.
- **The step per tap** ("Each tap adds") stays for counters.
- **Long-press menu** on counters and timed habits:
  - **Add Amount…** types any amount (3.2 km, 45 min);
  - **Mark as Done** fills the day's goal in one tap.
  Going past the goal is allowed and recorded.
- **No caps** on goals or amounts.
- **Evidence** (addendum 3):
  - No reviewer wants "a unit but only a tick".
  - A plain habit shown as "0/1" annoys people.
  - Strides' separate tracker types cause setup confusion (118 reviews).

## 4. Numbers

| Rule | Examples |
|---|---|
| A whole number shows as a whole number | 8 → "8", never "8.0" |
| A decimal shows up to **2 places**, trailing zeros dropped; input accepts up to 2 places | 2.5 → "2.5" · 0.25 → "0.25" · 2.50 → "2.5" |
| Totals follow the same rule | 0.25 + 0.25 → "0.5" |
| From **1,000** up: the **k** suffix, at most one decimal, no ".0" | 1,000 → "1k" · 5,200 → "5.2k" · 12,500 → "12.5k" |
| Time never uses decimals or "k"; it shows hours and minutes | 45 → "45 min" · 60 → "1 h" · 85 → "1 h 25 min" |
| Time is stored in minutes, so totals add up correctly | 1 h 30 min + 1 h 40 min = "3 h 10 min" |
| VoiceOver reads the full number | "five thousand two hundred steps" |

Change `Format.amount` from one decimal place to up to two, and add a time formatter.

## 5. Time of Day

**Naming:** "Time of Day" is what reviewers say (121 against 93 for "section"). Today reads "Edit Times of Day"; the editor says "New Time of Day", "Edit Time of Day" and "Delete Time of Day".

**The row** looks like How Often: `Time of Day   Anytime ⌃⌄`. It's a native `Menu` that stays open while choosing, and the whole row is tappable.

```
PICK ONE OR MORE        (always: every type)
   Morning
   Afternoon
   Evening
   <user's own, in time order>
OR
 ✓ Anytime
────────────
 + New Time of Day…
```

- **Pattern:** GOV.UK Design System's "none" checkbox: an "or" divider, the exclusive option last. Picking either side **clears the other automatically**. There's no pop-up.
- **Unticking the last part** returns to Anytime, so the row is never blank.
- **The daily goal and the time of day are independent (decided by the user, 28 Sep).**
  - **The goal** is how much or how many times a day, e.g. 4 times or 20 times.
  - **The time of day only says where the habit is displayed** on Today, e.g. Morning and Afternoon.
  - **Picking parts of the day never changes the goal.** Type 4 per day, pick Morning and Afternoon, and it stays "4 times a day". The goal never limits how many parts can be picked.
- **Always multi-select:** any number of parts, for every type except Quit, which has no time of day. **Only Anytime is single.**
- **Several parts = the same row in each part, with one shared progress. For every type.**
  - A 4-times-a-day habit in Morning and Afternoon shows "1/4" in both parts. A tick in either adds to the same 4.
  - It's one habit, with one daily total and one streak. The day is done when the goal is reached, wherever it was ticked.
  - **This replaces** the earlier per-part ticks ("a tick in each") and shared-out amounts ("3 + 3 + 2"). There's no splitting of the goal.
- **Built 28 Sep:** per-part ticks and shares removed; the Times a day stepper always shows the goal as typed; the sentence uses the shared-row wording.
- **Row summary:** "Anytime", "Morning" or "Morning, Evening".
- **Sentence:** "It shows in Anytime on Today, so you can do it whenever suits you." / "It shows in Morning and Afternoon. It's one habit: do it in any of them."
- **Why not reminder times:** a reminder never decides where a habit shows (§6). The first build did that, and it confused people.

## 6. Reminders

Each detail appears only once the one before it is on: **Remind Me** → the reminder times → **Remind Me With** (a notification or an alarm) → **If Not Done, Remind Again**.

- **Remind Me** is off by default. A time of day never forces a notification.
- **Any number of reminders (decided by the user, 28 Sep).** It's not limited to one per part of the day, and Anytime can have several too.
  - Evidence: 52 reviews in 29 apps (mean 4.1★) tie reminders to how often they do the habit: "drink 4 cups of water a day… set 4 reminder times instead of making 4 diff[erent habits]"; "8 glasses… an alarm for every single intake"; "drink water every two hours on weekdays". A 1★ review complains when an app allows only one: "you can't have multiple reminders a day". Scan: `Temp/timeofday`, 28 Sep.
  - **No small cap in the form.** iOS keeps at most 64 upcoming notifications per app; the scheduler already keeps the nearest 60, so a habit with many reminders just fills fewer days ahead.
- **Each reminder sits inside one of the chosen parts, and its time can only be set inside that part** ("Morning reminder" can't be set to 9 PM). Anytime reminders can be any time. With only Morning chosen, every reminder is in the morning; with Morning and Afternoon, e.g. 3 morning and 1 afternoon.
  - This is the user's proposal: a "Morning reminder" at 9 PM contradicts its own label, and placement and reminders disagreeing is what confused reviewers (main report §1, `A53#1416`).
  - "Add Another Reminder" adds one to the part of the day with the fewest.
- **Reminders stop once the day's goal is met.** With 4 cups and 4 reminders, the rest of the day's reminders don't come after the 4th tick. One reviewer complains about the opposite: "notifications continue even after the habit has been marked as complete" (Awesome Habits, `11839032938`).
- **Turning it on** adds one reminder per chosen part of the day, at a time inside it (Morning → 7:00 AM; Anytime → 9:00 AM). The rows are labelled "Morning reminder". They follow the parts of the day until the user edits one, and "Add Another Reminder" adds more.
- **Reminders never move the habit.** If one falls in another part of the day, the sentence says so.
- **Alert** (Notification or Alarm, iOS 26+) and **If Not Done, Remind Again** (Never, 15 min, 30 min, or every hour, up to 3 times) show only when Remind Me is on.
- **Denied permission:** the footer says so and shows an **Open Settings** button.
- Scheduling, grouping, alarms and notification actions follow [Pending to Implement.md](<Pending to Implement.md>) §6. They're already built.

## 7. Types that keep their own form

- **Checklist:** items to tick; done when all are ticked.
- **Set a limit:** a goal that's a maximum; + always logs; no Remind Again.
- **Quit:** time since the last slip; shown under Quitting; no time of day.
- **To-do:** a date and an optional time; moves forward until done.
All of them use the same Time of Day row, always multi-select (§5). Quit has no row.

## 8. Changing a habit later (the edit screen)

**Decision (user, 27 Sep, following HabitNow):** the edit screen shows **only what can be changed**. What can't be changed isn't shown at all: no greyed-out rows, and no "can't change this" notes.

| Fixed after creation (not shown when editing) | Can be edited |
|---|---|
| **How it's tracked:** Done or not, A number, Time, Checklist | Name, icon, colour |
| **What it is:** Build (habit), Break (Set a limit, Quit), Just once (to-do) | How Often |
| For **Done or not:** that it's ticks. For **A number:** that it's a counter. For **Time:** that it's minutes | The goal's number: times a day, the amount, the minutes. For A number, also the unit and the step |
| | Time of Day, Reminders, Alert, Remind Again |
| | Checklist items, a limit's maximum, a to-do's date and time |

**The trade-off:** HabitNow's 11 reviews asking to change how a habit is tracked (addendum 5). We accept it: it's rare (about 0.04% of HabitNow's reviews), those reviewers are happy (mostly 4–5★), and the workaround is making a new habit. Evidence and quotes are in addendum 5 of the research report.

**Rules for the changes that are allowed:**
1. **Changes apply from today.** Nothing is deleted.
2. **Past days keep the result they had.** Each day is judged by the goal and frequency in force on that day. This needs a **goal history**: an add-only table of habit, from day, goal, unit, step and frequency. The day, streak and progress rules read the rule in force on each day. It's needed for any edit, even changing 8 glasses to 10.
3. **Streak:**
   - It continues when the kind of period stays the same: between set schedules, or within the same week or month rule.
   - If the kind of period changes (daily ↔ weekly ↔ monthly), **the streak restarts**, and the best streak and history keep the past. There's no conversion maths.
4. **The edit form says what will happen before saving**, in one line: "Changes apply from today. Your history stays as it was." or "Your streak restarts. Your history stays."

## 9. Progress and statistics after a change

| Kind of stat | Rule | Example (a counter whose goal or frequency changed on 12 Oct) |
|---|---|---|
| **Did I do it?** (calendar, % of due days done, days done, streak, best) | Runs straight through; each day is judged by its own rule; not-due days are neutral | "Done 58 of 63 days"; one calendar across both periods |
| **How much?** after a change of **frequency** only | The chart continues; totals keep adding | — |
| **Same unit, new number** (8 → 10 glasses) | The amount chart stays continuous; the goal line steps up on the date | — |
| **A different unit** (steps → km; only A number can change unit) | The units can't be converted: the amounts chart starts again at the change, with a marker; nothing is invented for earlier days | "Steps until 12 Oct" · "km since 12 Oct" |

## 10. Out of scope for now

- **Readings** (weight, a mood score, hours slept as a value): a latest value or average, not a daily total (addendum 4).
- **Converting streaks** between days, weeks and months (§8).
- **Changing how a habit is tracked** (§8). It's fixed at creation.

## 11. Order of work

1. **Numbers** (§4): the formatters only.
2. **Goal history** storage (§8.2): Core schema 5 (add-only table and migration test), plus the day, streak and progress rules reading it.
3. **The chooser** (§1) and the **New habit form** with the Goal row (§2–3). Existing check, amount and duration habits keep working; the form maps onto the stored kind.
4. **Time of Day** menu: display only, the same row in each chosen part (§5).
5. **Long-press** Add Amount… and Mark as Done (§3).
6. **Edit screen**: the form showing only editable rows (§8), with the one-line "what will happen" footer.
7. **Build and install on the iPhone.** The user checks it before any full test run.
