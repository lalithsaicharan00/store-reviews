# Server Cost and Capacity — Free Safety Copy vs Plus Sync

> **Replaced by [Architecture 11 — iCloud Sync with CloudKit](<11. iCloud Sync with CloudKit.md>) on Apple devices (built 10 Oct
> 2026, Current Work 81).** Habits are in each person's own iCloud, counted against their storage, not ours; the costs here no longer apply. Kept as the record of the server-era design; `server/` is tagged
> `server-final-2026-10` and removed from `main` once CloudKit sync has passed the device checks (11 §17).

> **Superseded in part, 10 Oct 2026 (the user, final): no server holds anyone's habits** (Rulebook D16). Apple syncs and backs up through iCloud (CloudKit), Plus comes from StoreKit and Plus Family from Apple's Family Sharing; Android follows. What this document says about accounts, our server sync and invites stays only until the CloudKit work rewrites it. See [Plus, Price and the Server — How We Decided](<../Research/Research Reports/Business Model and Monetization/Plus, Price and the Server — How We Decided/README.md>).

> **Updated 1 Oct 2026:** the anonymous free "safety copy" was dropped ([Backup, Sync and Accounts — One Seamless Experience](<../Research/Research Reports/Data, Sync and Accounts/Backup, Sync and Accounts — One Seamless Experience.md>)). The free lane below now serves **free accounts only**: nightly backup to R2 for people who chose an account. Users without an account cost us nothing. The prices and the Plus lane are unchanged.

*Written by Claude (Claude Code), 1 Oct 2026. A plan, not a decision. It prices two things on Cloudflare: the free "safety copy" proposed in [Free Plan Data Protection](<../Research/Research Reports/Data, Sync and Accounts/Free Plan Data Protection — Backup Without Giving Away Plus.md>), and Plus sync as it is being built on branch `claude/server-and-sync` (commit `7a2f9d3`). Prices are from Cloudflare's docs on 1 Oct 2026.*

**The user's ask (1 Oct):** How much will it cost, and how many free users can we handle? Paid users need sync, so they should get more requests. Free users should use very few resources. The data must stay safe.

---

## 1. The short answer

1. **It is cheap at every size we can expect.** On the Workers Paid plan ($5 a month), the cost is:

   | Free users | Plus users | Cloudflare, per month |
   |---|---|---|
   | 10,000 | 500 | **$5** (the plan fee; everything fits in what it includes) |
   | 100,000 | 5,000 | **about $13** |
   | 250,000 | 12,500 | **about $33** |
   | 1,000,000 | 50,000 | **about $175** |
   | 1,000,000 | 100,000 | **about $295** |

   - **A free user costs about $0.0013 a year.** A million free users cost about $105 a month.
   - **A Plus user costs about $0.03 a year,** so a one-time Plus purchase covers its server costs for decades.
2. **We need the $5 Paid plan before launch.** The Workers Free plan allows 100,000 Durable Object row writes a day. With sync as built, that is only **about 1,900 Plus users**. The free plan could hold about 150,000 free users on their own. It also caps CPU at 10 ms per request, which is tight for checking App Store and App Attest signatures.
3. **Two lanes, so free users can't use expensive parts:**
   - **Free lane: Worker + R2 only.** One upload on each day the data changed. No account, no Durable Object, no database row. Expiry is handled by an R2 rule, so we write no cleanup code.
   - **Plus lane: Worker + one Durable Object per account + D1.** Live sync, every device, with much higher limits.
4. **One gap on the server branch:** `/v1/sync` doesn't check Plus today. Any signed-in account can sync. The check belongs at the very front (§4.2), so a free account never reaches a Durable Object.
5. **Two small changes make Plus about 25% cheaper:** write `device.last_seen` at most once an hour instead of on every poll, and make no Durable Object call for free accounts (§4.3).

---

## 2. Prices used

