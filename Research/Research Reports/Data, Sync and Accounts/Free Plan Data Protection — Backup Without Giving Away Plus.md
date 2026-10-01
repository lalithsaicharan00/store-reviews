# Free Plan Data Protection — Backup Without Giving Away Plus

*Written by Claude (Claude Code), 1 Oct 2026. Research, not a decision. It revisits the 27 Sep 2026 choice "free = local only, no off-phone backup" ([Architecture 03 §6](<../../../Architecture/03. Backup and Restore.md>), [Backlog](<../../../Architecture/Backlog.md>)).*

**The user's question (1 Oct):**
- Free users' data lives only on their phone. We did that so people upgrade to Plus.
- But if a free user loses their data, that is a one-star review.
- If free gets automatic backup, will anyone still upgrade?
- iCloud and Google Drive backups were a mess: two clouds, two failure modes, and iPhone ⇄ Android means copying from iCloud to Drive. That is why we dropped them.
- So: how do we protect free users' data **without** giving away everything in free? What should we build, and how?

**How each point is backed:**
- **Users show**: review evidence from this study (or an earlier report, linked).
- **Platform fact**: Apple, Google or Cloudflare documentation, linked.
- **First principles**: reasoned from how the system works.

**Evidence:**
- **Fresh screen:** all 1,238,784 App Store and Play reviews in the repo, 5 multilingual patterns, 1,353 matches (Nov 2011 – Sep 2026).
- **Every match read and hand-coded:** 710 about paywalled backup, "hostage" data, paying for backup or sync, and free backup; 643 data-loss stories. 885 on topic, from 72 apps.
- **50 quotes**, each checked word for word against `reviews.jsonl`.
- **Reused:** payer reasons from [Plus Scope and Account at Purchase §3](<../Business Model and Monetization/Plus Scope and Account at Purchase.md>) (14,034 "I paid" reviews), [Backlog 4](<Sign-in Prompts and the Backup Guarantee — Backlog 4.md>), [Data Safety](<Data Safety — Every Way Users Lose Data, and the Rules That Prevent It.md>).
- **Files:** [`Free Backup Evidence/`](<Free Backup Evidence/>).

---

## 1. The short answer

1. **Your fear is mostly not supported by reviews.** Backup is rarely why people pay; what they pay for is a one-time price, more habits and **using more than one device**. Payer reviews mention backup in 0.9% of cases, against 4.3% for sync and devices and 15.8% for lifetime. In this study, 92 people say they paid for sync against 21 for backup. **Our upgrade lever is the 5-habit limit and the extra devices.** Free backup touches neither.
2. **Paywalled backup costs more than it earns.** 83 reviews from 24 apps attack a backup paywall (2.39★), 23 of them with words like "hostage", "ransom" or "blackmail". Against that, 43 accept it, paid for it or would pay. And **paid backup that then fails is the worst-rated thing in this study** (33 reviews, 1.64★, 61% one-star).
3. **Most data loss is not fixed by any cloud.** Of 516 loss stories with a clear cause, **55% are the app's own update or bug wiping data on the phone.** On-device snapshots before every update fix those (already designed in 03). **41% need a copy off the phone:** the user reinstalled after a crash (96), got a new, reset, lost or broken phone (92), or deleted the app (24). That 41% is where free users are exposed today.
4. **The biggest hole is iPhone reinstall.** On Android, Google's Auto Backup gives the data back when the app is reinstalled. **On iPhone, deleting the app deletes its data,** and the iCloud phone backup only comes back if you restore the whole phone. 74 of the 120 reinstall or delete stories are from iPhone.
5. **Recommendation: a free "safety copy" on our own server, with no account and no setup.**
   - Every night the app sends **one encrypted copy** of the data to our Cloudflare server. **Only the user's phone holds the key,** so we can't read it.
   - The key lives in **iCloud Keychain (iPhone)** and **Google Block Store (Android).** Both survive deleting the app and come to a new phone with the same Apple or Google account.
   - After a reinstall or on a new phone, the app says **"Welcome back. Restore your habits from yesterday 21:40?"** One tap.
   - It is **one copy for one phone, restore-only.** It does not sync. Two devices, Watch, iPad together with the phone, live backup after every change and history stay **Plus**.
6. **This removes the "mess" you described.** There is no iCloud Drive and no Google Drive. Both platforms write the **same file to the same place**, so iPhone ⇄ Android is just "restore from our server" with a recovery code. Nothing has to be copied from one cloud to another.
7. **Cost is close to zero** (under about $10 a month at 100,000 free users, §6), and it reuses the server, the snapshot file and the restore screen we already designed for Plus.

---

## 2. Does free backup stop people upgrading? What users show

### 2.1 What people say they paid for

| Reason in the review | Reviews | Source |
|---|---|---|
| Lifetime / one-time price, in "I paid" reviews | 15.8% of 14,034 | [Plus Scope §3](<../Business Model and Monetization/Plus Scope and Account at Purchase.md>) |
| Sync, devices, iPad, Mac | 4.3% | same |
| Widgets | 3.5% | same |
| More habits | 1.8% | same |
| **Backup** | **0.9%** | same |
| **Paid for sync / multi-device** (this study, read by hand) | **92** (19 apps, 2.80★) | `SYNC_PAID` |
| **Paid for backup / data safety** (this study) | **21** (8 apps, 2.76★) | `BK_PAID_FOR_SAFETY` |

