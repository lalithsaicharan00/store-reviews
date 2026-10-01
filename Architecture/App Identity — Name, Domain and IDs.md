# App identity: name, domain and IDs

Written by Claude (Claude Code), 1 October 2026. **Decided by the user:** the app is **Often Enough**, and its domain is
**oftenenough.com**. Every identifier below comes from that domain, written in reverse (reverse-DNS), which is what
Apple and Google ask for.

> **When you merge any branch:** the IDs below win. Before `main` moves, run
> `git grep -n 'lalithsaicharan\.habits'`. It must find nothing outside `Research/` and old checklists. The GitHub repo
> name `lalithsaicharan00/store-reviews` (for example `CI_REPOSITORY` in `server/wrangler.jsonc`) is the repository,
> not an app ID: keep it.

## Why this matters

Once the app is registered in the Apple Developer account and uploaded to App Store Connect, **its bundle ID can never be
changed**. The same goes for the Android `applicationId` once it's on Google Play, and for in-app purchase product IDs:
a deleted product ID can't be used again. So these are set once, here, before anything is registered.

## The IDs

| What | Value | Where it lives |
|---|---|---|
| Name on the home screen | **Often Enough** | `INFOPLIST_KEY_CFBundleDisplayName` (app and widget extension) |
| iPhone app bundle ID | `com.oftenenough.app` | `project.pbxproj` (app target) |
| Widget and Live Activity extension | `com.oftenenough.app.LiveActivity` | `project.pbxproj` (extension target). An extension's ID must start with the app's ID |
| UI tests | `com.oftenenough.app.uitests` | `project.pbxproj`. Never registered with Apple |
| App Group (widgets read the app's data) | `group.com.oftenenough.app` | `Habits.entitlements`, `HabitsLiveActivity.entitlements`, `WidgetSnapshot.group` |
| Background refresh task | `com.oftenenough.app.refresh` | `Habits-Info.plist` (`BGTaskSchedulerPermittedIdentifiers`), `AppModel.refreshTaskID` |
| In-app purchases | `com.oftenenough.app.plus`, `com.oftenenough.app.plusfamily`, `com.oftenenough.app.plusfamily.upgrade` | `iOS/OftenEnough.storekit`, then App Store Connect and Play Console (same IDs on both) |
| Sign in with Apple audience | `com.oftenenough.app` | `server/wrangler.jsonc` → `APPLE_AUDIENCES`, `APPLE_BUNDLE_ID` |
| API | `api.oftenenough.com` (dev: `api-dev.oftenenough.com`) | `server/wrangler.jsonc`, the app's server address |
| Android `applicationId` (later) | `com.oftenenough.app` | the same as iPhone, as most apps on both stores do |
| Apple Watch app (later) | `com.oftenenough.app.watchkitapp` | Apple's naming for a companion Watch app |
| Sign in with Apple on the web (later) | Services ID `com.oftenenough.web` | Apple Developer account, only when the web app is built |

The Xcode project and target names stay `Habits`. Users never see them, and renaming them would cause conflicts in
every branch for no gain.

**Never hard-code the Apple Team ID.** It arrives with the developer account; Xcode's signing settings carry it.

## State of the branches (1 Oct 2026)

| Branch | State | When it's merged |
|---|---|---|
| `claude/server-and-sync` (from `claude/gracious-newton-exo5ow`) | **Already renamed:** app and extension IDs, refresh task, display name, StoreKit products, server audiences | Keep its values |
| `integration` | Still `com.lalithsaicharan.habits`. The user asked not to rename it during the merge | Take the new IDs. `iOS/Tools/perf/measure_perf_driver.sh` (`BUNDLE=`) came from `undo-research` and isn't in the rename commit: change it too |
| `codex/iphone-widgets` | App Group is already `group.com.oftenenough.app`, but the bundle IDs are still the old ones | The new bundle IDs must come with it. Apple only lets an app use an App Group registered under the same team, and the IDs must match what's registered |

## What gets registered, and where (once each account is ready)

- **Apple Developer account:** the App IDs `com.oftenenough.app` and `com.oftenenough.app.LiveActivity`, each with the
  App Groups capability (`group.com.oftenenough.app`). The app also gets Sign in with Apple, and later HealthKit. Then
  create the App Store Connect app record and the three in-app purchases with the IDs above.
- **Google Cloud:** OAuth clients for Google sign-in (an iOS client using bundle ID `com.oftenenough.app`, and a web
  client). Their client IDs go into `GOOGLE_AUDIENCES`. OAuth clients don't use free-trial credit.
- **Google Play Console:** the app `com.oftenenough.app` and the same three product IDs, once the Android app exists.
- **Cloudflare:** `oftenenough.com` DNS, the Worker routes above.
