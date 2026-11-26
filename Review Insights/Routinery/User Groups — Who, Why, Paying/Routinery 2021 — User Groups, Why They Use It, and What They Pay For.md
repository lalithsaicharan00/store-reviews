# Routinery 2021: User Groups, Why They Use It, and What They Pay For

Written by Claude (Claude Code), 26 November 2026, at the user's request.

**What this is.** Routinery's target users as its 2021 reviews show them, the way UX user research describes them:
the groups of people who use it, each defined by the **pain point** that brought them; why each group uses it; whether
each group pays, how many, and for what; and which free features each group likes. The third year of a series
([2019](<Routinery 2019 — User Groups, Why They Use It, and What They Pay For.md>),
[2020](<Routinery 2020 — User Groups, Why They Use It, and What They Pay For.md>)).

**How it was done.** From the reviews alone, as research for a new product or a full rebuild. No product of ours, its
features or its code was used to choose, read or group anything.

**Source.** The checked labels for all 1,626 reviews of 2021 in `Review Labels/Routinery/2021/labels.jsonl`, the same
way as 2020:

- **Groups:** from `who` and `why_chose`. I read all 357 reviews that have either and put each person in the group(s)
  their own words describe. One person can be in more than one group.
- **Features liked:** from `liked` and `chose_for`, sorted into the same kinds as 2020 by the words in each feature.
- **Paying:** from `paid` and its reason, plus the price and premium complaints in `problems`.

Review IDs are shortened to their first 8 characters; the appendix maps every group member to its line in the labels
file. The map is saved as [`Tools/groups_2021.py`](<Tools/groups_2021.py>); [README.md](<README.md>) explains the method.

---

## The short answer

- **1,626 reviews** (1,309 Google Play, 317 App Store), average 4.29★. **200 people (12%) name a pain point**; 18 more
  name only a goal.
- **The target users are the same people as in 2020: those whose days fall apart without outside structure.** The
  order changed. People who **can't start or keep going**, people who **tried everything else** and people with
  **ADHD and similar** now lead; COVID's "lost my structure" nearly disappears. A new group shows up: people
  **overwhelmed** by long to-do lists and by busy, complicated apps.

| # | User group (the pain point) | People | Share of the 200 | ★ | Paid or trial | 2020 share |
|---|---|---|---|---|---|---|
| 1 | **Can't start or keep going:** procrastinate, low willpower, quit within days, lethargic | 56 | 28% | 4.82 | 6 | 27% |
| 2 | **Tried other apps, planners or paper; nothing stuck** | 55 | 28% | 4.85 | 8 | 16% |
| 3 | **Have ADHD, autism, executive dysfunction, depression or anxiety** | 48 | 24% | 4.83 | 3 | 15% |
| 4 | **Lose time:** distracted, daydream, can't manage time, run late | 42 | 21% | 4.69 | 7 | 24% |
| 5 | **Mornings go badly:** groggy, scroll in bed, fall back asleep, rush | 37 | 19% | 4.78 | 1 | 31% |
| 6 | **Forget steps and small habits** (meds, vitamins, teeth) | 12 | 6% | 4.50 | 3 | 8% |
| 7 | **Overwhelmed:** long to-do lists, or other apps too busy and complicated *(new)* | 8 | 4% | **5.00** | 1 | — |
| 8 | **Parents:** for themselves with kids, or running it for a child | 6 | 3% | 4.50 | 1 | 3% |
| 9 | **Lost their structure:** COVID, back to in-person school, life changes | 5 | 3% | 5.00 | 0 | 11% |
| 10 | **Follow a method** (BJ Fogg, Miracle Morning, self-management books) | 4 | 2% | 4.75 | 1 | 6% |

  (61 people are in more than one group, so shares add up to more than 100%.)

- **Why they use it:** the same as 2020. The app walks them through a routine one step at a time with a timer on each
  step, so they don't have to decide, remember or find the willpower. New this year, more people say **why this app
  and not the others**: other apps were *"too damn complicated"*, *"all flash and no substance"* (about Fabulous),
  made for kids, or paywalled everything.
- **Paying is up but still small.** 64 of 1,626 (3.9%) say they paid (2.2% in 2020), 9 are on a trial and 4 were
  charged when they didn't expect it. Of the 186 who say anything about paying, 64 (34%) paid.
- **Most payers still pay for the whole app, not a feature:** 19 because it works for them, 10 because it's "worth
  it" for the price, and only 7 for a feature, 5 of those for **more routines**. 8 regret it, cancelled or asked for a
  refund.
- **The paywall is the third routine.** 79 reviews mention the free plan's two-routine limit: 66 want more, 10 say
  two are enough, 3 paid to get more. Others object to **subscription instead of one-time** (23), price (21) and the
  trial (14).
- **Korean reviewers pay most again:** 33 of the 64 payers write in Korean. 9.2% of Korean reviews say they paid,
  against 2.9% of English ones.
- **Free features liked:** simple and clean (202), the look and icons (154), **a timer on every step (85)**, more
  than one routine (58), encouraging words (47), reminders (41).

---

## 1. The year in numbers

| | Count | Share of 1,626 |
|---|---|---|
| Reviews | 1,626 | 100% |
| Google Play / App Store | 1,309 / 317 | 81% / 19% |
| Language: English, Korean, Spanish, Arabic, Portuguese, other | 893, 359, 163, 41, 41, 129 | 55%, 22%, 10%, 3%, 3%, 8% |
| Ratings 5★ / 4★ / 3★ / 2★ / 1★ | 1,064 / 259 / 122 / 72 / 109 | 65% / 16% / 8% / 4% / 7% |
| Say who they are (`who`) | 296 | 18% |
| Say why they came (`why_chose`) | 117 | 7% |
| Name a pain point (any group below) | **200** | **12%** |
| Name only a goal | 18 | 1% |
| Name a feature they like | 1,079 | 66% |
| Say anything about paying | 186 | 11% |
| Nothing useful ("great app") | 260 | 16% |

