# Local database: SQLite through Room 3, inside the Kotlin core

*Written by Claude (Claude Code), 27 Sep 2026. Build-plan task 4 ([iOS/Build Plan.md](<../iOS/Build Plan.md>)). Settles Backlog contradiction C2.*

**The question.** Which local database do we use, given that it must:
- run on iPhone, Android, Mac, Windows and the web;
- fit the Kotlin Multiplatform shared core ([decision](<Shared Core Decision.md>));
- be well established;
- be easy to build with AI;
- never lose data?

## Decision

1. **The storage engine is SQLite, on every platform.** It is the most widely deployed database in the world, has been in every iPhone and Android phone for over 15 years, and has a file format that stays stable for decades. It is also what the architecture docs already assume (topic 5).
2. **The library is Room 3 (`androidx.room3`), used from the Kotlin shared core.** Google's persistence library became multiplatform in Room 2.7 and reached **3.0 stable on 1 Jul 2026** (3.0.3 on 9 Sep 2026). It covers Android, iOS, desktop JVM (Windows and Mac) and, new in 3.0, **JavaScript and WebAssembly**. On the web it runs SQLite in a Web Worker and stores the database in the browser's persistent file system (OPFS). ([Room 3.0 announcement](https://android-developers.googleblog.com/2026/03/room-30-modernizing-room.html), [release notes](https://developer.android.com/jetpack/androidx/releases/room3))
3. **SQLite itself ships inside the app** (`BundledSQLiteDriver`), so every platform runs the same SQLite version, as Google recommends ([Room for KMP](https://developer.android.com/kotlin/multiplatform/room)). On the web: `WebWorkerSQLiteDriver`.
4. **One schema, one set of migrations, one set of queries** for every platform, written once in `Core/`. Swift and the web call a small repository API; they never write SQL.

This replaces the earlier "GRDB on iOS, Room on Android" plan in the [Shared Core Decision](<Shared Core Decision.md>) (Backlog C2). One implementation is less to maintain than five, and it keeps the "same data, same answers everywhere" rule.

## Options compared

| Option | Every platform we need? | Established | Easy with AI | Verdict |
|---|---|---|---|---|
| **Room 3 + SQLite** | Android, iOS, JVM desktop (Windows, Mac), JS, Wasm; web persists in OPFS | Room since 2017, millions of Android apps; Google's official KMP path | The most-written Android database API. The 3.0 changes are small and documented: suspend DAOs, KSP only, driver API | **Chosen** |
| SQLDelight + SQLite | All native targets, including macOS and watchOS | Cash App, since 2016 | Plain SQL files, which AI writes well | **Runner-up.** Its web driver defaults to an in-memory database (sql.js); persistence needs a custom OPFS worker, and automatic migrations don't run on the web driver |
| GRDB (iOS) + Room (Android) + IndexedDB (web) | One library per platform | Each is solid | Three schemas and three migration histories to keep identical | Rejected: triple the work and the risk of drift |
| SwiftData / Core Data | Apple only | Mature | — | Rejected: not cross-platform |
| Realm | — | Deprecated by MongoDB in Sep 2024, end of life Sep 2025 ([source](https://github.com/realm/realm-swift/discussions/8680)) | — | Rejected |

## How it keeps data safe (task 5 builds these)

| Rule | How |
|---|---|
| A tap is saved before the screen changes | Every change is one SQLite transaction, run one at a time in order; memory and the screen update only after the commit. If a write fails, the app reloads from the database and says so |
| Crashes and power loss can't corrupt or undo a save | WAL journal with `synchronous = FULL` (a committed change survives power loss) |
| Right place on disk | iOS: `Application Support` (included in the phone's own iCloud/Finder backup, hidden from Files), file protection "until first unlock" so widgets and reminders work after a restart |
| Schema changes never lose data | Room schema export + versioned migrations; a migration test for every shipped version; a copy of the file taken before each migration (topic 8 §3); never `fallbackToDestructiveMigration` |
| Local snapshots | A daily `VACUUM INTO` copy: the last 7 days plus one a week for 5 weeks (safety net 2); "Restore to this point" later |
| Sync-ready | UUID IDs, entries as events, tombstones (`deleted_at`) and `updated_at` from the first schema (topic 5). The outbox table arrives with Plus sync; the first sign-in uploads everything, so no old data needs migrating (topic 5 §5) |

## What changes in the iOS app

- A `Core/` Gradle module (Kotlin Multiplatform) holds the schema, Room DAOs and a small `HabitRepository`. It builds an Apple framework that Xcode links using the official direct integration (`embedAndSignAppleFrameworkForXcode`) ([Kotlin docs](https://kotlinlang.org/docs/multiplatform/multiplatform-direct-integration.html)).
- Swift's `HabitStore` keeps its role (UI state) and reads and writes through the repository. The day, streak and progress rules move into `Core` in a later step, per the shared-core decision.
- **Checked 27 Sep:** Room 3.0.3 publishes macOS, watchOS and tvOS builds as well. Swift calls Kotlin `suspend` functions through the standard Objective-C bridge (completion handlers / Swift `async`); add SKIE only if that proves awkward.

## Sources

- [Room 3.0 — Modernizing the Room](https://android-developers.googleblog.com/2026/03/room-30-modernizing-room.html) (Android Developers Blog, Mar 2026)
- [Room 3 release notes](https://developer.android.com/jetpack/androidx/releases/room3)
- [Set up Room for KMP](https://developer.android.com/kotlin/multiplatform/room) and [SQLite for KMP](https://developer.android.com/kotlin/multiplatform/sqlite)
- [SQLDelight multiplatform JS docs](https://github.com/BinaryTape/Open-Docs/blob/main/docs/sqldelight/js_sqlite/multiplatform.md) (web worker limits)
- [Realm deprecation discussion](https://github.com/realm/realm-swift/discussions/8680)
- [Kotlin direct integration with Xcode](https://kotlinlang.org/docs/multiplatform/multiplatform-direct-integration.html)

## Built (27 Sep 2026, build-plan task 5)

- `Core/`: Kotlin Multiplatform module (Kotlin 2.4.20, Room 3.0.3, bundled SQLite 2.7.1). Tables `habit`, `step`, `reminder`, `entry`, `setting`; schema v1 exported to `Core/schemas/`. Seven JVM tests pass (reopen, retried write counts once, tombstones, edits, WAL + synchronous FULL, snapshot copy, import).
- iOS: `Persistence.swift` (file, pre-upgrade copy, daily snapshots), `RecordMapping.swift`, `HabitStore` writing through `HabitRepository`. On the iPhone, `PersistenceUITests` proves a habit, a tick and an undo survive the app being killed.
- **Schema 2 (27 Sep 2026):** one frequency rule per habit, checklists and one-time tasks. Added columns only (`frequency`, `due_day`, `due_minute`); `MigrationTest` upgrades a real schema-1 database built from `schemas/…/1.json`. The iPhone's own schema-1 database upgraded in place with its habits intact.
- **Schema 3 (27 Sep 2026):** a Check it off habit can sit in several day sections (`habit.part` holds their IDs, comma-separated) and each tick records its section in the new `entry.slot` column (added only; old ticks have none and still count). `MigrationTest` also upgrades a real schema-2 database; all 9 Core tests pass.
