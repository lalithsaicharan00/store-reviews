Written by Claude (Claude Code), 28 September 2026. Revised the same day after the user pointed back to the earlier Goal research (§3.10).

# Schedule and Goal — Round 2, Making It Intuitive

The user tested the Schedule and Goal screens built from [Schedule and Goal — One Coherent System](<Schedule and Goal — One Coherent System.md>) and found them confusing, even as the person who built the app. This report finds out why, using the review corpus and every earlier report on goals and frequency, and sets out **one model to settle Schedule and Goal for good**: the design and the copy.

The supplied report and this report's own first version are both treated as input, not as rules. §7 says what each got right and what changes.

Every point the user made is listed in [the checklist](<../../../iOS/Docs/Checklists/Schedule and Goal — Round 2 Checklist.md>). The evidence (scripts, hand codes, and a per-review index) is in [`Habit Creation Evidence/schedule_goal_round2/`](<Habit Creation Evidence/schedule_goal_round2/README.md>).

**Status: proposal.** Nothing in this report is built yet. It needs the user's go-ahead.

---

## The model, in one sentence

> **Schedule says which days the habit is on your list. Goal says what counts, and over what period: a day, a week, a month or a year. Schedule never counts.**

Everything else follows from that sentence:

- Every habit type keeps its **Daily · Weekly · Monthly · Yearly** goal: Check it off ("8 glasses a day", "3 times a week", "12 books a year"), Track an amount ("100 pages a week"), Time it ("7 h a week"), Checklist ("finish it 3 times a week"), and Cut down's Limit.
- **"3 times a week, on any days" is a weekly goal**, set in one place: the Goal. Schedule no longer has "A number of days", which was a second place to set the same thing and the source of the pop-ups.
- Schedule is the calendar: **Every day · Specific days · Every few days or weeks**. It restricts which days count, and never adds a second target.
- Combinations that make no sense are **not offered** and say why in one line. Nothing changes by itself, and there are **no pop-ups** anywhere in this flow.

## 0. Answers at a glance

| The user's point | Answer | Basis |
|---|---|---|
| **People want to check it off *and* have daily, weekly, monthly, yearly goals** | **Yes, and the model keeps all of it.** Check it off gets the same Daily · Weekly · Monthly · Yearly goal as every other type, and each ✓ counts one ("8 glasses a day", "3 times a week", "gym 100 times a year"). This is what the earlier reports settled (§3.10). The first version of this report took it away; that is withdrawn. | Users show (§3.4, §3.10) |
| **Why is it confusing now?** | **Two places hold a period.** Schedule's "A number of days: 3 a week" and Goal's "a week" say the same thing twice for a check-off, so the app shows pop-ups to reconcile them. Other apps with the same split get the same reviews: *"Why Repeat and Goal are two different things?"*; *"I set my Task Days to 1 day a week, and there's a setting right below saying 1 time/day?"* | Users show (§3.2) + first principles (§1) |
| **The "Use 1 day a week?" pop-up** | **Gone, because its cause is gone.** "3 times a week" exists only as a weekly goal. There is nothing left to reconcile. | §4, D1–D3 |
| **Does "3 times a week" count days or ticks?** | **Ticks**, as the Goals report decided. People who say "3 times a week" tick once on each day they do it (41 of 48 reviews where the meaning is clear), so counting ticks gives them exactly that, and the 7 who sometimes do it twice in one day are served too. Accidental double ticks are what annoyed the other 5; Today's "✓ today" state and Undo bar handle that. | Users show (§3.1) |
| **"Once / a day" next to "Every 2 days"** | **The read-back uses the schedule when the goal is daily:** "Once / every 2 days", "5 km / on Mon, Wed & Fri", "8 glasses / every day". For weekly and longer goals it uses the period: "3 times / a week". | First principles (D6) |
| **"30 min on any 4 days a week"** (an amount on some days) | Kept: a **Daily** goal for amounts and time can say **"on any 4 days a week"** (a Days row under the daily amount). 26 reviews want this; it is already built. | Users show (§3.5) |
| **Do we need "specific dates of the month"?** | **Keep it, only inside "Every few days or weeks → Months", never top-level.** 52 habit reviews want a fixed date (12 of them really tasks: rent, bills), about as many as want "first Saturday" (34), and fewer than want "once a month, any day" or "every N weeks" (51). Monthly medicine and bedding on the 1st are real habit cases. | Users show (§3.7) |
| **Schedule copy is weird** | The big read-back says **what is chosen**; the line under it says **what you'll see on Today**, never a repeat. | §6 |
| **Specific days reads "Sun, Mon, Tue, Wed and Thu"** | Runs become ranges: **"Sun–Thu"**, "Weekdays", "Weekends". The sentence names the days off: "Shows on Today Sunday to Thursday. Friday and Saturday are off." | First principles (§6) |
| **"Next: Mon 28 Sep" = the start date** | **"Coming up: Today · Wed 30 Sep · Fri 2 Oct"**, with the start date editable right there. Reviewers get stuck exactly here: every-2-weeks landing on the wrong Saturday, all every-other-day habits landing on the same day. | Users show (§3.6) |
| **"Reach the goal on any 12 different days each year"** | That sentence came from Schedule's "A number of days", which leaves Schedule. The weekly/yearly **Goal** says it instead: "12 times / a year" and "Every check-off this year counts. It starts fresh on 1 January." | §6 |
| **Settle it once** | One sentence (above), one place for every period, one table of allowed combinations (D5), and no pop-ups. §7 lists what changes from both earlier versions and why, so this doesn't swing back. | §4, §7 |

---

## 1. What is confusing now, and why

These are the screens as built (commit `d988616`: `ScheduleEditor.swift`, `GoalEditor.swift`, `NewHabitView.swift`, `Schedule.swift`).

