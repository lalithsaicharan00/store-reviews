package app.habits.core

import androidx.sqlite.driver.bundled.BundledSQLiteDriver
import androidx.sqlite.execSQL
import java.io.File
import kotlin.test.AfterTest
import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertTrue
import kotlinx.coroutines.test.runTest

/** Builds a real schema-1 database from the exported schema, then opens it with the current code. */
class MigrationTest {
    private val dir = File(System.getProperty("java.io.tmpdir"), "habits-migration-${System.nanoTime()}").apply { mkdirs() }
    private val path = File(dir, "habits.db").path

    @AfterTest fun cleanUp() { dir.deleteRecursively() }

    /** Creates an empty database exactly as schema `version` defined it. */
    private fun createSchema(version: Int): androidx.sqlite.SQLiteConnection {
        val json = File("schemas/app.habits.core.HabitDatabase/$version.json").readText()
        val statements = Regex("\"createSql\": \"(.*?)\"").findAll(json).map { it.groupValues[1] }.toList()
        val tables = Regex("\"tableName\": \"(.*?)\"").findAll(json).map { it.groupValues[1] }.toList()
        val setup = Regex("\"setupQueries\": \\[(.*?)]", RegexOption.DOT_MATCHES_ALL).find(json)!!.groupValues[1]
            .let { Regex("\"((?:[^\"\\\\]|\\\\.)*)\"").findAll(it).map { m -> m.groupValues[1] }.toList() }
        val connection = BundledSQLiteDriver().open(path)
        var table = 0
        for (sql in statements) {
            // Entity CREATE TABLE statements are followed by their index statements.
            if (sql.startsWith("CREATE TABLE")) {
                connection.execSQL(sql.replace("\${TABLE_NAME}", tables[table++]))
            } else {
                connection.execSQL(sql.replace("\${TABLE_NAME}", tables[table - 1]))
            }
        }
        setup.forEach { connection.execSQL(it.replace("\\\"", "\"")) }
        connection.execSQL("PRAGMA user_version = $version")
        return connection
    }

    private fun createVersion1() {
        val connection = createSchema(1)
        fun habit(id: String, kind: String, period: String, days: String?, goal: Double) = connection.execSQL(
            "INSERT INTO habit VALUES ('$id', '$id', 'star.fill', 'blue', '$kind', NULL, 1.0, 'anytime', $goal, '$period', " +
                (days?.let { "'$it'" } ?: "NULL") + ", 0, NULL, 0, 1000, 1000, NULL, NULL)"
        )
        habit("daily", "check", "day", null, 1.0)
        habit("weekly", "check", "week", null, 3.0)
        habit("weekdays", "check", "day", "2,4,6", 1.0)
        habit("steps", "check", "day", null, 1.0)
        connection.execSQL("INSERT INTO step VALUES ('s1', 'steps', 'Floss', 0, NULL)")
        connection.execSQL("INSERT INTO entry VALUES ('e1', 'daily', NULL, '2026-09-27', 1.0, 2000, 'Europe/London', NULL)")
        connection.close()
    }

    @Test fun version1UpgradesWithoutLosingAnything() = runTest {
        createVersion1()
        val repo = HabitRepository.open(path)
        val snapshot = repo.load()
        val byId = snapshot.habits.associateBy { it.id }
        assertEquals("daily", byId.getValue("daily").frequency)
        assertEquals("week:3", byId.getValue("weekly").frequency)
        assertEquals("weekdays:2,4,6", byId.getValue("weekdays").frequency)
        assertEquals("checklist", byId.getValue("steps").kind)
        assertEquals("check", byId.getValue("daily").kind)
        assertEquals(listOf("e1"), snapshot.entries.map { it.id })
        assertEquals(listOf("Floss"), snapshot.steps.map { it.name })
        assertEquals(HabitRepository.SCHEMA_VERSION.toString(), repo.pragma("user_version"))
        repo.close()
    }

    @Test fun version2UpgradesAndOldTicksHaveNoSection() = runTest {
        val connection = createSchema(2)
        connection.execSQL("INSERT INTO entry VALUES ('e1', 'h1', NULL, '2026-09-27', 1.0, 2000, 'Europe/London', NULL)")
        connection.execSQL("INSERT INTO setting VALUES ('week_start', '2')")
        connection.close()
        val repo = HabitRepository.open(path)
        val snapshot = repo.load()
        assertEquals(listOf("e1"), snapshot.entries.map { it.id })
        assertEquals(null, snapshot.entries.single().slot)
        assertEquals(HabitRepository.SCHEMA_VERSION.toString(), repo.pragma("user_version"))
        repo.close()
    }

    @Test fun version3UpgradesAndHabitsKeepReminding() = runTest {
        val connection = createSchema(3)
        connection.execSQL(
            "INSERT INTO habit VALUES ('h1', 'Floss', 'mouth', 'cyan', 'check', NULL, 1.0, 'morning,evening', 1.0, 'day', " +
                "NULL, 'daily', NULL, NULL, 0, NULL, 0, 1000, 1000, NULL, NULL)"
        )
        connection.execSQL("INSERT INTO reminder VALUES ('r1', 'h1', 21, 0, NULL)")
        connection.execSQL("INSERT INTO entry VALUES ('e1', 'h1', NULL, '2026-09-27', 1.0, 2000, 'Europe/London', NULL, 'morning')")
        connection.close()
        val repo = HabitRepository.open(path)
        val snapshot = repo.load()
        val habit = snapshot.habits.single()
        assertEquals("morning,evening", habit.part)
        assertEquals(true, habit.remind)
        assertEquals("notification", habit.alert)
        assertEquals(null, habit.followUpMinutes)
        assertEquals(listOf(21), snapshot.reminders.map { it.hour })
        assertEquals(listOf("morning"), snapshot.entries.map { it.slot })
        assertEquals(HabitRepository.SCHEMA_VERSION.toString(), repo.pragma("user_version"))
        repo.close()
    }

