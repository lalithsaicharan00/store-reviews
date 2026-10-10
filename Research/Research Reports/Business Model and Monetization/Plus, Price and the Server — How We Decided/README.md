# Plus, Price and the Server — How We Decided

Written by Claude (Claude Code), 10 October 2026, at the user's request: everything from the Plus price to the
no-server plan in one folder, with how we got there and the user's own prompts, so that another agent picking this up
doesn't lose the thread and think otherwise.

**Read this first, then the reports in order.** The user's words are in
[The User's Prompts, Word for Word](<The User's Prompts, Word for Word.md>).

## Where things stand (10 Oct 2026)

**Decided by the user:**

| | Decision |
|---|---|
| Plus | **One-time, never a subscription.** List price **never below $24.99** (raise it if the evidence allows) |
| Lowest price anywhere | **Never below $19.99** (regional, student, sale); discounts real, never a raised price crossed out, never stacked |
| Plus Family | **$59.99** one-time; through Family Sharing on Apple, so **the buyer + 5** (Apple's number; the earlier 5 assumed our own invite) |
| Free users | **Must be cheap by design** |
| Every sale | **Profitable with a good margin**, at the extreme case, with inflation; never at break-even |
| Every user | **Thought of as an extreme power user** (60 habits, ~70 logs a day, 3 devices, 15–20 years), free users too |
| What people once had | **Never taken away** after release; nothing is released yet, so the plan can still change |
| Cross-store Plus | An entitlement record **only**, on Cloudflare's free plan, added when Android launches; never habits |
| **No server for habits** | **Final (the user, 10 Oct 2026).** Rulebook D16 |
| **Apple, built first** | Sync and backup through the person's iCloud (CloudKit with `CKSyncEngine`); Plus from StoreKit; **Plus Family through Apple's Family Sharing** (the buyer + 5, Apple's number), so no invites and no account |
| **Android, after Apple** | Android's own Auto Backup + a daily file in their Google Drive (free) at launch; **Drive sync for Plus after a two-device prototype passes, built after the CloudKit work** |
| **Privacy** | **Full privacy: habits never reach us.** They live on the person's devices and in their own iCloud or Google Drive. A new advantage to say plainly in the listing and on the Plus page |
| **Plus price** | **$24.99** (the user's price; $29.99 was suggested only to carry server costs, now gone) |

**Still open:** the student price and how students are verified (Apple offer codes work for one-time purchases);
before Android, Google Play's rules on unlocking purchases from another store and its family sharing.

## How we got here

1. **Buying Plus (account at purchase).** The account isn't required to buy; Plus lives in the App Store purchase
   and on the account when there is one. [Buying Plus — Should an Account Be Required](<../Buying Plus — Should an Account Be Required.md>).
2. **One-time or subscription?** Server costs keep running, so should Plus become yearly? No: one sale paid for a
   typical user's servers for decades; subscriptions wrecked rival apps. **The user decided: one-time.**
   [Plus — One-Time or Subscription](<Plus — One-Time or Subscription, and What Sync Costs Over the Years.md>).
3. **Price from the extreme case.** Every user extreme, free users' costs paid by Plus: $24.99 and Family $59.99 for 5
   recommended. The user then asked for inflation, regional and student prices and a margin on every sale: **with the
   server as built, $24.99 loses money**; with a list of server changes it keeps 43% (52% at $29.99).
   [Plus and Plus Family — Price and Size from the Extreme Case](<Plus and Plus Family — Price and Size from the Extreme Case.md>).
4. **The user: we keep coming back to square one.** A one-time price and a server we must run for decades don't fit.
   Can there be no server, without losing entitlements or data safety? **Yes for Apple devices**: CloudKit
   (`CKSyncEngine`) for sync and backup, StoreKit for Plus, Family Sharing for Plus Family; about 92% of a sale kept.
   Not possible without a server: iPhone ⇄ Android sync, web, one purchase on both stores.
   [Plus Without a Server](<Plus Without a Server — Sync, Entitlements and Data Safety on Apple's Own Services.md>).
5. **Android and mixed devices.** CloudKit is part of the developer program and free to us (the person's iCloud
   storage); its limits are the person's storage and Apple's throttling. Android users ask above all for an
   automatic backup to their own Google Drive (117 of 205 reviews naming Drive); the plan uses Android's Auto Backup,
   a daily Drive file and, for Plus, sync through their Drive. Mixed devices pick Google Drive as their one sync
   place. Plus across stores uses the entitlement-only account.
   [Android and Mixed Devices Without a Server](<Android and Mixed Devices Without a Server — and CloudKit's Limits.md>).

6. **The user: Apple is final (CloudKit, no server). Is Android sync through Google Drive practical, or only
   theoretical?** Practical for us: Google offers no sync framework and the apps that "sync with Drive" copy one
   whole file and ask which copy wins, but our sync already sends small changes that merge the same way in any
   order (`SyncRules.kt`), so Drive only has to be a mailbox. Android launches with the two free backups; Drive sync
   for Plus ships only after a prototype passes the listed tests. Drive's API is free up to 400 million quota units
   a day per app (about 100,000 extreme users syncing daily), with charges above that planned by Google.
   [Android Sync Through Google Drive](<Android Sync Through Google Drive — Practical or Only Theoretical.md>).

7. **The user: decisions final** (10 Oct 2026): no server; Apple first with CloudKit, then Android; the Drive
   prototype after the CloudKit work; "full privacy" as a new advantage. Logged as Rulebook D16.

Related, same day: [Where the Plus Button Goes](<../Where the Plus Button Goes — Accidental Taps and Pushy Placement.md>)
(the Plus sheets' order and wording).

## What changes now that "no server" is chosen

Rules to rewrite with the user's say-so: Rulebook D3, D4, D9, D12, D14, D15 and U26's sync step;
[Billing and Entitlements](<../../../../Architecture/02. Billing and Entitlements.md>) §3.6–3.7;
[Server Cost and Capacity](<../../../../Architecture/Server Cost and Capacity — Free Safety Copy vs Plus Sync.md>) §7;
the Plus screens in Figma (1021:309). The server, accounts and invites would be set aside, not deleted.

## Files

- Models: [`Research/Temp/plus-pricing/`](../../../Temp/plus-pricing/) (`extreme_price.py`, `pricing_v2.py`,
  `pricing_v3.py`, family size and accidental-tap codes).
- Review scans and hand codes: [`Research/Temp/no-server/`](../../../Temp/no-server/) (`sync_where.py`,
  `icloud_codes.py`, `android_scan.py`, `play_drive_codes.py`).
- `Research/Temp/` is not in git: these files live on this Mac only.
