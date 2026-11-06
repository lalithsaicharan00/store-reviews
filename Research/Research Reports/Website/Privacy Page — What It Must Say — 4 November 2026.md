# Privacy Page — What It Must Say

Written by Claude (Claude Code), 4 November 2026, at the user's request: the Privacy page comes first after the homepage, because the stores need it.

## The answer

**One page at `/privacy`: four plain questions at the top, then the full policy, written from what the app really does.** The address never moves, because the Android app links to it (`SettingsHome.kt`).

Three things needed attention before publishing:

1. **The developer's name: done.** Koyalakonda Lalith Sai Charan, the user's legal name, given on 4 Nov 2026. They're an individual with no company, so they're the person responsible for the data, and both stores show the legal name publicly anyway (Google's help for personal accounts, Apple's enrolment help). A chosen brand name can sit beside it, not replace it.
2. **The iPhone's old "Share Usage" switch.** See below: it must not come back in the rebuilt iPhone app, or the homepage and this page become untrue.
3. **Play Console's Data safety** still declares email, user IDs and purchase history from the account days. It has to match this page before production.

## What people want to see here (W6)

Users show the same few fears when they talk about privacy. In the 800 privacy-worded reviews sampled for the last audit, keyword searches found 36 on selling data and 50 on collecting or third parties. The sellers-of-data complaints read by hand were angry and specific: an app asking to share data with about 80 vendors, a policy that says it sells data while the app says data never leaves the device. These are small machine counts, used only to choose the four questions.

So the page opens with them, answered in a line each:

- What do you collect?
- Who can see my habits?
- Do you sell my data?
- How do I delete it?

Someone who wants more reads on. Anyone who doesn't has their answer in ten seconds. The question wording also suits search and AI tools. That layout is reasoned from first principles.

## What the app really does

Read from the Android code on 4 Nov 2026.

| Fact | Where |
|---|---|
| The app talks only to Google Drive, Google's sign-in token service and Google Play | Every `https://` address in the code |
| Drive access is `drive.appdata` only: the app's hidden folder | `GoogleDriveLink.kt` |
| The Google address is read for display, kept on the phone, never sent anywhere | `GoogleDriveLink.kt` |
| No ads (`AD_ID` removed), no analytics or crash library | `AndroidManifest.xml`, `build.gradle.kts` |
| Permissions: notifications, promoted notifications, exact alarms, full screen, start after boot, internet, network state | `AndroidManifest.xml` |
| Android's own backup is off | `data_extraction_rules.xml` |
| A support email starts with the app version, phone model and Android version | `Support.kt` |
| A restore's undo file lasts 30 days | `BackupCenter.kt` |
| A backup file holds every row, plus the name of the phone that made it, with no password | `Core/Backup File Format.md` |

**Written honestly on the page, though it's less flattering:** backup files aren't password-protected, deleting the app doesn't delete a cloud backup, and Google Play and the App Store show us overall numbers such as installs and crashes. "No analytics" is true of the app, and saying so without that last line would mislead.

## The iPhone's usage sharing

The old iPhone code still has a **Share Usage** switch and a PostHog connection (`iOS/Habits/Analytics/`, `Menu/PrivacyView.swift`). It can't send anything today: `AnalyticsProductionEnabled` is `false` in `Habits-Info.plist`, and the live site's older policy still describes it.

The approved homepage card and this page both say the app has no analytics. That's true of Android and of any iPhone build with the switch off. **When the iPhone app is rebuilt, leave this out, or both pages must change first.** It's on the checklist.

## What the stores and Google ask for

- **Google Play:** a public, active, non-geofenced page, not a PDF, linked in Play Console and inside the app. It must disclose how the app accesses, collects, uses and shares data, and name the entity on the store listing or the app itself. The app is named; naming the developer too is safer, and European law expects it.
- **Google's API policy:** all data accessed, used, stored, deleted or shared must be disclosed. Google doesn't prescribe exact words, and the sentence used here is the wording many apps use, so it's our choice. If the use of Google data ever changes, people must agree first.
- **Apple:** a privacy policy link in App Store Connect and in the app. **Apple's own full list for guideline 5.1.1 wasn't confirmed here:** the search returned only secondary sources. Check it against Apple's page before submitting the iPhone app.

## Also true now

- **The live page is wrong today:** it describes an optional account, Plus Family, usage sharing and iPad-era features. The new page replaces it entirely.
- **A lawyer hasn't read this.** It's plain and accurate to the code, but a legal review is worth having before launch.

## Sources

- [Google Play: User Data policy](https://support.google.com/googleplay/android-developer/answer/13327111) · [Play Console: privacy policy help](https://support.google.com/googleplay/android-developer/answer/9888076)
- [Google API Services User Data Policy](https://developers.google.com/terms/api-services-user-data-policy) (last updated 15 Feb 2024 when read; check for changes)
- [iubenda: privacy policy for iOS apps](https://www.iubenda.com/en/help/401-privacy-policy-for-ios-macos-apps-apple-app-store-review-guidelines) (secondary; quotes part of Apple's 5.1.1)
- Reviews: `Research/Temp/website-section-9/` (not in git)
- Earlier: [Website Reset](<Website Reset — Pages, SEO and AI Search — 4 November 2026.md>) · [Private and Backed Up](<Private and Backed Up — What the Homepage Still Missed — 4 November 2026.md>)
