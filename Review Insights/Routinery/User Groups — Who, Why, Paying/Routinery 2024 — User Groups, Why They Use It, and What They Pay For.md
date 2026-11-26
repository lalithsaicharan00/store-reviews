# Routinery 2024: User Groups, Why They Use It, and What They Pay For

Written by Claude (Claude Code), 26 November 2026, at the user's request.

**What this is.** Routinery's target users as its 2024 reviews show them, the way UX user research describes them:
the groups of people who use it, each defined by the **pain point** that brought them; why each group uses it; whether
each group pays, how many, and for what; and which free features each group likes. The sixth year of a series
([2019](<Routinery 2019 — User Groups, Why They Use It, and What They Pay For.md>),
[2020](<Routinery 2020 — User Groups, Why They Use It, and What They Pay For.md>),
[2021](<Routinery 2021 — User Groups, Why They Use It, and What They Pay For.md>),
[2022](<Routinery 2022 — User Groups, Why They Use It, and What They Pay For.md>),
[2023](<Routinery 2023 — User Groups, Why They Use It, and What They Pay For.md>)).

**How it was done.** From the reviews alone, as research for a new product or a full rebuild. No product of ours, its
features or its code was used to choose, read or group anything.

**Source.** The checked labels for all 1,010 reviews of 2024 in `Review Labels/Routinery/2024/labels.jsonl`, the same
way as 2020–2023:

- **Groups:** from `who` and `why_chose`. I read all 248 reviews that have either and put each person in the group(s)
  their own words describe. One person can be in more than one group. No new group was needed this year.
- **Features liked:** from `liked` and `chose_for`, sorted into the same kinds as the earlier years.
- **Paying:** from `paid` and its reason, plus the price and premium complaints in `problems`. Every payer, every
  unexpected charge, every refusal and every routine-limit mention was sorted by hand.

Review IDs are shortened to their first 8 characters; the appendix maps every group member to its line in the labels
file. The map is saved as [`Tools/groups_2024.py`](<Tools/groups_2024.py>); [README.md](<README.md>) explains the method.

---

## The short answer

- **1,010 reviews** (568 Google Play, 442 App Store), the fewest since 2020, average **3.90★, the lowest of the six
  years**, with 134 1★ (13%). **132 people (13%) name a pain point**; 44 more name only a goal.
- **People with ADHD are back at the centre.** 56 of the 132 (42%) say they have ADHD, autism, executive dysfunction,
  depression or anxiety, up from 30% in 2023; 46 name ADHD. **Losing time is bigger than ever** (33%): phones, doom
  scrolling and time blindness. The 2023 wave of young "glow up" reviewers is gone.

| # | User group (the pain point) | People | Share of the 132 | ★ | Paid or trial | 2023 share |
|---|---|---|---|---|---|---|
| 1 | **Have ADHD, autism, executive dysfunction, depression or anxiety** | 56 | **42%** | 4.45 | 2 | 30% |
| 2 | **Lose time:** distracted (by the phone, doom scrolling, social media), time blindness, always late | 43 | **33%** | 4.72 | 1 | 23% |
| 3 | **Mornings go badly:** can't get up, back to sleep on the couch, rushing, late for the bus or work | 28 | 21% | 4.64 | 1 | 19% |
| 4 | **Can't start or keep going:** procrastinate, ADHD paralysis, a routine rut | 23 | 17% | 4.78 | 1 | 28% |
| 5 | **Forget steps and small habits** (teeth, shoes, "miss nothing") | 15 | 11% | 4.53 | 2 | 10% |
| 6 | **Overwhelmed:** large multi-step tasks, planning everything, medical school | 10 | 8% | 4.70 | 0 | 6% |
| 7 | **Tried other apps; nothing stuck** ("looking for the last 5 years") | 9 | 7% | 4.33 | 0 | 9% |
| 8 | **Lost their structure:** back to work after a baby, illness, a new school year | 4 | 3% | 4.50 | 0 | 3% |
| 9 | **Parents and carers:** mostly parents with ADHD getting children and themselves out the door | 4 | 3% | 4.50 | 0 | 7% |
| 10 | **Follow a method** | 0 | — | — | — | 1% |

  (47 people are in more than one group.)

- **Why they use it:** unchanged. The app **times every step so they can just follow along**: *"이 앱은 시간까지 딱딱
  재주니깐 그대로 따라가기만 하면 되기에 편해요"*, "this app times everything exactly, so I just have to follow it";
  *"making me stay on the one task in front of me"*; *"I have never found an app that really works with my
  ADHD-associated time blindness"*.
- **Paying is mostly about wanting money back.** 46 people (4.6%) say they paid; **their average rating is 2.72★**
  (2.97★ in 2023, 3.91★ in 2022) and 33 of them report something broken. Of the 46, **only 10 give a reason to pay**
  (7 the whole app, 2 a feature, 1 the price); 14 regret it or want a refund and 21 mention paying only to report a
  bug. **22 say they were charged unexpectedly**, 10 of them by a free trial that charged at once or became a year.
- **Korean reviews are now mostly refund requests.** 21 Korean reviewers say they paid (13.5% of Korean reviews,
  against 3.1% of English ones), but 9 of those 21 ask for a refund, and 14 of the 22 unexpected charges are Korean.
- **The paywall is still the third routine, and no one says they paid for it.** About 46 reviews mention the
  two-routine free limit: about 36 want more (usually 3–5), 8 say two are enough, and 2 say routines now need payment
  altogether. Every refusal tied to the limit says the same: two is too few for different days.
