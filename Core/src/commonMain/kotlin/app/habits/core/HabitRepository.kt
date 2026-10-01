package app.habits.core

import androidx.room3.RoomDatabase
import androidx.room3.useWriterConnection
import androidx.sqlite.SQLiteConnection
import androidx.sqlite.driver.bundled.BundledSQLiteDriver
import androidx.sqlite.execSQL
import app.habits.sync.SyncRules
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonArray
import kotlinx.serialization.json.JsonNull
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive
import kotlinx.serialization.json.booleanOrNull
import kotlinx.serialization.json.contentOrNull
import kotlinx.serialization.json.jsonArray
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.json.jsonPrimitive
import kotlinx.serialization.json.long

/**
 * The only way the apps read or write local data. Every call is one SQLite transaction;
 * a call that returns has been committed to disk (WAL + synchronous=FULL survives power loss).
 */
class HabitRepository private constructor(private val database: HabitDatabase, private val clock: () -> Long) {
    private val dao = database.dao()

    suspend fun load(): Snapshot = dao.snapshot()

    // Every write below is one transaction that also records the change for sync (SyncWriter).

    suspend fun saveHabit(habit: HabitRecord, steps: List<StepRecord>, reminders: List<ReminderRecord>, at: Long) =
        dao.synced(clock()) { sync ->
            sync.change(SyncCodec.HABIT, habit.id, SyncCodec.habit(habit))
            val keepSteps = steps.map { it.id }.toSet()
            dao.liveSteps(habit.id).filter { it.id !in keepSteps }.forEach { sync.change(SyncCodec.STEP, it.id, SyncCodec.step(it.copy(deletedAt = at))) }
            steps.forEach { sync.change(SyncCodec.STEP, it.id, SyncCodec.step(it)) }
            val keepReminders = reminders.map { it.id }.toSet()
            dao.liveReminders(habit.id).filter { it.id !in keepReminders }.forEach { sync.change(SyncCodec.REMINDER, it.id, SyncCodec.reminder(it.copy(deletedAt = at))) }
            reminders.forEach { sync.change(SyncCodec.REMINDER, it.id, SyncCodec.reminder(it)) }
        }

    /** The ID is made at the tap: saving the same tap again (a retry) changes nothing. */
    suspend fun addEntry(entry: EntryRecord) = dao.synced(clock()) { sync -> addEntry(sync, entry) }

    /** Undo keeps a tombstone rather than deleting the row (Architecture 05 §7). */
    suspend fun removeEntry(id: String, at: Long) = dao.synced(clock()) { sync -> removeEntry(sync, id, at) }

    suspend fun saveSetting(key: String, value: String) {
        if (SyncCodec.isLocalSetting(key)) return dao.upsertSetting(SettingRecord(key, value))
        dao.synced(clock()) { sync -> sync.change(SyncCodec.SETTING, key, mapOf("value" to JsonPrimitive(value))) }
    }

    suspend fun removeSetting(key: String) {
        if (SyncCodec.isLocalSetting(key)) return dao.deleteSetting(key)
        dao.synced(clock()) { sync -> removeSetting(sync, key) }
    }

    /** Stopping a timer must never save elapsed time without removing its running marker. */
    suspend fun finishTimer(entry: EntryRecord?, key: String) = dao.synced(clock()) { sync ->
        if (entry != null) addEntry(sync, entry)
        removeSetting(sync, key)
    }

    /** Adds everything in one transaction; rows that already exist (live or deleted) are kept as they are. */
    suspend fun importAll(snapshot: Snapshot) = dao.synced(clock()) { sync ->
        snapshot.habits.filterNot { sync.exists(SyncCodec.HABIT, it.id) }.forEach { sync.change(SyncCodec.HABIT, it.id, SyncCodec.habit(it)) }
        snapshot.steps.filterNot { sync.exists(SyncCodec.STEP, it.id) }.forEach { sync.change(SyncCodec.STEP, it.id, SyncCodec.step(it)) }
        snapshot.reminders.filterNot { sync.exists(SyncCodec.REMINDER, it.id) }.forEach { sync.change(SyncCodec.REMINDER, it.id, SyncCodec.reminder(it)) }
        snapshot.entries.forEach { addEntry(sync, it) }
        for (setting in snapshot.settings) {
            if (SyncCodec.isLocalSetting(setting.key)) dao.insertSettingsIfNew(listOf(setting))
            else if (!sync.exists(SyncCodec.SETTING, setting.key)) sync.change(SyncCodec.SETTING, setting.key, SyncCodec.setting(setting))
        }
    }

