package app.habits.core

import app.habits.sync.SyncRecord
import app.habits.sync.SyncRules
import java.io.File
import kotlin.random.Random
import kotlin.test.AfterTest
import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertTrue
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonArray
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive
import kotlinx.serialization.json.jsonArray
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.json.jsonPrimitive
import kotlinx.serialization.json.long

/**
 * Phones with real database files, syncing through [FakeServer], which follows the real server's protocol
 * (server/src/account.ts: op log, cursor, own ops skipped, 1,000 per page) and merges with the same rules.
 * The same scenarios run against the real server in [LiveSyncTest].
 */
class SyncTest {
    private val dir = File(System.getProperty("java.io.tmpdir"), "habits-sync-${System.nanoTime()}").apply { mkdirs() }

    @AfterTest fun cleanUp() { dir.deleteRecursively() }

    /** One device: its own database, its own clock (set by the test, so devices can disagree), and a link to a server. */
    inner class Phone(val name: String, private val server: FakeServer) {
        var wall = 1_000_000L
        val repo = HabitRepository.open(File(dir, "$name.db").path) { wall }
        private val deviceId = name

        /** One full sync, as the app runs it. `loseReplyOnce` simulates the app being killed before the reply lands. */
        fun sync(loseReplyOnce: Boolean = false) = runBlocking {
            var lose = loseReplyOnce
            var rounds = 0
            var more = true
            while (more) {
                val reply = server.handle(deviceId, repo.syncRequest())
                check(++rounds < 100) { "sync didn't finish" }
                if (lose) { lose = false; continue }
                more = repo.acceptSyncReply(reply)
            }
        }

        fun state(): Snapshot = runBlocking { repo.load() }.normalized()

        /** Counts over every row, tombstones included. */
        fun stats(): Map<String, Int> {
            val db = androidx.sqlite.driver.bundled.BundledSQLiteDriver().open(File(dir, "$name.db").path)
            fun count(sql: String) = db.prepare(sql).use { it.step(); it.getLong(0).toInt() }
            return mapOf(
                "entries" to count("SELECT count(*) FROM entry"),
                "undone" to count("SELECT count(*) FROM entry WHERE deleted_at IS NOT NULL"),
                "deletedHabits" to count("SELECT count(*) FROM habit WHERE deleted_at IS NOT NULL"),
                "names" to count("SELECT count(DISTINCT name) FROM habit"),
                "fieldClocks" to count("SELECT count(*) FROM sync_meta WHERE clocks IS NOT NULL"),
            ).also { db.close() }
        }
        fun close() = repo.close()
    }

    private fun Snapshot.normalized() = Snapshot(
        habits.sortedBy { it.id }, steps.sortedBy { it.id }, reminders.sortedBy { it.id }, entries.sortedBy { it.id }, settings.sortedBy { it.key },
    )

    private fun habit(id: String, name: String = "Water", position: Int = 0) = HabitRecord(
        id = id, name = name, symbol = "drop.fill", color = "blue", kind = "amount", unit = "glasses", increment = 1.0,
        part = "anytime", goal = 8.0, period = "day", scheduleDays = null, frequency = "daily", dueDay = null, dueMinute = null,
        atMost = false, quitSince = null, position = position, createdAt = 1_000, updatedAt = 1_000, archivedAt = null, deletedAt = null,
    )

    private fun entry(id: String, habitId: String, day: String = "2026-10-01") = EntryRecord(id, habitId, null, day, 1.0, 2_000, "Europe/London", null, null)

    private fun devices(vararg names: String): List<Phone> {
        val server = FakeServer()
        return names.map { Phone(it, server).also { p -> runBlocking { p.repo.bindAccount("acct") } } }
    }

