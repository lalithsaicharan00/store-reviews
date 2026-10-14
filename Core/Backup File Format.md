# Backup file format

*Written by Claude (Claude Code), 1 Oct 2026. The checked backup file of [Architecture 03 §3.2](<../Architecture/03. Backup and Restore.md>).
Code: `src/commonMain/kotlin/app/habits/core/BackupFile.kt` (writing and checking) and `Restore.kt` (preview, Replace,
Merge). Tests: `src/jvmTest/kotlin/app/habits/core/BackupTest.kt`.*

One file for every place a backup goes: the user's iCloud or Google Drive, our server (`PUT /v1/backup`), "Move to
another device" and Export. Every app version reads every older format; `src/jvmTest/resources/backups/` keeps a sample
of each, and a test reads it on every run.

## The file

A zip, **stored (not compressed)**, so any unzip tool opens it and no app needs a decompressor. Named
**`Often Enough backup YYYY-MM-DD HHmm.zip`** by every app (from 14 Oct 2026; it was `Often Enough YYYY-MM-DD HHmm.zip`):
see [One file on every device](#one-file-on-every-device-14-oct-2026) for why.

| Entry | What |
|---|---|
| `manifest.json` | What the file is, who made it, and how to check it (below) |
| `data.json` | Every row of every table, **deleted rows included** (so a habit deleted before the backup stays deleted after a restore) |
| `csv/habits.csv`, `steps.csv`, `times.csv`, `logs.csv`, `settings.csv` | The same rows, one readable table each, for Excel or Numbers. `logs.csv` also names each log's habit. Text that a spreadsheet would run as a formula is shown with a leading `'` |

### `manifest.json` (format 1)

```json
{
  "format": 1,
  "app": "Often Enough",
  "appVersion": "1.0",
  "platform": "ios",
  "deviceName": "Lalith’s iPhone",
  "createdAt": 1790000000000,
  "schema": 6,
  "data": { "file": "data.json", "sha256": "<hex of data.json>", "bytes": 1234 },
  "counts": { "habit": 5, "step": 2, "reminder": 3, "entry": 412, "setting": 10 },
  "live": { "habits": 5, "entries": 400 }
}
```

- `format`: bumped only for a new layout. A newer format than the app knows: "Update the app to open this backup".
- `counts`: every row in `data.json` per table. `live`: rows not deleted, for "5 habits, 400 check-ins".
- `schema`: the database schema of the app that wrote it (for support; reading doesn't depend on it).

### `data.json`

```json
{
  "habit":    [{ "id": "<uuid>", "name": "Water", "kind": "amount", "deleted_at": null, … }],
  "step":     [{ "id": "<uuid>", "habit_id": "<uuid>", "name": "Fill bottle", "position": 0, "deleted_at": null }],
  "reminder": [{ "id": "<uuid>", "habit_id": "<uuid>", "hour": 9, "minute": 30, "deleted_at": null }],
  "entry":    [{ "id": "<uuid>", "habit_id": "<uuid>", "day": "2026-10-01", "value": 1.0, … }],
  "setting":  [{ "id": "week_start", "value": "2" }]
}
```

Each row is `id` plus exactly the fields sync uses (`SyncCodec`, the database's column names). Times are epoch
milliseconds; days are `YYYY-MM-DD` in the user's calendar. Readers ignore fields and tables they don't know, and fill
fields an older file lacks with the same defaults sync uses. Settings that only make sense on one device
(`SyncCodec.isLocalSetting`) are never written.

Habit fields added since format 1, each optional for readers (an older file simply lacks them):

| Field | Schema | Meaning |
|---|---|---|
| `reminder_text` | 8 (9 Oct 2026, Current Work 58) | "Reminder says…": the person's own words for the habit's reminders, at most 24 characters; `null` for none. A file from schema 7 or earlier restores with none |

## Format 2: the compact automatic backup (10 Oct 2026)

The copies the apps make by themselves, as you go (the person's iCloud or Google Drive, the account: Current Work 75,
[Free Plan Backups §7 step 2](<../Research/Research Reports/Data, Sync and Accounts/Free Plan Backups — iPhone and iPad, and a Backup That's Never a Day Behind.md>)),
are `HabitRepository.automaticBackupFile`: the same `manifest.json` (`"format": 2`) and `data.json`, with two changes:

- `data.json` is **deflated** (zip method 8, raw DEFLATE). `manifest.json` stays stored, so a reader learns the format
  before inflating anything. The CRC-32, `data.sha256` and `data.bytes` are of the inflated `data.json`, as before.
- **No `csv/` folder**: it repeated `data.json` for people opening the file in a spreadsheet, and no reader uses it.

Any unzip tool still opens it. Measured (`BackupTest.theAutomaticFileIsSmallerAndRestoresTheSame`, 10 Oct 2026):

| Data | Format 1 (full) | Format 2 (automatic) |
|---|---|---|
| The research's average free user a year in: 5 habits, 1,500 check-ins, real UUIDs, varied times, notes | 555 KB | **75 KB (13 %)** |
| 30 habits, 720 check-ins (short test IDs) | 187 KB | 8 KB (4 %) |
| 12 habits × 365 days (short test IDs) | 1,019 KB | 41 KB (4 %) |

Backed up as you go (about 80 uploads a month, Free Plan Backups §5.2), the average user's **mobile data falls from
about 43 MB a month to about 6 MB**, under the report's 11 MB target.

Files made for a person stay **format 1** (Save a Backup File, Move to Another Device, a restore's undo file), which
every app version opens. An app older than 10 Oct 2026 shown a format 2 file says "Update the app" (`newer_version`)
and changes nothing. DEFLATE is in common Kotlin (`Deflate.kt`, checked against the JVM's zlib both ways).

## One file on every device (14 Oct 2026)

The user, 14 Oct 2026: "the backup file should be the same everywhere. The backup file created on iOS as well as Android
should be the same everywhere so that they can share it on different devices and use it on different devices." They then
asked whether zip, a database file or something else is best, and chose the zip and the name below.

**The rule.** Every backup file made for a person, on iPhone, iPad and Android alike (Save a backup file, Save a backup
file first before an erase or a delete), is this format 1 zip, named **`Often Enough backup YYYY-MM-DD HHmm.zip`**: the local
date and 24-hour time it was made (`Often Enough backup 2026-10-12 0914.zip`), type `application/zip`. Every app opens a
file from any other: Restore › A backup file in Settings, and **A backup file** when coming back (Android onboarding, row
6). Nothing in the file depends on the platform that made it: `platform` and `deviceName` in the manifest are only shown
("From a Pixel 9 · 12 Oct, 9:14 AM").

**Why a zip of our own JSON, and not the app's database file (`.db`):**

- **The database is the app's private storage; the backup file is a promise.** The database's layout changes with app
  updates (its `schema`), so a database copied from a newer app can't be opened by an older one: the iPhone's check
  refuses it as "newer version". `data.json` is the same fields sync uses, readers skip fields they don't know and fill
  missing ones with sync's defaults, so a phone on an older version still reads a newer phone's file whenever the format
  is the same.
- **It's checked before anything changes.** The manifest carries the SHA-256 and the counts, and the zip carries a CRC-32
  per entry: a damaged, cut-off or repacked file is refused with a reason (below). A copied SQLite file can also leave
  its most recent changes behind in a separate `-wal` file, and nothing in it says so.
- **It's readable without us (Rulebook D10).** Any unzip tool opens it, and `csv/` opens in Excel or Numbers.

**Why not the alternatives:**

- **Plain `.json`:** it works everywhere too, but has no room for the spreadsheet copies or for a checksum kept
  apart from the data. The zip holds all three in one file.
- **An ending of our own** (`.oftenenough`, drawn in the Android designs until 14 Oct, never built): it would only be a renamed zip.
  On the iPhone a registered type would let a tap in Files open the app. **Android doesn't know endings it hasn't been
  told about:** the file arrives as `application/octet-stream`, Files says it can't open it, and Gmail and Drive don't offer
  our app. One file that behaves the same everywhere wins. The cost is small: on the iPhone, tapping a `.zip` in Files
  unzips it into a folder beside it; a restore always starts inside the app, from its file picker, so the person chooses
  the zip there.

**Why this name:**

- **It starts with "Often Enough backup"**, the words the person looks for in a folder of downloads, and the words the
  app uses when a chosen file isn't one ("Choose a file whose name starts with “Often Enough backup”", Android 6.1.1).
- **Year-month-day** sorts in order in any folder and reads the same in every language and region.
- **The time** keeps two files saved the same day apart (the iPhone's Files would otherwise ask to replace the first;
  Android's picker would add "(1)").
- **No device name or account in the name** (the manifest has the device, the name never does).
- **Long names in Android's own file picker** are shortened to one line in the middle ("Often Enough back…6-10-12
  0914.zip"). That's Android's drawing; the app's own screen (6.1 · Your backup file) shows the whole name.

**Code to change** (not built yet; Current Work 111):

- **The name, both apps:** add "backup" to `Often Enough YYYY-MM-DD HHmm.zip`: the iPhone's `BackupCenter.writeFile`
  (`iOS/Habits/Backup/BackupCenter.swift`, today `"Often Enough \(stamp).zip"`) and Android's `BackupCenter.fileName()`
  (`Android/.../app/backup/BackupCenter.kt`, today `"Often Enough " + yyyy-MM-dd HHmm + ".zip"`). The format itself is
  already shared: both write it through `HabitRepository.backupFile`.
- **The iPhone's last `.db`:** the older Backup & Export page (`BackupExportView`), shown only when the database
  couldn't be opened, still saves a copy of the database itself (`HabitStore.backupFile`, `Often Enough Backup
  YYYY-MM-DD.db`). Make it save the shared zip, or remove its Save button. The iPhone's Restore can keep reading an older
  `.db` (`BackupCenter.isOlderBackupFile`, adding only what's missing) until release; nothing outside our own test
  phones has one, as the app isn't out yet.

## Checks before anything changes

Reading stops with a reason, and changes nothing, if any of these fail (03 §3.6 step 5):

| Check | Reason |
|---|---|
| A zip with `manifest.json`, a known `format` | `not_a_backup`, or `newer_version` |
| Every entry stored, except format 2's `data.json` (a file unzipped and zipped again by another app is deflated) | `repacked`: "use the original file" |
| Every entry's CRC-32 | `damaged` |
| `data.json`'s SHA-256 equals the manifest's | `damaged` |
| Each table's row count equals the manifest's | `damaged` |
| Every row builds, IDs are unique, and every step, time and log belongs to a habit in the file | `damaged` |

The app also compares the whole file's SHA-256 after writing it and reading it back (iCloud, Drive) or with the
checksum the server stored: only then does it say "Backed up" (03 §3.4).

## Restore

`HabitRepository.checkBackup(file)` returns the preview for both choices; `restore(file, mode, info)` does one in a
single transaction and returns the undo file (this device just before). Restoring the undo file with Replace undoes it.

| | Replace | Merge |
|---|---|---|
| Result | This device becomes exactly the backup | The two combined |
| Added since the backup | Removed (as deletions, so they sync) | Kept |
| Removed since the backup | Back. A sync delete is final, so a row deleted here returns **under a new ID**, with its steps, times, logs and settings | Stays removed |
| Both have it, edited differently | The backup's version | The more recently edited habit wins; for logs, steps, times and settings this device's |

Both go through `SyncWriter`, so on a synced device the restore reaches the other devices like any edit.
