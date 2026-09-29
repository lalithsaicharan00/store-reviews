# Export and Backup — Keeping Your Own Data

Written by Claude (Claude Code), 29 September 2026. The free app keeps everything on the phone, with no account (product rules). The Feature Ledger's must-never-break list starts with data: [C034](<../Feature Ledger.md#c034>) data must never be lost on update, reinstall or phone change (55 apps, Certain), [C176](<../Feature Ledger.md#c176>) never let fear of losing history be the reason people pay, [C262](<../Feature Ledger.md#c262>) recovery actions stay free, and [C020](<../Feature Ledger.md#c020>) export / backup / CSV. The rules were already worked out in [Data Safety — Every Way Users Lose Data](<Data Safety — Every Way Users Lose Data, and the Rules That Prevent It.md>) (B1–B4, A4, A12); this is what the free, local app builds from them now. Automatic server backup and sync belong to Plus and come later.

## Answer

1. **The database is in the phone's own backups** (Application Support, not excluded), and Settings says so: "Included in your iPhone's backups". Seven daily local copies already guard against a bad upgrade.
2. **Export a Spreadsheet (CSV)**, free: one row per thing logged or noted, with the local calendar date it counts for, the habit, what it was, the amount and unit, and the note. Archived habits included.
3. **Save a Backup File**, free: everything (habits, history, notes, goal history, settings) in one file, to keep in Files or send to yourself, and to move to a new phone.
4. **Restore from a Backup File**, free: it **only adds** what's missing. Anything already on the phone, edited or deleted, stays exactly as it is, so an older file can't undo newer work and a deleted habit doesn't come back. An old backup still restores after the app is updated (the copy is upgraded as it's opened). Restoring never stops at the free habit limit.
5. **Say what happened**: "Added 3 habits and 412 logged entries. Nothing already here was changed." or "Nothing New".

## What the reviews say

Keyword scan of habit and routine trackers' App Store and Play Store reviews (`Research/Temp/stats/data_hits.json`), samples read by hand; the Data Safety report has the full catalogue.

| Theme | Reviews | Apps | Mean ★ |
|---|---|---|---|
| Export or CSV, wanted or praised | 1,002 | 82 | 4.41 |
| Backup, restore or export behind a payment | 346 | 54 | 2.68 |
| Restore or import problems and requests | 230 | 42 | 3.21 |

- **Export is valued, and its absence is felt:** "allows you export your data. No brainer really." (Habitify, 5★, `3294255105`); "impossible to export data to desktop and web" (Habitify, 1★, `5659139426`); "I bought a premium version primarily to analyze data only to realize … export functionality is no longer supported" (Habitify, 1★, `6461863220`).
- **Local-only data with no way out is a disaster waiting:** "I deleted the app and redownloaded. All my data is lost, and there's no way to restore the data since everything's stored locally … At least there should be a pop up" (Finch, 2★, `9343658775`); "it is incredibly easy to lose ALL of your data and progress if the app gets deleted or if you get a new phone" (Finch, 3★, `12403284805`).
- **Restores that lose part, or roll back:** "when I changed phones and used the back up to restore my progress, all the furniture and outfits I had built up over months disappeared" (Finch, 2★, `14001697976`); "it only restored my data from two weeks ago. That's two entire weeks of progress wiped out" (Finch, 1★, `12935578472`). Hence a restore that adds and never replaces: two weeks of newer work can't be wiped by an older file.

## Reasoned from first principles

- **One file, not two:** the backup is a consistent copy of the database, the format of the shared Kotlin core that every platform's app will use, so it's complete by construction and every future version can open (and upgrade) it. The Data Safety report asked for "a readable CSV and a complete JSON"; the database copy is the complete one, and the CSV is the readable one.
- **Merge, don't replace:** a person restoring is either on an empty phone (everything is added) or has some data already (only what's missing is added). Neither case can lose anything.
- **No account, no server:** everything happens through the iOS share sheet and Files, so the Privacy line in Settings stays true.

## Not built yet

- Automatic off-phone backup with "last backed up" (Data Safety B1): Plus, with an account (Architecture).
- "I've used this before" on a fresh install's first screen (B4), and a crash-loop recovery screen (A3).
- Importing other apps' CSVs (users switching in).

## Tests

- Core: `HabitRepositoryTest.mergingABackupAddsOnlyWhatIsMissing` (newer edits win, deleted entries stay deleted, missing days and notes are added, settings here win, old timers don't restart, restoring twice adds nothing). Not run in this cloud session: Google's Maven is blocked, so the Kotlin build can't fetch Room.
- The CSV quoting was checked against a standard CSV reader.

## Limits

Keyword counts are floors. The flows haven't been tested with people or on a device.
