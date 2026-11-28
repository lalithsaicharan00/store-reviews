# Routinery 2022: User Groups, Why They Use It, and What They Pay For

Written by Claude (Claude Code), 26 November 2026, at the user's request.

**What this is.** Routinery's target users as its 2022 reviews show them, the way UX user research describes them:
the groups of people who use it, each defined by the **pain point** that brought them; why each group uses it; whether
each group pays, how many, and for what; and which free features each group likes. The fourth year of a series
([2019](<Routinery 2019 — User Groups, Why They Use It, and What They Pay For.md>),
[2020](<Routinery 2020 — User Groups, Why They Use It, and What They Pay For.md>),
[2021](<Routinery 2021 — User Groups, Why They Use It, and What They Pay For.md>)).

**How it was done.** From the reviews alone, as research for a new product or a full rebuild. No product of ours, its
features or its code was used to choose, read or group anything.

**Source.** The checked labels for all 1,534 reviews of 2022 in `Review Labels/Routinery/2022/labels.jsonl`, the same
way as 2020 and 2021:

- **Groups:** from `who` and `why_chose`. I read all 412 reviews that have either and put each person in the group(s)
  their own words describe. One person can be in more than one group.
- **Features liked:** from `liked` and `chose_for`, sorted into the same kinds as the earlier years.
- **Paying:** from `paid` and its reason, plus the price and premium complaints in `problems`.

Review IDs are shortened to their first 8 characters; the appendix maps every group member to its line in the labels
file. The map is saved as [`Tools/groups_2022.py`](<Tools/groups_2022.py>); [README.md](<README.md>) explains the method.

---

## The short answer

- **1,534 reviews** (1,118 Google Play, 416 App Store), average 4.18★, the lowest of the four years. **205 people (13%)
  name a pain point**; 8 more name only a goal.
- **2022 is the year Routinery became an app for people with ADHD.** **92 of the 205 (45%) say they have ADHD,
  autism, OCD, executive dysfunction, depression or anxiety**, up from 24% in 2021 and 15% in 2020; 78 name ADHD or
  ADD. The other groups are the same pains as before, many of them felt by the same people.

| # | User group (the pain point) | People | Share of the 205 | ★ | Paid or trial | 2021 share |
|---|---|---|---|---|---|---|
| 1 | **Have ADHD, autism, OCD, executive dysfunction, depression or anxiety** | 92 | **45%** | 4.66 | 6 | 24% |
| 2 | **Can't start or keep going:** procrastinate, lazy, quit after 3 days, task initiation | 58 | 28% | 4.76 | 6 | 28% |
| 3 | **Lose time:** distracted (often by the phone), time blindness, always late, chaotic days | 40 | 20% | 4.67 | 4 | 21% |
| 4 | **Mornings go badly:** can't get up, fall back asleep, lie on the couch, can't get out the door | 21 | 10% | 4.81 | 1 | 19% |
| 5 | **Tried other apps; nothing stuck** (Fabulous, Tiimo, Productive, "thousands of apps") | 20 | 10% | 4.50 | 2 | 28% |
| 6 | **Forget steps and small tasks** ("out of sight, out of mind") | 13 | 6% | 4.92 | 0 | 6% |
| 7 | **Parents, often running routines with their children** | 12 | 6% | 4.75 | 2 | 3% |
| 8 | **Overwhelmed:** too much to do, planning itself is stressful | 8 | 4% | 4.88 | 0 | 4% |
| 9 | **Lost their structure:** a hard period, isolation, a broken leg | 5 | 2% | 4.80 | 0 | 3% |
| 10 | **Follow a method** (Bullet Journal) | 1 | 0.5% | 5.00 | 0 | 2% |

  (59 people are in more than one group.)

- **Why they use it:** the same reason as every year, put in ADHD terms: the app **does the remembering, the
  deciding and the time-keeping** for them. *"no energy spent remembering steps"*, *"simplifies decisions"*,
  *"shows understanding of ADHD's core problems"*.
- **They want it on their wrist.** 69 people say they use a smartwatch (34 in 2021) and 86 reviews mention the watch
  app. Most of those are complaints: 57 say it's broken and 24 say a watch feature is missing.
- **Paying keeps rising.** 75 of 1,534 (4.9%) say they paid (3.9% in 2021); of the 212 who say anything about
  paying, 35% paid. Payers still mostly pay for **the whole app** (22) or its price (7); **10 pay for a feature, 9
  of them for more routines**, up from 5. 7 regret it or cancelled.
- **The paywall is still the third routine.** About 115 reviews mention the two-routine free limit: about 98 want
  more (usually 3–5), 12 say two are enough, 5 paid for more. **Children and students** say it most: they can't pay.
- **Korean reviewers pay most again:** 13.4% of Korean reviews say they paid, against 4.6% of English ones; 32 of 75
  payers write in Korean.
- **Free features liked:** simple and clean (158), the look and icons (117), **a timer on every step (86)**, more than
  one routine (57), encouraging words and the voice (51), reminders (42). People with ADHD name **reminders (14)**
  more than any other group.

---

## 1. The year in numbers