| Service | Workers **Free** plan | Workers **Paid** plan ($5/month) | Source |
|---|---|---|---|
| Worker requests | 100,000 a day; 10 ms CPU per request | 10M a month included, then $0.30 per million. 30M CPU-ms included, then $0.02 per million | [Workers pricing](https://developers.cloudflare.com/workers/platform/pricing/) |
| Durable Object requests | 100,000 a day | 1M a month, then $0.15 per million | [Durable Objects pricing](https://developers.cloudflare.com/durable-objects/platform/pricing/) |
| Durable Object duration | 13,000 GB-s a day | 400,000 GB-s a month, then $12.50 per million. Billed at 128 MB while running. An idle object that can hibernate costs nothing | same |
| Durable Object SQLite | 5M rows read, **100,000 rows written** a day, 5 GB | 25 billion reads and 50M writes a month included, then $0.001 and $1.00 per million; storage $0.20 per GB-month after 5 GB | same |
| D1 | 5M reads, 100,000 writes a day | the same as Durable Object SQLite; storage $0.75 per GB-month after 5 GB | [Workers pricing](https://developers.cloudflare.com/workers/platform/pricing/) |
| R2 | 10 GB, 1M writes, 10M reads a month free | storage $0.015 per GB-month; writes $4.50 per million; reads $0.36 per million; no egress fee | [R2 pricing](https://developers.cloudflare.com/r2/pricing/) |
| R2 lifecycle rules | delete objects a set number of days after upload, per prefix; a deleted object stops costing | | [R2 lifecycles](https://developers.cloudflare.com/r2/buckets/object-lifecycles/) |
| R2 in the EU | a bucket with jurisdiction `eu`, bound in Wrangler; can't be changed later | | [R2 data location](https://developers.cloudflare.com/r2/reference/data-location/) |
| Rate-limit binding | limit per key per 10 or 60 seconds. Approximate and per Cloudflare location, so it guards against abuse but is not exact accounting | | [Rate limiting](https://developers.cloudflare.com/workers/runtime-apis/bindings/rate-limit/) |
| Play Integrity (Android attestation) | 10,000 calls a day by default; more on request (2–3 working days) | | [Play Console Help](https://support.google.com/googleplay/android-developer/answer/11395166?hl=en) |

---

## 3. What one user uses

These are the model's inputs ([`server_cost_model.py`](<../Research/Research Reports/Data, Sync and Accounts/Free Backup Evidence/server_cost_model.py>)). Everything is per month.

| | Free (safety copy) | Plus (sync as built on `claude/server-and-sync`) |
|---|---|---|
| **What happens** | One upload on each day the data changed; about 20 days | The app syncs on open, 3 s after a change, and every 60 s while open. Assumed 1.5 devices × 10 syncs a day × 25 days, plus one token refresh a device a day |
| Worker requests | **20** | 413 |
| Durable Object requests | **0** | 438 (including one nightly snapshot read a day) |
| Durable Object duration | **0** | 2.6 GB-s (50 ms a call at 128 MB; a cautious guess) |
| Rows written | **0** | 1,575 (4 per op × 300 ops, plus a `last_seen` write on every sync) |
| R2 writes | 20 | 25 (one nightly snapshot per changed day, 06 §9) |
| R2 stored | 0.7 MB (7 copies × 100 KB) | 18 MB (90 nightly snapshots × 200 KB) |
| **Cost when large** | **$0.11 per 1,000 users** | **$2.51 per 1,000 users** |

**Where the money goes:**
- **Free:** almost all of it is R2 writes (1M free users = 20M writes = about $90 of the $105).
- **Plus:** Durable Object requests and rows written.

**What would change the numbers:**
- **Heavy Plus use** (the app open often, so the 60 s poll runs about 60 times a device a day): 50,000 Plus users cost **about $212** a month instead of $66. That is still small.
- **Bigger free copies** (long notes, 500 KB): storage at 1M free users goes from about $10 to about $50 a month. R2 writes stay the larger cost.
- **Duration:** at 50 ms a call, duration stays inside the included 400,000 GB-s up to about 140,000 Plus users. If Cloudflare bills a full second a call, it runs out at about 7,000 Plus users and then adds about $0.70 per 1,000 Plus users a month. That is still small.

---

## 4. How to keep free cheap and give Plus more

### 4.1 Two lanes

```
Free phone ── PUT /v1/copy/{id}/{weekday} ──► Worker ──► R2 bucket "safety-copies" (eu or default)
                                               (no account, no Durable Object, no D1)

Plus phone ── POST /v1/sync ───────────────► Worker ──► Durable Object "Account" (SQLite) ──► R2 nightly
              (signed in, token says plus)       │
                                                 └─ D1 "directory" (only at sign-in)
```

| Rule | Free lane | Plus lane |
|---|---|---|
| **Who** | Anyone with the app; no account | Signed-in accounts whose token says `plus: true` |
| **How often** | **At most 1 upload a day,** only on days with changes. The app enforces it; the server allows 2 a minute per copy as a loop guard | Sync on open, after changes (3 s debounce) and every 60 s while open. **60 syncs a minute per account** (already planned) |
| **Size** | 5 MB per copy, 7 copies (one per weekday, overwritten) | 2 MB per request, 500 ops (as built) |
| **Server parts touched** | Worker, R2 | Worker, Durable Object, D1, R2 |
| **Abuse check** | App Attest / Play Integrity **only when a copy is first created**; per-IP rate limit; size cap | Our session token (as built); per-IP limits on `/v1/auth/*` (planned) |
| **Cleanup** | R2 lifecycle rule: delete copies **365 days after their last upload**. Free, no code | Account deletion (as built); nightly snapshots kept 90 days, then monthly |
| **Restore** | `GET` latest copy metadata, then the copy (R2 reads, $0.36 per million) | Durable Object point-in-time recovery plus R2 nightlies (planned) |

### 4.2 Check Plus at the front, before any Durable Object

**First principles:** the cheapest request is one that stops in the Worker.

- **Today:** `/v1/sync` only checks that the access token is valid. Accounts are created at sign-in, so a free user could sign in and sync.
- **Change:** add `plus: true|false` to the access-token claims. Set it when the token is issued from the account's entitlements, and update it on every refresh (tokens are short-lived).
- `/v1/sync` with `plus: false` answers **`403 plus_required`** in the Worker, so no Durable Object is called.
- A refund (`/v1/hooks/apple`) takes Plus away at the next refresh.
- **Never downgrade on doubt** ([02](<02. Billing and Entitlements.md>)): if entitlements can't be read, keep the previous claim.

### 4.3 Small changes on the Plus lane

| Change | Saves | Risk |
|---|---|---|
| Write `device.last_seen` **at most once an hour** (skip it on syncs that push nothing) | About 24% of rows written; 50,000 Plus users go from $66 to $47 a month | None. "Last seen" only needs hour precision |
| Nightly R2 snapshot **only for accounts that changed that day** | Already planned (06 §9) | – |
| Poll every 60 s **only while the app is in front** | Already built | – |
| Later, if active use grows a lot: push changes over a **hibernatable WebSocket** instead of polling (20 messages bill as 1 request; no duration while idle) | Most of the polling cost | More moving parts; not needed at the sizes above |

### 4.4 Data safety in the free lane

- **Encrypted on the phone** with a key only the user's phones hold (iCloud Keychain / Block Store). R2 holds unreadable bytes.
- **7 weekday copies, overwritten in turn.** A bad night never destroys the last 6.
- **Shrink guard:** a copy with far fewer records than the previous one is stored beside it, never instead of it.
- **Checked after upload:** the server returns a checksum. The app shows "saved" only when it matches.
- **EU users' copies go to an `eu` bucket,** chosen from the store country, the same rule as accounts.
- **Plus accounts keep their own safety nets** (point-in-time recovery, nightly R2), and their phones keep local snapshots.

### 4.5 Watch-outs

- **Play Integrity is limited to 10,000 calls a day by default.** Call it only when a copy is first created (one call per new Android install), and ask Google for more before launch. Apple asks apps to roll App Attest out gradually because its attestation service has limits; one call per new install is light.
- **The rate-limit binding is approximate** and per location. It stops loops and floods; the 1-a-day rule lives in the app and in the weekday object names (at most 7 objects per copy, ever).
- **Cost alerts:** add R2 writes, Durable Object rows written and Worker requests to the daily report planned in 06 §10. Alert at 50% of each included amount.

---

## 5. For the `claude/server-and-sync` branch

*That branch is another agent's; nothing there was changed. Its status note lists "Backup and restore for free users: another agent is planning it; coordinate before touching restore". These are the coordination points.*

- [ ] Move to **Workers Paid** before real users (the Free plan's 100,000 rows written a day is about 1,900 Plus users).
- [x] **`plus` claim in the access token,** (done 1 Oct 2026) and `403 plus_required` on `/v1/sync` before the Durable Object call (§4.2).
- [x] **`last_seen` at most once an hour** (§4.3). (done 1 Oct 2026)
- [x] **Done differently (1 Oct 2026): backups of free accounts, not anonymous copies.** `PUT/GET/DELETE /v1/backup` on a signed-in account, 7 weekday copies per device, shrink guard, EU bucket, 365-day lifecycle (server/README.md). The anonymous design below was dropped. ~~**Safety-copy routes** (free lane, no account): `PUT /v1/copy/{id}/{weekday}`, `GET /v1/copy/{id}` (metadata for the 7 copies), `GET /v1/copy/{id}/{weekday}`, `DELETE /v1/copy/{id}`. The ID is a hash of a secret derived from the phone's key. An R2 bucket `safety-copies` (plus `eu`) with a 365-day lifecycle rule. Attestation on first create. Rate limits per copy ID and per IP.~~
- [ ] Add the free-lane numbers to the daily report and cost alerts (§4.5).

---

## 6. Limits of this estimate

- **Usage figures are assumptions,** not measurements. The app hasn't launched. Replace them with real numbers from the daily report in the first month.
- **Rows written per op** (4, counting indexes) and **50 ms per Durable Object call** are cautious guesses. Cloudflare's pricing page doesn't say whether index updates count as rows written.
- Prices are as of 1 Oct 2026 and change. Rerun `server_cost_model.py` with new prices.
- Apple and Google fees, the domain, Resend and Sentry are not included. Their free tiers cover launch (06, Email Delivery Decision).

## 7. Required before launch: cost by design (decided by the user, 10 Oct 2026)

The Plus prices (Billing 02 §3.7) are profitable at the extreme case, with inflation and Apple at 30%, **only with
these changes**; as built, a US$24.99 sale loses money in that case ([Price and Size from the Extreme Case](<../Research/Research Reports/Business Model and Monetization/Plus, Price and the Server — How We Decided/Plus and Plus Family — Price and Size from the Extreme Case.md>) §4–5).
The user: free users must be cheap by design.

**Free accounts:** one device, push only (never a timer); quiet for ~12 months → data compressed to R2 and restored on
sign-in, never deleted; 7 daily copies; change log trimmed.

**Every account:** sync by push (a hibernating WebSocket) instead of the 60-second poll; only the last 2 years of
history in the Durable Object, older years compressed in R2; 3 rows written per record; nightly copies as changes
(monthly full copy plus daily changes); the daily cost report and alerts (§4.5).

Result in the model (`Research/Temp/plus-pricing/pricing_v3.py`): an extreme Plus account costs about $3.57 over 15
years (it was $13.30), and one Plus sale with its 20 free accounts about $8.74.

