Written by Claude (Claude Code), 28 September 2026.

# Schedule and Goal — Round 2, Making It Intuitive

The user tested the Schedule and Goal screens built from [Schedule and Goal — One Coherent System](<Schedule and Goal — One Coherent System.md>) and found them confusing, even as the person who built the app. This report finds out why, using the review corpus, and sets out a design and copy that a first-time user can follow without learning any rules.

The supplied report is treated as input, not as a rule. Where it holds up, this report keeps it. Where it caused the confusion, this report replaces it and says why (§7).

Every point the user made is listed in [the checklist](<../../../iOS/Docs/Checklists/Schedule and Goal — Round 2 Checklist.md>). The evidence (scripts, hand codes, and a per-review index) is in [`Habit Creation Evidence/schedule_goal_round2/`](<Habit Creation Evidence/schedule_goal_round2/README.md>).

**Status: proposal.** Nothing in this report is built yet. It needs the user's go-ahead.

---

## 0. Answers at a glance

| The user's point | Answer | Basis |
|---|---|---|
| **Do we need "specific dates of the month"?** | **Keep it, but only inside "Every month", never as a top-level choice.** Habit reviewers ask for a fixed date 52 times, and 12 of those are really tasks (rent, bills, pay day). They ask as often for "first Saturday of the month" (34) and "once a month, any day" (29), and 22 more want "every 2 or 3 months" instead of a date. A fixed date is a real but minority habit need. Monthly medicine, bedding on the 1st and "15th and 30th" are real habit cases. It matters more for Tasks. | Users show (§3.7) |
| **Why is it confusing?** | **Two screens each have their own period.** Schedule has "3 days *a week*" and Goal has "counts over *a week*". Whenever they disagree the app shows an alert that explains its own rules ("One check-off in a period is one successful day…"). Reviewers of other apps with the same split say the same thing: *"Why Repeat and Goal are two different things?"* | Users show (§3.2) + first principles (§1) |
| **The "Use 1 day a week?" pop-up** | **Remove the cause.** For Check it off, the Goal gets no week, month or year option at all. "3 times a week" lives only in Schedule, as "Any 3 days a week". When the context shows what people mean, "3 times a week" means three *different days* in 41 of 48 reviews (85%). | Users show (§3.1) |
| **"Once / a day" next to "Every 2 days"** | **The Goal read-back repeats the Schedule** instead of saying "a day": "Once / every 2 days", "30 min / on any 4 days a week", "8 glasses / every day". | First principles (§4, D4) |
| **Goal "a week / a month / a year" for amounts** | **Keep, as one clear switch: "Each day \| Total".** Weekly, monthly and yearly totals are real (32 total requests, 22 yearly, and 12 one-star reviews when an app removed them). But they only make sense for amounts and time. Choosing Total sets Schedule to "Any day" **on screen, with no pop-up**, and choosing Each day brings the old days back. | Users show (§3.4) + first principles (D2, D5) |
| **Schedule copy is weird** | The big read-back says **what** is chosen ("Sun–Thu", "Any 3 days a week", "Every 2 days"). The line under it says **what happens on Today**, never a repeat ("Shows on Today Sunday to Thursday. Friday and Saturday are off."). | First principles + users show (§6) |
| **Specific days read "Sun, Mon, Tue, Wed and Thu"** | **Runs become ranges**: "Sun–Thu", "Weekdays", "Weekends", and the sentence names the days off instead of repeating the days on. | First principles (§6) |
| **"Next: Mon 28 Sep" = the start date** | **Replace "Next" with "Coming up"**: the next three dates ("Today · Wed 30 Sep · Fri 2 Oct"), with the start date editable right there. Reviewers fight hidden start days: every-2-weeks habits landing on the wrong Saturday, all every-other-day habits landing on the same day. | Users show (§3.6) |
| **"Reach the goal on any 12 different days each year"** | "Any 12 different days this year count. It stays on Today so you can pick the days, and starts again on 1 January." Plus, for amounts, "A day counts once you reach 30 min." | Users show (§3.3) |
| **"A number of days"** | Rename it **"Any days"**, the counterpart of "Specific days". The read-back is "Any 3 days a week" ("Once a week" for 1). People contrast "specific days" (365 mentions) with "any day" (160). | Users show (§3.8) |
| **"Every…"** | Rename it **"Every few days or weeks"**, with months and years inside. | First principles |

---

## 1. What is confusing now, and why

These are the screens as built (commit `d988616`: `ScheduleEditor.swift`, `GoalEditor.swift`, `NewHabitView.swift`, `Schedule.swift`).

| What the user did | What the app shows | Why it confuses |
|---|---|---|
| Check it off → Schedule **Any days, 3 a week** → Goal → "Goal counts over" **A week** | Alert: **"Use 1 day a week?** One check-off in a period is one successful day. Schedule will count that day, with a goal of once a day." Buttons: Use 1 Day · Cancel | The user asked for a weekly goal and got a question about "1 day", in the app's internal vocabulary ("period", "successful day"). The alert exists because Goal's period and Schedule's period describe **the same thing twice** for check-offs. `GoalEditor.oncePerPeriod` and `NewHabitView.confirmOnce` both exist only to reconcile that duplicate. |
| Schedule **Every 2 days**, Goal **Once** | Goal read-back "**Once** / **a day**"; form row "Goal: Once" | "a day" reads as "every day". The period menu value is "A day" even though the habit is every other day. |
| Amount habit, Schedule **Mon, Wed, Fri**, Goal → **A week** | Alert "Use Any Day? Your week goal adds up across the period, so the current day schedule won't apply. Your previous schedule is kept for later." | This one is technically correct, but it is a modal interruption for a reversible change that the screen could simply show. |
| Specific days **Sun–Thu** | Read-back "Sun, Mon, Tue, Wed and Thu"; sentence "On Sunday, Monday, Tuesday, Wednesday and Thursday." | The sentence repeats the read-back in longer words, and a run of five days isn't shown as a range. |
| Every… **2 days**, starting today | "Every 2 days" · "Every 2 days, starting Mon, 28 Sep 2026." · "**Next: Mon, 28 Sep 2026**" | "Next" repeats "starting" word for word. Three lines, one fact. |
| Every day | "Every day" · "**Every day is on the schedule.**" | A sentence that says nothing new, in scheduling jargon. |
| Any days, 12 a year | "12 days a year" · "Reach the daily goal on any 12 different days each year." | "Reach the daily goal" on a check-off habit with no goal set. It doesn't say what the user sees on Today. |

