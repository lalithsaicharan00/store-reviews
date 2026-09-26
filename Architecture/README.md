# Architecture

How the app works under the hood, on every platform: iPhone, Android, Watch, and later web, Windows and Mac.

**How we work:** one topic at a time. Each topic gets:
1. **Review evidence:** a fresh pass through the corpus for that topic, so nothing is missed.
2. **Production research:** Apple and Google rules, and how production systems do it.
3. **A design doc** in this folder.

The system diagram in Figma (page "App Architecture") comes **last**, once every topic below is settled.

**Starting point:** [Data Safety, Accounts and Sync.md](<Data Safety, Accounts and Sync.md>) is the overall proposal: local-first
SQLite, Cloudflare sync, and five safety nets. The topics below go deeper, one at a time.

## Topics, in order

| # | Topic | Why this order | Status |
|---|---|---|---|
| 1 | **Accounts and identity**: sign-up, sign-in, people who never sign in, linking Apple, Google and email, sessions, recovery, sign-out, deletion | Everything else hangs off *who the user is*. Billing links a purchase to an identity; migration moves an identity; backup needs an identity even for people without an account | [Done](<01. Accounts and Identity.md>) |
| 2 | **Billing and entitlements**: App Store and Play purchases, verifying and acknowledging them, linking premium to the account, restore, cross-platform, lifetime, family, refunds, grace periods | The top paid-user 1★ cause (72% 1★) | [Done](<02. Billing and Entitlements.md>) |
| 3 | **Backup without our account**: iCloud, Google Drive, OS backups, how the app *knows* a backup exists and how old it is | For people who never sign in | [Done](<03. Backup Without Our Account.md>) |
| 4 | **Phone migration**: same OS, iPhone ⇄ Android, QR transfer, restore before onboarding | Third most common 1★ story | [Done](<04. Phone Migration.md>) |
| 5 | **Sync engine**: data model, outbox, conflicts, tombstones, schema versions, dates and time zones | The core protocol | [Done](<05. Sync Engine.md>) |
| 6 | **Server on Cloudflare**: Worker, Durable Objects, R2, recovery, limits, cost, exit plan | Mostly designed already; needs production detail | [Done](<06. Server on Cloudflare.md>) |
| 7 | **Other surfaces**: Watch (Apple, Wear OS), widgets, web, Windows and Mac | How each device talks to the data | [Done](<07. Other Surfaces.md>) |
| 8 | **Release safety and operations**: migrations, phased rollout, the data-loss canary, crash-loop recovery, support tools, incident communication | Stops the "update wiped everything" disaster | [Done](<08. Release Safety and Operations.md>) |
| 9 | **Privacy and account deletion**: what we store, deletion across stores and servers, legal | Store requirements | [Done](<09. Privacy and Account Deletion.md>) |
| 10 | **Figma system diagram** (page "App Architecture") | Draws 1–9 | Next: waiting for your go-ahead |

## Related work

- **Parked decisions:** [Backlog.md](Backlog.md).

- **Accepted email behavior:** [Email OTP login, purchase confirmations and replaceable sending provider](<Email Delivery Decision.md>) — decided 26 Sep 2026; initial provider selection remains open.

- **Accepted shared-core decision:** [Kotlin Multiplatform + native UI + documented rules + shared tests](<Shared Core Decision.md>) — finalized 26 Sep 2026; resolves Backlog #15. [Research, production examples and support routes](<Shared Core Research.md>).

- **Evidence behind all of this:** [Research/Research Reports/Data, Sync and Accounts/](<../Research/Research Reports/Data, Sync and Accounts/>).
- **Bug catalogue** (separate workstream, after these topics or in parallel when asked): [Research/Research Reports/Bugs and Fixes/](<../Research/Research Reports/Bugs and Fixes/>).
