# Weekly Overview Card — Which Numbers to Show

Written by Claude (Claude Code), 2 October 2026, at the user's request: "In the overview card for weekly … combining all
of the habits together, what statistics do users actually expect? … Right now, the 'Done so far this week, 53 of 55 ·
96%' doesn't make sense even for me … we have different types of habits, quit habits and all. Combining everything in
an overview, what are the most useful statistics for a user in a week?"

**Status:** research and a recommendation. Nothing in the app was changed. Like every report in this folder, this is
not a decision record. It builds on [The Progress Page — What People Need, and How to Build It](<The Progress Page — What People Need, and How to Build It.md>)
(§7.2 and §16.4 defined today's card) and does not repeat its general findings. Visual layout is covered separately in
`Progress Week — Visual Options.md` (branch `claude/progress-week-research`). This report is only about **which numbers**
the card shows.

**What was read:** 1,856 reviews, each read by hand and coded (1,453 on topic, from 94 habit apps, App Store 921 and
Play Store 935, July 2011 to September 2026). They are every review the earlier Progress research had coded as asking
for or praising an all-habits overview (938), plus a new whole-corpus screen of 876,387 habit-app reviews for the
words people use about one combined figure or a weekly summary. §8 has the method. Every review ID is in
[`Weekly Overview Evidence/coded_reviews.tsv`](<Weekly Overview Evidence/coded_reviews.tsv>).

---

## 1. The answer

> **Revised the same day, after the user's review.** The first version kept weekly goals and quit habits out of the
> big number and gave each its own line. The user's point: the overview is the summary of *everything listed below
> it*, so a number that leaves some of those habits out has no job. That's right. This version makes one number that
> covers every habit on the page, built so each kind of habit is judged by its own goal.

**One number that sums up the habit rows beneath it: the average of every habit's own week score.** Each habit gets
a score for the week, from 0 to 100%, against *its own* goal: a daily habit by its days, "3 times a week" by its
three, a quit habit by its clean days. The overview is the plain average of those scores, so **each habit counts
once**, whatever its type. Every row shows its score, so anyone can check the big number against the list. Under the
number, the card names the habits pulling it down.

"53 of 55" counts *habit-days* (one per habit per day it was due). That unit is invisible, it lets a daily habit
weigh seven times a weekly one, weekly goals can only push it up, and quit habits are silently left out (§2).

```
This week · Sun–Fri so far                                   ⓘ
89%  of your plan this week
     every habit counts once, by its own goal · Last week 84%
 S    M    T    W    T    F    S
(27) (28) (29) (30) ( 1) ( 2)  3            ← unchanged: each ring is that day's share
───────────────────────────────────────────
Needs attention
 🏋  Gym        0 of 3 · 2 days left           0%
 🚭  Smoking    1 slip · 4 of 5 days clean     80%
 📖  Read       4 of 5 days, 1 part done       90%
9 habits fully on plan
```

Worked example (Friday, 12 habits): nine daily habits done every day so far (100% each), Read 4 days done and one half
done (90%), Gym "3 times a week" with nothing logged and two days left, so one session was already due (0%), Smoking
with one slip in five days (80%). (9 × 100 + 90 + 0 + 80) ÷ 12 = **89%**. Today's card would read about 98% for the same
week: Gym can't lower it and Smoking isn't counted.

| # | Element | What it answers | Evidence |
|---|---|---|---|
| 1 | **Average of every habit's own week score** ("89% of your plan this week") | "How did my week go, all of it?" | Users show: the most-asked combined figure (302 reviews in 47 apps ask for an overall % or a day's share), and **13 reviewers ask for exactly this: the average of each habit's own percentage** (§4.1) |
| 2 | **Last week, same number** ("Last week 84%") | "Am I improving?" | Users show: 22 asks in 13 apps; "46 of 57" can't be compared with "53 of 55" at a glance |
| 3 | **The seven day rings** (kept) | "Which days went well?" | Users show: "on Monday you did 8/10, on Tuesday 9/10" |
| 4 | **Needs attention**: the habits under 100%, lowest first, at most three, each with its own number and score | "What's pulling it down, and what do I do?" | Users show: 143 asks in 35 apps for "which habits need attention"; a single % "doesn't explain the story" |
| 5 | **A score on every habit row** (most rows have one today; amount, time, limit, week-goal and quit rows don't yet) | "Where does 89% come from?" | Reasoned from first principles: a summary you can't trace reads as broken (54 complaints at 2.96★, §2.2) |

**Remove:** the "53 of 55" sum, the "Full days", "Weekly goals met" tiles as headline numbers (their information is now
inside the score and in Needs attention), and "Last week · 46 of 57". Full days can stay as one small line if wanted
(§4.5).

---

## 2. What is wrong with "53 of 55 · 96%"

### 2.1 What it actually counts (from the code)

`progressTally` adds up `dayScore` for each day so far (`HabitStore.swift`, `HabitStore+Progress.swift`):

- **A daily habit** adds 1 to "planned" on each day it was due, and 1 to "done" if it was met. Part-done adds to
  planned only.
- **Today** adds only what's already done to both sides, so today can't lower it.
- **A weekly goal** ("3 times a week") **adds 1 to planned *and* 1 to done on each day something was logged, and nothing
  on other days.** It can only raise the percentage. A gym goal at 0 of 3 on Friday changes nothing.
- **"N days a week" habits** work the same way: an empty day doesn't count.
- **Quit habits are left out entirely**, with no line saying so. Daily limits count once the day is over; weekly limits
  don't count.

So in the screenshot, 55 means "habit-days judged so far, plus a bonus for each day a weekly goal was logged". 96%
sits right above "Weekly goals met so far: 0 of 1", and the two never interact. That is why it "doesn't make sense":
**the unit is invisible, the number mixes types, and the one habit that's actually behind cannot move it.**

### 2.2 What reviewers say about numbers like this (users show)

- **A count with no visible unit reads as noise.** "I understand the argument that I'm '19% of the way toward
  completing all of my habits this week,' but you should distinguish more clearly…" (Habit Tracker, 4★, `9835382363`);
  "the percentage completion figures are confusing - I assume they relate to a month but that makes no since when the
  overview is a week" (Habit, 2★, `4690039855`); "How is the score (percentage) calculated?" (TheFor, 5★,
  `b01b7efe-81ed-4daf-a0dd-62957dee1bd9`). Complaints that a combined number is wrong or can't be understood: 54 reviews
  in 17 apps, **2.96★**, the lowest-rated theme in this read.
