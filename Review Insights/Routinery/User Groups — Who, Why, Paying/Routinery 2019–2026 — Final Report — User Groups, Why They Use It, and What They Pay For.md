# Routinery 2019–2026, Final Report: User Groups, Why They Use It, and What They Pay For

Written by Claude (Claude Code), 26 November 2026, at the user's request: *"combine all of the 8 years together and
create the final report."*

**What this is.** Eight years of Routinery's store reviews read as UX user research: **who the target users are**
(groups of people who share a pain point), **why each group uses the app**, **which free features each group values**,
and **who pays, how many, and for what**. It brings together the eight yearly reports in this folder
([2019](<Routinery 2019 — User Groups, Why They Use It, and What They Pay For.md>),
[2020](<Routinery 2020 — User Groups, Why They Use It, and What They Pay For.md>),
[2021](<Routinery 2021 — User Groups, Why They Use It, and What They Pay For.md>),
[2022](<Routinery 2022 — User Groups, Why They Use It, and What They Pay For.md>),
[2023](<Routinery 2023 — User Groups, Why They Use It, and What They Pay For.md>),
[2024](<Routinery 2024 — User Groups, Why They Use It, and What They Pay For.md>),
[2025](<Routinery 2025 — User Groups, Why They Use It, and What They Pay For.md>),
[2026](<Routinery 2026 — User Groups, Why They Use It, and What They Pay For.md>)).

**How it was done.** From the reviews alone, as research for a new product or a full rebuild. No product of ours, its
features or its code was used to choose, read, group or recommend anything.

**Source.** All 9,644 checked review labels in `Review Labels/Routinery/<YEAR>/labels.jsonl`, 1 January 2019 to
7 September 2026 (the day before the reviews were collected). The groups are the hand-made maps in
[`Tools/groups_<YEAR>.py`](<Tools/>), one per year, made by reading every review that says who the person is or why
they came; the totals here are those maps added up. Paying reasons, objections and routine-limit counts are the
hand sorts in each yearly report. Every review ID cited is in the yearly reports' appendices; [README.md](<README.md>)
explains the method.

**Counting people.** A person is counted once per year, in every group their words describe. Reviewers have no
stable identity across years, so "people" in the totals means **person-years**: someone who reviewed in 2021 and
again in 2024 would count twice. This affects few people and none of the conclusions.

---

## The short answer

**1,276 people named a pain point** across eight years (13% of 9,644 reviews). They fall into ten groups, and **four
of them make up the target user**: people with ADHD and similar conditions, people who lose time, people who can't
start, and people whose mornings go badly. Most belong to more than one.

| # | User group (the pain point) | People, 2019–2026 | Share of the 1,276 | ★ | Paid or trial | Trend |
|---|---|---|---|---|---|---|
| 1 | **Have ADHD, autism, executive dysfunction, depression, anxiety or another condition** | 431 | **34%** | 4.61 | 29 | 15% (2020) → 45% (2022) → 38–42% since 2024 |
| 2 | **Lose time:** distracted (above all by the phone), time blindness, always late | 323 | 25% | 4.68 | 22 | 20–24% to 2023, then 26–33% |
| 3 | **Can't start or keep going:** procrastinate, quit after three days, no willpower, paralysis | 315 | 25% | **4.80** | 18 | 27–28% to 2023, 17–24% since |
| 4 | **Mornings go badly:** oversleep, groggy, rushing, late for work or school | 240 | 19% | 4.75 | 6 | 31% (2020), then 10–21% |
| 5 | **Tried other apps, planners or paper; nothing stuck** | 165 | 13% | 4.74 | 15 | 28% (2021), then 7–10% |
| 6 | **Forget steps and small habits** (teeth, medication, the next step) | 110 | 9% | 4.52 | 10 | 6–11% every year |
| 7 | **Overwhelmed:** long lists, busy lives, other apps too complicated | 64 | 5% | 4.69 | 2 | from 2021: 4–8% |
| 8 | **Parents and carers**, usually running a child's routine too | 59 | 5% | 4.66 | 7 | 3–7% |
| 9 | **Lost their structure:** COVID, working from home, a baby, grief, burnout | 47 | 4% | 4.79 | 3 | 11% (2020), then 2–3% |
| 10 | **Follow a method:** Atomic Habits, Tiny Habits, The Miracle Morning | 22 | 2% | **4.82** | 2 | 6% (2020), then 0–2% |

  411 of the 1,276 are in more than one group. 348 more people name only a goal ("build habits", "a morning routine").

- **Why they use it: one job, every year.** The app **walks them through a routine one step at a time, with a timer
  on every step**, so they don't have to remember what's next, decide, watch the clock or find willpower. In their
  words: *"The timers remove dilly-dallying that I end up doing between actions"* (2020); *"기계가 시키는데로 하면좋겠다싶었는데"*, "I wished I
  could just do what a machine told me" (2021, in Korean); *"No more decision paralysis!"* (2026). People with ADHD describe the
  same job in their own terms: *"as important as medication for my ADHD"* (2025).
