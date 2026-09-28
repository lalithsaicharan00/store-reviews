# Tasks in the Free Plan — Limit, Count or Plus?

*Written by Claude (Claude Code), 28 Sep 2026. Follows [Free Habit Limit — 5, 6, 7 or More](<Free Habit Limit — 5, 6, 7 or More.md>), which fixed the free plan at 5 habits (build and quit habits count together, and deleting one frees the slot). The question here: the app also has tasks, one-off or repeating, with no progress, streaks or stats. Should they have a free limit, count toward the 5, or be a Plus feature? This is a recommendation, not a decision.*

**How each point is backed:**
- **Users show**: review evidence.
- **First principles**: reasoned from how the product works.

---

## 1. The short answer

**Keep tasks free and unlimited, both one-off and repeating. Don't count them toward the 5. Don't put them in Plus.** Keep the upgrade moment where it is now: more than 5 habits, and every device. The app already works this way (`NewHabitView.swift`: "Tasks are always free").

| Option | What happens in reviews | Verdict |
|---|---|---|
| **Tasks count toward the 5** (one cap for habits and tasks) | The worst-rated kind of cap in the corpus: 342 reviews, **2.25★**, 45% 1★. At a pool of 4–6 items: 2.48★. | **No** |
| **A number cap on one-off tasks** | 57 reviews, **2.39★**, 46% 1★. When Tappsk capped tasks at 20, complaints rose from 0.3 to 11.3 per 1,000 reviews, and the share of reviewers saying they paid fell. | **No** |
| **Tasks as a Plus feature** | 18 reviews ask for the to-do list to be free, and 5 accept the paywall. Users say to-do lists are free everywhere: 185 name a free alternative (2.17★), and 93 won't pay for "a list" (1.96★). | **No** |
| **Repeating tasks capped or paid, one-off tasks free** | The mildest complaint type: 50 reviews, 3.20★. It is the paid lever of the two best hybrid apps. It still loses users to the free Reminders app. | Possible, but not at a pool of 5 (§5) |
| **All tasks free and unlimited** (recommended) | 292 reviews praise free or unlimited tasks (4.82★), and payers in hybrid apps say they pay for the habits. | **Yes**, with the guardrails in §6 |

