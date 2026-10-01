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

    @Throws(Exception::class)
    suspend fun load(): Snapshot = dao.snapshot()

    @Throws(Exception::class)
    suspend fun saveHabit(habit: HabitRecord, steps: List<StepRecord>, reminders: List<ReminderRecord>, at: Long) =
        dao.saveHabit(habit, steps, reminders, at)

    /** Includes tombstones, so replaying an undone system action cannot bring it back. */
    @Throws(Exception::class)
    suspend fun hasEntry(id: String): Boolean = dao.hasEntry(id)

    @Throws(Exception::class)
    suspend fun addEntry(entry: EntryRecord) = dao.insertEntries(listOf(entry))

    /** Correct one live entry without changing its ID, provenance or deletion state. */
    suspend fun editEntry(id: String, value: Double, createdAt: Long) = dao.editEntry(id, value, createdAt)

    /** Undo keeps a tombstone rather than deleting the row (Architecture 05 §7). */
    @Throws(Exception::class)
    suspend fun removeEntry(id: String, at: Long) = dao.tombstoneEntry(id, at)

    @Throws(Exception::class)
    suspend fun saveSetting(key: String, value: String) = dao.upsertSetting(SettingRecord(key, value))

    @Throws(Exception::class)
    suspend fun removeSetting(key: String) = dao.deleteSetting(key)

    @Throws(Exception::class)
    suspend fun mergeAll(snapshot: Snapshot) = dao.mergeAll(snapshot)

    /** Unlike launch data, a backup must carry deletion markers to a fresh installation. */
    @Throws(Exception::class)
    suspend fun loadForRestore(): Snapshot = dao.restoreSnapshot()

    @Throws(Exception::class)
    suspend fun finishTimer(entry: EntryRecord?, key: String) = dao.finishTimer(entry, key)

    /** Writes everything in one transaction; rows that already exist are kept as they are. */
    @Throws(Exception::class)
    suspend fun importAll(snapshot: Snapshot) = dao.importAll(snapshot)

    /** A consistent copy of the whole database to `path` (SQLite `VACUUM INTO`), for local snapshots. */
    @Throws(Exception::class)
    suspend fun snapshot(path: String) {
        database.useWriterConnection { transactor ->
            transactor.usePrepared("VACUUM INTO ?") { statement ->
                statement.bindText(1, path)
                statement.step()
            }
        }
    }

    /** For tests and diagnostics: the value of a PRAGMA on the writer connection. */
    @Throws(Exception::class)
    suspend fun pragma(name: String): String =
        database.useWriterConnection { transactor ->
            transactor.usePrepared("PRAGMA $name") { statement ->
                if (statement.step()) statement.getText(0) else ""
            }
        }

    @Throws(Exception::class)
    fun close() = database.close()

    companion object {
        /** Bump with every schema change, and add a migration plus a migration test. */
        const val SCHEMA_VERSION = 6

        @Throws(Exception::class)
        fun open(path: String): HabitRepository = HabitRepository(configure(databaseBuilder(path)))

        /** A throwaway database, for UI tests. */
        fun openInMemory(): HabitRepository = HabitRepository(configure(inMemoryDatabaseBuilder()))

        private fun configure(builder: RoomDatabase.Builder<HabitDatabase>): HabitDatabase =
            builder
                .setDriver(BundledSQLiteDriver())
                .setQueryCoroutineContext(databaseDispatcher)
                .addMigrations(Migrations.v1ToV2, Migrations.v2ToV3, Migrations.v3ToV4, Migrations.v4ToV5, Migrations.v5ToV6)
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
