package app.habits.core

import app.habits.sync.SyncRecord
import app.habits.sync.SyncRules
import java.io.File
import kotlin.random.Random
import kotlin.test.AfterTest
import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertFalse
import kotlin.test.assertTrue
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.json.jsonPrimitive

/**
 * The database's side of iCloud sync (Architecture 11 §6–9), against [FakeZone]: CloudKit's private zone as the engine
 * sees it, with change tags, "save if unchanged" conflicts and a change feed. The phones run what `CloudSync` runs on the
 * iPhone (waiting rows → batch → save → confirmed; fetch → merge), with failures injected between every step.
 */
class CloudStoreTest {
    private val dir = File(System.getProperty("java.io.tmpdir"), "habits-cloud-${System.nanoTime()}").apply { mkdirs() }

    @AfterTest fun cleanUp() { dir.deleteRecursively() }

    inner class Phone(val name: String, private val zone: FakeZone) {
        var wall = 1_000_000L
        val repo = HabitRepository.open(File(dir, "$name.db").path) { wall }
        val cloud get() = repo.cloud
        /** Where this phone's fetches have reached in the zone's change feed (the engine's state). */
        var token = 0

        /** One send, as `CloudSync` runs it: up to 250 rows, each saved only if unchanged; a conflict merges the
         *  server's record and stays queued. `loseReply` drops CloudKit's answer (the app died): nothing is confirmed. */
        fun send(loseReply: Boolean = false): Int = runBlocking {
            val names = cloud.waitingRows(250)
            val batch = cloud.batch(names)
            val saved = mutableListOf<CloudSaved>()
            for (row in batch.rows) {
                when (val result = zone.save(row)) {
                    is FakeZone.Result.Saved -> saved += CloudSaved(row.name, result.tag, row.upTo)
                    is FakeZone.Result.Conflict -> cloud.fetched(listOf(result.server), Int.MAX_VALUE, holdAll = false)
                }
            }
            if (!loseReply) cloud.saved(saved)
            names.size
        }

        /** Fetches the zone's changes since [token], a page at a time; each page is merged before the token moves. */
        fun fetch(page: Int = 100, crashBeforeTokenSave: Boolean = false, allowance: (Int) -> Int = { Int.MAX_VALUE }): List<CloudApplied> = runBlocking {
            val results = mutableListOf<CloudApplied>()
            var deleted = 0
            while (true) {
                val (records, next) = zone.changes(token, page)
                if (records.isEmpty()) break
                val applied = cloud.fetched(records, allowance(deleted), holdAll = results.any { it.held })
                results += applied
                deleted += applied.deleted
                if (crashBeforeTokenSave) break // the same page comes again next time
                token = next
            }
            results
        }

        fun syncFully() {
            sendAll()
            fetch()
            sendAll()
        }

        /** Sends until nothing waits; a lost reply or a conflict costs a round, never more than a few. */
        fun sendAll(): Int {
            var rounds = 0
            while (send() > 0) check(++rounds < 2_000) { "$name: sending never finished" }
            return rounds
        }

        fun state(): Snapshot = runBlocking { repo.load() }.let { s ->
            Snapshot(s.habits.sortedBy { it.id }, s.steps.sortedBy { it.id }, s.reminders.sortedBy { it.id }, s.entries.sortedBy { it.id }, s.settings.sortedBy { it.key })
        }

        fun counts() = runBlocking { cloud.counts() }
        fun close() = repo.close()
    }

    private fun habit(id: String, name: String = "Water", deletedAt: Long? = null) = HabitRecord(
        id = id, name = name, symbol = "drop.fill", color = "blue", kind = "amount", unit = "glasses", increment = 1.0,
        part = "anytime", goal = 8.0, period = "day", scheduleDays = null, frequency = "daily", dueDay = null, dueMinute = null,
        atMost = false, quitSince = null, position = 0, createdAt = 1_000, updatedAt = 1_000, archivedAt = null, deletedAt = deletedAt,
    )

    private fun entry(id: String, habitId: String) = EntryRecord(id, habitId, null, "2026-10-01", 1.0, 2_000, "Europe/London", null, null)