| | Count | Share of 1,534 |
|---|---|---|
| Reviews | 1,534 | 100% |
| Google Play / App Store | 1,118 / 416 | 73% / 27% |
| Language: English, Korean, Spanish, French, Polish, Portuguese, Japanese, other | 827, 238, 147, 57, 52, 45, 40, 128 | 54%, 16%, 10%, 4%, 3%, 3%, 3%, 8% |
| Ratings 5★ / 4★ / 3★ / 2★ / 1★ | 918 / 282 / 142 / 73 / 119 | 60% / 18% / 9% / 5% / 8% |
| Say who they are (`who`) | 388 | 25% |
| Say why they came (`why_chose`) | 63 | 4% |
| Name a pain point (any group below) | **205** | **13%** |
| Name a feature they like | 1,064 | 69% |
| Say anything about paying | 212 | 14% |
| Nothing useful ("great app") | 192 | 13% |

---

## 2. The user groups

### Group 1. Have ADHD, autism, OCD, executive dysfunction, depression or anxiety (92 people, 45%, 4.66★)

**Who they are:** ADHD or ADD (78), autism, OCD or executive dysfunction (10), depression or anxiety (13). Adults
diagnosed late (*"Diagnosed w/ADHD as an adult in the last year"*), students, parents of an *"ADHD family"*, people on
medication and without it, people working with a coach or psychologist. Many write as a community: *"as my fellow NDs
know"*, *"exactly what most of us with ADHD would do"*. 61 are only in this group.

**Why they use it:**
- *"As someone with ADHD who struggles with time management"* (`82309680`, en, 5★).
- *"as an ADHDer I have a hard time sticking to routines"* (`84476258`, en, 4★, a payer).
- *"none of them worked for me until I found Routinery"*, with ADHD and depression (`83550495`, en, 5★).
- *"I have severe ADHD"* and struggles to remember a routine's steps (`c7a70d88`, en, 5★).
- *"We literally perceive time differently"*, ADHD with time-perception difficulty, always late (`87425424`, en, 5★).
- *"Eu tenho TDA"*, "I have ADD" (`88825831`, pt, 5★).
- *"Helps with my depression"* (`84160661`, en, 5★).
- One found it through an article on ADHD scheduling tools (`88770344`); another's coach recommended it (`d289f6a0`).

**Free features they like** (91 of 92): simple and clean (20), the timer on every step (19), the look and icons (17),
**reminders and alerts (14: more than any other group)**, more than one routine (7), encouraging words and the voice
(7), seeing how long things take (6).

**Paying:** 6 paid, 6 free, 1 refused, 1 charged unexpectedly, 78 don't say. *"cheap; pays for unlimited routines"*,
*"a wonder for my ADHD"*, *"no energy spent remembering steps"* (`66ffd718`); a month for $2.99 *"to see if it's worth
it"* because the app *"shows understanding of ADHD's core problems"* (`83052283`); subscribed after one day
(`a65e89ce`, autistic). The refusal: an ADHD family of four won't pay *"$88 a year"* for four people (`e75d5c70`).

### Group 2. Can't start or keep going (58 people, 28%, 4.76★)

**Who they are:** procrastinators, self-described lazy people, people who never last past three days, people who
struggle with *"getting going"* or *"task initiation"*. 33 are only in this group.

**Why they use it:**
- *"I wasn't able to stick to a routine for more than 3 days"* (`4219ac94`, en, 5★).
- *"I've tried to have those routines before, but it never stuck"* (`83072457`, en, 5★).
- *"I have been trying to start night and morning routines for so long"* (`de032b7b`, en, 5★).
- *"I struggle with "getting going""* (`84947225`, en, 5★, a payer).
- *"게으른 생활을 하다가"*, "I was living lazily" (`978f5f20`, ko, 5★).
- *"Yo suelo procrastinar demasiado hasta para levantarme de la cama"*, "I procrastinate too much, even getting out
  of bed" (`89138068`, es, 5★).

**Free features they like** (all 58): the timer on every step (13), the look (10), simple (10), **more than one
routine (8)**, **encouraging words and the voice (8)**, being walked through (4).

**Paying:** 6 paid, 5 free, 1 refused. *"bought the full version within a week and doesn't regret it"* (`84476258`);
subscribed after testing the free version (`84947225`); upgraded for more routines (`df8fce36`); the annual plan
because *"starting the timer motivates"* (`6e1f227e`); *"the voice makes me more motivated"* (`e46de97c`). The refusal
wants a lifetime price.

### Group 3. Lose time (40 people, 20%, 4.67★)

**Who they are:** people who are distracted (very often **by their own phone**), have time blindness, can't plan
time, run late, or whose life is *"full of chaos"*.

**Why they use it:**
- *"My phone is the biggest distraction"* (`e8710d6d`, en, 3★).
- *"I struggle with time blindness"* (`84838955`, en, 4★, a payer).
- *"どうしてもダラダラしてしまって、時間管理が疎かになってしまう私には"*, "for me, who can't help dawdling and neglects
  time management" (`474aa8b8`, ja, 4★).
- *"i was never able to plan my time well before"* (`83110582`, en, 5★).
- *"i find it so hard to get out of the door on time in the morning"* (`85951197`, en, 5★).

**Free features they like** (all 40): simple (9), the timer (9), **reminders (6)**, pause, skip or add time (4), more
than one routine (4).

**Paying:** 4 paid, 5 free. Bought premium at once for the *"estimated end time"* and the *"history of start/end
times and over/under per task"* (`84838955`).

### Group 4. Mornings go badly (21 people, 10%, 4.81★)

Down again (31% in 2020, 19% in 2021).
- *"Usually I sleep 12 hours a day"* (`83095944`, en, 5★).
- *"would wake up but then fall back asleep"* (`89243424`, en, 4★).
- *"I wake up super early and just lay on the couch the whole morning"* (`88486865`, en, 3★).
- *"막상 눈을 뜨면 막막했는데"*, "once I opened my eyes I felt at a loss" (`86680171`, ko, 5★).
- *"especially for 0 period"*, an early class (`90664702`, en, 5★).

