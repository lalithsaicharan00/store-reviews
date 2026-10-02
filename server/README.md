# Often Enough API

> **Picking this up?** Start with [Architecture/Server, Sync and Launch — Status.md](<../Architecture/Server, Sync and Launch — Status.md>): what's next, in order.

The server for accounts: a Cloudflare Worker, one Durable Object per account, a small D1 directory, and R2 for the
backups of accounts that don't sync. Accounts are optional and free; only Plus syncs
([Backup, Sync and Accounts](<../Research/Research Reports/Data, Sync and Accounts/Backup, Sync and Accounts — One Seamless Experience.md>)).
Design: [Architecture/06. Server on Cloudflare.md](<../Architecture/06. Server on Cloudflare.md>) and
[01. Accounts and Identity.md](<../Architecture/01. Accounts and Identity.md>).

| | |
|---|---|
| Dev | `https://api-dev.oftenenough.com` (Worker `often-enough-api-dev`, D1 `often-enough-directory-dev`, R2 `often-enough-backups-dev` and `often-enough-backups-dev-eu`) |
| Production | `https://api.oftenenough.com` (Worker `often-enough-api`, D1 `often-enough-directory`, R2 `often-enough-backups` and `often-enough-backups-eu`): `env.production` in `wrangler.jsonc`. No test or CI sign-in, Apple's root only, purchases from Production and Sandbox. Release builds of the app use it; debug builds use dev |

## Run the tests

```sh
cd server
npm install          # .npmrc sets legacy-peer-deps (npm 10 bug with Vitest's optional peers)
npm test             # runs inside the real Workers runtime (Miniflare): Worker, Durable Objects, D1
npx tsc --noEmit     # type check
```

Apple and Google are replaced in tests by our own keys served at their real key URLs, so every check (signature,
issuer, audience, expiry, nonce, key rotation) runs on the real code. EU storage can only be checked on Cloudflare's
network: `scripts/live-smoke.mjs` does that against dev.

## Deploy dev

```sh
npx wrangler d1 migrations apply DIRECTORY --remote   # only when migrations/ changed
npx wrangler deploy
TEST_LOGIN_SECRET=... node scripts/live-smoke.mjs     # live check
```

## Deploy production

```sh
npm run migrate:production                     # only when migrations/ changed
npm run release:production                     # tests, then 5% → 25% → 100%, live checks each step, rollback on failure
node scripts/live-production.mjs               # live check, no secret needed
```

`release:production` waits 20 minutes at 5% and at 25% (`-- --step-minutes N` to change). A release that changes
Durable Object classes can't go out gradually (Cloudflare's rule): use `npm run deploy:production` for that one.
Drilled 1 Oct 2026: a full 5/25/100 release, and `-- --drill-rollback` (rolled back from 25%).

Its only secret is its own `TOKEN_KEY` (`npx wrangler secret put TOKEN_KEY --env production`; random, kept nowhere
else: losing it only makes every device refresh once). Test production's settings locally with `test/production.test.ts`.
Apple's App Store Server Notifications URL, once the Apple account exists: `https://api.oftenenough.com/v1/hooks/apple`.

The backup buckets were made once (1 Oct 2026, dev and production); a new environment needs the same, with its own names:

```sh
npx wrangler r2 bucket create often-enough-backups-dev
npx wrangler r2 bucket create often-enough-backups-dev-eu -J eu
npx wrangler r2 bucket lifecycle add often-enough-backups-dev expire-365-days --expire-days 365 -y
npx wrangler r2 bucket lifecycle add often-enough-backups-dev-eu expire-365-days --expire-days 365 -J eu -y
```

Needs `CLOUDFLARE_API_TOKEN` and `CLOUDFLARE_ACCOUNT_ID` in the environment.

**Secrets** (never in the repo; set with `wrangler secret put NAME` or `wrangler deploy --secrets-file`):
- `TOKEN_KEY`: signs access tokens (at least 32 characters). Changing it makes every access token refresh once.
- `TEST_LOGIN_SECRET`: dev only. Unlocks `POST /v1/auth/test`, a sign-in without Apple or Google for automated
  end-to-end tests. If it's lost, upload a new random one.