| What the user did | What the app shows | Why it confuses |
|---|---|---|
| Check it off → Schedule **A number of days, 3 a week** → Goal → "Goal counts over" **A week** | Alert: **"Use 1 day a week?** One check-off in a period is one successful day. Schedule will count that day, with a goal of once a day." Buttons: Use 1 Day · Cancel | The user asked for a weekly goal and got a question about "1 day", in the app's internal vocabulary ("period", "successful day"). The alert exists because Goal's period and Schedule's period describe **the same thing twice** for check-offs. `GoalEditor.oncePerPeriod` and `NewHabitView.confirmOnce` both exist only to reconcile that duplicate. |
| Schedule **Every 2 days**, Goal **Once** | Goal read-back "**Once** / **a day**"; form row "Goal: Once" | "a day" reads as "every day". The period menu value is "A day" even though the habit is every other day. |
| Amount habit, Schedule **Mon, Wed, Fri**, Goal → **A week** | Alert "Use Any Day? Your week goal adds up across the period, so the current day schedule won't apply. Your previous schedule is kept for later." | This one is technically correct, but it is a modal interruption for a reversible change that the screen could simply show. |
| Specific days **Sun–Thu** | Read-back "Sun, Mon, Tue, Wed and Thu"; sentence "On Sunday, Monday, Tuesday, Wednesday and Thursday." | The sentence repeats the read-back in longer words, and a run of five days isn't shown as a range. |
| Every… **2 days**, starting today | "Every 2 days" · "Every 2 days, starting Mon, 28 Sep 2026." · "**Next: Mon, 28 Sep 2026**" | "Next" repeats "starting" word for word. Three lines, one fact. |
| Every day | "Every day" · "**Every day is on the schedule.**" | A sentence that says nothing new, in scheduling jargon. |
| A number of days, 12 a year | "12 days a year" · "Reach the daily goal on any 12 different days each year." | "Reach the daily goal" on a check-off habit with no goal set. It doesn't say what the user sees on Today. |

**Root cause (reasoned from first principles).** The form asks two questions that both contain a period of time:

- Schedule: *which days*, including "3 days **a week**";
- Goal: *how much*, counted over **a day / week / month / year**.

A person can't tell which of the two a period belongs to. So there are two ways to say "gym 3 times a week", and a set of combinations the app forbids. The app then explains the forbidden combinations in alerts. Every alert in this flow exists only to reconcile the two period controls.

**The fix is structural, not wording:** only **one** place on the form may hold a period, and that place is the **Goal**, because the earlier research settled that the period is part of the goal (§3.10). Schedule keeps only the calendar: which days the habit is on your list. The rest of the report builds that.

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

**Users show:** people who say "3 times a week" tick once on each day they do it. So a **weekly goal that counts every ✓** gives the 85% exactly what they mean, because they tick once on each day they do it. It also serves the 15% who sometimes do it twice in one day. The 5 who were annoyed by same-day counting were annoyed by *accidental* double ticks; Today's Undo bar and a visible "✓ today" state handle that (§4, D3). No separate "different days" rule is needed for Check it off.

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

### 3.3 "N a week, on any days": the most-wanted rhythm, and how it should behave

- **237 requests** in 57 apps for "N a week/month/year on any days" (`FLEX_WANT`), and **135 praise** it where it exists (`FLEX_PRAISE`, 26 apps). It is the largest single code in this study.
- **It should stay on Today all week, not only on "its" days.** 12 complain when flexible habits vanish from the daily list (`FLEX_MUST_SHOW_DAILY`, mostly after a Productive update). `138730cd-d9f0-4fe5-ba47-056ffabcda44` Habit Tracker, 5★: *"the goals that are 3x/week can show up everyday so you can check them off whichever day works best for you!"* `c6a49007-1681-406d-b8a1-b0570c073661` Hizo, 5★, asks that it *"automatically reappears every day until that target is reached"*.
- **Show progress as a fraction of the week.** 59 ask for or praise week progress on the daily list (`TODAY_WEEK_PROGRESS`). `8755220237` DayStamp, 5★: *"2/3 would indicate I have completed 2 of my weekly goal of 3. That's way easier to parse than 66%."* `11502774826`: *"'2/3 completed this week' or '2 remain this week'"*.
- **Never block a 4th day.** 31 complain that the app stops them logging after the target is met (`FLEX_EXTRA_BLOCKED`). `3556407816` Habitify, 4★: *"I wanted to mark down my 4th day, I can't record that."* A handful (about 4) want a done habit hidden. So the recommendation is to keep it visible, marked done for the week.
- **Off days aren't failures.** 76 complain that a flexible habit looks failed, or drags down a day's score, on days it wasn't needed (`FLEX_OFFDAY_FAIL`). `9534338255` Habit Tracker, 4★: with *"'complete any 3 days a week'… it will seem as though you've not made any progress."*
- **Calendar weeks, not rolling 7 days.** 18 complain about rolling windows (`CALENDAR_PERIOD_NOT_ROLLING`, mostly Loop). `673569e1-c9e3-4c7f-9b33-576bcdad8a41`: *"3 days per week this is not the same as 3 out of 7 days"*. `6d025c22-c0fa-44ec-b851-6700c9a3e9b6`: *"weekly goals are a rolling 7 days not a calendar week."*

### 3.4 Week, month and year goals: real, for every type

- **32** want a quantity that adds up over the period (`PERIOD_TOTAL`): hours, pages, km, steps, words, pomodoros. `5054446330` Streaks, 3★: *"read for 10 hours a week, it doesn't make sense that I have to set the same time goal for each day"*. `b089d9d5-ad2a-4901-a6eb-b7ee592d920e`: *"'read at least 15 pages a week' so if I'm busy I can get it done in one day"*.
- **22** want yearly goals specifically (`PERIOD_YEAR_WANT`). `9446793703`: *"read 40 books per year"*. `12096219187`: *"at least 200 gym workout in total"*.
- **12** one- to three-star Do Habits reviews after monthly and yearly goals were removed (`PERIOD_GOAL_REMOVED_ANGER`). `9579733483`: *"Why was the monthly goal option removed? That is one of the biggest reasons I paid for this app."*

