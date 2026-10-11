package app.habits.core

import java.io.File
import kotlin.random.Random
import kotlin.test.AfterTest
import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertFailsWith
import kotlin.test.assertNotNull
import kotlin.test.assertNull
import kotlin.test.assertTrue
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive
import kotlinx.serialization.json.jsonArray
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.json.jsonPrimitive

/**
 * The iPhone and its Apple Watch (Architecture 12): each with its own database, changes travelling both ways through
 * `peer_out` batches (what WatchConnectivity carries), and the iPhone, optionally the Watch too, syncing with a fake
 * iCloud ([FakeServer]). Batches arrive late, twice, out of order, or not at all and are sent again; acknowledgements
 * get lost; devices restart. Whatever happens, every device ends with the same data, nothing lost, nothing counted twice.
 */
class PeerSyncTest {
    private val dir = File(System.getProperty("java.io.tmpdir"), "habits-peer-${System.nanoTime()}").apply { mkdirs() }

    @AfterTest fun cleanUp() { dir.deleteRecursively() }

    /** One device. `file` false keeps the database in memory (fast, for the thousands of seeded runs). */
    inner class Device(val name: String, private val cloud: FakeServer?, private val file: Boolean, private val clock: () -> Long) {
        var repo: HabitRepository = open()
        private fun open() = if (file) HabitRepository.open(File(dir, "$name.db").path, clock) else HabitRepository.openInMemory(clock)

        /** The app is killed and opened again: what's committed stays; the system keeps queued transfers. */
        fun restart() { check(file); repo.close(); repo = open() }

        fun sync(loseReplyOnce: Boolean = false) = runBlocking {
            val cloud = cloud ?: return@runBlocking
            var lose = loseReplyOnce
            var more = true
            var rounds = 0
            while (more) {
                val reply = cloud.handle(name, repo.syncRequest())
                check(++rounds < 200) { "sync didn't finish" }
                if (lose) { lose = false; continue }
                more = repo.acceptSyncReply(reply)
            }
        }

        fun state(): Snapshot = runBlocking { repo.loadForRestore() }.let { s ->
            Snapshot(s.habits.sortedBy { it.id }, s.steps.sortedBy { it.id }, s.reminders.sortedBy { it.id }, s.entries.sortedBy { it.id }, s.settings.sortedBy { it.key })
        }
        fun live(): Snapshot = runBlocking { repo.load() }
        fun waiting() = runBlocking { repo.peerStatus().waiting + repo.syncStatus().waiting }
        fun close() = repo.close()
    }

    /** What WatchConnectivity carries between the two: queued batches, delivered in any order, maybe twice. */
    class Link {
        val toWatch = mutableListOf<String>()
        val toPhone = mutableListOf<String>()
    }

    private fun habit(id: String, kind: String = "amount", name: String = "Water") = HabitRecord(
        id = id, name = name, symbol = "drop.fill", color = "blue", kind = kind, unit = "glasses", increment = 1.0,
        part = "anytime", goal = 8.0, period = "day", scheduleDays = null, frequency = "daily", dueDay = null, dueMinute = null,
        atMost = false, quitSince = null, position = 0, createdAt = 1_000, updatedAt = 1_000, archivedAt = null, deletedAt = null,
    )

    private fun entry(id: String, habitId: String, at: Long, value: Double = 1.0, source: String = "today", day: String = "2026-10-10") =
        EntryRecord(id, habitId, null, day, value, at, "Europe/London", null, null, source)

    /** Sends everything waiting both ways, in order, and syncs with the cloud, until nothing is waiting anywhere. */
    private fun drain(phone: Device, watch: Device, link: Link) = runBlocking {
        repeat(50) {
            link.toWatch.toList().forEach { b -> phone.repo.ackPeer(watch.repo.acceptPeerBatch(b)) }; link.toWatch.clear()
            link.toPhone.toList().forEach { b -> watch.repo.ackPeer(phone.repo.acceptPeerBatch(b)) }; link.toPhone.clear()
            phone.repo.peerBatch(1_000)?.let { phone.repo.ackPeer(watch.repo.acceptPeerBatch(it)) }
            watch.repo.peerBatch(1_000)?.let { watch.repo.ackPeer(phone.repo.acceptPeerBatch(it)) }
            phone.sync(); watch.sync()
            if (phone.waiting() == 0 && watch.waiting() == 0) {
                phone.sync(); watch.sync()
                return@runBlocking
            }
        }
        error("queues never emptied: phone ${phone.waiting()}, watch ${watch.waiting()}")
    }

