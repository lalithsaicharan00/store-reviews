package app.habits.core

import androidx.room3.RoomDatabase
import androidx.room3.useWriterConnection
import androidx.sqlite.SQLiteConnection
import androidx.sqlite.driver.bundled.BundledSQLiteDriver
import androidx.sqlite.execSQL
import app.habits.sync.SyncRules
import kotlinx.coroutines.withContext
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonArray
import kotlinx.serialization.json.JsonNull
import kotlinx.serialization.json.JsonElement
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

    /** Sync with the person's iCloud (Architecture 11): what CloudKit sends and what it brought, each in one transaction. */
    val cloud = CloudStore(dao, clock)

    @Throws(Exception::class)
    suspend fun load(): Snapshot = dao.snapshot()

    // Every write below is one transaction that also records the change for sync (SyncWriter).

    @Throws(Exception::class)
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

    /** Includes tombstones, so replaying an undone system action cannot bring it back. */
    @Throws(Exception::class)
    suspend fun hasEntry(id: String): Boolean = dao.hasEntry(id)

    /** The ID is made at the tap: saving the same tap again (a retry) changes nothing. */
    @Throws(Exception::class)
    suspend fun addEntry(entry: EntryRecord) = dao.synced(clock()) { sync -> addEntry(sync, entry) }

    /** Correct one live entry without changing its ID, provenance or deletion state. Synced like any edit. */
    @Throws(Exception::class)
    suspend fun editEntry(id: String, value: Double, createdAt: Long) = dao.synced(clock()) { sync ->
        val entry = dao.entryById(id)?.takeIf { it.deletedAt == null } ?: return@synced
        sync.change(SyncCodec.ENTRY, id, SyncCodec.entry(entry.copy(value = value, createdAt = createdAt)))
    }

    /** Undo keeps a tombstone rather than deleting the row (Architecture 05 §7). */
    @Throws(Exception::class)
    suspend fun removeEntry(id: String, at: Long) = dao.synced(clock()) { sync -> removeEntry(sync, id, at) }

    @Throws(Exception::class)
    suspend fun saveSetting(key: String, value: String) {
        if (SyncCodec.isLocalSetting(key)) return dao.upsertSetting(SettingRecord(key, value))
        dao.synced(clock()) { sync -> sync.change(SyncCodec.SETTING, key, mapOf("value" to JsonPrimitive(value))) }
    }

    @Throws(Exception::class)
    suspend fun removeSetting(key: String) {
        if (SyncCodec.isLocalSetting(key)) return dao.deleteSetting(key)
        dao.synced(clock()) { sync -> removeSetting(sync, key) }
    }

    /** Stopping a timer must never save elapsed time without removing its running marker. */
    @Throws(Exception::class)
    suspend fun finishTimer(entry: EntryRecord?, key: String) = dao.synced(clock()) { sync ->
        if (entry != null) addEntry(sync, entry)
        removeSetting(sync, key)
    }

    /**
     * Restores an old `.db` backup by adding what's missing (the Backup & Export screen's restore, before the checked
     * backup file): existing habits keep their configuration, a deleted habit stays deleted, and global settings are
     * only taken on an empty device. Every row goes through [SyncWriter], so a synced device sends it on.
     */
    @Throws(Exception::class)
    suspend fun mergeAll(snapshot: Snapshot) = dao.synced(clock()) { sync ->
        val known = dao.allHabitIds().toSet() // Includes tombstones: a deleted habit must stay deleted.
        val added = snapshot.habits.filter { it.id !in known }
        val newIds = added.map { it.id }.toSet()
        val live = dao.habits().map { it.id }.toSet() + added.filter { it.deletedAt == null }.map { it.id }
        added.forEach { sync.change(SyncCodec.HABIT, it.id, SyncCodec.habit(it)) }
        snapshot.steps.filter { it.habitId in newIds && !sync.exists(SyncCodec.STEP, it.id) }.forEach { sync.change(SyncCodec.STEP, it.id, SyncCodec.step(it)) }
        snapshot.reminders.filter { it.habitId in newIds && !sync.exists(SyncCodec.REMINDER, it.id) }.forEach { sync.change(SyncCodec.REMINDER, it.id, SyncCodec.reminder(it)) }
        snapshot.entries.filter { it.habitId in live }.forEach { addEntry(sync, it) }
        val globalKeys = setOf("day_end_hour", "week_start", "day_sections", "show_streaks", "haptics", "sounds", "appearance")
        val habitPrefixes = listOf("rules.", "pause.", "skip.", "move.", "desc.", "archived.")
        val wanted = snapshot.settings.filter { setting ->
            when {
                setting.key in globalKeys -> known.isEmpty()
                setting.key.startsWith("daynote.") -> true
                setting.key.startsWith("note.") -> setting.key.removePrefix("note.").substringBefore('|') in live
                else -> habitPrefixes.any { prefix -> setting.key.startsWith(prefix) && setting.key.removePrefix(prefix) in newIds }
            }
        }
        for (setting in wanted) {
            if (SyncCodec.isLocalSetting(setting.key)) dao.insertSettingsIfNew(listOf(setting))
            else if (dao.settingByKey(setting.key) == null && !sync.exists(SyncCodec.SETTING, setting.key)) sync.change(SyncCodec.SETTING, setting.key, SyncCodec.setting(setting))
        }
    }

    /** Adds everything in one transaction; rows that already exist (live or deleted) are kept as they are. */
    @Throws(Exception::class)
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

    /**
     * Swift calls these on the main thread, and a suspend function runs there until its first database call. Building,
     * checking or parsing a file of a year's history takes long enough to stall the screen (PERFORMANCE.md rule 7), so
     * that work runs on the database's background dispatcher.
     */
    private suspend fun <T> offMain(work: suspend () -> T): T = withContext(databaseDispatcher) { work() }

    // MARK: Backup and restore (Architecture 03 §3.2, §3.6). The platform stores and sends the file; see BackupFile.

    /** Unlike launch data, a backup must carry deletion markers to a fresh installation. */
    @Throws(Exception::class)
    suspend fun loadForRestore(): Snapshot = dao.restoreSnapshot()

    /** The checked backup file of everything on this device, deleted rows included. */
    @Throws(Exception::class)
    suspend fun backupFile(info: BackupInfo): BackupFileData = offMain { BackupFile.write(dao.restoreSnapshot(), info, clock()) }

    /**
     * The same file for the automatic backups (iCloud, the account), without the CSV copies a person opens in a
     * spreadsheet: smaller to send as you go, and imported the same way by every app version (Current Work 75).
     */
    @Throws(Exception::class)
    suspend fun automaticBackupFile(info: BackupInfo): BackupFileData = offMain {
        BackupFile.write(dao.restoreSnapshot(), info, clock(), readable = false)
    }

    /**
     * Checks a backup file (base64) and says what restoring it would change, both ways. Never throws for a bad file:
     * `problem` says why it can't be used, and nothing is changed.
     */
    @Throws(Exception::class)
    suspend fun checkBackup(file: String): BackupCheck = offMain {
        val contents = try {
            BackupFile.read(file)
        } catch (problem: BackupProblem) {
            return@offMain BackupCheck(problem.reason, null)
        }
        val (phone, known) = dao.restoreState()
        val now = clock()
        val live = { s: Snapshot -> s.habits.count { it.deletedAt == null } to s.entries.count { it.deletedAt == null } }
        val (fileHabits, fileEntries) = live(contents.snapshot)
        val (phoneHabits, phoneEntries) = live(phone)
        BackupCheck(
            problem = null,
            preview = RestorePreview(
                createdAt = contents.createdAt, deviceName = contents.deviceName, platform = contents.platform, appVersion = contents.appVersion,
                fileHabits = fileHabits, fileEntries = fileEntries, phoneHabits = phoneHabits, phoneEntries = phoneEntries,
                replace = RestorePlanner.plan(phone, known, contents.snapshot, RestoreMode.REPLACE, now).counts,
                merge = RestorePlanner.plan(phone, known, contents.snapshot, RestoreMode.MERGE, now).counts,
            ),
        )
    }

    /**
     * Restores a backup file (base64) in one transaction, after checking it again. The result carries the undo file:
     * this device exactly as it was just before (03 §3.6 step 3). Restoring that with [RestoreMode.REPLACE] undoes it.
     * Throws [BackupProblem] for a bad file, before anything is changed.
     */
    @Throws(Exception::class)
    suspend fun restore(file: String, mode: RestoreMode, info: BackupInfo): RestoreResult = offMain {
        val contents = BackupFile.read(file)
        val now = clock()
        dao.synced(now) { sync ->
            // The person chose this restore and saw what it removes: one explicit action (Architecture 11 §13.2).
            sync.explicitDeletes = true
            val phone = dao.restoreSnapshot()
            val undo = BackupFile.write(phone, info, now)
            val plan = RestorePlanner.plan(phone, dao.knownSettingKeys().toSet(), contents.snapshot, mode, now)
            plan.changes.forEach { sync.change(it.table, it.row, it.fields) }
            RestoreResult(plan.counts, undo)
        }
    }

    /**
     * "Also erase this iPhone's data" after deleting the account, and "Erase all my data" (Architecture 09 §7): every
     * row, deletion markers and sync state included, so nothing is left and nothing syncs. Not undoable; the app offers
     * an export first. Not routed through sync on purpose: other devices keep their own copy.
     */
    @Throws(Exception::class)
    suspend fun eraseAllData() = dao.eraseAll()

    // MARK: Sync with the server (Architecture 05, 06 §4). The platform sends the request and hands back the reply.

    /** Starts syncing this device's data with [accountId], right after sign-in. See [SyncWriter.bind]. */
    @Throws(Exception::class)
    suspend fun bindAccount(accountId: String) = dao.synced(clock()) { it.bind(accountId) }

    /** The next request for `POST /v1/sync`: the cursor and up to [maxOps] unsent changes, oldest first. */
    @Throws(Exception::class)
    suspend fun syncRequest(maxOps: Int = 500): String = offMain {
        val cursor = dao.state(SyncWriter.CURSOR)?.toLongOrNull() ?: 0
        val ops = dao.outbox(maxOps).map { Json.parseToJsonElement(it.op) }
        val request = mutableMapOf<String, JsonElement>("cursor" to JsonPrimitive(cursor), "ops" to JsonArray(ops))
        if (dao.state(SyncWriter.FULL_PULL) == "1") request["full"] = JsonPrimitive(true)
        JsonObject(request).toString()
    }

    /**
     * Applies the server's reply in one transaction: acknowledged changes leave the outbox, other devices' changes
     * are merged in, and the cursor moves on. Returns true when another round is needed straight away.
     * If the app dies before this commits, nothing is lost: the next round resends the same ops, which the server
     * recognises, and pulls from the old cursor again.
     */
    @Throws(Exception::class)
    suspend fun acceptSyncReply(reply: String): Boolean = offMain {
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
        dao.synced(now) { sync ->
            applied.chunked(500).forEach { dao.deleteOutbox(it) }
            rejected.forEach { (id, problem) -> dao.markOutboxProblem(id, problem) }
            ops.filter { SyncRules.problem(it) == null }.forEach { sync.receive(it) }
            dao.setState(LocalStateRecord(SyncWriter.CURSOR, cursor.toString()))
            // The last page of the first full download has arrived: from now on, own ops are skipped again.
            if (!more) dao.setState(LocalStateRecord(SyncWriter.FULL_PULL, "0"))
            dao.setState(LocalStateRecord(SyncWriter.LAST_SYNCED, now.toString()))
            more || dao.outboxCount() > 0
        }
    }

    /** For Settings → Account & backup: "Synced 2 min ago", or how many changes are waiting. */
    @Throws(Exception::class)
    suspend fun syncStatus(): SyncStatus = SyncStatus(
        accountId = dao.state(SyncWriter.ACCOUNT),
        waiting = dao.outboxCount(),
        keptAside = dao.outboxProblemCount(),
        lastSyncedAt = dao.state(SyncWriter.LAST_SYNCED)?.toLongOrNull(),
    )

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
        const val SCHEMA_VERSION = 9

        @Throws(Exception::class)
        fun open(path: String): HabitRepository = HabitRepository(configure(databaseBuilder(path)), ::currentTimeMillis)

        /** A throwaway database, for UI tests. */
        fun openInMemory(): HabitRepository = HabitRepository(configure(inMemoryDatabaseBuilder()), ::currentTimeMillis)

        /** For tests: a database whose sync clock reads [clock] instead of the wall clock. */
        internal fun open(path: String, clock: () -> Long): HabitRepository = HabitRepository(configure(databaseBuilder(path)), clock)

        private fun configure(builder: RoomDatabase.Builder<HabitDatabase>): HabitDatabase =
            builder
                .setDriver(BundledSQLiteDriver())
                .setQueryCoroutineContext(databaseDispatcher)
                .addMigrations(Migrations.v1ToV2, Migrations.v2ToV3, Migrations.v3ToV4, Migrations.v4ToV5, Migrations.v5ToV6, Migrations.v6ToV7, Migrations.v7ToV8, Migrations.v8ToV9)
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
