# Built-in Trackers — The Market and What Fits Version 2

Written by Claude (Claude Code), 17 October 2026.

**The question (the user, 17 Oct 2026):** version 2 adds a library of built-in trackers. A person picks one, it joins
Today as a normal row in a section of their choosing (Morning, Anytime…) with a reminder, and its settings are its own
(not the habit form). Mood ("How was today?") is the first. **Across every tracker on the market, which others should
the library have?**

**The short answer:** of 42 kinds of tracker on the stores, only about six need a tracker of their own. About fifteen
more are already habits the app can track today; they belong in the library as ready-made habits (templates), not
trackers. The rest are separate products (medical, money, babies, GPS) and stay out.

| Group | Kinds | What the library does |
|---|---|---|
| **A. Trackers of their own** (a new kind of record) | Sleep, Weight (later with body measurements), Energy and stress (one scale, like Mood), Fasting, Gratitude, Steps and exercise from Apple Health / Health Connect | Built as trackers, like Mood |
| **B. Already habits** | Water, meditation, reading, study / focus, medication, vitamins, quit smoking, sobriety, days since, the five daily prayers, Bible reading, skincare, kegel, cleaning, plant watering, pet care, caffeine | Offered as ready-made habits the person can edit |
| **C. Separate products** | Period, pregnancy, calories / food, blood pressure, blood sugar, heart rate, migraine and symptom diaries, bowel / IBS, baby, money, time tracking, GPS running, gym sets and reps, screen time | Left out |

Recommended for version 2, in this order: **Sleep, Weight, Energy, then Fasting or Gratitude** (Part 4).

---

## 1. How this was measured

- **Google Play (US, English):** one search per kind of tracker (the term is in the data file), the first 8 apps
  returned, and each app's public download band ("10M+") read from its store page.
- **App Store (US):** the same search through Apple's search API, the first 8 apps and each one's **US rating count**.
  A rating count is not a download count and is never treated as one (Rulebook W2).
- Observed 17 Oct 2026, 14:05 UTC. 42 kinds, 672 rows:
  [`Built-in Trackers Data/tracker_market_survey.csv`](<Built-in Trackers Data/tracker_market_survey.csv>). The
  script and its cached store pages are in `Research/Temp/tracker_survey_2026_10_17/` (not in git).
- **Limits.** One search term per kind, in one country, in English. Search order is the store's ranking, not market
  share, and a well-known leader can rank below the first 8 for the one term searched, so it would be missing here. Play bands are lower bounds for all-time installs worldwide. Treat
  every number as "at least this big".