**Root cause (reasoned from first principles).** The form asks two questions that both contain a period of time:

- Schedule: *which days*, including "3 days **a week**";
- Goal: *how much*, counted over **a day / week / month / year**.

A person can't tell which of the two a period belongs to. So there are two ways to say "gym 3 times a week", and a set of combinations the app forbids. The app then explains the forbidden combinations in alerts. Every alert in this flow exists only to reconcile the two period controls.

**The fix is structural, not wording:** at any moment, only one control on the whole form may hold a period. The rest of the report builds that.

---

## 2. Method

- **Corpus.** Every `reviews.jsonl` in `App Store Reviews/`, `Play Store Reviews/` and `Native Store Reviews/`: **1,487,223 reviews** (habit, routine and to-do apps, plus Apple and Google native apps such as Reminders, Calendar, Health and Google Tasks). Review dates of the coded set run from 20 Nov 2011 to 3 Sep 2026.
- **Scan.** `scan.py` (8 English regex themes): dates of the month (957 hits), "N times a week/month/year" (741), "N days a week" (338), the same day twice (44), setup confusion around frequency or goal (340), weekly/monthly/yearly goals (464), "every other day / N weeks / biweekly" (1,126), weekday ranges (230).
- **Read by hand.** **3,123 theme hits read** in context, one by one (a review can match more than one theme):

  | Theme | App Store | Play Store | Native |
  |---|---|---|---|
  | Dates of the month | 226 (all) | 242 | 264 (recurrence-worded hits) |
  | N times a week/month/year | 388 | 250 | 56 |
  | N days a week | 154 (all) | 127 (all) | 57 (all) |
  | Same day twice | 44 (all stores) | | |
  | Setup confusion | 162 (all) | 105 | — |
  | Weekly/monthly/yearly goals | 269 | 105 | — |
  | Every other day / N weeks | 365 | 309 | — |

  Where a count is below the theme total, hits whose visible text was about billing, trials, refunds, crashes or app updates were filtered out by keyword **before** reading. Those were not read, and none of the counts below come from them. Weekday-range hits (230) were used for phrase counts only. Native "dates" hits about one-off dates ("set date and time") and native "setup confusion" and "goal" hits were not read.
- **Coded.** **1,401 distinct reviews** were coded into 55 codes (1,714 code assignments). The map is `codes.py`. `verify_ids.py` confirms that every ID exists in its source file, with no duplicates inside a code. Every review is listed under its code, with an excerpt, in `review_index.md`.
- **Phrase counts.** `phrases.py` over the **922,405** English (or untagged-language) reviews: how people word schedules (§3.8).
- **Signal labels used below:** *request* (asks for it), *complaint* (a problem with an app that has it), *praise* (likes having it). Counts are reviews read and judged on topic, not raw pattern hits.
- **What this can't tell us.** App reviews are self-selected and skew to people who hit a limit, so counts show **what people ask for and stumble on**, not how common each need is among all users. The corpus is English-first. Reddit and forums weren't reached. No usability test has been run (§9 proposes one).

---

## 3. What users show

### 3.1 "N times a week" almost always means N different days

When a review makes clear what "3 times a week" means:

| Reading | Reviews | Share | Example |
|---|---|---|---|
| **Different days** | **41** | **85%** | `14042363994` Awesome Habits, 4★: *"doing something 3 times a week, not necessarilly on the same day every week"*. `1303958312` Streaks, 4★: *"run a mile 3x/wk. but not necessarily on MWF. Any day is fine"*. `2303983048` Productive, 5★: *"'clean the litter box 3 times each week' than every 2 days exactly or every Mon, Wed, Fri"*. |
| Several can fall on one day | 7 | 15% | `531ca9fe-c42a-4183-8474-686eec4e4958` HabitNow, 4★: *"5 times a week, even if it's all on one day"*. `37a335f4-08e8-490d-b165-9cf184e34507` HabitNow, 3★: *"6 times a week, with the possibility to do it twice on one day"*. |

Denominator: the 48 reviews, among the 1,032 "times/days a week" hits read, whose context shows which meaning they intend. Scope: App Store + Play Store. Code `TIMES_MEANS_DAYS` / `SAMEDAY_WANTED`.

Five more reviews complain when an app **does** count several ticks on one day towards a weekly number (`SAMEDAY_REPEAT_ILLOGICAL`). Examples: `12967314765` Habitify, 3★ (Dutch: going to bed on time 4× a week "can be ticked several times a day, which isn't logical"), and `7a287137-526a-4922-b36e-fb09f9e530cd` Disciplined, 3★ (*"working out 3 times a week… counts 3 times on the same day"*).

People *say* "times" more than "days" (452 vs 245 phrase hits, §3.8), but they *mean* days.

**Users show:** for a check-off habit, "N a week" is a **schedule of different days**, not a count. The rare "several on one day" need is already covered by Track an amount with a weekly total (unit "sessions").

### 3.2 Two settings that both hold a period confuse people, and not only in this app

| Review | What they say |
|---|---|
| `714d083a-f170-4f6c-8558-a234fb65604b` Habitify, Play, 2★ | *"UX became very confusing. Why Repeat and Goal are two different things? Why I can't set repetition to N times a week, but can with Goals?"* |
| `10709565816` Streaks, 3★ | Asks *"what does it mean when I set my Task Days to 1 day a week, and there's a setting right below saying 1 time/day?"*. This is the user's exact confusion, in another app. |
| `8446205059` Habit Tracker, 1★ | *"If I set 3 times it thinks I should do some habit 3 times a day not a week."* |
| `3828842561` HabitMinder, 3★ | *"if I set a habit to be 2 times weekly, I have to do the habit twice in one day in order for it to be considered complete."* |
| `8969578768` HabitMinder, 3★ | *"you can't even do twice a month because it ends up being twice in one day to check it as complete"*. |
| `7109279443` Do Habits, 2★ | *"The options for reminders and how many times you want to do it each day/week/month just aren't clear at all. I quit and deleted out of frustration."* |
| `10827758382` Habit Tracker, 1★ | *"Setting the frequency and tracking is confusing. Input them wrong and you won't accurately track your habbit progress."* |

