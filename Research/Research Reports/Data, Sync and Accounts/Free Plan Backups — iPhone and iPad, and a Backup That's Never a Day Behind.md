# Free Plan Backups — iPhone and iPad, and a Backup That's Never a Day Behind

*Written by Claude (Claude Code), 9 Oct 2026. Current Work 75. Research and a recommendation.*

> **Decided by the user, 10 Oct 2026: option B, backed up as you go**, for every free user, as §7 sets out (10-minute
> gap, a smaller file first, the iCloud reinstall fix before release). The user asked first whether it would cost too
> much; §5's model answers it.

**The user's questions (9 Oct):**
1. How backup works today is confusing: explain it from the reports.
2. **iPhone and iPad without an account** both back up to the same iCloud. Can the copies collide or duplicate? On the
   free plan the two devices must **not** sync.
3. **A free account backs up once a day.** Someone who made an account thinks they're safe, loses the phone, signs in on
   a new one, and the last day is missing. Is that fine? If not, how do we solve it?
4. Should a free account back up **everything, as it happens** (server "sync", for that one device only), since free
   users have few habits and one device? Devices must still never sync with each other on the free plan.
5. **What do we give, and what do we get?** A little profit, against goodwill and reviews. The goal is as many
   conversions as possible. Use Cloudflare's own numbers.

**How each point is backed:**
- **Users show**: reviews, from a fresh screen read by hand for this report or from an earlier report (named).
- **Measured**: Cloudflare's analytics and the dev backup bucket, read on 9 Oct 2026.
- **Code**: what the app does today, read from the source on branch `app-lock-privacy-security`.
- **First principles**: reasoned.

**Evidence:**
- **Fresh screen:** all 1,238,784 App Store and Play reviews in the repo, 3 patterns: restores missing the recent part,
  backup frequency, and "I had an account and still lost it". **103 matches, every one read and hand-coded**; 23 on topic
  from 11 apps; 12 quotes checked word for word by script. Files: [`Free Backup Freshness Evidence/`](<Free Backup Freshness Evidence/>).
- **Reused, as attributed:** [Free Plan Data Protection](<Free Plan Data Protection — Backup Without Giving Away Plus.md>)
  (1 Oct; 1,353 reviews coded), [Backup, Sync and Accounts — One Seamless Experience](<Backup, Sync and Accounts — One Seamless Experience.md>)
  (1 Oct), [Server Cost and Capacity](<../../../Architecture/Server Cost and Capacity — Free Safety Copy vs Plus Sync.md>) (1 Oct),
  [Architecture 03](<../../../Architecture/03. Backup and Restore.md>) and [07 §7](<../../../Architecture/07. Other Surfaces.md>).
- **Cloudflare:** the account's Workers, Durable Object and R2 analytics for 25 Sep – 9 Oct 2026, the backup bucket's
  objects and their metadata, and today's prices from Cloudflare's docs.

---

## The short answer