    private fun phones(vararg names: String, zone: FakeZone = FakeZone()): List<Phone> =
        names.map { Phone(it, zone).also { p -> runBlocking { p.cloud.bind("icloud:account") } } }

    @Test fun mergeRecordIsTheSameAsApplyingItsOps() {
        val random = Random(7)
        repeat(500) {
            // Distinct stamps, as real ops have (a stamp is made once, by one device).
            val stamps = generateSequence { app.habits.sync.Hlc(random.nextLong(1, 50), random.nextInt(0, 3), listOf("a", "b", "c").random(random)).encode() }
                .distinct().take(random.nextInt(1, 8)).toList()
            val ops = stamps.mapIndexed { i, hlc ->
                val fields = buildMap {
                    if (random.nextBoolean()) put("name", JsonPrimitive("n$i"))
                    if (random.nextInt(4) == 0) put("deleted_at", if (random.nextBoolean()) JsonPrimitive(random.nextLong(1, 99)) else kotlinx.serialization.json.JsonNull)
                    if (isEmpty() || random.nextBoolean()) put("goal", JsonPrimitive(random.nextInt(9)))
                }
                app.habits.sync.Op("op$i", "habit", "h1", fields, hlc, 9)
            }
            val folded = ops.fold(null as SyncRecord?) { r, o -> SyncRules.merge(r, o) }!!
            // A record (the merged state of some ops) merged into the merge of the others equals merging all ops.
            val split = random.nextInt(0, ops.size + 1)
            val left = ops.take(split).fold(null as SyncRecord?) { r, o -> SyncRules.merge(r, o) }
            val right = ops.drop(split).fold(null as SyncRecord?) { r, o -> SyncRules.merge(r, o) }
            val viaRecord = if (right == null) left else SyncRules.mergeRecord(left, right)
            assertEquals(folded, viaRecord)
            // Order-free and idempotent.
            if (left != null && right != null) {
                assertEquals(SyncRules.mergeRecord(left, right), SyncRules.mergeRecord(right, left))
                assertEquals(SyncRules.mergeRecord(left, right), SyncRules.mergeRecord(SyncRules.mergeRecord(left, right), right))
            }
        }
    }

    @Test fun theOutboxShrinksOnlyOnConfirmedSaves() = runBlocking {
        val (phone) = phones("phone")
        phone.repo.saveHabit(habit("h1"), emptyList(), emptyList(), 1)
        phone.repo.addEntry(entry("e1", "h1"))
        assertEquals(2, phone.counts().waitingRows)
        phone.send(loseReply = true)
        assertEquals(2, phone.counts().waitingRows, "a save CloudKit made but the app never heard of stays waiting")
        // The next save is a conflict (this phone never got the record's system fields): it merges and goes again.
        assertTrue(phone.sendAll() <= 2)
        assertEquals(0, phone.counts().waitingRows)
        phone.close()
    }

    @Test fun aChangeMadeWhileTheBatchWasInFlightStaysQueued() = runBlocking {
        val zone = FakeZone()
        val (phone) = phones("phone", zone = zone)
        phone.repo.saveHabit(habit("h1"), emptyList(), emptyList(), 1)
        val names = phone.cloud.waitingRows(250)
        val batch = phone.cloud.batch(names)
        phone.wall += 10
        phone.repo.saveHabit(habit("h1", name = "Tea"), emptyList(), emptyList(), 2) // made after the batch was built
        val saved = batch.rows.map { CloudSaved(it.name, (zone.save(it) as FakeZone.Result.Saved).tag, it.upTo) }
        phone.cloud.saved(saved)
        assertEquals(1, phone.counts().waitingRows, "the rename isn't in the saved record, so it waits")
        phone.send()
        assertEquals(0, phone.counts().waitingRows)
        assertEquals("Tea", zone.record("habit:h1").fields["name"]!!.jsonPrimitive.content)
        phone.close()
    }

