package app.habits.core

import androidx.room3.migration.Migration
import androidx.sqlite.SQLiteConnection
import androidx.sqlite.execSQL

/**
 * Every schema change is a migration that only adds, never drops or renames (Architecture 08 §3).
 * Each one has a test that upgrades a real database from the previous version's exported schema.
 */
internal object Migrations {
    /** Schema 2: one frequency rule per habit, checklists and one-time tasks. */
    val v1ToV2 = object : Migration(1, 2) {
        override suspend fun migrate(connection: SQLiteConnection) {
            connection.execSQL("ALTER TABLE habit ADD COLUMN frequency TEXT NOT NULL DEFAULT 'daily'")
            connection.execSQL("ALTER TABLE habit ADD COLUMN due_day TEXT")
            connection.execSQL("ALTER TABLE habit ADD COLUMN due_minute INTEGER")
            // Old weekday schedules and weekly goals become frequency rules.
            connection.execSQL("UPDATE habit SET frequency = 'weekdays:' || schedule_days WHERE schedule_days IS NOT NULL")
            connection.execSQL("UPDATE habit SET frequency = 'week:' || CAST(goal AS INTEGER) WHERE period = 'week'")
            // A yes/no habit with steps is now a checklist.
            connection.execSQL(
                "UPDATE habit SET kind = 'checklist' WHERE kind = 'check' AND EXISTS " +
                    "(SELECT 1 FROM step WHERE step.habit_id = habit.id AND step.deleted_at IS NULL)"
            )
        }
    }

    /** Schema 3: a habit can sit in several day sections (`part` holds their IDs, comma-separated),
     *  and each tick records which section it was for. Old ticks have no section. */
    val v2ToV3 = object : Migration(2, 3) {
        override suspend fun migrate(connection: SQLiteConnection) {
            connection.execSQL("ALTER TABLE entry ADD COLUMN slot TEXT")
        }
    }
}