    /**
     * One seeded run: random changes on both devices (logs, undos, skips, timer starts and stops, settings, renames),
     * random delivery, and at the end the same data everywhere with every log either there once or undone.
     */
    private fun randomRun(seed: Int, files: Boolean, steps: Int = 50) = runBlocking {
        val random = Random(seed)
        var wall = 1_790_000_000_000L
        val clock = { wall }
        val cloud = FakeServer()
        val phone = Device("phone-$seed", cloud, files, clock)
        val watchUsesCloud = random.nextBoolean() // the Watch's own iCloud path (after item 81): changes then arrive both ways
        val watch = Device("watch-$seed", if (watchUsesCloud) cloud else null, files, clock)
        val link = Link()
        phone.repo.bindAccount("acct")
        if (watchUsesCloud) watch.repo.bindAccount("acct")
        val habits = listOf("h1", "h2", "h3")
        habits.forEach { phone.repo.saveHabit(habit(it), emptyList(), emptyList(), wall) }
        // Some history before the Watch appears; then the Watch asks for its first fill, in small parts.
        repeat(random.nextInt(0, 8)) { phone.repo.addEntry(entry("pre-$seed-$it", habits.random(random), wall)) }
        watch.repo.peerStart()
        phone.repo.peerStart()
        var fillCursor: String? = null
        var fillDone = false
        val added = mutableSetOf<String>()
        added += phone.live().entries.map { it.id }
        val removed = mutableSetOf<String>()
        val stopped = mutableSetOf<String>()
        val devices = listOf(phone, watch)

        repeat(steps) { step ->
            wall += random.nextLong(1, 90_000)
            val d = devices.random(random)
            when (random.nextInt(16)) {
                0, 1, 2 -> { val id = "${d.name}-$step"; d.repo.addEntry(entry(id, habits.random(random), wall)); added += id }
                3 -> d.live().entries.filter { it.source != "timer" }.randomOrNull(random)?.let { d.repo.removeEntry(it.id, wall); removed += it.id }
                4 -> d.repo.saveSetting("skip.${habits.random(random)}", "2026-10-${random.nextInt(1, 29)}")
                5 -> d.repo.saveSetting("timer.${habits.random(random)}", wall.toString())
                6 -> {
                    val h = habits.random(random)
                    val start = d.live().settings.firstOrNull { it.key == "timer.$h" }?.value?.toLongOrNull()
                    if (start != null) {
                        val id = TimerStop.entryId(h, start)
                        d.repo.finishTimer(entry(id, h, wall, value = (wall - start) / 60_000.0, source = "timer"), "timer.$h")
                        stopped += id
                    }
                }
                7 -> d.repo.saveSetting("week_start", random.nextInt(1, 8).toString())
                8 -> d.live().habits.randomOrNull(random)?.let { d.repo.saveHabit(it.copy(name = "${d.name} $step"), emptyList(), emptyList(), wall) }
                // Delivery: send a batch (always from the oldest unacknowledged change), maybe twice.
                9 -> phone.repo.peerBatch(random.nextInt(1, 6))?.let { link.toWatch += it; if (random.nextInt(4) == 0) link.toWatch += it }
                10 -> watch.repo.peerBatch(random.nextInt(1, 6))?.let { link.toPhone += it; if (random.nextInt(4) == 0) link.toPhone += it }
                // Deliver one queued batch, in any order; sometimes the acknowledgement is lost on the way back.
                11 -> link.toWatch.randomOrNull(random)?.let { b ->
                    link.toWatch.remove(b)
                    val seq = watch.repo.acceptPeerBatch(b)
                    if (random.nextInt(5) > 0) phone.repo.ackPeer(seq)
                }
                12 -> link.toPhone.randomOrNull(random)?.let { b ->
                    link.toPhone.remove(b)
                    val seq = phone.repo.acceptPeerBatch(b)
                    if (random.nextInt(5) > 0) watch.repo.ackPeer(seq)
                }
                // A batch lost before it was saved (the app killed mid-transaction): never acknowledged, sent again later.
                13 -> link.toWatch.randomOrNull(random)?.let { link.toWatch.remove(it) }
                14 -> if (random.nextBoolean()) phone.sync(loseReplyOnce = random.nextInt(4) == 0) else watch.sync(loseReplyOnce = random.nextInt(4) == 0)
                else -> if (!fillDone) {
                    val part = phone.repo.peerFillPart(fillCursor, maxRecords = random.nextInt(1, 6))
                    val receipt = watch.repo.acceptPeerFill(part.base64)
                    fillCursor = receipt.next
                    fillDone = receipt.next == null
                } else if (files && random.nextInt(3) == 0) d.restart()
            }
        }
        while (!fillDone) {
            val receipt = watch.repo.acceptPeerFill(phone.repo.peerFillPart(fillCursor).base64)
            fillCursor = receipt.next; fillDone = receipt.next == null
        }
        drain(phone, watch, link)

        val expected = phone.state()
        assertEquals(expected, watch.state(), "seed $seed: the Watch differs from the iPhone")
        val live = expected.entries.filter { it.deletedAt == null }.map { it.id }.toSet()
        assertEquals(added - removed, live - stopped, "seed $seed: a log was lost or came back")
        assertTrue(watch.live().entries.isNotEmpty() || expected.entries.none { it.deletedAt == null }, "seed $seed")
        assertTrue(runBlocking { watch.repo.peerStatus() }.filled, "seed $seed: the fill finished")
        // Each timer stopped is one log at most, however many devices stopped it.
        val timerLogs = expected.entries.filter { it.source == "timer" }
        assertEquals(timerLogs.map { it.id }.toSet().size, timerLogs.size)
        assertTrue(timerLogs.all { it.id in stopped }, "seed $seed: a timer log not made from its timer")
        phone.close(); watch.close()
    }

