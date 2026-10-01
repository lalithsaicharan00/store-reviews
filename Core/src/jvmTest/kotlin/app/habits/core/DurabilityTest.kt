package app.habits.core

import androidx.sqlite.driver.bundled.BundledSQLiteDriver
import androidx.sqlite.execSQL
import java.io.File
import java.util.concurrent.TimeUnit
import kotlin.random.Random
import kotlin.test.AfterTest
import kotlin.test.Test
import kotlin.test.assertContentEquals
import kotlin.test.assertEquals
import kotlin.test.assertFailsWith
import kotlin.test.assertTrue
import kotlin.time.measureTime
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.async
import kotlinx.coroutines.awaitAll
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.withContext

/**
 * The phone is the only copy of a free user's data, so these tests try hard to lose some:
 * killed processes, damaged files, a database from a newer app, many writers at once, years of data.
 */
class DurabilityTest {
    private val dir = File(System.getProperty("java.io.tmpdir"), "habits-durability-${System.nanoTime()}").apply { mkdirs() }
    private val path = File(dir, "habits.db").path

    @AfterTest fun cleanUp() { dir.deleteRecursively() }

    companion object {
        fun habit(id: String = "h1", name: String = "Water") = HabitRecord(
            id = id, name = name, symbol = "drop.fill", color = "blue", kind = "amount", unit = "glasses",
            increment = 1.0, part = "anytime", goal = 8.0, period = "day", scheduleDays = null, frequency = "daily",
            dueDay = null, dueMinute = null, atMost = false,
            quitSince = null, position = 0, createdAt = 1_000, updatedAt = 1_000, archivedAt = null, deletedAt = null,
        )

        fun entry(id: String, habitId: String = "h1", day: String = "2026-09-27", at: Long = 2_000) =
            EntryRecord(id, habitId, null, day, 1.0, at, "Europe/London", null, null)
    }

    // MARK: Killed mid-write

    /** SIGKILL at random moments, five times on the same file. Nothing acknowledged is lost, nothing is half-saved. */
    @Test fun killingTheAppMidWriteLosesNothingThatWasSaved() = runBlocking {
        val acks = File(dir, "acks.txt")
        val random = Random(42)
        repeat(5) { round ->
            val java = File(System.getProperty("java.home"), "bin/java").path
            val process = ProcessBuilder(java, "-cp", System.getProperty("java.class.path"), CrashWriter::class.java.name, path, acks.path)
                .redirectErrorStream(true).redirectOutput(File(dir, "writer-$round.log")).start()
            val started = System.currentTimeMillis()
            while (!acks.exists() && System.currentTimeMillis() - started < 30_000) Thread.sleep(10)
            Thread.sleep(300L + random.nextLong(900))
            process.destroyForcibly() // SIGKILL: no shutdown hooks, no clean close
            assertTrue(process.waitFor(10, TimeUnit.SECONDS))

            val acknowledged = acks.readLines().filter { it.isNotBlank() }.map { it.toInt() }
            assertTrue(acknowledged.isNotEmpty(), "round $round: the writer saved nothing; see writer-$round.log")
            val repo = HabitRepository.open(path)
            assertEquals("ok", repo.pragma("integrity_check"), "round $round")
            val snapshot = repo.load()
            val saved = snapshot.entries.map { it.id }.toSet()
            val missing = acknowledged.filter { "e$it" !in saved }
            assertTrue(missing.isEmpty(), "round $round: acknowledged writes lost: ${missing.take(10)}")
            // The habit and its steps were written in one transaction, so they must agree.
            val version = snapshot.habits.single().name.removePrefix("v").toInt()
            assertTrue(version >= acknowledged.max(), "round $round: the last acknowledged habit save is missing")
            assertEquals((0..version % 5).map { "$version-$it" }, snapshot.steps.map { it.id }, "round $round: half-saved habit")
            repo.close()
        }
    }

    // MARK: Damaged or unexpected files

    /** A damaged file must fail loudly and stay on disk for recovery; it must never be replaced by an empty database. */
    @Test fun aDamagedFileIsReportedAndNeverReplaced() = runBlocking {
        val garbage = Random(7).nextBytes(64 * 1024)
        File(path).writeBytes(garbage)
        val repo = HabitRepository.open(path)
        assertFailsWith<Throwable> { repo.load() }
        assertFailsWith<Throwable> { repo.saveHabit(habit(), emptyList(), emptyList(), 1) }
        runCatching { repo.close() }
        assertContentEquals(garbage, File(path).readBytes(), "the damaged file was changed")
    }