    @Test fun everythingMadeOnThePhoneArrivesOnTheIpad() = runBlocking {
        val (phone, ipad) = devices("phone", "ipad")
        phone.repo.saveHabit(habit("h1"), listOf(StepRecord("s1", "h1", "Fill bottle", 0, null)), listOf(ReminderRecord("r1", "h1", 9, 30, null)), 1)
        phone.repo.addEntry(entry("e1", "h1"))
        phone.repo.saveSetting("week_start", "2")
        phone.repo.saveSetting("note.h1|2026-10-01", "Felt great ☀️")
        phone.sync()
        ipad.sync()
        assertEquals(phone.state(), ipad.state())
        assertEquals(1, ipad.state().entries.size)
        assertEquals(0, phone.repo.syncStatus().waiting)
        assertTrue(phone.repo.syncStatus().lastSyncedAt != null)
        listOf(phone, ipad).forEach { it.close() }
    }

    @Test fun editsOnTwoOfflineDevicesMergeFieldByField() = runBlocking {
        val (phone, ipad) = devices("phone", "ipad")
        phone.repo.saveHabit(habit("h1"), emptyList(), emptyList(), 1)
        phone.sync(); ipad.sync()
        phone.wall += 1000; ipad.wall += 1000
        phone.repo.saveHabit(habit("h1", name = "Drink water"), emptyList(), emptyList(), 2)
        ipad.repo.saveHabit(habit("h1").copy(color = "green"), emptyList(), emptyList(), 2)
        phone.sync(); ipad.sync(); phone.sync()
        val h = phone.state().habits.single()
        assertEquals("Drink water" to "green", h.name to h.color)
        assertEquals(phone.state(), ipad.state())
        listOf(phone, ipad).forEach { it.close() }
    }

    @Test fun ticksFromTwoDevicesBothCount() = runBlocking {
        val (phone, watch) = devices("phone", "watch")
        phone.repo.saveHabit(habit("h1"), emptyList(), emptyList(), 1)
        phone.sync(); watch.sync()
        phone.repo.addEntry(entry("e-phone", "h1"))
        watch.repo.addEntry(entry("e-watch", "h1"))
        phone.repo.addEntry(entry("e-phone", "h1")) // the same tap saved twice
        watch.sync(); phone.sync(); watch.sync()
        assertEquals(listOf("e-phone", "e-watch"), phone.state().entries.map { it.id })
        assertEquals(phone.state(), watch.state())
        listOf(phone, watch).forEach { it.close() }
    }

    @Test fun anUndoAndADeletedHabitStayThatWayEverywhere() = runBlocking {
        val (phone, ipad) = devices("phone", "ipad")
        phone.repo.saveHabit(habit("h1"), listOf(StepRecord("s1", "h1", "A", 0, null)), emptyList(), 1)
        phone.repo.addEntry(entry("e1", "h1"))
        phone.sync(); ipad.sync()
        phone.wall += 1000
        phone.repo.removeEntry("e1", phone.wall)
        phone.repo.saveHabit(habit("h1").copy(deletedAt = phone.wall), emptyList(), emptyList(), phone.wall)
        phone.sync()
        // The iPad, offline for 400 days with its clock ahead, renames the habit and re-adds the undone tick.
        ipad.wall += 400L * 86_400_000
        ipad.repo.saveHabit(habit("h1", name = "Renamed"), listOf(StepRecord("s1", "h1", "A", 0, null)), emptyList(), ipad.wall)
        ipad.repo.addEntry(entry("e1", "h1"))
        ipad.sync(); phone.sync()
        for (d in listOf(phone, ipad)) {
            val s = d.state()
            assertTrue(s.habits.isEmpty(), "${d.name}: the deleted habit came back")
            assertTrue(s.entries.isEmpty(), "${d.name}: the undone tick came back")
            assertTrue(s.steps.isEmpty(), "${d.name}: the deleted step came back")
        }
        listOf(phone, ipad).forEach { it.close() }
    }

    @Test fun aRemovedSettingSyncsAndCanBeSetAgain() = runBlocking {
        val (phone, ipad) = devices("phone", "ipad")
        phone.repo.saveSetting("timer.h1", "1000")
        phone.sync(); ipad.sync()
        assertEquals("1000", ipad.state().settings.single().value)
        phone.wall += 10; phone.repo.removeSetting("timer.h1"); phone.sync(); ipad.sync()
        assertTrue(ipad.state().settings.isEmpty())
        phone.wall += 10; phone.repo.saveSetting("timer.h1", "2000"); phone.sync(); ipad.sync()
        assertEquals("2000", ipad.state().settings.single().value)
        listOf(phone, ipad).forEach { it.close() }
    }