**Users show:** people pay to **use the app in more places**, about four times as often as they pay to keep data safe.
- “Got premium on day 2 for sync to other devices” (`A1#53622`)
- “Purchased mainly for it's ability to sync across devices” (`P126#70222`)
- “I paid for premium mostly so that I can have the ability to Sync my habits on my devices.” (`A1#2374`)

**Some people do pay for backup.** It is a real but small reason, and it shows up mostly in apps where almost everything else is free:
- “I decided just to pay the $4.99 in case my data doesn’t back up in the cloud.” (`A1#55468`)
- “I’m only buying premium for automatic backup.” (`P15#350`)
- “I upgraded to premium app for the back up capabilities well worth it to me” (`P84#12103`)
- In a to-do app with everything else free: “Only backup needs a payed version. Thanks! I am thinking about buying the full version” (`P84#1024`).

Our free plan is different. It already has a strong lever (the 6th habit and every extra device), so backup is not needed to sell Plus.

### 2.2 How people react when backup is behind a paywall

| What they say | Reviews | Apps | Mean ★ | 1★ |
|---|---|---|---|---|
| **Against the backup paywall** (complain, lost data because of it, left, "hostage", restore paid as a surprise) | **83** | 24 | **2.39** | 35% |
| of which call it hostage, ransom or blackmail | 23 | 12 | 1.91 | 57% |
| of which lost data because backup or restore was paid | 17 | 7 | 2.24 | |
| of which say they uninstalled or left because of it | 14 | 7 | 2.00 | |
| **Accept it, paid for it, or would pay** | **43** | 13 | 3.63 | 19% |
| of which simply accept it ("understandable") | 14 | 6 | 4.64 | 0% |
| **Paid for backup or sync, and it failed** (`BK_PAID_FAIL`) | **33** | 13 | **1.64** | 61% |
| of the 21 who paid *for safety*, say it then failed | 9 | | | |
| **Praise free backup, or chose the app for it** | 24 | 14 | **4.58** | 0% |

*15 of the 33 paid-backup failures come from one Android app (folder 24, HabitBull) whose sync server stopped working; without it the group is still 18 reviews from 12 apps.*

**The words people use:**
- “Gating my own (old) data on my own device behind a pay wall? That sounds borderline ransomware!” (`P106#854`)
- “the longer I use the app, the more it's going to feel like my save is being held hostage by the subscription” (`P12#61966`)
- “Shame on devs to hold data hostage in this manner. Uninstalling.” (`P130#295`)
- “A subscription to backup & restore to my own Google Drive, no and uninstalled.” (`P106#678`)
- “Paying to get MY OWN data back is a big red no no flag for me.” (`P84#9108`)
- “По-моему это что-то на уровне шантажа” — to me this is close to blackmail (`P84#54167`)
- After the loss: “Switched phones and I have to pay to backup and restore my lists. Thanks for making me lose all my lists.” (`P84#7935`); “the backup option is only for premium users, so it demotivates me to use it all over again” (`P12#17496`); “Back up is literally PREMIUM? Back up should be apart of EVERY app for FREE.” (`A3#175`)
- From someone who can't pay yet: “I want to support you in the future when I have a job, now I'm just a student.” (`P12#49888`)

**The accepting side is real but mild:**
- “it is sad that you need to pay for back up, but it is understandable.” (`P24#4502`)
- “Despite it requires an annual subscription to save your data, you can use 100% of their functions” (`A48#2750`)

**Selling safety makes failures much worse.** When a paid backup fails, people are angrier than at any other failure in this study:
- “I paid for premium only for the back-up option, for it to dissappear now.” (`P24#4874`)
- “I paid for Premium because it's supposed to back up progress. They didn't.” (`P12#46983`)
- “I upgraded to the premium version for the automatic backup feature… I discovered none of my backups had actually occurred and over two years of habit tracking data had been lost.” (`P2#5681`)

**Free backup is a reason to choose an app:**
- “I love that the free version allows iCloud sync (unlike some of the other leading habit trackers) No account necessary and I don’t have to worry about my logs when I eventually upgrade my phone.” (`A13#1921`)
- “A major plus is that all the important features including backup are included in the free version” (`P69#252`)
- “Habitify is completely free without any restrictions and also syncs perfectly with my phone so prefer it more now” (`A33#2107`)

**Two users even suggest our exact split:** limit sync, not safety.
- “Instead of limiting habits for free version, disable notifications or cloud storage or inter device sync” (`P24#7579`)
- “maybe the basic functionality should be free, if one doesn't care about syncing the data and using the web interface. There would still be plenty of people that would pay. I would.” (`A48#4112`)

**People also understand that a cloud costs money**, which makes a paid *sync* feel fair:
- “This is not cloud based, it does not produce any costs.” (`A7#572`, complaining about a habit cap)
- “I just wish it has icloud saving but I realize if something is free like this, the devs cant afford such” (`A8#552`)

### 2.3 A warning case: backup free, restore paid

One to-do app (Play folder 84, "Tasks") lets free users **make** a backup file but charges to **restore** it. People find out on their new phone. It accounts for 30 of the 83 "against" reviews and all 9 "restore paid as a surprise" reviews: “They do not tell you this when you make the backup, just so to blackmail you later.” (`P84#8976`). **First principles:** never split backup and restore across the paywall. Whatever is backed up for free must be restorable for free.