The period goals people ask for are both **amounts that add up** (hours, pages, km) and **counts of check-offs** ("Gym 100 times a year" `3661092892`, "go to gym 200x" `10775655163`, "at least 200 gym workout in total" `12096219187`, "Go to Dentist twice a year" `9621516200`). **Users show:** keep Daily · Weekly · Monthly · Yearly goals for every countable type.

### 3.5 An amount on some days, and "both clocks at once"

- **26** want a daily amount on a flexible or fixed set of days (`COMBO_AMOUNT_ON_N_DAYS`): *"30 minutes, four times a week"* (`7681273373`, praise), *"exercising 4 times per week, 20 min per day"* (`12529452345`). The built app supports this through Schedule; the settled model keeps it inside the Goal, as a Daily goal with a Days row (D4).
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
4. The Months panel carries a one-line escape to what most monthly users want: *"Any day of the month? Set Schedule to Every day and a monthly goal of Once."*
5. Tasks keep it fully. It matters most there.

### 3.8 The words people use (922,405 English reviews)

| Concept | Phrase counts | Use in the app |
|---|---|---|
| Fixed weekdays | "specific days" **365** · "certain days" 294 · "set days" 42 · "particular days" 28 | **Specific days** (keep) |
| Flexible | "any day(s)" 160 · "different days" 191 · "not on specific days" appears throughout `FLEX_WANT` | "…on any days" in the Goal read-back and form summary |
| N a week | "N times a week" 452 · "N days a week" 245 · "N days out of 7" 42 | Goal read-back **"3 times / a week"** (their words); 1 → **"Once / a week"** |
| Once a week | "once a week" **251** vs "one day a week" 20 | **"Once a week"**, not "1 day a week" |
| Suffix | "a week" **560** · "per week" 130 · "each week" 5 | **"a week"** |
| Every 2 days | "every other day" **231** · "every 2/two days" 74 · "every second day" 12 | Read-back "Every 2 days"; for 2, the sentence may say "every other day" |
| Every 2 weeks | "every 2/two weeks" **120** · "biweekly" 110 · "every other week" 63 · "fortnight(ly)" 51 | "Every 2 weeks". **Never "biweekly"** (one reviewer calls every other week "semi-weekly", `9822158917`) |
| Weekdays | "weekdays" 150 · "Monday to/through Friday" 72 | "Weekdays" quick pick; "Monday to Friday" in sentences |
| Days off | "day(s) off" **186** · "free day(s)" 91 · "off day(s)" 80 · "rest day(s)" 73 | "…are **off**" |
| Goals | "daily goal" 1,533 · "weekly goal" 208 · "monthly goal" 150 · "yearly/annual goal" 61 | The Goal's period control: **Daily · Weekly · Monthly · Yearly**; headers "Daily goal", "Weekly goal" |
| "due" | "due today" 108 · "not due" 35 | Not in Schedule or Goal copy (Design Rules) |

### 3.9 Changing a schedule must not rewrite the past

**26** complain that editing a habit's frequency erased or re-scored its history (`EDIT_KEEPS_HISTORY`, 6 apps). `5124722372` Productive, 3★: *"all the historic data is deleted when you change the periodity of a task (e.g. changing the task from 2 times per week to 3 times per week)"*. `1d8df9f2-7120-4c71-8e12-a7dad6552df5`: *"increase/decrease a habit without retroactively turning past week successes into failures."*

This app stores **one** `frequency` per habit (`Habit.swift`), so editing a schedule today re-judges every past day by the new rule. See D9.

---

### 3.10 What the earlier reports already settled, and must stay settled

These reports came before this one. Their decisions rest on review evidence and this redesign keeps every one:

| Earlier report | What it settled | Evidence it rests on |
|---|---|---|
| [Goals — Periods, Entry and What + Adds](<Goals — Periods, Entry and What + Adds.md>) §1 | **The period is part of the goal** ("100 pages a week", "12 books a year"). A week, month or year goal stands alone; forcing a daily goal first is the complaint. One primary goal per habit (1 of 15 wanted daily + weekly on one habit) | 13 quoted reviews in §1.1; 15 "daily and weekly" hits |
| same, §5 | **A week goal for Check it off counts ticks**, "even twice in one day" | Decided from first principles, with a note to revisit if reviews ask; §3.1 above now confirms it serves both groups |
| [Goal Screen Round 2](<Goal Screen Round 2 — Icons, Periods, Units and Copy.md>) T4 | People say "a day / a week" (68%) and "daily/weekly/monthly/yearly goal"; **all four periods visible at once** so people learn weekly, monthly and yearly exist | 1,238,784 reviews scanned for period wording |
| same, T5 | Period copy says what **counts** and when it **starts fresh**, naming the user's own week start; never due, missed, failed or minimum | 19 + 39 + 155 tone hits read |
| same, T7 | **Check it off stays Check it off, whatever the unit.** "8 glasses a day": each ✓ counts one glass | 10 reviews that check off each glass or set; one downgraded when an app took it away |
| [New Habit Round 4](<New Habit Round 4 — Checklists, Streaks and Times a Day.md>) §4 | Amounts, time and limits get weekly and monthly totals; **Check it off and checklists keep "a few times a week / month / year"**, counting ticks or finished checklists | Review quotes in §4 |
| Feature Ledger **C043** (Certain, 53 apps) | Flexible frequency is the #1 unmet functional need: N a week on any days, specific weekdays, every N days, monthly and yearly. Off days neutral | 194 cards; report 31: removing monthly and yearly goals drew 58 requests |
| Feature Ledger **C048** (Strong, 25 apps) | Partial progress and going over the goal are kept | 66 cards |
| Feature Ledger **C041** (Strong, 7 apps) | Editing a habit never wipes its history | 14 cards |

