# iPad Sync and Server Trust — Backlog #5

*Written by Claude (Claude Code), 26 Sep 2026. Evidence for [Backlog #5](<../../../Architecture/Backlog.md>) ("CloudKit sync for people without our account"). Research, not a decision.*

**Three questions this answers:**
1. What is "CloudKit sync", and why does #5 decide whether we have one sync system or two?
2. If someone doesn't want their data on our server, what happens to them today?
3. From the reviews: is the iPad segment worth it, and do people refuse to send data to a server?

**Evidence:**
- **A fresh screen** of all 1,487,223 reviews (App Store habit apps 337,331; Play Store 901,453; Apple/Google/Microsoft/Samsung's own apps 248,439), 13 patterns in ~12 languages, 19,229 matches.
- **1,712 read in full and hand-coded** (App Store 932, Play Store 741, native 39). Every quote below is verbatim and checked by script.
- **The trust patterns were read in full, not sampled:** every App Store and Play Store match for forced accounts, server distrust, local-only, "prefer iCloud", privacy praise and "no account" praise.
- **The iPad patterns were sampled**, at most 6 reviews per app.
- **Files:** [`iPad and Server Trust Evidence/`](<iPad and Server Trust Evidence/>).

**How each claim is backed:** "users show" means reviews; "first principles" means reasoning; "platform fact" means an Apple or Google rule.

---

## 1. The short answer

| Question | Answer |
|---|---|
| **Is iPad worth it?** | **Yes, as a synced second screen. Not as a reason to build a second sync system.** iPad reviews are rare (0.56% of App Store reviews) but come from **buyers**: they mention paying **2.1×** as often as the average review. The complaint is almost always the same: *"I paid, and my iPhone and iPad don't sync."* |
| **Do people refuse to send data to a server?** | **A small, loud minority does, and they object to being *forced*.** Across every match we read, 55 reviews say no to storing data online or on the developer's server. **160** want cloud sync or backup, or lost data for lack of it. No review asks for both. The anger (1.42★) is at sign-up walls before trying the app, and at apps that sell data. |
| **What do we do today for them?** | **Nothing goes to our server unless they sign in.** The app works fully on the phone. Backups go to *their own* iCloud or Google Drive. Sync between devices is the one thing that needs a sign-in. |
| **So, CloudKit sync?** | **Keep one sync system.** The only people it would serve are those who (a) have an iPhone and iPad on the **same Apple ID**, (b) want live sync, and (c) refuse even Sign in with Apple. **6 of 1,712** reviews read are that person. **220** want iPhone ⇄ iPad sync and don't care how it's done. Several need what iCloud *can't* do: different Apple IDs, Android, or a full iCloud. |

---

## 2. What "CloudKit sync" means, in plain words

**Our plan today** (first principles, from [05 Sync](<../../../Architecture/05. Sync Engine.md>) and [03 Backup](<../../../Architecture/03. Backup and Restore.md>)):

```
 Signed in:      iPhone ⇄ our server (Cloudflare) ⇄ iPad / Android / web     ← live sync
 Not signed in:  iPhone ──(one-way dated copies)──► their own iCloud          ← backup only
```

- **Sync** means a change on one device appears on the others within seconds, and the two copies are *merged*.
- **Backup** means a dated copy you can restore from. It doesn't merge, and it doesn't keep two devices in step.

**What #5 asks:** should a person who never signs in still get *live* iPhone ⇄ iPad sync, running through their own iCloud (Apple's CloudKit) instead of our server?

```
 Option "yes":   iPhone ⇄ their iCloud (CloudKit) ⇄ iPad      ← a second, Apple-only sync path
                 iPhone ⇄ our server ⇄ everything else          ← still needed for everyone else
```

**Why that means two sync systems** (first principles):
- Sync is the hard part of the app. Two devices change the same habit. A delete must never come back. A phone with a wrong clock must not win. The same check-in must never count twice. [05 Sync](<../../../Architecture/05. Sync Engine.md>) solves all of this **once, on our server**.
- CloudKit sync would need all of that again, on a system we don't control, **plus** a hand-over. When a CloudKit user later signs in, the two systems must agree without losing or doubling anything.
- CloudKit only reaches Apple devices **on the same Apple ID**. Android, web and Windows still need our server, so ours can never go away.

---

## 3. What happens today to someone who won't use our server

This is already designed ([01 Accounts](<../../../Architecture/01. Accounts and Identity.md>), [03 Backup](<../../../Architecture/03. Backup and Restore.md>), [09 Privacy](<../../../Architecture/09. Privacy and Account Deletion.md>)):

| They get | How |
|---|---|
| **The whole app, forever, no account, no email** | "No account needed, ever. The app opens straight into Today" (01 rule 1). |
| **Nothing on our server** | No hidden guest account and no server ID. The only identity is a local install ID used for diagnostics (01 §3). |
| **Automatic backup to *their* cloud** | iPhone: dated snapshots in **their** iCloud (CloudKit private database), with no prompt. Android: one tap connects **their** Google Drive. We can't read either. |
| **Backups they can see and move** | A folder auto-export to any place they choose (iCloud Drive, Files, Drive), plus manual export and import as an open zip. |
| **A new phone without an account** | The QR move. It passes through our server, but **encrypted end to end**: the key sits in the QR code and never reaches us, and the copy is deleted after 15 minutes (04 §4). |
| **Plus without an account** | The purchase is verified by the store on the device. It's never forced (02). |
| **One thing they don't get** | **Live sync between devices.** On a second device they can "Use on its own", or copy data across once with the QR move. The copy then doesn't update (07 §7, 04 §4.1). |

**So the question in #5 is only about that last row.**

---

## 4. Is the iPad segment worth it?

### 4.1 How many people bring up the iPad

| Measure | Value |
|---|---|
| App Store habit-app reviews that mention the iPad | **1,883 of 337,331 = 0.56%** (5.6 per 1,000), across 55 apps |
| …that are really about the iPad (read and checked) | 86% of those sampled. About **0.48%** |
| Per year, recent | **3.6–5.3 per 1,000** reviews in 2021–2026. The peak was **11.1 per 1,000** in 2020, the lockdown year |
| Mean rating (App Store) | **3.57** vs 4.24 for all App Store reviews |

**Reviews undercount iPad users.** People write about the iPad when it breaks. Apple doesn't publish how many iPads are in use; it gives only a combined figure of [2.5 billion active Apple devices](https://appleinsider.com/articles/26/01/29/apple-reaches-25-billion-active-devices-after-record-breaking-quarter). So 0.5% is a floor for "people who care enough to write".

### 4.2 Who they are: buyers

| Measure | iPad reviews | All App Store reviews | Lift |
|---|---|---|---|
| Mentions paying (paid, premium, subscribed, lifetime… in 12 languages) | **23.8%** | 11.1% | **×2.1** |
| …when the review is about iPad **sync** | **28.5%** | 11.1% | **×2.6** |

In the coded sample, **92 of 363** iPad or tablet reviews (25%) name a purchase. For sync complaints it's **63 of 220** (29%). Users show:

- “Do not buy if you expect to sync with iPad.” (`A1#48313`)
- “That is the whole reason I bought the premium subscription.” (`A59#15054`)
- “I probably wouldn’t have subscribed if I had noticed this sooner.” (`A7#340`)
- “I’d suggest adding another pricing tier to add this feature. I’d pay it. I use my MacBook, 2 iPads, and iPhone interchangeably” (`A36#509`)
- “Готова купить пожизненную подписку, но хотелось быть уверенной, что есть синхронизация с айпадом по iCloud.” — *I'm ready to buy lifetime, but I want to be sure it syncs with my iPad* (`A59#12282`)
- “If there was an iPad app I’d purchase for sure.” (`A20#570`)

### 4.3 What they ask for

Sample of 363 iPad or tablet reviews, 60 apps. A review can carry several codes.

| What they say | Reviews | Mean ★ | What it means for us |
|---|---|---|---|
| **iPhone and iPad don't sync, or sync breaks** | **106** | 2.97 | The biggest single iPad complaint |
| **Please let iPhone and iPad sync** | **76** | 4.05 | Happy users asking for it |
| **Make an iPad version** | 74 | 4.15 | We ship universal ([07 §7](<../../../Architecture/07. Other Surfaces.md>)) |
| **The iPad version is a stretched iPhone app, crashes, no landscape** | 62 | 3.48 | Same |
| **The iPad is my main device** | 29 | 3.83 | e.g. “half of my mobile time is spent on iPad” (`N6#6918`) |
| **Android phone + iPad (cross-platform)** | 19 | 3.32 | Only an account can do this, not iCloud |
| **Paid on one device, not on the other** | 10 | 3.00 | Entitlements (topic 2) |
| **iPhone and iPad sync well (praise)** | 18 | 4.94 | e.g. “Нормальная синхронизация между iPhone и iPad. У многих приложений либо нет версии для iPad, либо данные не синхронизируются с iPhone.” (`A46#856`) — *proper sync, unlike most apps* |

**Users show:** the iPad is a second screen people use at home or at a desk, alongside the phone they carry:
- “I do switch from my phone to my iPad in the evening and wish the routines would sync.” (`A5#3009`)
- “I use Fabulous on my Ipad but I also wanna use it on my Iphone cause I don&#39;t carry my Ipad with me all the time.” (`A24#553`)

**Verdict: worth it.** It isn't a big group, but it's a paying one, and working sync is what wins them.

---

## 5. Do users refuse to send data to a server?

**Your assumption was: "not everyone will send their data to our server".** Partly true. Every match below was read, not sampled.

| Group (App Store + Play Store) | Reviews | Apps | Mean ★ |
|---|---|---|---|
| **Want cloud sync or backup, or lost data without it** | **160** | 43 | 3.36 |
| **Like that no account is needed, or that data stays local** | **179** | 48 | **4.87** |
| **Complain about a forced account** (any reason) | 86 | 26 | **1.42** |
| …of which uninstalled because of it | 20 | 8 | 1.25 |
| …of which gave privacy as the reason | 19 | 11 | 1.05 |
| **Say no to storing data online or on the developer's server** | **55** | 25 | 2.40 |
| *Separately:* want backups in their own Drive, Dropbox or Nextcloud | 8 | 7 | – |
| **Both "no server" and "I want sync"** | **0** | – | – |

### 5.1 What they actually object to

**1. Being forced to sign up before trying the app** (users show; the strongest feeling in this study, mean 1.42★):
- “Uninstalled straight away because I had to create an account before I could use. Let me use it before I decide to take this seriously, I don't want to give my info to anyone” (`P122#17295`)
- “I'm not gonna sign up for something I haven't gotten to try as a guest first. Uninstall for me.” (`P8#3150`)

**2. Data being collected or sold.** Of the privacy complaints, 68 are about selling, trackers, "consent to hundreds of vendors" or unclear policies, not about sync:
- “dont force me to make an account so you can sell my personal data” (`P12#10280`)
- “I think this app record our personal data and send some offers.” (`A4#10294`)

**3. Data on someone else's server at all.** This is the real "no server" group, and it's small:
- “This app requires you to create an account and save your data on their server(s). There is no need for this because you don’t need to share data.” (`A33#2514`)
- “I'd much rather my data was stored locally where only I have access to it.” (`P8#7017`)
- “No I don&#39;t want to login and send my data to you. Your privacy policy is garbage. […] let me back up my data to iCloud like a normal app.” (`A5#2748`)

**4. An app that stops working offline** (17, half of them about Habitica):
- “it's totally server based. Want to update anything, but have a bad internet connection? Too bad” (`P8#5049`)

### 5.2 What the same users praise

The "no account" praise is mostly about **friction**, not about fearing servers:
- “I refuse to accept that the little checklist on my phone needs to know my email.” (`P84#12543`)
- “You don't need to sign up to try out the app. No need to give my email and name, until I want to.” (`P10#11994`)

People praise local storage mainly in **private** apps: journals, mood, quitting habits.
- “I really appreciate how my entries are stored locally on my phone, and not uploaded to who knows where.” (`A10#69715`)

"Privacy" often means **people around me**, not the server. 22 reviews are about an app lock: “so that someone with your phone can’t see what you’re struggling with” (`A3#6967`).

### 5.3 The other side: local-only loses data

**The same apps that are praised for "no account" get 1★ reviews when a phone dies** (users show):
- “No Cloud Backup — Entire Year of Data Gone” (`P3#2436`), about Loop, the most-praised local-only app in the corpus
- “I lost my data when I did a factory reset.” (`A34#292`)
- “I hope they allow us to make an account and save our data on the cloud so that we don't lose any data in case the phone is damaged.” (`P3#4360`)

This study was aimed at trust, so it only catches data-loss reviews by accident. The full data-loss evidence is far larger: Feature Ledger **C034 "Data must never be lost"** is rated *Certain* across 55 apps. The Data Safety report found 53,884 matching reviews.

### 5.4 Verdict on your assumption

- **True:** some people won't create an account or store data online, and they feel strongly (1★, uninstall).
- **But what they reject is being *forced*, and data being *sold*.** No review objects to an **optional** sign-in that syncs their own data.
- **Our design already meets every one of their demands:** no account ever required, the full app offline, nothing on our server when signed out, backups to their own cloud, no data sold ([09 Privacy](<../../../Architecture/09. Privacy and Account Deletion.md>)).

---

## 6. Would CloudKit sync win the people we're missing?

**The person CloudKit sync serves:** iPhone + iPad on one Apple ID, wants live sync, won't tap Sign in with Apple. In the reviews:

| Evidence | Reviews |
|---|---|
| Asks for iCloud sync **instead of** the developer's server or account | **6** (`A5#2748`, `A33#1296`, `A33#2669`, `A48#1050`, `A33#542`, `A33#681`). Two of these are from China, where the developer's server needed a VPN |
| Names iCloud when asking for sync, but doesn't reject an account | 78. On an iPhone, "iCloud sync" is simply what people call syncing |
| Asks for "iCloud **or** an account / login / email" | 35 |
| Says iCloud is **not enough**, or avoids it | **12**: different Apple IDs on phone and iPad, iCloud full, “Please enable Email ID based back-up option. As there are users who dont use iCloud.” (`A20#3788`), “I will never enable iCloud for privacy reasons” (`A41#753`) |
| Apps whose **iCloud sync broke** or lost data | **52 reviews, 11 apps** (mean 2.77). Worst: “when I tried to sync Streaks on my iPad, which I hadn’t synced in a while, it erased all the tasks that I had tracked on my iPhone” (`A23#4460`) |

**iCloud can't do some of what iPad users ask for** (platform fact + users show):
- **Different Apple IDs:** “I purchased the app on iPhone which has different iCloud Id I just wanna login the same I’d to iPad.” (`A1#46779`), and “sign in with gmail would solve everything” (`A59#934`)
- **Android phone + iPad:** “i purchased the lifetime version and it's working well on ipad but i want to sync it with my android phone too” (`P142#11`), 19 reviews in all

**Reading it together** (first principles):
- Demand for **working iPhone ⇄ iPad sync** is real and comes from buyers (220 reviews).
- Demand for **sync that avoids our server** is tiny (6 reviews). Our account plus our own sync engine covers more of the iPad cases than CloudKit would: other Apple IDs, Android, web.
- iCloud-synced apps show exactly the failures a second system would bring back (52 reviews). Report 23 (Streaks) had already shown this in the Feature Ledger.

---

## 7. Recommendation for #5

1. **Decide: one sync system (ours). No CloudKit sync.** This makes the current lean firm, now backed by reviews rather than first principles alone.
2. **Treat the iPad as a first-class, synced surface.** That's where the money is (×2.1–2.6 buyer lift): the universal app, a real large-screen layout, sync through the account ([07 §7](<../../../Architecture/07. Other Surfaces.md>)).
3. **Make the sign-in answer the privacy objection, right where it's asked.** On the iPad's first screen and in the sign-in sheet, say it in one line: "Sign in only to sync. Apple can hide your email. We never sell data. Export or delete everything any time." *(First principles: the people who refuse are reacting to being forced and to data being sold. Saying plainly that we do neither is what removes that objection.)*
4. **Keep everything else account-free, as designed:** the whole app, backups to their own iCloud or Drive, the QR copy to a second device.
5. **Revisit only if** after launch a real share of iPad installs pick "Use on its own", keep a second device, and never sign in. That's the one number that would show demand for no-account sync. (The measurement goes with backlog #23, analytics.)

---

## 8. Method and limits

- **The screen:** `scan.py`, 13 patterns, English plus Chinese, Japanese, Korean, German, French, Spanish, Portuguese, Russian and Turkish. Counts and stats are in `mode-stats.txt` and `tally.txt`. The 9.9 MB match file (`candidates.jsonl`) and the reading batches aren't committed. `scan.py` and `sample.py` rebuild them, and they sit in `Research/Temp/backlog5-ipad-trust/`, which the checking scripts need.
- **The reading:** `sample.py`. Trust patterns: every App Store and Play Store match. iPad patterns: a sample, at most 6 per app. Native apps: 3 per pattern, for contrast.
- **Coding:** in `cls/`, one line per review, with a verbatim quote. `check_cls.py` found zero unknown keys, zero duplicates, zero unread reviews and zero quotes that don't match.
- **Precision:** a keyword match isn't the same as the topic. The share of matches that were really on topic: iPad sync 97%, iPad 86%, "prefer iCloud" 88%, forced account 63%, server distrust 52%, "no account" praise 42%. The last one is low because the Portuguese pattern also caught "sem contar" ("not to mention"). The trust numbers above count **only reviews that were read and confirmed**.
- **The paid-word lift** is a keyword measure over *all* matches, not the coded sample. It shows mentions of paying, not proven purchases.
- **Limits:** reviews over-represent people with problems. The iPad share is a floor, not the real number of iPad users. The screens looked for server distrust, so the "want cloud" count (160) is incidental and far below the true scale (see §5.3).

<!-- APPENDIX -->

## Appendix — reviews cited

36 reviews cited. Ref = store letter (A App Store, P Play Store, N native app) + app number + line index in that app's `reviews.jsonl`.

| Ref | Review ID | Store | App | Date | Stars | Codes |
|---|---|---|---|---|---|---|
| `A1#46779` | `13947497418` | App Store (in) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2026-04-11 | 4★ | IPAD_SYNC_FAIL, ICLOUD_NOT_ENOUGH, IPAD_BUYER |
| `A1#48313` | `6253109873` | App Store (mx) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2020-07-28 | 3★ | IPAD_SYNC_FAIL, IPAD_APP_BAD, IPAD_BUYER |
| `A3#6967` | `12123965670` | App Store (us) | 3. Days Since - Quit Habit Tracker - Sober Streak Day Counter | 2024-12-30 | 5★ | LOCK_PRIVACY |
| `A4#10294` | `10891582939` | App Store (se) | 4. Me+ Lifestyle Routine - Daily Planner & Habit Tracker | 2024-02-02 | 1★ | PRIVACY_CONCERN |
| `A5#2748` | `11395184650` | App Store (us) | 5. Routine Planner, Habit Tracker - Daily Time Management for ADHD | 2024-06-18 | 1★ | SERVER_DISTRUST, ICLOUD_OVER_SERVER |
| `A5#3009` | `9486900794` | App Store (us) | 5. Routine Planner, Habit Tracker - Daily Time Management for ADHD | 2023-01-09 | 5★ | IPAD_SYNC_REQ |
| `A7#340` | `13473841112` | App Store (gb) | 7. Habit Tracker - HabitKit - Streaks & Accountability | 2025-12-04 | 3★ | IPAD_SYNC_REQ, ICLOUD_REQ, IPAD_BUYER |
| `A10#69715` | `8088314653` | App Store (us) | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2021-12-02 | 5★ | LOCAL_PRAISE, SERVER_DISTRUST |
| `A20#570` | `5886190168` | App Store (ca) | 20. Habit — Daily Tracker - Crush your goals like a boss | 2020-05-01 | 4★ | IPAD_APP_REQ, IPAD_BUYER |
| `A20#3788` | `4426204671` | App Store (us) | 20. Habit — Daily Tracker - Crush your goals like a boss | 2019-07-07 | 4★ | ICLOUD_NOT_ENOUGH |
| `A23#4460` | `10125490424` | App Store (us) | 23. Streaks - The habit-forming to-do list | 2023-07-10 | 1★ | IPAD_SYNC_FAIL, ICLOUD_SYNC_FAIL, ICLOUD_LOSS |
| `A24#553` | `8670335661` | App Store (at) | 24. Fabulous - Daily Habit Tracker - Morning Routines & ADHD Help | 2022-05-14 | 3★ | IPAD_SYNC_REQ, IPAD_PRIMARY |
| `A33#542` | `5716375250` | App Store (cn) | 33. Habitify - Habit Tracker - Daily Goals, Routine & Streaks | 2020-03-26 | 3★ | ICLOUD_OVER_SERVER |
| `A33#681` | `3208341657` | App Store (cn) | 33. Habitify - Habit Tracker - Daily Goals, Routine & Streaks | 2018-09-20 | 5★ | ICLOUD_OVER_SERVER |
| `A33#1296` | `11626791974` | App Store (id) | 33. Habitify - Habit Tracker - Daily Goals, Routine & Streaks | 2024-08-19 | 1★ | ICLOUD_OVER_SERVER, SERVER_DISTRUST |
| `A33#2514` | `3837963170` | App Store (nl) | 33. Habitify - Habit Tracker - Daily Goals, Routine & Streaks | 2019-03-03 | 1★ | ACCT_FORCED_BAD, SERVER_DISTRUST |
| `A33#2669` | `4505011830` | App Store (pl) | 33. Habitify - Habit Tracker - Daily Goals, Routine & Streaks | 2019-07-23 | 4★ | ICLOUD_OVER_SERVER, NOACCT_PRAISE |
| `A34#292` | `7344582690` | App Store (in) | 34. Habit Tracker - Evoday - Daily Streaks Calendar & Goals | 2021-05-16 | 5★ | ICLOUD_REQ, LOCAL_LOSS |
| `A36#509` | `8757837312` | App Store (us) | 36. (Not Boring) Habits - Science-backed habit tracker | 2022-06-09 | 4★ | IPAD_SYNC_REQ, IPAD_BUYER |
| `A41#753` | `9104605843` | App Store (us) | 41. Awesome Habits - Habit Tracker - Streaks, days since & goals | 2022-09-20 | 1★ | ICLOUD_AVOID, PRIVACY_CONCERN |
| `A46#856` | `13358297289` | App Store (ge) | 46. everyday - Habit Tracker - Daily Routine Checklist | 2025-11-05 | 5★ | IPAD_SYNC_PRAISE, IPAD_BUYER |
| `A48#1050` | `2113118458` | App Store (gb) | 48. Strides - Habit Tracker + Goals - Goal Planner & Daily Checklist | 2018-01-21 | 1★ | ACCT_FORCED_BAD, ACCT_FORCED_PRIVACY, ICLOUD_OVER_SERVER |
| `A59#934` | `13956074699` | App Store (ca) | 59. Tappsk - ToDo & Habit Tracker - Task Manager & Daily schedule | 2026-04-14 | 5★ | IPAD_SYNC_REQ, SYNC_ANY_REQ, IPAD_BUYER |
| `A59#12282` | `5917966979` | App Store (ru) | 59. Tappsk - ToDo & Habit Tracker - Task Manager & Daily schedule | 2020-05-08 | 5★ | IPAD_SYNC_REQ, IPAD_BUYER |
| `A59#15054` | `6653802158` | App Store (us) | 59. Tappsk - ToDo & Habit Tracker - Task Manager & Daily schedule | 2020-11-17 | 5★ | IPAD_SYNC_FAIL, IPAD_BUYER |
| `N6#6918` | `2469184580` | App Store (native app) (us) | 6. Google Tasks- Get Things Done - Plan, Organize & Schedule Work | 2018-04-26 | 2★ | IPAD_APP_REQ, IPAD_PRIMARY |
| `P3#2436` | `16cc8d9e-2ba1-4d55-bcec-df0d9e5ec8ee` | Play Store (en) | 3. Loop Habit Tracker | 2025-11-18 | 2★ | WANTS_SYNC, LOCAL_LOSS |
| `P3#4360` | `ee5a54a4-b1e6-41cb-8ad9-100a58f8c8a6` | Play Store (en) | 3. Loop Habit Tracker | 2024-01-31 | 5★ | WANTS_SYNC |
| `P8#3150` | `b28f9c46-1582-4ebc-bbc7-e4cf9364d05d` | Play Store (en) | 8. Habitica - Gamify Your Tasks | 2024-06-20 | 1★ | ACCT_FORCED_BAD, ACCT_FORCED_QUIT |
| `P8#5049` | `e50b072f-27a6-436f-ab71-711cc6e97fbb` | Play Store (en) | 8. Habitica - Gamify Your Tasks | 2022-07-08 | 5★ | LOCAL_WANTED |
| `P8#7017` | `295905fb-c384-4eab-b424-0e33c8067f9a` | Play Store (en) | 8. Habitica - Gamify Your Tasks | 2019-08-06 | 3★ | ACCT_FORCED_BAD, ACCT_FORCED_QUIT, SERVER_DISTRUST, LOCAL_WANTED |
| `P10#11994` | `1fcea44e-7da8-4398-be8f-9e708640048d` | Play Store (en) | 10. Habit Tracker - Habit Diary | 2021-09-01 | 5★ | NOACCT_PRAISE |
| `P12#10280` | `7f2c961c-e5e6-4843-a0fe-811fa7c1b689` | Play Store (en) | 12. Fabulous Daily Routine Planner | 2025-11-13 | 1★ | ACCT_FORCED_BAD, ACCT_FORCED_PRIVACY |
| `P84#12543` | `ba898b5e-90c4-43cd-87c0-54cd48cf7f45` | Play Store (en) | 84. Tasks - To Do List & Reminders | 2023-10-07 | 5★ | NOACCT_PRAISE |
| `P122#17295` | `f8cec9ac-54f3-4cec-9c77-bc432296bddd` | Play Store (en) | 122. Hevy - Gym Log Workout Tracker | 2023-05-29 | 1★ | ACCT_FORCED_BAD, ACCT_FORCED_QUIT, ACCT_FORCED_PRIVACY |
| `P142#11` | `c06e8fa8-ea3f-4aea-b7c5-91ade8625389` | Play Store (en) | 142. Habit Share - HabitRix | 2026-02-01 | 4★ | TABLET_SYNC_REQ, IPAD_BUYER |
