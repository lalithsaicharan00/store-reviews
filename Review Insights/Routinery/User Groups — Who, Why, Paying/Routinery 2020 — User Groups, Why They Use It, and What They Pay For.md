# Routinery 2020: User Groups, Why They Use It, and What They Pay For

Written by Claude (Claude Code), 26 November 2026, at the user's request.

**What this is.** Routinery's target users as its 2020 reviews show them, the way UX user research describes them:
the groups of people who use it, each defined by the **pain point** that brought them; why each group uses it; whether
each group pays, how many, and for what; and which free features each group likes. The second year of a series
([2019](<Routinery 2019 — User Groups, Why They Use It, and What They Pay For.md>)).

**How it was done.** From the reviews alone, as research for a new product or a full rebuild. No product of ours, its
features or its code was used to choose, read or group anything.

**Source.** The checked labels for all 1,122 reviews of 2020 in `Review Labels/Routinery/2020/labels.jsonl` (each made
by reading one review, in its own language, and checked by a second reader):

- **Groups:** from `who` (what people say about themselves) and `why_chose` (the need or struggle that brought them).
  I read every one of the 288 reviews that have either and put each person in the group(s) their own words describe.
  One person can be in more than one group (a person with ADHD whose mornings fall apart is in both).
- **Features liked:** from `liked` and `chose_for`, sorted into kinds by the words in each feature.
- **Paying:** from `paid` (`paid`, `trial`, `charged_unexpectedly`, `refused`, `free` or `not_said`) and its reason,
  plus the price and premium complaints in `problems`.

Review IDs are shortened to their first 8 characters; the appendix maps every group member to its full place in the
labels file. The map is saved as [`Tools/groups_2020.py`](<Tools/groups_2020.py>); [README.md](<README.md>) explains the method.

---

## The short answer

- **1,122 reviews** (946 Google Play, 176 App Store), average 4.33★. **166 people (15%) name a pain point**; 45 more
  name only a goal ("build habits"); the rest say what they like or what's broken without saying why they came.
- **The target users are people whose days fall apart without outside structure.** Nine groups, by the pain point:

| # | User group (the pain point) | People | Share of the 166 | ★ | Paid or trial |
|---|---|---|---|---|---|
| 1 | **Mornings go badly:** can't get up, rushed, late, slow, dazed | 51 | 31% | 4.71 | 2 |
| 2 | **Can't start or keep going:** procrastinate, low willpower, give up new habits within days, listless | 45 | 27% | 4.82 | 2 |
| 3 | **Lose time:** get distracted, space out between tasks, can't manage time, disorganised days | 40 | 24% | 4.85 | 0 |
| 4 | **Tried other apps, planners or paper; nothing stuck** | 26 | 16% | 4.77 | 2 |
| 5 | **Have ADHD, autism, executive dysfunction, brain fog, depression or anxiety** | 25 | 15% | **4.92** | 1 |
| 6 | **Lost their structure:** COVID lockdown, working or studying from home, breakup, new baby | 18 | 11% | 4.78 | 3 |
| 7 | **Forget steps and small habits;** can't trust memory for the routine | 14 | 8% | 4.57 | 1 |
| 8 | **Follow a method** (Atomic Habits, Tiny Habits, Miracle Morning, GTD) and want a tool for it | 10 | 6% | 4.90 | 1 |
| 9 | **Parents and carers:** home and family take the day | 5 | 3% | 4.60 | 0 |

  (Shares add up to more than 100% because 54 people are in more than one group.)

- **Why they use it, in one line:** the app *walks them through* a routine, one step at a time, with a timer on each
  step, so they don't have to decide, remember or push themselves. The words people use are "without thinking",
  "takes the pressure off deciding", "like a game", "keeps me on track".
- **Paying is rare and mostly isn't about a feature.** 25 of 1,122 (2.2%) say they paid and 7 are on a trial;
  of the 128 who say anything about paying, 25 (20%) paid. Payers mostly pay because they **like the whole app**; not
  one payer says "I paid for feature X". What premium holds shows only in what free users miss: **a third routine**
  (53 mention the two-routine free limit), statistics, backup and sync.
- **People who say they paid are mostly Korean:** 14 of the 25. 6.4% of Korean reviewers say they paid, against 1.6%
  of English ones, while 27 of the 35 refusals are in English, most of them over **subscription instead of a one-time
  price** (33 reviews ask for one-time or lifetime).
- **Free features every group likes:** simple and clean (141 reviews of the year), the look and cute icons (132), the
  timer on every step (56), encouraging words (30), being walked through one step at a time (26). Groups 1, 3, 4, 5
  and 7 name **the timer** first; group 2 names the look and the encouragement as often as the timer; group 5 is the
  only group that often names **seeing when the routine will finish**.

---

## 1. The year in numbers

| | Count | Share of 1,122 |
|---|---|---|
| Reviews | 1,122 | 100% |
| Google Play / App Store | 946 / 176 | 84% / 16% |
| Language: English, Korean, Spanish, Portuguese, Arabic, other | 700, 218, 66, 37, 36, 65 | 62%, 19%, 6%, 3%, 3%, 6% |
| Ratings 5★ / 4★ / 3★ / 2★ / 1★ | 717 / 205 / 98 / 52 / 50 | 64% / 18% / 9% / 5% / 4% |
| Say who they are (`who`) | 153 | 14% |
| Say why they came (`why_chose`) | 210 | 19% |
| Name a pain point (any group below) | **166** | **15%** |
| Name only a goal ("build habits", "a routine") | 45 | 4% |
| Name a feature they like | 552 | 49% |
| Say anything about paying | 128 | 11% |
| Nothing useful ("great app") | 211 | 19% |

