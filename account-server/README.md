# The Plus account Worker

Written by Claude (Claude Code), 16 October 2026. Rulebook **D16** (what an account holds), **D11** (secrets), **T6**
(testing and releasing a server); Android **A15**; Current Work **110**; Figma `1476:2` (the screens it serves).

One Cloudflare Worker on the free plan, with one D1 database. It holds **only** who someone is (Google's or Apple's fixed
account ID, a first name the family sees, a masked email hint like `l•••••@gmail.com`), their store purchases **as
checked with Google Play**, and their Plus Family. **Never a habit**, never a whole email address. It replaces the old
`server/` (the habit-sync server D16 retired; its Cloudflare resources were deleted on 15 Oct 2026).

| | |
|---|---|
| Dev | `https://api-dev.oftenenough.com`: Worker `often-enough-account-dev`, D1 `often-enough-accounts-dev`. Debug builds of the app with the Google client (this PC) |
| Production | `https://api.oftenenough.com`: Worker `often-enough-account`, D1 `often-enough-accounts`. Release builds. **Released 16 Oct 2026** (the user's go-ahead); its live checks pass; the Play service account's key is still to be put in |

## What it does

| Call | |
|---|---|
| `POST /v1/sign-in` `{provider, idToken, nonce}` | Google's or Apple's ID token, checked (signature against the provider's keys, issuer, audience = our OAuth client, expiry, and the nonce: the app makes a random value, Google signs its SHA-256, so a copied token can't be replayed). Finds the account (`found`, a new `session` for this device) or says there's none (Figma 3.4) |
| `POST /v1/accounts` `{…, name?, purchase?}` | Makes the account (once, however often or at once it's asked) and checks the purchase sent with it |
| `GET /v1/account` | The account: `plus` (`NONE`, `PLUS`, `FAMILY_OWNER`, `FAMILY_MEMBER`) and the family. Purchases not checked for a day are checked again after the answer, so a refund reaches the account |
| `POST /v1/account/purchases` `{product, token}` | A Google Play purchase, checked with Google; one purchase belongs to one account |
| `POST /v1/account/delete` `{provider, idToken, nonce}` | Needs a fresh sign-in as the same person (Figma 7.2.1). Removes the account, its sessions, its purchase records (the purchases stay with Google, so signing in again brings Plus back), its place in a family, and a family it owns with that family's invites (everyone in it loses Plus, nobody loses habits) |
| `POST /v1/sign-out` | Ends this device's session |
| `POST /v1/family/invite`, `/invite/cancel`, `/remove {person}`, `/leave` | Plus Family: the owner and up to 5 more; one single-use invite at a time, for 7 days (`https://oftenenough.com/join/<token>`, 128 random bits) |
| `GET /v1/invites/<token>`, `POST /v1/invites/<token>/join` | Opening an invite (open, ended, used, cancelled, full; the owner's first name) and joining it. Claiming the invite and taking the place are one transaction, so a family never passes six |
| `GET /v1/health` | `{ok, environment}` |

Every call but sign-in and opening an invite needs `Authorization: Bearer <session>` (32 random bytes; the database keeps
only its SHA-256; forgotten after 400 days unused). Every call is safe to repeat. Rate limits per minute: 30 sign-ins
per IP, 30 invite opens per IP, 120 calls per account. A daily job (05:00 UTC) deletes invites 30 days after they ended
and sessions unused for 400 days. Errors are `{error, message}`; a 401 carries `WWW-Authenticate` (Android's
HttpURLConnection throws on a 401 without it). Nothing logs a request body or a token (D11).

**Dev only, refused by production:** the app's end-to-end tests sign in with a test secret (`provider: "test"`,
`TEST_SIGN_IN_SECRET`, kept only in the PC's `~/.gradle/gradle.properties` as `accountTestSecret`), and the debug app's
stand-in purchases (`stand-in-…` tokens) count as bought. `test/dev-and-production.test.ts` checks production has
neither.

## Test

```sh
cd account-server
npm install
npm test               # 45 tests in the Workers runtime (Miniflare) with a real D1; Google, Apple and Play are stand-ins
npm run typecheck
```

Google's and Apple's keys are our own RSA keys served at their real URLs, and the Play Developer API (with the
service-account sign-in, its JWT checked against the key) answers as Google does, so every check runs on the real code.

The app against the live dev Worker (an emulator running): `AccountServerLiveTest` (the app's client through a whole
family, and the screens: buy Plus Family, sign in, invite, someone joins, remove, delete):

```sh
cd Android
./gradlew :app:connectedDebugAndroidTest -Pandroid.testInstrumentationRunnerArguments.class=com.oftenenough.app.AccountServerLiveTest \
  "-Pandroid.testInstrumentationRunnerArguments.accountTestSecret=$(grep '^accountTestSecret=' ~/.gradle/gradle.properties | cut -d= -f2-)"
```

## Deploy dev

```sh
npm run migrate:dev    # only when migrations/ changed
npm run deploy:dev
ACCOUNT_TEST_SECRET=... npm run live:dev   # the basics, then a whole family end to end (its test accounts deleted)
```

## Production (T6: only with the user's go-ahead)

Done once on 16 Oct 2026: the database made (`often-enough-accounts`), migrated, and the first release deployed whole.
A new custom domain takes a few minutes to resolve on this PC (it remembered the old one as missing): the release
script's checks wait and try again.

```sh
npm run migrate:production     # only when migrations/ changed (a change must work with the old version too)
npm run release:production     # tests, then 5% → 25% → 100% with live checks, rolling back on a failure
npm run live:production        # the basics, no secret
```

## Google Play, keyless (Workload Identity Federation)

The user, 16 Oct 2026, after Google's own advice ([why](https://cloud.google.com/blog/products/identity-security/how-to-authenticate-service-accounts-to-help-keep-applications-secure)):
**no service account key is ever downloaded.** The Worker signs in to Google as `play-purchases@often-enough.iam.gserviceaccount.com`
through [Workload Identity Federation](https://docs.cloud.google.com/iam/docs/workload-identity-federation), as its own
small identity provider (`src/play.ts`):

1. It signs a 5-minute token (RS256) with its own key, the secret `GOOGLE_WIF_SIGNING_KEY`: issuer
   `https://api.oftenenough.com`, subject `often-enough-account` (production) or `often-enough-account-dev` (dev),
   audience the provider's address, key ID `account-production-1` or `account-dev-1`.
2. Google's Security Token Service checks it against the public keys uploaded to the pool's provider (`google/jwks.json`)
   and gives a federated token.
3. IAM Credentials `generateAccessToken` gives a one-hour token as the service account, which Play Console lets read
   purchases. It's cached for its hour.

`scripts/make-wif-key.mjs dev|production` makes a key straight into Cloudflare (never on disk, never printed) and writes
its public half to `google/jwks.json`. Done for both on 16 Oct 2026. To change a key: bump its ID in `wrangler.jsonc`,
run the script, upload the new `jwks.json` in the provider (an upload replaces every key), deploy.
`GET /v1/health/play` says `ready`, `not_set_up` or `unavailable` (no token is shown); `REQUIRE_PLAY=1 npm run
live:production` fails unless it's ready.

**Google Cloud Console, project "Often Enough" (number 367584981284), done once by the user:**

1. **APIs & Services › Library:** enable *IAM Service Account Credentials API*, *Security Token Service API*,
   *Identity and Access Management (IAM) API* and *Cloud Resource Manager API* (the Google Play Android Developer API is
   already on).
2. **IAM & Admin › Workload Identity Federation › Create pool:** name *Cloudflare Workers*, pool ID `cloudflare-workers`.
   Add a provider: **OpenID Connect (OIDC)**, name *Often Enough account*, provider ID `often-enough-account`, issuer URL
   `https://api.oftenenough.com`, **JWK file**: upload `account-server/google/jwks.json`, audiences: *Default
   audience*. Attribute mapping: `google.subject` = `assertion.sub`. Attribute condition:
   `assertion.sub in ["often-enough-account", "often-enough-account-dev"]`. Save.
3. **IAM & Admin › Service accounts › `play-purchases@…` › Principals with access › Grant access:** principal
   `principal://iam.googleapis.com/projects/367584981284/locations/global/workloadIdentityPools/cloudflare-workers/subject/often-enough-account`,
   role **Workload Identity User**; again for `…/subject/often-enough-account-dev`. Its **Keys** tab stays empty.
4. **Play Console › Users and permissions › `play-purchases@…`:** keep *View app information* and *View financial
   data*; untick *Manage orders and subscriptions* (the Worker only reads purchases).