    private suspend fun addEntry(sync: SyncWriter, entry: EntryRecord) {
        if (!sync.exists(SyncCodec.ENTRY, entry.id)) sync.change(SyncCodec.ENTRY, entry.id, SyncCodec.entry(entry))
    }

    private suspend fun removeEntry(sync: SyncWriter, id: String, at: Long) {
        val entry = dao.entryById(id)?.takeIf { it.deletedAt == null } ?: return
        sync.change(SyncCodec.ENTRY, id, SyncCodec.entry(entry.copy(deletedAt = at)))
    }

    private suspend fun removeSetting(sync: SyncWriter, key: String) {
        if (dao.settingByKey(key) != null) sync.change(SyncCodec.SETTING, key, mapOf("value" to JsonNull))
    }

    // MARK: Sync with the server (Architecture 05, 06 §4). The platform sends the request and hands back the reply.

    /** Starts syncing this device's data with [accountId], right after sign-in. See [SyncWriter.bind]. */
    suspend fun bindAccount(accountId: String) = dao.synced(clock()) { it.bind(accountId) }

    /** The next request for `POST /v1/sync`: the cursor and up to [maxOps] unsent changes, oldest first. */
    suspend fun syncRequest(maxOps: Int = 500): String {
        val cursor = dao.state(SyncWriter.CURSOR)?.toLongOrNull() ?: 0
        val ops = dao.outbox(maxOps).map { Json.parseToJsonElement(it.op) }
        return JsonObject(mapOf("cursor" to JsonPrimitive(cursor), "ops" to JsonArray(ops))).toString()
    }

    /**
     * Applies the server's reply in one transaction: acknowledged changes leave the outbox, other devices' changes
     * are merged in, and the cursor moves on. Returns true when another round is needed straight away.
     * If the app dies before this commits, nothing is lost: the next round resends the same ops, which the server
     * recognises, and pulls from the old cursor again.
     */
    suspend fun acceptSyncReply(reply: String): Boolean {
        val o = Json.parseToJsonElement(reply).jsonObject
        val applied = o["applied"]?.jsonArray?.map { it.jsonPrimitive.content } ?: emptyList()
        val rejected = o["rejected"]?.jsonArray?.mapNotNull { r ->
            val id = r.jsonObject["id"]?.jsonPrimitive?.contentOrNull ?: return@mapNotNull null
            id to (r.jsonObject["problem"]?.jsonPrimitive?.contentOrNull ?: "rejected")
        } ?: emptyList()
        val ops = o["ops"]?.jsonArray?.mapNotNull { (it as? JsonObject)?.let(SyncRules::opFrom) } ?: emptyList()
        val cursor = o.getValue("cursor").jsonPrimitive.long
        val more = o["more"]?.jsonPrimitive?.booleanOrNull ?: false
        val now = clock()
        return dao.synced(now) { sync ->
            applied.chunked(500).forEach { dao.deleteOutbox(it) }
            rejected.forEach { (id, problem) -> dao.markOutboxProblem(id, problem) }
            ops.filter { SyncRules.problem(it) == null }.forEach { sync.receive(it) }
            dao.setState(LocalStateRecord(SyncWriter.CURSOR, cursor.toString()))
            dao.setState(LocalStateRecord(SyncWriter.LAST_SYNCED, now.toString()))
            more || dao.outboxCount() > 0
        }
    }

    /** For Settings → Account & backup: "Synced 2 min ago", or how many changes are waiting. */
    suspend fun syncStatus(): SyncStatus = SyncStatus(
        accountId = dao.state(SyncWriter.ACCOUNT),
        waiting = dao.outboxCount(),
        keptAside = dao.outboxProblemCount(),
        lastSyncedAt = dao.state(SyncWriter.LAST_SYNCED)?.toLongOrNull(),
    )

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
        const val SCHEMA_VERSION = 6

        fun open(path: String): HabitRepository = HabitRepository(configure(databaseBuilder(path)), ::currentTimeMillis)

        /** A throwaway database, for UI tests. */
        fun openInMemory(): HabitRepository = HabitRepository(configure(inMemoryDatabaseBuilder()), ::currentTimeMillis)

        /** For tests: a database whose sync clock reads [clock] instead of the wall clock. */
        internal fun open(path: String, clock: () -> Long): HabitRepository = HabitRepository(configure(databaseBuilder(path)), clock)

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

/** Where sync stands on this device. */
data class SyncStatus(
    /** The account this device syncs with, or null if it never signed in. */
    val accountId: String?,
    /** Changes not yet acknowledged by the server. */
    val waiting: Int,
    /** Changes the server can never accept (kept, not retried). */
    val keptAside: Int,
    /** When the server last acknowledged a sync (epoch ms): the only time "Synced" may be shown (05 §11.2). */
    val lastSyncedAt: Long?,
)
