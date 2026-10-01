# Core

The Kotlin Multiplatform shared core ([decision](<../Architecture/Shared Core Decision.md>)).

- **Today:** local storage — SQLite through Room 3 ([decision](<../Architecture/Local Database Decision.md>)). `HabitRepository` is the only way apps read and write data.
- **Sync** (`sync/`, shared with the server) and **backup files and restore** ([format](<Backup File Format.md>)): `backupFile`, `checkBackup` (the preview), `restore` (Replace or Merge, with undo).
- **Next:** the day, schedule, streak and progress rules, with `spec/` and shared `fixtures/`.
- **Targets:** JVM (tests; later desktop), iOS device and simulator. Android, macOS and web are added when those apps start.

```bash
cd Core && ./gradlew jvmTest
```

The iOS app builds this module itself (Xcode "Build Kotlin Core" phase). Every schema change bumps `HabitRepository.SCHEMA_VERSION`, adds a migration, and keeps the exported schema in `schemas/`.