    @Test fun twoPhonesConvergeThroughConflicts() = runBlocking {
        val zone = FakeZone()
        val (phone, ipad) = phones("phone", "ipad", zone = zone)
        phone.repo.saveHabit(habit("h1"), emptyList(), emptyList(), 1)
        phone.syncFully(); ipad.syncFully()
        phone.wall += 5; ipad.wall += 9
        phone.repo.saveHabit(phone.state().habits.single().copy(name = "Tea"), emptyList(), emptyList(), 2)
        ipad.repo.saveHabit(ipad.state().habits.single().copy(goal = 3.0), emptyList(), emptyList(), 2)
        phone.send()
        ipad.send() // conflicts: merges the phone's rename, stays queued
        ipad.send()
        phone.syncFully(); ipad.syncFully()
        assertEquals(phone.state(), ipad.state())
        assertEquals("Tea", phone.state().habits.single().name)
        assertEquals(3.0, phone.state().habits.single().goal)
        phone.close(); ipad.close()
    }

    @Test fun aDeleteOnOnePhoneStaysDeletedWhateverTheOtherDid() = runBlocking {
        val zone = FakeZone()
        val (phone, ipad) = phones("phone", "ipad", zone = zone)
        phone.repo.saveHabit(habit("h1"), emptyList(), emptyList(), 1)
        phone.syncFully(); ipad.syncFully()
        phone.wall += 5; ipad.wall += 50
        phone.repo.saveHabit(habit("h1", deletedAt = 5), emptyList(), emptyList(), 5)
        ipad.repo.saveHabit(habit("h1", name = "Later edit"), emptyList(), emptyList(), 50)
        phone.syncFully(); ipad.syncFully(); phone.syncFully()
        assertTrue(phone.state().habits.isEmpty() && ipad.state().habits.isEmpty())
        phone.close(); ipad.close()
    }

    @Test fun changesDeliveredTwiceOrAfterACrashChangeNothingMore() = runBlocking {
        val zone = FakeZone()
        val (phone, ipad) = phones("phone", "ipad", zone = zone)
        repeat(30) { phone.repo.addEntry(entry("e$it", "h1")) }
        phone.repo.saveHabit(habit("h1"), emptyList(), emptyList(), 1)
        phone.syncFully()
        ipad.fetch(page = 7, crashBeforeTokenSave = true) // applied, then the app died before the engine saved its state
        ipad.fetch(page = 7) // the same page again, then the rest
        val once = ipad.state()
        assertEquals(phone.state(), once)
        ipad.token = 0
        ipad.fetch(page = 13) // the engine lost its state: everything again
        assertEquals(once, ipad.state())
        assertEquals(0, ipad.counts().waitingRows, "fetched changes are never sent back")
        phone.close(); ipad.close()
    }

    @Test fun nothingFetchedEverRemovesALocalRow() = runBlocking {
        val zone = FakeZone()
        val (phone, ipad) = phones("phone", "ipad", zone = zone)
        ipad.repo.saveHabit(habit("mine"), emptyList(), emptyList(), 1)
        ipad.repo.addEntry(entry("e-mine", "mine"))
        phone.repo.saveHabit(habit("h1"), emptyList(), emptyList(), 1)
        phone.syncFully()
        zone.purge() // the person deleted the app's iCloud data
        ipad.token = 0
        ipad.fetch()
        assertEquals(setOf("mine"), ipad.state().habits.map { it.id }.toSet().minus("h1"))
        assertEquals(1, ipad.state().entries.size)
        // Back Up Again: everything goes up as new records.
        ipad.cloud.uploadEverythingAgain()
        assertTrue(ipad.counts().waitingRows >= 2)
        ipad.syncFully()
        assertTrue(zone.has("habit:mine") && zone.has("entry:e-mine"))
        phone.close(); ipad.close()
    }

    @Test fun anotherAccountGetsEverythingAndTheOldSystemFieldsGo() = runBlocking {
        val first = FakeZone()
        val (phone) = phones("phone", zone = first)
        phone.repo.saveHabit(habit("h1"), emptyList(), emptyList(), 1)
        phone.repo.addEntry(entry("e1", "h1"))
        phone.syncFully()
        assertEquals(0, phone.counts().waitingRows)
        phone.cloud.bind("icloud:other")
        assertEquals(2, phone.counts().waitingRows, "everything is queued for the other account")
        phone.close()
    }

