# Routinery 2025: User Groups, Why They Use It, and What They Pay For

Written by Claude (Claude Code), 26 November 2026, at the user's request.

**What this is.** Routinery's target users as its 2025 reviews show them, the way UX user research describes them:
the groups of people who use it, each defined by the **pain point** that brought them; why each group uses it; whether
each group pays, how many, and for what; and which free features each group likes. The seventh year of a series
([2019](<Routinery 2019 — User Groups, Why They Use It, and What They Pay For.md>),
[2020](<Routinery 2020 — User Groups, Why They Use It, and What They Pay For.md>),
[2021](<Routinery 2021 — User Groups, Why They Use It, and What They Pay For.md>),
[2022](<Routinery 2022 — User Groups, Why They Use It, and What They Pay For.md>),
[2023](<Routinery 2023 — User Groups, Why They Use It, and What They Pay For.md>),
[2024](<Routinery 2024 — User Groups, Why They Use It, and What They Pay For.md>)).

**How it was done.** From the reviews alone, as research for a new product or a full rebuild. No product of ours, its
features or its code was used to choose, read or group anything.

**Source.** The checked labels for all 1,620 reviews of 2025 in `Review Labels/Routinery/2025/labels.jsonl`, the same
way as 2020–2024:

- **Groups:** from `who` and `why_chose`. I read all 462 reviews that have either and put each person in the group(s)
  their own words describe. One person can be in more than one group. No new group was needed this year.
- **Features liked:** from `liked` and `chose_for`, sorted into the same kinds as the earlier years.
- **Paying:** from `paid` and its reason, plus the price and premium complaints in `problems`. Every payer, every
  unexpected charge, every refusal and every routine-limit mention was sorted by hand.

Review IDs are shortened to their first 8 characters; the appendix maps every group member to its line in the labels
file. The map is saved as [`Tools/groups_2025.py`](<Tools/groups_2025.py>); [README.md](<README.md>) explains the method.

---

## The short answer

- **1,620 reviews** (980 App Store, 640 Google Play: **the first year the App Store has more**), average **4.06★**, up
  from 3.90★. **237 people (15%) name a pain point**, the most of any year; 93 more name only a goal.
- **Routinery is an ADHD app now, more than ever by count.** 97 of the 237 (41%) say they have ADHD, autism,
  executive dysfunction, depression, anxiety or bipolar disorder; **81 name ADHD or ADD** (AuDHD included), the most
  of any year. Losing time is again the second group (32%), and many of its members write that they are **no longer
  late**.

| # | User group (the pain point) | People | Share of the 237 | ★ | Paid or trial | 2024 share |
|---|---|---|---|---|---|---|
| 1 | **Have ADHD, autism, executive dysfunction, depression, anxiety or bipolar disorder** | 97 | **41%** | 4.54 | 8 | 42% |
| 2 | **Lose time:** always late, distracted (phone, YouTube, social media), time blindness | 76 | **32%** | 4.68 | 6 | 33% |
| 3 | **Can't start or keep going:** procrastinate, lethargy, never kept a routine past a few days | 46 | 19% | 4.87 | 1 | 17% |
| 4 | **Mornings go badly:** can't get out of bed, rushing, late for work, school or the bus | 40 | 17% | 4.65 | 0 | 21% |
| 5 | **Forget steps and small habits** (teeth, supplements, things for school or work) | 25 | 11% | 4.44 | 1 | 11% |
| 6 | **Tried other apps; nothing stuck** (Tiimo, me+, a discontinued app, notes, "every … app") | 24 | 10% | 4.71 | 1 | 7% |
| 7 | **Overwhelmed:** giant lists, busy schedules, homework till 11 pm | 16 | 7% | 4.44 | 0 | 8% |
| 8 | **Parents and carers**, often doing routines with their children | 13 | 5% | 4.92 | 1 | 3% |
| 9 | **Lost their structure:** grief, illness, a new puppy, graduating, working from home | 7 | 3% | 4.86 | 0 | 3% |
| 10 | **Follow a method** (The Miracle Morning, habit stacking) | 3 | 1% | 4.67 | 0 | — |

  (90 people are in more than one group.)

- **Why they use it:** the same as every year. The app **puts a timer on every step and walks them through**, so they
  don't have to remember, decide or watch the clock: *"as important as medication for my ADHD"*, *"stay on task and on
  a routine, rather than trying to use my memory"*, *"Protects me from time blindness"*. **The timer on every step is
  liked by 103 people (from 53)**, and by 21 of the ADHD group, more than any feature in any group in any year.