    /** A file cut short (an interrupted copy or restore) must not be mistaken for an empty database. */
    @Test fun aTruncatedFileIsReportedAndKept() = runBlocking {
        val repo = HabitRepository.open(path)
        repo.saveHabit(habit(), emptyList(), emptyList(), 1)
        repeat(2_000) { repo.addEntry(entry("e$it")) }
        repo.close()
        val full = File(path).readBytes()
        val cut = full.copyOf(full.size / 2)
        File(path).writeBytes(cut)
        listOf("-wal", "-shm").forEach { File(path + it).delete() }

        val reopened = HabitRepository.open(path)
        val result = runCatching { reopened.load() }
        runCatching { reopened.close() }
        // Either it can't be read (and says so), or it reads only rows that were really there. Never "empty and fine".
        result.onSuccess { snapshot -> assertTrue(snapshot.habits.isNotEmpty(), "a truncated file read as an empty database") }
        assertTrue(File(path).length() >= cut.size, "the truncated file was replaced")
    }

    /** A database from a newer app (a restored backup, a rolled-back update) is refused, not wiped. */
    @Test fun aDatabaseFromANewerAppIsRefusedAndKept() = runBlocking {
        val repo = HabitRepository.open(path)
        repo.saveHabit(habit(), emptyList(), emptyList(), 1)
        repo.addEntry(entry("e1"))
        repo.close()
        BundledSQLiteDriver().open(path).apply { execSQL("PRAGMA user_version = ${HabitRepository.SCHEMA_VERSION + 1}"); close() }

        val newer = HabitRepository.open(path)
        assertFailsWith<Throwable> { newer.load() }
        runCatching { newer.close() }
        val raw = BundledSQLiteDriver().open(path)
        val rows = raw.prepare("SELECT count(*) FROM entry").use { it.step(); it.getLong(0) }
        raw.close()
        assertEquals(1, rows, "the newer database's data was wiped")
    }

    // MARK: Many writers, lots of data, odd text

    @Test fun manyWritesAtOnceAreAllSaved() = runBlocking {
        val repo = HabitRepository.open(path)
        repo.saveHabit(habit(), emptyList(), emptyList(), 1)
        withContext(Dispatchers.Default) {
            (0 until 500).map { i ->
                async {
                    repo.addEntry(entry("e$i", at = i.toLong()))
                    if (i % 10 == 0) repo.saveSetting("k$i", "v$i")
                    if (i % 25 == 0) repo.saveHabit(habit(id = "h$i", name = "H$i"), emptyList(), emptyList(), i.toLong())
                }
            }.awaitAll()
        }
        repo.close()
        val snapshot = HabitRepository.open(path).run { load().also { close() } }
        assertEquals(500, snapshot.entries.size)
        assertEquals(50, snapshot.settings.size)
        assertEquals(21, snapshot.habits.size)
    }

    /** Reads during writes see whole transactions: a habit never appears without its steps. */
    @Test fun readsDuringWritesNeverSeeHalfASave() = runBlocking {
        val repo = HabitRepository.open(path)
        val writer = launch(Dispatchers.Default) {
            for (n in 1..300) {
                repo.saveHabit(habit(name = "v$n"), (0..n % 5).map { StepRecord("$n-$it", "h1", "S", it, null) }, emptyList(), n.toLong())
            }
        }
        while (writer.isActive) {
            val snapshot = repo.load()
            val habit = snapshot.habits.singleOrNull() ?: continue
            val n = habit.name.removePrefix("v").toInt()
            assertEquals((0..n % 5).map { "$n-$it" }, snapshot.steps.map { it.id })
        }
        repo.close()
    }

    /** Ten years of a heavy user: 50 habits, ticked every day. Everything survives and loads quickly. */
    @Test fun tenYearsOfDataLoadsCompletelyAndQuickly() = runBlocking {
        val repo = HabitRepository.open(path)
        val habits = (0 until 50).map { habit(id = "h$it", name = "Habit $it") }
        val entries = (0 until 3_650).flatMap { day ->
            val date = java.time.LocalDate.of(2016, 1, 1).plusDays(day.toLong()).toString()
            habits.map { entry("${it.id}-$day", it.id, date, day.toLong()) }
        }
        repo.importAll(Snapshot(habits, emptyList(), emptyList(), entries, emptyList()))
        repo.close()

        val reopened = HabitRepository.open(path)
        val snapshot: Snapshot
        val took = measureTime { snapshot = reopened.load() }
        reopened.close()
        println("Loaded ${snapshot.entries.size} entries in $took (JVM; a phone is slower)")
        assertEquals(entries.size, snapshot.entries.size)
        assertEquals(50, snapshot.habits.size)
        assertTrue(took.inWholeSeconds < 10, "loading ten years took $took")
    }

