# MyRoutine 2021: User Groups, Why They Use It, and What They Pay For

Written by Claude (Claude Code), 27 November 2026, at the user's request.

**What this is.** MyRoutine's target users as its 2021 reviews show them, the way UX user research describes them: the
groups of people who use it, each defined by the **pain point** that brought them; why each group uses it; whether each
group pays, how many, and for what; and which free features each group likes. The second year of a series (2020 is
[here](<MyRoutine 2020 — User Groups, Why They Use It, and What They Pay For.md>)).

**How it was done.** From MyRoutine's labels alone, as research for a new product or a full rebuild. **The groups were
made from this year's own words:** I read every `who` and `why_chose` of 2021 and put together the people who say the
same pain. Where a 2021 pain is the same as one of 2020's, it keeps 2020's group so the years compare; **four groups are
new this year** because 2021's words show pains 2020's didn't (time slipping away, days with no steady shape, wanting
to be seen, having neglected oneself), and one 2020 group (not knowing what routine to make) has no one this year. No
other app's groups, and no product of ours, were used to choose, read or group anything.

**Source.** The checked labels for all 387 reviews of 2021 in `Review Labels/MyRoutine/2021/labels.jsonl` (each made
by reading one review, in its own language, and checked by a second reader). Every number and quote here comes from
the label fields, not from rereading the reviews:

- **Groups:** from `who` (what people say about themselves) and `why_chose` (the need or struggle that brought them).
  78 reviews have either; 25 say a pain, 11 only a goal, and 42 only a device, an identity or how they found the app.
  One person can be in more than one group.
- **Features liked:** from `liked` and `chose_for`, sorted into kinds by the words in each feature, every kind's
  matches checked by hand (2021's traps are in [README.md](<README.md>)).
- **Paying:** from `paid` (`paid`, `trial`, `charged_unexpectedly`, `refused`, `free` or `not_said`) and its reason,
  plus the labellers' `note` where someone says they *would* pay.
- **What's broken and wished for:** from `problems` (`broken`, `missing`, `dislike`), sorted by hand.

Quotes are the labels' own exact quotes, in Korean, with a translation. Review IDs are shortened to their first 8
characters; the appendix maps every group member to its line in the labels file. The map is saved as
[`Tools/groups_2021.py`](<Tools/groups_2021.py>); [README.md](<README.md>) explains the method.

---

## The short answer

- **387 reviews** (132 App Store, 255 Google Play), **98% in Korean** (379; 7 English, 1 Persian), average 4.12★, from
  3 January to 31 December 2021. Three times 2020's half-year, with **103 in December alone**. **25 people (6.5%) name a
  pain point**; 11 more name only a goal ("build habits", "manage my time"); most of the rest say what they like or,
  very often, what's broken.
- **The target users are people who know what to do but don't do it, people whose old way of keeping track didn't fit,
  and people whose time or days won't hold a routine.** Eight groups, by the pain point in their own words:

| # | User group (the pain point) | People | Share of the 25 | ★ | Paid |
|---|---|---|---|---|---|
| 1 | **Know what to do but don't do it:** lazy, procrastinate, leave things to the deadline, plans never finished | 6 | 24% | 5.00 | 0 (1 free) |
| 2 | **Their way of keeping track didn't fit:** hopped between apps, deleted them in days, apps too complex or too plain, a missed day meant starting over | 6 | 24% | 4.83 | 0 |
| 3 | **Time slips away** *(new)*: too much to do for the hours, planning itself eats time, routines with no set time don't happen | 5 | 20% | 4.20 | 0 |
| 4 | **Their days have no steady shape** *(new)*: shift work, an irregular life lately, a new job, recovering from surgery | 4 | 16% | 5.00 | 0 |
| 5 | **Start, then give up within days:** three-day resolve (작심삼일), willpower that fades | 3 | 12% | 5.00 | 0 |
| 6 | **Forget things:** medicine, the routine itself | 2 | 8% | 5.00 | 0 |
| 7 | **Keep going when others can see them** *(new)* | 1 | 4% | 5.00 | 1 |
| 8 | **Feel they've been neglecting themselves** *(new)* | 1 | 4% | 5.00 | 0 (1 trial) |

  (Three people are in two groups, so the shares add up to more than 100%. **These are small numbers:** 25 people, 14
  of them writing in November or December; see Limits.)

- **Why they use it, in one line: each group values what its pain lacked.** People whose tracking didn't fit value a
  **forgiving, encouraging tracker** (4 of 6: the traffic light, "it's okay to rest", a rest button and holidays that
  let them start again, badges that feel like a game). People who don't act value **seeing what they did and a
  gentler bar** (a challenge routine apart from the basic ones, so a part-done day isn't a failure) and a clean look.
  People short of time or with shifting days want the app to **hold the time for them** (set times, a whole day's
  routine to switch by shift) and are the most critical: two of the five short of time rate it 3★, for slowness and
  fiddly time entry. Other people's routines, the social side 2020's groups named most, is named by 5 of the 25.
- **How it helps them:** 30 people say what changed: **days fuller and more regular (9), acting instead of putting
  off (5), habits taking hold (5), a missed day hurting less (4)**. They credit a pull and a cushion together: small
  wins they can see, the green light and badges that can be lost, and a bar that forgives (rest, holidays, a gentler
  challenge routine). For people whose tracking didn't fit, the help is simply that they stayed.
- **Paying: 20 of 387 say they paid (5.2%); 20 of the 41 who say anything about it.** **2021 is the year a paywall
  appears in the reviews:** a Premium membership (monthly or yearly) with a **three-week free trial** from January, a
  **free plan capped at 10 routines** by August and **15** from October. Payers pay for **the whole app**: 8 of the 20
  say they liked the whole app, often the best of those they tried (two after a single day), one to "invest" in it, one for "a feature
  they wanted"; 10 give no reason. **Half the payers (10 of 20) report something broken**, and two want a refund or
  can't cancel. 7 refuse: the free limit, a subscription instead of one payment, the price, or an app too unstable to
  charge for.
- **Bugs and the widget are the year's other story:** **149 of 387 reviews (38%) report something broken**, mostly the
  app not opening (34) or being slow (25). **The widget is the most-asked-for thing of the year:** 41 reviews, 27 of
  them iPhone users asking for one (it reached the iPhone at the very end of December), while 26 Android users report
  the widget they had since spring flickering, blank or stuck loading.
- **Free features the whole year likes** (198 name one): **simple, clean and easy (57)**, the look and cute design (24),
  encouragement and a sense of achievement (22), checking off the day at a glance (16), a responsive developer (15),
  building habits that last (13), the Android widget (9), other people's routines (8).

---

## 1. The year in numbers

| | Count | Share of 387 |
|---|---|---|
| Reviews | 387 | 100% |
| App Store / Google Play | 132 / 255 | 34% / 66% |
| Language | Korean 379, English 7, Persian 1 | 98% / 2% / 0.3% |
| Ratings 5★ / 4★ / 3★ / 2★ / 1★ | 228 / 62 / 46 / 19 / 32 | 59% / 16% / 12% / 5% / 8% |
| Say who they are (`who`) | 40 | 10% |
| Say why they came (`why_chose`) | 51 | 13% |
| Name a pain point (any group below) | **25** | **6.5%** |
| Name only a goal ("build habits", "manage my time") | 11 | 2.8% |
| Name a feature they like | 198 | 51% |
| Say anything about paying | 41 | 11% |
| Report something broken | 149 | 38% |
| Wish for something missing | 127 | 33% |
| Dislike something | 66 | 17% |
| Still using / about to quit / quit / came back / not said | 288 / 16 / 9 / 6 / 68 | 74% / 4% / 2% / 2% / 18% |
| Developer replied | 229 | 59% |

By month: January 36, February 8, March 13, April 15, May 13, June 20, July 19, **August 37**, September 27, **October
40, November 56, December 103**. Reviews grew through the autumn and December alone holds 27% of the year; the reviews
don't say why. Google Play now holds two thirds of them (it was 45% in 2020). The English reviews are mostly short and
low: three ask for an English version (`bae7c7b8`, `7ae04d1b`, `73f4d5e4`) and one can't open the app (`e5c2b3d9`).

---

## 2. The user groups

Each group is the people whose own words describe that pain point. ★ is the group's average rating.

### Group 1. Know what to do but don't do it (6 people, 24% of those naming a pain point, 5.00★)

**Who they are:** people who know the plan and don't carry it out. In 2021 they call themselves **lazy** (게으른, three
of them), a procrastinator, the "extreme P" type who crams before deadlines, or someone who plans and never finishes.
4 are only in this group; one also gives up within days (group 5), one is also short of time (group 3). All six rate
5★; three wrote in November or December.

**Why they use it:**
- *"게으른 완벽주의자였던 제가"*, "I, who was a lazy perfectionist" (`223585e2`, 5★), who also *"다이어리를 사고 매일
  버리기만 했던"*, "kept buying diaries and giving up on them every day".
- *"항상 계획만 세우다 다 못하고 그러면 또 나한테 실망하고 그랬는데"*, "I'd always just make plans, not finish them,
  and then be disappointed in myself again" (`48873f2f`, 5★, studying for exams, home late at night).
- *"극단적인 P형인데"*, "I'm an extreme P type", one who does *"해야할 일을 매번 마감일이 가까워졌을 때 몰아 하는"*,
  "everything I have to do in one rush as the deadline gets close" (`74162386`, 5★).
- *"게으른 절 바르게 해주는것같아요"*, "it seems to straighten out lazy me" (`0785f7c3`, 5★).
- *"미루는 습관 탈출할 수 있을 것 같아요"*, "I think I can escape my habit of putting things off" (`80394456`, 5★).
- *"게으른 저의 성향 탓도 있지만"*, "it's partly my lazy nature, but…" (`81322773`, 5★, on the free plan, first day).

**Free features they like** (all 6 name one): **seeing their own record and a gentler bar**, more than any named
feature kind. One sets a **challenge routine** apart from the basic ones: *"도전루틴만 성공만 해도 만족도가 높아서
실망,자책하는 느낌이 줄어드는 것 같아서 더 좋아요"*, "even if I only succeed at the challenge routine I'm satisfied, so
the feeling of disappointment and blaming myself seems to shrink" (`48873f2f`). Another values *"시각적으로 내가 지킨
결과를 확인"*, "seeing, visually, what I kept" and *"내가 어느 부분이 부족한지 확인해 계획을 다시 수정"*, "seeing which
part I'm short on and revising the plan" (`74162386`). By kind: the look and a clean design (2), simple and intuitive
(2), other people's routines (1), a separate alarm for each item (1). **Two of the six want a widget** (`80394456`,
`81322773`): *"너무 좋은데 위젯만"*, "it's great, only the widget…", and *"제발 위젯 만들어주세요"*, "please,
make a widget" (`80394456`).

