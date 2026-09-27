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

    @Upsert suspend fun upsertHabit(habit: HabitRecord)
    @Upsert suspend fun upsertSteps(steps: List<StepRecord>)
    @Upsert suspend fun upsertReminders(reminders: List<ReminderRecord>)
    @Upsert suspend fun upsertSetting(setting: SettingRecord)

    /** Ignoring a duplicate ID makes a retried write harmless. */
    @Insert(onConflict = OnConflictStrategy.IGNORE)
    suspend fun insertEntries(entries: List<EntryRecord>)

    @Query("UPDATE entry SET deleted_at = :at WHERE id = :id AND deleted_at IS NULL")
    suspend fun tombstoneEntry(id: String, at: Long)

    @Query("UPDATE step SET deleted_at = :at WHERE habit_id = :habitId AND deleted_at IS NULL AND id NOT IN (:keep)")
    suspend fun tombstoneStepsExcept(habitId: String, keep: List<String>, at: Long)

    @Query("UPDATE reminder SET deleted_at = :at WHERE habit_id = :habitId AND deleted_at IS NULL AND id NOT IN (:keep)")
    suspend fun tombstoneRemindersExcept(habitId: String, keep: List<String>, at: Long)

    @Query("DELETE FROM setting WHERE `key` = :key")
    suspend fun deleteSetting(key: String)

    @Transaction
    suspend fun snapshot(): Snapshot = Snapshot(habits(), steps(), reminders(), entries(), settings())

    /** A habit with its steps and reminders, saved all-or-nothing. */
    @Transaction
    suspend fun saveHabit(habit: HabitRecord, steps: List<StepRecord>, reminders: List<ReminderRecord>, at: Long) {
        upsertHabit(habit)
        tombstoneStepsExcept(habit.id, steps.map { it.id }, at)
        upsertSteps(steps)
        tombstoneRemindersExcept(habit.id, reminders.map { it.id }, at)
        upsertReminders(reminders)
    }

    @Transaction
    suspend fun importAll(snapshot: Snapshot) {
        snapshot.habits.forEach { upsertHabit(it) }
        upsertSteps(snapshot.steps)
        upsertReminders(snapshot.reminders)
        insertEntries(snapshot.entries)
        snapshot.settings.forEach { upsertSetting(it) }
    }
}

@Database(
    entities = [HabitRecord::class, StepRecord::class, ReminderRecord::class, EntryRecord::class, SettingRecord::class],
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
