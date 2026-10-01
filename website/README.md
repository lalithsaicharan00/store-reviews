# oftenenough.com

*Written by Claude (Claude Code), 1 Oct 2026.* The website: home, [privacy policy](public/privacy.html), [terms](public/terms.html),
[support](public/support.html), and [delete your account](public/delete-account.html) without the app (Google Play
requires one; Architecture 09 §7). Plain HTML and one stylesheet in `public/`; no build step.

**Hosting:** Cloudflare, as static assets only (`wrangler.jsonc` has no Worker script). Every request is a static-asset
request: free, unlimited, and never counted against the API's request limits
([Cloudflare](https://developers.cloudflare.com/workers/static-assets/billing-and-limitations/)). A classic Pages
project couldn't be created through the API (Cloudflare error 8000000; Pages now runs on this same platform); if you
prefer one, create it in the dashboard and upload `public/`.

| | |
|---|---|
| Test address | `https://site-dev.oftenenough.com` (its delete page talks to `api-dev`) |
| Live address | `https://oftenenough.com` (its delete page talks to `api.oftenenough.com`), once the steps below are done |

## Deploy and check

```sh
cd website
npx --prefix ../server wrangler deploy
TEST_LOGIN_SECRET=… NODE_PATH=$(npm root -g) node tests/site-check.mjs     # 21 checks in Chromium
```

`tests/site-check.mjs` loads every page in light and dark mode at phone width (no errors, no security-policy
violations, nothing wider than the screen), then runs the delete page end to end against the dev API: Google's
script is replaced by a stand-in, its answer becomes a real dev account, and the page's own calls must really delete it
(or, after Cancel, sign out), after downloading a copy of its data. Behind a TLS-inspecting proxy, set `CHROMIUM_TRUST_SPKI` to the proxy CA's key hash.

**How the delete page works:** Sign in with Google (Google Identity Services, the web OAuth client) → `POST
/v1/auth/google` (never `create`) → "Signed in as …" and a confirmation box → `POST /v1/account/delete`. Cancel calls
`/v1/account/signout`. The API answers the browser only from the origins in `WEB_ORIGINS` (server/wrangler.jsonc), and
only for those three routes. Apple sign-in on the web needs the Apple Developer account, so Apple users are pointed to
the app or support.

## To go live (needs you)

1. **Cloudflare DNS:** delete the parked Hostinger `A`/`AAAA` records for `oftenenough.com` (and any for `www`). Then add
   the two routes shown in `wrangler.jsonc` and deploy. (This API token can't edit DNS.)
2. **Google Cloud → Clients → the web client → Authorized JavaScript origins:** add `https://oftenenough.com`,
   `https://www.oftenenough.com` and `https://site-dev.oftenenough.com`. Until then Google refuses to show its button.
3. **Cloudflare Web Analytics:** it's set to inject its script into the zone's pages; the site's security policy blocks
   it. Turn the automatic setup off (or allow it and mention it in the privacy policy).
4. **`support@oftenenough.com`:** the pages use this address. Set up Cloudflare Email Routing to forward it to the
   shared support inbox (it adds MX records and asks you to verify the destination).
5. **Before the stores and the Google consent screen:** read the privacy policy against the shipped app. It follows
   Architecture 09's data map, including anonymous analytics (PostHog EU) and crash reports (Sentry), which aren't in
   the app yet; add the company's legal name and country if the stores or a generator require them. Then use
   `https://oftenenough.com/privacy` and `/terms` on the Google consent screen and in both stores, and
   `https://oftenenough.com/delete-account` as Google Play's deletion link.
