package app.habits.core

import androidx.sqlite.driver.bundled.BundledSQLiteDriver
import androidx.sqlite.execSQL
import java.io.File
import kotlin.test.AfterTest
import kotlin.test.Test
import kotlin.test.assertEquals
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
        assertEquals("3", repo.pragma("user_version"))
        repo.close()
    }
}