In all, **39** reviews say setting up frequency, schedule or goal was confusing (`SETUP_CONFUSION`, 22 apps). Five more say exactly that "count vs days" or "repeat vs goal" was the confusing part (`TIMES_AMBIGUITY_BUG`, `SCHEDULE_GOAL_SPLIT_CONFUSING`, `GOAL_VS_REPEAT_DISTINCTION`). On the other side, **12** praise a setup that is simple (`SIMPLE_SETUP_PRAISE`). `8227611758` Habit Tracker, 5★: *"simply calculates my habit completion progress based on the counts… A lot of other trackers calculate habit progress with weird and complicated algorithms."*

`11018442332` Atoms, 4★, describes the split people want: *"separate out… how often you want to do the habit (like 3 days per week) and… when you would like a reminder (like MWF at 8am)"*. That is the split between how often and *when*, not between days and quantity.

### 3.3 Flexible days: the most-wanted schedule, and how it should behave

- **237 requests** in 57 apps for "N a week/month/year on any days" (`FLEX_WANT`), and **135 praise** it where it exists (`FLEX_PRAISE`, 26 apps). It is the largest single code in this study.
- **It should stay on Today all week, not only on "its" days.** 12 complain when flexible habits vanish from the daily list (`FLEX_MUST_SHOW_DAILY`, mostly after a Productive update). `138730cd-d9f0-4fe5-ba47-056ffabcda44` Habit Tracker, 5★: *"the goals that are 3x/week can show up everyday so you can check them off whichever day works best for you!"* `c6a49007-1681-406d-b8a1-b0570c073661` Hizo, 5★, asks that it *"automatically reappears every day until that target is reached"*.
- **Show progress as a fraction of the week.** 59 ask for or praise week progress on the daily list (`TODAY_WEEK_PROGRESS`). `8755220237` DayStamp, 5★: *"2/3 would indicate I have completed 2 of my weekly goal of 3. That's way easier to parse than 66%."* `11502774826`: *"'2/3 completed this week' or '2 remain this week'"*.
- **Never block a 4th day.** 31 complain that the app stops them logging after the target is met (`FLEX_EXTRA_BLOCKED`). `3556407816` Habitify, 4★: *"I wanted to mark down my 4th day, I can't record that."* A handful (about 4) want a done habit hidden. So the recommendation is to keep it visible, marked done for the week.
- **Off days aren't failures.** 76 complain that a flexible habit looks failed, or drags down a day's score, on days it wasn't needed (`FLEX_OFFDAY_FAIL`). `9534338255` Habit Tracker, 4★: with *"'complete any 3 days a week'… it will seem as though you've not made any progress."*
- **Calendar weeks, not rolling 7 days.** 18 complain about rolling windows (`CALENDAR_PERIOD_NOT_ROLLING`, mostly Loop). `673569e1-c9e3-4c7f-9b33-576bcdad8a41`: *"3 days per week this is not the same as 3 out of 7 days"*. `6d025c22-c0fa-44ec-b851-6700c9a3e9b6`: *"weekly goals are a rolling 7 days not a calendar week."*

### 3.4 Totals over a week, month or year: real, and about amounts

- **32** want a quantity that adds up over the period (`PERIOD_TOTAL`): hours, pages, km, steps, words, pomodoros. `5054446330` Streaks, 3★: *"read for 10 hours a week, it doesn't make sense that I have to set the same time goal for each day"*. `b089d9d5-ad2a-4901-a6eb-b7ee592d920e`: *"'read at least 15 pages a week' so if I'm busy I can get it done in one day"*.
- **22** want yearly goals specifically (`PERIOD_YEAR_WANT`). `9446793703`: *"read 40 books per year"*. `12096219187`: *"at least 200 gym workout in total"*.
- **12** one- to three-star Do Habits reviews after monthly and yearly goals were removed (`PERIOD_GOAL_REMOVED_ANGER`). `9579733483`: *"Why was the monthly goal option removed? That is one of the biggest reasons I paid for this app."*

Every total request in the table above is for an **amount or time**. None asks for a check-off count that must differ from a count of days. **Users show:** keep totals, for amount and time habits only.

### 3.5 An amount on some days, and "both clocks at once"

- **26** want a daily amount on a flexible or fixed set of days (`COMBO_AMOUNT_ON_N_DAYS`): *"30 minutes, four times a week"* (`7681273373`, praise), *"exercising 4 times per week, 20 min per day"* (`12529452345`). The current model supports this: Any 4 days a week plus 30 min each day.
- **1** wants both at once, a per-day minimum **and** a weekly total (`7ad472e7-f7fa-4364-a70b-ce9f9aafc254` HabitNow: *"at least 25 min at least 4 times per week, but in total not less than 2h each week"*). Too rare to design for now. Keep one clock.

### 3.6 Intervals: big demand, and the start day is where they go wrong