---

## 2. The user groups

### Group 1. Can't start or keep going (56 people, 28% of those naming a pain point, 4.82★)

**Who they are:** people who say they lack willpower or discipline, procrastinate, quit new habits within three days
(the Korean *작심삼일*) or a week, or were stuck in lethargy. Many are young: *"I'm in my 20s, eager to manage myself
but bad at following through"*. 33 are only in this group.

**Why they use it:**
- *"자기관리에 대한 열망은 높지만 실행력이 떨어지는 20대입니다"*, "I'm in my twenties, with a strong wish to manage
  myself but poor follow-through" (`68830277`, ko, 5★).
- *"평소 제가 작심삼일이라"*, "I usually give up after three days" (`70469879`, ko, 5★).
- *"have used them for a few days to a week at most"*, about other routine apps (`c76bedcc`, en, 5★).
- *"수개월 다짐만하던 아침루틴"*, "the morning routine I'd only resolved to do for months" (`a8d2844c`, ko, 5★).
- *"I was desperate to form these habits"* (`0fc50d24`, en, 4★).
- *"don't necessarily have the discipline to do so (like me)"* (`d6ef97d8`, en, 5★).
- *"my issue is procrastination"* (`892a7dbe`, en, 3★).

**Free features they like** (all 56 name one): the timer on every step (10), simple and clean (10), **more than one
routine (7)**, encouraging words (5), the look (5), reminders (4).

**Paying:** 6 paid, 8 free, 42 don't say. Reasons: *"habits became routine in under two weeks"* (`6978bd03`); *"it
worked from day one"* (`83c51e6e`); *"subscription worth every cent"* (`75964028`); worth investing in, a yearly plan
(`a7887427`); has the pro version, *"breaks indecision paralysis"* (`80169861`).

### Group 2. Tried other apps, planners or paper; nothing stuck (55 people, 28%, 4.85★)

**Who they are:** people who tested many apps (one *"6 other apps … today"*, another *"decenas"*, dozens), hopped
from app to app, wrote routines by hand, or left a specific app. **Fabulous** is named most: *"all flash and no
substance"*, *"patronising"*, *"overwhelming with too many distractions"*, *"no longer needed their mentorship"*.
Others left Habitify, Tiimo, Brili, Reminders and Calendar. Up from 16% of the pain-point people in 2020 to 28%.

**Why they use it:**
- *"Every other habit app I've tried just makes it too damn complicated"* (`e3561b40`, en, 5★).
- *"it's hard to find good routine timers like this that aren't made for kids"* (`07eca013`, en, 5★).
- *"It was all flash and no substance"*, about Fabulous (`f660fd82`, en, 4★).
- *"without the patronising tone & it has a lot more scope for customisation"* (`be710682`, en, 4★).
- *"where it's always necessary to pay but with this app there's no need"* (`69528509`, en, 5★).
- *"워낙 앱 하나에 정착하지 못하고 여기저기 다니는데"*, "I never settle on one app and keep wandering between them"
  (`41a1981b`, ko, 5★).
- *"It was recommended by another reddit user with ADHD"* (`2dd9c0ed`, en, 4★).

**Free features they like** (54 of 55): **simple and clean (21)**, the look and icons (15), the timer on every step
(12), the free version being enough (5). This group values *less*: fewer extras than the apps they left.

**Paying:** the group that pays most often: 7 paid and 1 trial (8 of 55, 15%), 8 free, 1 refused. Payers: unlimited
routines and all icons (`378b0ca9`); *"it worked from day one"* (`83c51e6e`); *"subscription well worth it"*
(`77769088`); liked the design and wanted the routine log (`77860486`); many routines to fix (`77444954`). The
refusal *"would pay more for a one-time purchase"* (`75458624`).

### Group 3. Have ADHD, autism, executive dysfunction, depression or anxiety (48 people, 24%, 4.83★)

**Who they are:** people who say so: ADHD or ADD (38, up from 15 in 2020), autism, OCD or executive dysfunction (7),
depression, anxiety or other mental-health difficulty (10). One found it through *"another reddit user with ADHD"*.
44 of 48 give 5★. 27 are only in this group.

**Why they use it:**
- *"maintaining a routine is really beneficial for me but its hard for me to maintain"* (`d980af9f`, en, 5★, ADHD).
- *"I have ADHD and need to be nudged to do things"* (`7be9312c`, en, 5★).
- *"the executive disfunction caused by my autism"* (`7d94012a`, en, 5★).
- *"I have recently discovered that I have autism"*, at 22, and struggles with routines and tasks (`71784648`, en,
  5★).
- *"I'm a mom who is very adhd and visual"* (`70576600`, en, 5★).
- *"got me out of my depression rut"* (`941e7292`, en, 5★).
- *"I used to watch morning routine tiktok videos and feel so jealous"*, with anxiety, depression and ADHD
  (`73611321`, en, 5★).
- *"this is the only app I've found that lets you set up a routine and then track how you follow it with timers"*
  (`27f14311`, en, 5★, ADD).

**Free features they like** (47 of 48): the timer on every step (9), simple and clean (6), **reminders and nudges
(5)**, the look (4), more than one routine (4), pause, skip or add time (3).

**Paying:** 2 paid, 1 trial, 3 free, 42 don't say. *"worth $2.50 a month"*, *"press start and it keeps me on task"*
(`291a401d`, ADHD with executive dysfunction); unlimited routines and all icons (`378b0ca9`, adult with ADD).

