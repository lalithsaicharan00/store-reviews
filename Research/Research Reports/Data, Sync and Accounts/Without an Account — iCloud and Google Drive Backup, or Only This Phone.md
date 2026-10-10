# Without an Account — iCloud and Google Drive Backup, or Only This Phone?

*Written by Claude (Claude Code), 10 October 2026. Current Work 77. Research and a recommendation, not a decision.*

**The user's question (10 Oct 2026):** professional apps from big companies mostly don't offer "back up to Google
Drive" or "back up to iCloud". On the free plan, when someone has **no account**, should we keep the automatic iCloud
and Google Drive backup that branch `app-lock-privacy-security` builds, or remove it, so the free plan without an
account keeps data **only on the device**, and an account (free) backs up and syncs one device?

**How each point is backed:**
- **Users show**: reviews, read by hand for this report (counts, stars, review IDs).
- **Earlier report**: a finding from an earlier study, named and linked; not re-checked here.
- **Platform fact**: how iOS or Android behave, from the earlier reports that cite Apple's and Google's documents.
- **First principles**: reasoned.

**Evidence:**
- **Fresh screen:** all **1,487,223** reviews in the repo (337,331 App Store, 901,453 Play Store, 248,439 for the
  built-in and big-company apps), 6 patterns: iCloud, Google Drive, "stored locally", "no account / no sign-up",
  "account required", and data lost after a reinstall, a new phone or a reset. Script: [`scan.py`](<No-Account Backup Evidence/scan.py>).
- **Read by hand:** **every one of the 2,505 matches in third-party apps** (habit, routine and to-do apps, 2012–2026,
  every language), coded into 24 codes; the map validates with no unknown or duplicate IDs
  ([`codes.txt`](<No-Account Backup Evidence/codes.txt>), [`tally.py`](<No-Account Backup Evidence/tally.py>),
  [`stats.txt`](<No-Account Backup Evidence/stats.txt>)).
- **Big companies' own apps:** 3,485 matches in Apple's, Google's, Microsoft's and Samsung's apps; **363 read by
  hand** (every "account required", "no account" and "stored locally" match, plus random samples of the rest). This is a
  sample, not a full read, and is labelled as such below.
- **22 quotes**, each checked word for word by [`verify.py`](<No-Account Backup Evidence/verify.py>) (it also caught a
  deliberately wrong test quote).