- Every N **days**: **167** requests (`INTERVAL_DAYS_WANT`, 45 apps). Every N **weeks** or fortnightly: **188** (`INTERVAL_WEEKS_WANT`, of which 33 are class timetables or to-do apps). Every N **months/quarterly/yearly**: **43**. Praise where it exists: **65**. Medicine on an interval: **14** (`MED_INTERVAL`, e.g. insulin site every 3 days, a pill every other day).
- **Every N days is not the same as N a week.** 21 say so (`INTERVAL_NOT_FLEX`). `7838880865`: *"every 2 days or 3 days and that is different from doing the habit twice a week"*. `9802990166`: *"every second day not any 3 days in a week"*.
- **Every 2 weeks needs a chosen weekday:** 28 (`INTERVAL_WEEK_WITH_DAY`), e.g. `4949195093` Productive, 5★ (*"water every two weeks, always on Saturday's"*).
- **The start day is the failure point:** 10 (`INTERVAL_ANCHOR_PROBLEM`). `83be1417-ce06-4236-8224-697c31f91865` Me+, 3★: *"every 4 weeks Saturday… it changes that the task starts this closest saturday April 12… I want it on the first."* `1868a2f6-ec1a-48da-b75f-d92b1711f696` Me+, 2★: *"it chooses the same start day for them all so it's giving me all the every 2 days tasks on the same day"*. `1370329172` Productive, 5★: *"add the day of starting a habit when I choose once every two weeks"*.
- **Off days must look off:** 26 (`INTERVAL_OFFDAY_DISPLAY`). `f0317069-7246-459c-9922-457e4675ddc3`: *"I wish it would show me somehow that today I don't have to do this."* `34d0db7f-d6b1-49ad-bad9-dea28ae34c13`: *"once every 14 days, I shouldn't be asked if I performed it every day."*
- **Count from when it was actually done:** 25 (`INTERVAL_AFTER_COMPLETION`), mostly chores and to-dos (haircut, mowing, filters). `13321732943` Finch, 5★: *"repeats every 10 days, I always mean 10 days since the last time I completed it"*. This supports "After completion" for **tasks**, as the supplied report already says.
- **Long intervals must be allowed:** 3 complain Loop caps intervals at 99 days (`LONG_INTERVAL_CAP`).

### 3.7 Dates of the month: the verdict (P2)

| Code | Reviews | What they want |
|---|---|---|
| `MD_DATE_WANT` (habit and routine apps) | 52 (+3 native Health: a monthly injection on the 1st) | A fixed date: "13th of every month", "15th and 30th", "1st of every month" |
| … of which `MD_DATE_IS_TASK` | 12 | The example given is rent, bills, pay day, an IRS report: task-shaped |
| `MD_ORDINAL` | 34 | "First Saturday", "third Wednesday", "last Sunday": a weekday of the month, not a date |
| `MD_ANYDAY_MONTH` | 29 | "Once a month, **not** on a specific date", and complaints when a monthly habit is forced onto one date |
| `MD_INTERVAL_NOT_DATE` | 22 | "Every 4 weeks / 10 days / 3 months" instead of a date |
| `MD_LASTDAY` | 6 | Last day of the month |
| `TASK_ORDINAL` / `TASK_LASTDAY` / `TASK_MONTH_DATE` (to-do, reminder and calendar apps) | 70 / 11 / 5 | Meetings, bin day, benefit payments: these are tasks |

Denominator: 732 dates-of-the-month hits read (all 226 App Store; 242 Play Store after the noise filter; 264 native recurrence-worded hits).

What the numbers say:

- **Fixed-date monthly habits exist but are a minority.** About 40 habit-shaped requests, against 51 that want the opposite of a fixed date (29 "any day this month" + 22 "every N weeks instead"). `11466714855` Productive, 4★: *"There are some things I only want to do once a month but not on a specific date."* `4688a0ce-a0f0-4970-aec8-e65c4be8f0b2` TheFor, 2★: *"you have to do something on exactly the same day each month in order to get a score."* `10540465575` Me+, 5★: bedding set to *"the 1st of every month… I had a really rough day… there wasn't a way to… reschedule it"*.
- **"First Saturday" is asked for about as often as a date** (34 vs 40 in habit apps), and far more in task apps (70). The 30th, for example, *"won't always fall on the same day of the week"* (`5a45a18a-316e-4de7-b34a-f63e43f9510b`). *"Not a specific date, but a day, like the last Saturday of every month"* (`fe991d84-ab89-4e78-b5c8-62b04234632e`).
- **Real habit uses of a date:** monthly medicine (`12691418942`: *"I take it on the 1st!"*; `11892460206`: *"a once monthly injection… on the same date"*), bedding on the 1st, contact lenses.

**Decision (users show):** keep dates of the month, but:

1. Only inside **Every few days or weeks → Months**, never as a top-level choice.
2. It defaults to the start date's day ("On the 28th"), so most people never see the 1–31 grid.
3. "On the last day" and "On the first Saturday" sit beside it with equal weight.
4. The Months panel carries a one-line escape to what most monthly users want: *"Any day of the month? Use Any days → once a month."*
5. Tasks keep it fully. It matters most there.

### 3.8 The words people use (922,405 English reviews)

| Concept | Phrase counts | Use in the app |
|---|---|---|
| Fixed weekdays | "specific days" **365** · "certain days" 294 · "set days" 42 · "particular days" 28 | **Specific days** (keep) |
| Flexible | "any day(s)" 160 · "different days" 191 · "not on specific days" appears throughout `FLEX_WANT` | **Any days**; the read-back "Any 3 days a week" |
| N a week | "N times a week" 452 · "N days a week" 245 · "N days out of 7" 42 | Read-back uses **days** (what people mean, §3.1); 1 → **"Once a week"** |
| Once a week | "once a week" **251** vs "one day a week" 20 | **"Once a week"**, not "1 day a week" |
| Suffix | "a week" **560** · "per week" 130 · "each week" 5 | **"a week"** |
| Every 2 days | "every other day" **231** · "every 2/two days" 74 · "every second day" 12 | Read-back "Every 2 days"; for 2, the sentence may say "every other day" |
| Every 2 weeks | "every 2/two weeks" **120** · "biweekly" 110 · "every other week" 63 · "fortnight(ly)" 51 | "Every 2 weeks". **Never "biweekly"** (one reviewer calls every other week "semi-weekly", `9822158917`) |
| Weekdays | "weekdays" 150 · "Monday to/through Friday" 72 | "Weekdays" quick pick; "Monday to Friday" in sentences |
| Days off | "day(s) off" **186** · "free day(s)" 91 · "off day(s)" 80 · "rest day(s)" 73 | "…are **off**" |
| Goals | "daily goal" 1,533 · "weekly goal" 208 · "monthly goal" 150 · "yearly/annual goal" 61 | Goal stays "Goal"; totals are "a week / a month / a year" |
| "due" | "due today" 108 · "not due" 35 | Not in Schedule or Goal copy (Design Rules) |