- **Weekly goals inside a daily number:** "if I have a habit to workout 3x a week, this habit will count against my
  success scores … even though I have the rest of the week" (HabitMinder, 4★, `3638140023`). The opposite hurts too:
  "weekly and monthly habits no longer count, so my score shows 0%" (Habitify, **1★**, `8d7173ed-c152-4692-a20c-3060362fa3f9`).
  So weekly goals must neither be faked into days nor dropped. They need their own count.
- **A number that only goes up is not trusted either.** "The reporting sees a 'done' checkmark as the same as 'skipped' so
  even on a day that I skip a goal, it tells me I had a perfect day. I want it to show me how many things I actually
  did" (Habit Tracker, 3★, `11163941293`); "my weekly report told me that I am amazing for doing nothing" (Fabulous, 3★,
  `8599cbb6-8e17-41f3-b3c6-6ba115102136`).
- **Different units added together are rejected by the people who propose them.** A HabitBull user asks for "yes=1 and
  5 miles=5, daily score is 6" (`07459cbd-150f-4a0b-84ba-ceebdc299ef6`). That shows the need for one number, but
  reasoned from first principles a mile and a tick are not comparable. Scores built that way are what users call
  meaningless: Productive's meter ("You get an automatic 20% for having the app", 3★, `10126604467`); HabitBull's score
  "always trending down no matter what" (3★, `88f9f70c-c5a4-48ef-bbab-0369b52243ff`).

---

## 3. What people ask a combined view to show