### Group 4. Lose time (42 people, 21%, 4.69★)

**Who they are:** people who get distracted, daydream, can't manage time or are always late; several want to run
their routine from a **watch** to stay away from the phone.

**Why they use it:**
- *"the time gets away from me and I start day dreaming"* (`89686734`, en, 5★).
- *"해야할 일을 머릿 속으로는 아는데 집중력이 분산되어"*, "I know what I have to do, but my focus scatters"
  (`74114269`, ko, 5★).
- *"before this app I was constantly running late"* (`80770118`, en, 5★).
- *"people like me who suck at managing their time"* (`bcbaabdf`, en, 5★).
- *"Gasto tanto tiempo"*, "I spend so much time" (`ebff22f5`, es, 5★).
- *"I rely on the watch to run my routines"* (`72666788`, en, 3★).

**Free features they like** (41 of 42): the timer (7), more than one routine (6), simple (5), reminders (4), the look
(4).

**Paying:** 4 paid, 3 trial, 4 free. The yearly plan for the time limit per task and *"shows when you'll be done"*
(`bcbaabdf`); bought it for their son *"to see the other options"* (`e5c86982`).

### Group 5. Mornings go badly (37 people, 19%, 4.78★)

**Who they are:** people who wake groggy, scroll in bed, fall back asleep watching YouTube, rush to school or work
late. Down from the biggest group in 2020 (31%) to fifth.

**Why they use it:**
- *"I tend to wake up groggy and want to mindlessly scroll"* (`3590da4b`, en, 5★).
- *"맨날 아침에 유투브 보다가 다시 잠드는게 일상이엿는데"*, "every morning I'd watch YouTube and fall back asleep"
  (`621d4f69`, ko, 5★).
- *"cuando ando en modo zombie por recién levantarme"*, "when I'm in zombie mode right after getting up" (`0c242aa6`,
  es, 5★).
- *"when I get ready for school I'm on my phone and then rushing when I'm already late"* (`c9512807`, en, 5★).
- *"Had a normal person morning routine for the first time in my life"* (`78f60a2b`, en, 5★).
- *"기계가 시키는데로 하면좋겠다싶었는데"*, "I wished I could just do what a machine told me" (`2fc7ed8f`, ko, 5★).

**Free features they like** (all 37): the timer on every step (9), simple (6), **seeing how long things take (4)**,
the look (3).

**Paying:** 1 trial, 6 free, 30 don't say. The group least likely to pay, in both years.

### Group 6. Forget steps and small habits (12 people, 6%, 4.50★)

- *"part of the struggle I had with setting routines was that I'd forget what habits I wanted to have"*
  (`457361a2`, en, 5★).
- A phone alarm for meds *"I was continually snoozing"* (`1599fd0e`, en, 5★).
- *"알람을 설정해놨음에도 자꾸 까먹는 경향이 있어서요"*, "I keep forgetting even with alarms set" (`894833d6`, ko,
  4★).
- Alarms *"disturbed my family"* (`3414eebf`, en, 5★).

**Free features they like:** the timer (5), **reminders (4)**, simple (3). **Paying:** 2 paid, 1 trial.

### Group 7. Overwhelmed (8 people, 4%, 5.00★) *new*

**Who they are:** people overwhelmed by long to-do lists, or by other apps with too much in them. All 8 give 5★.

- *"I get overwhelmed with long todo lists"* (`fb61e04b`, en, 5★).
- *"a lot of these apps have too many extras that overwhelm me so I end up just deleting"* (`78748451`, en, 5★,
  ADHD).
- *"I tried the fabulous app and it was overwhelming with too many distractions"* (`79220783`, en, 5★).
- *"I came after downloading about 50+ for productivity just because they are complex"* (`af0366c0`, en, 5★).

**Free features they like:** **simple and clean (6 of 8)**, the look (4), the free version is enough (3). **Paying:**
1 trial, 2 free.

### Group 8. Parents (6 people, 3%, 4.50★)