**Free features they like:** **the timer (8 of 21)**, encouraging words (4), simple (3). **Paying:** 1 paid: *"doesn't
regret the monthly fee"*, *"gets them up and going"* (`93264846`).

### Group 5. Tried other apps; nothing stuck (20 people, 10%, 4.50★)

Fewer than in 2021 (55). The apps they left: Fabulous (*"I wanted something to replace Fabulous's routine timers"*,
`e2230360`), Tiimo (*"glitchy and never worked"*, `89987790`), Productive (*"the more cutesy that app got the more it
distracted me"*, `86254726`), calendars and to-do apps (*"カレンダーに入れれば拘束されるようで窮屈"*, "putting it in a
calendar feels restrictive", `89378384`).
- *"I have tried so many apps since 2014. My search has finally ended."* (`84484648`, en, 5★, a payer).
- *"Dozens of productivity apps have failed me before I found Routinery"* (`86197148`, en, 5★).

**Free features they like:** the timer (6), the look (5), simple (4), more than one routine (4). **Paying:** 2 paid
(*"subscribed without hesitation"*, `82373596`; bought it after a year of free use, `84484648`), 2 refused (both want
a one-time price).

### Group 6. Forget steps and small tasks (13 people, 6%, 4.92★)

- *"For me, it's out of sight out of mind"* (`1ca30c61`, en, 5★).
- *"tasks that I usually forget to do"* (`5c680902`, en, 5★).
- *"have been struggling with to-do lists and trying to keep track of all the steps"* (`90840275`, en, 5★).
- An 11-year-old who used to be late, disorganised and forgetful (`93379130`, en, 5★).

**Free features they like:** **reminders (4)**, the timer (2), simple (2). **Paying:** none say.

### Group 7. Parents, often with their children (12 people, 6%, 4.75★)

Doubled from 2021. They use it **with or for their children**:
- *"my son and I have turned it into a challenge"* (`98650d64`, en, 5★).
- *"con mi hijo para alistarnos para el colegio"*, "with my son, to get ready for school" (`4e783282`, es, 5★).
- *"motiver ma fille le matin et le soir"*, "to motivate my daughter morning and evening" (`760b0ea2`, fr, 5★).
- *"I even have my 14 year old son using it too"* (`91889429`, en, 5★, a payer).
- *"our ADHD family"*, four people (`e75d5c70`, en, 4★).

**Free features they like:** the look (2), more than one routine (2), encouraging words (2). **Paying:** 2 paid
(*"just what they needed"*, `91889429`; *"subscriptions for the family"*, `94009434`), 1 refused (no family price).

### Group 8. Overwhelmed (8 people, 4%, 4.88★)

- *"I felt really stressed with everything I had to do"* (`85687834`, en, 5★).
- *"계획 세우는것도 스트레스 받아하고 세운다 해도 지키는일이 없어서"*, "even making plans stresses me, and I never keep
  them" (`89729423`, ko, 5★).
- *"organization with my businesses"*, running several (`92621448`, en, 5★).

**Free features they like:** simple (3), the look (2), the timer (2). **Paying:** none say.

### Group 9. Lost their structure (5 people) and Group 10. Follow a method (1 person)

A stressful period that *"lost all of my normal routines"* (`59055fec`), isolation (`039b3b22`), a broken leg
(`60298f16`), *"mi proceso de volver a encontrarme"*, "finding myself again" (`b2c5bedd`). One has kept Bullet Journal
routines *"depuis plus de 10 ans"*, "for more than ten years" (`91933812`). None say they paid.

### People who name only a goal (8 people, 4.00★)

*"I wanted to become more structured in the new year"* (`87444913`); *"une appli pour définir une routine
répétitive … et non pas une to do list"*, "an app for a repeating routine, not a to-do list" (`a9f988b5`).

---

## 3. Paying

### How many pay

| | 2022 | Share of 1,534 | Share of the 212 who say anything | 2021 | 2020 |
|---|---|---|---|---|---|
| Paid | 75 | 4.9% | 35% | 64 (3.9%) | 25 (2.2%) |
| On a trial | 3 | 0.2% | 1% | 9 | 7 |
| Charged unexpectedly | 6 | 0.4% | 3% | 4 | 2 |
| Refused to pay | 28 | 1.8% | 13% | 23 | 35 |
| Use it free and say so | 100 | 6.5% | 47% | 86 | 59 |
| Don't say | 1,322 | 86% | — | 1,440 | 994 |

**By group** (paid + trial): ADHD and similar 6 of 92; can't start 6 of 58; lose time 4 of 40; tried everything 2 of
20; parents 2 of 12; mornings 1 of 21; forget, overwhelmed, lost structure, method 0. **No group pays clearly more
than the others.**

**By language:** 32 of the 75 payers write in Korean, 38 in English. 13.4% of the 238 Korean reviews say they paid,
against 4.6% of the 827 English ones. Refusals: 18 of 28 in English. 4 of the 6 unexpected charges are Korean.

### Why the payers paid

| Reason | Payers | IDs |
|---|---|---|
| The whole app works for them, or they liked it straight away (*"subscribed for a year after 3 days; first paid app on this phone"*) | 22 | `81919943` `82204774` `82373596` `2d4f9b88` `84476258` `2b839dc5` `84702590` `84838955` `53de7b42` `e5401ede` `b6d0c4f6` `5ba49229` `86447106` `6e3d0ecb` `5e6f7e05` `87958748` `91889429` `a65e89ce` `ad8e1b17` `93200049` `94009434` `07a387bf` |
| **For more routines** (*"to make more than 2 routines"*, weekday routines, several routines) | 9 | `84757689` `bf7be9fa` `87811856` `88483996` `df8fce36` `66ffd718` `e5ae26b7` `92457717` `93068612` |
| For another feature: the voice | 1 | `e46de97c` |
| Worth it for the price (*"worth every penny"*, *"money isn't wasted"*) | 7 | `84292408` `6e1f227e` `0a1ecdbb` `90afd720` `92548795` `93264846` `93851976` |
| Used the free version first (one for a year) | 2 | `84484648` `84947225` |
| To support the developer | 2 | `136bc16c` `1f43da7e` |
| The tutorial convinced them | 1 | `72df6b6a` |
| A promotion (6 months + 6 free) | 1 | `81950286` |
| Paying makes them do the routine | 1 | `1a7d2918` |
| A month to test it | 1 | `83052283` |
| Regret it, cancelled, want a refund, or annoyed by an outage | 7 | `833d19ad` `89385869` `89419489` `91108241` `e2e807f8` `7886e56f` `92673806` |
| No reason given | 21 | `82123570` `11f795ad` `82508291` `82544956` `7841d393` `4a947197` `5966f7f6` `953ee2e4` `86956016` `87737640` `a7573650` `3484ee5e` `9252cc0a` `7ab1f15c` `291c6a4a` `92470963` `92716931` `93005963` `4facac14` `ebbc61c2` `dafcf1f2` |

**The feature people pay for, when they name one, is still more routines** (9 of 10). 7 of those 9 write in English.
Prices named: $2.99 a month, £3 a month, about 30 euros a year, *"$88 a year"* for a family of four.

**Charged unexpectedly (6):** charged after leaving a trial (`327819bc`), still charged after cancelling
(`d61de794`, `87639339`), charged twice (`120cacb0`, `e66b7bd7`), switching to yearly didn't cancel monthly
(`3efdf950`).

### What premium holds (from what free users miss and payers name)

| Behind the paywall | Reviews |
|---|---|
| **More than two routines** | about 115 mention it: about 98 want more (usually 3–5), 12 say two are enough (*"enough for morning and night"*), 5 paid for more |
| Custom icons | about 16 |
| Backup or sync between devices | 9 |
| Statistics | 2 |

Students and children say the limit hurts most: *"루티너리를 구독하지 못하는 학생들은 루틴을 두개밖에 작성할 수
없어서"*, "students who can't subscribe can only make two routines" (`87713753`); *"paying is hard for young
students"*.

### Why others won't pay

| Objection | Reviews |
|---|---|
| A subscription rather than a one-time or lifetime price | 26 |
| Too expensive or can't afford it (students, minors whose parents won't pay, a family of four) | 21 |
| The trial | 6 |
| Charged unexpectedly | 6 |