Denominator: **1,453 on-topic reviews, 94 apps**. One review can carry several codes. "Asks" are requests, "Praise" is
for having it, "Complaints" are about it done badly. Full counts: [`theme_counts.txt`](<Weekly Overview Evidence/theme_counts.txt>).

| What they want | Reviews | Apps | Mean ★ | Praise · Ask · Complain | Used for |
|---|---|---|---|---|---|
| **One overall percentage** across habits | 276 | 50 | 4.27 | 67 · 191 · 16 | The number (§4.1) |
| **One combined graph over time** | 271 | 40 | 4.29 | 11 · 258 · 1 | Month/Year, not this card (§6) |
| **All habits × days at a glance** (the week grid) | 256 | 49 | 4.36 | 98 · 147 · 0 | Already the habit rows under the card |
| **Which habits are strong, which need attention** | 201 | 41 | 4.36 | 60 · 143 · 0 | Needs attention (§4.4) |
| **Each day's share** ("8 of 10 on Monday") | 174 | 41 | 4.34 | 35 · 130 · 3 | Day rings, Day sheet |
| **A weekly / monthly report** as such | 172 | 38 | 4.34 | 57 · 103 · 3 | The card *is* this |
| **Perfect / full days** | 142 | 26 | 4.20 | 59 · 18 · 35 | Optional line (§4.5) |
| **Weekly or flexible goals counted wrongly** | 73 | 25 | 3.68 | 13 · 19 · 37 | Week-goal rule (§4.2) |
| **Totals** (time spent, counts) | 59 | 29 | 4.27 | 7 · 49 · 1 | Optional line (§4.5) |
| **Quit habits in the overview** | 36 | 11 | 4.50 | 16 · 11 · 2 | Clean days in the number (§4.2) |
| **Compared with last week** | 31 | 17 | 4.42 | 8 · 22 · 0 | Last week (§4.3) |
| **A forgiving measure** (one miss doesn't wipe it) | 24 | 13 | **4.92** | 22 · 2 · 0 | Shares, not pass/fail (§4.2) |
| **By category / group** | 33 | 15 | 4.33 | 1 · 31 · 0 | Group chips already filter the card |
| **Shame / pressure from the number** | 11 | 9 | 3.09 | — | Tone (§4.4) |

Three things stand out:

1. **The percentage is the language people use.** "Can you please add the overall percentage of all habits … This is
   the only think which makes me to return to my previous app" (Habit, 3★, `6949334514`); "I want to see a score of all
   habits combined not just each one individually.. so for example like sayin the total performance is like 70%" (HabitNow, 5★, `b8f8084d-77bf-4023-8174-96df3c96ce34`). When people
   give raw numbers, they give them **per day, in habits**: "on Monday you did 8/10, on Tuesday 9/10"
   (`8502b10c-b560-4c64-aea5-e053bbaa442d`), "SCORE FOR THE DAY 3 out of 4" (`82224478-a7b7-4475-bdf4-f20bd67982a5`).
   In this read, only that reviewer also sums a week of habit-days ("23 / 28"): one supporter in 1,453 reviews. The per-day fraction is what people actually use.
2. **People want the overview to say what to do next.** "Add a screen … which one you are acing and which one need
   improvement" (HabitNow, 5★, `221e4dc8-d0d1-4e9a-8d1f-3e884aaa34f0`); "5 stars if the app would tell me at a glance
   which habits are lagging or not meeting my goal quota's" (HabitBull, 4★, `1296985275`); "nothing shows how well
   you've been doing overall which makes it easy to not notice falling behind on a single habit" (HabitNow, 3★,
   `4289afb7-50cb-4dcb-86c0-c361b51d430c`); a list running from neglected to well-done habits (Loop, 5★,
   `702167f5-450e-4acc-b71f-67920f2ce235`). A percentage alone hides this: "Seeing a single 75% ring doesn't explain the
   story" (Habit Tracker, 5★, `6087594649`).