Dates: 10 January to 31 December 2020. The app changed its name from Good Morning to Routinery during the year
(`ac6eb127`: *"since it was good morning with the old version"*), added more than one routine, and started selling
premium.

---

## 2. The user groups

Each group is the people whose own words describe that pain point. ★ is the group's average rating.

### Group 1. Mornings go badly (51 people, 31% of those naming a pain point, 4.71★)

**Who they are:** people who oversleep, rush, run late to work or school, or stand dazed after waking. Some are
workers (*"barely get to work on time every day"*), some students, some say mental health makes getting up hard. 23 are
only in this group; the rest are also distracted (group 3), can't start (group 2) or forget steps (group 7).

**Why they use it:**
- *"매일 아침 늘어지고 늦잠자던 저에게"*, "for me, who dragged and overslept every morning" (`54325467`, ko, 5★).
- *"아침에 항상 허둥지둥하고 정신 없이 준비하다보면 꼭 놓치는게 생기더라구요"*, "I'm always flustered in the mornings,
  and getting ready in a rush I always miss something" (`54250498`, ko, 4★).
- *"mi rutina en la mañana la cual suele ser un desastre"*, "my morning routine, which is usually a disaster"
  (`26a58a72`, es, 4★).
- *"я не залипаю 3 часа в стену, не понимая, что мне надо делать"*, "I don't stare at the wall for 3 hours not knowing
  what to do" (`db49a94b`, ru, 5★).
- *"I usually have a very difficult time getting up because of mental health reasons"* (`1ac11d9c`, en, 5★).
- *"Not late to work since using this"* (`243a7081`, en, 4★).

**Free features they like** (38 of 51 name one): the timer on every step (10), the look and icons (8), simple and
clean (8), being walked through in order (7), reminders (3), more than one routine (3), no ads (3).

**Paying:** 1 paid, 1 trial, 4 say free, 45 don't say. The payer (`65744612`) says premium *"has been so worth it that
I'm happy to pay"*; the trial user (`63706862`) thinks it's worth $3 a month.

### Group 2. Can't start or keep going (45 people, 27%, 4.82★)

**Who they are:** people who say they procrastinate, have no willpower, give up new habits after three days (the Korean
*작심삼일*), or are stuck being lazy and listless. Many have tried before and blamed themselves.

**Why they use it:**
- *"I would give up so easily or talk myself out of even getting started"* (`58880910`, en, 5★).
- *"Completely removed my struggles with willpower and motivation"* (`bf73e8a7`, en, 5★).
- *"끈기도 없고 작심 3일인"*, "I have no persistence and quit everything after three days" (`28c8b64f`, ko, 5★).
- *"저 처럼 의지 없는 사람들에게 아주 최고"*, "the very best for people with no willpower, like me" (`62570460`, ko,
  5★).
- *"나태지옥에서 벗어났습니다"*, "I've escaped laziness hell" (`039c8e46`, ko, 5★).
- *"If I don't have an hourly schedule, I tend to sink into a slump"* (`03401fb6`, en, 5★).
- *"I could never get a morning/night routine in my 23 years of life"* (`acaa58b4`, en, 5★).

**Free features they like** (41 of 45 name one): the look and icons (9), simple and clean (8), **encouraging words and
the "Well done" moment (8)**, being walked through one step at a time (7), the timer (7). This group talks most about
how the app *feels*: *"takes the pressure off you having to decide every day … the countdown clock feels like I'm
playing a game"* (`665b0595`, 4★); *"I just take the action I've allocated, whether I feel like it or not"*
(`bf73e8a7`).

**Paying:** 2 paid, 3 say free, 40 don't say. Payers: *"plenty of free content and no ads, which is why I bought the
premium version"* (`caee22d9`); *"a habit for about 100 won a day"* (the subscription page's words) was worth it
(`66692955`).

### Group 3. Lose time (40 people, 24%, 4.85★)

