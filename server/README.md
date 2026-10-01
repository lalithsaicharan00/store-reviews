# Often Enough API

> **Picking this up?** Start with [Architecture/Server, Sync and Launch — Status.md](<../Architecture/Server, Sync and Launch — Status.md>): what's next, in order.

The server for Plus accounts: a Cloudflare Worker, one Durable Object per account, and a small D1 directory.
Design: [Architecture/06. Server on Cloudflare.md](<../Architecture/06. Server on Cloudflare.md>) and
[01. Accounts and Identity.md](<../Architecture/01. Accounts and Identity.md>).

| | |
|---|---|
| Dev | `https://api-dev.oftenenough.com` (Worker `often-enough-api-dev`, D1 `often-enough-directory-dev`) |
| Production | not created yet; it gets its own `env.production` block, Worker, D1 and secrets |

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

Needs `CLOUDFLARE_API_TOKEN` and `CLOUDFLARE_ACCOUNT_ID` in the environment.

**Secrets** (never in the repo; set with `wrangler secret put NAME` or `wrangler deploy --secrets-file`):
- `TOKEN_KEY`: signs access tokens (at least 32 characters). Changing it makes every access token refresh once.
- `TEST_LOGIN_SECRET`: dev only. Unlocks `POST /v1/auth/test`, a sign-in without Apple or Google for automated
  end-to-end tests. If it's lost, upload a new random one.

## API (v1)

| Route | Does |
|---|---|
| `GET /v1/status` | health check, no sign-in |
| `POST /v1/auth/apple`, `/v1/auth/google` | `{idToken, nonce, create?, device, country?}` → tokens. An unknown key answers `404 unknown_key` unless `create: true` |
| `POST /v1/auth/test` | dev only: `{secret, subject, create?, device}` |
| `POST /v1/auth/refresh` | `{refreshToken}` → new tokens. The old one may be retried for 2 minutes (lost replies); later reuse signs that device out |
| `GET /v1/account` | keys and devices |
| `POST /v1/account/link`, `/unlink` | add or remove a sign-in method (never the last one) |
| `POST /v1/account/signout`, `/delete` | end this device's session; delete the account (directory first, then its data) |
| `POST /v1/auth/ci` | dev only: GitHub Actions runs of this repository sign in with the run's identity token (iPhone end-to-end tests) |
| `POST /v1/sync` | `{cursor, ops}` → `{applied, rejected, ops, cursor, more}`; merges with the shared Kotlin rules in `core/` |
| `POST /v1/purchases/verify` | `{jws}` (StoreKit 2 `jwsRepresentation`) → entitlements; checked against Apple Root CA - G3, no call to Apple |
| `GET /v1/purchases` | the account's entitlements (`plus`, `family`, purchases) |
| `POST /v1/hooks/apple` | App Store Server Notifications V2: refunds and revocations remove Plus; a reversed refund restores it |

The app sends `nonce` raw and gives Apple or Google its SHA-256 (hex). `device` is `{id (UUID), platform, name, appVersion}`.
`country` (the store country, alpha-2 or alpha-3) decides at creation whether the account is stored in the EU.

`core/` is the shared Kotlin sync code compiled to JavaScript. After changing `Core/sync`, run `scripts/build-core.sh`.

**Not built yet:** Google Play purchases and notifications, Sign in with Apple server-to-server notifications and token
revocation, the purchase email, rate limiting, the daily report and R2 snapshots. Real Apple and Google sign-in need
their keys (the Apple Developer account and a Google Cloud OAuth client); everything else is tested with stand-ins.