- **The target user moved, the job didn't.** In 2020 the biggest group was people whose mornings went badly (31%), in a
  COVID year. From 2022 it has been **people with ADHD** (and autism, executive dysfunction, depression, anxiety), who
  hear about the app from each other, from therapists and on ADHD forums. **345 people name ADHD or ADD themselves.**
- **Free features valued, by group:** the **timer on every step** first for people with ADHD, people who lose time,
  people who can't start and people whose mornings go badly; **encouraging words and the voice** for people who can't
  start (46); **reminders** for people with ADHD (43) and the forgetful (16 of 110); simplicity everywhere.
- **Paying:** 393 people (4.1%) say they paid, 39% of the 1,098 who say anything about paying. **Payers mostly pay for
  the whole app working for them** (105 of the 193 who give a reason). When they name a feature it's **more routines**
  (23 of 33). **Korean reviewers pay at 3.3× the English rate** (10.9% against 3.3%), every year.
- **The paywall never moved: the third routine.** About 500 reviews mention the free plan's two-routine limit; about
  400 want more (usually 3–5, often "just one more" for weekends), about 70 say two are enough.
- **The money story turned in 2023.** Payers rated the app as highly as everyone else in 2020–2021 (4.36★ and 4.22★,
  against 4.33★ and 4.29★) and far below it from 2023 (2.72–3.08★), when **bugs** (a quarter to a third of reviews), **unexpected charges** (20–22 a year, mostly
  free trials) and later **ads, upsells and AI features** took over. Objections moved with it: **a subscription
  instead of a one-time price** (2020–2022) → **price** (2023) → **bugs** (2024) → **the free trial** (2025–2026).

---

## 1. Eight years in numbers

| | 2019 | 2020 | 2021 | 2022 | 2023 | 2024 | 2025 | 2026* | All |
|---|---|---|---|---|---|---|---|---|---|
| Reviews | 11 | 1,122 | 1,626 | 1,534 | 1,763 | 1,010 | 1,620 | 958 | **9,644** |
| Average rating | 3.55 | 4.33 | 4.29 | 4.18 | 3.96 | 3.90 | 4.06 | 4.20 | 4.13 |
| Name a pain point | 3 | 166 | 200 | 205 | 177 | 132 | 237 | 156 | **1,276** |
| Share naming a pain point | 27% | 15% | 12% | 13% | 10% | 13% | 15% | 16% | 13% |
| Name only a goal | 0 | 45 | 18 | 8 | 76 | 44 | 93 | 64 | 348 |
| Say they paid | 0 | 25 | 64 | 75 | 71 | 46 | 75 | 37 | **393** |
| Share who say they paid | — | 2.2% | 3.9% | 4.9% | 4.0% | 4.6% | 4.6% | 3.9% | 4.1% |
| Charged unexpectedly | 0 | 2 | 4 | 6 | 20 | 22 | 22 | 14 | 90 |
| Report something broken | 18% | 11% | 14% | 20% | 25% | **30%** | 23% | 17% | 20% |

\* 2026 is 1 January – 7 September.

Across all eight years: Google Play 6,302 (65%), App Store 3,342 (35%; the App Store had more from 2025). Languages:
English 5,622 (58%), Korean 1,384 (14%), Spanish 831 (9%), Japanese 301, French 275, Portuguese 241, Polish 210,
Arabic 166, German 158, Brazilian Portuguese 99. Ratings: 5★ 60%, 4★ 17%, 3★ 8%, 2★ 5%, 1★ 9%. 5,291 reviews (55%)
name a feature they like; 1,098 (11%) say anything about paying.

**Group shares by year** (share of that year's people naming a pain point; 2019's three people left out):

| Group | 2020 | 2021 | 2022 | 2023 | 2024 | 2025 | 2026* | All |
|---|---|---|---|---|---|---|---|---|
| ADHD, autism, executive dysfunction, depression, anxiety | 15% | 24% | **45%** | 30% | 42% | 41% | 38% | **34%** |
| Lose time | 24% | 21% | 20% | 23% | **33%** | 32% | 26% | 25% |
| Can't start or keep going | 27% | 28% | 28% | 28% | 17% | 19% | 24% | 25% |
| Mornings go badly | **31%** | 18% | 10% | 19% | 21% | 17% | 17% | 19% |
| Tried everything else | 16% | **28%** | 10% | 9% | 7% | 10% | 9% | 13% |
| Forget steps | 8% | 6% | 6% | 10% | 11% | 11% | 9% | 9% |
| Overwhelmed | — | 4% | 4% | 6% | 8% | 7% | 7% | 5% |
| Parents and carers | 3% | 3% | 6% | 7% | 3% | 5% | 4% | 5% |
| Lost their structure | **11%** | 2% | 2% | 3% | 3% | 3% | 2% | 4% |
| Follow a method | 6% | 2% | 0.5% | 1% | 0% | 1% | 1% | 2% |

