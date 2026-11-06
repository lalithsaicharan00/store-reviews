# Data Rules for Sync — To Build

Written by Claude (Claude Code), 6 November 2026, at the user's request: "whatever the rules that iPhone has to follow, write
them … in detail". Read from Android's code and `Core/` at schema 11. Nothing here has been run on an iPhone or against a
server.

**Status: not built on the iPhone.** Read this before writing the Swift app's storage. Android has all of it, except the
open points at the end.

## The plan these rules serve

The user, 6 November 2026:

1. Both apps launch: the iPhone with iCloud, Android with Google Drive.
2. Five or six months later, an update adds a server. Free people stay on the free app.
3. Someone who buys the plan creates an account, and the app activates. Their data moves to the server without loss or
   damage, whichever phone they use.
4. From then on it syncs by itself. The app still works without internet: changes wait on the phone and go up when it's back
   online (D1).

The iPhone is written in Swift with no shared code, so the two apps stay compatible only by storing the same things in the
same way. Screens can differ; what's stored can't. **If Swift's storage needs something this page doesn't allow, stop and
ask.** A difference here is the expensive mistake.

## What has to match

**Must match Android exactly:** IDs, table and field names, the text and numbers inside each field, setting keys, stamps, the
merge rules and backup files.

**Free to differ:** how Swift reaches the database, its indexes and caches, what's held in memory, and the screens. Use SQLite
with Android's tables and column names: the backup file, sync and the rule tests all use those names, so a different layout
only adds a translation step that can go wrong.

**The code to copy from:**

| What | Where |
|---|---|
| Tables | `Core/src/commonMain/kotlin/app/habits/core/Records.kt` |
| Fields as sync sees them | `SyncCodec.kt` (same folder) |
| Stamps | `Core/sync/src/commonMain/kotlin/app/habits/sync/Hlc.kt` |
| Merging | `SyncRules.kt` (same folder as `Hlc.kt`) |
| Writing changes, starting sync | `SyncWriter.kt`, `HabitRepository.kt` |
| Restoring | `Restore.kt` |
| The JSON inside settings | `Android/app/src/main/kotlin/com/oftenenough/app/data/SwiftJson.kt` |
| Reading rows for the rules | `Core/rules/src/commonMain/kotlin/app/habits/rules/Rows.kt`, `Core/spec/README.md` |
| Backup files | [Backup File Format](<../../Core/Backup File Format.md>) |

## 1. IDs

- Every habit, task, step, reminder and log has a UUID, made once on the phone and never changed.
- New IDs are upper case: Swift's `UUID().uuidString`, as Android's `newId()`.
- An ID is exact text. Never change its case, and never compare it ignoring case.
- Some IDs are made from other values and are lower case: a timer's log and a restored row (sections 7 and 13). Keep them as
  they are.
- A log's ID is made at the tap, so the same tap saved twice counts once.
- A custom time of day's ID is a UUID too. The built-in ones are `anytime`, `morning`, `afternoon` and `evening`.
- `quitting` is the ID of Today's "Quit or cut down" card. It's not a time of day.
- A setting has no ID: its key is its identity.
- Any row ID or setting key fits `[0-9A-Za-z_.:|-]`, at most 128 characters.

## 2. Tables and fields

Five tables hold people's data. Numbers are JSON numbers, text is JSON strings and booleans are real booleans, never text.

### `habit` (habits and tasks)