    @Test fun killedBeforeTheReplyNothingIsLostOrDoubled() = runBlocking {
        val (phone, ipad) = devices("phone", "ipad")
        phone.repo.saveHabit(habit("h1"), emptyList(), emptyList(), 1)
        repeat(3) { phone.repo.addEntry(entry("e$it", "h1")) }
        phone.sync(loseReplyOnce = true) // the server applied it; the phone never heard back, then synced again
        assertEquals(0, phone.repo.syncStatus().waiting)
        ipad.sync(loseReplyOnce = true)
        assertEquals(phone.state(), ipad.state())
        assertEquals(3, ipad.state().entries.size)
        listOf(phone, ipad).forEach { it.close() }
    }

    @Test fun aLongOfflineSpellGoesUpInChunks() = runBlocking {
        val (phone, ipad) = devices("phone", "ipad")
        phone.repo.saveHabit(habit("h1"), emptyList(), emptyList(), 1)
        repeat(1_300) { phone.repo.addEntry(entry("e$it", "h1", day = "2026-${(it % 9) + 1}-01")) }
        assertEquals(1_301, phone.repo.syncStatus().waiting)
        phone.sync(); ipad.sync()
        assertEquals(1_300, ipad.state().entries.size)
        listOf(phone, ipad).forEach { it.close() }
    }

    @Test fun fieldsFromANewerAppSurviveAnOlderOnesEdits() = runBlocking {
        val server = FakeServer()
        val phone = Phone("phone", server).also { it.repo.bindAccount("acct") }
        phone.repo.saveHabit(habit("h1"), emptyList(), emptyList(), 1)
        phone.sync()
        // A newer app adds a field this version doesn't have, and a table it doesn't have.
        server.inject("newer", """{"id":"n1","table":"habit","row":"h1","fields":{"mood_tag":"calm"},"hlc":"000000000009000000-00000-newer","schema":9}""")
        server.inject("newer", """{"id":"n2","table":"journal","row":"j1","fields":{"text":"hi"},"hlc":"000000000009000001-00000-newer","schema":9}""")
        phone.sync()
        phone.wall = 10_000_000
        phone.repo.saveHabit(habit("h1", name = "Renamed"), emptyList(), emptyList(), 2)
        phone.sync()
        val record = server.record("habit", "h1")
        assertEquals("calm", record.fields.getValue("mood_tag").jsonPrimitive.content)
        assertEquals("Renamed", record.fields.getValue("name").jsonPrimitive.content)
        // Signing in to a new account later uploads the unknown field and table too.
        val fresh = FakeServer()
        val moved = Phone("phone2", fresh)
        phone.close()
        File(dir, "phone.db").copyTo(File(dir, "phone2.db"))
        listOf("-wal", "-shm").forEach { s -> File(dir, "phone.db$s").takeIf { it.exists() }?.copyTo(File(dir, "phone2.db$s")) }
        val reopened = Phone("phone2", fresh)
        reopened.repo.bindAccount("another-account")
        reopened.sync()
        assertEquals("calm", fresh.record("habit", "h1").fields.getValue("mood_tag").jsonPrimitive.content)
        assertEquals("hi", fresh.record("journal", "j1").fields.getValue("text").jsonPrimitive.content)
        moved.close(); reopened.close()
    }

    @Test fun signingInToADifferentAccountUploadsEverythingAgain() = runBlocking {
        val server = FakeServer()
        val phone = Phone("phone", server)
        phone.repo.saveHabit(habit("h1"), emptyList(), emptyList(), 1)
        phone.repo.addEntry(entry("e1", "h1"))
        assertEquals(0, phone.repo.syncStatus().waiting, "a free user's phone queues nothing")
        phone.repo.bindAccount("acct-a")
        assertEquals(2, phone.repo.syncStatus().waiting)
        phone.sync()
        phone.repo.bindAccount("acct-a") // the same account again: nothing to redo
        assertEquals(0, phone.repo.syncStatus().waiting)
        phone.repo.bindAccount("acct-b")
        assertEquals(2, phone.repo.syncStatus().waiting)
        phone.close()
    }

