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

**Stop adding unlike things into one number.** "53 of 55" counts *habit-days*: one per habit per day it was due. Nobody
thinks in that unit. It also blends weekly goals in a way that can only push the number up, and it leaves quit habits
out without saying so. The fix is not a better formula. It is **one plain figure per kind of habit, each in the unit
people already use for it**, plus the one thing the current card never says: **which habits need attention.**

```
This week · Sun–Fri so far                               ⓘ
96%  of daily habits done
     Last week 81%
 S    M    T    W    T    F    S
(27) (28) (29) (30) ( 1) ( 2)  3          ← unchanged: each ring is that day's share
───────────────────────────────────────
3 of 5 days        1 of 2 weekly goals     Quit: no slips
everything done    met so far              2 of 2 habits
───────────────────────────────────────
Needs attention
 🏋  Gym              1 of 3 this week · 2 days left
 📖  Read             4 of 5 days
```

| # | Element | What it answers | Evidence |
|---|---|---|---|
| 1 | **A percentage of the day-by-day habits** ("96% of daily habits done") | "How did my week go?" | Users show: the most-asked combined figure. 302 reviews in 47 apps ask for an overall percentage or a day's share (§3) |
| 2 | **Last week in the same unit** ("Last week 81%") | "Am I improving?" | Users show: 22 asks in 13 apps. Today's "Last week · 46 of 57" can't be compared with "53 of 55" at a glance; reasoned from first principles |
| 3 | **The seven day rings** (kept) | "Which days went well?" | Users show: "on Monday you did 8/10, on Tuesday 9/10". Kept as decided |
| 4 | **Full days as a share of days** ("3 of 5 days everything done") | "How many perfect days?" | Users show: perfect days are loved (59 praise) when weekly goals and skips can't break them (35 complaints) |
| 5 | **Weekly goals counted by goals** ("1 of 2 weekly goals met so far") | "Are my 3-times-a-week habits on course?" | Users show: weekly goals miscounted is the costliest complaint here (37 reviews, 3.30★) |
| 6 | **Quit habits counted by slips** ("Quit: no slips · 2 of 2 habits") | "Did I stay clean?" | Users show: quit is judged by slips and runs, never a share. Earlier report §10 |
| 7 | **Needs attention**: up to three habits by name, each with its own number | "What do I do about it?" | Users show: 143 asks in 35 apps for "which habits need attention" (§3). The current card has nothing for this |

**Remove:** the "53 of 55" sum as the headline, and "Last week · 46 of 57". Raw numbers stay one tap away, per day in
the Day sheet and in the ⓘ sheet, where they mean something ("Tuesday: 9 of 10 habits").

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
| **One overall percentage** across habits | 276 | 50 | 4.27 | 67 · 191 · 16 | Element 1 |
| **One combined graph over time** | 271 | 40 | 4.29 | 11 · 258 · 1 | Month/Year, not this card (§6) |
| **All habits × days at a glance** (the week grid) | 256 | 49 | 4.36 | 98 · 147 · 0 | Already the habit rows under the card |
| **Which habits are strong, which need attention** | 201 | 41 | 4.36 | 60 · 143 · 0 | Element 7 |
| **Each day's share** ("8 of 10 on Monday") | 174 | 41 | 4.34 | 35 · 130 · 3 | Element 3, Day sheet |
| **A weekly / monthly report** as such | 172 | 38 | 4.34 | 57 · 103 · 3 | The card *is* this |
| **Perfect / full days** | 142 | 26 | 4.20 | 59 · 18 · 35 | Element 4 |
| **Weekly or flexible goals counted wrongly** | 73 | 25 | 3.68 | 13 · 19 · 37 | Elements 1, 5 |
| **Totals** (time spent, counts) | 59 | 29 | 4.27 | 7 · 49 · 1 | Optional line (§4.6) |
| **Quit habits in the overview** | 36 | 11 | 4.50 | 16 · 11 · 2 | Element 6 |
| **Compared with last week** | 31 | 17 | 4.42 | 8 · 22 · 0 | Element 2 |
| **A forgiving measure** (one miss doesn't wipe it) | 24 | 13 | **4.92** | 22 · 2 · 0 | Elements 1, 4 |
| **By category / group** | 33 | 15 | 4.33 | 1 · 31 · 0 | Group chips already filter the card |
| **Shame / pressure from the number** | 11 | 9 | 3.09 | — | Tone (§5) |

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
3. **Weekly goals need their own progress, not a daily share.** "it would be great to have a week view where you can
   see … how much you have left to do that week" (HabitNow, 4★, `53d05a77-686c-4e45-b4f1-c3682066bd3e`); "So i can see
   easily 'D'oh.. i have to do it at least two times more this week'" (HabitBull, 4★,
   `074b9e99-2679-4d2b-acdb-23742c20ecbf`); "tracks per week progress/completion based on the set frequency … knowing
   how much more you need to do to complete your weekly goals" (Loop, 4★, `76fc3a7b-23e2-4e57-93c0-262c4233448b`); a
   week summary showing how many times each habit was done and what share of the week's and month's goals were met (Loop, 4★,
   `e3c47c51-3563-4d1f-92a4-32cc59a86491`, Russian, paraphrased).

