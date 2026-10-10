# Android Sync Through Google Drive — Practical or Only Theoretical?

Written by Claude (Claude Code), 10 October 2026, for Current Work 80. The user, the same day: **"for Apple it has
been finalized"** (CloudKit, no server). For Android: syncing through Google Drive sounds very hard. Has anyone done
it? Is there a framework? If it's only theoretically possible and impractical to build, it isn't realistic, and only
if it's practical do we think about Android.

**Evidence.** Google's Drive API documentation (usage limits, read today); how apps that "sync with Google Drive" work
(their own guides and developer forums); our own code: the merge rules in the shared core
(`Core/sync/src/commonMain/kotlin/app/habits/sync/SyncRules.kt`, `Hlc.kt`) and [Architecture 05](<../../../../Architecture/05. Sync Engine.md>) §5–8;
and the 205 Play reviews naming Google Drive, read by hand for the previous report.

## 1. The answer

**Practical for us, not just theoretical, because the hardest part is already built and shared.** Google gives no
sync framework for Drive, and the apps that "sync with Google Drive" mostly do it badly (§2). What makes them fail is
something our app doesn't do: they copy **one whole file** back and forth and ask the person which copy wins. Ours
sends **small changes that merge the same way whatever order they arrive in** (§3). So Drive only has to be a
mailbox where each device drops its own changes and picks up the others'. That's a small, testable piece.

**But prove it before promising it:** Android launches with the two automatic backups (free), and **Drive sync for
Plus ships when a prototype passes the tests in §6**. If it doesn't pass, Android stays backup-only, which the most
loved Android habit app already is.

## 2. Has anyone done it? Is there a framework?