### 3.9 Changing a schedule must not rewrite the past

**26** complain that editing a habit's frequency erased or re-scored its history (`EDIT_KEEPS_HISTORY`, 6 apps). `5124722372` Productive, 3★: *"all the historic data is deleted when you change the periodity of a task (e.g. changing the task from 2 times per week to 3 times per week)"*. `1d8df9f2-7120-4c71-8e12-a7dad6552df5`: *"increase/decrease a habit without retroactively turning past week successes into failures."*

This app stores **one** `frequency` per habit (`Habit.swift`), so editing a schedule today re-judges every past day by the new rule. See D9.

---

## 4. The design

Each decision says whether users show it (reviews) or it is reasoned from first principles.

**D1. One question per row, one place for a period.** Reasoned from first principles, confirmed by §3.2.
- **Schedule** answers *"Which days?"*
- **Goal** answers *"How much on a day you do it?"* For amounts and time only, it can instead be *"How much in total this week, month or year?"*
- At any moment exactly one control on the whole form holds a week, month or year.

**D2. Check it off has no Goal period.** Users show (§3.1, §3.2).
- The Goal for a check-off is *times a day* (Once, twice…) plus an optional unit.
- "3 times a week" is Schedule → **Any days → 3 a week**.
- The "Use 1 day a week?" alert, `GoalEditor.oncePerPeriod` and `NewHabitView.confirmOnce` go away.
- Same-day counting (7 reviews) is done with Track an amount (unit "sessions", Total a week).

**D3. Schedule has four choices, each with a subtitle.** Users show for the names (§3.8). The structure is kept from the supplied report.

| Choice | Subtitle | Controls when selected (inline, right under it) |
|---|---|---|
| **Every day** | — | none |
| **Specific days** | Pick the weekdays | Weekdays · Weekends quick picks; S M T W T F S |
| **Any days** | A number of days each week, month or year | Stepper "3 days" · menu "a week / a month / a year" |
| **Every few days or weeks** | Every 2 days, every 2 weeks, monthly… | Every [2] [days ▾]; weeks → weekday picker; months → On the 28th / last day / first Saturday; years → date. Then **Coming up** and **Starts** |

**D4. Every read-back says what is chosen, and the line under it says what happens.** Reasoned from first principles; the user's P6–P9.
- Schedule read-back: "Sun–Thu", "Any 3 days a week", "Every 2 weeks · Sat".
- The line under it: what the user will see on Today, and which days are off. Never a restatement.
- **The Goal read-back takes its second line from Schedule**: "Once / every 2 days", "30 min / on any 4 days a week", "8 glasses / every day", "100 pages / a week, on any days". "a day" never sits under a habit that isn't daily.

**D5. Amount and time goals get one switch: Each day | Total.** Users show that both exist (§3.4, §3.5).
- **Each day** (default): the amount is for each day on the schedule.
- **Total**: shows one more row, *Total for: A week ▾ / A month / A year*.
- A single two-way choice replaces the four-value "Goal counts over" menu, whose "A day" value was the source of "Once / a day".

**D6. No pop-ups in this flow; every change is shown in place and is reversible.** Reasoned from first principles; the user's alert was the worst moment.
- Choosing **Total** while Schedule is "Mon, Wed & Fri": the Schedule row becomes "Any day". A footer under the switch says *"A total can be reached on any days, so Schedule is now Any day. Choose Each day to go back to Mon, Wed & Fri."* The old days are kept.
- Opening Schedule while a Total is on shows one line, *"This goal is a weekly total, so any day counts."*, and one button, **Use set days instead**. The button switches Goal back to Each day and restores the old days.
- Alerts are for decisions that lose data; this loses nothing.

**D7. Intervals show "Coming up", and Starts is editable where it matters.** Users show (§3.6).
- "Coming up: Today · Wed 30 Sep · Fri 2 Oct" replaces "Next:".
- A **Starts** row sits right under the interval controls. It is the same start date as the form's Dates section, edited in either place.

**D8. Today shows flexible progress as days, and keeps the habit.** Users show (§3.3).
- A flexible habit stays on Today every day, including after its target.
- The line under its name is "2 of 3 days this week", then "Done this week · 3 of 3", then "4 days this week ✓".
- Weeks follow the user's week start (calendar weeks, never rolling).

**D9. Schedule changes apply from the day they are made.** Users show (§3.9).
- Store schedule versions with an effective date. Past days are judged by the rule in force then.
- Until that exists, editing a schedule should say, in the form footer, "Changes apply from today." It must never re-score history silently.

**D10. Dates of the month stay, nested and defaulted** (§3.7). Keep "Shorter months: Use the last day / Skip that month" only when the 29th–31st is chosen, and add "On the last day" and "On the first Saturday" as equal patterns.

What stays exactly as the supplied report and Design Rules have it:
- Off days are neutral.
- Flexible schedules count *different* days; extra days can be logged.
- Choosing all seven days turns into Every day.
- Every-N-weeks keeps its anchor week.
- No streak or "due" wording in Schedule.
- Cut down uses Limit.
- Tasks get "After completion".
- Full VoiceOver labels, and large-text layouts.

---

## 5. Screens

### 5.1 Schedule

```
Every day                       (large, rounded)
Shows on Today every day.       (callout, secondary)

┌──────────────────────────────────────────────┐
│ ✓ Every day                                   │
│   Specific days                               │
│   Pick the weekdays                           │
│   Any days                                    │
│   A number of days each week, month or year   │
│   Every few days or weeks                     │
│   Every 2 days, every 2 weeks, monthly…       │
└──────────────────────────────────────────────┘
```

**Specific days (Sun–Thu, week starting Sunday)**
```
Sun–Thu
Shows on Today Sunday to Thursday. Friday and Saturday are off.

  ✓ Specific days
     Weekdays   Weekends
     (S) (M) (T) (W) (T)  F   S        ← selected shown filled + checkmark
```