| Field | Type | Meaning |
|---|---|---|
| `id` | text | Section 1 |
| `name` | text | At most 24 characters |
| `symbol` | text | The SF Symbol's name |
| `symbol_names` | text or null | Every name the icon goes by, comma-separated: [Icon Names](<Icon Names in Backup Files — To Build.md>) |
| `color` | text | `red`, `orange`, `yellow`, `green`, `mint`, `teal`, `cyan`, `blue`, `indigo`, `purple`, `pink`, `brown`, `gray` |
| `kind` | text | `check`, `amount`, `duration`, `checklist`, `quit`, `task`. Never changes once made (D6) |
| `unit` | text or null | Amount: its unit. Check: its own word, if any |
| `increment` | number | Amount: what one tap adds, and 0 means + asks how much. Otherwise 1 |
| `part` | text | One time of day's ID (Rulebook, A118) |
| `goal` | number | The goal |
| `period` | text | Not used: always `day` |
| `schedule_days` | null | Not used: always null |
| `frequency` | text | Section 3 |
| `due_day` | `YYYY-MM-DD` or null | One-time task: its day |
| `due_minute` | number or null | One-time task: minutes after midnight |
| `at_most` | boolean | The goal is a limit |
| `quit_since` | ms or null | Quit: when the current run began |
| `position` | number | Order within the person's list |
| `created_at` | ms | When it was made |
| `updated_at` | ms | When it was last saved |
| `archived_at` | ms or null | Set while archived |
| `deleted_at` | ms or null | Section 9 |
| `remind` | boolean | Remind Me is on. When false, times only place the habit on Today |
| `alert` | text | `notification` or `alarm`. Read anything else as `notification` |
| `follow_up_minutes` | number or null | Remind Again If Not Done: 15, 30 or 60 |
| `starts_on` | `YYYY-MM-DD` or null | First day it counts. Null: the day it was made |
| `ends_on` | `YYYY-MM-DD` or null | Last day it's due. Null: never ends |
| `reminder_text` | text or null | The person's own reminder words, at most 24 characters |

### `step` (a checklist's steps)

`id`, `habit_id`, `name` (at most 24 characters), `position`, `deleted_at`.

### `reminder` (a habit's times)

`id`, `habit_id`, `hour`, `minute`, `deleted_at`. The time is on the phone's local clock.

### `entry` (logs)

| Field | Type | Meaning |
|---|---|---|
| `id` | text | Section 1 |
| `habit_id` | text | Its habit |
| `step_id` | text or null | Its step, on a checklist |
| `day` | `YYYY-MM-DD` | The day it counts for (section 6) |
| `value` | number | Section 7 |
| `created_at` | ms | When it happened |
| `time_zone` | text | The IANA name then: `TimeZone.current.identifier` |
| `deleted_at` | ms or null | Section 9 |
| `slot` | text or null | The time of day it belongs to |
| `source` | text or null | `today`, `manual`, `routine`, `reminder`, `timer`, `daySheet`, `shortcut`, `widget`, `watch` |

### `setting`

`key` and `value`, both text. See section 5.

### Reading a row

- Required on a habit: `name`, `symbol`, `color`, `kind`, `increment`, `part`, `goal`, `position`, `created_at`.
- Missing values take these defaults: `period` `day`, `frequency` `daily`, `at_most` false, `remind` true, `alert`
  `notification`, `updated_at` the same as `created_at`.
- **A row this version can't read is left out of the screens, never guessed at, rewritten or deleted.** That covers an unknown
  `kind`, `color` or `frequency`.
- Logs load only for habits that were read, and rows with `deleted_at` are left out of what people see.

## 3. `frequency`

| Stored text | Meaning |
|---|---|
| `daily` | Every day |
| `weekdays:2,4,6` | Those weekdays: 1 is Sunday, 7 is Saturday |
| `every:3` | Every 3 days |
| `weeks:2` | Every 2 weeks |
| `dates:1,15` | Those dates of the month |
| `week:3`, `month:4`, `year:6` | That many times in the period |
| `v2:` and base64 JSON | The newer kinds below |

The JSON after `v2:` is what Swift's `JSONEncoder` writes for an enum with values:

- `{"flexible":{"_0":"week","_1":3}}`
- `{"afterCompletion":{"_0":2,"_1":"week"}}`
- `{"calendar":{"_0":{…}}}`

A calendar rule must carry **every** field: `unit`, `interval`, `weekdays`, `dates`, `pattern` (`Dates`, `Last day` or
`Weekday`), `ordinal`, `weekday`, `month`, `day`, `useLastDay`, `anchorWeekStart`. A rule missing one isn't read at all.

Name the Swift cases and fields exactly as `SwiftJson.kt` does, so `JSONEncoder` gives this same text.

## 4. Days and moments