- **New things people dislike:** bugs above all (**30% of reviews report something broken**, from 25%), an **AI chatbot
  and voice** on the main screen (*"I will be using a competitor app that doesn't try to make me speak to a chatbot
  constantly"*), being logged out or asked to log in, and an AI-translated interface.
- **Free features liked:** simple and clean (84), the look (55), **a timer on every step (53)**, encouraging words
  (30), reminders (23), a **responsive developer (14)**. People with ADHD name simplicity (10) and the timer (8) first.

---

## 1. The year in numbers

| | Count | Share of 1,010 |
|---|---|---|
| Reviews | 1,010 | 100% |
| Google Play / App Store | 568 / 442 | 56% / 44% |
| Language: English, Korean, Spanish, Japanese, Polish, French, Portuguese, other | 553, 156, 93, 39, 34, 26, 21, 88 | 55%, 15%, 9%, 4%, 3%, 3%, 2%, 9% |
| Ratings 5★ / 4★ / 3★ / 2★ / 1★ | 538 / 172 / 95 / 71 / 134 | 53% / 17% / 9% / 7% / 13% |
| Say who they are (`who`) | 159 | 16% |
| Say why they came (`why_chose`) | 155 | 15% |
| Name a pain point (any group below) | **132** | **13%** |
| Name only a goal | 44 | 4% |
| Name a feature they like | 425 | 42% |
| Say anything about paying | 122 | 12% |
| Report something broken | 303 | **30%** |
| Nothing useful ("great app") | 118 | 12% |

Reviews by month are steadier than in 2023 (no July wave): the most in August (143) and January (123), the fewest in
May (57) and October (57).

---

## 2. The user groups

### Group 1. Have ADHD, autism, executive dysfunction, depression or anxiety (56 people, 42%, 4.45★)

**Who they are:** ADHD (46), autism or executive dysfunction (4), depression, anxiety, panic attacks or other mental
health (8). Diagnosed adults, people who say they have *"some adhd-struggles"* or ADHD tendencies, students, **three mothers
with ADHD getting children to daycare and themselves to work**, a person sent by their therapist. 28 are only in this
group. They give the reason in ADHD terms: time blindness, paralysis, wandering minds, unstructured time.

**Why they use it:**
- *"As a person with some adhd-struggles"* (`b7354781`, en, 5★).
- *"極度のADHDなので"*, "because I have extreme ADHD" (`10934839`, ja, 5★).
- *"Tenho TDAH diagnosticado"*, "I have diagnosed ADHD" (`e5c2d0ce`, pt, 5★).
- *"to overcome ADHD paralysis"* (`11157017`, en, 3★).
- *"With ADHD I feel like tasks and time often escape me"* (`409a257f`, en, 5★).
- *"I have never found an app that really works with my ADHD-associated time blindness and inability to stick to a
  schedule"* (`bbb32e3c`, en, 5★).
- *"We were running late every morning, no matter what I did"*, a mother with ADHD and three children under five
  (`11628572`, en, 5★).
- *"Cette application m'a été conseillée par mon psy"*, "this app was recommended to me by my therapist" (`814268fb`,
  fr, 5★).
- *"need everything to be on time and need a schedule or else I have a panic attack"* (`11883196`, en, 5★).
- *"sem ficar ansiosa pensando na infinidade de coisas que tenho para fazer"*, "without getting anxious thinking about
  the endless things I have to do" (`f0d61c80`, pt-BR, 5★).
- And the disappointed: *"As someone with intense ADHD, I thought the structure this app provides would be helpful"*
  (`11984464`, en, 1★).

**Free features they like** (46 of 56): **simple and clean (10)**, the timer on every step (8), encouraging words
(4), a responsive developer (3), the look (3), reminders (3), more than one routine (2).

**Paying:** 2 paid, 2 free, 1 refused, 51 don't say. One subscribed for a year once the bugs were fixed (`11233772`);
one isn't renewing *"because I forget about it too much"* (`af2fe9dd`). The refusal: *"I am unwilling to pay a monthly
fee for something that should be a one-time purchase"*, though the app *"has been a game-changer for my ADHD"*
(`10878380`).

### Group 2. Lose time (43 people, 33%, 4.72★)

**Who they are:** people distracted by their phone and social media, people who lose track of time, are always late,
or used to live without plans (*"평소에 계획없이 살았는데"*, `10934300`). 18 are only in this group. The biggest share this group has had in any year.

**Why they use it:**
- *"no tenía tiempo para nada o me distraía con mi teléfono"*, "I had no time for anything, or got distracted by my
  phone" (`cca3f2dc`, es, 5★).
- *"予定の時間に15分くらい遅刻するのが当たり前でした"*, "being about 15 minutes late for appointments was normal for me"
  (`10925188`, ja, 5★).
- *"No more hours lost doom scrolling before I shower"* (`11641777`, en, 5★).
- *"the worst thing that happened to me that is social media"* (`11944681`, en, 5★).
- *"すぐ別のことに脱線してしまうのが防げてとても良い"*, "it's great that it stops me going off onto something else"
  (`adfb5da5`, ja, 5★).
- *"I lose track of time and I'll forget that I have things to do in my routine"* (`a632a519`, en, 5★).
- *"I was always running late and never felt like I had enough time for anything!"* (`11392402`, en, 5★).
- A teenager *"trying to make the most of my teenage years"*, instead of doom-scrolling after school (`11421062`, en,
  5★).

**Free features they like** (36 of 43): simple (8), **the timer (7)**, the look (4), seeing when the routine will
finish (2), reminders (2), seeing how long things take (2).

**Paying:** 1 paid, *"기록보려고 유료결제까지 했는데"*, "I even paid to see my records", then lost them to a sync bug
(`7753c730`, ko, 1★); 4 free.

### Group 3. Mornings go badly (28 people, 21%, 4.64★)

Up a little again (10% in 2022, 19% in 2023). Fewer school mornings than 2023, more **work mornings**, often with ADHD.
- *"Normally I wake up late and sometimes only just get my bus on time"* (`10853808`, en, 5★).
- *"I would just wake up and sleep more on the couch"* (`11102702`, en, 5★).
- *"아침에 항상 일어나기 힘들었는데"*, "I always found it hard to get up in the morning" (`11044929`, ko, 5★).
- *"przed rutyną byłam zawsze leniwa i nawet na 8:00 nie wstawałam"*, "before the routine I was always lazy and didn't
  even get up by 8:00" (`ed5ed588`, pl, 5★).
- *"아침마다 어영부영 시간보내다가"*, "I used to fritter away every morning" (`11897932`, ko, 5★).
- *"It completely helps my ADHD specifically when getting ready for work in the morning"* (`11908206`, en, 5★).
- *"평생 못 고칠 줄 알았던 수면패턴"*, "a sleep pattern I thought I could never fix" (`12114097`, ko, 5★).
- *"Before this, my mornings were a mess."* (`12077111`, en, 5★).

**Free features they like** (22 of 28): **the timer (5)**, encouraging words (4), simple (3). **Paying:** 1 paid (the
records payer above, `7753c730`), 2 free, 1 refused (the one-time-price ADHD parent, `10878380`).

### Group 4. Can't start or keep going (23 people, 17%, 4.78★)

Smaller than in any year so far (27–28% in 2020–2023). 13 are only in this group.
- *"I didn’t make my bed my face was dry and I never tidied my room"* (`10847884`, en, 5★).
- *"it’s the only thing that can make me commit to a routine"* (`10968567`, en, 5★).
- *"途中でだるくなってソファで煙草吸いながらボケーっとしちゃう気がして"*, "I feel I'd get sluggish partway and zone out on
  the sofa smoking" (`11002089`, ja, 5★).
- *"I was in a routine rut until I used this"* (`11537230`, en, 5★).
- *"I always spend so much time procrastinating"* (`a3304c50`, en, 5★).
- *"i just needed someone (me/this app) telling me what i need to be doing right now for most of the day"*
  (`11709753`, en, 5★).
- *"my brain is not working anymore but I still have a lot of stuff to do before going to sleep"*, after work
  (`57b505e3`, en, 5★).

**Free features they like** (22 of 23): the timer (3), simple (2), encouraging words (2), reminders (2). The
highest-rated group. **Paying:** 1 paid: *"유료버전 1년 결제해서 뽕뽑는다는 마음으로 열심히 썼는데 쓰면 쓸수록
좋아지네요"*, "I paid for a year and used it hard to get my money's worth, and the more I use it the better it gets"
(`11980662`, ko, 5★).

### Group 5. Forget steps and small habits (15 people, 11%, 4.53★)

- *"when I forget something in my routine, like brushing my teeth or putting my shoes on"* (`11639547`, en, 5★).
- *"Helps me remember to do all those little things I tend to forget"* (`11316567`, en, 4★).
- *"om mijn ochtendroutine goed te doen en geen dingen te vergeten"*, "to do my morning routine well and not forget
  things" (`11909065`, nl, 5★).
- *"아무생각없이 습관들 쫙 진행하며 시간도 아끼고, 빠뜨린거 없으려고 이 어플을 쓰는건데"*, "I use this app to run
  through my habits without thinking, save time and miss nothing", until a bug deleted them (`a912e07a`, ko, 1★, a
  payer).