**Any days (3 a week)**
```
Any 3 days
a week
Any 3 different days this week count. It stays on Today so you can
pick the days, and starts again on Monday.
A day counts once you reach 30 min.          ← only for amount/time habits

  ✓ Any days
     Days                    − 3 +
     Each                    Week ▾
```

**Every few days or weeks (every 2 days)**
```
Every 2 days
Every other day.
Coming up: Today · Wed 30 Sep · Fri 2 Oct

  ✓ Every few days or weeks
     Every                 − 2 +   Days ▾
     Starts                Today ▸
```

**Every 2 weeks · Saturday**
```
Every 2 weeks
on Saturday
Coming up: Sat 3 Oct · Sat 17 Oct · Sat 31 Oct

     Every                 − 2 +   Weeks ▾
     (S)  M  T  W  T  F [S]
     Starts                Sat 3 Oct ▸
```

**Monthly**
```
Monthly
on the 28th
Coming up: Today · Wed 28 Oct · Sat 28 Nov

     Every                 − 1 +   Months ▾
     On                    The 28th ▾   (The 28th · The last day · The first Saturday · Choose dates…)
     Starts                Today ▸
     Any day of the month? Use Any days → once a month.     (tappable)
```

**While Goal is a Total**
```
Any day
this week
This goal is a weekly total, so any day counts.

     [ Use set days instead ]
```

### 5.2 Goal: Check it off
```
Once                     (large)
every 2 days             (from Schedule)

GOAL
  Amount                        1
  Unit                   Optional ▸
Each tap on ✓ adds one.
```
There is no period menu.

### 5.3 Goal: Track an amount / Time it
```
30 min
on any 4 days a week

  [  Each day  |  Total  ]
A day counts once you reach 30 min.

GOAL
  Scroll | Type
  [ 0 h ][ 30 min ]
```
After choosing **Total** with a fixed schedule:
```
100 pages
a week, on any days

  [  Each day  |  Total  ]
  Total for                    A week ▾
Everything you log this week adds up. It starts again on Monday.
A total can be reached on any days, so Schedule is now Any day.
Choose Each day to go back to Mon, Wed & Fri.
```

### 5.4 The form
```
Schedule                 Any 4 days a week
Time of Day                       Any Time
Goal                                30 min
30 min on any 4 days a week.
```
Check-off examples: "Check it off every 2 days." "Check it off on any 3 days a week." With a Total, the Schedule row reads "Any day" and the Goal row "100 pages a week".

### 5.5 Today

| Habit | Line under the name |
|---|---|
| Gym, Any 3 days a week, done Mon | "1 of 3 days this week" |
| … after the 3rd day | "Done this week · 3 of 3" (row in the done style, still tappable) |
| … a 4th day | "4 days this week ✓" |
| Read, 30 min on any 4 days, 15 min today | "15/30 min · 2 of 4 days this week" |
| Read, 100 pages a week (Total) | "60/100 pages this week" |
| Water plants every 3 days, on an off day | Not in the main list; inside the existing "Not due today" row |

---

## 6. Copy deck

### 6.1 Static strings