---

## 4. Free features people like

Across all 1,534 reviews, 1,064 (69%) name something they like:

| Feature | Reviews | Groups that name it most |
|---|---|---|
| Simple, clean, easy | 158 | ADHD and similar (20), can't start (10), lose time (9) |
| The look: design, cute icons | 117 | ADHD and similar (17), can't start (10) |
| **A timer on every step** | 86 | ADHD and similar (19), can't start (13), lose time (9), mornings (8 of 21) |
| More than one routine | 57 | Can't start (8), ADHD and similar (7) |
| Encouraging words, the voice | 51 | Can't start (8), ADHD and similar (7), mornings (4) |
| **Reminders and alerts** | 42 | **ADHD and similar (14)**, lose time (6), forget (4) |
| Walked through one step at a time | 30 | Can't start (4) |
| The free version is enough | 24 | — |
| Pause, skip or add time | 22 | Lose time (4) |

**Per group:** the same pattern as the earlier years. The **timer** matters to everyone; **reminders** matter most to
people with ADHD and to the forgetful; people who can't start like **encouragement and the voice**. New this year:
people want the timer and reminders **on a watch**, so they can leave the phone that distracts them.

---

## 5. Who they say they are

From `who` (388 people say something):

| They say they are | People | 2021 | 2020 |
|---|---|---|---|
| ADHD or ADD | 78 | 38 | 15 |
| **Smartwatch user** (Apple Watch, Galaxy Watch, Wear OS, Fitbit) | 69 | 34 | 10 |
| Student | 37 | 21 | 10 |
| Working | 16 | 17 | 17 |
| iPad or tablet user | 14 | 9 | 5 |
| Parent | 13 | 7 | 5 |
| Depression or anxiety | 13 | 10 | 6 |
| Procrastinator, lazy, low willpower | 12 | 19 | 13 |
| Autism, OCD, executive dysfunction | 10 | 7 | 4 |
| Short of money or won't subscribe | 9 | 17 | — |
| Children and minors (an 11-year-old, an elementary student, teenagers whose parents control purchases) | 7 | 5 | 3 |

**The watch:** 86 reviews mention the watch app. 15 like it (*"on task without carrying the phone"*, auto-complete
from Fitbit), 57 say it's broken (crashes when starting a routine, doesn't sync, the timer runs slow, three
overlapping loud alerts) and 24 say a watch feature is missing.

---

## 6. What changed from 2021