3. **Weekly goals are judged by their own goal, not as if they were daily.** "it would be great to have a week view where you can
   see … how much you have left to do that week" (HabitNow, 4★, `53d05a77-686c-4e45-b4f1-c3682066bd3e`); "So i can see
   easily 'D'oh.. i have to do it at least two times more this week'" (HabitBull, 4★,
   `074b9e99-2679-4d2b-acdb-23742c20ecbf`); "tracks per week progress/completion based on the set frequency … knowing
   how much more you need to do to complete your weekly goals" (Loop, 4★, `76fc3a7b-23e2-4e57-93c0-262c4233448b`); a
   week summary showing how many times each habit was done and what share of the week's and month's goals were met (Loop, 4★,
   `e3c47c51-3563-4d1f-92a4-32cc59a86491`, Russian, paraphrased).

---

## 4. The card, element by element

### 4.1 The number: every habit's own week score, averaged

**Each habit counts once.** Users show this is how people think about "overall": "habit a has 90%, habit b has 70%,
my overall habit strength is, let's say 80%" (Loop, 4★, `3ba719b4-b3c3-47fa-82e4-eac69b1d5cc9`); "Each habit will be
calculated by percentage … The average of all percentage score will be the score of the day" (HabitNow, 4★,
`5f859344-d082-4af9-8a15-d1713f702e6d`); "a total cumulative percentage score (all percentages averaged)" (Strides,
5★, `1298693623`); "the average completion rate of all habits so you can tell if you are making progress overall with
one number" (HabitNow, 3★, `d861fc22-27ea-41e3-8aa7-142061e2b53d`); "No ability to see an average score across all
habits. Deal breaker." (2★, `c461b6a5-5ad0-4e89-82ff-652dd61aa80b`). Also `4f121790-692f-4361-bd58-1c41a10d03d2`,
`074a0b59-dce4-4f50-99cb-b39642d8714f`, `0f1157c7-2aac-4edf-9ac8-f47f0912152e`, `61f4f69b-9e97-4941-9621-20f09bdcbfdf`,
`a6363b89-850a-47b6-af2e-f3899d547a44` (Russian), `127b60ea-505e-4e03-ab29-9637061224ed` (Portuguese), `779435004`,
`994bd795-72d4-4a66-ab51-76c083192eca`: 13 in all, nobody asking for the opposite.

**Why an average of habits and not a pooled count** (reasoned from first principles): pooling habit-days makes a daily
habit weigh seven times a "once a week" one and thirty times a monthly one, so the habits people most often fall behind
on barely register. An average of habits is also the only combined number a person can check by looking at the rows
below it, which answers the user's own test: the overview should be "a combination of everything below".

