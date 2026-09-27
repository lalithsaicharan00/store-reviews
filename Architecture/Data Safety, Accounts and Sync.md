# Data Safety, Accounts and Sync

*Written by Claude, 26 Sep 2026. A proposal: nothing here is built yet.*

*Updated 27 Sep 2026:*
- *Free is one phone and 5 habits, local-only, with no account.*
- *Plus (lifetime) adds every device, sync and server backup through an account created right after purchase (Apple or Google).*
- *No copies in iCloud or Google Drive, and no email sign-in. One email ever: the purchase confirmation.*

*See [01](<01. Accounts and Identity.md>), [02 §3.1](<02. Billing and Entitlements.md>) and [03](<03. Backup and Restore.md>).*

**Goal:** a habit, a check-in or a streak is never lost. That holds through an app update, a reinstall, a new
phone, or a switch from iPhone to Android (and later to web or Windows). The app stays offline-first, and we
avoid running costs.

**In one line:** each device keeps a real database of its own. A small sync service on Cloudflare's free tier
holds one copy per account. Five independent safety nets sit underneath, so no single failure can wipe anyone.

---

## 1. Why this comes first: what the reviews say

| Evidence (Feature Ledger) | What it means for us |
|---|---|
| **C034 Data must never be lost**: Certain, 55 apps. ×10.6 over-represented among people who paid. The #2 cause of 1★ in report 2 (23.4%). | It is the one defect that turns paying users into refund requests. |
| Report 20: update 1.41.0 erased 2–5 years of history, and 78% of reviews in the following seven weeks were about it. | A single bad update can kill an app. We need a way to stop a rollout and to restore data. |
| **C035 Account system from day one**: Certain, 29 apps. With no account, a new phone means lost data *and* a lost purchase. Report 20: "no signup" was praised, and it was also the root cause of the data loss. | Accounts must exist from launch, but **signing up stays optional**. |
| **C030 Sync must work, and prove it**: sync failures are ×12.8 among buyers. Report 27: sync that works but can't be seen still causes fear of data loss. | Sync status has to be visible ("Backed up 2 min ago"). |
| **C020 Export / backup**: the #1 request by volume, from happy users. Charging for it produces requests, not revenue. | Export and import are free. |
| R02-054: "date off by one", 2.71% of reviews. | Store the user's calendar day ("2026-09-26"), not only a UTC timestamp. |

---

## 2. The options, compared

| Option | Works across iPhone ⇄ Android ⇄ web? | Running cost | Gives us accounts? | Verdict |
|---|---|---|---|---|
| **iCloud** (CloudKit / iCloud Drive) | ❌ Apple only | $0, uses the user's iCloud storage | Apple ID only | **Not used** (decided 27 Sep 2026): no sync and no backup copies of ours |
| **Google Drive hidden app folder** (`drive.appdata`) | ⚠️ iOS, Android and web, but only for people with a Google account | $0, uses the user's Drive storage | Google only | **Not used** (decided 27 Sep 2026) |
| **Android Auto Backup** | Android → Android only | $0: 25 MB, and doesn't count toward the user's quota | – | **Turn on**: a free safety net |
| **iPhone backup / Quick Start** | iPhone → iPhone only | $0 | – | **Automatic** if the database sits in the right folder |
| **Firebase** (Firestore + Auth) | ✅ | $0 up to 20k writes/day (about 2,000 daily users at ~10 check-ins each). After that, pay-as-you-go **with no hard spending cap** | ✅ | Workable, but a poor fit: offline storage is a cache, conflicts are resolved per whole document, lock-in, and the risk of a surprise bill |
| **Supabase** | ✅ | Free projects **pause after a week without activity**; Pro is $25/month | ✅ | No |
| **Hosted sync engines** (PowerSync, formerly Realm Sync, …) | ✅ | Paid tiers | varies | No: MongoDB shut down Realm Device Sync in Sept 2025, and apps built on it had to rewrite |
| **Cloudflare Workers + Durable Objects (SQLite)**, built by us | ✅ every platform, including web and Windows later | **$0** up to about 10–12k daily active users. Then **$5/month**, rising to about **$30/month at 100k daily users** (see 3.4) | ✅ we verify Apple, Google and email ourselves | **Recommended** |