**Why:**
1. **A task without streaks or stats is what every phone gives away free** (users show). Reminders, Google Tasks and Microsoft To Do make up much of the praise for free tasks ("with this app it is unlimited", `N1#8068`). A paywall on tasks gets compared with them and loses. This matches ledger card [C214](<../Feature Ledger.md#c214>), rated Certain across 22 apps.
2. **Every form of task cap is rated worse than the habit cap you already have** (users show). Here are average ratings of reviews that mention each kind of cap:
   - habit-only caps: 2.77★
   - caps on one-off tasks: 2.39★
   - one cap shared by habits and tasks: 2.25★
   - shared caps of 1–3 items: 1.45★
3. **Free tasks don't stop people paying** (users show). In apps that combine habits and to-dos, 127 of 210 reviewers who praise the combination say they paid. They pay to track more habits:
   - "you get unlimited tasks, but not recurring habits. so far, it's great" (`P2#13190`, who paid);
   - "Нет лимита на список дел в бесплатной версии … только на привычки, но я все равно купила полную" (no limit on the to-do list in the free version, only on habits, but I still bought the full version, `A59#2982`).
4. **A free task type protects the habit cap** (users show). Without one, people spend habit slots on chores and bills: 59 reviews in 18 apps, for example "some household chores don’t need to be done daily" (`A1#1759`). With free tasks, the 5-habit limit is only reached by habits, which is where the buyers are.
5. **You can't safely add a task limit later** (users show). 91 reviews complain that something free was taken away. Most come from people returning to an app after a limit was added (Me+, Tappsk, Productive, Fabulous). If tasks start unlimited, they have to stay unlimited, so decide before launch.

---

## 2. Method

- **Screen:** every review in the corpus, 1,487,223 in all:
  - 74 App Store apps;
  - 146 Play Store apps;
  - 11 native apps, including Reminders, Google Tasks and Microsoft To Do.

  Five patterns in 13 languages looked for:
  - task caps;
  - paid tasks;
  - paid repeating tasks;
  - shared caps and workarounds;
  - praise for free tasks.

  They found 3,772 reviews (`Task Limit Evidence/scan.py`, `mode-stats.txt`).
- **Read:** 3,517 reviews, every one of them, in the original language. The other 255 matched only the generic word "workaround" with no link to paying or limits (bug workarounds in Calendar, Sheets and similar), so they were set aside (`sample.py`).
- **Hand-coded:** 1,937 of the 3,517 were on topic, from 95 apps. Each got codes for:
  - what the cap covered: habits, one-off tasks, both, repeating tasks only, or the whole to-do list;
  - the number named;
  - the reaction: complaint, accepted, paid, left, "used to be free";
  - how people use tasks.

  Codebook: `Task Limit Evidence/codebook.md`. Codes: `cls/`. Every coded review: `coded.json`.
- **Checked:**
  - by script: no unknown IDs, no duplicates, no review filed in the wrong batch;
  - every quote below was compared with its review by script;
  - the 1,580 reviews not coded are off topic.
- **Year by year:** for the apps whose task rules changed, `eras.py` gives yearly figures (`eras.txt`):
  - review count;
  - mean rating;
  - cap complaints per 1,000 reviews;
  - the share of reviews that say "I paid" (same pattern as the earlier free-plan reports).
- **Totals:** `tally.txt`.

---

## 3. Users call habits "tasks"

**Of 713 complaints about free habit caps, 489 (69%) call the habits "tasks", "to-dos" or "reminders"** (users show):
- "You can only have 5 habits or tasks without premium" (`A13#16295`);
- "I have more than 5 things to do in a day and I don’t wanna pay money for that" (`A1#52086`, 1★);
- Streaks, a paid app, calls its habits "tasks" in the app itself, and 151 of its 155 cap reviews use the same word.

**What this means:**
- **Users see little difference between the two** (first principles). If free "tasks" sit next to 5 paid "habits", some people will put habits in as tasks. That is fine as long as tasks stay plain tasks (§6).
- **The words on the store page matter.** A listing that just says "unlimited tasks" will be read by many people as "unlimited habits". The earlier report found that "I thought it was free" reviews average 1.20★ ([Free Plan Design §5](<Free Plan Design — Habit Cap, Widgets and an Honest Listing.md>)). So always pair it: "5 habits free, with streaks and stats. To-dos, once or repeating, free and unlimited."

---

## 4. What each kind of task limit does

### 4.1 One cap for habits and tasks together

| Pool size | Reviews | Apps | Mean ★ | 1★ |
|---|---|---|---|---|
| All | 342 | 15 | **2.25** | 45% |
| 1–3 items | 150 | 9 | **1.45** | 72% |
| 4–6 items | 69 | 7 | 2.48 | 30% |
| 7–10 items | 22 | 2 | 2.77 | 23% |

**Me+ ran this experiment twice** (users show; mostly Me+, whose single list holds routines and to-dos).
- **Play Store, 2023: 2 items free.** Cap complaints ran at 9.4 per 1,000 reviews. The monthly rating was 2.64★ in July and 3.18★ in August. Once each extra task instead cost watching an ad, complaints fell to 0.6 per 1,000 and the 2024 rating was 4.49★.
- **App Store, mid-2025: about 5–6 items free.** Complaints rose from 0 to 13.7 per 1,000 in 2025 and 19.0 in 2026. The "I paid" share did not rise; it fell from 1.1% to 0.6%.
- **What reviewers said:**
  - "IF MY ROUTINE WAS TWO STEPS I WOULDN'T NEED THIS APP" (`P4#29605`);
  - "6 tasks is NOT a routine" (`A4#11548`);
  - "I wanted to make a to do list for my room. I have way more than Six things to be doing" (`A4#7498`);
  - "I feel that many others, like me, have just deleted the app instead of paying just to add some more tasks" (`A4#5443`).
- **People moved to other apps because of it:**
  - "Another app I tried called me+ had task limits without getting pro, and that really slowed my progress" (`A10#24288`, now on Finch);
  - "Switched from Me+ to HERE because … you can keep adding new ones" (`P22#539`).
- **Caveats:** Me+ asks for ratings inside the app (reviewers say it asks for 5★ before you can use it, `P4#24967`), so its average ratings are inflated. Read the complaint rates, not the stars.

**Counting tasks toward our 5 would put the app in the 4–6 row**, the second-worst band (users show).

### 4.2 A cap on one-off tasks

**57 reviews in 8 apps, 2.39★, 46% 1★** (users show).

**Tappsk, January 2021:** a to-do and habit app capped free one-off tasks, first at 20 and then at 50.
- Complaints went from 0.3 to 11.3 per 1,000 reviews in 2021.
- The rating went from 4.62★ to 4.48★.
- The "I paid" share went down, from 6.3% to 5.1%.
- In 2022 complaints fell back to 1.6 per 1,000 and the rating rose to 4.69★. A 2026 reviewer says the to-do list has no free limit, only habits (`A59#2982`).
- What reviewers said:
  - "Ввести платный режим на добавление любой задачи - отличный способ убить приложение" (putting a paywall on adding any task is a great way to kill the app, `A59#10153`, 1★);
  - "20 задач за весь период? … Ещё неделю назад я могла спокойно ставить 30 задач только на день" (20 tasks in total? A week ago I could add 30 tasks for a single day, `A59#10192`);
  - "могли оставить хотя бы обычные задачи на день бесплатными" (you could at least have left ordinary daily tasks free, `A59#10618`).

**A cap can even delete data.** A to-do app that kept only 100, then 63, tasks started throwing old ones away:
- "it just starts deleting... even incomplete tasks!!!" (`P126#66475`);
- "Gibt man dann zusätzlich eine neue Aufgabe dazu, wird eine andere rausgeschmissen" (add a new task and another one is thrown out, `P126#9733`).

### 4.3 Repeating tasks limited or paid, one-off tasks free

**50 reviews in 10 apps, 3.20★, 28% 1★.** This is the mildest kind of complaint (users show).

**Both of the best-reviewed hybrid apps in the corpus work this way:**
- **HabitNow:** 7 free slots for habits and repeating tasks together, unlimited one-off tasks ("无限添加Task，可以添加5个分类，7个习惯", unlimited tasks, 5 categories, 7 habits, `P2#28982`).
  - Rating 4.70–4.73★ from 2022 to 2026.
  - Cap complaints of 3–4 per 1,000 reviews.
  - "I paid" share 2.1–3.3%, against Me+'s 0.2–1.5%.
  - Some people pay for the repeating tasks: "Just upgraded to premium … so I could set unlimited tasks" (`P2#4413`).
- **Tappsk:** 2 habits and 2 repeating tasks free, unlimited one-off tasks.

**The cost is real, though:**
- People still leave. 4 said so, including a user of several years: "I'm switching now, because the amount of recurring tasks you can have for free is just not enough for me..." (`P2#13555`). Another: "needing to buy premium to be able to repeat a task? Really? Nah... Uninstalled." (`P61#353`)
- The free Reminders app is the comparison: "While you can have unlimited non-recurring tasks, you really might as well use iOS’ Notes at that point. Heck, even iOS’ Reminders lets you have unlimited recurring tasks." (`A59#13804`)
- Free repeating tasks win praise on their own. 17 reviews praise them in to-do apps, for example "в большинстве программ необходимо платить чтобы задачу сделать цекличной" (in most apps you have to pay to make a task repeat, `P97#17578`, 5★). Another says paying for it is too much: "タスクの繰り返しが有料プランのみで年間6,900円は高い" (repeating tasks only on a ¥6,900 a year plan is expensive, `A42#82`, 1★).
- Some people accept it: "I feel like there shouldn't be a limit to how many habits or repeating tasks … but since I know this doesn't have ads … I'll give 4 stars anyway" (`P2#7128`).

**Why not copy HabitNow** (users show, and first principles):
- Its pool is 7. Ours would be 5, which is the 4–6 band above.
- Its repeating tasks sit alongside a to-do list people already value. They pay because the app has become their whole planner (87 of its 109 "habits and tasks in one" reviewers paid).
- Our Plus is a one-time purchase of about US$14.99, against HabitNow's roughly $5–10. Putting everyday chores behind it makes that price harder to accept.

### 4.4 The whole to-do list in Plus

**18 reviews in 5 apps, 3.56★** (users show).
- **Rabit (13 reviews):** 9 ask for the to-do list to be free and 3 accept the paywall.
  - "I think it should be free" (`P98#982`);
  - one would even take a daily cap: "Poderiam até colocar um limite de "to do" por dia, mas seria ótimo se fosse gratuito" (they could even set a daily to-do limit, but it would be great if it were free, `P98#385`).
- **MyRoutine** moved its to-do list into Plus and was criticised for it: "ToDoリストも有料化して、無料で利用出来る範囲が一気に減って残念です" (they made the to-do list paid too, and the free part shrank all at once, `A18#271`).
- **Productive** charged for one-off tasks: "Разовая задача просит платную подписку" (a one-off task asks for a paid subscription, `P33#5291`, 2★).

**People refuse to pay for "a list" in general** (users show):
- 185 reviews name a free alternative (2.17★) and 93 won't pay for "a list" (1.96★):
  - "why on GODS CREATION WOULD I SPEND MONEY ON A TASK APP?!!! … Get google tasks instead" (`A1#52374`);
  - "Please tell me why someone would logically pay for a TO DO LIST app????" (`A1#1623`).
- Some habit-app users leave for the free Reminders app once their tracker adds a limit: "recently they created a paywall and half my “habits” were removed … I’m got reminders for all my “habits” now" (`N1#8394`).

---

## 5. What people do with tasks

**Tasks and habits in one app is a reason to pay** (users show).
- 210 reviews praise having both in one app (4.87★), and 127 of them say they paid.
- Examples:
  - "Hier kann ich jetzt alle Gewohnheiten, ToDos, Ziele und Aufgaben vereinen wofür ich vorher 5 verschiedene Apps hatte" (I can now combine all my habits, to-dos, goals and tasks that used to take 5 apps, `A1#44325`, bought premium);
  - "It replaced multiple apps for me as I can add both use todo and habit tracker … I bought it without hesitation" (`P2#10647`).

**Without a task type, chores end up as habits** (users show).
- 59 reviews in 18 apps. For example, someone making "the one-time habit a repeated habit that you set to once a month and delete it when you finally get around to it" (`A13#13498`).
- Others don't like doing it: "Não gosto da opção de ter que utilizar os hábitos para tarefas rotineiras" (I don't like having to use habits for routine tasks, `P2#28200`).