- `APPLE_SIGNIN_KEY`: the Sign in with Apple key's `.p8` file (Key ID `S2D594VDJH`, team `MHTC4C9P8F`, both vars in
  `wrangler.jsonc`), for token revocation (`src/appleTokens.ts`). Set it in both environments, pasting the whole file:
  `npx wrangler secret put APPLE_SIGNIN_KEY < AuthKey_S2D594VDJH.p8` (add `--env production` for production). Until it
  is set, sign-in works and nothing is revoked. A new key: put the new file and change `APPLE_SIGNIN_KEY_ID`.

## API (v1)

| Route | Does |
|---|---|
| `GET /v1/status` | health check, no sign-in |
| `POST /v1/auth/apple`, `/v1/auth/google` | `{idToken, nonce, create?, device, country?}` → tokens and `plus`. An unknown key answers `404 unknown_key` unless `create: true`. Apple also takes `authorizationCode`: after the reply, the server swaps it at Apple for a refresh token, kept with the key only to revoke it |
| `POST /v1/auth/test` | dev only: `{secret, subject, create?, device, plus?}`. Plus unless `plus: false` (a free account) |
| `POST /v1/auth/refresh` | `{refreshToken}` → new tokens and `plus`. The old one may be retried for 2 minutes (lost replies); later reuse signs that device out |
| `GET /v1/account` | keys and devices |
| `POST /v1/account/link`, `/unlink` | add or remove a sign-in method (never the last one) |
| `POST /v1/account/signout`, `/delete` | end this device's session; delete the account (directory first, then its data, then its Apple sign-in is revoked at Apple). Unlinking Apple revokes it too |
| `POST /v1/auth/ci` | dev only: GitHub Actions runs of this repository sign in with the run's identity token (iPhone end-to-end tests); Plus unless `plus: false` |
| `POST /v1/sync` | **Plus only.** `{cursor, ops}` → `{applied, rejected, ops, cursor, more}`; merges with the shared Kotlin rules in `core/`. A free account gets `403 plus_required` from the Worker, before any Durable Object |
| `PUT /v1/backup` | The body is the backup file (at most 5 MB). Headers: `x-backup-sha256` (hex), `x-backup-device-name` (URL-encoded), `x-backup-platform`, `x-backup-app-version`, `x-backup-format`, `x-backup-created-at` (ms), `x-backup-habits`, `x-backup-entries`, `x-backup-records`. → `201` with the copy's details and the `sha256` R2 stored. One copy per device per weekday (UTC); a copy with under half the records of the newest one first keeps the newest aside as `before-shrink` |
| `GET /v1/backup` | `{copies: [...]}`: every copy of every device of the account, newest first |
| `GET /v1/backup/{device}/{slot}` | one copy's file (`slot`: `sun`…`sat`, `before-shrink`) |
| `DELETE /v1/backup` | removes every copy ("keep my backup only in my iCloud") |
| `POST /v1/purchases/verify` | `{jws}` (StoreKit 2 `jwsRepresentation`) → entitlements and a new access token (so a new Plus syncs at once); checked against Apple Root CA - G3, no call to Apple |
| `GET /v1/purchases` | the account's entitlements (`plus`, `family`, purchases) |
| `POST /v1/hooks/apple` | App Store Server Notifications V2: refunds and revocations remove Plus; a reversed refund restores it |
| `POST /v1/hooks/apple-signin` | Sign in with Apple server-to-server notifications `{payload}`: `consent-revoked` ends the sessions Apple sign-in opened; `account-delete` removes the Apple sign-in, or deletes the whole account if it was the only one; `email-disabled`/`-enabled` update the relay email. Register `https://api.oftenenough.com/v1/hooks/apple-signin` with Apple once the developer account exists |
| `/v1/admin/*` | Support only, with `Authorization: Bearer <ADMIN_SECRET>`; a plain 404 where that secret isn't set. Snapshots and restoring one account (below) |

The app sends `nonce` raw and gives Apple or Google its SHA-256 (hex). `device` is `{id (UUID), platform, name, appVersion}`.
`country` (the store country, alpha-2 or alpha-3) decides at creation whether the account is stored in the EU, and its
backups go to the EU bucket.

**Plus in the access token:** set from the account's purchases whenever a token is issued (sign-in, refresh, purchase).
A refund takes sync away at the next refresh (within an hour). A token from before this check has no claim and counts as
free: the app refreshes on `403 plus_required` once before believing it.