**Why the user's own cloud can't be the main answer.** iCloud and Google Drive can't see each other. An iPhone
user who moves to Android has data sitting in iCloud, and the Android app can't reach it. Anything
cross-platform needs one neutral place in the middle. Decided 27 Sep 2026: we don't build on the user's cloud at
all. The group that asks for it is small and rarely pays ([evidence](<../Research/Research Reports/Business Model and Monetization/Plus Scope and Account at Purchase.md>)).

**Cloudflare free tier, checked on 26 Sep 2026:**
- Workers: 100k requests/day.
- Durable Objects: 100k requests/day, 5M rows read/day, 100k rows written/day, 5 GB stored in total.
- Paid plan: $5/month, which includes 10M requests/month and 50M rows written/month.
- Durable Object storage has **30-day point-in-time recovery** built in.

**Other costs that can't be avoided:**
- Apple Developer: $99/year (already needed).
- A domain: about $10/year. Needed for the Sign in with Apple web flow and for the purchase email.

---

## 3. The architecture

```
 iPhone (SwiftUI)                 Android (Compose)               Web / Windows (later)
 ┌────────────────────┐           ┌────────────────────┐          ┌──────────────────┐
 │ SQLite (GRDB)      │           │ SQLite (Room)      │          │ SQLite (wasm/    │
 │  • tables = truth  │           │  • tables = truth  │          │  OPFS)           │
 │  • outbox of edits │           │  • outbox of edits │          │                  │
 │  • daily snapshots │           │  • daily snapshots │          │                  │
 └─────────┬──────────┘           └─────────┬──────────┘          └────────┬─────────┘
           │  push outbox / pull changes since cursor  (HTTPS, only when online)
           └──────────────────────────────┬─────────────────────────────────┘
                                          ▼
                     Cloudflare Worker: sign-in, token check, routing
                                          │
                                          ▼
                 One Durable Object per account = its own SQLite database
                   • change log with a sequence number  • current state
                   • devices                            • 30-day point-in-time recovery
                                          │ nightly
                                          ▼
                     R2: a dated snapshot of every account changed that day
```

### 3.1 On the device: the phone is the source of truth
- **Real SQLite**: GRDB on iOS, Room on Android. Not a cache. The app never waits on the network.
- **IDs are created on the device** (UUIDv7). This avoids clashes between devices and never uses auto-increment.
- **Every row carries** `updated_at` (a hybrid logical clock), `updated_by` (the device ID) and `deleted` (soft delete).
- **Every edit, in the same transaction, also writes a row to an `outbox`.** Either both happen or neither does, so sync can never miss a change.
- **Check-ins are stored by calendar day plus time zone**, e.g. `2026-09-26` plus `Asia/Kolkata`. Travel and daylight saving can't shift them to another day.
- **Deleting is reversible**: deleted habits go to "Recently deleted" for 30 days.

### 3.2 Sync protocol: what gets sent, and when

**Cloudflare is not only a backup.** It is the meeting point that carries changes between a user's devices. It
also keeps a server copy of each account.

**One call**, `POST /sync`: the device sends everything in its outbox and gets back every change from other
devices since its last sequence number. It is one round trip.

**When the app calls it:**

| Moment | What happens |
|---|---|
| The user ticks a habit | It is saved to the phone **instantly**; this is the real save, and it works offline. A sync is scheduled for **3 seconds after the last tap**, so ticking five habits in a row becomes one request, and a quick tick-untick cancels out |
| The app goes to the background | Sync immediately (iOS allows ~30 s of background time) |
| The app opens | Sync, to pull in changes made on other devices |
| No network | Nothing is lost. The outbox waits, and the app retries with growing gaps once the network is back |
| During the day | An occasional background sync (iOS background refresh, Android WorkManager) so widgets and the Watch see other devices' changes |

**Why sending in batches is just as safe:**
1. The tap is written to the phone's database and outbox in one transaction.
2. The batch arrives at the server, which stores **the whole batch in one transaction**: all of it or none of
   it. Then it replies "stored as #1043".
3. **Only after that reply** does the phone mark those changes as sent. If the connection drops at any point,
   nothing is marked and the whole batch is resent later.
4. If the server stored the batch but its reply was lost, the resend carries the same change IDs. The server
   recognises them, ignores the duplicate and answers "#1043" again.

**The only gap:** a phone destroyed while offline, *before* its latest changes reached the server. Syncing within
seconds whenever the phone is online keeps that gap as small as it can be.

