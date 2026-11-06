# Onboarding and Restore — iOS Native

Written by Claude (Claude Code), 5 November 2026, at the user's request: "in Android, they have to select Google Drive because it isn't a default thing. But in Apple … iCloud is a default thing … So do we really need this screen? Or … do we only just need a backup from file? So do that research and based on that, update the screen."

Figma: file `zLgBjb7M7Fp6UN0pg7J3a8`, page onboarding (`1:5`), section `onboarding components` (`796:42464`), and the 12 flows under it. The Activity indicator is in section 10 on the design system page.

## Where each part comes from

- **What iOS draws:** real SwiftUI on the iPhone 17 Simulator, iOS 26.5, in a throwaway app (`Research/Temp/ios-onboarding/`, git-ignored): `ContentUnavailableView`, `ProgressView`, `.alert`, `.fileImporter`.
- **What the app does:** its code. `TodayView.swift` (the empty Today), `OnboardingReturning.swift`, `RestoreViews.swift`, `PlusScreens.swift`, `PlusStore.swift`.
- **What Apple says:** the Human Interface Guidelines on launching, loading, progress indicators, onboarding, buttons, alerts and iCloud, and CloudKit's `accountStatus`.

## Do we need the "where is your backup" screen? No

Android asks because Google Drive is something a person connects: pick an account, allow access. iCloud isn't.

- **Apple's guidance is to make iCloud work by itself.** Don't ask people whether to use it. If it's off, no alert: say so quietly.
- **An app can't sign anyone in to iCloud.** CloudKit only reports the account's status, and the app can't read which account it is. Only Settings can sign someone in, so a screen offering "iCloud" would have nothing to do.
- **The app already behaves this way (D14):** a fresh install fetches first, and habits come back by themselves.

So on iPhone:

| Android | iPhone |
|---|---|
| Restore from a backup (Google Drive or a file) | **Deleted.** Restore from a Backup opens Apple's file picker directly |
| Choose a Google account, Allow Google Drive | **Deleted** |
| No backup found | **Deleted.** With iCloud empty, Today simply opens |
| Wrong Google account flow | **iCloud is off** flow: Today looks the same, the person turns iCloud on in the Settings app, then habits come back by themselves |

A file stays because moving from Android is a file (D15), and the picker reaches On My iPhone, iCloud Drive and anything else in Files.

## The screens

| Component | Was | What it is now |
|---|---|---|
| **Launch screen** (`553:2427`) | Splash with the logo | Today's background and nothing else. Apple asks for a launch screen nearly identical to the first page, with no logo or words. The app's generated launch is already blank |
| **Today, no habits yet** (`547:2419`) | Cookie shape, Android buttons | `ContentUnavailableView`: `checklist` symbol, Title 2 Bold, Subheadline, New Habit prominent and Large, Restore from a Backup plain. One component, with no iCloud versions |
| **Restoring** (`582:7893`) | Morphing shape, Bottom bar, Drive words | One page: iOS's `ProgressView` with a label. Its Label property says Restoring Your Habits… (with Cancel) or Looking in iCloud… (without) |
| **Activity indicator** (`4166:8524`) | New | iOS's spinner, read from the phone: Large 37, Regular 20, 8 spokes, head at 85 % fading to 27 % |
| **Plus isn’t on this iPhone** (`4168:7890`) | Android page, Play Store words | `Made on=iPhone`: Restore Purchases prominent and Large, Contact Us plain. `Made on=Android`: Contact Us only, because Plus can't cross stores (D16) |
| **No internet** (`582:8426`) | Android page | `wifi.slash`, Apple's own "No Internet Connection", "If you have habits in iCloud, they'll come back once you're online.", Try Again prominent and Large, Not Now plain. For iCloud only |
| **Restore Purchases, no internet** (`4189:4128`) | New | `.alert` over Plus isn't on this iPhone: No Internet Connection, "Connect to restore your purchases. Nothing has changed.", OK |
| **Choose a file (Apple’s picker)** (`582:8487`) | Android's picker | Apple's document picker, read from the Simulator: sheet from y 72, Back, title, ✕ and ⋯ sharing a capsule, Search, grid, count, tab bar with Recents, Shared, Browse |
| **That isn’t a backup** (`4172:6415`) | Full Android pages | `.alert` over Today. Not a backup: Cancel, Choose File. Newer version: Cancel, Update |
| **Email** (flows 4 and 5) | Android's compose | Apple's Mail sheet, with App Store words in flow 4. Flow 5 asks for "My order number" and names no other store |

## Two buttons

