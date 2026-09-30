# Sidebar — Backup, Tasks and Reminders

Written by Codex, 1 October 2026. Branch: `sidebar`.

The user requested all work on the existing sidebar branch, one step at a time, with GitHub Actions validation for each step. Performance is the highest priority; reminders must be reliable. Progress is being implemented independently. Help & Feedback and About remain blank until their content is available.

| Step | Requirement | Implementation | Validation |
|---|---|---|---|
| 1 | Free CSV export, complete backup and safe restore from Backup & Export | [x] | [x] |
| 1a | Current edits and deleted records survive an older restore; repeating restore is harmless; old versions migrate | [x] | [x] |
| 1b | Explain and protect free users' data across closing, offloading, reinstall and moving phones | [x] | [x] |
| 2 | Every created task appears in Tasks, including future, completed, repeating and archived tasks | [x] | [x] |
| 2a | Open and edit tasks using the existing native task form; changes persist | [x] | [x] |
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

- First backup run: [36764217121](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36764217121), build and Core migrations/storage passed. Seven of eight UI tests passed; share dismissal needed an explicit completion and a hittability wait. Performance probes passed: Backup page main thread busy 4.5%, redraw 0.2%; Menu 3.8%/1.3%; Today 6.1%/1.0%. Open times include XCTest overhead (Backup 2.2s). These are comparative simulator samples, not a device responsiveness guarantee.
- Restore now also carries tombstones onto a new installation, checks semantic record validity and newer schemas, serializes alongside writes, preserves default preferences on a populated destination, and groups children once on load. Latest validation pending.

- Second backup run [36767141883](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36767141883): latest Core and Swift restore checks passed, plus Today and timer regression tests. Share test still failed: the accessibility tree shows the remote ActivityListView arrives before its Close button. The test's fallback swipe scrolled the sheet rather than closing it. Follow-up waits for the actual `header.closeButton`, taps it, and checks dismissal before trying another backup.

- Backup validation complete: [36769714504](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36769714504), build + all 3 BackupUITests passed. Complete restoration/integrity golden cases reran. Core storage/migration and Today/timer checks passed on the preceding unchanged implementation (728f208); only share-test waits and CI dependency caching changed in 64c1a26. Uninstall retention itself is a platform limitation, handled with free external files and an explicit warning, not a guarantee.

## Tasks implementation

- Every saved task remains listed, including future, completed, repeating and archived tasks. Existing native task detail/Edit Task form is reused. A + button also creates a task directly from Tasks.
- Tasks neither consume the free habit limit nor need Plus to leave the archive. Completed tasks say Completed (repeating tasks: Done today).
- Editing an old one-time task keeps its past date instead of the date picker clamping it to today.
- Research: `Tasks in the Free Plan — Limit, Count or Plus.md` corroborates the existing “Tasks are always free” design. Current reminder reports and ledger C039/C123/C252 guide the following reliability stage.
- Validation pending: task fixtures cover all 5 task types, model reload checks, every task opening Edit with no spurious changes, creation from Tasks, edit + terminate/relaunch on a real database, relevant schedule golden/task UI cases, and performance with 200 tasks and a year of history.

- Tasks run [36771897272](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36771897272): build and 7/8 UI checks passed. The rename and task-edit performance checks wrongly expected the full name in the navigation title, which intentionally caps names at 15 characters; the failure hierarchy shows the edited full name correctly saved on the detail page. Tests now verify the full detail text and the Edit button. Tasks list measured 3.9% main-thread busy / 0.4% redraw; Today 3.7% / 0.7%. Task edit remains unmeasured until the corrected probe passes.

- Tasks validation complete: [36774788090](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36774788090), build and all 3 TasksUITests passed, including real-database edit + terminate/relaunch. Edit Task measured 0.8% main-thread busy / 0.5% redraw. Relevant schedule/Today and Tasks list/Today performance checks passed on the unchanged app implementation in c3c09f2; only incorrect title assertions changed.

## Reminders implementation — validation pending

Native page shows configured and disabled rules, permission status, explicit recovery and item editing. Reliability addendum: Specs/Pending to Implement.md. Controlled services exercise races, failure/retry, authorization states, action replay after undo, alarm ownership, recurrence, budgets, DST and local clocks. Planning fixture contains 100 reminders and >30,000 history entries. Latest run will also rerun backup, task, Today, timer and relevant schedule regressions. Uninstall retention and real-device OS delivery cannot be guaranteed by simulator tests.

- First reminder build [36777003676](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36777003676) found the new suspend Boolean is exported as KotlinBoolean; use its boolValue. No runtime checks ran on that build. Follow-up also exports repository exceptions to Swift, retains a separate storage-ready state after an open/read failure, and re-plans after a recoverable error is acknowledged. Added actual corrupt-SQLite restore and closed-database checks; dismissing the error cannot authorize clearing saved alerts.

- Second reminder build [36777680943](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36777680943): storage error bridge and app code compile; the new closed-database check needed `import Core` to call close. Fixed that test import. Reminder configuration hashes now canonicalize numeric sets (weekday/month-date order) as well as reminder IDs and millisecond timestamps, with cold-load checks. Default midnight day boundaries keep the inexpensive local-day path. Native protected-data availability retries a previously blocked read. Latest complete validation pending.