**Few people use free tasks to get around a habit limit** (users show).
- Only 10 reviews describe any workaround, and one uses repeating tasks in place of habits: "it’s only two usable goals without premium. But you can let other tasks repeat daily … It’s very functional for me without premium" (`A59#13759`).
- 13 use repeating reminders in a to-do app as a habit tracker. Most of them are on free apps they would not have paid for anyway.
- The evidence here is thin: people who work around a limit rarely write about it. §7 says what to measure.

---

## 6. How it should work

**1. One-off tasks: free and unlimited, and never counted.** Users show (§4.2). No hidden cap either. A silent limit that quietly deletes tasks is the worst version: one user who had paid hit a 100-task ceiling and lost upcoming tasks without warning (`P126#66475`).

**2. Repeating tasks: also free and unlimited, and not counted, as long as they stay plain tasks.** First principles, with §4.3 and §5 as users show:
- Tasks keep what the New flow already says: "No habit progress, streaks or stats." No streak, no history chart, no progress ring. That is what makes a habit worth tracking and paying for, and it stays a habit feature.
- Turning a task into a habit type creates a habit, so it counts toward the 5.
- The habit-limit screen doesn't suggest "add it as a task instead". The task type is already one tap away in the New flow. The limit screen is where Plus gets explained ([Free Habit Limit §7](<Free Habit Limit — 5, 6, 7 or More.md>)).

