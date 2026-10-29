# Google Drive Sync — Download, Merge, Upload, and the Version Chain

Written by Claude (Claude Code) after the user asked: phone uploads the whole package when done; the tablet, the
moment it opens, downloads first, then changes, then uploads. Is there a practical approach with no bugs in production?

## Facts checked
- **Drive v3 `files.update` has no precondition / If-Match / revision check** (official reference lists 11 query
  parameters, none of them a precondition). So Drive cannot refuse an upload because someone else uploaded first.
  `headRevisionId` / `md5Checksum` / `modifiedTime` can be compared by the app, but a small race window always stays.
  https://developers.google.com/workspace/drive/api/reference/rest/v3/files/update
- **appDataFolder**: hidden from the user and other apps, scope `drive.appdata` (non-sensitive), deleted if the user
  removes the app from their Drive; files can't be shared/moved/trashed.
  https://developers.google.com/workspace/drive/api/guides/appdata
- **Precedent for download → merge → upload of one whole file**: KeePass 2 "Synchronize" merges two databases entry by
  entry by last modification time and keeps the losing change as history; works over cloud folders (Google Drive,
  Dropbox, OneDrive). https://keepass.info/help/v2/sync.html
- **Precedent for the plain version (replace, no merge)**: Money Manager EX users sync a SQLite file through Drive and
  must keep the app closed on the other device; last writer wins. https://forum.moneymanagerex.org/viewtopic.php?p=25508

## The user's idea, plain (download → change → REPLACE)
Works when everyone behaves; loses data when they don't:
1. Phone's upload never finished (Android killed it, no signal, phone died) → tablet downloads the old copy → tablet's
   upload replaces the phone's later upload → phone's changes gone from Drive.
2. Tablet opened offline → it can't download first → either block the app (breaks D1, everything works offline) or
   work on old data and overwrite later.
3. Widget / notification / Live-activity-style logs on the phone happen without "opening" or "closing" the app.
4. Two devices used close together → whichever uploads last wins.
Plain replace needs "one device at a time" discipline; reviews show people don't keep it.

## The same idea with one change: MERGE instead of REPLACE (recommended)
"Download, merge, upload." Every device keeps its own database as the truth (D1) and merges what it downloads with the
shared merge rules the iPhone already uses for iCloud (SyncRules: per-field newest wins, deletes as tombstones, unknown
fields kept, order-free and repeatable).