- A day in a field or a setting's plain text: `YYYY-MM-DD`.
- A moment in a field: milliseconds since 1970.
- Inside the JSON settings only, a day is `{"year":2026,"month":10,"day":12}`, and a moment is seconds since 1 January 2001
  (the default for Swift's `Date`). A missing value is left out, not null.

## 5. Settings

These are synced and backed up. `<id>` is the habit's ID.

| Key | Value |
|---|---|
| `day_end_hour` | 0 to 12 |
| `week_start` | 1 to 7. Missing: the phone's region |
| `day_sections` | JSON list of `{"id","name","start","end"}`, in minutes after midnight, with `start` and `end` left out when not set. Anytime has no `start` |
| `today_order` | JSON list of text |
| `skip.<id>` | Days, comma-separated |
| `move.<id>` | `from>to` day pairs, comma-separated |
| `pause.<id>` | JSON list of `{"from","through","pausedAt","resumedAt"}`. `through` and `resumedAt` are left out when not set |
| `rules.<id>` | Goal history: JSON list of `{"until","goal","frequency","kind","checkUnit","steps":[{"id","name"}]}`. `kind` is `{"check":{}}` or `{"amount":{"unit":"glasses","increment":1}}` |
| `timer.<id>` | A running timer: its start in ms, or `ms\|section` |
| `archived.<id>` | The day it was archived |
| `replacedby.<id>` | The ID of the habit that replaced it |
| `startedover.<id>` | What it was started over as |
| `note.<id>\|<day>` | That habit's note for that day, at most 1,000 characters |
| `daynote.<day>` | The day's note |
| `desc.<id>` | Description, at most 200 characters |
| `cost.<id>` | JSON `{"amount","currency"}` |

`skip.`, `move.`, `pause.`, `rules.`, `day_sections` and `today_order` may change: see the open points at the end.

A key this version doesn't know is kept as it is. Removing a setting goes through section 8 as `value: null`.

## 6. Which day a log belongs to

- A log's day is the local calendar day when it was logged, and it's stored in `day`. It's never worked out again from
  `created_at` (D7).
- "Today" is the store's today, with the day start applied, never `Date.now` or `Calendar.current` directly.
- A day's start hour is found on the clock with `Calendar.date(from:)`, never `date(bySettingHour:)` (D7).
- Day start and week start apply everywhere or nowhere.

## 7. What a log's `value` means

| Kind | `value` |
|---|---|
| `check` | 1 for each check |
| `amount` | The amount, in the habit's unit |
| `duration` | **Minutes**: whole seconds ÷ 60, so 90 seconds is 1.5 |
| `checklist` | 1 for each step, with `step_id` set |
| `quit` | 1 for each slip, with `created_at` the moment it happened |
| `task` | 1 when done |

A timer's log has `created_at` at the moment it stopped, and a run under one second makes no log.

**A timer's log ID** comes from the habit and the timer's start, so two phones stopping one timer make one log, not two:

1. Take the text `often-enough.timer-stop|<habit id in lower case>|<start in ms>` as UTF-8.
2. Take its SHA-256, and keep the first 16 bytes.
3. Set byte 6 to `(b & 0x0f) | 0x50`, and byte 8 to `(b & 0x3f) | 0x80`.
4. Write it as a lower-case UUID.

This can wait until sync is built, because it only affects new logs. It's short enough to build with timers.

## 8. Stamps and changes

**A stamp records when a field last changed.** Every field of every row has one, from the first version, whether or not sync
is on. Moving one phone to the server doesn't depend on them: a row without a stamp can be given a first one
(`stampExistingRows`). What they keep is the true order of changes when two copies meet.

**The format:** `000001790841344500-00000-<node>`: 18 digits of milliseconds, 5 of counter, then the node. Stamps are compared
as plain text.

**The node** identifies this phone: 16 hex characters, made once. A phone restored from another phone's device backup gets a
new one (`identifierForVendor` changed, D14).

**Making a stamp:**

- If the clock is later than the last stamp, use the clock's milliseconds, with counter 0.
- Otherwise keep the last stamp's milliseconds and add 1 to the counter.
- At 99,999, move to the next millisecond with counter 0.
- Save the last stamp in the same transaction as the change.

**Seeing another phone's stamp:** move past it, as `HlcClock.observe` does, so the next change here sorts after it, even if this
phone's clock is behind.

**A change:**

1. Compare the new values with what's stored. Only fields that differ become a change, and no difference means no change.
2. Give those fields one stamp.
3. Write the row and its stamps in one transaction.
4. If sync is on, put the change in the outbox in that same transaction.

Every write goes this way, including widgets, notifications and restores. Nothing writes to a data table around it.

**What's stored beside each row** (`sync_meta`, one row per table and row ID):

| Column | Holds |
|---|---|
| `hlc` | The stamp most fields share |
| `clocks` | JSON `{field: stamp}` for fields with another stamp, or null |
| `extra` | JSON `{field: value}` for fields this version doesn't know, or null |
| `pending` | True while a row can't be built yet because a change came before the rest of it |

**A change on the wire:**

```json
{"id":"<unique>","table":"habit","row":"<row id>","fields":{"name":"Water"},"hlc":"<stamp>","schema":11}
```

At most 64 fields and 32 KB of fields. Field names fit `[a-z][a-z0-9_]{0,63}`, and values are plain values, never lists or
objects. `id` can't be a field. `schema` is the app's schema number, so the iPhone needs to keep this in step with Android.

## 9. Merging and deleting

Merging gives the same answer in any order, however many times a change arrives. Copy `SyncRules.mergeFields` exactly.

1. **Field by field, the later stamp wins.** A name changed on one phone and a colour on the other both stay.
2. **A delete always wins.** An edit from another phone can't bring a deleted row back, even with a later stamp. Its other fields
   are still kept.
3. **"Not deleted" never overrides a delete.** Between two deletes, the later stamp's time is kept.
4. **Nothing is dropped.** Fields this version doesn't know are merged, kept in `extra` and passed on.
5. **The same change twice changes nothing.**
6. **A field with no stamp is ignored**, never guessed.
7. **A row is never replaced whole.** A missing row is never taken for a deleted one.

**Deleting marks a row; it doesn't remove it.**

- Habits, steps, reminders and logs get `deleted_at`, and the row stays. That covers undoing a log and removing a step or a time.
- A step or reminder keeps its ID when the habit is edited. Only one that was really removed gets `deleted_at`.
- A removed setting's row goes, but its stamps stay as `value: null`, so an older value can't come back.
- The only real erase is Erase All My Data, which the person chooses (D9).
- A log that's put back after a delete is a new log with a new ID.

## 10. Numbers that are worked out

Never store a streak, a best streak, progress or a milestone reached. They're always worked out from the logs (D6, Rulebook "A
streak is the logs").

The Swift rules must pass the 2,063 cases in `Core/fixtures`, which are plain files that any language can read. Some of those
cases hold a habit in several times of day, separated by commas. The rules must read those to pass, but the app only ever writes
one.

## 11. What stays on the phone

Never in the database's synced tables, and never in a backup or on a server:

- Appearance, vibration and sound
- Hide Done Habits and Hide Done Tasks
- Opening the timer screen, and the timer's notification
- Hiding names outside the app
- Today's milestones as already shown
- Widget choices, notices and questions asked once
- `placement_v1` and `placement_v2`, the only local settings stored in `setting` (`SyncCodec.isLocalSetting`)
- Whether this phone has Plus: the store says so (D16, D18)

A new setting is synced if it's about the person's habits, and stays on the phone if it's about this phone.

## 12. Limits on text

| Text | Most characters |
|---|---|
| Habit, task or step name | 24 |
| Time of day | 16 |
| Unit | 12 |
| Note | 1,000 |
| Description | 200 |
| Reminder words | 24 |

## 13. Backup files

A file made on either phone must open on the other (D5, D15). The format is
[Backup File Format](<../../Core/Backup File Format.md>). In short:

- A checked zip with `manifest.json`, `data.json` and `csv/`, named `Often Enough backup YYYY-MM-DD HHmm.zip`.
- `data.json` holds every row of every table, **deleted rows included**.
- Files don't carry stamps, and local settings are never written.
- Readers ignore fields and tables they don't know, and fill missing fields with the defaults in section 2.
- A restore goes through section 8, so its rows get fresh stamps, and keeps a 30-day undo file.

**Replace:**

- Live rows the file doesn't have get `deleted_at`.
- A row that's live in the file but deleted on this phone comes back under a new ID, and everything pointing at it follows,
  settings keys included.
- That ID is the UUID from the first 16 bytes of SHA-256 of `restored:<id>`, with byte 6 `(b & 0x0f) | 0x80` and byte 8
  `(b & 0x3f) | 0x80`, in lower case. Restoring the same file twice changes nothing.

**Merge:** new rows are added by ID, a habit edited later in the file updates the phone's copy, and settings already on the phone
stay. Copy `Restore.kt` for both.

## 14. iCloud

- The iPhone backs up and syncs through the person's own iCloud (D4, D12, D14). That design is the iPhone's own, but each
  CloudKit record has to carry every field's stamp, and fetched records merge by section 9.
- A fresh install fetches first, and sends nothing until its welcome is finished (D14).
- A backup never replaces a copy that has habits with an empty or much smaller one (D4).
- The server later takes data from the phone's own database, not from iCloud, so what's on the phone has to be complete by itself.

## 15. Upgrades

- Every database upgrade is tested from every past version, keeps a copy first and never resets on error (D2).
- A new field is added only if it's missing, and columns aren't dropped in the release that stops using them.
- Android's schema number and the iPhone's move together. A new field is written into this page, the backup format and
  `SyncCodec` the same day.
- A test launch never touches the person's data (D8).

## 16. Before the Swift storage is called done

- [ ] A file saved on the iPhone opens on Android, and one saved on Android opens on the iPhone, with every kind of habit, every
  `frequency`, notes, pauses, skips and deleted rows
- [ ] All 2,063 cases in `Core/fixtures` pass
- [ ] Merging gives Android's answers: the same changes in any order, a change applied twice, a delete against a later edit, an
  unknown field
- [ ] Every write path makes stamps, including widgets, notifications and restores
- [ ] Nothing is erased outside Erase All My Data
- [ ] Every upgrade path is tested from every past version

## 17. Moving to the server

Each phone sends its own database, so what matters is what's on the phone that day.

**On Android today:** `SyncWriter.bind` queues every row with its real stamps, deleted rows included, and `syncRequest` and
`acceptSyncReply` send them and take the reply. An update can also reshape anything on the phone before sending (D2).

**To build with the server version:**

- Accounts and the server. The old one is in git history (tag `server-final-2026-10`, and `account-server/` before 21 October 2026).
- The same sending step in Swift.
- A way for Google Drive and the server to run side by side. `sync.account` holds one account and there's one outbox, so
  binding to the server replaces Drive's binding today.
- New privacy wording, because "no server holds your habits" (D16) stops being true for people on the plan.

**Still to decide:**

- **Two phones with separate habits:** rows merge by ID, so habits made separately on an iPhone and an Android phone both stay,
  and "Water" shows twice. Nothing is lost, but nothing combines them. Habits moved by a backup file keep their IDs and merge
  properly.
- **People who already bought Plus:** whether they get the server or pay for the yearly plan. Plus's wording at launch shouldn't
  promise sync.

## Open: fix on Android before the release

Found on 6 November 2026, not changed yet. Nothing is lost until two phones share one account, so this can't happen on Android
before the server. Fixing it before the release keeps one format: afterwards, every app must read the old one for good (D5).
**Settle these before writing Swift's storage, so the iPhone starts with the final format.**

- **Lists in one value.** `skip.`, `move.`, `pause.` and `rules.` hold a habit's whole list in one setting, with one stamp. A
  Monday skip on one phone and a Tuesday skip on the other: the later save wins and the other is lost, which can break a streak.
  `note.` doesn't have this problem, because it's one key per habit and day. Each skip, move, pause and goal change needs its own
  key or row.
- **`day_sections` and `today_order`** are one value each too. A new time of day made on each phone keeps only one, and a habit
  in the lost one moves to the first section.