**3. Plus stays what it is.** Unlimited habits, every device, sync and backup. Tasks sync and back up with Plus like everything else, and free tasks live on the one phone, as the rest of the free plan does ([Plus Scope and Account at Purchase](<Plus Scope and Account at Purchase.md>)). Nothing about tasks is behind the paywall. Features the free Reminders app has (reminders, repeats, subtasks) stay free (users show: 27 complaints about paid task features, 3.26★, 6 of them naming a free app).

**4. Say it plainly** (users show, §3 and [Free Plan Design §5](<Free Plan Design — Habit Cap, Widgets and an Honest Listing.md>)):
- **In the app:** keep the current footer, "[N] of 5 free habits used. Tasks are always free."
- **On the store page:** "Track 5 habits free, with streaks and stats. Tasks, once or on repeat, are free and unlimited." Don't write "unlimited tasks" without the habit line next to it.
- **Why it matters:** people who hit a limit they weren't told about are angry about the time they wasted. "gostaria de ter sido avisada sobre o limite antes de perder tempo preenchendo tudo!" (I wish I'd been told about the limit before wasting time filling everything in, `P2#25695`); "didn't clearly mention the task limit" (`A4#9394`).

**5. Decide now and don't change it later** (users show, §1 point 5). If tasks launch unlimited, they stay unlimited. Free users have no account (free is local, one phone), so anyone who reinstalls counts as a new user. You can't exempt existing users from a new limit.