**Free features they like** (13 of 15): simple (2), the timer (2), reminders, pause or skip, more than one routine (1
each). **Paying:** 2 paid: the payer above, and *"便利で機能も充実してるので課金して活用させていただいてる"*, "it's
convenient and full of features, so I pay and use it", but *"忘れてしまわないため・習慣を守るためのルーティン管理アプリなので、決めた時間に通知が来ないと意味がない"*,
"it's a routine app for not forgetting and keeping habits, so it's pointless if the reminder doesn't come at the set
time", and they're thinking of cancelling (`10a0d5b1`, ja, 3★). 1 free.

### Group 6. Overwhelmed (10 people, 8%, 4.70★)

- *"I tend to be overwhelmed with large multi-step tasks"* (`11617837`, en, 5★, ADHD).
- *"its always hard to plan evrything out without getting overwhelmed"*, a child with anxiety (`11629935`, en, 5★).
- *"used to be bogged down by uncertainty of time commitments for things"* (`11685886`, en, 5★).
- *"when self-care was hard to manage"*, in medical school (`11658595`, en, 5★).
- *"It helps me tackle hard things and create flow without getting overwhelmed"* (`12119991`, en, 5★).

**Free features they like:** simple (4), the timer (3). **Paying:** 1 refused: two routines aren't enough *"because I
have a busy schedule and need to make more routines tor different days"* (`b10b40f4`, en, 2★).

### Group 7. Tried other apps; nothing stuck (9 people, 7%, 4.33★)

- *"This is the app I've been looking for for the last 5 years"* (`1a9ff4a6`, en, 5★).
- *"não existe nada que funcione realmente para mim"*, "there's nothing that really works for me" (`b76a8397`, pt-BR,
  4★).
- *"ほんの些細なことにつまずいて挫折していました"*, "I would trip over the tiniest things and give up", with earlier
  routine timers (`11615230`, ja, 5★).
- *"Was hoping for something better than workshift calendar"* (`be917c35`, en, 3★).
- Others had tried *"plein d'autres trucs et astuces avec mon tdah"*, "lots of other tricks and tips for my ADHD"
  (`814268fb`) or found other apps too complicated
  (`11656544`).

**Free features they like:** simple (2). **Paying:** 1 free; none paid.

### Group 8. Lost their structure (4 people) and Group 9. Parents and carers (4 people)

Back to work in 2024 after a baby in 2023 (`10878380`), recently sick (`11521931`), and two students before a new
school year (`11631460`, `11628099`). The parents are **three mothers with ADHD** getting children to preschool or
daycare and themselves to work (`10878380`, `11628572`, `11745385`) and a parent whose son it helped, *"ساعدني
ابني"*, "it helped my son" (`a6406fb9`, ar, 5★). Outside the groups, one person wants to share routines with a partner, and a family plan (`e98e34d3`). None of
these say they paid; one refused (the one-time-price parent).

### People who name only a goal (44 people, 4.27★)