---

## 2. The target users, group by group

### Group 1. Have ADHD, autism, executive dysfunction, depression, anxiety or another condition (431 people, 34%, 4.61★)

**Who they are.** People who say it about themselves: ADHD or ADD above all (345 name it across the years), autism and
AuDHD, executive dysfunction, brain fog from illness, depression, anxiety, bipolar disorder, PTSD, burnout. Adults
diagnosed late, students, people on and off medication, people working with a therapist, **mothers with ADHD getting
children with ADHD out the door**. They often write as a community and arrive by word of mouth: *"It was recommended by
another reddit user with ADHD"* (2021, `2dd9c0ed`), an ADHD community forum (2025, `12562803`), therapists (2025,
`13127830`; 2026 a therapist who uses it for patients).

**The pain, in their words, across the years:**
- *"I have ADHD and it feels impossible sometimes to stay focused and accomplish my goals"* (2020, `1e7aa119`, en, 5★).
- *"I struggle with Executive Dysfunction a LOT"* (2020, `53180359`, en, 5★).
- *"I have ADHD and need to be nudged to do things"* (2021, `7be9312c`, en, 5★).
- *"the executive disfunction caused by my autism"* (2021, `7d94012a`, en, 5★).
- *"Helps me save my executive function reserves for other important daily tasks"* (2023, `5a53035e`, en, 4★).
- *"With ADHD I feel like tasks and time often escape me"* (2024, `409a257f`, en, 5★).
- *"as important as medication for my ADHD"* (2025, `12769141`, en, 5★).
- *"because of my autism, I’m not really able to form habits"* (2025, `12439307`, en, 5★).
- *"Nothing helps my ADHD time blindness more"* (2026, `14223005`, en, 5★).
- *"ADHDでルーティンを維持するのが難しく、このアプリをダウンロードしました"*, "with ADHD it's hard to keep a routine, so I
  downloaded this app" (2026, `9a937167`, ja, 5★).

**What they share with other groups.** Time is their pain as much as attention: 82 of them are also in "lose time",
50 in "can't start", 44 in "mornings go badly", 30 in "forget steps". The ADHD reviewer's problem is usually several
of the other groups' problems at once.

**Free features they value** (all years): **the timer on every step (85)**, simple and clean (60), the look (47),
**reminders and alerts (43, the most of any group)**, encouraging words and the voice (30). They also value seeing
**when the routine will end** and a developer who answers.

**Paying.** 28 paid and 1 trial; 25 use it free and say so; 7 refused; 369 don't say. Of the 62 who say anything, 29
paid or trialled. They pay for the whole app working for their brain (*"Die beste App überhaupt für mein ADHS-Gehirn"*,
"the best app ever for my ADHD brain", 2025, `57c669ed`) and, when they name a feature, for more routines or the
watch. Refusals are about price per year and families: *"I don't want to pay $88 per year for the 4 of us"*, an ADHD
family (2022, `e75d5c70`).

### Group 2. Lose time (323 people, 25%, 4.68★)

**Who they are.** People who drift between actions, get pulled into the phone (YouTube, shorts, Instagram, games),
have time blindness, are always late, or whose days are "a mess". Many are also in the ADHD group; many others don't
name any condition.

**The pain, across the years:**
- *"The timers remove dilly-dallying that I end up doing between actions"* (2020, `8a806edc`, en, 5★).
- *"It turned my phone to a hazardous distraction to a great motivator"* (2020, `1c909b18`, en, 5★).
- *"the time gets away from me and I start day dreaming"* (2021, `89686734`, en, 5★).
- *"antes de tener la app, tardaba horas en salir de casa, porque hacía todo en desorden y me distraía"*, "before the
  app it took me hours to leave the house, because I did everything out of order and got distracted" (2023,
  `99147063`, es, 5★).
- *"No more hours lost doom scrolling before I shower"* (2024, `11641777`, en, 5★).
- *"Protects me from time blindness"* (2025, `12688377`, en, 5★).
- *"Non arrivo più in ritardo!"*, "I'm not late any more!" (2026, `14497138`, it, 5★).

**Free features they value:** **the timer on every step (72; the most named feature of any group in 2023 and 2026)**, simple (47), reminders (30), more than one routine (19), seeing how long things take. Several use a
**smartwatch to leave the phone behind** during a routine.

