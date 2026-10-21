# The move relay Worker

Written by Claude (Claude Code), 16 October 2026, as the Plus account Worker; **rewritten 21 October 2026** when the
accounts went. Rulebook **D15** (moving to a new phone with a code), **D16** (no accounts), **D11** (secrets), **T6**
(testing and releasing a server).

One Cloudflare Worker on the free plan. **It holds nothing about anyone.** It passes two online phones' messages while
one moves its habits to the other with a 6-digit code, and answers `GET /v1/health`.

| | |
|---|---|
| Dev | `https://api-dev.oftenenough.com`: Worker `often-enough-account-dev`. Debug builds of the apps |
| Production | `https://api.oftenenough.com`: Worker `often-enough-account`. Release builds |

## The accounts, deleted 21 Oct 2026

The user, 21 Oct 2026: phones only, **no accounts**, no Plus Family; Plus stays with the store that sold it and is moved
between iPhone and Android **by hand** (Rulebook D16). The same day, with the user's go-ahead:

- **Both Workers redeployed with only the move relay and health** (dev `ed77f81d`, production `890a2795`): sign-in,
  accounts, purchases checked with Google Play, Plus Family and invites, where the habits live, Google Play's
  notifications (`/v1/google/notifications`) and the daily job all answer 404 or are gone. Live checks pass on both.
- **Both D1 databases deleted** (`often-enough-accounts`, which held no account, and `often-enough-accounts-dev`, which
  held 4 test accounts, 6 test purchases and 1 test family). Cloudflare can't bring them back.
- **The secrets deleted:** `GOOGLE_WIF_SIGNING_KEY` (dev and production) and `TEST_SIGN_IN_SECRET` (dev). The Worker
  has no secrets now.
- The account code (`src/accounts.ts`, `identity.ts`, `play.ts`, `refunds.ts`, their tests, `migrations/`, `google/`,
  `scripts/make-wif-key.mjs`) is deleted from this folder; it's in git history before 21 Oct 2026, with this README's
  old sections on accounts, keyless Google sign-in and refunds.

**Google Cloud, deleted the same day with `gcloud`** (project `often-enough`, signed in by the user): the Pub/Sub
subscriptions `play-notifications-dev` and `play-notifications-production`, the topic `play-notifications`, the
Workload Identity pool `cloudflare-workers` (Google erases a deleted pool for good after 30 days) and the service
accounts `play-purchases` and `play-notifications-push`. Play Console dropped
`play-purchases@…` from Users and permissions by itself once the service account was gone. **Left in Play Console, by
hand (no command line reaches it):** turn off Real-time developer notifications (Monetize with Play › Monetization
setup). **In the apps, deleted the same day:** the shared core's
`app.habits.account` package, Android's sign-in, account screens, family invites and their tests, and Plus Family on
Android; the menu row is now **Plus** (Free or Plus, Restore from Google Play, Redeem a code).

## Test

```sh
cd account-server
npm install
npm test               # the move relay's tests (test/move.test.ts) in the Workers runtime (Miniflare)
npm run typecheck
```

## Moving to a new phone with a code

Added 19 October 2026 (Rulebook **D15**, Current Work **136**, Figma `1461:2` 3–3.3 and `1549:2` 5–5.4). Two Durable
Objects on the free plan (SQLite-backed, `new_sqlite_classes`): **`MoveRegistry`**, one for the Worker, which hands out
channels `00`–`99`, each for 10 minutes; and **`MoveRelay`**, one per move, holding the two phones' WebSockets
(hibernating, so an idle wait costs nothing). The whole protocol is in the header of `src/move.ts`.

- **The code is 6 digits:** 2 for the channel (which old phone to reach, the only part the Worker sees) and 4 made on
  the old phone, which never leave it. The QR code is `oftenenough://move/NNNNNN`.
- **SPAKE2** (RFC 9382, P256-SHA256-HKDF-HMAC, as Magic Wormhole uses a password-authenticated key exchange) turns the
  code into a strong key on both phones; the Worker passes their messages without being able to read them, and never
  has the code or the key. The habits then go as AES-256-GCM frames of 48 KB **straight through the relay**: nothing is
  stored, so there is no R2 copy to delete (D15 allowed R2 for a large copy; streaming made it unnecessary).
- **One guess per code.** A channel takes one new phone ever. A wrong code shows only as confirmations that don't match:
  the old phone says `wrong`, the relay closes both (4001), and the old phone shows a new code at once. A new phone that
  leaves before pairing also ends the code (4002). So a stranger's chance is 1 in 10,000 per try, and every try costs
  them a new code; the `MOVE_LIMIT` rate limit (20 calls a minute per IP) slows anyone trying many.
- The old phone's token is sent as `Authorization: Bearer`, never in the URL (dev logs URLs; D11).

Tests: `test/move.test.ts` (9: a right code moves bytes both ways, a wrong code ends it for both, a code is single-use,
expiry, busy channels, and that every named export of the entry module is an entry point; a stray export broke
`wrangler dev`). The app's side against the real Workers runtime: run `npx wrangler dev --port 8787 --ip 0.0.0.0` here,
then `MOVE_SERVER=http://127.0.0.1:8787 ./gradlew :app:testDebugUnitTest --tests '*MoveLiveTest'` in `Android/` (a whole
move, a wrong code, the code after it); two emulators reach it at `http://10.0.2.2:8787` with the debug app's
`--es moveServer`. **On dev since 19 Oct 2026** (version `2bcaf388`): `npm run live:dev` and `MoveLiveTest` with
`MOVE_SERVER=https://api-dev.oftenenough.com` pass against it. **On production since 21 Oct 2026** (version `890a2795`, deployed whole: a Worker's first Durable Object migration can't go out gradually).

## Deploy dev

**On the user's Windows PC, wrangler's default login belongs to another Cloudflare account.** The user's own login is
kept apart, in the git-ignored `Research/Temp/wrangler-home` (signed in there on 19 Oct 2026), so every wrangler command
for this Worker sets it first (PowerShell: `$env:XDG_CONFIG_HOME="C:\Users\lalit\Desktop\store-reviews\Research\Temp\wrangler-home"`). Check with `npx wrangler whoami` (account `fd5d7e49…`)
before deploying; if the login has expired, start `npx wrangler login` with the same setting and the user approves it in
the browser.

```sh
npm run deploy:dev
npm run live:dev
```

## Production (T6: only with the user's go-ahead)

```sh
npm run release:production     # tests, then 5% → 25% → 100% with live checks, rolling back on a failure
npm run live:production        # the basics
```

A change that adds or changes a Durable Object class (a migration in `wrangler.jsonc`) can't go out gradually:
`wrangler versions upload` refuses it, so it's deployed whole with `npx wrangler deploy --env production` and checked
with `npm run live:production` (21 Oct 2026).
