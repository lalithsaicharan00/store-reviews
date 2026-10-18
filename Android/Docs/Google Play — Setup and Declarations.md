# Google Play — Setup and Declarations

Written by Claude (Claude Code), 15 October 2026, while the user set up Google Play and Google Cloud step by step.
Everything that was configured, every answer given to Google, and what is still open. **No secrets are here**
(D11): passwords, the review code, bank, tax and KYC details stay with the user.

## Identity and signing

| What | Value |
|---|---|
| App | **Often Enough**, `com.oftenenough.app`, Play Console app created 15 Oct 2026 (Free, English (US), App) |
| Store name | `Often Enough: Habit Tracker` |
| Upload key | `C:\Users\lalit\Keys\often-enough-upload.jks` on the user's PC (alias `upload`, RSA 4096, PKCS12, valid to 2054), password only in the user's password manager. Upload key SHA-1 `6F:EE:0F:BE:E0:A9:53:51:3A:76:9B:54:02:45:1A:97:AD:8E:33:46` |
| Play app signing key | Google-generated. SHA-1 `92:20:69:D3:CA:B6:41:B1:F2:1B:A2:1A:04:E8:3C:E0:B5:B2:B6:FB`; SHA-256 `18:52:5B:FA:DB:66:C9:E6:7A:3B:74:B3:36:25:1B:89:FC:4D:54:E3:B0:B0:B3:DB:66:F3:9F:B7:D3:25:48:9E` (for `/.well-known/assetlinks.json`, so `oftenenough.com/join/…` opens the app) |
| This PC's debug key | SHA-1 `DA:6D:3F:E8:4C:8C:DB:90:BA:4A:91:81:91:F2:65:BF:50:4F:AC:41` |