    @Test fun aRecordTooLargeIsKeptAsideNotDropped() = runBlocking {
        val (phone) = phones("phone")
        repeat(40) { phone.repo.saveSetting("note.big$it", "x") }
        phone.repo.saveSetting("daynote.2026-10-01", "a".repeat(300 * 1024))
        val batch = phone.cloud.batch(phone.cloud.waitingRows(250))
        assertEquals(listOf("setting:daynote.2026-10-01"), batch.refused)
        assertEquals(1, phone.counts().keptAside)
        assertEquals("a".repeat(300 * 1024), phone.state().settings.first { it.key == "daynote.2026-10-01" }.value, "still on the phone")
        phone.close()
    }

    @Test fun aRecordFromANewerFormatIsKeptAsideUntilItCanBeRead() = runBlocking {
        val (phone) = phones("phone")
        val future = CloudIncoming("habit:h9", """{"name":"From the future"}""", """{"name":"000000000000000100-00000-x"}""", 2, null)
        val applied = phone.cloud.fetched(listOf(future), Int.MAX_VALUE, false)
        assertEquals(1, applied.quarantined)
        assertTrue(phone.state().habits.isEmpty())
        assertEquals(1, phone.counts().unreadable)
        phone.close()
    }

    @Test fun theBrakeHoldsAFetchedMassDeleteUntilThePersonSays() = runBlocking {
        val zone = FakeZone()
        val (phone, ipad) = phones("phone", "ipad", zone = zone)
        phone.repo.saveHabit(habit("h1"), emptyList(), emptyList(), 1)
        repeat(100) { phone.repo.addEntry(entry("e$it", "h1")) }
        phone.syncFully(); ipad.syncFully()
        assertEquals(100, ipad.state().entries.size)
        // A bug on the phone takes back 60 logs.
        phone.wall += 10
        repeat(60) { phone.repo.removeEntry("e$it", phone.wall) }
        assertTrue(CloudStore.outgoingBrake(phone.counts().waitingDeletes, phone.counts().liveRecords), "the phone's own brake trips")
        phone.syncFully() // (the test sends anyway, as if the person on the phone said yes)
        val live = ipad.counts().liveRecords
        val results = ipad.fetch(page = 20) { deleted -> CloudStore.incomingAllowance(live, deleted) }
        assertTrue(results.any { it.held }, "held")
        val counts = ipad.counts()
        assertTrue(counts.heldPages > 0 && counts.heldDeletes > 0)
        assertTrue(ipad.state().entries.size >= 80, "at most 20% went before the brake held the rest: ${ipad.state().entries.size}")
        ipad.cloud.applyHeld()
        assertEquals(40, ipad.state().entries.size)
        assertEquals(0, ipad.counts().heldPages)
        phone.close(); ipad.close()
    }

    @Test fun aConfirmedRestoreIsNotHeldByTheOutgoingBrake() = runBlocking {
        val (phone) = phones("phone")
        phone.repo.saveHabit(habit("h1"), emptyList(), emptyList(), 1)
        val empty = Snapshot(listOf(habit("h1")), emptyList(), emptyList(), emptyList(), emptyList())
        repeat(80) { phone.repo.addEntry(entry("e$it", "h1")) }
        phone.syncFully()
        val file = phone.repo.backupFile(BackupInfo("x", "ios", "1"))
        phone.repo.importAll(empty)
        // Restoring an older copy with no logs removes all 80: the person chose Replace.
        val emptier = HabitRepository.open(File(dir, "other.db").path) { 5 }
        emptier.saveHabit(habit("h1"), emptyList(), emptyList(), 1)
        val older = emptier.backupFile(BackupInfo("x", "ios", "1"))
        phone.repo.restore(older.base64, RestoreMode.REPLACE, BackupInfo("x", "ios", "1"))
        val counts = phone.counts()
        assertEquals(0, counts.waitingDeletes)
        assertEquals(80, counts.confirmedDeletes)
        assertFalse(CloudStore.outgoingBrake(counts.waitingDeletes, counts.liveRecords))
        assertTrue(file.base64.isNotEmpty())
        emptier.close(); phone.close()
    }