    /** Names come back exactly as typed: emoji, accents, right-to-left text, quotes, SQL-looking text, the 100-character limit. */
    @Test fun anyTextRoundTripsExactly() = runBlocking {
        val names = listOf(
            "Drink water 💧🏃‍♀️👩🏽‍💻", "Méditer à l'aube", "قراءة القرآن", "日本語を勉強する", "Robert'); DROP TABLE habit;--",
            "\"quoted\" and \\backslash\\", "tab\tand\nnewline", "x".repeat(100), " leading and trailing ",
        )
        val repo = HabitRepository.open(path)
        names.forEachIndexed { i, name ->
            repo.saveHabit(habit(id = "h$i", name = name).copy(position = i), listOf(StepRecord("s$i", "h$i", name, 0, null)), emptyList(), 1)
            repo.saveSetting("note.$i", name)
        }
        repo.close()
        val snapshot = HabitRepository.open(path).run { load().also { close() } }
        assertEquals(names, snapshot.habits.map { it.name })
        assertEquals(names, snapshot.steps.sortedBy { it.habitId.drop(1).toInt() }.map { it.name })
        assertEquals(names, snapshot.settings.sortedBy { it.key.drop(5).toInt() }.map { it.value })
    }

    // MARK: Safety copies and import

    /** The daily copy is taken while the app keeps writing, and the copy is a complete, healthy database. */
    @Test fun aSnapshotTakenDuringWritesIsHealthy() = runBlocking {
        val repo = HabitRepository.open(path)
        repo.saveHabit(habit(), emptyList(), emptyList(), 1)
        repeat(1_000) { repo.addEntry(entry("before$it")) }
        val writer = launch(Dispatchers.Default) { repeat(1_000) { repo.addEntry(entry("during$it")) } }
        val copy = File(dir, "copy.db").path
        repo.snapshot(copy)
        writer.join()
        repo.close()

        val restored = HabitRepository.open(copy)
        assertEquals("ok", restored.pragma("integrity_check"))
        val ids = restored.load().entries.map { it.id }.toSet()
        restored.close()
        assertTrue((0 until 1_000).all { "before$it" in ids }, "the copy is missing data written before it was taken")
    }

    /** Taking a copy onto an existing file fails rather than overwriting an older copy. */
    @Test fun aSnapshotNeverOverwritesAnExistingCopy() = runBlocking {
        val copy = File(dir, "copy.db").apply { writeText("an older copy") }
        val repo = HabitRepository.open(path)
        repo.saveHabit(habit(), emptyList(), emptyList(), 1)
        assertFailsWith<Throwable> { repo.snapshot(copy.path) }
        repo.close()
        assertEquals("an older copy", copy.readText())
    }

    /** Importing (a backup, a file from another phone) never overwrites what's already here, as its documentation promises. */
    @Test fun importNeverOverwritesExistingRows() = runBlocking {
        val repo = HabitRepository.open(path)
        repo.saveHabit(habit(name = "Mine"), listOf(StepRecord("s1", "h1", "My step", 0, null)), listOf(ReminderRecord("r1", "h1", 9, 0, null)), 1)
        repo.saveSetting("day_end_hour", "3")
        repo.addEntry(entry("e1"))
        repo.removeEntry("e1", 5)

        repo.importAll(
            Snapshot(
                habits = listOf(habit(name = "Theirs")),
                steps = listOf(StepRecord("s1", "h1", "Their step", 0, null)),
                reminders = listOf(ReminderRecord("r1", "h1", 18, 30, null)),
                entries = listOf(entry("e1")),
                settings = listOf(SettingRecord("day_end_hour", "0")),
            )
        )
        val snapshot = repo.load()
        repo.close()
        assertEquals("Mine", snapshot.habits.single().name)
        assertEquals("My step", snapshot.steps.single().name)
        assertEquals(9, snapshot.reminders.single().hour)
        assertEquals("3", snapshot.settings.single().value)
        assertTrue(snapshot.entries.isEmpty(), "an import brought an undone tick back")
    }
}