### 2.4 So, does free backup hurt upgrades?

**Users show:**
- Payers buy reach (more devices) and a fair price, not safety.
- Paying for safety is rare and turns into the angriest reviews when anything goes wrong.
- A free user who loses everything rarely comes back to buy. In the loss stories, 81 say they left or switched; 17 more say they lost motivation. Examples: “I dropped my phone and lost my progress. With the my new phone I've decided to try a new habit tracker” (`P10#11216`); “Was done my free trial and ready to subscribe. But I got a new phone and when I logged in with my email all my progress was gone.” (`P12#29471`).

**First principles:**
- The people most likely to buy Plus are the ones with months of history. Protecting their data protects the future buyers.
- Free users have at most 5 habits, so the safety copy gives them nothing that pushes against the 5-habit limit.
- What must stay Plus is **using more than one device**. The safety copy must therefore never work as sync (§4.4).

---

## 3. How free users actually lose data

### 3.1 The causes

643 loss stories read; 516 with a clear cause; 46 more from people afraid to reinstall.

| Cause | Stories | Mean ★ | 1★ | Left | What fixes it |
|---|---|---|---|---|---|
| **The app's own update or bug wiped data on the phone** | **282** (55%) | 1.76 | 63% | 57 | On-device snapshots before every update, release safety ([03](<../../../Architecture/03. Backup and Restore.md>), [08](<../../../Architecture/08. Release Safety and Operations.md>)). A cloud copy is a second net |
| **App broke, the user reinstalled** | **96** (19%) | 2.16 | 46% | 6 | **An off-phone copy** |
| **New, reset, lost or broken phone** | **92** (18%) | 2.66 | 32% | 7 | **An off-phone copy** (or the phone's own transfer, if it worked) |
| **Deleted the app** (by accident, for space, or "auto-uninstalled") | **24** (5%) | 3.17 | 17% | 3 | **An off-phone copy** |
| Account or login failure | 15 | 2.47 | 33% | 3 | Not relevant to free (no account) |
| Other | 11 | 1.36 | 73% | 5 | – |

- **The three "off-phone" rows total 212 stories (41%).** None of them names our current free safety nets (local snapshots die with the app; export is manual).
- **The update row is the biggest and angriest.** No cloud backup replaces getting updates right. It is still worth noting: a nightly cloud copy also saves people when a bad update reaches the phone, as long as it keeps several days of copies (§4.3).
- 131 of the 562 on-topic loss stories (23%) come from people who had **paid**. Paying does not protect people unless the backup is automatic and checked.

### 3.2 What users show about the off-phone cases

- **They assume someone else has a copy:** “I assumed my data was backed up in iCloud. Big mistake.” (`A13#12526`); “I did not know there is no backup until I searched about it.” (`A10#56746`)
- **They expect it to be automatic:** “Literally every app I have backs up to my iCloud - daily and seamlessly.” (`A10#29159`)
- **Manual backup gets forgotten:** “Today i lost 2.5 years of data as i forgot to backup the file and hit factory reset.” (`P3#10433`)
- **Their iCloud is full:** “I did not save it to my cloud because I do not have space but did not know I would need to.” (`A10#30736`)
- **The phone's own backup doesn't always bring the app back:** “All other apps restored the data, EXCEPT for this app. This app restored my lists from 3 years ago” (`P126#30659`); “I do back up my phone. My data was gone when I restored the backup to my new phone.” (`A3#8946`)
- **Apps disappear for odd reasons:** “many apps got uninstalled from my phone automatically due to some issue and Loop Habit tracker was also one of them.” (`P3#3532`)
- **People leave before buying:** “Would like to keep it and buy. But the reason I'll go to different app is there no option to save or export my progress” (`P33#5815`); “I've finally switched to another habit tracking app (Habitify)… it doesn't save your data to the cloud, even when you make an account” (`P33#844`)
- **Free users even blame themselves:** “I was not on your paid subscription bit i guess that’s on me” (`A20#1466`). The review is still 3★.
- **Local snapshots do save people when the cause is a bad update:** “the company listed where to find backups in the app” (`A23#4691`). This supports keeping layer 1.

### 3.3 Why iPhone reinstall is the gap (platform facts)

| Fact | What it means | Source |
|---|---|---|
| **Deleting an iPhone app removes it and its data.** Offloading keeps the data | Reinstalling after a crash starts empty. Our local snapshots are deleted too | [Apple: Remove or delete apps](https://support.apple.com/guide/iphone/remove-or-delete-apps-iph248b543ca/ios) |
| The iCloud phone backup comes back only when the **whole phone** is restored, not when one app is reinstalled | It helps with a new phone, never with a reinstall | Same page; first principles |
| **Android Auto Backup restores an app's data whenever the app is installed again**, including after a factory reset, if the user's Google backup is on | Android reinstall is mostly covered already | [Android: Auto Backup](https://developer.android.com/identity/data/autobackup) |
| About a third of US iPhone users are on free 5 GB iCloud, often full | A full iCloud means no phone backup at all | [Backlog 4 §3](<Sign-in Prompts and the Backup Guarantee — Backlog 4.md>) |

In this study, 74 of the 120 reinstall-or-delete stories are from iPhone.

---

## 4. Recommendation: a free safety copy on our server

### 4.1 The three layers, by plan

| Layer | Free | Plus | Fixes |
|---|---|---|---|
| **1. On-device snapshots** (7 daily, 4 weekly, 6 monthly; one before every update, restore, sign-in) | ✅ | ✅ | Bad updates and bugs (55% of losses). Already designed in [03](<../../../Architecture/03. Backup and Restore.md>) |
| **2. The phone's own backup and transfer** (iCloud backup, Quick Start, Android Auto Backup, Smart Switch) | ✅ | ✅ | New phone, when it works. Already designed |
| **3a. Safety copy** (new): one encrypted copy a night on our server, the last 7 nights kept, **one device**, **restore only**, no account | ✅ | – (replaced by 3b) | Reinstall, deleted app, lost or broken phone, iCloud full, iPhone ⇄ Android |
| **3b. Account backup and sync**: every change, every device, 30-day history, Apple or Google sign-in | – | ✅ | Everything 3a does, plus using the app on iPad, Watch, a second phone and the web |
| Export and import file | ✅ | ✅ | Your own copy, any time |

**What stays Plus:** more than 5 habits; iPad, Watch, tablets, web; **live sync**; backup after every change; history; Apple Health; widget designs; Family.

### 4.2 How the safety copy works

1. **First launch:** the app makes a random **256-bit key**.
   - **iPhone:** saved in the Keychain as a **synchronizable** item, so it goes into iCloud Keychain. iCloud Keychain is end-to-end encrypted, it survives deleting the app, and it reaches a new iPhone on the same Apple Account.
   - **Android:** saved in **Block Store** with cloud backup on when end-to-end encryption is available. Block Store data survives an uninstall and comes back on a new phone when the user's Google backup is on. It holds up to 16 entries of 4 KB, so it fits a key easily.
   - The server never sees the key. The copy's ID on the server is a hash of the key.
2. **Every night** (plus after a big change, at most every few hours), the app takes the same `.habits.zip` file that layer 1 already makes and **encrypts it with the key** (AES-GCM). It then uploads it to our Cloudflare Worker, which stores it in R2. The server keeps **one copy per night for 7 nights**.
3. **Check before it counts:** the server returns a checksum. The app shows a copy as saved only after the checksum matches (users show silent backup failures: `P2#5681`).
4. **Shrink guard:** if tonight's copy has far fewer records than last night's (for example, a bad update emptied the phone), the server keeps it **beside** the older copies and never instead of them. The restore screen then offers the older one.
5. **Settings → Backup** shows the honest state, with no badges or nagging: "Safety copy · last night 03:12 · encrypted, only your phones can open it · [Restore…] [Turn off]".

### 4.3 Restoring

- **Fresh install or new phone:** before onboarding, the app looks for the key.
  - If it finds one, it asks the server for the latest copy's date and counts, then shows: **"Welcome back. Your habits from Tue 30 Sep, 21:40 — 5 habits, 412 check-ins. [Restore] [Start fresh]"**.
  - "Start fresh" keeps the old copies for 30 days under "Earlier safety copies".
- **Any time:** Settings → Backup → Restore lists the 7 nightly copies with dates and counts. It uses the restore flow already designed in 03 §3.6: preview first, snapshot current data, undo for 30 days, validate before changing anything.
- **iPhone ⇄ Android, or a new Apple or Google account:** Settings → Backup → **"Moving to a new phone? Show my recovery code."** This shows the key as 12 words and a QR code. On the new phone: "I've used this before → Enter recovery code". This replaces copying data from iCloud to Google Drive. Cross-platform moves are rare (154 in 1.24M reviews, [Final Backlog](<QR Move, Apple Health and Launch Operations — Final Backlog.md>)), so this can ship after launch; export and import already covers it.

### 4.4 Keeping it from becoming free sync

**First principles.** The free copy must protect one phone, never connect two.
- **One owner device:** the copy belongs to the install that last created or restored it.
- **When another device restores it,** ownership moves there. The old device's next upload is refused, and it shows one honest line: **"Your safety copy moved to your iPad on 3 Oct. To use both, get Plus."** This is the only Plus mention, and it appears at the exact moment someone wants two devices. That is the highest-intent moment in the evidence (§2.1), and it is not a fear message.
- **Restore-only, once a night:** there is no merging between devices and no upload after every change. Using it as manual sync would be slow and would overwrite. (Users show "backup file used as sync" is a chore: 23 reviews in [Backlog 4](<Sign-in Prompts and the Backup Guarantee — Backlog 4.md>).)
- **iPad on the same Apple Account** will find the iPhone's key. Since 1 Oct 2026 a tablet on its own is free, so its first screen offers "Copy my iPhone's habits here once" or "Start fresh"; after that each device keeps its own safety copy and they don't sync ([07 §7.1](<../../../Architecture/07. Other Surfaces.md>)). Taking over a copy (moving ownership, as above) is only for a reinstall or a device that replaces the old one.

### 4.5 When a free user buys Plus

- They sign in (Apple or Google). The newest safety copy becomes the account's starting data, and live sync takes over.
- The safety copy is deleted 30 days later, because the account is now the backup.

### 4.6 Rules

- **On by default, stated once.** One line in onboarding: "Your habits stay on this phone. An encrypted safety copy, which only your phones can open, is kept on our server so a lost phone doesn't mean lost habits. You can turn it off in Settings."
  - Users show that manual and opt-in backup fail the people who need it most (`P3#10433`, `A10#56746`).
  - The privacy-minded minority is small but real ([Plus Scope §2](<../Business Model and Monetization/Plus Scope and Account at Purchase.md>): 87 refuse servers), so the switch is one tap and turning it off deletes the copies.
- **No prompts, no reminders, no upsell around safety.** The only Plus mention is §4.4. Users show prompts drive people away (72 reviews, 1.75★, [Backlog 4](<Sign-in Prompts and the Backup Guarantee — Backlog 4.md>)).
- **Never weaken it on purpose** (weekly instead of nightly, or the last copy only). The gap between copies is exactly what people lose ("backup stale": [03 §2](<../../../Architecture/03. Backup and Restore.md>)).
- **Expiry:** copies not updated for 12 months are deleted. The app says so in Settings.
- **Abuse protection:** uploads need **App Attest** (iPhone) or **Play Integrity** (Android). Copies are capped at 5 MB and uploads at about 24 a day per copy, rate-limited at the Worker.
- **If the user turns off iCloud Keychain or Google backup:** the key stays only on the phone. Reinstall is usually still covered on Android (Block Store and Auto Backup), and on iPhone only by an undocumented Keychain behaviour (§5), so the recovery code is the safety net. Settings shows: "Safety copy works on this phone only. Keep your recovery code."

---

## 5. Platform facts used

| Fact | Source |
|---|---|
| Keychain items marked **synchronizable** go into iCloud Keychain. That is the only way for a keychain item to appear on another device after a restore. iCloud Keychain is end-to-end encrypted, and users can turn it off | [Apple Developer Forums 93373](https://developer.apple.com/forums/thread/93373), [93198](https://developer.apple.com/forums/thread/93198) |
| Non-synced keychain items have outlived app deletion in practice, but Apple says this is a side effect, not a feature. An iOS 10.3 beta briefly deleted them | [Apple Developer Forums 72271](https://developer.apple.com/forums/thread/72271) |
| **Block Store:** 16 entries × 4 KB. It survives uninstall and reinstall when Backup is on, and is restored on a new device. It is end-to-end encrypted on Android 9+ with a screen lock. Turn on `setShouldBackupToCloud` only when encryption is available | [Android: Block Store](https://developer.android.com/identity/block-store) |
| Deleting an iPhone app deletes its data; offloading keeps it | [Apple Support](https://support.apple.com/guide/iphone/remove-or-delete-apps-iph248b543ca/ios) |
| Android Auto Backup restores app data whenever the app is installed again, including after a factory reset | [Android: Auto Backup](https://developer.android.com/identity/data/autobackup) |
| **R2:** $0.015 per GB-month; writes $4.50 per million; reads $0.36 per million; free tier 10 GB, 1M writes and 10M reads a month; no egress fees | [Cloudflare R2 pricing](https://developers.cloudflare.com/r2/pricing/) |
| **App Attest** lets the server check that a request comes from our real app on a real Apple device | [Apple: Validating apps that connect to your server](https://developer.apple.com/documentation/devicecheck/validating-apps-that-connect-to-your-server) |
| Apple's privacy label: "collect" means sending data off the device **in a way that allows you … to access it** longer than needed to serve the request. The page says nothing specific about encrypted data. **Check when filling in the label:** the copy's contents are unreadable to us, but the upload itself (copy ID, timestamps) is stored | [Apple: App privacy details](https://developer.apple.com/app-store/app-privacy-details/) |
| A precedent for "free safety, paid extras": Signal's encrypted backups (Sept 2025) are free for all messages plus 45 days of media; $1.99 a month adds full media up to 100 GB. The key stays on the phone. *Not a reason by itself (Research/CLAUDE.md); it shows the model is accepted at scale* | [TechCrunch](https://techcrunch.com/2025/09/08/signal-introduces-free-and-paid-backup-plans-for-your-chats), [Cybernews](https://cybernews.com/security/signal-introduces-secure-backup-plans/) |

---

## 6. Cost and size of the work

**Running cost (first principles, with R2 prices).** Assume 100,000 free users with a copy, about 100 KB per compressed copy (5 habits, notes included) and 7 copies each:
- **Storage:** about 70 GB, so about $0.90 a month after the free 10 GB.
- **Uploads:** about 50,000 daily users × 30 = 1.5M writes, so about $2.25 a month after the free 1M.
- **Workers:** the paid plan (about $5 a month) already covers this many requests.
- **Total:** under about $10 a month. At 1M free users, roughly ten times that.

**Build (reuses what is designed):**

| Piece | New or reused |
|---|---|
| The snapshot zip, checksum and nightly job | Reused (03 §3.2–3.3) |
| Restore with preview, undo and validation | Reused (03 §3.6) |
| Worker + R2 on Cloudflare | Reused (06); 4 new endpoints: put copy, get latest metadata, get copy, delete |
| Encrypt and decrypt with a key (AES-GCM) | New, small, in the shared Kotlin core |
| Key in Keychain (iPhone) and Block Store (Android) | New, small, one adapter per platform |
| "Welcome back" screen before onboarding | New. 04 already plans an "I've used this before" entry point |
| App Attest and Play Integrity checks | New, on the Worker |
| Recovery code (12 words and QR) | New. Can ship after launch |

**Compared with what we dropped:** iCloud plus Google Drive meant two integrations, two quotas ("iCloud full"), two consent flows, and no way to cross platforms. The safety copy has one format, one place, one code path, and it works across platforms by design.

---

## 7. Options compared

| Option | Protects free users | Keeps Plus attractive | Build and mess | Users show |
|---|---|---|---|---|
| **A. Today's plan:** local snapshots, phone backup, export | Updates only; **not reinstall on iPhone**, not a lost phone with iCloud off or full | ✅ | None | 212 off-phone loss stories; 81 left after a loss |
| **B. Safety copy on our server, no account** *(recommended)* | ✅ Reinstall, deleted app, new or lost phone; cross-platform with a code | ✅ Sync, devices and the habit cap untouched | Small, one path | Free backup praised (4.58★); "hostage" anger avoided |
| C. Same copy, but only after an optional sign-in | Only people who sign in, and the people who lose data are the ones who never set anything up | ✅ | Smallest (reuses accounts) | Forced sign-up 1.35★; repeated prompts 1.75★ ([01](<../../../Architecture/01. Accounts and Identity.md>), [Backlog 4](<Sign-in Prompts and the Backup Guarantee — Backlog 4.md>)) |
| D. Backup to the user's own iCloud Drive / Google Drive | Partly; fails when iCloud is full or Drive isn't connected | ✅ | **Large: the mess you described**; no cross-platform | iCloud backups failing at restore, 46 reviews at 1.93★ ([Backlog 4](<Sign-in Prompts and the Backup Guarantee — Backlog 4.md>)) |
| E. Off-phone backup only in Plus | No | Slightly more conversion from fear | None | 83 against at 2.39★, 23 "hostage"; paid backup failures 1.64★ |

**If B feels like too much for launch, ship C first:** a "Back up my habits" button in Settings that signs in with Apple or Google and stores the same encrypted copy. Then move to B, which needs no sign-in, in the first update. Both use the same server pieces.

---

## 8. What to change if you decide this

*Decisions live in Notion; these are the repo documents that would need updating.*
- [Architecture 03](<../../../Architecture/03. Backup and Restore.md>): add layer 3a (§4); change "Free: Saved on this phone" to the safety copy line; update §6 "Decided and removed".
- [Architecture 06](<../../../Architecture/06. Server on Cloudflare.md>): the 4 safety-copy endpoints, R2 layout `copies/{hash(key)}/{weekday}.bin`, 12-month expiry, attestation, rate limits.
- [Architecture 09](<../../../Architecture/09. Privacy and Account Deletion.md>): the data map (encrypted blob, copy ID, timestamps); "turn off" deletes; the privacy label check (§5).
- [Architecture 04](<../../../Architecture/04. Phone Migration.md>): "I've used this before → restore safety copy or enter recovery code".
- [Backlog](<../../../Architecture/Backlog.md>): the 27 Sep row "Free … local-only" would read "local-first, with an encrypted safety copy; no account".

**What to watch after launch:**
- The share of free installs with a verified copy (target above 90%).
- Restore success rate.
- Reviews that mention data loss.
- Conversion at the 6th habit and at the "safety copy moved" line.

---

## 9. Limits of this evidence

- **Keyword screen:** reviews that describe these situations in other words were missed. The 643 loss stories were limited to ones naming a cause (reinstall, new phone, update…).
- **"Paid" is self-reported** and reviews lean negative. Counts compare groups within the same corpus; they are not market shares.
- **One app dominates some rows:** Tasks (P84) supplies 30 of 83 "against" reviews; HabitBull (P24) supplies 15 of 33 paid-backup failures. Both are disclosed where used.
- **Duplicate text:** `P91#143` and `P91#170` are word-for-word the same review (one user, likely posted twice); both are counted in the loss table (1 row each, "other").
- **No review tests our exact design** (a server copy without an account). B's design is reasoned from first principles and the platform facts above. Its parts (automatic, free, encrypted, restore on a new phone) are each backed by users.
- **Not legal advice:** the privacy-label and GDPR treatment of an encrypted copy should be checked when the label is filled in.

---

## Appendix — reviews cited

<!-- APPENDIX -->

50 reviews cited. Ref = store letter + app number + line index in that app's `reviews.jsonl`. Full index of all 1,353 coded reviews: [`coded.json`](<Free Backup Evidence/coded.json>).

| Ref | Review ID | Store | App | Date | Stars | Codes |
|---|---|---|---|---|---|---|
| `A1#2374` | `8103489546` | App Store (ca) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2021-12-07 | 4★ | SYNC_PAID, SYNC_PAID_FAIL |
| `A1#53622` | `10223796498` | App Store (us) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2023-08-05 | 5★ | SYNC_PAID |
| `A1#55468` | `8209537613` | App Store (us) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2022-01-06 | 5★ | BK_PAID_FOR_SAFETY |
| `A3#175` | `13629061971` | App Store (au) | 3. Days Since - Quit Habit Tracker - Sober Streak Day Counter | 2026-01-13 | 3★ | BKPW_COMPLAIN, BKPW_LOSS |
| `A3#8946` | `9112628469` | App Store (us) | 3. Days Since - Quit Habit Tracker - Sober Streak Day Counter | 2022-09-23 | 1★ | BKPW_COMPLAIN, BKPW_LOSS, OS_BACKUP_MISSED |
| `A7#572` | `9589360229` | App Store (pl) | 7. Habit Tracker - HabitKit - Streaks & Accountability | 2023-02-06 | 2★ | CLOUD_JUSTIFIES_PAY |
| `A8#552` | `11943323917` | App Store (ph) | 8. Onrise - Habit Tracker & Focus - Build habits, focus & journal | 2024-11-12 | 5★ | CLOUD_JUSTIFIES_PAY |
| `A10#29159` | `13192704866` | App Store (us) | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2025-09-27 | 1★ | L_OTHER, MANUAL_FORGOT, O_LEFT |
| `A10#30736` | `12944782274` | App Store (us) | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2025-07-28 | 1★ | L_CRASH_REINSTALL, ICLOUD_FULL |
| `A10#56746` | `9343658775` | App Store (us) | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2022-11-30 | 2★ | L_CRASH_REINSTALL |
| `A10#58720` | `9056445459` | App Store (us) | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2022-09-06 | 3★ | L_DELETE, O_DEMOTIVATED |
| `A13#1921` | `6085545766` | App Store (ca) | 13. Productive - Habit Tracker - Daily Routine & Goals Planner | 2020-06-17 | 5★ | FREE_BK_PRAISE |
| `A13#12526` | `6513657026` | App Store (us) | 13. Productive - Habit Tracker - Daily Routine & Goals Planner | 2020-10-08 | 1★ | L_CRASH_REINSTALL, O_LEFT |
| `A20#1466` | `12437544668` | App Store (in) | 20. Habit — Daily Tracker - Crush your goals like a boss | 2025-03-19 | 3★ | L_APP_BUG, SELF_BLAME_FREE |
| `A23#4691` | `8553855848` | App Store (us) | 23. Streaks - The habit-forming to-do list | 2022-04-10 | 2★ | L_APP_BUG, LOCAL_SNAPSHOT_SAVED |
| `A33#2107` | `6638054327` | App Store (kr) | 33. Habitify - Habit Tracker - Daily Goals, Routine & Streaks | 2020-11-12 | 5★ | FREE_BK_PRAISE, CHOSE_FOR_FREE_BK |
| `A48#2750` | `4327171011` | App Store (us) | 48. Strides - Habit Tracker + Goals - Goal Planner & Daily Checklist | 2019-06-16 | 5★ | BKPW_ACCEPT |
| `A48#4112` | `1135626987` | App Store (us) | 48. Strides - Habit Tracker + Goals - Goal Planner & Daily Checklist | 2015-01-25 | 1★ | PREFER_GATE_SYNC_OVER_CAP |
| `P2#5681` | `612d885e-cb1c-4553-ac0b-fca77eaf2090` | Play Store (en) | 2. HabitNow Daily Routine Planner | 2024-02-04 | 2★ | BK_PAID_FOR_SAFETY, BK_PAID_FAIL |
| `P3#3532` | `e96ff9bc-c47a-4ff3-aa33-6661d10d0b9a` | Play Store (en) | 3. Loop Habit Tracker | 2024-11-24 | 5★ | L_DELETE |
| `P3#10433` | `5d37a37b-72de-4482-a85c-c7138ebebc8b` | Play Store (en) | 3. Loop Habit Tracker | 2020-01-08 | 4★ | L_NEWPHONE, MANUAL_FORGOT |
| `P10#11216` | `39506d7d-2ab6-4ef3-81fb-86e61d9a20ed` | Play Store (en) | 10. Habit Tracker - Habit Diary | 2022-03-05 | 3★ | L_NEWPHONE, O_LEFT |
| `P12#17496` | `46d717d2-4f1c-436f-80b8-08ed0ef4c894` | Play Store (en) | 12. Fabulous Daily Routine Planner | 2023-09-02 | 3★ | BKPW_LOSS, BKPW_LEFT |
| `P12#29471` | `7715fa8e-6a78-4e09-a6c0-1ed7abc85a44` | Play Store (en) | 12. Fabulous Daily Routine Planner | 2021-11-25 | 1★ | L_NEWPHONE, LOST_SALE |
| `P12#46983` | `dcdd3633-6671-49b2-a624-b76b93c55ab2` | Play Store (en) | 12. Fabulous Daily Routine Planner | 2020-09-29 | 1★ | BK_PAID_FOR_SAFETY, BK_PAID_FAIL |
| `P12#49888` | `d47efabd-9ae2-4c39-9de1-a0daa201ce25` | Play Store (en) | 12. Fabulous Daily Routine Planner | 2020-07-25 | 1★ | WANT_FREE_BK |
| `P12#61966` | `0b12fc3e-f7e8-47d8-9eec-baa2b5fb2b4b` | Play Store (en) | 12. Fabulous Daily Routine Planner | 2019-08-06 | 2★ | BKPW_COMPLAIN, HOSTAGE_DATA, WOULD_PAY_ONETIME_BK |
| `P15#350` | `42920bfb-2b09-4803-b521-d7e7fe250967` | Play Store (en) | 15. Habit Tracker - HabitGenius | 2026-01-01 | 5★ | BK_PAID_FOR_SAFETY |
| `P24#3426` | `ebebcbd0-24dd-4ca9-ba39-cccb134a417b` | Play Store (en) | 24. Habit Tracker | 2020-06-13 | 1★ | BKPW_COMPLAIN, BKPW_LOSS |
| `P24#4502` | `78c5b857-1ddd-4ee3-9092-f7b21999d470` | Play Store (en) | 24. Habit Tracker | 2019-10-18 | 4★ | BKPW_ACCEPT |
| `P24#4874` | `9cd2e6db-9e01-43a7-a21f-8961a8aaf765` | Play Store (en) | 24. Habit Tracker | 2019-08-16 | 1★ | BK_PAID_FOR_SAFETY, BK_PAID_FAIL |
| `P24#7579` | `f30de521-8b0e-4ff4-8e19-aa9c0696c3db` | Play Store (en) | 24. Habit Tracker | 2018-11-07 | 3★ | PREFER_GATE_SYNC_OVER_CAP |
| `P33#844` | `22b83679-52da-4983-af59-9ff2fb695f99` | Play Store (en) | 33. Productive - Habit tracker | 2023-01-15 | 3★ | L_NEWPHONE, O_LEFT |
| `P33#5815` | `86468f0b-e37b-4ec4-bb46-ab2dc65c21ed` | Play Store (ru) | 33. Productive - Habit tracker | 2021-01-19 | 3★ | FEAR, O_LEFT, WOULD_PAY_BK |
| `P69#252` | `a7b016b1-334c-4233-af29-4846b386e2dc` | Play Store (en) | 69. EZ Habit - simple habit tracker | 2022-06-02 | 5★ | FREE_BK_PRAISE |
| `P84#1024` | `0cd8e530-d615-4642-9fbe-8bcb73d9f37a` | Play Store (de) | 84. Tasks - To Do List & Reminders | 2026-01-15 | 5★ | BKPW_ACCEPT |
| `P84#7935` | `fd06ff6f-7403-45aa-93cc-b50da46a351f` | Play Store (en) | 84. Tasks - To Do List & Reminders | 2025-12-03 | 1★ | BKPW_COMPLAIN, BKPW_LOSS, BKPW_LEFT |
| `P84#8976` | `b061afe4-2731-40d0-a221-41f367d4744a` | Play Store (en) | 84. Tasks - To Do List & Reminders | 2025-05-16 | 1★ | BKPW_COMPLAIN, HOSTAGE_DATA, RESTORE_PW_SURPRISE |
| `P84#9037` | `145a974a-04bd-4d12-8004-2d43bd268eff` | Play Store (en) | 84. Tasks - To Do List & Reminders | 2025-05-06 | 1★ | L_OTHER, BKPW, O_LEFT |
| `P84#9108` | `c62dcaea-bb6a-4a16-b760-0cd3e3e9267d` | Play Store (en) | 84. Tasks - To Do List & Reminders | 2025-04-23 | 2★ | BKPW_COMPLAIN, RESTORE_PW_SURPRISE |
| `P84#12103` | `f8a37906-5d61-48e1-a73b-038dcbc5a52e` | Play Store (en) | 84. Tasks - To Do List & Reminders | 2023-12-13 | 5★ | BK_PAID_FOR_SAFETY |
| `P84#54167` | `67ad7eb3-35b9-4d68-9175-507026952100` | Play Store (ru) | 84. Tasks - To Do List & Reminders | 2021-02-11 | 1★ | BKPW_COMPLAIN, HOSTAGE_DATA |
| `P97#2819` | `fc98ed3c-af38-4f69-84d4-59f52f369455` | Play Store (en) | 97. To-do list - tasks planner | 2024-02-07 | 5★ | FREE_BK_PRAISE |
| `P106#678` | `b46a70a1-d4c6-4858-b306-ea4c783204ae` | Play Store (en) | 106. Habit Tracker n Pets - HabitYou | 2021-01-08 | 2★ | BKPW_COMPLAIN, BKPW_LEFT |
| `P106#854` | `6cbd6fb3-afd7-417f-befa-8018ecad8411` | Play Store (hu) | 106. Habit Tracker n Pets - HabitYou | 2021-05-26 | 2★ | DATA_ACCESS_PW, HOSTAGE_DATA |
| `P126#30659` | `7275f299-9e8a-4017-8f66-5795b4e2a828` | Play Store (en) | 126. To Do List | 2023-03-29 | 1★ | L_NEWPHONE, OS_BACKUP_MISSED |
| `P126#70222` | `b05143c1-69ed-435b-8fb5-76976a5a2568` | Play Store (en) | 126. To Do List | 2019-07-01 | 5★ | SYNC_PAID |
| `P130#295` | `7f6026f5-4873-4722-bfa1-c8f600cf39cb` | Play Store (en) | 130. Way of Life - habit tracker | 2019-09-10 | 1★ | BKPW_COMPLAIN, HOSTAGE_DATA, BKPW_LEFT |
| `P91#143` | `922e80a5-2049-4109-a7e0-449b2ca89736` | Play Store (en) | 91. Habit Check Calendar | 2025-01-21 | 1★ | L_OTHER, O_LEFT, DATA_LOCK_AFTER_TRIAL (duplicate text, §9) |
| `P91#170` | `2e386ecb-15b4-47ea-b072-cc6fc99c8673` | Play Store (en) | 91. Habit Check Calendar | 2025-01-09 | 1★ | L_OTHER, O_LEFT, DATA_LOCK_AFTER_TRIAL (duplicate text, §9) |