    @Test fun theBrakeRule() {
        assertFalse(CloudStore.outgoingBrake(3, 10), "a handful never trips")
        assertFalse(CloudStore.outgoingBrake(10, 1_000))
        assertTrue(CloudStore.outgoingBrake(10, 30), "10 of 40 is 25%")
        assertTrue(CloudStore.outgoingBrake(51, 100_000), "more than 50")
        assertFalse(CloudStore.outgoingBrake(50, 100_000))
        assertEquals(200, CloudStore.incomingAllowance(1_000, 0))
        assertEquals(9, CloudStore.incomingAllowance(5, 0))
    }

    @Test fun aClonedPhoneGetsItsOwnNode() = runBlocking {
        val (phone) = phones("phone")
        val before = phone.cloud.node()
        phone.cloud.renewNode()
        phone.repo.saveHabit(habit("h1"), emptyList(), emptyList(), 1)
        val after = phone.cloud.node()
        assertTrue(before != after && after != null)
        val row = phone.cloud.batch(listOf("habit:h1")).rows.single()
        assertTrue(Json.parseToJsonElement(row.clocks).jsonObject.values.all { it.jsonPrimitive.content.endsWith("-$after") }, "new stamps carry the new node")
        phone.close()
    }

    /** The property test (§19): three phones, random edits, deletes, conflicts, lost replies, crashes mid-fetch and lost
     *  engine state, in many seeds; every run converges, and nothing made on any phone is lost. */
    @Test fun randomInterleavingsOnThreePhonesAlwaysConverge() = runBlocking {
        repeat(40) { seed ->
            val random = Random(seed)
            val zone = FakeZone()
            val all = phones("p$seed", "i$seed", "w$seed", zone = zone)
            val made = mutableSetOf<String>()
            val habitIds = listOf("h1", "h2", "h3")
            repeat(20) { round ->
                for (d in all) {
                    d.wall += random.nextLong(1, 2_000)
                    repeat(random.nextInt(0, 5)) { i ->
                        val id = habitIds.random(random)
                        val live = d.state().habits.firstOrNull { it.id == id }
                        when (random.nextInt(7)) {
                            0, 1 -> d.repo.saveHabit((live ?: habit(id)).copy(name = "${d.name}-$round-$i"), emptyList(), emptyList(), d.wall)
                            2 -> d.repo.saveHabit((live ?: habit(id)).copy(goal = random.nextInt(1, 9).toDouble()), emptyList(), emptyList(), d.wall)
                            3 -> "${d.name}-$round-$i".let { d.repo.addEntry(entry(it, id)); made += it }
                            4 -> d.state().entries.randomOrNull(random)?.let { d.repo.removeEntry(it.id, d.wall) }
                            5 -> if (random.nextInt(4) == 0 && live != null) d.repo.saveHabit(live.copy(deletedAt = d.wall), emptyList(), emptyList(), d.wall)
                            else -> d.repo.saveSetting("week_start", random.nextInt(1, 8).toString())
                        }
                    }
                    when (random.nextInt(6)) {
                        0 -> d.send(loseReply = true)
                        1 -> d.fetch(page = random.nextInt(1, 9), crashBeforeTokenSave = true)
                        2 -> { d.token = 0; d.fetch(page = 50) } // lost engine state
                        3 -> {}
                        else -> { d.send(); d.fetch(page = random.nextInt(1, 30)) }
                    }
                }
            }
            repeat(3) { all.forEach { it.syncFully() } }
            val expected = all.first().state()
            all.forEach { assertEquals(expected, it.state(), "seed $seed: ${it.name} differs") }
            all.forEach { assertEquals(0, it.counts().waitingRows, "seed $seed: ${it.name} still has changes waiting") }
            // Nothing made anywhere is missing: every log exists (live or taken back) on every phone.
            val everywhere = runBlocking { all.first().repo.loadForRestore() }.entries.map { it.id }.toSet()
            assertTrue(everywhere.containsAll(made), "seed $seed: lost ${made - everywhere}")
            assertEquals(zone.size(), runBlocking { all.first().repo.loadForRestore() }.let { it.habits.size + it.entries.size + it.settings.size + it.steps.size + it.reminders.size } + zone.removedSettings())
            all.forEach { it.close() }
        }
    }

