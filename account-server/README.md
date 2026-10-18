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
| `POST /v1/google/notifications` | Google Play's Real-time developer notifications, pushed by Pub/Sub with its OIDC token; nobody else. A refund ends Plus here, within seconds ([Refunds](#refunds-within-seconds)) |

Every call but sign-in, opening an invite and Pub/Sub's push needs `Authorization: Bearer <session>` (32 random bytes;
the database keeps only its SHA-256; forgotten after 400 days unused). Every call is safe to repeat. Rate limits per
minute: 30 sign-ins per IP, 30 invite opens per IP, 120 calls per account. One daily job (05:00 UTC) deletes invites
30 days after they ended, sessions unused for 400 days and handled Pub/Sub message IDs after 30 days, then reads Google
Play's voided purchases since the day before. Errors are `{error, message}`; a 401 carries `WWW-Authenticate` (Android's
HttpURLConnection throws on a 401 without it). Nothing logs a request body or a token (D11).

**Dev only, refused by production:** the app's end-to-end tests sign in with a test secret (`provider: "test"`,
`TEST_SIGN_IN_SECRET`, kept only in the PC's `~/.gradle/gradle.properties` as `accountTestSecret`), and the debug app's
stand-in purchases (`stand-in-…` tokens) count as bought. `test/dev-and-production.test.ts` checks production has
neither.

## Test