    /** Three devices make random changes while offline and sync at random; all end up identical. */
    @Test fun randomChangesOnThreeDevicesConverge() = runBlocking {
        val random = Random(99)
        val all = devices("phone", "ipad", "watch")
        val habitIds = listOf("h1", "h2", "h3")
        repeat(25) { round ->
            for (d in all) {
                d.wall += random.nextLong(1, 2_000) // clocks drift apart
                repeat(random.nextInt(0, 5)) { i ->
                    val id = habitIds.random(random)
                    val live = d.state().habits.firstOrNull { it.id == id }
                    when (random.nextInt(7)) {
                        0, 1 -> d.repo.saveHabit((live ?: habit(id)).copy(name = "${d.name}-$round-$i"), emptyList(), emptyList(), d.wall)
                        2 -> d.repo.saveHabit((live ?: habit(id)).copy(position = random.nextInt(10)), emptyList(), emptyList(), d.wall)
                        3 -> d.repo.addEntry(entry("${d.name}-$round-$i", id))
                        4 -> d.state().entries.randomOrNull(random)?.let { d.repo.removeEntry(it.id, d.wall) }
                        5 -> if (random.nextInt(4) == 0 && live != null) d.repo.saveHabit(live.copy(deletedAt = d.wall), emptyList(), emptyList(), d.wall)
                        else -> d.repo.saveSetting("week_start", random.nextInt(1, 8).toString())
                    }
                }
                if (random.nextInt(3) > 0) d.sync(loseReplyOnce = random.nextInt(5) == 0)
            }
        }
        repeat(2) { all.forEach { it.sync() } }
        val expected = all.first().state()
        all.forEach { assertEquals(expected, it.state(), "${it.name} differs") }
        // The run must have exercised real conflicts, not converged on nothing.
        val raw = runBlocking { all.first().repo.pragma("integrity_check") }
        assertEquals("ok", raw)
        val stats = all.first().stats()
        println("random sync: $stats")
        assertTrue(stats.getValue("entries") > 20 && stats.getValue("undone") > 0 && stats.getValue("names") > 1, stats.toString())
        all.forEach { it.close() }
    }
}

/** The server's sync protocol, in memory (mirrors server/src/account.ts `sync`). */
class FakeServer {
    private val log = mutableListOf<Triple<Long, String, JsonObject>>()
    private val records = mutableMapOf<Pair<String, String>, SyncRecord>()

    fun record(table: String, row: String): SyncRecord = records.getValue(table to row)

    fun inject(deviceId: String, op: String) {
        handle(deviceId, """{"cursor":${log.size},"ops":[$op]}""")
    }

    fun handle(deviceId: String, request: String): String {
        val body = Json.parseToJsonElement(request).jsonObject
        val ops = body.getValue("ops").jsonArray
        require(ops.size <= 500)
        val applied = mutableListOf<JsonPrimitive>()
        for (element in ops) {
            val op = SyncRules.opFrom(element.jsonObject)!!
            check(SyncRules.problem(op) == null) { SyncRules.problem(op)!! }
            applied += JsonPrimitive(op.id)
            if (log.any { it.third.getValue("id").jsonPrimitive.content == op.id }) continue
            records[op.table to op.row] = SyncRules.merge(records[op.table to op.row], op)
            log += Triple(log.size + 1L, deviceId, element.jsonObject)
        }
        val cursor = body.getValue("cursor").jsonPrimitive.long
        val page = log.filter { it.first > cursor }.take(1000)
        return JsonObject(
            mapOf(
                "applied" to JsonArray(applied),
                "rejected" to JsonArray(emptyList()),
                "ops" to JsonArray(page.filter { it.second != deviceId }.map { it.third }),
                "cursor" to JsonPrimitive(page.lastOrNull()?.first ?: cursor),
                "more" to JsonPrimitive(page.size == 1000),
            ),
        ).toString()
    }
}
