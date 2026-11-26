# Routinery 2026: User Groups, Why They Use It, and What They Pay For

Written by Claude (Claude Code), 26 November 2026, at the user's request.

**What this is.** Routinery's target users as its 2026 reviews show them, the way UX user research describes them:
the groups of people who use it, each defined by the **pain point** that brought them; why each group uses it; whether
each group pays, how many, and for what; and which free features each group likes. The eighth and last year of a
series ([2019](<Routinery 2019 — User Groups, Why They Use It, and What They Pay For.md>),
[2020](<Routinery 2020 — User Groups, Why They Use It, and What They Pay For.md>),
[2021](<Routinery 2021 — User Groups, Why They Use It, and What They Pay For.md>),
[2022](<Routinery 2022 — User Groups, Why They Use It, and What They Pay For.md>),
[2023](<Routinery 2023 — User Groups, Why They Use It, and What They Pay For.md>),
[2024](<Routinery 2024 — User Groups, Why They Use It, and What They Pay For.md>),
[2025](<Routinery 2025 — User Groups, Why They Use It, and What They Pay For.md>)).

**A part year.** The reviews were collected on 8 September 2026, so 2026 runs from 1 January to 7 September (about
eight months; September holds only 34 reviews). **Compare shares with earlier years, not counts.**

**How it was done.** From the reviews alone, as research for a new product or a full rebuild. No product of ours, its
features or its code was used to choose, read or group anything.

**Source.** The checked labels for all 958 reviews of 2026 in `Review Labels/Routinery/2026/labels.jsonl`, the same
way as 2020–2025:

- **Groups:** from `who` and `why_chose`. I read all 271 reviews that have either and put each person in the group(s)
  their own words describe. One person can be in more than one group. No new group was needed this year. One person
  posted the same review twice on 15 July (lines 793 and 794); they are counted once.
- **Features liked:** from `liked` and `chose_for`, sorted into the same kinds as the earlier years.
- **Paying:** from `paid` and its reason, plus the price and premium complaints in `problems`. Every payer, every
  unexpected charge, every refusal and every routine-limit mention was sorted by hand.

Review IDs are shortened to their first 8 characters; the appendix maps every group member to its line in the labels
file. The map is saved as [`Tools/groups_2026.py`](<Tools/groups_2026.py>); [README.md](<README.md>) explains the method.

---

## The short answer

- **958 reviews to 7 September** (508 App Store, 450 Google Play), average **4.20★, the best since 2021**, with 97 1★
  (10%). **156 people (16%) name a pain point**, the highest share of any year; 64 more name only a goal.
- **The same core as 2024 and 2025.** People with ADHD and similar conditions are still the biggest group (38%), then
  people who lose time (26%) and **people who can't start (24%, back up from 17–19%)**. Several ADHD reviewers name
  **decision paralysis** and **task-initiation paralysis** as the problem the app solves.

| # | User group (the pain point) | People | Share of the 156 | ★ | Paid or trial | 2025 share |
|---|---|---|---|---|---|---|
| 1 | **Have ADHD, autism, executive dysfunction, depression, anxiety, bipolar disorder or PTSD** | 60 | **38%** | 4.68 | 6 | 41% |
| 2 | **Lose time:** time blindness, chronically late, distracted (the phone, shorts, Instagram) | 41 | 26% | 4.66 | 3 | 32% |
| 3 | **Can't start or keep going:** procrastination loops, decision paralysis, lethargy | 37 | **24%** | 4.89 | 2 | 19% |
| 4 | **Mornings go badly:** can't wake up, rushing before work or school, late | 27 | 17% | 4.78 | 0 | 17% |
| 5 | **Forget steps and small habits** (self-care, "anything without writing it down") | 14 | 9% | 4.64 | 1 | 11% |
| 6 | **Tried other apps; nothing stuck** (paper, Excel, alarm clocks, Reminders, other routine apps) | 14 | 9% | 4.79 | 0 | 10% |
| 7 | **Overwhelmed:** too much to keep straight, three businesses, "everything life brings" | 11 | 7% | 4.55 | 1 | 7% |
| 8 | **Parents and carers**, often running a child's routine | 7 | 4% | 5.00 | 0 | 5% |
| 9 | **Lost their structure:** burnout, a bipolar crash, a grandmother's death | 3 | 2% | 5.00 | 0 | 3% |
| 10 | **Follow a method** (Atomic Habits, The Miracle Morning) | 2 | 1% | 4.50 | 0 | 1% |

  (47 people are in more than one group.)

- **Why they use it:** unchanged since 2019. The app **decides the next step and times it**: *"No more decision
  paralysis!"*, *"Nothing helps my ADHD time blindness more"*, *"I struggle with paralyzing executive function"*.
- **Paying is healthier than in 2023–2025.** 37 people (3.9%) say they paid; **21 give a reason** (13 the whole app, 3
  the price, 2 a feature, 2 a promotion, 1 after years free), and **3 bought a lifetime plan**, the first lifetime
  purchases in the reviews. Payers average **3.08★** (2.89★ in 2025), and 17 of 37 report a bug (47 of 75 in 2025).
- **But payers are now nagged:** asked to buy a year they already have at 60% off, a full-screen "change your
  subscription" after a price rise, a warning that premium features are going away unless they buy again, and ads.
  **AI features** are a new dislike (8 reviews: *"please don't ruin it with AI"*, a fortune-telling feature).
- **The free trial is still the trap.** 14 say they were charged unexpectedly, 9 of them by a 7-day trial, and the trial
  is again the top reason to refuse (6 of 15).
- **The paywall is still the third routine**, mentioned about 28 times: 26 want more, usually **just one more** (for
  weekends, or weekday and weekend mornings), 2 say two are enough.