The first version of this report broke two of these: it removed week, month and year goals from Check it off, and it moved "N a week" out of the Goal. Both are withdrawn. The confusion was never the goal periods themselves. It was that **Schedule held a second, competing period** ("A number of days: 3 a week") and pop-ups tried to reconcile the two.

---

## 4. The design

Each decision says whether users show it (reviews) or it is reasoned from first principles.

**D1. Schedule = which days it's on your list. Goal = what counts, and over what period.** Reasoned from first principles, confirmed by §3.2 and §3.10.
- Schedule never counts and never holds "a week".
- The Goal (or Items for a checklist, or Limit for Cut down) is the **only** place with a period.
- So there is one answer to "where do I set 3 times a week?": the Goal, as a weekly goal of 3.

**D2. Every countable type has the same period control: Daily · Weekly · Monthly · Yearly.** Users show (§3.4, §3.10; Goal Round 2 T4).
- A segmented control at the top of the Goal screen, with all four periods visible, so people see that weekly, monthly and yearly goals exist.
- The section header follows it: "Daily goal", "Weekly goal"…
- **Check it off, Track an amount and Time it**: on the Goal screen.
- **Checklist**: on the Items screen, as "Finish it [1] time(s)" with the same control. A day's checklist counts once when every item is ticked.
- **Cut down**: Limit keeps Daily · Weekly · Monthly, as built.

**D3. Check it off counts every ✓, in any period.** Users show (§3.1; Goals report §5; Goal Round 2 T7).
- "8 glasses a day": each ✓ is one glass. "3 times a week": each ✓ is one time. "12 books a year": each ✓ is one book.
- A weekly goal doesn't need "different days". People who mean days tick once a day, and the few who mean ticks are served too.
- Today protects against accidental doubles: after a tick the row shows today's tick, and the existing Undo bar ("Gym 2/3 this week · Undo") appears after every tap.

**D4. Amounts and time: weekly, monthly and yearly goals add up; a daily goal can be for "any N days".** Users show (§3.4, §3.5).
- **Weekly / Monthly / Yearly**: everything logged in the period adds up ("100 pages a week", "7 h a week").
- **Daily**: the amount is for each day. Under it, one row, **Days**, holds "Every day it's on" (the default) or "Any 4 days a week / month / year". A day counts once it reaches the daily amount.
- This keeps the built "30 min on any 4 days a week" (26 reviews) inside the Goal, next to the amount it qualifies.
- Check it off has no Days row: "Once a day on any 3 days" *is* "3 times a week".

**D5. Only sensible combinations are offered. The rest are greyed out with a one-line reason.** Reasoned from first principles. No pop-ups, and nothing changes by itself.

| Schedule \ Goal | Daily | Weekly | Monthly | Yearly |
|---|---|---|---|---|
| **Every day** | ✓ | ✓ on any days | ✓ on any days | ✓ on any days |
| **Specific days** (e.g. Mon–Fri) | ✓ each of those days | ✓ counts on those days only | ✓ counts on those days only | ✓ counts on those days only |
| **Every few days or weeks** (every 2 days, every 2 weeks, monthly on the 1st, yearly) | ✓ each time it comes up | greyed | greyed | greyed |

- **Why intervals take only a daily goal:** the interval already says how often. A weekly count on an every-2-weeks habit has weeks where it can't happen. *First principles.*
- **Specific days + a weekly goal is allowed on purpose:** "3 times a week, but only on weekdays" or "the office 2 days a week, weekdays only" (4 reviews want a count restricted to some days, `FLEX_WITH_ALLOWED_DAYS`). Off days stay neutral.
- **The reasons, where they show:**
  - On the Goal screen, under the greyed Weekly, Monthly and Yearly segments: *"Every 2 days already sets how often. For a weekly goal, set Schedule to Every day or Specific days."*
  - On Schedule, under a greyed "Every few days or weeks" while the goal is weekly: *"Not with a weekly goal. Make the goal Daily first."*
- **Amount Days row:** "Any N days a week" can't exceed the days on the schedule (the stepper stops there).

**D6. Read-backs say the plan once, in the user's words.** Reasoned from first principles; the user's P5–P9.
- **Goal read-back**: the amount big; the second line is the period for weekly and longer goals ("3 times / a week"). For daily goals it is taken from Schedule ("Once / every 2 days", "5 km / on Mon, Wed & Fri", "8 glasses / every day"), or from the Days row ("30 min / on any 4 days a week"). "a day" never sits under a habit that isn't daily.
- **Schedule read-back**: what is chosen ("Every day", "Sun–Thu", "Every 2 weeks · Sat"). The sentence under it says what you'll see on Today, and mentions the goal when the goal is weekly or longer: *"Shows on Today every day, so you can do your 3 times on any days."*
- **Form footer**: one sentence for the whole plan ("Check it off 3 times a week, on any days.").

**D7. Schedule has three choices, each with a subtitle.**

| Choice | Subtitle | Controls when selected (inline, right under it) |
|---|---|---|
| **Every day** | — | none |
| **Specific days** | Pick the weekdays | Weekdays · Weekends quick picks; S M T W T F S |
| **Every few days or weeks** | Every 2 days, every 2 weeks, monthly… | Every [2] [days ▾]; weeks → weekday picker; months → On the 28th / the last day / the first Saturday; years → a date. Then **Coming up** and **Starts** |

The footer under the list points to where the count lives, because reviewers look for it in Schedule first (`714d083a-f170-4f6c-8558-a234fb65604b`): *"To do it a number of times a week, month or year on any days, keep Every day and set a weekly, monthly or yearly goal."*