- **Earlier reports reused, as attributed:** [Free Plan Data Protection](<Free Plan Data Protection — Backup Without Giving Away Plus.md>)
  (1 Oct), [Backup, Sync and Accounts — One Seamless Experience](<Backup, Sync and Accounts — One Seamless Experience.md>)
  (1 Oct), [Architecture 01. Accounts and Identity](<../../../Architecture/01. Accounts and Identity.md>) (26 Sep),
  [Free Plan Backups](<Free Plan Backups — iPhone and iPad, and a Backup That's Never a Day Behind.md>) (9 Oct).

---

## The short answer

1. **Keep the automatic iCloud backup for people without an account, on iPhone.** Removing it would bring back the
   single most common kind of 1★ story in this study, and it costs us nothing to keep.
   - **Users show:** **339** people lost everything because the data lived only on the phone (2.78★, 53 apps), and
     **464** asked for a cloud backup or iCloud/Drive sync (3.83★ App Store, 4.15★ Play). Only **5** people asked for a
     backup that never leaves the phone, and **36** praised local-only storage.
   - **First principles:** device-only means the first broken, lost or reset phone ends someone's history and streak,
     the thing people value most in a habit app (Free Plan Backups §3).
2. **Don't make an account the only way to be safe.** People dislike accounts they're made to create far more than
   they like accounts.
   - **Users show:** "had to make an account" averages **1.42–1.61★** (96 reviews); "no account needed" averages
     **4.82–4.89★** (173). Accounts also fail: **179** people lost data *with* an account (sign-in broken, sync never
     ran, a new phone that didn't recognise them), at **1.66–1.97★**.
   - Under "device-only unless you sign up", most free users would never sign up, so most would have no backup at all.
3. **Big companies do back up, through the account people already have.** Apple's own apps keep data in iCloud,
   Google's in the Google account, Microsoft's in a Microsoft account. None of them keeps your data only on the phone.
   For a small app, the person's **own iCloud** is the closest thing to that: an account they already have, with
   nothing new to create. Of the big companies, Microsoft makes its own account mandatory, and that drew the most
   complaints in the sample (§4).
4. **Simplify instead: one place, chosen for them, on each platform.**
   - **iPhone:** iCloud only, automatic, no choice to make. **Drop Google Drive from iPhone** (it's built but hidden
     behind a flag today). Only **13** App Store reviews mention Google Drive at all, against **269** asking for iCloud.
   - **Android (later):** Google Drive is what people there ask for: **158** of 195 cloud-backup requests name it (4.27★), often "like WhatsApp".
   - **With an account:** the account only, as built. That's the "one backup place at a time" rule (D4).
5. **What has to stay true for iCloud to help rather than hurt** (§3): it's a quiet **backup**, never a sync between
   devices. It only counts once it's read back and checked. It never nags. It says so plainly when iCloud is full. The
   branch already builds these (D4, Current Work 75–76).

---

## 1. What happens with data that lives only on the phone

| What people say | App Store | Play Store | Total | Mean ★ |
|---|---|---|---|---|
| **Lost everything: the data was only on the phone** | 194 (29 apps) | 145 (24 apps) | **339** | 2.76 / 2.80 |
| …after the app crashed and had to be reinstalled | 68 | 42 | 110 | 2.22 / 1.93 |
| …after a new, lost, broken or reset phone | 45 | 71 | 116 | 3.27 / 3.07 |
| …after deleting or offloading the app | 31 | 13 | 44 | 2.97 / 3.62 |
| Worried they would lose it (no loss yet) | 54 | 65 | **119** | 3.43 / 3.80 |

*Third-party apps, all 2,505 matches read. A review can carry more than one code. About 50 App Store loss stories
don't say what caused the loss.*

- **Users show:** "Literally every app I have backs up to my iCloud - daily and seamlessly." (Finch, 1★, `13192704866`,
  a psychologist who lost months); "Every other app I use allows its data to be backed up automatically via iCloud."
  (Days Since, 1★, `9112628469`); "This is literally the only app (out of 114 on my phone) that neither has automatic
  periodic backups nor iCloud sync support." (Way of Life, 3★, `1798965025`); "No Cloud Backup — Entire Year of Data
  Gone" (Loop, 2★, `16cc8d9e-2ba1-4d55-bcec-df0d9e5ec8ee`).
- **One app is a large share:** **Finch** accounts for **81** of the 194 App Store losses. It keeps data on the phone
  unless the person makes a manual backup ("if you don't backup your data either on the cloud or your device (it does
  not automatically do it) and accidentally delete the app, you will lose your finch", 5★, `12382308793`). Without
  Finch there are still **113** App Store losses from 28 apps, and Play has its own clusters (Tasks 30, Fabulous 28,
  Loop 27).
- **The iPhone's own backup doesn't cover it.** Deleting an app deletes its data, and the iPhone backup comes back
  only when the whole phone is restored (platform fact, from [Free Plan Data Protection](<Free Plan Data Protection — Backup Without Giving Away Plus.md>)).
  People say so: "I do back up my phone. My data was gone when I restored the backup to my new phone." (`9112628469`).
  Even Apple's own Notes loses notes kept "On My iPhone" (14 of 19 local-loss stories in the big-company sample, 1.84★):
  "NEVER store your notes on places OTHER THAN your iCloud account." (Notes, 1★, `11798328593`).
- **How it's trending:** loss-only-on-the-phone stories grow with the corpus: 2–16 a year before 2020, then 34–53 a
  year from 2020 to 2025 (2026 is a part year).

## 2. Accounts: wanted as a way back, disliked when required, and they fail too

| What people say | App Store | Play Store | Mean ★ |
|---|---|---|---|
| **Praise "no account / no sign-up"** | 54 (27 apps) | 119 (23 apps) | **4.89 / 4.82** |
| **Dislike being made to create an account** | 24 | 72 | **1.42 / 1.61** |
| Want an account or a login so data can come back | 74 | 75 | 3.53 / 3.13 |
| **Lost data even though they had an account** | 60 | 119 | **1.97 / 1.66** |

- **Users show:** "I love that I do not need to create an account to use it" (Loop, 5★, `725d4706-…`); "i should have
  the option to simply keep the app local on my device" (Strides, 3★, `1196440570`, after sign-in became required).
  The earlier accounts study found the same split: forced sign-up 1.35★ against "no account needed" 4.89★
  ([Architecture 01](<../../../Architecture/01. Accounts and Identity.md>)).
- **The people who ask for an account mostly have no automatic backup.** 149 want a login, most in apps that keep data
  on the phone (Loop 24, Finch 17, Me+ 15, HabitNow 10) or whose iCloud backup failed them. They want *any* way back. An automatic iCloud copy answers them without an
  account. Some explicitly prefer that: "I don't get why developers should avoid implementing iCloud sync and push for
  extra account." (Habitify, 4★, `1934322613`); "Why must I create another online account that can get hacked,
  instead of using the Google drive I already have?" (everyday Habit Tracker, 3★, `4ccc8f63-…`).
- **Accounts are not a guarantee.** 179 lost data with an account: a sign-in that broke, "sync" that never ran
  (HabitBull: "There is a sync option in the app", 1★, `aa636cda-…`), or a new phone that didn't recognise them
  (Fabulous, Finch, My Study Life).

## 3. iCloud: liked when it quietly works, punished when it promises and fails

*App Store only (iCloud is an Apple service).*

| What people say about iCloud | Reviews | Mean ★ | Apps |
|---|---|---|---|
| **Ask for iCloud backup or sync** | 269 | 3.83 | 37 |
| …to use more devices (iPad, Mac, Watch) | 106 | | |
| …to protect against loss | 53 | | |
| **Praise iCloud** | 71 | 4.87 | 20 |
| …and that no account is needed | 13 of them | 5.00 | |
| **iCloud sync or backup failed** | 212 | 2.85 | 19 |
| **Lost data even with iCloud on** | 93 | **1.91** | 13 |
| Dislike iCloud or prefer something else | 42 | 3.60 | 14 |

- **Users show (praise):** "I love that the free version allows iCloud sync (unlike some of the other leading habit
  trackers) No account necessary and I don't have to worry about my logs when I eventually upgrade my phone"
  (Productive, 5★, `6085545766`); "requires no account—your data is stored securely in iCloud" (Awesome Habits, 5★,
  `13278332346`).
- **The failures are mostly *sync between devices*, not a backup copy.** They cluster in three apps that sync live through iCloud: Productive (64), Streaks (41) and Habit Tracker (36). One reviewer
  puts it bluntly: "iCloud sync is deplorable on every app where it's used, including Apple's own apps" (Streaks, 2★,
  `13491181225`). Our design doesn't sync through iCloud at all. It writes one copy per device, read back and checked,
  restored only on purpose (Free Plan Backups §2; D4).
- **A promise that fails is the worst outcome:** "lost data even with iCloud on" averages **1.91★**, worse than having
  no backup (2.78★). "Changed devices and lost months worth of data, even though I had iCloud sync enabled"
  (Productive, 2★, `6132261207`). So the copy must be checked, its status must be honest ("Backed up today 09:14 ·
  iCloud", or what's wrong), and Restore must name the device and day (the branch builds all three).
- **Why some dislike iCloud (43, hand sub-coded):** iCloud is full or costs money (15); the app keeps asking to turn
  iCloud on (7); they want the app's own account, for Android or WeChat or trust (11); privacy (5); they don't use
  iCloud (5). Most are from two apps (ShineDay 13, Habit Tracker 10) and from China, where a phone-number or WeChat login
  is the norm: "An email login should be a non negotiable" (Habit Tracker, 5★, `13369066030`); "不然icloud没有空间做不到多设备同步"
  (no iCloud space, so no multi-device sync; `9660134870`). **Design rules from this:** never nag, say plainly when
  iCloud is full, and keep the account as the other way.

## 4. How the big companies do it

*From the sample of their own apps (363 of 3,485 matches read; sample, not a full read).*

| What people say | Reviews | Mean ★ | Mostly |
|---|---|---|---|
| Dislike a required account | 59 | 1.58 | Microsoft To Do (45) |
| Account failed, lost access or data | 29 | 1.10 | Microsoft To Do (22) |
| Cloud copy failed or lost data | 60 | 1.54–1.83 | Apple Notes, Reminders, Calendar |
| Lost data kept only on the device | 19 | 1.84 | Apple Notes "On My iPhone" (14) |

- **Platform fact:** Apple's apps live in iCloud, Google's in the Google account, Microsoft's in a Microsoft account.
  None of them keeps data only on the phone. When they do (Apple Notes "On My iPhone"), losing it is the angriest kind
  of review in the sample.
- **Users show:** Microsoft's mandatory account is the most disliked account in the corpus ("I didn't even get to try the
  app as I was required to sign in with a microsoft account before anything else", 1★, `5006286204`), and forcing it
  later lost people's data ("I lost ALL my lists without any notice whatsoever of this app update", 1★, `10029231730`).
- **First principles:** a small app can't be "the account people already have". Their Apple ID *is* that account on
  an iPhone. Backing up to it quietly is the closest a small app can come to how Apple's own apps behave, and it
  needs no new account.

## 5. Google Drive

- **iPhone:** 13 App Store reviews mention Google Drive at all (3.85★), mostly as an export target. Nobody on iPhone
  asks for Drive as their backup place in a way that iCloud wouldn't answer.
- **Android:** 195 Play reviews ask for automatic cloud backup (4.15★); 158 of them name Google Drive (4.27★; Loop 86, Tasks 27): "please consider
  adding automatic daily backups to Google Drive, like Truecaller and WhatsApp" (Loop, 5★, `3a240b2b-…`). On Android
  the system's own Auto Backup also restores app data after a reinstall (platform fact, from
  [Free Plan Data Protection](<Free Plan Data Protection — Backup Without Giving Away Plus.md>)).
- **So:** Google Drive belongs to the Android app, as its no-account place. On iPhone it adds a choice nobody asked
  for, plus a Google sign-in and a consent screen to maintain. Keep it hidden on iPhone (it's behind a feature flag
  today), or take the row out entirely.

## 6. Recommendation

| Who | Where their habits are kept safe | What changes from the branch |
|---|---|---|
| **iPhone or iPad, no account** | **Their own iCloud, automatically**, backed up as they go; per-device copies, 7 days, never syncing; status shown, never nagging | Nothing. Google Drive stays off on iPhone (flag), or its code and row come out |
| **Android, no account** (future app) | **Google Drive** (app data folder) plus Android's own Auto Backup | Build when the Android app is built |
| **Free account** | **The account**, backed up as they go; one device | Nothing |
| **Plus** | The account; sync across devices; any of the last 90 days | Nothing |
| **iCloud off or full, no account** | Only on this device, **said plainly** on Backup & Export with the two ways out: turn on iCloud, or make a free account | Already shown; keep the words honest |

**Why not device-only without an account:**
- **Users show:** device-only loss is the biggest theme in this study (339 stories, 2.78★), and the people it hits
  are exactly those who never make an account.
- **Platform fact:** the iPhone doesn't bring an app's data back after a reinstall unless the whole phone is restored.
- **First principles:** it would also break rule D4 ("backup is automatic, on by default, free") and the user's own
  rule of 1 Oct: without an account nothing goes to *our* server. iCloud keeps that rule, because the copy is in the
  person's own iCloud, not ours, and it costs us nothing (Free Plan Backups §5).

**Why not iCloud *and* Google Drive on iPhone:** two places is a choice nobody asked for. Only 2 of 110
backup-request reviews asked to *choose* where it goes ([One Seamless Experience](<Backup, Sync and Accounts — One Seamless Experience.md>) §2),
and it's one more sign-in and consent screen that can break.

**If the user still prefers device-only:** the minimum to avoid the stories in §1 would be (1) a clear, permanent
line on Today's first week and on Backup & Export ("Your habits are only on this iPhone. Deleting the app deletes
them."), (2) a backup file offered before every risky moment (an app update, a "reinstall" support answer, a new
phone), and (3) the free account offered as the way to be safe. The reviews suggest this still loses the people who
never act on it: Finch offers a manual backup file and an optional account, and has 81 of the 194 App Store loss
stories, many saying they were never told ("the app never tells you that there’s no backup", Finch, 1★, `14243659017`).

## 7. Limits of this study

- Reviews skew to problems; people whose backup quietly worked rarely write about it (71 iCloud praise reviews against
  212 failures says more about what people write than about how often iCloud fails).
- The big-company apps are a sample (363 of 3,485), not a full read. The Google Drive matches there are mostly Google
  Sheets and say little about backup.
- Patterns are mostly English and Chinese keywords, so other languages are under-counted.
- Finch is a large share of App Store device-only losses (81 of 194). The table gives the total without it.