| Key | Now | New | Basis |
|---|---|---|---|
| `schedule.option.daily` | Every day | **Every day** | — |
| `schedule.option.specific` | Specific days | **Specific days** + subtitle "Pick the weekdays" | Users show ("specific days" 365) |
| `schedule.option.flexible` | A number of days | **Any days** + subtitle "A number of days each week, month or year" | Users show ("any day" 160; the contrast in `FLEX_WANT`) |
| `schedule.option.interval` | Every… | **Every few days or weeks** + subtitle "Every 2 days, every 2 weeks, monthly…" | First principles (no ellipsis-only label) |
| `schedule.section.fixed` / `.flexible` headers | Set days / Flexible days | **none**: four rows in one list, each with a subtitle | First principles (one list, one choice) |
| `schedule.flex.days` / `.period` | Different days (stepper) / Count days over | **Days** (stepper) / **Each** (Week / Month / Year) | First principles |
| `schedule.next` | Next: {date} | **Coming up: {d1} · {d2} · {d3}** ("Today"/"Tomorrow" for near dates) | Users show (§3.6) |
| `schedule.starts` | Starts {date} (read-only) | **Starts {date} ▸** (editable, same value as Dates) | Users show (§3.6) |
| `schedule.month.hint` | — | **Any day of the month? Use Any days → once a month.** | Users show (§3.7) |
| `schedule.total.note` | Your goal adds up across the week, so you can work on it on any day. | **This goal is a weekly total, so any day counts.** | First principles (shorter) |
| `schedule.total.button` | Use set days instead… | **Use set days instead** (no alert) | D6 |
| `goal.mode` | Goal counts over: A day / A week / A month / A year | **Each day \| Total** (amount/time only) + **Total for: A week / A month / A year** | D5 |
| `goal.check.period` | Goal counts over … | **removed** for Check it off | D2 |
| `goal.readback.line2` | "a day" / "a week" | **From Schedule**: "every day", "on Sun–Thu", "every 2 days", "on any 4 days a week"; Total: "a week, on any days" | D4 |
| `goal.help.eachDay` | Starts again each scheduled day. | **A day counts once you reach {goal}.** (flexible) · **It starts again each day.** (other schedules) | First principles |
| `goal.help.total` | Everything you log this week adds up. It starts again on {weekStart}. | **keep** | — |
| `goal.total.scheduleNote` | alert "Use Any Day?…" | **A total can be reached on any days, so Schedule is now Any day. Choose Each day to go back to {old schedule}.** | D6 |
| alert `Use 1 day a week?` | exists | **removed** | D2 |
| alert `Use Any Day?` / `Restore …?` / `Use a goal for each scheduled day?` | exist | **removed**, replaced by inline notes | D6 |
| `form.editNote` | — | **Changes apply from today.** (when editing an existing habit's Schedule or Goal) | Users show (§3.9) |

### 6.2 Templates

| Key | Template |
|---|---|
| Specific days read-back | a run of ≥3 days (wrapping round the week) → "{first}–{last}"; Mon–Fri → "Weekdays"; Sat+Sun → "Weekends"; otherwise "Mon, Wed & Fri" |
| Specific days sentence | "Shows on Today {range in full: Sunday to Thursday \| on Mondays and Thursdays}." + if 1–2 days are off: " {Friday and Saturday} {are\|is} off." |
| Any days read-back | 1 → "Once" / "a week"; N → "Any {N} days" / "a week" |
| Any days sentence | "Any {N} different days this {week} count. It stays on Today so you can pick the days, and starts again {on Monday \| on the 1st \| on 1 January}." (N=1: "Any one day this week counts…") |
| + amount/time | " A day counts once you reach {goal}." |
| + checklist | " A day counts once the checklist is done." |
| Interval read-back | "Every {N} days" · "Every {N} weeks" / "on {weekdays}" · "Monthly" or "Every {N} months" / "on the {28th \| last day \| first Saturday}" · "Yearly" or "Every {N} years" / "on {12 March}" |
| Interval sentence | days: N=2 → "Every other day."; otherwise none. Months with the 29th–31st: "Shorter months use the last day." |
| Coming up | "Coming up: {3 next dates}" |
| Goal line 2 | Every day → "every day"; Specific → "on {read-back}"; Any days → "on any {N} days a {period}" / "once a {period}"; Interval → "{read-back, lower-case}"; Total → "a {period}, on any days" |
| Form summary | "{goal} {goal line 2}." For check-off with Once: "Check it off {goal line 2}." |
| Today, flexible | "{done} of {N} days this {period}" → "Done this {period} · {N} of {N}" → "{done} days this {period} ✓" |

### 6.3 Rendered: the user's own cases

| Setup | Schedule screen | Goal screen | Form footer |
|---|---|---|---|
| Check, Every day | **Every day** / Shows on Today every day. | **Once** / every day | Check it off every day. |
| Check, Sun–Thu (week starts Sunday) | **Sun–Thu** / Shows on Today Sunday to Thursday. Friday and Saturday are off. | **Once** / on Sun–Thu | Check it off on Sun–Thu. |
| Check, every 2 days from Mon 28 Sep | **Every 2 days** / Every other day. / Coming up: Today · Wed 30 Sep · Fri 2 Oct | **Once** / every 2 days | Check it off every 2 days. |
| Check, any 3 days a week | **Any 3 days** / a week / Any 3 different days this week count. It stays on Today so you can pick the days, and starts again on Monday. | **Once** / on any 3 days a week (no period menu, so no pop-up) | Check it off on any 3 days a week. |
| Check, any 12 days a year | **Any 12 days** / a year / Any 12 different days this year count. It stays on Today so you can pick the days, and starts again on 1 January. | **Once** / on any 12 days a year | Check it off on any 12 days a year. |
| Check, once a week | **Once** / a week / Any one day this week counts. It stays on Today so you can pick the day, and starts again on Monday. | **Once** / once a week | Check it off once a week. |
| Read 30 min, any 4 days | **Any 4 days** / a week / …starts again on Monday. A day counts once you reach 30 min. | **30 min** / on any 4 days a week · [Each day] | 30 min on any 4 days a week. |
| Read 100 pages a week | **Any day** / this week / This goal is a weekly total, so any day counts. | **100 pages** / a week, on any days · [Total] · Total for A week | 100 pages a week, on any days. |
| Run 5 km Mon, Wed, Fri | **Mon, Wed & Fri** / Shows on Today on Monday, Wednesday and Friday. | **5 km** / on Mon, Wed & Fri | 5 km on Mon, Wed & Fri. |
| Bedsheets every 2 weeks on Sunday (week starts Monday) | **Every 2 weeks** / on Sunday / Coming up: Sun 4 Oct · Sun 18 Oct · Sun 1 Nov | **Once** / every 2 weeks on Sunday | Check it off every 2 weeks on Sunday. |
| Injection on the 1st | **Monthly** / on the 1st / Coming up: Thu 1 Oct · Sun 1 Nov · Tue 1 Dec | **Once** / monthly on the 1st | Check it off monthly on the 1st. |

---

## 7. The supplied report: what to keep and what to change

| Supplied report said | This report | Why |
|---|---|---|
| Schedule = days, Goal = quantity; one success clock | **Keep** | It is right. The confusion came from how it was exposed. |
| Check it off keeps week/month/year goals; "once a week" is converted to "1 day a week" through a confirmation | **Change:** Check it off has no Goal period (D2) | That conversion is the pop-up the user found incomprehensible. 85% of reviewers mean days (§3.1). |
| Confirm every Schedule↔Goal period change with an alert | **Change:** show it in place, reversible, no alert (D6) | Alerts for reversible changes interrupt, and here they explain internal rules. Nothing is lost. |
| "Goal counts over: A day · A week · A month · A year" | **Change:** "Each day \| Total" + "Total for" (D5) | "A day" produced "Once / a day" under "Every 2 days". A two-way choice states the real decision. |
| Goal read-back "{amount} / a day" | **Change:** the second line comes from Schedule (D4) | It removes the contradiction the user saw. |
| "A number of days" / "Every…" | **Change:** "Any days" / "Every few days or weeks" | The supplied report itself called "A number of days" its weakest label. "Any days" matches reviewers' wording. |
| "Every day is on the schedule." / "On {days}." | **Change:** sentences say what happens on Today | The old sentences repeated the read-back. |
| "Next: {date}" for intervals | **Change:** "Coming up" (3 dates) + editable Starts (D7) | "Next" repeated the start date. The start day is where reviewers get stuck (§3.6). |
| Dates of month under Every… → month | **Keep**, add the "Any day of the month?" escape and defaults (D10) | §3.7 |
| Distinct days, extra logging, neutral off days, week-start rules, anchors, Cut down Limit, tasks After completion, VoiceOver and Dynamic Type | **Keep** | Users show it again here (§3.3, §3.6). |
| — | **Add:** schedule changes apply from today (D9) | 26 reviews (§3.9). Not covered by the supplied report. |

---

## 8. Implementation plan

For the implementing session. Each step: build, run the UI tests, screenshot at iPhone size with the keyboard up where there is typing (Design Rules). This needs a Mac with Xcode; this report was written in a Linux container without one.

1. **Schedule model** (`Model/Schedule.swift`): rename `Mode` titles (Any days, Every few days or weeks); add `rangeSummary` (cyclic runs → "Sun–Thu", Weekdays, Weekends); add `todaySentence(goal:kind:weekStart:)`; add `comingUp(count: 3)`; drop `explanation`'s restating strings. Allow day intervals up to 365.
2. **ScheduleEditor.swift**: one section of four rows with subtitles; inline controls under the selected row; "Coming up" under the read-back; editable Starts bound to the form's `startDate`; the Months "Any day of the month?" link; the Total state with **Use set days instead** and no `.alert`.
3. **GoalEditor.swift**: for `check`, remove the period picker and every `pendingPeriod`/`oncePerPeriod` path; for amount/time, add a segmented **Each day | Total** and, for Total, a **Total for** menu (week/month/year); the read-back's second line comes from a new `ScheduleDraft.goalLine`; inline notes instead of `.alert`.
4. **NewHabitView.swift**: remove `confirmOnce` and its alert; `combinedSummary` uses `goalLine`; the Schedule row value reads "Any day" while a Total is on.
5. **Today** (`TodayRows.swift`): "Done this week · 3 of 3" and "4 days this week ✓"; the flexible row stays in the list in the done style.
6. **Data**: convert demo `.perWeek(n)` check-offs to `.flexible(.week, n)` (the app hasn't shipped; Release starts empty). Plan schedule versions with an effective date (D9) as its own step.
7. **Tests** (`HabitsUITests/ScheduleUITests.swift`, `GoalFlowUITests.swift`, `NewHabitUITests.swift`): replace the label lookups ("A number of days", "Every…", "Goal counts over"); add tests for (a) check-off Goal has no period control, (b) Total switches Schedule to Any day and Each day restores Mon/Wed/Fri, with no alert on screen, (c) Sun–Thu reads "Sun–Thu", (d) Coming up shows three dates and never repeats the Starts date as a separate "Next".
8. **Docs**: once built, update Design Rules' "Schedule and Goal" section and the spec, and mark this report "Built".

---

## 9. Check it with people before freezing it

A five-person predict-what-happens test, like the earlier Time of Day test. Don't explain Schedule or Goal first.

| Ask them to set up | Then ask |
|---|---|
| "Go to the gym 3 times a week" | Where did you set the 3? If you go Monday and Tuesday, how many are left? |
| "Read 30 minutes on any 4 days a week" | Does reading 15 min on Tuesday count? |
| "Read 100 pages a week" | Starting from Mon/Wed/Fri: what happened to the days? How do you get them back? |
| "Water the plants every 3 days, starting Thursday" | Which are the next two dates? |
| "Change bedsheets every other Sunday" | Which Sunday is first? |
| "Take an injection on the 1st of every month" | Where did you find it? |

Pass: at least four of five answer each question right without help, and **nobody sees a pop-up**.

---

## 10. Limitations

- Counts are of reviews read and judged on topic. They show what people ask for and stumble on, not how common each need is.
- Some hits were filtered out by keyword (billing, crashes, updates) before reading. They were not read.
- Native-app "dates" hits about one-off dates, and native confusion and goal hits, were not read.
- English patterns only. A few non-English reviews were read where they matched (Dutch, German, Japanese, Czech).
- No usability test has been run. The words and screens here are the best reading of the evidence, to be checked with §9.

---

## Appendix: code book

All 55 codes, their counts and every review ID are in [`review_index.md`](<Habit Creation Evidence/schedule_goal_round2/review_index.md>). The codes that carry a decision:

| Code | Reviews | Decision it supports |
|---|---|---|
| `FLEX_WANT` | 237 | D3 (Any days) |
| `INTERVAL_WEEKS_WANT` | 188 | D3, D7 |
| `INTERVAL_DAYS_WANT` | 167 | D3, D7 |
| `FLEX_PRAISE` | 135 | D3 |
| `FLEX_OFFDAY_FAIL` | 76 | D8 |
| `TASK_ORDINAL` | 70 | D10 (tasks) |
| `INTERVAL_PRAISE` | 65 | D3 |
| `TODAY_WEEK_PROGRESS` | 59 | D8 |
| `MD_DATE_WANT` / `MD_DATE_IS_TASK` | 55 / 12 | D10 |
| `INTERVAL_MONTHS_WANT` | 43 | D3 |
| `TIMES_MEANS_DAYS` / `SAMEDAY_WANTED` | 41 / 7 | D2 |
| `SETUP_CONFUSION` | 39 | D1, D6 |
| `MD_ORDINAL` | 34 | D10 |
| `PERIOD_TOTAL` / `PERIOD_YEAR_WANT` / `PERIOD_GOAL_REMOVED_ANGER` | 32 / 22 / 12 | D5 |
| `FLEX_EXTRA_BLOCKED` | 31 | D8 |
| `MD_ANYDAY_MONTH` / `MD_INTERVAL_NOT_DATE` | 29 / 22 | D10 |
| `INTERVAL_WEEK_WITH_DAY` | 28 | D3 |
| `COMBO_AMOUNT_ON_N_DAYS` / `DOUBLE_CLOCK_WANTED` | 26 / 1 | D1, D5 |
| `EDIT_KEEPS_HISTORY` | 26 | D9 |
| `INTERVAL_OFFDAY_DISPLAY` | 26 | Today (off days stay off the main list) |
| `INTERVAL_AFTER_COMPLETION` | 25 | Tasks: After completion (kept) |
| `CALENDAR_PERIOD_NOT_ROLLING` | 18 | D8 |
| `INTERVAL_ANCHOR_PROBLEM` | 10 | D7 |
| `TIMES_AMBIGUITY_BUG` / `SCHEDULE_GOAL_SPLIT_CONFUSING` / `GOAL_VS_REPEAT_DISTINCTION` | 4 / 2 / 3 | D1, D2 |