- **Paying is two stories.** 75 people (4.6%) say they paid. **29 give a reason to pay** (19 the whole app, 4 more
  routines, 4 the price, 1 the alarm, 1 a promotion), many of them with ADHD (*"Die beste App überhaupt für mein ADHS-Gehirn"*, "the
  best app ever for my ADHD brain"). **46 others write because the paid app broke or they want out**: 32 report bugs or
  a subscription the app forgot, 14 regret it or want a refund. Payers average **2.89★**: 27 gave 1★ and 24 gave 5★.
- **The trial is the new trap.** **22 say they were charged unexpectedly, 15 of them by a free trial**, and 9 refusals
  are about the trial or a price shown too late. 12 of the 22 are Korean.
- **The paywall is still the third routine, now with ads.** About 70 reviews mention the two-routine free limit:
  about 47 want more (usually 3–5), 14 say two are enough. **Ads are now part of the free plan** (20 complaints, from 5
  in 2024): free users watch ads to archive or switch routines (*"ad-bombing for access to 2 routines is pure greed"*).
- **Japanese reviewers pay most this year:** 12.7% of Japanese reviews say they paid, 10.6% of Korean ones, 3.7% of
  English ones.
- **New dislikes:** social features (a Social tab, "send cheers", celebrities' routines: 9 complain, 3 want more),
  notifications and pop-ups that won't stop, and being logged out (about 19 reviews).

---

## 1. The year in numbers

| | Count | Share of 1,620 |
|---|---|---|
| Reviews | 1,620 | 100% |
| App Store / Google Play | 980 / 640 | 60% / 40% |
| Language: English, Korean, Spanish, Japanese, French, Portuguese (Brazil), German, other | 1,035, 161, 114, 102, 44, 28, 27, 109 | 64%, 10%, 7%, 6%, 3%, 2%, 2%, 7% |
| Ratings 5★ / 4★ / 3★ / 2★ / 1★ | 975 / 243 / 114 / 101 / 187 | 60% / 15% / 7% / 6% / 12% |
| Say who they are (`who`) | 305 | 19% |
| Say why they came (`why_chose`) | 317 | 20% |
| Name a pain point (any group below) | **237** | **15%** |
| Name only a goal | 93 | 6% |
| Name a feature they like | 779 | 48% |
| Say anything about paying | 177 | 11% |
| Report something broken | 368 | 23% |
| Nothing useful ("great app") | 186 | 11% |

Reviews come more in the second half of the year (165 in July, 172 in August, 158 in September) than the first (105 to
129 a month). Fewer reviews report a bug than in 2024 (23% against 30%), and the average rating rose for the first time
since 2020.

**How they found it:** an ADHD community forum (`12562803`), a therapist (`13127830`), a therapist who recommends it to
patients with ADHD (`12384933`), ChatGPT (`6240afd6`), an Instagram ad (`13333169`), *"A recommendation from a
stranger"* (`12151779`).

---

## 2. The user groups

### Group 1. Have ADHD, autism, executive dysfunction, depression, anxiety or bipolar disorder (97 people, 41%, 4.54★)

**Who they are:** ADHD or ADD (81, including several who say AuDHD), autism, executive dysfunction or brain fog
(11), depression, anxiety, bipolar disorder or other mental health (11). Adults diagnosed late (*"I'm 32"*), people
off medication (*"I’m fully relying on coping skills and strategies to manage my symptoms"*), a 12-year-old with ADHD
whose parents keep the phone downstairs, a single mother working from home, a parent and child who both have ADHD.
47 are only in this group.

**Why they use it:**
- *"as important as medication for my ADHD"* (`12769141`, en, 5★).
- *"All apps are a challenge with ADHD"* (`12405134`, en, 5★).
- *"rattraper mon cerveau de TDAH (qui cherche à partir sur une autre tâche)"*, "to catch my ADHD brain (which tries to
  go off onto another task)" (`0dbe7511`, fr, 4★).
- *"doing simple tasks like making the bed or starting your work is hard (feels like moving a mountain)"* (`40242f2d`,
  en, 5★).
- *"because of my autism, I’m not really able to form habits"* (`12439307`, en, 5★, AuDHD).
- *"I have severe executive function problems due to auDHD"* (`12876052`, en, 5★).
- *"this is the only thing that helps me when I am manic"* (`12337959`, en, 5★, bipolar disorder).
- *"I was struggling so much with my chronic illness related brain fog, especially in the morning"* (`12658218`, en,
  5★).
- *"使わないと、つい何か検索してそのままSNSを見て寝るのが遅くなります"*, "without it I end up searching something, then
  looking at social media, and go to bed late" (`12845166`, ja, 5★).
- *"ASD ADHD 双極性の私"*, "me, with ASD, ADHD and bipolar disorder" (`13441105`, ja, 4★).
- *"I have tried soooo many other strategies and none of them have worked at All, or if they have, only for a short
  period of time"* (`12952781`, en, 5★).

**Free features they like** (83 of 97): **the timer on every step (21)**, simple and clean (10), the look (8),
reminders (6), pause, skip or add time (4), the free version is enough (4), walked through one step at a time (4).

**Paying:** **8 paid, the most of any group**, 6 free, 3 refused, 80 don't say. *"Die beste App überhaupt für mein
ADHS-Gehirn"*, "the best app ever for my ADHD brain", paid *"um mehr Routinen einrichten zu können und die Entwicklung zu unterstützen"*, "to be able to set up more routines
and support the development" (`57c669ed`); an AuDHD reviewer short on money is *"really glad it’s cheap considering how
broke I am"* (`12710625`); *"안쓸 때랑 쓸 때랑 정말 다르다고 느껴서"*, "I felt how different it is when I use it and when I
don't", while preparing for meetings (`416d9463`); *"I do pay for a yearly membership because I need it"* (`13518248`); an ADHD parent and child on a yearly plan (`13186621`). Three paid and then hit bugs or cancelled
(`bb062353`, `13100664`, `13469367`). The refusals: the price per year (`12181718`), *"I wish I didn’t have to pay so much for
premium otherwise I would get it"* from someone who *"just graduated college"* (`13278570`), and the 12-year-old who can't afford it
(`12740246`).

### Group 2. Lose time (76 people, 32%, 4.68★)

**Who they are:** people who are late, rushed, distracted by their phone, YouTube or social media, or have time
blindness. 35 are only in this group. **Many write as people who used to be late:** *"now I'm never late"*
(`516a96e0`), *"I’m never late anymore"* (`bef3f8f2`), *"I haven’t been late to anything"* (`13233621`).

**Why they use it:**
- *"유투브 스트레칭 영상 틀면서 맨날 다른곳으로 샜었는데"*, "I'd put on a YouTube stretching video and always drift off
  somewhere else" (`12133166`, ko, 5★).
- *"nosotros los distraídos"*, "we, the easily distracted" (`12145145`, es, 5★).
- *"I always feel like I don’t have enough time or I should rush"* (`12403348`, en, 5★).
- *"Protects me from time blindness"* (`12688377`, en, 5★).
- *"I literally had horrible habits like sleeping at 4 am in the morning,not really doing anything all day,on my phone
  24/7"* (`12920796`, en, 5★).
- *"매일 늦고 촉박하게 일을 마무리했는데"*, "I was late every day and finished work in a rush", a nurse on shifts
  (`13126579`, ko, 5★).
- *"to help me break my habit of using my phone for entertainment"* (`12961134`, en, 5★).
- *"違うことに気を取られやすい私"*, "me, who gets easily caught up in other things" (`12877060`, ja, 5★).

**Free features they like** (68 of 76): **the timer (12)**, simple (8), encouraging words (6), reminders (4), the free
version is enough (4), more than one routine (3).

**Paying:** 6 paid (*"the paid version of this is absolutely worth it"*, for the reminders of when the next task starts and when
it all ends, `12911127`; for more routines, because it *"has stopped me arriving late all the time"*, `e0742977`; and four ADHD members above), 3 free, 1 refused.

### Group 3. Can't start or keep going (46 people, 19%, 4.87★)

The highest-rated large group. 23 are only in it.
- *"Have not been able to stick with a routine longer than the first few days"* (`13528082`, en, 5★).
- *"the only think that can make me do something other than procrastinating"* (`12220758`, en, 5★).
- *"자유도가 있으면 내게 할지말지를 맡기기때문에 사실상 해내지 않는 경우가 많은데"*, "when there's freedom it's left to me
  whether to do it, so in practice I often don't" (`12235381`, ko, 5★).
- *"무기력할 때 나를 이끌어주는 앱"*, "an app that leads me when I'm lethargic" (`12861507`, ko, 5★).
- *"なんでも面倒くさい、後でいいやと先延ばしにしてやらなきゃいけない事が常に溜まっているような状態だった私"*, "I found
  everything a hassle, put it off for later, and the things I had to do always piled up" (`12926483`, ja, 5★).
- *"청소가 도저히 습관이 들지 않아서 항상 지저분한 방에서 지냈었는데"*, "I could never make cleaning a habit, so I always
  lived in a messy room" (`13183836`, ko, 5★).
- *"I’d been literally falling apart till I found your app"* (`13446802`, en, 5★).

**Free features they like** (42 of 46): **the timer (12)**, simple (8), encouraging words (5), reminders (5), the free
version is enough (3), pause or skip (3). **Paying:** 1 paid (`12710625`, above), 5 free.

### Group 4. Mornings go badly (40 people, 17%, 4.65★)

Work mornings and school mornings in about equal number, and some parents getting a child to the bus.
- *"I would wake up at 5:30 and barely make it out the door at 6:30"* (`13442882`, en, 5★).
- *"früher bin ich fast immer zuspät zum Bus gekommen"*, "I used to be late for the bus almost every time"
  (`292611ca`, de, 5★).
- *"i could never get out of bed on school mornings"* (`13127372`, en, 5★).
- *"어떻게 하면 조금이라도 준비 시간을 단축할 수 있을까가 고민이었습니다"*, "I worried about how to cut my getting-ready
  time even a little" (`12701763`, ko, 5★).
- *"I have struggled my whole life with getting out of bed in the morning"* (`13549556`, en, 4★, ADHD).
- *"helps my daughter wake up and not miss the buss"* (`15b49d01`, en, 5★).
- *"I have a big problem of being late for school and it leads to lots of stress and negativity"* (`13337327`, en,
  5★).

**Free features they like** (38 of 40): **the timer (9)**, simple (6), the look (4), encouraging words (3), seeing when
the routine will finish (2). **Paying:** none say they paid; 3 free.

### Group 5. Forget steps and small habits (25 people, 11%, 4.44★)

- *"Routines and remembering to do certain things (like brush my teeth) has been a NIGHTMARE my entire life"*
  (`12954702`, en, 5★).
- *"I always forgot something before leaving for work"* (`d1622eb5`, en, 4★).
- *"朝夜のサプリの飲み忘れが多かった"*, "I often forgot my morning and evening supplements" (`13487673`, ja, 5★).
- *"切り替えが苦手で忘れっぽいので、いつも助けられています"*, "I'm bad at switching and forgetful, so it always helps me"
  (`12655526`, ja, 4★).
- *"I usually always forget stuff for school"* (`13150817`, en, 5★).

**Free features they like** (22 of 25): the timer (4), simple (4), **seeing when the routine will finish (3)**, pause
or skip (3). **Paying:** 1 paid: *"The app is worth the annual fee charged no question"*, because there *"don’t seem to be any
other options for people whose mind works the way mine does"*, though the review is 1★ for bugs (`12737168`).

### Group 6. Tried other apps; nothing stuck (24 people, 10%, 4.71★)

The most in this group since 2021. The apps left: **Tiimo** (*"Ever since Tiimo stopped serving its purpose, I needed
a new routine app"*, `12759884`; *"after tiimo got rid of their routine settings"*, `13356551`), **me+** (*"now you have
to pay to make a routine"*, `13091389`), a discontinued routines app (`12251430`), apps whose alarms failed (*"타 어플은
알람을 제대로 안줬었는데"*, "other apps didn't give proper alarms", `13032757`), notes (`12622045`) and apps that were too
complex (`497247f6`).
- *"tried every schedule, routine, and self care app"* (`12585389`, en, 5★, ADHD).
- *"Es la primera App con la que por fin puedo seguir mis rutinas."*, "It's the first app with which I can finally
  follow my routines." (`13416875`, es, 5★).
- *"I was looking for apps like this for years"* (`13361043`, en, 5★).

**Free features they like** (22 of 24): **the timer (6)**, simple (3). **Paying:** 1 paid (`12737168`), 3 free.

### Group 7. Overwhelmed (16 people, 7%, 4.44★)

- *"Instead of thinking about these giant list and all these things that I need to be consistent at"* (`12279005`,
  en, 5★, ADHD).
- *"I have been overwhelmed with to dos and lack of structure in my life"* (`12769367`, en, 4★).
- *"Before Routinery I had to stay awake till 11:00 at night so I could finish my homework"* (`12474079`, en, 5★).
- *"We have a lot of routine care tasks to track"*, a mother of a child with severe disabilities (`12915068`, en, 5★).
- *"늘 복잡한 업무, 정리되지 않은 일상에 고생하전 저에게"*, "to me, who always struggled with complicated work and an
  unorganised daily life" (`13259393`, ko, 5★).

**Free features they like:** simple (4), the free version is enough (2). **Paying:** none say; 2 free.

### Group 8. Parents and carers (13 people, 5%, 4.92★)

Mostly **parents who run routines together with their children**: *"używam ja i córka"*, "my daughter and I use it"
(`eacb3a10`, pl, 5★); *"my daughter also uses it for am and pm routines"* (`13121738`); *"Kids use it also!"*
(`13411638`); *"do our daily family routines jointly"* (`12619513`); a parent with an ADHD son (`12598922`); and parents
who have ADHD themselves (*"to create a programmed routine with specific alerts that get me through my crazy mornings"*,
a mom of two, `12463184`). **Free features they like:** encouraging words (3), a responsive developer (2). **Paying:** 1
paid (the ADHD parent and child, `13186621`).

### Group 9. Lost their structure (7 people) and Group 10. Follow a method (3 people)

Grief (*"help me let go of loss of our dog"*, `12197272`), illness (`5a8cb098`), *"minha nova rotina com meu novo
cachorrinho"*, "my new routine with my new puppy" (`713c6bfd`), graduating (`13278570`), working from home as a single
mother (*"Un must pour me cadrer en télétravail"*, "a must for keeping me on track while working from home",
`fbe9a38a`), *"hard times"* (`8d9f5d47`). The methods: **The Miracle Morning** (*"미라클모닝 성공한적 한번도없는데"*, "I'd
never once succeeded at a miracle morning", `13454877`; a reader who looked for an app after the book, `12198081`) and
**habit stacking** (`fe93abb1`). None paid.

### People who name only a goal (93 people, 4.37★)

Morning and night routines, *"갓생"* ("god-life", a productive life), school and work; New Year goals in January. Paying: 4 paid, 7 free, 1 refused.

---

## 3. Paying

### How many pay

| | 2025 | Share of 1,620 | Share of the 177 who say anything | 2024 | 2023 |
|---|---|---|---|---|---|
| Paid | 75 | 4.6% | 42% | 46 (4.6%) | 71 (4.0%) |
| On a trial | 2 | 0.1% | 1% | 5 | 4 |
| **Charged unexpectedly** | **22** | 1.4% | 12% | 22 (2.2%) | 20 (1.1%) |
| Refused to pay | 33 | 2.0% | 19% | 21 | 37 |
| Use it free and say so | 45 | 2.8% | 25% | 28 | 50 |
| Don't say | 1,443 | 89% | — | 888 | 1,581 |

**By group** (paid + trial): ADHD and similar 8 of 97; lose time 6 of 76; can't start, forget, tried everything and
parents 1 each; mornings, overwhelmed, lost structure and method 0. **ADHD and similar has the most payers, but 8 of 97
is no proof the group pays more:** a handful of people, and most don't say.

**By language:** 38 of the 75 payers write in English, 17 in Korean, 13 in Japanese. **12.7% of the 102 Japanese
reviews say they paid**, 10.6% of the 161 Korean ones and 3.7% of the 1,035 English ones; 2 of 114 Spanish. Refusals:
21 of 33 in English, 5 in German. 12 of the 22 unexpected charges are Korean.

**Payers split in two.** Their average is **2.89★** (2.72★ in 2024): 27 gave 1★ and 24 gave 5★. 47 of the 75 report
something broken, and 8 say the app stopped recognising their subscription (`83ed60bd` `414be342` `1fe8fde4`
`018048d7` `13142540` `9b89fccf` `6a259c2e` `13491501`), one of them a lifetime purchase (*"I paid for lifetime
subscription and it disappeared"*).

### Why the payers paid

| Reason | Payers | IDs |
|---|---|---|
| The whole app works for them, or they liked it straight away (*"하루 사용해보고 바로 1년 구독했어요"*, "I tried it for one day and subscribed for a year right away"; *"Just renewed for an additional year"*; *"これがないと生きていけないです。課金して毎日使っています！"*, "I can't live without this. I pay and use it every day!") | 19 | `05b1d6f5` `7cfb6a13` `12411473` `12444613` `12544440` `416d9463` `e1959ec7` `12555501` `12632014` `d20227e2` `13007276` `13075115` `13093885` `13088709` `13186621` `13364876` `13390488` `13518248` `13568802` |
| **For more routines** | 4 | `57c669ed` `e0742977` `13449391` `13100664` |
| For another feature: the alarm's continuous notifications | 1 | `13319989` |
| Worth it for the price (*"The app is worth the annual fee charged no question"*) | 4 | `12625991` `12710625` `12737168` `12911127` |
| A promotion: the year-end "1+1" offer | 1 | `d2d521df` |
| Regret it, won't renew, cancelled, or want a refund (*"次の年間更新はしない予定"*, "I don't plan to renew the yearly plan"; *"I want to stop my subscription and they make impossible"*) | 14 | `12304726` `12402110` `12993749` `eadb5499` `51ce55bd` `13157287` `13256544` `13259002` `13376641` `13449732` `13441647` `9461603d` `33bfec17` `0ef1cf27` |
| No reason; they mention paying only to report a bug, ads, pop-ups, or a subscription the app forgot (*"Paguei a assinatura e agora o app sequer abre."*, "I paid for the subscription and now the app won't even open.") | 32 | `12140169` `64368a49` `12274575` `bb062353` `32f2b222` `862399dd` `4903030a` `12578850` `ed874ce8` `efc4e0a6` `12809291` `83ed60bd` `12845383` `a1c9a5fe` `414be342` `da32409f` `1fe8fde4` `018048d7` `3e46bde5` `13049897` `13099883` `97cc4f5e` `13142540` `13204543` `9b89fccf` `13340409` `8dca4df1` `13382239` `9b0a5b0c` `6a259c2e` `13491501` `13469367` |

**29 give a reason to pay, against 10 in 2024.** When they name a feature it's **more routines** again (4 of 5). Prices
named: 35,000 won a year, $30 a year, 35 euros a year, 4.50 euros a month, 339 kr a year, 30.99 euros.

**Charged unexpectedly (22):**

| What happened | Reviews |
|---|---|
| **A free trial** charged at once, or became a year (*"It said I would have 7 days trial, I bough an year plan"*) | 15: `12188001` `12213361` `12243823` `12319574` `12379919` `12402580` `12394473` `12448354` `12477311` `c05f8c6d` `12766581` `12852521` `12871573` `12861318` `12886666` |
| Renewed without notice, or while not using the app | 4: `12273106` `12345494` `204e0c0e` `31cfdea3` |
| A discount offer or a cancel screen that charged instead | 3: `13112958` `1bf00f9b` `7b98588d` |

### What premium holds (from what free users miss and payers name)

| Behind the paywall | Reviews |
|---|---|
| **More than two routines** | about 70 mention it: about 47 want more (usually 3–5), 14 say two are enough (*"Das reicht für Morgen- und Abendroutine"*, "that's enough for a morning and evening routine"), 3 paid and have more, 3 say the free plan allows one (or two a day), 2 say archiving or switching routines now needs a subscription or an ad |
| Icons | about 4 |
| Widgets | 3 |
| Statistics, backup | 1 each |

**Ads now pay for the free plan.** 20 reviews complain of ads (5 in 2024, 12 in 2023), most from September: free users
watch an ad to archive or swap a routine (*"it doesn't allow me to archive my routine without subscribing or watching
ads"*, `7b5aca9d`; *"Non-premium accounts used to have restricted access to 2 routine slots. However, you could archive
multiple routines for later"*, `47f733b0`), and one payer still sees them (`13382239`).

### Why others won't pay

The 33 who refuse:

| Objection | Refusals | IDs |
|---|---|---|
| **The trial or a price shown too late** (card needed for the trial, a year's commitment, the subscription not in the description) | 9 | `12137087` `51cabdea` `47d07ec3` `2c2dae0c` `98034e3f` `12931755` `327f7816` `12863660` `55b04b4d` |
| Too expensive or no money | 7 | `12181718` `8ea83d6f` `b65b7484` `12740246` `12996845` `13278570` `13575599` |
| Two routines are too few, or routines need a subscription or an ad | 7 | `12171510` `36fba247` `12629436` `12951870` `a2785d21` `7b5aca9d` `13502501` |
| A subscription instead of a one-time or lifetime price (*"I'd be willing to pay 30€ for a lifetime of Pro but not for just a year"*) | 5 | `12433331` `2ed0b53b` `81bea5ec` `09989d80` `25a8f2ba` |
| Not worth it, or unclear what premium adds | 4 | `ad701ddc` `e2dd23bd` `c6e02d4f` `637a3b58` |
| The bugs come first | 1 | `b602b6b4` |

**The trial is the most common reason to refuse** this year (bugs were in 2024, price before that). Across all
reviews, by keyword: the trial or being pushed to pay about 34, too expensive about 20, subscription instead of
one-time about 11.

---

## 4. Free features people like

Across all 1,620 reviews, 779 (48%) name something they like:

| Feature | Reviews | Groups that name it most |
|---|---|---|
| Simple, clean, easy | 135 | ADHD and similar (10), lose time (8), can't start (8) |
| **A timer on every step** | **103** | **ADHD and similar (21)**, lose time (12), can't start (12), mornings (9), tried everything (6) |
| The look: design, cute icons | 78 | Goal only (9), ADHD and similar (8) |
| Encouraging words, the voice | 49 | Goal only (7), lose time (6), can't start (5) |
| Reminders and alerts | 30 | ADHD and similar (6), can't start (5) |
| **A responsive developer** | 29 | Parents (2) |
| Pause, skip or add time | 22 | ADHD and similar (4), forget (3), can't start (3) |
| The free version is enough | 21 | ADHD and similar (4), lose time (4) |
| Walked through one step at a time | 13 | ADHD and similar (4) |
| Seeing how long things take, stats | 12 | — |
| More than one routine | 10 | Lose time (3) |

**Per group:** the timer is the feature of 2025, first in five of the ten groups. People with ADHD name it twice as
often as anything else. The forgetful like **seeing when the routine will finish**. A responsive developer is named
twice as often as in 2024 (29 against 14).

**What people dislike that is new or growing:** **social features** (*"routines app has a social network built in"*, a
setting minors and adults share, celebrities' routines, "send cheers" messages: `12140169` `12811011` `13030062`
`13094268` `e9ef2335` `58c4b730` `13364876` `13373809` `39bcb55b`; 3 want more of them), **notifications and pop-ups**
that repeat every few seconds (*"They come every 5 seconds. I counted."*, `12578850`), being logged out (about 19), and
an AI voice (`13419963`). Two want AI to suggest routine steps (`12376007`, `12523518`).

---

## 5. Who they say they are

From `who` (305 people say something), with the keyword traps fixed by hand:

| They say they are | People | 2024 | 2023 |
|---|---|---|---|
| **ADHD or ADD** (AuDHD included) | **81** | 46 | 38 |
| Working (a nurse on shifts, a car detailer, a software developer, office workers) | 39 | 12 | 15 |
| **Smartwatch user** | 35 | 36 | 38 |
| Student | 32 | 10 | 31 |
| Parent | 13 | 5 | 11 |
| Autism, executive dysfunction, brain fog | 11 | 4 | 10 |
| Depression, anxiety, bipolar disorder, other mental health | 11 | 8 | 6 |
| Children and minors (a 9-, two 10- and two 12-year-olds, a 15-year-old, an elementary student) | 7 | 4 | 9 |
| iPad or tablet user | 6 | 6 | 8 |
| Procrastinator, lazy | 3 | 4 | 12 |
| Short of money | 3 | 1 | 9 |

**The watch:** 54 reviews mention the watch app; 29 say it’s broken, 14 like it (the most of any year). People use it
to leave the phone behind: *"I’m trying to stay off my phone"* (`12442067`).

---

## 6. What changed

| | 2020 | 2021 | 2022 | 2023 | 2024 | 2025 |
|---|---|---|---|---|---|---|
| Reviews | 1,122 | 1,626 | 1,534 | 1,763 | 1,010 | 1,620 |
| Name a pain point | 166 | 200 | 205 | 177 | 132 | **237** |
| Biggest group | Mornings (31%) | Can't start (28%), tried everything (28%) | ADHD and similar (45%) | ADHD and similar (30%) | ADHD and similar (42%) | **ADHD and similar (41%)** |
| ADHD or ADD named | 15 | 38 | 78 | 38 | 46 | **81** |
| Lose time | 24% | 21% | 20% | 23% | 33% | 32% |
| Can't start | 27% | 28% | 28% | 28% | 17% | 19% |
| Mornings | 31% | 19% | 10% | 19% | 21% | 17% |
| Tried everything else | 16% | 28% | 10% | 9% | 7% | 10% |
| Timer on every step liked | — | — | 86 | 71 | 53 | **103** |
| Said they paid | 2.2% | 3.9% | 4.9% | 4.0% | 4.6% | 4.6% |
| Payers giving a reason to pay | — | — | 47 | 32 | 10 | 29 |
| Payers' average rating | — | — | 3.91 | 2.97 | 2.72 | 2.89 |
| Charged unexpectedly | 2 | 4 | 6 | 20 | 22 | 22 |
| Ads complained of | — | — | 0 | 12 | 5 | **20** |
| Report something broken | 11% | 14% | 20% | 25% | 30% | **23%** |
| Average rating | 4.33 | 4.29 | 4.18 | 3.96 | 3.90 | **4.06** |

(Payers giving a reason: the whole app, a feature, the price, a promotion, free first, support, a test month; not
regret, a bug or no reason.)

The pains are the same as every year, and **people with ADHD and people who lose time are now the app's core**, with
students back. 2025 is better than 2024 on the surface (fewer bugs, a higher rating, more payers with a reason), but the
paywall has moved: **from bugs to the trial and ads.** Unexpected charges stay at 22, mostly free trials.

---

## 7. Limits

- **85% don't name a pain point,** so the groups describe the 237 who do; the order is more reliable than the exact
  sizes.
- **`who` (305) and `why_chose` (317) are almost even**, as in 2023 and 2024; I read both for every person, so the
  groups compare with earlier years, but goal-only counts (93) don't.
- **Paying is said by 11%.** Group paying rates rest on 0–8 people.
- **The routine-limit count is approximate** (about 70): every hit was read and sorted by hand.
- **Feature kinds are sorted by their words**, as in 2023 and 2024.
- **"Now I'm never late" is counted as a pain** (lose time): the review says they were late before.
- **"Paid" includes refund requests** (4 Korean payers ask for one), as in 2024.

---

## Appendix: every group member

`Line` is the review's line in `Review Labels/Routinery/2025/labels.jsonl`; `ID` is the first 8 characters of its
review ID.


| Line | ID | Store | ★ | Language | Groups | Paid |
|---|---|---|---|---|---|---|
| 7 | `12133166` | App Store | 5 | ko | 2 Lose time | not said |
| 13 | `12151779` | App Store | 5 | en | 2 Lose time | not said |
| 16 | `12153416` | App Store | 5 | en | State only a goal | not said |
| 20 | `12135925` | App Store | 5 | en | 3 Can't start or keep going | not said |
| 21 | `12154298` | App Store | 5 | en | 1 ADHD and similar | not said |
| 23 | `eacb3a10` | Play | 5 | pl | 8 Parents and carers | not said |
| 26 | `12137471` | App Store | 5 | ja | State only a goal | not said |
| 27 | `12138524` | App Store | 5 | en | 1 ADHD and similar; 2 Lose time; 6 Tried other apps, planners or paper | not said |
| 37 | `12142252` | App Store | 5 | en | State only a goal | not said |
| 39 | `12145145` | App Store | 5 | es | 2 Lose time | not said |
| 42 | `12134454` | App Store | 5 | en | 2 Lose time | not said |
| 45 | `0dbe7511` | Play | 4 | fr | 1 ADHD and similar; 2 Lose time | not said |
| 48 | `12150983` | App Store | 5 | es | 2 Lose time; 3 Can't start or keep going | not said |
| 51 | `12198081` | App Store | 5 | en | 6 Tried other apps, planners or paper; 10 Follow a method | not said |
| 57 | `0a7b04ee` | Play | 5 | en | 1 ADHD and similar | not said |
| 61 | `2a4eebcf` | Play | 5 | en | 1 ADHD and similar | not said |
| 69 | `12223042` | App Store | 5 | en | State only a goal | not said |
| 79 | `12171510` | App Store | 3 | en | State only a goal | refused |
| 82 | `12181718` | App Store | 3 | en | 1 ADHD and similar | refused |
| 89 | `b9e2ae38` | Play | 5 | en | 3 Can't start or keep going | not said |
| 92 | `12197272` | App Store | 5 | en | 1 ADHD and similar; 9 Lost their structure | not said |
| 95 | `12184714` | App Store | 5 | en | 3 Can't start or keep going; 4 Mornings go badly | free |
| 100 | `12220758` | App Store | 5 | en | 3 Can't start or keep going | not said |
| 102 | `12251430` | App Store | 5 | en | 1 ADHD and similar; 6 Tried other apps, planners or paper | not said |
| 106 | `12251535` | App Store | 5 | ko | State only a goal | not said |
| 112 | `12235381` | App Store | 5 | ko | 3 Can't start or keep going | not said |
| 117 | `f0810f8b` | Play | 5 | en | State only a goal | not said |
| 118 | `12238910` | App Store | 5 | en | 1 ADHD and similar | not said |
| 122 | `12239208` | App Store | 5 | en | State only a goal | not said |
| 127 | `12267126` | App Store | 5 | en | 3 Can't start or keep going | not said |
| 135 | `d7557d21` | Play | 4 | en | State only a goal | not said |
| 146 | `12271890` | App Store | 5 | ko | State only a goal | not said |
| 150 | `12264034` | App Store | 5 | en | State only a goal | not said |
| 151 | `7eba2b7c` | Play | 1 | ko | State only a goal | not said |
| 152 | `12293195` | App Store | 4 | en | State only a goal | not said |
| 157 | `497247f6` | Play | 5 | en | 6 Tried other apps, planners or paper; 7 Overwhelmed | free |
| 162 | `652f8b0c` | Play | 5 | es | State only a goal | not said |
| 163 | `0b677307` | Play | 5 | pt-BR | 1 ADHD and similar; 3 Can't start or keep going | not said |
| 171 | `12278612` | App Store | 5 | ko | State only a goal | free |
| 180 | `12315285` | App Store | 4 | en | 3 Can't start or keep going | free |
| 182 | `12316501` | App Store | 2 | en | State only a goal | not said |
| 191 | `12292767` | App Store | 5 | en | 1 ADHD and similar; 2 Lose time | not said |
| 194 | `12276725` | App Store | 5 | en | 6 Tried other apps, planners or paper | not said |
| 195 | `12279005` | App Store | 5 | en | 1 ADHD and similar; 7 Overwhelmed | not said |
| 197 | `12283999` | App Store | 5 | en | 1 ADHD and similar; 4 Mornings go badly; 5 Forget steps and small habits | not said |
| 199 | `12312398` | App Store | 4 | en | 1 ADHD and similar | not said |
| 206 | `12322163` | App Store | 5 | ko | 2 Lose time | not said |
| 208 | `5a8cb098` | Play | 5 | en | 4 Mornings go badly; 9 Lost their structure | not said |
| 210 | `12323445` | App Store | 5 | es | 2 Lose time; 4 Mornings go badly | not said |
| 213 | `12325461` | App Store | 4 | en | State only a goal | free |
| 223 | `047a2da5` | Play | 1 | en | State only a goal | not said |
| 227 | `b6ec358d` | Play | 4 | es | State only a goal | not said |
| 228 | `63a9aa84` | Play | 5 | en | State only a goal | not said |
| 232 | `bb062353` | Play | 4 | en | 1 ADHD and similar; 2 Lose time | paid |
| 234 | `12337959` | App Store | 5 | en | 1 ADHD and similar | not said |
| 238 | `12342360` | App Store | 5 | en | 2 Lose time; 4 Mornings go badly; 5 Forget steps and small habits | not said |
| 246 | `12380308` | App Store | 5 | en | 3 Can't start or keep going | not said |
| 248 | `12342952` | App Store | 3 | en | 7 Overwhelmed | free |
| 250 | `12376007` | App Store | 5 | en | 1 ADHD and similar; 2 Lose time | not said |
| 256 | `12403348` | App Store | 5 | en | 2 Lose time | not said |
| 261 | `12405134` | App Store | 5 | en | 1 ADHD and similar; 2 Lose time | not said |
| 264 | `8516630d` | Play | 5 | en | State only a goal | not said |
| 281 | `12414898` | App Store | 5 | en | 1 ADHD and similar; 2 Lose time; 4 Mornings go badly | free |
| 285 | `12417804` | App Store | 4 | en | 1 ADHD and similar | not said |
| 289 | `12422507` | App Store | 5 | ko | 3 Can't start or keep going | not said |
| 304 | `12428324` | App Store | 5 | en | 4 Mornings go badly | not said |
| 308 | `12431601` | App Store | 5 | en | 7 Overwhelmed | not said |
| 311 | `12458742` | App Store | 5 | ko | 3 Can't start or keep going | not said |
| 313 | `12459764` | App Store | 5 | es | 1 ADHD and similar | not said |
| 321 | `12434231` | App Store | 5 | en | 1 ADHD and similar; 3 Can't start or keep going | not said |
| 322 | `12463184` | App Store | 5 | en | 1 ADHD and similar; 4 Mornings go badly; 8 Parents and carers | not said |
| 327 | `12463642` | App Store | 5 | en | State only a goal | not said |
| 329 | `d1622eb5` | Play | 4 | en | 4 Mornings go badly; 5 Forget steps and small habits | not said |
| 330 | `12465341` | App Store | 5 | en | 1 ADHD and similar; 2 Lose time; 3 Can't start or keep going | not said |
| 334 | `12470101` | App Store | 5 | en | State only a goal | free |
| 346 | `12439307` | App Store | 5 | en | 1 ADHD and similar; 2 Lose time; 3 Can't start or keep going | not said |
| 347 | `12442067` | App Store | 3 | en | 2 Lose time | not said |
| 349 | `12474079` | App Store | 5 | en | 7 Overwhelmed | not said |
| 353 | `12485608` | App Store | 4 | en | State only a goal | not said |
| 357 | `12490763` | App Store | 5 | en | State only a goal | not said |
| 360 | `12492675` | App Store | 5 | en | 1 ADHD and similar; 2 Lose time | not said |
| 362 | `156994a3` | Play | 5 | en | State only a goal | not said |
| 366 | `8d399c6a` | Play | 5 | en | 1 ADHD and similar | not said |
| 379 | `12503333` | App Store | 5 | en | State only a goal | not said |
| 380 | `12532834` | App Store | 5 | en | State only a goal | free |
| 384 | `12536372` | App Store | 5 | en | 1 ADHD and similar | not said |
| 392 | `12512307` | App Store | 4 | en | 1 ADHD and similar | not said |
| 394 | `12513553` | App Store | 5 | en | State only a goal | not said |
| 401 | `12544130` | App Store | 4 | ja | State only a goal | not said |
| 402 | `12544440` | App Store | 5 | ko | State only a goal | paid |
| 403 | `12523518` | App Store | 4 | en | 1 ADHD and similar | not said |
| 407 | `416d9463` | Play | 5 | ko | 1 ADHD and similar | paid |
| 419 | `719b0fb1` | Play | 4 | en | 3 Can't start or keep going | free |
| 420 | `12506823` | App Store | 5 | en | 2 Lose time; 5 Forget steps and small habits; 8 Parents and carers | not said |
| 421 | `14d85746` | Play | 5 | ko | 1 ADHD and similar | not said |
| 434 | `12557553` | App Store | 5 | en | 2 Lose time; 6 Tried other apps, planners or paper | not said |
| 440 | `12585389` | App Store | 5 | en | 1 ADHD and similar; 6 Tried other apps, planners or paper | free |
| 444 | `192f4904` | Play | 4 | en | State only a goal | not said |
| 452 | `12598922` | App Store | 5 | en | 8 Parents and carers | not said |
| 461 | `12572469` | App Store | 5 | es | 6 Tried other apps, planners or paper | not said |
| 467 | `b96b7728` | Play | 4 | es | State only a goal | free |
| 469 | `12576810` | App Store | 5 | en | State only a goal | not said |
| 470 | `12555501` | App Store | 5 | ko | State only a goal | paid |
| 471 | `12562803` | App Store | 5 | en | 1 ADHD and similar | not said |
| 479 | `b5088eca` | Play | 5 | en | 1 ADHD and similar | not said |
| 480 | `64653b2e` | Play | 2 | en | 4 Mornings go badly | not said |
| 484 | `12622045` | App Store | 4 | en | 6 Tried other apps, planners or paper | not said |
| 486 | `ac3fcbd4` | Play | 1 | en | State only a goal | not said |
| 496 | `12614424` | App Store | 5 | de | State only a goal | not said |
| 497 | `afa06db4` | Play | 1 | en | State only a goal | not said |
| 502 | `12616659` | App Store | 5 | en | 1 ADHD and similar; 2 Lose time; 5 Forget steps and small habits | not said |
| 508 | `12632014` | App Store | 5 | en | State only a goal | paid |
| 511 | `12619513` | App Store | 5 | en | 8 Parents and carers | not said |
| 519 | `12614787` | App Store | 5 | en | State only a goal | not said |
| 522 | `12629348` | App Store | 5 | en | 3 Can't start or keep going | not said |
| 524 | `12634975` | App Store | 5 | en | State only a goal | not said |
| 544 | `12685058` | App Store | 5 | en | 2 Lose time; 5 Forget steps and small habits | not said |
| 552 | `ba945df6` | Play | 5 | en | 1 ADHD and similar | not said |
| 567 | `12641736` | App Store | 4 | ru | 2 Lose time; 3 Can't start or keep going | not said |
| 569 | `12655526` | App Store | 4 | ja | 5 Forget steps and small habits | not said |
| 570 | `12658218` | App Store | 5 | en | 1 ADHD and similar; 4 Mornings go badly | not said |
| 571 | `12670271` | App Store | 5 | en | State only a goal | not said |
| 573 | `12682810` | App Store | 4 | ja | 1 ADHD and similar; 4 Mornings go badly; 6 Tried other apps, planners or paper | not said |
| 574 | `12688377` | App Store | 5 | en | 2 Lose time | not said |
| 578 | `12701763` | App Store | 5 | ko | 4 Mornings go badly | not said |
| 579 | `12734741` | App Store | 5 | en | State only a goal | not said |
| 582 | `12704361` | App Store | 5 | en | 2 Lose time | not said |
| 587 | `12710625` | App Store | 5 | en | 1 ADHD and similar; 2 Lose time; 3 Can't start or keep going | paid |
| 589 | `12712004` | App Store | 5 | en | 1 ADHD and similar; 4 Mornings go badly | not said |
| 603 | `0f8a78d6` | Play | 2 | en | 2 Lose time | not said |
| 605 | `12731101` | App Store | 4 | en | State only a goal | not said |
| 615 | `12759884` | App Store | 4 | en | 6 Tried other apps, planners or paper | not said |
| 619 | `12737168` | App Store | 1 | en | 5 Forget steps and small habits; 6 Tried other apps, planners or paper | paid |
| 621 | `12740246` | App Store | 3 | en | 1 ADHD and similar; 2 Lose time | refused |
| 623 | `40242f2d` | Play | 5 | en | 1 ADHD and similar; 3 Can't start or keep going; 6 Tried other apps, planners or paper | free |
| 624 | `12747179` | App Store | 5 | en | State only a goal | not said |
| 628 | `92456d41` | Play | 5 | es | State only a goal | not said |
| 629 | `12766742` | App Store | 5 | en | State only a goal | not said |
| 630 | `12792671` | App Store | 5 | en | 1 ADHD and similar; 4 Mornings go badly; 5 Forget steps and small habits | not said |
| 632 | `12769141` | App Store | 5 | en | 1 ADHD and similar | not said |
| 633 | `12769367` | App Store | 4 | en | 3 Can't start or keep going; 7 Overwhelmed | not said |
| 634 | `12769744` | App Store | 5 | en | 1 ADHD and similar | not said |
| 635 | `12798009` | App Store | 5 | en | State only a goal | not said |
| 646 | `12779342` | App Store | 5 | ja | State only a goal | free |
| 647 | `12780143` | App Store | 1 | en | State only a goal | not said |
| 651 | `12780689` | App Store | 5 | en | 5 Forget steps and small habits | not said |
| 661 | `12790699` | App Store | 5 | en | 4 Mornings go badly; 5 Forget steps and small habits | not said |
| 662 | `12814625` | App Store | 3 | fr | State only a goal | not said |
| 664 | `b2ad4b01` | Play | 5 | en | 1 ADHD and similar | not said |
| 676 | `5023cf4c` | Play | 5 | ja | State only a goal | not said |
| 677 | `12820169` | App Store | 3 | en | 1 ADHD and similar | not said |
| 678 | `12844920` | App Store | 5 | en | 2 Lose time; 3 Can't start or keep going | not said |
| 680 | `12822219` | App Store | 5 | en | 1 ADHD and similar; 2 Lose time | not said |
| 681 | `12845166` | App Store | 5 | ja | 1 ADHD and similar; 2 Lose time | not said |
| 690 | `12827787` | App Store | 5 | pl | 3 Can't start or keep going | not said |
| 692 | `12828483` | App Store | 5 | en | 2 Lose time | not said |
| 698 | `12845872` | App Store | 4 | en | 2 Lose time; 3 Can't start or keep going | not said |
| 707 | `12822051` | App Store | 5 | en | State only a goal | not said |
| 710 | `12827274` | App Store | 5 | en | State only a goal | not said |
| 711 | `b8f77b8e` | Play | 4 | en | 1 ADHD and similar; 4 Mornings go badly | not said |
| 721 | `12845433` | App Store | 5 | ja | 1 ADHD and similar; 3 Can't start or keep going | not said |
| 722 | `12845443` | App Store | 2 | en | State only a goal | not said |
| 726 | `f8468cf7` | Play | 5 | es | 1 ADHD and similar | not said |
| 729 | `12877060` | App Store | 5 | ja | 2 Lose time | not said |
| 733 | `12877888` | App Store | 5 | en | State only a goal | not said |
| 743 | `12861507` | App Store | 5 | ko | 3 Can't start or keep going | not said |
| 746 | `12883310` | App Store | 5 | en | State only a goal | not said |
| 770 | `fe93abb1` | Play | 4 | en | 10 Follow a method | not said |
| 772 | `12876052` | App Store | 5 | en | 1 ADHD and similar; 6 Tried other apps, planners or paper | not said |
| 773 | `12881476` | App Store | 5 | ja | State only a goal | not said |
| 778 | `9794b3e8` | Play | 5 | es | State only a goal | not said |
| 791 | `57c669ed` | Play | 5 | de | 1 ADHD and similar | paid |
| 794 | `12926483` | App Store | 5 | ja | 3 Can't start or keep going | not said |
| 796 | `12915068` | App Store | 5 | en | 7 Overwhelmed; 8 Parents and carers | not said |
| 800 | `12926698` | App Store | 2 | en | 2 Lose time | not said |
| 805 | `d889bda4` | Play | 2 | en | State only a goal | not said |
| 807 | `12918871` | App Store | 5 | en | 3 Can't start or keep going | not said |
| 816 | `12911127` | App Store | 5 | en | 2 Lose time | paid |
| 819 | `12920796` | App Store | 5 | en | 2 Lose time; 3 Can't start or keep going | not said |
| 834 | `6cf0d609` | Play | 5 | en | 1 ADHD and similar; 7 Overwhelmed | not said |
| 835 | `12954702` | App Store | 5 | en | 5 Forget steps and small habits | not said |
| 837 | `12956678` | App Store | 5 | en | 4 Mornings go badly; 9 Lost their structure | not said |
| 842 | `713c6bfd` | Play | 5 | pt | 9 Lost their structure | not said |
| 847 | `12961134` | App Store | 5 | en | 2 Lose time | not said |
| 848 | `12936726` | App Store | 5 | en | 2 Lose time | not said |
| 867 | `12931105` | App Store | 5 | ko | 3 Can't start or keep going; 6 Tried other apps, planners or paper | not said |
| 871 | `12952781` | App Store | 5 | en | 1 ADHD and similar; 6 Tried other apps, planners or paper | not said |
| 887 | `68adc66c` | Play | 3 | ko | State only a goal | not said |
| 892 | `12988413` | App Store | 5 | en | State only a goal | not said |
| 908 | `12979356` | App Store | 5 | en | 4 Mornings go badly; 5 Forget steps and small habits; 8 Parents and carers | not said |
| 919 | `12976579` | App Store | 5 | en | State only a goal | not said |
| 921 | `12981307` | App Store | 5 | ja | State only a goal | not said |
| 924 | `12995259` | App Store | 5 | en | State only a goal | not said |
| 925 | `12995397` | App Store | 4 | en | State only a goal | not said |
| 926 | `13024058` | App Store | 5 | en | State only a goal | not said |
| 932 | `13025856` | App Store | 5 | en | 4 Mornings go badly | not said |
| 938 | `11625f15` | Play | 5 | en | 3 Can't start or keep going | not said |
| 953 | `13011730` | App Store | 5 | en | State only a goal | not said |
| 954 | `13012228` | App Store | 5 | en | 7 Overwhelmed | not said |
| 956 | `13032757` | App Store | 5 | ko | 6 Tried other apps, planners or paper | not said |
| 957 | `13014127` | App Store | 1 | en | 1 ADHD and similar | not said |
| 962 | `13020807` | App Store | 5 | nl | 6 Tried other apps, planners or paper | not said |
| 973 | `13019086` | App Store | 5 | en | 1 ADHD and similar | not said |
| 974 | `13031655` | App Store | 5 | ko | 3 Can't start or keep going; 5 Forget steps and small habits | not said |
| 978 | `e5ee564d` | Play | 5 | en | 1 ADHD and similar; 5 Forget steps and small habits | not said |
| 990 | `eadb5499` | Play | 1 | en | State only a goal | paid |
| 992 | `13063276` | App Store | 5 | en | State only a goal | not said |
| 994 | `13064087` | App Store | 4 | en | 4 Mornings go badly; 7 Overwhelmed | not said |
| 997 | `13044848` | App Store | 4 | en | State only a goal | free |
| 1003 | `13048791` | App Store | 5 | en | 2 Lose time | not said |
| 1018 | `13041479` | App Store | 5 | en | State only a goal | not said |
| 1021 | `13056607` | App Store | 5 | en | 2 Lose time; 7 Overwhelmed | not said |
| 1023 | `13072478` | App Store | 5 | en | 2 Lose time | not said |
| 1025 | `13073278` | App Store | 3 | en | 1 ADHD and similar; 5 Forget steps and small habits | not said |
| 1030 | `13093690` | App Store | 5 | en | 1 ADHD and similar | not said |
| 1035 | `db54f086` | Play | 5 | en | 1 ADHD and similar | not said |
| 1050 | `13088721` | App Store | 5 | ja | 2 Lose time | not said |
| 1051 | `13088824` | App Store | 4 | en | State only a goal | not said |
| 1062 | `13091389` | App Store | 5 | en | 6 Tried other apps, planners or paper | not said |
| 1066 | `13092402` | App Store | 5 | ja | 1 ADHD and similar; 2 Lose time | not said |
| 1067 | `13104145` | App Store | 5 | en | State only a goal | not said |
| 1072 | `13086335` | App Store | 4 | en | State only a goal | not said |
| 1074 | `13100664` | App Store | 4 | en | 1 ADHD and similar; 2 Lose time | paid |
| 1081 | `13126579` | App Store | 5 | ko | 2 Lose time | not said |
| 1084 | `13127372` | App Store | 5 | en | 4 Mornings go badly | not said |
| 1087 | `13127830` | App Store | 2 | en | State only a goal | not said |
| 1106 | `13138269` | App Store | 5 | en | 3 Can't start or keep going | not said |
| 1107 | `13119858` | App Store | 5 | de | 4 Mornings go badly | not said |
| 1109 | `13120403` | App Store | 5 | en | 2 Lose time; 5 Forget steps and small habits | not said |
| 1114 | `13120896` | App Store | 5 | en | 3 Can't start or keep going | not said |
| 1117 | `13121738` | App Store | 5 | en | 8 Parents and carers | not said |
| 1119 | `13124196` | App Store | 3 | en | 4 Mornings go badly; 5 Forget steps and small habits | not said |
| 1125 | `13137235` | App Store | 5 | en | 1 ADHD and similar | not said |
| 1129 | `8b9f72e6` | Play | 5 | en | 1 ADHD and similar | not said |
| 1134 | `9726d7a9` | Play | 5 | en | State only a goal | not said |
| 1141 | `13174756` | App Store | 5 | en | 1 ADHD and similar | not said |
| 1143 | `5eef5b99` | Play | 5 | en | 2 Lose time; 4 Mornings go badly | not said |
| 1148 | `13177355` | App Store | 5 | en | 3 Can't start or keep going; 4 Mornings go badly | not said |
| 1149 | `13149754` | App Store | 5 | en | 2 Lose time; 3 Can't start or keep going | not said |
| 1150 | `163b85bc` | Play | 2 | en | 2 Lose time; 4 Mornings go badly | not said |
| 1153 | `13150817` | App Store | 5 | en | 5 Forget steps and small habits | not said |
| 1160 | `13183836` | App Store | 5 | ko | 3 Can't start or keep going | not said |
| 1168 | `13166666` | App Store | 5 | en | State only a goal | not said |
| 1171 | `4f21117d` | Play | 5 | ko | State only a goal | not said |
| 1172 | `e0742977` | Play | 5 | en | 2 Lose time | paid |
| 1173 | `13159440` | App Store | 5 | fr | 1 ADHD and similar; 3 Can't start or keep going; 4 Mornings go badly | not said |
| 1175 | `13186621` | App Store | 4 | ja | 1 ADHD and similar; 2 Lose time; 8 Parents and carers | paid |
| 1176 | `13216659` | App Store | 4 | en | 2 Lose time | not said |
| 1186 | `13220167` | App Store | 5 | en | 1 ADHD and similar; 2 Lose time | not said |
| 1202 | `13227657` | App Store | 5 | en | 1 ADHD and similar | not said |
| 1212 | `13215301` | App Store | 4 | en | 2 Lose time | not said |
| 1218 | `516a96e0` | Play | 4 | en | 2 Lose time | not said |
| 1222 | `f3397d6e` | Play | 5 | en | State only a goal | not said |
| 1223 | `13224248` | App Store | 5 | en | 1 ADHD and similar | not said |
| 1228 | `13233621` | App Store | 5 | en | 2 Lose time | not said |
| 1233 | `13235258` | App Store | 5 | en | State only a goal | not said |
| 1234 | `13235496` | App Store | 5 | en | 2 Lose time | not said |
| 1235 | `b2ed63ef` | Play | 5 | de | State only a goal | not said |
| 1237 | `7a389b32` | Play | 4 | en | 1 ADHD and similar | not said |
| 1238 | `ac6746be` | Play | 5 | ko | State only a goal | not said |
| 1246 | `bef3f8f2` | Play | 5 | en | 2 Lose time | not said |
| 1248 | `13246506` | App Store | 5 | en | 2 Lose time | not said |
| 1258 | `fbe9a38a` | Play | 5 | fr | 1 ADHD and similar; 8 Parents and carers; 9 Lost their structure | not said |
| 1261 | `13265373` | App Store | 5 | en | State only a goal | not said |
| 1263 | `13268140` | App Store | 4 | fr | 2 Lose time; 7 Overwhelmed | not said |
| 1267 | `13246617` | App Store | 5 | ko | State only a goal | not said |
| 1269 | `13257733` | App Store | 5 | en | 1 ADHD and similar | not said |
| 1272 | `13259393` | App Store | 5 | ko | 2 Lose time; 7 Overwhelmed | not said |
| 1275 | `13263494` | App Store | 4 | en | 1 ADHD and similar | not said |
| 1290 | `13278570` | App Store | 4 | en | 1 ADHD and similar; 9 Lost their structure | refused |
| 1302 | `13290711` | App Store | 5 | en | 2 Lose time; 3 Can't start or keep going | not said |
| 1310 | `13293644` | App Store | 5 | en | State only a goal | not said |
| 1311 | `13322087` | App Store | 5 | en | 1 ADHD and similar | not said |
| 1317 | `13323483` | App Store | 5 | en | 3 Can't start or keep going | not said |
| 1321 | `15b49d01` | Play | 5 | en | 4 Mornings go badly; 8 Parents and carers | not said |
| 1322 | `13317314` | App Store | 5 | ko | 6 Tried other apps, planners or paper | not said |
| 1323 | `13318004` | App Store | 1 | en | 1 ADHD and similar; 5 Forget steps and small habits | not said |
| 1324 | `13329626` | App Store | 5 | en | 1 ADHD and similar | not said |
| 1325 | `13323018` | App Store | 2 | ja | State only a goal | not said |
| 1329 | `13333169` | App Store | 5 | en | 2 Lose time | not said |
| 1330 | `13360994` | App Store | 4 | en | 2 Lose time; 3 Can't start or keep going; 4 Mornings go badly | free |
| 1332 | `13361043` | App Store | 5 | en | 6 Tried other apps, planners or paper | not said |
| 1335 | `13337327` | App Store | 5 | en | 4 Mornings go badly | not said |
| 1343 | `6e93f301` | Play | 5 | en | 1 ADHD and similar | not said |
| 1346 | `13343765` | App Store | 5 | ko | 3 Can't start or keep going; 7 Overwhelmed | not said |
| 1348 | `13344868` | App Store | 5 | en | State only a goal | not said |
| 1364 | `13356551` | App Store | 5 | en | 1 ADHD and similar; 6 Tried other apps, planners or paper | not said |
| 1369 | `13336308` | App Store | 5 | en | 1 ADHD and similar; 4 Mornings go badly; 5 Forget steps and small habits | not said |
| 1375 | `13362713` | App Store | 4 | ja | State only a goal | not said |
| 1378 | `13381742` | App Store | 5 | en | 2 Lose time | not said |
| 1397 | `13411638` | App Store | 5 | en | 8 Parents and carers | not said |
| 1405 | `13413544` | App Store | 5 | en | 5 Forget steps and small habits | not said |
| 1417 | `8d0f8458` | Play | 2 | en | 1 ADHD and similar | free |
| 1418 | `13416875` | App Store | 5 | es | 6 Tried other apps, planners or paper | not said |
| 1419 | `13397217` | App Store | 5 | en | State only a goal | not said |
| 1433 | `d210b418` | Play | 5 | en | 3 Can't start or keep going | not said |
| 1440 | `13442882` | App Store | 5 | en | 4 Mornings go badly | not said |
| 1447 | `292611ca` | Play | 5 | de | 4 Mornings go badly | not said |
| 1458 | `13446802` | App Store | 5 | en | 3 Can't start or keep going | not said |
| 1464 | `13447962` | App Store | 5 | en | 7 Overwhelmed | not said |
| 1467 | `13450325` | App Store | 5 | en | 1 ADHD and similar; 5 Forget steps and small habits | not said |
| 1472 | `13436267` | App Store | 5 | en | 2 Lose time | not said |
| 1473 | `13441105` | App Store | 4 | ja | 1 ADHD and similar | not said |
| 1482 | `13454877` | App Store | 5 | ko | 10 Follow a method | not said |
| 1484 | `13477790` | App Store | 5 | en | 8 Parents and carers | not said |
| 1487 | `13482391` | App Store | 5 | en | 1 ADHD and similar | not said |
| 1502 | `8d9f5d47` | Play | 5 | en | 9 Lost their structure | not said |
| 1504 | `13466318` | App Store | 5 | en | State only a goal | not said |
| 1505 | `13466771` | App Store | 5 | en | State only a goal | not said |
| 1520 | `13452925` | App Store | 5 | en | 1 ADHD and similar; 2 Lose time | not said |
| 1522 | `13463871` | App Store | 5 | en | 2 Lose time | not said |
| 1523 | `13469367` | App Store | 2 | en | 1 ADHD and similar | paid |
| 1524 | `13485138` | App Store | 5 | en | 3 Can't start or keep going; 4 Mornings go badly | not said |
| 1525 | `13487673` | App Store | 5 | ja | 4 Mornings go badly; 5 Forget steps and small habits | not said |
| 1527 | `13495875` | App Store | 5 | en | 2 Lose time | not said |
| 1545 | `13503431` | App Store | 5 | en | 1 ADHD and similar; 2 Lose time | free |
| 1558 | `13528082` | App Store | 5 | en | 3 Can't start or keep going | not said |
| 1563 | `13529738` | App Store | 5 | en | 1 ADHD and similar | not said |
| 1565 | `81225ee7` | Play | 5 | en | 4 Mornings go badly | not said |
| 1569 | `13509163` | App Store | 5 | en | 2 Lose time | not said |
| 1572 | `13518248` | App Store | 3 | en | 1 ADHD and similar | paid |
| 1577 | `13535253` | App Store | 2 | en | 1 ADHD and similar | not said |
| 1583 | `b2880169` | Play | 5 | en | 6 Tried other apps, planners or paper | not said |
| 1584 | `501e7de8` | Play | 2 | it | 1 ADHD and similar | free |
| 1586 | `13568781` | App Store | 1 | en | 7 Overwhelmed | not said |
| 1587 | `13538905` | App Store | 5 | en | 2 Lose time; 4 Mornings go badly; 5 Forget steps and small habits | not said |
| 1597 | `13548134` | App Store | 5 | ko | State only a goal | not said |
| 1602 | `a7733fa5` | Play | 5 | en | 2 Lose time | not said |
| 1604 | `13549556` | App Store | 4 | en | 1 ADHD and similar; 4 Mornings go badly | not said |
| 1612 | `13553552` | App Store | 5 | en | 1 ADHD and similar; 4 Mornings go badly | not said |

330 people: 237 in at least one pain-point group, 93 with a goal only. Checked: every ID in this report is in `Review Labels/Routinery/2025/reviews.jsonl`.
