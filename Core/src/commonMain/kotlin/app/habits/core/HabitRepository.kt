package app.habits.core

import androidx.room3.RoomDatabase
import androidx.room3.useWriterConnection
import androidx.sqlite.SQLiteConnection
import androidx.sqlite.driver.bundled.BundledSQLiteDriver
import androidx.sqlite.execSQL

/**
 * The only way the apps read or write local data. Every call is one SQLite transaction;
 * a call that returns has been committed to disk (WAL + synchronous=FULL survives power loss).
 */
class HabitRepository private constructor(private val database: HabitDatabase) {
    private val dao = database.dao()

    suspend fun load(): Snapshot = dao.snapshot()

    suspend fun saveHabit(habit: HabitRecord, steps: List<StepRecord>, reminders: List<ReminderRecord>, at: Long) =
        dao.saveHabit(habit, steps, reminders, at)

    suspend fun addEntry(entry: EntryRecord) = dao.insertEntries(listOf(entry))

    /** Undo keeps a tombstone rather than deleting the row (Architecture 05 §7). */
    suspend fun removeEntry(id: String, at: Long) = dao.tombstoneEntry(id, at)

    suspend fun saveSetting(key: String, value: String) = dao.upsertSetting(SettingRecord(key, value))

    suspend fun removeSetting(key: String) = dao.deleteSetting(key)

    suspend fun finishTimer(entry: EntryRecord?, key: String) = dao.finishTimer(entry, key)

    /** Writes everything in one transaction; rows that already exist are kept as they are. */
    suspend fun importAll(snapshot: Snapshot) = dao.importAll(snapshot)

    /** A consistent copy of the whole database to `path` (SQLite `VACUUM INTO`), for local snapshots. */
    suspend fun snapshot(path: String) {
        database.useWriterConnection { transactor ->
            transactor.usePrepared("VACUUM INTO ?") { statement ->
                statement.bindText(1, path)
                statement.step()
            }
        }
    }

    /** For tests and diagnostics: the value of a PRAGMA on the writer connection. */
    suspend fun pragma(name: String): String =
        database.useWriterConnection { transactor ->
            transactor.usePrepared("PRAGMA $name") { statement ->
                if (statement.step()) statement.getText(0) else ""
            }
        }

    fun close() = database.close()

    companion object {
        /** Bump with every schema change, and add a migration plus a migration test. */
        const val SCHEMA_VERSION = 5

        fun open(path: String): HabitRepository = HabitRepository(configure(databaseBuilder(path)))

        /** A throwaway database, for UI tests. */
        fun openInMemory(): HabitRepository = HabitRepository(configure(inMemoryDatabaseBuilder()))

        private fun configure(builder: RoomDatabase.Builder<HabitDatabase>): HabitDatabase =
            builder
                .setDriver(BundledSQLiteDriver())
                .setQueryCoroutineContext(databaseDispatcher)
                .addMigrations(Migrations.v1ToV2, Migrations.v2ToV3, Migrations.v3ToV4, Migrations.v4ToV5)
                .addCallback(Durability)
                .build()
    }

    private object Durability : RoomDatabase.Callback() {
        override suspend fun onOpen(connection: SQLiteConnection) {
            connection.execSQL("PRAGMA synchronous = FULL")
            connection.execSQL("PRAGMA foreign_keys = ON")
        }
    }
}
