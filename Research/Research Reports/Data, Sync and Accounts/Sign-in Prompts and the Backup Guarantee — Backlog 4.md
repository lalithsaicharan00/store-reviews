# Sign-in Prompts and the Backup Guarantee — Backlog 4

*Written by Claude (Claude Code), 27 Sep 2026. Research for [Backlog #4](<../../../Architecture/Backlog.md>), widened at the user's request to cover the rule "data must never be lost". A recommendation, not yet decided.*

**The questions:**
1. If someone doesn't want an account, should we keep asking them?
2. Should buying Premium mean their data goes to our server?
3. Is there always *somewhere* the data is backed up? Is iCloud on by itself? What about Google Drive on Android?
4. Is syncing several devices through iCloud or Google Drive easy or hard?
5. How do we make sure data is never lost, even in the worst case?

**How each point is backed:**
- **Users show**: review evidence from this screen.
- **Platform fact**: Apple or Google documentation, linked.
- **First principles**: reasoned from how the system works.

---

## 1. The short answer

1. **Don't keep asking.** Users show that repeated prompts are one of the most hated patterns in these apps: 72 reviews, mean **1.75★**, 60% 1★, and 14 of them say they left or will leave. The fix they ask for is plain: “Once is fine but they keep popping up” (`A13#12100`), and “I don't want to be asked again after I say no the first time” (`P12#51759`). So we drop the time-based nudges (day 3, 5th habit, weekly). We offer sign-in only when the person asks for something that needs it, and **once** after they buy Plus. A "Not now" is final.
2. **Buying Premium uploads nothing.** Only signing in does, and the sign-in screen says so. Plus already restores itself from the App Store or Google Play on a new phone *without* our account ([02 §3.4](<../../../Architecture/02. Billing and Entitlements.md>)). So an account is never needed to keep what they paid for on the same platform.
3. **Change the question from "make an account" to "keep a copy somewhere else".** The one thing we *do* ask, once, is where their backup goes, and only if there isn't one already.
   - **iPhone:** backup to the user's own iCloud is automatic if iCloud is on for the phone, so most people never see a question.
   - **Android:** Google Drive always needs one tap of consent, so everyone sees one card: **Connect Google Drive · Sign in instead · Keep on this phone only**.
   - Whatever they pick, we respect it and never ask again.
4. **Sync through their own cloud: iCloud is medium-hard, Google Drive is hard.** Both only reach one platform. Users show both going wrong: 37 reviews of iCloud sync failing vs 10 praising it, and 23 of "backup file used as sync" losing edits. Keep the 26 Sep decision: **their cloud is for backup, our account is for sync.**
5. **Data safety is layered, and each layer is verified by reading it back.** Section 5 walks through 16 worst cases and the layer that catches each. Only one case can still lose data: someone who chose "Keep on this phone only", turned off their phone's own backup, and then loses the phone. That was their informed choice, and the app told them plainly.

---

## 2. What users show

**Screen:** all 1,487,223 reviews, 10 multilingual patterns, 2,792 matches. **Read and hand-coded:** 885 from the habit apps (App Store and Play), every match for the prompt, Google Drive and cloud-failure patterns, plus capped samples of iCloud sync and "no nagging" praise. 671 were on topic, from 76 apps. Files: [`Sign-in and Backup Evidence/`](<Sign-in and Backup Evidence/>).

| What users say | Reviews | Apps | Mean ★ | 1★ | Payers |
|---|---|---|---|---|---|
| **Repeated prompts** (upsell, sign-in, backup, iCloud, referral) | 72 | 20 | **1.75** | 60% | 15 |
| of those, say they left or will leave | 14 | | | | |
| **Praise for not nagging / no account needed** | 53 | 26 | **4.91** | 0% | 3 |
| **Accounts that broke**: stuck at sign-up, can't log in, logged out every launch | 111 | 24 | 2.03 | 54% | 14 |
| **Lost data with no off-phone copy** (reinstall, new, lost or broken phone, iCloud off or full) | 44 | 17 | 3.16 | 23% | 10 |
| **Ask for automatic backup to their own cloud** (Drive 131, iCloud 79, any 15) | 225 | 47 | 4.17 | 4% | 11 |
| Manual backup forgotten, or a chore | 22 | 12 | 3.09 | 27% | 4 |
| Backup or restore behind a paywall | 17 | 8 | 2.35 | 41% | 3 |
| **iCloud backup or restore failed** (error, empty, stale, crash, overwrote) | 46 | 8 | **1.93** | 57% | 16 |
| Google Drive backup failed / works | 7 / 10 | 6 / 7 | 3.29 / 4.80 | | |
| **iCloud sync failed** (none, partial, slow, duplicates, reverts, wipes) / works | 37 / 10 | 12 / 6 | 3.08 / 4.60 | | |
| **Backup file used as sync**: manual, stale, lost edits | 23 | 10 | 3.91 | 4% | 6 |
| **iCloud not usable for them** (full, off, refused, work phone, confusing) | 16 | 10 | 3.88 | 12% | 2 |

Counts are from the reading sample, not the whole corpus. A review counts once per row.

### 2.1 Repeated prompts drive people away
- **Most repeated prompts in these apps are upsells**, but the reaction is the same for sign-in and backup prompts:
  - “I got rid of it because it nagged me to create an account” (`P126#156727`);
  - “The app keeps asking me to sign into my Apple ID. I don’t want to do this. It’s annoying.” (`A53#1609`);
  - from a paying subscriber: “No I don't want to login and send my data to you” (`A5#2748`).
- **Backup reminders with no "never" option get the app deleted:**
  - “There isn’t an option to turn off the reminder, only remind me tomorrow or remind me in 5 days. For that reason I’m deleting the app.” (`A31#459`);
  - “How about never? I don’t want to backup to the cloud.” (`A31#725`);
  - “不想备份的不备呗，不要让它一直显示着行吗” — if someone doesn't want to back up, let them; stop showing it all the time (`A52#896`);
  - “every time I open it, it tells me to turn on iCloud. It’s irritating enough I might switch to another app.” (`A1#55183`).
- **What they want instead:**
  - “Once is fine but they keep popping up” (`A13#12100`);
  - “I don't want to be asked again after I say no the first time” (`P12#51759`);
  - praise for apps that leave them alone: “It doesn't nag you with an account” (`P3#2299`), “no login prompts or spam” (`P84#9978`), “No login required. No pop-ups.” (`P126#63579`).

### 2.2 Accounts are a failure point, not only a safety net
111 reviews are about sign-in itself breaking. Examples: “I can’t get past the log in screen” (`A55#1486`), “Forces me to log in with password every time I open the app” (`A85#1467`), and a phone login that loses years: “Lost a lot of time of multiple accounts” (`A10#26304`). This is one more reason to keep the app fully usable signed out, and never gate a check-in on the network: “If you are offline, this means you can’t do anything until you go back online” (`A46#2056`).

### 2.3 Without an off-phone copy, data is lost, and users know it
- **What happens:**
  - “Today i lost 2.5 years of data as i forgot to backup the file and hit factory reset.” (`P3#10433`);
  - “I lost my phone and I lost track of over a year of habits” (`P3#11416`);
  - “many apps got uninstalled from my phone automatically due to some issue and Loop Habit tracker was also one of them. Problem is I lost all my tracking data.” (`P3#3532`).
- **The 225 requests are mostly from *happy* users** (mean 4.17★). They want backup that is automatic and goes to *their own* cloud:
  - “please consider adding automatic daily backups to Google Drive, like Truecaller and WhatsApp” (`P3#2596`);
  - “Google drive backup option is crying need to backup my tracks in my own cloud” (`P3#9143`);
  - “not requiring to register to another online service” (`P2#13093`).
  - Most Drive requests come from one open-source Android app (Loop). Even so, they span 18 apps.
- **Manual backup fails people:** “if something happens to the phone suddenly, you'll lose the data since the last time you remembered to back up” (`P3#14335`), and “This is literally the only app (out of 114 on my phone) that neither has automatic periodic backups nor iCloud sync support” (`A76#5566`).
- **Some would pay for it:** “I am happy to pay for the app if it has got Google drive backup sync” (`P84#30756`). But charging for backup is punished: “A subscription to backup & restore to my own Google Drive, no and uninstalled.” (`P106#678`). Backup stays free (03 rule 8).

### 2.4 iCloud is not everyone, and iCloud backups fail at the worst moment
- **Not everyone has working iCloud:**
  - full: “I’m not paying extra for iCloud storage. I maxed that out years ago.” (`A20#3069`), and “icloud都没有空间了” — iCloud has no space left (`A52#16955`);
  - off: “我的iCloud没有开” — my iCloud wasn't on, so a reinstall erased everything (`A52#1940`), and “due to upgrading my iPhone with no cloud backup space I lost my last finch” (`A10#12241`);
  - refused: “I will never enable iCloud for privacy reasons” (`A41#753`);
  - work phones: “На корп гаджетах синхронизацию отключают” — on company devices sync is switched off (`A59#4499`);
  - confusing: “It turns out that I didn't have iCloud Drive activated” (`A48#1410`).
- **iCloud backups that "worked" until the restore** (46 reviews, 1.93★):
  - “Changed devices and lost months worth of data, even though I had iCloud sync enabled” (`A13#12689`);
  - “When I tried to restore from iCloud backup, it only restored data from perhaps a year ago” (`A20#229`);
  - “iCloud明明开着却没有自动备份，数据全都没了” — iCloud was clearly on but it never backed up automatically; all data gone (`A86#184`).
  - These are the apps' bugs, not iCloud's. The lesson is ours (03 §3.4): **a backup counts only after it has been read back and checked**, and restore is tested on every build.

---

## 3. Platform facts

| Fact | What it means for us | Source |
|---|---|---|
| On a new iPhone, iCloud features are set up automatically when the user signs in to their Apple Account. Apps that use iCloud get a per-app switch the user can turn off | Most iPhone users need **no question**: we check `CKContainer.accountStatus` and write the first backup silently. *Confirm at build time that a new app's switch starts on* | [Apple: apps and features that use iCloud](https://support.apple.com/guide/icloud/overview-of-apps-and-features-that-use-icloud-mm203ae070a2/icloud), [AppleInsider](https://appleinsider.com/inside/icloud/tips/how-to-turn-off-iclouds-default-settings-in-macos-and-ios) |
| Free iCloud is still 5 GB (unchanged since 2011). **About 64% of US Apple customers pay** for more | About a third are on free iCloud and often **full**. A full iCloud rejects our tiny (<1 MB) backup too, so we must detect it and offer another place | [CIRP via Cult of Mac](https://www.cultofmac.com/news/icloud-storage-adoption-apple-tv-plus-music-applecare-2024), [iDownloadBlog](https://www.idownloadblog.com/2024/08/21/cirp-survey-apple-icloud-storage-most-popular-apple-service/) |
| Android Auto Backup is on for our app by default, but it only runs if the **user's** Google backup is on, about once every 24 h, when the phone is idle and on Wi-Fi. It keeps 25 MB and one copy | A useful net, but we **can't see** whether it is on or when it last ran. So it never counts as "backed up" in our status | [Android Auto Backup](https://developer.android.com/identity/data/autobackup), [Android Help](https://support.google.com/android/answer/2819582?hl=en) |
| Our own copy in Google Drive (`drive.appdata`) needs the user's consent once. After that it is silent. The app folder is deleted if they disconnect us in Drive | On Android there is **always one question**. It can be one tap, because the Google account is already on the phone | [Drive app data](https://developers.google.com/workspace/drive/api/guides/appdata) (see 03 §4) |
| **CloudKit sync** is much easier since `CKSyncEngine` (iOS 17). Still, the app must pick its own conflict rule, persist the engine's state, and deletions are applied with no conflict check | iCloud sync is doable, but it would be a **second sync engine**, and it only reaches Apple devices | [Christian Selig: CKSyncEngine Q&A](https://christianselig.com/2026/01/cksyncengine/), [Superwall](https://superwall.com/blog/syncing-data-with-cloudkit-in-your-ios-app-using-cksyncengine-and-swift-and-swiftui) |
| **Google Drive** is file storage, not a sync service. Other devices see changes only by polling the Changes API, listings are eventually consistent, rate limits apply, and it has no conflict handling | Sync over Drive means building our own sync engine on a slower, weaker transport | [Drive changes.list](https://developers.google.com/drive/api/reference/rest/v3/changes/list), [RxDB Google Drive sync](https://rxdb.info/replication-google-drive.html) |

---

## 4. Recommendation

### 4.1 Sign-in: only when needed, once after purchase (replaces 01 §3.2's nudge list)

| Moment | Show? | What it says |
|---|---|---|
| Day 3, 5th habit, weekly | **No. Dropped** | – |
| **They tap something that needs an account** (use on iPad or another phone, web, Plus Family, a family invite, an iPhone ⇄ Android move) | Yes, every time they ask. It is the answer to their tap, not a nudge | "Syncing needs a free account. Sign in with Apple / Google." Plus the privacy line from #5: "Sign in only to sync. Apple can hide your email. We never sell data. Export or delete everything any time." |
| **Right after buying Plus** | **Once**, on the "Plus is yours" screen, *below* the celebration (not a separate popup before it) | "Plus is yours on every device with this Apple ID. Want your habits and Plus on Android or the web too? [Sign in] [Not now]" |
| After any "Not now" | **Never again.** Settings → Account keeps a plain "Sign in to sync" row | – |

**Why this is enough (first principles):**
- A signed-out buyer's Plus already comes back from the store on any device on that store (02 §3.4).
- Their habits are protected by the backup in §4.2.
- So the only things an account adds are **sync** and **crossing platforms**, and the person asks for those themselves.

### 4.2 The backup guarantee: one question, asked once, only if needed

**The rule:** every user has a **verified copy off the phone**, or has **told us** they want the phone only.

1. **iPhone with iCloud available:** say nothing. The first backup runs within 5 minutes of the first habit (03 §3.3) and is read back. Settings shows "iCloud · backed up 2 min ago ✅".
2. **Everyone else gets one card, once.** That is every Android user, plus iPhones where iCloud is signed out, switched off for our app, full, or blocked by a work profile.
   - **When:** the day after they create their first habit, so there is something to protect and onboarding isn't interrupted.
   - **Where:** a card on Today, not a popup.
   - **Android card:** "Your habits are only on this phone. Back them up to your Google Drive: free, private, one tap." [Connect Google Drive] · [Sign in instead] · [Keep on this phone only]
   - **iPhone card:** "Your habits are only on this phone. [Turn on iCloud backup] (shows the exact Settings steps, or 'iCloud is full: free up space') · [Save to a folder] (Files: Google Drive, Dropbox, On My iPhone) · [Sign in instead] · [Keep on this phone only]"
3. **Closing the card counts as "Keep on this phone only".** A short confirmation says "OK. Your phone's own backup may still include us. Change this any time in Settings → Backup."
4. **After that, no more asking.** Settings shows the honest state ("Backed up only on this phone"), and the avatar dot is not shown for a choice the user made.
5. **Alerts only when a backup the user has breaks** (03 §3.4, kept): "iCloud is full", "Google Drive access was removed". One notice per incident, with the fix. Users who chose phone-only get none.

**Changes to 03 this needs:**
- §3.4: the health rule fires only for a destination that is on.
- §3.9: drop the monthly "export" suggestion. It is the "remind me in 5 days" pattern users delete apps over (`A31#459`).

### 4.3 Premium and our server (the user's question)
- **Premium never uploads anything.** Buying Plus changes nothing about where data lives.
- **Signing in means a copy on our server**, because that is what sync is. The sign-in sheet says it in one line. "Turn off sync" (09 §7) deletes the server copy and keeps everything on the phone.
- **Signed-in users keep their own iCloud or Drive snapshot too** (03 §3.8), so there are two independent copies off the phone.

### 4.4 Multi-device through iCloud or Google Drive: easy or hard?

| | iCloud (CloudKit) | Google Drive | Our account (decided) |
|---|---|---|---|
| Reaches | iPhone, iPad, Mac only | Any device with that Google account, but no push | iPhone, iPad, Android, web |
| Effort | **Medium.** `CKSyncEngine` does transport; we still write conflicts, deletions, state | **Hard.** Polling, rate limits, eventual consistency, no conflict handling. We'd build a full sync engine on files | One engine, already designed (05) |
| What users show | 37 failing vs 10 working. Duplicates: “Either the app shows duplicate entries (with an incorrect streak count) or don’t appear at all” (`A23#3191`). A backup cleanup wiped data through sync: “I deleted my backups in icloud ti have some space but app just sync” (`A23#2936`) | Drive used as sync by hand loses edits: “I accidently lost a few days worth of tracking because I backed up the wrong device and imported from cloud on the device with the last few days on it” (`P2#3087`) | – |
| Verdict | A second sync system for one platform. **No** (#5) | **No** | **Yes** |

**Signed-out users with an iPhone and an iPad still get something:** the one-time "Copy from your iPhone's backup" (03 §3.6a), which says it won't stay in step.

### 4.5 Two rules the reviews add
- **A backup is never a sync source.** Deleting or pruning backups must never delete live data. That is `A23#2936`'s disaster.
- **Restore merges by default and can be undone** (03 §3.6). It never silently replaces newer data: “只能将另一个设备的数据复制过来，同时原设备的数据删除，无法做到整合” — restoring copies the other device and deletes this one's data; they can't be combined (`A52#13244`).

---

## 5. Worst cases, and what catches each

"Layer" refers to the five safety nets in [Data Safety, Accounts and Sync §5](<../../../Architecture/Data Safety, Accounts and Sync.md>) and the backup rules in [03](<../../../Architecture/03. Backup and Restore.md>).

| # | Worst case | What catches it | Left at risk |
|---|---|---|---|
| 1 | App killed or crashes mid-write | SQLite transactions + WAL (net 1) | Nothing |
| 2 | A bad update's migration fails or corrupts | No destructive migration; snapshot before every migration; tests on a database from every shipped version; phased rollout stopped at 1–5% | Nothing |
| 3 | A sync bug deletes or duplicates data on every device | Merge by ID; tombstones, not hard deletes; the data-loss canary stops sync when counts drop sharply; 30-day Recently deleted; server point-in-time recovery (30 days) + nightly R2 snapshots; each device's local snapshots | Nothing |
| 4 | A restore overwrites newer data | Preview; snapshot first; Merge by default; Undo restore for 30 days | Nothing |
| 5 | Backup "succeeded" but is empty or unreadable | Read-back verification with checksum; 7/4/6 generations; the newest good copy is never pruned; CI does backup → wipe → restore → compare | Nothing |
| 6 | Backup silently stops (iCloud full, Drive access removed, folder moved) | Backup ledger; one alert after 3 days naming the reason and the fix | Up to 3 days of changes if the phone dies in that window; local snapshots still hold them |
| 7 | Phone lost, broken or reset: signed out, backup on | Their iCloud or Drive snapshot + reinstall marker → "We found your backup" before onboarding | Changes since the last backup (≤ 6 h for check-ins, ≤ 5 min for edits) |
| 8 | Same, but they chose "phone only" | OS backup / Quick Start / Auto Backup if the user has it on; phone-to-phone transfer (04) | **Everything, if their phone backup is off too.** This is the one case left, and the user chose it knowingly |
| 9 | Reinstall or offload | Data in Application Support (kept on offload); marker offers the cloud copy | Same as 7 / 8 |
| 10 | iPhone ⇄ Android move | Move flow (04): QR transfer or open file format; account optional | Nothing if they use the flow |
| 11 | Our server down, or our company gone | The phone is the source of truth and works offline; the user's own cloud copy in an open format; the weekly off-Cloudflare export | Nothing (sync pauses) |
| 12 | Account deleted by mistake | Deletion needs a fresh Face ID / Apple or Google sign-in; it asks "Also erase this phone's data?" with the default **keep** (09 §7) | Nothing on that phone |
| 13 | Account can't sign in (provider broken, lost email) | Linked sign-in methods and recovery (01 §3.6); the phone keeps working signed out | Nothing |
| 14 | Phone storage full | A write that fails is reported and never truncates the database (03 §3.7) | The unsaved change, with a clear message |
| 15 | Paywall or ended subscription | Backup, restore, export and sync are never paid | Nothing |
| 16 | A bug in the backup code itself | Format is backward-readable forever; restore from every old format is tested; a second, independent copy (OS backup, and the server for signed-in users) | Nothing, as long as either copy is intact |

**Why this holds (first principles):**
- Every row has at least **two independent copies** made by **different code paths**: the local database plus snapshots, the OS backup, their own cloud, and our server if signed in.
- One bug can't take out all of them. The canary stops the one path most likely to spread damage, which is sync.

---

## 6. What changes if you agree

1. **01 §3.2:**
   - replace the nudge list with §4.1;
   - Backlog #4 becomes decided.
2. **03 Backup:**
   - add the one-time protection card (§4.2);
   - the health alert only fires for a destination that is on;
   - drop the monthly export suggestion;
   - add "a backup is never a sync source".
3. **02 Billing:** the post-purchase offer sits on the "Plus is yours" screen, once.
4. **Tests to add:**
   - Android fresh install: the card shows on day 2, and one tap makes Drive verified;
   - close the card: never shown again, no dot;
   - iCloud full: the card offers folder or sign-in;
   - delete every backup in iCloud: live data is untouched;
   - signed-out Plus buyer taps "Not now": never asked again, and Plus restores from the store on a new phone.
5. **Housekeeping:** 03's appendix is printed three times (an appendix-builder rerun). Trim it to one.

---

## 7. Method and limits
- **Screen:** `scan.py` ran 10 multilingual regex patterns over every review in the corpus.
  - The sign-in-nag pattern was noisy: 57% of what was read was on topic, because "every time I log in" often just means "every time I open the app".
  - Every relevant review was coded by hand anyway.
  - Precision for the other patterns is in [`tally.txt`](<Sign-in and Backup Evidence/tally.txt>).
- **Reading set:** `sample.py` drew every App Store and Play match for 8 patterns. iCloud sync was capped at 110 and "no nagging" praise at 60, with at most 6 per app. Native apps were left out: the Drive and iCloud matches there are mostly reviews of Google's and Apple's own apps.
- **Coding:** one line per review, `key|CODES|"verbatim quote"`. `check_cls.py` checks that all 885 were coded and every quote is verbatim (0 errors). The group rollups are in [`groups.txt`](<Sign-in and Backup Evidence/groups.txt>).
- **Limits:**
  - Sign-in nagging on its own is rare in this corpus: 9 reviews, because few habit apps nag for accounts. The conclusion leans on the 72 reviews about repeated prompts in general.
  - The Drive requests are concentrated in Loop Habit Tracker (Play).
  - iCloud failures reflect how these apps implemented iCloud, not iCloud itself.
  - The 64% iCloud figure is US-only.

<!-- APPENDIX -->

## Appendix — reviews cited

40 reviews cited. Ref = store letter (A App Store, P Play Store, N native app) + app number + line index in that app's `reviews.jsonl`.

| Ref | Review ID | Store | App | Date | Stars | Codes |
|---|---|---|---|---|---|---|
| `A1#55183` | `8532904534` | App Store (us) | 1. Habit Tracker - Goal Tracker & ADHD Planner | 2022-04-05 | 3★ | IC_NAG, LEFT |
| `A5#2748` | `11395184650` | App Store (us) | 5. Routine Planner, Habit Tracker - Daily Time Management for ADHD | 2024-06-18 | 1★ | SN_NAG, SN_NO_SKIP, SERVER_REFUSE, IC_WANT, X_PAYER |
| `A10#12241` | `11944274918` | App Store (gb) | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2024-11-13 | 5★ | IC_FULL_LOSS |
| `A10#26304` | `13626704582` | App Store (us) | 10. Finch - Self-Care Pet - Daily Journal & Habit Tracker | 2026-01-12 | 3★ | SN_LOGIN_FAIL |
| `A13#12100` | `7558415832` | App Store (us) | 13. Productive - Habit Tracker - Daily Routine & Goals Planner | 2021-07-09 | 2★ | UP_NAG |
| `A13#12689` | `6132261207` | App Store (us) | 13. Productive - Habit Tracker - Daily Routine & Goals Planner | 2020-06-28 | 2★ | IC_BK_FAIL, LOSS_MOVE, X_PAYER |
| `A20#229` | `12431520165` | App Store (ca) | 20. Habit — Daily Tracker - Crush your goals like a boss | 2025-03-17 | 1★ | IC_BK_STALE, LOSS_UPDATE, X_PAYER |
| `A20#3069` | `12433150633` | App Store (us) | 20. Habit — Daily Tracker - Crush your goals like a boss | 2025-03-18 | 1★ | IC_FULL, BK_MANUAL, X_PAYER |
| `A23#2936` | `10325632518` | App Store (kr) | 23. Streaks - The habit-forming to-do list | 2023-09-02 | 1★ | IC_SYNC_WIPE |
| `A23#3191` | `8539464388` | App Store (mx) | 23. Streaks - The habit-forming to-do list | 2022-04-06 | 5★ | IC_SYNC_DUP |
| `A31#459` | `10286948200` | App Store (ca) | 31. Do Habits - Get It Done - Daily Routine & Goal Planner | 2023-08-22 | 1★ | BK_NAG, LEFT |
| `A31#725` | `5443901971` | App Store (ca) | 31. Do Habits - Get It Done - Daily Routine & Goal Planner | 2020-01-24 | 4★ | BK_NAG, CLOUD_REFUSE |
| `A41#753` | `9104605843` | App Store (us) | 41. Awesome Habits - Habit Tracker - Streaks, days since & goals | 2022-09-20 | 1★ | IC_REFUSE, PRIVACY_CONCERN |
| `A46#2056` | `7098518884` | App Store (us) | 46. everyday - Habit Tracker - Daily Routine Checklist | 2021-03-13 | 1★ | SN_LOGOUT, ONLINE_ONLY |
| `A48#1410` | `9719638045` | App Store (mx) | 48. Strides - Habit Tracker + Goals - Goal Planner & Daily Checklist | 2023-03-16 | 5★ | IC_SETUP_CONFUSE |
| `A52#896` | `13870790082` | App Store (cn) | 52. ShineDay - Habit Tracker - Micro Habits, ADHD & Focus | 2026-03-21 | 3★ | BK_NAG, IC_BK_FAIL |
| `A52#1940` | `13218927800` | App Store (cn) | 52. ShineDay - Habit Tracker - Micro Habits, ADHD & Focus | 2025-10-03 | 5★ | IC_OFF_LOSS, LOSS_REINSTALL |
| `A52#13244` | `5691983568` | App Store (cn) | 52. ShineDay - Habit Tracker - Micro Habits, ADHD & Focus | 2020-03-21 | 5★ | XDEV_MANUAL, RESTORE_REPLACE |
| `A52#16955` | `2235141495` | App Store (cn) | 52. ShineDay - Habit Tracker - Micro Habits, ADHD & Focus | 2018-02-22 | 4★ | IC_FULL, ACCT_WANT |
| `A53#1609` | `3066587541` | App Store (us) | 53. HabitMinder • Habit Tracker - Daily Reminders & Routines | 2018-08-15 | 2★ | SN_NAG |
| `A55#1486` | `2070655387` | App Store (us) | 55. Habit-Bull - Daily Goal Planner - Best To Do List Streak Tracker | 2018-01-09 | 1★ | SN_STUCK |
| `A59#4499` | `11608765801` | App Store (ru) | 59. Tappsk - ToDo & Habit Tracker - Task Manager & Daily schedule | 2024-08-14 | 5★ | IC_NOT_USED |
| `A76#5566` | `1798965025` | App Store (us) | 76. Way of Life - Habit Tracker - Build a better, stronger you | 2017-09-19 | 3★ | LOSS_NO_BACKUP, BK_MANUAL, LEFT |
| `A85#1467` | `1756036334` | App Store (no) | 85. Habitica - Gamified Taskmanager - Stay motivated and organized | 2017-08-28 | 2★ | SN_LOGOUT |
| `A86#184` | `9310883434` | App Store (cn) | 86. Today Habit tracker - For to-dos, routines & goals | 2022-11-20 | 1★ | IC_SILENT_FAIL, LOSS_UPDATE |
| `P2#3087` | `4ad4eb96-420d-4360-b4cd-684bdc0b573d` | Play Store (en) | 2. HabitNow Daily Routine Planner | 2025-04-14 | 3★ | XDEV_MANUAL, LOSS_XDEV, X_PAYER |
| `P2#13093` | `22a5afec-add1-4df9-9305-1a66d3ac9c8d` | Play Store (en) | 2. HabitNow Daily Routine Planner | 2019-10-23 | 5★ | GD_WANT, OWN_CLOUD_PREF |
| `P3#2299` | `7e4e5152-4c62-4fbe-9ee1-983fed831643` | Play Store (en) | 3. Loop Habit Tracker | 2025-12-24 | 5★ | NOACC_PRAISE, LOCAL_PRAISE |
| `P3#2596` | `3a240b2b-3412-44f5-9c0c-c6b832ca2abb` | Play Store (en) | 3. Loop Habit Tracker | 2025-09-26 | 5★ | GD_WANT |
| `P3#3532` | `e96ff9bc-c47a-4ff3-aa33-6661d10d0b9a` | Play Store (en) | 3. Loop Habit Tracker | 2024-11-24 | 5★ | LOSS_NO_BACKUP, GD_WANT |
| `P3#9143` | `88357842-14e1-40b0-9eb0-6e6d1dc14c54` | Play Store (en) | 3. Loop Habit Tracker | 2020-08-22 | 3★ | GD_WANT, OWN_CLOUD_PREF |
| `P3#10433` | `5d37a37b-72de-4482-a85c-c7138ebebc8b` | Play Store (en) | 3. Loop Habit Tracker | 2020-01-08 | 4★ | LOSS_NO_BACKUP, BK_MANUAL, GD_WANT |
| `P3#11416` | `f569ebb0-238a-4964-ac9f-137c9fba2438` | Play Store (en) | 3. Loop Habit Tracker | 2019-05-29 | 5★ | LOSS_NO_BACKUP |
| `P3#14335` | `a80cb37a-509e-4958-b412-58c0961dee39` | Play Store (en) | 3. Loop Habit Tracker | 2017-07-25 | 4★ | GD_WANT, BK_MANUAL |
| `P12#51759` | `922ee00b-0fdc-43d0-ac7a-c2e24fdbd5c6` | Play Store (en) | 12. Fabulous Daily Routine Planner | 2020-06-12 | 4★ | NAG_OTHER, ASK_ONCE, X_PAYER |
| `P84#9978` | `3c5ec97d-a526-48b4-8d7e-e50e20ec6829` | Play Store (en) | 84. Tasks - To Do List & Reminders | 2024-11-17 | 5★ | NOACC_PRAISE |
| `P84#30756` | `8e3c0afd-d1c4-43f5-bd9c-92e3bc4d9a36` | Play Store (en) | 84. Tasks - To Do List & Reminders | 2018-12-27 | 5★ | GD_WANT, PAY_FOR_BACKUP |
| `P106#678` | `b46a70a1-d4c6-4858-b306-ea4c783204ae` | Play Store (en) | 106. Habit Tracker n Pets - HabitYou | 2021-01-08 | 2★ | BK_PAID, LEFT |
| `P126#63579` | `f6795c0d-9eb4-45d2-8282-afa812e72f50` | Play Store (en) | 126. To Do List | 2020-03-31 | 5★ | NOACC_PRAISE |
| `P126#156727` | `d25a2fc7-b31d-440b-b80f-fe5d168fd3d9` | Play Store (pl) | 126. To Do List | 2019-05-17 | 1★ | SN_NAG, LEFT |