| | 2020 | 2021 | 2022 |
|---|---|---|---|
| Biggest group | Mornings (31%) | Can't start (28%), tried everything (28%) | **ADHD and similar (45%)** |
| ADHD or ADD named | 15 | 38 | **78** |
| Tried everything else | 16% | 28% | 10% |
| Mornings | 31% | 19% | 10% |
| Parents | 3% | 3% | 6% |
| Smartwatch users | 10 | 34 | 69 |
| Said they paid | 2.2% | 3.9% | 4.9% |
| Payers naming a feature | none | 7 | 10 |
| Average rating | 4.33 | 4.29 | 4.18 |

The app's users moved from "people whose mornings go badly" to **people with ADHD and similar conditions**, who now
come for the app's structure and often hear about it from each other. They want it on a watch, and the watch app is
where their complaints concentrate.

---

## 7. Limits

- **87% don't name a pain point,** so the groups describe the 205 who do; the order is more reliable than the exact
  sizes.
- **The 2022 labels put the pain mostly into `who`** (388) and little into `why_chose` (63). I read both fields for
  every person, so the groups are comparable with earlier years; a count of `why_chose` alone is not.
- **Paying is said by 14%.** Group paying rates rest on 0–6 people.
- **The routine-limit count is approximate** (about 115): a few hits were read by hand and removed, and some reviews
  mention the limit without asking for anything.
- **Features are sorted by their words**, as in earlier years.

---

## Appendix: every group member

`Line` is the review's line in `Review Labels/Routinery/2022/labels.jsonl`; `ID` is the first 8 characters of its
review ID.