A mom with ADHD; a parent with kids every other week; parents who run it for a child (*"Je l'ai téléchargé pour mon
fiston"*, "I downloaded it for my little boy", `e5c86982`); *"even my 12 year old daughter does this app"*
(`641c62c4`); one uses it to help a family member's adult ADHD (`79759086`). **Paying:** 1 paid (`e5c86982`).

### Group 9. Lost their structure (5 people, 3%, 5.00★)

COVID is fading from the reviews: rebuilding *"my previous routine, prior to COVID"* (`f7fff1c7`), getting used to
in-person school again (`fc779935`), *"ahora que regresaron las clases"*, "now that classes are back" (`f3249f17`).
**Paying:** none say.

### Group 10. Follow a method (4 people, 2%, 4.75★)

BJ Fogg (*"As soon as I saw the words, BJ Fogg, I was elated"*, `af652797`), the Miracle Morning (`a3910ec6`,
`73291309`), self-management books that were hard to apply (`a7887427`, a payer). **Paying:** 1 paid.

### People who name only a goal (18 people, 4.56★)

"Build habits", "plan my day", a "glow-up". 2 paid, 3 refused (*"can't experience the app before paying"*, advertised
as free, *"would pay £20 once"*).

---

## 3. Paying

### How many pay

| | 2021 | Share of 1,626 | Share of the 186 who say anything | 2020 (of 1,122) |
|---|---|---|---|---|
| Paid | 64 | 3.9% | 34% | 25 (2.2%) |
| On a trial | 9 | 0.6% | 5% | 7 |
| Charged unexpectedly | 4 | 0.2% | 2% | 2 |
| Refused to pay | 23 | 1.4% | 12% | 35 |
| Use it free and say so | 86 | 5.3% | 46% | 59 |
| Don't say | 1,440 | 89% | — | 994 |

**By group** (paid + trial): tried everything 8 of 55 (15%); lose time 7 of 42; can't start 6 of 56; ADHD and
similar 3 of 48; forget steps 3 of 12; mornings 1 of 37; overwhelmed 1 of 8; parents 1 of 6; method 1 of 4; lost
structure 0 of 5. **Only the "tried everything" group stands out a little, and the counts are small.**

**By language:** 33 of the 64 payers write in Korean, 26 in English. 9.2% of the 359 Korean reviews say they paid,
against 2.9% of the 893 English ones. Refusals: 17 of 23 in English. Two payers (one Korean, one English) bought a **"1+1" offer**
(a 6-month plan with a second one given away).

### Why the payers paid

| Reason | Payers | IDs |
|---|---|---|
| The whole app works for them, or they liked it straight away | 19 | `6978bd03` `69132848` `12f0fcae` `bd3c67a4` `83c51e6e` `c22987e4` `a870d0d2` `76377735` `a88f65e8` `77372980` `77551425` `e568898f` `2a89a44e` `80169861` `f367b502` `81201373` `72680769` `c1fcf399` `bcbaabdf` |
| Worth it for the price (*"worth 10 cents a day"*, *"$2.50 a month"*, *"worth every cent"*) | 10 | `291a401d` `fa03d3ab` `1ae88669` `ac5ef02d` `75964028` `6751bc00` `789352f7` `77769088` `3c1c40e0` `a7887427` |
| **For a feature: more routines (5)**, the routine log (1), to see the paid options (1) | 7 | `b72d1805` `378b0ca9` `3e6fb1ba` `42142896` `77444954` · `77860486` · `e5c86982` |
| Used the free version first, then paid | 2 | `b9eb2124` `09af6243` |
| A promotion (1+1) | 1 | `81426667` |
| Out of gratitude, not need | 1 | `2e8ee251` |
| Regret it, cancelled, or asked for a refund | 8 | `8ea89303` `2641fd7f` `77861924` `78055913` `c87b5447` `79507231` `bc168cd9` `81022149` |
| No reason given | 16 | `68172394` `892a7dbe` `69624565` `8605ed47` `71506706` `72886403` `9cf9111e` `1451771e` `e969208d` `79790709` `3f3e72d1` `894833d6` `65271ab4` `81190937` `81343308` `3f13d6cb` |

**The feature people pay for, when they name one, is more routines** (*"to get more than two routines"*; *"wanted more
routines (work day, off day, bedtime)"*). Payers who weigh the price think of it per day: *"a habit for about 100 won a day"*
(Korean, 2020), *"worth 10 cents a day"* (Italian, 2021).

**Charged unexpectedly (4):** renewed after cancelling in the trial (`68829264`), a yearly plan with no free trial
(`e866c1c8`), $30 charged at once on starting a trial (`79818020`), a double charge with no reply (`11ac49fe`).

### What premium holds (from what free users miss and payers name)

| Behind the paywall | Reviews |
|---|---|
| **More than two routines** | 79 mention it: 66 want more (most want 3–5), 10 say two are enough (*"two routines are plenty"*), 3 paid for more |
| All the icons | 7 |
| Backup or sync | 4 |
| Statistics | 2 |

### Why others won't pay

| Objection | Reviews |
|---|---|
| A subscription rather than a one-time or lifetime price | 23 |
| Too expensive or can't afford it (students, job seekers, minors whose parents control purchases) | 21 |
| The trial: too short, or asked to pay before trying | 14 |
| Charged unexpectedly | 4 |

---

## 4. Free features people like

Across all 1,626 reviews, 1,079 (66%) name something they like:

| Feature | Reviews | Groups that name it most |
|---|---|---|
| Simple, clean, easy, nothing extra | 202 | **Tried everything (21)**, can't start (10), overwhelmed (6 of 8) |
| The look: design, cute icons | 154 | Tried everything (15), can't start (5) |
| **A timer on every step** | 85 | Tried everything (12), can't start (10), ADHD and similar (9), mornings (9), lose time (7) |
| More than one routine (morning, night, work day, off day) | 58 | Can't start (7), lose time (6), ADHD and similar (4) |
| Encouraging words, levels, "Well done" | 47 | Can't start (5) |
| Reminders and nudges | 41 | ADHD and similar (5), forget steps (4), lose time (4) |
| The free version is enough | 25 | Tried everything (5), overwhelmed (3) |
| Walked through one step at a time | 23 | — |
| Pause, skip or add time to a step | 21 | ADHD and similar (3) |
| A responsive developer | 19 | — |

**Per group:** the same pattern as 2020. The **timer** matters to everyone who loses time or can't start; **simple
and uncluttered** matters most to people coming from other apps and to the overwhelmed; **reminders and nudges**
matter to people with ADHD and to the forgetful; people who can't start also like **more than one routine** and the
encouragement.

---

## 5. Who they say they are

From `who` (296 people say something):

| They say they are | People | 2020 |
|---|---|---|
| ADHD or ADD | 38 | 15 |
| **Apple Watch or other smartwatch user** (several want to run routines from the wrist, away from the phone) | 34 | 10 |
| Student | 21 | 10 |
| Procrastinator, lazy, low willpower, quits within days | 19 | 13 |
| Working (5 of them shift or night workers) | 17 | 17 |
| Short of money or won't subscribe | 17 | — |
| Tried many other apps | 14 | 10 |
| Depression, anxiety, other mental-health difficulty | 10 | 6 |
| iPad or tablet user | 9 | 5 |
| Parent | 7 | 5 |
| Autism, OCD, executive dysfunction | 7 | 4 |
| Minor (12-year-olds, teenagers) | 5 | 3 |
| Follow a method or book | 4 | 8 |

---

## 6. What changed from 2020

| | 2020 | 2021 |
|---|---|---|
| Biggest group | Mornings go badly (31%) | Can't start (28%), tried everything (28%) |
| ADHD and similar | 25 people (15%) | 48 (24%) |
| Lost their structure (COVID) | 18 (11%) | 5 (3%) |
| New group | — | Overwhelmed by busy apps and long lists (8) |
| Said they paid | 25 (2.2%) | 64 (3.9%) |
| Payers writing in Korean | 14 of 25 | 33 of 64 |
| Refused to pay | 35 | 23 |
| Two-routine limit mentioned | 53 | 79 |

The app is found more often by people **leaving another app** and by people with **ADHD**, and more people say they
heard of it from someone: YouTubers (6), friends, Reddit, a writing group. People who come for "my mornings" fall from first to fifth.

---

## 7. Limits

- **88% don't name a pain point,** so the groups describe the 200 who do; the order is more reliable than the exact
  sizes.
- **The 2021 labels put more of the pain into `who`** (296) and less into `why_chose` (117) than 2020 did (153 and
  210). I read both fields for every person, so the groups are comparable, but the 2020 and 2021 counts of `why_chose`
  alone aren't.
- **Paying is said by 11%.** Group paying rates rest on 0–8 people.
- **Features are sorted by their words**, as in 2020.

---

## Appendix: every group member

`Line` is the review's line in `Review Labels/Routinery/2021/labels.jsonl`; `ID` is the first 8 characters of its
review ID.

| Line | ID | Store | ★ | Language | Groups | Paid |
|---|---|---|---|---|---|---|
| 20 | `38b749dd` | Play | 2 | en | Goal only | refused |
| 22 | `3590da4b` | Play | 5 | en | 4 Lose time; 5 Mornings | not said |
| 30 | `d980af9f` | Play | 5 | en | 1 Can't start; 3 ADHD and similar | not said |
| 51 | `532ec35e` | Play | 5 | en | 1 Can't start | not said |
| 62 | `ca702f16` | Play | 5 | ko | 5 Mornings | not said |
| 73 | `76b63f72` | Play | 5 | ko | 5 Mornings | not said |
| 76 | `378b0ca9` | Play | 5 | en | 2 Tried everything; 3 ADHD and similar; 4 Lose time; 6 Forget steps | paid |
| 77 | `d513280b` | Play | 5 | en | 3 ADHD and similar | not said |
| 80 | `6978bd03` | Play | 5 | ko | 1 Can't start | paid |
| 84 | `e5093781` | Play | 4 | en | 4 Lose time; 5 Mornings | not said |
| 87 | `68678885` | App Store | 5 | en | Goal only | not said |
| 89 | `99bb4497` | Play | 5 | en | 3 ADHD and similar; 4 Lose time | not said |
| 94 | `c76bedcc` | Play | 5 | en | 1 Can't start; 2 Tried everything | not said |
| 95 | `27f14311` | Play | 5 | en | 3 ADHD and similar | not said |
| 103 | `36e41b18` | Play | 5 | en | Goal only | not said |
| 107 | `68830277` | App Store | 5 | ko | 1 Can't start; 2 Tried everything; 5 Mornings | free |
| 115 | `68865614` | App Store | 5 | en | 1 Can't start; 5 Mornings | free |
| 122 | `68906973` | App Store | 5 | en | 1 Can't start | not said |
| 128 | `68949144` | App Store | 4 | ko | 4 Lose time | trial |
| 132 | `0fc50d24` | Play | 4 | en | 1 Can't start | not said |
| 143 | `cce32388` | Play | 4 | en | 6 Forget steps | not said |
| 146 | `69101140` | App Store | 5 | ko | 1 Can't start | not said |
| 168 | `b30b84af` | Play | 5 | en | 1 Can't start; 3 ADHD and similar; 8 Parents | not said |
| 175 | `7dc9ef04` | Play | 5 | ko | 1 Can't start; 2 Tried everything | not said |
| 182 | `a8d2844c` | Play | 5 | ko | 1 Can't start; 5 Mornings | not said |
| 184 | `6bfcf416` | Play | 5 | ko | 2 Tried everything | not said |
| 190 | `184c3889` | Play | 5 | en | 1 Can't start; 2 Tried everything | not said |
| 191 | `69528509` | App Store | 5 | en | 2 Tried everything | free |
| 193 | `892a7dbe` | Play | 3 | en | 1 Can't start | paid |
| 199 | `a78e1ce3` | Play | 5 | en | 2 Tried everything | not said |
| 200 | `7be9312c` | Play | 5 | en | 3 ADHD and similar; 6 Forget steps | not said |
| 208 | `69695471` | App Store | 5 | ko | 1 Can't start | not said |
| 213 | `69752108` | App Store | 5 | ko | 1 Can't start | free |
| 216 | `0c242aa6` | Play | 5 | es | 5 Mornings | not said |
| 225 | `8f6385d5` | Play | 1 | en | 3 ADHD and similar | not said |
| 235 | `af652797` | Play | 5 | en | 2 Tried everything; 10 Method | not said |
| 236 | `fb61e04b` | Play | 5 | en | 7 Overwhelmed | not said |
| 244 | `166f9176` | Play | 5 | fr | 3 ADHD and similar | not said |
| 249 | `dd965685` | Play | 5 | en | 1 Can't start | not said |
| 266 | `641c62c4` | Play | 5 | en | 8 Parents | not said |
| 271 | `7d94012a` | Play | 5 | en | 3 ADHD and similar | not said |
| 272 | `41a1981b` | Play | 5 | ko | 2 Tried everything | not said |
| 278 | `d6ef97d8` | Play | 5 | en | 1 Can't start | free |
| 285 | `e3561b40` | Play | 5 | en | 2 Tried everything; 7 Overwhelmed | not said |
| 288 | `246f8bb4` | Play | 4 | es | 2 Tried everything | not said |
| 289 | `70469879` | App Store | 5 | ko | 1 Can't start | not said |
| 290 | `70487309` | App Store | 3 | ko | 4 Lose time; 6 Forget steps | trial |
| 304 | `70576600` | App Store | 5 | en | 3 ADHD and similar; 8 Parents | not said |
| 307 | `12d906e9` | Play | 5 | en | 3 ADHD and similar | not said |
| 317 | `70687613` | App Store | 5 | en | 3 ADHD and similar | not said |
| 320 | `ee3e010b` | Play | 5 | es | 5 Mornings | not said |
| 321 | `1599fd0e` | Play | 5 | en | 6 Forget steps | not said |
| 339 | `70877308` | App Store | 5 | en | 2 Tried everything | not said |
| 346 | `fcf5aca5` | Play | 5 | en | 3 ADHD and similar | not said |
| 355 | `621d4f69` | Play | 5 | ko | 5 Mornings | not said |
| 360 | `4fdf145d` | Play | 5 | en | 3 ADHD and similar | not said |
| 368 | `bc1b847d` | Play | 5 | en | 3 ADHD and similar | not said |
| 381 | `78f60a2b` | Play | 5 | en | 5 Mornings | not said |
| 389 | `f7fff1c7` | Play | 5 | en | 9 Lost structure | not said |
| 397 | `457361a2` | Play | 5 | en | 6 Forget steps | not said |
| 415 | `09315c86` | Play | 5 | ko | 2 Tried everything; 6 Forget steps | not said |
| 420 | `2dd9c0ed` | Play | 4 | en | 2 Tried everything | not said |
| 435 | `71784648` | App Store | 5 | en | 1 Can't start; 3 ADHD and similar | free |
| 440 | `84c5fbbe` | Play | 5 | ko | 1 Can't start; 4 Lose time | not said |
| 441 | `71847621` | App Store | 5 | en | 4 Lose time; 5 Mornings | not said |
| 472 | `07eca013` | Play | 5 | en | 2 Tried everything | not said |
| 480 | `89686734` | Play | 5 | en | 4 Lose time | not said |
| 499 | `941e7292` | Play | 5 | en | 3 ADHD and similar | not said |
| 505 | `4ef261f7` | Play | 5 | ko | 5 Mornings | not said |
| 508 | `b4bfdf40` | Play | 4 | en | 2 Tried everything | not said |
| 513 | `72441407` | App Store | 5 | en | 1 Can't start; 3 ADHD and similar; 4 Lose time | free |
| 519 | `3341d889` | Play | 5 | en | 1 Can't start | not said |
| 525 | `c9512807` | Play | 5 | en | 4 Lose time; 5 Mornings | not said |
| 530 | `72666788` | App Store | 3 | en | 4 Lose time | not said |
| 531 | `291a401d` | Play | 5 | en | 3 ADHD and similar | paid |
| 538 | `19f49049` | Play | 5 | ko | Goal only | not said |
| 545 | `a0df4fde` | Play | 5 | es | 2 Tried everything | not said |
| 565 | `f660fd82` | Play | 4 | en | 2 Tried everything | not said |
| 568 | `1ae88669` | Play | 5 | it | Goal only | paid |
| 571 | `ddc7b64d` | Play | 5 | en | 9 Lost structure | not said |
| 573 | `be710682` | Play | 4 | en | 2 Tried everything | not said |
| 578 | `83c51e6e` | Play | 5 | en | 1 Can't start; 2 Tried everything | paid |
| 579 | `194e6b91` | Play | 5 | pl | 1 Can't start | not said |
| 585 | `a3910ec6` | Play | 5 | pt | 10 Method | not said |
| 591 | `b4dafa49` | Play | 5 | en | 5 Mornings | free |
| 596 | `73291309` | App Store | 4 | en | 1 Can't start; 5 Mornings; 10 Method | not said |
| 618 | `4fb2a6fa` | Play | 4 | en | Goal only | not said |
| 624 | `73611321` | App Store | 5 | en | 3 ADHD and similar; 5 Mornings | not said |
| 648 | `cb4afd9e` | Play | 5 | en | 2 Tried everything | not said |
| 650 | `73947663` | App Store | 5 | ko | 2 Tried everything | not said |
| 653 | `08f7b1d6` | Play | 5 | ko | 2 Tried everything | not said |
| 666 | `74114269` | App Store | 5 | ko | 4 Lose time | not said |
| 667 | `2fc7ed8f` | Play | 5 | ko | 1 Can't start; 5 Mornings | not said |
| 675 | `be11eefe` | Play | 5 | pt | 4 Lose time | not said |
| 682 | `36269afe` | Play | 5 | en | 3 ADHD and similar | not said |
| 690 | `d52296ea` | Play | 5 | en | 1 Can't start | not said |
| 697 | `74428283` | App Store | 5 | ko | 1 Can't start | not said |
| 703 | `414be491` | Play | 5 | en | 5 Mornings | not said |
| 721 | `64fe5cfa` | Play | 5 | en | 2 Tried everything; 5 Mornings | free |
| 723 | `cb336a4a` | Play | 5 | en | Goal only | not said |
| 724 | `87aeee81` | Play | 5 | en | 4 Lose time | not said |
| 725 | `4af0fee6` | Play | 5 | en | Goal only | not said |
| 732 | `74688649` | App Store | 5 | en | 1 Can't start; 5 Mornings | not said |
| 771 | `2638dd89` | Play | 5 | en | 2 Tried everything | not said |
| 773 | `b2107701` | Play | 5 | en | 2 Tried everything | free |
| 775 | `75123770` | App Store | 5 | de | Goal only | free |
| 778 | `d02cdf47` | Play | 5 | en | 2 Tried everything; 7 Overwhelmed | free |
| 781 | `c22987e4` | Play | 5 | ko | Goal only | paid |
| 783 | `3667f367` | Play | 5 | en | 2 Tried everything | not said |
| 792 | `2d74682c` | Play | 5 | en | 2 Tried everything; 3 ADHD and similar | not said |
| 800 | `75354230` | App Store | 5 | en | 1 Can't start | not said |
| 801 | `75365746` | App Store | 5 | en | 1 Can't start | not said |
| 811 | `0584cd7d` | Play | 5 | es | 2 Tried everything | not said |
| 816 | `fc779935` | Play | 5 | en | 9 Lost structure | not said |
| 817 | `75458624` | App Store | 4 | en | 2 Tried everything | refused |
| 834 | `d5d85143` | Play | 5 | en | 4 Lose time | not said |
| 847 | `8d3985c2` | Play | 5 | pt | 1 Can't start | not said |
| 856 | `75649102` | App Store | 5 | en | 3 ADHD and similar | not said |
| 860 | `ebff22f5` | Play | 5 | es | 4 Lose time | not said |
| 861 | `75669366` | App Store | 1 | en | 4 Lose time; 5 Mornings | not said |
| 871 | `75739472` | App Store | 5 | ko | Goal only | not said |
| 872 | `9bd230d4` | Play | 5 | es | 5 Mornings | not said |
| 886 | `bcbaabdf` | Play | 5 | en | 4 Lose time | paid |
| 898 | `75964028` | App Store | 5 | en | 1 Can't start; 2 Tried everything | paid |
| 943 | `98ba99fa` | Play | 5 | en | 1 Can't start | not said |
| 967 | `f3249f17` | Play | 5 | es | 9 Lost structure | not said |
| 978 | `29f9dcfb` | Play | 5 | en | 3 ADHD and similar | not said |
| 1001 | `80770118` | Play | 5 | en | 4 Lose time; 5 Mornings | not said |
| 1005 | `76846800` | App Store | 5 | en | 3 ADHD and similar; 4 Lose time | not said |
| 1022 | `a4f4671c` | Play | 5 | es | 1 Can't start | not said |
| 1029 | `3f5c78f0` | Play | 5 | en | 3 ADHD and similar | not said |
| 1034 | `77132065` | App Store | 5 | ko | 4 Lose time; 5 Mornings | not said |
| 1039 | `7aad547f` | Play | 5 | ko | 1 Can't start | not said |
| 1046 | `77199362` | App Store | 5 | en | 3 ADHD and similar; 4 Lose time; 5 Mornings | not said |
| 1049 | `fdf62a0a` | Play | 5 | es | 4 Lose time | not said |
| 1052 | `2343d5ce` | Play | 5 | en | 1 Can't start | not said |
| 1058 | `686e1cea` | Play | 5 | en | 1 Can't start | not said |
| 1073 | `317a8e32` | Play | 5 | es | 2 Tried everything | not said |
| 1077 | `77444954` | App Store | 5 | en | 2 Tried everything; 4 Lose time | paid |
| 1079 | `7984c7cb` | Play | 4 | fr | 4 Lose time | not said |
| 1089 | `92e024f8` | Play | 4 | en | 4 Lose time | free |
| 1092 | `ccaa042e` | Play | 5 | es | 6 Forget steps | not said |
| 1093 | `77524968` | App Store | 5 | en | 1 Can't start | not said |
| 1099 | `77550432` | App Store | 5 | ko | 5 Mornings | free |
| 1111 | `5e118c4d` | Play | 4 | en | 1 Can't start | not said |
| 1115 | `765dacf7` | Play | 5 | en | 3 ADHD and similar | not said |
| 1117 | `146dd5c8` | Play | 5 | en | 4 Lose time | not said |
| 1118 | `ba2109b4` | Play | 5 | ko | 4 Lose time | not said |
| 1124 | `77664876` | App Store | 5 | en | Goal only | not said |
| 1139 | `77769088` | App Store | 5 | ko | 2 Tried everything | paid |
| 1147 | `7cbef2db` | Play | 4 | en | 1 Can't start; 2 Tried everything | not said |
| 1153 | `77860486` | App Store | 5 | ko | 2 Tried everything | paid |
| 1164 | `77914204` | App Store | 5 | en | 2 Tried everything; 4 Lose time | not said |
| 1196 | `3414eebf` | Play | 5 | en | 6 Forget steps | not said |
| 1198 | `78061755` | App Store | 5 | en | 4 Lose time | not said |
| 1208 | `78112028` | App Store | 5 | ko | 1 Can't start; 2 Tried everything | not said |
| 1215 | `636a4e94` | Play | 5 | en | 1 Can't start | not said |
| 1220 | `78198029` | App Store | 5 | en | 3 ADHD and similar | not said |
| 1232 | `346a8cae` | Play | 4 | fr | 2 Tried everything | not said |
| 1244 | `bd1fe7fe` | Play | 4 | en | 3 ADHD and similar | not said |
| 1245 | `189ef66a` | Play | 5 | es | 2 Tried everything | not said |
| 1251 | `54f7a1b9` | Play | 4 | en | 1 Can't start | free |
| 1263 | `e5c86982` | Play | 4 | fr | 4 Lose time; 8 Parents | paid |
| 1271 | `08abb3f4` | Play | 5 | en | 4 Lose time; 5 Mornings | not said |
| 1285 | `78635131` | App Store | 5 | en | 2 Tried everything | free |
| 1293 | `78748451` | App Store | 5 | en | 2 Tried everything; 3 ADHD and similar; 4 Lose time; 5 Mornings; 7 Overwhelmed | trial |
| 1294 | `78768208` | App Store | 5 | en | 3 ADHD and similar | not said |
| 1299 | `58aec13d` | Play | 5 | en | 1 Can't start; 2 Tried everything; 3 ADHD and similar; 9 Lost structure | free |
| 1300 | `40193909` | Play | 5 | en | 1 Can't start | not said |
| 1304 | `62b03197` | Play | 5 | en | Goal only | not said |
| 1317 | `a32ff034` | Play | 5 | en | 5 Mornings | not said |
| 1322 | `5cc17343` | Play | 5 | es | 4 Lose time | not said |
| 1324 | `a4458585` | Play | 5 | en | 2 Tried everything; 4 Lose time | not said |
| 1332 | `79162415` | App Store | 5 | en | 2 Tried everything | not said |
| 1336 | `79220783` | App Store | 5 | en | 2 Tried everything; 7 Overwhelmed | not said |
| 1351 | `79295553` | App Store | 5 | ja | 2 Tried everything | not said |
| 1362 | `79347572` | App Store | 5 | en | 3 ADHD and similar | not said |
| 1366 | `a1598820` | Play | 5 | es | 1 Can't start | not said |
| 1368 | `79384929` | App Store | 5 | en | 3 ADHD and similar; 4 Lose time | not said |
| 1373 | `79432626` | App Store | 4 | ko | 1 Can't start | not said |
| 1379 | `79482001` | App Store | 5 | ko | 1 Can't start | not said |
| 1380 | `79492285` | App Store | 5 | en | 1 Can't start | not said |
| 1387 | `d68fcba5` | Play | 5 | en | 6 Forget steps | not said |
| 1393 | `65ba08e1` | Play | 5 | en | 5 Mornings | not said |
| 1399 | `7715f763` | Play | 5 | en | 2 Tried everything; 7 Overwhelmed | free |
| 1401 | `79596414` | App Store | 4 | en | 1 Can't start; 3 ADHD and similar | not said |
| 1405 | `a41475af` | Play | 5 | en | Goal only | not said |
| 1406 | `474ca8c0` | Play | 5 | ko | 3 ADHD and similar; 4 Lose time | not said |
| 1408 | `79627076` | App Store | 5 | en | 3 ADHD and similar | not said |
| 1418 | `79759086` | App Store | 5 | ko | 3 ADHD and similar; 8 Parents | not said |
| 1430 | `4e77e6ce` | Play | 5 | en | 3 ADHD and similar; 5 Mornings | not said |
| 1432 | `9cf08ce8` | Play | 5 | it | 2 Tried everything | not said |
| 1433 | `79836120` | App Store | 5 | es | 2 Tried everything; 4 Lose time | not said |
| 1441 | `0db2da70` | Play | 5 | en | 4 Lose time | free |
| 1447 | `79987950` | App Store | 5 | en | 1 Can't start; 3 ADHD and similar | not said |
| 1452 | `8f12ed8a` | Play | 3 | fr | 8 Parents | not said |
| 1456 | `4e66efaf` | Play | 3 | en | 3 ADHD and similar; 6 Forget steps | not said |
| 1461 | `5d436b4c` | Play | 5 | en | 7 Overwhelmed | not said |
| 1468 | `af0366c0` | Play | 5 | en | 2 Tried everything; 7 Overwhelmed | not said |
| 1469 | `9a45d8bb` | Play | 5 | en | 3 ADHD and similar | not said |
| 1473 | `eb6c770c` | Play | 4 | en | 5 Mornings | not said |
| 1475 | `80169861` | App Store | 5 | en | 1 Can't start | paid |
| 1514 | `44830335` | Play | 2 | en | Goal only | refused |
| 1528 | `894833d6` | Play | 4 | ko | 6 Forget steps | paid |
| 1529 | `e5b98ce4` | Play | 4 | en | 1 Can't start; 5 Mornings | not said |
| 1537 | `fbe8f3cb` | Play | 5 | en | Goal only | not said |
| 1539 | `65271ab4` | Play | 5 | cs | 2 Tried everything | paid |
| 1546 | `758a9942` | Play | 4 | en | Goal only | refused |
| 1555 | `df9bb846` | Play | 5 | en | 3 ADHD and similar | not said |
| 1556 | `dee6f283` | Play | 5 | en | Goal only | not said |
| 1565 | `9bd3b0a0` | Play | 5 | en | 4 Lose time; 5 Mornings | free |
| 1566 | `e3453e1e` | Play | 5 | en | 5 Mornings | not said |
| 1586 | `f24c7634` | Play | 5 | en | 3 ADHD and similar | not said |
| 1591 | `a7887427` | Play | 5 | ko | 1 Can't start; 10 Method | paid |
| 1606 | `81384763` | App Store | 5 | en | 3 ADHD and similar | not said |
| 1620 | `81773662` | App Store | 5 | en | 2 Tried everything | not said |
| 1621 | `81794789` | App Store | 5 | ko | 4 Lose time; 5 Mornings | not said |
| 1623 | `4bcc9756` | Play | 5 | en | 3 ADHD and similar | not said |

218 people: 200 in at least one pain-point group, 18 with a goal only. Checked: every ID in this report is in `Review Labels/Routinery/2021/reviews.jsonl`.
