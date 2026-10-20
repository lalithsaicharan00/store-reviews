# Verification website — 15 October 2026

Written by Codex, 15 October 2026, at the user's request. This is a plain static verification release, not the final Figma marketing implementation. The user explicitly authorized immediate hosting and said visual fidelity is secondary for this release.

## Scope and content

Home, Download, Plus, Privacy, Help, Terms and Delete Account are implemented in `public/`, with one stylesheet, an approved tonal brand asset and no client scripts or external fonts. Every page says **Work in progress** and clearly distinguishes planned platforms from public downloads. `/support` remains compatible, with privacy/terms aliases and a real 404.

The Figma references are `1284:2`, `1289:2245`, `1289:2657`, `1289:2916`, `1289:3145`, `1289:3401`, `1289:3603` in file `Ncccsm1l2O62GJ5xLSInqk`. All seven design contexts were read. No changes were made to Figma, the app or the API.

The old website described server-held habit backups, sign-in, Resend purchase emails and active crash collection. Those descriptions do not match the current architecture. The verification policy and deletion guide instead follow:

- `iOS/Habits/Backup/BackupFeatures.swift`: accounts removed with the server; iCloud enabled; iPhone Google Drive option currently disabled.
- `iOS/Habits/Backup/ICloudPage.swift` and `BackupCenter.swift`: local erasure, private-cloud deletion, export, import and separate dated backups.
- `iOS/Habits/Plus/PlusScreens.swift` and `PlusProduct.swift`: store entitlements, one-time Plus/Plus Family, restoration and private family records.
- `iOS/Habits/Menu/PrivacyView.swift`, `AnalyticsTransport.swift`, `AnalyticsLedger.swift`: optional usage sharing, a random installation identifier, EU endpoint, production delivery gate, seven-day queue expiry and no active crash collector.

No web sign-in/deletion form is simulated. The obsolete JavaScript for the old server-account form is removed. Deletion instructions explicitly distinguish local records, personal cloud, exported files, store purchases and support/usage requests. No operator jurisdiction, analytics provider retention period or guaranteed support response time was invented. Production analytics configuration/retention remains a pre-release gate, described on the policy page.

## Validation

`python website/build-verification.py` regenerates the HTML, CSS and supporting static files without dependencies. `python website/tests/verification-check.py` passes: seven required pages plus support/404, 160 internal link/asset checks, notices, unique IDs, one H1 per document, strict CSP, exact approved logo, no scripts or fake sign-in. The existing `site-check.mjs` tests the historical account-based website/API flow and is not the acceptance test for this static release.

All seven pages were visited in the real in-app browser at a 320px viewport: no horizontal overflow, broken images or scripts. Desktop Home and narrow Delete Account were visually inspected. This verifies responsive static presentation, not native app/device performance. `check_rules.sh` and `git diff --check` passed.

## Hosting status

The repository's earlier site used Cloudflare static Worker assets at site-dev.oftenenough.com; its existing configuration is preserved. The user now requests Pages on oftenenough.com. Cloudflare plugin discovery returned no available connector. Wrangler 4.145.0 is available through npm; the saved OAuth login is expired and cannot refresh. A new device-login request with account/user read, Pages write and zone read is awaiting the user's Cloudflare authorization. No token or credential is stored in the repository.

**Completed after reconnection:** The user connected the Cloudflare plugin. Its authenticated account and active oftenenough.com zone were verified; the separate CLI device code had expired, but no additional sign-in was needed for the plugin. Cloudflare Pages project `oftenenough` was created with production branch `main`. Assets were uploaded using a short-lived Pages JWT via hidden terminal input; no credential was written to a file or command argument.

Final successful production deployment: `4399123f-1c45-4dab-8b38-80cc18995c00`, completed 15 October 2026 at 11:13:33 UTC (16:43:33 IST). Immutable deployment URL: https://4399123f.oftenenough.pages.dev. Public site: https://oftenenough.com; https://www.oftenenough.com also responds over HTTPS. Both custom domains report active verification and validation.

