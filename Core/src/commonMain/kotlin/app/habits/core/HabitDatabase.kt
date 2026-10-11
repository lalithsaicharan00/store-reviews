package app.habits.core

import androidx.room3.ColumnInfo
import androidx.room3.ConstructedBy
import androidx.room3.Dao
import androidx.room3.Database
import androidx.room3.Embedded
import androidx.room3.Insert
import androidx.room3.OnConflictStrategy
import androidx.room3.Query
import androidx.room3.RoomDatabase
import androidx.room3.RoomDatabaseConstructor
import androidx.room3.Transaction
import androidx.room3.Upsert

@Dao
interface HabitDao {
    @Query("SELECT * FROM habit WHERE deleted_at IS NULL ORDER BY position, created_at")
    suspend fun habits(): List<HabitRecord>

    @Query("SELECT * FROM step WHERE deleted_at IS NULL ORDER BY position")
    suspend fun steps(): List<StepRecord>

    @Query("SELECT * FROM reminder WHERE deleted_at IS NULL ORDER BY hour, minute")
    suspend fun reminders(): List<ReminderRecord>

    @Query("SELECT * FROM entry WHERE deleted_at IS NULL ORDER BY created_at")
    suspend fun entries(): List<EntryRecord>

    /** The Apple Watch's history in memory: logs from [day] on, and every log of a quit habit or a task (their runs
     *  and repeats read the whole past, and they are few). Older logs stay in the database. */
    @Query(
        "SELECT * FROM entry WHERE deleted_at IS NULL AND (day >= :day OR habit_id IN " +
            "(SELECT id FROM habit WHERE kind IN ('quit', 'task'))) ORDER BY created_at"
    )
    suspend fun entriesSince(day: String): List<EntryRecord>

    /** The day of each habit's oldest log, so the Watch knows which habits have history before its window. */
    @Query("SELECT habit_id, MIN(day) AS day FROM entry WHERE deleted_at IS NULL GROUP BY habit_id")
    suspend fun oldestDays(): List<HabitOldestDay>

    @Query("SELECT * FROM setting")
    suspend fun settings(): List<SettingRecord>

    @Query("SELECT id FROM habit")
    suspend fun allHabitIds(): List<String>

    @Query("SELECT * FROM habit") suspend fun backupHabits(): List<HabitRecord>
    @Query("SELECT * FROM step") suspend fun backupSteps(): List<StepRecord>
    @Query("SELECT * FROM reminder") suspend fun backupReminders(): List<ReminderRecord>
    @Query("SELECT * FROM entry") suspend fun backupEntries(): List<EntryRecord>

    @Transaction
    suspend fun restoreSnapshot(): Snapshot = Snapshot(backupHabits(), backupSteps(), backupReminders(), backupEntries(), settings())

    @Query("SELECT row_id FROM sync_meta WHERE table_name = 'setting'") suspend fun knownSettingKeys(): List<String>

    @Query("DELETE FROM habit") suspend fun eraseHabits()
    @Query("DELETE FROM step") suspend fun eraseSteps()
    @Query("DELETE FROM reminder") suspend fun eraseReminders()
    @Query("DELETE FROM entry") suspend fun eraseEntries()
    @Query("DELETE FROM setting") suspend fun eraseSettings()
    @Query("DELETE FROM outbox") suspend fun eraseOutbox()
    @Query("DELETE FROM sync_meta") suspend fun eraseSyncMeta()
    @Query("DELETE FROM local_state") suspend fun eraseLocalState()
    @Query("DELETE FROM peer_out") suspend fun erasePeerOut()

    /** Every row of every table, in one transaction: the database is as on first launch. */
    @Transaction
    suspend fun eraseAll() {
        eraseHabits(); eraseSteps(); eraseReminders(); eraseEntries(); eraseSettings()
        eraseOutbox(); eraseSyncMeta(); eraseLocalState(); erasePeerOut()
    }

    /** Everything a restore compares against, read in one transaction. */
    @Transaction
    suspend fun restoreState(): Pair<Snapshot, Set<String>> = restoreSnapshot() to knownSettingKeys().toSet()

    @Upsert suspend fun upsertHabit(habit: HabitRecord)
    @Upsert suspend fun upsertSteps(steps: List<StepRecord>)
    @Upsert suspend fun upsertReminders(reminders: List<ReminderRecord>)
    @Upsert suspend fun upsertSetting(setting: SettingRecord)


    // Import only adds: a local-only setting that's already here is never replaced.
    @Insert(onConflict = OnConflictStrategy.IGNORE) suspend fun insertSettingsIfNew(settings: List<SettingRecord>)

