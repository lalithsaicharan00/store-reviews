# Routinery 2023: User Groups, Why They Use It, and What They Pay For

Written by Claude (Claude Code), 26 November 2026, at the user's request.

**What this is.** Routinery's target users as its 2023 reviews show them, the way UX user research describes them:
the groups of people who use it, each defined by the **pain point** that brought them; why each group uses it; whether
each group pays, how many, and for what; and which free features each group likes. The fifth year of a series
([2019](<Routinery 2019 — User Groups, Why They Use It, and What They Pay For.md>),
[2020](<Routinery 2020 — User Groups, Why They Use It, and What They Pay For.md>),
[2021](<Routinery 2021 — User Groups, Why They Use It, and What They Pay For.md>),
[2022](<Routinery 2022 — User Groups, Why They Use It, and What They Pay For.md>)).

**How it was done.** From the reviews alone, as research for a new product or a full rebuild. No product of ours, its
features or its code was used to choose, read or group anything.

**Source.** The checked labels for all 1,763 reviews of 2023 in `Review Labels/Routinery/2023/labels.jsonl`, the same
way as 2020–2022:

- **Groups:** from `who` and `why_chose`. I read all 378 reviews that have either and put each person in the group(s)
  their own words describe. One person can be in more than one group. No new group was needed this year.
- **Features liked:** from `liked` and `chose_for`, sorted into the same kinds as the earlier years.
- **Paying:** from `paid` and its reason, plus the price and premium complaints in `problems`. Every payer, every
  refusal and every routine-limit mention was sorted by hand.

Review IDs are shortened to their first 8 characters; the appendix maps every group member to its line in the labels
file. The map is saved as [`Tools/groups_2023.py`](<Tools/groups_2023.py>); [README.md](<README.md>) explains the method.

---

## The short answer

- **1,763 reviews** (1,263 Google Play, 500 App Store), average **3.96★, the lowest of the five years**, with 202 1★
  (11%). **177 people (10%) name a pain point**; 76 more name only a goal.
- **The same pains, a younger and broader crowd.** People with ADHD and similar conditions are still the biggest
  group, but fewer (53, 30%, down from 92 and 45%). **Mornings come back** (19%, from 10%), much of it **school
  mornings**, and a July wave of 380 reviews (22% of the year, 72% English) brought many short "glow up", "build good
  habits" reviews from teenagers and children.

| # | User group (the pain point) | People | Share of the 177 | ★ | Paid or trial | 2022 share |
|---|---|---|---|---|---|---|
| 1 | **Have ADHD, autism, executive dysfunction, depression or anxiety** | 53 | **30%** | 4.36 | 3 | 45% |
| 2 | **Can't start or keep going:** procrastinate, lethargy, never stuck to a routine | 49 | 28% | 4.69 | 0 | 28% |
| 3 | **Lose time:** distracted (by games, TikTok, social media), time blindness, messy days | 41 | 23% | 4.51 | 1 | 20% |
| 4 | **Mornings go badly:** late for school or work, miss the bus, can't get out of bed | 34 | 19% | 4.88 | 1 | 10% |
| 5 | **Forget steps and small habits** (medication, the next step, "by memory") | 17 | 10% | 4.18 | 2 | 6% |
| 6 | **Tried other apps; nothing stuck** (Fabulous, Habitica, Tiimo, checklists, alarms, ~50 apps) | 16 | 9% | 4.81 | 2 | 10% |
| 7 | **Parents and carers, usually running a child's routine** | 12 | 7% | 4.25 | 3 | 6% |
| 8 | **Overwhelmed:** too much to keep up with (chores and school, business and family) | 11 | 6% | 4.82 | 0 | 4% |
| 9 | **Lost their structure:** a new school year, working from home | 5 | 3% | 4.60 | 0 | 2% |
| 10 | **Follow a method** (The Miracle Morning) | 2 | 1% | 5.00 | 0 | 0.5% |

  (49 people are in more than one group.)

- **Why they use it:** unchanged. The app **walks them through a routine one step at a time with a timer**, so they
  don't have to remember, decide or find willpower: *"Helps me save my executive function reserves for other
  important daily tasks"*, *"if I don’t have a timing I just take WAYYY to long doing 1 thing"*.
- **2023 is the year the app broke for payers.** 71 people (4.0%) say they paid, slightly fewer than in 2022 (4.9%),
  and **their average rating fell from 3.91★ to 2.97★**. **54 of the 71 report something broken**; 27 mention paying
  only to say a paid app crashes, freezes or forgot their subscription, and 11 regret it, cancelled or want a refund.
  12 payers say the app treated them as free or showed them ads. A quarter of all reviews (25%) report a bug, up from
  20% in 2022 and 11% in 2020.
- **Payers who give a reason still mostly pay for the whole app** (17); **7 name a feature, 4 of them more routines.**
  3 bought in a New Year "1+1" offer. **20 say they were charged unexpectedly** (6 in 2022), 12 of them in Korean,
  mostly trials that turned into a yearly charge.
- **The paywall is still the third routine.** About 108 reviews mention the two-routine free limit: about 85 want
  more (usually 3–5), 15 say two are enough, 3 paid for more, and **5 say the free plan dropped to one routine** (March
  and August). **Ads appear for the first time** (12 complaints from April, 2 of them from payers).
- **Korean reviewers pay most again:** 13.7% of Korean reviews say they paid, against 3.5% of English ones; Japanese
  reviews 11.7%.
- **Free features liked:** simple and clean (137), the look and icons (109), encouraging words and the voice (84), **a
  timer on every step (71)**, reminders (31). The timer matters most to people who lose time and whose mornings go
  badly; people who can't start name **encouraging words** first.

---

## 1. The year in numbers

| | Count | Share of 1,763 |
|---|---|---|
| Reviews | 1,763 | 100% |
| Google Play / App Store | 1,263 / 500 | 72% / 28% |
| Language: English, Korean, Spanish, Polish, French, Japanese, Portuguese, other | 961, 183, 177, 83, 75, 60, 55, 169 | 55%, 10%, 10%, 5%, 4%, 3%, 3%, 10% |
| Ratings 5★ / 4★ / 3★ / 2★ / 1★ | 927 / 351 / 174 / 109 / 202 | 53% / 20% / 10% / 6% / 11% |
| Say who they are (`who`) | 277 | 16% |
| Say why they came (`why_chose`) | 178 | 10% |
| Name a pain point (any group below) | **177** | **10%** |
| Name only a goal | 76 | 4% |
| Name a feature they like | 909 | 52% |
| Say anything about paying | 182 | 10% |
| Report something broken | 438 | 25% |
| Nothing useful ("great app") | 265 | 15% |

**July.** 380 reviews (22% of the year) came in July, 45 of them on 9 July alone: 272 in English, 246 of them 5★, 97
with nothing useful in them. They hold 30 of the 76 goal-only reviews. Seven reviews say "glow up", all in July; three
in the whole year mention TikTok. The reviews don't say what brought this wave, so its cause is unknown.

---

## 2. The user groups

### Group 1. Have ADHD, autism, executive dysfunction, depression or anxiety (53 people, 30%, 4.36★)