1. **iPhone and iPad can't collide, and they don't sync.** Each device writes its own file in iCloud, named by that
   device's ID, and the app never reads another device's file unless the person chooses to restore it. **But the iCloud
   backup has three problems, and the first one loses data** (§2):
   - **A reinstall wipes the iCloud backup.** The device ID survives a reinstall (it's in the Keychain), so the fresh,
     empty app writes to the *same* file. It does so seconds after it first opens, before the welcome can offer a
     restore. The server keeps a copy aside when this happens; iCloud doesn't.
   - iCloud keeps **one copy per device, overwritten each day**: no week of history, so one bad day replaces the good
     copy.
   - The restore lists can't say **which device** a copy came from ("Another device's backup"), so with an iPhone and an
     iPad it's a guess. The new welcome offers the newest first, which may be the iPad's.
2. **A day behind is not fine** (§3).
   - **Users show:** people who had a backup and lost the days after it are angry, not relieved: 11 reviews, 2.36★.
     People who made an account and found it hadn't kept their data: 12 reviews, **1.92★**.
   - **First principles:** in a habit app, the newest day is the most valuable one. A streak runs through today, so a
     backup without today shows a **broken streak**, the one number people care most about.
   - **Code:** today's "once a day" is really "the first time the app opens each day". So a lost phone loses
     **everything since this morning**: up to a full day.
3. **The best answer: back up "as you go", for every free user, with or without an account** (§4, §7).
   - Make a fresh copy **when the person leaves the app, if anything changed**, and after a log from a widget, a
     notification or the Live Activity.
   - Keep everything else as it is: still **one copy per device**, a week of history, the shrink guard, and restore only
     on purpose. It **never syncs**.
   - Without an account it goes to their iCloud, at **no cost to us**. With a free account it goes to our server.
4. **Not through the sync engine** (§4).
   - The sync engine merges everything an account sends into **one** set of habits. A free iPhone and iPad on one
     account would be mixed together: exactly the sync we don't give on free.
   - Stopping that needs new "one device" rules on the server, and it costs about twice as much.
   - Keep the sync engine for Plus, the only plan where devices meet.
5. **Give and get** (§5, §6).
   - **What it costs us:** about **$0.45 a month per 1,000 free accounts**, against $0.17 today; about $45 a month at
     100,000 free accounts.
   - **What it takes:** one extra Plus sale covers about **3,700 free-account user-years**.
   - **What we get:** data-loss reviews are among the angriest in the corpus, and free users who lose everything rarely
     come back to buy.
   - **What Plus loses: nothing.** People pay to use more devices and more habits, not for backup (payer reviews: sync
     and devices 4.3%, backup 0.9%), and this gives neither away.
6. **One cost to the person, which we can fix first.**
   - Sending the whole backup file each time uses about **47 MB a month of mobile data** a year in, with today's file.
   - Our own nightly copy of the same kind of data on the server is **4.4× smaller per record**. A smaller file brings
     this to about **11 MB a month**, about the size of three photos.

---

## 1. How backup works today, in one table

**Code** (BackupCenter.swift, SyncService.swift) and the reports above.

| | **No account** (iPhone or iPad) | **Free account** | **Plus** |
|---|---|---|---|
| Where the copy goes | Their own iCloud, a hidden folder of the app | Our server (Cloudflare R2), and the iCloud copy too | Our server, live (one Durable Object per account), plus a nightly snapshot |
| When | The first time the app opens each day (it's due once something has changed and 20 hours have passed), or during a background refresh, which iOS runs when it chooses | The same | Every change, about 2–3 seconds later, even from a widget (D12) |
| What's kept | **One file per device**, overwritten each time | **7 copies per device** (one per weekday) and a "before shrink" copy | Everything, with history; nightly snapshots kept 90 days |
| Devices | Each device its own file; nothing syncs | Each device its own copies; nothing syncs | All devices share one set of habits, kept in sync |
| What a lost phone loses | Everything since the first open today, at worst | The same | Seconds |

**In plain words:**
- **Backup** is a dated copy of one device, to restore on purpose.
- **Sync** is one set of habits shared by every device.
- Free gets backup; Plus gets sync. The confusing part is that a free account looks like an account (sign in, devices)
  but backs up on the same once-a-day rhythm as iCloud.

---

## 2. iPhone and iPad on one iCloud

### 2.1 What works

**Code:**
- **No collision.** The iCloud file is `Backups/<device ID>.zip`. The device ID is made once per device and kept in that
  device's Keychain (`…ThisDeviceOnly`), so the iPhone and the iPad always write different files.
- **No sync.** The app never reads another device's file by itself. It shows in Restore as "Another device's backup", and
  only the person's tap copies it, once.
- **No duplicates after a copy.** Habits keep their IDs inside a backup. If someone copies the iPhone's habits to the
  iPad and later buys Plus, sync matches them by ID instead of doubling them.

### 2.2 What's wrong

| # | Problem | What happens | Fix |
|---|---|---|---|
| **1** | **A reinstall overwrites the iCloud backup with an empty one** | At every launch the app checks whether a backup is due (`runIfDue`). After a reinstall it has never backed up, so one is due at once. The device ID is still in the Keychain, so the empty database is written to the **same** file, within seconds, before the welcome's "I've used it before → Restore a backup" | **Before release.** Never back up an empty database over a copy that has habits. On a fresh install, back up only once the welcome is finished. And keep a shrunk copy *beside* the old one, as the server does |
| 2 | **One copy per device, no history** | A bad update, a wrong restore or an accidental erase is backed up over the good copy the next day | Keep 7 weekday files per device, as the server does |
| 3 | **Copies have no names** | Restore shows "This device's backup" / "Another device's backup" with a date. With an iPhone and an iPad, which is which? The new welcome selects the newest, which may be the iPad's | Name each copy by its device and what it holds ("Lalith's iPad · 12 habits · today 9:41"). The file already carries the device name inside, so a small index file next to the copies is enough |
| 4 | Old devices' files stay forever | A new iPhone gets a new device ID, so the old phone's file stays as "Another device's backup" | Harmless (about 100–350 KB each); hide copies older than a year from the list |

**Measured: the server had to save this exact case on 8 Oct.** The dev bucket holds a 30-habit, 712-check-in copy
(341 KB) kept as `before-shrink`, and next to it Thursday's copy with **0 habits**, uploaded by the reinstalled test
iPhone the same morning. On the server, the shrink guard kept the good copy. **The iCloud lane has no such guard.**
Whether iCloud keeps the old file as a hidden conflict version wasn't tested; the app never looks at those, so for the
person it's gone either way. **First principles:** this is the "I reinstalled and lost everything" story, the second-largest
loss cause in the corpus (96 stories, 2.16★; [Free Plan Data Protection §3.1](<Free Plan Data Protection — Backup Without Giving Away Plus.md>)).

---

## 3. Is a day behind fine?

### 3.1 What users show

From the fresh screen (103 read, on topic 23):

| What they say | Reviews | Apps | Mean ★ | 1–2★ |
|---|---|---|---|---|
| **Had a backup, lost what came after it** (the gap between copies) | **11** | 6 | **2.36** | 7 |
| **Made an account and believed it kept their data**, then found it hadn't | **12** | 7 | **1.92** | 8 |
| Say backups aren't frequent enough, or expect every change saved | 2 | 2 | 3.00 | 1 |

*One app (Finch, App Store 10) supplies 4 of the 11 gap stories and 4 of the 12 account stories. Without it, the
groups are 7 reviews from 5 apps and 8 from 6.*

**A partial loss still gets a low star rating:**
- “it only restored my data from two weeks ago” (`A10#30797`, 1★)
- “I was able to restore data up until almost 2 weeks ago, so I only lost the data from the last 2 weeks” (`A23#4691`, 2★)
- “it also results in missing data for the past few days” (`A23#3883`, 1★)
- “There is a back-up option however you usually lose a few days of progress” (`P98#600`, 2★)
- “Automatic backups are not frequent enough” (`A23#4531`, 2★)

**People believe an account means safe:**
- “You cannot just log back into your account and have all of your stuff there” (`A10#35429`)
- “I thought journey progress was saved in the account?” (`P12#35599`, 1★)
- “why do you even have an option of creating an account if you can't backup the data” (`P22#992`)
- “when I logged in with my email all my progress was gone” (`P12#29471`, 1★: this person had finished the free trial
  and was ready to subscribe)
- From a paying user: “I would expect the ability to instantly sync to the cloud for every change” (`P2#22852`)

**Earlier studies agree:**
- Backups "not frequent enough", every 2 days or "real-time": 7 reviews, 3.57★ ([One Seamless Experience §2](<Backup, Sync and Accounts — One Seamless Experience.md>)).
- Backups months old: 5 reviews, 2.40★ ([Architecture 03](<../../../Architecture/03. Backup and Restore.md>)).
- 81 people say they left or switched apps after a loss ([Free Plan Data Protection §2.4](<Free Plan Data Protection — Backup Without Giving Away Plus.md>)).
- That report's own rule: *"Never weaken it on purpose. The gap between copies is exactly what people lose."*

**Honest scale:** stories of losing only the recent part are rare next to losing everything (643 loss stories in the
1 Oct study). Most reviews don't describe the gap at all. The point is how people react when it happens: mostly 1–2★,
and loudest from people who set up an account to be safe.

### 3.2 First principles: why the last day matters most here

- **The streak runs through today.** Streaks are worked out from the logs (D6). Restore a copy without yesterday's and
  today's logs, and the streak shows broken, even though the person kept it. That's the number people protect most.
- **An account is a promise.** "Encrypted daily backups that follow you to a new phone" is what Create Account says
  today. Someone who signed up for that and then finds a day missing feels the promise was broken, not that they were
  unlucky.
- **People can't re-log what they don't remember.** Past days can be logged by hand in the app, but a day of ticks
  across five habits, with times and amounts, is rarely remembered exactly.

**So: a day behind isn't fine.** It's survivable, but it falls exactly where the person cares most.

---

## 4. The options

| | How often | Devices kept apart? | Our cost per 1,000 free accounts a month | Mobile data per person a month (a year in) | Build |
|---|---|---|---|---|---|
| **A. Today** | First open each day | ✅ by device | $0.17 | 12 MB | – |
| **B. As you go** *(recommended)* | Leaving the app, if anything changed; after widget or notification logs | ✅ by device, as today | **$0.45** | 47 MB, or **11 MB with a smaller file** | Small: when to upload, plus background time; the server and the restore stay the same |
| C. Through the sync engine (one device, push only) | Every change | ❌ One set per account: a free iPhone and iPad would merge. Needs new "one device" rules | $0.80 | 0.2 MB | Medium–large: server rules for free accounts, ownership moves, a merge at the Plus purchase |
| D. Every change only with Plus | – | – | – | – | Turns safety into a paywall: 83 reviews against it at 2.39★, 23 call it hostage; paid backups that fail get **1.64★** ([Free Plan Data Protection §2.2](<Free Plan Data Protection — Backup Without Giving Away Plus.md>)) |

**Why B, not C** (first principles):
- **The line between free and Plus stays a line.** With B, free never shares one set of habits between devices,
  because the server never merges anything; each device keeps its own copies, as today. With C, a free account already
  merges every device's changes into one set; a server rule would then have to hold devices apart, and one wrong rule
  would give Plus away or mix two people's devices.
- **It matches the decided free plan.** A free iPhone and a free iPad each keep their own habits
  ([07 §7.1](<../../../Architecture/07. Other Surfaces.md>)). B already stores them apart; C would have to separate them
  again.
- **It's twice as cheap,** and it changes nothing on the server: the same endpoint, the same 7 weekday copies, the same
  shrink guard and restore. The rate limit is the only server change.
- **C's one advantage, tiny uploads, can be had in B** by making the backup file smaller (§6), and later, if needed, by
  sending only "today so far" between full copies.

**For no-account users, B costs us nothing:** the copy goes to their own iCloud. The only cost is iCloud space, about
100–350 KB a device.

---

## 5. Cloudflare: what it costs, measured

### 5.1 What the account shows (25 Sep – 9 Oct 2026)

- **No real users yet.** The production bucket is empty; the production Worker served 5–611 requests a day, none from
  real users. Every real number below comes from the user's own testing on dev.
- **A real backup's size:** 30 habits, 712 check-ins, 888 records = **341 KB** (about 393 bytes a record).
- **The server's nightly copy of an account:** 1,451 records = **126 KB** gzipped JSON (about 89 bytes a record), **4.4×
  smaller per record** than the backup file.
- **Worker CPU:** median 0.3–3.4 ms a request, 99th percentile at most 23 ms, inside the Paid plan's limits.
- **Durable Objects on the heaviest test day (8 Oct, sync device tests):** 567 requests, 14,298 rows written, about 36 s
  active. The server writes 2 rows per change, about 4 with indexes, as the 1 Oct model assumed.
- **Prices** (Cloudflare docs, 9 Oct): R2 $4.50 per million writes, $0.015 per GB-month, no egress fee; Durable Objects
  $0.15 per million requests and $1.00 per million rows written. Unchanged since the 1 Oct model.
- **Not checked:** which Workers plan the account is on (the API token can't read billing). The Free plan's 100,000
  Durable Object rows written a day is about 1,900 Plus users ([Server Cost §1](<../../../Architecture/Server Cost and Capacity — Free Safety Copy vs Plus Sync.md>)),
  so the $5 Paid plan is needed before launch whichever option is chosen.

### 5.2 The model

**Assumptions:** an average free user with 5 habits, about 4 logs a day on 20 active days a month, 3 visits a day that
change something, 1 widget or notification log a day, about 1,500 records a year in. Every allowance included in the plan
is ignored, so these are upper bounds. Model: [`cost_model.py`](<Free Backup Freshness Evidence/cost_model.py>).

| Free accounts | **A. Today** | **B. As you go** | C. Sync engine |
|---|---|---|---|
| 1,000 | $0.17 a month | **$0.45** | $0.80 |
| 10,000 | $1.67 | **$4.55** | $8.02 |
| 100,000 | $16.67 | **$45.47** | $80.21 |
| 1,000,000 | $167 | **$455** | $802 |

- **Per user per year:** A $0.002 · B $0.005 · C $0.010.
- **Where B's money goes:** R2 writes (80 a month per user) are about 80%; storage is unchanged, because the same 8 copies
  are overwritten.
- **No-account users cost us nothing** either way (their iCloud).

---

## 6. Give and get

**What we give:**
- About **$0.0035 per free account per year** more than today: **$29 a month at 100,000 free accounts**.
- Plus is a one-time **US$14.99** ([Architecture 02](<../../../Architecture/02. Billing and Entitlements.md>)), about $12.74
  after Apple's 15%. **One extra Plus sale pays for about 3,700 free-account user-years.**

**What we get (users show, from the 1 Oct study unless noted):**
- **Fewer of the worst reviews.** Losses after an update or bug: 1.76★, 63% one-star. Paid backups that failed: 1.64★.
  The account believers in §3: 1.92★.
- **Kept users, who are the future buyers.** 81 people left after a loss. "Was done my free trial and ready to subscribe.
  But I got a new phone… all my progress was gone" (`P12#29471`) is a lost sale *and* a 1★.
- **A reason to choose the app.** Free backup is praised at 4.58★ and named as the reason people chose an app (24
  reviews, 0% one-star). "Backed up as you go, free" belongs in the store description next to "5 habits free".

**What Plus keeps:**
- People pay for **reach and amount**, not safety: payer reviews name sync and devices 4.3%, more habits 1.8%, backup
  0.9% ([Plus Scope §3](<../Business Model and Monetization/Plus Scope and Account at Purchase.md>)).
- In the 1 Oct study, 92 people say they paid for sync against 21 for backup.
- B gives neither more devices nor more habits. **The upgrade moment stays exactly where it is:** the 6th habit, and the
  second device, where the app already says "Without Plus, the two don't stay in sync".

**Conversions, in one sentence (first principles):** the people who make a free account are the ones who care most about
their data and have used the app longest. Making their backup trustworthy protects the people most likely to buy Plus, at
a cost one sale in thousands repays.

**Being generous here is cheap and visible; being stingy is cheap and invisible until it's a 1★.** The saving from a
nightly-only backup is about $29 a month at 100,000 accounts. One lost buyer a month costs more.

---

## 7. Recommendation, in order

1. **Fix the iCloud lane before release** (data safety, D2/D4/D5):
   - Never back up an empty database over a copy that has habits.
   - On a fresh install, don't back up until the welcome is finished. Then a reinstall reaches "I've used it before →
     Restore a backup" with the old copy still there.
   - Keep 7 weekday files per device and a "before shrink" copy, as the server does.
   - Name each copy by device and contents in Restore, and select this device's own copy first, not just the newest.
2. **Make the backup file smaller**, then measure on the iPhone. The server's nightly gzip of the same records is 4.4×
   smaller per record; find out why the checked backup is bigger (it may hold uncompressed tables) before changing the
   format. It must stay importable (D5).
3. **Back up as you go, for every free user:**
   - **When:** on leaving the app, if anything changed and at least 10 minutes have passed since the last upload; after
     a log from a widget, a notification or the Live Activity (the same background time as D12's `scheduleSoon`); and at
     least once a day, as today.
   - **Where:** iCloud without an account; the account with one (the iCloud copy beside it, as today).
   - **What's kept:** the weekday copies are overwritten in place, so storage doesn't grow.
   - **Server:** raise the per-copy rate limit to about 12 an hour as a loop guard; nothing else changes.
   - **Words:** Backup & Export already says "Backed up today 09:14"; it simply stays current. Create Account's line
     becomes "Backed up as you go, encrypted, and back on a new phone just by signing in" (the user decides the words).
4. **Keep the sync engine for Plus only.** Revisit "only today's changes between full copies" only if the measured
   mobile data stays high after step 2.

**What to watch after launch** (Analytics Contract): the age of the newest backup at restore time; restores that bring
back 0 habits; and reviews that mention losing days.

---

## 8. Limits

- **The fresh screen is small and keyword-based.** It finds people who describe a gap or an account in these words;
  others were missed. Four of the 11 gap stories are from one app (disclosed in §3.1). No review tests "backed up as
  you go".
- **Usage is assumed, not measured.** There are no production users yet; the model's visits and logs a day are
  estimates. Replace them with the daily report's numbers in the first month (Server Cost §4.5).
- **Sizes come from one test account** (the user's iPhone, demo and test habits). A real free user's file will differ.
- **The iCloud overwrite is from reading the code** and the server's matching record of 8 Oct. It still needs one device
  test: reinstall with an iCloud copy, and see what's left.
- **Prices and Apple's fee** are as of 9 Oct 2026. Rerun `cost_model.py` when they change.

---

## Appendix — reviews cited

Ref = store letter + app number + line index in that app's `reviews.jsonl`. Every one of the 103 candidates was read; the
coded map is [`classification.py`](<Free Backup Freshness Evidence/classification.py>), and `verify.py` checks every quote.

| Ref | Review ID | App | Date | Stars | Code |
|---|---|---|---|---|---|
| `A10#17190` | `14172953944` | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2026-06-12 | 2★ | ACCOUNT_SAFE |
| `A10#21825` | `14106775895` | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2026-05-26 | 2★ | ACCOUNT_SAFE |
| `A10#30767` | `12939486987` | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2025-07-26 | 1★ | GAP |
| `A10#30797` | `12935578472` | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2025-07-25 | 1★ | GAP |
| `A10#35429` | `12403284805` | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2025-03-10 | 3★ | ACCOUNT_SAFE |
| `A10#36599` | `12261608514` | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2025-02-02 | 5★ | GAP |
| `A10#42119` | `11291619797` | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2024-05-21 | 3★ | GAP |
| `A10#51700` | `9938003372` | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2023-05-18 | 1★ | ACCOUNT_SAFE |
| `A20#3400` | `6938214798` | 20. Habit — Daily Tracker - Crush your goals like a boss | 2021-02-01 | 2★ | GAP |
| `A23#3883` | `8773471707` | 23. Streaks - The habit-forming to-do list | 2022-06-14 | 1★ | GAP |
| `A23#4531` | `9564489033` | 23. Streaks - The habit-forming to-do list | 2023-01-30 | 2★ | GAP, FREQUENCY |
| `A23#4691` | `8553855848` | 23. Streaks - The habit-forming to-do list | 2022-04-10 | 2★ | GAP |
| `A24#37440` | `6807744815` | 24. Fabulous - Daily Habit Tracker - Morning Routines & ADHD Help | 2020-12-29 | 3★ | ACCOUNT_SAFE |
| `A33#3715` | `1477979042` | 33. Habitify - Habit Tracker - Daily Goals, Routine & Streaks | 2016-11-03 | 1★ | ACCOUNT_SAFE |
| `A4#542` | `12052853074` | 4. Me+ Lifestyle Routine - Daily Planner & Habit Tracker | 2024-12-12 | 2★ | ACCOUNT_SAFE |
| `P12#15623` | `ec76abc0-cab1-4841-9bdc-9daca22a4a0f` | 12. Fabulous Daily Routine Planner | 2024-02-16 | 3★ | ACCOUNT_SAFE |
| `P12#29471` | `7715fa8e-6a78-4e09-a6c0-1ed7abc85a44` | 12. Fabulous Daily Routine Planner | 2021-11-25 | 1★ | ACCOUNT_SAFE |
| `P12#35599` | `ca8c0a0a-9196-4537-8df6-c35e395d9cae` | 12. Fabulous Daily Routine Planner | 2021-06-15 | 1★ | ACCOUNT_SAFE |
| `P126#162320` | `a4b97f82-c527-4067-829a-2905dfd806cd` | 126. To Do List | 2023-01-15 | 1★ | ACCOUNT_SAFE |
| `P2#22852` | `dec8ab3c-0902-4151-9fb8-53450dfe9ce9` | 2. HabitNow Daily Routine Planner | 2024-04-13 | 4★ | FREQUENCY |
| `P2#3087` | `4ad4eb96-420d-4360-b4cd-684bdc0b573d` | 2. HabitNow Daily Routine Planner | 2025-04-14 | 3★ | GAP |
| `P22#992` | `409ac9a2-5f0b-4e40-a462-f4f1f50187ff` | 22. Disciplined - Habit Tracker | 2024-05-04 | 3★ | ACCOUNT_SAFE |
| `P3#8779` | `c8bf1553-37a6-4ade-9a07-f7c1c3b9ac84` | 3. Loop Habit Tracker | 2020-11-17 | 4★ | GAP |
| `P98#600` | `f9c04c43-71dc-4f24-9a09-bfee6268ff13` | 98. Rabit - Habit Tracker & Planner | 2022-02-22 | 2★ | GAP |
