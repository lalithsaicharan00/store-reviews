# Backup file format

*Written by Claude (Claude Code), 1 Oct 2026. The checked backup file of [Architecture 03 §3.2](<../Architecture/03. Backup and Restore.md>).
Code: `src/commonMain/kotlin/app/habits/core/BackupFile.kt` (writing and checking) and `Restore.kt` (preview, Replace,
Merge). Tests: `src/jvmTest/kotlin/app/habits/core/BackupTest.kt`.*

One file for every place a backup goes: the user's iCloud or Google Drive, our server (`PUT /v1/backup`), "Move to
another device" and Export. Every app version reads every older format; `src/jvmTest/resources/backups/` keeps a sample
of each, and a test reads it on every run.

## The file

A zip, **stored (not compressed)**, so any unzip tool opens it and no app needs a decompressor. Named
`Often Enough YYYY-MM-DD HHmm.zip` by the apps.

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

## Checks before anything changes

Reading stops with a reason, and changes nothing, if any of these fail (03 §3.6 step 5):

| Check | Reason |
|---|---|
| A zip with `manifest.json`, a known `format` | `not_a_backup`, or `newer_version` |
| Every entry stored (a file unzipped and zipped again by another app is deflated) | `repacked`: "use the original file" |
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