    /** Includes tombstones (an undone tick still "exists"), so replaying an undone action can't bring it back. */
    @Query("SELECT EXISTS(SELECT 1 FROM entry WHERE id = :id)")
    suspend fun hasEntry(id: String): Boolean

    @Query("DELETE FROM setting WHERE `key` = :key")
    suspend fun deleteSetting(key: String)

    // Single rows, tombstones included: sync works on every row.
    @Query("SELECT * FROM habit WHERE id = :id") suspend fun habitById(id: String): HabitRecord?
    @Query("SELECT * FROM step WHERE id = :id") suspend fun stepById(id: String): StepRecord?
    @Query("SELECT * FROM reminder WHERE id = :id") suspend fun reminderById(id: String): ReminderRecord?
    @Query("SELECT * FROM entry WHERE id = :id") suspend fun entryById(id: String): EntryRecord?
    @Query("SELECT * FROM setting WHERE `key` = :key") suspend fun settingByKey(key: String): SettingRecord?
    @Query("SELECT * FROM step WHERE habit_id = :habitId AND deleted_at IS NULL") suspend fun liveSteps(habitId: String): List<StepRecord>
    @Query("SELECT * FROM reminder WHERE habit_id = :habitId AND deleted_at IS NULL") suspend fun liveReminders(habitId: String): List<ReminderRecord>
    @Upsert suspend fun upsertEntry(entry: EntryRecord)

    // Rows that have no sync stamps yet (written before schema 6).
    @Query("SELECT * FROM habit WHERE id NOT IN (SELECT row_id FROM sync_meta WHERE table_name = 'habit')") suspend fun unstampedHabits(): List<HabitRecord>
    @Query("SELECT * FROM step WHERE id NOT IN (SELECT row_id FROM sync_meta WHERE table_name = 'step')") suspend fun unstampedSteps(): List<StepRecord>
    @Query("SELECT * FROM reminder WHERE id NOT IN (SELECT row_id FROM sync_meta WHERE table_name = 'reminder')") suspend fun unstampedReminders(): List<ReminderRecord>
    @Query("SELECT * FROM entry WHERE id NOT IN (SELECT row_id FROM sync_meta WHERE table_name = 'entry')") suspend fun unstampedEntries(): List<EntryRecord>
    @Query("SELECT * FROM setting WHERE `key` NOT IN (SELECT row_id FROM sync_meta WHERE table_name = 'setting')") suspend fun unstampedSettings(): List<SettingRecord>

    @Query("SELECT * FROM sync_meta WHERE table_name = :table AND row_id = :row") suspend fun syncMeta(table: String, row: String): SyncMetaRecord?
    @Query("SELECT * FROM sync_meta") suspend fun allSyncMeta(): List<SyncMetaRecord>
    @Upsert suspend fun upsertSyncMeta(meta: SyncMetaRecord)

    @Query("SELECT value FROM local_state WHERE `key` = :key") suspend fun state(key: String): String?
    @Query("SELECT * FROM local_state WHERE `key` IN (:keys)") suspend fun states(keys: List<String>): List<LocalStateRecord>
    @Upsert suspend fun setState(state: LocalStateRecord)

    @Insert suspend fun insertOutbox(op: OutboxRecord)
    @Query("SELECT * FROM outbox WHERE problem IS NULL ORDER BY seq LIMIT :limit") suspend fun outbox(limit: Int): List<OutboxRecord>
    @Query("SELECT count(*) FROM outbox WHERE problem IS NULL") suspend fun outboxCount(): Int
    @Query("SELECT count(*) FROM outbox WHERE problem IS NOT NULL") suspend fun outboxProblemCount(): Int
    @Query("DELETE FROM outbox WHERE op_id IN (:ids)") suspend fun deleteOutbox(ids: List<String>)
    @Query("UPDATE outbox SET problem = :problem WHERE op_id = :id") suspend fun markOutboxProblem(id: String, problem: String)
    @Query("DELETE FROM outbox") suspend fun clearOutbox()
    /** A change passed on from the paired device may already be waiting (it came both ways): kept once. */
    @Insert(onConflict = OnConflictStrategy.IGNORE) suspend fun insertOutboxIfNew(op: OutboxRecord)

    // The paired device's queue (schema 9, Architecture 12 §3.1).
    @Insert suspend fun insertPeerOut(op: PeerOutRecord)
    @Insert(onConflict = OnConflictStrategy.IGNORE) suspend fun insertPeerOutIfNew(op: PeerOutRecord)
    @Query("SELECT * FROM peer_out ORDER BY seq LIMIT :limit") suspend fun peerOut(limit: Int): List<PeerOutRecord>
    @Query("SELECT * FROM peer_out WHERE seq > :after ORDER BY seq LIMIT :limit") suspend fun peerOutAfter(after: Long, limit: Int): List<PeerOutRecord>
    @Query("SELECT count(*) FROM peer_out") suspend fun peerOutCount(): Int
    @Query("DELETE FROM peer_out WHERE seq <= :seq") suspend fun deletePeerOutThrough(seq: Long)

