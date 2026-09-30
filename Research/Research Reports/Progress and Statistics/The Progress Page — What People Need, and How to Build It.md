# The Progress Page — What People Need, and How to Build It

Written by Claude (Claude Code), 30 September 2026. Build Plan #60 (Progress and statistics screens). Checklist: [`iOS/Docs/Checklists/Progress Page — Research.md`](<../../../iOS/Docs/Checklists/Progress Page — Research.md>).

**Status:** research and a build-ready specification. Nothing is built. Like every report in this folder, **this is not a decision record**: decisions live in Notion. Where the report says "build", read it as "the evidence says build".

**What was read:**

- **14,726 reviews** about progress, statistics and history, from 156 habit apps (App Store and Play Store). Each one was read by hand and coded. **11,870** are on topic.
- **1,604 Feature Ledger cards**: every card that touches progress, statistics, history, streaks, quit or cut-down records. Each one was read.
- **The app's own code:** the model (`Habit.swift`, `HabitStore.swift`) and the habit page (`HabitPageView.swift`). The design follows them.

Every number below says what it counts. Every review ID can be checked in [`Progress Evidence/coded_reviews.tsv`](<Progress Evidence/coded_reviews.tsv>).

---

## Contents

1. [The answer on one page](#1-the-answer-on-one-page)
2. [How this was done](#2-how-this-was-done)
3. [What people said, in numbers](#3-what-people-said-in-numbers)
4. [What gets praised, and how we take it our own way](#4-what-gets-praised-and-how-we-take-it-our-own-way)
5. [What gets complaints, and how we avoid it](#5-what-gets-complaints-and-how-we-avoid-it)
6. [The structure of the page](#6-the-structure-of-the-page)
7. [The Progress screen, element by element](#7-the-progress-screen-element-by-element)
8. [The habit page's progress sections](#8-the-habit-pages-progress-sections)
9. [Every habit type, one by one](#9-every-habit-type-one-by-one)
10. [Quit habits](#10-quit-habits)
11. [Cut-down habits](#11-cut-down-habits)
12. [Tasks stay out](#12-tasks-stay-out)
13. [Day marks and the legend](#13-day-marks-and-the-legend)
14. [Time ranges](#14-time-ranges)
15. [Groups: planned now, built later](#15-groups-planned-now-built-later)
16. [How every number is worked out](#16-how-every-number-is-worked-out)
17. [Changes needed in the model](#17-changes-needed-in-the-model)
18. [Edge cases](#18-edge-cases)
19. [Exact copy](#19-exact-copy)
20. [Speed](#20-speed)
21. [Accessibility](#21-accessibility)
22. [Every statistic is free](#22-every-statistic-is-free)
23. [What not to build](#23-what-not-to-build)
24. [Every relevant ledger card, and where it is answered](#24-every-relevant-ledger-card-and-where-it-is-answered)
25. [Build phases and tests](#25-build-phases-and-tests)
26. [Limits of this research](#26-limits-of-this-research)
27. [Appendix: evidence files and cited reviews](#27-appendix-evidence-files-and-cited-reviews)

---

## 1. The answer on one page

**Build one Progress screen, reached from the Progress row in the ≡ menu** (the user's final navigation decision, 30 Sep 2026; see the update at the top of §6). It shows everything together first. Tapping a habit opens that habit's own page, which gets new progress sections. The habit page is the detail view: there is no second detail screen.

| Question (checklist point) | Answer | Evidence |
|---|---|---|
| Do we need an all-habits overview? (P7) | **Yes. It is the most-repeated single ask in this corpus**: 697 reviews in 63 apps ask for an overview, and 243 in 44 apps praise one they have. | §3, §4 |
| Structure (P6) | **Overview first, then a list of habits; tap a habit to open its page.** The overview is a set of day rings (a week, a month or a year of days) plus three plain numbers. Under it, one row per habit with a small strip of that habit's days. | §6, §7 |
| Per-habit detail (P8, P14) | **The existing habit page grows downwards.** Kept as it is: streak, best, done this month and the month calendar. Added: a total since the start; an "Over time" section with a range picker, the type's own numbers and a chart; a year grid; the history of runs; a by-weekday view. | §8 |
| Per type (P9) | **Each type shows the number that means something for it.** Check it off: days done out of planned days. Amounts and time: totals and averages in the person's own unit, with over-goal shown. Checklist: steps done, plus each step's rate. Weekly or monthly goals: the period's progress and pace, never a daily failure mark. | §9 |
| Quit (P10) | **The live clock, best run and the total of clean days since the start**: a slip never wipes the record. Also: a run history, slips with their date, time and note, and the next milestone. | §10 |
| Cut-down (P11) | **Lower is better, and hitting the limit is never celebrated.** Show the average against the limit, days within the limit (judged once the day is over), days with none, and the change from the last period. | §11 |
| Tasks (P12) | **Kept out entirely**, as the app already decided. | §12 |
| Groups (P13) | **Every calculation takes a set of habits**, so adding groups later means adding a chip filter and one summary line per group. Nothing gets rebuilt. | §15 |
| Free or paid | **Every statistic and all history stay free.** The evidence against gating is the strongest in the corpus: a paywall on stats has a mean of 2.87★ and 44.6% of those reviews are 1–2★. Removing a stats feature is worse: 2.64★, 50%. | §22 |
| Tone | **No red, no "missed", no guilt.** "Not done" is an empty ring that is plainly different from skipped and paused. Every number can be explained in one tap. | §5, §13 |

**The five things that decide whether people trust it** (all users show):

1. **The numbers must be right.** Wrong stats are the largest complaint: 468 reviews in 72 apps, mean 3.08★, 34.2% at 1–2★.
2. **Days that weren't planned never count against anyone.** That covers weekly habits, skipped days, paused days, days before the habit started and today while it's still going. Wrong counting here: 245 reviews in 53 apps.
3. **Every number explains itself.** Confusing numbers: 253 reviews in 52 apps. Loop's score alone draws 67 of them.
4. **History is never lost, gated or rewritten.** Lost history: 220 reviews in 52 apps, 2.65★. Removed features: 166 reviews in 30 apps, 2.64★.
5. **It is one tap from Today, and calm.** Too hard to find: 189 reviews in 39 apps. Too cluttered: 106 reviews in 42 apps.

---

## 2. How this was done

### 2.1 Reviews

| Step | Count | What happened |
|---|---|---|
| All reviews in the three corpora | 1,487,223 | App Store (70 apps), Play Store (146 apps) and Native Store. |
| Kept: habit apps only | 876,387 | Native apps (Reminders, Samsung Health and the like) and 13 adjacent Play Store apps were set aside, because their "statistics" are about other things. |
| Keyword screen | 19,382 | Patterns in 17 languages for statistics, charts, calendars, history, percentages, best streaks, totals, quit counters, reports, overviews, partial progress and group stats (`scripts/screen.py`). |
| First clean-up | 16,996 | Dropped matches where the only hit was a weak word with no progress context nearby (for example "historial" or "rekord" on their own) (`scripts/refine.py`). |
| Second clean-up | **14,726** | Dropped 2,270 quit-pattern matches that were about free trials ("7 days free", "charged me") and not quitting. |
| **Read by hand and coded** | **14,726** | Every review, in its own language, in 74 batches of 200. Codes are in `codebook.md`. **11,870 are on topic** and 2,856 are not (about the store, billing or a crash with no stats angle). |

**Codes** (full list in [`codebook.md`](<Progress Evidence/codebook.md>)): what people **praise** (for example `CAL` calendar, `YEAR` year grid, `ALL` overview, `TOT` totals, `FORG` forgiving view), what they **ask for** (the same code with `?`), and what they **complain** about (`XWRONG` wrong numbers, `XGATE` paywalled, `XNONDAILY` weekly or skipped days counted wrongly, and so on). One review can carry several codes.

**Validation** (`scripts/aggregate.py`), all run before writing:

- **14,726 rows**: every row coded, no duplicate rows, no unknown row numbers.
- **Every code is in the codebook.** One code, `CONF` (marks and scoring made clear or configurable), was used during coding before it was written down. It is now defined (31 reviews).
- **Every review ID cited in this report exists in the source files.** Checked by `scripts/verify_ids.py`; see §27.

### 2.2 Feature Ledger cards

- `scripts/ledger_filter.py` picked **1,895 cards**. These are cards attached to a progress-related canonical point, or cards whose text mentions stats, charts, history, streaks, relapse, totals, reports, overviews and the like.
- **291** of them matched on a keyword only and were about something else (billing, calendar sync, rating history). They were set aside after reading the title.
- **The other 1,604 were read in full.** Notes: [`ledger_reading_notes.md`](<Progress Evidence/ledger_reading_notes.md>). List: [`ledger_cards_read.tsv`](<Progress Evidence/ledger_cards_read.tsv>).
- **Section 24 maps every canonical point these cards belong to onto this design.** A point is either built, answered, or named as out of scope with its owner.

### 2.3 Bursts and solicited reviews, disclosed

Some apps have runs of short, generic 5★ reviews that look solicited. They mostly say "helps me see my progress" and carry the codes `GEN` or `STAT`. **No design decision in this report rests on `GEN` or `STAT` counts.** They are shown for completeness only.

| App | What it looks like |
|---|---|
| **Habio** (App Store 67) | A run of generic 5★ reviews: 35 of its 68 on-topic reviews are `GEN`. |
| **Ultiself** (App Store 68) | The same pattern: 31 of 64 are `GEN`. |
| **Rise** (Play Store 123) | A cluster of look-alike "game-changer" reviews (`c2e6b670-42a7-4fb2-953f-3caf8c9530aa`, `e5145920-f0e8-4e58-8b57-98d848e2eb4c`, `3a884b46-ead8-44ad-9655-e8608bc23868`, `5b41ba09-9297-47cd-980f-12a636778599`), one of them 1★ with 5★ text (`b9073377-fbfa-4dd8-8d69-688f8f1fa04a`). |
| **Habit Tracker** (App Store 1) | A review-for-premium campaign in China that the ledger has already disclosed (card R01-002). Its stats praise is used here only where it agrees with other apps. |


---

## 3. What people said, in numbers

Denominator: **11,870 on-topic reviews** in 152 apps. The three rows below overlap, because one review can praise one thing and ask for another.

| | Reviews | Apps | Mean ★ | 1–2★ |
|---|---|---|---|---|
| Praise something about progress | 7,264 | 136 | 4.75 | 2.5% |
| Ask for something | 3,639 | 124 | 4.17 | 5.3% |
| Complain about something | 2,330 | 123 | 3.19 | 31.7% |

### 3.1 What people praise and ask for

| Theme | Praise: reviews · apps · ★ | Ask: reviews · apps · ★ | Used in |
|---|---|---|---|
| **Charts and graphs** | 1,222 · 74 · 4.80 | 627 · 82 · 4.16 | §8.3 |
| **Overview of all habits** | 243 · 44 · 4.57 | **697 · 63 · 4.25** | §7 |
| **Quit statistics** (clock, runs, slips) | 708 · 26 · 4.83 | 158 · 36 · 4.14 | §10 |
| **Month calendar** of a habit | 496 · 62 · 4.61 | 373 · 72 · 3.95 | §8.2 |
| **Streaks** (current, best, history) | 479 · 73 · 4.60 | 111 · 38 · 4.15 | §8.5 |
| **Totals and averages** in units | 216 · 42 · 4.61 | 440 · 72 · 4.16 | §9 |
| **Weekly, monthly and yearly reports** | 407 · 44 · 4.78 | 341 · 62 · 4.18 | §7, §14 |
| **Rate or percentage** | 393 · 51 · 4.62 | 249 · 54 · 4.27 | §7, §16 |
| **Year grid** (heat map, "GitHub") | 383 · 50 · 4.74 | 131 · 50 · 4.17 | §8.4 |
| **Long history** (all-time, years back) | 380 · 44 · 4.78 | 249 · 48 · 3.92 | §14 |
| **Week view** of all habits | 262 · 42 · 4.78 | 145 · 44 · 4.29 | §7 |
| **A forgiving view** (a miss doesn't zero) | 246 · 48 · 4.78 | 114 · 45 · 4.03 | §16 |
| **Partial progress** shown | 42 · 14 · 4.69 | 230 · 49 · 4.07 | §9, §13 |
| **Patterns** (weekday, comparisons) | 215 · 38 · 4.82 | 179 · 35 · 4.36 | §8.6 |
| **Tap a day** for its detail or notes | 119 · 33 · 4.85 | 181 · 50 · 4.10 | §7.4, §8.2 |
| **Group or category stats** | 33 · 17 · 4.79 | 140 · 36 · 4.34 | §15 |
| **Export** of data | 83 · 19 · 4.86 | 98 · 36 · 4.03 | §23 (separate item) |
| **Milestones** | 66 · 14 · 4.73 | 59 · 18 · 4.42 | §10 |

### 3.2 What people complain about

| Complaint | Reviews | Apps | Mean ★ | 1–2★ |
|---|---|---|---|---|
| **Wrong numbers:** stats, streaks or dates are wrong | 468 | 72 | 3.08 | 34.2% |
| **Too thin:** stats too basic or missing | 366 | 76 | 2.94 | 34.2% |
| **Paywalled:** stats or history behind a paywall | 345 | 58 | 2.87 | 44.6% |
| **Confusing:** can't understand a number or a mark | 253 | 52 | 3.53 | 20.9% |
| **Weekly, flexible, skipped or unplanned days counted wrongly** | 245 | 53 | 3.84 | 11.8% |
| **History lost or reset** | 220 | 52 | 2.65 | **50.0%** |
| **Hard to find:** too many taps to reach stats | 189 | 39 | 3.48 | 23.3% |
| **Crashes:** the stats screen crashes, hangs or won't load | 176 | 47 | 2.83 | 40.9% |
| **Removed:** a stats feature was taken away | 166 | 30 | 2.64 | **50.0%** |
| **Too cluttered or complex** | 106 | 42 | 3.52 | 26.4% |
| **Guilt:** stats or streaks shame or pressure | 87 | 35 | 3.64 | 21.8% |

**How to read these:** complaint reviews score about 1.5 stars lower than praise reviews (3.19 against 4.75). The four most punishing complaints are all about **trust**: lost history, removed features, a paywall, and crashes. Each has 40–50% of its reviews at 1–2★. Getting the basics right and keeping them is worth more than any single feature.

Per-app tables are in [`per_app.md`](<Progress Evidence/per_app.md>), and every code's counts are in [`theme_counts.md`](<Progress Evidence/theme_counts.md>).

---

## 4. What gets praised, and how we take it our own way

The project rule is to never copy an app because it does something. Each row below says what **users show** they like and why, and then how this app gets the same result its own way.

| What users praise | Evidence (users show) | Why it works for them | Our way |
|---|---|---|---|
| **One view of all habits together** | Habitify's all-habits rings: "Overall all habits stats have Apple Watch Fitness Rings like view, excellently executed" (`23fab1a2-2491-4b8f-ba75-8c4fc6a228e5`). HabitBull: "I like how it gives an overall habit score, not just individual scores." (`8bbc108d-4962-4c64-b348-463377350a4d`). Asked for 697 times in 63 apps, for example "Not motivating since you have to see progress one habit at a time." (HabitNow, `2622560b-331d-484c-95e2-38164951e723`) | You see at a glance whether the day or week went well, and which habit is slipping behind, without opening each habit. | **Day rings**: the same partly-filled ring the Today calendar already draws, one per day, for a week, a month or a year. The number under them is a plain fraction ("38 of 45"), never an unexplained score. |
| **The year grid** (GitHub-style) | Year-grid praise: 383 reviews in 50 apps at 4.74★. It is the purchase driver in Evoday (ledger R34: 105 reviews, no 1★). "I really like the possibility of you seeing how the whole year went on a single screen" (EZ Habit, `b2f125b8-c3ab-4a31-88eb-b2eb55ecf806`). "Different shades based on the frequency instead of just true/false." (Rise, `c92ea41d-a00a-4a57-a8d2-2a0331d53eab`) | The chain is visible across months, so one bad week looks small. Filling it in is satisfying. | **Round dots**, because the app's rule is that every calendar shape is round. Months and weekdays are labelled, because users complain about grids with no dates: "there's no weeks or dates or statistics" (HabitKit, `d8f69999-ee53-45e3-a1b5-5820b569469d`). Shade shows how much was done. Tapping a month opens that month. |
| **A rate that forgives** | Loop's score: "The habit score is forgiving if you miss a day which keeps me from becoming discouraged if I break a streak." (`0574e834-b8fa-4a60-8bea-3e330ed3ed52`). HabitBull: "it gives you an overall percentage, which I find really helps motivate me even if a streak is broken." (`051607de-1ae0-44ea-94b0-71b1b1a37a4d`). Way of Life's trend graphs "show that one red blip is not the end of the world" (`754313902`). | A single miss doesn't erase months of work, so people keep going. | **A "30-day rate": of the planned days in the last 30 days, how many were done.** It moves gently like Loop's score, but anyone can check it on a calendar. Loop's exponential score confuses people (67 confusion reviews for Loop), so it is not copied. |
| **Streaks, shown with the best and a total** | Streak praise: 479 reviews in 73 apps at 4.60★. "you can see your current streak Vs your previous streak and so it stops the all or nothing approach other apps have." (EZ Habit, `e39e69e7-c38a-4994-b80f-42a57f2d7cff`). "It tells me how many total days we've walked and how many days in a row." (Goal Tracker, `802a8de2-8685-4e59-962a-ddbfe5f81bb2`) | The streak motivates; the best and the total mean a break doesn't feel like losing everything. | Streak, best and total days are always side by side. A list of past runs is added. The streak can be hidden (§7.6). |
| **Totals and averages in the person's own unit** | "how many minutes you did a certain activity this week, this month, on average week, on average month. I found it very helpful" (HabitBull, `f763379a-f140-4c74-a39c-e44e2482936e`) | People care about 412 km, not only about "18 of 22 days". | Every amount and timed habit shows its total, its average and its best day in its unit. Time is always shown as h and min. |
| **Weekly, monthly and yearly rates** | "very detailed reporting that includes weekly, monthly and yearly completion rate." (Everyday, `a14ba9ec-e843-4002-9536-d374e8f150d0`). Reports praise: 407 reviews in 44 apps at 4.78★. | Recent periods show whether things are improving now. An all-time number hides that. | The Week, Month and Year picker with ‹ › shows any past period. Its numbers restart each period, including at a new year. |
| **Three honest states, clearly different** | Way of Life separates done, not done, skipped and not logged, so you can look back accurately (`952112429`, Japanese; paraphrased). "skipping a day without affecting the chain is very encouraging." (everyday, `3642b356-e9f0-4d88-82fd-b6ea06a907ba`) | Honesty without punishment. | One set of marks, used everywhere (§13): filled, partly filled, empty ring, skip sign, pause sign, and blank for days that weren't planned. **No red.** |
| **Seeing time spent per step** | "the Insights tab includes statistics about the length of time each task took and I LOVE IT" (RoutineFlow, `3415197c-8655-443b-b3dc-f17d0e32c624`) | ADHD users learn how long things really take. | Timed habits show their total and average time. Per-step routine timing is a separate item, because the player doesn't store step times (§23). |
| **Pace toward a period goal** | Strides' pace line is praised in 56 reviews (ledger R48). | "Am I on track this month?" | Period totals ("60 km a month") show "18 km to go, 9 days left", with a cumulative line and a pace line on the chart (§9). |
| **Filled things stay filled** | DotHabit: "even if the streak breaks, the colour I filled stays" (ledger R47) | Progress is counted by what you did, not by what you lost. | Totals and filled dots never reset. A slip on a quit habit ends a run, but the clean days already earned stay counted (§10). |

---

## 5. What gets complaints, and how we avoid it

| What goes wrong | Evidence (users show) | The rule we follow |
|---|---|---|
| **Numbers that are simply wrong** | 468 reviews in 72 apps, 3.08★. "My total days are 25, not sure how it's calculating my best streak as 30. Fix Or Explain." (Loop, `5aaabc5f-54b7-492a-91a4-f04161a41031`). "if i have set a goal of studying at least 6hrs and today i studied 7hr still it shows 20%" (Loop, `782e80f7-0324-4b60-a336-ffbb95b668b8`). A weekday shown one day off (DotHabit, `e26d2077-5e70-40b1-8e67-3f936a86c671`). | **One definition per number, in `HabitStore`, used by every screen** (§16). The best streak comes from the same run list as the streak, so it can never be larger than the total. Golden test cases are in §25. |
| **Weekly or flexible habits counted as daily failures** | 245 reviews in 53 apps. "As I take Sundays off, my maximum streak is capped at 6, even if I do everything perfectly all year." (Habitify, `9cefa7ff-ffe4-4c38-9770-b94a81d07329`). "After the update, weekly and monthly habits no longer count, so my score shows 0%." (Habitify, `8d7173ed-c152-4692-a20c-3060362fa3f9`, 1★) | A day that wasn't planned is **neutral**: never counted and never marked. A weekly goal is judged per week, not per day. It counts on a day only when something was logged that day (§16.3). |
| **Unfinished today dragging the number down** | "I do wish they wouldn't preemptively set your percent success rate to 97% if you haven't performed the habit yet that same day." (HabitBull, `0f9dd5bd-44f7-4470-be65-bd99402b7821`). Habitify's weekly report includes today: "reports include stats from today." (`9cefa7ff-ffe4-4c38-9770-b94a81d07329`) | **Today counts only once it's done.** A limit day counts only after it ends. |
| **A new habit lowering past days** | "when i put a new habit, it counts as if this habit was supposed to be started the same time with other habits. so my previous days are not complete anymore and habit score % goes down" (TickOff, `f9009c3a-c858-4ec5-b3ec-b3f2ff25ba50`). The same in Daily Habits (`217876e7-7c7c-4294-8913-e7fccf435f6b`, `b006f8ff-ea2b-4556-8f18-93eca15bef40`). | **Days before a habit's start day don't exist for it** (`startDay(of:)`). |
| **Editing rewrites history** | "if I change the number of repetitions per week of an activity, it changes the whole statistics (also for the previous period" (HabitBull, `dbf59948-0c4b-49b3-ace8-42372bcdc4a3`) | Every past day is judged by the rule in force that day (`store.rule(habit, on:)`, already built). The chart's goal line steps at the edit date. |
| **Partial effort shown as nothing** | 230 reviews in 49 apps ask for partial progress. "when I say I have to read 20 pages a day and I read 19 pages the app will give me the exact result as if I have read 0 pages!" (HabitBull, `753c81c3-07a4-44bb-a105-99c61ebc62a2`). "if a habit has multiple checklist items, it’s treated as an 'all-or-nothing' task." (TickOff, `6b31fe24-5e5e-45ee-8f14-41054366f9ee`) | **Part done** is its own mark, a partly-filled ring, and has its own count. Amounts show the real number. Checklists show steps done. |
| **Unexplained scores** | 253 reviews in 52 apps. "The only thing I don't get is the percentage tracker." (Goal Tracker, `2a4226fd-b8cf-4167-9177-1d18ff5a3320`). "It should be 0% or 100% not incremental to 100% you have either hit the target or haven't." (Loop, `a477d6d2-54c1-4d51-b5de-92885a5cb7d3`) | **Every percentage sits next to its fraction** ("38 of 45 · 84%"). An ⓘ opens a short sheet that explains each number in one sentence. There is no hidden formula. |
| **A number that jumps unfairly** | "if you have a good day your percentage of success goes up by 1, but if you have a bad day it goes down 20%." (HabitBull, `4ff8c8d4-91cf-47e8-9d7b-0ecbbb018f95`) | Rates are simple counts over a stated window, so one day moves them by one day's worth. |
| **Stats behind a paywall, or removed** | Paywalled: 345 reviews, 2.87★. Removed: 166 reviews, 2.64★. "They removed the ability to check individual success rates of habits." (Habitify, `05ddee66-1d59-4fe3-a3f6-7c5b41695757`). "You can only see progress from last 7 days!" (Avocation, `fb31ec89-de54-4441-b4ab-a6c5c2cde8ee`, 1★) | **All free, all history, forever** (§22). Once shipped, nothing is removed. |
| **History lost** | 220 reviews, 2.65★, half of them 1–2★. "I've lost all my progress that I've been tracking from 300 days." (HabitBull, `ebebcbd0-24dd-4ca9-ba39-cccb134a417b`) | Progress only reads. It never writes, deletes or "resets stats". Backup and sync are Build Plan items of their own. |
| **Hard to find** | 189 reviews in 39 apps. "When you go to the progress page you have to scroll past stuff that doesn't mean anything to you to see your stats." (Habitify, `3109ebd7-175a-44ca-b1ae-21664c0b58b5`, 1★) | One tap from Today. The numbers come first on the screen. There are no badges, tips or sales cards on it. |
| **Crashes on the stats screen** | 176 reviews, 2.83★. "crashes when going to progress page which defeats the purpose of TRACKING HABITS." (Habitify, `ee142a71-81ca-42b4-a035-282e97a2d122`, 1★). Way of Life's stats tab closing after an update (`f62b7d9a-d671-4aab-bcfb-6249806cd6a3`). | Tested with years of data on every `[ios-perf]` run (§20). |
| **Clutter, and people who want no stats at all** | 106 reviews in 42 apps. "No weird percentage analytics of how much you achieved on a particular day or during the week; just a straight out 'yes' or 'no'." (Goal Tracker, `402c8d8c-192d-439b-9a34-ee3276b8d240`). "the simplicity and general resume of your habits is gone" (Habitify, after its big stats update, `0f6507c6-7cc0-4d02-8928-d25305087b74`) | **Nothing on Today changes.** Progress is a screen you open by choice. The screen itself is short: one visual, three numbers, then the list. Detail lives on the habit page. |
| **Guilt** | 87 reviews in 35 apps. "Always opens to bad news" (HabitBull, `83a077dc-1175-4280-8983-ac7cb330d5bd`). A grid that "makes you feel guilty when you're not doing anything." (Rise, `e72a9a68-b85a-492c-be2a-08285e8e1aa0`) | No red, no "missed", no "failed", no down arrows on build habits, and no label that calls days bad. A Habit360 reviewer objected, in Arabic, to its stats naming "bad" days (`a9e50e90-e1d0-4727-9161-adc3dab998cc`, paraphrased). Percentages and streaks can be hidden. |
| **Changing data by accident from a stats screen** | "we can bymistakely click on previous days and unknowingly mark the habit undone" (Habit360, `e20a0188-4949-445f-97b3-c71778990840`). "It could have been better if tapping on a day in calendar view shows the details of that day rather than marking it." (everyday, `cece2a48-af57-458b-b27f-0862d9a3ec10`) | **Progress never logs.** Tapping a day shows its detail. Logging stays on Today, the same rule as the habit page. |
| **Colour-only meaning** | A reviewer with red-green colour weakness finds the stats "absolut unlesbar" (unreadable) (HabitNow, `2834a251-dd15-49fe-ba6e-0587a4dffba8`) | Every mark differs by **shape**, not only colour (§21). |

---

## 6. The structure of the page

> **Update, 30 Sep 2026 (the user, final):** Progress opens from the **≡ side menu**, not Today's top bar. The menu is built on the `sidebar` branch (`Docs/Checklists/Sidebar Menu.md`); its Progress row is wired to a "coming" page in `MenuPage` that Progress replaces. Everything else in this report stands. The build order is in `iOS/Docs/Specs/Progress — What to Build, in Order.md`.

### 6.1 The decision

**One Progress screen, then the habit's own page. Two levels, no more.**

```
Today ──(≡ menu, Progress row)──▶ Progress
                                     ├─ Week · Month · Year     ‹ This week ›
                                     ├─ Overview: day rings + 3 numbers   (tap a day ▶ Day sheet)
                                     ├─ Habits: one row per habit, with its strip   (tap ▶ Habit page)
                                     ├─ Quitting: one row per quit habit            (tap ▶ Habit page)
                                     └─ Archived (only when it has days in this period)

Habit page (existing, extended)
   header · numbers · month calendar  (kept as they are)
   + Over time  (Week · Month · Year · All, the type's numbers, a chart)
   + Year grid
   + Runs  (past streaks, or quit runs and slips)
   + By weekday
   notes · actions  (kept as they are)
```

### 6.2 Why this shape

- **Overview first** (users show). An overview is the most-asked-for thing: 697 asks in 63 apps. People say plainly that one habit at a time doesn't motivate (`2622560b-331d-484c-95e2-38164951e723`, `4289afb7-50cb-4dcb-86c0-c361b51d430c`). They want to land on the overview, not on the first habit. A Way of Life reviewer asks for the statistics to open with all habits selected (`5467149849`, German, paraphrased). A HabitBull reviewer wants to land on its "All Habits" overview (`6e034ffb-761f-4d1b-8d99-69e6aede544a`).
- **Rows with each habit's own strip under the overview** (users show). The weekly "all habits on one page" view is praised in 262 reviews in 42 apps at 4.78★. People also want to see which habit is falling behind without opening each one (`b91388f6-4872-46a8-aabd-5f2645ec6e28`, Spanish, paraphrased).
- **Detail on the habit's existing page, not a new screen** (reasoned from first principles). The habit page already shows the streak, best, done this month and the month calendar. Its research put charts under #60 on purpose. A second detail screen would repeat those numbers and split one habit's story across two places (checklist P14). So Progress adds sections to that page. Nothing on it is moved or removed, per the rule that a new feature must not remove an old one.
- **Easy to reach from Today** (users show). Hard-to-find stats draw 189 reviews in 39 apps. One user deleted an app because its statistics were hidden in the profile (ledger R86). **Final (the user, 30 Sep 2026):** Progress is the second row of the ≡ side menu, right under Today (`MenuPlace.progress`, built on the `sidebar` branch). The row pushes Progress onto Today's navigation stack, so Back and the edge swipe return to Today. The chart button that was in Today's top bar is gone. The row's place near the top of the menu keeps it two taps away and in plain sight.
- **Progress never logs** (reasoned from first principles, and users show). Stats screens that change data by accident draw complaints (`e20a0188-4949-445f-97b3-c71778990840`). Logging from the habit page was already rejected. Every tap in Progress opens detail. The day sheet has "Show on Today" for filling in a day.

---

## 7. The Progress screen, element by element

The screen is a SwiftUI `List` (`.insetGrouped`) called **`ProgressScreen`**. Don't name it `ProgressView`: that clashes with SwiftUI's own `ProgressView`. Its title is **Progress**, shown inline. It uses native parts only.

### 7.1 The range control (top)

| Part | Spec |
|---|---|
| Picker | `Picker` with `.segmented` style: **Week · Month · Year**. |
| Period line | `‹  This week  ›` as a centred title between two `chevron` buttons, the same pattern as `HabitMonthView`. |
| Period names | **Week:** "This week", "Last week", then "22–28 Sep" (the range, honouring the week start). **Month:** "September 2026". **Year:** "2026". |
| Limits | **›** is disabled on the current period: there are no future periods. **‹** is disabled at the period holding the earliest start day of any habit, archived habits included. |
| Default | **Week** on first open. After that, the last range chosen is remembered (`@AppStorage("progress.range")`). The period always opens on the current one. |
| Swipe | None. Swipes on a list of rows are easy to trigger by accident, and HabitBull reviewers complain of exactly that (`60331d1f-15a4-4a98-b0e9-fcc78ce682ae`, `015047ab-7e4a-4ee2-bd64-6957bca98d75`). The ‹ › buttons are enough. |

**Why Week by default** (reasoned from first principles, with users showing): a week is the period people can still act on. Weekly habits are judged by the week. A weekly dashboard is asked for directly: "a weekly dashboard that gives a weekly snapshot of all my habits at once." (HabitNow, `e5e7dcfa-c5dc-4f61-ac58-0e839234b99a`). A new user also has a full week sooner than a full month.

### 7.2 The overview (section 1)

**The visual changes with the range. The three numbers underneath keep the same meaning.**

| Range | Visual | Tap |
|---|---|---|
| **Week** | A row of **7 day rings**, one per day in the user's week order, each with its weekday initial above and the date inside. It is the same ring as the Today calendar sheet (`DayBar.dayButton`), taken out into a shared `DayRing` view. | A day ▶ **Day sheet** (§7.4) |
| **Month** | A **month calendar of day rings**: 7 columns, weekday initials, blank lead-in days. It is the same layout as the calendar sheet. | A day ▶ Day sheet |
| **Year** | A **year grid of round dots**, one per day. Weeks run left to right in columns and weekdays run top to bottom; month initials are above and M, W, F labels on the left. A dot's shade is that day's fraction done (§13.3). Days that weren't planned, and future days, have no dot. | A month column ▶ switches to **Month** on that month. A 5-point dot is too small to tap (§21). |

**How a ring fills (the day fraction):** planned habits done, plus part credit, divided by planned habits (§16.4). A day with nothing planned has no ring, only its date, in secondary colour. Future days show a faint empty track, as the calendar sheet already does.

**The three numbers**, in one row of three native stat tiles (the habit page's `stat` style):

| Tile | Big text | Caption | Rule |
|---|---|---|---|
| 1 | **38 of 45** | "Done · 84%" (the percentage only while percentages are shown, §7.6) | Planned check-offs done in the period, counting up to today. Today counts only for what is already done (§16), so it never lowers the number. The Today day bar's "2 of 5" for today is a different number: what is left today. |
| 2 | **4** | "Full days" | Days where every planned habit was done. Days with nothing planned aren't counted. |
| 3 | **2 of 3** | "Weekly goals met" (or "Monthly goals met", or "Goals met" when kinds are mixed); "… so far" while the current period is running | Periods of week, month or year goals inside this range: those that ended, plus the current one. The current period adds to the top number only once it's met. **This tile is hidden when the person has no such goals.** |

**Under the tiles, one neutral line:** "Last week: 31 of 42". For Month it reads "August: 70 of 88", and for Year "2025: 812 of 990". It is plain text with no arrow and no colour. It is hidden when there was no earlier period, or while percentages are hidden, because it is a comparison and the people who hide percentages don't want one. Users show that comparing periods helps: "improvement of habits week or month wise" (everyday, `ed968575-15a9-4e9c-86a1-e4649c160a8b`). Arrows that judge were disliked (ledger R59), so there are none.

**An ⓘ button** at the end of the section header ("Overview") opens the **How it's counted** sheet (§7.5).

**When the overview is hidden:** when the only habits are quit habits, or when nothing was planned in the period. The Quitting section then shows alone, or the empty state (§7.8).

### 7.3 The habit rows (section "Habits")

One row per build habit and cut-down habit that has at least one planned day in the period, or that is running now. Rows follow the person's own order from All Habits: users reorder habits, and Today already follows that order.

**Row layout** (native `HStack` in a `List` row, with the whole row as one button):

```
[icon 32]  Read                                   ● ● ○ ● ◐ · ·     ← Week: 7 marks, trailing
           4 of 5 days · 80%

[icon 32]  Water                                                     ← Month and Year: the strip goes under the name
           412 glasses · 18 of 22 days
           ●●●◐●●○●●●●◐●●●●○●●●●●◐●● · · · · · ·            ← Month: one dot per day
```

| Range | Visual in the row | Size |
|---|---|---|
| Week | 7 marks in fixed columns, trailing. One weekday-initial header row sits above the first habit row. | 14-point marks, 18-point columns (126 points in all) |
| Month | One dot per day of the month, in a line under the subtitle. | 7-point dots, 2.5-point gaps, drawn with one `Canvas` |
| Year | That habit's own mini year grid, under the subtitle. | 4.5-point dots, 1.5-point gaps, 7 rows, drawn with one `Canvas` |

The marks are the ones in §13. Tapping the row opens **HabitPageView** for that habit, already scrolled to its **Over time** section with the same range and period selected.

**The row's subtitle** depends on the habit's type and the range (§9.1 has every case). While the current period is still running it says "so far" ("2 of 3 so far"). A habit that starts later says "Starts Mon 6 Oct". A paused habit says "Paused until 12 Oct" or "Paused". A habit with nothing planned in the period says "Nothing planned this week" (or month, or year).

### 7.4 The Day sheet (tap a day)

A native sheet at medium height, which can be dragged to large. Its title is the date: "Wednesday 24 September". It holds:

1. **A summary line:** "5 of 6 done · 1 part done".
2. **Habits planned that day**, in the person's order. Each row shows its mark, name and value: "Water · 6 of 8 glasses", "Read · Done", "Run · Skipped", "Stretch · Not done", "Journal · Paused".
3. **Weekly and monthly goals with something logged that day:** "Gym · 1 time (2 of 3 this week)".
4. **Quit habits with a slip that day:** "Smoking · Slip at 21:40".
5. **Notes:** the day's note, and each habit's note for that day. Notes are read-only here, and each row with a note shows it under the name.
6. **A "Show on Today" button** at the bottom. It clears the menu's navigation path (`MenuModel.path`), which closes Progress, and sets Today to that day, where logging happens.

The sheet never logs. A day with nothing planned still opens, showing its notes or "Nothing was planned on this day."

Users show they want this: "can't tap a day to see which habits were done" (ledger R69). Asks for day detail and notes in history: 181 reviews in 50 apps.

### 7.5 "How it's counted" sheet (ⓘ)

A short native sheet with a list of plain sentences and the legend. Every number on the screen is explained, so none reads as broken (ledger C217, Certain).

- **Done:** "Each thing you planned and finished. A habit you do 3 times a day counts 3."
- **Percentage:** "Done out of planned, for days up to today. Today counts once it's done."
- **Full days:** "Days when everything you planned was done."
- **Weekly goals met:** "Weeks where you reached a '3 times a week' or '20 km a week' goal. The week in progress counts once it's met."
- **What isn't counted:** "Days that aren't one of a habit's days, skipped days, paused days, days before a habit started and weekly goals on days you didn't log. None of these count for or against you."
- **Part done:** "Some of the goal was reached. The ring fills part of the way; it isn't counted as done."
- **The legend** (§13): every mark with its name.

### 7.6 View options (toolbar menu)

A `Menu` in the toolbar (the `ellipsis.circle` button) with two toggles:

- **Show Percentages** (on by default). When off, every percentage and the last-period line are hidden on Progress and on the habit page. Fractions stay.
- **Show Streaks** (on by default). When off, streaks and bests are hidden on Progress, on the habit page and on Today's rows.

Stored in `@AppStorage`. Users show both needs:

- For hiding: "The only problem I have with the app is the success percentage which can't be disabled" (HabitBull, `56d1a62e-8aa5-4c14-835c-d66bd6f064c6`). A MyRoutine subscriber cancelled over the pressure of its green light and streak system, and asks for an on/off switch (`b55e7182-c881-4c52-9b8c-3cd61c197502`, Korean, paraphrased).
- For keeping them on by default: percentages are praised in 393 reviews and streaks in 479, far more than they are disliked.

Ledger C157 ("every guilt mechanic must be optional", Certain) and C207 ("let users hide surfaces they don't use", Certain) both point here. **Two toggles, not a settings page:** the app has no Settings yet (Build Plan). When Settings arrives, these two move there and stay in this menu too.

### 7.7 The other sections

- **Quitting:** one row per quit habit. It shows the current run and the slips in the period (§10.2). The strip marks clean days and slip days.
- **Archived:** shown only when an archived habit has planned days in the period on screen. Its rows are like any other. The section footer reads: "Archived habits count for the days before they were archived."
- **Tasks:** never shown (§12).

### 7.8 Empty and edge states

| State | What shows |
|---|---|
| No habits at all | `ContentUnavailableView`: title "No Progress Yet", image `chart.bar.xaxis`, text "Add a habit on Today and its progress shows here." |
| Habits exist but none has started | The overview is hidden. Rows say "Starts Mon 6 Oct". |
| A past period with nothing planned | The overview reads "Nothing was planned this week." (or month, or year). There are no rows. ‹ › still work. |
| Only quit habits | No overview; only the Quitting section. |
| The first day of use, or the first day of a period | The overview shows today's ring filling as things get done. Until something in the period is planned and counted, tile 1 shows **"0"** with the caption **"Done so far"**, never "0 of 0" and never 0%. |

---

## 8. The habit page's progress sections

`HabitPageView` keeps everything it has. The new sections go between the month calendar and the notes. Quit habits get their own version (§10). Tasks get none.

### 8.1 The numbers row (kept, with one line added)

The existing three tiles stay: **Streak · Best · Done this month**, using the existing unit words ("23", "4 wk"). **One line is added under them:**

- Build habits: "213 days done since 12 Mar 2025". Amounts and time add their total: "1,204 km in all since 12 Mar 2025".
- Weekly and other period goals: "Goal met 31 weeks since 12 Mar 2025".

Users show that a total which a break can't take away matters: "Wish I could get total count of successful days though, instead of just a percentage." (HabitBull, `e4caab0a-b727-4499-99e4-232ff05d43fc`). Also a DotHabit reviewer (`f9c34729-82c4-4f1d-b6e5-7e73b8a26f97`, Japanese, paraphrased: show both the total and the current run). Ledger C047 is Strong.

### 8.2 The month calendar (kept, one behaviour added)

Unchanged in look. **Tapping a day now opens a small popover** with the date, the mark in words, the value ("6 of 8 glasses"), and the note if there is one. It never logs. The page's research wrote "tapping a day does nothing yet"; this fills that gap. Users ask for day detail: 181 reviews in 50 apps. The popover is the same content as one row of the Day sheet (§7.4), so the code is shared.

### 8.3 "Over time" (new)

| Part | Spec |
|---|---|
| Range | Segmented **Week · Month · Year · All**, and ‹ period › (All has no ‹ ›). When opened from Progress, it starts on Progress's range and period. |
| Numbers | Two to four tiles, depending on the type (§9.2). |
| Count bar | One thin horizontal stacked bar: **Done · Part done · Not done · Skipped · Paused**, with counts under it ("18 · 2 · 2 · 1 · 0"), always in that order, and zero parts left out. It gives what people ask a pie chart for (successful, failed and skipped days in a month: HabitBull, `6ad5d1f7-2278-4299-b010-aa527f8432fc`; Habitify, `e2ea8762-9eb8-49d7-b84e-aff1e292a263`), and is easier to read than a pie. |
| Chart | Swift Charts, one chart per type and range (§9.3). Bars use the habit's colour. A goal or limit is a `RuleMark` line that steps where the goal changed. Part-done bars are lighter. There is no red anywhere. |
| 30-day rate | In **All** only, for day-based habits: a line of the 30-day rate (§16.6), one point per week. Title "30-day rate", with ⓘ. |
| Footnotes | Plain sentences, only when they apply: "Goal changed from 30 to 45 min on 15 Sep." "This habit started on 12 Mar." "Counted in miles before 3 Sep." |

**Why All exists** (users show): long-range history is praised in 380 reviews in 44 apps. Losing it or being capped hurts: "I need to see the trends over long term" (Avocation, `d2a54f67-c049-4b2d-a013-351683c5c4ae`), and "I wish there was a monthly calendar view so I could see I got my goals 23 out of 31 days" (Avocation, `03a966a7-d386-4474-a51a-2e3194db2c9c`). But **all-time alone is also a complaint**: "Even with premium theres almost zero statistics that show improvement over time, theres only alltime stats." (Productive, `2dbb9c3e-6eec-4c28-9ee4-4d0fa0a7b244`). Hence the recent periods as well as All.

### 8.4 Year grid (new)

- One year of this habit's days as round dots, in the same layout as the Year overview (§7.2) but larger: 9-point dots.
- Months are labelled across the top and weekdays down the side. A year title sits in the middle with ‹ › to earlier years. › stops at the current year.
- **Shade = that day's fraction** (§13.3). Days over the goal get a small white centre dot, so doing more shows. Users ask for this: "Different shades based on the frequency instead of just true/false." (`c92ea41d-a00a-4a57-a8d2-2a0331d53eab`) and "more sets done of a habit means a darker shade" (TickOff, `b2514b65-60f1-4dc9-a7ae-1a3157c80f8e`).
- **Tap a month** ▶ the month calendar above jumps to that month and scrolls to it.
- Days before the start, days that weren't planned, and future days get no dot.

### 8.5 Runs (new)

For every build habit: **the five longest runs**, each with its dates, and the current run marked. For example:

- 40 days · 3 Mar – 11 Apr 2026
- 22 days · 1 – 22 Jul 2026 (current)

The unit follows the streak's own unit (days, times, weeks, months). A "Show all" link opens the full list, newest first.

Users show:

- "Add setting to always show best streak." (Way of Life, `1760651629`)
- "I’d love to see a section where I can see my progression of streak length." (Way of Life, `9405916639`)
- "you see some sort of graph showing the history of streak lengths to really visualize how much one has improved." (Productive, `fa7ace69-ea88-42c9-924c-1a5ecb21aa77`)

A "longest gap" number was asked for once (`cadc79f8-180d-4536-9d9f-52412d26f8a1`). **It is not built:** it measures the person's worst stretch (§23).

### 8.6 By weekday (new)

Only for day-based habits with at least **28 planned days** in the chosen range; otherwise the section is hidden. It has 7 small bars in the person's week order:

- Check habits: the percentage done of that weekday's planned days.
- Amounts and time: the average on that weekday.

The title is "By weekday" with one neutral caption: "Most often done on Mon and Wed." **No "worst day" wording.**

Users show: "I'd like to see if I have lack of meditation on Fridays or lack of early awakenings on weekends." (Way of Life, `680402f4-7571-4e86-9f58-a9bf46a024d5`). Patterns are praised in 215 reviews at 4.82★. Roubit's version was criticised for judging a weekday by raw counts instead of by the share of what was planned (`5d3f4c6c-3d54-4297-b669-8062e0c5dab9`, Korean, paraphrased). So the rate is always out of the planned days.

---

## 9. Every habit type, one by one

The app's types (`HabitKind`) and frequencies (`Frequency`) come down to **ten shapes**. Each shape is taken from the rule in force (`store.rule(habit, on:)`) on the last day of the range. Each past day is still judged by its own rule.

| Shape | Which habits | Judged per |
|---|---|---|
| **A · Once a day** | Check it off with goal 1, on a day-based rule: every day, days of the week, every few days or weeks, dates, calendar rules | day |
| **B · Several times a day** | Check it off with goal > 1, or with two or more times of day (slots) | day, counting times |
| **C · An amount a day** | Track an amount, day-based, not a limit | day |
| **D · Time a day** | Time it, day-based | day |
| **E · Checklist** | Checklist | day, counting steps |
| **F · Times a period** | Check it off, `perWeek` / `perMonth` / `perYear` | week / month / year |
| **G · Total a period** | Amount or time, week / month / year total (`isTotal`), not a limit | week / month / year |
| **H · Days a period** | `flexible(period, n)`, for example "5 km on 3 days a week" | week / month / year, counting days reached |
| **I · Cut down** | Amount with `atMost`: a daily limit (I-day) or a weekly or monthly limit (I-period) | day, or the period |
| **J · Quit** | `.quit` | a run of time |

### 9.1 The row subtitle on Progress

Examples use real-looking values. "· 82%" appears only while percentages are shown.

| Shape | Week | Month | Year |
|---|---|---|---|
| A | "4 of 5 days · 80%" | "18 of 22 days · 82%" | "201 of 240 days · 84%" |
| B | "18 of 21 times · 86%" | "52 of 60 times · 87%" | "610 of 720 times · 85%" |
| C | "46 glasses · 5 of 7 days" | "412 km · 18 of 22 days" | "4,310 km · 201 of 240 days" |
| D | "3 h 20 min · 5 of 7 days" | "14 h 5 min · 18 of 22 days" | "162 h · 201 of 240 days" |
| E | "34 of 40 steps · 4 full days" | "150 of 176 steps · 16 full days" | "1,720 of 2,000 steps · 170 full days" |
| F (weekly) | "2 of 3 so far" or "3 of 3 · met" | "Met 3 of 4 weeks · 11 times" | "Met 40 of 52 weeks · 150 times" |
| F (monthly) | "2 times this week" | "7 of 10 so far" | "Met 9 of 12 months" |
| G (monthly) | "12 km this week" | "42 of 60 km so far" | "Met 9 of 12 months · 520 km" |
| G (weekly) | "31 of 50 km so far" | "Met 3 of 4 weeks · 168 km" | "Met 41 of 52 weeks · 2,210 km" |
| H | "2 of 3 days so far · 10 km" | "Met 3 of 4 weeks · 11 days" | "Met 41 of 52 weeks" |
| I-day | "Avg 4.1 a day · limit 6" | "Avg 4.6 a day · limit 6" | "Avg 5.2 a day · limit 6" |
| I-period | "12 of 20 this week" | "38 of 60 this month" | "Within the limit 10 of 12 months" |
| J | "12 days · no slips this week" | "12 days · 2 slips in September" | "12 days · 5 slips in 2026" |

### 9.2 The numbers in "Over time"

Each shape's numbers in order, with what they answer.

| Shape | Tile 1 | Tile 2 | Tile 3 | Tile 4 |
|---|---|---|---|---|
| A | **Done** "18 of 22 days" · 82% | **Longest run** in the range | **Skipped** n (hidden at 0) | **Paused** n (hidden at 0) |
| B | **Done** "52 of 60 times" · 87% | **Full days** "16 of 20" | **Part done** n days | — |
| C | **Total** "412 km" | **Average** "18.7 km a planned day" | **Goal reached** "18 of 22 days" | **Best day** "25 km · 3 Sep" |
| D | **Total** "14 h 5 min" | **Average** "38 min a planned day" | **Goal reached** "18 of 22 days" | **Longest day** "1 h 30 min · 3 Sep" |
| E | **Steps** "150 of 176" · 85% | **Full days** "16 of 22" | **Part done** n days | — |
| F | **Periods met** "3 of 4 weeks" | **Times** "11" | **Average** "2.8 a week" | This period: "2 of 3 so far" |
| G | **This period** "42 of 60 km" + pace line (below) | **Periods met** "9 of 12 months" | **Average** "48 km a month" | **Best period** "71 km · Mar" |
| H | **This period** "2 of 3 days so far" | **Periods met** "3 of 4 weeks" | **Days reached** "11" | **Total** "58 km" (amounts only) |
| I-day | §11 | | | |
| I-period | §11 | | | |
| J | §10 | | | |

**Pace line for G and I-period**, under tile 1, in neutral words:

- "18 km to go · 9 days left", or "Reached on 24 Sep" once it's met.
- For a limit: "38 of 60 so far · 9 days left".

**E (checklist) also gets a "By step" list** under the chart: each step's name and the share of planned days it was ticked ("Floss · 60%", "Brush · 100%"), in the person's step order. It is **never sorted worst first**. Users show: "I only wish the statistics would show how many steps I completed rather than how many routines" (RoutineFlow, `3e445595-8d0a-4e8a-bbaf-9aaed5c236a4`).

### 9.3 The charts

| Shape | Week | Month | Year | All |
|---|---|---|---|---|
| A | none (the week strip is enough) | 4–5 bars: % done each week | 12 bars: % done each month | monthly % bars (scrolling) + 30-day rate line |
| B | 7 bars: times each day, goal line | ~30 bars: times each day, goal line | 12 bars: times each month, with the planned count as a line | monthly bars |
| C, D | 7 bars: amount each day, goal line; bars go past the line when more was done | ~30 daily bars, goal line | 12 bars: total each month; caption "Avg 18.7 km a planned day" | monthly totals |
| E | 7 bars: steps done each day, step-count line | ~30 daily bars | 12 bars: % of steps each month | monthly % |
| F | 7 dots on the days logged + "2 of 3" | 4–5 bars: times each week, goal line | 52 bars (weekly) or 12 (monthly), goal line | per-period bars |
| G | cumulative line through the period + straight pace line from 0 to the goal | the same, for a monthly goal; weekly goals: 4–5 bars with a goal line | 12 or 52 bars, goal line | per-period bars |
| H | 7 daily bars with a day-goal line; days that reached it are marked | weekly bars of days reached, with an N line | the same, 52 bars | per-period bars |

**How charts look:**

- The y-axis has the unit's own labels, and time is always h:mm. This matters: a Loop user asks, in Ukrainian, why an hour has 100 minutes in its stats (`c603b916-e750-41c4-90dd-f0d7b33aaef5`, paraphrased).
- The x-axis has dates.
- Tapping a bar shows its exact value in a callout (Swift Charts `chartXSelection`).
- Numbers are drawn at full scale, not squeezed flat: a Loop user who is a scientist found values of 113–115 plotted as a flat line on a percent-only axis (`c94ac6df-0aad-4798-bfd6-f8a574a14c93`, paraphrased).
- Every chart here shows counts, totals or percentages, so each y-axis starts at 0 and is labelled in the habit's own unit. That complaint came from values plotted on a percent-only axis, which never happens here. A value with no goal, like weight, isn't a habit type in this app.

---

## 10. Quit habits

### 10.1 What people need (users show)

Quit statistics are praised in **708 reviews in 26 apps (mean 4.83★)**, 614 of them for Days Since. Asks: 158 in 36 apps. The ledger's Quit Habit Decision and card C019 (Strong, 30 apps) say the same things:

- **A slip must not wipe the record.** A Quit Bad Habits reviewer asks that a slip show words of support and how many days *could have been* clean, instead of zeroing the counter (`10995642477`, Russian, paraphrased). Ledger C308 (Moderate): logging a lapse must not be the same action as destroying the count.
- **The slip's own date and time.** "Очень нравиться то что при рецидиве можно выбирать дату и время" (Quit Bad Habits, `14000029981`, Russian: *I really like that for a slip you can choose the date and time*).
- **A reason saved with a slip.** Praised in Japanese: "再発してしまった時に理由を書いて保存できる機能が素晴らしい" (Quit Bad Habits, `11090976286`: *the feature to write and save the reason when you slip is wonderful*).
- **Slips shown on a calendar as dots** (`14380495771`, Russian, paraphrased).
- **Best run next to the current run, runs over time, and milestones.** Milestones are Days Since's largest positive request (ledger R03-077). Graphs of run length over time and of average runs are asked for (R03-112).
- **Money saved** (ledger C100, Moderate, 3 apps): for example an app "that tells me how much time I'm saving by not logging onto inst[agram]" (Quit Bad Habits, `14510416958`).

### 10.2 On Progress

A **Quitting** section, with one row per quit habit:

```
[icon] Smoking                                      12 d 4 h
       Best 40 days · 2 slips in September
       ●●●●●●●●○●●●●●●●●●○●●●● · · · · · ·    ← clean days filled, slip days an empty ring, paused blank
```

The time on the row ticks **once a minute** (days and hours only). Seconds tick only on the habit page's clock (§10.3). This follows the rule that a list must never sit inside a per-second `TimelineView`.

Quit habits are **not part of the overview's day rings or numbers**. They aren't planned day by day, and mixing a clean-days count into "38 of 45" would blur both.

### 10.3 On the habit page (quit version)

| Part | Spec |
|---|---|
| **Clock** (existing "This run" tile, now live) | "12 d 4 h 31 min 07 s", ticking every second **inside this tile only**. It uses `TimelineView(.periodic(from: runStart, by: 1))`, anchored at the run's start and never at `.now`, as the design rules require. Shows "Paused" while paused. |
| **Best run** (existing) | "40 days". |
| **Added line** | "187 clean days since 2 Jan 2026 · 5 slips". **The total of clean days never goes down.** |
| **Next milestone** | "Next: 14 days · in 2 days". The ladder is 1, 3, 7, 14, 30, 60, 90 and 180 days, then 1 year, then each year. It is gentler than a 1→7→30→100 ladder that users found rigid (ledger R90). No confetti and no pop-up. |
| **Over time** (Week · Month · Year · All) | Tiles: **Slips** n · **Clean days** "26 of 30" · **Longest run** in the range · **Average run** (All only: the mean of runs that ended in a slip). |
| **Runs chart** | One bar per run in time order. Height is the length in days. The current run is in the habit's colour and labelled "Now"; earlier runs are lighter. A dashed line marks the average. Titled "Runs". |
| **Year grid** | Clean days filled, slip days an empty ring, paused days blank, days before the start blank. |
| **Slips list** | Newest first: "Sat 20 Sep · 08:00", with that day's note under it if there is one. Tap ▶ the note bar for that day, which already exists. |
| **Milestones reached** (All only) | One line: "Reached: 1 day (3 Jan) · 7 days (9 Jan) · 30 days (1 Feb)". |

**Copy** (§19): "slip", "clean days", "run". Never "relapse", "failed", "reset" or "back to zero".

### 10.4 Needed first: a slip is an event with its own time

Today, `quitRuns` reads slips from the habit's entries (`Entry.createdAt`), and treats a later `quitSince` as one more slip. **Today's quit row has no "I slipped" action.** The form's "Started" date is the only way to restart, and it keeps only the latest start. So **the run history, slip count and slip list above need a real slip event**:

- A **"Log a Slip…"** item in the quit row's long-press menu and on the habit page.
- It opens a small sheet with the date and time, defaulting to now, and an optional note.
- It saves an `Entry` whose `createdAt` is **the chosen moment**, and whose `day` is that moment's local day.
- **Undo** is shown right after. A widget slip needs a confirm or an undo (ledger R03-075).
- Editing "Started" stays for fixing a wrong start. It must not be the way to record a slip.

This sits in the quit type's own build item. The Progress sections read these events; they don't create them.

### 10.5 Later: money saved

This needs one optional field on quit habits, "What it costs you a day" (an amount and a currency). Then "Saved so far: £312" shows under the clock. It is left out of the first build because the form has no such field. The evidence is Moderate (3 apps, ledger C100). Phase 3 (§25).

---

## 11. Cut-down habits

### 11.1 What people need (users show)

- **Hitting the limit is not success:** "You can set a goal of at most, but the graphs still congratulate me on smoking my upper limit" (Loop, `05abe6c1-13db-4234-8299-9eac9d0d6e65`).
- **Staying under the limit is.** A Pole with a limit of 15 cigarettes smoked 12 and didn't get 100% for the day, and asks whether they should smoke the missing 3 before bed (`174b7e07-cc46-4dab-9d82-985b242ba7a6`, Polish, paraphrased).
- **How far over matters.** Going over the limit by 1 or by 2 made the same drop in the score (`4316a23a-bff7-4cbe-9cd1-1fdeedd74859`, paraphrased).
- **Seeing the counter against the limit:** "it's quite hard to see how many you still have left." (Avocation, `de0a9484-5b7a-4ede-b836-1e5578c01fa4`)
- **Tapering over time.** Cutting 100 cigarettes a week by 10% steps (Loop, `a4b5695d-08b2-4fb8-9220-91fe96284a3d`, Russian, paraphrased). Seeing progress in cutting down without logging "relapses" (HabitKit, `3cb152c4-ecfe-4a60-a540-9d8cc7ec83da`).
- **An upper limit at all.** Asked for in Loop again and again: six reviews, rows 10152, 10173, 10269, 10311, 10382 and 10413 of `coded_reviews.tsv`, for example `699fdccf-57ec-4525-939e-ccc22a8cf4bd`. Both at-most and at-least goals are praised by an IBS symptom tracker (HabitBull, `faeb0944-1c84-4935-a7e5-c11e4dcdc2e7`).

### 11.2 Rules

1. **Lower is better, and the chart never celebrates.** Bars are in a neutral colour, the habit's colour at 60%. The limit is a dashed line. A day over the limit gets a small ▲ above its bar. There is no red and no "failed".
2. **A limit day is judged only when it's over.** Today shows progress toward the limit ("2 of 6 so far") and is never counted as "within the limit" before it ends. Otherwise every morning would start as a success with nothing logged (§17.2).
3. **A day with nothing logged, once over, is within the limit and counts as "a day with none".** For cut-down, zero is the best result there is.
4. **Change against the last period is shown as plain words:** "Down from 5.1 a day in August" or "Up from 3.8 a day in August". It uses the same neutral colour both ways. This is the one place a trend is stated, because for a limit going down is the goal.

### 11.3 What shows

| Where | Daily limit (I-day) | Weekly or monthly limit (I-period) |
|---|---|---|
| **Progress row** | "Avg 4.1 a day · limit 6" | "38 of 60 this month" or "Within the limit 10 of 12 months" |
| **Over time tiles** | **Average** "4.6 a day" · **Within the limit** "24 of 30 days" · **Days with none** "3" · **Highest day** "9 · 12 Sep" | **This period** "38 of 60 so far · 9 days left" · **Periods within** "10 of 12" · **Average** "44 a month" · **Lowest period** "31 · Jul" |
| **Change line** | "Down from 5.1 a day in August" | "Down from 51 in August" |
| **Chart** | Daily bars (Week, Month), dashed limit line, ▲ on days over. Year: monthly average bars against the limit. All: monthly averages. | A cumulative line through the period against a straight line from 0 to the limit (Week, Month); per-period bars (Year, All). |
| **Day marks** | Within the limit, once over: filled. Over the limit: an empty ring with a ▲. Today: open. | Days with something logged: a dot sized by share. No "not done" days. |
| **Streak** | "Within the limit N days in a row", using the existing streak. It works once today is judged only when it ends. | N weeks or months in a row. |

---

## 12. Tasks stay out

**No task appears anywhere in Progress**: not in the day rings, not in the numbers, not in the rows, and not on the Day sheet. This matches what is built ("tasks have no habit progress, streaks or stats") and the user's instruction.

Checked against the evidence: a few reviewers want to-do counts in reports (for example a daily report for an accountability partner, HabitBull `d1f94777-b640-4a0a-ac73-ac1713f6afdc`). The ledger's all-habits overview point (C254) is about habits. Roubit users asked for its analysis to show routines only, not the one-off to-dos mixed in (`477586d2-a28c-469b-b4b4-e63b2201e97b`). **Leaving tasks out is also what users of mixed apps ask for.**

---

## 13. Day marks and the legend

### 13.1 One set of marks, everywhere

The existing month calendar (`HabitMonthView`) already draws these, round as the design rules require. Progress uses **the same shapes**, taken out into a shared `DayMarkView(mark:, fraction:, size:)`, so they are never defined twice. They are listed here with the name the legend uses.

| `DayMark` | Name in the legend | Large (calendar, 34 pt, with the date) | Small (strips and grids, 4.5–14 pt) | Counted? |
|---|---|---|---|---|
| `.done` | **Done** | Filled circle, habit colour, white date | Filled dot, habit colour | Yes: done |
| `.some` | **Part done** | Ring in the habit colour (kept). In Progress's week strip the ring's arc is trimmed to the fraction | Dot at 45% opacity (under half) or 70% (half or more) | Yes: planned, counted in "Part done", not in "Done" |
| `.missed` | **Not done** | Date only, no fill (kept, never a harsh mark) | **Empty ring**, secondary colour, 1 pt | Yes: not done |
| `.open` | **Not done yet** (today) | Faint ring around today's date (kept) | Empty ring, dashed | No, until done |
| `.skipped` | **Skipped** | Faint date + `forward.fill` sign (kept) | Blank in grids; a tiny `forward.fill` in the week strip | No |
| `.paused` | **Paused** | Faint date + `pause.fill` sign (kept) | Blank in grids; a tiny `pause.fill` in the week strip | No |
| `.notItsDay` | **Not one of its days** | Faint date (kept) | Blank | No |
| `.upcoming` | **Coming up** | Small dot under the date (kept) | Blank in grids; a small faint dot in the week strip | No |
| `.before` | **Before it started** | Faint date (kept) | Blank | No |

**Why this set** (users show, and reasoned from first principles):

- **"Not done" must look different from "skipped" and from "not planned".** Users ask for exactly this: "there should be possibility to discern between not tracking the habit and not doing the habit." (Loop, `007a9215-fc7b-493b-8e75-e6f252f27c15`). Also HabitBull: "If you leave the day unmarked it counts as failing." (`c7feefb1-ff50-4a99-8e6e-605588cd3e83`). Ledger C256 is Certain (14 apps).
- **In small grids, only planned days get a mark.** So a skipped, paused or unplanned day is simply empty space, and the grid shows the person's real plan.
- **No red.** The design rules forbid guilt colours. Way of Life users do praise red for honesty (ledger R76), and that honesty is kept: a "not done" empty ring is plainly different from a filled one. But red is also named by users as the thing that makes them quit. A MyRoutine user says the light stays red or orange all day until the routine can be finished in the evening, and it makes them uneasy (`12424534015`, Korean, paraphrased; ledger R18), and a Way of Life reviewer asks for a yellow "in between" so it doesn't feel like pass or fail (`1494739908`).

### 13.2 The legend is always one tap away

At the bottom of the "How it's counted" sheet (§7.5), and under the month calendar (kept). Everyday users couldn't find their skip symbols' meaning again after the intro, for seven years (ledger R46, C259).

### 13.3 Shade in year grids and month strips

| Day fraction (§16.4) | Shade |
|---|---|
| 1.0 (done) | 100% habit colour. For the overview: `Color.ink` (the Today ring colour) |
| 0.5 – 0.99 | 70% |
| 0.01 – 0.49 | 45% |
| 0 on a planned past day | Empty ring (not done) |
| Over the goal (amounts and time) | 100% plus a small white centre dot |

For **cut-down**: within the limit is 100%; over the limit is an empty ring with a ▲ in the week strip, or just the empty ring in grids.

---

## 14. Time ranges

| Range | On Progress | On the habit page | Periods run… |
|---|---|---|---|
| **Week** | Yes (default) | Yes | from the user's week start (`settings.weekStart`, `store.period(.week, containing:)`) |
| **Month** | Yes | Yes (default when opened from All Habits) | calendar months |
| **Year** | Yes | Yes | calendar years. Every number restarts on 1 January. A HabitNow user found last year's 50% carried into the new year (`06756e65-4d2a-4727-8067-c2424d76b53b`, Portuguese, paraphrased). Past years stay one ‹ away; one user worried that the current year's record would vanish when the year ends (ledger R58). |
| **All** | No (the overview is about periods) | Yes | the habit's start day to today |

**Rules that hold for every range** (users show each one):

- **Past periods can always be opened**: "I hope that in the statistic analysis it could show data of the month which I was looking, rather than merely current month." (HabitBull, `3589e020-8a88-4848-95ef-eec4854cd233`).
- **Recent rates, not only all-time**: "I can't change the indicator based on my desire period e.g. in a monthly percentage (currently only all time percentage)" (Goal Tracker, `627adfcc-9cca-4cb5-bc76-e003f356a139`).
- **Weeks follow the week start.** Users ask for this setting because statistics depend on it (`7a216abf-4537-407c-a6a5-f58939537ca1`). The monthly statistics must follow it too (MyRoutine, `6fa39e1c-a2a2-401f-9ef4-fd59bc4a1e46`, Korean, paraphrased).
- **Days follow the day-end hour** (`settings.dayEndHour`): "I often log sth after midnight but before sleeping and widgets are already set to next day." (Loop, `0ad9dd82-6c1a-4780-a049-7fbb4dd7efb3`). Every day in Progress is a `LocalDay` from `store.today()` and `Entry.day`, so this already holds.
- **No custom date ranges** in the first build. Twenty-two Way of Life users asked for other ranges (ledger R76), and Week, Month, Year and All cover the asks read here. Custom ranges would add a date picker to a calm screen (§23).

---

## 15. Groups: planned now, built later

Groups aren't built. The day-structure research already counted what people want from group stats: **174 reviews** (§2.6 of *Habit Tracker — Day Structure Explained in Plain English*). The top asks, in order, are:

1. Filter the stats to one group: 48.
2. A completion percentage per group: 37.
3. Compare groups: 31.
4. A trend per group: 24.
5. An overall number across everything: 20.

This corpus adds 140 asks and 33 praises in 36 and 17 apps. For example, "see the overall percentage for each category and not just per habit" (Habit360, `8b2d8fe4-d028-4b01-bacb-7603fe73adc5`), and "the ability to put multiple habits in one category and see the statistics of the category. This feature is missing in most apps." (`4082cc04-4dce-4ebe-b9e6-9ca23bb7f88e`).

**What is built now so groups need no rework:**

- **Every calculation in §16 takes a list of habits** (`[Habit]`), never "all habits". `dayScore(on:habits:)`, `periodResults(_:in:)` and the rest are written that way from day one.
- **`ProgressScreen` keeps a `scope`**: `enum ProgressScope { case all; case group(UUID) }`. While groups don't exist it is always `.all`, and nothing shows for it.
- **The habit list is already split into sections** (Habits, Quitting, Archived), so group sections are one more way to split it.

**What gets added when groups ship** (from the day-structure report, kept):

1. **A chip row** under the range control: "All · Health · Work…". Picking a group filters the overview, the numbers and the rows.
2. **The Habits section splits by group**, each with a summary line in its header: "Health · 24 of 30 · 80%".
3. **A "Groups" section** when All is selected: one horizontal bar per group showing its rate for the period, sorted by the person's group order. **Not sorted by rate**, so nothing is ranked worst.
4. **The overall number** is the All view that already exists.

Later still: group targets and time per group. Both are small asks.

---

## 16. How every number is worked out

**The one rule:** every number reads `HabitStore` functions that already exist, or the new ones below. Nothing is computed in a view. Every past day goes through `store.rule(habit, on: day)`, so edits never rewrite history. Function names are either those in `HabitStore.swift` today or new ones proposed here, and each new one says which existing function it builds on.

### 16.1 Planned days

```swift
/// Days in `range` that count for `habit`: on or after its start, on or before today and its end and archive
/// days, and one of its days (isDue already excludes skipped and paused days and applies the rule in force).
/// Today is included only once it's met, and for a limit (atMost) only once it's over — so today never
/// counts against anyone.
func plannedDays(_ habit: Habit, in range: ClosedRange<LocalDay>) -> [LocalDay]
```

- `day >= startDay(of: habit)` means days before the start don't exist for this habit.
- `day <= min(today, habit.endsOn ?? today)`, and `day < habit.archivedOn` when it is set: the archive day itself and after don't count. `archivedOn` is new (§17.1).
- `isDue(habit, on: day)` already returns false for skipped, paused and unplanned days, and applies `rule(habit, on:)`.
- **Today:** include it only if `isDayMet(habit, on: today)` and the habit is not `atMost`.

### 16.2 The outcome of one day

```swift
enum DayOutcome { case done, part(Double), notDone, neutral }
func outcome(_ habit: Habit, on day: LocalDay) -> DayOutcome   // built on dayMark(_:on:)
```

It maps the existing `DayMark`:

- `.done` → done.
- `.some` → part(fraction).
- `.missed` → notDone.
- Everything else → neutral.

The fraction is `min(dayProgress / dayGoal, 1)` for build habits. Cut-down has no part.

### 16.3 Period habits (shapes F, G, H, I-period)

- **They never make a "not done" day.** `dayMark` already returns `.open` or `.notItsDay` for a day with nothing logged. Keep that.
- **They are judged per period:**

```swift
func periodResults(_ habit: Habit, in range: ClosedRange<LocalDay>) -> [(period: ClosedRange<LocalDay>, met: Bool?, value: Double, goal: Double)]
```

  - `met` is true or false for periods that ended.
  - For the current period, `met` is true once `isPeriodMet(habit, on: today)` is true, and `nil` before that. `nil` means in progress: not counted.
  - `value` is `periodCount` or `periodTotal`, which exist today.
- **Pace** (G, I-period): `goal - value` "to go" (or "used" for limits), and the number of days left in the period, including today.

### 16.4 The overview's day

```swift
/// One day across `habits`: planned build and cut-down habits whose day is judged (shapes A–E, I-day), plus
/// period habits only on days they were logged (they add to planned and to done that day, never to not done).
func dayScore(on day: LocalDay, habits: [Habit]) -> (done: Int, part: Double, planned: Int)
```

- **A ring's fill** = `(done + part) / planned`. Part credit shows in the ring only.
- **Today's ring shows progress so far**, including habits not finished yet (as the Today calendar sheet does). The tiles count today only for what is done.
- **"Done" in the tiles** is the sum of `done` over the period. It never includes part.
- **"Planned"** is the sum of `planned` over the period, up to today.
- **The percentage** = done ÷ planned. It is shown only when planned > 0 and done > 0.
- **Several times a day counts each time** (dayGoal 3 → 3 planned), as the ⓘ sheet says (§7.5). This matches the overall day score a HabitNow reviewer describes (`5f859344-d082-4af9-8a15-d1713f702e6d`).
- **Full days**: days where `planned > 0 && done == planned`.
- **Quit habits and tasks are never in `habits`.**
- **Cut-down habits join a day's ring only once that day is over**, as within the limit (done) or over it (not done). Today's ring doesn't show them, because a limit has nothing to fill.

> **Change to one existing function.** Today's `daySummary(on:)` counts `perWeek` habits as due every day and not done until their week is met. That is the exact behaviour behind the Habitify 1★ quoted in §5. `daySummary` feeds the Today day bar and the calendar sheet. It should be **replaced by `dayScore`**, so the day bar, the calendar sheet and Progress agree (one definition, as its own comment says). This changes what Today's day bar shows on days when a weekly habit is still open: it stops counting it. **The same problem is in Today's "N left" and the routine player** (the user, 30 Sep 2026). Both use `isSatisfied`, which for a "3 times a week" habit stays false after today's tick until the week is met, so the row stays "left" and the player's segment stays unfinished. The fix: a weekly or monthly goal is done *for the day* once something is logged that day, or once its period is met. On a day with nothing logged it is still open today, but it never counts against past days. Build Plan #60a; update the day-bar and player UI tests.

### 16.5 Streaks, best and runs

```swift
struct Run { let start: LocalDay; let end: LocalDay; let length: Int; let unit: StreakUnit; let isCurrent: Bool }
func runs(of habit: Habit) -> [Run]
```

- `runs` walks the days exactly as `bestStreak` does today: the same period stepping, pauses and rule handling.
- `bestStreak(of:)` becomes `runs(of:).map(\.length).max() ?? 0`.
- The current run must equal `streak(of:asOf: today)`. A test checks this on every golden case.

So **"best" can never exceed the total**, and never disagrees with the list. Users caught apps doing both (`5aaabc5f-54b7-492a-91a4-f04161a41031`, `e24e107c-2cc4-4f7b-86f4-885f0f79665d`).

### 16.6 The 30-day rate (the forgiving measure)

For a day `t`: done ÷ planned over the days `t−29…t`, using `plannedDays` and `outcome`. It is plotted weekly in the All range, and it is only for day-based habits.

- **Why this, not an exponential score** (users show): the forgiving idea is loved, and Loop's score draws praise such as `0574e834-b8fa-4a60-8bea-3e330ed3ed52` and `4bca591b-5718-49b5-974e-343f3705aa3a`. But its formula is misread constantly (67 confusion reviews for Loop), for example "из 60 дней у меня 60 подтверждений, но процент 95" (Loop, `3ef4af91-987f-4760-8860-50564f99e9bc`, Russian: *60 of 60 days done, but the percent is 95*).
- **A 30-day window forgives the same way:** one miss moves it by about 3%, and it can be checked on the calendar.
- The ⓘ text: "Of the planned days in the last 30 days, how many were done."

### 16.7 Totals and averages

- **Total** = the sum of `Entry.value` over the range, step entries excluded (`stepID == nil`), with `rule` units respected (§18). While a timer is running, today's total includes it as of when the snapshot was taken.
- **Average a planned day** (C, D) = total ÷ the number of planned days.
- **Average a period** (F, G, I-period) = the total over finished periods ÷ the number of finished periods.
- **Best day or period** = the highest value, with its date. For cut-down it is the "Highest day" and "Lowest period".
- **Time** is stored in minutes and shown as "1 h 30 min", never as a decimal (§9.3).

### 16.8 Quit numbers

```swift
struct QuitRun { let start: Date; let end: Date?; let endedBy: Ending }  // Ending: .slip, .pause, .ongoing
func quitHistory(of habit: Habit, now: Date = .now) -> [QuitRun]
```

- It generalises `quitRuns`, which already walks the same edges. `quitRuns` then reads from it.
- **Clean days in a range**: local days in the range, on or after the start, with no slip and not paused.
- **Slips in a range**: slip entries whose `day` is in the range.
- **Average run**: the mean of runs with `endedBy == .slip`.

### 16.8a By weekday

For each weekday: the done share of the planned days that fall on it, or the average value on them. It is shown only when there are 28 or more planned days in the range.

---

## 17. Changes needed in the model

Each change is small, and each one is needed for a number above to be right.

| # | Change | Why | Where |
|---|---|---|---|
| 17.1 | **`archivedOn: LocalDay?` on `Habit`**: set to the archive day on Archive; from that day on, the habit has no planned days. **On Restore, save the archived stretch as a pause** (`HabitPause` from `archivedOn` through yesterday), then clear it. | Without it, an archived habit either disappears from past overviews, which rewrites history, or counts forever. Restoring must not turn the archived days into "not done". Ledger C041 and C034 (history kept); users show rewritten history is the worst failure. | `Habit.swift`, `HabitStore.archive/restore`, the Kotlin core schema, a migration and `RecordMapping` |
| 17.2 | **A limit day is judged only after it ends.** In `dayMark`, `isDone` and `streak`: for `atMost` habits, today is `.open`, or `.some` when something is logged. It is never `.done`. The streak counts today only after it ends. | Otherwise every morning a cut-down habit reads as within its limit before anything happens, and its streak is one too high. | `HabitStore.dayMark`, `streak`, `bestStreak`/`runs` |
| 17.3 | **`dayScore(on:habits:)` replaces `daySummary(on:)`** (§16.4). | Period habits must not count as not done every day. One definition for the day bar, the calendar sheet and Progress. | `HabitStore`, `DayBar.swift`, `TodayView.swift` |
| 17.4 | **`runs(of:)`** (§16.5). `bestStreak` reads from it. | The run list, best and current always agree. | `HabitStore` |
| 17.5 | **`quitHistory(of:)`** (§16.8), plus **"Log a Slip…"** saving an `Entry` at the chosen moment (§10.4). | The run history, slip count and slip list. Ledger C308. | `HabitStore`, `QuitRow`, the habit page |
| 17.6 | **A change counter** (`dataVersion`), bumped by every write. | The Progress cache key (§20). | `HabitStore.perform` |
| 17.7 | **Shared views**: `DayRing` (taken out of `DayBar.dayButton`), `DayMarkView` (taken out of `HabitMonthView.cell`) and `DayDetailRow` (used by the Day sheet and the calendar popover). | One drawing of each mark; no second definition. | a new `Shared/` folder |

---

## 18. Edge cases

| Case | What happens | Rule or evidence |
|---|---|---|
| A habit made today | The row says "Started today" and today counts once done. | §16.1 |
| A start date in the past (backfilled) | It counts from that date, with past days judged like any other. | `startDay(of:)`. Users want to set an earlier start: ledger C010, and "I can't manually add previous streaks" (Avocation, `ed54f1b5-3a70-4751-a1d3-49e963db7def`) |
| A start date in the future | The row says "Starts Mon 6 Oct". It is left out of every number. | — |
| An end date | No planned days after it. The row stays for periods that include its days. | `endsOn` |
| Archived | Counted up to `archivedOn`. Listed under Archived for periods with its days. | §17.1 |
| Restored after archiving | The archived stretch is neutral, like a pause. | §17.1 |
| Deleted | Gone from everything, including past overviews. The delete dialog already says the history goes. | Already built (tombstone) |
| Paused days | Neutral everywhere. A week or month with a paused day can't break the streak. | Already built |
| Skipped days | Neutral everywhere. | Already built. Users show that skipped days lowering the rate is a complaint: "My score gets below 50% even though it was supposed the be a skipped day." (everyday, `f4dca8bc-b603-4987-a86d-d6629ba16aa5`) |
| Goal raised or lowered | Past days are judged by the old goal. The chart's goal line steps, with a footnote. | `rule(habit, on:)`. Users show: `f18d2f4d-6631-492f-b273-874ef47fdfe2` (Loop, Czech, paraphrased: raising a goal changed past stats) |
| Frequency changed (for example daily → 3 a week) | Days before the change stay judged daily. Weeks after it are judged as weeks. The streak restarts only when the kind of period changes (already built). The range uses the latest shape; a footnote gives the change date. | `rule`, `editRestartsStreak` |
| Unit changed (km → miles) | The total adds only entries in the current unit. Footnote: "Counted in miles before 3 Sep." | `HabitRule.kind` holds the unit |
| Several times a day with times-of-day slots | Progress is capped at the slot count (as `dayProgress` does). Each slot counts in "times". | Already built |
| A timer running now | Today's total includes it up to when the screen last refreshed. | §20 |
| Over the goal | The day is done. Totals include the extra, and the bar goes past the goal line. The rate never goes above 100%. | Users show: "the option for a double tick for days when you over achieve your goal" (Goal Tracker, `4af1a74e-d38c-4674-9d17-339b1acdfad1`) |
| A flexible habit done on more days than needed | Extra days count as done days. The week is met. Nothing is marked "not done". | §16.3 |
| Cut-down with nothing logged all day | Within the limit, once the day is over. Counted under "days with none". | §11.2 |
| Quit habit paused | The run ends (kept as a run). Paused days are blank. The clock shows "Paused". | Already built |
| A quit slip logged later for an earlier moment | Saved at the chosen moment. Runs are recomputed. | §10.4 |
| Day end after midnight | Everything uses `LocalDay` from `store.today()` and `Entry.day`. | Already built |
| Week start changed | Every week range moves at once. Streaks by week are recomputed from the entries. | `store.period(.week, …)` |
| Time zone change | No effect: days are stored as local days on the entry. | `Entry.day` |
| Daylight saving and 29 Feb | No effect: dates are `LocalDay` (calendar days), not 24-hour steps. | Ledger C038 (Certain) |
| A new year | Year numbers restart. Past years stay one ‹ away. | §14 |
| A period before any habit existed | ‹ is disabled. | §7.1 |
| A range with nothing planned | "Nothing was planned this week." | §7.8 |
| Only quit habits | No overview; the Quitting section only. | §7.2 |
| Very long history (years) | The grids draw with `Canvas`. The data is cached per range (§20). | Ledger C303, C083 |
| 30+ habits | The list is lazy. The week strip still fits. The month and year strips draw with one `Canvas` per row. | Ledger R86 (one-page-per-habit doesn't scale) |
| Large Dynamic Type | Tiles wrap to two lines. Past accessibility sizes, strips give way to a text summary (§21). | §21 |
| A habit's name at the 24-character limit | Wraps to 2 lines in rows, like Today. | `TextLimit` |
| Notes on a day | Shown in the Day sheet and the popover, read-only. | Notes are never prompted and never change progress (already a rule) |

---

## 19. Exact copy

Plain words, the app's existing vocabulary, and **never** "due", "overdue", "missed", "failed", "fail", "bad", "relapse" or "minimum" (the design rules, plus this report).

| Where | Text |
|---|---|
| ≡ menu row (exists on `sidebar`) | "Progress", `chart.bar.xaxis` |
| Screen title | "Progress" |
| Range picker | "Week", "Month", "Year" (the habit page adds "All") |
| Period titles | "This week", "Last week", "22–28 Sep", "September 2026", "2026", "All time" |
| Overview header | "Overview" + ⓘ |
| Tile captions | "Done", "Done · 84%", "Full days", "Weekly goals met", "Monthly goals met", "Goals met" |
| Last-period line | "Last week: 31 of 42", "August: 70 of 88", "2025: 812 of 990" |
| Section headers | "Habits", "Quitting", "Archived" |
| Archived footer | "Archived habits count for the days before they were archived." |
| Row states | "so far", "Started today", "Starts Mon 6 Oct", "Paused until 12 Oct", "Paused", "Nothing planned this week" |
| Day sheet | Title: the date, for example "Wednesday 24 September". Summary: "5 of 6 done · 1 part done". Button: "Show on Today". Empty: "Nothing was planned on this day." |
| Mark names (legend, VoiceOver) | "Done", "Part done", "Not done", "Not done yet", "Skipped", "Paused", "Not one of its days", "Coming up", "Before it started" |
| ⓘ sheet title | "How It's Counted" |
| View options menu | "Show Percentages", "Show Streaks" |
| Habit page: total line | "213 days done since 12 Mar 2025", "1,204 km in all since 12 Mar 2025", "Goal met 31 weeks since 12 Mar 2025" |
| Habit page section titles | "Over Time", "Year", "Runs", "By Weekday" |
| Over time tiles | "Done", "Longest run", "Skipped", "Paused", "Full days", "Part done", "Total", "Average", "Goal reached", "Best day", "Longest day", "Steps", "Periods met", "Times", "This week" / "This month" / "This year", "Best week" / "Best month", "Days reached" |
| Pace | "18 km to go · 9 days left", "Reached on 24 Sep", "38 of 60 so far · 9 days left" |
| Footnotes | "Goal changed from 30 to 45 min on 15 Sep.", "This habit started on 12 Mar.", "Counted in miles before 3 Sep." |
| 30-day rate | Title "30-day rate". ⓘ: "Of the planned days in the last 30 days, how many were done." |
| By weekday caption | "Most often done on Mon and Wed." |
| Runs | "40 days · 3 Mar – 11 Apr 2026", "22 days · 1 – 22 Jul 2026 · now", "Show All" |
| Cut-down | "Avg 4.1 a day · limit 6", "Within the limit", "Days with none", "Highest day", "Down from 5.1 a day in August", "Up from 3.8 a day in August" |
| Quit | "This run", "Best run", "187 clean days since 2 Jan 2026 · 5 slips", "Next: 14 days · in 2 days", "Slips", "Clean days", "Average run", "Runs", "Reached: 1 day (3 Jan) · 7 days (9 Jan)", "Log a Slip…" |
| Empty state | "No Progress Yet" / "Add a habit on Today and its progress shows here." |

---

## 20. Speed

The app's speed rules apply to every screen. This screen is the heaviest one yet: years of days × many habits.

| Rule | How |
|---|---|
| **Numbers are worked out when data changes, never while drawing** | A `ProgressModel` (`@Observable`, owned by `ProgressScreen`) holds one snapshot per key `(scope, range, period, dataVersion)`. Views read the snapshot only. The same cache serves the habit page's Over Time and Year sections, keyed per habit. |
| **Only what's on screen is computed** | The Year grids are computed when Year is chosen, and the habit page's Year when that section appears. Past periods are computed when navigated to, then kept in the cache (up to a few dozen snapshots). |
| **Grids are drawn, not built from views** | Month strips and year grids use one `Canvas` per row. 365 SwiftUI circles × 20 rows would be 7,300 views. |
| **Lazy lists** | `List` rows are created on scroll. The week strip is 7 small views per row, which is fine. |
| **No ticking around the screen** | Quit rows show days and hours from the snapshot, refreshed by a minute tick that uses Today's pattern (`@State` time moved on by a `.task` that sleeps). The only per-second view is the quit clock tile on a quit habit's page, in its own `TimelineView` anchored at the run's start. |
| **Covered means not drawing** | Progress is pushed on Today's `NavigationStack`. Check with `[ios-perf]` that Today doesn't redraw underneath. If it does, use the same covered flag as the routine player. |
| **Read one habit's entries** | Everything goes through `entries(of:)` and the by-day cache, never through the whole entry list per day. This is already the rule. |
| **Off the main thread only if needed** | Start on the main actor with caching. If `[ios-perf]` shows Progress taking over 100 ms to open with a year of data for 30 habits, move the snapshot build to a background task on copied values (`Habit` and `Entry` are `Sendable`). |

**Measure** (the CLAUDE.md rule: on GitHub, never the MacBook):

- Extend `PerformanceUITests` to open Progress, switch Week → Month → Year, open a habit page and scroll to its Year, all with **two years of history across 30 habits**.
- Push with `[ios-perf]` and read `ci-results/latest.md`.
- **Targets:** Progress opens in under 300 ms. Switching range takes under 150 ms. SwiftUI redraw stays under 10% while scrolling.

Ledger C303 (check-in latency must not grow with history) and C083 (performance must not degrade with habit count, Certain, 16 apps) are why this matters.

---

## 21. Accessibility

Ledger C171 is Certain (26 apps).

| Part | VoiceOver and other support |
|---|---|
| Day ring | One element: "Wednesday 24 September, 5 of 6 done". The hint says it opens the day. |
| Week strip in a row | The whole row is one element: "Read. 4 of 5 days. Monday done, Tuesday done, Wednesday not done, Thursday done, Friday part done, Saturday coming up, Sunday coming up." |
| Month strip and year grid | Hidden from VoiceOver. The row's label summarises them instead ("18 of 22 days in September"). The year grid gets an `accessibilityChartDescriptor` so the audio graph works. |
| Charts | Swift Charts' built-in accessibility, plus `accessibilityChartDescriptor` with the axis titles and units. Values are read as "18.7 kilometres", never "18.7". |
| Tiles | "Done, 38 of 45, 84 percent". |
| Colour | **Every state differs by shape** (fill, ring, dashed ring, sign, blank), so colour-blind users can read it. A HabitNow user with red-green colour weakness found its stats unreadable (`2834a251-dd15-49fe-ba6e-0587a4dffba8`, German, paraphrased). Marks keep at least 3:1 contrast against the background in light and dark mode. Quit and zero-goal states stay readable in dark mode (Quit Habit Decision #5). |
| Dynamic Type | Tiles grow and wrap. From `.accessibility1` up, the week strip turns into text ("4 of 5 days") and month and year strips are hidden: the numbers carry the meaning. |
| Tap targets | 44 × 44 pt at least. That is why a year dot isn't tappable: the month column is the target. |
| Reduce Motion | No ring-fill animation; values appear directly. |

---

## 22. Every statistic is free

**Nothing on Progress or the habit page is paid, and all history is readable forever.** That includes archived habits, and habits past the free limit if a Plus purchase ever lapses.

**The evidence (users show, strongest first):**

| Evidence | Numbers |
|---|---|
| Stats paywalled (this corpus) | 345 reviews in 58 apps, mean 2.87★, 44.6% at 1–2★ |
| Stats removed | 166 reviews in 30 apps, mean 2.64★, 50% at 1–2★ |
| History lost | 220 reviews in 52 apps, mean 2.65★ |
| Ledger C234: statistics stay readable on the free tier | Strong, 13 apps |
| Ledger C001: never move a free feature behind the paywall | Certain, 37 apps |
| Ledger C176: never let fear of losing history be the reason people pay | Certain, 11 apps |
| Ledger C193: a lapsed subscriber keeps read-only history | Certain, 8 apps |
| Ledger C262: never gate a recovery action | Certain, 8 apps |
| Ledger C236: never silently stop a visible progress signal | Certain, 18 apps |

**In their words:**

- A Grit reviewer finds the free version useless because even seeing their progress costs money (`13636020247`, French, paraphrased). Ledger R25 collects seven such reviews: for someone at rock bottom, free statistics are the motivation.
- Roubit put its weekly report behind the paywall and drew a run of complaints (`050f63ce-e08b-4d2c-9dff-f3322d019e84`, `2298baa2-5026-4ffa-882b-44acad46904d`, `c362fc63-6e3c-45b5-95d2-887d9eabaaf7`).
- A calendar app removed its month view in an update and got a 1★ burst (Habit Tracker Unlimited: `8d47a518-29b0-4d92-9d1a-7b6beedc841e`, `eec3579f-51e9-494d-a31d-bfc5661030a2`, `6a763e0d-cfe5-4d2d-bc5d-014514f05ef0`).
- Avocation sold "advanced statistics" that turned out to be a calendar: "App says advanced anlaytics with purchase, but its the same." (`9951fcde-32de-4965-9670-9ab931eb0bad`). Also `12680052718`. Ledger C218 and C078: never sell a stats feature that isn't there.

**Counter-evidence, stated:** the ledger marks weekly, monthly and yearly reports (C011) as *Contested*. They are the top stated reason to pay in Habit Tracker (ledger R01-013, for example `11309506354`). So stats *can* sell. But in that same app, locking yearly stats before year end produced its worst month (ledger R01-057). Across the category, gating stats costs far more rating than it earns. The app's model is a one-time Plus purchase with a habit cap, and this report keeps Plus away from statistics. If Plus ever needs more value, the ledger points to widgets, themes and sync (C107, C013), not to seeing one's own record.

---

## 23. What not to build

| Don't build | Why |
|---|---|
| **An unexplained score** (an exponential "habit strength" as the headline) | 253 confusion reviews. Loop alone has 67. "Obwohl ich Mathe und Statistik mag, sind die Statistiken in dieser App zu Beginn richtig Hardcore" (Loop, `7a291ab3-c451-40ad-a686-de0370dece54`, German: *even though I like maths and statistics, the stats in this app are hardcore at first*). The 30-day rate keeps the forgiving idea in a form anyone can check. |
| **Weighted habits** in the overall number | Asked for by a few people (Awesome Habits, `13325152566`; HabitBull, paraphrased: "priority" weights). It adds a setting to every habit and makes the number impossible to check by eye. Reasoned from first principles against ledger C006 (stay minimal, Certain). |
| **Red marks, down arrows or "worst" rankings for build habits** | §5 guilt evidence, C095 (Certain). A Tappsk user found its productivity arrow "ОЧЕНЬ ДЕМОТИВИРУЕТ" (very demotivating) (`10957454552`). |
| **"Longest gap"** or any stat that measures a person's worst stretch | One ask (`cadc79f8-180d-4536-9d9f-52412d26f8a1`). It turns a history into a record of failure. |
| **Badges, trophies or an achievements wall** for build habits | C101 (Certain, 21 apps) is split: 10 apps positive, 9 negative. MyRoutine users complain that badges fill the first page where the monthly statistics should be (`aa5005d3-b5c7-4a40-9155-d3a0bef2c9d0`, Korean, paraphrased). Totals and runs carry the same pride quietly. Quit habits get their milestone line (§10), which that evidence supports. |
| **Pie or radar charts** | A pie is asked for by a few, but the stacked count bar (§8.3) reads better. A radar chart was called inaccurate (Qhabit, `c725df30-bce7-4828-900f-04118bd34ab2`). |
| **Sentences instead of visuals** | "Reading a sentence about my progress doesn’t feel as rewarding as seeing a visual tracker" (Atoms, `11052153505`). The copy here is labels and short lines, never a narrative summary. |
| **A chart builder or configurable cards** | Most users found them confusing (ledger R86). |
| **A button that resets a habit's statistics** | Asked for once (`8916a30d-61f1-491b-ac20-50085f3bdb62`). Progress never deletes. To start fresh, archive the habit and make a new one. Its history stays. |
| **Custom date ranges** | Week, Month, Year and All plus ‹ › cover what is asked. A range picker is clutter on a calm screen. Revisit if asked for. |
| **Stats per time of day** | Small demand, and two users say such stats get in the way (Day Structure report §1.11). |
| **Mood or cause correlations** | The app records no mood. A note's text isn't data. Patterns asks (179) are served by By Weekday. |
| **Export from Progress** | Export is its own Build Plan item (ledger C020, Strong, 35 apps). When built, it lives in Settings, not on this screen. |
| **Per-step routine timing** | Loved in RoutineFlow (`3415197c-8655-443b-b3dc-f17d0e32c624`), but the routine player doesn't store step times. It is a separate, later item. |
| **Social comparison or leaderboards** | Not asked for in stats reviews, and against the calm, private positioning (C178, Certain). |
| **Any stat that changes data** | §5. Progress only reads. |

**People who want no stats at all** (users show): "No graphs, no dates, no calendar. Just what I want nothing more nothing less." (TheFor, `d2c3b799-af3b-4ada-91ae-4a73fd57eced`). Also HabitMinder, in Chinese, asking the developer *not* to add a calendar of missed days (`4284181386`). Two Avocation users see it the same way: one praises having no streaks and no constant statistics, because that adds no pressure (`0750ad9a-be8f-4e22-ace4-f23c64f59cf2`, German, paraphrased); another finds it unhealthy to want a day count to feel proud of (`8adb668a-f1ba-453f-862f-195fb58fd744`, Russian, paraphrased).

**That is why Progress is a separate screen that Today never shows by itself, and why percentages and streaks can be hidden.** Nothing on Today changes for someone who never opens it.

---

## 24. Every relevant ledger card, and where it is answered

**How to read this:**

- The 1,604 cards read belong to **254 canonical points**. **96 of them bear on progress**, and each one is answered below.
- The "Cards" column counts the cards read for this report that are attached to the point. Confidence and apps are the ledger's own.
- Points merged into another in the ledger (C158 into C216, C243 into C038, C192 into C193, C259 into C075) are answered with the point they merged into.
- The other 158 points are about pricing, sync, reminders, onboarding, widgets and the like. They are listed at the end so that none is silently dropped.

### 24.1 Built on this screen or the habit page

| Point | Ledger | Cards | Answer |
|---|---|---|---|
| **C012** Week / month / year grid views | Strong · 36 apps | 107 | Week, Month and Year on Progress (§7.2). Month calendar, Year grid and Over Time on the habit page (§8). |
| **C011** Weekly / monthly / yearly reports | Contested · 34 | 90 | Any week, month or year on screen, with ‹ › to past ones, all free (§14, §22). A shareable year image is Phase 3. |
| **C038** (+C243) Dates, streaks and stats correct on every surface | Certain · 36 | 96 + 13 | One definition per number (§16). `LocalDay` throughout. Week start and day end honoured. Golden tests (§25). |
| **C024** Streaks | Strong · 38 | 91 | Streak, best and runs history (§8.1, §8.5). Hideable (§7.6). |
| **C216** (+C158) Forgiving long-run measure alongside streaks | Certain · 18 | 44 + 2 | Total days done (§8.1), the 30-day rate (§16.6), quit clean days (§10.3). |
| **C234** Statistics readable on the free tier | Strong · 13 | 22 | Everything free (§22). |
| **C256** Skip, miss and not-yet-logged visibly distinct, stats explain which | Certain · 14 | 29 | One mark set with a legend (§13). The ⓘ sheet says what isn't counted (§7.5). |
| **C217** Explain any score on screen | Certain · 8 | 20 | Every % beside its fraction. ⓘ on every section that has a number (§7.5). No opaque score (§23). |
| **C047** Cumulative totals and total-days counter | Strong · 7 | 15 | "213 days done since…" and totals in units (§8.1, §9.2). |
| **C048** Flexible units / partial progress | Strong · 25 | 37 | The Part done mark and count. Totals in the person's unit. Over-goal shown (§9, §13). |
| **C201** User-set "good day" threshold | Strong · 4 | 19 | The partial rings show partial days without a threshold. A **"Full day at 100% / 80% / 60%"** option is Phase 3 (§25). It changes only the Full Days count and the ring's filled colour. |
| **C143** Tap N times to fill N/N | Strong · 26 | 21 | Several times a day counts each time; the ring shows the fraction (§16.4). |
| **C254** All-habits overview (one tap) | Strong · 8 | 14 | The Progress overview and rows (§7). One tap from Today. Check-off stays on Today (§6.2). |
| **C019** Quit mode with a relapse record and non-punitive reset | Strong · 30 | 75 | §10. |
| **C308** Logging a lapse ≠ destroying the count | Moderate · 2 | 8 | "Log a Slip…" as an event. Clean days total never drops (§10.3, §10.4). |
| **C309** Quit belongs inside the habit app | Moderate · 1 | 5 | Quit habits share Progress, in their own section (§10.2). |
| **C100** Money saved | Moderate · 3 | 4 | Phase 3, needs a cost field (§10.5). |
| **C101** Milestones and celebration | Certain · 21 (split: 10 +, 9 −) | 32 | Quit milestones as one line, no pop-ups (§10.3). Build habits: totals and runs, no badges (§23). |
| **C157** Every guilt mechanic optional | Certain · 21 | 66 | Show Streaks and Show Percentages toggles (§7.6). No red (§13). |
| **C095** Neutral tone on failure | Certain · 21 | 27 | The copy list, with banned words (§19). |
| **C043** Flexible frequency, non-scheduled days neutral in stats | Certain · 53 | 81 | Shapes F, G, H judged per period. Unplanned days neutral everywhere (§9, §16.3). |
| **C016** Skip / holiday / pause without losing history | Strong · 33 | 60 | Skipped and paused days neutral, with their own marks (§13, §18). |
| **C010** Backfill missed days / edit start date | Strong · 34 | 34 | "Show on Today" from any day (§7.4). Past start dates respected (§18). |
| **C041** Editing never wipes history | Strong · 7 | 12 | `rule(habit, on:)` everywhere. Goal lines step, with footnotes (§8.3, §18). |
| **C142** Surface features where users look | Certain · 24 | 21 | The Progress row near the top of the ≡ menu. Rows open the habit page at Over Time (§6.2, §7.3). |
| **C207** Let users hide surfaces they don't use | Certain · 9 | 7 | View options (§7.6). Progress never shows on Today by itself. |
| **C227** Graduated state (keep tracking a mastered habit) | Strong · 8 | 17 | Archived habits keep all their stats and appear for their periods (§7.7, §17.1). A "graduated" state itself belongs to All Habits, not here. |
| **C303** Latency independent of history | Moderate · 1 | 3 | §20: cache, `Canvas`, performance test with two years of history. |
| **C083** Performance must not degrade with habit count | Certain · 16 | 9 | §20: tested with 30 habits. |
| **C171** Accessibility stack | Certain · 26 | 11 | §21. |
| **C265** Tracker types beyond yes/no | Moderate · 2 | 8 | Each type shows its own numbers (§9). Pace for period totals. |
| **C102** Inverse mode for a counter | Moderate · 3 | 4 | Cut-down: lower is better, and the limit is never celebrated (§11). |
| **C135** Check-in tracking and auto-counting | Moderate · 1 | 4 | Quit habits auto-count (the clock). Cut-down is check-in (§10, §11). |
| **C098** Time-unit flexibility for counters | Moderate · 3 | 3 | The quit clock shows d h min s; long runs read "1 year 12 days". Totals use h and min. |
| **C032** New Year robustness | Certain · 8 | 15 | Year numbers restart on 1 Jan. Past years are reachable. A year-change golden test (§25). |
| **C170** Configurable day boundary | Strong · 21 | 18 | `dayEndHour` honoured through `LocalDay` (§14). |
| **C045** Grouping | Contested · 28 | 24 | Planned in §15, with no rework. |
| **C172** Per-day notes and journal | Strong · 44 | 27 | Notes shown in the Day sheet and the calendar popover, read-only (§7.4, §8.2). |
| **C205** Aggregated journal across days | Moderate · 3 | 3 | All Notes already exists on the habit page. The Day sheet adds the whole day's notes. |
| **C289** One "quiet mode" switch | Moderate · 1 | 3 | The two view-option toggles are the quiet mode for numbers (§7.6). |
| **C042** Aim at ADHD, neurodivergent and chronic-illness users | Certain · 52 | 31 | Part credit, no red, neutral pauses and skips, and calm defaults. Users in this corpus: "if you're dealing with ADHD or PDD like me, sometimes only" rewarding a perfect day hurts on a 3/10 day (Dear Me, `d654931f-9c4d-46c7-8270-11ce0f42bd71`); "My Adhd means I find it difficult to estimate how long a task will take." (RoutineFlow, `d3327c35-e451-4565-b660-039408de5ae4`). |
| **C103** Vulnerable users are a sensitive surface | Certain · 33 | 18 | Quit copy without "relapse" or "failed". No pop-ups on slips. No ads (§10, §19). |
| **C006** Stay minimal | Certain · 55 | 78 | One visual, three numbers and a list. Detail one level down (§6, §23). |
| **C178** A quiet, adult tracker | Certain · 23 | 27 | No badges, mascots or rewards on Progress (§23). |
| **C119** Redesigns must not regress layout | Certain · 24 | 22 | The habit page keeps every existing part; sections are only added (§8). |
| **C264** Never add a tap to logging | Certain · 12 | 15 | Progress never logs, and Today's logging is untouched (§6.2). |
| **C108** Goals / targets | Strong · 8 | 8 | Goal lines, periods met, and pace (§9). |
| **C099** Countdown / "days until" | Certain · 8 | 3 | Not a progress feature: it belongs to tasks and dates. Out of scope here. |
| **C273** A reward mechanic must never silently stall | Moderate · 2 | 5 | There is no reward mechanic. The milestone ladder never runs out: yearly after a year (§10.3). |
| **C237** The reward loop needs a content runway | Strong · 8 | 11 | As C273. Totals and runs grow forever. |
| **C052** Points and rewards | Strong · 6 | 7 | Not built (§23). |
| **C117** Mascot | Strong · 10 | 12 | Not built. |
| **C049** Mood tracker | Strong · 12 | 8 | No mood data, so there are no mood charts (§23). |
| **C259** (→C075) In-app help, legend reachable again | — | 1 | The legend and ⓘ are always one tap away (§7.5, §13.2). |

### 24.2 Rules this design keeps (owned by other items)

| Point | Ledger | Cards | How Progress keeps it |
|---|---|---|---|
| **C001** Never move a free feature behind the paywall | Certain · 37 | 53 | Nothing here is ever gated (§22). |
| **C176** Fear of losing history is never why people pay | Certain · 11 | 22 | History is always readable (§22). |
| **C193** (+C192) A lapsed plan keeps read-only history | Certain · 8 | 18 + 2 | All history is readable past the free cap (§22). |
| **C262** Never gate a recovery action | Certain · 8 | 9 | "Show on Today" for backfill is free (§7.4). |
| **C236** Never silently stop a progress signal | Certain · 18 | 19 | No caps on history depth or ranges. |
| **C133** Gate on capability, not quantity | Contested · 39 | 53 | Statistics are not one of the gated capabilities (§22). |
| **C218** Store listing and paywall copy stay true | Certain · 47 | 32 | Never advertise stats that aren't there (the Avocation lesson, §22). |
| **C078** The paid purchase trigger must work | Certain · 13 | 20 | Not paid. Tested anyway (§25). |
| **C065** Paying customers are the highest 1★ risk | Certain · 59 | 49 | As C078. |
| **C034** Data never lost | Certain · 55 | 87 | Progress only reads (§5). |
| **C175** Updates must not break function or wipe progress | Certain · 38 | 34 | Golden tests run on every `[ios-ci]` push (§25). |
| **C155** Never remove a feature people bought the app for | Contested · 22 | 37 | Once shipped, no Progress view is removed. Add alongside (§5). |
| **C104** Never ship a removal silently | Certain · 32 | 21 | As C155. |
| **C031** Crashes are the largest complaint | Certain · 60 | 53 | Performance and crash tests with years of data (§20, §25). |
| **C059** Be visibly responsive | Certain · 62 | 41 | Owned by support. Progress gives nothing to apologise for. |
| **C040** Widgets must not disagree with the app | Certain · 35 | 37 | Future widgets must read `dayScore` and `runs`, never their own counts (§16). |
| **C023** Interactive widget check-off | Strong · 35 | 39 | Separate item. The same numbers apply. |
| **C020** Data export / CSV | Strong · 35 | 81 | Separate item. It exports the same entries (§23). |
| **C007** Habit cap | Contested · 56 | 91 | Archived and over-cap habits keep their stats (§22). |
| **C219** Deleting frees a slot (concurrent cap) | Strong · 4 | 4 | Archiving frees a slot (built). Its stats stay. |
| **C191** Never shrink a tier someone holds | Certain · 11 | 10 | No stats tier exists to shrink. |
| **C296** The free tier must show the differentiator | Strong · 4 | 4 | The overview and year grid are free. |
| **C200** Never meter the completion action | Strong · 4 | 4 | Progress has no completion action. |
| **C013 / C030 / C153 / C230** Sync, backup, event log | Strong / Contested | 38 / 30 / 27 / 10 | Separate items. Progress is computed from the append-only entries, so it stays right after a sync merge. |
| **C022 / C021** Watch, Health | Strong | 48 / 31 | Separate items. |
| **C080 / C261 / C009** Colours, dark mode, palette | Strong | 32 / 13 / 37 | Marks use the habit's colour. Readable in dark mode (§21). |
| **C107** Widget variants as the paid layer | Strong · 15 | 13 | Where Plus value belongs, instead of stats (§22). |
| **C223 / C090** Visible undo; confirm destructive quick actions | Certain / Strong | 10 / 2 | The slip sheet has Undo (§10.4). Progress has no destructive actions. |
| **C160** Honour what onboarding asks | Moderate · 3 | 1 | Not applicable to Progress. |
| **C069 / C229** Check-off sound; deliberate completion gesture | Certain / Strong | 9 / 1 | Not applicable: Progress never logs. |
| **C002** Ratings follow the offer | Certain · 63 | 63 | The free, full statistics are part of the offer (§22). |

### 24.3 The other points the cards belong to (not about the Progress page)

These 158 canonical points came with cards read for this report, because those cards also mention a stats word. They are **not** about the Progress page. Each is owned by its own Build Plan item, or by pricing and support. The number in brackets is the number of cards read.

<details><summary>158 points</summary>

- **C003** (66) Lead with a one-time lifetime purchase — and keep it visibly on the shelf if a subscription is ever added beside it
- **C004** (13) Price low and fair, anchored against subscription competitors
- **C005** (48) Know which competitors buyers compare against
- **C008** (15) Daily check-in and reminders are free — never paywall the reminder
- **C014** (11) Multiple reminders per habit
- **C015** (11) Shared / group habits
- **C017** (13) Passcode lock
- **C018** (4) App-icon themes
- **C025** (5) Scholarship / hardship / discount program
- **C026** (8) Handle markets where card payment fails (RU, AR, TR, DZ, PK)
- **C027** (37) Localise early — it unlocks revenue
- **C029** (17) Billing must be exactly right
- **C033** (34) Restore purchase and entitlements must work immediately
- **C035** (11) Account system from day one
- **C036** (26) A support channel that exists, is reachable outside the app, and answers
- **C037** (9) Family plan
- **C039** (19) Reminders fire reliably, once
- **C044** (20) Mac / desktop / web app
- **C046** (16) Shortcuts / Siri / URL scheme / API
- **C050** (11) One-off to-dos alongside habits
- **C051** (4) Android version
- **C053** (3) Custom time-of-day segments
- **C054** (5) Never run incentivised / review-for-premium campaigns
- **C056** (7) Don't build AI features on demand grounds
- **C057** (6) Offer a non-pastel / premium design option
- **C058** (11) Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN)
- **C060** (5) Cross-sell an app family on brand trust
- **C061** (17) Goodwill conversion — a generous free tier and 'support the devs'
- **C062** (31) Weight English-speaking rich markets; volume ≠ revenue
- **C063** (17) Free trial before purchase
- **C064** (14) Price level — where 'fair' turns into 'too expensive'
- **C066** (12) Focus timer
- **C067** (6) Fitness / health tracking use case
- **C068** (2) Parents tracking kids
- **C070** (5) Use the language users use: Atomic Habits, 75 Hard
- **C071** (5) Never ship and walk away
- **C072** (3) Writes to shared system stores (calendar, health) must be exact and reversible
- **C073** (35) Manual reordering, renaming and editing of habits/tasks — free
- **C074** (1) Customisable, louder reminder sounds
- **C075** (28) Skippable, replayable onboarding tour and an in-app help screen — searchable FAQ and per-setting explanations for anything richer than the daily check-in
- **C076** (7) Never seed the launch rating — templated or bought reviews decay and leave the markets they cover unmeasurable
- **C077** (3) Purchase and signup flow must not leak buyers
- **C079** (7) Personal photos as habit icons
- **C082** (7) Ads in the free tier — viable only off the logging path, off the launch path and out of harmful categories, and they turn 'free' praise into the churn segment
- **C085** (17) Address tracking / privacy visibly
- **C089** (4) Promos, giveaways and gift codes must work exactly as advertised
- **C092** (5) Regional pricing
- **C093** (11) No upsell nagging without a 'never ask again' option
- **C094** (33) Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire
- **C096** (2) Privacy and discretion stack
- **C097** (12) A tip / donate option
- **C109** (9) A free trial must be a real trial
- **C110** (9) An obvious 'continue free' path on the paywall — the free/paid boundary must be legible
- **C111** (2) No long quiz before the price; show the price up front
- **C112** (2) In-app cancellation
- **C113** (4) One stable, disclosed price — no discount wheels
- **C114** (1) Ads must match the app
- **C116** (7) Content library (workouts, meditation, sleep, journal) as the paid layer
- **C118** (8) Preset routines / templates / programs
- **C120** (5) Sequential routine timer with spoken next step and live finish-time estimate
- **C123** (10) Notifications are few and finely user-controllable — per-type settings, escalation opt-in, never spammy and never silently retuned
- **C127** (9) Never show ads or upsells to anyone holding an active or historical entitlement — including cross-promotion of sibling apps
- **C130** (4) Use the lead-user market as the beta cohort
- **C132** (1) Do not sell in a storefront where the app cannot function
- **C134** (33) Lead the store listing with what users actually love
- **C136** (7) When an item can be tracked more than one way, make the user choose the mode at creation
- **C137** (5) Show the paywall at the moment of need, not on app open
- **C139** (4) Cache entitlements locally — never block a paid surface on a live server check
- **C140** (4) Market the generic-tracker use case
- **C141** (19) Native iPad layout
- **C144** (12) Habits, focus timer and journal in one simple app
- **C145** (3) Every promotional or onboarding modal must be dismissible on the smallest screen
- **C146** (1) Harden onboarding before January (merged into C032)
- **C147** (30) Let people use the product before they pay
- **C148** (1) The paid product must deliver what the ads and onboarding demonstrate
- **C150** (7) Never ask for a rating before the user has used the app
- **C152** (1) A promised pre-charge trial reminder must actually arrive — in-app, with amount and date
- **C154** (1) Compensation for lost data must match the loss — never a flat token
- **C156** (8) Content and event releases need a crash gate across device generations
- **C159** (4) Launch-to-core-action path with no interstitials
- **C162** (5) Automated suggestions from user text must be safety-filtered; notifications must be crisis-aware
- **C163** (3) Visible monthly plan — annual-default trials drive billing disputes
- **C164** (2) A random-rotation shop with paid re-rolls and unpurchasable catalogue items is a friction generator
- **C167** (1) Cosmetic and colour variety as the paid layer
- **C169** (5) Completion verification / anti-cheat
- **C173** (6) Sub-tasks / sub-routines nested inside a habit or routine
- **C177** (18) One clear SKU shelf — every plan distinctly named, stating its period, and delivering exactly what its label says
- **C181** (7) If the app is paid-only or trial-gated, say so in the subtitle, first screenshot and first screen — a free download that stops after N days is 'paid-only' to the person who hits the wall
- **C182** (8) A pre-use hard paywall makes every purchase non-evidence-based and non-durable
- **C183** (2) A pre-planned, structured day is the outcome ADHD and autistic users praise
- **C184** (1) Gendered branding narrows the audience; a neutral name is already tested
- **C185** (13) Aesthetic and a polished onboarding convert; they do not retain
- **C186** (23) Never revoke what earlier buyers paid for when the model changes
- **C188** (11) The app must open offline — never block launch on a network call
- **C189** (2) Public review replies answer the specific complaint — never canned, never argue price, never press a reviewer to change the rating
- **C190** (1) No weekly billing tier
- **C196** (2) A subscription is a promise of continued delivery — back it with a visible cadence
- **C198** (1) Edit one instance of a repeating block without changing the series; a slipped block pushes the ones after it
- **C199** (6) System calendar integration — see appointments inside the plan
- **C202** (13) A light social layer that is explicitly not a social network
- **C203** (8) Onboarding lets the user author their own routine first — suggested plans, surveys and pledges are optional
- **C204** (5) Never destroy user work at the paywall
- **C206** (1) Swappable day templates / routine modes for irregular schedules
- **C208** (4) Photo / media / URL attached to a habit, memo or diary entry
- **C209** (12) No sign-up wall before first use
- **C210** (7) Bill App Store users through the App Store — never route them to an off-store subscription the app cannot show or cancel
- **C212** (3) No conditional refunds — no proof-of-use requirement, and an advertised guarantee is honoured on request
- **C214** (16) A bare checklist or task-slot paywall cannot carry a premium price — it is compared to Reminders, Notes, alarms and paper, free on every phone, and loses
- **C222** (9) A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes
- **C224** (1) Disclose product limits in the listing
- **C225** (1) A one-off free promotion (App of the Week, partner promo) acquires durable users
- **C226** (8) App-icon badge count of outstanding habits, with an active-hours window
- **C231** (58) Audit the funnel per market and per channel — storefronts diverge on billing and funnel stage, not on the product, and written reviews are a complaint channel that under-rates it against public ratings
- **C233** (2) Content the user paid for is saveable and replayable — a library, not a stream
- **C235** (1) A first-run failure escape hatch — skip setup / continue offline, with a visible error state
- **C238** (1) A rewarded-ad unlock path for users who cannot pay (teens, students)
- **C239** (6) A personal origin story in the listing builds trust — and turns any later gate into a betrayal
- **C240** (3) Never interrupt the completion moment — no ad, upsell or rating prompt on the check-off tap
- **C242** (3) Never monetise by routing the user's device or bandwidth for third parties — and never gate first launch behind any such opt-in
- **C244** (1) Never seed the launch rating (merged into C076)
- **C245** (3) Every SKU delivers exactly what its label says
- **C246** (11) No ads in a personal habit tracker — 'no ads' is among the highest-rated topics and ads on the reward loop are the largest 1★ driver
- **C248** (4) Never show an upsell to anyone holding an entitlement (merged)
- **C249** (2) Account deletion completes in one step, in-app and on the web, and is confirmed — never a spinner or a silent chatbot
- **C250** (1) Marketing e-mail needs consent and a working one-tap unsubscribe — never e-mail dormant or deleted accounts
- **C251** (5) If cross-platform is what people buy, ship every platform in parity — same release, same entitlement, or a visible 'coming' state
- **C252** (1) Complete a habit from the notification — an actionable reminder is part of the one-tap loop
- **C253** (2) Notification restraint
- **C255** (3) An in-app language selector that respects the user's choice — shipping a localisation must never trap someone in a language
- **C258** (2) A 'nag until done' repeating reminder — the one reminder shape reviewers say no other app offers
- **C260** (1) Never argue price in a public review reply
- **C263** (6) An AI encouragement reply on each check-in as the premium hook — the first paid feature reviewers praise unprompted; its state must be visible
- **C266** (2) A generated programme escalates on observed completion, never on a fixed calendar — and never past what a health limit the user declared allows
- **C267** (2) No AI-generated art, copy or content in a paid product — reviewers accept an AI coach and reject AI decoration
- **C268** (4) Journal / notes prompts are optional — a toggle to stop the post-completion journal prompt, and a text editor that never corrupts input
- **C271** (2) One membership at one price across every platform the app ships on — never sell the same entitlement twice or price it differently by store
- **C275** (1) Never gate the core create action behind an ad — an interstitial at setup is the churn engine, and an ad that fails to load must never block creation
- **C276** (1) An optional event time (and duration) on a task or habit, distinct from its reminder, with the day sorted by it and shown on the widget
- **C277** (2) Price the paid tier against what the phone gives away
- **C278** (7) Do not name the app after an established competitor — a name collision makes the product 'the fake one' before it is tried, and the cost cannot be measured from reviews
- **C282** (1) A generated plan belongs to the user — it persists, every assigned task can be deleted, declined and reordered, and it is built around the user's fixed commitments
- **C285** (1) A paid add-on is never bought on a single tap — its own price on the button, its own confirmation (never the trial's stored authorisation), 'no thanks' by default and worded neutrally, repeat taps ignored, and a clear way to turn it off
- **C288** (1) A user who declined notifications at first run must have an in-app way back — detect the denied state, explain it, and deep-link to iOS Settings
- **C290** (1) Guide every new goal down to something doable on a bad day — a setup that asks 'can you really do that in 5 minutes?' is a feature users thank
- **C291** (2) A way past the free cap that is not a payment (referral, invite, earned unlock) only works if it is shown at the wall — audit whether capped users can see it
- **C293** (2) Raising a free habit cap by a couple of slots does not buy back sentiment — the objection re-forms at the new number; change what the cap gates or when it is hit, and instrument it
- **C294** (2) When the pricing model changes, the historical review corpus keeps advertising the old one — state the current model on the listing and paywall, and honour every old receipt automatically
- **C297** (2) A free cap's acceptability is set by the bundle around it — the same number reads as generous or as a wall depending on what else is free; moving a loved feature behind the wall changes sentiment as much as changing the number
- **C298** (3) A public roadmap converts — and becomes a promise users hold you to
- **C299** (2) Never attach an app subscription to another product's checkout by default — the subscription is its own opt-in line with its own amount, period, renewal date and final-total confirmation, and a 'book only' choice must never produce a recurring charge
- **C300** (6) A headline star rating that sits far above its own written reviews is a signal to audit, not a satisfaction figure — find where and when star-only ratings are collected before trusting them
- **C301** (2) The support form and account deletion must not live behind the surface most likely to break — a tab outage must never take the reporting and exit paths down with it
- **C302** (2) A premium currency must have a slow, honest earned path — a currency free players cannot earn turns free-core goodwill into 'pay-to-win' and rewards lying
- **C304** (1) A discounted offer shown during or after a purchase must replace and refund the first purchase, visibly — never stack a timed second offer on a completed one
- **C305** (2) Say 'one-time, not a subscription' wherever a one-time price appears — a buyer who mistakes it for a subscription reviews it as one
- **C306** (5) Third-party ad code never sits on the launch path — the core surface renders first and any ad failure fails open
- **C307** (2) In a recovery or addiction app, exclude gambling, alcohol, tobacco and vaping ad categories — and verify the exclusion per storefront
- **C310** (1) A low request count for a feature the market leader already ships measures satisfaction with that implementation, not demand for the feature

</details>

---

## 25. Build phases and tests

### 25.1 Phases

Each phase is shippable on its own, and no phase removes anything an earlier one added.

**Phase 1: the overview and every type's numbers** (what people ask for most)

1. Model: §17.1 (`archivedOn`), §17.2 (limit days judged at the end), §17.3 (`dayScore`), §17.4 (`runs`), §17.6 (`dataVersion`), §17.7 (shared views).
2. `ProgressScreen`: Week and Month, the overview with its rings and three tiles, the last-period line, the Habits and Archived sections with week and month strips, the Day sheet, the How It's Counted sheet with the legend, view options, and the empty states. It replaces the "coming" page in the ≡ menu's `MenuPage`.
3. Habit page: the total line (§8.1), the calendar popover (§8.2), and Over Time for shapes A–I with Week, Month, Year and All, including cut-down's change line.
4. Tests (§25.3) and the performance test (§20).

**Phase 2: the long view and quit**

1. Year on Progress, and the habit page's Year grid, both with `Canvas`.
2. Runs (§8.5), By Weekday (§8.6), and the 30-day rate in All (§16.6).
3. Quit: "Log a Slip…" (§10.4), `quitHistory` (§17.5), the Quitting section, the live clock tile, the runs chart, the slips list and milestones (§10.3).

**Phase 3: options and groups**

1. **Full day at 100 / 80 / 60%** (ledger C201). It lives in view options and changes only Full Days and the ring's filled colour.
2. **Money saved** for quit habits (§10.5).
3. **A shareable year image** (Year range ▶ Share). It is rendered with `ImageRenderer` and shared with `ShareLink`, free. Users ask for this: a TickOff reviewer wants a picture reviewing the whole year (`a440892d-d994-4147-8cdc-b0d728f9a512`, paraphrased). It must pass a year-end crash test (ledger C032).
4. **Groups** (§15), when groups ship.

### 25.2 Golden cases (exact expected numbers)

The fixed "now" is **Friday 26 September 2026, 12:00**. Week start is Monday and the day ends at 0:00 unless the case says otherwise. The week is Mon 22 – Sun 28 Sep.

| # | Setup | Expected |
|---|---|---|
| G1 | **Read**, check once a day, starts Mon 22. Done Mon, Tue, Thu. Wed skipped. Fri nothing yet. | Row: "3 of 3 days so far · 100%". Marks: done, done, skipped, done, open (today), coming up, coming up. Streak 3, best 3. Overview: Read adds 1 planned and 1 done on Mon, Tue and Thu; nothing on Wed or Fri. |
| G2 | **Gym**, 3 times a week. Done Mon and Wed. | Row: "2 of 3 so far". No "not done" mark on any day. Overview: +1 planned +1 done on Mon and on Wed only. Tile 3: "0 of 1", caption "Weekly goals met so far". |
| G3 | **Water**, 8 glasses a day. Thu 5, Fri 6 (today). | Thu: part (0.625); it counts 1 planned, 0 done, and 1 in "Part done". Fri: the ring shows 6/8 progress, but the tiles don't count it until it reaches 8. |
| G4 | **Coffee**, cut down, limit 3 a day. Wed 4, Thu 0, Fri 2 (today). | Wed: over (▲). Thu: within, and "Days with none: 1". Fri: open ("2 of 3 so far"), not counted. Streak "within the limit": 1 (Thu). |
| G5 | **Meditate**: 10 min until 14 Sep, 15 min from 15 Sep. Sun 14 Sep 12 min; Tue 16 Sep 12 min. | 14 Sep done; 16 Sep part (0.8). The chart's goal line steps from 10 to 15 on 15 Sep. Footnote: "Goal changed from 10 to 15 min on 15 Sep." |
| G6 | **Stretch**, created Thu 25 (daily). Done Thu. | Mon–Wed are "Before it started" and appear in no number. Thu counts 1 of 1. The overview for Mon–Wed is unchanged by this habit. |
| G7 | **Run**, daily, paused Tue–Thu. Done Mon; Fri not yet. | Tue–Thu paused (neutral). Streak kept at 1. Row: "1 of 1 days so far". |
| G8 | **Journal**, daily, done Mon and Tue, archived Wed 24. | Counts Mon and Tue only (planned days before 24 Sep). Listed under Archived this week. Next week it isn't listed. |
| G9 | **Smoking**, quit, started 1 Aug 2026 09:00. Slips 3 Sep 22:10 and 20 Sep 08:00. | Runs: 33 d 13 h 10 min · 16 d 9 h 50 min · current 6 d 4 h. Best 33 d. September: 2 slips, 24 of 26 clean days. Clean days since 1 Aug: 55. Average run: 25 days. |
| G10 | **Cycle**, 60 km a month. 42 km logged by Fri 26 Sep. | "42 of 60 km so far". Pace: "18 km to go · 5 days left". Month tile 3: "0 of 1", caption "Monthly goals met so far". |
| G11 | G1 with the week starting on Sunday. | The week is Sun 21 – Sat 27. The range title reads "21–27 Sep". |
| G12 | Day ends at 3:00. Now is Sat 27 Sep 02:00 (this case's own now). A tick at 01:30. | It counts for Fri 26, and Progress's "today" is still Fri 26. |
| G13 | Year change: a daily habit started 1 Jan 2026, done every day of 2026. Now is 1 Jan 2027 at 12:00, nothing done yet. | Year 2026: 365 of 365 days (from its start). Year 2027 on 1 Jan: tile 1 shows "0", "Done so far", with no percentage. 2026 is reachable with ‹. |
| G14 | **Pills**, twice a day, starts Thu 25. Thu 1 of 2. | Thu part (0.5). Thu adds 2 planned and 1 done to the overview. Row: "1 of 2 times so far" (shape B counts times, not days). |
| G15 | **Morning**, a checklist with 5 steps. Thu 3 ticked. | Thu part (0.6). Steps 3 of 5. "By step" shows each step's own share. |
| G16 | **Run 5 km on 3 days a week**. Mon 5 km, Wed 3 km, Thu 6 km. | "2 of 3 days so far · 14 km". Wed part. No "not done" marks. |
| G17 | Best never above total | For every case: best ≤ days done in total, and the current run equals `streak(of:asOf: today)`. |

### 25.3 Tests

- **`-progresscheck`**, like the existing `-copycheck`. This launch argument seeds G1–G17 in an in-memory store with the fixed now, runs every function from §16 and shows "Progress: all checks passed" or the cases that differ. **`ProgressUITests.testProgressChecks`** reads that label.
  - Add `ProgressUITests` to the `[ios-ci]` test list in `.github/workflows/ios-tests.yml`.
- **UI tests** in `ProgressUITests`:
  - The ≡ menu's Progress row opens Progress, and Back returns to Today.
  - Week, Month and Year switch.
  - ‹ is disabled at the first period.
  - Tapping a ring opens the Day sheet, and "Show on Today" opens Today on that day.
  - Tapping a row opens the habit page at Over Time.
  - Turning Show Percentages off hides every "%".
  - The empty state appears with no habits.
- **Existing tests to update:** the day bar and calendar tests, if `dayScore` changes their counts on days with an open weekly goal. Per the design rules, labels and tests change in the same commit.
- **Performance:** extend `PerformanceUITests` as in §20, and push with `[ios-perf]`.
- **By hand, on the phone:** VoiceOver across one row, the Day sheet and a chart. The largest Dynamic Type size. Dark mode with a quit habit.

---

## 26. Limits of this research

- **The keyword screen finds people who name a feature.** Happy users rarely write about a screen that works, so every count is a floor. Praise counts are also lower than the real liking, because a stat that works goes unmentioned.
- **One reader coded every review.** The codes are auditable in `coded_reviews.tsv`, but there was no second coder. Some codes are judgement calls: `STAT` versus `CHART` versus `GEN`, and `XTHIN` versus `?CHART`. Decisions rest on themes that are large and seen in many apps, not on a single code's exact count.
- **Corpora differ in size by more than 100×.** Loop (1,736 on topic), Habit Tracker (1,290) and HabitNow (866) carry many reviews. The report counts **apps** next to reviews for that reason, as the Feature Ledger does.
- **Bursts** (§2.3) inflate generic praise in a few apps. No decision rests on those codes.
- **Translations are paraphrased.** Only English (and a few original-language) quotes are verbatim, and all of those are machine-checked.
- **The layout is reasoned from first principles and the evidence.** It hasn't been tested with people. The golden cases fix the numbers, not how the screen feels.
- **Performance targets are targets.** The `[ios-perf]` run is the judge.

---

## 27. Appendix: evidence files and cited reviews

**Files** (in [`Progress Evidence/`](<Progress Evidence/>)):

| File | What it is |
|---|---|
| `coded_reviews.tsv` | **The complete per-review index**: all 14,726 reviews read, with the row number, review ID, store, app, stars, date and codes. Any number in §3 resolves back to rows here, and any review resolves to the codes it supports. |
| `codebook.md` | Every code and what it means. |
| `theme_counts.md` | Every code's count, apps, mean ★, 1–2★ share and first review IDs. |
| `per_app.md` | For every app: on-topic reviews, mean ★, and its top praise, complaints and asks. |
| `ledger_cards_read.tsv` | The 1,604 Feature Ledger cards read, with their canonical points. |
| `ledger_reading_notes.md` | Notes taken while reading the cards, report by report. |
| `reading_notes_by_batch.txt` | Notes taken while reading each batch of 200 reviews (row numbers, not IDs). |
| `scripts/` | `screen.py` (keyword screen), `refine.py` (first clean-up), `aggregate.py` (validation and counts), `perapp.py`, `ledger_filter.py`, `verify_ids.py`, `cited_table.py` (rebuilds the table below). The scripts expect the working files in `Research/Temp/progress/`, which is gitignored; the evidence here is their output. |

**Check this report:** from `Research/`, run

```
python3 "Research Reports/Progress and Statistics/Progress Evidence/scripts/verify_ids.py" "Research Reports/Progress and Statistics/The Progress Page — What People Need, and How to Build It.md"
```

It checks that every cited review ID exists in the source `reviews.jsonl` files, that every English or original-language quote appears in its review, and that every ID in `coded_reviews.tsv` exists. The last run: **all IDs found, all quotes found** (see the table below for the count).

**App names used in this report.** Play Store folder 24 ("Habit Tracker") is **HabitBull**: its reviews name it, and it was renamed. Play Store 3 is Loop Habit Tracker. Play Store 2 is HabitNow. App Store 76 and Play Store 130 are Way of Life. App Store 33 and Play Store 37 are Habitify. Every other name is the store folder's own.

### Cited reviews
136 reviews are cited, listed in the order they first appear.

| Review ID | Store | App (folder) | ★ | Date | First cited in § |
|---|---|---|---|---|---|
| `c2e6b670-42a7-4fb2-953f-3caf8c9530aa` | Play Store | 123. Rise - Habit List | 5 | 2024-09-20 | 2 |
| `e5145920-f0e8-4e58-8b57-98d848e2eb4c` | Play Store | 123. Rise - Habit List | 5 | 2024-11-20 | 2 |
| `3a884b46-ead8-44ad-9655-e8608bc23868` | Play Store | 123. Rise - Habit List | 5 | 2024-11-24 | 2 |
| `5b41ba09-9297-47cd-980f-12a636778599` | Play Store | 123. Rise - Habit List | 5 | 2024-12-29 | 2 |
| `b9073377-fbfa-4dd8-8d69-688f8f1fa04a` | Play Store | 123. Rise - Habit List | 1 | 2024-12-27 | 2 |
| `23fab1a2-2491-4b8f-ba75-8c4fc6a228e5` | Play Store | 37. Habitify - Habit Tracker | 5 | 2022-06-19 | 4 |
| `8bbc108d-4962-4c64-b348-463377350a4d` | Play Store | 24. Habit Tracker | 5 | 2018-09-13 | 4 |
| `2622560b-331d-484c-95e2-38164951e723` | Play Store | 2. HabitNow Daily Routine Planner | 3 | 2023-10-22 | 4 |
| `b2f125b8-c3ab-4a31-88eb-b2eb55ecf806` | Play Store | 69. EZ Habit - simple habit tracker | 5 | 2022-02-24 | 4 |
| `c92ea41d-a00a-4a57-a8d2-2a0331d53eab` | Play Store | 123. Rise - Habit List | 5 | 2025-01-14 | 4 |
| `d8f69999-ee53-45e3-a1b5-5820b569469d` | Play Store | 9. Habit Tracker - HabitKit | 1 | 2024-03-21 | 4 |
| `0574e834-b8fa-4a60-8bea-3e330ed3ed52` | Play Store | 3. Loop Habit Tracker | 5 | 2018-02-08 | 4 |
| `051607de-1ae0-44ea-94b0-71b1b1a37a4d` | Play Store | 24. Habit Tracker | 5 | 2021-02-19 | 4 |
| `754313902` | App Store | 76. Way of Life - Habit Tracker - Build a better, stronger you | 5 | 2013-02-19 | 4 |
| `e39e69e7-c38a-4994-b80f-42a57f2d7cff` | Play Store | 69. EZ Habit - simple habit tracker | 3 | 2022-09-23 | 4 |
| `802a8de2-8685-4e59-962a-ddbfe5f81bb2` | Play Store | 65. Goal & Habit Tracker Calendar | 5 | 2023-04-14 | 4 |
| `f763379a-f140-4c74-a39c-e44e2482936e` | Play Store | 24. Habit Tracker | 5 | 2018-10-03 | 4 |
| `a14ba9ec-e843-4002-9536-d374e8f150d0` | Play Store | 70. everyday Habit Tracker | 5 | 2020-06-01 | 4 |
| `952112429` | App Store | 76. Way of Life - Habit Tracker - Build a better, stronger you | 5 | 2014-03-01 | 4 |
| `3642b356-e9f0-4d88-82fd-b6ea06a907ba` | Play Store | 70. everyday Habit Tracker | 5 | 2019-08-23 | 4 |
| `3415197c-8655-443b-b3dc-f17d0e32c624` | Play Store | 49. RoutineFlow - Routine for ADHD | 5 | 2023-03-29 | 4 |
| `5aaabc5f-54b7-492a-91a4-f04161a41031` | Play Store | 3. Loop Habit Tracker | 3 | 2021-02-02 | 5 |
| `782e80f7-0324-4b60-a336-ffbb95b668b8` | Play Store | 3. Loop Habit Tracker | 3 | 2024-07-31 | 5 |
| `e26d2077-5e70-40b1-8e67-3f936a86c671` | Play Store | 124. Habit Streak Tracker - DotHabit | 1 | 2019-08-12 | 5 |
| `9cefa7ff-ffe4-4c38-9770-b94a81d07329` | Play Store | 37. Habitify - Habit Tracker | 2 | 2024-02-04 | 5 |
| `8d7173ed-c152-4692-a20c-3060362fa3f9` | Play Store | 37. Habitify - Habit Tracker | 1 | 2026-08-03 | 5 |
| `0f9dd5bd-44f7-4470-be65-bd99402b7821` | Play Store | 24. Habit Tracker | 5 | 2020-10-28 | 5 |
| `f9009c3a-c858-4ec5-b3ec-b3f2ff25ba50` | Play Store | 44. Habit Tracker - TickOff | 4 | 2026-03-27 | 5 |
| `217876e7-7c7c-4294-8913-e7fccf435f6b` | Play Store | 32. Daily Habits - AI Habit Tracker | 4 | 2025-08-13 | 5 |
| `b006f8ff-ea2b-4556-8f18-93eca15bef40` | Play Store | 32. Daily Habits - AI Habit Tracker | 5 | 2026-02-19 | 5 |
| `dbf59948-0c4b-49b3-ace8-42372bcdc4a3` | Play Store | 24. Habit Tracker | 4 | 2019-02-05 | 5 |
| `753c81c3-07a4-44bb-a105-99c61ebc62a2` | Play Store | 24. Habit Tracker | 4 | 2016-08-12 | 5 |
| `6b31fe24-5e5e-45ee-8f14-41054366f9ee` | Play Store | 44. Habit Tracker - TickOff | 5 | 2026-06-24 | 5 |
| `2a4226fd-b8cf-4167-9177-1d18ff5a3320` | Play Store | 65. Goal & Habit Tracker Calendar | 4 | 2018-08-31 | 5 |
| `a477d6d2-54c1-4d51-b5de-92885a5cb7d3` | Play Store | 3. Loop Habit Tracker | 4 | 2025-01-11 | 5 |
| `4ff8c8d4-91cf-47e8-9d7b-0ecbbb018f95` | Play Store | 24. Habit Tracker | 2 | 2019-12-06 | 5 |
| `05ddee66-1d59-4fe3-a3f6-7c5b41695757` | Play Store | 37. Habitify - Habit Tracker | 1 | 2023-09-21 | 5 |
| `fb31ec89-de54-4441-b4ab-a6c5c2cde8ee` | Play Store | 105. Avocation Goal & Habit Tracker | 1 | 2024-01-17 | 5 |
| `ebebcbd0-24dd-4ca9-ba39-cccb134a417b` | Play Store | 24. Habit Tracker | 1 | 2020-06-13 | 5 |
| `3109ebd7-175a-44ca-b1ae-21664c0b58b5` | Play Store | 37. Habitify - Habit Tracker | 1 | 2023-09-28 | 5 |
| `ee142a71-81ca-42b4-a035-282e97a2d122` | Play Store | 37. Habitify - Habit Tracker | 1 | 2020-02-02 | 5 |
| `f62b7d9a-d671-4aab-bcfb-6249806cd6a3` | Play Store | 130. Way of Life - habit tracker | 3 | 2021-03-30 | 5 |
| `402c8d8c-192d-439b-9a34-ee3276b8d240` | Play Store | 65. Goal & Habit Tracker Calendar | 5 | 2015-12-12 | 5 |
| `0f6507c6-7cc0-4d02-8928-d25305087b74` | Play Store | 37. Habitify - Habit Tracker | 3 | 2019-03-17 | 5 |
| `83a077dc-1175-4280-8983-ac7cb330d5bd` | Play Store | 24. Habit Tracker | 3 | 2020-06-11 | 5 |
| `e72a9a68-b85a-492c-be2a-08285e8e1aa0` | Play Store | 123. Rise - Habit List | 5 | 2025-01-02 | 5 |
| `a9e50e90-e1d0-4727-9161-adc3dab998cc` | Play Store | 30. Habit Tracker - Routine & Goals | 5 | 2023-10-12 | 5 |
| `e20a0188-4949-445f-97b3-c71778990840` | Play Store | 30. Habit Tracker - Routine & Goals | 4 | 2023-12-12 | 5 |
| `cece2a48-af57-458b-b27f-0862d9a3ec10` | Play Store | 70. everyday Habit Tracker | 4 | 2024-06-18 | 5 |
| `2834a251-dd15-49fe-ba6e-0587a4dffba8` | Play Store | 2. HabitNow Daily Routine Planner | 4 | 2021-05-24 | 5 |
| `4289afb7-50cb-4dcb-86c0-c361b51d430c` | Play Store | 2. HabitNow Daily Routine Planner | 3 | 2024-01-05 | 6 |
| `5467149849` | App Store | 76. Way of Life - Habit Tracker - Build a better, stronger you | 5 | 2020-01-30 | 6 |
| `6e034ffb-761f-4d1b-8d99-69e6aede544a` | Play Store | 24. Habit Tracker | 4 | 2015-10-22 | 6 |
| `b91388f6-4872-46a8-aabd-5f2645ec6e28` | Play Store | 2. HabitNow Daily Routine Planner | 5 | 2020-11-30 | 6 |
| `60331d1f-15a4-4a98-b0e9-fcc78ce682ae` | Play Store | 24. Habit Tracker | 4 | 2015-10-11 | 7 |
| `015047ab-7e4a-4ee2-bd64-6957bca98d75` | Play Store | 24. Habit Tracker | 3 | 2018-10-08 | 7 |
| `e5e7dcfa-c5dc-4f61-ac58-0e839234b99a` | Play Store | 2. HabitNow Daily Routine Planner | 5 | 2021-01-05 | 7 |
| `ed968575-15a9-4e9c-86a1-e4649c160a8b` | Play Store | 70. everyday Habit Tracker | 3 | 2022-12-01 | 7 |
| `56d1a62e-8aa5-4c14-835c-d66bd6f064c6` | Play Store | 24. Habit Tracker | 4 | 2018-11-24 | 7 |
| `b55e7182-c881-4c52-9b8c-3cd61c197502` | Play Store | 20. MyRoutine - Routine Habit Goal | 5 | 2026-01-26 | 7 |
| `e4caab0a-b727-4499-99e4-232ff05d43fc` | Play Store | 24. Habit Tracker | 5 | 2015-03-18 | 8 |
| `f9c34729-82c4-4f1d-b6e5-7e73b8a26f97` | Play Store | 124. Habit Streak Tracker - DotHabit | 4 | 2022-06-05 | 8 |
| `6ad5d1f7-2278-4299-b010-aa527f8432fc` | Play Store | 24. Habit Tracker | 4 | 2021-03-12 | 8 |
| `e2ea8762-9eb8-49d7-b84e-aff1e292a263` | Play Store | 37. Habitify - Habit Tracker | 4 | 2021-04-09 | 8 |
| `d2a54f67-c049-4b2d-a013-351683c5c4ae` | Play Store | 105. Avocation Goal & Habit Tracker | 4 | 2021-05-19 | 8 |
| `03a966a7-d386-4474-a51a-2e3194db2c9c` | Play Store | 105. Avocation Goal & Habit Tracker | 5 | 2020-10-16 | 8 |
| `2dbb9c3e-6eec-4c28-9ee4-4d0fa0a7b244` | Play Store | 33. Productive - Habit tracker | 2 | 2022-01-01 | 8 |
| `b2514b65-60f1-4dc9-a7ae-1a3157c80f8e` | Play Store | 44. Habit Tracker - TickOff | 5 | 2026-05-16 | 8 |
| `1760651629` | App Store | 76. Way of Life - Habit Tracker - Build a better, stronger you | 4 | 2017-08-30 | 8 |
| `9405916639` | App Store | 76. Way of Life - Habit Tracker - Build a better, stronger you | 5 | 2022-12-17 | 8 |
| `fa7ace69-ea88-42c9-924c-1a5ecb21aa77` | Play Store | 33. Productive - Habit tracker | 3 | 2020-01-18 | 8 |
| `cadc79f8-180d-4536-9d9f-52412d26f8a1` | Play Store | 3. Loop Habit Tracker | 5 | 2017-11-07 | 8 |
| `680402f4-7571-4e86-9f58-a9bf46a024d5` | Play Store | 130. Way of Life - habit tracker | 4 | 2019-05-23 | 8 |
| `5d3f4c6c-3d54-4297-b669-8062e0c5dab9` | Play Store | 38. Roubit -Daily Life Routine Care | 4 | 2022-01-23 | 8 |
| `3e445595-8d0a-4e8a-bbaf-9aaed5c236a4` | Play Store | 49. RoutineFlow - Routine for ADHD | 5 | 2025-03-11 | 9 |
| `c603b916-e750-41c4-90dd-f0d7b33aaef5` | Play Store | 3. Loop Habit Tracker | 3 | 2025-02-19 | 9 |
| `c94ac6df-0aad-4798-bfd6-f8a574a14c93` | Play Store | 3. Loop Habit Tracker | 4 | 2025-08-14 | 9 |
| `10995642477` | App Store | 90. Quit Bad Habits & Addiction - Sobriety Counter & Tracker | 5 | 2024-03-01 | 10 |
| `14000029981` | App Store | 90. Quit Bad Habits & Addiction - Sobriety Counter & Tracker | 5 | 2026-04-26 | 10 |
| `11090976286` | App Store | 90. Quit Bad Habits & Addiction - Sobriety Counter & Tracker | 5 | 2024-03-27 | 10 |
| `14380495771` | App Store | 90. Quit Bad Habits & Addiction - Sobriety Counter & Tracker | 5 | 2026-08-02 | 10 |
| `14510416958` | App Store | 90. Quit Bad Habits & Addiction - Sobriety Counter & Tracker | 5 | 2026-09-04 | 10 |
| `05abe6c1-13db-4234-8299-9eac9d0d6e65` | Play Store | 3. Loop Habit Tracker | 5 | 2024-08-23 | 11 |
| `174b7e07-cc46-4dab-9d82-985b242ba7a6` | Play Store | 35. Motivated - Habit Tracker | 5 | 2024-04-10 | 11 |
| `4316a23a-bff7-4cbe-9cd1-1fdeedd74859` | Play Store | 35. Motivated - Habit Tracker | 4 | 2025-06-14 | 11 |
| `de0a9484-5b7a-4ede-b836-1e5578c01fa4` | Play Store | 105. Avocation Goal & Habit Tracker | 4 | 2022-07-08 | 11 |
| `a4b5695d-08b2-4fb8-9220-91fe96284a3d` | Play Store | 3. Loop Habit Tracker | 5 | 2024-01-03 | 11 |
| `3cb152c4-ecfe-4a60-a540-9d8cc7ec83da` | Play Store | 9. Habit Tracker - HabitKit | 4 | 2025-09-19 | 11 |
| `699fdccf-57ec-4525-939e-ccc22a8cf4bd` | Play Store | 3. Loop Habit Tracker | 4 | 2023-05-30 | 11 |
| `faeb0944-1c84-4935-a7e5-c11e4dcdc2e7` | Play Store | 24. Habit Tracker | 5 | 2018-10-10 | 11 |
| `d1f94777-b640-4a0a-ac73-ac1713f6afdc` | Play Store | 24. Habit Tracker | 3 | 2020-01-29 | 12 |
| `477586d2-a28c-469b-b4b4-e63b2201e97b` | Play Store | 38. Roubit -Daily Life Routine Care | 4 | 2023-06-02 | 12 |
| `007a9215-fc7b-493b-8e75-e6f252f27c15` | Play Store | 3. Loop Habit Tracker | 4 | 2020-06-18 | 13 |
| `c7feefb1-ff50-4a99-8e6e-605588cd3e83` | Play Store | 24. Habit Tracker | 4 | 2018-06-01 | 13 |
| `12424534015` | App Store | 18. MyRoutine - Organize your day - Built around your real life | 5 | 2025-03-15 | 13 |
| `1494739908` | App Store | 76. Way of Life - Habit Tracker - Build a better, stronger you | 4 | 2016-12-02 | 13 |
| `06756e65-4d2a-4727-8067-c2424d76b53b` | Play Store | 2. HabitNow Daily Routine Planner | 4 | 2024-01-04 | 14 |
| `3589e020-8a88-4848-95ef-eec4854cd233` | Play Store | 24. Habit Tracker | 4 | 2016-09-06 | 14 |
| `627adfcc-9cca-4cb5-bc76-e003f356a139` | Play Store | 65. Goal & Habit Tracker Calendar | 4 | 2022-01-17 | 14 |
| `7a216abf-4537-407c-a6a5-f58939537ca1` | Play Store | 2. HabitNow Daily Routine Planner | 5 | 2021-10-03 | 14 |
| `6fa39e1c-a2a2-401f-9ef4-fd59bc4a1e46` | Play Store | 20. MyRoutine - Routine Habit Goal | 5 | 2024-09-23 | 14 |
| `0ad9dd82-6c1a-4780-a049-7fbb4dd7efb3` | Play Store | 3. Loop Habit Tracker | 5 | 2019-03-17 | 14 |
| `8b2d8fe4-d028-4b01-bacb-7603fe73adc5` | Play Store | 30. Habit Tracker - Routine & Goals | 4 | 2023-08-10 | 15 |
| `4082cc04-4dce-4ebe-b9e6-9ca23bb7f88e` | Play Store | 58. Habitide - Habit Streak Tracker | 3 | 2025-04-10 | 15 |
| `5f859344-d082-4af9-8a15-d1713f702e6d` | Play Store | 2. HabitNow Daily Routine Planner | 4 | 2020-12-14 | 16 |
| `e24e107c-2cc4-4f7b-86f4-885f0f79665d` | Play Store | 7. Habit Tracker - Habit Streak | 1 | 2026-02-17 | 16 |
| `4bca591b-5718-49b5-974e-343f3705aa3a` | Play Store | 3. Loop Habit Tracker | 5 | 2020-05-16 | 16 |
| `3ef4af91-987f-4760-8860-50564f99e9bc` | Play Store | 3. Loop Habit Tracker | 5 | 2023-11-27 | 16 |
| `ed54f1b5-3a70-4751-a1d3-49e963db7def` | Play Store | 105. Avocation Goal & Habit Tracker | 3 | 2020-09-03 | 18 |
| `f4dca8bc-b603-4987-a86d-d6629ba16aa5` | Play Store | 70. everyday Habit Tracker | 4 | 2021-10-04 | 18 |
| `f18d2f4d-6631-492f-b273-874ef47fdfe2` | Play Store | 3. Loop Habit Tracker | 5 | 2025-03-20 | 18 |
| `4af1a74e-d38c-4674-9d17-339b1acdfad1` | Play Store | 65. Goal & Habit Tracker Calendar | 5 | 2023-11-19 | 18 |
| `13636020247` | App Store | 25. Grit - Daily Habit Tracker - Routines & Goals ADHD Planner | 2 | 2026-01-15 | 22 |
| `050f63ce-e08b-4d2c-9dff-f3322d019e84` | Play Store | 38. Roubit -Daily Life Routine Care | 2 | 2023-02-06 | 22 |
| `2298baa2-5026-4ffa-882b-44acad46904d` | Play Store | 38. Roubit -Daily Life Routine Care | 2 | 2023-03-04 | 22 |
| `c362fc63-6e3c-45b5-95d2-887d9eabaaf7` | Play Store | 38. Roubit -Daily Life Routine Care | 4 | 2023-04-01 | 22 |
| `8d47a518-29b0-4d92-9d1a-7b6beedc841e` | Play Store | 110. Habit Tracker Unlimited | 1 | 2024-08-24 | 22 |
| `eec3579f-51e9-494d-a31d-bfc5661030a2` | Play Store | 110. Habit Tracker Unlimited | 1 | 2024-08-27 | 22 |
| `6a763e0d-cfe5-4d2d-bc5d-014514f05ef0` | Play Store | 110. Habit Tracker Unlimited | 1 | 2024-08-29 | 22 |
| `9951fcde-32de-4965-9670-9ab931eb0bad` | Play Store | 105. Avocation Goal & Habit Tracker | 1 | 2024-09-07 | 22 |
| `12680052718` | App Store | 54. Avocation - Habit Tracker - Daily planner & ADHD organizer | 2 | 2025-05-21 | 22 |
| `11309506354` | App Store | 1. Habit Tracker - Goal Tracker & ADHD Planner | 1 | 2024-05-26 | 22 |
| `7a291ab3-c451-40ad-a686-de0370dece54` | Play Store | 3. Loop Habit Tracker | 4 | 2023-07-15 | 23 |
| `13325152566` | App Store | 41. Awesome Habits - Habit Tracker - Streaks, days since & goals | 3 | 2025-10-28 | 23 |
| `10957454552` | App Store | 59. Tappsk - ToDo & Habit Tracker - Task Manager & Daily schedule | 4 | 2024-02-19 | 23 |
| `aa5005d3-b5c7-4a40-9155-d3a0bef2c9d0` | Play Store | 20. MyRoutine - Routine Habit Goal | 5 | 2023-11-14 | 23 |
| `c725df30-bce7-4828-900f-04118bd34ab2` | Play Store | 92. Qhabit - Daily habit tracker | 2 | 2024-01-22 | 23 |
| `11052153505` | App Store | 16. Atoms - from Atomic Habits - The official Atomic Habits app | 3 | 2024-03-16 | 23 |
| `8916a30d-61f1-491b-ac20-50085f3bdb62` | Play Store | 24. Habit Tracker | 4 | 2017-04-23 | 23 |
| `d2c3b799-af3b-4ada-91ae-4a73fd57eced` | Play Store | 19. TheFor - Habit Tracker | 4 | 2023-11-05 | 23 |
| `4284181386` | App Store | 53. HabitMinder • Habit Tracker - Daily Reminders & Routines | 5 | 2019-06-08 | 23 |
| `0750ad9a-be8f-4e22-ace4-f23c64f59cf2` | Play Store | 105. Avocation Goal & Habit Tracker | 5 | 2023-04-26 | 23 |
| `8adb668a-f1ba-453f-862f-195fb58fd744` | Play Store | 105. Avocation Goal & Habit Tracker | 5 | 2021-05-25 | 23 |
| `d654931f-9c4d-46c7-8270-11ce0f42bd71` | Play Store | 11. Dear Me - Daily Routine Tracker | 4 | 2026-05-06 | 24 |
| `d3327c35-e451-4565-b660-039408de5ae4` | Play Store | 49. RoutineFlow - Routine for ADHD | 3 | 2023-01-08 | 24 |
| `a440892d-d994-4147-8cdc-b0d728f9a512` | Play Store | 44. Habit Tracker - TickOff | 4 | 2025-10-06 | 25 |
