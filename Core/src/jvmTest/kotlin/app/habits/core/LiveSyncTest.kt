package app.habits.core

import java.io.File
import java.net.URI
import java.net.http.HttpClient
import java.net.http.HttpRequest
import java.net.http.HttpResponse
import java.util.UUID
import kotlin.test.AfterTest
import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertTrue
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.json.jsonPrimitive

/**
 * Phones with real database files, syncing through the real server (api-dev by default) over HTTPS, signed in with
 * the dev-only test sign-in. Runs only when TEST_LOGIN_SECRET is set; otherwise it's skipped (it needs the network).
 *
 *     TEST_LOGIN_SECRET=... ./gradlew jvmTest --tests '*LiveSyncTest*'
 */
class LiveSyncTest {
    private val secret: String? = System.getenv("TEST_LOGIN_SECRET")
    private val base = System.getenv("API_BASE") ?: "https://api-dev.oftenenough.com"
    private val http = HttpClient.newHttpClient()
    private val dir = File(System.getProperty("java.io.tmpdir"), "habits-live-${System.nanoTime()}").apply { mkdirs() }
    private val opened = mutableListOf<LivePhone>()

    @AfterTest fun cleanUp() {
        opened.firstOrNull()?.let { runCatching { it.post("/v1/account/delete", "{}") } }
        opened.forEach { runCatching { it.repo.close() } }
        dir.deleteRecursively()
    }

    private fun post(path: String, body: String, token: String? = null): Pair<Int, JsonObject> {
        val request = HttpRequest.newBuilder(URI("$base$path"))
            .header("content-type", "application/json")
            .apply { if (token != null) header("authorization", "Bearer $token") }
            .POST(HttpRequest.BodyPublishers.ofString(body)).build()
        val response = http.send(request, HttpResponse.BodyHandlers.ofString())
        return response.statusCode() to Json.parseToJsonElement(response.body()).jsonObject
    }

    inner class LivePhone(val name: String, subject: String, create: Boolean) {
        val repo = HabitRepository.open(File(dir, "$name.db").path)
        private val token: String
        val accountId: String

        init {
            val (status, json) = post(
                "/v1/auth/test",
                """{"secret":"$secret","subject":"$subject","create":$create,"device":{"id":"${UUID.randomUUID()}","platform":"ios","name":"$name","appVersion":"test"}}""",
            )
            check(status in 200..201) { "sign-in failed: $status $json" }
            token = json.getValue("accessToken").jsonPrimitive.content
            accountId = json.getValue("accountId").jsonPrimitive.content
            runBlocking { repo.bindAccount(accountId) }
            opened += this
        }

        fun post(path: String, body: String) = post(path, body, token)

        fun sync(loseReplyOnce: Boolean = false) = runBlocking {
            var lose = loseReplyOnce
            var more = true
            var rounds = 0
            while (more) {
                val (status, reply) = post("/v1/sync", repo.syncRequest())
                check(status == 200) { "sync failed: $status $reply" }
                check(++rounds < 50)
                if (lose) { lose = false; continue }
                more = repo.acceptSyncReply(reply.toString())
            }
        }

        fun state() = runBlocking { repo.load() }.let { s ->
            Snapshot(s.habits.sortedBy { it.id }, s.steps.sortedBy { it.id }, s.reminders.sortedBy { it.id }, s.entries.sortedBy { it.id }, s.settings.sortedBy { it.key })
        }
    }

    private fun habit(id: String, name: String) = HabitRecord(
        id = id, name = name, symbol = "drop.fill", color = "blue", kind = "amount", unit = "glasses", increment = 1.0,
        part = "anytime", goal = 8.0, period = "day", scheduleDays = null, frequency = "daily", dueDay = null, dueMinute = null,
        atMost = false, quitSince = null, position = 0, createdAt = 1_000, updatedAt = 1_000, archivedAt = null, deletedAt = null,
    )

    @Test fun twoPhonesStayIdenticalThroughTheRealServer() = runBlocking {
        if (secret == null) return@runBlocking println("LiveSyncTest skipped: set TEST_LOGIN_SECRET to run it")
        val subject = "live-sync-${UUID.randomUUID()}"
        val phone = LivePhone("phone", subject, create = true)
        val ipad = LivePhone("ipad", subject, create = false)
        assertEquals(phone.accountId, ipad.accountId)

        // The phone sets up two habits with history, offline; then syncs, losing the first reply.
        val water = UUID.randomUUID().toString()
        val read = UUID.randomUUID().toString()
        phone.repo.saveHabit(habit(water, "Water 💧"), listOf(StepRecord(UUID.randomUUID().toString(), water, "Fill bottle", 0, null)), listOf(ReminderRecord(UUID.randomUUID().toString(), water, 9, 0, null)), 1)
        phone.repo.saveHabit(habit(read, "Read"), emptyList(), emptyList(), 1)
        repeat(600) { phone.repo.addEntry(EntryRecord(UUID.randomUUID().toString(), water, null, "2026-${(it % 9) + 1}-${(it % 28) + 1}", 1.0, it.toLong(), "Asia/Kolkata", null, null)) }
        phone.repo.saveSetting("week_start", "2")
        phone.sync(loseReplyOnce = true)
        ipad.sync()
        assertEquals(phone.state(), ipad.state())
        assertEquals(600, ipad.state().entries.size)

        // Both edit while offline: the phone renames Read, the iPad recolours it and undoes one tick; then the phone deletes Water.
        phone.repo.saveHabit(habit(read, "Read 20 pages"), emptyList(), emptyList(), 2)
        ipad.repo.saveHabit(habit(read, "Read").copy(color = "orange"), emptyList(), emptyList(), 2)
        val undone = ipad.state().entries.first()
        ipad.repo.removeEntry(undone.id, 3)
        phone.repo.saveHabit(phone.state().habits.first { it.id == water }.copy(deletedAt = 4), emptyList(), emptyList(), 4)
        ipad.sync(); phone.sync(); ipad.sync()

        val final = phone.state()
        assertEquals(final, ipad.state())
        assertEquals(listOf("Read 20 pages" to "orange"), final.habits.map { it.name to it.color })
        assertTrue(final.entries.none { it.id == undone.id })
        assertEquals(0, phone.repo.syncStatus().waiting + ipad.repo.syncStatus().waiting)
    }
}