---

## 7. What would change the answer

**Measure from launch:**
1. The share of free users who reach 5 habits, and how many of them buy within 14 days (from the earlier report).
2. Among free users at the 5-habit limit, the share who create 3 or more repeating tasks within 7 days, and how many of those are named like habits (for example, matching the habit suggestion list).
3. Conversion at the limit for that group, compared with everyone else at the limit.
4. Reviews that mention tasks or to-dos, per 1,000.

**If free repeating tasks turn out to replace habits** (the group in point 2 is large and buys much less), don't add a task cap afterwards (§6 point 5). Instead, make the difference clearer:
- the streak and stats on each habit;
- widget progress rings.

Only one option has review support, and only before launch: HabitNow's shared pool for habits and repeating tasks. It would need a pool larger than 5, around HabitNow's 7, and it changes the promise from "5 habits" to "7 habits and repeating tasks" (§4.3).

---

## 8. Limits of this research

1. **Reviews are not sales data.** The "I paid" shares are signals, and apps differ in price and model (subscription or one-time).
2. **The year-by-year comparisons have other things going on.** Me+ asks for ratings inside the app, and several apps changed prices in the same years. They show which way things moved, not how much.
3. **The hybrid-app evidence comes from a few apps.** Most of it is HabitNow, Tappsk, Me+, Rabit and Hizo. The "4–6" and "7–10" rows are small (69 and 22 reviews).
4. **People rarely write about substitution.** The small number of workaround reviews doesn't prove substitution is rare in the app itself. That is why §7 measures it.
5. **Productive, Do Habits and Fabulous call habits "tasks".** Their caps are coded as habit caps, not task caps.

<!-- APPENDIX -->

## Appendix — reviews cited

40 reviews cited. Ref = store letter (A App Store, P Play Store, N native app) + app number + line index in that app's `reviews.jsonl`. Codes are defined in `Task Limit Evidence/codebook.md`; every coded review is in `Task Limit Evidence/coded.json`.