| | What it is | How it does "sync" | Lesson |
|---|---|---|---|
| **Google** | Drive REST API and a hidden per-app folder (`appDataFolder`) | No sync framework; Google retired its old Drive Android API | We write the sync part ourselves |
| Bluecoins (finance, Android) | Premium "sync" through Google Drive or Dropbox | One data file; the newer copy replaces the older, with a prompt or a conflict message when two devices write ([Bluecoins guide](https://www.bluecoinsapp.com/?p=1124)) | Whole-file sync needs "pick a version" prompts: the failure we must avoid |
| KeePass apps (passwords) | A database file kept in Drive | Detects that the file changed and asks to merge or overwrite; users report crashes and buttons easy to mis-tap ([ctrl.blog](https://www.ctrl.blog/entry/keepass-file-conflicts-android/)) | Same |
| Cashew (budget, open source) | Google sign-in, Drive backups, sync | Uses Firebase (a Google server) for sync, Drive for backup (third-party descriptions) | Not server-free |
| Small open-source samples | e.g. single-active-device snapshot sync in `appDataFolder` ([drive-sync](https://github.com/nachi3d/drive-sync)) | One device at a time, no merge | Shows the plumbing only |
| Joplin (a widely used open-source notes app) | Sync through Dropbox, OneDrive, WebDAV, S3 (not Google Drive) | One small file per note, each with its own timestamp | **File-store sync works at scale when each item is small and merges on its own** |
| Apple's old Core Data + iCloud (2011–16) | Change logs in iCloud Drive files | Retired for being unreliable; replaced by CloudKit | A warning: it relied on iCloud's local file syncing and an opaque framework; a direct API with our own tested rules avoids both, but the risk is real |

**Users show (205 Play reviews naming Drive):** 117 ask for an automatic Drive backup, 19 for devices kept in sync,
and 12 describe a Drive backup or restore that failed (3.08★): the whole-file kind.

## 3. Why our case is different: the merge already exists

Our sync engine (Architecture 05, written in the shared Kotlin core and used on every platform) was designed for
exactly this:

- **Every record has a permanent ID made on the device** (UUIDv7), so the same change arriving twice never makes a
  copy.
- **Changes travel as small "ops"**: one record's changed fields, each stamped with a hybrid logical clock.
- **The merge is fixed and order-free:** field by field the later stamp wins, a delete always wins, unknown fields
  are kept. The code says it outright: "everyone converges on the same record **whatever order the ops arrive in, and
  however many times each one arrives**" (`SyncRules.kt`).
- **No conflict dialogs**, a 30-day undo as the safety net.

That property is what makes any delivery method work, our server, CloudKit or a folder of files: the transport only
has to deliver every op to every device, eventually. **CloudKit on Apple needs the same on-device merge**, so building
it for Apple builds most of it for Android.

## 4. How the Drive mailbox would work

All inside the app's hidden Drive folder (`appDataFolder`, Google's non-sensitive `drive.appdata` access):

1. **Each device only ever creates its own new files**: `ops-<device>-<number>.gz`, a compressed batch of its changes.
   It never edits a file and never writes another device's, so two devices can't collide (and Drive's same-name
   quirk can't matter: files are found by ID).
2. **Each device reads the others' new files** (Drive's change list tells it what's new), applies their ops with the
   shared merge, and remembers how far it has read for each device.
3. **Now and then a device writes a snapshot** (everything, compressed, about 89 bytes a record), so a new phone
   starts from the snapshot plus newer changes instead of years of files.
4. **Old change files are removed** only after every device has read past them (each device writes its own small
   "read up to" file). A device away for months just reads the newest snapshot and catches up; its own unsent
   changes still merge correctly.
5. **When it runs:** on opening and leaving the app, a few seconds after changes, and a few times a day in the
   background. Not instant; the phone and widgets are always right locally.

Write it once in the shared core (Drive's REST API works from Kotlin on any platform), so the iPhone, iPad and Mac
could use the same mailbox later for people with Apple and Android devices.

## 5. What it costs and where it could break

- **Our money:** Drive's API is free up to **400 million quota units a day per app**; a file list costs 100 units,
  a file read 5, an update 50 ([Drive API usage limits](https://developers.google.com/workspace/drive/api/guides/limits)).
  A sync is roughly 200 units, so an extreme user syncing 20 times a day uses about 4,000: **about 100,000 such
  people a day before any charge** (about 300,000 at 6 syncs a day). Google says charges above the threshold are
  "planned … later in 2026", price not yet published, with 90 days' notice. Unlike a server, the cost doesn't grow
  with years of history, only with daily syncing, and we can sync less often in an update if it ever matters.
- **The person's storage:** their Drive (15 GB free, shared with Gmail and Photos); an extreme account is tens of MB.
- **Where it can break:** Google access revoked or a different Google account chosen; Drive full; a device offline
  for months; two devices editing the same day; a half-uploaded file; Google's rate limits (back off and retry); a
  fresh install that must never sync "nothing" over everything (our D4 "never shrink" and "wait for the backup"
  rules apply as they do on iCloud).

## 6. The test it must pass before Plus promises it

A prototype on two real Android devices (and the emulator), with a fake Drive for automated tests:

1. Two devices log the same habits offline for a week, then sync: identical results, nothing doubled, nothing lost.
2. Same field edited on both; a delete on one and an edit on the other: the fixed rules decide, no prompt.
3. A device offline for 6 months returns; a new phone installs from the snapshot; history matches row by row (D14).
4. Upload cut off halfway; Drive full; access revoked; wrong Google account: nothing lost, the app says what happened.
5. An extreme account (25,000 records a year, 15 years of data) syncs within budget: quota units and time measured.
6. A month of daily use on two phones without a single difference.

**If it passes: Android Plus includes sync between Android devices.** If not: Android stays backup-only, and we say so
honestly in the listing.

## 7. For the user to decide

1. **Android at launch with the two free automatic backups** (Android's own and the daily Drive file), and Drive sync
   for Plus only after the §6 prototype passes (recommended).
2. Build the prototype now, or after the Apple CloudKit work (which builds the on-device merge both need).

## Sources

- Google: [Drive API usage limits](https://developers.google.com/workspace/drive/api/guides/limits) (quota units,
  the 400 million daily threshold, planned charges); [Drive API scopes](https://developers.google.com/workspace/drive/api/guides/api-specific-auth).
- Apps: [Bluecoins online sync](https://www.bluecoinsapp.com/?p=1124); [KeePass file conflicts on Android](https://www.ctrl.blog/entry/keepass-file-conflicts-android/);
  [drive-sync sample](https://github.com/nachi3d/drive-sync); Cashew's sync is described only by third parties and
  wasn't checked in its code.
- Our code: `Core/sync/src/commonMain/kotlin/app/habits/sync/SyncRules.kt`, `Hlc.kt`; Architecture 05.