Morning and night routines above all: *"wanting to have a better morning routine"* (`10780301`), *"forming and
maintaining good routines after I wake up and before I go to bed"* (`11222845`), *"do my cooking, fitness, education,
grooming routine and managing my time"* (`cd468f19`), *"Je hais la routine… mais elle est nécessaire"*, "I hate routine…
but it's necessary" (`11733654`, fr), *"es la primera que logro encontrar en español"*, "it's the first one I've managed
to find in Spanish" (`363f6df0`, es). Paying: 4 paid, 1 trial, 2 free, 2 refused.

---

## 3. Paying

### How many pay

| | 2024 | Share of 1,010 | Share of the 122 who say anything | 2023 | 2022 |
|---|---|---|---|---|---|
| Paid | 46 | 4.6% | 38% | 71 (4.0%) | 75 (4.9%) |
| On a trial | 5 | 0.5% | 4% | 4 | 3 |
| **Charged unexpectedly** | **22** | **2.2%** | 18% | 20 (1.1%) | 6 (0.4%) |
| Refused to pay | 21 | 2.1% | 17% | 37 | 28 |
| Use it free and say so | 28 | 2.8% | 23% | 50 | 100 |
| Don't say | 888 | 88% | — | 1,581 | 1,322 |

**By group** (paid + trial): ADHD and similar 2 of 56; forget 2 of 15; lose time 1 of 43; mornings 1 of 28; can't start
1 of 23; overwhelmed, tried everything, lost structure and parents 0. **One or two people each: no group pays clearly
more than another.**

**By language:** 21 of the 46 payers write in Korean, 17 in English. 13.5% of the 156 Korean reviews say they paid,
against 3.1% of the 553 English ones and 1 of 39 Japanese ones. **But 9 of the 21 Korean payers ask for a refund**
(`11195252` `11360005` `11522558` `d6696980` `11729876` `1369bd85` `4e34d3c3` `11973001` `11940731`), several for a
year they never used, and **14 of the 22 unexpected charges are Korean.** Refusals: 12 of 21 in English.

**Payers are the unhappiest they have been.** Their average rating is **2.72★** (2.97★ in 2023, 3.91★ in 2022): 17 gave
1★ and 9 gave 5★. 33 of the 46 report something broken, and 5 say the app doesn't recognise what they paid for
(`dc84883d` `3be83c61` `4559e54f` `362ddc4d` `c923ddfc`).

### Why the payers paid

| Reason | Payers | IDs |
|---|---|---|
| The whole app works for them, or they liked it (*"설치한지 하루만에 유료결제 결정할만큼 다 너무 좋은데요"*, "everything is so good I decided to pay one day after installing"; *"I bought this app tonight thinking it would be a scam"*, then *"This app is amazing!"*) | 7 | `6de157c3` `d7e79c8f` `615bfa8f` `11622956` `9da8248b` `10a0d5b1` `11233772` |
| For a feature: to see their records; the rain white noise (*"백색소음에 빗소리가 있길래 기대하고 프리미엄을 결제했는데"*, "I paid for premium looking forward to the rain white noise", then found it too loud) | 2 | `7753c730` `11595847` |
| To get their money's worth from a year | 1 | `11980662` |
| Regret it, won't renew, or want a refund (*"Now really regretting that I got the yearly subscription!"*; *"Not renewing my subscription at this time because I forget about it too much"*) | 14 | `d967921c` `11195252` `11360005` `6b8774be` `11522558` `d6696980` `ead8ae59` `11626919` `11729876` `1369bd85` `4e34d3c3` `11973001` `af2fe9dd` `11940731` |
| No reason; they mention paying only to say the paid app is slow, crashes, rings at random or doesn't recognise the subscription (*"Took my money for a subscription but now won't recognise that I have subscribed"*) | 21 | `64db607d` `10881832` `bb7178fd` `10991423` `ac48baf3` `dc84883d` `f998e024` `3be83c61` `11263474` `b9384761` `9ed1de2f` `11395184` `11515721` `4559e54f` `362ddc4d` `46258820` `c923ddfc` `11628855` `a912e07a` `11903518` `5ba630b4` |
| No reason given | 1 | `11217088` |

**For the first time no payer says they paid for more routines.** The two features named are records and a sound.
Prices named: about 27 a year (`8b1ba81c`), 35,000 won a year.

**Charged unexpectedly (22):**

| What happened | Reviews |
|---|---|
| A free trial charged at once, charged twice, or turned into a year | 10: `11104661` `11084864` `11360391` `11422332` `dabc53b1` `11674221` `52a4d97f` `11850519` `11919502` `c4edfccb` |
| Charged without knowing, or after uninstalling | 7: `ca7e002c` `10859182` `11052787` `11462945` `caf0a154` `11951808` `986be4ac` |
| Charged after cancelling | 3: `4e2ce563` `11219949` `fe3ef80f` |
| Paid by mistake | 2: `10940540` `d35ebe81` |

### What premium holds (from what free users miss and payers name)

| Behind the paywall | Reviews |
|---|---|
| **More than two routines** | about 46 mention it: about 36 want more (usually 3–5), 8 say two are enough (*"Free version allows two routines which is perfect for morning evening"*), 2 say routines now need payment altogether, none paid for more |
| Custom icons and stickers | about 6 |
| Backup or sync | 4 |
| Statistics and data analysis | 2 |

**Free routines gone?** Two reviews say routines now need paying for altogether: *"maintenant il faut payer pour
débloquer les routines"*, "now you have to pay to unlock the routines" (`cbc70c88`, fr, March), and after a reinstall
*"now they make you pay for it"* (`05f580e7`, en, July). One says the free plan allows three (`8b1ba81c`); most still say
two. As in 2023, the reviews can't tell whether this was a test, a bug or a change.

**Ads** are mentioned 5 times (12 in 2023).

### Why others won't pay

The 21 who refuse:

| Objection | Refusals | IDs |
|---|---|---|
| **The bugs come first** (*"큰 버그들만 해결되면 유료결제 당연히 하려고 했는데"*, "I was certainly going to pay once the big bugs were fixed") | 7 | `28882ff0` `a29cacd0` `08205e79` `7c99b9c4` `870a6e24` `1c7aaa22` `15e15852` |
| Two routines are too few, or routines are now paid | 5 | `cbc70c88` `36c3784e` `05f580e7` `b10b40f4` `11953147` |
| A subscription instead of a one-time price | 4 | `10878380` `11181014` `11308909` `5f36c1ef` |
| Not worth it for what premium adds (data analysis, two features) | 2 | `d8e828d7` `11486140` |
| Too expensive or no money | 2 | `84c55b5c` `11748315` |
| Doesn't pay for apps | 1 | `11096315` |

**For the first time bugs, not price, are the most common reason to refuse.** Across all reviews, by keyword: too
expensive about 19, the trial or being pushed to pay about 16, subscription instead of one-time about 8.

---

## 4. Free features people like

Across all 1,010 reviews, 425 (42%) name something they like:

| Feature | Reviews | Groups that name it most |
|---|---|---|
| Simple, clean, easy | 84 | **ADHD and similar (10)**, lose time (8), goal only (8), overwhelmed (4) |
| The look: design, cute icons | 55 | Goal only (6), lose time (4), ADHD and similar (3) |
| **A timer on every step** | 53 | ADHD and similar (8), lose time (7), mornings (5), can't start (3), overwhelmed (3) |
| Encouraging words, the voice | 30 | ADHD and similar (4), mornings (4) |
| Reminders and alerts | 23 | ADHD and similar (3), can't start (2), lose time (2) |
| **A responsive developer** | 14 | ADHD and similar (3) |
| Pause, skip or add time | 11 | — |
| The free version is enough | 9 | — |
| More than one routine | 9 | ADHD and similar (2) |
| Walked through one step at a time | 8 | — |

**Per group:** the timer and simplicity matter to every group; **reminders** and **encouragement** still matter most to
people with ADHD. Fewer people name a feature at all (42%, from 52% in 2023 and 69% in 2022), because more reviews are
about bugs. A responsive developer is named more than before (14, from 9): people thank the replies even while the
bugs remain.

**What people dislike that is new:** an **AI chatbot** on the main screen and a new AI voice (`df54f4c2` `e0bc2095`
`11233772` `11327316` `15e15852`: *"Please give a settings option to disable the "AI" that tries to talk to you"*), an
AI-translated interface (`11732991`), and **accounts**: being logged out, having to log in again, or being asked to
sign up and upload data (about 9 reviews).

---

## 5. Who they say they are

From `who` (159 people say something), with the keyword traps fixed by hand:

| They say they are | People | 2023 | 2022 |
|---|---|---|---|
| ADHD or ADD | 46 | 38 | 78 |
| **Smartwatch user** (Apple Watch, Galaxy Watch, Pixel Watch, Wear OS) | 36 | 38 | 69 |
| Working (a software engineer, fast-food early shifts, night workers) | 12 | 15 | 16 |
| Student | 10 | 31 | 37 |
| Depression, anxiety, panic attacks, other mental health | 8 | 6 | 13 |
| iPad or tablet user | 6 | 8 | 14 |
| Parent | 5 | 11 | 13 |
| Autism, executive dysfunction | 4 | 10 | 10 |
| Procrastinator, lazy, low willpower | 4 | 12 | 12 |
| Children and minors (14 or younger, a teenager, a child with anxiety, one whose mum allows the app) | 4 | 9 | 7 |

**The watch:** 47 reviews mention the watch app (40 in 2023); 32 say it's broken and 12 say something is missing,
6 like it. Four use the watch so they can leave the phone behind in the morning (`10924800`, `11427409`, `11537230`,
`11819860`).

---

## 6. What changed

| | 2020 | 2021 | 2022 | 2023 | 2024 |
|---|---|---|---|---|---|
| Reviews | 1,122 | 1,626 | 1,534 | 1,763 | 1,010 |
| Name a pain point | 166 | 200 | 205 | 177 | 132 |
| Biggest group | Mornings (31%) | Can't start (28%), tried everything (28%) | ADHD and similar (45%) | ADHD and similar (30%) | **ADHD and similar (42%)** |
| ADHD or ADD named | 15 | 38 | 78 | 38 | 46 |
| Lose time | 24% | 21% | 20% | 23% | **33%** |
| Can't start | 27% | 28% | 28% | 28% | 17% |
| Mornings | 31% | 19% | 10% | 19% | 21% |
| Students | 10 | 21 | 37 | 31 | 10 |
| Smartwatch users | 10 | 34 | 69 | 38 | 36 |
| Said they paid | 2.2% | 3.9% | 4.9% | 4.0% | 4.6% |
| Payers' average rating | — | — | 3.91 | 2.97 | **2.72** |
| Payers naming a feature | none | 7 | 10 | 7 | 2 |
| Charged unexpectedly | 2 | 4 | 6 | 20 | **22** |
| Report something broken | 11% | 14% | 20% | 25% | **30%** |
| Average rating | 4.33 | 4.29 | 4.18 | 3.96 | **3.90** |

The pains are the same as every year. What changed is that **people with ADHD and people who lose time to their
phone are now most of the app's users**, students fell away, and **paying has turned from "I pay because it works" into
"I paid and it broke" or "I was charged and want it back."** Bugs are now the main reason people won't pay.

---

## 7. Limits

- **87% don't name a pain point,** so the groups describe the 132 who do; the order is more reliable than the exact
  sizes.
- **`who` (159) and `why_chose` (155) are almost even this year**, like 2023; I read both for every person, so the
  groups compare with earlier years, but goal-only counts (44) don't.
- **Paying is said by 12%.** Group paying rates rest on 0–2 people.
- **The routine-limit count is approximate** (about 46): every hit was read and sorted by hand.
- **Feature kinds are sorted by their words**, as in 2023.
- **"Paid" includes refund requests:** a label of `paid` means the person says they paid, not that they meant to; 9
  Korean "payers" want their money back, and the line between them and "charged unexpectedly" is the reviewer's own
  wording.