| Ref | Review ID | Store | App | Date | Stars | Codes |
|---|---|---|---|---|---|---|
| `A1#1623` | `13768262254` | App Store (ca) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2026-02-20 | 1★ | HCAP, N5, NEG, FREE_ELSEWHERE |
| `A1#1759` | `11523932529` | App Store (ca) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2024-07-23 | 2★ | HABIT_FOR_TODO, HCAP, NEG |
| `A1#44325` | `5923106755` | App Store (de) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2020-05-09 | 5★ | ALLINONE, PAID |
| `A1#52086` | `11625465254` | App Store (us) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2024-08-18 | 1★ | TW_HABIT, HCAP, N5, NEG, LEFT |
| `A1#52374` | `11232123969` | App Store (us) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2024-05-04 | 5★ | TW_HABIT, HCAP, N4, NEG, FREE_ELSEWHERE |
| `A4#5443` | `13387105218` | App Store (gb) | 4. Me+ Lifestyle Routine - Daily Planner & Habit Tracker | 2025-11-12 | 2★ | SHARED, NEG, BAIT, LEFT |
| `A4#7498` | `14096559570` | App Store (ie) | 4. Me+ Lifestyle Routine - Daily Planner & Habit Tracker | 2026-05-23 | 1★ | SHARED, N6, NEG, HABIT_FOR_TODO |
| `A4#9394` | `12969778054` | App Store (nz) | 4. Me+ Lifestyle Routine - Daily Planner & Habit Tracker | 2025-08-03 | 3★ | SHARED, N6, NEG |
| `A4#11548` | `13557184530` | App Store (us) | 4. Me+ Lifestyle Routine - Daily Planner & Habit Tracker | 2025-12-26 | 1★ | SHARED, N6, NEG, BAIT |
| `A10#24288` | `13814604520` | App Store (us) | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2026-03-05 | 4★ | TASK_FREE_PRAISE, SHARED, NEG |
| `A13#13498` | `5399355171` | App Store (us) | 13. Productive - Habit Tracker - Daily Routine & Goals Planner | 2020-01-13 | 4★ | HABIT_FOR_TODO, TODO_DEMAND, PAID |
| `A13#16295` | `1882210922` | App Store (us) | 13. Productive - Habit Tracker - Daily Routine & Goals Planner | 2017-10-29 | 3★ | TW_HABIT, HCAP, N5, NEG |
| `A18#271` | `10787375859` | App Store (jp) | 18. MyRoutine - Organize your day - Built around your real life | 2024-01-05 | 2★ | TODO_PAID, NEG, BAIT |
| `A42#82` | `11948614593` | App Store (jp) | 42. Daily Habit & Routine Tracker - Goals planner. Productive days | 2024-11-14 | 1★ | RECUR_PAID, NEG |
| `A59#2982` | `13962874852` | App Store (ru) | 59. Tappsk - ToDo & Habit Tracker - Task Manager & Daily schedule | 2026-04-16 | 5★ | TASK_FREE_PRAISE, HCAP, PAID |
| `A59#10153` | `7081671398` | App Store (ru) | 59. Tappsk - ToDo & Habit Tracker - Task Manager & Daily schedule | 2021-03-09 | 1★ | TCAP, NEG, BAIT, WANT_MORE |
| `A59#10192` | `7059732384` | App Store (ru) | 59. Tappsk - ToDo & Habit Tracker - Task Manager & Daily schedule | 2021-03-03 | 3★ | TCAP, N20, NEG, BAIT |
| `A59#10618` | `6846738817` | App Store (ru) | 59. Tappsk - ToDo & Habit Tracker - Task Manager & Daily schedule | 2021-01-08 | 1★ | TCAP, NEG, BAIT |
| `A59#13759` | `9655364829` | App Store (se) | 59. Tappsk - ToDo & Habit Tracker - Task Manager & Daily schedule | 2023-02-25 | 5★ | TASK_FREE_PRAISE, HCAP, N2, OK, WORKAROUND |
| `A59#13804` | `7222832694` | App Store (sg) | 59. Tappsk - ToDo & Habit Tracker - Task Manager & Daily schedule | 2021-04-14 | 1★ | RECUR_PAID, N2, NEG, FREE_ELSEWHERE, HCAP, N2, NEG |
| `N1#8068` | `13215377130` | App Store (native app) (gb) | 1. Reminders - Don’t forget. Use Reminders | 2025-10-02 | 5★ | TASK_FREE_PRAISE, FREE_ELSEWHERE |
| `N1#8394` | `11443263250` | App Store (native app) (gb) | 1. Reminders - Don’t forget. Use Reminders | 2024-07-01 | 5★ | RECUR_AS_HABIT, HCAP, NEG, LEFT, FREE_ELSEWHERE, BAIT |
| `P2#4413` | `e0ba4115-23bd-4882-a9fd-e4a0d8bd3d77` | Play Store (en) | 2. HabitNow Daily Routine Planner | 2024-08-12 | 5★ | ALLINONE, PAID, SHARED, HABIT_FOR_TODO |
| `P2#7128` | `0c7e8664-c822-46d4-94d8-0cdff7d881f7` | Play Store (en) | 2. HabitNow Daily Routine Planner | 2023-08-18 | 4★ | SHARED, RECUR_PAID, OK |
| `P2#10647` | `4894c224-251b-4383-9194-093a293ce679` | Play Store (en) | 2. HabitNow Daily Routine Planner | 2021-12-27 | 5★ | ALLINONE, PAID |
| `P2#13190` | `f916939b-e463-482f-ad18-8f28b8f1ebde` | Play Store (en) | 2. HabitNow Daily Routine Planner | 2019-07-27 | 5★ | TASK_FREE_PRAISE, HCAP, PAID |
| `P2#13555` | `e5078004-0fb5-4413-9ab5-20a556d362f1` | Play Store (es) | 2. HabitNow Daily Routine Planner | 2026-02-12 | 4★ | RECUR_PAID, NEG, LEFT |
| `P2#25695` | `260e1095-f079-41f1-b1a8-d14230e8ff3f` | Play Store (pt) | 2. HabitNow Daily Routine Planner | 2023-05-10 | 4★ | SHARED, RECUR_PAID, NEG |
| `P2#28200` | `c653b437-1610-40bf-a451-22e961240456` | Play Store (pt) | 2. HabitNow Daily Routine Planner | 2021-02-09 | 3★ | TODO_DEMAND, HABIT_FOR_TODO, NEG |
| `P2#28982` | `c9065e31-a8d8-4ebd-8a42-8e7a9e56027b` | Play Store (zh-CN) | 2. HabitNow Daily Routine Planner | 2022-11-18 | 5★ | TASK_FREE_PRAISE, HCAP, N7, OK, ALLINONE |
| `P4#24967` | `2dffeac7-5db3-4f1d-adcf-afc5fe53a4d5` | Play Store (en) | 4. Me+ Lifestyle Routine | 2023-12-07 | 1★ | SHARED, N2, NEG |
| `P4#29605` | `38075390-2c7d-4c56-8299-0fb2c2938862` | Play Store (en) | 4. Me+ Lifestyle Routine | 2023-08-21 | 1★ | SHARED, N2, NEG |
| `P22#539` | `fe74acb1-c6f5-4725-99a2-1687dc3be5bc` | Play Store (en) | 22. Disciplined - Habit Tracker | 2025-02-19 | 5★ | TASK_FREE_PRAISE, SHARED, NEG, LEFT |
| `P33#5291` | `790fbd02-586c-40fd-9112-fff92a696b2e` | Play Store (ru) | 33. Productive - Habit tracker | 2024-08-15 | 2★ | TODO_PAID, NEG |
| `P61#353` | `ff8356a2-ce51-4766-9825-287b1807d315` | Play Store (en) | 61. Hizo - Habit Tracker & Todo | 2025-06-28 | 1★ | RECUR_PAID, NEG, LEFT |
| `P97#17578` | `2e9477f7-10c9-49c1-89eb-fd88adb00654` | Play Store (ru) | 97. To-do list - tasks planner | 2025-02-07 | 5★ | RECUR_FREE_PRAISE, TASK_FREE_PRAISE |
| `P98#385` | `1269ec69-27a0-4d4c-8312-74e04d7cd919` | Play Store (en) | 98. Rabit - Habit Tracker & Planner | 2023-01-17 | 4★ | TODO_PAID, NEG, TCAP, OK |
| `P98#982` | `79028600-36fa-4116-a843-f7accf4f36cf` | Play Store (en) | 98. Rabit - Habit Tracker & Planner | 2021-06-06 | 5★ | TODO_PAID, NEG |
| `P126#9733` | `23db5959-8956-4ef1-8ddf-bd5996a5e4f8` | Play Store (de) | 126. To Do List | 2026-07-17 | 1★ | TCAP, N63, NEG, LEFT, BAIT |
| `P126#66475` | `6446c1ce-a3f4-4f64-a13b-b7dc372272df` | Play Store (en) | 126. To Do List | 2019-11-27 | 1★ | TCAP, N100, NEG |