- **Korean reviewers pay most again:** 14.1% of Korean reviews say they paid, against 3.2% of English and 3.7% of
  Japanese ones. **Spanish is now the second language** (71 reviews, ahead of Korean's 64).
- **Free features liked:** simple and clean (88), **a timer on every step (61)**, the look (54), encouraging words (31),
  reminders (25), **a responsive developer (25)**.

---

## 1. The year in numbers

| | Count | Share of 958 |
|---|---|---|
| Reviews (1 January – 7 September) | 958 | 100% |
| App Store / Google Play | 508 / 450 | 53% / 47% |
| Language: English, Spanish, Korean, Japanese, Portuguese (Brazil), Portuguese, French, German, other | 648, 71, 64, 54, 21, 21, 20, 17, 42 | 68%, 7%, 7%, 6%, 2%, 2%, 2%, 2%, 4% |
| Ratings 5★ / 4★ / 3★ / 2★ / 1★ | 620 / 146 / 54 / 41 / 97 | 65% / 15% / 6% / 4% / 10% |
| Say who they are (`who`) | 170 | 18% |
| Say why they came (`why_chose`) | 206 | 22% |
| Name a pain point (any group below) | **156** | **16%** |
| Name only a goal | 64 | 7% |
| Name a feature they like | 480 | 50% |
| Say anything about paying | 91 | 9% |
| Report something broken | 159 | **17%** |
| Nothing useful ("great app") | 120 | 13% |

The most reviews came in January (159), the fewest in June (84). **Bugs are reported least since 2021** (17%, from a
peak of 30% in 2024).

**How they found it:** YouTube (*"A YouTube video I was watching suggested the app"*, `14104903`; also `13610671`,
`13800444`, `13821749`), TikTok (*"la encontré por tiktok"*, "I found it on TikTok",
`14497946`), social media (`14070027`), friends and good reviews.

---

## 2. The user groups

### Group 1. Have ADHD, autism, executive dysfunction, depression, anxiety, bipolar disorder or PTSD (60 people, 38%, 4.68★)

**Who they are:** ADHD or ADD (49, with AuDHD), autism or executive dysfunction (4), depression, anxiety, bipolar
disorder, PTSD, multiple sclerosis or burnout (13). A 60-year-old with AuDHD, people not yet diagnosed
(*"저는 진단받지는 않았지만 ADHD로 보이는 생활패턴을 가지고있은데"*, "I'm not diagnosed, but my life pattern looks like
ADHD"), a homeschooling mother with ADHD, a mother getting *"kids with ADHD out the door in the mornings"*. 33 are
only in this group. The highest rating this group has had (4.68★).

**Why they use it:**
- *"When I am struggling with decision paralysis"* (`270296bc`, en, 5★).
- *"I struggle with paralyzing executive function"* (`14049946`, en, 5★, a lifetime payer).
- *"Nothing helps my ADHD time blindness more"* (`14223005`, en, 5★).
- *"i have so much ADHD its painful"* (`13910877`, en, 5★).
- *"I struggle with time blindness (losing track of time)"*, with multiple sclerosis, depression and anxiety
  (`13641280`, en, 5★).
- *"makes it extremely challenging to think clearly and perform well"*, ADHD and PTSD (`13628302`, en, 4★).
- *"I’ve been on a depression episode for months"* (`13924719`, en, 5★).
- *"ADHDでルーティンを維持するのが難しく、このアプリをダウンロードしました"*, "with ADHD it's hard to keep a routine,
  so I downloaded this app" (`9a937167`, ja, 5★).
- *"promete solucionarme mi mayor problema cono persona con tdah"*, "it promises to solve my biggest problem as a person
  with ADHD" (`81539a39`, es, 5★).
- *"I have used every app for routines to help my ADHD"* (`905e7041`, en, 5★).
- *"Something that is incredibly important for me is routine, consistency, regularity"*, after a bipolar crash
  (`14168412`, en, 5★).

**Free features they like** (53 of 60): **the timer on every step (14)**, encouraging words (7), pause, skip or add
time (6), reminders (6), simple (6), **a responsive developer (6)**, seeing how long things take (5).

**Paying:** 6 paid, 2 free, none refused. A lifetime plan from someone who struggles *"with paralyzing executive function"* (`14049946`);
*"with the premium I can make multiple routines for the same time of day"* (`5067cc9c`); the Apple Watch timer,
*"スマホを触らずにタイマーが使えて"*, "I can use the timer without touching my phone" (`13786020`); a newly paying
not-yet-diagnosed user (`14022461`); someone who uses the going-out routine (`14025409`); and *"merece totalmente la pena"*, "totally worth
it", from someone with depression and anxiety who found it on TikTok (`14497946`).

### Group 2. Lose time (41 people, 26%, 4.66★)

**Who they are:** people with time blindness, the chronically late, people pulled away by their phone. 20 are only in
this group.
- *"in the world that’s constantly trying to get my attention to go the wrong way"* (`13626272`, en, 5★).
- *"手書きだとつい脱線して、気づけば数時間"*, "planning by hand I drift off, and before I know it hours have gone"
  (`57369711`, ja, 5★).
- *"As someone who runs chronically late"* (`14221322`, en, 5★).
- *"this is what life without time blindness looks like"* (`14053874`, en, 5★).
- *"딴짓하느라 느려지는 습관이 잇엇는데"*, "I had a habit of slowing down by doing other things" (`14372695`, ko, 5★).
- *"Siempre tuve mala percepción del tiempo a la hora de prepararme para salir o acostarme"*, "I always had a poor sense
  of time when getting ready to go out or go to bed" (`81aa4e6c`, es, 5★).
- *"Non arrivo più in ritardo!"*, "I'm not late any more!" (`14497138`, it, 5★).
- *"i went from being half an hour late to things"* (`13976478`, en, 5★, a payer).

**Free features they like** (39 of 41): **the timer (15: the most of any group)**, seeing how long things take (5),
reminders (5), simple (5), a responsive developer (4). **Paying:** 3 paid (`13643916`, who loves it and can't do
without it; *"very worth it for me because of how helpful"* it is, `13976478`; the Apple Watch timer, `13786020`), 3 free.

### Group 3. Can't start or keep going (37 people, 24%, 4.89★)

Back up from 17% in 2024. The highest-rated large group again.
- *"I have been stuck in a constant loop of procrastination for years"* (`13814341`, en, 5★).
- *"No more decision paralysis!"* (`14055829`, en, 5★).
- *"I can’t get anything done if I don’t have a routine but I can’t follow routines by myself"* (`13863453`, en, 5★).
- *"After creating but flaking on my routines for years, this gives structure + accountability"* (`5311ff75`, en, 4★).
- *"무기력엔 루티너리"*, "for lethargy, Routinery" (`13951907`, ko, 5★).
- *"qui crée des routine mais ne passe pas à l’action comme moi"*, "who creates routines but doesn't take action, like
  me" (`95cd569b`, fr, 5★).
- *"une meuf qui s’en foutait je me levais a 13 h"*, "a girl who didn't care, I used to get up at 1 pm" (`14209934`,
  fr, 5★).

**Free features they like** (34 of 37): **encouraging words (6)**, the timer (5), reminders (5), pause or skip (4).
**Paying:** 2 paid (both also ADHD: `14022461`, `14049946`).

### Group 4. Mornings go badly (27 people, 17%, 4.78★)

- *"出勤前の焦りが毎日本当にストレスで"*, "the rush before work was really stressful every day" (`13703469`, ja, 5★).
- *"전에는 계속 8시에 일어나가지구 맨날 늦었어요"*, "I used to keep waking at 8 and was late every day" (`13939498`, ko,
  5★).
- *"いつもギリギリまで寝てしまうのが自分でも嫌になっていた"*, "I'd come to hate myself for always sleeping until the last
  minute" (`13951712`, ja, 5★).
- *"I went from late arrivals to work"* (`47b9ec74`, en, 5★).
- *"目覚まし時計では起きられない自分"*, "me, who can't wake up with an alarm clock" (`14447685`, ja, 1★).
- *"Can't leave the house on time without it"*, a parent (`45684fda`, en, 5★).

**Free features they like** (26 of 27): reminders (3), seeing how long things take (3), **walked through one step at a
time (3)**, simple (3). **Paying:** none say they paid; 1 free.

### Group 5. Forget steps and small habits (14 people, 9%, 4.64★)

- *"i have a hard time doing literally anything without writing it down"* (`13931174`, en, 5★).
- *"I used to be so forgetful"* (`0fc9df4c`, en, 5★).
- *"ting jeg vanligvis pleier å glemme"*, "things I usually forget" (`14003576`, no, 5★).
- *"i often forget to do things like selfcare"* (`14279579`, en, 4★, ADHD).
- *"That always forced me to remember what I need to do"*, before a change to the alarm (`14371016`, en, 1★, a payer
  who is cancelling).

**Free features they like:** reminders (2), the look (2), encouraging words (2). **Paying:** 1 paid (`14371016`, above).

### Group 6. Tried other apps; nothing stuck (14 people, 9%, 4.79★)

Paper and spreadsheets (*"紙に書いたり、エクセルでチェックしたりしてましたが"*, "I wrote on paper or ticked in Excel",
`13814491`), alarm clocks and Reminders (*"I have tried everything from alarm  clocks  to Reminders"*, `14218890`),
and other routine apps (*"Después de tantas apps de rutinas está me convenció"*, "after so many routine apps, this one
convinced me", `dddc982f`; *"Other apps like this one I found to not hold the accountability that this one does"*,
`14294512`). *"I usually download apps like this, use them for a while, then either decide it’s too much work or forget
about them"* (`14466229`). **Free features they like:** the timer (4), simple (4). **Paying:** none say.

### Group 7. Overwhelmed (11 people, 7%, 4.55★)

- *"overwhelmed by having multiple things to do"* (`13625402`, en, 4★).
- *"in seasons of overwhelm and anxiety"* (`13902004`, en, 5★).
- *"it's hard just planning on your mind"*, with three businesses (`7494b14f`, en, 5★).
- *"para alguien como yo que le abruma la cantidad de cosas que te trae la vida"*, "for someone like me who is
  overwhelmed by everything life brings" (`3bd42107`, es, 4★).

**Free features they like:** **a responsive developer (3)**, the timer (2), walked through (2). **Paying:** 1 paid, to
*"nail down my exercise habit"* (`14459020`); 1 refused (the routine limit and the cost, `14047899`).

### Group 8. Parents and carers (7 people) · Group 9. Lost their structure (3) · Group 10. Follow a method (2)

Parents running a child's routine: *"morgens und abends für meine Kinder benutze"*, "I use it mornings and evenings for
my children" (`4a8d93df`, de); *"my 13 year old"* (`14079774`); *"my daughter was going through a really tough time
taking care of herself"* (`5610f82a`); a daughter with ADHD (`f60cfe0f`). All seven gave 5★; none say they paid. Lost
structure: burnout (`14305701`), a bipolar crash (`14168412`), a grandmother's death and divorced parents
(`14389084`). The methods: Atomic Habits (*"I get to incorporate my own Atomic Habits"*, `13658574`) and The Miracle
Morning (*"미라클 모닝 하는데 큰 도움이 됩니다"*, "it helps a lot with my Miracle Morning", `14408209`).

### People who name only a goal (64 people, 4.48★)

Morning routines, school mornings, gym days, Bible reading and prayer (*"I have read the bible, counted my blessings in
a journal, prayed and read my daily text every single day"*, `14375560`, a lifetime payer), New Year resolutions.
Paying: 5 paid, 3 free, 1 refused, 1 charged unexpectedly.

---

## 3. Paying

### How many pay

| | 2026 (to 7 Sep) | Share of 958 | Share of the 91 who say anything | 2025 | 2024 |
|---|---|---|---|---|---|
| Paid | 37 | 3.9% | 41% | 75 (4.6%) | 46 (4.6%) |
| On a trial | 5 | 0.5% | 5% | 2 | 5 |
| Charged unexpectedly | 14 | 1.5% | 15% | 22 (1.4%) | 22 (2.2%) |
| Refused to pay | 15 | 1.6% | 16% | 33 | 21 |
| Use it free and say so | 20 | 2.1% | 22% | 45 | 28 |
| Don't say | 867 | 91% | — | 1,443 | 888 |

**By group** (paid + trial): ADHD and similar 6 of 60; lose time 3 of 41; can't start 2 of 37; forget and overwhelmed 1
each; mornings, tried everything, parents, lost structure and method 0. **No group pays clearly more than another.**

**By language:** 21 of the 37 payers write in English, 9 in Korean, 3 in German. **14.1% of the 64 Korean reviews say
they paid**, against 3.2% of the 648 English ones and 3.7% of the 54 Japanese ones (12.7% in 2025); 1 of 71 Spanish.
Unexpected charges: 6 English, 5 Korean. Refusals: 9 of 15 in English.

**Payers are more content than in the last three years:** 3.08★ (2.89★, 2.72★, 2.97★ in 2025, 2024, 2023), 14 gave
5★ and 12 gave 1★, and 17 of 37 report something broken.

### Why the payers paid

| Reason | Payers | IDs |
|---|---|---|
| The whole app works for them, or they liked it straight away (*"5 minutes in and I’ve already snagged the lifetime"*; *"This is THE ONE!! I purchased it for life."*) | 13 | `13595999` `13643916` `13661473` `13803638` `13909411` `13935031` `13987336` `14022461` `14025409` `14049946` `e57c903a` `14375560` `14459020` |
| For a feature: the Apple Watch timer; several routines for the same time of day | 2 | `13786020` `5067cc9c` |
| Worth it for the price (*"it’s an affordable price and I feel I’m getting my money’s worth"*) | 3 | `13718226` `13976478` `14497946` |
| After years on the free version (*"I've been using it for 3 years (the free version)"*) | 1 | `13891754` |
| A promotion: a limited discount, a 1+1 offer (both say it wasn't honoured) | 2 | `13684291` `13901606` |
| Regret it, cancelled, can't cancel, or want a refund (*"unsubscribed after 4 years paid"*) | 6 | `13611258` `13628965` `de90c294` `5935dd2a` `9fceb42c` `14371016` |
| No reason; they mention paying only to report a bug, ads, pop-ups, an upsell or AI (*"I ALREADY HAVE A 12 MONTH SUBSCRIPTION STOP ASKING ME TO BOOK A 12 MONTH ONE FOR -60% OFF"*) | 10 | `13679660` `13689381` `afc1f678` `13726548` `fd5fb53c` `14021959` `62309414` `80b44e6f` `14390918` `f3d7faae` |

**21 of 37 give a reason to pay (57%), the best share since 2022.** **Three bought a lifetime plan** (`13987336`
`14049946` `14375560`), the first in eight years of reviews. Only one payer names more routines, and it's a new kind:
several routines for the same time of day. Prices named: $30 a year, $36 a year, 4,000 yen a year.

**Payers nagged to buy again (4):** asked to buy a year they already have at 60% off (`afc1f678`); after a price rise,
*"앱 들어갈때마다 “구독권 변경”하라고 풀 팝업이 뜨는게 말이 됩니까?"*, "does it make sense that a full-screen pop-up
telling me to "change my subscription" appears every time I open the app?" (`13726548`); a warning that *"premium
features are going away soon and you need to make ANOTHER purchase in app"* (`80b44e6f`); banner ads for a new feature
shown to paid users, since fixed (`14049946`). And *"multiple back-to-back, full-screen unskippable, LONG brainrot ads"*
for a payer using one feature (`14021959`).

**Charged unexpectedly (14):**

| What happened | Reviews |
|---|---|
| A 7-day free trial charged at once or became a year | 9: `13610671` `13599626` `13638132` `13878515` `d942080b` `bd09d5e3` `14422666` `14509669` `14515793` |
| An offer that charged early, or an old account that charged a full year on login | 2: `13605567` `13666735` |
| Charged after deleting the app, or renewed early without consent | 2: `1f8d922a` `5129a5f3` |
| An accidental annual purchase (support was kind, the store refused the refund) | 1: `4d4af4ac` |

### What premium holds (from what free users miss and payers name)

| Behind the paywall | Reviews |
|---|---|
| **More than two routines** | about 28 mention it: 26 want more, most **just one more**, often for the weekend (*"平日朝、平日夜、休日朝、休日夜など複数ルーティンを作りたい自分"*, "I want several routines: weekday mornings, weekday nights, weekend mornings, weekend nights"), 2 say two are enough |
| Icons, widgets | 2 each |
| A daily task without a time (`bbfeef7c`) | 1 |

Ads are mentioned 6 times (20 in 2025), 4 of them by payers.

### Why others won't pay

The 15 who refuse:

| Objection | Refusals | IDs |
|---|---|---|
| **The trial** (the auto-charge after a week, a card up front, yearly billing hidden in it, too short) | 6 | `5293da37` `e546587a` `13799067` `14086661` `14168205` `5ffac395` |
| Too expensive or no money (4,000 yen a year, "30 bucks a month when it was free") | 5 | `13835212` `13863035` `6f51db3f` `33ec0f20` `46181634` |
| Routines or basic features behind a subscription | 4 | `bbfeef7c` `3fc8d71f` `14047899` `14307800` |

*"1週間で解約しなければ自動有料とか、こわくて使えない"*, "auto-paid unless I cancel within a week? Too scary to use"
(`5293da37`): fear of the trial heads the list in 2025 and 2026 alike.

---

## 4. Free features people like

Across all 958 reviews, 480 (50%) name something they like:

| Feature | Reviews | Groups that name it most |
|---|---|---|
| Simple, clean, easy | 88 | Goal only (10), ADHD and similar (6), lose time (5) |
| **A timer on every step** | 61 | **Lose time (15)**, ADHD and similar (14), goal only (12), can't start (5) |
| The look: design, cute icons | 54 | Goal only (4) |
| Encouraging words, the voice | 31 | ADHD and similar (7), can't start (6) |
| Reminders and alerts | 25 | ADHD and similar (6), lose time (5), can't start (5) |
| **A responsive developer** | 25 | ADHD and similar (6), lose time (4), overwhelmed (3) |
| Seeing how long things take, stats | 14 | ADHD and similar (5), lose time (5) |
| Pause, skip or add time | 13 | ADHD and similar (6), can't start (4) |
| Walked through one step at a time | 12 | Mornings (3) |
| The free version is enough | 11 | — |

**Per group:** the timer leads for people who lose time and people with ADHD; encouragement and reminders for those who
can't start. A responsive developer is now the sixth most-liked feature, named as often as reminders (25 each).

**What people dislike that is new:** **AI features** (8: *"the use of AI has tipped me over to uninstalling"*,
`ba4631db`; *"운세라니 최악 입니다"*, "a fortune-telling feature, the worst", `14022962`; AI behind binary gender
options, `5067cc9c`; *"pushing AI gimmicks like fortunes"*, `9fceb42c`; `86620034` `62309414` `14279579` `14264972`),
and the upsells to payers above. Social features, a dislike in 2025, are almost gone from the complaints (1).

---

## 5. Who they say they are

From `who` (170 people say something), with the keyword traps fixed by hand:

| They say they are | People | 2025 | 2024 |
|---|---|---|---|
| **ADHD or ADD** (AuDHD included) | 49 | 81 | 46 |
| Student | 19 | 32 | 10 |
| Working (a therapist, a coach, the self-employed, three businesses) | 15 | 39 | 12 |
| Depression, anxiety, bipolar disorder, PTSD, burnout | 13 | 11 | 8 |
| Smartwatch user (Apple Watch, Galaxy Watch, Garmin) | 10 | 35 | 36 |
| Parent | 7 | 13 | 5 |
| Children and minors (a fourth grader, an 11-year-old, a teenager, under 16, "a kid") | 5 | 7 | 4 |
| Autism, executive dysfunction | 4 | 11 | 4 |
| Procrastinator, lazy | 4 | 3 | 4 |
| iPad or tablet user | 3 | 6 | 6 |
| Short of money, or not allowed to buy | 2 | 3 | 1 |

(Counts are for eight months; the shares of the 156 are the fairer comparison.) **The watch** is mentioned far less: 15
reviews, 7 broken, 7 liked.

---

## 6. What changed, over eight years

| | 2019 | 2020 | 2021 | 2022 | 2023 | 2024 | 2025 | 2026* |
|---|---|---|---|---|---|---|---|---|
| Reviews | 11 | 1,122 | 1,626 | 1,534 | 1,763 | 1,010 | 1,620 | 958 |
| Name a pain point | 3 | 166 | 200 | 205 | 177 | 132 | 237 | 156 |
| Share naming a pain point | 27% | 15% | 12% | 13% | 10% | 13% | 15% | **16%** |
| Biggest group | Mornings | Mornings (31%) | Can't start, tried everything (28%) | ADHD and similar (45%) | ADHD and similar (30%) | ADHD and similar (42%) | ADHD and similar (41%) | **ADHD and similar (38%)** |
| ADHD and similar, share | — | 15% | 24% | 45% | 30% | 42% | 41% | 38% |
| Lose time | — | 24% | 21% | 20% | 23% | 33% | 32% | 26% |
| Can't start | — | 27% | 28% | 28% | 28% | 17% | 19% | 24% |
| Mornings | 2 of 3 | 31% | 19% | 10% | 19% | 21% | 17% | 17% |
| Said they paid | none | 2.2% | 3.9% | 4.9% | 4.0% | 4.6% | 4.6% | 3.9% |
| Payers giving a reason | — | — | — | 47 of 75 | 32 of 71 | 10 of 46 | 29 of 75 | **21 of 37** |
| Payers' average rating | — | — | — | 3.91 | 2.97 | 2.72 | 2.89 | 3.08 |
| Charged unexpectedly | — | 2 | 4 | 6 | 20 | 22 | 22 | 14 |
| Report something broken | 18% | 11% | 14% | 20% | 25% | 30% | 23% | **17%** |
| Average rating | 3.55 | 4.33 | 4.29 | 4.18 | 3.96 | 3.90 | 4.06 | **4.20** |

\* 1 January – 7 September 2026.

**Eight years in one paragraph.** The pains never changed: people use Routinery because it **walks them through a
routine one step at a time with a timer**, so they don't have to remember, decide, watch the clock or find willpower.
What changed is **who**: from people whose mornings went badly (2020) to people with ADHD and time blindness (2022
onward). Paying followed the app's quality: payers were happy in 2022, wrote mostly about bugs and refunds in
2023–2024, and recovered in 2025–2026 as bugs fell, while the friction moved to the free trial, ads, upsells and AI.
The free plan's limit stayed the same thing throughout: **two routines, when people want three**.

---

## 7. Limits

- **A part year.** Eight months and a week; counts are lower than full years, so compare shares.
- **84% don't name a pain point,** so the groups describe the 156 who do; the order is more reliable than the exact
  sizes.
- **`who` (170) and `why_chose` (206)** are read together for every person, as in 2023–2025; goal-only counts (64)
  don't compare with 2022 and earlier.
- **Paying is said by 9%.** Group paying rates rest on 0–6 people.
- **The routine-limit count is approximate** (about 28), sorted by hand.
- **One duplicate review** (lines 793 and 794, the same person on the same day) is counted once in the groups; both
  stay in the year's totals in section 1.
- **Feature kinds are sorted by their words**, as in 2023–2025.

---

## Appendix: every group member

`Line` is the review's line in `Review Labels/Routinery/2026/labels.jsonl`; `ID` is the first 8 characters of its
review ID.


| Line | ID | Store | ★ | Language | Groups | Paid |
|---|---|---|---|---|---|---|
| 16 | `270296bc` | Play | 5 | en | 1 ADHD and similar; 3 Can't start or keep going | not said |
| 22 | `13587263` | App Store | 5 | en | 1 ADHD and similar | not said |
| 24 | `13587312` | App Store | 5 | en | 3 Can't start or keep going | not said |
| 29 | `2d3dfc0a` | Play | 5 | en | State only a goal | not said |
| 34 | `ddb15b30` | Play | 5 | en | State only a goal | free |
| 44 | `13595999` | App Store | 5 | ko | State only a goal | paid |
| 50 | `13583538` | App Store | 5 | en | 3 Can't start or keep going; 4 Mornings go badly | not said |
| 75 | `13623525` | App Store | 4 | en | State only a goal | not said |
| 77 | `13641280` | App Store | 5 | en | 1 ADHD and similar; 2 Lose time; 3 Can't start or keep going | not said |
| 78 | `13624963` | App Store | 5 | en | 1 ADHD and similar; 4 Mornings go badly; 8 Parents and carers | not said |
| 80 | `13625006` | App Store | 5 | en | State only a goal | not said |
| 81 | `13625402` | App Store | 4 | en | 2 Lose time; 7 Overwhelmed | not said |
| 82 | `13643916` | App Store | 5 | ja | 2 Lose time | paid |
| 84 | `13626272` | App Store | 5 | en | 2 Lose time | not said |
| 86 | `13628302` | App Store | 4 | en | 1 ADHD and similar | not said |
| 88 | `13645079` | App Store | 2 | en | State only a goal | not said |
| 96 | `13650428` | App Store | 5 | en | State only a goal | not said |
| 97 | `13651168` | App Store | 5 | en | State only a goal | not said |
| 98 | `5610f82a` | Play | 5 | en | 8 Parents and carers | not said |
| 99 | `13636693` | App Store | 5 | en | State only a goal | not said |
| 105 | `57757546` | Play | 5 | pt-BR | 2 Lose time; 6 Tried other apps, planners or paper | not said |
| 107 | `cbe5389f` | Play | 5 | en | 1 ADHD and similar; 8 Parents and carers | not said |
| 112 | `13656133` | App Store | 5 | en | 2 Lose time; 5 Forget steps and small habits | not said |
| 118 | `13658574` | App Store | 4 | en | 10 Follow a method | not said |
| 119 | `13679660` | App Store | 3 | en | State only a goal | paid |
| 120 | `13660740` | App Store | 5 | en | 1 ADHD and similar; 3 Can't start or keep going; 4 Mornings go badly | not said |
| 131 | `13682992` | App Store | 4 | ja | 2 Lose time; 4 Mornings go badly | not said |
| 132 | `13666750` | App Store | 5 | en | State only a goal | free |
| 138 | `13686048` | App Store | 5 | en | 1 ADHD and similar; 3 Can't start or keep going | not said |
| 140 | `13687325` | App Store | 5 | en | State only a goal | not said |
| 144 | `842178d7` | Play | 5 | fr | State only a goal | not said |
| 148 | `13661473` | App Store | 4 | en | State only a goal | paid |
| 150 | `13666735` | App Store | 1 | en | State only a goal | charged unexpectedly |
| 152 | `225b6f84` | Play | 5 | en | State only a goal | not said |
| 153 | `c6653a22` | Play | 5 | en | 1 ADHD and similar; 2 Lose time; 5 Forget steps and small habits | not said |
| 154 | `13709979` | App Store | 5 | en | 2 Lose time; 6 Tried other apps, planners or paper | not said |
| 166 | `13698824` | App Store | 5 | en | 2 Lose time; 5 Forget steps and small habits | not said |
| 171 | `8e5dce11` | Play | 5 | ja | 3 Can't start or keep going | not said |
| 183 | `13703469` | App Store | 5 | ja | 4 Mornings go badly | not said |
| 184 | `4a7cdcfe` | Play | 5 | en | 4 Mornings go badly | not said |
| 194 | `fdb572cc` | Play | 5 | en | State only a goal | not said |
| 198 | `13714159` | App Store | 3 | en | 1 ADHD and similar | not said |
| 199 | `13716342` | App Store | 5 | en | 4 Mornings go badly | not said |
| 201 | `13744676` | App Store | 5 | en | 3 Can't start or keep going; 4 Mornings go badly | not said |
| 207 | `13748753` | App Store | 5 | en | 1 ADHD and similar | not said |
| 208 | `13726795` | App Store | 5 | en | 1 ADHD and similar | not said |
| 218 | `3b7aefed` | Play | 5 | en | 3 Can't start or keep going | not said |
| 220 | `13728659` | App Store | 5 | en | State only a goal | not said |
| 226 | `13756829` | App Store | 4 | fr | State only a goal | not said |
| 227 | `13730328` | App Store | 5 | en | State only a goal | not said |
| 238 | `13763004` | App Store | 5 | es | 1 ADHD and similar | free |
| 244 | `08f931bc` | Play | 1 | en | 2 Lose time | not said |
| 245 | `13743292` | App Store | 5 | en | 6 Tried other apps, planners or paper | not said |
| 250 | `13757445` | App Store | 5 | en | 3 Can't start or keep going | not said |
| 262 | `13796939` | App Store | 5 | en | State only a goal | not said |
| 264 | `c7dd92ee` | Play | 4 | en | 6 Tried other apps, planners or paper | not said |
| 267 | `13779626` | App Store | 5 | en | 2 Lose time | not said |
| 279 | `13803638` | App Store | 4 | en | State only a goal | paid |
| 281 | `13786020` | App Store | 2 | ja | 1 ADHD and similar; 2 Lose time | paid |
| 287 | `13786373` | App Store | 5 | en | 1 ADHD and similar | not said |
| 288 | `81539a39` | Play | 5 | es | 1 ADHD and similar | not said |
| 306 | `6a113d86` | Play | 5 | en | State only a goal | not said |
| 307 | `13814341` | App Store | 5 | en | 3 Can't start or keep going | not said |
| 312 | `13814491` | App Store | 5 | ja | 6 Tried other apps, planners or paper | not said |
| 319 | `c12199cb` | Play | 5 | pt-BR | State only a goal | not said |
| 333 | `8b59e469` | Play | 5 | en | 2 Lose time; 4 Mornings go badly | not said |
| 336 | `85e2ed49` | Play | 4 | ja | State only a goal | not said |
| 351 | `13863035` | App Store | 1 | ja | State only a goal | refused |
| 355 | `13863453` | App Store | 5 | en | 3 Can't start or keep going; 7 Overwhelmed | not said |
| 357 | `70a1a072` | Play | 4 | en | State only a goal | not said |
| 361 | `5311ff75` | Play | 4 | en | 3 Can't start or keep going | not said |
| 365 | `13848425` | App Store | 5 | en | 5 Forget steps and small habits | not said |
| 367 | `13868494` | App Store | 5 | en | 1 ADHD and similar | not said |
| 376 | `13856956` | App Store | 5 | en | State only a goal | not said |
| 380 | `7a09213d` | Play | 5 | en | State only a goal | not said |
| 382 | `13875005` | App Store | 5 | ja | State only a goal | free |
| 384 | `13875347` | App Store | 5 | en | State only a goal | not said |
| 389 | `13862199` | App Store | 1 | en | State only a goal | not said |
| 392 | `13845796` | App Store | 1 | en | State only a goal | not said |
| 393 | `13847349` | App Store | 4 | en | 3 Can't start or keep going | not said |
| 395 | `4e1d6a78` | Play | 5 | en | 2 Lose time | not said |
| 396 | `55c613b3` | Play | 5 | en | 3 Can't start or keep going | not said |
| 397 | `57369711` | Play | 5 | ja | 2 Lose time | not said |
| 398 | `ae5ec522` | Play | 5 | en | 3 Can't start or keep going | not said |
| 402 | `13910877` | App Store | 5 | en | 1 ADHD and similar | not said |
| 403 | `ee0a3a73` | Play | 4 | en | 1 ADHD and similar | not said |
| 406 | `13890701` | App Store | 5 | ja | 4 Mornings go badly | not said |
| 421 | `13924719` | App Store | 5 | en | 1 ADHD and similar | not said |
| 426 | `13931174` | App Store | 5 | en | 5 Forget steps and small habits | not said |
| 427 | `13901529` | App Store | 5 | ko | 1 ADHD and similar | not said |
| 432 | `13934372` | App Store | 5 | ko | 3 Can't start or keep going | not said |
| 433 | `13902004` | App Store | 5 | en | 1 ADHD and similar; 7 Overwhelmed | not said |
| 436 | `9167e99f` | Play | 5 | en | State only a goal | not said |
| 441 | `13939498` | App Store | 5 | ko | 4 Mornings go badly | not said |
| 445 | `f5616b85` | Play | 5 | es | 2 Lose time; 5 Forget steps and small habits; 6 Tried other apps, planners or paper | not said |
| 447 | `13916284` | App Store | 5 | en | 2 Lose time; 4 Mornings go badly | free |
| 450 | `13938213` | App Store | 5 | en | 1 ADHD and similar | not said |
| 452 | `13942902` | App Store | 5 | en | State only a goal | not said |
| 457 | `13976478` | App Store | 5 | en | 2 Lose time | paid |
| 459 | `47b9ec74` | Play | 5 | en | 4 Mornings go badly | not said |
| 469 | `13951907` | App Store | 5 | ko | 3 Can't start or keep going | not said |
| 479 | `13984125` | App Store | 5 | en | 4 Mornings go badly | not said |
| 480 | `1976eb5f` | Play | 5 | en | 2 Lose time | not said |
| 490 | `13987364` | App Store | 4 | en | 4 Mornings go badly | not said |
| 493 | `13964403` | App Store | 5 | en | State only a goal | not said |
| 494 | `13951712` | App Store | 5 | ja | 4 Mornings go badly | not said |
| 496 | `13967822` | App Store | 4 | en | State only a goal | not said |
| 497 | `13976561` | App Store | 5 | en | 1 ADHD and similar | not said |
| 499 | `4a8d93df` | Play | 5 | de | 8 Parents and carers | not said |
| 502 | `14019554` | App Store | 5 | en | State only a goal | not said |
| 505 | `3208425d` | Play | 5 | en | 1 ADHD and similar | not said |
| 511 | `14022461` | App Store | 5 | en | 1 ADHD and similar; 3 Can't start or keep going | paid |
| 515 | `14025409` | App Store | 5 | ko | 1 ADHD and similar | paid |
| 516 | `14003576` | App Store | 5 | no | 5 Forget steps and small habits | not said |
| 520 | `b51e1a90` | Play | 2 | en | State only a goal | not said |
| 522 | `14005587` | App Store | 4 | pt-BR | 1 ADHD and similar | not said |
| 531 | `14029572` | App Store | 4 | en | 2 Lose time | not said |
| 532 | `14015256` | App Store | 5 | ko | 3 Can't start or keep going | not said |
| 541 | `e9f150a0` | Play | 5 | en | 7 Overwhelmed | not said |
| 543 | `14033978` | App Store | 4 | en | 1 ADHD and similar | not said |
| 551 | `14034438` | App Store | 5 | ja | 1 ADHD and similar; 3 Can't start or keep going; 6 Tried other apps, planners or paper | not said |
| 555 | `14034857` | App Store | 5 | en | 2 Lose time | not said |
| 563 | `70e5d07d` | Play | 2 | pt-BR | 1 ADHD and similar | not said |
| 568 | `905e7041` | Play | 5 | en | 1 ADHD and similar | not said |
| 580 | `14047899` | App Store | 2 | en | 7 Overwhelmed | refused |
| 583 | `14049946` | App Store | 5 | en | 1 ADHD and similar; 3 Can't start or keep going | paid |
| 584 | `9d7de123` | Play | 5 | en | 3 Can't start or keep going | not said |
| 588 | `2316cd51` | Play | 5 | en | 1 ADHD and similar | not said |
| 589 | `9f6dc6e6` | Play | 5 | es | State only a goal | not said |
| 591 | `14079774` | App Store | 5 | en | 8 Parents and carers | not said |
| 592 | `5067cc9c` | Play | 4 | en | 1 ADHD and similar | paid |
| 593 | `14083519` | App Store | 5 | tr | State only a goal | not said |
| 596 | `14053874` | App Store | 5 | en | 2 Lose time | not said |
| 597 | `14055829` | App Store | 5 | en | 3 Can't start or keep going | not said |
| 599 | `14070027` | App Store | 5 | ja | 1 ADHD and similar; 2 Lose time | free |
| 600 | `14073080` | App Store | 4 | ko | State only a goal | not said |
| 602 | `dddc982f` | Play | 4 | es | 6 Tried other apps, planners or paper | not said |
| 622 | `14091189` | App Store | 4 | ja | 1 ADHD and similar; 2 Lose time | not said |
| 623 | `95cd569b` | Play | 5 | fr | 3 Can't start or keep going | not said |
| 642 | `14114238` | App Store | 4 | en | 1 ADHD and similar | not said |
| 643 | `14115048` | App Store | 5 | en | 4 Mornings go badly | not said |
| 645 | `14102953` | App Store | 5 | en | 3 Can't start or keep going | not said |
| 646 | `45684fda` | Play | 5 | en | 4 Mornings go badly; 8 Parents and carers | not said |
| 647 | `14104903` | App Store | 5 | en | 1 ADHD and similar; 2 Lose time; 4 Mornings go badly | not said |
| 657 | `0fc9df4c` | Play | 5 | en | 5 Forget steps and small habits | not said |
| 665 | `14156987` | App Store | 5 | en | State only a goal | not said |
| 669 | `f60cfe0f` | Play | 5 | en | 8 Parents and carers | not said |
| 674 | `14166860` | App Store | 5 | en | 3 Can't start or keep going | not said |
| 684 | `14208313` | App Store | 5 | en | 3 Can't start or keep going | not said |
| 686 | `14209934` | App Store | 5 | fr | 3 Can't start or keep going; 4 Mornings go badly | not said |
| 692 | `14214126` | App Store | 5 | en | 2 Lose time | not said |
| 696 | `14168412` | App Store | 5 | en | 1 ADHD and similar; 9 Lost their structure | not said |
| 703 | `14217992` | App Store | 5 | en | State only a goal | not said |
| 704 | `14256818` | App Store | 5 | en | 3 Can't start or keep going; 4 Mornings go badly | not said |
| 705 | `7494b14f` | Play | 5 | en | 7 Overwhelmed | not said |
| 707 | `14218890` | App Store | 5 | en | 6 Tried other apps, planners or paper | not said |
| 713 | `14267806` | App Store | 5 | en | State only a goal | not said |
| 715 | `14269209` | App Store | 5 | en | 1 ADHD and similar; 6 Tried other apps, planners or paper | not said |
| 716 | `14221322` | App Store | 5 | en | 2 Lose time | not said |
| 723 | `14223005` | App Store | 5 | en | 1 ADHD and similar; 2 Lose time | not said |
| 728 | `40f86f08` | Play | 5 | es | State only a goal | not said |
| 731 | `14279579` | App Store | 4 | en | 1 ADHD and similar; 3 Can't start or keep going; 5 Forget steps and small habits | not said |
| 732 | `9a937167` | Play | 5 | ja | 1 ADHD and similar | not said |
| 733 | `6cca08d2` | Play | 2 | en | 2 Lose time | not said |
| 737 | `b1b34290` | Play | 5 | en | 4 Mornings go badly | not said |
| 741 | `14247765` | App Store | 5 | en | State only a goal | not said |
| 744 | `14216125` | App Store | 5 | en | State only a goal | not said |
| 746 | `14264972` | App Store | 3 | en | 1 ADHD and similar | not said |
| 750 | `14294512` | App Store | 4 | en | 1 ADHD and similar; 3 Can't start or keep going; 6 Tried other apps, planners or paper | not said |
| 751 | `626fc697` | Play | 5 | en | State only a goal | not said |
| 754 | `14297901` | App Store | 5 | en | 7 Overwhelmed | not said |
| 755 | `14323219` | App Store | 5 | en | State only a goal | not said |
| 757 | `14298391` | App Store | 5 | en | 1 ADHD and similar | not said |
| 758 | `14298870` | App Store | 5 | en | 1 ADHD and similar | not said |
| 766 | `14302680` | App Store | 5 | en | 1 ADHD and similar; 2 Lose time | not said |
| 768 | `14302691` | App Store | 5 | en | 1 ADHD and similar | not said |
| 783 | `14308105` | App Store | 5 | en | State only a goal | not said |
| 785 | `8c34bacb` | Play | 5 | en | State only a goal | not said |
| 792 | `14303816` | App Store | 5 | en | 3 Can't start or keep going | not said |
| 793 | `14305701` | App Store | 5 | en | 1 ADHD and similar; 2 Lose time; 5 Forget steps and small habits; 9 Lost their structure | not said |
| 802 | `14389084` | App Store | 5 | en | 1 ADHD and similar; 9 Lost their structure | not said |
| 806 | `aabcee12` | Play | 5 | en | 5 Forget steps and small habits | free |
| 811 | `8d064dc4` | Play | 5 | es | State only a goal | not said |
| 813 | `14395329` | App Store | 5 | en | 1 ADHD and similar; 2 Lose time | not said |
| 821 | `14371016` | App Store | 1 | en | 5 Forget steps and small habits | paid |
| 823 | `f3f897ac` | Play | 5 | en | 3 Can't start or keep going; 7 Overwhelmed | not said |
| 825 | `14371526` | App Store | 5 | en | 1 ADHD and similar; 3 Can't start or keep going | not said |
| 827 | `14372695` | App Store | 5 | ko | 2 Lose time | not said |
| 830 | `14408209` | App Store | 5 | ko | 10 Follow a method | not said |
| 831 | `14375560` | App Store | 5 | en | State only a goal | paid |
| 843 | `44aef4ac` | Play | 5 | en | 2 Lose time | not said |
| 844 | `14361903` | App Store | 5 | en | State only a goal | not said |
| 848 | `14388138` | App Store | 5 | en | 1 ADHD and similar; 3 Can't start or keep going | not said |
| 849 | `14408847` | App Store | 5 | en | State only a goal | not said |
| 850 | `14410372` | App Store | 5 | en | 1 ADHD and similar; 2 Lose time; 4 Mornings go badly; 6 Tried other apps, planners or paper | not said |
| 853 | `14414547` | App Store | 5 | en | 1 ADHD and similar | not said |
| 856 | `14420872` | App Store | 5 | ja | State only a goal | not said |
| 857 | `456cdd62` | Play | 5 | en | 1 ADHD and similar | not said |
| 863 | `81aa4e6c` | Play | 5 | es | 2 Lose time | free |
| 870 | `d3ef8c3f` | Play | 5 | es | State only a goal | not said |
| 872 | `14447685` | App Store | 1 | ja | 4 Mornings go badly | not said |
| 875 | `14450832` | App Store | 5 | en | 2 Lose time; 4 Mornings go badly | not said |
| 879 | `14454697` | App Store | 5 | en | 2 Lose time | not said |
| 882 | `14459020` | App Store | 5 | en | 7 Overwhelmed | paid |
| 891 | `14414373` | App Store | 5 | en | 3 Can't start or keep going; 5 Forget steps and small habits | not said |
| 892 | `14422197` | App Store | 5 | es | State only a goal | not said |
| 893 | `14426456` | App Store | 5 | en | 4 Mornings go badly; 7 Overwhelmed | not said |
| 896 | `4bea7612` | Play | 5 | ko | 2 Lose time | not said |
| 898 | `66c160fc` | Play | 5 | es | State only a goal | not said |
| 901 | `14466229` | App Store | 5 | en | 5 Forget steps and small habits; 6 Tried other apps, planners or paper | not said |
| 903 | `14497458` | App Store | 5 | en | 1 ADHD and similar | not said |
| 904 | `14497946` | App Store | 5 | es | 1 ADHD and similar | paid |
| 912 | `14475922` | App Store | 5 | ja | 4 Mornings go badly | not said |
| 923 | `14507104` | App Store | 5 | en | State only a goal | not said |
| 935 | `0c4a7e49` | Play | 4 | en | State only a goal | not said |
| 936 | `14511056` | App Store | 5 | en | State only a goal | not said |
| 943 | `14492866` | App Store | 5 | en | 6 Tried other apps, planners or paper | not said |
| 944 | `14497138` | App Store | 5 | it | 2 Lose time | not said |
| 945 | `75288086` | Play | 5 | en | State only a goal | not said |
| 958 | `3bd42107` | Play | 4 | es | 7 Overwhelmed | free |

220 people: 156 in at least one pain-point group, 64 with a goal only. Checked: every ID in this report is in `Review Labels/Routinery/2026/reviews.jsonl`.
