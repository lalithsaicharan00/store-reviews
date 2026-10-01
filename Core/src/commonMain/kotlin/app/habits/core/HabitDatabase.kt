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

    @Query("SELECT * FROM habit") suspend fun backupHabits(): List<HabitRecord>
    @Query("SELECT * FROM step") suspend fun backupSteps(): List<StepRecord>
    @Query("SELECT * FROM reminder") suspend fun backupReminders(): List<ReminderRecord>
    @Query("SELECT * FROM entry") suspend fun backupEntries(): List<EntryRecord>

    @Transaction
    suspend fun restoreSnapshot(): Snapshot = Snapshot(backupHabits(), backupSteps(), backupReminders(), backupEntries(), settings())

    @Query("SELECT row_id FROM sync_meta WHERE table_name = 'setting'") suspend fun knownSettingKeys(): List<String>

    /** Everything a restore compares against, read in one transaction. */
    @Transaction
    suspend fun restoreState(): Pair<Snapshot, Set<String>> = restoreSnapshot() to knownSettingKeys().toSet()

    @Upsert suspend fun upsertHabit(habit: HabitRecord)
    @Upsert suspend fun upsertSteps(steps: List<StepRecord>)
    @Upsert suspend fun upsertReminders(reminders: List<ReminderRecord>)
    @Upsert suspend fun upsertSetting(setting: SettingRecord)


    // Import only adds: a local-only setting that's already here is never replaced.
    @Insert(onConflict = OnConflictStrategy.IGNORE) suspend fun insertSettingsIfNew(settings: List<SettingRecord>)

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
    @Upsert suspend fun setState(state: LocalStateRecord)

    @Insert suspend fun insertOutbox(op: OutboxRecord)
    @Query("SELECT * FROM outbox WHERE problem IS NULL ORDER BY seq LIMIT :limit") suspend fun outbox(limit: Int): List<OutboxRecord>
    @Query("SELECT count(*) FROM outbox WHERE problem IS NULL") suspend fun outboxCount(): Int
    @Query("SELECT count(*) FROM outbox WHERE problem IS NOT NULL") suspend fun outboxProblemCount(): Int
    @Query("DELETE FROM outbox WHERE op_id IN (:ids)") suspend fun deleteOutbox(ids: List<String>)
    @Query("UPDATE outbox SET problem = :problem WHERE op_id = :id") suspend fun markOutboxProblem(id: String, problem: String)
    @Query("DELETE FROM outbox") suspend fun clearOutbox()

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