    private val seeds = System.getenv("PEER_SEEDS")?.toIntOrNull() ?: 200

    @Test fun thousandsOfRandomRunsConverge() {
        repeat(seeds) { randomRun(it, files = false) }
        println("peer property test: $seeds seeded runs converged")
    }

    @Test fun randomRunsWithRestartsConverge() {
        repeat(maxOf(10, seeds / 10)) { randomRun(100_000 + it, files = true, steps = 40) }
    }

    // MARK: Architecture 12 §4, one test each

    private fun pair(files: Boolean = false, clock: () -> Long): Triple<Device, Device, Link> = runBlocking {
        val phone = Device("phone", FakeServer(), files, clock)
        val watch = Device("watch", null, files, clock)
        phone.repo.peerStart(); watch.repo.peerStart()
        Triple(phone, watch, Link())
    }

    @Test fun theSameTapArrivingTwiceIsOneLog() = runBlocking {
        var wall = 5_000L
        val (phone, watch, link) = pair { wall }
        phone.repo.saveHabit(habit("h"), emptyList(), emptyList(), wall)
        drain(phone, watch, link)
        watch.repo.addEntry(entry("tap-1", "h", wall))
        val batch = watch.repo.peerBatch()!!
        phone.repo.acceptPeerBatch(batch); phone.repo.acceptPeerBatch(batch) // both paths, or a retry
        drain(phone, watch, link)
        assertEquals(listOf("tap-1"), phone.live().entries.map { it.id })
        assertEquals(phone.state(), watch.state())
    }

    @Test fun bothDevicesAddingAtOnceBothCount() = runBlocking {
        val wall = 5_000L
        val (phone, watch, link) = pair { wall }
        phone.repo.saveHabit(habit("h"), emptyList(), emptyList(), wall)
        drain(phone, watch, link)
        phone.repo.addEntry(entry("p", "h", wall)); watch.repo.addEntry(entry("w", "h", wall))
        drain(phone, watch, link)
        assertEquals(setOf("p", "w"), watch.live().entries.map { it.id }.toSet())
        assertEquals(phone.state(), watch.state())
    }

    @Test fun aTickAgainstAnUntickEndsUnticked() = runBlocking {
        var wall = 5_000L
        val (phone, watch, link) = pair { wall }
        phone.repo.saveHabit(habit("h", kind = "check"), emptyList(), emptyList(), wall)
        phone.repo.addEntry(entry("tick", "h", wall))
        drain(phone, watch, link)
        wall += 10
        phone.repo.removeEntry("tick", wall) // the iPhone unticks…
        wall += 5
        watch.repo.editEntry("tick", 1.0, wall) // …while the Watch, not yet knowing, changes the same tick, later
        drain(phone, watch, link)
        assertTrue(phone.live().entries.isEmpty() && watch.live().entries.isEmpty(), "the delete wins")
    }