**What they say changed:** *"일상을 알차게 보내게 되었어요"*, "I've come to spend my days fully" (`223585e2`, over a
year in); *"허투루 쓰는 시간을 줄일 수 있었어요"*, "I could cut the time I waste" (`74162386`).

**Paying:** none say they paid; one is on the free plan (`81322773`); 5 don't say.

### Group 2. Their way of keeping track didn't fit (6 people, 24%, 4.83★)

**Who they are:** people who had tried other apps and left them: an *"어플 유목민"*, "app nomad"; someone who deleted any
app at the slightest dislike; apps dropped within days as a bother; apps *"너무 복잡하거나 너무 심플하고"*, "too complex
or too plain"; and one whose old app made a fresh start after failing feel impossible. All 6 are only in this group;
five rate 5★, one 4★.

**Why they use it:**
- *"드디어 정착할 어플을 찾았어요"*, "I've finally found an app to settle on" (`69531729`, 4★).
- *"제가 루틴 앱이나, 투두 앱을 선택할 때 조금이라도 마음에 안 들면 바로 삭제해버렸는데"*, "when I chose a routine or
  to-do app, I'd delete it straight away if there was anything at all I didn't like" (`78355712`, 5★).
- *"어플 유목민이였는데"*, "I was an app nomad" (`952f894f`, 5★).
- *"기존앱은 실패하고나면 다시 시작하는게 엄두가 안났는데"*, "with my old apps, once I failed I couldn't face starting
  again" (`3b12f8e1`, 5★).
- *"다른 앱은 귀찮아서 몇일만에 지웠는데"*, "other apps were a bother and I deleted them within days" (`b1e6fbb3`, 5★).
- *"너무 복잡하거나 너무 심플하고 계속 쓰고싶은 재미가 없었다"*, "[other apps] were too complex or too plain, and had no
  fun that made me want to keep using them" (`81748005`, 5★).

**Free features they like** (all 6 name one): **encouragement that forgives (4 of 6, more than any other group)**: the
traffic light that turns green as routines are done, being told rest is fine, a rest button and holidays, badges.
- *"루틴을 하지 못 해도 쉬어도 괜찮다고 해주고"*, "even when I can't do a routine, it tells me it's okay to rest"
  (`78355712`).
- *"마이루틴은 휴가기능, 쉼버튼이 있어서 언제든지 다시 도전할 수 있어서"*, "MyRoutine has a holiday feature and a rest
  button, so I can try again any time" (`3b12f8e1`): the answer to their pain in their own words.
- *"세세하게 못짜서 오히려 강박관념이 없는 느낌입니다"*, "you can't plan in fine detail, so it actually feels free of
  obsession" (`952f894f`).
- *"이모니콘 설정/뱃지 획등 등등 약간 게임을 하는것같은 기분이 들고"*, "setting emoticons, earning badges and so on
  feels a bit like playing a game" (`81748005`).

