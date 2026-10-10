package app.habits.core

import androidx.room3.ConstructedBy
import androidx.room3.Dao
import androidx.room3.Database
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

    /** Every row of every table, in one transaction: the database is as on first launch. */
    @Transaction
    suspend fun eraseAll() {
        eraseHabits(); eraseSteps(); eraseReminders(); eraseEntries(); eraseSettings()
        eraseOutbox(); eraseSyncMeta(); eraseLocalState()
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

}

@Database(
    entities = [
        HabitRecord::class, StepRecord::class, ReminderRecord::class, EntryRecord::class, SettingRecord::class,
        OutboxRecord::class, SyncMetaRecord::class, LocalStateRecord::class,
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