**Conflict rules:**
- **Habit settings:** per-field last-writer-wins. Two devices editing different fields both keep their changes.
- **Check-ins:** keyed by (habit, day). The latest edit wins.
- **Deletes are tombstones**, so a deleted habit can't come back when an old device syncs.

**Older app versions:** they send *field-level changes*, never whole rows. A phone that hasn't updated can't
blank out a field it doesn't know about. The server keeps accepting old payload versions for at least a year.

**How the server stores it cheaply:**
- Each batch is stored as **one row** in the account's change log (numbered by sequence, with no extra indexes).
  Cloudflare charges per row written, and each extra index costs another row.
- The device keeps track of its own sequence number, so a sync that sends nothing writes nothing.
- About once a week, the log is folded into one compressed snapshot row.
- A year of one active user's data is about 100–300 KB.

### 3.3 On the server
- **One Durable Object per account.** Each account's writes happen one at a time, so there are no race
  conditions between a phone and a tablet syncing at the same moment.
- **Deleting an account** means deleting one object.
- **Exporting an account** means dumping one database.
- **Two independent server copies:**
  - Durable Object point-in-time recovery, going back 30 days;
  - a nightly snapshot to R2, which also protects against a bug in our own sync code.
- **Encryption:** Cloudflare encrypts data at rest. **No end-to-end encryption in v1**, because with end-to-end
  encryption a forgotten key means permanently lost data, which works against the goal. It can come later as
  an opt-in.

### 3.4 Capacity and cost

**Daily active users vs accounts.** The free-tier limits (requests per day, rows written per day) only count
people **who open the app that day**. An account that hasn't been opened costs nothing except its stored data,
and people who never sign in cost nothing at all. As a rough guide, habit apps have far fewer daily users than
accounts. My estimate is 10–25% of accounts on a given day; our own analytics will give the real figure.

**Planning numbers per daily active user:**
- **Habits:** median 5–6 (report 46), so about 10 changes a day, counting steps and undos.
- **Syncs:** about 8 a day (opens, backgrounding, background refresh), all small. About 5 of them carry changes.
- **Rows written:** about 5 a day, one per sync that carries changes, plus compaction.

**Free plan:** whichever limit is hit first sets the ceiling.

| Limit | Per day | Use per daily user | Ceiling |
|---|---|---|---|
| Worker requests | 100k | ~8 | **~12k daily users** ← the one we hit first |
| Durable Object requests | 100k | ~8 | ~12k |
| Rows written | 100k | ~5 | ~20k |
| Compute time | 13,000 GB-s | ~0.02 GB-s (≈20 ms per sync; no charge while idle) | ~600k |
| Storage | 5 GB total | ~0.2 MB per account per year | ~25k account-years (**total accounts**, not daily users) |

**Paid plan** ($5/month base; nothing stops working at the limits, extra use is billed):

| Daily active users | Accounts (rough) | Monthly cost |
|---|---|---|
| 10k | 50k | ~$6 |
| 30k | 150k | ~$11 |
| 100k | 400k | ~$30 (requests ~$8, storage ~$16) |

**Sign-in has no per-user limit and no fee.** Cloudflare doesn't sell user logins, so we write that part
ourselves, and there is no monthly-active-user cap like Firebase's.
- **The Worker checks the Apple or Google sign-in token** and issues our own session token.
- **Every sync checks that token,** which takes under 1 ms of the 10 ms free CPU budget.
- **The provider ID → account table** lives in D1 and is written only at sign-up.
- **The one email** (the purchase confirmation) goes through Resend's free tier, so the Worker stays on the free plan. See [Email Delivery Decision](<Email Delivery Decision.md>).

**Launch on the free plan; upgrade when usage calls for it** (decided 26 Sep 2026):
- **Sign-in at launch: Apple + Google** (decided 27 Sep 2026; email codes removed). Accounts exist only for Plus.
- **If a daily limit is hit, sync pauses until the next day.** No data is lost, because phones keep their
  outbox. The app shows "Backup delayed", not an error.
- **A Cloudflare rate-limiting rule sits in front of the Worker,** so blocked requests never count against the
  100k. The Worker also limits syncs per device.
- **A daily scheduled Worker (cron) counts yesterday's sync requests** and emails us.
- **Upgrade trigger:** requests pass **50k/day** (about 6k daily users), or another backend limit requires it. Upgrading
  takes a minute and needs no code change or data move.

---

## 4. Accounts