| Line | ID | Store | ★ | Language | Groups | Paid |
|---|---|---|---|---|---|---|
| 12 | `82043427` | App Store | 5 | en | 1 ADHD and similar; 2 Can't start | not said |
| 14 | `82056209` | App Store | 5 | en | 2 Can't start | not said |
| 17 | `e7af288d` | Play | 5 | en | 1 ADHD and similar; 2 Can't start | not said |
| 20 | `82137217` | App Store | 5 | ko | 3 Lose time; 6 Forget steps | free |
| 22 | `82156016` | App Store | 3 | en | Goal only | free |
| 34 | `474aa8b8` | Play | 4 | ja | 3 Lose time | not said |
| 36 | `82298903` | App Store | 1 | en | 1 ADHD and similar | not said |
| 37 | `82309680` | App Store | 5 | en | 1 ADHD and similar; 3 Lose time | not said |
| 40 | `82373596` | App Store | 5 | ko | 5 Tried everything | paid |
| 45 | `82487364` | App Store | 5 | en | 1 ADHD and similar; 7 Parents | not said |
| 57 | `14871750` | Play | 5 | en | 1 ADHD and similar | not said |
| 58 | `dd340cb5` | Play | 1 | en | 1 ADHD and similar | not said |
| 67 | `82675969` | App Store | 4 | en | 1 ADHD and similar | not said |
| 78 | `de032b7b` | Play | 5 | en | 2 Can't start | not said |
| 93 | `c886d747` | Play | 5 | en | 1 ADHD and similar | not said |
| 96 | `82801565` | App Store | 5 | en | 3 Lose time; 4 Mornings | not said |
| 114 | `cf0d1451` | Play | 5 | en | 1 ADHD and similar; 3 Lose time | not said |
| 121 | `5c680902` | Play | 5 | en | 6 Forget steps | not said |
| 131 | `1aef9210` | Play | 5 | id | 6 Forget steps | not said |
| 133 | `02f9a984` | Play | 5 | en | 1 ADHD and similar | not said |
| 152 | `83052283` | App Store | 3 | en | 1 ADHD and similar; 3 Lose time | paid |
| 153 | `83052414` | App Store | 5 | en | 1 ADHD and similar | not said |
| 154 | `83072457` | App Store | 5 | en | 2 Can't start; 5 Tried everything | not said |
| 157 | `83080540` | App Store | 5 | en | 1 ADHD and similar | not said |
| 160 | `4219ac94` | Play | 5 | en | 2 Can't start | not said |
| 162 | `83095944` | App Store | 5 | en | 2 Can't start; 4 Mornings; 6 Forget steps | not said |
| 165 | `83110582` | App Store | 5 | en | 3 Lose time | not said |
| 168 | `83118128` | App Store | 5 | en | 1 ADHD and similar | not said |
| 169 | `844f84d4` | Play | 5 | en | 1 ADHD and similar | not said |
| 172 | `e75d5c70` | Play | 4 | en | 1 ADHD and similar; 7 Parents | refused |
| 173 | `b3c1a9c5` | Play | 5 | en | 1 ADHD and similar | not said |
| 179 | `cf91499e` | Play | 5 | en | 1 ADHD and similar | not said |
| 191 | `bc79b387` | Play | 4 | en | 7 Parents | not said |
| 199 | `83326979` | App Store | 5 | en | 1 ADHD and similar; 6 Forget steps | not said |
| 214 | `83450444` | App Store | 5 | en | 1 ADHD and similar | not said |
| 226 | `a520dea1` | Play | 5 | en | 3 Lose time | not said |
| 231 | `83550495` | App Store | 5 | en | 1 ADHD and similar; 5 Tried everything | not said |
| 258 | `88825831` | Play | 5 | pt | 1 ADHD and similar | not said |
| 263 | `83812481` | App Store | 5 | en | 1 ADHD and similar; 2 Can't start; 3 Lose time | not said |
| 267 | `dbbbe3dc` | Play | 4 | en | 2 Can't start | not said |
| 273 | `e1c501af` | Play | 3 | en | 1 ADHD and similar | not said |
| 279 | `83946145` | App Store | 4 | en | 5 Tried everything | not said |
| 280 | `978f5f20` | Play | 5 | ko | 2 Can't start | not said |
| 286 | `5a18ea55` | Play | 5 | en | 6 Forget steps | not said |
| 304 | `2f0e8c60` | Play | 1 | en | 3 Lose time | not said |
| 305 | `e8710d6d` | Play | 3 | en | 3 Lose time | not said |
| 311 | `b93e9df6` | Play | 5 | en | 1 ADHD and similar; 2 Can't start | not said |
| 313 | `84160661` | App Store | 5 | en | 1 ADHD and similar | not said |
| 340 | `84314450` | App Store | 4 | en | 3 Lose time | not said |
| 342 | `cd9f4d8b` | Play | 4 | en | Goal only | not said |
| 350 | `84395439` | App Store | 5 | en | 1 ADHD and similar; 3 Lose time | not said |
| 360 | `84476258` | App Store | 4 | en | 1 ADHD and similar; 2 Can't start | paid |
| 361 | `84484648` | App Store | 5 | en | 5 Tried everything | paid |
| 365 | `84527203` | App Store | 3 | en | 1 ADHD and similar | not said |
| 386 | `a4a4e2f0` | Play | 5 | en | 4 Mornings | not said |
| 389 | `84694093` | App Store | 4 | en | 1 ADHD and similar | not said |
| 392 | `84702590` | App Store | 5 | en | 2 Can't start | paid |
| 394 | `84731962` | App Store | 5 | es | 2 Can't start | not said |
| 409 | `84838955` | App Store | 4 | en | 3 Lose time | paid |
| 413 | `84885907` | App Store | 5 | en | 2 Can't start | free |
| 417 | `53de7b42` | Play | 5 | ko | 1 ADHD and similar | paid |
| 419 | `14f791c7` | Play | 5 | en | 1 ADHD and similar; 6 Forget steps | not said |
| 422 | `84947225` | App Store | 5 | en | 2 Can't start | paid |
| 425 | `85009665` | App Store | 5 | en | 1 ADHD and similar | not said |
| 446 | `3446e9ae` | Play | 5 | en | 1 ADHD and similar | not said |
| 447 | `061991fc` | Play | 5 | en | 1 ADHD and similar | not said |
| 480 | `163ddb45` | Play | 5 | en | 1 ADHD and similar | not said |
| 481 | `85579725` | App Store | 5 | en | 1 ADHD and similar | not said |
| 487 | `a3b317a4` | Play | 5 | en | 1 ADHD and similar | free |
| 490 | `85682881` | App Store | 5 | en | 8 Overwhelmed | not said |
| 491 | `85687834` | App Store | 5 | en | 8 Overwhelmed | not said |
| 498 | `b7acad91` | Play | 5 | ko | Goal only | not said |
| 508 | `85892507` | App Store | 5 | en | 1 ADHD and similar | not said |
| 512 | `5ba49229` | Play | 5 | ko | 1 ADHD and similar | paid |
| 514 | `85951197` | App Store | 5 | en | 3 Lose time; 4 Mornings | not said |
| 524 | `86057385` | App Store | 5 | en | 2 Can't start; 3 Lose time | free |
| 529 | `e2e479f3` | Play | 5 | en | 5 Tried everything | not said |
| 531 | `98650d64` | Play | 5 | en | 7 Parents | not said |
| 534 | `86132390` | App Store | 5 | en | 2 Can't start | not said |
| 542 | `86197148` | App Store | 5 | en | 2 Can't start; 5 Tried everything | not said |
| 543 | `86254726` | App Store | 4 | en | 1 ADHD and similar; 5 Tried everything; 6 Forget steps; 8 Overwhelmed | not said |
| 551 | `86389669` | App Store | 4 | ko | 2 Can't start; 9 Lost structure | not said |
| 568 | `86602999` | App Store | 5 | en | 3 Lose time | not said |
| 572 | `86680171` | App Store | 5 | ko | 4 Mornings | not said |
| 578 | `86789843` | App Store | 4 | en | 2 Can't start | not said |
| 590 | `87102295` | App Store | 4 | en | 1 ADHD and similar; 2 Can't start | not said |
| 598 | `87151223` | App Store | 5 | en | 2 Can't start | not said |
| 616 | `244b980b` | Play | 5 | en | 1 ADHD and similar | free |
| 619 | `6c2f04ba` | Play | 4 | en | 3 Lose time | not said |
| 622 | `69b70592` | Play | 5 | en | 2 Can't start | not said |
| 628 | `87425424` | App Store | 5 | en | 1 ADHD and similar; 3 Lose time; 4 Mornings | not said |
| 630 | `87444913` | App Store | 5 | en | Goal only | not said |
| 631 | `61353f94` | Play | 5 | en | 3 Lose time; 4 Mornings | not said |
| 642 | `a9f988b5` | Play | 5 | fr | Goal only | not said |
| 644 | `87596880` | App Store | 5 | en | 3 Lose time; 7 Parents | not said |
| 645 | `1f853deb` | Play | 5 | en | 1 ADHD and similar; 7 Parents | not said |
| 649 | `accdeb67` | Play | 4 | en | 1 ADHD and similar | not said |
| 659 | `87713753` | App Store | 5 | ko | 4 Mornings | free |
| 663 | `76c0c09a` | Play | 5 | ko | 3 Lose time | not said |
| 665 | `039b3b22` | Play | 5 | en | 9 Lost structure | not said |
| 677 | `87916562` | App Store | 4 | en | 2 Can't start; 3 Lose time | free |
| 698 | `896dbeb4` | Play | 1 | en | 5 Tried everything | not said |
| 724 | `88331753` | App Store | 4 | en | 5 Tried everything | not said |
| 741 | `88486865` | App Store | 3 | en | 2 Can't start; 4 Mornings | not said |
| 747 | `f77cfa64` | Play | 4 | en | 1 ADHD and similar | not said |
| 751 | `124d3784` | Play | 5 | en | 2 Can't start | not said |
| 754 | `e2230360` | Play | 5 | en | 5 Tried everything | not said |
| 756 | `6a5b871e` | Play | 4 | en | 1 ADHD and similar | free |
| 758 | `df8fce36` | Play | 5 | en | 2 Can't start | paid |
| 768 | `6c802143` | Play | 5 | en | 1 ADHD and similar | not said |
| 773 | `88895759` | App Store | 5 | en | 3 Lose time | not said |
| 775 | `59055fec` | Play | 5 | en | 9 Lost structure | not said |
| 779 | `a620908b` | Play | 5 | en | 1 ADHD and similar | not said |
| 781 | `e3e9b9e8` | Play | 5 | en | 1 ADHD and similar | not said |
| 790 | `88983813` | App Store | 5 | ko | 2 Can't start | not said |
| 794 | `88988503` | App Store | 5 | en | 1 ADHD and similar; 3 Lose time; 6 Forget steps | not said |
| 796 | `23ed6b45` | Play | 5 | en | 1 ADHD and similar; 3 Lose time | not said |
| 808 | `89138068` | App Store | 5 | es | 2 Can't start; 4 Mornings | not said |
| 822 | `03feb0a4` | Play | 5 | en | 2 Can't start | not said |
| 824 | `5cc2b73a` | Play | 5 | en | 5 Tried everything | not said |
| 826 | `89243424` | App Store | 4 | en | 4 Mornings | not said |
| 831 | `89270809` | App Store | 5 | en | 1 ADHD and similar | not said |
| 833 | `9062e13e` | Play | 5 | en | 2 Can't start | not said |
| 842 | `89347921` | App Store | 5 | en | 2 Can't start; 5 Tried everything | not said |
| 845 | `531e1728` | Play | 5 | ko | 2 Can't start | not said |
| 849 | `89378384` | App Store | 5 | ja | 5 Tried everything | not said |
| 852 | `afe8d56b` | Play | 5 | en | 2 Can't start; 3 Lose time | not said |
| 854 | `6a348e54` | Play | 5 | en | 1 ADHD and similar | not said |
| 862 | `60298f16` | Play | 5 | en | 9 Lost structure | not said |
| 867 | `7a65dfc4` | Play | 5 | ko | 2 Can't start | free |
| 884 | `d3891b47` | Play | 5 | ko | 2 Can't start | not said |
| 888 | `0b9c7fd4` | Play | 5 | en | 1 ADHD and similar; 2 Can't start | free |
| 889 | `149243df` | Play | 5 | en | 2 Can't start | not said |
| 895 | `c7a70d88` | Play | 5 | en | 1 ADHD and similar; 6 Forget steps | not said |
| 899 | `89729423` | App Store | 5 | ko | 2 Can't start; 8 Overwhelmed | not said |
| 902 | `07fbf4f1` | Play | 5 | en | 2 Can't start; 4 Mornings | not said |
| 914 | `96cc8fdb` | Play | 5 | en | 1 ADHD and similar; 3 Lose time | not said |
| 917 | `89849434` | App Store | 3 | en | 5 Tried everything | refused |
| 921 | `f68b2060` | Play | 5 | es | 1 ADHD and similar | not said |
| 943 | `89987790` | App Store | 5 | en | 1 ADHD and similar; 5 Tried everything | not said |
| 944 | `b1ec0c92` | Play | 5 | en | 1 ADHD and similar | not said |
| 955 | `90108996` | App Store | 5 | ko | 2 Can't start | not said |
| 963 | `90176855` | App Store | 5 | en | 3 Lose time; 4 Mornings | not said |
| 994 | `66ffd718` | Play | 5 | en | 1 ADHD and similar | paid |
| 1000 | `6e1f227e` | Play | 5 | fr | 2 Can't start | paid |
| 1019 | `90664702` | App Store | 5 | en | 2 Can't start; 4 Mornings | not said |
| 1022 | `cb8e6da5` | Play | 5 | en | 1 ADHD and similar | not said |
| 1025 | `92840693` | Play | 5 | en | 1 ADHD and similar; 4 Mornings | not said |
| 1027 | `6699e7d2` | Play | 5 | en | 1 ADHD and similar | not said |
| 1030 | `7c051a20` | Play | 4 | en | 7 Parents | not said |
| 1032 | `d289f6a0` | Play | 5 | en | 1 ADHD and similar; 3 Lose time | free |
| 1038 | `b2c5bedd` | Play | 5 | es | 9 Lost structure | not said |
| 1043 | `90840275` | App Store | 5 | en | 6 Forget steps | not said |
| 1044 | `90854453` | App Store | 5 | en | 1 ADHD and similar | not said |
| 1045 | `54e25f36` | Play | 5 | de | 3 Lose time | not said |
| 1048 | `a935ba45` | Play | 5 | en | 1 ADHD and similar | not said |
| 1052 | `90960375` | App Store | 5 | en | 5 Tried everything; 8 Overwhelmed | not said |
| 1055 | `90988372` | App Store | 5 | en | 1 ADHD and similar | not said |
| 1074 | `91132559` | App Store | 5 | en | 1 ADHD and similar | not said |
| 1076 | `30a0c4dc` | Play | 5 | en | 1 ADHD and similar | not said |
| 1077 | `91152861` | App Store | 5 | en | 1 ADHD and similar; 4 Mornings | not said |
| 1112 | `91478862` | App Store | 5 | en | 4 Mornings; 8 Overwhelmed | not said |
| 1126 | `54e0fb96` | Play | 5 | es | 7 Parents | not said |
| 1129 | `6a43e66f` | Play | 5 | en | 1 ADHD and similar | not said |
| 1149 | `91708706` | App Store | 3 | en | 1 ADHD and similar | not said |
| 1152 | `8355e3e5` | Play | 5 | en | 2 Can't start; 8 Overwhelmed | not said |
| 1156 | `2499ba2e` | Play | 5 | en | 1 ADHD and similar | not said |
| 1158 | `91756797` | App Store | 5 | en | 1 ADHD and similar | not said |
| 1165 | `ff82be7c` | Play | 5 | es | 2 Can't start | not said |
| 1169 | `91837717` | App Store | 4 | en | 1 ADHD and similar; 2 Can't start | not said |
| 1172 | `e46de97c` | Play | 5 | ko | 2 Can't start | paid |
| 1175 | `91889429` | App Store | 5 | en | 3 Lose time; 7 Parents | paid |
| 1184 | `91933812` | App Store | 5 | fr | 10 Method | not said |
| 1188 | `7e5eedd0` | Play | 5 | en | 1 ADHD and similar | not said |
| 1189 | `91974647` | App Store | 4 | en | 2 Can't start; 5 Tried everything | refused |
| 1211 | `92153696` | App Store | 4 | en | 4 Mornings | not said |
| 1217 | `1a8f23a1` | Play | 3 | pt | Goal only | free |
| 1225 | `74b3fb59` | Play | 5 | ko | 4 Mornings | not said |
| 1229 | `f5e543d8` | Play | 5 | en | 1 ADHD and similar | free |
| 1231 | `a65e89ce` | Play | 5 | de | 1 ADHD and similar | paid |
| 1233 | `f2804c65` | Play | 5 | fr | Goal only | not said |
| 1234 | `92288612` | App Store | 5 | ko | 4 Mornings | not said |
| 1240 | `14a0bcc6` | Play | 5 | ko | 2 Can't start | not said |
| 1242 | `760b0ea2` | Play | 5 | fr | 7 Parents | not said |
| 1248 | `3d3e5d7c` | Play | 5 | ko | 2 Can't start; 3 Lose time | not said |
| 1260 | `92473907` | App Store | 5 | en | 1 ADHD and similar | not said |
| 1261 | `92476194` | App Store | 5 | en | 1 ADHD and similar; 2 Can't start | not said |
| 1264 | `1a388d7c` | Play | 5 | en | 1 ADHD and similar | not said |
| 1277 | `92621448` | App Store | 5 | en | 3 Lose time; 8 Overwhelmed | not said |
| 1279 | `92629984` | App Store | 5 | ko | 2 Can't start | not said |
| 1290 | `92695225` | App Store | 5 | en | 1 ADHD and similar | not said |
| 1314 | `92836942` | App Store | 5 | en | 1 ADHD and similar; 5 Tried everything | not said |
| 1341 | `bffd69e3` | Play | 5 | ja | 2 Can't start | not said |
| 1350 | `40bc8516` | Play | 5 | en | 3 Lose time | free |
| 1355 | `93122142` | App Store | 5 | en | 3 Lose time | not said |
| 1357 | `93160594` | App Store | 5 | en | 1 ADHD and similar; 3 Lose time | not said |
| 1374 | `93264846` | App Store | 5 | ko | 3 Lose time; 4 Mornings | paid |
| 1375 | `4e783282` | Play | 5 | es | 7 Parents | not said |
| 1384 | `93331305` | App Store | 5 | ko | 2 Can't start | not said |
| 1391 | `93379130` | App Store | 5 | en | 3 Lose time; 6 Forget steps | not said |
| 1417 | `93607428` | App Store | 5 | ja | 5 Tried everything | not said |
| 1421 | `7c0fa854` | Play | 1 | en | 2 Can't start | not said |
| 1422 | `8a71a16e` | Play | 5 | ko | 2 Can't start | not said |
| 1442 | `3efdf950` | Play | 1 | en | 1 ADHD and similar | charged unexpectedly |
| 1457 | `5b0794fe` | Play | 5 | pl | 3 Lose time | not said |
| 1463 | `a5adeea7` | Play | 5 | en | 1 ADHD and similar | not said |
| 1469 | `94009434` | App Store | 5 | en | 7 Parents | paid |
| 1487 | `94147748` | App Store | 5 | en | 1 ADHD and similar | not said |
| 1500 | `1ca30c61` | Play | 5 | en | 6 Forget steps | not said |
| 1503 | `94299047` | App Store | 5 | en | 1 ADHD and similar | not said |
| 1505 | `2b83b233` | Play | 5 | ko | 2 Can't start | not said |
| 1514 | `94392587` | App Store | 2 | en | Goal only | not said |
| 1523 | `a2d41e9b` | Play | 4 | en | 1 ADHD and similar | not said |

213 people: 205 in at least one pain-point group, 8 with a goal only. Checked: every ID in this report is in `Review Labels/Routinery/2022/reviews.jsonl`.