**One prominent button for the likeliest action, Large, and the other plain.** The main action is `.borderedProminent` with `.controlSize(.large)`: Figma's Button, Large, 50 tall, Body Regular; 32 below it, a plain button in Ink, Subheadline.

**Corrected the same day (the user: "the buttons are very weird here. They are looking very small … is this how native apps in the iOS look like?").** This page first used the size `ContentUnavailableView` gives a button by default, 31 tall in Subheadline, and called that native. It was only the default. Apple's own empty screen in Shortcuts has the same layout with a much bigger button, the same size as `.controlSize(.large)`. Files' No Recents has no button.

| In the Simulator (iPhone 17, iOS 26.5) | Tall |
|---|---|
| Default inside `ContentUnavailableView` | 31 |
| `.controlSize(.large)`, inside it or on its own | 54.3 |
| `.controlSize(.extraLarge)` inside it | 54.3 |
| New Automation in Shortcuts | 54.3 |

**Figma stays at 50, section 05's Large, because that was read from the phone** (iPhone 16, iOS 26.6). The Simulator's buttons read taller than the phone's at every size: 31 against 28, 38 against 34, 54 against 50. We don't know why yet.

Words are verbs in title style: New Habit, Try Again, Restore Purchases, Contact Us. **Restore Purchases replaced Check again** because it's Apple's word, already the app's, and App Review expects it.

## The animation

**iOS's animation here is `ProgressView()`, and nothing custom.** Apple says standard indicators suit most apps and custom ones are mainly for games. We can't tell how long a restore takes, so it's the spinner, not a bar.

**One page, not three (the same day, the user: "I don't know why we have like a three restoring screens … if we only need one, then it's better to remove").**

| It was | What the app knows | Now |
|---|---|---|
| Looking in iCloud | One state in the code: `!firstLookDone \|\| bringingIn != nil`. It can't tell whether anything is coming until it arrives | **Looking in iCloud…**, no button |
| Restoring Your Habits, From iCloud | The same state | **Deleted.** Flows 2, 8 and 10 go from Looking straight to Today |
| Restoring Your Habits, From your backup file | The person just picked the file, so the line said nothing new | **Restoring Your Habits…**, Cancel 20 below until writing starts |

The words can't be fewer than two: a new person isn't restoring anything, and a file isn't in iCloud. The rest is the same, so it's one component with a Label and a Cancel switch.

**It's now what iOS draws, not an empty page with a spinner.** `ProgressView { Text(…) }.controlSize(.large)` is the spinner at 37, 8, then Body in Secondary Label, measured in the Simulator (`Research/Temp/ios-onboarding/`). The bold title and second line were `ContentUnavailableView`'s, which is for a page with nothing to show. Apple asks for a short, accurate description.

**Looking in iCloud… shows only if it takes more than a second.** Apple keeps indicators for loading that takes "more than a moment or two", and the launch screen before it is the same empty background, so a quick look shows no spinner at all. A file restore keeps the app's one second on screen (`settle`), because the person asked for it and should see it happen. The flows still draw Looking, for when it's slow.

In Figma the Activity indicator turns in eight hard steps, one a second round, as the spokes do on the phone (`manualKeyframeTracks`, ROTATION −45° every 0.125 s, HOLD). An export of one copy showed eight different frames in the first second.

## Offline

The app works without internet (D1). **No internet shows only in onboarding,** on a fresh install that can't reach iCloud (the user, 5 Nov 2026: "our app will actually work without internet. So these are just in the onboarding"). Everything else that needs a connection fails quietly or says so where it happens.

- **It goes on by itself once the phone is online,** with Try Again to ask at once. Not Now opens Today, and habits come back by themselves later, so nobody has to wait here.
- **The words changed** because a brand new person has no habits in iCloud: "Connect to look for your habits in iCloud" said they did.
- **Plus has no No internet screen on iPhone (the same day, the user: "plus status by default, it will come back").** Apple says a reinstall or a new device "automatically has all transactions available to it upon initial launch", and `Transaction.currentEntitlements` is what the app reads. So a backup over the free limit restores straight on for someone with Plus.
- **If Plus hasn't come back,** the person sees Plus isn't on this iPhone, the same as online. A No internet page first would only delay that answer. Only Restore Purchases (`AppStore.sync()`) needs the connection, so it answers with an alert.
- **Android keeps its No internet page for Plus** (A30). The user's new word here is about the iPhone, and Android is unchanged.

**Not tested:** Apple's page doesn't say the entitlements read works with no connection at all, and the Simulator has no real App Store account to try it. If it comes back empty offline, someone with Plus sees Plus isn't on this iPhone, connects, and taps Restore Purchases. Nothing is lost either way.

