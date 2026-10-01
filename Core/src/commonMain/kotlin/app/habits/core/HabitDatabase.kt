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

    @Upsert suspend fun upsertHabit(habit: HabitRecord)
    @Upsert suspend fun upsertSteps(steps: List<StepRecord>)
    @Upsert suspend fun upsertReminders(reminders: List<ReminderRecord>)
    @Upsert suspend fun upsertSetting(setting: SettingRecord)

    @Insert(onConflict = OnConflictStrategy.IGNORE) suspend fun insertHabitsIfNew(habits: List<HabitRecord>)
    @Insert(onConflict = OnConflictStrategy.IGNORE) suspend fun insertStepsIfNew(steps: List<StepRecord>)
    @Insert(onConflict = OnConflictStrategy.IGNORE) suspend fun insertRemindersIfNew(reminders: List<ReminderRecord>)
    @Insert(onConflict = OnConflictStrategy.IGNORE) suspend fun insertSettingsIfNew(settings: List<SettingRecord>)

    /** Existing habits keep their current configuration, including removed steps and reminders. */
    @Transaction
    suspend fun mergeAll(snapshot: Snapshot) {
        val known = allHabitIds().toSet() // Includes tombstones: a deleted habit must stay deleted.
        val added = snapshot.habits.filter { it.id !in known }
        val newIds = added.map { it.id }.toSet()
        val live = habits().map { it.id }.toSet() + added.filter { it.deletedAt == null }.map { it.id }
        insertHabitsIfNew(added)
        insertStepsIfNew(snapshot.steps.filter { it.habitId in newIds })
        insertRemindersIfNew(snapshot.reminders.filter { it.habitId in newIds })
        insertEntries(snapshot.entries.filter { it.habitId in live })
        val globalKeys = setOf("day_end_hour", "week_start", "day_sections", "show_streaks", "haptics", "sounds", "appearance")
        val habitPrefixes = listOf("rules.", "pause.", "skip.", "desc.", "archived.")
        insertSettingsIfNew(snapshot.settings.filter { setting ->
            when {
                setting.key in globalKeys -> known.isEmpty()
                setting.key.startsWith("daynote.") -> true
                setting.key.startsWith("note.") -> setting.key.removePrefix("note.").substringBefore('|') in live
                else -> habitPrefixes.any { prefix -> setting.key.startsWith(prefix) && setting.key.removePrefix(prefix) in newIds }
            }
        })
    }

    @Query("SELECT EXISTS(SELECT 1 FROM entry WHERE id = :id)")
    suspend fun hasEntry(id: String): Boolean

    /** Ignoring a duplicate ID makes a retried write harmless. */
    @Insert(onConflict = OnConflictStrategy.IGNORE)
    suspend fun insertEntries(entries: List<EntryRecord>)

    @Query("UPDATE entry SET value = :value, created_at = :createdAt WHERE id = :id AND deleted_at IS NULL")
    suspend fun editEntry(id: String, value: Double, createdAt: Long)

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

    /** Stopping a timer must never save elapsed time without removing its running marker. */
    @Transaction
    suspend fun finishTimer(entry: EntryRecord?, key: String) {
        if (entry != null) insertEntries(listOf(entry))
        deleteSetting(key)
    }

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