    // The first fill, read a page at a time by key, so rows added meanwhile never shift a page and skip a row.
    @Query("SELECT * FROM sync_meta WHERE (table_name != 'entry' OR pending = 1) AND (table_name > :table OR (table_name = :table AND row_id > :row)) ORDER BY table_name, row_id LIMIT :limit")
    suspend fun fillMeta(table: String, row: String, limit: Int): List<SyncMetaRecord>
    @Query("SELECT id, day FROM entry WHERE day < :day OR (day = :day AND id < :id) ORDER BY day DESC, id DESC LIMIT :limit")
    suspend fun fillEntries(day: String, id: String, limit: Int): List<EntryKey>

    // iCloud (Architecture 11 §6–8): the CloudKit system fields kept with each row, and the outbox by row.
    @Query("UPDATE sync_meta SET ck_system = :system WHERE table_name = :table AND row_id = :row")
    suspend fun setCloudSystem(table: String, row: String, system: String?)
    @Query("UPDATE sync_meta SET ck_system = NULL WHERE ck_system IS NOT NULL") suspend fun clearCloudSystem()
    /** The oldest waiting ops' rows, in order (a row with several ops is named several times; the caller keeps each
     *  once). By `seq` alone, so it reads only the head of the outbox however long it is (an extreme first upload). */
    @Query("SELECT table_name || ':' || row_id FROM outbox WHERE problem IS NULL AND table_name IS NOT NULL ORDER BY seq LIMIT :limit")
    suspend fun oldestWaiting(limit: Int): List<String>
    @Query("SELECT count(*) FROM (SELECT 1 FROM outbox WHERE problem IS NULL AND table_name IS NOT NULL GROUP BY table_name, row_id)")
    suspend fun waitingRowCount(): Int
    @Query("SELECT count(*) FROM (SELECT 1 FROM outbox WHERE problem IS NULL AND deletes = :kind GROUP BY table_name, row_id)")
    suspend fun waitingDeleteCount(kind: Int): Int
    /** Removes the ops a confirmed save contained: the row's ops queued before its record was built (`seq` ≤ `upTo`). */
    @Query("DELETE FROM outbox WHERE table_name = :table AND row_id = :row AND seq <= :upTo AND problem IS NULL")
    suspend fun deleteConfirmed(table: String, row: String, upTo: Long)
    @Query("SELECT coalesce(max(seq), 0) FROM outbox") suspend fun lastOutboxSeq(): Long
    @Query("SELECT EXISTS(SELECT 1 FROM outbox WHERE table_name = :table AND row_id = :row AND deletes = 1 AND problem IS NULL)")
    suspend fun hasWaitingDelete(table: String, row: String): Boolean
    @Query("UPDATE outbox SET problem = :problem WHERE table_name = :table AND row_id = :row AND problem IS NULL")
    suspend fun markRowProblem(table: String, row: String, problem: String)
    @Query("SELECT table_name || ':' || row_id || ' ' || problem FROM outbox WHERE problem IS NOT NULL GROUP BY table_name, row_id LIMIT 50")
    suspend fun keptAsideRows(): List<String>
    @Query("SELECT (SELECT count(*) FROM habit WHERE deleted_at IS NULL) + (SELECT count(*) FROM entry WHERE deleted_at IS NULL) + (SELECT count(*) FROM step WHERE deleted_at IS NULL) + (SELECT count(*) FROM reminder WHERE deleted_at IS NULL)")
    suspend fun liveRecordCount(): Int
    @Query("SELECT count(*) FROM habit WHERE deleted_at IS NULL AND kind != 'task'") suspend fun liveHabitCount(): Int
    @Query("SELECT * FROM local_state WHERE `key` LIKE :prefix || '%' ORDER BY `key`") suspend fun statesWithPrefix(prefix: String): List<LocalStateRecord>
    @Query("DELETE FROM local_state WHERE `key` = :key") suspend fun removeState(key: String)
    @Query("DELETE FROM local_state WHERE `key` LIKE :prefix || '%'") suspend fun removeStatesWithPrefix(prefix: String)

    // Google Drive (DriveSync): one file per year of logs, and one for everything else ("base"). A log belongs to the
    // year of its day; anything else, or a log this device can't build yet, to base. The same rule as DriveStore.chainOf.