**Rate limits** (Cloudflare's rate-limit binding, per location, approximate): 60 a minute per account for sync and backup
reads, 30 a minute per IP for `/v1/auth/*`, 2 a minute per device for backup uploads. Over the limit: `429 slow_down`
with `Retry-After: 60`. `device.last_seen` is written at most once an hour.

`core/` is the shared Kotlin sync code compiled to JavaScript. After changing `Core/sync`, run `scripts/build-core.sh`.

## Nightly snapshots and restoring one account

Synced accounts are copied to R2 every night they changed (`src/snapshots.ts`): the day's first change sets the account
object's alarm for 02:00 UTC, which writes `snapshots/<account>/<day>.json.gz` (every record with its field stamps)
to the account's bucket (EU accounts: the EU bucket). 90 nightlies are kept, then each month's 1st, for 365 days.
Deleting an account deletes its snapshots. Durable Objects' own 30-day point-in-time recovery is the other net; it
restores a whole object to a moment, so it's for emergencies only (it would drop the user's newer edits).

Restoring one account (`scripts/restore-account.mjs`, needs that environment's `ADMIN_SECRET`; production has none
until support needs it: `npx wrangler secret put ADMIN_SECRET --env production`):

```sh
ADMIN_SECRET=… node scripts/restore-account.mjs list <account>
ADMIN_SECRET=… node scripts/restore-account.mjs check <account> 2026-10-01          # counts only
ADMIN_SECRET=… node scripts/restore-account.mjs restore <account> 2026-10-01        # merges back what's missing
```

It never overwrites: what's missing or older comes back through the same merge rules, as ops from the device
`restore`, and phones receive them on their next sync. The drill (`scripts/restore-drill.mjs`, against dev) restores a
205-record account into a fresh one and checks a device pulls back every record.

## The purchase email

The one email we send (Architecture/Email Delivery Decision.md), `src/email.ts`: after `/v1/purchases/verify` records a
purchase under 30 days old, a job is written once per store + purchase ID (`purchase_email`, no account or address in
it), then sent after the reply. Before sending it rechecks that the account exists, the purchase isn't refunded and
there's an address; failures retry with the daily cron for 7 days (5 tries). Restores, new accounts and repeated
verifications find the row and send nothing. Until `RESEND_API_KEY` is set, jobs wait.

To switch it on (needs you): verify `oftenenough.com` in Resend (SPF, DKIM), register the sending domain with Apple's
Private Email Relay, `wrangler secret put RESEND_API_KEY [--env production]`, optionally `EMAIL_FROM` (default
`Often Enough <hello@oftenenough.com>`), and send a real purchase to Gmail, Outlook and an Apple relay address.

## Monitoring

`src/report.ts`. A cron at 06:00 UTC builds the daily report for the last 24 hours: accounts (open, new, deleted),
purchases linked, failed nightly snapshots, and (once set up) requests, server errors by route and the share of the free
plan's 100,000 daily requests used. It warns at 1% server errors, half the free plan, and any failed snapshot. It's
always written to the logs; read it any time with `GET /v1/admin/report?format=text` (admin secret).

To finish setting it up (each needs you, once per environment):
- **Analytics Engine:** switch it on in the Cloudflare dashboard (Workers → Analytics Engine), then add the
  `analytics_engine_datasets` lines shown in `wrangler.jsonc` and deploy. Every request then writes one data point
  (route name and status only).
- **`ANALYTICS_TOKEN`** (`wrangler secret put ANALYTICS_TOKEN [--env production]`): a Cloudflare API token with only
  "Account Analytics: Read", so the report can read those numbers.
- **Email:** `RESEND_API_KEY` (secret) and `REPORT_TO` (comma-separated), with `oftenenough.com` verified in Resend;
  `REPORT_FROM` defaults to `Often Enough <reports@oftenenough.com>`.
- **Outside checks:** a free uptime monitor (UptimeRobot, Better Stack) on `https://api.oftenenough.com/v1/status`
  every minute, and Cloudflare notifications for Worker errors. Neither can run from inside Cloudflare itself.

**Not built yet:** Google Play purchases and notifications, and a WAF rule in front of the Worker. Real Apple and Google sign-in need
their keys (the Apple Developer account and a Google Cloud OAuth client); everything else is tested with stand-ins.
