# Weekly Habit Cards — What Each Card Shows

Written by Claude (Claude Code), 2 October 2026, at the user's request: "Let's remove the overview and calendar ring.
Not just from progress, but even from the today … regarding the weekly … have individual cards [the Figma frame] …
for each type of habit do some research, like in a week, no matter what kind of habit it is, what is the useful
information that we can present … we should just present the facts, user will derive any meaning out of it … we
need to figure out a framework … it always shows a meaningful data to the user, data shouldn't be redundant in any
card … also I'm thinking at the very top instead of saying just this week, like a date range."

> **Copy note (3 Oct 2026):** the app never says "due" or "missed" (Rulebook U3; Design Rules' "Words the app never uses"). The examples below that use them shipped as "Planned for Wednesday", "Not planned this week", "Next planned for Mon 12 Oct" and "SPF not done twice".

**Status:** research and a recommendation. Nothing in the app was changed. Like every report in this folder, this is
not a decision record. It **replaces** [Weekly Overview Card — Which Numbers to Show](<Weekly Overview Card — Which Numbers to Show.md>)
(the overview it designed is being removed) and builds on the per-type work in
[The Progress Page — What People Need, and How to Build It](<The Progress Page — What People Need, and How to Build It.md>)
(§9 shapes, §10 quit, §11 cut-down), without repeating it. The card design starts from the Figma frame the user
sent (node 238-355), the same as option 1 in `Progress Week — Visual Options.md` on branch
`claude/progress-week-research`.

**What was read:** 2,994 reviews, each read by hand and coded for what the reviewer wants **one habit's** card to show.
2,218 of them were on topic, from 100 habit apps (App Store 1,433 and Play Store 785, July 2011 to September 2026).
§9 has the method. Every review ID and its codes are in
[`Weekly Cards Evidence/coded_reviews.tsv`](<Weekly Cards Evidence/coded_reviews.tsv>).

Labels used below: **users show** means the review evidence says so. **Reasoned** means first principles, where reviews
are thin or silent. Competitors are named only as the source of a review, never as a reason.

---

## 1. The answer

**Every card answers one question, "what happened with this habit this week?", using its own goal and its own unit.
It does that with at most three lines of text and a strip of seven days. No line repeats what another line or the strip
already shows.**

| Slot | What it holds | Always? |
|---|---|---|
| **Header** | Icon, name, and the goal in words ("8,000 steps a day", "3 times a week", "At most 10 a week") | Yes |
| **Headline** | The week measured against the goal's own clock. Days for a day goal, the count for a week goal, the month for a month goal, the current run for a quit habit | Yes |
| **Second line** | One *different* fact: the week's total in the habit's unit, what's extra, what's left, the slips, or which step was missed. Left out when it would only repeat the headline | Only when it adds something |
| **Day strip** | Sun–Sat (in the user's week order). Each day's own mark, and for counted habits the day's own number under it | Yes |

What leaves the card: the **percentage** (it restates the headline's two numbers and is the stat people most often
can't read, §6.5), the **"Today · …" line** (the day's number now sits under today in the strip), and anything that
isn't about this week (best streak, all-time averages). Those stay on the habit's own page.

Above the cards, **the week as dates** replaces "This week": `27 Sep – 3 Oct`, with "This week" in small type above
it, and ‹ › to step back through weeks (§3).

---

## 2. What is removed, and what stays

The user's decision (2 Oct), recorded here so the implementation matches it:

| Where | Removed | Why (the user's reason, and the evidence) |
|---|---|---|
| Progress, Week / Month / Year | The **overview card**: day rings, "Done so far 53 of 55 · 96%", "Weekly goals met", "Last week: 31 of 42" | A combined number can't be accurate once one habit is weekly, monthly, every N days, several times a day or a quit habit. Any formula is a choice the user can't see. Users show the cost: 197 "the number is wrong for my type" complaints in 39 apps, and 110 "I can't tell what this means" complaints in 34 apps (§6.5) |
| Today → calendar sheet (`CalendarSheet`, `DayBar.swift`) | The **ring around each date** | The same done-of-planned blend, drawn per day. The month grid keeps plain dates, today and the chosen day |
| Progress group headings (`ProgressRowSection.tally`, the Groups card) | **Recommended:** the group's done-of-planned numbers and bars | The same blend for a smaller set of habits. Keep the headings, drop the numbers. *Not in the user's list, so it needs a yes* |

**Stays:** the ring and "6/15" in Today's bottom bar (`DayLabel`, `MiniRing`). The user kept it on purpose. It only
covers today's own list.

---

## 3. The top of the page: the week as dates

**Reasoned, with support from users.** "This week" names the week but doesn't say which days it covers. A date range
does both, and it still reads correctly once you step back to earlier weeks.

```
This week                    ‹  ›
27 Sep – 3 Oct
```

- Current week: a small "This week" label, then the range. The week before: "Last week". Older weeks: just the range.
  Add the year only when it isn't the current one (`28 Dec 2025 – 3 Jan 2026`).
- The week starts on the user's first weekday (`calendar.firstWeekday`), the same as Today and the strip. Users ask
  for this (week start: 2444, 2681, 2888, 2801; a widget that ignored the setting: 2617), and a weekly goal resets
  on the day the user's week starts. A "3 times a week" goal counts inside the dates shown, so the header also tells
  the user what "this week" covers.
- ‹ › step one week at a time. That is how users compare with last week without a "Last week" number on every card.
  88 reviews ask for comparison with an earlier period (30 apps), and most of them want it for the whole app, not
  one habit (§6.8).

---

## 4. The card, slot by slot

### 4.1 Header

Icon, name, chevron (opens the habit page), and the **goal in words** on the line under the name, as in the Figma
frame ("4 steps a day"). The goal line belongs in the header because no number on the card can be read without it.

### 4.2 Headline: the goal's own clock

The headline measures the week **in the same unit as the goal**:

| Where the goal lives | Headline | Example |
|---|---|---|
| Each due day (daily, set days, every N days, set dates) | Days the day's goal was met, of the days due so far | `4 of 5 days so far` |
| The week (N times / N days / a total a week) | The count or total, of the week's goal | `2 of 3 this week` · `6 h 20 min of 10 h` |
| The month or year | That period's count, named | `October: 1 of 2` |
| A daily limit | Days that stayed within it, of the days that have ended | `Within limit on 4 of 5 days` |
| A weekly limit | The week's total, of the limit | `7 of 10 this week` |
| Quit | The run going on now | `12 d 11 h` |

**"So far" applies only to the current week.** Today counts only once it's done, so an unfinished evening never
lowers the number. Users show why: "It feels so weird to have a habit at 100% but see the graph sloping down just
because I haven't done it yet today" (Loop Habit Tracker, 4★ Play 2017, `9c883653-c8d9-45bd-9cd0-446713584ca7`). A limit
day is judged only once it's over, the same rule as Progress report §11.

### 4.3 Second line: one different fact, or nothing

Each kind gets at most one, chosen in this order:

1. **The week's total in the habit's unit**, when the unit isn't the same as the headline's (steps, minutes, glasses,
   km). This is the most-asked fact in the whole set: 382 mentions in 67 apps (§6.1).
2. **Extra**, when the goal was beaten: `+1 extra`, or a total over the goal. Never capped (§6.3).
3. **What's left**, for a week goal not yet met: `1 to go · 2 days left`.
4. **Slips**, for quit: `No slips this week` / `2 slips this week`.
5. **What was missed**, for a checklist: `22 of 24 steps · SPF missed twice`.
6. **Next due**, when the next due day is after this week: `Next due Mon 12 Oct`.

**The redundancy test (reasoned):** leave a line out when its number can be worked out from another line on the card
without counting marks. For example, `95 of 150 min` doesn't get `55 min to go` under it.

### 4.4 The day strip

Seven columns, Sun–Sat (or the user's order), today underlined as in the frame. Each day shows **its own state**, and
for counted habits **its own value** in small type under the mark (`8.2k`, `25`, `3`). That keeps every day a
fact you can read off, and makes the old "Today · 5,200 of 8,000 steps" line unnecessary.

| Mark | Meaning | Counts in the headline? |
|---|---|---|
| Filled ✓ | The day's goal was met | Yes |
| Filled + "+" / value past the goal | Met and went over | Yes (and feeds "extra") |
| Part-filled ring | Logged some, short of the day's goal (fill = fraction) | No, but its value adds to the week's total |
| Empty ring | Due and not done (a day that has ended) | Yes, as not met |
| Dashed ring | Today, still open | Not yet |
| Small dot | Not due that day / not on a day-based schedule | No |
| Dash | Skipped or paused | No |
| Faint outline | A due day still to come this week | No |
| Blank | Before the habit started | No |
| ▲ with value | A limit day that went over | Yes, as over |
| Slip mark with count | Quit: a day with a slip ("2" when two) | Feeds the slip count |

**Users show** every distinction in this table matters:

- Partial days must look partial: 166 mentions, 46 apps.
- A day that wasn't due must look different from a miss: 37 mentions, 26 apps.
- Skipped, and "not recorded", must look different from failed: 35 mentions, 14 apps.
- For week and month goals, only the days actually done get a mark; the rest of the week isn't filled in or marked
  missed (§6.4).

---

## 5. The framework: every habit type and rule

Worked for the week **Sun 27 Sep – Sat 3 Oct 2026, today Friday 2 Oct**. "Type" is `HabitKind`, "rule" is
`Frequency`/goal, and "shape" is `ProgressShape`. Tasks aren't on Progress.

| # | Habit (type · rule · shape) | Header goal line | Headline | Second line | Strip values |
|---|---|---|---|---|---|
| 1 | Check once · every day · `once` | Every day | `4 of 5 days so far` | — (anything more would repeat the strip) | Marks only |
| 2 | Check once · set days (Mon Wed Fri) · `once` | Mon, Wed, Fri | `2 of 3 due days so far` | `+1 extra day` if also done Tue | Marks only; Tue/Thu dots |
| 3 | Check once · every N days / N days after done · `once` | Every 3 days | `2 of 2 due days so far` | `Next due Mon 5 Oct` (only if beyond Sat) | Future due days outlined |
| 4 | Check once · set dates of the month, or every N weeks · `once` | 1st and 15th | `1 of 1 due day` | If none due this week, the headline is `Not due this week`, second line `Next due 15 Oct` | Marks only |
| 5 | Check, several a day · every day · `times` | 8 glasses a day | `Full on 4 of 5 days so far` | `42 glasses this week` | 8 8 6 8 9 3 |
| 6 | Amount · daily goal · `amount` | 8,000 steps a day | `Reached on 4 of 5 days so far` | `47,200 steps this week` | 9.1k 8.4k 6.2k 10.3k 8.0k 5.2k |
| 7 | Time · daily goal · `time` | 20 min a day | `Reached on 5 of 5 days so far` | `2 h 15 min this week` | 25 20 30 20 25 15 |
| 8 | Checklist · daily · `checklist` | 4 steps a day | `Every step on 6 of 6 days so far` | Nothing missed: — . Some missed: `22 of 24 steps · SPF missed twice` | Part-filled for part days |
| 9 | Check · N times a week (`perWeek`, `flexible(.week,n)` with goal 1) · `periodTimes` | 3 times a week | `2 of 3 this week` | Not met: `1 to go · 2 days left`. Met: `Met Wed · +1 extra` | Only done days marked; no empty rings |
| 10 | Amount/time on N days a week (`flexible(.week,n)`, goal > 1) · `periodDays` | 3 days a week, 5 km each | `2 of 3 days this week` | `13.4 km this week` | 5.0 3.4 5.0 (the 3.4 part-filled) |
| 11 | Amount/time total a week (`perWeek` total) · `periodTotal` | 10 h a week | `6 h 20 min of 10 h` | `on 4 days` | 1:30 0:50 2:00 2:00 |
| 12 | Month or year goal (`perMonth`, `perYear`, `flexible(.month/.year,n)`) · `periodTimes`/`periodTotal` | 2 times a month | `October: 1 of 2` | `Done Thu 1 Oct` (the dates done this week) | Only done days marked |
| 13 | Daily limit (amount, `atMost`) · `limitDay` | At most 3 cups a day | `Within limit on 4 of 5 days` | `15 cups this week` | 2 4▲ 3 1 3 · today 2 (dashed) |
| 14 | Weekly limit (`atMost`, week total) · `limitPeriod` | At most 10 a week | `7 of 10 this week` | `on 3 days`; over: `12 of 10 · 2 over` | 3 0 2 0 2 |
| 15 | Quit | Quit · since 20 Sep | `12 d 11 h` (live, as now) | `No slips this week` / `2 slips this week` | Clean ✓ / slip with count |

Notes on the table:

- **Rows 1–4 (day goals):** the headline counts due days and nothing else. Days that weren't due show a dot and aren't
  counted. **Users show** what happens otherwise: "even tho I should get 100% completion rate I don't because these
  days get counted as unfulfiled" (Habit Tracker, 5★ App Store 2020, `6779182833`). Extra done days are recorded, not
  dropped: users ask to "record habit completions outside the scheduled days" (Habit Tracker, 5★ App Store 2026,
  `14169481190`).
- **Row 3:** "next due" is a real ask for spaced schedules (6 mentions; few, but they agree), and it has to follow the
  schedule's actual rule: "I always mean 10 days since the last time I completed it, not since the last time it was
  assigned" (Finch, 5★ App Store 2025, `13321732943`). Inside the week, the strip's outlines already show it, so the
  text line appears only when the next due day is after Saturday.
- **Rows 5–7:** the card has two different facts, so both lines are earned. Days at goal comes first, the unit total
  second (§6.1, §6.2). An average is left off: on a seven-day card it is the total divided by days the user can see,
  and users disagree about which days it should divide by (§6.6).
- **Row 8:** the Figma card said the same thing three times ("24 of 24 steps so far", "6 full days", "100%", plus six
  ticks). Here the headline counts days, matching every other day goal, and the second line appears only when a step
  was missed, saying which one. **Users show** per-step results are the checklist ask (29 mentions; §6.7).
- **Rows 9–12 (period goals):** the headline is the goal's own count. The strip marks **only the days it was done**,
  and never marks the other days as missed. **Users show** both halves (§6.4). "Days left" counts today while it's
  still open.
- **Row 12:** the week is not the goal's period, so the headline names the period it is counting (`October: 1 of 2`).
  It doesn't turn the month into a week fraction. Edge case: the week of 27 Sep – 3 Oct crosses two months. The
  current week shows the month that holds today. A past week shows the month that holds its last day. If something
  this week was done in the other month, the second line says so: `Done Tue 29 Sep (September: 1 of 2)`.
- **Rows 13–14 (limits):** lower is better and every day's value is visible. An over day is marked ▲ with its value,
  never hidden or capped (Streaks review `8019547720`: it stopped counting past the limit). Today isn't judged until
  it ends.
- **Row 15 (quit):** the current run is what quit users come back to see (546 mentions). Its weekly fact is the slips:
  how many, and on which days. "Best run" moves to the habit page; see §7.

**Any future type fits the same four slots:** a headline on the goal's own clock, one non-repeating fact, the
strip, and the goal in the header. A new type that can't fill the headline that way isn't ready for a week card.

---

## 6. What the reviews show

Counts are mentions across the 2,994 reviews, as asks (?), praise (+) and complaints (−), with the number of distinct
apps. Full table: [`Weekly Cards Evidence/theme_counts.txt`](<Weekly Cards Evidence/theme_counts.txt>).

| Code | What people want on a habit's card | Mentions | ? / + / − | Apps |
|---|---|---|---|---|
| RUN | Quit: time since the last slip, current and longest run | 546 | 38 / 507 / 1 | 21 |
| TOTAL | The period's total in the habit's unit | 382 | 265 / 100 / 12 | 67 |
| PERIOD | Progress against a week or month goal | 237 | 131 / 82 / 13 | 42 |
| DAYVAL | Each day's own value or state visible | 218 | 136 / 80 / 2 | 47 |
| WRONG | The figure is counted wrongly for this type | 197 | complaints | 39 |
| PART | Partial days visible and counted | 166 | 118 / 19 / 28 | 46 |
| DAYS | Days done or met, "x of y days" | 122 | 78 / 42 / 1 | 39 |
| SLIPS | Quit: how many slips, and when | 120 | 37 / 83 / 0 | 19 |
| CLUTTER | Too many numbers, or stats that can't be read | 119 | complaints | 35 |
| PREV | Compared with the period before | 88 | 38 / 50 / 0 | 30 |
| AVG | Average per day or per session | 75 | 37 / 35 / 3 | 19 |
| OVER | Going over the goal recorded and shown | 56 | 51 / 5 / 0 | 18 |
| STREAK | Current or best streak in days | 53 | 15 / 19 / 18 | 23 |
| WEEKDAY | Patterns by day of the week | 48 | 17 / 31 / 0 | 17 |
| TIMES | Time of day it was done | 40 | 29 / 11 / 0 | 17 |
| NOTDUE | Days not due kept apart from misses | 37 | 13 / 2 / 22 | 26 |
| LIMIT | Cut-down: amount against the limit, days over | 36 | 31 / 5 / 0 | 10 |
| SKIP | Skipped / not-recorded days kept apart | 35 | 26 / 5 / 3 | 14 |
| STEPS | Checklist: which items done or missed | 29 | 28 / 1 / 0 | 11 |
| NOTES | Notes or reasons in the history | 26 | 11 / 15 / 0 | 8 |
| LEFT | What's left in the period | 14 | 11 / 3 / 0 | 10 |
| NEXT | Next due day | 6 | 5 / 1 / 0 | 6 |
| SAVED | Quit: money saved | 4 | 4 / 0 / 0 | 3 |

**Weighting caveats.** RUN, SLIPS and NOTES are mostly from one sobriety counter (Days Since: 487 of 546 RUN), and
WEEKDAY is half from Loop Habit Tracker. They show what that app's users value. They aren't a cross-app majority.
TOTAL, DAYVAL, PART, DAYS, PERIOD and WRONG are spread over 39–67 apps.

### 6.1 Totals in the habit's own unit (382, 67 apps) — the second line

The biggest single ask. People want the week's or month's sum in steps, minutes, pages or km, not a share. For example:
"It would be cool to get the sum" (Habit Tracker, 4★ App Store 2022, `8266040597`). It is especially common in Chinese
and Russian reviews, and in amount and time habits (274 of the amount_time group). → Rows 5–7, 10, 13, 14.

### 6.2 Days met (122, 39 apps) and each day's value (218, 47 apps) — the headline and the strip

Asks for "how many days did I keep it up this month" come alongside asks to see each day's own number. Praised:
"能够在月末、年末看到自己每个习惯坚持了多少天" (seeing how many days each habit was kept, at month and year end;
Habit Tracker, 5★ App Store 2025, `12376194056`). The Sun–Sat strip is itself something users ask for: "have a little
M T W Th F S Su with a little star or dot beneath, to give the user a quick glance of their progress!" (Strides, 4★
App Store 2018, `2351505798`).

### 6.3 Partial days (166, 46 apps) and going over (56, 18 apps) — never all-or-nothing, never capped

- "at the end of the day I only managed to do 9 of 10. And then I labelled my day as a 'fail day' cuz I miss to do
  one thing" (HabitNow, 5★ Play 2025, `aa0d4e95-a16f-4ad7-bbf4-5e32e81a05f7`).
- Two reviews (`7618806923`, `6345193240`) ask for a part day to show as a part-filled square, or a lighter shade,
  not as blank.
- On going over: "you can exceed the goal … other apps will be like 0 or 1 you must reach the goal or the app won’t
  save your data" (Habit Tracker, 5★ App Store 2023, `10430445130`).
- "I wish we could track exceeding goals, both in terms of the number of days per week/month the goal was
  accomplished, and in terms of the number of minutes/counts/etc of the goal" (Habit Tracker, 4★ App Store 2023,
  `9496045343`).

→ Part-filled marks, values under the strip, `+1 extra`.

### 6.4 Week and month goals (PERIOD 237, 42 apps; WRONG 68 in the weekly group alone)

- The ask is the goal's own count: "it would be great to add something like “2/3 completed this week” or “2 remain
  this week” in a calendar" (Habit Tracker, 5★ App Store 2024, `11502774826`).
- The complaints are about percentages worked out per day:
  - "unless you hit the entire weekly goal, it shows you a completion rate of 0%, which is misleading" (Do Habits,
    3★ App Store 2021, `7800629578`).
  - "it just shows 4%. Shouldn’t it be 100% as I’ve already done it for the whole month?" (Habit — Daily Tracker,
    4★ App Store 2019, `3964671953`).
- How the strip should look divides people:
  - "I want to see at glance in the report calendar view which day of the month I completed the task, but instead of
    doing that, it instead just highlights all the days of the month" (Habit Tracker, 4★ App Store 2023, `9542552588`).
  - "Now the whole week is highlighted so it’s alot harder to see which days i actually worked out" (Habit Tracker,
    5★ App Store 2023, `10203001150`).
  - One user wanted the whole week filled once the goal was met, and saw the problem with it themselves: "it might be
    considered mispresentation to bkock off the whole time period" (HelloHabit, 5★ App Store 2025, `13504655784`).
- → Mark only the days done. The headline says the goal is met.

### 6.5 Wrong and unreadable numbers (WRONG 197, 39 apps; CLUTTER 119, 35 apps) — why the percentage goes

Most of the "confusing" group is about a percentage nobody can work back:

- "I did it for 31 day in July month by marking it done everyday but its monthly percentage of completion is showing
  around 86" (Habit Tracker, 5★ App Store 2024, `11680390165`).
- "I thought it would track the percentage of events done over the total number of events needed to be done. But
  somehow that's not what it's for" (Goal & Habit Tracker Calendar, 4★ Play 2018, `2a4226fd-b8cf-4167-9177-1d18ff5a3320`).
- A Loop user (4★ Play 2024, `7ea8bc13-735d-4ac1-9d59-73c84bc006d0`, Portuguese) says the percentage measures
  steadiness, not the goal.
- A report that judges instead of stating facts gets caught out: "my weekly report told me that I am amazing for
  doing nothing" (Fabulous, 3★ Play 2016, `8599cbb6-8e17-41f3-b3c6-6ba115102136`).

**Reasoned:** on a week card, "6 full days · 100%" says one thing twice, and the percentage is the half people can't
read. Counts with their own denominator ("4 of 5 days so far") are facts. The user can draw their own conclusion.

### 6.6 Averages (75, 19 apps): left off the week card

A real ask, but people disagree about the denominator. "It seems to include the days I don’t do that activity while
I want it to include only the days I do" (Habit Tracker, 3★ App Store 2022, `8437295081`). Others want every day
counted. On a seven-day card the total and the day values are both visible, so any average can be read off them.
**Reasoned:** keep averages on the habit page, where the period is longer and the denominator can be stated.

### 6.7 Checklists (STEPS 29, PART 12 in 130 checklist reviews)

"it shows just the Habit at all but not the success on each item or which item was fulfilled best" (HabitNow, 4★
Play 2026, `67bf8f79-4802-4ef9-b22a-36fd92de11af`). Partial lists must count (`aa0d4e95-…` above). → Row 8: days
complete as the headline, the missed step as the second line.

### 6.8 Last week, weekdays and time of day (PREV 88, WEEKDAY 48, TIMES 40)

- These are mostly about the whole app or longer periods. For example: "I would love a weekly update on how I am
  doing based off the week before" (Loop Habit Tracker, 4★ Play 2022, `d828192c-185e-4757-96e7-fc2645cd9f5f`).
- "Give me a month overview and I can see if I'm more likely to do it certain days of the week" (HabitNow, 5★ Play
  2021, `9016bb4d-ec5f-4aa9-9606-d0141b0e7a0e`).
- On a single week's card, a weekday pattern is just the strip.
- **Reasoned:** stepping back a week with ‹ › covers "compared with last week" without adding a number to every card.
  Weekday and time-of-day patterns belong on the habit page (By Weekday, already planned in the Progress report).

### 6.9 Limits (LIMIT 36, 10 apps): a week limit is its own type

- "I just want to track that I don't have too many beers *in total* in a week" (Loop Habit Tracker, 2★ Play 2019,
  `d6dc9d24-7e26-4901-a416-7240f959f43d`).
- "you should be able to say I want to do it no more than 1 a week" (Loop Habit Tracker, 4★ Play 2018,
  `349fe158-99e5-42eb-8d56-2fcba799286a`).
- "max 3 days of video games per week, max 5 times of checking social media a day" (Today Habit tracker, 4★ App Store
  2018, `3088494191`).

→ Row 13 (a daily limit counts days within) and row 14 (a weekly limit counts the total against the limit) are
different headlines.

### 6.10 Quit (864 reviews: RUN 546, SLIPS 120)

- The live run is the core fact. Slips are the second fact, as a count, with notes kept on the habit page (NOTES 26).
  For example: "a stat log with how many resets you have, days since you’ve started, longest streak and average
  streak" (Days Since, 5★ App Store 2022, `8511030089`).
- The week framing is welcomed: "You feel more pride when you see a full week or month of no slips" (Days Since, 5★
  App Store 2023, `10014511743`).
- Best and average runs are praised, but one person was hurt by them: "seeing the longest streak and average streak
  ruins the progress if I keep comparing myself to the past" (Days Since, 2★ App Store 2022, `8404418658`).
- Another wants clean days kept across resets: "Gets me down that a reset removes my hard work up til the reset.
  Could you show total days as well?" (Days Since, 3★ App Store 2023, `9827138671`).

→ The week card shows the run and this week's slips. Best run, average run and total clean days go on the habit page.
That way the week card never puts the past next to a fresh start.

---

## 7. What doesn't go on a week card

| Fact | Where it goes instead | Why |
|---|---|---|
| Percentages | Nowhere on cards (a habit page may keep one, with its formula stated) | It repeats the headline and is the most misread figure (§6.5) |
| Current / best streak | The habit page | Not a fact about the week. Streak complaints (18) are mostly about weekly goals breaking it |
| Best run, average run, total clean days (quit) | The habit page | Not about this week. Can sting next to a fresh run (`8404418658`) |
| Average per day | The habit page | The denominator is disputed; it can be read off the strip (§6.6) |
| Last week's figure | ‹ › on the date range | Keeps every card to three lines (§3) |
| Weekday / time-of-day patterns | The habit page (By Weekday) | One week is too few days for a pattern |
| Money saved (quit) | Not now | 4 asks, and it needs a price per unit the app doesn't store |

---

## 8. The Figma card, before and after

The Figma frame (option 1), checklist habit:

```
Morning skincare routine with SPF            ›
4 steps a day
24 of 24 steps so far          ← same fact
6 full days · 100%             ← same fact, twice more
Sun Mon Tue Wed Thu Fri Sat
 ✓   ✓   ✓   ✓   ✓   ✓   ·     ← same fact again
Today · 4 of 4 steps           ← only on some cards
```

Following §4:

```
Morning skincare routine with SPF            ›
4 steps a day
Every step on 6 of 6 days so far
Sun Mon Tue Wed Thu Fri Sat
 ✓   ✓   ✓   ✓   ✓   ✓   ·
```

The same habit in a week where SPF was missed twice:

```
Every step on 4 of 6 days so far
22 of 24 steps · SPF missed twice
 ✓   ◐   ✓   ✓   ◐   ✓   ·
```

The steps habit from the frame ("Today · 5,200 of 8,000 steps"):

```
Daily steps                                  ›
8,000 steps a day
Reached on 4 of 5 days so far
47,200 steps this week
Sun  Mon  Tue  Wed   Thu  Fri  Sat
 ✓    ✓    ◔    ✓     ✓    ◌    ·
9.1k 8.4k 6.2k 10.3k 8.0k 5.2k
```

Cards are never taller than the frame's tallest, and the simplest habit (row 1) is header, one line and the strip.

---

## 9. Edge cases (reasoned)

- **Started mid-week:** days before the start are blank and not counted. The headline counts from the first day
  (`3 of 3 days so far`). One user asked for this to be clear: a day before the habit existed must look different
  from a missed day (`13783066497`, Russian).
- **Paused or skipped:** a dash, not counted. A habit paused all week shows `Paused this week` as its headline.
- **Not due at all this week** (set dates, every N weeks, a month goal with nothing logged): the card still shows,
  with `Not due this week` and `Next due 15 Oct`, or `October: 0 of 2`. It's a fact, and leaving the card out would
  make the list jump from week to week.
- **Several entries on one day:** the strip value is the day's sum. A quit day with two slips shows "2".
- **Goal changed mid-week:** each day should be judged against the goal in force that day, if the store keeps goal
  history. Check this before building; otherwise the current goal applies to the whole week. The header shows the
  current goal.
- **Archived habits:** not shown on past weeks unless they have entries in that week. Then they show under
  "Archived", as today.
- **VoiceOver:** each card is one element, read as header, headline, second line, then the days ("Sunday, 9,100
  steps, reached. Monday …"). This follows Progress report §21.

---

## 10. Building it (notes for when the user says go)

Nothing here is implemented. When it is:

- **Remove:**
  - The overview card and its rings: `ProgressScreen.swift`, around lines 300–370, `DayRing` use at ~324.
  - `ProgressTally`, `ProgressGoals` and `previous` from `ProgressSnapshot`, wherever only the overview reads them.
  - The rings in `CalendarSheet` (`DayBar.swift` ~129). The cells keep date, today and selection.
  - The group tallies, if the user agrees (§2).
- **Change:** `ProgressHabitRow` gets `headline`, `detail` (optional), and per-mark `value` text. `percent` goes. Both
  are worked out once in `HabitStore` per week, with formatters made once (`Format.trimmed`). That follows
  `PERFORMANCE.md` rules 5 and 8: no walking history or formatting in a card's `body`.
- **Add:** the date-range header with ‹ › (one `@State` week, no ticking). The quit card's run keeps its existing
  smallest-view clock (rule 3).
- **Test:**
  - Golden cases for each of the 15 rows in §5, for both a mid-week and a past week.
  - A `PerfDriver` scenario for stepping weeks and scrolling the cards, with a year of history, measured with
    `[ios-perf]`.
- **Month and Year:** the overview goes there too (the user's "for everything"). Their cards can use the same four
  slots with the period swapped (`October: 18 of 26 days`, `612 km this year`). That needs its own short pass before
  building.

---

## 11. Method

- **Sets read.**
  - (A) 2,533 reviews already hand-coded in the Progress research as about totals, partial days, quit, non-daily
    goals, patterns or confusion. Re-read and coded afresh for this question.
  - (B) 461 new reviews from a screen of the App Store (70 apps) and Play Store (146 apps) habit corpora, 876,387
    reviews. The screen matched habit-type words (several times a day, amount, minutes, checklist, weekly or monthly
    goal, every N days, limit, quit, best day, weekly notes) within 100 characters of a statistics word.
  - Adjacent Play apps were excluded as in earlier reports. Scripts: `patterns.py`, `screen_types.py`, `tighten.py`.
- **Reading.** Every review was read in full in its own language and given codes from the codebook (§6 table), with
  + for praise, ? for an ask, − for a complaint, or NA. 776 were NA: off topic, or about logging rather than showing.
- **Remaps** (in `tally.py`, also noted in the codebook): in quit reviews, "days since" and "longest streak" are
  counted under RUN. In the best-day and confusing groups, a plain best streak is STREAK.
- **Checks.**
  - All 2,994 rows have codes, and every code is in the codebook.
  - `verify_ids.py` confirms every backticked ID in this report exists in the source corpora. It also confirms every
    English quote attributed to a review appears in that review's text.
  - Non-English reviews are described in translation and never put in quotation marks as English.
- **Limits.**
  - Coding was done by one reader, in one pass.
  - Counts are mentions, not people.
  - One app dominates the quit codes (§6, caveat).
  - Reviews are written by people who chose to write. Silence on a fact (e.g. "next due") is weak evidence either way.

Evidence: [`Weekly Cards Evidence/`](<Weekly Cards Evidence/>), containing `coded_reviews.tsv`, `codebook.md`,
`theme_counts.txt` and `scripts/`.
