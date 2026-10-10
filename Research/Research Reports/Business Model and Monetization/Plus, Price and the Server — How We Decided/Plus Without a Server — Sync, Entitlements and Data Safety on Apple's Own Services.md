# Plus Without a Server — Sync, Entitlements and Data Safety on Apple's Own Services

Written by Claude (Claude Code), 10 October 2026, for Current Work 80. The user, the same day: a one-time Plus and a
server we must run and pay for over many years keep bringing us back to square one. Can we have **no server at all**,
so that what's left of each sale after the store, tax and refunds is profit, with no long-term obligation? Without
losing what made us choose a server: **entitlements** (Plus must never be lost) and **no data loss**. Still think of
every user as extreme, assume we don't know whether the app will succeed, and never take away anything people once
had. What sync do people actually want: across which devices? Are iCloud and Google Drive usable as a sync engine?
And without sync, would people still buy?

**Status: a proposal for the user to decide.** It would replace decided rules (accounts, server sync, Plus Family by
invite, moving with a code). Nothing has been released, so nothing would be taken from anyone.

**Evidence.** Fresh scans of all 1,487,223 reviews (scripts and codes in [`Research/Temp/no-server/`](../../../Temp/no-server)):
a machine inventory of reviews that mention sync and name a device (English wording only, so a floor, not a total),
with the cross-platform reviews read by hand; and all 96 reviews naming iCloud with a loss or failure, **read by hand**.
Earlier studies' counts are quoted, not recounted. Apple's documentation for CloudKit, StoreKit and Family Sharing.

## 1. The answer

**Yes, for Apple devices: iPhone, iPad, Apple Watch and later the Mac can have sync, backup and Plus with no server of
ours, at no cost to us per user, for ever.** Apple provides all three:

| What the server was for | Without a server | Cost to us |
|---|---|---|
| **Sync across devices** | **CloudKit's private database with `CKSyncEngine`**: Apple's own sync engine, not a file in iCloud Drive | $0: the data counts toward the person's iCloud storage, not ours |
| **Off-device copy (no data loss)** | The same CloudKit copy, kept as you go, **plus** a daily backup file in iCloud Drive (as today, D4) | $0 |
| **Entitlements (Plus never lost)** | **StoreKit 2**: Plus on every device signed in to the same Apple Account, checked on the device, offline, no login | $0 |
| **Plus Family** | **Apple's Family Sharing**, turned on for a separate Plus Family product | $0 |

**What a sale leaves us is then profit,** less support: about **$17 of a $24.99 sale (92%)** at Apple's 15%, about
$13.77 (90%) at 30%. The extreme user costs us nothing more in year 15 than in year 1.

**What it can't do,** and so must never be promised: sync between an iPhone and an Android phone, a web version,
Windows, and one purchase across the App Store and Google Play. Those need a server (§6). Users show these are much
smaller asks than Apple-device sync (§2).