---

## Appendix: every group member

`Line` is the review's line in `Review Labels/Routinery/2024/labels.jsonl`; `ID` is the first 8 characters of its
review ID.


| Line | ID | Store | ★ | Language | Groups | Paid |
|---|---|---|---|---|---|---|
| 28 | `10777878` | App Store | 3 | ja | 2 Lose time | not said |
| 30 | `7753c730` | Play | 1 | ko | 2 Lose time; 3 Mornings go badly | paid |
| 32 | `9bd7d55d` | Play | 5 | en | 2 Lose time; 6 Overwhelmed | not said |
| 37 | `10780301` | App Store | 5 | en | State only a goal | free |
| 44 | `10782662` | App Store | 5 | en | 3 Mornings go badly; 5 Forget steps and small habits | not said |
| 60 | `10847884` | App Store | 5 | en | 4 Can't start or keep going | not said |
| 66 | `10853808` | App Store | 5 | en | 3 Mornings go badly | not said |
| 76 | `10857578` | App Store | 5 | en | 1 ADHD and similar; 2 Lose time; 3 Mornings go badly | not said |
| 79 | `b7354781` | Play | 5 | en | 1 ADHD and similar | not said |
| 85 | `0b53ec0e` | Play | 5 | en | State only a goal | not said |
| 98 | `10828241` | App Store | 5 | pl | State only a goal | not said |
| 102 | `cca3f2dc` | Play | 5 | es | 2 Lose time | not said |
| 122 | `e854c0ab` | Play | 5 | en | 1 ADHD and similar; 5 Forget steps and small habits | not said |
| 129 | `10878380` | App Store | 4 | en | 1 ADHD and similar; 3 Mornings go badly; 8 Lost their structure; 9 Parents and carers | refused |
| 132 | `1af40f6a` | Play | 5 | en | State only a goal | not said |
| 134 | `c082fd23` | Play | 3 | ko | State only a goal | not said |
| 146 | `10924800` | App Store | 4 | en | State only a goal | not said |
| 147 | `e5c2d0ce` | Play | 5 | pt | 1 ADHD and similar | not said |
| 152 | `10925188` | App Store | 5 | ja | 2 Lose time | not said |
| 155 | `10960910` | App Store | 5 | en | 1 ADHD and similar; 4 Can't start or keep going | not said |
| 166 | `10934300` | App Store | 5 | ko | 2 Lose time | not said |
| 168 | `10934839` | App Store | 5 | ja | 1 ADHD and similar | not said |
| 169 | `10968567` | App Store | 5 | en | 4 Can't start or keep going | not said |
| 183 | `ead9ae2c` | Play | 3 | de | 1 ADHD and similar; 3 Mornings go badly | not said |
| 202 | `11015613` | App Store | 5 | en | 3 Mornings go badly | not said |
| 203 | `10987524` | App Store | 5 | en | State only a goal | not said |
| 206 | `11016042` | App Store | 5 | ko | 3 Mornings go badly | not said |
| 214 | `f14f2c99` | Play | 5 | en | 2 Lose time | not said |
| 220 | `a632a519` | Play | 5 | en | 2 Lose time; 5 Forget steps and small habits | not said |
| 229 | `11044929` | App Store | 5 | ko | 3 Mornings go badly | not said |
| 234 | `c1b4d6cf` | Play | 1 | en | 1 ADHD and similar | not said |
| 242 | `11010718` | App Store | 4 | fr | 1 ADHD and similar | not said |
| 246 | `2a407017` | Play | 5 | en | 4 Can't start or keep going | not said |
| 247 | `11064505` | App Store | 5 | en | 3 Mornings go badly; 4 Can't start or keep going | not said |
| 249 | `11002089` | App Store | 5 | ja | 4 Can't start or keep going | not said |
| 251 | `11096315` | App Store | 4 | en | State only a goal | refused |
| 256 | `11099850` | App Store | 3 | en | 1 ADHD and similar | not said |
| 267 | `11102702` | App Store | 5 | en | 3 Mornings go badly | not said |
| 268 | `11078878` | App Store | 5 | en | 2 Lose time | not said |
| 271 | `ed5ed588` | Play | 5 | pl | 3 Mornings go badly; 4 Can't start or keep going | not said |
| 293 | `11124514` | App Store | 5 | en | 1 ADHD and similar | not said |
| 295 | `11067615` | App Store | 5 | en | 1 ADHD and similar | not said |
| 299 | `11117437` | App Store | 5 | en | 2 Lose time | free |
| 326 | `11157017` | App Store | 3 | en | 1 ADHD and similar; 4 Can't start or keep going | not said |
| 333 | `11200687` | App Store | 5 | en | 1 ADHD and similar; 2 Lose time; 4 Can't start or keep going; 5 Forget steps and small habits | not said |
| 360 | `60cb3d54` | Play | 5 | en | 1 ADHD and similar | not said |
| 363 | `11222845` | App Store | 5 | en | State only a goal | not said |
| 372 | `cd468f19` | Play | 5 | en | State only a goal | not said |
| 376 | `11233772` | App Store | 5 | en | 1 ADHD and similar | paid |
| 395 | `7ec67c0c` | Play | 5 | fr | State only a goal | not said |
| 411 | `11316567` | App Store | 4 | en | 2 Lose time; 5 Forget steps and small habits | not said |
| 437 | `4ffb9444` | Play | 5 | ko | 2 Lose time; 3 Mornings go badly; 4 Can't start or keep going | not said |
| 440 | `11342366` | App Store | 5 | ko | 2 Lose time | not said |
| 446 | `11314153` | App Store | 5 | ja | 1 ADHD and similar; 4 Can't start or keep going | not said |
| 448 | `7a870681` | Play | 4 | en | 3 Mornings go badly; 4 Can't start or keep going | not said |
| 452 | `11392402` | App Store | 5 | en | 2 Lose time | not said |
| 453 | `11392777` | App Store | 5 | en | 3 Mornings go badly | free |
| 454 | `11421062` | App Store | 5 | en | 2 Lose time | not said |
| 455 | `adfb5da5` | Play | 5 | ja | 2 Lose time | free |
| 464 | `11427409` | App Store | 3 | en | 1 ADHD and similar | not said |
| 469 | `11400702` | App Store | 1 | ko | State only a goal | not said |
| 471 | `9f9cbc3c` | Play | 4 | en | State only a goal | not said |
| 477 | `11406797` | App Store | 5 | en | 2 Lose time | not said |
| 482 | `f0d61c80` | Play | 5 | pt-BR | 1 ADHD and similar; 2 Lose time; 6 Overwhelmed | not said |
| 484 | `93991683` | Play | 2 | tr | State only a goal | not said |
| 486 | `c0b258e9` | Play | 5 | ko | State only a goal | not said |
| 509 | `be917c35` | Play | 3 | en | 7 Tried other apps, planners or paper | not said |
| 523 | `d7e79c8f` | Play | 4 | ko | State only a goal | paid |
| 532 | `11521931` | App Store | 4 | en | 8 Lost their structure | not said |
| 534 | `d7d1bb84` | Play | 1 | en | 1 ADHD and similar | not said |
| 536 | `11484224` | App Store | 5 | en | 1 ADHD and similar | not said |
| 538 | `363f6df0` | Play | 3 | es | State only a goal | trial |
| 542 | `11537230` | App Store | 5 | en | 4 Can't start or keep going | not said |
| 546 | `11486140` | App Store | 3 | en | State only a goal | refused |
| 571 | `a6406fb9` | Play | 5 | ar | 9 Parents and carers | not said |
| 577 | `84d383f4` | Play | 5 | en | 2 Lose time | free |
| 592 | `cbb9e1be` | Play | 3 | en | 1 ADHD and similar | not said |
| 597 | `1151e1c7` | Play | 4 | en | 2 Lose time; 3 Mornings go badly | not said |
| 600 | `11602964` | App Store | 4 | en | State only a goal | not said |
| 602 | `11606439` | App Store | 4 | en | 1 ADHD and similar | not said |
| 608 | `11622839` | App Store | 4 | en | State only a goal | not said |
| 609 | `11608608` | App Store | 5 | en | 1 ADHD and similar | free |
| 612 | `b10b40f4` | Play | 2 | en | 6 Overwhelmed | refused |
| 622 | `11612642` | App Store | 5 | en | 1 ADHD and similar | not said |
| 628 | `11613112` | App Store | 5 | en | 1 ADHD and similar | not said |
| 629 | `11629935` | App Store | 5 | en | 1 ADHD and similar; 6 Overwhelmed | not said |
| 631 | `11631460` | App Store | 5 | en | 8 Lost their structure | not said |
| 635 | `1576d7bb` | Play | 5 | ko | State only a goal | not said |
| 637 | `11615230` | App Store | 5 | ja | 2 Lose time; 7 Tried other apps, planners or paper | not said |
| 638 | `11615292` | App Store | 5 | en | 2 Lose time; 5 Forget steps and small habits | not said |
| 641 | `11617837` | App Store | 5 | en | 1 ADHD and similar; 6 Overwhelmed | not said |
| 645 | `11622724` | App Store | 4 | ja | 1 ADHD and similar; 2 Lose time | not said |
| 648 | `11628099` | App Store | 5 | en | 8 Lost their structure | not said |
| 649 | `11628572` | App Store | 5 | en | 1 ADHD and similar; 3 Mornings go badly; 9 Parents and carers | not said |
| 650 | `11628855` | App Store | 3 | en | State only a goal | paid |
| 654 | `31a21bf0` | Play | 5 | en | State only a goal | not said |
| 657 | `11656544` | App Store | 5 | en | 6 Overwhelmed; 7 Tried other apps, planners or paper | not said |
| 661 | `11658595` | App Store | 5 | en | 6 Overwhelmed | not said |
| 662 | `11637832` | App Store | 5 | en | 2 Lose time | not said |
| 666 | `11639547` | App Store | 5 | en | 5 Forget steps and small habits | not said |
| 667 | `11659235` | App Store | 5 | en | 3 Mornings go badly; 5 Forget steps and small habits; 6 Overwhelmed | not said |
| 673 | `11660750` | App Store | 5 | en | State only a goal | not said |
| 676 | `11641777` | App Store | 5 | en | 2 Lose time; 3 Mornings go badly | not said |
| 677 | `a79a61cb` | Play | 5 | es | State only a goal | not said |
| 678 | `b1bdfedc` | Play | 5 | en | 2 Lose time; 5 Forget steps and small habits | not said |
| 680 | `73e7022d` | Play | 5 | en | 1 ADHD and similar; 2 Lose time | not said |
| 682 | `11664618` | App Store | 5 | en | State only a goal | not said |
| 685 | `11666847` | App Store | 5 | pl | State only a goal | not said |
| 690 | `11647546` | App Store | 5 | ko | State only a goal | not said |
| 692 | `9da8248b` | Play | 2 | ko | State only a goal | paid |
| 697 | `11653671` | App Store | 5 | en | 4 Can't start or keep going | not said |
| 699 | `11659001` | App Store | 5 | en | State only a goal | not said |
| 713 | `11677822` | App Store | 3 | en | 1 ADHD and similar; 4 Can't start or keep going | not said |
| 715 | `11689246` | App Store | 5 | en | State only a goal | free |
| 718 | `11679415` | App Store | 5 | en | 2 Lose time; 3 Mornings go badly | not said |
| 730 | `11694417` | App Store | 5 | en | State only a goal | not said |
| 734 | `11683538` | App Store | 5 | en | 1 ADHD and similar; 2 Lose time | not said |
| 739 | `11685689` | App Store | 5 | en | State only a goal | not said |
| 741 | `11685886` | App Store | 5 | en | 6 Overwhelmed | not said |
| 745 | `11702243` | App Store | 5 | ko | 4 Can't start or keep going | not said |
| 750 | `a3304c50` | Play | 5 | en | 4 Can't start or keep going | not said |
| 757 | `11717198` | App Store | 1 | en | State only a goal | not said |
| 774 | `11709753` | App Store | 5 | en | 4 Can't start or keep going | not said |
| 783 | `11732991` | App Store | 2 | de | 7 Tried other apps, planners or paper | not said |
| 786 | `11733654` | App Store | 5 | fr | State only a goal | not said |
| 794 | `11709741` | App Store | 5 | ko | State only a goal | not said |
| 795 | `11709836` | App Store | 5 | en | State only a goal | not said |
| 796 | `a912e07a` | Play | 1 | ko | 5 Forget steps and small habits | paid |
| 798 | `11719943` | App Store | 5 | en | State only a goal | not said |
| 804 | `11745385` | App Store | 4 | en | 1 ADHD and similar; 3 Mornings go badly; 9 Parents and carers | not said |
| 812 | `11757564` | App Store | 5 | ko | 4 Can't start or keep going | not said |
| 818 | `50729a50` | Play | 5 | en | 1 ADHD and similar | not said |
| 826 | `11767295` | App Store | 5 | en | State only a goal | not said |
| 827 | `409a257f` | Play | 5 | en | 1 ADHD and similar; 2 Lose time | not said |
| 830 | `11776189` | App Store | 5 | ko | 1 ADHD and similar | not said |
| 840 | `11794324` | App Store | 5 | en | 2 Lose time | not said |
| 851 | `11897932` | App Store | 5 | ko | 2 Lose time; 3 Mornings go badly | not said |
| 853 | `57b505e3` | Play | 5 | en | 4 Can't start or keep going | not said |
| 863 | `11908206` | App Store | 5 | en | 1 ADHD and similar; 3 Mornings go badly | not said |
| 867 | `11909065` | App Store | 5 | nl | 5 Forget steps and small habits | free |
| 871 | `11866462` | App Store | 5 | en | State only a goal | not said |
| 880 | `11882203` | App Store | 5 | en | 1 ADHD and similar; 2 Lose time; 3 Mornings go badly | free |
| 882 | `11883196` | App Store | 5 | en | 1 ADHD and similar | not said |
| 883 | `10a0d5b1` | Play | 3 | ja | 5 Forget steps and small habits | paid |
| 887 | `4bb8ebad` | Play | 5 | en | 2 Lose time | not said |
| 893 | `7baa46e7` | Play | 4 | en | 1 ADHD and similar | not said |
| 897 | `11903518` | App Store | 1 | da | State only a goal | paid |
| 898 | `11905618` | App Store | 5 | en | 1 ADHD and similar | not said |
| 904 | `d019a8e7` | Play | 5 | en | 4 Can't start or keep going | not said |
| 906 | `11925826` | App Store | 5 | en | 3 Mornings go badly | not said |
| 914 | `af2fe9dd` | Play | 4 | en | 1 ADHD and similar | paid |
| 921 | `11940737` | App Store | 5 | en | 1 ADHD and similar | not said |
| 924 | `11944681` | App Store | 5 | en | 2 Lose time | not said |
| 926 | `b76a8397` | Play | 4 | pt-BR | 7 Tried other apps, planners or paper | not said |
| 928 | `11980639` | App Store | 5 | en | 1 ADHD and similar | not said |
| 929 | `1a9ff4a6` | Play | 5 | en | 7 Tried other apps, planners or paper | free |
| 930 | `11980662` | App Store | 5 | ko | 4 Can't start or keep going | paid |
| 931 | `814268fb` | Play | 5 | fr | 1 ADHD and similar; 7 Tried other apps, planners or paper | not said |
| 934 | `11962137` | App Store | 5 | en | 7 Tried other apps, planners or paper | not said |
| 941 | `11994505` | App Store | 5 | en | 1 ADHD and similar; 2 Lose time | not said |
| 942 | `56d4d093` | Play | 5 | en | State only a goal | not said |
| 946 | `11973358` | App Store | 5 | en | 1 ADHD and similar | not said |
| 947 | `11984464` | App Store | 1 | en | 1 ADHD and similar | not said |
| 948 | `11994197` | App Store | 5 | en | 1 ADHD and similar; 2 Lose time; 3 Mornings go badly | not said |
| 949 | `bbb32e3c` | Play | 5 | en | 1 ADHD and similar; 2 Lose time; 7 Tried other apps, planners or paper | not said |
| 950 | `11999946` | App Store | 5 | en | State only a goal | not said |
| 968 | `12032917` | App Store | 5 | en | 1 ADHD and similar; 4 Can't start or keep going | not said |
| 970 | `12106328` | App Store | 5 | en | 5 Forget steps and small habits | not said |
| 975 | `12047448` | App Store | 5 | en | 1 ADHD and similar; 5 Forget steps and small habits | not said |
| 981 | `12114097` | App Store | 5 | ko | 3 Mornings go badly | not said |
| 987 | `12117455` | App Store | 5 | en | 1 ADHD and similar; 2 Lose time | not said |
| 988 | `12077111` | App Store | 5 | en | 3 Mornings go badly | not said |
| 997 | `12069182` | App Store | 2 | en | 2 Lose time | not said |
| 999 | `12091775` | App Store | 5 | es | 2 Lose time; 5 Forget steps and small habits | not said |
| 1001 | `12119158` | App Store | 5 | en | State only a goal | not said |
| 1002 | `12119991` | App Store | 5 | en | 1 ADHD and similar; 6 Overwhelmed | not said |

176 people: 132 in at least one pain-point group, 44 with a goal only. Checked: every ID in this report is in `Review Labels/Routinery/2024/reviews.jsonl`.