**Who they are:** people who get distracted, space out between tasks, lose track of time (one names *"time
blindness"*), or whose days are disorganised. Many overlap with group 1 (their mornings) and group 5 (ADHD).

**Why they use it:**
- *"se distrai com uma borboleta e acaba perdendo muito tempo"*, "you get distracted by a butterfly and end up losing
  a lot of time" (`c44beb64`, pt, 5★).
- *"The timers remove dilly-dallying that I end up doing between actions"* (`8a806edc`, en, 5★).
- *"행동 하나마다 멍때리는 시간이 길었는데"*, "I used to space out for a long time between every action" (`00b6a2f5`,
  ko, 5★).
- *"I struggle with "time blindness""* (`e96ffa22`, en, 5★).
- *"It turned my phone to a hazardous distraction to a great motivator"* (`1c909b18`, en, 5★).
- *"me distraían mucho con tanto mensajito y tanta parafernalia"*, about another app: "they distracted me a lot with
  all their little messages and fuss" (`66cd68ba`, es, 5★).

**Free features they like** (32 of 40): **the timer on every step (11)**, simple and clean (7), reminders when time is
up or a step is paused (5), no ads (4), seeing how long things take (4), seeing when the routine will finish (3).

**Paying:** none say they paid or tried it; 5 say they use the free version and that it's enough (*"the free version
has no ads and is completely strong enough"*, `8a806edc`).

### Group 4. Tried other apps, planners or paper; nothing stuck (26 people, 16%, 4.77★)

**Who they are:** people who searched for a long time, or used planners, notebooks, lists on the wall or other habit
apps and gave up. 18 are only in this group: they say why this app and not others, not what their own problem is.

**Why they use it:**
- *"I have been looking for a good app to help me with daily routines for years. This is the first app that actually
  does what I want"* (`267725e8`, en, 5★).
- *"계획 어플을 써보고 계획표도 써봤지만 금방 그만두었는데"*, "I tried planner apps and paper plans but quit quickly"
  (`57037296`, ko, 5★).
- *"매일 수첩에 손으로 잡고 동그라미 치고 힘들었는데"*, "every day I tracked it by hand in a notebook, circling things,
  and it was hard" (`68052256`, ko, 5★).
- *"o me aburrían o si no pagaban eran muy incompletas"*, "the other apps either bored me or, unless you paid, were
  very incomplete" (`1301afa7`, es, 5★).
- One came looking for a lost app: *"I had an app called Routinist which was very similar"*, then moved to Android
  (`ef72959b`, en, 4★).

**Free features they like** (24 of 26): the timer on every step (8), the look (5), simple and clean (5), being walked
through (5).

**Paying:** 1 paid, 1 trial, 1 free, 1 refused, 22 don't say. The trial user will *"probably"* subscribe *"because
it's the only type of app that keeps me consistent"* (`ef72959b`); the refusal *"would gladly pay a one-time fee, but
don't pay for subscriptions on apps like this"* (`64617988`).

### Group 5. Have ADHD, autism, executive dysfunction, brain fog, depression or anxiety (25 people, 15%, 4.92★)

**Who they are:** people who say so themselves: ADHD or ADD (15), autism, executive dysfunction or brain fog (4),
depression, anxiety or mental-health difficulty (6). The highest-rated group of the year: 24 of 25 give 5★.
Their pain is the same as groups 1, 2, 3 and 7, felt harder: they can't keep any schedule, lose focus, forget steps.

**Why they use it:**
- *"I have ADD, so I tend to have a LOT of trouble keeping up with any kind of schedule, especially when I don't have
  the structure that my classes would normally give me"* (`d978341d`, en, 5★).
- *"I have ADHD and it feels impossible sometimes to stay focused and accomplish my goals"* (`1e7aa119`, en, 5★).
- *"I struggle with Executive Dysfunction a LOT"* (`53180359`, en, 5★).
- *"I have a health condition that causes brain fog … this app has helped me so much with creating a consistent
  routine and helping me remember it"* (`3c1a0adf`, en, 5★).
- *"I have depression so sometimes doing things like brushing my teeth and making my bed is a struggle"* (`e413ae60`,
  en, 5★).
- *"I have autism … before I make a change to my routine it tells me when it will end, and that makes it so much
  easier for me to make a realistic mental map of my day"* (`9ebb4559`, en, 5★).
- *"plans/routines are the answer, not motivation or determination"* (`3b500845`, en, 5★, takes medication, foggy
  mornings).

**Free features they like** (24 of 25): the timer on every step (6), **seeing when the routine will finish (4: more
than any other group)**, being walked through one step at a time (4), pause, skip or add time (3), simple (3), more
than one routine (3). *"Countdowns for tasks in sequence; shows how long task series actually take"* (`bae761eb`,
ADHD, tried many paid habit apps).

**Paying:** 1 paid (`65744612`: ADHD, inattentive type, student working online, tried many productivity apps, says
premium *"has been so worth it"*), 2 free, 22 don't say. One asks for *"más de dos rutinas establecidas en la versión
gratis"*, "more than two routines in the free version" (`ad4337b1`).

### Group 6. Lost their structure (18 people, 11%, 4.78★)

**Who they are:** people whose outside structure disappeared in 2020: COVID lockdown or quarantine (most), working or
studying from home, a breakup, a new baby, the end of classes.

**Why they use it:**
- *"요새 코로나 때문에 재택근무하느라 사이클이 완전 무너지면서 약간 우울감도 오고 무기력해졌는데"*, "working from home
  because of COVID, my daily cycle collapsed completely and I felt a bit depressed and listless" (`59002629`, ko, 5★).
- *"been neglecting myself during quarantine"* (`83aef7b8`, en, 5★).
- *"I'd been struggling to find my pre-pandemic routines, so I figured let's start new ones"* (`63809630`, en, 5★).
- *"코로나때문에 집에서만 공부하기 힘들었는데"*, "studying only at home because of COVID was hard" (`fe9c2668`, ko,
  5★).
- *"I spent two weeks pretty lost"* after a breakup; trouble sleeping, always late to work (`63706862`, en, 5★).
- *"All the mess and disorganization has been stressing me out"*, after having a baby (`cad16270`, en, 5★).

**Free features they like** (15 of 18): encouraging words (4), simple (3), more than one routine (3: morning, bedtime,
cleaning, study, cooking, exercise).

**Paying: the group that pays most often**, though the numbers are tiny: 2 paid, 1 trial, 3 free (3 of 18, 17%).
*"한번 써보고 너무 좋아서 바로 1년구독했습니다"*, "tried it once, loved it, and subscribed for a year straight away"
(`fe9c2668`).

### Group 7. Forget steps and small habits (14 people, 8%, 4.57★)

**Who they are:** people who forget parts of their routine, the order of it, or small habits like vitamins,
stretching or the cat's litter; one says their brain *"can't be trusted"* to remember.

**Why they use it:**
- *"매일매일 뭐 빠뜨린거없나 하며 살아가고 있는데"*, "I live every day wondering whether I've forgotten something"
  (`55499179`, ko, 4★).
- *"비타민 먹기나 스트레칭 같은건 까먹기 일쑤였는데"*, "I'd always forget things like taking vitamins or stretching"
  (`f01ba046`, ko, 5★).
- *"I would forget parts of my routines regularly"*, parent of three (`9d05ec76`, en, 3★).

**Free features they like** (12 of 14): the timer (4), the steps in order so *"I don't need to memorize"* (2),
reminders (2).

**Paying:** 1 paid (`65744612`, also in groups 1, 4, 5 and 6), 13 don't say.

### Group 8. Follow a method and want a tool for it (10 people, 6%, 4.90★)

**Who they are:** readers of *Atomic Habits*, BJ Fogg's *Tiny Habits*, *The Miracle Morning* or GTD; self-described
productivity nerds and planning geeks. They want a tool, not coaching.

**Why they use it:**
- *"I've been looking for an app that fits in with the learnings and methodology from the Tiny Habits and Atomic
  Habits"* and wants *"no complicated gamification or upsold content"* (`64302384`, en, 5★).
- *"when I read that the developers use B.J Fogg"* (`67665517`, en, 5★).
- *"Dont want no checkboxes. I want it to accompany me real time!"* (`129b6da3`, en, 5★).
- *"미라클모닝 챌린지 중인데"*, "I'm doing a Miracle Morning challenge" (`e7d8542f`, ko, 5★).

**Free features they like:** being walked through, and **chaining habits** into a routine (3), the look (3).

**Paying:** 1 paid (`64302384`: *"I was glad to pay to support the indie developer"*), 9 don't say.

### Group 9. Parents and carers (5 people, 3%, 4.60★)

**Who they are:** parents (a new baby, three children, "as a mom") and one adult with ADD who gets the whole family
ready each morning.

**Why they use it:**
- *"I use it to keep a rythm of looking after the house and the kids … remind me to self-care too"* (`ae2b7f3a`, en,
  5★).
- *"as a mom, it can be rough to make myself a priority"* (`351f5ed1`, en, 5★).
- *"the two hours it takes me to get myself and my family ready for each day"* (`64852389`, en, 5★).

**Free features they like:** pausing the timer *"when children need them"* (`9d05ec76`), reminders, the timer.

**Paying:** none say.

### People who name only a goal (45 people, 4.71★)

Not a pain-point group: they say what they want ("build habits", "a routine", "be productive") but not what's wrong.
They like **simple and clean (14)**, the look (10) and **the free version being enough (6)**; 2 paid, 5 say free.

---

## 3. Paying

### How many pay

| | Count | Share of 1,122 | Share of the 128 who say anything |
|---|---|---|---|
| Paid | 25 | 2.2% | 20% |
| On a trial | 7 | 0.6% | 5% |
| Charged unexpectedly | 2 | 0.2% | 2% |
| Refused to pay | 35 | 3.1% | 27% |
| Use it free and say so | 59 | 5.3% | 46% |
| Don't say | 994 | 89% | — |

**By group** (paid + trial out of the group): lost their structure 3 of 18; mornings 2 of 51; can't start 2 of 45;
tried everything 2 of 26; ADHD and similar 1 of 25; forget steps 1 of 14; follow a method 1 of 10; lose time 0 of 40;
carers 0 of 5. **These are too few to compare groups.** No group stands out as the payers; the one person in five
groups (`65744612`) counts in every one of them.

**By language, the difference is clear:** 14 of the 25 payers write in Korean. 6.4% of the 218 Korean reviews say they
paid, against 1.6% of the 700 English ones (11). Refusals go the other way: 27 of 35 are in English, 1 in Korean.

### Why the payers paid

None of the 25 says they paid for one feature. Their reasons:

| Reason | Payers | IDs |
|---|---|---|
| Liked the whole app, so subscribed (often straight away, often for a year) | 7 | `58211518`, `148d0f11`, `62779480`, `fe9c2668`, `b21a9aeb`, `457c72e5`, `02da79c3` |
| Worth the price: "so worth it", "100 won a day" | 2 | `65744612`, `66692955` |
| The free version was generous, so they paid | 2 | `b8ac89a9` (*"I fell in love with this app over a few months before deciding to commit to premium"*), `caee22d9` |
| To support an indie developer | 1 | `64302384` |
| Simplicity, ease and the timer | 1 | `5fab98e0` |
| Read the reviews | 1 | `945b911e` |
| Pay, but only while bugs get fixed, or regret it | 3 | `5e719aa3`, `7fc41c8f`, `61977148` |
| No reason given | 8 | `58630341`, `316cdfc7`, `3784df0b`, `c23e86b8`, `07fe6e15`, `63264291`, `67194470`, `f94df55b` |

So payers pay for **the whole experience working for them**, often after using it free.

### What premium holds (from what free users miss)

| What's behind the paywall | Reviews | Example |
|---|---|---|
| **More than two routines** | 53 (45 want more; 8 say two are enough, usually *"morning and night"*) | *"I'm mainly using it for morning and nighttime anyways"* (`3fec66f4`) |
| Statistics | 6 | *"I can't see my data and statistics without buying premium"* (`b195b6a5`) |
| Backup or device sync | 2 | *"I wish I could save my data even without premium"* (`ffcf998d`) |
| More icons | mentioned once as a paid option | (`2ba2fb5b`) |

### Why others won't pay

| Objection | Reviews |
|---|---|
| **A subscription rather than a one-time or lifetime price** | 33 |
| Too expensive | 22 |
| The 7-day trial is too short, or they're pushed to pay before they know if they like it (*"a habit needs at least 21 days"*) | 20 |
| Can't afford it (a 13-year-old whose parents won't allow it; *"can't afford the membership"*) | 3 |
| Charged after cancelling | 2 (`62897267`, `63090881`) |

