# Architecture

How the app works under the hood, on every platform: iPhone, Android, Watch, and later web, Windows and Mac.

**How we work:** one topic at a time. Each topic gets:
1. **Review evidence:** a fresh pass through the corpus for that topic, so nothing is missed.
2. **Production research:** Apple and Google rules, and how production systems do it.
3. **A design doc** in this folder.

The system diagram in Figma (page "App Architecture") comes **last**, once every topic below is settled.

**Product shape (decided 27 Sep 2026; updated 1 Oct 2026):** free is any one device (a phone or a tablet), 5 habits, no sync, with no account. Plus (one-time, lifetime) adds every device, Watch and sync. Accounts (Apple or Google) are optional for everyone since 1 Oct 2026: a free account backs up to our server but never syncs. Without an account nothing goes to our server; backup goes to the user's own iCloud or Google backup ([Backup, Sync and Accounts](<../Research/Research Reports/Data, Sync and Accounts/Backup, Sync and Accounts — One Seamless Experience.md>)). One email ever: the purchase confirmation.

**Starting point:** [Data Safety, Accounts and Sync.md](<Data Safety, Accounts and Sync.md>) is the overall proposal: local-first
SQLite, Cloudflare sync, and five safety nets. The topics below go deeper, one at a time.

## Topics, in order

| # | Topic | Why this order | Status |
|---|---|---|---|
| 1 | **Accounts and identity**: who gets an account (Plus buyers and family members), the sign-in step after purchase, Apple and Google keys, sessions, recovery, sign-out, deletion | Everything else hangs off *who the user is*. Billing links a purchase to an identity; migration moves an identity | [Done](<01. Accounts and Identity.md>) |
| 2 | **Billing and entitlements**: App Store and Play purchases, verifying and acknowledging them, linking premium to the account, restore, cross-platform, lifetime, family, refunds | The top paid-user 1★ cause (72% 1★) | [Done](<02. Billing and Entitlements.md>) |
| 3 | **Backup and restore**: on-device snapshots, the phone's own backups, export/import, restore; server backup for Plus | Every user, free or Plus | [Done](<03. Backup and Restore.md>) |
| 4 | **Phone migration**: same OS, iPhone ⇄ Android (account or export file), restore before onboarding | Third most common 1★ story | [Done](<04. Phone Migration.md>) |
| 5 | **Sync engine**: data model, outbox, conflicts, tombstones, schema versions, dates and time zones | The core protocol | [Done](<05. Sync Engine.md>) |
| 6 | **Server on Cloudflare**: Worker, Durable Objects, R2, recovery, limits, cost, exit plan | Mostly designed already; needs production detail | [Done](<06. Server on Cloudflare.md>) |
| 7 | **Other surfaces**: Watch (Apple, Wear OS), widgets, web, Windows and Mac | How each device talks to the data | [Done](<07. Other Surfaces.md>) |
| 8 | **Release safety and operations**: migrations, phased rollout, the data-loss canary, crash-loop recovery, support tools, incident communication | Stops the "update wiped everything" disaster | [Done](<08. Release Safety and Operations.md>) |
| 9 | **Privacy and account deletion**: what we store, deletion across stores and servers, legal | Store requirements | [Done](<09. Privacy and Account Deletion.md>) |
| 10 | **Figma system diagram** (page "App Architecture") | Draws 1–9 | Next: waiting for your go-ahead |
| 11 | **iCloud sync with CloudKit** (`CKSyncEngine`): replaces our server's sync and accounts on Apple devices (Rulebook D16); data layout, limits, failures, the free plan's one device, safety nets, tests | Decided 10 Oct 2026: no server holds habits | [Research done, ready to build](<11. iCloud Sync with CloudKit.md>) |
| 12 | **Apple Watch — data and sync**: a full copy on the Watch (same Room database and core), synced straight with the iPhone over WatchConnectivity and with iCloud after item 11; the iPhone passes on the Watch's changes; the timer-stop entry ID; what GitHub's simulator can and can't test | Decided 10 Oct 2026 (Current Work 82, step 4) | [Ready to build](<../iOS/Docs/Apple Watch/Data and Sync (Architecture 12).md>) |

## Related work

- **Server, sync and launch: start here:** [what's built and what's next](<Server, Sync and Launch — Status.md>) (branch `claude/server-and-sync`).

- **Parked decisions:** [Backlog.md](Backlog.md).

- **Cost and capacity, free vs Plus:** [Server Cost and Capacity — Free Safety Copy vs Plus Sync](<Server Cost and Capacity — Free Safety Copy vs Plus Sync.md>) — 1 Oct 2026, a plan: two lanes (free = Worker + R2, Plus = Durable Objects), prices, and checks for `claude/server-and-sync`.
- **App identity:** [Often Enough, oftenenough.com, and every bundle and product ID](<App Identity — Name, Domain and IDs.md>) — decided 1 Oct 2026. Set once, before anything is registered with Apple or Google.

- **Accepted email behavior:** [The one email: purchase confirmation](<Email Delivery Decision.md>). Decided 26 Sep 2026, narrowed 27 Sep 2026; sent through Resend.

- **Accepted shared-core decision:** [Kotlin Multiplatform + native UI + documented rules + shared tests](<Shared Core Decision.md>) — finalized 26 Sep 2026; resolves Backlog #15. [Research, production examples and support routes](<Shared Core Research.md>).

- **Local database:** [SQLite through Room 3, inside the Kotlin core](<Local Database Decision.md>) — decided 27 Sep 2026 (build-plan task 4); replaces the GRDB/Room split.

- **Evidence behind all of this:** [Research/Research Reports/Data, Sync and Accounts/](<../Research/Research Reports/Data, Sync and Accounts/>).
- **Bug catalogue** (separate workstream, after these topics or in parallel when asked): [Research/Research Reports/Bugs and Fixes/](<../Research/Research Reports/Bugs and Fixes/>).