**Who they are:** ADHD or ADD (38), autism, CPTSD or executive dysfunction (10), depression or anxiety (6),
"neurodivergent" without saying more (4). Adults diagnosed late (*"late-diagnosed adult ADHD and ASD"*), the
recently diagnosed, the untreated, a teenage girl, students, a parent raising children on two jobs. Some arrive by
word of mouth: *"this app came highly recommended to me to help with my ADHD"* (`36e5e2aa`), *"highly recommended through several
users via blogs, Reddit posts, and general forums"* (`10337926`). 31 are only in this group. Fewer than in 2022 (92), and the **lowest-rated of the
large groups**: 1★ and 2★ reviews from this group are about bugs, not the idea (*"Was a great app for my adhd"*,
`98031992`, 1★).

**Why they use it:**
- *"I have ADHD, and one of my challenges is getting distracted easily"* (`1ff717ff`, en, 5★).
- *"Helps me save my executive function reserves for other important daily tasks"* (`5a53035e`, en, 4★).
- *"The only app that works for my ADHD"* (`96989375`, en, 5★).
- *"my ADHD-related challenges (having a poor working memory, time blindness, etc.)"* (`3adf1697`, en, 1★).
- *"Ajuda muito pra mim que tenho TDAH"*, "it helps me a lot, as someone with ADHD" (`32650ade`, pt, 4★).
- *"게으른 무기력에 빠진 우울증 환자"*, "a depression patient sunk in lazy lethargy" (`ebdc639a`, ko, 5★).
- *"when I’m alone I have trouble meeting my daily needs and responsibilities"*, autistic, while the spouse is away
  (`10219620`, en, 5★, a payer).
- *"I feel like I can finally get out of bed and not have my mental health issues affect me"*, with CPTSD
  (`a5425d05`, en, 5★).
- *"Sóc autista"*, "I'm autistic" (`f3dc3f59`, ca, 5★).

**Free features they like** (46 of 53): the timer on every step (8), the look and icons (7), encouraging words (6),
**reminders and alerts (6: the most of any group again)**, simple and clean (5), being walked through one step at a
time (2).

**Paying:** 3 paid, 4 free, 2 refused, 44 don't say. One paid to get past the routine limit, *"for me it was worth
it!"*, because *"this app helps get me like no other “ADHD hacks” have before"* (`97734557`); *"100% worth the money"* (`10219620`); one had to stop using it mid-subscription
when editing a routine on the go was removed (`10666322`). The refusals: the monthly price in dollars is too high
(`32650ade`), and bugs make it useless (`10077195`).

### Group 2. Can't start or keep going (49 people, 28%, 4.69★)

**Who they are:** procrastinators, people with chronic lethargy, people who never stuck to a routine, a 57-year-old
learning one for the first time. 30 are only in this group.

**Why they use it:**
- *"I've never stuck to a routine"* (`45169d4b`, en, 5★).
- *"if you're a student struggling with procrastination like me"* (`cb0b7057`, en, 5★).
- *"무기력증이 만성적으로 있어서 뭘 시작하기가 힘든데"*, "I have chronic lethargy, so it's hard to start anything"
  (`94863111`, ko, 5★).
- *"the hardest part is actually starting the routine in the morning"* (`24c3152e`, en, 5★).
- *"お風呂に入るのがとても億劫だった"*, "taking a bath was a real chore" (`af7ff931`, ja, 4★).
- *"j'ai souvent la flemme"*, "I often can't be bothered" (`e161ee7e`, fr, 5★).
- *"Often I only finish half of the tasks I set out to do that day"* (`10169742`, en, 5★).
- *"my brain doesn’t seem to want to reward me naturally with dopamine"* (`96490170`, en, 5★).

**Free features they like** (46 of 49): **encouraging words and the voice (11: the most of any group)**, the timer
(6), simple (5), **no ads (4)**, **the free version is enough (4)**, the look (3), seeing how long things take (3).

**Paying:** none say they paid; 7 use it free and say so, 1 refused (bugs, `10077195`). The group most content with
the free plan.

### Group 3. Lose time (41 people, 23%, 4.51★)

**Who they are:** people who get distracted (by games, TikTok, social media, their phone), who have time blindness,
who take too long on one thing, whose days or homes are *"a mess"*. Several are children.

**Why they use it:**
- *"antes de tener la app, tardaba horas en salir de casa, porque hacía todo en desorden y me distraía"*, "before the
  app it took me hours to leave the house, because I did everything out of order and got distracted" (`99147063`,
  es, 5★).
- *"if I don’t have a timing I just take WAYYY to long doing 1 thing"* (`10112660`, en, 5★).
- *"non mi perdo nei social media come faccio solitamente"*, "I don't get lost in social media the way I usually do"
  (`c7d95ee3`, it, 5★).
- *"I was always playing games on my phone always watching tiktok"*, an 11-year-old (`94be158c`, en, 5★).
- *"時間管理が苦手なので"*, "because I'm bad at time management" (`2582006a`, ja, 4★).
- *"starting on schedule despite time-blindness"* (`38282c51`, en, 5★).
- *"The reason I got a smart watch is so I can have less distractions from opening my phone"*, then the
  watch app didn't work (`5edb37b1`, en, 2★).

**Free features they like** (36 of 41): **the timer on every step (11: the most of any group)**, simple (5), reminders
(4), the look (4), encouraging words (3), pause, skip or add time (2).

**Paying:** 1 paid (`10219620`, *"100% worth the money"*), 1 free, 1 refused.

### Group 4. Mornings go badly (34 people, 19%, 4.88★)

Up again (31% in 2020, 19% in 2021, 10% in 2022). **8 of the 34 are school mornings.**
- *"I used to miss the bus, be late for school, not make a lunch"* (`96187623`, en, 5★).
- *"I wake up everyday at 6 disoriented and sleepy"* (`96891799`, en, 5★).
- *"출근시간 딱 맞춰서 도착하고 차 막히면 찔끔찔끔 늦는"*, "I arrive exactly on time for work, and I'm a little late
  whenever there's traffic" (`97358807`, ko, 5★, on a trial).
- *"Ik vond het altijd moeilijk om s'ochtends uit bed te komen"*, "I always found it hard to get out of bed in the
  morning" (`a7a04f9a`, nl, 5★).
- *"dont have to stress every school morning"* (`86fa8f00`, en, 4★).
- *"As a young girl with a lot of hectic mornings"* (`10635817`, en, 5★).
- *"아침 정신없는 와중에 루틴 챙기고 싶을때 최고"*, "the best when you want to keep your routine in the chaos of the
  morning" (`10609434`, ko, 5★).
- *"Kto nie jest rannym ptaszkiem i pracuje w domu w elastycznych godzinach"*, "for anyone who isn't an early bird and
  works from home on flexible hours" (`a5b4b189`, pl, 5★).

**Free features they like** (32 of 34): **the timer (9)**, encouraging words (5), seeing how long things take (3),
simple (3), reminders (3), the look (3). The highest-rated group. **Paying:** 1 on a trial who plans to subscribe after
it (`97358807`), 2 free.

### Group 5. Forget steps and small habits (17 people, 10%, 4.18★)

