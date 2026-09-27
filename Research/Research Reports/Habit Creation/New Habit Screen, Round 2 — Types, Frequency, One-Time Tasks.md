# New Habit Screen, Round 2 — Types, Frequency, One-Time Tasks

> **Updated by [New Habit Words and Units](<New Habit Words and Units.md>)**: the type names (Check it off, Count an amount, Time it, Checklist, Set a limit, Quit, To-do), units, three more frequency rules, day sections from the form, and the form order.
>
> **Written by Claude (Claude Code)**, 27 September 2026. Revises [round 1](<New Habit Screen — A Native iOS Design.md>) after the user tried it on the iPhone. Authorship of every report is listed in the [Research Reports index](<../README.md>).

**The feedback on round 1:**
- Steps inside Check feel odd; other apps call them a checklist.
- "Target: At Least / At Most" isn't understood.
- "Times a day" stops working when "Times a Week" is picked.
- The amount fields need precise taps, and there's no way to close the number keyboard.
- There's no obvious way to remove a reminder.
- The icon picker is weak.
- One-time tasks should be made from the same + screen, with no stats.

**Basis:**
- **A fresh screen of all 1,487,223 reviews** for 9 creation topics (one-off tasks, checklists, times a day, frequency, limits, creating habits, icons, units and number entry, editing reminders): 10,775 matches.
- **186 read in full and coded** (at most 3 per app per topic), with quotes verified. **101 are about creation.**
- **Ledger cards:**
  - C043 (frequency, 53 apps, "Certain");
  - C050 (one-off to-dos, 17 apps);
  - C173 (sub-tasks, 12 apps);
  - C014 (multiple reminders);
  - C048 (units);
  - C009 (icons free).
- **Report 36** (quit vs cutting back).

---

## The short answer

1. **Start by choosing what you want to do, in plain words.** The first screen behind **+** lists seven choices, grouped, each with an example:

   | Group | Choice | Example | Replaces |
   |---|---|---|---|
   | **Build a habit** | Do it | Meditate · 2× a day | Check |
   | | Reach an amount | Water · 8 glasses | Count, At Least |
   | | Spend time | Read · 20 min | Timer |
   | | Follow a checklist | Morning routine · 4 items | Steps inside Check |
   | **Break a habit** | Cut back | Coffee · no more than 2 cups | Count, At Most |
   | | Quit | Smoking · time since | Quit |
   | **Just once** | One-time task | Book the dentist · Tue | *new* |

   Choosing opens a short form with only the fields that type needs. Nothing is shown disabled or half-working, and the At Least / At Most control disappears: "Reach an amount" and "Cut back" are two plain choices.
2. **"How often" has five rules, in one menu:**
   - Every day;
   - On certain days (weekday chips);
   - Every few days ("every 3 days");
   - Times a week ("3 times a week, any days");
   - Times a month.
   
   **"Times a day"** belongs only to the day-based rules, so it can't clash with a weekly count.
3. **A checklist is its own type:** its items reset every day, and it's done when every item is ticked.
4. **One-time tasks** (a date, an optional time, one optional reminder) sit on Today in their part of the day. If unfinished, they move forward to today until done. They have no streak and no stats.
5. **Numbers are easy to set:**
   - the whole row is the tap target;
   - a stepper sits next to a number you can also type;
   - the keyboard has a **Done** button;
   - dragging the form closes the keyboard.
6. **Reminders are rows with a red ⊖ to remove and a green ⊕ to add**, as in Health's medication times. The first reminder's time follows the part of the day.
7. **The icon is picked for you from the name** ("Water" → 💧, "Read" → 📖). Tap the icon to change it; one sheet holds the colours and the icons, grouped and searchable, and closes as soon as you pick.

---

## 1. What users show