**D8. Intervals show "Coming up", and Starts is editable where it matters.** Users show (§3.6).
- "Coming up: Today · Wed 30 Sep · Fri 2 Oct" replaces "Next:".
- A **Starts** row sits right under the interval controls. It is the same start date as the form's Dates section, edited in either place.

**D9. Today shows progress in the goal's own period, and keeps the habit visible.** Users show (§3.3).
- A weekly or longer goal stays on Today every day, including after it's met, so people can pick their days and log extra ones (12 + 31 reviews).
- The line under the name uses fractions (`8755220237`: *"2/3… way easier to parse than 66%"*): "2/3 this week" → "3/3 this week ✓" → "4 this week · goal 3 ✓".
- A daily amount on any N days: "15/30 min · 2 of 4 days this week".
- Weeks follow the user's week start (calendar weeks, never rolling: 18 reviews).

**D10. Schedule and goal changes apply from the day they are made.** Users show (§3.9; ledger C041).
- Store schedule and goal versions with an effective date. Past days are judged by the rule in force then.
- Until that exists, editing an existing habit's Schedule or Goal says *"Changes apply from today."* in the form footer. History is never re-scored silently.

**D11. Dates of the month stay, nested and defaulted** (§3.7).
- Only under Every few days or weeks → Months, defaulting to the start date's day ("On the 28th"), beside "the last day" and "the first Saturday".
- "Shorter months: Use the last day / Skip that month" shows only when the 29th–31st is chosen.
- A one-line escape: *"Any day of the month? Set Schedule to Every day and a monthly goal of Once."*

What stays exactly as the earlier reports and Design Rules have it:
- Off days are neutral.
- Going over a goal is kept, and extra logs are allowed.
- Choosing all seven days turns into Every day.
- Every-N-weeks keeps its anchor week.
- There is no due, missed or failed wording.
- Period copy names when it starts fresh.
- Cut down uses Limit.
- Tasks have a Schedule with "After completion" and no goal.
- Full VoiceOver labels, and large-text layouts.

---

## 5. Screens

### 5.1 Schedule

```
Every day                          (large, rounded)
Shows on Today every day, so you can do your 3 times on any days.
                                   (the second clause only when the goal is weekly or longer)
┌──────────────────────────────────────────────┐
│ ✓ Every day                                   │
│   Specific days                               │
│   Pick the weekdays                           │
│   Every few days or weeks                     │
│   Every 2 days, every 2 weeks, monthly…       │
└──────────────────────────────────────────────┘
To do it a number of times a week, month or year on any days,
keep Every day and set a weekly, monthly or yearly goal.
```

**Specific days (Sun–Thu, week starting Sunday)**
```
Sun–Thu
Shows on Today Sunday to Thursday. Friday and Saturday are off.

  ✓ Specific days
     Weekdays   Weekends
     (S) (M) (T) (W) (T)  F   S        ← selected: filled, with a checkmark
```

**Every few days or weeks: every 2 days**
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
      S  M  T  W  T  F [S]
     Starts                Sat 3 Oct ▸
```

**Monthly (starting today, 28 Sep)**
```
Monthly
on the 28th
Coming up: Today · Wed 28 Oct · Sat 28 Nov

     Every                 − 1 +   Months ▾
     On                    The 28th ▾   (The 28th · The last day · The first Monday · Choose dates…)
     Starts                Today ▸
     Any day of the month? Set Schedule to Every day and a monthly goal of Once.
```

**While the goal is weekly or longer**
```
  ✓ Every day
    Specific days
    Every few days or weeks                      (greyed)
    Not with a weekly goal. Make the goal Daily first.
```

### 5.2 Goal: Check it off

Weekly:
```
3 times                               (large)
a week
[ Daily | Weekly | Monthly | Yearly ]
Every check-off from Monday to Sunday counts, even two in one day.
Then it starts fresh.

WEEKLY GOAL
  Amount                        3
  Unit                   Optional ▸
Each tap on ✓ counts one.
```
Daily, on an every-2-days schedule:
```
Once
every 2 days
[ Daily | Weekly | Monthly | Yearly ]          (Weekly, Monthly, Yearly greyed)
Every 2 days already sets how often. For a weekly goal, set Schedule to
Every day or Specific days.

DAILY GOAL
  Amount                        1
  Unit                   Optional ▸
```
Daily, with a unit: "8 glasses / every day", "Each tap on ✓ counts one glass."

### 5.3 Goal: Track an amount / Time it

Daily, on any 4 days:
```
30 min
on any 4 days a week
[ Daily | Weekly | Monthly | Yearly ]
Starts fresh every day.