The people who name a price would pay $25–30 once rather than $20–22 a year.

---

## 4. Free features people like

Across all 1,122 reviews, 552 name something they like. Sorted into kinds (one review can name several):

| Feature | Reviews | Which groups name it most |
|---|---|---|
| Simple, clean, easy, nothing extra | 141 | Goal-only (14), mornings (8), can't start (8), lose time (7) |
| The look: design, cute icons | 132 | Can't start (9), mornings (8), tried everything (5) |
| **A timer on every step** (countdown, alert when time is up) | 56 | **Lose time (11), mornings (10), tried everything (8), ADHD and similar (6)** |
| Encouraging words, "Well done", motivation | 30 | Can't start (8), lost their structure (4) |
| **Walked through one step at a time; no deciding what's next** | 26 | Mornings (7), can't start (7), tried everything (5), ADHD and similar (4) |
| Reminders and alerts | 26 | Lose time (5), mornings (3) |
| The free version is enough | 23 | Goal-only (6) |
| A responsive developer | 20 | — |
| Seeing when the routine will finish | — | **ADHD and similar (4)**, lose time (3) |
| Pause, skip or add time to a step | — | ADHD and similar (3) |

**What it means per group:** the pain decides the feature. People who lose time or have bad mornings value the
**timer**; people who can't start value **not having to decide** and the **encouragement**; people with ADHD and
similar value **knowing when it will end** and being able to **pause or add time** without losing the routine.