    /** §14: an extreme account (25,000 logs a year for 15 years) goes up and comes down in pages, within a time budget. */
    @Test fun anExtremeAccountUploadsAndFetches() = runBlocking {
        val zone = FakeZone()
        val (phone, ipad) = phones("phone", "ipad", zone = zone)
        val habits = (0 until 60).map { habit("h$it", name = "Habit $it") }
        val entries = (0 until 375_000).map { EntryRecord("e$it", "h${it % 60}", null, "2026-10-01", 1.0, 2_000L + it, "Europe/London", null, null) }
        val started = System.currentTimeMillis()
        phone.repo.importAll(Snapshot(habits, emptyList(), emptyList(), entries, emptyList()))
        val imported = System.currentTimeMillis()
        assertEquals(375_060, phone.counts().waitingRows)
        var requests = 0
        requests = phone.sendAll() + 1
        val uploaded = System.currentTimeMillis()
        assertEquals(375_060, zone.size())
        assertTrue(requests in 1_500..1_510, "$requests requests of at most 250")
        ipad.fetch(page = 400)
        val fetched = System.currentTimeMillis()
        assertEquals(375_000, runBlocking { ipad.repo.load() }.entries.size)
        println("extreme: import ${imported - started} ms, upload ${uploaded - imported} ms in $requests requests, fetch ${fetched - uploaded} ms")
        assertTrue(uploaded - imported < 10 * 60_000 && fetched - uploaded < 10 * 60_000, "within ten minutes each on CI's machine")
        phone.close(); ipad.close()
    }
}

/** A CloudKit zone, in memory: records by name with a change tag; saves only if the tag sent is the server's (a newer
 *  one is a conflict, answered with the server's record); a feed of changes in order. */
class FakeZone {
    sealed interface Result {
        data class Saved(val tag: String) : Result
        data class Conflict(val server: CloudIncoming) : Result
    }

    private class Stored(val fields: String, val clocks: String, val tag: Long)
    private val records = mutableMapOf<String, Stored>()
    /** The change feed: each record once, at the tag of its latest save (the fetch token is a tag). */
    private val feed = java.util.TreeMap<Long, String>()
    private var nextTag = 1L

    fun save(row: CloudRow): Result {
        val existing = records[row.name]
        if (existing != null && row.system != existing.tag.toString()) return Result.Conflict(incoming(row.name, existing))
        if (existing == null && row.system != null) {
            // CloudKit: a record saved with system fields from a record that's gone is `unknownItem`; the app forgets
            // them and saves it as new. The fake does both at once.
        }
        val tag = nextTag++
        existing?.let { feed.remove(it.tag) }
        records[row.name] = Stored(row.fields, row.clocks, tag)
        feed[tag] = row.name
        return Result.Saved(tag.toString())
    }

    /** The changes after [token]: the latest version of each record changed since, in order, and the next token. */
    fun changes(token: Int, limit: Int): Pair<List<CloudIncoming>, Int> {
        val page = feed.tailMap(token.toLong(), false).entries.take(limit)
        return page.map { incoming(it.value, records.getValue(it.value)) } to (page.lastOrNull()?.key?.toInt() ?: token)
    }

    fun record(name: String): SyncRecord = records.getValue(name).let {
        SyncRecord(Json.parseToJsonElement(it.fields).jsonObject, Json.parseToJsonElement(it.clocks).jsonObject.mapValues { c -> c.value.jsonPrimitive.content })
    }

    fun has(name: String) = records.containsKey(name)
    fun size() = records.size
    /** Settings removed everywhere (value null): a record in the zone, no row on the phone. */
    fun removedSettings() = records.count { (name, stored) -> name.startsWith("setting:") && (Json.parseToJsonElement(stored.fields) as JsonObject)["value"] is kotlinx.serialization.json.JsonNull }

    fun purge() {
        records.clear()
        feed.clear()
    }

    private fun incoming(name: String, stored: Stored) = CloudIncoming(name, stored.fields, stored.clocks, CloudStore.FORMAT, stored.tag.toString())
}