    @Test fun version4UpgradesWithNoStartOrEndDate() = runTest {
        val connection = createSchema(4)
        connection.execSQL(
            "INSERT INTO habit VALUES ('h1', 'Read', 'book', 'orange', 'duration', NULL, 1.0, 'anytime', 20.0, 'day', " +
                "NULL, 'daily', NULL, NULL, 0, NULL, 0, 1000, 1000, NULL, NULL, 1, 'notification', NULL)"
        )
        connection.close()
        val repo = HabitRepository.open(path)
        val habit = repo.load().habits.single()
        assertEquals(null, habit.startsOn)
        assertEquals(null, habit.endsOn)
        assertEquals(true, habit.remind)
        assertEquals(HabitRepository.SCHEMA_VERSION.toString(), repo.pragma("user_version"))
        repo.close()
    }

    /**
     * Schema 7 adds sync, on top of the schema 6 that shipped to phones (`entry.source`). Existing data is kept, gets
     * its first stamps, and is all queued once the person signs in, the entry's source included.
     */
    @Test fun version6UpgradesAndEverythingSyncsOnFirstSignIn() = runTest {
        val connection = createSchema(6)
        connection.execSQL(
            "INSERT INTO habit VALUES ('h1', 'Read', 'book', 'orange', 'duration', NULL, 1.0, 'anytime', 20.0, 'day', " +
                "NULL, 'daily', NULL, NULL, 0, NULL, 0, 1000, 1000, NULL, NULL, 1, 'notification', NULL, '2026-09-01', NULL)"
        )
        connection.execSQL("INSERT INTO entry VALUES ('e1', 'h1', NULL, '2026-09-27', 20.0, 2000, 'Europe/London', NULL, NULL, 'reminder')")
        connection.execSQL("INSERT INTO setting VALUES ('week_start', '2')")
        connection.execSQL("INSERT INTO setting VALUES ('placement_v2', '1')")
        connection.close()

        val repo = HabitRepository.open(path)
        val snapshot = repo.load()
        assertEquals("2026-09-01", snapshot.habits.single().startsOn)
        assertEquals(listOf("e1"), snapshot.entries.map { it.id })
        assertEquals("reminder", snapshot.entries.single().source)
        assertEquals(HabitRepository.SCHEMA_VERSION.toString(), repo.pragma("user_version"))
        assertEquals(0, repo.syncStatus().waiting, "nothing is queued before there's an account")
        repo.bindAccount("account-1")
        // The habit, the tick and the synced setting; the local-only placement marker stays on this phone.
        assertEquals(3, repo.syncStatus().waiting)
        assertTrue(repo.syncRequest().contains("\"source\":\"reminder\""), "the entry's source syncs")
        repo.close()
    }
    /**
     * A database from a test build of `claude/server-and-sync` before the 1 Oct merge: its "6" was the sync tables,
     * with no `entry.source`. It opens, keeps everything, and what was waiting to sync still waits.
     */
    @Test fun serverSyncTestBuildVersion6StillOpens() = runTest {
        val connection = createSchema(5)
        connection.execSQL("CREATE TABLE IF NOT EXISTS `outbox` (`seq` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `op_id` TEXT NOT NULL, `op` TEXT NOT NULL, `problem` TEXT)")
        connection.execSQL("CREATE UNIQUE INDEX IF NOT EXISTS `index_outbox_op_id` ON `outbox` (`op_id`)")
        connection.execSQL("CREATE TABLE IF NOT EXISTS `sync_meta` (`table_name` TEXT NOT NULL, `row_id` TEXT NOT NULL, `hlc` TEXT NOT NULL, `clocks` TEXT, `extra` TEXT, `pending` INTEGER NOT NULL, PRIMARY KEY(`table_name`, `row_id`))")
        connection.execSQL("CREATE TABLE IF NOT EXISTS `local_state` (`key` TEXT NOT NULL, `value` TEXT NOT NULL, PRIMARY KEY(`key`))")
        connection.execSQL("INSERT INTO entry VALUES ('e1', 'h1', NULL, '2026-09-27', 2.5, 2000, 'Europe/London', NULL, 'morning')")
        connection.execSQL("INSERT INTO outbox (op_id, op, problem) VALUES ('op-1', '{}', NULL)")
        connection.execSQL("PRAGMA user_version = 6")
        connection.close()
        val repo = HabitRepository.open(path)
        val entry = repo.load().entries.single()
        assertEquals("e1", entry.id)
        assertEquals("morning", entry.slot)
        assertEquals(null, entry.source)
        assertEquals(HabitRepository.SCHEMA_VERSION.toString(), repo.pragma("user_version"))
        repo.close()
        val after = BundledSQLiteDriver().open(path)
        val waiting = after.prepare("SELECT count(*) FROM outbox").use { it.step(); it.getLong(0) }
        after.close()
        assertEquals(1L, waiting, "the change waiting to sync is still there")
    }

    @Test fun version5KeepsOldEntriesWithoutInventingASource() = runTest {
        val connection = createSchema(5)
        connection.execSQL("INSERT INTO entry VALUES ('e1', 'h1', NULL, '2026-09-27', 2.5, 2000, 'Europe/London', NULL, 'morning')")
        connection.close()
        val repo = HabitRepository.open(path)
        val entry = repo.load().entries.single()
        assertEquals("e1", entry.id)
        assertEquals(2.5, entry.value)
        assertEquals("morning", entry.slot)
        assertEquals(null, entry.source)
        assertEquals(HabitRepository.SCHEMA_VERSION.toString(), repo.pragma("user_version"))
        repo.close()
    }

}