    /** The files this device's waiting changes belong to: years ("2026"), and "" for base. */
    @Query(
        "SELECT DISTINCT CASE WHEN o.table_name = 'entry' AND e.day GLOB '[0-9][0-9][0-9][0-9]-*' THEN substr(e.day, 1, 4) ELSE '' END " +
            "FROM outbox o LEFT JOIN entry e ON o.table_name = 'entry' AND e.id = o.row_id WHERE o.problem IS NULL AND o.table_name IS NOT NULL"
    )
    suspend fun waitingDriveChains(): List<String>

    /** Every log of one year with its sync stamps, read in one query (an extreme year is 25,000 logs). */
    @Query(
        "SELECT e.*, m.hlc AS sync_hlc, m.clocks AS sync_clocks, m.extra AS sync_extra, m.pending AS sync_pending FROM entry e " +
            "JOIN sync_meta m ON m.table_name = 'entry' AND m.row_id = e.id WHERE e.day >= :from AND e.day < :to AND e.day GLOB '[0-9][0-9][0-9][0-9]-*'"
    )
    suspend fun driveYear(from: String, to: String): List<EntryWithSync>

    /** Everything that isn't a log of some year. */
    @Query("SELECT * FROM sync_meta WHERE table_name != 'entry' OR row_id NOT IN (SELECT id FROM entry WHERE day GLOB '[0-9][0-9][0-9][0-9]-*')")
    suspend fun driveBaseMeta(): List<SyncMetaRecord>

    /** A saved year file confirmed: its logs' changes queued before it was built (`seq` ≤ `upTo`) leave the outbox. */
    @Query(
        "DELETE FROM outbox WHERE seq <= :upTo AND problem IS NULL AND table_name = 'entry' AND row_id IN " +
            "(SELECT id FROM entry WHERE day >= :from AND day < :to AND day GLOB '[0-9][0-9][0-9][0-9]-*')"
    )
    suspend fun confirmDriveYear(upTo: Long, from: String, to: String)

    /** A saved base file confirmed. */
    @Query(
        "DELETE FROM outbox WHERE seq <= :upTo AND problem IS NULL AND table_name IS NOT NULL AND " +
            "(table_name != 'entry' OR row_id NOT IN (SELECT id FROM entry WHERE day GLOB '[0-9][0-9][0-9][0-9]-*'))"
    )
    suspend fun confirmDriveBase(upTo: Long)

    /** For tests only: a row's sync stamps vanish (the never-shrink guard's test). */
    @Query("DELETE FROM sync_meta WHERE table_name = :table AND row_id = :row") suspend fun eraseSyncMetaRow(table: String, row: String)

    /** For tests: the waiting ops after [seq], oldest first. */
    @Query("SELECT * FROM outbox WHERE seq > :seq ORDER BY seq") suspend fun outboxAfter(seq: Long): List<OutboxRecord>

    /** Runs [block] in one transaction with a [SyncWriter]: every change and its op commit together, or not at all. */
    @Transaction
    suspend fun <T> synced(now: Long, block: suspend (SyncWriter) -> T): T {
        val writer = SyncWriter(this, now)
        writer.begin()
        val result = block(writer)
        writer.end()
        return result
    }

    @Transaction
    suspend fun snapshot(): Snapshot = Snapshot(habits(), steps(), reminders(), entries(), settings())

    @Transaction
    suspend fun snapshotSince(day: String): Snapshot = Snapshot(habits(), steps(), reminders(), entriesSince(day), settings())

}

/** A habit's oldest log day (`HabitDao.oldestDays`). */
data class HabitOldestDay(@ColumnInfo(name = "habit_id") val habitId: String, val day: String)

/** A log with its sync stamps (`HabitDao.driveYear`). */
data class EntryWithSync(
    @Embedded val entry: EntryRecord,
    @ColumnInfo(name = "sync_hlc") val hlc: String,
    @ColumnInfo(name = "sync_clocks") val clocks: String?,
    @ColumnInfo(name = "sync_extra") val extra: String?,
    @ColumnInfo(name = "sync_pending") val pending: Boolean,
)

/** An entry's place in the first fill's newest-first order. */
data class EntryKey(val id: String, val day: String)

@Database(
    entities = [
        HabitRecord::class, StepRecord::class, ReminderRecord::class, EntryRecord::class, SettingRecord::class,
        OutboxRecord::class, SyncMetaRecord::class, LocalStateRecord::class, PeerOutRecord::class,
    ],
    version = HabitRepository.SCHEMA_VERSION,
    exportSchema = true,
)
@ConstructedBy(HabitDatabaseConstructor::class)
abstract class HabitDatabase : RoomDatabase() {
    abstract fun dao(): HabitDao
}

@Suppress("KotlinNoActualForExpect")
expect object HabitDatabaseConstructor : RoomDatabaseConstructor<HabitDatabase> {
    override fun initialize(): HabitDatabase
}