---

## 4. The card, element by element

### 4.1 The headline: a percentage of the day-by-day habits

- **Text:** "96%" large. Under it, "of daily habits done". When a group chip is chosen, "of Health habits done".
- **What counts:** every habit judged day by day (check-off, amount, time, checklist, specific days, every N days,
  daily limits once the day is over), once per planned day, up to today. Today counts only what's done. Skipped,
  paused, not-yet-started and archived days don't count. All of this is unchanged.
- **What changes:** **weekly, monthly and flexible ("N days a week") goals leave this number** and get their own line
  (§4.4). Then 0-of-3 gym can no longer hide behind a 96%, and weekly logs can no longer inflate it.
- **"Daily habits"** is the wording because it's what these habits are to the person. The ⓘ sheet says exactly what is
  in it.
- **Why a percentage and not "53 of 55"** (users show + outside evidence): people ask in percentages (§3). Natural
  frequencies ("9 of 10") beat percentages only when the counted thing is natural: a person or a day, not a habit-day
  ([Gigerenzer & Hoffrage, 1995](https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2015.00642/full)).
  So natural fractions go where they are natural: per day (rings, Day sheet), in days (§4.3) and in goals (§4.4).
- **Why it stays forgiving** (users show): "If I break a streak I don't feel so defeated since I can see the total
  completion rate" (everyday, 5★, `11397647494`); "it gives you an overall percentage, which I find really helps
  motivate me even if a streak is broken" (HabitBull, 5★, `051607de-1ae0-44ea-94b0-71b1b1a37a4d`). One miss costs a
  few points, not the week. Outside evidence agrees: missing one day did not materially affect habit formation
  ([Lally et al., 2010](https://bps.org.uk/research-digest/how-form-habit)), while all-or-nothing framing after one
  lapse leads people to drop the goal (the "what-the-hell" effect, [summary](https://more.efpsa.org/rpblog/?p=1172)).
- **Shown when** at least one daily habit had a planned day this week. Never "0 of 0", never 0% (as now).

### 4.2 Last week, in the same unit

- "Last week 81%". Plain text, no arrow, no colour, hidden while percentages are hidden (the View Options rule). In
  Month, "August 74%".
- Users show: "I want to see how disciplined I've become since last week … last week 75% … this week done only 71%"
  (Loop, 4★, `f9aa4227-c189-4278-87f7-8caa9f2a9b38`); "Or like how I was this week compared to last week" (Awesome Habits, 5★, `7229548903`). A week is also the natural fresh start: commitments rise right after Mondays
  ([Dai, Milkman & Riis, 2014](https://knowledge.wharton.upenn.edu/article/need-fresh-start-heres-begin/)). So each
  week starts clean and is compared with the last, not with all time.
- **Mid-week fairness** (reasoned from first principles): a running week has fewer days than last week, but a
  percentage of planned days is already fair to that. Say "so far" in the period line, not in every caption.

### 4.3 Full days, as a share of days

- "3 of 5 days" with "everything done" under it, instead of a bare "3". The denominator is the number of days so far
  that had something planned. The existing 80% / 60% threshold from View Options stays.
- Users show it motivates: "I'm always looking to see what little things I can do to increase my percentage or have a
  perfect day" (Habit Tracker, 5★, `8994676845`); Productive's perfect days carry 59 praise reviews. It goes wrong only when weekly
  goals, skips or pauses break a day: "If I set something to be done 4 times a week … it always marks the days as not
  perfect" (Productive, 4★, `2395740335`), 35 complaints at 3.31★. The app already keeps weekly goals and skipped days
  out of a full day. Keep it that way.
- It is a secondary number, never the headline: an all-or-nothing day means "If you complete 9/10 task the app will record you do nothing" (Eden, 3★,
  `12251741381`) and means "completing six feels the same as one" (Productive, 4★, `1565906427`).

### 4.4 Weekly goals, counted as goals

- "1 of 2 weekly goals met so far". Shown only when the person has week goals. Mostly unchanged; the difference is that
  these habits now live *only* here and in §4.5, not inside the percentage.
- **Flexible "N days a week" habits join this count** (they're judged by the week, like "3 times a week"). Week limits
  ("at most 3 drinks a week") count as met once the week ends within the limit, and appear in §4.5 when over it.
- Monthly and yearly goals stay off the Week card. They are on the Month card and in their own rows.

### 4.5 Needs attention: the habits behind their own plan, by name

The current card has no answer to the most practical question. Add a short list under the numbers.

| Habit kind | Listed when | Text |
|---|---|---|
| Daily, specific days, every N days | At least one planned day before today was not done | "Read · 4 of 5 days" |
| Daily amount or time | Same, counting part days as not done | "Water · 3 of 5 days" |
| Weekly goal / N days a week | Not met yet | "Gym · 1 of 3 · 2 days left"; past week: "Gym · 1 of 3" |
| Daily or weekly limit | Over the limit on a day / the week | "Coffee · over on 2 days" |
| Quit | Never here (§4.6) | — |

- **Order:** weekly goals with the least room first (the most still needed for the days left), then day habits by
  fewest days done. **At most three**, then "and 2 more" which scrolls to the habit rows below. When nothing qualifies:
  one line, "Every habit on plan so far".
- **Tone** (decided earlier and kept): no red, no "missed", no "failed", no grade. Just the habit's own number. Users show
  what goes wrong: "Always opens to bad news ... Overall percentage failure" (HabitBull, 3★,
  `83a077dc-1175-4280-8983-ac7cb330d5bd`).
- **Why not a "10 of 12 habits on track" headline instead** (reasoned from first principles): for a daily habit, one
  missed day would make it "not on track" for the rest of the week. Users show where that leads: "once you've broken a
  streak, that week is lost, isn't it? Tempting not to bother till the next Monday" (HabitBull, 4★,
  `6e034ffb-761f-4d1b-8d99-69e6aede544a`). Naming the habits with their numbers gives the same information without
  turning a week into pass/fail.
- **Tapping** a name opens that habit's page, as the rows already do. Progress never logs.

### 4.6 Quit habits, counted by slips

- One line when the person has quit habits: "Quit: no slips · 2 of 2 habits", or "Quit: 1 slip this week". Tapping
  scrolls to the Quitting section, which already shows each current run.
- **Never inside the percentage**, and never a score (earlier report §10). Users show both sides: seeing all quit
  counters together helps ("If I slip in one area I am encouraged by success in the other areas", Days Since, 5★,
  `9511554988`), and counting slips keeps people honest ("I used to think, oh I only smoked like one night this week…
  nope think again, more like 3!", Way of Life, 5★, `1453443526`). But a slip should cost a line, not the week. That is the
  relapse-prevention point about all-or-nothing thinking after a lapse
  ([abstinence violation effect](https://www.mayo.edu/research/documents/relapse-prevention-mdash-moran/DOC-20003018)).

### 4.7 Optional, not by default: time on timed habits

- "4 h 10 min on timed habits" when two or more habits are measured in time. Minutes add up honestly; kilometres,
  glasses and ticks don't, so nothing else is summed.
- Users show a modest ask (49 reviews in 24 apps for totals; "how much productive time I had today … I have to count
  the time myself", HabitNow, 3★, `ead6336e-4dc8-4098-be4e-d6b66b2ef1b7`). Behind the View Options switch, off by
  default, because users also ask for a calm card ("Now it have lot of data, that's cool but, the simplicity and general resume of
  your habits is gone", Habitify, 3★, `0f6507c6-7cc0-4d02-8928-d25305087b74`).

### 4.8 The ⓘ sheet, rewritten

"**Daily habits:** each habit counts once on each day it was planned. Today counts what's done. Skipped and paused days
don't count. **Weekly goals** count once, when met. **Quit habits** count slips, not days. **Full days** are days
everything planned was done." Users ask for exactly this: a box that explains how the percentages are calculated
(Habitify, 4★, `3159218172`, Spanish, paraphrased).

---

## 5. Every kind of habit, and where it shows

| Kind | Headline % | Rings | Full days | Weekly goals line | Quit line | Needs attention |
|---|---|---|---|---|---|---|
| Check-off, daily or on set days | ✓ per planned day | ✓ | ✓ | — | — | days not done |
| Amount / time, daily goal | ✓ when met | ✓ part fill | ✓ when met | — | — | days not met |
| Checklist | ✓ when its rule is met | ✓ part fill | ✓ | — | — | days not met |
| Every N days | ✓ per due day | ✓ | ✓ | — | — | due days not done |
| N days a week (flexible) | — (moved) | logged days show | — | ✓ | — | still needed |
| N times a week / week amount | — (as now, but no longer +1/+1) | logged days show | — | ✓ | — | still needed |
| Monthly, yearly goals | — | logged days show | — | — (Month card) | — | — |
| Daily limit (cut down) | ✓ once the day is over | ✓ after the day | ✓ | — | — | days over |
| Weekly limit | — | — | — | ✓ at week end | — | when over |
| Quit | — | — | — | — | ✓ slips | — |
| Task | — | — | — | — | — | — (as decided) |

---

## 6. What not to put on this card

- **A sum of habit-days** ("53 of 55"). An invisible unit (§2).
- **A single score** that blends kinds, weights, points or "strength". 54 complaints at 2.96★ about combined numbers
  being wrong or opaque, and specific complaints about Loop's, Productive's and HabitBull's scores (§2.2). Two
  reviewers ask for weights (`d1fb6a31-09e1-4478-827d-8428bfb6b0df` among them). Weights need setting and explaining,
  which is too much for a card meant to be glanced at.
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
| Natural frequencies are understood far better than percentages, when the counted thing is natural | [Gigerenzer & Hoffrage, 1995](https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2015.00642/full) | Fractions in days, goals and per day; a % over habit-days |
| Missing one day did not materially affect habit formation | [Lally et al., 2010](https://bps.org.uk/research-digest/how-form-habit) | A forgiving headline |
| One lapse under all-or-nothing rules leads people to abandon the goal | ["What-the-hell" effect](https://more.efpsa.org/rpblog/?p=1172); [abstinence violation effect](https://www.mayo.edu/research/documents/relapse-prevention-mdash-moran/DOC-20003018) | No pass/fail week; quit counts slips |
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
