# MyRoutine 2020: User Groups, Why They Use It, and What They Pay For

Written by Claude (Claude Code), 27 November 2026, at the user's request.

**What this is.** MyRoutine's target users as its 2020 reviews show them, the way UX user research describes them: the
groups of people who use it, each defined by the **pain point** that brought them; why each group uses it; whether each
group pays, how many, and for what; and which free features each group likes. The first year of a series, the same
study as [Routinery's](<../../Routinery/User Groups — Who, Why, Paying/README.md>).

**How it was done.** From the labels alone, as research for a new product or a full rebuild. No product of ours, its
features or its code was used to choose, read or group anything.

**Source.** The checked labels for all 131 reviews of 2020 in `Review Labels/MyRoutine/2020/labels.jsonl` (each made
by reading one review, in its own language, and checked by a second reader). Every number and quote here comes from
the label fields, not from rereading the reviews:

- **Groups:** from `who` (what people say about themselves) and `why_chose` (the need or struggle that brought them).
  I read every one of the 47 reviews that have either and put each person in the group(s) their own words describe.
  One person can be in more than one group.
- **Features liked:** from `liked` and `chose_for`, sorted into kinds by the words in each feature, every match
  checked by hand.
- **Paying:** from `paid` (`paid`, `trial`, `charged_unexpectedly`, `refused`, `free` or `not_said`) and its reason,
  plus the labellers' `note` where someone says they *would* pay.
- **What's broken and wished for:** from `problems` (`broken`, `missing`, `dislike`), sorted by hand.

Quotes are the labels' own exact quotes, in Korean, with a translation. Review IDs are shortened to their first 8
characters; the appendix maps every group member to its line in the labels file. The map is saved as
[`Tools/groups_2020.py`](<Tools/groups_2020.py>); [README.md](<README.md>) explains the method.

---

## The short answer

- **131 reviews** (72 App Store, 59 Google Play), **all in Korean**, average 4.00★, from 5 July (the week the phone
  apps came out) to 31 December 2020. **18 people (14%) name a pain point**; 9 more name only a goal ("build good
  habits"); the rest say what they like or, very often, what's broken.
- **The target users are people who can't keep a routine going on their own, and have already failed with other
  apps or a paper diary.** Five groups, by the pain point:

| # | User group (the pain point) | People | Share of the 18 | ★ | Paid |
|---|---|---|---|---|---|
| 1 | **Can't start or keep going:** plan but don't act, no willpower, give up new habits within days (작심삼일) | 11 | 61% | 5.00 | 0 |
| 2 | **Tried other apps, planners or a paper diary; nothing stuck** | 9 | 50% | 4.89 | 0 |
| 3 | **Overwhelmed:** other apps too much to learn, or a first blank list feels daunting | 2 | 11% | 5.00 | 0 |
| 4 | **Forget small habits:** medicine, tasks at set times | 2 | 11% | 5.00 | 0 |
| 5 | **Lose time:** a hectic, frantic life | 1 | 6% | 5.00 | 0 |

  (Shares add up to more than 100% because 7 people are in more than one group. **These are small numbers:** 18
  people, 9 of them writing on two days in October; see Limits.)

- **Why they use it, in one line:** **other people's routines keep them going.** 11 of the 18 name the social side:
  seeing other people's routines, copying them with a long press, following "routiners". The words are "motivating"
  (동기부여), "it keeps me coming back" (자꾸 들어가게 되는), "like a social network" (SNS처럼). After that come
  checking off the day (the green light, emoji, badges) and reminders.
- **Paying: 6 of 131 say they paid (4.6%); 6 of the 7 who say anything about it.** None of the six names a feature
  or says what pain brought them; four simply liked the whole app after using it (one after the free trial), one pays
  *because* paying makes them keep at it, one says only "I'm a paying user" while reporting a bug. **No review says
  what premium holds**, and one in December still thinks the app is free. 1 refuses to pay; 3 more would pay *if*
  (colour options, a fair price, once it's stable).
- **Bugs are the year's other story:** **54 of 131 reviews (41%) report something broken**, rising to 31 of 45 in
  December, when an update stopped the app opening for many (10 reviews on 14 December). Half the payers (3 of 6)
  report a bug.
- **Free features the whole year likes** (71 name one): simple and clean (21), encouraging, a sense of achievement
  (17), checking off the day at a glance (16), **other people's routines (16, 11 of them from the 18 with a pain
  point)**, building habits that last (13), the web, PC and phone versions (12), the reflection diary (11).

---

## 1. The year in numbers

| | Count | Share of 131 |
|---|---|---|
| Reviews | 131 | 100% |
| App Store / Google Play | 72 / 59 | 55% / 45% |
| Language | Korean 131 | 100% |
| Ratings 5★ / 4★ / 3★ / 2★ / 1★ | 75 / 17 / 18 / 6 / 15 | 57% / 13% / 14% / 5% / 11% |
| Say who they are (`who`) | 16 | 12% |
| Say why they came (`why_chose`) | 36 | 27% |
| Name a pain point (any group below) | **18** | **14%** |
| Name only a goal ("build good habits") | 9 | 7% |
| Name a feature they like | 71 | 54% |
| Say anything about paying | 7 | 5% |
| Report something broken | 54 | 41% |
| Wish for something missing | 35 | 27% |
| Still using / about to quit / quit / not said | 106 / 6 / 4 / 15 | 81% / 5% / 3% / 11% |
| Developer replied | 59 | 45% |

Dates: 5 July to 31 December 2020. By month: July 17, August 15, September 4, **October 37**, November 13, **December
45**. In July the app came to phones for people who had used its web version (`61646772`: *"어플로도 나와서 너무
좋네요"*, "great that it's out as an app too"; `ef8ea94c`: *"웹으로 볼 때보다 훨씬 편하고 잘 다듬어졌네요"*, "much
more comfortable and polished than on the web").

---

## 2. The user groups

Each group is the people whose own words describe that pain point. ★ is the group's average rating.

### Group 1. Can't start or keep going (11 people, 61% of those naming a pain point, 5.00★)

**Who they are:** people who make plans and don't act on them, who blame a lack of willpower, or whose habits last
three days (the Korean *작심삼일*, "resolve for three days"). Several had quit habit apps within days before. 6 are only
in this group; 5 are also in group 2 (tried other apps). Every one rates 5★.

**Why they use it:**
- *"루틴이라는게 별로 어려운 일 아닌데도 실천하기가 너무 어려워 이 앱을 설치하게 되었습니다"*, "a routine isn't
  anything hard, but actually doing it was so hard that I installed this app" (`f3d4dccf`, 5★).
- *"늘 머리로 계획만 하고 몸이 못따라서 현타오는 스탈이라"*, "I'm the type who only ever plans in my head while my body
  can't follow, and then feels awful about it" (`65756554`, 5★).
- *"저같이 생각만하고 움직이지 않는 사람들에게"*, "for people like me who only think and don't move" (`65753826`, 5★).
- *"평소에 생활습관을 바꾸고 싶었는데 의지 박약으로 늘 실패하다가"*, "I always wanted to change my habits but always
  failed for lack of willpower" (`65774215`, 5★).
- *"매일 시작하기 귀찮고 어려웠던 습관들"*, "habits that were a bother and hard to start every day" (`403638c4`, 5★).
- *"작심삼일하던 여러 습관들"*, "the many habits I used to drop after three days" (`66843788`, 5★).
- *"정말 실패를 많이 겪었는데"*, "I really failed many times" (`67689214`, 5★).

**What they say changed:** *"지금 인생 최초로 작심2주 넘겼어요"*, "for the first time in my life I've kept a resolve
past two weeks" (`67689214`); habits kept *"두 달이 넘었네요"*, "for over two months now" (`66843788`); two morning
habits *"자리잡아"*, "have taken hold" after 40 days (`f3d4dccf`).

**Free features they like** (all 11 name one): building habits that last (6), **encouragement and a sense of
achievement (6)**, **other people's routines (5)**, checking off the day (4), simple and clean (4), **reminders (4)**.
How they say it works:
- Other people: *"다른 사람들과 루틴을 공유할 수 있어, 동기부여도 되고"*, "I can share routines with others, which
  motivates me" (`62665137`); *"다른 사람들 루틴도 볼 수 있어서 자꾸 들어가게 되는 것 같아요"*, "I can see other people's
  routines too, so I keep going back in" (`a363537c`).
- Rewards: *"계속 초록불 달성하면 뱃지를 주어서 뱃지가 받은게 아까워서 계속 꾸준히 하게 되네요"*, "it gives a badge when
  you keep getting the green light, and I don't want to waste the badge, so I keep at it" (`403638c4`); *"매일 루틴
  지킨 거 체크하는 재미가 쏠쏠합니다"*, "checking off the routines I kept each day is real fun" (`67689214`).
- Reminders: *"매일 제 때 알림 오니까"*, "the notification comes on time every day" (`65756554`); *"저를 일깨워주는
  기분"*, "it feels like it wakes me up" (`65774215`).

**Paying:** none say; 11 of 11 don't mention it.

### Group 2. Tried other apps, planners or a paper diary; nothing stuck (9 people, 50%, 4.89★)

**Who they are:** people who gave up other routine, habit or productivity apps (7), or found a paper diary too much
work to carry and keep up (2). 3 are only in this group; they say why this app and not the others.

**Why they use it:**
- *"다른 루틴앱은 몇번 하다가 그만두게 되는데"*, "with other routine apps I quit after a few goes" (`62250619`, 5★).
- *"이런 앱들은 매번 며칠 사용하다 중단하곤 했는데"*, "I always used to stop apps like this after a few days"
  (`62665137`, 5★).
- *"혼자 하다 보면 앱을 깔아만 놓고 잘 안쓰게 됐는데"*, "doing it alone, I'd install an app and then hardly use it"
  (`a363537c`, 5★).
- *"한번이라도 빼먹으면 뭔가 실패한 느낌이였는데"*, about other apps that track one habit: "if I missed it even once it
  felt like I'd failed" (`65294837`, 5★). What fixed it here: *"내가 하려는 것들 중 몇 퍼센트만 해도 잘 한걸로
  나오니까"*, "if I do even some percent of what I planned, it shows as doing well".
- *"다른 앱들은 제대로 사용하려면 할 게 너무 많아서 익숙해지는 것 자체가 스트레스였거든요"*, "with other apps there was
  so much to do to use them properly that getting used to them was itself stressful" (`8e7a60f3`, 5★).
- *"까먹고 안가지고 다니는 경우도 많고"*, about a paper diary: "I often forgot to carry it" (`01035435`, 5★);
  *"루틴은 아날로그다이어리로 매번 체크하기어려웠는데"*, "checking routines in an analog diary every time was hard"
  (`168f42da`, 4★).

**Free features they like** (all 9 name one): **other people's routines (6: the most of any group)**, simple and
clean (4), encouragement (3), a diary feel or a replacement for the paper diary (3). *"다른 루틴앱은 몇번 하다가
그만두게 되는데 마이루틴에는 루틴퍼오는기능이나 관심루티너 지정하는기능이 있어서 동기부여가 되서"*, "other routine apps I
quit after a few goes, but MyRoutine has copying routines and following routiners, which motivates me" (`62250619`);
*"내가 할 일을 정리하고, 실천하고, 피드백(회고)하고, 다른 사람들의 루틴을 보면서 자극 받는 선순환을 심플하게 구현한
게 좋았습니다"*, "I liked that it simply builds a good cycle: organise what I'll do, do it, review it (reflection),
and get a push from seeing other people's routines" (`8e7a60f3`).

**Paying:** none say.

### Group 3. Overwhelmed (2 people, 11%, 5.00★)

**Who they are:** one who found other productivity apps too much to learn (`8e7a60f3`, also in group 2), and one who
didn't know where to begin a first list (`ce443230`).

**Why they use it:** *"처음에 리스트를 만들려고 할때 막막해서"*, "when I first tried to make a list I was at a loss"
(`ce443230`, 5★), solved by copying: *"나도 이런 루틴을 해보면 좋겠다 생각한 것들을 퍼와서 시작해보니 큰 어려움 없이
시작할 수 있었고요"*, "I took the routines I thought I'd like to try and started with those, so I could start without
much trouble".

**Free features they like:** other people's routines (2), simple (1). **Paying:** none say.

### Group 4. Forget small habits (2 people, 11%, 5.00★)

**Who they are:** one who forgets tasks until an alarm comes (`5eff2012`), one who wants to remember medicine in a
hectic life (`65756676`, also in group 5).

**Why they use it:**
- *"해야할 일을 적고 원하는 시간에 알람이 오는 앱을 찾고 있었는데"*, "I was looking for an app where I write my tasks and
  an alarm comes at the time I want" (`5eff2012`, 5★).
- *"약챙겨먹기나 꾸준히 뭔가를 계획하기에"*, "for remembering medicine and planning something steadily" (`65756676`,
  5★).

**Free features they like:** other people's routines (2: copying them, the Best Routine page), reminders, checking off
the day on time. **Paying:** none say.

### Group 5. Lose time (1 person, 6%, 5.00★)

*"요즘 매번 정신없이 사는데"*, "lately I'm always living in a rush" (`65756676`, 5★), who likes the **Best Routine**
page: *"다른분들이 자주 계획하는 루틴들을 보고 함께 공유할 수 있어서"*, "I can see the routines others often plan and
share them". One person: shown so later years can compare.

### People who name only a goal (9 people, 4.67★)

Not a pain-point group: they say what they want but not what's wrong. *"내가 만들고 싶은 매일을 만드는 어플"*, "an app
that makes the days I want to make" (`61636207`); *"이루고 싶은 습관들을 지치지 않고 꾸준히 형성할 수 있게
도와줘요"*, "it helps me build the habits I want steadily, without burning out" (`61646772`); a 5 AM wake-up kept
*"별 무리없이"*, "without much strain" (`65297172`). They like building habits that last (3), checking off the day
(2), encouragement (2) and **using it on the computer as well as the phone (2)**: *"업무할 땐 컴터로 하고 싶은데
데스크탑도 되는게 짱"*, "when I'm working I want to use the computer, and the desktop version is the best"
(`61636207`). None mention paying.

---

## 3. Paying

### How many pay

| | Count | Share of 131 | Share of the 7 who say anything |
|---|---|---|---|
| Paid | 6 | 4.6% | 86% |
| On a trial | 0 | — | — |
| Charged unexpectedly | 0 | — | — |
| Refused to pay | 1 | 0.8% | 14% |
| Use it free and say so | 0 | — | — |
| Don't say | 124 | 95% | — |

Three more say they **would** pay, under a condition (from the labellers' notes; their `paid` is "not said"): if
colour options existed, *"even in a paid version"* (`40e356a5`); *"at a reasonable price"* if it becomes paid later
(`67324983`); once it's stable (`168f42da`). One wishes they could **gift a subscription** (`66843788`).

**By group:** none of the 18 people naming a pain point says they paid, and none of the six payers says what pain
brought them (one, `65267659`, says only that it was an editors' pick). **So 2020 can't say which group pays.**

**By language:** every review is Korean, so there's no comparison this year.

### Why the payers paid

None of the 6 says they paid for one feature. Their reasons:

| Reason | Payers | IDs |
|---|---|---|
| Liked the whole app after using it (one after the free trial, one for a year) | 4 | `65267659` (*"무료 체험 써보고 넘 좋아서 구독하면서 쓰고 있어요"*, "tried the free trial, loved it, and I'm subscribed"), `65294933` (*"마이루틴이 제 일상에 미치는 영향이 넘 크고 만족 스러워서 처음으로 유료 결제 했어요"*, "MyRoutine's effect on my daily life is so big and satisfying that I paid for an app for the first time"), `1c86c481` (*"유용한 앱이라고 생각해 유료결제까지 했는데"*, "I thought it useful enough to pay, but…"), `67934501` (*"쓰다가 만족해서 1년 결제해서 쓰고있어요"*, "I was satisfied using it, so I paid for a year") |
| Paying as a commitment: paying makes them keep at it | 1 | `65331859` (*"돈을 내고나니 더 열심히 실천하게되는 마법"*, "the magic of practising harder now that I've paid"; they say the trial was so long they thought it was free) |
| No reason; writes about a bug | 1 | `0a9f520e` (*"유료사용중인데"*, "I'm a paying user", ticks keep disappearing) |

So payers pay for **the whole app working for them**, after using it. **Half the payers report a bug** (`0a9f520e`,
`1c86c481`, `67934501`), and their average rating is 4.00★, the same as the year's. One uses it less now: *"초반보다
가끔 쓰게 되는 거 같아요"*, "I seem to use it only sometimes now, compared with the start" (`1c86c481`).

### What premium holds

**No 2020 review says.** No one names a paid feature or a free-plan limit; one asks *"혹시 9개까지만 루틴을 만들수 있는
건가요?"*, "can I only make up to nine routines?" (`dbcb5073`), without saying it's a paywall. Two payers mention the
free trial, and one in December still writes as if the app were free (`67324983`).

### Why others won't pay

Only one refusal, with no reason: *"유료는 사용하고싶지않아요"*, "I don't want to use the paid version" (`beef41ed`,
1★, July). The conditional payers' conditions show the year's objections instead: **stability** (`168f42da`),
**missing features** (`40e356a5`) and **price** (`67324983`).

---

## 4. Free features people like

Across all 131 reviews, 71 name something they like. Sorted into kinds (one review can name several):

| Feature | Reviews | Which groups name it most |
|---|---|---|
| Simple, clean, easy to use | 21 | Can't start (4), tried everything (4) |
| Encouraging, a sense of achievement (green light, badges, "fun to check") | 17 | **Can't start (6)**, tried everything (3) |
| Check off the day; see it at a glance (emoji, weekly view) | 16 | Can't start (4), goal-only (2) |
| **See, copy and follow other people's routines** | 16 | **Tried everything (6), can't start (5), overwhelmed (2), forget (2): 11 of the 18 with a pain point** |
| Builds habits, keeps routines going | 13 | **Can't start (6)**, goal-only (3) |
| Web, PC and phone versions, synced | 12 | Goal-only (2) |
| Reflection, diary, memo | 11 | Tried everything (3: a diary feel, or replacing a paper diary) |
| Responsive developer, frequent updates | 9 | Can't start (2) |
| Reminders and push alarms | 6 | **Can't start (4)**, forget (1) |
| Looks good, cute | 5 | — |
| Private routines | 3 | Tried everything (1) |
| Partial credit (some done still counts), repeat on chosen weekdays, long free trial | 1 each | — |

**What it means per group:** the people with a pain point are the ones who name the **social side**; the year as a
whole names **simple and clean** first. People who can't keep going value what keeps them coming back: **other
people's routines, badges and the green light, and reminders**. People who quit other apps value **other people's
routines** and an app that is **easy to learn**. People who don't know where to start value **copying a ready
routine**.

---

## 5. Who they say they are, and how they found it

From `who` (16 people say something). Mostly a device, not a problem:

| They say they are | People | IDs |
|---|---|---|
| Use the web version or a computer (laptop, PC, work computer) | 4 | `8753f087`, `61636207`, `fc0345b5`, `66407369` |
| Name their phone (iPhone 3, Galaxy 1, Android 1) | 5 | `67488650`, `67538747`, `67552467`, `cc7f8983`, `cc32bf96` |
| Use an iPad or tablet | 2 | `66153439`, `67513853` |
| Name the habits they're working on (water and reading; supplements, a face pack, newsletters) | 2 | `65298124`, `66843788` |
| Work | 1 | `61636207` |
| University student | 1 | `661afcdc` |
| Wake at 5 AM | 1 | `65297172` |
| Live a hectic life | 1 | `65756676` |
| Write a lot of memos | 1 | `66407369` |

**Where they came from** (`came_from`, 12): other routine, habit, productivity or scheduling apps (8), a to-do app
with a reminder on every item (1, `65756554`), a paper or analog diary (2, `01035435`, `168f42da`), the phone's
built-in app (1, `cc32bf96`).

**How they found it** (`why_chose`, 9): an **App Store editors' pick** (2, `62250619`, `65267659`), a friend's
recommendation (2, `33c2b34f`, `65774215`), an Instagram ad (`17135f90`), store search (`67543729`), by chance
(`68132544`), its good reviews (`67163740`), its introduction (`97463a11`). One waited for the phone app after the web
(`68125799`).

---

## 6. What's broken and what's wished for

### Broken (54 reviews, 41%)

| Kind | Reviews | IDs |
|---|---|---|
| **Won't open or crashes on launch** | 15 | `63334404`, `e1a4e9d2`, `61642566`, `67488650`, `67508051`, `67513706`, `a5b48bd1`, `67529178`, `67538747`, `67539091`, `67509097`, `67513853`, `67540446`, `67541095`, `67539332` |
| Stuck on a screen; nothing can be tapped (first screen, the "last step", the tutorial) | 8 | `ba72ca66`, `67163740`, `68008610`, `68050490`, `68087697`, `68089520`, `67918946`, `68095283` |
| Can't log in or sign up | 6 | `e157befc`, `fc0345b5`, `65858077`, `65864791`, `d4e74dcc`, `edef112a` |
| Records lost or wrong (ticks vanish, deleted routines stay, typing wiped by a refresh, badges come and go) | 5 | `3ce547e6`, `0a9f520e`, `78b37b96`, `6ccb2b06`, `1c86c481` |
| Closes during an action (a memo, editing, a popular routine, an alarm) | 4 | `17135f90`, `abbfd761`, `c23ee39b`, `586fafb9` |
| Slow | 4 | `cc7f8983`, `32aadb92`, `586fafb9`, `168f42da` |
| Can't delete the account; can't connect | 2; 2 | `62556876`, `cb4410e3`; `67521900`, `67543729` |

(A review can be in more than one kind; small one-off bugs are left out.) **On 14 December, 10 reviews came in, 8 of
them about the app crashing or not opening** after an update; December had 31 of its 45 reviews reporting a bug and
an average of 3.51★.

### Wished for (35 reviews)

| Wish | Reviews | IDs |
|---|---|---|
| Reorder or sort the routine list (by time, by dragging) | 4 | `5482c144`, `70f8372c`, `68132544`, `1b37c820` |
| Colours, fonts, skins, dark mode | 4 | `40e356a5`, `5d20e491`, `63073147`, `68002332` |
| More ways to repeat: times a week, weekly or monthly, set dates, weekdays vs weekends | 4 | `65296709`, `87e1307c`, `67324983`, `67857277` |
| A widget | 3 | `64583974`, `65397111`, `68029962` |
| **More privacy:** share only with chosen friends, a private account, private reflections | 3 | `87e1307c`, `65540383`, `661afcdc` |
| One-time to-dos or a bucket list beside the routines | 3 | `40e356a5`, `403638c4`, `168f42da` |
| Apple Watch; find my ID | 2; 2 | `65277787`, `65400478`; `65858077`, `65864791` |

Once each: export to Excel (`61640397`), choose when the day ends (`bd70e405`), English or Japanese (`3688f08d`),
suggested routiners with similar habits (`403638c4`), a ready-made first routine (`5482c144`), a monthly calendar or
graph of progress (`67857277`), gifting a subscription (`66843788`).

**The social side cuts both ways.** It's what people with a pain point like most, but two people didn't know strangers
could see them: *"1도 모르는 사람들이 내 이름을 보고 들어와서 내 루틴을 보고 평가할수 있는게 나는 별로 좋지는 않음"*,
"I don't really like that people I don't know at all can see my name, come in, and judge my routine" (`87e1307c`);
*"다른사람에게 제 루틴이 보이는줄 모르고있다가 누가 이모티콘을 보내서 조금 놀랐거든요"*, "I didn't know others could see
my routine until someone sent me an emoji, and I was a bit startled" (`65540383`).

**Disliked:** frequent updates and a changed interface (3: `abbfd761`, `1c86c481`, `d1d4f0d8`); hard to learn at first
(3: `b7208246`, `67543729`, `67689214`, who asks *"큰 변화 없이 오류만 수정하면서 계속 이어나갔으면 좋겠어요"*, "please
keep going without big changes, only fixing bugs"); editing a habit rewrites its past records (`68127339`).

---

## 7. What changed

The first year of MyRoutine; later years will be added here. Beside it, the same study's first full year of
**Routinery** (2020), a timer-led routine app:

| | MyRoutine 2020 | Routinery 2020 |
|---|---|---|
| Reviews | 131 (all Korean) | 1,122 (62% English, 19% Korean) |
| Name a pain point | 18 (14%) | 166 (15%) |
| Can't start or keep going | **61%** | 27% |
| Tried everything else | **50%** | 16% |
| Mornings go badly | 0 | **31%** |
| ADHD and similar | 0 | 15% |
| The most liked feature among people with a pain point | **Other people's routines** | A timer on every step |
| Say they paid | 6 (4.6%) | 25 (2.2%; 6.4% of Korean reviews) |
| What premium holds, from the reviews | Not said | More than two routines |

MyRoutine's people name almost one pain, **keeping going**, and say other people are what keeps them going; Routinery's
name the pains of the clock (mornings, lost time). Its paying rate (4.6%) is close to Routinery's Korean rate (6.4%).

---

## 8. Limits

- **Small:** 18 people name a pain point, and three groups have one or two people. The shares describe the 18, not
  every user.
- **Clustered:** 9 of the 18 wrote on 13 or 26 October, all 5★; 8 App Store reviews, all 5★, came on 6 July, in the
  phone apps' first week. The reviews don't say why. The 5.00★ averages are of enthusiastic reviewers, not of every
  user.
- **One market:** every review is Korean, so nothing here says how people elsewhere use it.
- **Half a year:** the phone apps came out in July, so this is July to December.
- **Bug reports crowd out the rest:** most of the 54 people reporting a bug say nothing about who they are or why they
  came, so the groups come from the happier half of the reviews.
- **Paying is mostly unsaid** (124 of 131), and no review says what premium holds.
- Feature kinds are sorted by keywords on the labels' feature text and every match was checked by hand (four traps
  are listed in [README.md](<README.md>)).

---

## Appendix: every group member

| Line | ID | Store | ★ | Language | Groups | Paid |
|---|---|---|---|---|---|---|
| 4 | `f3d4dccf` | Play | 5 | ko | 1 Can't start or keep going | not said |
| 5 | `61622784` | App Store | 5 | ko | State only a goal | not said |
| 10 | `61636207` | App Store | 5 | ko | State only a goal | not said |
| 15 | `61646772` | App Store | 5 | ko | State only a goal | not said |
| 23 | `62250619` | App Store | 5 | ko | 1 Can't start or keep going; 2 Tried other apps, planners or a paper diary | not said |
| 30 | `65294837` | App Store | 5 | ko | 2 Tried other apps, planners or a paper diary | not said |
| 36 | `65297172` | App Store | 5 | ko | State only a goal | not said |
| 37 | `65298124` | App Store | 5 | ko | 1 Can't start or keep going | not said |
| 38 | `5eff2012` | Play | 5 | ko | 4 Forget small habits | not said |
| 39 | `ce443230` | Play | 5 | ko | 3 Overwhelmed | not said |
| 42 | `61623024` | App Store | 5 | ko | State only a goal | not said |
| 46 | `62665137` | App Store | 5 | ko | 1 Can't start or keep going; 2 Tried other apps, planners or a paper diary | not said |
| 50 | `403638c4` | Play | 5 | ko | 1 Can't start or keep going | not said |
| 54 | `01035435` | Play | 5 | ko | 2 Tried other apps, planners or a paper diary | not said |
| 58 | `a363537c` | Play | 5 | ko | 1 Can't start or keep going; 2 Tried other apps, planners or a paper diary | not said |
| 66 | `65753826` | App Store | 5 | ko | 1 Can't start or keep going | not said |
| 71 | `8e7a60f3` | Play | 5 | ko | 2 Tried other apps, planners or a paper diary; 3 Overwhelmed | not said |
| 72 | `65774215` | App Store | 5 | ko | 1 Can't start or keep going | not said |
| 92 | `65756554` | App Store | 5 | ko | 1 Can't start or keep going; 2 Tried other apps, planners or a paper diary | not said |
| 93 | `65756676` | App Store | 5 | ko | 4 Forget small habits; 5 Lose time | not said |
| 96 | `66843788` | App Store | 5 | ko | 1 Can't start or keep going | not said |
| 103 | `68127339` | App Store | 4 | ko | State only a goal | not said |
| 104 | `67541095` | App Store | 4 | ko | State only a goal | not said |
| 114 | `67838994` | App Store | 5 | ko | State only a goal | not said |
| 126 | `67543729` | App Store | 4 | ko | State only a goal | not said |
| 127 | `67689214` | App Store | 5 | ko | 1 Can't start or keep going; 2 Tried other apps, planners or a paper diary | not said |
| 130 | `168f42da` | Play | 4 | ko | 2 Tried other apps, planners or a paper diary | not said |

27 people: 18 in at least one pain-point group, 9 with a goal only. Checked: every ID in this report is in `Review Labels/MyRoutine/2020/reviews.jsonl`.