    @Test fun theSameTimerStoppedOnBothDevicesLogsOnce() = runBlocking {
        var wall = 1_790_000_000_000L
        val (phone, watch, link) = pair { wall }
        phone.repo.saveHabit(habit("read", kind = "duration"), emptyList(), emptyList(), wall)
        val start = wall
        phone.repo.saveSetting("timer.read", start.toString())
        drain(phone, watch, link)
        // Out of range of each other, both stop it: the Watch after 12 minutes, the iPhone a little later.
        val id = TimerStop.entryId("read", start)
        wall = start + 12 * 60_000
        watch.repo.finishTimer(entry(id, "read", wall, value = 12.0, source = "timer"), "timer.read")
        wall = start + 13 * 60_000
        phone.repo.finishTimer(entry(id, "read", wall, value = 13.0, source = "timer"), "timer.read")
        drain(phone, watch, link)
        val logs = phone.live().entries
        assertEquals(1, logs.size, "one log, not two")
        assertEquals(13.0, logs.single().value, "the later stop's minutes win")
        assertEquals(phone.state(), watch.state())
        assertTrue(phone.live().settings.none { it.key == "timer.read" } && watch.live().settings.none { it.key == "timer.read" })
        // The ID is the same on every platform for the same timer, and differs for another start.
        assertEquals(id, TimerStop.entryId("READ".lowercase(), start))
        assertTrue(id != TimerStop.entryId("read", start + 1))
        assertTrue(Regex("[0-9A-F]{8}-[0-9A-F]{4}-5[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}").matches(id), id)
    }

    @Test fun aTimerStartedOnBothWhileApartRunsFromTheLaterStart() = runBlocking {
        var wall = 1_790_000_000_000L
        val (phone, watch, link) = pair { wall }
        phone.repo.saveHabit(habit("read", kind = "duration"), emptyList(), emptyList(), wall)
        drain(phone, watch, link)
        phone.repo.saveSetting("timer.read", wall.toString())
        wall += 30_000
        watch.repo.saveSetting("timer.read", wall.toString())
        drain(phone, watch, link)
        // Accepted for version 1 (Architecture 12 §4): one timer, from the later start; the earlier start's time isn't logged.
        assertEquals(wall.toString(), phone.live().settings.single { it.key == "timer.read" }.value)
        assertEquals(phone.state(), watch.state())
    }

    @Test fun aLogJustAfterMidnightKeepsTheDayItWasMadeFor() = runBlocking {
        // 01:30 on 11 Oct with a 3 AM day start is still 10 Oct: the day is worked out on the device that logs (D7, WA5)
        // and travels with the log, never recomputed on the other device.
        val wall = 1_791_000_000_000L
        val (phone, watch, link) = pair { wall }
        phone.repo.saveHabit(habit("h"), emptyList(), emptyList(), wall)
        phone.repo.saveSetting("day_end_hour", "3")
        drain(phone, watch, link)
        assertEquals("3", watch.live().settings.single { it.key == "day_end_hour" }.value, "the day start reaches the Watch")
        watch.repo.addEntry(entry("late", "h", wall, day = "2026-10-10"))
        drain(phone, watch, link)
        assertEquals("2026-10-10", phone.live().entries.single().day)
    }

    @Test fun fieldsFromANewerAppAreKeptAndPassedOn() = runBlocking {
        val wall = 1_790_000_000_000L
        val (phone, watch, link) = pair { wall }
        phone.repo.bindAccount("acct")
        phone.repo.saveHabit(habit("h"), emptyList(), emptyList(), wall)
        drain(phone, watch, link)
        // A newer Watch app sends a field this iPhone version doesn't know.
        val op = """{"id":"op-new","table":"habit","row":"h","fields":{"sparkle":"on","name":"Water+"},"hlc":"${"%018d".format(wall + 1)}-00000-watchnode","schema":99}"""
        phone.repo.acceptPeerBatch("""{"seq":1,"ops":[$op]}""")
        assertEquals("Water+", phone.live().habits.single().name)
        // The iPhone passes it on to iCloud whole, the unknown field included.
        assertTrue(phone.repo.syncRequest().contains("\"sparkle\":\"on\""), "unknown field passed on")
        // …and a first fill to another Watch carries it too.
        val part = phone.repo.peerFillPart(null)
        val fresh = Device("fresh", null, false) { wall }
        fresh.repo.acceptPeerFill(part.base64)
        assertTrue(fresh.repo.peerFillPart(null).let { PeerFill.read(it.base64) }.rows.any { it.record.fields["sparkle"] == JsonPrimitive("on") })
    }

