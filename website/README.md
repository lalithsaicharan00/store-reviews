# oftenenough.com

## Current verification release — 15 October 2026

**Live:** https://oftenenough.com and https://www.oftenenough.com, on Cloudflare Pages project `oftenenough` (`oftenenough.pages.dev`). Home, Download, Plus, Privacy, Help, Terms and Delete Account are plain static HTML, clearly marked work in progress. This is the user-authorized verification release, not the final Figma marketing implementation.

Source: `public/`. Regenerate with `python website/build-verification.py`. Validate with `python website/tests/verification-check.py` and, after deployment, `python website/tests/live-verification-check.py https://oftenenough.com`. No build dependencies or browser scripts are required. The old account-based browser test below is historical and does not describe current deletion behavior.

Deployment is Direct Upload, not Git integration. With an authenticated Wrangler session, deploy from the repository root using `npx wrangler pages deploy website/public --project-name oftenenough --branch main --commit-dirty=true`. The 15 October release used the connected Cloudflare plugin, its documented Pages API and a short-lived asset-upload authorization passed to `upload-pages-assets.py` through hidden terminal input. Never put credentials in source or CLI arguments. The older `website/wrangler.jsonc` remains the legacy development Worker's configuration; it is not this production Pages project.

Production deployment: `4399123f-1c45-4dab-8b38-80cc18995c00`. All seven routes, three aliases, assets and a real 404 passed HTTPS checks on the custom domain. Both custom domains are active. Automatic Cloudflare Web Analytics injection is disabled for this site; public support links opt out of email obfuscation using documented markup so they work without JavaScript. Details and rollback information: [Verification Deployment.md](<Verification Deployment.md>).

## Historical deployment notes — 1 October 2026

The notes below describe the superseded server-account website. The current app does not use a separate Often Enough habit account, and the current deletion page gives separate device/private-cloud/exported-copy instructions.

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