**Converting each kind to a share of its own goal** is how Apple's Activity rings put calories, minutes and hours side
by side: each ring is the share of its own goal ([Apple](https://www.apple.com/watch/close-your-rings/)). Reviewers
point to the Apple Watch rings as the model for habits (`10204139203`, `6087594649`). Ticks, kilometres and minutes are never
added to each other; only each habit's share of its own goal is.

### 4.2 Each kind of habit's week score

"So far" means up to today. **Today never counts against anyone**: a day habit counts today only once it's done, and
a goal counts the days still left, today included, as days you can still use.

| Kind | Week score | Example |
|---|---|---|
| Check-off, daily or on set days, every N days | Share of its planned days done so far | 4 of 5 days → 80% |
| Amount or time with a daily goal; checklist | Each planned day counts its share of the day's goal (capped at 100%), averaged | 4 full days + one half day → 90% |
| **"N times a week" / "N days a week"** | Done ÷ what's already due. What's due is the part that no longer fits in the days left: goal − days left (today included), never below 0. Once the week ends: done ÷ goal. Capped at 100% | 3 a week, Friday, 2 days left: 1 due. Nothing done → 0%. 1 done → 100% |
| **Week amount or time goal** ("20 km a week") | Done ÷ an even pace over the finished days (goal × finished days ÷ 7). 100% on the first day. Once the week ends: done ÷ goal. Capped | Friday, 5 days finished: 14.3 km due; 12 km done → 84% |
| Monthly and yearly goals | The same two rules over their own month or year | 2 a month, 3 days left in the month, none done → 0% |
| Daily limit (cut down) | Share of finished days within the limit | 4 of 5 days within → 80% |
| Week limit | 100% while within; once over: limit ÷ used | 4 drinks against a limit of 3 → 75% |
| **Quit** | Share of days so far without a slip (today counts once it's over, or at once if there's a slip today) | 1 slip in 5 days → 80% |
| Tasks | Not in it (decided earlier) | — |

- **Skipped, paused, not-yet-started and archived days** don't count, as now. A habit with nothing that counts this week
  (paused all week, starts tomorrow) is left out of the average, never counted as 0 or 100.
- **Doing more than the goal** shows on the row ("4 of 3 · met") but the score stays 100%, so one overachieved habit can't
  hide another that's behind. Users show both halves: they want extra sessions recorded (Productive, 3★, `2530726777`;
  `554b5f67-3ed8-4097-b887-111f0dbc7991`; `f3326a1b-7b14-4210-8e57-2fe8052408ae`), and they want to see which habit
  "needs more attention".
- **Why weekly goals use "what's already due"** (users show): "this habit will count against my success scores if
  they're not completed … even though I have the rest of the week to get those 3 workouts in" (HabitMinder, 4★,
  `3638140023`); "it will break my streak even if … I still have time to get in my 16 a month" (Loop, 3★,
  `836746ac-98e7-46f5-a9df-8bd654c68ca1`). Dropping them instead earns a 1★ (`8d7173ed-c152-4692-a20c-3060362fa3f9`).
  "What's already due" is the fairest honest rule for counts and days: nothing is late until it can no longer fit. For
  amounts there is no "one per day", so an even pace over finished days is used. Strides users praise exactly that
  ("works well to keep on pace for daily/weekly goals", 5★, `5366122746`;
  [Strides FAQ](https://www.stridesapp.com/faq.html)).
- **Why quit habits are in it, as clean days** (users show + first principles): the user asked for every kind of habit
  in the overview. A share of clean days is a count of days, not a grade, and a slip lowers it by one day's worth, not
  to zero: "If I slip in one area I am encouraged by success in the other areas" (Days Since, 5★, `9511554988`). The
  run clock and best run stay in the Quitting section. A slip costs a day, never the week; that is the lesson of the
  abstinence violation effect ([Marlatt](https://www.mayo.edu/research/documents/relapse-prevention-mdash-moran/DOC-20003018)).
- **Why it stays forgiving** (users show): "If I break a streak I don't feel so defeated since I can see the total
  completion rate" (everyday, 5★, `11397647494`); "it gives you an overall percentage, which I find really helps
  motivate me even if a streak is broken" (HabitBull, 5★, `051607de-1ae0-44ea-94b0-71b1b1a37a4d`). A missed day costs a
  few points. Missing once did not materially affect habit formation
  ([Lally et al., 2010](https://bps.org.uk/research-digest/how-form-habit)).

**Shown when** at least one habit has something that counts this week. Never "0 of 0", never a bare 0% on the first
morning (every habit is still on plan then, so it reads 100% with "so far").

**When percentages are hidden** (View Options): the big number becomes "9 of 12 habits fully on plan" and the list
keeps each habit's own words ("0 of 3 · 2 days left") without scores.

### 4.3 Last week, the same number

"Last week 84%". Plain text, no arrow, no colour. In Month, "August 78%". Users show: "I want to see how disciplined
I've become since last week … last week 75% … this week done only 71%" (Loop, 4★, `f9aa4227-c189-4278-87f7-8caa9f2a9b38`);
"Or like how I was this week compared to last week" (Awesome Habits, 5★, `7229548903`). A week is a natural fresh start
([Dai, Milkman & Riis, 2014](https://knowledge.wharton.upenn.edu/article/need-fresh-start-heres-begin/)), so each week
is compared with the last, not with all time.

### 4.4 Needs attention: the habits pulling the number down

| Rule | Detail |
|---|---|
| Who | Habits with a week score under 100% |
| Order | Lowest score first; ties: the goal with the fewest days left first |
| How many | At most three, then "and 2 more", which scrolls to the habit rows. Under the list: "9 habits fully on plan". When none: "Every habit on plan so far" |
| Text | The habit's own words, then its score: "0 of 3 · 2 days left · 0%", "1 slip · 4 of 5 days clean · 80%", "4 of 5 days · 80%", "Over on 2 days · 60%" |
| Tap | Opens the habit's page. Progress never logs |
| Tone | No red, no "missed", no "failed", no grade (decided earlier). Users show what goes wrong: "Always opens to bad news ... Overall percentage failure" (HabitBull, 3★, `83a077dc-1175-4280-8983-ac7cb330d5bd`) |

Users show this is the practical half of an overview: "which one you are acing and which one need improvement"
(HabitNow, 5★, `221e4dc8-d0d1-4e9a-8d1f-3e884aaa34f0`); "at a glance which habits are lagging or not meeting my goal
quota's" (HabitBull, 4★, `1296985275`); "Seeing a single 75% ring doesn't explain the story" (Habit Tracker, 5★,
`6087594649`).

### 4.5 Kept or optional

- **Day rings:** kept exactly. They answer a different question (each day), so they keep their own rule (that day's
  share of the habits due that day). The ⓘ sheet says so in one line.
- **Full days:** optional small line, "3 of 5 days everything done". Loved (59 praise) as long as weekly goals and skips
  can't break a day (35 complaints when they do). It is no longer a headline tile.
- **Time on timed habits** ("4 h 10 min"): optional, off by default (§3: 49 asks for totals; calm-card asks against).

### 4.6 The ⓘ sheet, rewritten

"**This week's number** is the average of every habit's own score, each habit counted once. A daily habit scores the
share of its days done so far. A weekly goal ('3 times a week') counts only what's already due: what no longer fits in
the days left. A weekly amount ('20 km') is compared with an even pace. A quit habit scores its days without a slip. A
limit scores its days within the limit. Today never counts against you, and skipped or paused days don't count. **The
rings** show each day: how many of that day's habits were done." Users ask for exactly this kind of box: one that
explains how the percentages are calculated (Habitify, 4★, `3159218172`, Spanish, paraphrased).

---

## 5. Every kind of habit in the number

Every habit listed on the page is in the number, except tasks (excluded from Progress earlier). Each kind is scored by
§4.2, every row shows that score, and the overview is their average. The day rings keep their per-day rule.

| Kind | In the big number | Row shows | In Needs attention when |
|---|---|---|---|
| Check-off (daily, set days, every N days) | ✓ days done ÷ planned | "4 of 5 days · 80%" | a planned day wasn't done |
| Amount / time, daily goal | ✓ day shares, averaged | "1 h 52 min · 4 of 5 days · 90%" | any day short |
| Checklist | ✓ step shares, averaged | "18 of 20 steps · 90%" | any day short |
| N times / N days a week | ✓ done ÷ already due | "1 of 3 · 2 days left · 100%" | something due isn't done |
| Week amount / time | ✓ done ÷ even pace | "12 of 20 km · 84%" | behind pace |
| Monthly, yearly goals | ✓ same rules over its period | "1 of 2 this month · 100%" | something due isn't done |
| Daily limit | ✓ days within ÷ finished days | "Within on 4 of 5 days · 80%" | over on a day |
| Week limit | ✓ 100% within, else limit ÷ used | "2 of 3 this week · 100%" | over |
| Quit | ✓ clean days ÷ days so far | "1 slip · 4 of 5 days clean · 80%" | a slip this week |
| Task | — | — | — |

---

## 6. What not to put on this card

- **A sum of habit-days** ("53 of 55"). An invisible unit (§2).
- **An opaque score**: points, weights, a "strength" formula or a smoothed curve that can't be traced to the rows.
  54 complaints at 2.96★ about combined numbers being wrong or opaque, with specific complaints about Loop's,
  Productive's and HabitBull's scores (§2.2). The recommended number differs on purpose: it is only the average of
  scores printed on the rows. Two reviewers ask for weights (`d1fb6a31-09e1-4478-827d-8428bfb6b0df` among them).
  Weights need setting and explaining, which is too much for a card meant to be glanced at; every habit counts once.
- **Different units added together** (miles + ticks + minutes).
- **A combined graph over time** (271 reviews, mostly Loop users asking for a chart across months). That belongs in
  Month and Year, which already have it. A week is seven rings.
- **Category rings** (33 asks): the group chips already filter the whole card.
- **Praise for nothing** or a report that counts today's unfinished habits as failures: "my perfect week always
  appears to end in failure" (Habitify, 2★, `9cefa7ff-ffe4-4c38-9770-b94a81d07329`). Today counts what's done (kept).

---

## 7. Outside evidence

| Finding | Source | Used for |
|---|---|---|
| Monitoring progress raises goal attainment (138 studies, d = 0.40), more when the progress is recorded | [Harkin et al., 2016, *Psychological Bulletin*](https://eprints.whiterose.ac.uk/91437/) | Why the card earns its place |
| Natural frequencies are understood far better than percentages, when the counted thing is natural | [Gigerenzer & Hoffrage, 1995](https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2015.00642/full) | The rows keep plain fractions ("4 of 5 days", "1 of 3"); the % summarises them, never a fraction of habit-days |
| Missing one day did not materially affect habit formation | [Lally et al., 2010](https://bps.org.uk/research-digest/how-form-habit) | A forgiving headline |
| One lapse under all-or-nothing rules leads people to abandon the goal | ["What-the-hell" effect](https://more.efpsa.org/rpblog/?p=1172); [abstinence violation effect](https://www.mayo.edu/research/documents/relapse-prevention-mdash-moran/DOC-20003018) | A slip or a miss costs a day's share, never the week |
| Goal-pursuit rises after temporal landmarks such as Mondays | [Dai, Milkman & Riis, 2014](https://knowledge.wharton.upenn.edu/article/need-fresh-start-heres-begin/) | Each week starts clean; compare with last week |
| Habitify's weekly report shows success, failed, skipped and total per habit, plus a comparison with the previous range | [Habitify help](https://intercom.help/habitify-app/en/articles/9728009-how-to-track-a-weekly-habit) | Checked only. Its own reviews ask for raw numbers and complain that weekly goals left its score (§2.2) |

---

## 8. Method and limits

- **Reading set:** every review the Progress research coded `ALL` or `?ALL` (938), plus a new screen of all 876,387
  habit-app reviews (App Store and Play Store, adjacent Play apps excluded as before) for perfect / full days, "x of y
  habits", weekly summaries, overall scores and percentages, comparisons with last week, strongest and weakest habits,
  total time, and the same in Spanish, Portuguese, French, German, Italian, Russian, Turkish, Chinese, Japanese and
  Korean ([`scripts/screen_overview.py`](<Weekly Overview Evidence/scripts/screen_overview.py>)).
- **Noise removed before reading:** "on track" and "best habit" matches with no overview context (7,521 and 3,418,
  almost all "keeps me on track" and "best habit app"). This left **1,856 reviews, all read by hand**, 74 of them
  generic matches such as "most consistent I've been" that were still read and coded.
- **Codes** are in [`codebook.md`](<Weekly Overview Evidence/codebook.md>). `scripts/tally.py` checks that every row is
  coded once and every code is in the codebook, then counts reviews, apps and mean stars.
- **Limits:** keyword retrieval misses reviews that describe the wish in other words, so counts are floors. Codes
  overlap. Store ratings are given to the whole app, not to the statistic. Loop and HabitNow supply many of the
  combined-graph and overall-percentage asks (both lack the feature), which inflates those two counts relative to
  apps that already have it. Habio and Ultiself have bursts of generic 5★ reviews (earlier report §2.3). They add only
  `GEN` codes here, and no recommendation rests on `GEN`. The card itself is reasoned from these reviews and hasn't been
  tested with people. It should be measured with `[ios-perf]` once built, like any screen.
- **Cited IDs** were checked against the source files (`scripts/verify_ids.py`, all found).