- *"je suis très étourdie"*, "I'm very scatterbrained" (`3bf76a71`, fr, 4★).
- *"I often forget to take medication"*, disabled and on a low income (`c14ac293`, en, 2★).
- *"trying to keep a steady morning routine by memory"* didn't work (`10448542`, en, 5★, a payer).
- *"I'm someone who struggles with mentally queueing tasks"* (`3f45a171`, en, 5★, a payer).
- *"trataba de no olvidar la actividad que seguía"*, "I tried not to forget the next activity" (`9ab5c327`, es, 4★).
- *"sie ist toll um wichtige Dinge nicht zu vergessen"*, "it's great for not forgetting important things"
  (`bed07888`, de, 3★).

**Free features they like** (14 of 17): the timer (4), simple (2). **Paying:** 2 paid: *"Best paid app"*, because it
*"only shows the current task"* and the timer (`3f45a171`); *"once i got the subscription it was SO AMAZING"*
(`10448542`). 1 refused: can't afford it, and it's a subscription, not a lifetime purchase (`c14ac293`).

### Group 6. Tried other apps; nothing stuck (16 people, 9%, 4.81★)

The apps and methods they left: Fabulous (*"Fabulous downgraded and only let you choose up to 3 habits in a routine"*,
`2c888bb2`), Habitica (*"Apps like Habitica aren't enough for me"*, `0aaaa664`), Tiimo (*"so glitchy it was
unusable"*, `94850989`), checklist trackers (*"This works much better for me compared with checklist
habitat-tracker-type apps"*, `07c9f894`), alarms (*"Tener muchas alarmas era un problema"*, "having lots of alarms
was a problem", `9ab5c327`) and a notepad (`96972106`).
- *"이것만큼 심플하고 실용적인 어플은 없습니다"*, "there's no app as simple and practical as this one", after about 50
  (`242c6165`, ko, 5★).
- *"다른 루틴 앱 써보려다가 번거로워서 포기했는데"*, "I tried other routine apps but gave up because they were too
  much trouble" (`42f2ac32`, ko, 5★).
- *"Watchが使えるルーチンタイマーが他にないので使ってるんですが"*, "I use it because no other routine timer works on the
  Watch" (`e5be6e7a`, ja, 3★).
- *"I’ve tried so many apps for productivity and motivation and they tend to just not help at all"* (`10334851`, en,
  5★).

**Free features they like** (14 of 16): the timer (6), simple (4), encouraging words (3). **Paying:** 2 paid, **both
for more routines** (*"Being a premium user is worth it so I can have more than one routine"*, `0aaaa664`; *"I just
upgraded to the paid version to get more routines"*, `07c9f894`), 2 free.

### Group 7. Parents and carers, usually running a child's routine (12 people, 7%, 4.25★)

- *"I use it with my toddler son for his bedtime routine"* (`96905345`, en, 5★).
- *"la routine de soir de ma fille"*, "my daughter's evening routine", but *"ça me refroidit énormément d’avoir à
  gérer des abonnements d’enfants"*, "having to manage children's subscriptions really puts me off" (`98301200`, fr,
  4★).
- *"아이들 아침 루틴으로 활용중인데요"*, "I'm using it as the children's morning routine" (`30572d33`, ko, 3★, a payer).
- *"家族みんなで使って習慣の改善ができています"*, "the whole family uses it and our habits have improved"
  (`99075031`, ja, 3★).
- *"考えなくても動けるルーティーンが必要と感じていました"*, "I felt I needed a routine I could follow without thinking",
  raising children on two jobs (`10062211`, ja, 5★).
- *"I work nights with three small kids"* (`10402562`, en, 4★).
- *"if your a busy mom like me"* (`95012295`, en, 5★).

**Free features they like** (11 of 12): pause, skip or add time (2), reminders (2), the look (2). **Paying:** 3 paid
(`30572d33`, who liked it but would pay again only once the errors are fixed; `d303cfad`, whose autistic son's
routines were archived and whose paid plan asked to resubscribe; `10561260`, for a son's iPad), 1 refused because
there's **no Family Sharing** (`99075031`), and `98301200` is put off for the same reason. **Two of the twelve ask for a
family plan.**

### Group 8. Overwhelmed (11 people, 6%, 4.82★)

- *"eu tenho bastante coisa pra fazer na semana"*, "I have a lot to do during the week" (`a2ef6895`, pt-BR, 5★).
- *"TASKS YOU CAN’T KEEP UP"* (`10134738`, en, 5★).
- *"Sometimes it’s hard for me too keep up with chores and school work"* (`10182697`, en, 5★).
- *"I’m so scattered and chaotic"*, with business, family and home to run (`10427548`, en, 5★).
- A teenager *"managing my after school and morning routines"* (`10696652`, en, 5★).

**Free features they like:** the timer (2). **Paying:** none say.

### Group 9. Lost their structure (5 people) and Group 10. Follow a method (2 people)

**Four of the five are going back to school** (reviews from July to November): *"I'm about to start school again"*
(`fe0f0a9d`), *"get back on track since a new school year has started"* (`957a2e69`), also `10256989` and `10576804`.
The fifth works from home on flexible hours (`a5b4b189`). The method is **The Miracle Morning**: *"Routinery répond plus
à mes besoins"*, "Routinery meets my needs better" than the book's own app (`99310525`, fr, 5★); *"My ADD...I really
just need step-by-step"*, for the Miracle Morning routine (`b1899f6e`, en, 5★). None say they paid.

### People who name only a goal (76 people, 4.20★)

Many more than in 2022 (8), because the 2023 labels put more into `why_chose` (178 against 63), and **30 of them are
from July**. Mornings and school dominate: *"build a productive morning routine"* (`807afeb8`), *"to get ready for
school"* (`49e434e9`), *"i downloaded this app to keep me in track for 2023"* (`94619699`), *"hoping to get a glow up
during summer"* (`10146215`), *"glow upp tiktok"* (`4a2f9174`), *"I wanted to get my life together"* after a TikTok ad
(`10435856`), *"J'ai téléchargé cette application suite à une vidéo d'un réseau social"*, "I downloaded this app after
a video on a social network" (`00df08d1`). Paying: 2 paid, 1 trial, 2 free, 2 refused.

---

## 3. Paying

### How many pay

| | 2023 | Share of 1,763 | Share of the 182 who say anything | 2022 | 2021 |
|---|---|---|---|---|---|
| Paid | 71 | 4.0% | 39% | 75 (4.9%) | 64 (3.9%) |
| On a trial | 4 | 0.2% | 2% | 3 | 9 |
| **Charged unexpectedly** | **20** | 1.1% | 11% | 6 | 4 |
| Refused to pay | 37 | 2.1% | 20% | 28 | 23 |
| Use it free and say so | 50 | 2.8% | 27% | 100 | 86 |
| Don't say | 1,581 | 90% | — | 1,322 | 1,440 |

**By group** (paid + trial): ADHD and similar 3 of 53; parents 3 of 12; forget 2 of 17; tried everything 2 of 16; lose
time 1 of 41; mornings 1 of 34 (a trial); can't start 0 of 49; overwhelmed, lost structure and method 0. **These are
one to three people each: no group pays clearly more than another.** Can't start, the second-biggest group, has no
payer and the most people saying the free plan is enough.

**By language:** 25 of the 71 payers write in Korean, 34 in English, 7 in Japanese. 13.7% of the 183 Korean reviews say
they paid, against 3.5% of the 961 English ones and 11.7% of the 60 Japanese ones; 1 of 177 Spanish reviews. Refusals:
24 of 37 in English. **12 of the 20 unexpected charges are Korean.**

**Payers are unhappy this year.** Their average rating is **2.97★** (3.91★ in 2022): 19 gave 5★ and 18 gave 1★. 54 of
the 71 report something broken, and 12 say the app told them their subscription had ended, asked them to resubscribe,
treated them as free or showed them ads (`96072952` `96465008` `96653839` `d303cfad` `98616608` `10265409` `10332054`
`d8aff0c5` `3a5c9464` `2312fef6` `24c58da8` `10439176`).

### Why the payers paid

| Reason | Payers | IDs |
|---|---|---|
| The whole app works for them, or they liked it (*"課金してよかったオブザイヤー"*, "the best thing I paid for this year"; *"정말 몇년 째 유료 결제하며 잘 쓰고있는 어플"*, "an app I've paid for and used happily for years") | 17 | `ee98d8f9` `97129447` `3c18a7e1` `3f45a171` `97807206` `99236455` `8aa90f33` `87fa9173` `10005584` `10265409` `5aeefb1b` `10448542` `59678a60` `72d2f43b` `30572d33` `98d32d0f` `0cd6a332` |
| **For more routines** (*"gladly payed for the full version which allows me to have multiple routines"*) | 4 | `95378775` `0aaaa664` `97734557` `07c9f894` |
| For another feature: start and end times in the analysis (*"그거 되는 줄 알고 12개월 결제한 거거든요"*, "I paid for 12 months thinking it did that"), online backups, a clean experience without distractions | 3 | `95766418` `d9baebdf` `3a5c9464` |
| Worth it for the price (*"Worth every penny!"*, *"no me arrepiento de haberla comprado"*, "I don't regret buying it") | 3 | `96736698` `818238f0` `10219620` |
| Loved the free trial, then bought a year | 1 | `9d170d21` |
| To support the app improving | 1 | `10141244` |
| A promotion: the New Year "1+1" offer | 3 | `95305137` `95570235` `95680444` |
| Regret it, cancelled, won't renew, or want a refund (*"예전엔 1년 구독을 잠시 썼었는데 재구독 의사는 없습니다"*, "I had a year's subscription before but won't subscribe again"; *"2년 구독권 구매했는데 매우 실망입니다"*, "I bought two years and I'm very disappointed") | 11 | `96685679` `97644748` `e3a3e3e0` `98162482` `f50f2d33` `be381180` `99406704` `9420c1e7` `10359901` `24c58da8` `10666322` |
| No reason; they mention paying only to say the paid app crashes, freezes or doesn't recognise the subscription (*"Love the app but now that I’ve paid for it it keeps crashing"*) | 27 | `95580815` `96072952` `96465008` `96653839` `97336150` `d9755b1e` `d303cfad` `37357318` `98616608` `fc978823` `385f6d73` `da4a465f` `10020747` `81baa237` `18345d89` `10152455` `10221690` `10332054` `d8aff0c5` `10343319` `61949e69` `2312fef6` `0fa8cc43` `10439176` `78356c0a` `10561260` `10744641` |
| No reason given | 1 | `94698860` |

**The feature people pay for, when they name one, is still more routines** (4 of 7), all four in English. Prices named:
18,900 won a month, 35,000 won a year, $30–35 a year, about 4 euros a month for more than two routines.

**Charged unexpectedly (20):**

| What happened | Reviews |
|---|---|
| A free trial charged at once or turned into a yearly charge | 6: `94922825` `10066843` `10174413` `10304658` `10592288` `372e6496` |
| Never signed up, or never set up payment | 4: `001510f5` `10377242` `10383807` `10724405` |
| Auto-renewed without them noticing | 3: `5c2f907b` `95894947` `95906419` |
| Charged after cancelling | 3: `10072978` `ad95f3bc` `e5883cae` |
| Charged more, or twice (a month's plan at 18,900 won, a yearly plan charged monthly) | 3: `98162901` `a3cc93aa` `10377951` |
| Pressed the wrong button | 1: `10545570` |

### What premium holds (from what free users miss and payers name)

| Behind the paywall | Reviews |
|---|---|
| **More than two routines** | about 108 mention it: about 85 want more (usually 3–5), 15 say two are enough (*"The free version lets you do two routines, so it's perfect for my morning and night routines"*), 3 paid for more, 5 say the free plan dropped to **one** routine |
| Custom icons and pictures | about 14 |
| Watch features | 6 |
| Widgets | 4 |
| Statistics | 3 |
| Backup or sync | 2 |

**One routine, not two?** In March and August five reviews say the free plan now allows only one routine (*"newest
update meant the free version only supports one routine"*, `9420c1e7`; *"Now they have downgraded to only allowing one
routine with the free version"*, `423db4f1`; also `96685679`, `888a67b9`, `10230860`), while most later reviews still
say two. The reviews can't tell whether this was a test, a bug or a change that was reversed.

**Ads** appear for the first time: 12 reviews complain of them, from April, mostly from September (`97856447`
`2c52500f` `6c6a1925` `d8aff0c5` `3a5c9464` `10383807` `36d1b05a` `3700f59c` `10604905` `10598751` `10682964`
`c4c39902`). Two are payers who still see them.

### Why others won't pay

The 37 who refuse:

| Objection | Refusals |
|---|---|
| Too expensive or can't afford it (students, teenagers, no income, a low income) | 13 |
| A subscription instead of a one-time or lifetime price (*"I wish I could just pay like $12 one time and be done with it"*) | 11 |
| Not worth it just for more routines (*"I refuse to pay a subscription just to have one more morning routine"*) | 4 |
| The bugs come first (*"Des bugs sans arrêt ça n'encourage pas a payé cette appli"*, "constant bugs don't make you want to pay for this app") | 4 |
| The paywall comes too soon or locks too much | 4 |
| No Family Sharing | 1 |

Across all reviews, by keyword: too expensive or can't afford about 27, subscription instead of a one-time price about
19, the trial or being pushed to pay about 18.

---

## 4. Free features people like

Across all 1,763 reviews, 909 (52%) name something they like:

| Feature | Reviews | Groups that name it most |
|---|---|---|
| Simple, clean, easy | 137 | Goal only (10), ADHD and similar (5), can't start (5), lose time (5) |
| The look: design, cute icons | 109 | ADHD and similar (7), lose time (4) |
| Encouraging words, the voice, nudges | 84 | **Can't start (11)**, ADHD and similar (6), mornings (5) |
| **A timer on every step** | 71 | **Lose time (11)**, mornings (9 of 34), ADHD and similar (8), tried everything (6 of 16) |
| Reminders and alerts | 31 | ADHD and similar (6), lose time (4) |
| The free version is enough | 19 | Can't start (4) |
| More than one routine | 18 | ADHD and similar (2), lose time (2) |
| No ads | 17 | Can't start (4) |
| Seeing how long things take, stats | 14 | Can't start (3), mornings (3) |
| Pause, skip or add time | 9 | Parents (2), lose time (2) |
| Walked through one step at a time | 9 | ADHD and similar (2) |
| A responsive developer | 9 | — |

**Per group:** the same pattern as every year. The **timer** matters to everyone, and most to people who lose time and
whose mornings go badly; **reminders** matter most to people with ADHD; people who can't start like **encouragement
and the voice**. Fewer people name features at all this year (52% against 69% in 2022): more reviews are short, and
more are about bugs.

---

## 5. Who they say they are

From `who` (277 people say something), with the keyword traps fixed by hand:

| They say they are | People | 2022 | 2021 |
|---|---|---|---|
| ADHD or ADD | 38 | 78 | 38 |
| **Smartwatch user** (Apple Watch, Galaxy Watch, Wear OS) | 38 | 69 | 34 |
| Student | 31 | 37 | 21 |
| Working (including a night worker, a 3 a.m. starter, an executive) | 15 | 16 | 17 |
| Procrastinator, lazy, low willpower | 12 | 12 | 19 |
| Parent | 11 | 13 | 7 |
| Autism, CPTSD, executive dysfunction | 10 | 10 | 7 |
| **Children and minors** (a 10-year-old, an 11-year-old, 6th and 7th graders, teenagers with no income) | 9 | 7 | 5 |
| Short of money or won't subscribe | 9 | 9 | 17 |
| iPad or tablet user | 8 | 14 | 9 |
| Depression, anxiety, other mental health | 6 | 13 | 10 |
| "Neurodivergent", not saying more | 4 | — | — |

**The watch:** 40 reviews mention the watch app (86 in 2022); 35 say it's broken (the timer stops when the screen
turns off, sync fails, it closes when a routine starts), 4 like it.

---

## 6. What changed

| | 2019 | 2020 | 2021 | 2022 | 2023 |
|---|---|---|---|---|---|
| Reviews | 11 | 1,122 | 1,626 | 1,534 | 1,763 |
| Name a pain point | 3 | 166 | 200 | 205 | 177 |
| Biggest group | Mornings (2 of 3) | Mornings (31%) | Can't start (28%), tried everything (28%) | ADHD and similar (45%) | **ADHD and similar (30%)**, can't start (28%) |
| ADHD or ADD named | — | 15 | 38 | 78 | 38 |
| Mornings | 2 of 3 | 31% | 19% | 10% | **19%** |
| Tried everything else | — | 16% | 28% | 10% | 9% |
| Parents | — | 3% | 3% | 6% | 7% |
| Smartwatch users | — | 10 | 34 | 69 | 38 |
| Said they paid | none | 2.2% | 3.9% | 4.9% | 4.0% |
| Payers naming a feature | — | none | 7 | 10 | 7 |
| Charged unexpectedly | — | 2 | 4 | 6 | **20** |
| Report something broken | 2 | 11% | 14% | 20% | **25%** |
| Average rating | 3.55 | 4.33 | 4.29 | 4.18 | **3.96** |

The pains are the same five as always (ADHD and similar, can't start, lose time, mornings, forget). What changed in
2023 is **who wrote and how they felt**: a wave of younger people with school mornings and "glow up" goals, fewer
people with ADHD, and **payers who mostly write because the app they paid for broke**, plus a jump in unexpected
charges.

---

## 7. Limits

- **90% don't name a pain point,** so the groups describe the 177 who do; the order is more reliable than the exact
  sizes.
- **The 2023 labels split the pain between `who` (277) and `why_chose` (178)**, more evenly than 2022 (388 / 63). I read
  both for every person, so the groups compare with earlier years, but the goal-only count (76 against 8) mostly
  reflects that split, not a real change.
- **Paying is said by 10%.** Group paying rates rest on 0–3 people.
- **The routine-limit count is approximate** (about 108): every hit was read and sorted by hand, and some reviews
  mention the limit without asking for anything.
- **Feature kinds are sorted by their words.** From 2023 the kinds also match "voice", "nudge", "history" and
  "weekday and weekend", so "encouraging words" (84) and a few other counts aren't strictly comparable with 2022's.
- **The July wave's cause isn't in the reviews.** Three mention TikTok and seven "glow up"; anything beyond that would
  be a guess.

---

## Appendix: every group member

`Line` is the review's line in `Review Labels/Routinery/2023/labels.jsonl`; `ID` is the first 8 characters of its
review ID.


| Line | ID | Store | ★ | Language | Groups | Paid |
|---|---|---|---|---|---|---|
| 3 | `cb0b7057` | Play | 5 | en | 2 Can't start or keep going | free |
| 10 | `94619699` | App Store | 4 | en | State only a goal | free |
| 13 | `1ff717ff` | Play | 5 | en | 1 ADHD and similar; 3 Lose time | not said |
| 22 | `79f193bb` | Play | 2 | en | State only a goal | not said |
| 41 | `13690840` | Play | 5 | es | State only a goal | not said |
| 56 | `45169d4b` | Play | 5 | en | 2 Can't start or keep going | not said |
| 68 | `ba0e3149` | Play | 5 | en | 2 Can't start or keep going; 3 Lose time | free |
| 69 | `94850989` | App Store | 5 | en | 1 ADHD and similar; 3 Lose time; 6 Tried other apps, planners or paper | not said |
| 74 | `94863111` | App Store | 5 | ko | 2 Can't start or keep going | not said |
| 75 | `11fe7d5b` | Play | 5 | fr | 1 ADHD and similar | not said |
| 77 | `94871786` | App Store | 5 | en | 4 Mornings go badly | not said |
| 81 | `94898014` | App Store | 5 | en | 1 ADHD and similar | not said |
| 85 | `24c3152e` | Play | 5 | en | 2 Can't start or keep going; 4 Mornings go badly | not said |
| 104 | `95012295` | App Store | 5 | en | 7 Parents and carers | not said |
| 111 | `3bf76a71` | Play | 4 | fr | 5 Forget steps and small habits | not said |
| 123 | `049a2f26` | Play | 5 | ko | State only a goal | not said |
| 126 | `756d5c94` | Play | 5 | en | 6 Tried other apps, planners or paper | not said |
| 128 | `f932a829` | Play | 5 | en | 7 Parents and carers; 8 Overwhelmed | not said |
| 168 | `00df08d1` | Play | 5 | fr | State only a goal | not said |
| 186 | `5a53035e` | Play | 4 | en | 1 ADHD and similar | not said |
| 211 | `5379f8bb` | Play | 3 | en | 3 Lose time; 4 Mornings go badly | not said |
| 215 | `a5b4b189` | Play | 5 | pl | 4 Mornings go badly; 9 Lost their structure | not said |
| 230 | `2aaff9d8` | Play | 5 | ja | 2 Can't start or keep going | not said |
| 247 | `89f23f64` | Play | 5 | en | 1 ADHD and similar | free |
| 261 | `2c888bb2` | Play | 5 | en | 6 Tried other apps, planners or paper | not said |
| 273 | `96122116` | App Store | 5 | en | 2 Can't start or keep going; 3 Lose time | not said |
| 278 | `6e71b46e` | Play | 4 | en | 1 ADHD and similar | free |
| 286 | `96187623` | App Store | 5 | en | 4 Mornings go badly | not said |
| 316 | `96490170` | App Store | 5 | en | 2 Can't start or keep going | free |
| 320 | `37c7165a` | Play | 5 | ko | State only a goal | not said |
| 326 | `96553746` | App Store | 5 | en | 1 ADHD and similar; 4 Mornings go badly | free |
| 348 | `8740d2a4` | Play | 4 | en | 1 ADHD and similar | not said |
| 358 | `cde808b4` | Play | 5 | pt | 1 ADHD and similar | not said |
| 359 | `96905345` | App Store | 5 | en | 3 Lose time; 7 Parents and carers | not said |
| 360 | `96891799` | App Store | 5 | en | 4 Mornings go badly | not said |
| 365 | `96972106` | App Store | 5 | en | 6 Tried other apps, planners or paper | not said |
| 369 | `96989375` | App Store | 5 | en | 1 ADHD and similar | not said |
| 392 | `0aaaa664` | Play | 5 | en | 6 Tried other apps, planners or paper | paid |
| 394 | `97154891` | App Store | 5 | en | 1 ADHD and similar | not said |
| 395 | `8a6a80bb` | Play | 5 | en | 3 Lose time | not said |
| 399 | `97202928` | App Store | 5 | en | 2 Can't start or keep going; 3 Lose time | not said |
| 408 | `3f45a171` | Play | 5 | en | 5 Forget steps and small habits | paid |
| 414 | `2582006a` | Play | 4 | ja | 3 Lose time | not said |
| 416 | `97358807` | App Store | 5 | ko | 4 Mornings go badly | trial |
| 430 | `97425548` | App Store | 5 | en | 4 Mornings go badly | free |
| 431 | `03e31011` | Play | 5 | en | 2 Can't start or keep going | not said |
| 435 | `242c6165` | Play | 5 | ko | 6 Tried other apps, planners or paper | not said |
| 444 | `32650ade` | Play | 4 | pt | 1 ADHD and similar | refused |
| 462 | `05bae83b` | Play | 5 | es | 2 Can't start or keep going | not said |
| 463 | `97734557` | App Store | 5 | en | 1 ADHD and similar | paid |
| 466 | `97757585` | App Store | 4 | en | 3 Lose time | not said |
| 473 | `97822491` | App Store | 5 | en | 4 Mornings go badly | not said |
| 479 | `d1dc1a28` | Play | 5 | en | 1 ADHD and similar | not said |
| 491 | `42f2ac32` | Play | 5 | ko | 6 Tried other apps, planners or paper; 8 Overwhelmed | not said |
| 502 | `98031992` | App Store | 1 | en | 1 ADHD and similar | not said |
| 505 | `af7ff931` | Play | 4 | ja | 2 Can't start or keep going | not said |
| 515 | `59c5af28` | Play | 5 | en | 1 ADHD and similar; 3 Lose time; 4 Mornings go badly | not said |
| 523 | `e98f9e00` | Play | 5 | ko | 2 Can't start or keep going | not said |
| 537 | `98301200` | App Store | 4 | fr | 7 Parents and carers | not said |
| 540 | `d303cfad` | Play | 3 | en | 7 Parents and carers | paid |
| 549 | `98399872` | App Store | 5 | en | 4 Mornings go badly; 5 Forget steps and small habits | not said |
| 576 | `15a8a2de` | Play | 5 | en | 2 Can't start or keep going | not said |
| 577 | `98642475` | App Store | 4 | en | 2 Can't start or keep going | not said |
| 580 | `c0dc8652` | Play | 4 | en | 2 Can't start or keep going | not said |
| 588 | `2bd32109` | Play | 5 | ja | 3 Lose time; 4 Mornings go badly | not said |
| 592 | `a7170a35` | Play | 5 | en | State only a goal | not said |
| 594 | `34fa2c44` | Play | 5 | en | State only a goal | not said |
| 600 | `e161ee7e` | Play | 5 | fr | 2 Can't start or keep going | not said |
| 608 | `a9fe787f` | Play | 5 | en | 2 Can't start or keep going | not said |
| 615 | `98860524` | App Store | 5 | en | 8 Overwhelmed | not said |
| 616 | `c14ac293` | Play | 2 | en | 5 Forget steps and small habits | refused |
| 619 | `99039433` | App Store | 4 | ko | State only a goal | not said |
| 631 | `99075031` | App Store | 3 | ja | 7 Parents and carers | refused |
| 634 | `99310525` | App Store | 5 | fr | 10 Follow a method | not said |
| 639 | `43b9decf` | Play | 4 | en | State only a goal | not said |
| 640 | `30572d33` | Play | 3 | ko | 7 Parents and carers | paid |
| 647 | `99355075` | App Store | 4 | en | State only a goal | not said |
| 648 | `99147063` | App Store | 5 | es | 3 Lose time; 4 Mornings go badly | not said |
| 658 | `9ab5c327` | Play | 4 | es | 5 Forget steps and small habits; 6 Tried other apps, planners or paper | not said |
| 662 | `9f817b6c` | Play | 5 | es | 1 ADHD and similar; 2 Can't start or keep going | not said |
| 674 | `6b3a5bce` | Play | 5 | en | 1 ADHD and similar | not said |
| 696 | `b1fc5374` | Play | 5 | es | 2 Can't start or keep going | not said |
| 713 | `99908484` | App Store | 2 | en | State only a goal | not said |
| 720 | `99646570` | App Store | 4 | en | 1 ADHD and similar; 2 Can't start or keep going; 5 Forget steps and small habits | not said |
| 722 | `99999793` | App Store | 3 | en | State only a goal | not said |
| 727 | `1bdfd0a5` | Play | 5 | en | 2 Can't start or keep going; 3 Lose time; 4 Mornings go badly | not said |
| 731 | `53a91ed1` | Play | 5 | ko | 6 Tried other apps, planners or paper | not said |
| 733 | `10005584` | App Store | 2 | ko | State only a goal | paid |
| 745 | `5daab0e1` | Play | 5 | es | State only a goal | not said |
| 750 | `72be0bf2` | Play | 2 | ko | State only a goal | trial |
| 764 | `07c9f894` | Play | 5 | en | 6 Tried other apps, planners or paper | paid |
| 772 | `10055340` | App Store | 5 | en | 1 ADHD and similar | not said |
| 776 | `a2ef6895` | Play | 5 | pt-BR | 8 Overwhelmed | not said |
| 783 | `a7a04f9a` | Play | 5 | nl | 4 Mornings go badly; 5 Forget steps and small habits | not said |
| 796 | `10062211` | App Store | 5 | ja | 1 ADHD and similar; 4 Mornings go badly; 5 Forget steps and small habits; 7 Parents and carers | not said |
| 799 | `4c25c797` | Play | 5 | en | 1 ADHD and similar | not said |
| 800 | `f23bc7ca` | Play | 5 | en | 4 Mornings go badly | not said |
| 803 | `ebdc639a` | Play | 5 | ko | 1 ADHD and similar; 2 Can't start or keep going | not said |
| 826 | `10077195` | App Store | 5 | en | 1 ADHD and similar; 2 Can't start or keep going; 3 Lose time | refused |
| 843 | `c25cbbab` | Play | 5 | en | 1 ADHD and similar; 4 Mornings go badly; 7 Parents and carers | not said |
| 844 | `10110272` | App Store | 5 | en | 3 Lose time | not said |
| 858 | `4d163283` | Play | 5 | en | 4 Mornings go badly | not said |
| 860 | `10112660` | App Store | 5 | en | 3 Lose time | not said |
| 875 | `10114201` | App Store | 3 | en | State only a goal | refused |
| 877 | `d9bd72aa` | Play | 4 | en | 2 Can't start or keep going | not said |
| 882 | `08ff50c2` | Play | 5 | en | State only a goal | not said |
| 887 | `10120147` | App Store | 5 | en | State only a goal | not said |
| 894 | `479aceeb` | Play | 5 | en | State only a goal | not said |
| 898 | `10115166` | App Store | 5 | en | 2 Can't start or keep going | not said |
| 901 | `10115398` | App Store | 4 | en | State only a goal | not said |
| 909 | `92909878` | Play | 4 | en | State only a goal | not said |
| 910 | `23d5b5bd` | Play | 4 | en | 2 Can't start or keep going; 3 Lose time | not said |
| 918 | `8d7682ce` | Play | 5 | lt | State only a goal | not said |
| 922 | `807afeb8` | Play | 5 | en | State only a goal | free |
| 926 | `10119313` | App Store | 5 | en | State only a goal | not said |
| 927 | `10116932` | App Store | 5 | en | 1 ADHD and similar | not said |
| 928 | `10121415` | App Store | 5 | en | 1 ADHD and similar; 4 Mornings go badly | not said |
| 938 | `10121847` | App Store | 5 | en | 2 Can't start or keep going | not said |
| 939 | `44f0685f` | Play | 5 | cs | State only a goal | not said |
| 959 | `37e940a2` | Play | 5 | pl | 3 Lose time | not said |
| 961 | `4a2f9174` | Play | 5 | en | State only a goal | not said |
| 963 | `a24892a8` | Play | 4 | en | State only a goal | not said |
| 968 | `10123077` | App Store | 5 | en | State only a goal | not said |
| 970 | `10123082` | App Store | 5 | en | State only a goal | not said |
| 973 | `25fc9f82` | Play | 2 | en | State only a goal | not said |
| 974 | `76b2ca2c` | Play | 5 | de | State only a goal | not said |
| 977 | `c7d95ee3` | Play | 5 | it | 3 Lose time | not said |
| 985 | `cb2dc949` | Play | 3 | en | State only a goal | not said |
| 989 | `c67c02ff` | Play | 4 | es | 2 Can't start or keep going | not said |
| 1001 | `f1cd52cf` | Play | 5 | en | State only a goal | not said |
| 1004 | `699262f4` | Play | 5 | en | State only a goal | not said |
| 1010 | `10134016` | App Store | 5 | en | State only a goal | not said |
| 1020 | `10134738` | App Store | 5 | en | 8 Overwhelmed | not said |
| 1022 | `7a497e6e` | Play | 5 | fr | State only a goal | not said |
| 1024 | `10130650` | App Store | 1 | en | State only a goal | not said |
| 1025 | `10135102` | App Store | 5 | pl | 6 Tried other apps, planners or paper | not said |
| 1031 | `31fdc13b` | Play | 5 | en | 2 Can't start or keep going; 8 Overwhelmed | not said |
| 1036 | `10146215` | App Store | 4 | en | State only a goal | not said |
| 1037 | `10136211` | App Store | 4 | en | 2 Can't start or keep going | not said |
| 1041 | `82d694ef` | Play | 5 | en | State only a goal | not said |
| 1042 | `10147092` | App Store | 5 | en | 1 ADHD and similar; 2 Can't start or keep going | not said |
| 1046 | `52c9c446` | Play | 4 | en | 3 Lose time | not said |
| 1072 | `10135282` | App Store | 2 | en | State only a goal | not said |
| 1077 | `10152810` | App Store | 1 | en | State only a goal | not said |
| 1088 | `10155607` | App Store | 5 | en | 2 Can't start or keep going; 3 Lose time | not said |
| 1091 | `fe0f0a9d` | Play | 5 | en | 9 Lost their structure | not said |
| 1103 | `94be158c` | Play | 5 | en | 3 Lose time | not said |
| 1109 | `10169742` | App Store | 5 | en | 2 Can't start or keep going | not said |
| 1116 | `86fa8f00` | Play | 4 | en | 4 Mornings go badly | not said |
| 1125 | `10160487` | App Store | 1 | ko | State only a goal | not said |
| 1131 | `10184385` | App Store | 5 | en | State only a goal | not said |
| 1134 | `59d4eb2e` | Play | 5 | en | 3 Lose time | not said |
| 1147 | `10178407` | App Store | 4 | en | 2 Can't start or keep going; 4 Mornings go badly | not said |
| 1150 | `0fed2b7f` | Play | 5 | en | State only a goal | not said |
| 1155 | `69133f79` | Play | 5 | en | 5 Forget steps and small habits | not said |
| 1163 | `dc97159a` | Play | 5 | en | State only a goal | not said |
| 1165 | `10192296` | App Store | 5 | en | 4 Mornings go badly | not said |
| 1167 | `10192445` | App Store | 5 | en | 3 Lose time; 4 Mornings go badly; 8 Overwhelmed | not said |
| 1169 | `10182697` | App Store | 5 | en | 4 Mornings go badly; 8 Overwhelmed | not said |
| 1180 | `68cba620` | Play | 5 | en | 3 Lose time; 4 Mornings go badly | not said |
| 1198 | `10219620` | App Store | 5 | en | 1 ADHD and similar; 3 Lose time | paid |
| 1203 | `fd257dea` | Play | 4 | en | 2 Can't start or keep going | not said |
| 1213 | `10233119` | App Store | 5 | en | 5 Forget steps and small habits | not said |
| 1220 | `7db627a7` | Play | 5 | en | State only a goal | not said |
| 1227 | `10230501` | App Store | 4 | en | State only a goal | not said |
| 1228 | `55502ffd` | Play | 3 | en | 1 ADHD and similar | not said |
| 1229 | `e5be6e7a` | Play | 3 | ja | 6 Tried other apps, planners or paper | not said |
| 1246 | `10244550` | App Store | 5 | en | State only a goal | not said |
| 1250 | `bed07888` | Play | 3 | de | 5 Forget steps and small habits | not said |
| 1261 | `51cef04a` | Play | 5 | en | 4 Mornings go badly | not said |
| 1264 | `10256362` | App Store | 5 | en | 2 Can't start or keep going | not said |
| 1266 | `de159e48` | Play | 5 | en | 1 ADHD and similar; 3 Lose time | not said |
| 1268 | `10256989` | App Store | 3 | en | 9 Lost their structure | not said |
| 1272 | `5edb37b1` | Play | 2 | en | 3 Lose time | not said |
| 1273 | `b1899f6e` | Play | 5 | en | 1 ADHD and similar; 10 Follow a method | not said |
| 1274 | `10258018` | App Store | 5 | en | 4 Mornings go badly | not said |
| 1281 | `888a67b9` | Play | 4 | en | State only a goal | not said |
| 1288 | `49e434e9` | Play | 5 | en | State only a goal | not said |
| 1294 | `94e27ad6` | Play | 5 | en | State only a goal | not said |
| 1303 | `41f0add3` | Play | 4 | en | State only a goal | not said |
| 1317 | `83c3a08d` | Play | 5 | fr | 1 ADHD and similar; 3 Lose time | not said |
| 1318 | `10317507` | App Store | 5 | ko | State only a goal | not said |
| 1319 | `db49513d` | Play | 5 | en | 4 Mornings go badly | not said |
| 1322 | `10281620` | App Store | 4 | en | State only a goal | not said |
| 1328 | `10318686` | App Store | 5 | fr | 2 Can't start or keep going | not said |
| 1329 | `1b2f9ee8` | Play | 5 | en | State only a goal | not said |
| 1335 | `10333293` | App Store | 5 | de | State only a goal | not said |
| 1339 | `10334851` | App Store | 5 | en | 2 Can't start or keep going; 6 Tried other apps, planners or paper | free |
| 1344 | `10337926` | App Store | 2 | en | 1 ADHD and similar | free |
| 1358 | `e2f5828a` | Play | 5 | en | 2 Can't start or keep going; 4 Mornings go badly | not said |
| 1360 | `3c836908` | Play | 4 | fr | 3 Lose time | not said |
| 1363 | `10343011` | App Store | 5 | en | State only a goal | not said |
| 1370 | `957a2e69` | Play | 5 | en | 9 Lost their structure | not said |
| 1372 | `10330070` | App Store | 3 | en | State only a goal | refused |
| 1374 | `1a833f96` | Play | 5 | en | State only a goal | not said |
| 1375 | `10347387` | App Store | 3 | en | State only a goal | not said |
| 1382 | `10374014` | App Store | 4 | en | 2 Can't start or keep going | free |
| 1401 | `3fe0fa24` | Play | 5 | es | State only a goal | not said |
| 1415 | `6c2e2404` | Play | 4 | fr | State only a goal | not said |
| 1417 | `bb4dd500` | Play | 4 | en | 1 ADHD and similar | not said |
| 1427 | `10384142` | App Store | 1 | en | State only a goal | not said |
| 1435 | `10402562` | App Store | 4 | en | 7 Parents and carers | not said |
| 1436 | `10432199` | App Store | 2 | ja | 2 Can't start or keep going; 3 Lose time | not said |
| 1448 | `10435856` | App Store | 5 | en | State only a goal | not said |
| 1452 | `a5425d05` | Play | 5 | en | 1 ADHD and similar; 4 Mornings go badly; 6 Tried other apps, planners or paper | not said |
| 1462 | `c0852f07` | Play | 5 | ko | State only a goal | not said |
| 1465 | `10424843` | App Store | 5 | en | 3 Lose time | not said |
| 1467 | `10427548` | App Store | 5 | en | 3 Lose time; 7 Parents and carers; 8 Overwhelmed | not said |
| 1469 | `7b336b4e` | Play | 5 | de | State only a goal | not said |
| 1479 | `10448542` | App Store | 5 | en | 5 Forget steps and small habits | paid |
| 1492 | `10487082` | App Store | 5 | en | 3 Lose time | not said |
| 1501 | `9478a6c3` | Play | 5 | en | 1 ADHD and similar | not said |
| 1504 | `10496004` | App Store | 5 | en | 2 Can't start or keep going; 3 Lose time; 5 Forget steps and small habits | not said |
| 1524 | `10473682` | App Store | 5 | en | 1 ADHD and similar; 5 Forget steps and small habits | not said |
| 1538 | `b9c2588c` | Play | 5 | ro | State only a goal | not said |
| 1554 | `10518295` | App Store | 5 | en | 1 ADHD and similar | not said |
| 1555 | `9cc2e743` | Play | 3 | en | State only a goal | not said |
| 1570 | `10552179` | App Store | 5 | fr | State only a goal | not said |
| 1575 | `10542119` | App Store | 3 | en | 1 ADHD and similar | not said |
| 1576 | `10544743` | App Store | 4 | en | 1 ADHD and similar; 2 Can't start or keep going | not said |
| 1580 | `72d2f43b` | Play | 5 | ko | State only a goal | paid |
| 1586 | `10561260` | App Store | 4 | en | 7 Parents and carers | paid |
| 1604 | `83bccce6` | Play | 5 | es | 2 Can't start or keep going | free |
| 1605 | `10576804` | App Store | 5 | en | 9 Lost their structure | not said |
| 1611 | `10577898` | App Store | 4 | en | 1 ADHD and similar | not said |
| 1612 | `10602755` | App Store | 5 | en | 2 Can't start or keep going | not said |
| 1613 | `10578243` | App Store | 5 | en | 1 ADHD and similar | not said |
| 1615 | `10579539` | App Store | 5 | en | 6 Tried other apps, planners or paper | not said |
| 1616 | `36e5e2aa` | Play | 1 | en | 1 ADHD and similar | not said |
| 1622 | `34b9f04a` | Play | 5 | pt | 2 Can't start or keep going | free |
| 1635 | `f3dc3f59` | Play | 5 | ca | 1 ADHD and similar | not said |
| 1637 | `10609434` | App Store | 5 | ko | 4 Mornings go badly | not said |
| 1638 | `defaa5c5` | Play | 2 | en | 1 ADHD and similar; 3 Lose time | not said |
| 1644 | `93892464` | Play | 3 | en | 8 Overwhelmed | not said |
| 1651 | `10655581` | App Store | 5 | es | 3 Lose time | not said |
| 1653 | `10656223` | App Store | 5 | en | State only a goal | not said |
| 1656 | `f99b6709` | Play | 4 | en | 1 ADHD and similar | not said |
| 1664 | `10635817` | App Store | 5 | en | 4 Mornings go badly | not said |
| 1687 | `10696652` | App Store | 5 | en | 8 Overwhelmed | not said |
| 1700 | `c65ba92c` | Play | 3 | en | State only a goal | not said |
| 1701 | `3adf1697` | Play | 1 | en | 1 ADHD and similar; 3 Lose time; 5 Forget steps and small habits | not said |
| 1702 | `c7c40d56` | Play | 5 | en | State only a goal | not said |
| 1705 | `10710417` | App Store | 5 | ja | 1 ADHD and similar | not said |
| 1709 | `b0ca363b` | Play | 5 | en | 1 ADHD and similar | not said |
| 1716 | `10666322` | App Store | 2 | en | 1 ADHD and similar | paid |
| 1723 | `10689369` | App Store | 5 | en | 6 Tried other apps, planners or paper | free |
| 1726 | `d823f693` | Play | 5 | en | 2 Can't start or keep going | not said |
| 1729 | `38282c51` | Play | 5 | en | 3 Lose time | not said |
| 1742 | `3576226d` | Play | 5 | en | 1 ADHD and similar; 3 Lose time; 5 Forget steps and small habits | not said |
| 1745 | `10766539` | App Store | 5 | en | State only a goal | not said |
| 1754 | `10746011` | App Store | 3 | en | 5 Forget steps and small habits | not said |
| 1758 | `764597f3` | Play | 5 | fr | 2 Can't start or keep going | not said |
| 1763 | `dc6ace72` | Play | 5 | es | State only a goal | not said |

253 people: 177 in at least one pain-point group, 76 with a goal only. Checked: every ID in this report is in `Review Labels/Routinery/2023/reviews.jsonl`.