    @Test fun aWipedWatchIsFilledAgainWithNothingLost() = runBlocking {
        var wall = 1_790_000_000_000L
        val (phone, watch, link) = pair { wall }
        phone.repo.saveHabit(habit("h"), emptyList(), emptyList(), wall)
        repeat(40) { phone.repo.addEntry(entry("e$it", "h", wall + it, day = "2026-09-${((it % 28) + 1).toString().padStart(2, '0')}")); wall += 1 }
        phone.repo.saveSetting("week_start", "2")
        drain(phone, watch, link)
        watch.repo.addEntry(entry("from-watch", "h", wall)) // not yet sent when the Watch is wiped
        watch.close()
        val wiped = Device("watch2", null, false) { wall }
        wiped.repo.peerStart()
        assertEquals(false, wiped.repo.peerStatus().filled, "an empty Watch knows it hasn't heard back (WA2)")
        var cursor: String? = null
        var parts = 0
        do {
            val receipt = wiped.repo.acceptPeerFill(phone.repo.peerFillPart(cursor, maxRecords = 7).base64)
            cursor = receipt.next; parts++
        } while (cursor != null)
        assertTrue(parts > 3)
        assertTrue(wiped.repo.peerStatus().filled)
        drain(phone, wiped, link)
        assertEquals(phone.state(), wiped.state())
        // What the old Watch hadn't sent is the one thing a wipe loses (Architecture 12 §4, said in Help).
        assertTrue(phone.live().entries.none { it.id == "from-watch" })
    }

    @Test fun whenPlusEndsTheWatchSendsEverythingAndNothingIsDeleted() = runBlocking {
        val wall = 1_790_000_000_000L
        val (phone, watch, link) = pair { wall }
        phone.repo.saveHabit(habit("h"), emptyList(), emptyList(), wall)
        drain(phone, watch, link)
        repeat(5) { watch.repo.addEntry(entry("w$it", "h", wall + it)) }
        // The Watch sends what's waiting first…
        drain(phone, watch, link)
        assertEquals(0, watch.repo.peerStatus().waiting)
        // …then the link stops. Everything stays, on both.
        watch.repo.peerStop(); phone.repo.peerStop()
        assertEquals(5, phone.live().entries.size)
        assertEquals(5, watch.live().entries.size)
        phone.repo.addEntry(entry("later", "h", wall + 100))
        assertNull(phone.repo.peerBatch(), "a stopped link queues nothing")
    }

    // MARK: peer_out

    @Test fun aChangeLeavesTheQueueOnlyWhenAcknowledged() = runBlocking {
        val wall = 5_000L
        val (phone, watch, _) = pair(files = true) { wall }
        watch.repo.addEntry(entry("x", "h", wall))
        assertEquals(1, watch.repo.peerStatus().waiting, "queued in the same transaction as the change")
        val batch = watch.repo.peerBatch()!!
        assertEquals(1, watch.repo.peerStatus().waiting, "making a batch doesn't remove it")
        val seq = phone.repo.acceptPeerBatch(batch)
        assertEquals(1, watch.repo.peerStatus().waiting, "still there until the acknowledgement")
        // The app is killed before the acknowledgement arrives: the change is still waiting after a restart.
        watch.restart()
        assertEquals(1, watch.repo.peerStatus().waiting)
        // Sent again; the iPhone already has it, so it merges as nothing, and the acknowledgement clears it.
        val again = watch.repo.peerBatch()!!
        watch.repo.ackPeer(phone.repo.acceptPeerBatch(again))
        assertEquals(seq, Json.parseToJsonElement(again).jsonObject.getValue("seq").jsonPrimitive.content.toLong())
        assertEquals(0, watch.repo.peerStatus().waiting)
        assertEquals(1, phone.live().entries.size)
        watch.repo.ackPeer(seq) // a late, repeated acknowledgement is harmless
        phone.close(); watch.close()
    }