*The full design, including evidence and platform rules, is in [01. Accounts and Identity.md](<01. Accounts and Identity.md>).*

- **Accounts are for Plus only** (decided 27 Sep 2026). The free app has no sign-in at all.
  - **The purchase flow ends with "One last step: turn on sync and backup":** **Continue with Apple**, **Continue with Google**, and a visible "Not now: use Plus on this device only" (Apple 5.1.1(v)).
  - **There are no sign-in nudges.** After "Not now", only the features ask: a tablet or second device, and Settings → Backup.
- **Sign-in methods:**
  - **Apple:** required by App Store guideline 4.8 once Google sign-in is offered. It also works on Android and
    web through Apple's web flow, so an iPhone user who moves to Android can still sign in.
  - **Google:** on every platform.
  - **No email sign-in and no passwords.** Every buyer has an Apple ID or a Google account.
- **An account has our own UUID.** Linked Apple and Google provider IDs open that account. Matching emails never silently merge accounts. Apple relay addresses are supported.
- **First sign-in when the account already has data** (for example, a second phone):
  - the app asks whether to merge, keep the account's data, or keep this phone's data;
  - whatever is set aside is saved as a snapshot, so nothing is thrown away.
- **Deleting an account** (required by Apple 5.1.1(v) and by Google Play):
  - one step, inside the app, with an offer to export first;
  - it also removes the R2 snapshots;
  - Play also needs a web link for deletion.
- **Moving phones** (topic 4): the phone's own transfer on the same platform; Plus users sign in; free users moving
  iPhone ⇄ Android export a file and import it. No QR phone-to-phone move (decided 28 Sep 2026).
- **Purchases are tied to the account**, so a paid plan follows the user to a new phone or platform. This
  addresses the lost-purchase complaints in C035.

---

## 5. The five safety nets

Any one of these can fail, and the data still survives.