DAILY GOAL
  Scroll | Type
  [ 0 h ][ 30 min ]
  Days                  Any 4 a week ▸     (Every day it's on · A number of days: [4] a [week ▾])
A day counts once you reach 30 min.
```
Weekly total:
```
100 pages
a week
[ Daily | Weekly | Monthly | Yearly ]
Everything you log from Monday to Sunday adds up. Then it starts fresh.

WEEKLY GOAL
  Amount                      100
  Unit                      pages ▸
On Today, + asks how much, so you can type it.
```

### 5.4 Checklist: Items

```
Finish it once
a day
[ Daily | Weekly | Monthly | Yearly ]
A day counts once every item is ticked.

  Times                         1
ITEMS
  Push-ups, squats, plank …
```
Weekly: "Finish it 3 times / a week", "Every finished checklist from Monday to Sunday counts. Then it starts fresh."

### 5.5 The form

```
Schedule                        Every day
Time of Day                      Any Time
Goal                   3 times a week
Check it off 3 times a week, on any days.
```
More footers:
- "8 glasses every day."
- "5 km on Mon, Wed & Fri."
- "Check it off every 2 days."
- "30 min on any 4 days a week."
- "100 pages a week, on any days."
- "Check it off 3 times a week, on weekdays."

### 5.6 Today

| Habit | Line under the name |
|---|---|
| Gym, 3 times a week, ticked Mon | "1/3 this week" (row shows today's ✓ on Monday only) |
| … after the 3rd | "3/3 this week ✓" (done style, still tappable) |
| … a 4th | "4 this week · goal 3 ✓" |
| Water, 8 glasses a day | "3/8 glasses" (as built) |
| Books, 12 a year | "5/12 books this year" |
| Read, 30 min on any 4 days, 15 min today | "15/30 min · 2 of 4 days this week" |
| Read, 100 pages a week | "60/100 pages this week" |
| Plants every 3 days, on an off day | Not in the main list; inside the existing "Not due today" row |

---

## 6. Copy deck

### 6.1 Static strings

| Key | Now | New | Basis |
|---|---|---|---|
| `schedule.option.daily` | Every day | **Every day** | — |
| `schedule.option.specific` | Specific days | **Specific days** + subtitle "Pick the weekdays" | Users show ("specific days" 365) |
| `schedule.option.flexible` | A number of days | **removed from Schedule**: it is a weekly, monthly or yearly **Goal** | D1 |
| `schedule.option.interval` | Every… | **Every few days or weeks** + subtitle "Every 2 days, every 2 weeks, monthly…" | First principles |
| `schedule.section.*` | Set days / Flexible days | **none**: three rows in one list | First principles |
| `schedule.footer.count` | — | **To do it a number of times a week, month or year on any days, keep Every day and set a weekly, monthly or yearly goal.** | Users show (`714d083a…` looked in Repeat first) |
| `schedule.interval.disabled` | — | **Not with a weekly goal. Make the goal Daily first.** (monthly/yearly wording to match) | D5 |
| `schedule.next` | Next: {date} | **Coming up: {d1} · {d2} · {d3}** ("Today"/"Tomorrow" for near dates) | Users show (§3.6) |
| `schedule.starts` | Starts {date} (read-only) | **Starts {date} ▸** (editable, same value as Dates) | Users show (§3.6) |
| `schedule.month.hint` | — | **Any day of the month? Set Schedule to Every day and a monthly goal of Once.** | Users show (§3.7) |
| `goal.period` | Goal counts over: A day / A week / A month / A year (menu) | **Daily · Weekly · Monthly · Yearly** (segmented, all visible); header "Daily goal" / "Weekly goal"… | Users show (Goal Round 2 T4) |
| `goal.period.disabled` | — | **Every {2 days} already sets how often. For a weekly goal, set Schedule to Every day or Specific days.** | D5 |
| `goal.help.day` | Starts again each scheduled day. | **Starts fresh every day.** (Every day) · **Starts fresh each day it's on.** (Specific days, intervals) | Goal Round 2 T5 wording |
| `goal.help.week` (check) | Everything you log this week adds up… | **Every check-off from {Monday} to {Sunday} counts, even two in one day. Then it starts fresh.** | Goals report §5 + T5 |
| `goal.help.week` (amount/time) | same | **Everything you log from {Monday} to {Sunday} adds up. Then it starts fresh.** | T5 |
| `goal.help.month` / `.year` | … | **…this month counts, and it starts fresh on the 1st.** / **…this year counts, and it starts fresh on 1 January.** | T5 |
| `goal.days` (amount/time, Daily) | (in Schedule as "A number of days") | Row **Days**: **Every day it's on** / **Any {N} a {week}** | D4 |
| `goal.days.help` | Reach the daily goal on any N different days… | **A day counts once you reach {goal}.** | First principles |
| `items.times` (checklist) | (frequency in Schedule) | **Finish it {once \| N times}** + the same period control; help **A day counts once every item is ticked.** | D2 |
| alerts `Use 1 day a week?` · `Use Any Day?` · `Restore …?` · `Use a goal for each scheduled day?` | exist | **all removed** | D1, D5 |
| `form.editNote` | — | **Changes apply from today.** (editing an existing habit's Schedule or Goal) | Users show (§3.9) |

### 6.2 Templates

| Key | Template |
|---|---|
| Specific days read-back | a run of ≥3 days (wrapping round the week) → "{first}–{last}"; Mon–Fri → "Weekdays"; Sat+Sun → "Weekends"; otherwise "Mon, Wed & Fri" |
| Specific days sentence | "Shows on Today {Sunday to Thursday \| on Mondays and Thursdays}." + if 1–2 days are off: " {Friday and Saturday} {are\|is} off." + if the goal is weekly or longer: " Your {3 times a week} count{s} on these days." |
| Every day sentence | "Shows on Today every day." + if the goal is weekly or longer: replace the full stop with ", so you can do your {3 times} on any days." |
| Interval read-back | "Every {N} days" · "Every {N} weeks" / "on {weekdays}" · "Monthly" or "Every {N} months" / "on the {28th \| last day \| first Monday}" · "Yearly" or "Every {N} years" / "on {12 March}" |
| Interval sentence | days, N=2: "Every other day."; otherwise none. Months with the 29th–31st: "Shorter months use the last day." |
| Coming up | "Coming up: {3 next dates}" |
| Goal read-back | line 1: "{Once \| Twice \| N times \| N {unit}}"; line 2: weekly or longer → "a {week \| month \| year}"; daily → the Days row ("on any 4 days a week") if set, otherwise the schedule ("every day", "on Sun–Thu", "every 2 days", "monthly on the 1st") |
| Form summary | Check it off with no unit: "Check it off {Once → ''}{N times} {line 2}{, on any days \| , on {specific}}." · otherwise "{amount} {line 2}{…}." |
| Today | Check/amount/time with a week+ goal: "{done}/{goal} this {period}" → "{goal}/{goal} this {period} ✓" → "{done} this {period} · goal {goal} ✓"; amount on N days: "{today}/{daily} · {days} of {N} days this {period}" |

### 6.3 Rendered: the user's own cases

| Setup | Schedule screen | Goal screen | Form footer |
|---|---|---|---|
| Check, Every day, Daily | **Every day** / Shows on Today every day. | **Once** / every day | Check it off every day. |
| Check, 3 times a week | **Every day** / Shows on Today every day, so you can do your 3 times on any days. | **3 times** / a week · [Weekly] · "Every check-off from Monday to Sunday counts, even two in one day." | Check it off 3 times a week, on any days. |
| Check, 12 times a year | **Every day** / …so you can do your 12 times on any days. | **12 times** / a year · "…this year counts, and it starts fresh on 1 January." | Check it off 12 times a year, on any days. |
| Check, once a month | **Every day** / …so you can do it once on any day. | **Once** / a month | Check it off once a month, on any day. |
| Check, 8 glasses a day | **Every day** / Shows on Today every day. | **8 glasses** / every day · "Each tap on ✓ counts one glass." | 8 glasses every day. |
| Check, Sun–Thu, Daily (week starts Sunday) | **Sun–Thu** / Shows on Today Sunday to Thursday. Friday and Saturday are off. | **Once** / on Sun–Thu | Check it off on Sun–Thu. |
| Check, weekdays, 3 times a week | **Weekdays** / Shows on Today Monday to Friday. Weekends are off. Your 3 times a week count on these days. | **3 times** / a week | Check it off 3 times a week, on weekdays. |
| Check, every 2 days | **Every 2 days** / Every other day. / Coming up: Today · Wed 30 Sep · Fri 2 Oct | **Once** / every 2 days (Weekly, Monthly, Yearly greyed, with the reason) | Check it off every 2 days. |
| Read 30 min, any 4 days | **Every day** / Shows on Today every day. | **30 min** / on any 4 days a week · Days: Any 4 a week · "A day counts once you reach 30 min." | 30 min on any 4 days a week. |
| Read 100 pages a week | **Every day** / …so you can read on any days. | **100 pages** / a week | 100 pages a week, on any days. |
| Run 5 km Mon, Wed, Fri | **Mon, Wed & Fri** / Shows on Today on Monday, Wednesday and Friday. | **5 km** / on Mon, Wed & Fri | 5 km on Mon, Wed & Fri. |
| Bedsheets every 2 weeks on Sunday (week starts Monday) | **Every 2 weeks** / on Sunday / Coming up: Sun 4 Oct · Sun 18 Oct · Sun 1 Nov | **Once** / every 2 weeks on Sunday | Check it off every 2 weeks on Sunday. |
| Injection on the 1st | **Monthly** / on the 1st / Coming up: Thu 1 Oct · Sun 1 Nov · Tue 1 Dec | **Once** / monthly on the 1st | Check it off monthly on the 1st. |

---

## 7. What changes, and why it shouldn't swing back

Three versions now exist. This table is the record of what each got right, so the next change starts from here.

| Question | Supplied report (built) | This report, first version | **Settled** | Why this one holds |
|---|---|---|---|---|
| Where does "3 times a week, any days" live? | **Both** Schedule ("A number of days") and Goal ("a week"), reconciled by pop-ups | Schedule only | **Goal only** (Weekly goal, 3) | One place, and it's the place the earlier research put periods (§3.10). People say "weekly goal" (208) and "3 times a week" (452) |
| Check it off: weekly, monthly, yearly goals? | Yes, with pop-ups converting "once a week" | **No** (withdrawn) | **Yes**, each ✓ counts one | Goals report, Goal Round 2 T7, Round 4 §4, ledger C043 (58 people protested an app removing monthly and yearly goals) |
| Ticks or different days? | Different days (Schedule) and ticks (Goal): two meanings | Different days | **Ticks** | Serves the 85% who tick once a day and the 15% who don't; no hidden rule (§3.1) |
| An amount on any N days | Schedule "A number of days" + Goal "a day" | Schedule "Any days" | **Goal: Daily + Days row** | The qualifier sits next to the amount it qualifies; no second period on another screen |
| Conflicting combinations | Confirmation alerts | Inline notes, automatic Schedule change | **Not offered; greyed with a one-line reason** (D5) | Nothing changes by itself, nothing interrupts |
| Goal period control | "Goal counts over: A day ▾" (menu) | "Each day \| Total" | **Daily · Weekly · Monthly · Yearly** (segmented) | Round 2's evidence: people say "daily/weekly goal"; all four visible teaches that they exist. The supplied report hid them in a menu to avoid looking like recurrence, but Schedule no longer holds any counts, so there is nothing to confuse them with |
| Goal read-back line 2 | "a day" / "a week" | From Schedule | **Period for week+, Schedule or Days for daily** (D6) | Fixes "Once / a day" under "Every 2 days" |
| Schedule choices | Every day · Specific days · Every… · A number of days | + renamed Any days | **Every day · Specific days · Every few days or weeks** | Three calendar choices; counting left for the Goal |
| Schedule sentences, "Next", ranges, dates of the month, edits keep history | as built | as proposed | **Kept from the first version** | §3.6, §3.7, §3.9 |
| Distinct-day rule, "one success clock" | Core rules | Kept | **Replaced by one plain rule:** Schedule filters days, the Goal's period is the only clock | Simpler to explain; D5 removes the combinations that needed the rule |

---

## 8. Implementation plan

For the implementing session. Each step: build, run the UI tests, screenshot at iPhone size with the keyboard up where there is typing (Design Rules). This needs a Mac with Xcode; this report was written in a Linux container without one.

1. **Model** (`Model/Schedule.swift`, `Model/GoalInput.swift`, `Model/Habit.swift`):
   - `ScheduleDraft.Mode` loses `.flexible`.
   - Frequency must hold **specific weekdays + a weekly/monthly/yearly count** (new: a count limited to some days) and **a daily amount + "any N days"** (the existing `.flexible` case, now set from the Goal).
   - Add `rangeSummary` (cyclic runs → "Sun–Thu", Weekdays, Weekends), `todaySentence(goal:)`, `comingUp(count: 3)`, and `goalLine2`.
   - Allow day intervals up to 365.
2. **ScheduleEditor.swift**:
   - One section of three rows with subtitles, controls inline under the selected row.
   - The count footer.
   - "Coming up" under the read-back, and an editable Starts row bound to the form's `startDate`.
   - The Months hint.
   - The interval row greyed when the goal is weekly or longer.
   - Remove the aggregate state and its alert.
3. **GoalEditor.swift**:
   - The segmented Daily · Weekly · Monthly · Yearly control, with segments greyed when Schedule is an interval.
   - For amount/time, a Daily **Days** row.
   - Remove `pendingPeriod`, `oncePerPeriod`, `confirmPeriod` and every `.alert`.
   - Copy per §6.
4. **Checklist Items** (`NewHabitView.checklistSection`): add "Finish it" times + the period control; a finished checklist counts once per tick of the last item.
5. **NewHabitView.swift**: remove `confirmOnce` and its alert; `combinedSummary` per §6.2; form footer "Changes apply from today." when editing.
6. **Today** (`TodayRows.swift`): fractions per D9; week+ goals stay in the list in the done style after they're met; today's tick visible.
7. **Data**: convert demo `.flexible` check-offs to weekly goals, and keep amount `.flexible` as Daily + Days (the app hasn't shipped; Release starts empty). Plan schedule and goal versions with an effective date (D10) as its own step.
8. **Tests** (`ScheduleUITests.swift`, `GoalFlowUITests.swift`, `NewHabitUITests.swift`): replace the label lookups ("A number of days", "Every…", "Goal counts over"). Add tests for:
   - (a) a check-off weekly goal of 3, and no alert appears at any point;
   - (b) Every 2 days greys Weekly, Monthly and Yearly, with the reason;
   - (c) a weekly goal greys "Every few days or weeks";
   - (d) Sun–Thu reads "Sun–Thu";
   - (e) Coming up shows three dates;
   - (f) 30 min on any 4 days reads "30 min / on any 4 days a week".
9. **Docs**: once built, rewrite Design Rules' "Schedule and Goal" section to the one-sentence model and D5's table, update the spec, and mark this report "Built".

---

## 9. Check it with people before freezing it

A five-person predict-what-happens test, like the earlier Time of Day test. Don't explain Schedule or Goal first.

| Ask them to set up | Then ask |
|---|---|
| "Go to the gym 3 times a week" | Where did you set the 3? If you go Monday and Tuesday, how many are left? |
| "Drink 8 glasses of water a day, ticking each glass" | What does one tap do? |
| "Read 12 books this year" | When does it start again? |
| "Read 30 minutes on any 4 days a week" | Does reading 15 min on Tuesday count as a day? |
| "Water the plants every 3 days, starting Thursday" | Which are the next two dates? Try to make it weekly: what does the screen tell you? |
| "Take an injection on the 1st of every month" | Where did you find it? |

Pass: at least four of five answer each question right without help, **nobody sees a pop-up**, and nobody sets "3 times a week" in two places.

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
| `FLEX_WANT` | 237 | D1, D2 (weekly/monthly/yearly goals on any days) |
| `INTERVAL_WEEKS_WANT` | 188 | D7, D8 |
| `INTERVAL_DAYS_WANT` | 167 | D7, D8 |
| `FLEX_PRAISE` | 135 | D1, D2 |
| `FLEX_OFFDAY_FAIL` | 76 | D9 (off days neutral) |
| `TASK_ORDINAL` | 70 | D11 (tasks) |
| `INTERVAL_PRAISE` | 65 | D7 |
| `TODAY_WEEK_PROGRESS` | 59 | D9 |
| `MD_DATE_WANT` / `MD_DATE_IS_TASK` | 55 / 12 | D11 |
| `INTERVAL_MONTHS_WANT` | 43 | D7 |
| `TIMES_MEANS_DAYS` / `SAMEDAY_WANTED` / `SAMEDAY_REPEAT_ILLOGICAL` | 41 / 7 / 5 | D3 (every ✓ counts; Undo for accidents) |
| `SETUP_CONFUSION` | 39 | D1, D5 |
| `MD_ORDINAL` | 34 | D11 |
| `PERIOD_TOTAL` / `PERIOD_YEAR_WANT` / `PERIOD_GOAL_REMOVED_ANGER` | 32 / 22 / 12 | D2, D4 |
| `FLEX_EXTRA_BLOCKED` / `FLEX_MUST_SHOW_DAILY` | 31 / 12 | D9 |
| `MD_ANYDAY_MONTH` / `MD_INTERVAL_NOT_DATE` | 29 / 22 | D11 |
| `INTERVAL_WEEK_WITH_DAY` | 28 | D7 |
| `COMBO_AMOUNT_ON_N_DAYS` / `DOUBLE_CLOCK_WANTED` | 26 / 1 | D4 (one goal per habit) |
| `EDIT_KEEPS_HISTORY` | 26 | D10 |
| `INTERVAL_OFFDAY_DISPLAY` | 26 | Today (off days stay off the main list) |
| `INTERVAL_AFTER_COMPLETION` | 25 | Tasks: After completion (kept) |
| `INTERVAL_NOT_FLEX` | 21 | D5 (intervals and counts stay separate) |
| `CALENDAR_PERIOD_NOT_ROLLING` | 18 | D9 |
| `INTERVAL_ANCHOR_PROBLEM` | 10 | D8 |
| `FLEX_WITH_ALLOWED_DAYS` | 4 | D5 (Specific days + a weekly goal) |
| `TIMES_AMBIGUITY_BUG` / `SCHEDULE_GOAL_SPLIT_CONFUSING` / `GOAL_VS_REPEAT_DISTINCTION` | 4 / 2 / 3 | D1 |
