# Android — Start Here

Written by Claude (Claude Code), 11 October 2026, at the user's request: "document everything that we have discussed …
regarding the Android and the decision on working on Google Drive." Everything about the Android app is in this
folder: the decisions (with the user's words and dates), the research, the sync design, and what comes next. Status
lives in the [Current Work Checklist](<../../iOS/Docs/Checklists/Current Work Checklist.md>) items **89** (Android),
**90** (refunds), **91** (the sync line on Today) and **77** (Google Drive on Apple devices).

**The principle (the user, 11 Oct 2026):** "the same thing what we have for iPhone should also work for Android, or
whatever we are designing for Android should work for iPhone as well, the same way." One shared core, the same Plus,
the same words; differences only where a platform forces them.

## Read in this order

1. [Android Plus — What Android People Pay For, and Keeping Both Apps the Same](<Research/Android Plus — What Android People Pay For, and Keeping Both Apps the Same.md>):
   1,500 reviews read by hand on both stores; Plus is the same on both, minus the Watch.
2. [How Sync Works — iCloud and Google Drive, One Core](<How Sync Works — iCloud and Google Drive, One Core.md>):
   the shared merge rules, a sync round on each carrier, and how it avoids what breaks other apps.
3. [Google Drive Sync — Download, Merge, Upload, and the Version Chain](<Research/Google Drive Sync — Download, Merge, Upload, and the Version Chain.md>):
   the user's "download first, then upload" idea, made safe; what Google Drive can and can't guarantee.
4. [Sync Status Across Devices — When It Shows, Where, and the Complaints Behind It](<Research/Sync Status Across Devices — When It Shows, Where, and the Complaints Behind It.md>):
   how a device knows another went quiet, the line on Today, the Watch, the 197 sync complaints and what can't be solved.
5. [Android Plus Evidence](<Research/Android Plus Evidence/>): every script, sample, hand coding, tally and web source.

Earlier work this builds on: [Plus, Price and the Server — How We Decided](<../../Research/Research Reports/Business Model and Monetization/Plus, Price and the Server — How We Decided/README.md>)
(no server for habits; the first Android and Google Drive reports), [Architecture 11](<../../Architecture/11. iCloud Sync with CloudKit.md>)
(iCloud sync as built), Rulebook D16.

## Decisions (11 October 2026)

| # | Decision | The user's words |
|---|---|---|
| A1 | **Order of platforms:** the Watch and iPad are in progress; Android next; the Mac last, designed from the iPad (only the Mac's own parts: menu-bar item, shortcuts, menus, windows) | "the only thing that is left is creating an app for mac"; then "let's go to the Android" |
| A2 | **The Mac includes the Google Drive option** | "in the Mac also we need to include the Google Drive option … we do need to include it" |
| A3 | **Android Plus = iPhone Plus, at the same price, minus the Watch**; one shared design for both platforms | "the same thing what we have for iPhone should also work for Android" |
| A4 | **Android sync through the person's Google Drive by download → merge → upload** (never replace), with the shared merge rules, one file per year, and the version chain so no device can overwrite another; proven by a two-device prototype first | The user's idea: "it downloads the backup, then it changes and then it uploads it back"; "what if we build that protection ourselves?" |
| A5 | **No relay server** for faster Android-to-Android sync: sync on open, about once a minute while the app is on screen, and in the background | "let's not use relay server. It's not necessary cost and unnecessary relay" |
| A6 | **Offline is said, not hidden:** the app works offline and says so; nobody expects sync without internet | "without internet the app will work but we clearly display that there is no internet and changes might not sync" |
| A7 | **A quiet sync line at the end of Today's list, only when there's something to say** (changes waiting, another device gone quiet, just caught up), on iPhone, iPad, the Watch's list and Android; never blaming the person (Current Work 91; Design Rules' iCloud page updated) | "we are not blaming the user but we are just telling them the information … show when it is necessary"; "I'll vote for iPhone also … Android, you need to do it" |
| A8 | **When iCloud or Google Drive can't be used after someone bought Plus: offer a refund** (and another account if they have one) instead of checking before purchase (Current Work 90) | "if it is not working, then we will just refund it … if you have any other iCloud, connect to it; same thing for Google Drive" |
| A10 | **Google Drive sync is offered on iPhone, iPad and Mac too**, as an alternative to iCloud, with the same code as Android; iCloud stays the default; one sync place at a time; built after the prototype passes (stage 4; a new iOS client is needed: the old one was deleted, Current Work 84) | "we are obviously including it for iOS" |
| A9 | **Work starts with Google Drive sync in the shared core** (the biggest unknown; it decides Android Plus; built and mostly tested on GitHub's Linux machines with a stand-in Drive), alongside the Android research report | "the decision on working on Google Drive" |

**Recorded corrections** (so no agent repeats them): an early summary said Android people don't pay for sync; measured
side by side they do, at least as much as on the iPhone (report §3–4). Day details was first proposed for the "last
synced" note; the user doubted it and it moved to the end of Today's list, the native place (Mail, Photos).

## Still open

- **One purchase working on both stores from Android's launch** (the entitlement record, D16).
- **Plus Family on Android:** Google Play can't share an in-app purchase with a family.
- **Designs still to make:** the same field edited on two offline devices ("Use This Instead"), a delete arriving from
  another device ("Archived on Pixel 8"), the same thing logged on two devices ("Keep Both / Remove One"), two devices
  that each created the same habit (combine), widgets refreshed the moment synced changes arrive.
- **Android research report** (what Android people want beyond Plus; Google's own rules), then Figma designs, small
  screens first.
- **Moving the day, schedule, streak and progress rules into the shared core** (they're in the iPhone's Swift today), so
  Android shows the same numbers; with speed runs on the iPhone, after the iPad and Watch branches merge.

## What comes next

1. **Google Drive sync in the shared core**: transport, version chain and merge, tested against a stand-in Drive on
   GitHub; then a real-Drive check that a second device's save under a taken ID is refused. The cloud session's full
   instructions: [Build Prompt — Google Drive Sync, Stages 1–2](<Build Prompt — Google Drive Sync, Stages 1–2 (Delete When Done).md>).
2. Alongside: the Android research report, and Current Work 91 on the iPhone.
3. Then the shared rules into the core, the Android designs, and the Android app with Drive sync plugged in.

**Done by the user, 11 Oct 2026:** a Web OAuth client "Drive sync tests" (`drive.appdata`; redirect
`https://developers.google.com/oauthplayground`), a test Google account added as a test user, and three GitHub
secrets: `GDRIVE_TEST_CLIENT_ID`, `GDRIVE_TEST_CLIENT_SECRET`, `GDRIVE_TEST_REFRESH_TOKEN` (the token can expire after
about 7 days in Testing mode; renew it in the OAuth Playground). **Still needed later:** an Android OAuth client and
two Android devices or emulators (stage 3); a new iOS client (stage 4).
