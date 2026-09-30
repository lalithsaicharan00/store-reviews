# Sidebar — Backup, Tasks and Reminders

Written by Codex, 1 October 2026. Branch: `sidebar`.

The user requested all work on the existing sidebar branch, one step at a time, with GitHub Actions validation for each step. Performance is the highest priority; reminders must be reliable. Progress is being implemented independently. Help & Feedback and About remain blank until their content is available.

| Step | Requirement | Implementation | Validation |
|---|---|---|---|
| 1 | Free CSV export, complete backup and safe restore from Backup & Export | [ ] | [ ] |
| 1a | Current edits and deleted records survive an older restore; repeating restore is harmless; old versions migrate | [ ] | [ ] |
| 1b | Explain and protect free users' data across closing, offloading, reinstall and moving phones | [ ] | [ ] |
| 2 | Every created task appears in Tasks, including future, completed, repeating and archived tasks | [ ] | [ ] |
| 2a | Open and edit tasks using the existing native task form; changes persist | [ ] | [ ] |
| 3 | Complete the Reminders page with existing habit/task reminders and permission recovery | [ ] | [ ] |
| 3a | Validate scheduling, suppression, edits, duplicate/grouped times, limits, tasks, pauses, archives, travel and DST | [ ] | [ ] |
| 4 | Measure relevant screens and report real failures without treating a green measurement job as a performance sign-off | [ ] | [ ] |

## Platform limit: uninstall and reinstall

Deleting an iOS app deletes its sandbox, including its database and local recovery snapshots. Offloading retains Documents and Data. Ordinary reinstall does not restore that data automatically, and inclusion in a device backup does not establish that the user has made a device backup. Keychain retention and App Groups cannot guarantee retention of an app's full database through uninstall. This app will not claim that they can.

Free users can save a complete backup outside the app with the native share sheet and restore it without an account or purchase. Restoring is offered on an empty installation. The Backup page explains the difference before a person deletes the app. Exported copies in Files remain under the person's control; saving into the app's own folder is not protection against uninstall.

## Research and implementation choices

- Existing evidence: `Architecture/03. Backup and Restore.md`, the Data Safety report, and the newer Export and Backup report on the feature branch. Users complain about lost data after reinstall, partial restores, old backups overwriting newer progress, paywalled recovery and misleading backup status.
- Restore only adds missing rows. Existing habits keep their current steps/reminders and rule history; deleted records remain deleted. Empty note values retain deletion markers for future restores. Deletions made by older builds without a note marker cannot be reconstructed.
- Complete backup is SQLite, consistent via `VACUUM INTO`. Source header/version, Room schema and integrity are checked on a temporary copy before the destination changes. Running timers from a backup are not resumed.
- User authorization to implement and validate through Actions includes the commits/pushes necessary to run those checks. No builds or simulator runs on the user's MacBook.

## Results

Pending.