    @Test fun aChangeNeverGoesBackWhereItCameFrom() = runBlocking {
        val wall = 5_000L
        val (phone, watch, link) = pair { wall }
        phone.repo.bindAccount("acct")
        watch.repo.addEntry(entry("x", "h", wall))
        val batch = watch.repo.peerBatch()!!
        watch.repo.ackPeer(phone.repo.acceptPeerBatch(batch))
        assertNull(phone.repo.peerBatch(), "the Watch's change isn't queued back to the Watch")
        assertTrue(phone.repo.syncRequest().contains("\"x\""), "it is passed on to iCloud")
        phone.sync()
        assertTrue(Json.parseToJsonElement(phone.repo.syncRequest()).jsonObject.getValue("ops").jsonArray.isEmpty(), "sent and acknowledged")
        // The same change comes back from iCloud (the Watch sent it there too): it changes nothing, so it goes nowhere.
        val op = Json.parseToJsonElement(batch).jsonObject.getValue("ops").jsonArray.single()
        phone.repo.acceptSyncReply("""{"applied":[],"ops":[$op],"cursor":99,"more":false}""")
        assertNull(phone.repo.peerBatch())
        assertTrue(Json.parseToJsonElement(phone.repo.syncRequest()).jsonObject.getValue("ops").jsonArray.isEmpty())
        drain(phone, watch, link)
        assertEquals(phone.state(), watch.state())
    }

    @Test fun aChangeFromICloudReachesTheWatch() = runBlocking {
        val wall = 5_000L
        val cloud = FakeServer()
        val ipad = Device("ipad", cloud, false) { wall }
        val phone = Device("phone", cloud, false) { wall }
        val watch = Device("watch", null, false) { wall }
        ipad.repo.bindAccount("acct"); phone.repo.bindAccount("acct")
        phone.repo.peerStart(); watch.repo.peerStart()
        ipad.repo.saveHabit(habit("h"), emptyList(), emptyList(), wall)
        ipad.repo.addEntry(entry("from-ipad", "h", wall))
        ipad.sync(); phone.sync()
        assertNotNull(phone.repo.peerBatch(), "what the iPhone fetched is queued for the Watch")
        drain(phone, watch, Link())
        assertEquals(listOf("from-ipad"), watch.live().entries.map { it.id })
    }

    // MARK: First fill

    @Test fun aDamagedPartIsRefusedAndChangesNothing() = runBlocking {
        val wall = 5_000L
        val (phone, watch, _) = pair { wall }
        phone.repo.saveHabit(habit("h"), emptyList(), emptyList(), wall)
        val part = phone.repo.peerFillPart(null)
        val bytes = java.util.Base64.getDecoder().decode(part.base64)
        bytes[bytes.size / 2] = (bytes[bytes.size / 2].toInt() xor 0x55).toByte()
        val damaged = java.util.Base64.getEncoder().encodeToString(bytes)
        assertFailsWith<BackupProblem> { watch.repo.acceptPeerFill(damaged) }
        assertFailsWith<BackupProblem> { watch.repo.acceptPeerFill("not a file") }
        assertTrue(watch.live().habits.isEmpty())
        assertEquals(false, watch.repo.peerStatus().filled)
        // Asked again, the good part goes in.
        watch.repo.acceptPeerFill(part.base64)
        assertEquals(listOf("h"), watch.live().habits.map { it.id })
    }

    @Test fun theFillNeverOverwritesAChangeMadeWhileItTravelled() = runBlocking {
        var wall = 5_000L
        val (phone, watch, link) = pair { wall }
        phone.repo.saveHabit(habit("h", name = "Water"), emptyList(), emptyList(), wall)
        val part = phone.repo.peerFillPart(null) // made now…
        wall += 1_000
        phone.repo.saveHabit(habit("h", name = "Water 2L"), emptyList(), emptyList(), wall) // …renamed meanwhile…
        drain(phone, watch, link) // …and the rename reaches the Watch first
        wall += 1_000
        watch.repo.acceptPeerFill(part.base64) // the older copy arrives late
        drain(phone, watch, link)
        assertEquals("Water 2L", watch.live().habits.single().name)
        assertEquals("Water 2L", phone.live().habits.single().name)
    }