| # | Net | Covers | Cost |
|---|---|---|---|
| 1 | **Safe local database:** transactions, WAL mode, stored in Application Support (iOS) or app files (Android), never in caches | crashes, the app being killed mid-write | $0 |
| 2 | **Local snapshots:** 7 daily + 4 weekly copies of the database, and a copy taken **before every schema migration** | a bad update or migration, accidental deletes | $0 |
| 3 | **Operating-system backup:** iCloud device backup / Quick Start on iPhone; Auto Backup (25 MB) and device transfer on Android | same-platform phone switch **without an account** (the free user's main net) | $0 |
| 4 | **Export and import:** a readable JSON file plus CSV; either app can import the other's file | cross-platform move without an account; the user owns a copy | $0 |
| 5 | **Account sync:** the server copy, 30-day point-in-time recovery and nightly R2 snapshots | any device, any platform, including web and Windows later | $0 → $5–30/month |

**Settings → Backup & sync** shows:
- when the data was last backed up;
- the list of snapshots, with "Restore to this point";
- export and import.

This is the "prove it" part of C030.

---

## 6. Rules that prevent the Report 20 disaster

- **The app never resets the database when a migration fails.**
  - Room's `fallbackToDestructiveMigration` is **banned**, and so are SwiftData or Core Data automatic resets.
  - If a migration fails, the app rolls back, keeps the old data, shows a message and reports the error.
- **Schema changes only add.** No renames or drops in a release. Old columns are removed only after two
  releases, once they are empty.
- **Migration tests** run on a saved database file from **every shipped version**, on every build.
- **A convergence test** simulates 3 devices making random offline edits and syncing in random order, and checks
  they all end up with the same data.
- **A data-loss canary** compares the habit and check-in counts before and after each migration and each sync.
  If a count drops sharply, the app logs `data_drop_detected` to PostHog, keeps the snapshot and stops syncing
  for that account.
- **Staged releases:**
  - App Store phased release and Play staged rollout, so a bad update can be halted at 1–5% of users;
  - the server can refuse sync from a specific broken app version.

---

## 7. If Cloudflare changes or disappears

**How likely it is** (my judgement, not a guarantee):

| Risk | Likelihood over ~5 years | Impact on us |
|---|---|---|
| Workers or Durable Objects shut down | Very low. Workers is a core product: they run their own platform on it, and have built on it since 2017. Past deprecations (Workers Sites, Pages folding into Workers) came with long notice and a migration path | Sync paused until we move. No data lost |
| Prices or free-tier limits change | Likely at some point (Durable Object storage billing started Jan 2026) | A few dollars a month |
| Our account suspended by mistake | Low | Sync paused until we move. No data lost |

**Why it can't cost users their data:**
- **The phone is the source of truth.** Cloudflare only holds a copy and relays changes. If it vanished overnight,
  every phone still has all its data and keeps working offline.
- **The sync API runs on our own domain** (`api.<ourapp>.com`), never a Cloudflare URL. Moving providers is a DNS
  change, not an app update.
- **The protocol is ours.** It is two plain HTTPS endpoints (push and pull). All Cloudflare-specific code stays in
  one thin storage layer.
- **The data is plain SQLite,** so it can be moved to Postgres or SQLite anywhere.
- **Exit plan:** keep a short, tested script that runs the same push/pull API on a plain server (Node or Bun
  with SQLite). Cloudflare's runtime, `workerd`, is also open source.
- **Recovery after a move:** point the domain at the new server. Phones re-upload anything the server is
  missing, because their outboxes and cursors handle this automatically.

**Worst case:** a few days without sync while we move. No habits are lost.

## 8. Build order

1. **Data model and local database** on iOS: tables, outbox, snapshots, export/import (nets 1, 2 and 4).
2. **Sync service:** a Worker plus one Durable Object per account, with push/pull and the convergence test.
3. **Accounts:** Apple and Google (Plus only); merge on first sign-in; account deletion.
4. **Nightly R2 snapshots and the data-loss canary.**
5. **Android** uses the same schema and protocol. The schema lives in one shared folder, and both apps are tested
   against it.

## 8a. Rules added from the review research

The full failure catalogue, with review evidence and the Apple and Google rules, is in
[`Research/Research Reports/Data, Sync and Accounts/Data Safety — Every Way Users Lose Data, and the Rules That Prevent It.md`](<../Research/Research Reports/Data, Sync and Accounts/Data Safety — Every Way Users Lose Data, and the Rules That Prevent It.md>).
It adds these requirements to the design above:

1. **Crash-loop recovery:** after 2 failed launches, open a recovery screen (export, backup status, support). Support never tells a user to reinstall.
2. **"I've used this before"** is offered on a fresh install *before* onboarding: sign in (Plus) or import a file.
3. **Signing in never deletes local data.** Show which account it is before merging; warn when a sign-in creates a brand-new account; signing out asks whether to keep a local copy.
4. **Schedules and goals have effective dates.** Streaks are always *computed* from records, never stored as a counter.
5. **Undo** for every destructive action, **Recently deleted** for 30 days, and **Archive** instead of delete.
6. **Data is never held hostage:** backup, restore, export and sync are free forever, and an ended subscription never hides data.
7. **Export uses local calendar dates,** every export can be imported back on either platform, and there is CSV import from rival apps.
8. **A backup counts only when the server confirms it.** CI runs backup → wipe → restore → compare on every build.
9. **Ticking a habit on one device cancels its pending reminder on the others.**
10. **The widget database uses "complete until first unlock" file protection,** and widgets refresh at the user's day boundary.
11. **Store billing only.** Account deletion shows the subscription status and links to the store to cancel.
12. **Entitlements are restored automatically on launch.** Play purchases are acknowledged at once (Google refunds after 3 days). "Lifetime" is stored on the server and kept forever.
13. **The device ID, sync cursor and session tokens stay out of OS backups** (`no_backup` on Android, excluded on iOS). After an OS restore, the app does a full sync.
14. **Performance budget:** 10 years × 50 habits of data, ticking under 100 ms.
15. **Incidents** are communicated in the app (a banner from `/v1/status`).

## 9. Open decisions

- **Shared code:** *decided 26 Sep 2026:* one Kotlin Multiplatform domain core, native platform UIs, written behavior specifications and shared fixtures. Merge rules live in the core; transport, storage and transactions remain adapters. This does not select SQLDelight or require sharing every part of the sync client. See [Shared Core Decision](<Shared Core Decision.md>).
- **Purchases:** *decided 26 Sep 2026:* native StoreKit 2 and Play Billing, verified and recorded by our own Worker
  for cross-platform use; no RevenueCat. See [02 Billing §3.11](<02. Billing and Entitlements.md>).
- **Where the sign-in step goes:** *decided 27 Sep 2026:* not in onboarding. It is the last step of the Plus purchase flow, with a skip link. See [02 §3.2](<02. Billing and Entitlements.md>).