- **Review evidence** comes from our own Feature Ledger (100 habit apps' reviews). It covers habit apps only, so it says
  what habit-app users ask for, not what users of sleep or period apps want. Where the ledger has nothing, this report
  says "reasoned from first principles" (Research/CLAUDE.md).

## 2. The whole market at a glance

The largest Play band in each kind's first 8 results, and the largest US App Store rating count. "Group" is where
Part 3 puts it.

| Kind | Biggest on Play (band) | Biggest on App Store (US ratings) | What people log | Group |
|---|---|---|---|---|
| Mood | Daylio 10M+ | DailyBean 70,818 · Daylio 62,076 | a face a day | **A** (built) |
| Journal / gratitude | Gratitude: Self-Care Journal 5M+ · Presently 1M+ | Apple's Journal 332,547 · Day One 118,593 | a few lines a day | **A** |
| Sleep | Sleep Cycle, Sleep as Android, ShutEye, BetterSleep 10M+ each | ShutEye 350,045 · SleepWatch 328,437 | hours, bed/wake times, quality | **A** |
| Weight | Monitor Your Weight 10M+ | Happy Scale 58,094 | one number, a trend | **A** |
| Body measurements | Body Measurement & Weight Loss 1M+ | MeThreeSixty 18,418 | waist, hips… | A, later with Weight |
| Energy / chronic illness | Bearable 500K+ · Visible 100K+ | Juno 10,208 · Bearable 6,494 | a scale a day | **A** (as a scale) |
| Anxiety / stress | Anxiety Tracker 100K+ (Daylio leads the search) | StressWatch 24,462 | a scale a day | **A** (as a scale) |
| Fasting | Leap Fitness "Fasting" 50M+ · BodyFast 10M+ | Zero 445,288 | start and end of a fast | **A** |
| Steps | Leap Fitness pedometers 100M+ · Google Fit 100M+ | Sweatcoin 400,566 · Pacer 334,713 | read from the phone | **A** (from Health) |
| Workouts / gym | Leap Fitness gym log 10M+ · Hevy 5M+ | Fitbod 287,607 · Strong 108,535 | sets, reps, weights | C (exercise minutes from Health fit A) |
| Running | Strava 100M+ | Map My Run 755,634 | GPS routes | C |
| Water | Water Reminder 10M+ · Leap Fitness 10M+ | Waterllama 163,160 · Plant Nanny 106,526 | glasses or ml | **B** |
| Meditation | Calm 50M+ · Headspace, Insight Timer 10M+ | Calm 1,988,219 · Headspace 973,782 | minutes | **B** (content is C) |
| Quit smoking | Quit Tracker, QuitNow 5M+ | Smoke Free 57,278 | time since the last one | **B** (quit habit) |
| Sobriety / alcohol | I Am Sober 10M+ | I Am Sober 189,039 | days since | **B** (quit habit) |
| Days since / countdown | Simple Days Counter, Days Since 100K+ | DayCount 26,263 · Days Since 19,470 | days since | **B** (quit habit) |
| Focus / pomodoro | Focus To-Do 10M+ | Forest 49,541 | minutes | **B** (timer habit) |
| Study time | Forest, Focus To-Do 10M+ | Flora 82,880 · Study Bunny 21,764 | minutes | **B** (timer habit) |
| Reading | Goodreads 10M+ · Bookmory 1M+ | Goodreads 758,705 · Fable 81,931 | pages or minutes (books are C) | **B** |
| Medication | Medisafe, MyTherapy 5M+ | Medisafe 101,478 | taken / not taken | **B** |
| Supplements / vitamins | largest 5K+ | SuppCo 31,121 (a scanner) | taken / not taken | **B** |
| Caffeine | largest 10K+ | HiCoffee 843 | cups, a limit | **B** (cut-down habit) |
| Prayer | Muslim Pro 100M+ (prayer times, Quran); trackers 5te5 500K+ | Prayminder 4,854 | five prayers a day | **B** (checklist) |
| Bible reading | YouVersion 100M+ | YouVersion's Bible 13,837,716 | a chapter a day | **B** |
| Skincare | Skin Bliss 1M+ | BasicBeauty 608 | morning / evening steps | **B** (checklist) |
| Kegel / pelvic floor | Kegel Trainer, Kegel Men 1M+ | Dr. Kegel 46,403 | sessions | **B** |
| Cleaning / chores | Tody, Sweepy 1M+ | FlyLady 23,113 · Tody 10,765 | rooms, every N days | **B** |
| Plant care | PictureThis 50M+ (identifying) · Planta 1M+ | PictureThis 1,119,757 | watering every N days | **B** (identifying is C) |
| Pet care | largest 100K+ | PetDesk 507,488 (vets) | walks, feeding, meds | **B** |
| Period / cycle | Flo, Period Calendar 100M+ · Clue 50M+ | Flo 1,998,429 · Clue 405,820 | days, symptoms, predictions | C |
| Pregnancy | Pregnancy+ 50M+ | What to Expect 380,280 | weeks, appointments | C |
| Calories / food | MyFitnessPal 100M+ | MyFitnessPal 2,379,247 · Lose It! 781,281 · Cal AI 371,083 | every meal | C |
| Blood pressure | Blood Pressure Tracker 5M+ | SmartBP 60,673 | two numbers and pulse | C |
| Blood sugar | mySugr 5M+ | mySugr 33,339 | readings, insulin | C |
| Heart rate | Instant Heart Rate 10M+ | Instant Heart Rate 228,949 | camera reading | C |
| Symptoms | Bearable 500K+ | Bearable 6,494 | many scales and notes | C (energy and stress fit A) |
| Migraine | Migraine Buddy 1M+ | Migraine Buddy 42,103 | attacks, triggers, medicine | C |
| Bowel / IBS | Happy Poop, Poop Tracker 500K+ | Happy Poop 2,720 | each visit, type | C |
| Baby | Baby+ 5M+ · Baby Tracker 1M+ | Baby Tracker 227,351 | feeds, nappies, sleep | C |
| Expenses | Wallet, Money Manager 10M+ | Rocket Money 399,872 · Expensify 157,686 | every payment | C |
| Time tracking | Toggl Track 1M+ | Hours Tracker 56,377 | hours per project | C |
| Screen time | StayFree 10M+ | Opal 89,917 | read from the phone | C |

**Two things the map shows:**

1. **Single trackers are a portfolio business.** One developer, Leap Fitness Group, is in the first 8 for eight kinds
   (sleep, water, fasting, steps, period, running, gym, heart rate), each a separate app. Daylio's developer (Habitics)
   put weight in a separate app (Weight Tracker, BMI Calculator, 1M+) rather than inside Daylio. Simple trackers are
   cheap to make, so they're mostly won with store listings and keywords, not features. This supports the earlier
   conclusion: the logging itself is the commodity.
2. **The kinds worth the most need what we don't do:** food databases or photo AI (calories), predictions (period,
   pregnancy), medical judgement (blood pressure, sugar, migraine), sensors and GPS (heart rate, running). Those are
   group C.