    /**
     * An extreme account (25,000 logs a year; 15 years with PEER_EXTREME=1, one year otherwise) arrives part by part:
     * every part small, all of it merged, in time. Prints the numbers for the storage report.
     */
    @Test fun anExtremeAccountFillsInSmallCheckedParts() = runBlocking {
        val years = if (System.getenv("PEER_EXTREME") == "1") 15 else 1
        val wall = 1_790_000_000_000L
        val phone = Device("phone-x", null, true) { wall }
        val watch = Device("watch-x", null, true) { wall }
        val habits = (1..12).map { "habit-$it" }
        val perYear = 25_000
        val total = perYear * years
        val made = System.nanoTime()
        // Made a chunk at a time, so the test itself never holds 375,000 logs in memory.
        for (chunk in 0 until total step 25_000) {
            val logs = (chunk until minOf(total, chunk + 25_000)).map { i ->
                val day = java.time.LocalDate.of(2026, 10, 10).minusDays((i / (perYear / 365)).toLong())
                EntryRecord("entry-$i", habits[i % habits.size], null, day.toString(), 1.0, wall - i * 60_000L, "Europe/London", null, null, "today")
            }
            phone.repo.importAll(Snapshot(if (chunk == 0) habits.map { habit(it) } else emptyList(), emptyList(), emptyList(), logs, emptyList()))
        }
        val madeSeconds = (System.nanoTime() - made) / 1e9
        phone.repo.peerStart(); watch.repo.peerStart()
        val start = System.nanoTime()
        var cursor: String? = null
        var parts = 0
        var biggest = 0
        var sent = 0L
        val runtime = Runtime.getRuntime()
        var peakMemory = 0L
        do {
            val part = phone.repo.peerFillPart(cursor)
            biggest = maxOf(biggest, part.size); sent += part.size
            val receipt = watch.repo.acceptPeerFill(part.base64)
            peakMemory = maxOf(peakMemory, runtime.totalMemory() - runtime.freeMemory())
            cursor = receipt.next; parts++
        } while (cursor != null)
        val seconds = (System.nanoTime() - start) / 1e9
        val dbBytes = File(dir, "watch-x.db").length() + File(dir, "watch-x.db-wal").length()
        println("first fill: $total logs ($years years) in $parts parts, biggest part ${biggest / 1024} KB, " +
            "total ${sent / 1024 / 1024} MB, ${"%.1f".format(seconds)} s (made in ${"%.1f".format(madeSeconds)} s); " +
            "Watch database ${dbBytes / 1024 / 1024} MB; peak heap ${peakMemory / 1024 / 1024} MB")
        assertEquals(total, watch.live().entries.size)
        assertTrue(watch.repo.peerStatus().filled)
        assertTrue(biggest < 3 * 1024 * 1024, "every part stays small: $biggest bytes")
        // The first page of logs is the newest: today's state is right after the first parts.
        phone.close(); watch.close()
    }

    /** The Watch reads its last 400 days into memory, and every log of a quit habit or a task; the rest stays stored. */
    @Test fun theWatchReadsItsWindowAndEveryQuitAndTaskLog() = runBlocking {
        val repo = HabitRepository.openInMemory { 5_000L }
        repo.saveHabit(habit("water"), emptyList(), emptyList(), 1_000)
        repo.saveHabit(habit("smoke", kind = "quit", name = "No smoking"), emptyList(), emptyList(), 1_000)
        repo.saveHabit(habit("rent", kind = "task", name = "Pay rent"), emptyList(), emptyList(), 1_000)
        repo.addEntry(entry("old-water", "water", 1, day = "2020-01-01"))
        repo.addEntry(entry("new-water", "water", 2, day = "2026-10-10"))
        repo.addEntry(entry("old-slip", "smoke", 3, day = "2019-05-05"))
        repo.addEntry(entry("old-rent", "rent", 4, day = "2021-02-01"))
        val window = repo.loadSince("2025-09-06")
        assertEquals(listOf("new-water", "old-slip", "old-rent").sorted(), window.entries.map { it.id }.sorted())
        assertEquals(3, window.habits.size)
        assertEquals(4, repo.load().entries.size, "the database keeps every log")
        assertEquals(mapOf("water" to "2020-01-01", "smoke" to "2019-05-05", "rent" to "2021-02-01"), repo.oldestLogDays())
        repo.close()
    }
}
