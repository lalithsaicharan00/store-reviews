package app.habits.core

import androidx.room3.migration.Migration
import androidx.sqlite.SQLiteConnection
import androidx.sqlite.execSQL
import app.habits.sync.SyncRules

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

    /** Schema 6: keep the origin of a log; never guess the origin of old entries. */
    val v5ToV6 = object : Migration(5, 6) {
        override suspend fun migrate(connection: SQLiteConnection) {
            connection.execSQL("ALTER TABLE entry ADD COLUMN source TEXT")
        }
    }

    /**
     * Schema 7: sync bookkeeping (outbox, per-row stamps, device state). Existing rows get their stamps on first open.
     * Test builds of `claude/server-and-sync` (before the 1 Oct merge) called the sync tables "6" and had no
     * `entry.source`: such a database gets the column here, so it opens instead of failing Room's schema check.
     */
    val v6ToV7 = object : Migration(6, 7) {
        override suspend fun migrate(connection: SQLiteConnection) {
            if (!connection.hasColumn("entry", "source")) connection.execSQL("ALTER TABLE entry ADD COLUMN source TEXT")
            connection.execSQL("CREATE TABLE IF NOT EXISTS `outbox` (`seq` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `op_id` TEXT NOT NULL, `op` TEXT NOT NULL, `problem` TEXT)")
            connection.execSQL("CREATE UNIQUE INDEX IF NOT EXISTS `index_outbox_op_id` ON `outbox` (`op_id`)")
            connection.execSQL("CREATE TABLE IF NOT EXISTS `sync_meta` (`table_name` TEXT NOT NULL, `row_id` TEXT NOT NULL, `hlc` TEXT NOT NULL, `clocks` TEXT, `extra` TEXT, `pending` INTEGER NOT NULL, PRIMARY KEY(`table_name`, `row_id`))")
            connection.execSQL("CREATE TABLE IF NOT EXISTS `local_state` (`key` TEXT NOT NULL, `value` TEXT NOT NULL, PRIMARY KEY(`key`))")
        }
    }

    /** Schema 8: "Reminder says…" per habit. Added only if missing, so a database that already has it still opens. */
    val v7ToV8 = object : Migration(7, 8) {
        override suspend fun migrate(connection: SQLiteConnection) {
            if (!connection.hasColumn("habit", "reminder_text")) connection.execSQL("ALTER TABLE habit ADD COLUMN reminder_text TEXT")
        }
    }

    /**
     * Schema 9: iCloud (Architecture 11 §6–7). Each row keeps its CloudKit record's system fields, and each waiting op
     * names its row and stamp, so a confirmed save removes exactly what it contained. Only adds; each column only if it's
     * missing. Ops already waiting get their row and stamp from their own JSON; one that can't be read is kept aside,
     * never deleted.
     */
    val v8ToV9 = object : Migration(8, 9) {
        override suspend fun migrate(connection: SQLiteConnection) {
            if (!connection.hasColumn("sync_meta", "ck_system")) connection.execSQL("ALTER TABLE sync_meta ADD COLUMN ck_system TEXT")
            if (!connection.hasColumn("outbox", "table_name")) connection.execSQL("ALTER TABLE outbox ADD COLUMN table_name TEXT")
            if (!connection.hasColumn("outbox", "row_id")) connection.execSQL("ALTER TABLE outbox ADD COLUMN row_id TEXT")
            if (!connection.hasColumn("outbox", "hlc")) connection.execSQL("ALTER TABLE outbox ADD COLUMN hlc TEXT")
            if (!connection.hasColumn("outbox", "deletes")) connection.execSQL("ALTER TABLE outbox ADD COLUMN deletes INTEGER NOT NULL DEFAULT 0")
            connection.execSQL("CREATE INDEX IF NOT EXISTS `index_outbox_table_name_row_id` ON `outbox` (`table_name`, `row_id`)")
            val waiting = mutableListOf<Pair<Long, String>>()
            connection.prepare("SELECT seq, op FROM outbox WHERE table_name IS NULL").use { statement ->
                while (statement.step()) waiting += statement.getLong(0) to statement.getText(1)
            }
            for ((seq, text) in waiting) {
                val op = SyncRules.decodeOp(text)
                if (op == null) {
                    connection.prepare("UPDATE outbox SET problem = 'unreadable' WHERE seq = ?").use { it.bindLong(1, seq); it.step() }
                    continue
                }
                connection.prepare("UPDATE outbox SET table_name = ?, row_id = ?, hlc = ?, deletes = ? WHERE seq = ?").use {
                    it.bindText(1, op.table); it.bindText(2, op.row); it.bindText(3, op.hlc)
                    it.bindLong(4, if (SyncWriter.deletes(op)) 1L else 0L); it.bindLong(5, seq)
                    it.step()
                }
            }
        }
    }

    private fun SQLiteConnection.hasColumn(table: String, column: String): Boolean =
        prepare("PRAGMA table_info(`$table`)").use { statement ->
            while (statement.step()) if (statement.getText(1) == column) return@use true
            false
        }
}