## 3. The test each kind had to pass

A kind is a **tracker of its own (A)** only if all five hold:

1. **It's a different kind of record.** A habit adds things up toward a goal or counts time since a slip. A tracker
   records something else: a feeling on a scale, a body measurement where the latest value counts and not the sum
   (habit-app users show the problem: one app "read weight as an entry count", report 25 in C021), a span that crosses
   midnight (sleep, a fast), or a few lines of text.
2. **It can be done in one tap, one number or a few words a day**, so it fits a row on Today and the round button.
3. **It helps explain the person's habits.** That's what makes it a complement, not a second app inside ours.
4. **It needs no medical judgement and no predictions.** Being wrong there costs more than being absent.
5. **It works offline with no server of ours** (D1, D16), and with nothing that counts against anyone (U3).

A kind that fails test 1 but is common becomes a **ready-made habit (B)**. A kind that fails tests 4 or 5, or needs a
whole product around it, is **left out (C)**.

## 4. Group A: the trackers worth building

### 4.1 Sleep — first

- **Market:** four apps at 10M+ on Play; ShutEye and SleepWatch over 300,000 US ratings each.
- **Users show:** habit-app users want sleep (with weight, mindful minutes and workouts) synced from Apple Health
  instead of typed in (report 50, in C021); Apple Health is a reason to buy in our corpus (C021: "I paid for it
  specifically for synching with the health app").
- **What it records:** hours slept, bedtime and wake time; quality as an optional face.
- **Where it sits:** Morning (the night just ended). It belongs to the day you woke up on (to be written down per D7).
- **The round button:** shows last night's hours when Apple Health / Health Connect has them; otherwise opens a quick
  entry ("Went to bed · Woke up").
- **Its settings:** read from Apple Health / Health Connect or log it myself; a target number of hours (never shown as
  failure).
- **Explains habits:** sleep against everything else is the most useful link we could show.
- **Watch out:** reading Health on the Watch and the iPad (no Health on the iPad: manual only); several sleep sessions in
  a night (naps); nights that cross a day start of 3 AM.

### 4.2 Weight — second (body measurements later, in the same tracker)

- **Market:** Monitor Your Weight 10M+; Happy Scale 58,094 US ratings; Daylio's maker sells one at 1M+.
- **Users show:** HelloHabit bundles a body-weight tracker (report 50, C049); "weight sync would move the rating to 5"
  (report 50, C021); fitness and weight is among the largest named uses of habit apps (C067: "80 lbs lost").
- **What it records:** one number, in kg or lb (stones later), the latest of the day counts; a trend line.
- **Where it sits:** Morning.
- **Its settings:** unit; read from Apple Health / Health Connect; whether to show the trend; an optional goal weight
  and direction (lose, gain, keep).
- **Watch out:** this is the tracker most likely to hurt someone. No red, no "gained", no shame (U3), and a way to hide
  the numbers from Today and widgets (a row can show "Logged" instead of the number).

### 4.3 Energy and stress — third, and nearly free

- **Market:** Bearable 500K+, Visible 100K+, Juno and StressWatch on the App Store; a niche on its own, but it costs us
  almost nothing because it is Mood's scale again.
- **Users show:** a lifetime buyer with ADHD asked for "a mood/energy tracker so the statistics screen can answer why a
  habit failed" (report 25, C049). Our corpus leans towards ADHD and chronic-illness users (C042).
- **What it records:** a five-step scale a day (Energy: Drained … Full; Stress: Calm … Overwhelmed).
- **Where it sits:** best as an optional second question under "How was today?" rather than its own row, so Today
  doesn't fill with check-ins (reasoned from first principles). The person can turn it on in Mood's settings.

### 4.4 Fasting — fourth, if the day rules are ready

- **Market:** large. Leap Fitness's Fasting app 50M+, BodyFast and GoFasting 10M+; Zero 445,288 US ratings.
- **Users show:** nothing. Fasting isn't mentioned in our habit-app corpus, so this is reasoned from first principles
  and from market size.
- **What it records:** start and end of a fast, a target (16:8, 18:6, 20:4, custom), elapsed time.
- **The round button:** ▶ starts a fast, ■ ends it; the clock runs on the row like a timer habit (S3: only the
  smallest view ticks), on the Watch and the Live Activity.
- **Watch out:** a fast crosses midnight and the day start. Which day does a 20:00 → 12:00 fast count for? (Proposed:
  the day it ends.) This is a new D7 rule and must be in the shared core's golden cases (T21) before it's built. Keep it
  away from health claims ("burns fat").

### 4.5 Gratitude — fourth, the alternative to Fasting

- **Market:** Gratitude: Self-Care Journal 5M+, Presently 1M+; Day One 118,593 US ratings.
- **Users show:** a journal or gratitude note per day was asked for in several apps (reports 25 and 26 in C172;
  themed mood, gratitude and day-rating logging, report 58 in C049); daily prompts split people ("simply yet
  engaging" against "doesn't really have a point", report 27 in C172).
- **What it records:** three short lines ("Three good things today").
- **Where it sits:** Evening, next to Mood.
- **Watch out:** "How was today?" already has a day note. Gratitude must not become a second, competing note. One
  option is a gratitude prompt inside the day note (Mood's setting) rather than its own tracker. Decide this with Mood.

### 4.6 Steps and exercise from Apple Health / Health Connect — better as a link than a tracker

- **Market:** the biggest of all (pedometers 100M+ on Play; Pacer and StepsApp over 300,000 US ratings).
- **Users show:** Apple Health auto-completion is the strongest purchase reason in our corpus (C021: "the single
  highest-leverage integration in the category"; "Coming from Grit, I almost instantly bought it because the Apple
  Health habits actually work"), and it's also where apps break most visibly ("steps off by 568", "step counting
  starting at 04:00").
- **Recommendation:** don't make "Steps" a tracker. Let **any amount or time habit read from Health** (a 10,000-step
  habit, 30 exercise minutes, mindful minutes, water) and fill itself. That covers steps, exercise, mindful minutes and
  more at once, and is a strong Plus candidate. Sleep and Weight above use the same link.
- **Watch out:** read the person's day start (D7), not midnight; never fill a habit with data from before it existed.

## 5. Group B: offer them as ready-made habits, not trackers

Each of these is already a habit kind the app has (an amount, a time, a check, a checklist, quit or cut down). As
trackers they would be locked-down copies of something people can already make, and lose what people can change today
(U5). In the library they come ready to use and stay editable.

| Ready-made habit | Our kind | Notes |
|---|---|---|
| Drink water | amount (glasses or ml) | units matter to people: "In Europe we have no idea what a US Fl Oz is!" (report 53, C048) |
| Meditate | time | can read mindful minutes from Health (4.6) |
| Read | amount (pages) or time | books and shelves are Goodreads' job |
| Study / focus | time | the timer already does this |
| Take medication · Take vitamins | check, with reminders | reminders must be reliable before we offer medication (C042 audience) |
| Quit smoking · Stay sober · Days since… | quit habit | our quit habits already show time since the last slip and the best run; the ledger's own finding is that quitting belongs inside the habit app as a habit type (C309) |
| Cut down on caffeine | cut-down habit (at most N cups) | |
| Five daily prayers | checklist (Fajr, Dhuhr, Asr, Maghrib, Isha) | prayer times by location are a separate feature; asked for once in our corpus, limited evidence (report 7) |
| Read the Bible | check or amount (chapters) | a reading plan is content, not tracking |
| Skincare routine | checklist (morning, evening) | |
| Kegel exercises | check or amount | |
| Clean the house | tasks and habits every N days | Tody and Sweepy show the demand (1M+ each) |
| Water the plants · Walk the dog | every N days / daily check | |

Templates also help people get started and can each get a page on our website, which is how a single app can show up
in search for many kinds of tracking (reasoned from first principles). The survey shows it can happen in the stores too:
a general app named "Habit Tracker" (148,007 US ratings) is in the App Store's first 8 for both "water tracker" and
"skincare routine tracker".

## 6. Group C: leave to dedicated apps

| Kind | Why it stays out |
|---|---|
| Period, pregnancy | People expect predictions, fertility windows and medical content; the leaders (Flo 100M+, Clue) are built on them. It's logged a few days a month, so a Today row every day is wrong. Apple Health already tracks cycles. Habit-app users barely ask (only Dear Me lists cycle tracking, in our corpus). Revisit only as "show Health's cycle data as context". |
| Calories, food | Needs a food database or photo AI on a server (Cal AI); D16 rules out a server holding people's data. |
| Blood pressure, blood sugar, heart rate, migraine | Medical readings and judgement (what's high, what triggers what); a wrong answer costs more than no answer. |
| Symptom diaries, bowel / IBS | Bearable's niche needs many scales, notes and correlations at once; we take only the simple scale (Energy, Stress) in 4.3. |
| Baby | A different person is tracked (the baby), many events a day; a separate product. |
| Money, time tracking | Different products with their own reports and exports. |
| GPS running, gym sets and reps | Need maps, sensors, exercise libraries; exercise minutes come in through Health (4.6). |
| Screen time | On iOS an app can show Screen Time inside Apple's own report view but can't read the numbers into its own data, so it can't sit on a row or in Progress. Android could; leave until both work the same way (the user, 11 Oct 2026: the platforms work the same). |

## 7. What to decide before designing

1. **The order:** Sleep, Weight, Energy, then Fasting or Gratitude (this report's recommendation).
2. **Energy and Gratitude as part of "How was today?"** (an optional second question, a gratitude prompt in the note)
   or as rows of their own.
3. **Which day a span belongs to** (sleep: the day you woke up; a fast: the day it ended), as D7 rules with golden
   cases in the core.
4. **Health as a Plus feature** (any habit filled from Apple Health / Health Connect) or free.
5. **What counts as done for a tracker** (proposed earlier: logged = done for the day, nothing counts against a day
   without it, U3).

## Sources

- Store survey data: [`Built-in Trackers Data/tracker_market_survey.csv`](<Built-in Trackers Data/tracker_market_survey.csv>)
  (Google Play US search and store pages; Apple iTunes Search API, US; 17 Oct 2026).
- Our review evidence: [Feature Ledger](<../Feature Ledger.md>) cards C021 (Apple Health), C042 (ADHD, medication and
  chronic-illness users), C048 (flexible units), C049 (mood tracker), C067 (fitness and health use), C172 (day and
  habit notes, journal text), C309 (quitting as a habit type).
- Our design: Figma, section "How was today: mood and the day's note" (node 2037:2).
