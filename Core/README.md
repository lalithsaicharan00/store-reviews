# Core

The Kotlin Multiplatform shared core ([decision](<../Architecture/Shared Core Decision.md>)).

- **Today:** local storage — SQLite through Room 3 ([decision](<../Architecture/Local Database Decision.md>)). `HabitRepository` is the only way apps read and write data.
- **Sync** (`sync/`, shared with the server) and **backup files and restore** ([format](<Backup File Format.md>)): `backupFile`, `checkBackup` (the preview), `restore` (Replace or Merge, with undo).
- **The habit rules** (`rules/`, package `app.habits.rules`, Current Work 92): which day a log belongs to, schedules,
  goals, streaks, quit runs, how a day counts across habits, where habits show on Today. Pure Kotlin (no database, no
  clock: "now" and the time zone are inputs), one copy for every app. Written down in [`spec/`](spec/README.md); proven
  against the iPhone's own recorded answers by the golden cases in [`fixtures/`](fixtures/README.md) (`GoldenTest`,
  2,063 cases; `python3 fixtures/tools/generate.py` makes their inputs first). Apps call it through `LiveRules` (a live
  copy of the data, plain values across the bridge) or build `HabitRules` from `Rows.load` / `RulesInput`.
- **Targets:** JVM (tests; later desktop), iOS device and simulator. Android, macOS and web are added when those apps start.

```bash
cd Core && python3 fixtures/tools/generate.py && ./gradlew jvmTest
```

The iOS app builds this module itself (Xcode "Build Kotlin Core" phase). Every schema change bumps `HabitRepository.SCHEMA_VERSION`, adds a migration, and keeps the exported schema in `schemas/`.