| Topic | Read | Mean ★ | What they say | Design |
|---|---|---|---|---|
| **Frequency** | 20 | 2.8 | 7 want "N times a week, any days"; 4 specific days; 3 weekly goals; 2 every N days; 2 monthly | Rule 2 |
| **Reminders** | 20 | 2.9 | 9 want several; 3 resent paying for several; 2 couldn't remove or change one (one quit onboarding over it); 2 praise several | Rule 6 |
| **Creating, numbers, keyboard** | 18 | 2.4 | 5 number-entry failures, 5 keyboard problems (won't close, covers fields), 3 praise easy creation | Rules 1, 5 |
| **One-time tasks** | 12 | 3.6 | 4 praise tasks + habits in one app; 3 want one-off events; one asks to keep them secondary | Rule 4 |
| **Checklists** | 12 | 3.8 | 4 want sub-tasks; 4 praise checklists; 2 want a checklist that "reappears every day" | Rule 3 |
| **Times a day** | 10 | 2.7 | 6 want N× a day; a tick that completes all of them instead of one | Rule 2 |
| **Icons** | 10 | 3.2 | 5 want more (chores, faith, …); hard to find; return automatically after choosing | Rule 7 |
| **Units** | 6 | 3.0 | want cups and other units; "what does count mean?" | Rule 1 |
| **Limits** | 3 | 2.7 | a weekly limit; cutting down | Rule 1 |

The ledger backs the biggest items. **C043** says flexible frequency is "the #1 unmet functional need" (53 apps): N× a week on any days, specific weekdays, every N days and monthly. **C050** says one-off to-dos alongside habits are an emerging request (17 apps), with the most-voted review in one corpus praising "tasks and habits in one app".

### Quotes behind the rules

- **Remove a reminder:** “Stopped the onboarding process when I wasn't easily able to remove a reminder for my first habit.” (`P37#825`). Several reminders, free: “I love that I can set up multiple reminders at different parts of the day.” (`A13#13777`); resented when paid: “seriously only two reminders?” (`A13#15743`).
- **Times a week, any days:** “Can't add a goal to do x times a week without adding specific days” (`P65#7763`). And “if I want to track something 3 days per week this is not the same as 3 out of 7 days” (`P3#25245`).
- **Specific days, every few days, monthly:** “Really need an option to choose what specific days you want to do a habit on” (`P3#4151`); “reminds you everyday or every week or every 4 days” (`P126#50796`); “would like the option for a once a month or once a year routine” (`P49#2817`).
- **Times a day, each counted:** “rather than giving me three boxes/buttons a day to check” (`A24#30290`); “there should be a 0/8 fraction instead of an X, with 8 reminders for the day” (`P3#15459`). A tick that finishes everything: “completes the whole thing instead of part when I mark it complete” (`A23#5751`).
- **Checklists:** “I need something like google keep check list where i can thick boxes but than they should reappear every day” (`A1#46435`). “Sub-tasks are very important to me, as I can break tasks down into smaller chunks.” (`A1#43741`). “Tasks are enhanced with the use checklists” (`P2#5401`).
- **One-time tasks:** “you can’t do one time events” (`A4#20007`); “Is there a way I can set a one time reminder for an activity that I do not wish to repeat?” (`A13#15720`); praise: “an app that has both a to-do list with categories and a habit improvement feature” (`A59#190`). Keep it secondary: “Ease of use for me would be if they removed one off tasks as the primary focus” (`P2#10132`).
- **Numbers and keyboard:** “I would love to be able to tap the time a step takes when creating it to enter a number manually instead of scrolling” (`P49#4046`); “keyboard screen won’t close” (`A1#2010`); “The keyboard now hides half the screen” (`P3#2435`).
- **Units:** “What does “count” mean?” (`A1#54718`); “I drink a cup of water at a time” (`A23#2215`).
- **Icons:** “There’s a middle finger but no vacuum, sink, fridge” (`A4#13048`); “the icons are a bit hard to find” (`P4#24545`); “a very nice to have would be an auto close and return to adding a new habit” (`P9#1097`).

---

## 2. The screens

### 2.1 "New" — choose what you want to do

- A sheet titled **New**, with Cancel. An inset-grouped list with three sections (Build a habit · Break a habit · Just once). Each row has:
  - the type's symbol in a coloured tile;
  - a title;
  - a grey example line;
  - a chevron.
- Tapping a row pushes that type's form, like choosing a template in Health or Reminders. *First principles:* one clear question first, then a short form without irrelevant fields.
- **Free plan:** the footer shows "3 of 5 free habits". One-time tasks don't count toward the limit (Backlog #31).

### 2.2 The form, by type

Every form starts the same way (same mental model):
- **Header:** the icon, the name field ("Name") and the colour row.
- **Middle:** the type's own section.
- **Footer:** When in the day, and Reminders.

| Type | Its own section | How often | Times a day |
|---|---|---|---|
| Do it | — | yes | yes (1–10, default 1) |
| Reach an amount | Goal: **[8] [glasses]** per day, with unit suggestions (glasses, pages, steps, km, reps, cups); **Each tap adds [1]** | yes | — |
| Spend time | Goal: **[20] min** a day | yes | — |
| Follow a checklist | Items (add, remove with ⊖, reorder) | yes | — |
| Cut back | Limit: **no more than [2] [cups] a day** | day-based only | — |
| Quit | Started (date and time) | — | — |
| One-time task | **Date** (Today by default) and an optional **time** | — | — |

**How often** is a menu row:
- Every Day;
- On Certain Days (then 7 weekday chips);
- Every Few Days ("Every **[3]** days");
- Times a Week ("**[3]** times a week");
- Times a Month.

The footer states the rule in words, for example "Any days count. The streak counts weeks."

**When in the day** is a segmented control: Anytime · Morning · Afternoon · Evening. It is visible, not hidden in a menu.

### 2.3 Numbers and the keyboard

- A number sits in a row with its unit; tapping anywhere in the row puts the cursor in the number.
- Counts that are small (times a day, days a week) use a **Stepper** with the value shown, so no keyboard is needed.
- The number keyboard carries a **Done** button (keyboard toolbar). Dragging the form closes the keyboard (`scrollDismissesKeyboard(.interactively)`). Return in the name field closes the keyboard.

### 2.4 Reminders

- **Rows:** each reminder is a row with a red **⊖** on the left and a time picker on the right. Tapping ⊖ removes it. Swipe-to-delete also works.
- **"Add Reminder"** has a green **⊕**. The first reminder's time follows the part of the day (Morning 8:00, Afternoon 13:00, Evening 19:00, Anytime 9:00), and each later one is an hour after the last.
- **One-time tasks** get one optional "Remind me" at the task's time.
- **Free, unlimited,** as in round 1 (C008, C014).

### 2.5 Icon and colour

- **Suggested from the name.** As the name is typed, a keyword map picks the icon ("water" → drop, "read"/"book" → book, "walk"/"run" → figure, "meds"/"vitamin" → pills). It stops once the user picks one themselves. *First principles:* a good default makes the choice optional.
- **Changing it:** tapping the icon opens one **Appearance** sheet with:
  - the colour row;
  - a search field;
  - the icon grid in named groups (Health, Fitness, Mind, Home & chores, Work & study, Faith, Food, Break a habit, Other). Chores and faith were added because users asked for them.
  
  Picking an icon closes the sheet (users show: `P9#1097`).

---

## 3. What changes underneath

- **Frequency** becomes one rule per habit:
  - every day, certain weekdays, or every N days, each with a times-a-day goal;
  - N a week, or N a month (counts in the period).
  
  Streaks count due days for day rules, and weeks or months for period rules. Days that aren't due never break a streak.
- **Checklist** and **One-time task** become types of their own; cut back stays an amount with a maximum.
- The database moves to **schema version 2**. Columns are only added (`frequency`, `due_day`, `due_minute`), with a tested migration from version 1 and a copy of the file taken before it (topic 8 §3).

## 4. Parked (Backlog)

- **#31:** do one-time tasks count toward the 5 free habits? Lean: no. They're tasks, and a cap on them would be felt on every errand.
- **Later:** end dates and "until done" challenges, yearly habits, Nth weekday of the month (C043 tail). They're not in this round, to keep the menu to five rules.

---

## Appendix — reviews cited

<!-- APPENDIX -->

26 reviews cited. Ref = store letter + app number + line index in that app's `reviews.jsonl`.

| Ref | Review ID | Store | App | Date | Stars | Codes |
|---|---|---|---|---|---|---|
| `A1#2010` | `10328505440` | App Store (ca) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2023-09-03 | 2★ | CR_KEYBOARD |
| `A1#43741` | `10688157208` | App Store (cr) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2023-12-13 | 3★ | CL_WANT, CL_PARTIAL |
| `A1#46435` | `12884346290` | App Store (hu) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2025-07-12 | 3★ | CL_DAILY_RESET, CR_TOO_COMPLEX |
| `A1#54718` | `9287651787` | App Store (us) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2022-11-14 | 3★ | UN_CONFUSING, FQ_WEEKLY_GOAL |
| `A4#13048` | `12024620648` | App Store (us) | 4. Me+ Lifestyle Routine - Daily Planner & Habit Tracker | 2024-12-04 | 3★ | IC_MORE |
| `A4#20007` | `9247408220` | App Store (us) | 4. Me+ Lifestyle Routine - Daily Planner & Habit Tracker | 2022-11-02 | 2★ | OO_WANT, FQ_MONTHLY |
| `A13#13777` | `5265019732` | App Store (us) | 13. Productive - Habit Tracker - Daily Routine & Goals Planner | 2019-12-12 | 5★ | RM_MULTIPLE_PRAISE |
| `A13#15720` | `3091985476` | App Store (us) | 13. Productive - Habit Tracker - Daily Routine & Goals Planner | 2018-08-20 | 4★ | OO_WANT |
| `A13#15743` | `3052663898` | App Store (us) | 13. Productive - Habit Tracker - Daily Routine & Goals Planner | 2018-08-12 | 3★ | RM_MULTIPLE_PAID |
| `A23#2215` | `1904760032` | App Store (gb) | 23. Streaks - The habit-forming to-do list | 2017-11-07 | 3★ | UN_MORE_UNITS |
| `A23#5751` | `1625223936` | App Store (us) | 23. Streaks - The habit-forming to-do list | 2017-05-27 | 2★ | TD_PARTIAL |
| `A24#30290` | `9026484273` | App Store (us) | 24. Fabulous - Daily Habit Tracker - Morning Routines & ADHD Help | 2022-08-28 | 1★ | TD_SEPARATE_CHECKS |
| `A59#190` | `4174959753` | App Store (au) | 59. Tappsk - ToDo & Habit Tracker - Task Manager & Daily schedule | 2019-05-19 | 3★ | OO_PRAISE |
| `P2#5401` | `b127af47-e26b-4059-9835-b1b1a110806d` | Play Store (en) | 2. HabitNow Daily Routine Planner | 2024-03-09 | 4★ | CL_PRAISE, RM_NOT_CANCELLED_WHEN_DONE |
| `P2#10132` | `d5b6350a-fb22-4b33-9822-22de5be2e401` | Play Store (en) | 2. HabitNow Daily Routine Planner | 2022-03-12 | 5★ | OO_SECONDARY |
| `P3#2435` | `382cabbf-63d4-4773-b253-d59887b28c39` | Play Store (en) | 3. Loop Habit Tracker | 2025-11-18 | 1★ | CR_KEYBOARD |
| `P3#4151` | `7724741b-a189-447e-9594-33f900513a10` | Play Store (en) | 3. Loop Habit Tracker | 2024-04-15 | 3★ | FQ_SPECIFIC_DAYS |
| `P3#15459` | `ae532e5b-97f1-4ecc-bffb-30b333cfec8a` | Play Store (en) | 3. Loop Habit Tracker | 2016-12-18 | 3★ | TD_WANT |
| `P3#25245` | `673569e1-c9e3-4c7f-9b33-576bcdad8a41` | Play Store (sv) | 3. Loop Habit Tracker | 2018-01-04 | 3★ | FQ_TIMES_WEEK |
| `P4#24545` | `e5165957-90ca-4d65-a8bd-5903e83845f4` | Play Store (en) | 4. Me+ Lifestyle Routine | 2023-12-21 | 3★ | IC_HARD_TO_FIND, FQ_WEEKLY_GOAL |
| `P9#1097` | `869e7702-f350-40aa-83b7-da1fb35ab12f` | Play Store (en) | 9. Habit Tracker - HabitKit | 2024-01-25 | 4★ | IC_AUTO_RETURN |
| `P37#825` | `8c0afdb1-a1d1-4d61-b774-406d4a76b180` | Play Store (en) | 37. Habitify - Habit Tracker | 2021-04-21 | 3★ | RM_REMOVE_HARD |
| `P49#2817` | `6916c28b-6490-4c3f-a065-8db901a14e43` | Play Store (en) | 49. RoutineFlow - Routine for ADHD | 2023-06-25 | 3★ | FQ_MONTHLY |
| `P49#4046` | `f2980c4b-3922-4608-b03d-75491b79b7e2` | Play Store (en) | 49. RoutineFlow - Routine for ADHD | 2022-11-15 | 5★ | CR_NUMBER_ENTRY |
| `P65#7763` | `b0a94160-dbc0-4a58-b619-65ff42f29dc0` | Play Store (en) | 65. Goal & Habit Tracker Calendar | 2018-04-16 | 3★ | FQ_TIMES_WEEK |
| `P126#50796` | `c135189f-ab4d-4fdf-ba15-081668738852` | Play Store (en) | 126. To Do List | 2021-01-29 | 5★ | FQ_EVERY_N_DAYS |