1. **Drive holds one snapshot of everything** (compressed, ~89 bytes a record) — split into one file per year, so
   finished years almost never change and a sync moves only the current year (an extreme user's year ≈ 2 MB; a
   typical user's whole history well under 1 MB).
2. **When it runs:** on opening the app (the user's "download first"), a few seconds after changes, on leaving, after a
   widget/notification log, and a few times a day in the background (WorkManager). Never blocks the screen: the app
   shows local data at once and folds the download in when it arrives.
3. **Each run:** read the files' revision ids (one cheap list call) → if Drive changed, download and merge into the
   phone's database → if this device has anything Drive lacks, build the merged snapshot, re-check the revision id
   just before uploading (changed → start again), upload.
4. **Why a race can't lose data:** if two devices upload at the same moment and one overwrites the other, the
   overwritten device still has all its changes locally; on its next run it downloads, merges (its changes are still
   newer), and uploads again. Drive is briefly missing them; no device ever loses them. The merge is repeatable, so
   doing it twice is harmless.
5. **Safety rules already in the Rulebook apply:** a fresh install downloads and merges before it ever uploads; never
   replace a file that has habits with an empty or much smaller one (D4); the daily dated backup file stays separate
   (D5); a mass-change brake on downloaded deletes (as iCloud).
6. **"One device at a time" isn't needed for correctness.** It can stay a free-plan rule if wanted, never a lock (a
   lock left by a phone that died blocks everyone).

## Compared with the earlier "mailbox" design (Drive report §4)
| | Mailbox (change files per device) | Snapshot merge (this) |
|---|---|---|
| Files | Many small files per device + cleanup + "read up to" markers | One file per year |
| Hard parts | Cleaning up old change files safely; a device away for months | Upload size for extreme users (solved by per-year files) |
| Data after a race | Safe | Safe (healed on the next run) |
| Code to build | More | Less; reuses the iCloud merge and the backup file format |
Snapshot merge is simpler and has fewer ways to go wrong; it costs more bytes, which a habit app can afford.

## Small change files, looked at again (29 Oct 2026, kept for later)
The user asked whether small change files (one per change or batch, like a sync server's log) would be better than
rewriting a year's file. The shape that would work on Drive: Drive's changes feed (`changes.list` from a saved
`getStartPageToken`, `spaces=appDataFolder`) for "what's new since"; each small batch carried in the file's private
properties (30 × 124 bytes, returned by one `files.list` for up to 1,000 files, so no download per file); the per-year
files kept as checkpoints that any device folds the change files into; change files deleted only once folded and 30
days old. It would make each save small and the other device's pickup quick for heavy accounts; a new phone is
already 15–27 s. **The user's call: keep today's design for launch, and think about this for Plus sync** (it needs a
prototype measured on the real Drive first: the changes feed on the app folder, rate limits, folding while two devices
write).

## What still goes wrong in production (honest)
- **Slow, not lost:** Android delays background work (Xiaomi/Samsung battery savers), so a change can show on the
  other device only when it's opened. "Didn't sync" complaints stay possible; show "Synced 2 min ago" and sync on open.
- **Google side:** access revoked, Drive full, wrong Google account → sync stops, nothing lost; the app must say so.
- **Our bugs:** the merge is shared and tested on the iPhone already, which is the main reason this is practical.
- No design gives "no complaints"; this one aims for "no lost data".

## Update, same day: building the protection ourselves (the user: "what if we build that protection?")

- **A plain lock file doesn't work on Drive:** Drive can't stop two devices creating a lock at the same moment (names
  aren't unique), and a phone that dies while holding the lock blocks everyone until it expires.
- **A real protection exists in Drive's own rules: pre-generated file IDs.** A client can ask Drive for file IDs in
  advance and create a file with one; creating a file whose ID already exists returns **409 Conflict** and makes no
  duplicate (Drive upload guide, documented for retries:
  https://developers.google.com/workspace/drive/api/guides/manage-uploads). That is a server-enforced
  "only the first one wins".
- **"Version chain" design built on it:** every snapshot file carries the ID reserved for the next one. To save,
  a device creates the next file with that ID. If another device saved first, Drive answers 409: this device
  downloads the newer version, merges, and tries the following ID. No upload can ever overwrite another; Google
  enforces it. Old versions are deleted after a few newer ones exist.
- **To confirm in the prototype:** that a 409 also comes when a *different* device (same Google account, same app)
  uses the reserved ID — the guide documents it for retries, not explicitly for a second client.
- **The protection says "someone saved since you looked"; merge decides what happens next.** Without merge the device
  could only refuse (its changes stuck) or overwrite (the other device's changes deleted). With merge, both are kept.
- **Offline:** the app works offline and says so ("Offline — saved on this phone, syncs when you're back online");
  nobody expects sync without internet (the user). What matters is the moment it comes back online with changes made
  on an older copy: the protection catches it and the merge keeps both devices' work.
- **Checked and not suitable:** Play Games "Saved Games" has conflict detection built in, but it is made for games,
  resolves by keeping one whole save (or asking the user), and its use outside games is unclear
  (https://developer.android.com/games/pgs/android/saved-games). Dropbox and OneDrive have real "only if unchanged"
  uploads, but only help people who use them.

## Telling people when a device hasn't synced (the user, same day: "avoid complaints … without blaming the user …
show it only when necessary")

The case: the phone logged things while offline (or then died); the person opens the tablet/desktop and those logs
aren't there. Nothing can bring them over until the phone is online. Reasoned from first principles plus D4's "backup
is visible" and U3's no-blame words: complaints come from silence ("I logged it and it's gone"), not from a delay that
was explained. Same design for iCloud on iPhone/iPad, which has the same case.

1. **On the device holding unsynced changes** (shown only while it has changes waiting AND can't reach Drive/iCloud):
   a quiet status line on Today: "Offline · 3 changes waiting to sync". Tapping it: "They're saved on this phone and
   will sync by themselves when it's back online. You don't need to keep the app open." Never shown when nothing is
   waiting. (Android: WorkManager with a network constraint uploads when the connection returns, app closed or not.)
2. **On the other device** (shown only when another of the person's devices has gone quiet): every device writes a
   small "last checked" time to Drive whenever it syncs, including the background checks a few times a day. If a
   device that was in use in the last 14 days hasn't checked in for 8 hours or more, one dismissible line on Today:
   "Pixel 8 last synced at 9:14 AM. Anything logged there since will show up here once it's back online."
   Shown once per quiet spell; dismissing hides it until that device syncs again. Always available, without a banner,
   in Sync settings: each device with its last-synced time.
3. **When it catches up:** one quiet confirmation on the other device: "Updated with 3 logs from Pixel 8." Each log's
   view already says where it came from (U19), e.g. "Logged on Pixel 8".

**Words:** name the device, never the person ("Pixel 8 last synced…", not "you were offline"). Never "error",
"failed", "missed", "not saved" (U3/U11): the changes ARE saved, on that device.

**The complaint this prevents most: double logging.** Seeing a log missing, people log it again on the other device;
when the phone syncs, a counted habit gets both (+1 twice). A check habit is safe (done twice is still done once). The
"last synced" line on the other device is the main defence; after a catch-up, the confirmation names what arrived, so a
duplicate is easy to spot and undo from Day details.

## Test before promising it (unchanged from the Drive report §6)
Two real Android devices + a fake Drive in CI: offline week on both, same field edited on both, delete vs edit, upload
cut off, simultaneous uploads (the race above), Drive full, access revoked, fresh install, extreme account size.