```sh
cd account-server
npm install
npm test               # 66 tests in the Workers runtime (Miniflare) with a real D1; Google, Apple and Play are stand-ins
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


## Refunds, within seconds

The user, 16 Oct 2026: a refund on Google Play ends Plus at once, built the way Google describes for production, not
as a stopgap. Seen that day: a license tester's Plus Family refund took up to a day to reach the account, because the
Worker only re-checked a purchase once a day, and Google Play on the phone had already dropped the purchase, so the app
no longer sent its token.

**How it works** (`src/refunds.ts`), from Google's own guidance
([RTDN reference](https://developer.android.com/google/play/billing/rtdn-reference),
[one-time product lifecycle](https://developer.android.com/google/play/billing/lifecycle/one-time),
[Voided Purchases API](https://developers.google.com/android-publisher/voided-purchases),
[Pub/Sub push authentication](https://docs.cloud.google.com/pubsub/docs/authenticate-push-subscriptions)):

1. **Real-time developer notifications, pushed.** Google Play publishes to our Pub/Sub topic when a purchase is voided
   (refunded, revoked or charged back: `voidedPurchaseNotification`) or a one-time purchase is cancelled or completed
   (`oneTimeProductNotification`). Pub/Sub pushes each one to `POST /v1/google/notifications` with an OIDC token signed
   by Google for our push service account. The Worker checks it like a sign-in token (Google's keys, issuer
   `accounts.google.com`, **audience** = this environment's own address, **email** = `play-notifications-push@…`, verified)
   and refuses anything else with 401.
   - **Voided:** the notification names the token, which Google says is enough "to find the right purchase and order
     and adjust entitlements". The account holding it loses what it paid for at once, through the same rules as every
     refund (`paidFor`: a refunded Plus Family ends the family for everyone in it; a refunded upgrade keeps Plus).
     Subscriptions (we sell none) and partial refunds (ours are bought one at a time) change nothing.
   - **One-time cancelled or purchased:** the notification only says the state changed, so the Worker asks the Play
     Developer API, as Google says to, and acts on its answer.
   - **Pub/Sub delivers at least once:** each `messageId` is handled once (`play_notifications`, kept 30 days). The Worker
     answers 204 only once a message is handled; when Google Play or the database can't be asked it answers 503 and
     Pub/Sub delivers it again with backoff, for up to 7 days. A message it can't read is acknowledged and logged (the
     sweep below still catches any void in it), so it isn't retried for a week.
2. **The Voided Purchases API once a day, the backstop** (the daily job at 05:00 UTC, `sweepVoided`): every one-time
   purchase Google first saw as voided since the last sweep, with an hour's overlap; the first sweep reads the last 30
   days (all the API keeps). It covers a notification that never came: the endpoint down for longer than Pub/Sub keeps
   messages, or a setting changed in Play Console. The cursor (`worker_state`) moves only after a whole sweep worked.
   About one query a day, against a quota of 6,000. **Daily, not hourly (the user, 16 Oct 2026):** Google's
   notifications already end Plus within seconds, so an hourly backstop "unnecessarily wastes the resources"; for a
   one-time purchase that uses none of our resources, a refund that reaches the account the next day is fine. **Within the Workers Free plan** (50 outside calls, 1,000 database calls, 10 ms of CPU a
   run): a page of up to 1,000 voids costs about 13 database calls (`voidMany`: held purchases looked up 90 at a time,
   every void remembered in one batch), and a run ends at most 120 held purchases one by one; what doesn't fit is done by
   the next day's run (`refunds.test.ts` checks 3,000 voids with 200 held stay under 1,000 calls a run). It lists only
   purchases Google **voided**: a Play Console refund without "Remove entitlement" never appears (below). Test purchases
   refunded with it do appear: production's first run (16 Oct 2026, 15:07 UTC) listed the day's two such test refunds.
3. **A void is final.** Every voided token's SHA-256 is kept (`voided_purchases`, never the token): it never counts
   again, even when it reaches the Worker later (bought, refunded, then the account made) or Google's check briefly
   still says purchased. A new purchase has a new token and counts as usual. Deleting an account doesn't forget a void.
4. **The daily re-check stays** (`GET /v1/account` re-checks a purchase a day old), as a third, slower path.

**⚠️ A refund from Play Console ends Plus only when "Remove entitlement" is ticked** (found 16 Oct 2026 on dev). In
**Order management › the order › Refund**, Play Console offers a **Remove entitlement** checkbox:

- **Ticked:** the money goes back **and** the purchase is cancelled. Google voids it, sends its notification within
  seconds, and the Worker ends what it paid for (seen: the upgrade `GPA.3300-8440-7215-88090`, refunded with the box
  ticked at 14:33 UTC, ended its family within seconds and kept Plus).
- **Unticked:** the money goes back but **the person keeps the purchase**. Google still reports it as purchased, sends
  no notification, never lists it as voided, and the Worker rightly keeps Plus. It's a goodwill refund, nothing more.
  (Seen: `GPA.3382-…` and `GPA.3355-…` were refunded without it; no notification ever came.) Developers report the
  entitlement can't be removed afterwards, so decide at the moment of the refund.

**So: tick "Remove entitlement" on every refund that should end Plus** (every refund under the refund policy). A
customer's own refund through Google Play (within 48 hours) cancels the purchase by itself.

Nothing logs a token, a message ID or a body (D11); the log says only what kind of notification came and what it did
(`rtdn: voided one-time purchase (held by an account: what it paid for ended)`). Keyless like the rest: Pub/Sub signs its own tokens
as `play-notifications-push@…`, a service account with no keys and no roles.

**How quickly:** Google publishes no figure for how soon after a refund it sends the notification; Pub/Sub's push
itself takes well under a second, and the Worker acts on it in the same request. The app shows the change when it next
reads the account. If a notification were lost, the daily sweep ends Plus the next day (05:00 UTC).

**Status (16 Oct 2026):** set up in Google Cloud and Play Console by the user; on dev and, after a gradual release with
the user's go-ahead (version `44f5e6ed`, 12:45 UTC), on production, whose triggers were deployed separately
(`npx wrangler triggers deploy --env production`: a gradual release doesn't change Cron Triggers). Seen on dev: Play
Console's test notification and test refunds' notifications arrived within seconds; two refunds made **without**
"Remove entitlement" never sent one and never appeared in the Voided Purchases API (above). Production's scheduled job
didn't fire after the gradual release until its triggers were deployed again (`npx wrangler triggers deploy --env
production`, 14:17 UTC); it then ran at 15:07 and listed the two voided test refunds. The hourly sweep became daily the
same day (the user).

### Setting it up (done once by the user)

**Google Cloud Console, project "Often Enough" (`often-enough`, number 367584981284):**

1. **APIs & Services › Library:** enable the **Cloud Pub/Sub API**.
2. **IAM & Admin › Service accounts › Create service account:** name *Play notifications push*, ID
   `play-notifications-push`. Give it **no roles** (skip both optional steps) and **never make a key** (its Keys tab stays
   empty). Pub/Sub signs its push tokens as this account.
3. Open `play-notifications-push@often-enough.iam.gserviceaccount.com` › **Principals with access › Grant access:** principal
   `service-367584981284@gcp-sa-pubsub.iam.gserviceaccount.com` (Pub/Sub's own service agent), role **Service Account
   Token Creator**. This lets Pub/Sub make its tokens, for this one account only.
4. **Pub/Sub › Topics › Create topic:** topic ID `play-notifications`; untick *Add a default subscription*. Its full
   name is `projects/often-enough/topics/play-notifications`.
5. Open the topic › **Permissions** (the info panel; *Show info panel* if hidden) › **Add principal:**
   `google-play-developer-notifications@system.gserviceaccount.com`, role **Pub/Sub Publisher**. Only Google Play may
   publish to it.
6. **Pub/Sub › Subscriptions › Create subscription**, twice, one per Worker:

   | | Production | Dev |
   |---|---|---|
   | Subscription ID | `play-notifications-production` | `play-notifications-dev` |
   | Topic | `projects/often-enough/topics/play-notifications` | the same |
   | Delivery type | **Push** | **Push** |
   | Endpoint URL | `https://api.oftenenough.com/v1/google/notifications` | `https://api-dev.oftenenough.com/v1/google/notifications` |
   | Enable authentication | ✓, service account `play-notifications-push@often-enough.iam.gserviceaccount.com` | the same |
   | Audience | `https://api.oftenenough.com/v1/google/notifications` | `https://api-dev.oftenenough.com/v1/google/notifications` |

   For both: *Enable payload unwrapping* **off** (the Worker reads Pub/Sub's wrapped message); **Expiration period:
   Never expire** (by default a subscription with no activity for 31 days is deleted); acknowledgement deadline 30
   seconds; message retention 7 days; **Retry policy: Retry after exponential backoff delay**, minimum 10 s, maximum
   600 s; no dead lettering, no filter. Both get every notification: the debug app's license-tester purchases are held
   by dev, real ones by production, and each ignores tokens it doesn't hold.

**Play Console › Often Enough:**

7. **Monetize with Play › Monetization setup › Real-time developer notifications:** tick **Enable real-time
   notifications**; topic name `projects/often-enough/topics/play-notifications`; notification content **Get all
   notifications for subscriptions and one-time products** (the other choice leaves out one-time cancellations; voids
   come with both). **Send test message**, then **Save changes**. `npx wrangler tail` (and `--env production`) shows
   `rtdn: Play Console's test notification` within seconds.
8. **Users and permissions › `play-purchases@…`:** keep **View financial data** ticked: the Voided Purchases API needs it.

**Deploying it** (the schema change goes first and works with the old version too):

```sh
npm run migrate:dev && npm run deploy:dev && npm run live:dev
npm run migrate:production && npm run release:production    # only with the user's go-ahead (T6)
```

**Checking it end to end:** a license tester buys Plus on the debug app (held by dev); refund the order in Play
Console's **Order management** with **Remove entitlement** ticked. Within seconds `npx wrangler tail` shows `rtdn: voided one-time purchase (held by an
account: what it paid for ended)` and the account reads `NONE`. The daily job logs `voided sweep: N voided, M held by an
account`; `voided sweep failed: store_unavailable` means step 8's permission is missing.