## The app never names Android or Google Play

App Review 2.3.10 says: "don't include names, icons, or imagery of other mobile platforms or alternative app marketplaces in your app or metadata, unless there is specific, approved interactive functionality." So someone moving from Android reads "made with Plus on a different kind of phone", and their email asks for "My order number". Support can still tell from the words and the backup. Flow titles and notes in Figma still say Android, because people never see them. We don't know how strictly App Review applies this to a backup file; these words avoid having to find out.

## The flows

The 12 flows are rebuilt at 393 × 852, 600 apart, with Google's steps gone and each Who and rule reworded. New names: **No internet: restoring Plus** (was checking Plus), **Back on iCloud** (was Back from Google Drive), **From Android, with Plus** and **without Plus** (were From an iPhone), **No internet: iCloud**, **iCloud is off** (was Wrong Google account). A new person passes through Looking in iCloud first, as D14 says; it's usually a moment, and no spinner shows unless it takes more than a second.

**The empty Today has no iCloud Off version (the same day, the user's choice).** It first had one, with an extra sentence and Open Settings. Apple asks for a quiet note about iCloud, the iCloud page already says it's off (D4), and habits come back by themselves once it's on (D14). `openSettingsURLString` also opens the app's own page in Settings, as far as we know, not the iCloud sign-in it promised. So flow 10 now goes from the ordinary empty Today to the person turning iCloud on in the Settings app. **What this costs:** someone who reinstalls while signed out isn't told on Today why their habits are missing.

## For the Swift rewrite

- **The backup folder must be public to reach the picker.** The app has no `NSUbiquitousContainers` in its Info.plist, so dated iCloud backups in its container don't show in Files. Set `NSUbiquitousContainerIsDocumentScopePublic` for the picker to find them, or keep another way to reach them.
- **`.fileImporter(allowedContentTypes: [.zip])`** replaces `RestoreSourcePage`.
- **`NWPathMonitor`** moves No internet on when the phone comes online. The app has none today.
- **No Android or Google Play in the iPhone's words.** `HelpView.swift` still names them in an answer about moving phones; check it, and every string, in the rewrite.
- **`ProgressView` with a label** replaces `OnboardingHeading`'s "Restoring your backup." and its status line. Looking in iCloud… waits a second before it appears.
- **Launch:** keep `UILaunchScreen` blank, with the page's background colour.
- **Plus:** `AppStore.sync()` is Restore Purchases, and the check comes before anything is restored.
- **The empty pages' main button:** `.controlSize(.large)`. `TodayView.swift` has the default today.
- **The iCloud page must say when iCloud is off.** It's the only place that does now, so check that when the Settings pages are redone.

## Choices for the user to judge

- **The logo left the launch screen,** as Apple asks. Putting it back is one layer.
- **Plus's symbol is `plus.circle`,** chosen for the name; the app has no symbol of its own for Plus.
- **Apple's blue stays in the picker's tab bar.** iOS draws the picker in its own process, so the app's tint doesn't reach it.

## Not measured

- **The real iPhone.** All of this is from the Simulator, except the 50 of a Large button. The 32 under it is the Simulator's, and it may differ on the phone.
- **Mail's compose sheet.** The Simulator has no Mail account, so it's drawn from memory; its send button is blue on the phone and plain here.
- **The ZIP file icon** is `doc.zipper`, a stand-in for the Files thumbnail.
- **Real iCloud behaviour:** a slow fetch, or another Apple Account.
- **Dark.** Figma has no dark screens here.

## Still Android's

- **Today, habits restored** in the flows is Today's own component, 360 × 800, until that page is resized.
- **Settings and Today still show Google screens** in their Drive flows. Their 11 copies were detached, so they're plain frames now, kept until those pages are redone.
- **Sentence-case labels** remain on buttons in sections 05 to 09 ("All milestones").

## Checking this in Figma

- **`resetOverrides()` resets a copy's name too.** Read the name first and set it back; the Android file has the old ones under the same ids.
- **A copy keeps its own timeline length.** `setTimelineDuration` on a copy did nothing, so the old 4.55 s stayed. The spinner's keyframes run on to 5 s so it keeps turning.
- **`getInstancesAsync` can return copies inside a deleted main.** They have a stale `parent` and no page at the top of their chain, so walk up to the page before counting them.
- **Detaching a copy can leave nested copies of the same screen.** Look again before deleting the main.
- **An empty frame laid over canvas nodes pictures nothing.** To see a flow, clone its nodes into a temporary frame.
- **`createFrame` clips,** which cut the Search field's shadow into a box: set `clipsContent` false.
