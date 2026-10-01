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

    /** Schema 4: a habit's times place it on Today; "Remind Me", the alert style and "Remind Again" are per habit.
     *  Existing habits keep reminding as before (remind = 1, notification, no repeat). */
    val v3ToV4 = object : Migration(3, 4) {
        override suspend fun migrate(connection: SQLiteConnection) {
            connection.execSQL("ALTER TABLE habit ADD COLUMN remind INTEGER NOT NULL DEFAULT 1")
            connection.execSQL("ALTER TABLE habit ADD COLUMN alert TEXT NOT NULL DEFAULT 'notification'")
            connection.execSQL("ALTER TABLE habit ADD COLUMN follow_up_minutes INTEGER")
        }
    }

    /** Schema 5: a start date (past or future) and an optional end date per habit. */
    val v4ToV5 = object : Migration(4, 5) {
        override suspend fun migrate(connection: SQLiteConnection) {
            connection.execSQL("ALTER TABLE habit ADD COLUMN starts_on TEXT")
            connection.execSQL("ALTER TABLE habit ADD COLUMN ends_on TEXT")
        }
    }

    /** Schema 6: sync bookkeeping (outbox, per-row stamps, device state). Existing rows get their stamps on first open. */
    val v5ToV6 = object : Migration(5, 6) {
        override suspend fun migrate(connection: SQLiteConnection) {
            connection.execSQL("CREATE TABLE IF NOT EXISTS `outbox` (`seq` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `op_id` TEXT NOT NULL, `op` TEXT NOT NULL, `problem` TEXT)")
            connection.execSQL("CREATE UNIQUE INDEX IF NOT EXISTS `index_outbox_op_id` ON `outbox` (`op_id`)")
            connection.execSQL("CREATE TABLE IF NOT EXISTS `sync_meta` (`table_name` TEXT NOT NULL, `row_id` TEXT NOT NULL, `hlc` TEXT NOT NULL, `clocks` TEXT, `extra` TEXT, `pending` INTEGER NOT NULL, PRIMARY KEY(`table_name`, `row_id`))")
            connection.execSQL("CREATE TABLE IF NOT EXISTS `local_state` (`key` TEXT NOT NULL, `value` TEXT NOT NULL, PRIMARY KEY(`key`))")
        }
    }
}