Also other people's routines (2: *"다른 루티너들 보면서 동기부여를 하는데"*, "I get motivated watching other
routiners", and *"또 SNS 같지는 않아서 좋아요"*, "and it's good that it doesn't feel like a social network", `78355712`), simple
and readable (1), the Android widget (1: *"핸드폰을 켜자마자 볼수 있다는게 장점"*, "being able to see it as soon as I turn
the phone on is the plus", `b1e6fbb3`).

**Paying:** none say. One asks to keep the 15 free routines and would buy it at once **if there were a one-time
lifetime purchase** (`81748005`).

### Group 3. Time slips away (5 people, 20%, 4.20★) *(new in 2021)*

**Who they are:** people for whom the problem is the clock: too much to fit into the day, a new field to learn, the
time making plans itself takes, or routines that never happened because they had no set time. 3 are only in this
group; one is also in group 1, one in group 4. **The most critical group:** two rate 3★.

**Why they use it:**
- *"하루에 해야할 게 많아서 시간이 촉박한 편이라"*, "I have a lot to do each day, so I'm usually pressed for time"
  (`5805cb99`, 3★).
- *"계획을 세우는 시간을 줄이고자 이 앱을 사용합니다"*, "I use this app to cut the time I spend making plans" (`c5a30769`,
  3★).
- *"루틴대로 못했던 이유가 명확한 시간설정이 안되있어서 그랬던거군요"*, "so the reason I couldn't keep to my routines was
  that they had no clear time set" (`77650939`, 5★).
- *"공부하고 익숙해져야하는게 많아서"*, "there's a lot to study and get used to" (`77551168`, 5★, three months into a new
  industry).
- Studying for exams and home late at night (`48873f2f`, also group 1).

**Free features they like** (4 of 5 name one): few feature kinds fit; what they name is **time saved**: *"소소하게
버리는 시간이 거의 줄었습니다"*, "the little bits of time I used to throw away have almost gone" (`77551168`), and other
people's routines and the challenge routine (`48873f2f`). The developer (`77650939`: *"고객의 고민을 제대로 캐치해"*,
"really caught what customers worry about").

**What they want and dislike** is the clearer signal: things that cost them time. *"앱 반응속도가 느린 게 상당히
짜증나요"*, "the app's slow response is quite annoying", saving and notifications that arrive late, an extra step to add or move a routine
(`5805cb99`); reminder times that can't be typed, no "10 minutes before" choice, no routine every few weeks, no
landscape view (`c5a30769`); schedules and plans beside routines, routines inside routines, colours for morning,
afternoon and evening (`77650939`); more than 23 routines a day (`77551168`).

**Paying:** none say.

### Group 4. Their days have no steady shape (4 people, 16%, 5.00★) *(new in 2021)*

**Who they are:** people whose days don't repeat: a shift nurse on morning, afternoon and night shifts; someone whose
life *"요즘 너무 일상히 규칙적이지 않기도"*, "hasn't been regular lately"; someone managing their days after surgery; and
someone who changed industries three months ago (also group 3). Three wrote in December 2021. All rate 5★.

**Why they use it:**
- *"저도 그렇고 교대근무 하는 사람들은 생활패턴 루틴을 정해놔도 매일 챙겨야하는 시간이 다르니 그게 너무
  불편하거든요"*, "for me and for anyone doing shift work, even once you set a daily routine, the times you have to keep
  differ every day, and that's really awkward" (`c607d2b5`).
- *"수술후 일정관리"*, "managing my schedule after surgery" (`d11aff78`).
- *"요즘 너무 일상히 규칙적이지 않기도"*, "my days have not been regular lately", and *"꼭 고치고 싶은 습관이
  있어서"*, "there's a habit I really want to fix" (`41b41d83`).
- *"그동안 오래 해온 일을 그만두고 다른 업계로 이직한지 3개월차"*, "three months since I left the work I'd done for a long
  time for another industry" (`77551168`).

**Free features they like:** no feature kind; three like it in general (*"다른기능은 정말 너무 완벽한거 같아요"*, "the
other features seem really perfect", `c607d2b5`). **What they lack is a routine that follows the day:** the nurse asks
for a way to group a whole day's routine and switch it day by day.

**Paying:** none say they paid; the nurse **says they'll pay for premium straight away** (labellers' note; not a
purchase).

### Group 5. Start, then give up within days (3 people, 12%, 5.00★)

**Who they are:** people who start and stop: everything lasts three days, willpower fades, diaries bought and dropped.
Two are only in this group; one is also in group 1.

**Why they use it:**
- *"끈기가 부족하달까 뭐든 작심삼일이라 루틴만드는 일이 정말 어려운 사람인데"*, "I lack perseverance, I guess; everything
  lasts three days, so building routines is really hard for me" (`80483937`).
- *"의지가 약해지는걸 막아줍니다"*, "it stops my willpower from weakening" (`06f273e9`, a tablet user).
- Diaries bought and given up on every day (`223585e2`, also group 1).