**The user's worry, "iCloud and Google Drive are not made for sync", is right about files** (iCloud Drive, Google
Drive) **but not about CloudKit**, which is exactly a sync engine: Apple introduced `CKSyncEngine` in 2023 for apps
that sync their own data, and uses it in its own apps, including Freeform ([WWDC23 "Sync to iCloud with
CKSyncEngine"](https://developer.apple.com/videos/play/wwdc2023/10188/)). Android has no equivalent (§7).

## 2. What sync people want (users show)

Reviews that mention sync and name a device (a review can name several):

| Devices named | App Store | Google Play | Needs our server? |
|---|---|---|---|
| iPad | 535 | 27 | No (CloudKit) |
| Apple Watch | 347 | 55 | No (CloudKit, or the iPhone) |
| Mac | 203 | 17 | No (CloudKit) |
| Web, computer, Windows | 112 | 431 | **Yes** |
| An Android tablet | 21 | 136 | No for Android-only (Google Drive, §7); yes with an iPhone |
| **Android and iPhone/iPad together** | 11 | 39 | **Yes** |
| No device named (also Google Calendar or Health sync) | 1,145 | 3,017 | — |

- **On the App Store, Apple devices are the ask:** about 1,085 mentions of iPad, Watch and Mac against 144 for the
  web, computers and Android devices together. Payers cluster in iPad and multi-device use (Plus Scope §2), and "iPad sync
  failed" is the most payer-heavy complaint there (21 of 106 said they had paid).
- **Web and computer demand is mostly outside habit trackers:** the top apps are a to-do list (120), a school planner
  (111) and another to-do list (41); habit trackers follow with about 30 each (HabitNow, Loop, Habitica).
- **Cross-platform (50 read by hand):** mostly mixed households (an Android phone and an iPad) and people who
  switched phones and found the purchase didn't follow: "Bought the premium on my ipad and now i can't sync it with my
  android phone" (Productive, Play, 2★, `70fd52c0-e85f-4d48-8b3e-dac881b6f3c3`). Real, but small.

## 3. Can iCloud lose data? (users show)

**44 hand-read reviews (mean 1.98★)** describe iCloud sync or backup failing or losing data, almost all in four apps
(Productive 12, Streaks 9, Habit Tracker 8, Habit — Daily Tracker 6); 15 more ask for iCloud sync (3.40★).

- What went wrong is **the app's own sync logic, not iCloud losing files:** duplicates, habits coming back, one device
  overwriting another, "Changed devices and lost months worth of data, even though I had iCloud sync enabled"
  (Productive, 2★, `6132261207`); a new phone that synced an empty app over the old: "ALL DATA (months of history) were
  deleted from BOTH old and new device" (Awesome Habits, 1★, `12701004929`).
- **The same failures happen with servers:** 46 reviews of "paid, but the login my data hangs on failed", 1.96★
  ([Buying Plus §3](<../Buying Plus — Should an Account Be Required.md>)). The engine
  doesn't save an app; its rules do.
- **So our data-safety rules carry over unchanged:** the phone is the truth (D1); a sync never replaces records with
  fewer or none (D4's "never shrink"): with `CKSyncEngine` a delete is only ever sent for a record the person deleted,
  so an empty new phone deletes nothing; a fresh install waits for iCloud before saying "no backup" (D4,
  `ICloudLookup`); restore keeps an undo file (D5); the daily backup file is a second copy that sync can't touch.
- One review shows the person can delete the iCloud copy themselves (Settings › iCloud): "I deleted my backups in
  icloud … app just sync'ed to it and make my 3+ years record to null" (Streaks, 1★, `10325632518`). The phone's own
  data and the daily file must survive that, and the app should say what happened.

## 4. Entitlements without a server

- **StoreKit 2** checks Plus on the device from Apple's signed record (`Transaction.currentEntitlements`): every iPhone,
  iPad, Mac and Watch on the same Apple Account has Plus on first launch, offline, with nothing to sign in to.
  Restore Purchases stays (Apple 3.1.1). A refund removes it; nothing else can.
- **The worst purchase failure disappears:** "I paid but the login won't let me in" (46 reviews, 1.96★) can't happen
  without a login.
- **What's lost:** Plus on a device signed in to a *different* Apple Account, and Plus on Android (§7).
- **Plus Family = Apple's Family Sharing on its own product.** Family Sharing is turned on per product, so Plus (just
  you) keeps it off and Plus Family turns it on. Apple's family holds the organiser + 5, so **the family size becomes
  Apple's 6**, not our 5; with no server cost per person, that costs us nothing. The one known failure (a family plan
  people couldn't find how to share: 77 reviews, [Family Sharing — Backlog 1](<../Family Sharing — Backlog 1.md>))
  is answered by an in-app "Share Plus with your family" page that explains Apple's Family Sharing step by step.
- **Upgrading Plus to Plus Family:** a separate one-time product at the price difference, offered only to Plus owners
  (Billing 02 §3.1a already plans it).

## 5. The extreme user on CloudKit

- **Storage** is the person's iCloud, not ours. An extreme account adds about 25,000 records a year. Kept as one
  CloudKit record each (an estimate: about 1 KB with Apple's own fields), that's about 25 MB a year; **compacting
  every finished year into one compressed file** (about 89 bytes a record, as our snapshot measures) brings 15 years
  to roughly 55 MB. Small even on the free 5 GB plan, which many people have filled with photos.
- **When iCloud is full, off or signed out,** sync and the CloudKit copy pause; nothing on the phone is touched. The
  app says so plainly ("Not backed up: your iCloud is full") and keeps the backup file and export (D4: backup is
  visible). People without iCloud still have Export and the file.
- **Speed:** about 70 changes a day is nothing for CloudKit; `CKSyncEngine` batches, retries and handles Apple's
  throttling itself.

## 6. What only a server can give (and what that would mean)

| Without a server, not possible | Users show | If it's ever wanted |
|---|---|---|
| iPhone ⇄ Android sync, one purchase on both stores | ~50 reviews (English) | A server for those people only |
| Web, Windows | ~543 mentions, mostly to-do and school apps | A server |
| Moving from iPhone to Android with everything | The switchers above | **An export file** (Export → AirDrop / Files → Import) moves the data with no server; the purchase is bought again on Google Play |
| Friends, sharing a habit, accountability | Social requests (C-cards, small) | A server |

**Adding a server later is adding, never taking away.** Going from a server to none after release would take away;
starting without one and adding a clearly separate paid service later (if a market ever shows up) would not. That
makes **no server the safer first step** when we don't know whether the app will succeed.

## 7. Android later

- **Entitlements:** Google Play Billing gives the same "Plus on every device with this Google account", checked on the
  device. A separate purchase from the App Store's.
- **Sync and backup:** no CloudKit equivalent. Options, weakest to strongest: Android's own Auto Backup (capped at
  25 MB an app: too small for an extreme user's years); a backup file in the person's Google Drive (as today, D4);
  **sync through the app's hidden Google Drive folder** (`appDataFolder`, the person's storage), where each device
  writes its own change files and the shared core merges them. The last works because our sync already exchanges
  changes, not whole databases, but it's our own engine on a file store: more work and more risk than CloudKit.
  Android may launch with backup and the file, and sync later.

## 8. Would people still buy Plus?

Yes, with sync kept in Plus, because sync across Apple devices now costs us nothing:

- **Lifetime itself is the top reason people pay** (15.8% of self-declared payers name it, 3.7× the next reason) and
  multi-device / iPad is where payers cluster (Plus Scope §2–3).
- **Plus keeps:** unlimited habits, the iPad and Mac apps with sync, the Apple Watch app, and the extras already
  planned (themes, deeper Progress, Health auto-complete, Shortcuts).
- **Free keeps:** 5 habits, widgets, reminders, full history, and **automatic backup** (CloudKit and the daily file:
  free to us, so it stays free; data is never held hostage, D10). Moving some widget designs or customisation into
  Plus is possible (customising widgets is a top purchase trigger once a basic widget is free, report 03) but not
  needed for the sums.

**What a sale leaves us** (10% tax, 3% refunds, $1.50 support per sale, $3 for a family; no server):

| Price | Apple 15% | Apple 30% |
|---|---|---|
| $19.99 | $13.33 (90%) | $10.72 (88%) |
| **$24.99** | **$17.04 (92%)** | **$13.77 (90%)** |
| $29.99 | $20.75 (93%) | $16.83 (92%) |
| **Plus Family $59.99** | **$41.52 (93%)** | **$33.66 (92%)** |

With a server and every cost change, the same $24.99 kept 43% at Apple 30% in the pessimistic case, and less as
accounts age ([Price and Size from the Extreme Case](<Plus and Plus Family — Price and Size from the Extreme Case.md>) §4).
Fixed costs (the Apple Developer Program, a domain, a static support page) are about $150 a year, whatever happens.

## 9. What would change in the app (if the user chooses this)

| Today (decided) | No-server plan |
|---|---|
| Accounts (Apple / Google sign-in), free account sync on one device | **No accounts.** iCloud is the person's Apple Account; nothing to sign in to |
| Our server's sync (Cloudflare Durable Objects) | CloudKit private database with `CKSyncEngine` |
| Backup to the account, or iCloud / Google Drive without one (D4) | CloudKit copy as you go + the daily file in iCloud Drive (kept) |
| Plus recorded on the account and in StoreKit | StoreKit only |
| Plus Family: our invite codes, 5 people | Apple Family Sharing on a Plus Family product, Apple's 6 |
| Moving with a code through the server (D15) | Same Apple Account: everything arrives by iCloud. Another platform: an export file |
| Account deletion (D9) | "Delete iCloud data" in the app (the CloudKit zone) and the phone's own erase |

Rules that would need rewriting, with the user's say-so: D3, D4, D9, D12, D14, D15, U26's sync step, and the Plus
screens (Figma 1021:309). The server code, accounts and the Plus Family invite flow would be set aside, not deleted,
in case a separate service is ever added.

## 10. For the user to decide

1. **No server for launch (recommended):** Apple devices only, CloudKit sync and backup, StoreKit and Family Sharing;
   or keep the server with the cost changes and margins of the price report.
2. If no server: Plus Family becomes **6 people (Apple's number)** instead of 5.
3. If no server: Android launches with backup and the file first, sync through Google Drive later; and the
   listing never promises iPhone ⇄ Android sync or a web version.
4. The price stays as decided ($24.99, Family $59.99); the $19.99 floor was set for server costs and could be lowered
   for regional prices if the user wants.

## Sources

- Apple, [Sync to iCloud with CKSyncEngine (WWDC23)](https://developer.apple.com/videos/play/wwdc2023/10188/) and
  [CloudKit `CKContainer`](https://developer.apple.com/documentation/cloudkit/ckcontainer) (the private database
  counts toward the user's iCloud storage, not the app's).
- Apple, [Implementing offer codes in your app](https://developer.apple.com/documentation/storekit/implementing-offer-codes-in-your-app).
- Reviews: `Research/Temp/no-server/` (`sync_where.py` inventory, `icloud_codes.py` hand codes); quotes checked against
  those files.