**Paying:** 19 paid and 3 trials of the 49 who say anything. They pay for the app working (*"has stopped me arriving
late all the time"*, 2025) and for a feature that keeps time: the estimated end time, the history of start and end
times (2022), the Apple Watch timer (2026).

### Group 3. Can't start or keep going (315 people, 25%, 4.80★)

**Who they are.** Procrastinators, self-described lazy people, people who quit new habits within days (*작심삼일*,
"resolve for three days", in Korean reviews), people with no willpower, and, from 2026, people who name **decision
paralysis** and **task-initiation paralysis**. **The highest-rated large group in almost every year.**

**The pain, across the years:**
- *"I would give up so easily or talk myself out of even getting started"* (2020, `58880910`, en, 5★).
- *"끈기도 없고 작심 3일인"*, "I have no persistence and quit everything after three days" (2020, `28c8b64f`, ko, 5★).
- *"나태지옥에서 벗어났습니다"*, "I've escaped laziness hell" (2020, `039c8e46`, ko, 5★).
- *"자기관리에 대한 열망은 높지만 실행력이 떨어지는 20대입니다"*, "I'm in my twenties, with a strong wish to manage myself
  but poor follow-through" (2021, `68830277`, ko, 5★).
- *"I've never stuck to a routine"* (2023, `45169d4b`, en, 5★).
- *"I was in a routine rut until I used this"* (2024, `11537230`, en, 5★).
- *"Have not been able to stick with a routine longer than the first few days"* (2025, `13528082`, en, 5★).
- *"No more decision paralysis!"* (2026, `14055829`, en, 5★).

**Free features they value:** the timer (56), **encouraging words, the voice and "well done" messages (46: the most of
any group)**, simple (45), the look (31), reminders (22). Being told what to do now, and praised for doing it, is what
gets them going.

**Paying:** 18 paid of the 48 who say anything, and **28 say they use it free and are happy to**, the most of any
group. When they pay it's for the whole app or the voice (*"목소리 들어가면 괜히 더 의욕이 생겨서 구독하고 있는중이거든요"*, "the voice makes me more motivated, so I'm
subscribing", 2022, `e46de97c`).

### Group 4. Mornings go badly (240 people, 19%, 4.75★)

**Who they are.** People who oversleep, scroll in bed, fall back asleep, rush, forget things on the way out, and are
late for work, school or the bus. Students (school mornings) and workers (getting ready for work) in about equal
number; in 2020 also people whose routine broke in lockdown. The app began as a morning app (굿모닝, "Good Morning",
2019), and this was its first group.

**The pain, across the years:**
- *"그동안 의지탓을 많이 했었는데 이제는 아침이 달라지는게 느껴지네요"*, "I used to blame my willpower a lot, but now I
  can feel my mornings changing" (2019, `4004808264`, ko, 5★).
- *"매일 아침 늘어지고 늦잠자던 저에게"*, "for me, who dragged and overslept every morning" (2020, `54325467`, ko, 5★).
- *"Not late to work since using this"* (2020, `243a7081`, en, 4★).
- *"I tend to wake up groggy and want to mindlessly scroll"* (2021, `3590da4b`, en, 5★).
- *"Had a normal person morning routine for the first time in my life"* (2021, `78f60a2b`, en, 5★).
- *"I used to miss the bus, be late for school, not make a lunch"* (2023, `96187623`, en, 5★).
- *"I would wake up at 5:30 and barely make it out the door at 6:30"* (2025, `13442882`, en, 5★).
- *"出勤前の焦りが毎日本当にストレスで"*, "the rush before work was really stressful every day" (2026, `13703469`, ja, 5★).

**Free features they value:** **the timer (52)**, simple (32), the look (23), encouraging words (20), being walked
through one step at a time (14).

**Paying: the lowest of the large groups.** 3 paid and 3 trials, against 19 who use it free and say so, of the 26 who
say anything. Two routines (morning and night) is what this group needs, and the free plan gives it.

### Group 5. Tried other apps, planners or paper; nothing stuck (165 people, 13%, 4.74★)

**Who they are.** People who searched for years, used paper, notebooks, spreadsheets, alarms, calendars and other
apps. **The apps they left, in their words:** Fabulous (*"It was all flash and no substance"*, 2021, `f660fd82`;
limited routines, 2023), Tiimo (*"so glitchy it was unusable"*, 2023, `94850989`; *"after tiimo got rid of their routine
settings"*, 2025, `13356551`), me+ (charging for routines, 2025), Habitica, Productive, Structured, checklist habit
trackers, Excel and paper. The biggest share was in 2021 (28%).

- *"I have been looking for a good app to help me with daily routines for years."* (2020, `267725e8`, en, 5★).
- *"Every other habit app I've tried just makes it too damn complicated"* (2021, `e3561b40`, en, 5★).
- *"I came after downloading about 50+ for productivity just because they are complex"* (2021, `af0366c0`, en, 5★).
- *"Dozens of productivity apps have failed me before I found Routinery"* (2022, `86197148`, en, 5★).
- *"I usually download apps like this, use them for a while, then either decide it’s too much work or forget about
  them"* (2026, `14466229`, en, 5★).

**What they left the others for:** too complicated, too much "flash", a checklist instead of a timer, glitches, or
the routine features being taken away or paywalled. **Free features they value:** simple (43), the timer (43), the look
(31), **the free version is enough (12)**. **Paying:** 13 paid and 2 trials of the 34 who say anything.

### Group 6. Forget steps and small habits (110 people, 9%, 4.52★)

**Who they are.** People who forget medication, vitamins, brushing teeth, the next step, things for school or work.
- *"비타민 먹기나 스트레칭 같은건 까먹기 일쑤였는데"*, "I'd always forget things like taking vitamins or stretching" (2020,
  `f01ba046`, ko, 5★).
- *"For me, it's out of sight out of mind"* (2022, `1ca30c61`, en, 5★).
- *"I often forget to take medication"* (2023, `c14ac293`, en, 2★).
- *"Routines and remembering to do certain things (like brush my teeth) has been a NIGHTMARE my entire life"* (2025,
  `12954702`, en, 5★).

**Free features they value:** the timer (22), simple (17), **reminders (16)**, pause or skip (8), seeing when the
routine will end. **Paying:** 9 paid and 1 trial of the 14 who say anything; small numbers.

### Group 7. Overwhelmed (64 people, 5%, 4.69★)

First seen in 2021. People with long to-do lists, many responsibilities (businesses, family, school), or who find
other apps too busy. *"I get overwhelmed with long todo lists"* (2021, `fb61e04b`); *"I tried the fabulous app and it
was overwhelming with too many distractions"* (2021, `79220783`); *"I tend to be overwhelmed with large multi-step
tasks"* (2024, `11617837`). **Free features they value:** simple (19), the timer (11). **Paying:** 1 paid, 1 trial; the
group least likely to pay.

### Group 8. Parents and carers (59 people, 5%, 4.66★)

Parents who **run a routine with or for their child**, or who need one for themselves around children: *"my son and I
have turned it into a challenge"* (2022, `98650d64`); *"아이들 아침 루틴으로 활용중인데요"*, "I'm using it as the
children's morning routine" (2023, `30572d33`); parents with ADHD and children with ADHD (2024–2026). **What they miss:
a family plan** and shared routines: *"$88 per year for the 4 of us"* (2022), *"le partage familial n’est pas activé"*, "Family
Sharing isn't enabled" (2023, `98301200`). **Free features they value:** encouraging words (7), the look (6),
reminders (5). **Paying:** 7 paid; 3 refused, two of them for want of a family price.

### Group 9. Lost their structure (47 people, 4%, 4.79★)

Above all **2020's COVID year** (18 people, 11%): *"요새 코로나 때문에 재택근무하느라 사이클이 완전 무너지면서"*, "lately,
working from home because of COVID, my rhythm completely collapsed" (2020, `59002629`); *"I’d been struggling to find
my pre-pandemic routines"* (2020, `63809630`). Since then: a new baby, a breakup, a broken leg, grief, burnout, going
back to school or work. Small but steady: a life event that removes the day's structure.

### Group 10. Follow a method (22 people, 2%, 4.82★)

Readers of **Atomic Habits** and **Tiny Habits** (*"when I read that the developers use B.J Fogg"*, 2020,
`67665517`), **The Miracle Morning**, the Bullet Journal, habit stacking. The highest-rated group, and the smallest.

### People who name only a goal (348 people, 4.39★)

"Build good habits", "a morning and night routine", New Year resolutions, a "glow up" (a wave of young reviewers in
July 2023). They name the same free features as everyone else (simple 55, the look 40, the timer 31) and pay at a
similar rate (19 paid, 2 trials). The rise from 2023 reflects how the labels recorded reasons, not a change in
users.

---

## 3. Why they use it, and the free features each group values

**One job.** Every group, every year, describes the same thing: the app **puts the routine in order, puts a timer on
each step, and tells them when to move on**. What differs is *why* they need that:

| Group | Why the step-by-step timer helps them |
|---|---|
| ADHD and similar | It does the remembering, the deciding and the time-keeping their brain doesn't |
| Lose time | The countdown stops them drifting; the end time shows them where the time goes |
| Can't start | Being told "now this", and praised for it, gets them going without willpower |
| Mornings go badly | It moves them out of bed and out of the door on time, half awake |
| Forget steps | The list remembers; reminders bring them back |
| Tried everything | It's simpler than the rest, and it's a timer, not a checklist |
| Overwhelmed | One step on screen instead of the whole list |
| Parents | A child can follow it alone |

**Free features liked across all 9,644 reviews** (sorted by their words; one review can name several):

| Feature | Reviews | Groups that value it most (people, all years) |
|---|---|---|
| Simple, clean, easy | 946 | ADHD and similar (60), lose time (47), can't start (45), tried everything (43) |
| The look: design, cute icons | 700 | ADHD and similar (47), can't start (31), tried everything (31) |
| **A timer on every step** | 515 | **ADHD and similar (85), lose time (72), can't start (56), mornings (52)**, tried everything (43) |
| Encouraging words, the voice | 330 | **Can't start (46)**, ADHD and similar (30), mornings (20) |
| Reminders and alerts | 221 | **ADHD and similar (43)**, lose time (30), can't start (22), forget (16) |
| More than one routine | 180 | Lose time (19) |
| The free version is enough | 132 | Tried everything (12) |
| A responsive developer | 129 | Rises from 2024 (14, 29, 25 a year) |
| Walked through one step at a time | 121 | Mornings (14) |
| Pause, skip or add time | 112 | Forget (8) |
| Seeing how long things take, stats | 82 | — |
| No ads | 65 | — |
| Seeing when the routine will end | 50 | Forget, lose time |

The timer is the feature that defines the app for its core users: liked by 515 people overall, and **first (or tied
first) for six of the ten groups** across the eight years. In 2025 alone 103 people named it, 21 of them with ADHD.

---

## 4. Paying

### How many pay

| | All years | Share of 9,644 | Share of the 1,098 who say anything |
|---|---|---|---|
| Paid | 393 | 4.1% | 36% |
| On a trial | 35 | 0.4% | 3% |
| Charged unexpectedly | 90 | 0.9% | 8% |
| Refused to pay | 192 | 2.0% | 17% |
| Use it free and say so | 388 | 4.0% | 35% |
| Don't say | 8,546 | 89% | — |

**By group** (paid or trial, of those in the group who say anything about paying):

| Group | Paid or trial | Of those who say anything | Use it free and say so | Refused |
|---|---|---|---|---|
| ADHD and similar | 29 | 62 | 25 | 7 |
| Lose time | 22 | 49 | 25 | 2 |
| Can't start | 18 | 48 | **28** | 2 |
| Tried everything | 15 | 34 | 15 | 4 |
| Forget steps | 10 | 14 | 3 | 1 |
| Parents and carers | 7 | 10 | 0 | 3 |
| **Mornings go badly** | **6** | 26 | **19** | 1 |
| Lost their structure | 3 | 9 | 4 | 2 |
| Overwhelmed | 2 | 9 | 5 | 2 |
| Follow a method | 2 | 2 | 0 | 0 |

These rest on small numbers: only about one person in seven in any group says anything about paying. The one pattern that
holds over several years is **mornings**: people who only need a morning and a night routine say they use it free far
more than they say they paid. People with ADHD and people who lose time pay at about the same rate as each other.

**By language** (every year the same shape):

| Language | Reviews | Paid | Share who say they paid | Charged unexpectedly |
|---|---|---|---|---|
| English | 5,622 | 185 | 3.3% | 33 |
| **Korean** | 1,384 | 151 | **10.9%** | **50** |
| Japanese | 301 | 24 | 8.0% | 0 |
| German | 158 | 7 | 4.4% | 0 |
| Portuguese | 241 | 5 | 2.1% | 0 |
| French | 275 | 5 | 1.8% | 0 |
| Spanish | 831 | 8 | 1.0% | 4 |
| Polish | 210 | 1 | 0.5% | 0 |

Korean reviewers say they paid at **3.3 times** the English rate; Japanese reviewers passed them in 2025 (12.7% against 10.6%). Korean
reviewers also account for **56% of unexpected charges** (50 of 90), and from 2024 many Korean "payers" write to ask
for a refund.

### Why the payers paid

Every payer was sorted into one reason in the yearly reports:

| Reason | 2020 | 2021 | 2022 | 2023 | 2024 | 2025 | 2026 | All |
|---|---|---|---|---|---|---|---|---|
| **The whole app works for them**, or they liked it straight away | 8 | 19 | 22 | 17 | 7 | 19 | 13 | **105** |
| **For more routines** | 0 | 5 | 9 | 4 | 0 | 4 | 1 | **23** |
| For another feature (the routine log, the voice, records, the watch timer, backups, a sound, the alarm) | 0 | 2 | 1 | 3 | 2 | 1 | 1 | 10 |
| Worth it for the price ("10 cents a day", in Italian) | 2 | 10 | 7 | 3 | 1 | 4 | 3 | 30 |
| Used it free first, then paid | 2 | 2 | 2 | 1 | 0 | 0 | 1 | 8 |
| To support the developer | 1 | 0 | 2 | 1 | 0 | 0 | 0 | 4 |
| A promotion (1+1, a discount) | 0 | 1 | 1 | 3 | 0 | 1 | 2 | 8 |
| Other (the reviews, gratitude, the tutorial, a test month, paying makes them do it) | 1 | 1 | 3 | 0 | 0 | 0 | 0 | 5 |
| Regret it, cancelled, or want a refund | 3 | 8 | 7 | 11 | 14 | 14 | 6 | 63 |
| No reason; mention paying only to report a bug, ads or an upsell | — | — | — | 27 | 21 | 32 | 10 | 90 |
| No reason given | 8 | 16 | 21 | 1 | 1 | 0 | 0 | 47 |
| **Payers** | 25 | 64 | 75 | 71 | 46 | 75 | 37 | **393** |
| Payers' average rating | 4.36 | 4.22 | 3.91 | 2.97 | 2.72 | 2.89 | 3.08 | 3.41 |

(2020–2022 didn't separate bug reports from "no reason given".)

**What this says:**
- **Payers pay for the app working, not for a premium feature.** Of the 193 who give a reason, 105 (54%) say the
  whole app works for them, and 30 more that it's worth the price. Only 33 name a feature, and **23 of those name more
  routines**.
- **Prices people accept are small and thought of per day:** "10 cents a day" (2021, in Italian), "about 100 won a
  day" (2020, in Korean), $2.99 a month, about $30 a year, 35,000 won a year. In 2026 **3 bought a lifetime plan**, the first
  in the reviews.
- **From 2023 payers became the app's harshest critics.** Bugs, subscriptions the app forgot, ads shown to payers,
  pop-ups asking them to buy again: 90 payers in 2023–2026 mention paying only to report a bug, a forgotten
  subscription, ads or an upsell.

### Unexpected charges (90)

2 in 2020, 4 in 2021, 6 in 2022, then **20, 22, 22 and 14** from 2023. Most are **free trials that charged at once or
became a year's subscription** (15 of 22 in 2025, 9 of 14 in 2026), the rest renewals not noticed, charges after
cancelling, and discount offers or cancel screens that charged instead. 50 of the 90 are Korean.

### What premium holds

| Behind the paywall | What reviews say |
|---|---|
| **More than two routines** | About 500 mentions in eight years (53, 79, ~115, ~108, ~46, ~70, ~28 a year from 2020). About 400 want more, **usually three to five**; about 70 say two are enough, *"morning and night"*; about 15 paid for more. In 2023–2024 a few reviews say the free plan dropped to one routine, or routines needed paying for altogether; from 2025, archiving or swapping routines needs a subscription or an ad |
| Custom icons and pictures | 4–16 a year |
| Backup or sync between devices | up to 9 a year (2022) |
| Statistics and history | a few a year |
| No ads | from 2023, when ads appear in the free plan (12, 5, 20, 6 complaints a year) |

**Who the limit hurts most:** students and children who can't pay (*"루티너리를 구독하지 못하는 학생들은 루틴을 두개밖에
작성할 수 없어서"*, "students who can't subscribe can only make two routines", 2022, `87713753`), people with
different weekday and weekend days, and people who split a day into several routines.

### Why others won't pay

| Years | The main objection |
|---|---|
| 2020–2022 | **A subscription rather than a one-time or lifetime price** (33, 23, 26 reviews), then price, then the trial |
| 2023 | **Too expensive or can't afford it** (13 of 37 refusals), then the subscription (11) |
| 2024 | **The bugs come first** (7 of 21 refusals) |
| 2025–2026 | **The free trial**: a card up front, a year's charge after seven days, the price shown late (9 of 33, 6 of 15) |

Across all years the steady objections are three: **a subscription for a simple app** (people name $12–30 once), **the
price per year** for students, families and people with little money, and **the trial**, which people fear will charge
them (*"1週間で解約しなければ自動有料とか、こわくて使えない"*, "auto-paid unless I cancel within a week? Too scary to use",
2026, `5293da37`).

---

## 5. Who they say they are

Identity isn't a pain point, so these aren't groups, but they show the people inside them. From `who`, keyword traps
fixed by hand in each year:

| They say they are | 2020 | 2021 | 2022 | 2023 | 2024 | 2025 | 2026* | All |
|---|---|---|---|---|---|---|---|---|
| **ADHD or ADD** | 15 | 38 | 78 | 38 | 46 | 81 | 49 | **345** |
| **Smartwatch user** | 10 | 34 | 69 | 38 | 36 | 35 | 10 | 232 |
| Student | 10 | 21 | 37 | 31 | 10 | 32 | 19 | 160 |
| Working | 17 | 17 | 16 | 15 | 12 | 39 | 15 | 131 |
| Depression, anxiety, other mental health | 6 | 10 | 13 | 6 | 8 | 11 | 13 | 67 |
| Parent | 5 | 7 | 13 | 11 | 5 | 13 | 7 | 61 |
| Autism, executive dysfunction, brain fog | 4 | 7 | 10 | 10 | 4 | 11 | 4 | 50 |
| Children and minors | 3 | 5 | 7 | 9 | 4 | 7 | 5 | 40 |

**The watch matters to the core users:** people with ADHD and people who lose time want to run a routine from the
wrist and leave the phone that distracts them. The watch app is also where complaints concentrate (57 broken in 2022,
35 in 2023, 32 in 2024, 29 in 2025).

---

## 6. How it changed: four periods

1. **2019–2020: a morning app.** It began in Korea as 굿모닝 ("Good Morning"); in 2020, the COVID year, the biggest
   groups were people whose mornings went badly (31%) and whose structure had gone (11%). Paying was rare (2.2%) and
   payers were happy (4.36★).
2. **2021–2022: an app for people with ADHD.** People who had tried everything else (28% in 2021) and then people with
   ADHD (45% in 2022) became the core, many of them on a smartwatch. Paying rose to 4.9%; the feature people paid for
   was more routines.
3. **2023–2024: the app broke for its payers.** Bugs rose to a quarter and then a third of reviews; unexpected charges
   jumped from 6 to 20 and 22; payers' rating fell to 2.97★ and 2.72★; ads, an AI chatbot and forced logins appeared.
   Students came and went (a young July wave in 2023).
4. **2025–2026: recovery, with new friction.** The most people ever naming a pain point (237 in 2025), 81 with ADHD;
   the rating back to 4.06★ and 4.20★; bugs down to 17%; the first lifetime plans. The friction moved to the free
   trial, ads in the free plan, upsells to people who already pay, social features and AI.

Through all four, **the pains, the job and the limit stayed the same**: people who struggle with time, starting and
remembering use a step-by-step routine timer, and the free plan gives them two routines when they want three.

---

## 7. What this means for a new routine product

These follow from the reviews alone.

- **Design for the core four, together.** ADHD and similar conditions, losing time, not starting and bad mornings
  overlap heavily (82 people are in both of the first two). The person to design for has time blindness, finds
  starting hard, and gets pulled away by their phone, most of all in the morning.
- **The step-by-step timer is the product.** It's the most liked feature of the core groups for eight years. Its
  supporting parts matter to specific groups: the end time (lose time, forget), reminders (ADHD, forget),
  encouragement and the voice (can't start), pause and skip, and a watch that lets them leave the phone.
- **Simplicity is why people switch.** "Tried everything" left other apps for being complicated, flashy, distracting,
  or for removing and paywalling routine features.
- **Free must cover a morning and a night.** People with only those two needs stay free and happy; the people who want
  more want three to five routines (weekday and weekend, work and home). The limit is the main paywall and the main
  complaint at once.
- **People pay for the whole thing working, cheaply, and want to own it.** A low price thought of per day, a one-time
  or lifetime option, and a family option for parents. Korean and Japanese reviewers are the most willing to pay.
- **Trust decides paying.** Every period where bugs, surprise trial charges, ads to payers or repeated upsells rose,
  payers turned into the harshest reviewers and refusals moved from price to trust. A trial that can't surprise anyone,
  and nothing pushed at people who already pay, protect the people most likely to pay.
- **Be careful with additions that aren't the job.** Social features, AI chat and fortunes drew complaints in
  2024–2026 from people who came for a quiet routine timer.

---

## 8. Limits

- **87% of reviews don't name a pain point,** so the groups describe the 1,276 who do; the order of the groups is more
  reliable than their exact sizes.
- **Person-years, not people.** The same person reviewing in two years counts twice; one same-day duplicate (2026) was
  counted once.
- **The labels split pain between `who` and `why_chose` differently each year** (2022: 388 / 63; 2025: 305 / 317). Both
  were read for every person, so the pain groups compare across years; goal-only counts don't.
- **Paying is said by 11%.** Group paying figures rest on small numbers; never rank groups on them.
- **Methods differ slightly by year.** 2020–2022 counted objections by keyword across all reviews; 2023–2026 sorted every
  refusal by hand. 2020–2022 didn't separate payers who only report a bug from "no reason given". Feature kinds are
  re-counted here with the current tool, so a few totals differ slightly from those printed in the earliest reports.
- **2019 has 11 reviews and 2026 is a part year** (to 7 September).
- **The routine-limit counts are approximate** (each year's hits were read and sorted by hand).

---

## Where every number comes from

| Figure | Source |
|---|---|
| Reviews, ratings, languages, stores, paid status, broken, liked features | `Review Labels/Routinery/<YEAR>/labels.jsonl`, all eight years |
| Group membership | [`Tools/groups_2019.py`](<Tools/groups_2019.py>) … [`Tools/groups_2026.py`](<Tools/groups_2026.py>), each year's appendix lists every member |
| Payers' reasons, unexpected charges, refusals, routine-limit sorts | Section 3 of each yearly report, with every review ID |
| Who they say they are | Section 5 of each yearly report (keyword counts fixed by hand) |
| Quotes | The yearly reports; each is quoted exactly as written, with its review ID |