**Free features they like:** encouragement and other people (`80483937`: *"중간중간 칭찬으로 당근도 주고"*, "it gives
carrots along the way with praise", and *"여러분들의 루틴을 공유하며 긍정적인 자극도 받을 수 있어"*, "sharing everyone's
routines gives a positive push"); a responsive developer (2: *"개발자/업체의 피드백이 즉각적이다"*, "the developer's
feedback is immediate", `06f273e9`); intuitive and easy to set up; *"알람보다 더 효과가 좋다"*, "it works better than
alarms" (`06f273e9`).

**Paying:** none say.

### Group 6. Forget things (2 people, 8%, 5.00★)

Medicine and the routine itself. *"알람 기능도 있어서 까먹지 않아서 좋아요"*, "it has an alarm feature too, so I don't
forget" and *"앱 설치한 이후 약도 시간내로 잘 먹고 있습니다"*, "since installing it I take my medicine on time"
(`79431633`); *"루틴이 눈에 보이니까 잊어버리지 않고 잘 실천할 수 있었어요"*, "because I can see my routines, I don't forget
and I keep to them" (`31fcac6d`). **They like the alarm and seeing the list.** Neither mentions paying.

### Group 7. Keep going when others can see them (1 person, 5.00★) *(new in 2021)*

*"저는 다른 사람의 시선을 의식하며 자극을 얻고, 그걸 원동력으로 규칙적인 생활을 하곤 하는데"*, "I get a push from being
aware of other people's eyes, and use that as the drive to live regularly" (`d00edbac`, January). **The only person with
a pain point who says they paid** (*"정기권을 사용해서"*, "I'm on a subscription"). What they want shows the need: a
feed where routiners post their plans, today's completion as a percentage, reminders, and a motivating message after a
long gap.

### Group 8. Feel they've been neglecting themselves (1 person, 5.00★) *(new in 2021)*

*"제 자신에게 너무 소홀했던 것 같았는데"*, "I felt I'd been neglecting myself too much" (`78712083`, October, an iPhone 6
user near the end of the three-week trial). They name the most liked features of anyone: the **reflection** to wrap up
the day (*"회고로 절 챙기게 되었습니다"*, "through the reflection I've come to look after myself"), short memos for weight
or water, long memos for book pages, morning, lunch and evening routines, other people's routines to browse and copy,
private routines, a cute design. They plan to subscribe when the trial ends, but the app crashes on opening even after
three reinstalls; they want dark mode and a widget.

### People who name only a goal (11 people, 4.00★)

Not a pain-point group: they say what they want but not what's wrong: self-care kept up (`70634606`), building habits
(`0c24bc52`, `0c78e619`), managing their time (`6150eed0`, `781e76ae`), a planned life (`e573f278`), daily habits on an
iPad (`78916119`), living by routines (`e4a37465`). They like building habits, checking off the day, encouragement and
the developer (2 each): *"초록불 꾸준히 달성하고 회고 꾸준히 쓰면 뱃지 주는 게 진짜 신의 한수"*, "giving a badge for
steadily hitting green and writing reflections is a real stroke of genius" (`e573f278`). **Unlike 2020's goal-only
people, three rate it low because it wasn't what they came for:** routines blocked at the free limit (*"저장하기 버튼을
누르니 프로 멤버십을 가입하라는 문자가 뜨고 저장을 못합니다"*, "when I press save, a message tells me to join the Pro
membership and I can't save", `6428e39d`, 3★); a to-do list where they wanted a timetable (`e8fc0fca`, 2★); all their
plans wiped by one wrong tap (`cb9365ae`, 1★). One paid after a single day (`781e76ae`); one won't pay for a
subscription (`0c78e619`).

---

## 3. How the app helps them

What people say the app **does for them**, as opposed to which feature they like: from the same `liked` and
`chose_for` labels, read one by one and kept only where the words describe a change in their days or in themselves.
**30 of the 198 people who name a like say how it changed something**; all 30 rate it 5★, and only four say how long
they've used it (over a year `223585e2`, almost three weeks `78712083`, ten days `3d54f4f8`, a week `4aa8ddad`).

### What changes for them

| What changes (one review can say several) | Reviews | IDs |
|---|---|---|
| **Their days feel fuller and more regular** | 9 | `223585e2`, `951bdfb0`, `74162386`, `b5d00111`, `688f24cd`, `2ac4ddd5`, `39203e59`, `4aa8ddad`, `e573f278` |
| **They act instead of putting things off; their willpower holds** | 5 | `8ed2ca8a`, `0785f7c3`, `1c41b5ee`, `06f273e9`, `f05bee19` |
| **Habits take hold** | 5 | `72897581`, `1f92f668`, `61669a51`, `3af1bf06`, `fde24388` |
| They feel better about themselves, and a missed day hurts less | 4 | `7b5c2249`, `68595910`, `48873f2f`, `3b12f8e1` |
| They get to know and look after themselves | 4 | `72897581`, `3f991e6d`, `3d54f4f8`, `78712083` |
| Less time wasted | 3 | `751b5f83`, `74162386`, `77551168` |
| They don't forget (medicine, the routine) | 2 | `79431633`, `31fcac6d` |

In their words:
- *"어플로 인해 규칙적이고 알차게 사려고 노력하는 내 모습을 발견하게 되어서 너무 행복합니다"*, "I'm so happy to find
  myself trying to live regularly and fully because of the app" (`4aa8ddad`, a week in).
- *"앱 쓰면서 하루를 더 알차게 보내게 되네요"*, "using the app, I spend my days more fully", and *"하루하루
  뿌듯해집니다"*, "every day I feel proud" (`b5d00111`).
- *"눈에 딱 보이게 할일들 보여주니깐 하게되는 느낌"*, "it shows my tasks right where I can see them, so I feel I end up
  doing them", and *"실행력이 올라갑니다"*, "my follow-through goes up" (`8ed2ca8a`).
- *"의지박약인 사람들에게 든든한 벗이 되어줍니다"*, "it's a reliable friend for people with weak willpower" (`1c41b5ee`).
- *"제 생활은 마이루틴을 사용하기 전과 후로 나뉘어요"*, "my life divides into before and after MyRoutine" (`fde24388`);
  *"이 앱으로 제 습관이 달라졌어요"*, "my habits changed with this app" (`3af1bf06`).
- *"쉬어가는 표현으로 루틴을 달성하지 못했을때의 박탈감도 적어요"*, "because it words it as taking a rest, I feel less
  deprived when I don't manage a routine" (`68595910`); *"저도 더 바르게 살고 싶어지고 자존감도 올라가더군요"*, "I
  find myself wanting to live better, and my self-esteem goes up" (`7b5c2249`, from its kind wording).
- *"나를 알수있게되요"*, "I come to know myself" (`3f991e6d`); *"하루를 잘 돌아볼 수 있는 계기가 됬어요"*, "it gave me a
  reason to look back on my day properly" (`3d54f4f8`).
- *"앱 설치한 이후 약도 시간내로 잘 먹고 있습니다"*, "since installing the app I take my medicine on time" (`79431633`).

### How it does it, in their words

| What does it | Reviews | IDs |
|---|---|---|
| **Small wins they can see:** ticking off one by one, the light turning green, feeling proud each time | 9 | `4b06ec73`, `63d8b9c6`, `2be35dfd`, `b5d00111`, `966bc28b`, `422df19f`, `b59c1d37`, `35c00500`, `6150eed0` |
| **Seeing the plan:** routines in view, the week at a glance, the widget, the results kept and what's lacking | 9 | `981b6aba`, `74162386`, `8ed2ca8a`, `31fcac6d`, `66324847`, `b1e6fbb3`, `8923d64b`, `f504e438`, `e6d380fd` |
| **A bar that forgives:** rest and holidays, a challenge routine apart from the basic ones, no obsession, a steady pace rewarded over many routines | 8 | `68595910`, `48873f2f`, `0c24bc52`, `78355712`, `78842383`, `952f894f`, `3b12f8e1`, `f504e438` |
| **A reflection at the end of the day** | 8 | `72192782`, `72897581`, `3f991e6d`, `3d54f4f8`, `78712083`, `781e76ae`, `fde24388`, `e573f278` |
| **Rewards that can be lost:** badges, levels | 6 | `966bc28b`, `2ac4ddd5`, `81104653`, `81748005`, `e573f278`, `7f54ffe3` |
| **Kind words:** praise and encouragement messages | 6 | `7b5c2249`, `6c39418e`, `78355712`, `14497274`, `80483937`, `639284c7` |
| Reminders at the right time | 5 | `422df19f`, `79431633`, `80058972`, `688f24cd`, `80394456` |
| Other people doing it too | 5 | `68844349`, `78355712`, `80483937`, `6150eed0`, `81748005` |
| A ready-made start: recommended routines | 3 | `68325940`, `79acdd3c`, `81322773` |

Three quotes show the mechanism best:
- *"설정한 습관들을 하니씩 체크하며 작은 성공을 쌓아가는게 기분이 좋아요"*, "checking off the habits I set one by
  one and piling up small successes feels good" (`4b06ec73`).
- *"초록불 꾸준히 달성하고 회고 꾸준히 쓰면 뱃지 주는 게 진짜 신의 한수"*, "giving a badge for steadily hitting green
  and writing reflections is a stroke of genius"; *"며칠 못 하면 뺏어가는게 신의 두수"*, "taking it away if you miss a few
  days is a second stroke"; *"그 덕에 해야 돼!- 라는 마음이 생겨"*, "thanks to that I get the feeling 'I have to do it!'"
  (`e573f278`).
- *"리워드 정책도 무조건 루틴이 많으면 장땡식이 아니고 합리적으로 내 페이스에 맞게 꾸준히 하는걸 유도하는게
  좋아요"*, "the reward policy isn't 'the more routines the better'; it sensibly nudges you to keep at it steadily at your
  own pace" (`78842383`).

**So the help comes from two sides at once:** a pull (small wins, a green light, badges that can be lost, praise) and a
cushion (rest is fine, a gentler bar, a fresh start any time). People don't describe one without the other.

### By group

| Group | How it helps them | Say a change |
|---|---|---|
| 1. Don't act | **Seeing what they did and a gentler bar**: the results kept and what's lacking, so they revise the plan (`74162386`); a challenge routine that cuts self-blame (`48873f2f`); *"게으른 절 바르게 해주는것같아요"*, "it seems to straighten out lazy me" (`0785f7c3`); days spent fully after a year of use (`223585e2`) | 4 of 6 |
| 2. Tracking didn't fit | **They stayed.** Their pain was leaving apps, and the help is staying: *"이 앱만큼 지속적으로 사용한 앱은 없는것같아요"*, "I don't think I've used any app as consistently as this one", because a rest button and holidays let them try again any time (`3b12f8e1`); "finally an app to settle on" (`69531729`); being told it's okay to rest (`78355712`); a game-like pull back (`81748005`) | 1 of 6 says a change; all 6 say why they stay |
| 3. Time slips away | **Time back:** *"소소하게 버리는 시간이 거의 줄었습니다"*, "the bits of time I used to throw away have almost gone" (`77551168`); the challenge routine that cuts self-blame (`48873f2f`, also group 1). Two others say the app costs them time instead (slow, fiddly time entry: `5805cb99`, `c5a30769`) | 2 of 5 |
| 4. Days with no steady shape | **Little so far:** one says it's good when they work at it (`41b41d83`); the shift nurse says a routine set once doesn't follow their shifts (`c607d2b5`) | 1 of 4 (`77551168`) |
| 5. Give up within days | **It keeps the resolve from fading:** *"의지가 약해지는걸 막아줍니다"*, "it stops my willpower weakening", and works *"알람보다 더 효과가 좋다"*, "better than alarms" (`06f273e9`); praise as a carrot and other people's routines (`80483937`); a lazy perfectionist still at it after a year (`223585e2`) | 2 of 3 |
| 6. Forget things | **The alarm and the list in view:** medicine on time (`79431633`); *"루틴이 눈에 보이니까 잊어버리지 않고"*, "because I can see my routines, I don't forget" (`31fcac6d`) | 2 of 2 |
| 7. Keep going when seen | No change said; what they ask for (a feed where routiners post their plans) is what would help (`d00edbac`) | 0 of 1 |
| 8. Neglected themselves | **The reflection:** *"회고로 절 챙기게 되었습니다"*, "through the reflection I've come to look after myself" (`78712083`) | 1 of 1 |
| Goal only | Badges that are taken away make them do it, a full, fun life (`e573f278`); pride at each routine done (`6150eed0`); habits without obsession (`0c24bc52`); a review menu to check the day (`781e76ae`) | 1 of 11 |

### Where it doesn't help

- *"한번정도는 깔아서 3일정도는 실천하게 만드는 앱"*, "an app that, if you install it once, makes you practise for
  about three days" (`20023fb1`, 3★).
- *"앱이 의욕을 팍팍 꺾어버림"*, "the app crushes my motivation", because loading is slow and adding or moving a routine
  takes patience (`e5c60e68`, 1★).
- **Bugs undo the help:** one wrong tap wiped all one person's plans (`cb9365ae`, 1★); routines and records vanished
  after an October update (`79522232`, `79578191`). 149 reviews report something broken (section 7).

**Limits of this section:** the 30 who say how it helped are all 5★ reviewers and mostly early in their use, so this
is what helps the people it works for, not how often it works. No review says the help faded over time, but almost no
one writes again later to say.

---

## 4. Paying

### How many pay

| | Count | Share of 387 | Share of the 41 who say anything |
|---|---|---|---|
| Paid | 20 | 5.2% | 49% |
| On a trial | 6 | 1.6% | 15% |
| Charged unexpectedly | 0 | — | — |
| Refused to pay | 7 | 1.8% | 17% |
| Use it free and say so | 8 | 2.1% | 20% |
| Don't say | 346 | 89% | — |

Three of the six on a trial plan to pay when it ends (`c3766731`, `78712083`, `9fd2ec69`); the other three are still
waiting for the app to stop being slow (`1b8c380a` asks *"무료 체험 기간이라 그런 건가요"*, "is it because it's the free
trial period?"). **Four more would pay, under a condition** (labellers' notes; their `paid` is "not said"): if it were
stable (`e2ef92c2`); for a widget (`80394456`); with a one-time lifetime purchase (`81748005`); and the shift nurse who
plans to pay right away (`c607d2b5`). One on the free plan feels they may end up paying (`f87c3f0e`).

**By group:** of the 25 naming a pain point, **one says they paid** (`d00edbac`, group 7), one is on the trial
(`78712083`, group 8), one is on the free plan (`81322773`, group 1). Of the goal-only 11, one paid (`781e76ae`) and one
refused (`0c78e619`). **So 2021 still can't say which group pays:** 18 of the 20 payers don't say what pain brought them.

**By language:** every payer, trial, refusal and free user writes in Korean (20 of 379 Korean reviews say they paid,
5.3%); none of the 8 other reviews mentions paying.

### Why the payers paid

| Reason | Payers | IDs |
|---|---|---|
| Liked the whole app, often the best of those they tried (two after one day, one straight to premium) | 8 | `2d008c20` (*"바로 프리미엄으로 끊어서 사용중인데"*, "I went straight to premium"), `70869543` (*"제일 괜찮은 것 같아서 구매까지했어요"*, "it seemed the best, so I even bought it"), `bd732e72`, `422df19f` (*"일부러 유료 결재했는데 잘 한 것 같아요"*, "I paid on purpose and I think it was a good move"), `80608046` (*"너무 좋아서 1년 유료결제 했습니다"*, "I loved it so much I paid for a year"), `781e76ae` (*"하루 사용해보고, 너무 좋아서 바로 유료결제했습니다"*, "I used it for a day, loved it, and paid at once"), `9125921b`, `fde24388` (*"유료결제가 아깝지 않습니다"*, "the payment doesn't feel wasted") |
| To invest in it | 1 | `35195557` (*"정말 좋아서 방금 1년 치 유료 결재를 했습니다"*, "it's really good, so I've just paid for a year"; "wanted to invest in it") |
| A feature they wanted | 1 | `17d91d11` (*"원하던 기능이라 돈 주고 샀는데"*, "it was the feature I wanted, so I paid for it", reporting the widget not showing) |
| No reason; writes about a bug or their account | 6 | `11223b87` (widget), `1b57d8c1` (*"기껏 프리미엄 샀는데"*, "I went and bought premium, and…", far too many bugs, 1★), `40cd7ca8` (upgraded Basic to Premium; an error fixed quickly by support), `93ccec57` (*"유료 결제자인데도"*, "even though I'm a paying user", can't get in, 1★), `8c55bdc7` (a time error abroad, 1★), `af7f990f` (can't change their ID because they paid) |
| No reason; wants a refund or can't cancel | 2 | `72365378` (paid a year, asks about a partial refund), `79163499` (*"멤버십 해지버튼을 눌러도"*, "even when I press the cancel-membership button", nothing happens, 1★) |
| No reason; writes to ask for a feature | 2 | `d00edbac` (a feed, percentages, reminders), `6f968d63` (goals as times a week or month) |

So payers pay for **the whole app**, often quickly: at least four paid at once or within a day (`2d008c20`,
`781e76ae`, `9125921b`, `6f968d63`). **Half (10 of
20) report something broken**, four of them at 1★; the payers' average is 3.85★ against the year's 4.12★. Five name a
**one-year plan**, one a subscription pass (정기권), one an upgrade from Basic to Premium.

### What premium holds

**2021 is the first year the reviews show it.** From the labels:

- **A Premium membership, monthly or yearly**, from the start of the year (`2d008c20`, 8 January; a pay-once option
  asked for instead of *"맴버쉽 결재 1달마다"*, "paying for the membership every month", `47df4c45`, 13 January). A year
  costs *"1년에 53000원"*, "53,000 won a year" even bought cheaply (`90c64fbd`, May), or *"연3만원 넘는"*, "over 30,000
  won a year" (`79411361`, October). One upgraded from **Basic** to Premium (`40cd7ca8`), one met a **Pro** membership
  prompt (`6428e39d`).
- **A three-week free trial** (`69290979`, January; `b95ecdc3`, June; `78712083`, October), then a free membership.
- **A cap on routines in the free plan:** 10 in August (`76929045`: told they were *"10개를 초과했다며"*, "over 10",
  when adding a theme routine), **15 from October** (`0ae9b50b`, `6bbe3325`, `f87c3f0e`, `6428e39d`, `b4b657cf`,
  `bb7471d2`, `81748005`).
- **Private reflections:** one says even premium allows only one private item in the reflection (`68495817`).

**Confusion runs through it:** one switched to free mid-trial and can't go back (`69290979`); one on the free plan
doesn't know what paying adds (`75929962`); one asks whether slowness is the trial's (`1b8c380a`); the store page didn't
say it had subscriptions (`11785dc9`); after a month a membership must be bought (`c97b1b2a`).

### Why others won't pay

| Reason | Refusals | Others who say the same |
|---|---|---|
| **The free limit or needing a membership at all** | 3: `c025c10f` (*"멤버쉽이 있어서 저는 못 쓸꺼 같네요"*, "it has a membership, so I don't think I can use it"), `12691faf` (*"무료로는 할 수 있는게 진짜 별로 없음"*, "there's really not much you can do for free"), `0ae9b50b` (*"루틴을 15개까지만 무료로 쓸 수 있다네요...? 살 사람은 사겠지만"*, "only 15 routines free…? Those who'll buy will buy, but…") | `6bbe3325`, `6428e39d`, `b4b657cf` |
| **A subscription instead of one payment, or the price** | 2: `c9510e48` (*"저는 가격을 내기 부담스럽군요"*, "the price is a burden for me"), `0c78e619` (*"구독형은 구매를 잘 안하게 되더라고요"*, "with a subscription I just don't end up buying") | one-time wanted: `47df4c45`, `90c64fbd`, `78419379`, `bd6d2bf0`, `81748005`; too expensive: `72616776`, `90c64fbd`, `79411361` |
| **Too slow or unstable to pay for** | 2: `c0154a44` (*"결제하고싶은데 너무 느려서 안함"*, "I want to pay, but it's too slow, so I won't"), `0a1c192f` (*"아직 돈받을 수준이 아님"*, "not yet good enough to take money for") | `e2ef92c2` (would pay once fixed), `793d7a6f` (*"유료임에도 불구하고 무료인 타 어플들보다도 너무 불안정하고"*, "despite being paid, far more unstable than free apps"), `79411361` (too many small bugs for the price) |

---

## 5. Free features people like

Across all 387 reviews, 198 name something they like. Sorted into kinds (one review can name several):

| Feature | Reviews | Which groups name it most |
|---|---|---|
| **Simple, clean, easy to use** | **57** | Don't act (2); one each in tracking didn't fit, give up within days, neglected themselves, goal-only |
| Looks good, cute design | 24 | Don't act (2), neglected themselves (1), goal-only (1) |
| Encouraging, a sense of achievement (the traffic light, badges, praise) | 22 | **Tracking didn't fit (4)**, goal-only (2) |
| Check off the day; see it at a glance | 16 | Goal-only (2), neglected themselves (1) |
| Responsive developer, frequent updates | 15 | Give up within days (2), goal-only (2) |
| Builds habits, keeps routines going | 13 | Goal-only (2) |
| Home-screen widget (6 on Android; 2 on the iPhone as it arrived; 1 a wish) | 9 | Tracking didn't fit (1) |
| See, copy and follow other people's routines | 8 | **Tracking didn't fit (2)**; one each in don't act, short of time, give up within days, neglected themselves, goal-only |
| Reminders and push alarms | 7 | One each in don't act, tracking didn't fit, forget |
| The free plan is enough | 6 | — |
| Reflection, diary, memo | 5 | Neglected themselves (1), goal-only (1) |
| Works on phone, tablet and PC, synced | 2 | Goal-only (1) |
| Private routines; repeat on chosen weekdays | 1; 1 | Neglected themselves (1) |

**What it means per group:** the year's reviewers as a whole praise **simplicity** above all (*"군더더기 없고 딱
필요한것만 있어서 좋았고"*, "no clutter, just what's needed", `6150eed0`), but the groups each name what their pain
lacked: **forgiving encouragement** for those whose tracking didn't fit, **a gentler bar and seeing what they did** for
those who don't act, **time saved** for those short of it, **an alarm** for those who forget. Two changes from 2020
stand out: **other people's routines fell from 16 reviews (11 of 18 with a pain point) to 8 (5 of 25)**, and the web
and PC versions from 12 to 2. The widget is the new kind: *"위젯기능이 있어서 핸드폰을 켜자마자 볼수 있다는게
장점"*, "having the widget means I can see it the moment I turn on my phone" (`b1e6fbb3`). Six praise the free plan:
*"이렇게 깔끔한 UI와 기능들이 무료라니"*, "a clean UI and features like this, for free" (`66324847`).

---

## 6. Who they say they are, and how they found it

From `who` (40 people say something). Still mostly a device:

| They say they are | People | IDs |
|---|---|---|
| **Use an iPad or tablet** (5 of them in landscape, or want it) | 10 | `29c41c30`, `3c19fda3`, `78916119`, `2f7e3d08`, `697b067d`, `80502017`, `81014716`, `80495427`, `06f273e9`, `81539735` |
| Name their phone (iPhone 4, Galaxy or Android 5) | 9 | `68495817`, `73852103`, `78712083`, `80394456`; `da991b9f`, `3376240a`, `ccca69ab`, `93ccec57`, `7d8e22ff` |
| Students (a middle-school student, exams, no school from June) | 3 | `7b5c2249`, `48873f2f`, `76671850` |
| Live abroad or on another country's time | 2 | `16a2b447`, `8c55bdc7` |
| Work (a shift nurse; changed industries) | 2 | `c607d2b5`, `77551168` |
| Also use it on a PC in a browser | 1 | `79580313` |

Once each: a 30-minute check every morning (`68747098`), writes a daily reflection (`75803176`), keeps widgets for
weather and the calendar (`76688251`), takes medication (`79431633`), eyes that hurt (`41cdeecd`), edits a lot when
typing (`80372085`), never makes plans (`cb9365ae`), never was an unplanned person (`e573f278`), plus the identities in
the groups above (lazy, the "P type", short of time, motivated by others' eyes).

**Where they came from** (`came_from`, 23): **other routine, habit, to-do or recording apps (19)**, *"루틴 앱 진짜
왠만한거 다 써봤는데"*, "I've tried pretty much every routine app" (`981b6aba`); a paper diary or planner (2,
`223585e2`, `76688251`); time-set scheduling (`0c24bc52`); alarms (`06f273e9`).

**How they found it** (`why_chose`): **Instagram** (3: its marketing, an ad, the founder's account: `03284f00`, `20023fb1`, `80994886`), **a self-management type test** made by the developer, MBTI-style (2:
`7f54ffe3`, `81855786`), a sister's recommendation (`81720768`). Five say only it was exactly what they were looking for.

---

## 7. What's broken and what's wished for

### Broken (149 reviews, 38%)

| Kind | Reviews | IDs |
|---|---|---|
| **Won't open, crashes, freezes or a white screen** | 34 | `7c46c512`, `68325940`, `03284f00`, `ecb79eeb`, `da991b9f`, `68548143`, `68748195`, `d383ed7a`, `68825510`, `71059800`, `73852103`, `71900134`, `72217546`, `234316a5`, `7f000991`, `b95ecdc3`, `72201511`, `f690dfe9`, `75854609`, `75961166`, `611bfaea`, `3376240a`, `e1c591f5`, `5085ee11`, `cb2674a8`, `0f7c36bc`, `93ccec57`, `369a35d4`, `c90b0dbb`, `78712083`, `6bbe3325`, `80078501`, `e5c2b3d9`, `80949664` |
| **The Android widget: flickers, blank, stuck loading, stale date** (one iPhone user can't find it) | 26 | `5e1a96c2`, `c3e14638`, `8016b540`, `bad673da`, `11223b87`, `17d91d11`, `f7617f2e`, `d7660977`, `19cc1f3d`, `e5c60e68`, `78673882`, `ff4c50f1`, `2f7e3d08`, `688f24cd`, `301a5b99`, `4d96db29`, `0c78e619`, `7d8e22ff`, `968637b1`, `3b12f8e1`, `da609db3`, `41cdeecd`, `9fd2ec69`, `5981f589`, `926e0a05`, `dfdf1c0b` |
| **Slow: loading, opening, saving** (20 seconds to two minutes to open) | 25 | `2d008c20`, `053b278b`, `68548143`, `d383ed7a`, `1b8c380a`, `fff4e213`, `71773552`, `db5439b3`, `74662894`, `c0154a44`, `72832647`, `b95ecdc3`, `72920008`, `793d7a6f`, `3c19fda3`, `0b148f7a`, `f690dfe9`, `78523143`, `78396252`, `78712083`, `90fcbb01`, `79528800`, `53400e45`, `9125921b`, `944d08c7` |
| Routines or records lost, not saved, or not showing (after updates in October, one wrong tap) | 17 | `9de23d21`, `68495817`, `73852103`, `76671850`, `75803176`, `ab0ce619`, `75942830`, `78507013`, `78523143`, `78470573`, `4a05d110`, `6a456b23`, `79522232`, `79578191`, `80315208`, `b4b657cf`, `cb9365ae` |
| Log in, sign up, delete the account or cancel the membership | 17 | `68920271`, `c396d9db`, `e2ef92c2`, `3d5197af`, `68495817`, `f4bed4ef`, `20023fb1`, `75854609`, `76776844`, `75961166`, `e2180eb1`, `cb2674a8`, `79163499`, `79262663`, `3ba06732`, `6f3f668b`, `5f19dc0a` |
| The order they set changes by itself, or can't be changed | 13 | `f35c3a16`, `68353838`, `ecb79eeb`, `9de23d21`, `74467820`, `76263783`, `76339816`, `78470573`, `da32897e`, `5a188dff`, `e4a37465`, `81626161`, `81732623` |
| Wrong date or time (abroad, the weekday shown) | 6 | `76671850`, `16a2b447`, `8c55bdc7`, `0c78e619`, `81063100`, `81878136` |

(A review can be in more than one kind; 27 report only general "errors" or one-off bugs.) Bugs are spread over the
year rather than one wave: January 21 (version 0.3.x, My Page force-closing), June 12, October 20 (routines lost after
an update), November 17, **December 24**. Two thirds come from Google Play (96 of 255 Play reviews, 53 of 132 App Store
reviews). Reviews reporting a bug average 3.38★.

### The widget, through the year

The single thing most asked about. **On Android** the widget arrived by April (`5e1a96c2`, 6 April: its date doesn't
change) after requests in February and March (`1956c61d`, `0b148f7a`). Six Android users like it, and 26 report it broken, 9 of
them in December, two saying a fix announced in an update didn't fix the flicker (`0c78e619`, `968637b1`). Ten more
Android users want it changed: transparent or black instead of white (*"위젯넘 화이트라 저녁사용때 눈이부셔요"*, "the widget's
so white it dazzles in the evening", `df2a20ff`), smaller than 4×2, a weekly view, the time shown, completed routines
hidden (`1319588c`, `11223b87`, `cf88e76c`, `1d0203fe`, `16a2b447`, `df2a20ff`, `34fb543b`, `4aa8ddad`, `1585677c`,
`c83d3d49`).

**On the iPhone**, 27 App Store reviews ask for one, from January (`68248759`) to December, **16 of them in November
and December** (`68248759`, `70634606`, `70903389`, `68495817`, `68844349`, `72625001`, `76057705`, `76678545`,
`76688251`, `78944111`, `78712083`, `79807180`, `80058972`, `80237431`, `80336041`, `80483937`, `80887683`,
`80608046`, `81014716`, `80394456`, `80614789`, `81341254`, `81047029`, `81382533`, `81104653`, `81322773`,
`81425981`). In a payer's words: *"더 빠른 체크와 확인을 위해 ios위젯이 꼭 필요합니다"*, "for faster checking, an iOS widget is a
must" (`80608046`). Two Play reviews asked for one before the Android widget came (`1956c61d`, `0b148f7a`), and one
waits for a redesign (`bc095706`). On 26 and 27 December two App Store reviews celebrate it arriving (`81720768`; `81732623`: *"일단 위젯
나와서 넘 신나구여"*, "first of all, I'm so excited the widget is out").

### Wished for (127 reviews)

| Wish | Reviews | IDs |
|---|---|---|
| **A widget, or a better one** (above) | 41 | — |
| **Landscape on iPad or tablet** (stopped in an update, `77623479`) | 16 | `77623479`, `78916119`, `78976500`, `78118236`, `79601291`, `79608493`, `d0ee5712`, `80856075`, `80502017`, `80511972`, `81014716`, `80495427`, `c5a30769`, `81076943`, `06f273e9`, `81539735` |
| **Apple Watch** (check, alarms) | 9 | `68595910`, `69531729`, `78250282`, `79914960`, `80550838`, `81033458`, `81144894`, `81104653`, `81539735` |
| More ways to repeat: every two weeks, a few times a month, fixed dates, times a week, an end date | 8 | `70963547`, `73135396`, `868b6674`, `76711236`, `697b067d`, `c5a30769`, `6f968d63`, `0e76e007` |
| A monthly view | 4 | `51a3f5fc`, `c5a30769`, `0e76e007`, `e6d380fd` |
| Dark mode or darker colours | 3 | `78712083`, `41cdeecd`, `ad024189` |
| English (or Spanish) | 3 | `bae7c7b8`, `7ae04d1b`, `73f4d5e4` |
| A one-time purchase | 2 (+5 who dislike the subscription) | `47df4c45`, `81748005` |

Once or twice each: set when the day ends (`48873f2f`, `81743675`), routines inside routines (`68747098`,
`77650939`), one-day to-dos (`868b6674`), autosave for the reflection (`e7f6b171`), statistics and export to Excel
(`baa13743`), talk or set goals with others (`3d54f4f8`, `78842383`), more praise and badges (`6c39418e`,
`df2a20ff`), a confirmation before deleting (`cb9365ae`).

**Disliked:** the price and the subscription (15, in section 4); slow or unstable (12); complex or not intuitive (18,
e.g. *"앱 인터페이스랑 플로우가 너무 복잡해요"*, "the app's interface and flow are too complex", `12691faf`); other people's
routines shown first on the home screen (`b9423ae3`, `81855786`). The reflection's public and private options confuse
one person into writing private things publicly (`81295592`).

---

## 8. What changed

| | 2020 (from 5 July) | 2021 |
|---|---|---|
| Reviews | 131 | 387 |
| App Store / Google Play | 55% / 45% | 34% / 66% |
| Korean | 100% | 98% |
| Average rating | 4.00 | 4.12 |
| People naming a pain point | 18 (14%) | 25 (6.5%) |
| Know what to do but don't do it | 33% | 24% |
| Their way of keeping track didn't fit | 28% | 24% |
| Time slips away | — | 20% (new) |
| Their days have no steady shape | — | 16% (new) |
| Start, then give up within days | 28% | 12% |
| Forget things | 11% | 8% |
| Keep going when others can see them | — | 4% (new) |
| Feel they've been neglecting themselves | — | 4% (new) |
| Don't know what routine to make | 6% | — |
| Say they paid | 6 (4.6%) | 20 (5.2%) |
| A paywall in the reviews | none | 3-week trial; free plan 10, then 15 routines |
| Report a bug | 54 (41%) | 149 (38%) |
| Ask for a widget | 3 | 41 |
| Like other people's routines | 16 | 8 |

**What moved:** the pain is the same at the core (not acting, and old ways of tracking that didn't fit) but 2021 adds
people whose problem is **time and the shape of their days**, and they're the most critical. Giving up within days
shrinks. The social side, 2020's most named feature among people with a pain, falls away; **simplicity and the widget
take its place**. Paying is about as rare as in 2020 but now has a price, a trial and a free limit, and the limit is
the commonest reason to refuse.

---

## 9. Limits

- **Small:** 25 people name a pain point out of 387, and groups 7 and 8 are one person each. The shares describe the
  25, not every user. A smaller share of reviews names a pain than in 2020 (6.5% against 14%).
- **Clustered late:** December holds 103 of the 387 reviews and 14 of the 25 people with a pain point wrote in November
  or December; the reviews don't say why. All but two groups average 5★: these are enthusiastic reviewers.
- **One market:** 379 of 387 reviews are Korean.
- **Bug reports crowd out the rest:** most of the 149 reporting a bug say nothing about who they are or why they came,
  so the groups come from the happier half of the reviews.
- **Paying is mostly unsaid** (346 of 387), and 18 of the 20 payers say nothing about why they came.
- **Groups are from 2021's words,** with 2020's kept where the pain is the same; four new groups rest on one to five
  people and may merge or split in later years.
- Feature kinds are sorted by keywords on the labels' feature text and every match was checked by hand (2021's traps
  are in [README.md](<README.md>)). One "widget" like is a wish ("perfect with a widget", `78944111`).

---

## Appendix: every group member

| Line | ID | Store | ★ | Language | Groups | Paid |
|---|---|---|---|---|---|---|
| 27 | `223585e2` | Play | 5 | ko | 1 Know what to do but don't do it; 5 Start, then give up within days | not said |
| 32 | `70634606` | App Store | 5 | ko | State only a goal | not said |
| 44 | `d00edbac` | Play | 5 | ko | 7 Keep going when others can see them | paid |
| 45 | `69531729` | App Store | 4 | ko | 2 Their way of keeping track didn't fit | not said |
| 72 | `48873f2f` | Play | 5 | ko | 1 Know what to do but don't do it; 3 Time slips away | not said |
| 100 | `74162386` | App Store | 5 | ko | 1 Know what to do but don't do it | not said |
| 125 | `0c24bc52` | Play | 5 | ko | State only a goal | not said |
| 153 | `78355712` | App Store | 5 | ko | 2 Their way of keeping track didn't fit | not said |
| 164 | `77551168` | App Store | 5 | ko | 3 Time slips away; 4 Their days have no steady shape | not said |
| 188 | `78916119` | App Store | 5 | ko | State only a goal | not said |
| 195 | `77650939` | App Store | 5 | ko | 3 Time slips away | not said |
| 200 | `78712083` | App Store | 5 | ko | 8 Feel they've been neglecting themselves | trial |
| 229 | `79431633` | App Store | 5 | ko | 6 Forget things | not said |
| 244 | `31fcac6d` | Play | 5 | ko | 6 Forget things | not said |
| 250 | `0785f7c3` | Play | 5 | ko | 1 Know what to do but don't do it | not said |
| 261 | `952f894f` | Play | 5 | ko | 2 Their way of keeping track didn't fit | not said |
| 275 | `80483937` | App Store | 5 | ko | 5 Start, then give up within days | not said |
| 276 | `0c78e619` | Play | 4 | ko | State only a goal | refused |
| 278 | `6150eed0` | Play | 5 | ko | State only a goal | not said |
| 285 | `5805cb99` | Play | 3 | ko | 3 Time slips away | not said |
| 293 | `80394456` | App Store | 5 | ko | 1 Know what to do but don't do it | not said |
| 295 | `6428e39d` | Play | 3 | ko | State only a goal | not said |
| 297 | `781e76ae` | Play | 5 | ko | State only a goal | paid |
| 300 | `c5a30769` | Play | 3 | ko | 3 Time slips away | not said |
| 305 | `d11aff78` | Play | 5 | ko | 4 Their days have no steady shape | not said |
| 307 | `41b41d83` | Play | 5 | ko | 4 Their days have no steady shape | not said |
| 313 | `e4a37465` | Play | 4 | ko | State only a goal | not said |
| 326 | `3b12f8e1` | Play | 5 | ko | 2 Their way of keeping track didn't fit | not said |
| 337 | `cb9365ae` | Play | 1 | ko | State only a goal | not said |
| 339 | `c607d2b5` | Play | 5 | ko | 4 Their days have no steady shape | not said |
| 343 | `06f273e9` | Play | 5 | ko | 5 Start, then give up within days | not said |
| 344 | `e8fc0fca` | Play | 2 | ko | State only a goal | not said |
| 346 | `81322773` | App Store | 5 | ko | 1 Know what to do but don't do it | free |
| 348 | `b1e6fbb3` | Play | 5 | ko | 2 Their way of keeping track didn't fit | not said |
| 381 | `81748005` | App Store | 5 | ko | 2 Their way of keeping track didn't fit | not said |
| 384 | `e573f278` | Play | 5 | ko | State only a goal | not said |

36 people: 25 in at least one pain-point group, 11 with a goal only. Checked: every ID in this report is in `Review Labels/MyRoutine/2021/reviews.jsonl`.
