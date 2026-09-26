# Backlog: decide later

Questions parked on purpose, to settle once every architecture topic is done. New questions that come up while
working through the topics are added at the bottom, with the topic they came from.

## Decided so far

| Date | Decision | From |
|---|---|---|
| 26 Sep 2026 | **Suggest signing in both after 3 days of use *and* at key moments** (5th habit, a purchase, a phone move), **at most once a week** | 01 Accounts §3.2 |
| 26 Sep 2026 | **After a premium purchase, always suggest linking an account** ("Keep Plus on every phone you own"). Never forced | 01 Accounts, 02 Billing §3.2 |
| 26 Sep 2026 | **Native billing (StoreKit 2, Play Billing), no RevenueCat.** Our apps sell lifetime purchases only. Signed-in purchases are sent to our server, verified and recorded on the account, so they unlock on iPhone and Android. Refunds, cancellations and failed payments reach the server through store notifications (plus a daily Google voided-purchases check) and remove Plus everywhere. Revisit RevenueCat only if a subscription is ever added | 02 Billing §3.11 (was #6) |
| 26 Sep 2026 | **Kotlin Multiplatform shared core + native UI + documented behavior + shared fixtures.** One Kotlin implementation for days, schedules, streaks, progress and merge rules. SwiftUI stays native; web and the initial Windows PWA use Kotlin/JS. Platform services remain adapters. Follow established production references and dedicated KMP support paths | [Accepted decision](<Shared Core Decision.md>), [research](<Shared Core Research.md>), 07 Surfaces §9 (was #15) |
| 26 Sep 2026 | **Email OTP login and purchase confirmations at launch.** No passwords; guest purchases require no email; confirmation follows server verification and never blocks Plus. Templates and authentication stay in our backend, with a replaceable sender for future Cloudflare migration. Initial provider remains open | [Email Delivery Decision](<Email Delivery Decision.md>), 01 Accounts §3.3/3.8, 02 Billing (resolves launch scope from #3) |

## Open questions

| # | Question | From | Options | Current lean |
|---|---|---|---|---|
| 1 | **Apple Family Sharing for Plus** | [02 Billing §3.6](<02. Billing and Entitlements.md>) | On: one purchase covers up to 6 people, but Android can't match it. Off: each person buys | On (users expect it; family plans without invites failed) |
| 2 | **Companion trial** | [02 Billing §3.7](<02. Billing and Entitlements.md>) | A free week with our reminder 2 days before it ends, or no trial (a clear monthly price, cancel any time) | Parked: no subscriptions planned (26 Sep 2026) |
| 3 | **Initial transactional email provider** | [Email Delivery Decision](<Email Delivery Decision.md>) | Resend, Brevo or another sender; OTP login and purchase confirmation scope is decided above. Cloudflare sending is a later paid-plan option | Resend for low-volume integration; Brevo for more daily free allowance. Final selection pending |
| 4 | **Sign-in prompts: the details still to research** | [01 Accounts §3.2](<01. Accounts and Identity.md>) | Timing is decided (see above). Still open: the exact wording, which "key moments" count, whether the post-purchase prompt comes before or after the "Plus is yours" screen, and what happens if they tap "Not now" | – |
| 5 | **CloudKit sync for people without our account** (iPhone ⇄ iPad without signing in) | [03 Backup §6](<03. Backup Without Our Account.md>) | Add CloudKit sync alongside our server, or require one-tap sign-in for multi-device | No (two sync systems double the failure surface) |
| 7 | **Offline local-network phone move** (same Wi-Fi, no internet; users praised a Bluetooth transfer) | [04 Migration §4.2](<04. Phone Migration.md>) | Add a local-network fallback to the QR relay, or relay only | Relay only at launch |
| 8 | **Day start later than 06:00** (up to noon, for night-shift workers) | [05 Sync §4.2](<05. Sync Engine.md>) | 00:00–06:00 only, or allow up to 12:00 | Allow it if testing shows no confusion |
| 9 | **Shared habits between two accounts** (partners, families) | [05 Sync §14](<05. Sync Engine.md>) | Build a sharing model, or keep every habit single-owner | Not at launch |
| 10 | **Writing to Apple Health / Health Connect** (e.g. mindful minutes) | [05 Sync §9](<05. Sync Engine.md>) | Read-only, or also write | Read-only at launch |
| 11 | **Per-habit time zone** ("count this in my home time zone") | [05 Sync §14](<05. Sync Engine.md>) | Add it, or rely on the per-reminder local/fixed choice | No |
| 12 | **Public status page** | [06 Server §15](<06. Server on Cloudflare.md>) | A free hosted status page, or our own on Cloudflare Pages fed by `/v1/status` | Our own |
| 13 | **Shutdown promise wording** (6 months' notice, final offline update, premium stays unlocked) before it goes in the privacy policy | [06 Server §12](<06. Server on Cloudflare.md>) | Publish as written, shorten the notice, or leave it out | Publish as written (it costs almost nothing to honour) |
| 14 | **Where the weekly off-Cloudflare copy goes** | [06 Server §9](<06. Server on Cloudflare.md>) | Backblaze B2, or a machine we own | B2 |
| 16 | **Selling Plus on the web** | [07 Surfaces §8.3](<07. Other Surfaces.md>) | None (web unlocks from the account), or web checkout with one-tap cancel in the app | None at launch |
| 17 | **Fitbit / Garmin watch apps** | [07 Surfaces §5](<07. Other Surfaces.md>) | Build, or Apple Watch + Wear OS only | Not at launch |
| 18 | **Native Windows app** | [07 Surfaces §8.2](<07. Other Surfaces.md>) | Installable web app only, or a native app too | Web app first; native only if demand shows |
| 19 | **Grandfathering free features** (existing users keep what was free when they started) | [08 Release §8](<08. Release Safety and Operations.md>) | Grandfather per account, or apply new limits to everyone with notice | Grandfather (12 reviews punish taking features back, mean 1.8) |
| 20 | **Supported OS versions** | [08 Release §7](<08. Release Safety and Operations.md>) | iOS current + two before; Android 10+; or wider or narrower | As stated |
| 21 | **Crash reporting tool** | [08 Release §11](<08. Release Safety and Operations.md>) | Sentry, Firebase Crashlytics, or only Apple and Google's own reports | Sentry free tier (iOS, Android and the Worker in one place) |
| 22 | **Support tooling** | [08 Release §9](<08. Release Safety and Operations.md>) | A shared inbox + our console, or a help-desk service | Shared inbox + console until volume grows |
| 23 | **Analytics provider** | [09 Privacy §6](<09. Privacy and Account Deletion.md>) | PostHog EU cloud, self-hosted PostHog, or no analytics at launch | PostHog EU, content-free, with an off switch |
| 24 | **Apple 5.1.3(ii): Health data in iCloud** | [09 Privacy §10](<09. Privacy and Account Deletion.md>), [03 Backup §3.2](<03. Backup Without Our Account.md>) | Leave Health-sourced entries out of our iCloud backups (re-read from Health after restore), or include them | Leave them out; confirm with App Review |
| 25 | **EU data residency** for EU accounts | [09 Privacy §11](<09. Privacy and Account Deletion.md>) | Pin EU accounts' Durable Objects to the EU jurisdiction, or one global location | Pin, if it costs nothing extra |
| 26 | **Lawyer review before launch** (privacy policy, data map, sync consent wording, EU representative, where the company is registered) | [09 Privacy §11](<09. Privacy and Account Deletion.md>) | — | Needed |
| 27 | **Figma "App Architecture" diagram** (topic 10) | [README](README.md) | Draw now, or after you've gone through this backlog | Waiting for your go-ahead, as you asked |