The root DNS record `79851642f386a20b609e2fef46dd3751` changed from proxied A `2.57.91.91` to proxied CNAME `oftenenough.pages.dev`. The www CNAME `b005ff5c14dac622bf72f6d77b26ce0a` changed from `oftenenough.com` to `oftenenough.pages.dev`. These prior values are retained for rollback. API and site-dev records and their Worker deployments were untouched.

The first live check exposed Cloudflare's automatic Web Analytics beacon and email obfuscation. Web Analytics site `3c20cc78632042b2a2b0e23ec3ebb41e`, ruleset `e2194bbb-f6c3-471c-9100-edf30988ec37`, was previously auto-installed/enabled with lite mode true. Its enabled flag is now false; no analytics history was deleted. Support-email HTML uses Cloudflare's documented `email_off` comments. Zone-wide security settings were not changed. The final public HTML has zero script tags and functional `mailto:` links, matching the static privacy policy and strict CSP.

Final live checks passed: all seven pages return 200 with the development notice and no scripts; favicon and CSS return 200; `/support`, `/privacy-policy` and `/terms-and-conditions` resolve to the correct pages; an unknown URL returns the real 404. The live homepage was inspected in the browser: HTTPS, correct title, no horizontal overflow, zero scripts and a working support email link. Earlier local phone-width checks remain valid because the final HTML changes only added non-rendering email comments.

No production API deployment, Git push, local branch or worktree creation was made. Figma and the native app remain unchanged. The old simulator capture task was not resumed for this explicitly simplified verification release.

## Optional account policy revision — 15 October 2026

At the user's request, `build-verification.py` now adds **Your optional account** and a short-version account summary to Privacy. It lists optional Google/Apple sign-in, account/provider IDs, a masked email hint (never the full email), verified purchase product/store/date and refunds, family membership, cloud/private cloud account ID and the last device sync time. It explains the purpose, Cloudflare Worker processing and encryption in transit, and explicitly excludes habits, tasks, logs and notes. Privacy and Delete account explain **Plus & Account › Delete my account**, family-owner deletion, separate device/cloud erasure, and purchases remaining with Google/Apple so signing in again restores Plus.

Source evidence: Rulebook D15/D16; Android A15 in `Android/Docs/README.md`; `Android/app/src/main/kotlin/com/oftenenough/app/app/account/Accounts.kt` (account server contract and deletion); `AppGraph.kt`'s `openAccounts` (debug/test stand-in, `NoAccountServer` in release). Inspected main at `11bf7531`. The public copy therefore says the account service is **being prepared and not live in the current release build**; this website deployment does not activate or deploy that service. The collection categories and purposes follow the user's supplied Google Play Data safety declarations.

Regenerated successfully. `website/tests/verification-check.py` passes: seven required pages plus support/404, **161** local links/assets, development notices, one H1, unique IDs, strict CSP, exact approved logo, and no scripts or fake sign-in. SHA-256 comparison against the pre-update build confirms that only `privacy.html` and `delete-account.html` changed; all other public files are byte-for-byte unchanged. `git diff --check` and `iOS/Tools/perf/check_rules.sh` pass.

Deployment pending renewed Cloudflare authentication: this session has no callable Cloudflare plugin (plugin search returned no matches), and Wrangler 4.145.0 reports the saved OAuth login expired and unable to refresh. A device sign-in with Pages write and account/user/zone read scopes timed out after its five-minute authorization window. The in-app Cloudflare dashboard also opens at its sign-in page. Reconnect Cloudflare or complete a fresh CLI sign-in before publication. The preceding successful production deployment remains live until this revision is published; no new deployment or live-policy verification is claimed yet. No DNS change, Git push, local branch/worktree or account-service deployment was made for this revision.