---

## 5. Who they say they are

From `who` (153 people say something). Identity overlaps with the groups but isn't the same thing.

| They say they are | People |
|---|---|
| Working (office, commute, from home, own hours) | 17 |
| ADHD or ADD | 15 |
| Procrastinator, lazy, no willpower | 13 |
| Student | 10 |
| Apple Watch user (and want an app for it) | 10 |
| Tried many other apps | 10 |
| In COVID lockdown or quarantine | 9 |
| Readers of habit books | 8 |
| Depression, anxiety, mental-health difficulty | 6 |
| Parent | 5 |
| iPad or tablet user | 5 |
| Autism, executive dysfunction, brain fog | 4 |
| Teenager or young adult | 3 |

---

## 6. Limits

- **85% don't name a pain point,** so the groups describe the 166 who do. The order of the groups is more reliable
  than their exact sizes.
- **Paying is said by 11%.** Group-by-group paying rates rest on 0–3 people each and can't be compared.
- **Features are sorted by their words**, so a few may sit in the wrong kind; the group-level patterns held when I
  read the lists by hand.
- **The labels are short summaries.** A few people who mention a condition only in passing (for example *"a great
  app for people with ADHD"* without saying they have it) are not counted in group 5.

---

## Appendix: every group member

`Line` is the review's line in `Review Labels/Routinery/2020/labels.jsonl`, so every number above resolves to an exact
review; `ID` is the first 8 characters of its review ID.

| Line | ID | Store | ★ | Language | Groups | Paid |
|---|---|---|---|---|---|---|
| 2 | `54155614` | App Store | 5 | ko | 1 Mornings | not said |
| 4 | `54250498` | App Store | 4 | ko | 1 Mornings; 7 Forget steps | not said |
| 5 | `54257449` | App Store | 4 | ko | Goal only | not said |
| 8 | `54278362` | App Store | 5 | ko | 1 Mornings; 3 Lose time | not said |
| 10 | `54325467` | App Store | 5 | ko | 1 Mornings | not said |
| 11 | `54326499` | App Store | 5 | ko | 2 Can't start | not said |
| 17 | `54809090` | App Store | 5 | ko | 1 Mornings; 7 Forget steps | not said |
| 20 | `4e2e7cb4` | Play | 3 | en | 1 Mornings; 3 Lose time | not said |
| 27 | `55499179` | App Store | 4 | ko | 7 Forget steps | not said |
| 29 | `55584159` | App Store | 5 | ko | 3 Lose time | not said |
| 46 | `56664932` | App Store | 5 | ko | 3 Lose time; 2 Can't start | not said |
| 48 | `3dcc6554` | Play | 4 | ko | Goal only | not said |
| 50 | `57001903` | App Store | 5 | ko | Goal only | not said |
| 52 | `57037296` | App Store | 5 | ko | 4 Tried everything; 2 Can't start | not said |
| 54 | `38a3c601` | Play | 3 | en | 1 Mornings; 4 Tried everything | not said |
| 56 | `57157990` | App Store | 4 | ko | 7 Forget steps | not said |
| 60 | `4cff5333` | Play | 5 | en | Goal only | not said |
| 62 | `8926f37f` | Play | 5 | en | 4 Tried everything | not said |
| 64 | `fdc5e23e` | Play | 5 | en | Goal only | not said |
| 71 | `26a58a72` | Play | 4 | es | 1 Mornings | not said |
| 74 | `501a073c` | Play | 5 | en | 4 Tried everything | not said |
| 75 | `57779979` | App Store | 5 | ko | 2 Can't start | not said |
| 82 | `57907304` | App Store | 5 | ko | 2 Can't start | not said |
| 84 | `58017457` | App Store | 4 | en | 3 Lose time | not said |
| 85 | `99617b3b` | Play | 4 | it | 1 Mornings | not said |
| 97 | `4bf84d8b` | Play | 5 | en | Goal only | not said |
| 98 | `f0f06aca` | Play | 5 | en | 1 Mornings | not said |
| 106 | `0ca8100e` | Play | 5 | en | Goal only | not said |
| 117 | `fa101889` | Play | 5 | en | 6 Lost structure | not said |
| 119 | `1e7d2dd4` | Play | 5 | en | Goal only | not said |
| 125 | `58880910` | App Store | 5 | en | 2 Can't start; 4 Tried everything | not said |
| 135 | `59002629` | App Store | 5 | ko | 6 Lost structure; 5 ADHD and similar | not said |
| 137 | `9ebb4559` | Play | 5 | en | 5 ADHD and similar; 3 Lose time | not said |
| 139 | `129b6da3` | Play | 5 | en | 8 Method | not said |
| 143 | `b23a2ace` | Play | 5 | en | 1 Mornings | not said |
| 144 | `617a2be4` | Play | 4 | en | 6 Lost structure | not said |
| 149 | `665b0595` | Play | 4 | en | 2 Can't start | not said |
| 153 | `e15904c7` | Play | 5 | en | 4 Tried everything | not said |
| 174 | `cdf2b554` | Play | 5 | es | Goal only | not said |
| 177 | `ae2b7f3a` | Play | 5 | en | 9 Carers | not said |
| 187 | `bf73e8a7` | Play | 5 | en | 2 Can't start | not said |
| 205 | `a0d0f060` | Play | 4 | en | 1 Mornings | not said |
| 208 | `3c1a0adf` | Play | 5 | en | 5 ADHD and similar; 7 Forget steps | not said |
| 211 | `2fa8288d` | Play | 5 | en | 5 ADHD and similar | not said |
| 218 | `bcddc28d` | Play | 5 | en | 1 Mornings | not said |
| 221 | `59727598` | App Store | 5 | ko | Goal only | not said |
| 223 | `885256bb` | Play | 5 | en | 3 Lose time | not said |
| 224 | `767089c2` | Play | 5 | en | 3 Lose time | not said |
| 229 | `91f1e0e2` | Play | 5 | en | 3 Lose time | not said |
| 232 | `cad16270` | Play | 5 | en | 9 Carers; 6 Lost structure | not said |
| 233 | `8a806edc` | Play | 5 | en | 3 Lose time | free |
| 260 | `b9b6f0cd` | Play | 5 | fr | 2 Can't start | not said |
| 262 | `9fc1e195` | Play | 5 | en | 5 ADHD and similar; 3 Lose time; 1 Mornings | free |
| 266 | `b8cf5a16` | Play | 4 | en | Goal only | not said |
| 284 | `324cc1f2` | Play | 4 | en | 2 Can't start | not said |
| 291 | `267725e8` | Play | 5 | en | 4 Tried everything | not said |
| 293 | `9f56a58e` | Play | 5 | en | 5 ADHD and similar; 2 Can't start | not said |
| 294 | `51a0459d` | Play | 2 | en | Goal only | free |
| 305 | `0f9b544c` | Play | 3 | en | Goal only | not said |
| 311 | `c733507a` | Play | 4 | en | Goal only | not said |
| 315 | `f38d9898` | Play | 5 | es | 3 Lose time | not said |
| 322 | `dd869653` | Play | 5 | ru | 1 Mornings; 3 Lose time | not said |
| 323 | `8fcbd9ff` | Play | 3 | pt | 6 Lost structure; 3 Lose time | not said |
| 329 | `e413ae60` | Play | 5 | en | 5 ADHD and similar | not said |
| 334 | `03b6b4c3` | Play | 5 | en | 5 ADHD and similar; 2 Can't start; 1 Mornings | not said |
| 338 | `83aef7b8` | Play | 5 | en | 6 Lost structure; 2 Can't start | not said |
| 341 | `adf96ba3` | Play | 5 | en | 4 Tried everything | not said |
| 360 | `1c909b18` | Play | 5 | en | 3 Lose time; 1 Mornings | free |
| 370 | `3d73f841` | Play | 4 | en | 2 Can't start; 4 Tried everything | not said |
| 376 | `f786fed3` | Play | 5 | es | 2 Can't start | not said |
| 379 | `5a85d26b` | Play | 5 | en | 1 Mornings; 3 Lose time | not said |
| 383 | `8d57e02a` | Play | 5 | en | 6 Lost structure | not said |
| 384 | `dfb650c8` | Play | 5 | pt | Goal only | not said |
| 386 | `2ba2fb5b` | Play | 5 | ko | Goal only | not said |
| 391 | `b2f8ebee` | Play | 5 | id | Goal only | not said |
| 394 | `90e89c31` | Play | 5 | ko | Goal only | not said |
| 396 | `c44beb64` | Play | 5 | pt | 3 Lose time | not said |
| 398 | `ef72959b` | Play | 4 | en | 4 Tried everything | trial |
| 399 | `1ac11d9c` | Play | 5 | en | 5 ADHD and similar; 1 Mornings | not said |
| 400 | `28c8b64f` | Play | 5 | ko | 2 Can't start | not said |
| 401 | `ba5e72ed` | Play | 4 | fr | 1 Mornings | not said |
| 427 | `d978341d` | Play | 5 | en | 5 ADHD and similar; 3 Lose time; 6 Lost structure | not said |
| 430 | `0601ca29` | Play | 5 | es | 3 Lose time | not said |
| 436 | `1e7aa119` | Play | 5 | en | 5 ADHD and similar; 3 Lose time | not said |
| 438 | `12d9dd9a` | Play | 5 | en | Goal only | not said |
| 439 | `1f3c7121` | Play | 5 | en | Goal only | not said |
| 442 | `61156707` | App Store | 5 | ko | 3 Lose time | not said |
| 444 | `fd8eba98` | Play | 5 | pt | Goal only | free |
| 451 | `da83b207` | Play | 5 | es | Goal only | free |
| 457 | `00b6a2f5` | Play | 5 | ko | 3 Lose time | not said |
| 460 | `45b6b2b6` | Play | 5 | pt | 3 Lose time | free |
| 461 | `b465d569` | Play | 5 | en | 5 ADHD and similar | not said |
| 470 | `3b500845` | Play | 5 | en | 5 ADHD and similar; 1 Mornings | not said |
| 481 | `482a9ce0` | Play | 4 | en | 1 Mornings | not said |
| 484 | `07d9bd50` | Play | 5 | en | 5 ADHD and similar; 3 Lose time; 7 Forget steps | not said |
| 487 | `d73f9f5f` | Play | 5 | en | Goal only | free |
| 489 | `2b888c59` | Play | 4 | en | Goal only | not said |
| 493 | `cf66ddcb` | Play | 5 | en | 6 Lost structure; 5 ADHD and similar | not said |
| 500 | `b82daf99` | Play | 5 | en | 5 ADHD and similar; 3 Lose time; 1 Mornings | not said |
| 507 | `03401fb6` | Play | 5 | en | 2 Can't start | not said |
| 509 | `9d05ec76` | Play | 3 | en | 9 Carers; 7 Forget steps | not said |
| 510 | `00289063` | Play | 5 | en | 2 Can't start | not said |
| 514 | `61906432` | App Store | 5 | ko | 2 Can't start | not said |
| 523 | `8542b09e` | Play | 5 | en | Goal only | not said |
| 524 | `07fe6e15` | Play | 4 | en | Goal only | paid |
| 525 | `62111821` | App Store | 5 | en | Goal only | not said |
| 527 | `ce566082` | Play | 5 | en | 1 Mornings | not said |
| 535 | `e7222679` | Play | 5 | en | 1 Mornings | not said |
| 537 | `5f90773b` | Play | 4 | en | Goal only | not said |
| 542 | `b79d6650` | Play | 5 | en | 4 Tried everything | not said |
| 551 | `62570460` | App Store | 5 | ko | 2 Can't start | not said |
| 552 | `62587411` | App Store | 5 | en | 3 Lose time | not said |
| 569 | `077c88f3` | Play | 5 | ko | 2 Can't start | not said |
| 572 | `e96ffa22` | Play | 5 | en | 3 Lose time | not said |
| 574 | `f219b09b` | Play | 5 | en | Goal only | not said |
| 581 | `62973133` | App Store | 5 | en | Goal only | not said |
| 584 | `1ae62139` | Play | 5 | ko | 2 Can't start | not said |
| 589 | `351f5ed1` | Play | 5 | en | 9 Carers | not said |
| 594 | `d2f22a01` | Play | 4 | en | 6 Lost structure; 1 Mornings | not said |
| 606 | `3570c16c` | Play | 4 | en | 1 Mornings | not said |
| 620 | `53180359` | Play | 5 | en | 5 ADHD and similar | not said |
| 621 | `5363ae3e` | Play | 5 | ar | 1 Mornings | not said |
| 623 | `ac038f92` | Play | 5 | en | 4 Tried everything; 2 Can't start | free |
| 628 | `1cfea650` | Play | 5 | en | 1 Mornings | not said |
| 631 | `393a854d` | Play | 5 | en | 1 Mornings | not said |
| 633 | `63706862` | App Store | 5 | en | 6 Lost structure; 1 Mornings | trial |
| 639 | `63778778` | App Store | 5 | ko | Goal only | not said |
| 645 | `63809630` | App Store | 5 | en | 6 Lost structure; 3 Lose time | not said |
| 654 | `1390b6a8` | Play | 5 | en | Goal only | not said |
| 658 | `77eb006d` | Play | 5 | es | Goal only | not said |
| 660 | `eaa315d6` | Play | 5 | en | Goal only | not said |
| 668 | `039c8e46` | Play | 5 | ko | 2 Can't start | not said |
| 669 | `ad4337b1` | Play | 5 | es | 5 ADHD and similar | free |
| 670 | `2adf8922` | Play | 5 | en | Goal only | not said |
| 672 | `628edd7a` | Play | 5 | ko | 3 Lose time; 1 Mornings | not said |
| 675 | `db49a94b` | Play | 5 | ru | 1 Mornings; 2 Can't start | not said |
| 676 | `cc9e1b9f` | Play | 5 | en | 1 Mornings | free |
| 682 | `67e087a1` | Play | 5 | en | 1 Mornings; 3 Lose time | not said |
| 687 | `243a7081` | Play | 4 | en | 1 Mornings; 3 Lose time | not said |
| 689 | `64231368` | App Store | 5 | en | 6 Lost structure; 2 Can't start | free |
| 699 | `4897bd92` | Play | 5 | ko | 2 Can't start | not said |
| 701 | `e7d8542f` | Play | 5 | ko | 8 Method; 1 Mornings | not said |
| 703 | `64302384` | App Store | 5 | en | 8 Method | paid |
| 705 | `c292afc4` | Play | 4 | en | 1 Mornings; 7 Forget steps | not said |
| 714 | `64346506` | App Store | 5 | en | 2 Can't start | not said |
| 716 | `44b4da76` | Play | 5 | en | Goal only | not said |
| 719 | `f9466555` | Play | 5 | en | 3 Lose time; 7 Forget steps | not said |
| 722 | `eab6e73d` | Play | 5 | ru | 3 Lose time | not said |
| 725 | `64401926` | App Store | 5 | en | 2 Can't start | not said |
| 726 | `cee7a3a0` | Play | 5 | ar | Goal only | not said |
| 729 | `fe9c2668` | Play | 5 | ko | 6 Lost structure | paid |
| 736 | `5f3eeb4f` | Play | 4 | en | Goal only | free |
| 739 | `3143d980` | Play | 5 | en | 4 Tried everything | not said |
| 743 | `f01ba046` | Play | 5 | ko | 7 Forget steps | not said |
| 751 | `64617988` | App Store | 5 | en | 4 Tried everything | refused |
| 769 | `11180e95` | Play | 5 | pt | Goal only | not said |
| 782 | `64852389` | App Store | 5 | en | 5 ADHD and similar; 9 Carers; 3 Lose time; 1 Mornings | not said |
| 784 | `49c9e97c` | Play | 5 | en | Goal only | not said |
| 805 | `866a49b1` | Play | 5 | ko | Goal only | not said |
| 807 | `aec02a15` | Play | 5 | pt | 7 Forget steps | not said |
| 812 | `fda805eb` | Play | 4 | en | 1 Mornings | not said |
| 818 | `388c8d56` | Play | 5 | ko | 1 Mornings | not said |
| 819 | `2f2c7272` | Play | 5 | ko | 2 Can't start | not said |
| 826 | `97ac07c1` | Play | 5 | en | 1 Mornings | free |
| 831 | `65325756` | App Store | 3 | en | 4 Tried everything | not said |
| 833 | `acaa58b4` | Play | 5 | en | 2 Can't start; 1 Mornings | not said |
| 843 | `ba1e66aa` | Play | 5 | en | 3 Lose time; 6 Lost structure | free |
| 854 | `9d7aa4db` | Play | 5 | en | 1 Mornings | not said |
| 865 | `caee22d9` | Play | 5 | en | 2 Can't start | paid |
| 867 | `65744612` | App Store | 5 | en | 5 ADHD and similar; 7 Forget steps; 6 Lost structure; 4 Tried everything; 1 Mornings | paid |
| 868 | `c3aeaa55` | Play | 5 | en | 1 Mornings; 2 Can't start | not said |
| 869 | `65760343` | App Store | 5 | ko | 3 Lose time | not said |
| 894 | `55879e8c` | Play | 5 | ko | 1 Mornings; 3 Lose time | not said |
| 895 | `65975620` | App Store | 5 | ko | 4 Tried everything | not said |
| 906 | `a2f06d4a` | Play | 5 | en | 2 Can't start | not said |
| 914 | `2388ba1a` | Play | 5 | ko | 7 Forget steps | not said |
| 920 | `13dbb806` | Play | 5 | en | 1 Mornings; 2 Can't start | not said |
| 923 | `66311642` | App Store | 5 | en | 2 Can't start | not said |
| 927 | `f457572b` | Play | 5 | en | 8 Method | not said |
| 947 | `5f6650e0` | Play | 5 | en | 2 Can't start | not said |
| 953 | `412053cf` | Play | 5 | en | 1 Mornings | not said |
| 962 | `66633853` | App Store | 5 | en | 5 ADHD and similar; 3 Lose time | not said |
| 967 | `be853b23` | Play | 2 | en | 2 Can't start | not said |
| 969 | `66676070` | App Store | 5 | ko | 2 Can't start | not said |
| 973 | `66692955` | App Store | 5 | ko | 2 Can't start | paid |
| 975 | `66765211` | App Store | 5 | ko | 8 Method | not said |
| 992 | `273e3c74` | Play | 5 | en | 4 Tried everything | not said |
| 1004 | `45227277` | Play | 5 | en | 6 Lost structure; 1 Mornings | not said |
| 1010 | `51e01f4c` | Play | 5 | en | 4 Tried everything; 8 Method | not said |
| 1016 | `6a67c16e` | Play | 5 | en | 2 Can't start; 4 Tried everything | not said |
| 1019 | `67194470` | App Store | 5 | ko | Goal only | paid |
| 1023 | `1371536d` | Play | 5 | pt | Goal only | not said |
| 1024 | `67279449` | App Store | 3 | en | 5 ADHD and similar; 2 Can't start | not said |
| 1025 | `d3bb4e8b` | Play | 5 | en | 6 Lost structure; 2 Can't start | free |
| 1035 | `67356632` | App Store | 5 | ko | Goal only | not said |
| 1043 | `5ff0c95b` | Play | 5 | ko | 8 Method | not said |
| 1046 | `66cd68ba` | Play | 5 | es | 3 Lose time; 4 Tried everything | not said |
| 1047 | `f2f38e46` | Play | 5 | en | 8 Method | not said |
| 1067 | `dbf0f455` | Play | 5 | ko | 2 Can't start | not said |
| 1072 | `67648883` | App Store | 5 | ko | Goal only | not said |
| 1073 | `65cd2f64` | Play | 5 | ko | 2 Can't start | not said |
| 1074 | `67665517` | App Store | 5 | en | 8 Method; 4 Tried everything | not said |
| 1075 | `1301afa7` | Play | 5 | es | 4 Tried everything | not said |
| 1079 | `bae761eb` | Play | 5 | en | 5 ADHD and similar; 3 Lose time; 4 Tried everything | not said |
| 1085 | `4a0292a7` | Play | 5 | ko | 1 Mornings | not said |
| 1087 | `92a50edc` | Play | 5 | en | 5 ADHD and similar | not said |
| 1088 | `67871360` | App Store | 5 | en | 5 ADHD and similar | not said |
| 1089 | `264601ff` | Play | 5 | en | 7 Forget steps | not said |
| 1100 | `67999611` | App Store | 4 | de | 8 Method | not said |
| 1105 | `68052256` | App Store | 5 | ko | 4 Tried everything | not said |
| 1106 | `ca13c65e` | Play | 5 | ko | 4 Tried everything | not said |

211 people: 166 in at least one pain-point group, 45 with a goal only. Checked: every ID in this report is in `Review Labels/Routinery/2020/reviews.jsonl`.