**Building a signed release** (the user's own PowerShell, so the password never leaves it): `Android/README.md` has the
Gradle commands; `build.gradle.kts` signs with `ANDROID_UPLOAD_KEYSTORE` / `ANDROID_UPLOAD_KEYSTORE_PASSWORD` when set.
Windows PowerShell 5.1 has no `PtrToStringAuth`: read the hidden password through `PSCredential` instead. Every upload
needs a higher `versionCode` (1 was the first internal upload, 2 the first closed test).

## Google Cloud (project "Often Enough", Google Auth Platform)

| Client | Type | Use |
|---|---|---|
| "Drive sync tests" | Web | The automated Drive tests only (GitHub secrets `GDRIVE_TEST_*`) |
| Often Enough sign-in | Web | Sign in with Google: the app asks for an ID token for it, the Worker will check it. Its ID is the repository **variable** `GOOGLE_WEB_CLIENT_ID` and `googleWebClientId` in the PC's `~/.gradle/gradle.properties`. Its secret is unused |
| Often Enough Android (debug, this PC) | Android | `com.oftenenough.app` + the debug SHA-1 |
| Often Enough Android (Google Play) | Android | `com.oftenenough.app` + the Play app signing SHA-1 |

**Checking Play purchases from the Worker:** the Google Play Android Developer API is enabled, and the service account
`play-purchases@often-enough.iam.gserviceaccount.com` (no Cloud roles) is invited in Play Console › Users and
permissions for Often Enough only, with View app information (read-only), View financial data, and Manage orders and
subscriptions (15 Oct 2026). **No key is made** (the user, 16 Oct 2026): the Worker acts as it keyless, through Workload Identity Federation (`account-server/README.md`, "Google Play, keyless").

The consent screen is **In production** (published 15 Oct 2026; External). Branding: app name Often Enough, home page
`https://oftenenough.com`, privacy `/privacy`, terms `/terms`, authorized domain `oftenenough.com`, **no logo** (a logo
needs Google's brand verification first). Only basic scopes (name, email, account ID), so no verification was needed.

Cloudflare: Wrangler is logged in on the user's PC (OAuth, saved outside the repository) for the Plus account Worker.

## Payments (all entered by the user)

- Payments profile: Individual, India, INR, business name = the user's name, category Computer Software.
- Google identity verification (PAN) and BillDesk PA-CB KYC (RBI rules; needed for buyers outside India): submitted
  15 Oct 2026, in review. Website given: `www.oftenenough.com`; app: the Play store link.
- 15% service fee: account group = this developer account only (not the employer's account the user works on), enrolled.
- Bank account for payouts: added, set as the primary payment method (15 Oct 2026).
- US tax form W-8BEN: submitted 15 Oct 2026 (individual, India; Foreign TIN = PAN; treaty: Other Copyright
  Royalties Article 12 ¶2(a)(ii) at 15%, Services/business income Article 7 ¶1 at 0%, no permanent establishment;
  no activities in the US; paperless delivery; no unchanged-status affidavit). Google reviews it.

## Declarations (App content), as answered

| Item | Answer |
|---|---|
| Privacy policy | `https://oftenenough.com/privacy` (needs the optional-account section, below) |
| Ads / Advertising ID | No ads · advertising ID **No** (the manifest removes `AD_ID`) |
| Sign in details | Yes (payments, optional Google sign-in, QR codes, biometric App lock, actions on another device). Instructions: free plan needs no sign-in; Plus via **Plus & Account › Redeem a code** with the review code (`PlusCodes`; only its SHA-256 is in the app). "Full access including paid content" ticked. A random 12-character code was made on the user's PC on 15 Oct 2026 (kept in their password manager as "Often Enough review code"); its fingerprint is in the app from version 4. **Once version 4 is live, put the random code in Sign in details, then remove the first code's fingerprint** |
| Content rating | All other app types; everything No except digital purchases Yes |
| Target audience | 13–15, 16–17, 18+ (not under 13, so not the Families policy; 18+ alone can restrict availability) |
| Data safety | Collected, not shared, optional, encrypted in transit, deletable: Email address, User IDs (account management), Purchase history (account management, app functionality). Habits are not "collected": they go only to the person's own Google Drive (Google's FAQ exemption). Account creation: OAuth. Delete URL `https://oftenenough.com/delete-account` |
| Government apps, Financial features | No |
| Health | **Activity and fitness** only (Google's definitions: the app records exercise; it is not dedicated to sleep and gives no meditation guidance) |
| Category, contact | Productivity (21 of the top 30 habit trackers on Play are); tags pending the research (`Research/Research Reports/Store Listing and ASO/`); contact email the user's Gmail; no phone |

## Store listing

Assets in `Research/Temp/play-listing/` (not in git): the 512 icon from `Brand/Assets/GooglePlay/`, a 1024×500 feature
graphic, and 8 phone screenshots from the App Store set (Figma `1206:2`, widened to Play's 2:1). **They show an iPhone:
replace them with Android screenshots before Production.**

## Plus products (created and active, 15 Oct 2026)

| Product ID | Name | Price | Purchase option |
|---|---|---|---|
| `com.oftenenough.app.plus` | Plus | US$24.99, converted by Google per country | `buy` (Buy) |
| `com.oftenenough.app.plusfamily` | Plus Family | US$59.99 | `buy` |
| `com.oftenenough.app.plusfamily.upgrade` | Plus Family upgrade | US$35.00 | `buy` |

All Digital content, tax category Digital app sales, one per purchase, every country. Google doesn't check that an
upgrade buyer owns Plus: the app offers the upgrade only to people who do. Real Play Billing is in the app from
version 3 (`PlayPlusStore`); version 2 still uses the stand-in store. Play promo codes are not needed yet (reviewers
use the in-app review code, testers are license testers); they're for giveaways and press after launch.

## Testing tracks

- **Internal testing:** an email list with the user's four real devices.
- **Closed testing – Alpha:** all 177 countries, the same list; release `2 (1.0)` published 15 Oct 2026; release
  `3 (1.0)` (real Play Billing) sent for review the same evening. For a new
  personal account, Production unlocks only after **12+ real testers stay opted in for 14 days**; own accounts on
  emulators don't count and risk the account. More testers go into the same list without a new release.

## Still open

1. The privacy policy's "Your optional account" section (handed to Codex, who owns the verification website).
2. ~~License testers~~ (done: Settings › License testing, the "Family & me" list of 4, RESPOND_NORMALLY). Version 3
   is in review; once it's out, try a test purchase of each product on a tester's phone (Play's test card), then
   Restore on a second phone.
3. 12+ closed testers for 14 days, then **Apply for production** (needs Android screenshots, the random review code in
   Sign in details, and the Worker for accounts).

### Store polish: once the app is finished and thoroughly tested (the user, 15 Oct 2026: "let's add them later")

Not before; set none of these until the user starts this step.

- **Tags** (Store settings › Tags › Manage tags): **Productivity**, then **Self-help**, only if those exact names are in
  the picker; two, not five ([evidence](<../../Research/Research Reports/Store Listing and ASO/Google Play Listing Tags — Evidence and Launch Shortlist.md>)).
  No "Habit tracker" tag exists; don't add half-fitting ones.
- **Store listing**: rework the text, the feature graphic and the screenshots (Android screenshots replace the iPhone
  ones).
- **Regional pricing**: per-country prices for Plus, Plus Family and the upgrade (the US$ base prices stay as set; today
  Google converts them per country).
