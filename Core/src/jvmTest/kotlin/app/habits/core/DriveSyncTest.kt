package app.habits.core

import app.habits.sync.Op
import app.habits.sync.SyncRecord
import app.habits.sync.SyncRules
import kotlin.random.Random
import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertNotNull
import kotlin.test.assertTrue
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.JsonPrimitive

/**
 * Google Drive sync ([DriveSync]) against [FakeDrive]: 2–4 devices, each with its own database and clock, changing
 * things, going offline, saving at the same moment, losing uploads half-way, being reinstalled, and coming back after
 * months. Whatever happens: every device ends identical, identical to merging every change in any order; nothing lost,
 * nothing counted twice, nothing deleted comes back, and no version is ever saved after one its writer hadn't merged.
 */
class DriveSyncTest {

    inner class Device(val name: String, val drive: FakeDrive, private val skew: Long = 0, seed: Int = 0) {
        var incarnation = 1
        var client = drive.client("$name#1")
        var repo = HabitRepository.openInMemory { now() + skew }
        val pauses = mutableListOf<Long>()
        private val random = Random(seed)
        var sync = make()
        /** Outbox position up to which this device's own changes were collected. */
        var captured = 0L
        var lastStatus: DriveStatus? = null
        val everDeleted = mutableSetOf<String>()

        private fun make() = DriveSync(repo, client, name, "android", clock = { now() + skew }, pause = { pauses += it }, random = random)

        fun connect() = runBlocking<Unit> { sync.connect("gdrive:test") }

        fun syncNow(allowUpload: Boolean = true): DriveStatus = runBlocking { sync.syncNow(allowUpload) }.also { lastStatus = it }

        /** Every change this device made since the last call, as the ops it queued. */
        fun collect(into: MutableList<Op>) = runBlocking<Unit> {
            val rows = repo.drive.opsAfter(captured)
            rows.forEach { row -> SyncRules.decodeOp(row.op)?.let(into::add) }
            rows.lastOrNull()?.let { captured = it.seq }
        }

        /** Uninstalled and installed again: an empty database, a new clock node, connected to the same Drive. */
        fun reinstall(): Set<String> = runBlocking {
            val unsent = repo.drive.opsAfter(0).map { it.opId }.toSet()
            repo.eraseAllData()
            incarnation++
            client = drive.client("$name#$incarnation").also { it.listLag = client.listLag }
            sync = make()
            captured = 0
            everDeleted.clear()
            sync.connect("gdrive:test")
            unsent
        }

        fun records(): Map<String, SyncRecord> = runBlocking { repo.drive.allRecords() }
        fun live(): Snapshot = runBlocking { repo.load() }
        fun waiting(): Int = runBlocking { repo.cloud.counts().waitingOps }
    }

    private var clockNow = 1_790_000_000_000L
    private fun now() = clockNow

    private fun habit(id: String, name: String = "Water", color: String = "blue", kind: String = "amount") = HabitRecord(
        id = id, name = name, symbol = "drop.fill", color = color, kind = kind, unit = "glasses", increment = 1.0,
        part = "anytime", goal = 8.0, period = "day", scheduleDays = null, frequency = "daily", dueDay = null, dueMinute = null,
        atMost = false, quitSince = null, position = 0, createdAt = 1_000, updatedAt = 1_000, archivedAt = null, deletedAt = null,
    )

    private fun entry(id: String, habitId: String, at: Long, value: Double = 1.0, day: String = "2026-10-10", source: String = "today") =
        EntryRecord(id, habitId, null, day, value, at, "Europe/London", null, null, source)

    private fun devices(n: Int, drive: FakeDrive = FakeDrive()): List<Device> = List(n) { Device("d$it", drive).also(Device::connect) }

    /** Everyone syncs until nothing waits anywhere, then once more so the last save reaches everyone. */
    private fun settle(devices: List<Device>) {
        repeat(30) {
            devices.forEach { d ->
                val status = d.syncNow()
                if (status.state == DriveState.HELD) runBlocking { d.sync.applyHeldDeletes() }
                if (status.state == DriveState.DELETES_WAITING) runBlocking { d.sync.sendWaitingDeletes() }
            }
            if (devices.all { it.waiting() == 0 }) {
                devices.forEach { it.syncNow() }
                return
            }
        }
        error("sync never settled: " + devices.joinToString { "${it.name} ${it.lastStatus}" })
    }

    private fun assertSame(devices: List<Device>, why: String) {
        val first = devices.first().records()
        devices.drop(1).forEach { assertEquals(first, it.records(), "$why: ${it.name} differs from ${devices.first().name}") }
    }

    private fun liveLogs(d: Device, habit: String) = d.live().entries.filter { it.habitId == habit && it.deletedAt == null }

    // MARK: The user's examples

    @Test fun offlinePhoneTwoGlassesAndTabletOneMakeThree() = runBlocking<Unit> {
        val (phone, tablet) = devices(2)
        phone.repo.saveHabit(habit("water"), emptyList(), emptyList(), now())
        phone.syncNow(); tablet.syncNow()
        phone.client.offline = true
        phone.repo.addEntry(entry("p1", "water", now()))
        phone.repo.addEntry(entry("p2", "water", now()))
        assertEquals(DriveState.OFFLINE, phone.syncNow().state)
        assertEquals(2, phone.syncNow().waiting, "the phone's two glasses wait, saved on the phone")
        tablet.repo.addEntry(entry("t1", "water", now()))
        tablet.syncNow()
        phone.client.offline = false
        settle(listOf(phone, tablet))
        assertEquals(3, liveLogs(phone, "water").size)
        assertEquals(3, liveLogs(tablet, "water").size)
        assertSame(listOf(phone, tablet), "two glasses + one")
    }

    @Test fun renameOnOneAndColourOnTheOtherKeepsBoth() = runBlocking<Unit> {
        val (phone, tablet) = devices(2)
        phone.repo.saveHabit(habit("water"), emptyList(), emptyList(), now())
        settle(listOf(phone, tablet))
        clockNow += 1_000
        phone.repo.saveHabit(habit("water", name = "Drink water"), emptyList(), emptyList(), now())
        tablet.repo.saveHabit(habit("water", color = "teal"), emptyList(), emptyList(), now())
        settle(listOf(phone, tablet))
        listOf(phone, tablet).forEach { d ->
            val h = d.live().habits.single()
            assertEquals("Drink water", h.name, d.name)
            assertEquals("teal", h.color, d.name)
        }
    }

    @Test fun aDeleteBeatsAnOfflineLogAndTheLogIsKept() = runBlocking<Unit> {
        val (phone, tablet) = devices(2)
        phone.repo.saveHabit(habit("water"), emptyList(), emptyList(), now())
        settle(listOf(phone, tablet))
        phone.client.offline = true
        clockNow += 1_000
        tablet.repo.saveHabit(habit("water").copy(deletedAt = now()), emptyList(), emptyList(), now())
        tablet.syncNow()
        clockNow += 1_000
        phone.repo.addEntry(entry("late", "water", now())) // later than the delete, on a phone that hasn't seen it
        phone.client.offline = false
        settle(listOf(phone, tablet))
        listOf(phone, tablet).forEach { d ->
            assertTrue(d.live().habits.isEmpty(), "${d.name}: the habit stays deleted")
            assertEquals(listOf("late"), runBlocking { d.repo.loadForRestore() }.entries.filter { it.deletedAt == null }.map { it.id }, "${d.name}: the log is kept for the undo")
        }
        assertSame(listOf(phone, tablet), "delete vs log")
    }

    @Test fun aStaleDeviceCannotReplaceNewerWork() = runBlocking<Unit> {
        val drive = FakeDrive()
        val phone = Device("phone", drive).also(Device::connect)
        val mac = Device("mac", drive, skew = -3 * 86_400_000L).also(Device::connect) // its clock is days behind too
        phone.repo.saveHabit(habit("water"), emptyList(), emptyList(), now())
        settle(listOf(phone, mac))
        mac.client.offline = true
        // Days of work on the phone while the Mac is shut.
        repeat(5) { day ->
            clockNow += 86_400_000L
            phone.repo.saveHabit(habit("water", name = "Water $day"), emptyList(), emptyList(), now())
            phone.repo.addEntry(entry("p$day", "water", now(), day = "2026-10-1$day"))
            phone.syncNow()
        }
        // The Mac opens with its old copy and changes something else.
        mac.repo.saveSetting("week_start", "2")
        mac.client.offline = false
        settle(listOf(phone, mac))
        listOf(phone, mac).forEach { d ->
            assertEquals("Water 4", d.live().habits.single().name, "${d.name}: the newer name stays")
            assertEquals(5, liveLogs(d, "water").size)
            assertEquals("2", d.live().settings.single { it.key == "week_start" }.value)
        }
    }

    @Test fun theSameTapTwiceCountsOnce() = runBlocking<Unit> {
        val (phone, watch) = devices(2)
        phone.repo.saveHabit(habit("water"), emptyList(), emptyList(), now())
        settle(listOf(phone, watch))
        val tap = entry("tap-1", "water", now())
        phone.repo.addEntry(tap)
        phone.repo.addEntry(tap) // a retry
        watch.repo.addEntry(tap) // the same tap, delivered to the other device too
        settle(listOf(phone, watch))
        assertEquals(1, liveLogs(phone, "water").size)
        assertSame(listOf(phone, watch), "same tap")
    }

    @Test fun aTimerStoppedOnTwoDevicesIsOneLog() = runBlocking<Unit> {
        val (phone, tablet) = devices(2)
        phone.repo.saveHabit(habit("read", kind = "duration"), emptyList(), emptyList(), now())
        val start = now()
        phone.repo.saveSetting("timer.read", start.toString())
        settle(listOf(phone, tablet))
        phone.client.offline = true
        tablet.client.offline = true
        val id = TimerStop.entryId("read", start)
        clockNow += 600_000
        phone.repo.finishTimer(entry(id, "read", now(), value = 10.0, source = "timer"), "timer.read")
        clockNow += 60_000
        tablet.repo.finishTimer(entry(id, "read", now(), value = 11.0, source = "timer"), "timer.read")
        phone.client.offline = false
        tablet.client.offline = false
        settle(listOf(phone, tablet))
        listOf(phone, tablet).forEach { d ->
            val logs = liveLogs(d, "read")
            assertEquals(1, logs.size, d.name)
            assertEquals(11.0, logs.single().value, "${d.name}: the later stop's minutes win")
            assertTrue(d.live().settings.none { it.key == "timer.read" }, "${d.name}: the timer stopped")
        }
    }

    // MARK: The version chain

    @Test fun simultaneousSavesNeverOverwriteEachOther() {
        var conflicts = 0
        repeat(60) { seed ->
            val drive = FakeDrive(Random(seed)).apply { turns = Turns(Random(seed)) }
            val ds = List(3) { Device("d$it", drive, seed = seed).also(Device::connect) }
            runBlocking { ds[0].repo.saveHabit(habit("water"), emptyList(), emptyList(), now()) }
            drive.turns!!.all(listOf(suspend { ds[0].sync.syncNow() }))
            // Everyone logs, then everyone saves at once.
            ds.forEachIndexed { i, d -> runBlocking { d.repo.addEntry(entry("e$i-$seed", "water", now())) } }
            drive.turns!!.all(ds.map { d -> suspend { d.sync.syncNow() } }).forEach { it.getOrThrow() }
            drive.turns = null
            settle(ds)
            assertSame(ds, "seed $seed")
            assertEquals(3, liveLogs(ds[0], "water").size, "seed $seed")
            conflicts += drive.log.count { it is FakeDrive.Event.Conflict }
            checkChains(drive, "seed $seed")
        }
        assertTrue(conflicts > 0, "the race happened (409s: $conflicts)")
        println("drive race: $conflicts saves refused with 409 in 60 seeded races, every one merged and saved after")
    }

    @Test fun twoFirstVersionsAreBothKeptAndTidiedLater() {
        val drive = FakeDrive(Random(7)).apply { turns = Turns(Random(7)) }
        val (a, b) = List(2) { Device("d$it", drive, seed = it).also(Device::connect) }
        runBlocking {
            a.repo.saveHabit(habit("a"), emptyList(), emptyList(), now())
            b.repo.saveHabit(habit("b"), emptyList(), emptyList(), now())
        }
        // Both start the base file at the same moment: two first versions.
        drive.turns!!.all(listOf(suspend { a.sync.syncNow() }, suspend { b.sync.syncNow() }))
        drive.turns = null
        settle(listOf(a, b))
        assertEquals(setOf("a", "b"), a.live().habits.map { it.id }.toSet())
        assertSame(listOf(a, b), "two first versions")
        // More saves: the second line is taken in and goes.
        repeat(6) { i ->
            clockNow += 1_000
            runBlocking { a.repo.saveSetting("week_start", "${i % 7 + 1}") }
            settle(listOf(a, b))
        }
        val base = drive.versions(DriveStore.BASE)
        assertTrue(base.size <= DriveSync.KEEP_VERSIONS + 1, "old versions tidied: ${base.size} left")
        assertEquals(1, DriveSync.Listing(drive.versions()).heads(DriveStore.BASE).size, "one line left")
        checkChains(drive, "two first versions")
    }

    @Test fun aDeviceFarBehindSavesAfterVersionsThatWereTidiedAway() = runBlocking<Unit> {
        val drive = FakeDrive()
        val (phone, mac) = List(2) { Device("d$it", drive).also(Device::connect) }
        phone.repo.saveHabit(habit("water"), emptyList(), emptyList(), now())
        settle(listOf(phone, mac))
        // The Mac lists, and stops before saving (its listing goes stale).
        val stale = DriveSync.Listing(drive.versions()).canonical(DriveStore.BASE)!!
        // Meanwhile the phone saves five more versions and tidies the oldest away, the Mac's head's successor too.
        repeat(5) { i -> clockNow += 1_000; phone.repo.saveSetting("week_start", "${i + 1}"); phone.syncNow() }
        assertEquals(null, drive.files[stale.next], "the Mac's next ID was used, then deleted")
        // The Mac saves after its stale head: Drive refuses the used ID with 400; the Mac lists again and saves after the newest.
        mac.repo.saveSetting("daynote.2026-10-11", "from the Mac")
        var staleOnce = true
        val lagging = object : DriveApi by mac.client {
            override suspend fun list(): List<DriveFile> = if (staleOnce) { staleOnce = false; listOf(stale.file) } else mac.client.list()
        }
        mac.sync = DriveSync(mac.repo, lagging, mac.name, "android", clock = { now() }, pause = {})
        val status = mac.syncNow()
        assertEquals(DriveState.SYNCED, status.state, status.problem ?: "")
        assertEquals(0, status.waiting)
        settle(listOf(phone, mac))
        assertSame(listOf(phone, mac), "far behind")
        assertEquals("from the Mac", phone.live().settings.single { it.key == "daynote.2026-10-11" }.value)
        checkChains(drive, "far behind")
    }

    @Test fun aFreshInstallDownloadsBeforeItSendsAnything() = runBlocking<Unit> {
        val drive = FakeDrive()
        val phone = Device("phone", drive).also(Device::connect)
        phone.repo.saveHabit(habit("water"), emptyList(), emptyList(), now())
        repeat(5) { phone.repo.addEntry(entry("e$it", "water", now())) }
        phone.syncNow()
        val before = drive.versions().map { it.id }.toSet()
        val fresh = Device("fresh", drive).also(Device::connect)
        val status = fresh.syncNow(allowUpload = false)
        assertEquals(DriveState.PAUSED, status.state)
        assertEquals(5, liveLogs(fresh, "water").size, "everything came down")
        assertEquals(before, drive.versions().map { it.id }.toSet(), "nothing went up")
        assertEquals(0, fresh.client.let { c -> drive.log.count { it is FakeDrive.Event.Created && it.by == c.name } })
        // Its welcome finished: it still has nothing of its own to send.
        fresh.syncNow()
        assertEquals(before, drive.versions().map { it.id }.toSet())
    }

    @Test fun aDeviceWithDataJoiningMergesFirst() = runBlocking<Unit> {
        val drive = FakeDrive()
        val phone = Device("phone", drive).also(Device::connect)
        phone.repo.saveHabit(habit("water"), emptyList(), emptyList(), now())
        phone.repo.addEntry(entry("p", "water", now()))
        phone.syncNow()
        // A tablet that had its own data before turning Drive sync on.
        val tablet = Device("tablet", drive)
        tablet.repo.saveHabit(habit("read"), emptyList(), emptyList(), now())
        tablet.repo.addEntry(entry("t", "read", now()))
        tablet.connect()
        settle(listOf(phone, tablet))
        assertEquals(setOf("water", "read"), phone.live().habits.map { it.id }.toSet())
        assertSame(listOf(phone, tablet), "joining")
        checkChains(drive, "joining")
    }

    // MARK: Safety: never shrink, the brake

    @Test fun neverSavesAVersionSmallerThanTheOneBefore() = runBlocking<Unit> {
        val (phone, tablet) = devices(2)
        phone.repo.saveHabit(habit("water"), emptyList(), emptyList(), now())
        repeat(10) { phone.repo.addEntry(entry("e$it", "water", now())) }
        settle(listOf(phone, tablet))
        val head = DriveSync.Listing(phone.drive.versions()).canonical("2026")!!
        // A bug loses two rows on the tablet without a delete; then the tablet logs something.
        tablet.repo.drive.loseRowForTest("entry", "e3")
        tablet.repo.drive.loseRowForTest("entry", "e4")
        tablet.repo.addEntry(entry("new", "water", now()))
        val status = tablet.syncNow()
        assertEquals(DriveState.PROBLEM, status.state)
        assertEquals("shrink:2026", status.problem)
        assertEquals(head.id, DriveSync.Listing(phone.drive.versions()).canonical("2026")!!.id, "nothing saved after the larger version")
        assertEquals(1, status.waiting, "the new log waits, kept")
    }

    @Test fun incomingDeletesPastTheBrakeWaitForThePerson() = runBlocking<Unit> {
        val (phone, tablet) = devices(2)
        phone.repo.saveHabit(habit("water"), emptyList(), emptyList(), now())
        repeat(40) { phone.repo.addEntry(entry("e$it", "water", now())) }
        settle(listOf(phone, tablet))
        clockNow += 1_000
        repeat(30) { phone.repo.removeEntry("e$it", now()) }
        assertEquals(DriveState.DELETES_WAITING, phone.syncNow().state, "30 of 41 at once: the phone asks first")
        runBlocking { phone.sync.sendWaitingDeletes() }
        assertEquals(0, phone.waiting())
        val held = tablet.syncNow()
        assertEquals(DriveState.HELD, held.state)
        assertEquals(30, held.heldDeletes)
        assertEquals(40, liveLogs(tablet, "water").size, "nothing applied while held")
        tablet.repo.addEntry(entry("t", "water", now()))
        assertEquals(DriveState.HELD, tablet.syncNow().state, "and nothing sent")
        val applied = runBlocking { tablet.sync.applyHeldDeletes() }
        assertEquals(DriveState.SYNCED, applied.state)
        assertEquals(11, liveLogs(tablet, "water").size)
        settle(listOf(phone, tablet))
        assertSame(listOf(phone, tablet), "after the brake")
    }

    @Test fun aFewDeletesGoStraightThrough() = runBlocking<Unit> {
        val (phone, tablet) = devices(2)
        phone.repo.saveHabit(habit("water"), emptyList(), emptyList(), now())
        repeat(40) { phone.repo.addEntry(entry("e$it", "water", now())) }
        settle(listOf(phone, tablet))
        repeat(5) { phone.repo.removeEntry("e$it", now()) }
        assertEquals(DriveState.SYNCED, phone.syncNow().state)
        assertEquals(DriveState.SYNCED, tablet.syncNow().state)
        assertEquals(35, liveLogs(tablet, "water").size)
    }

    // MARK: Failures become states, and nothing is lost

    @Test fun errorsAreStatesTheAppCanShow() = runBlocking<Unit> {
        val (phone) = devices(1)
        phone.repo.saveHabit(habit("water"), emptyList(), emptyList(), now())
        phone.client.faults += FakeDrive.Fault.Answer { DriveError.NotConnected("invalid_grant") }
        assertEquals(DriveState.NOT_CONNECTED, phone.syncNow().state)
        phone.drive.fullQuota = true
        val full = phone.syncNow()
        assertEquals(DriveState.FULL, full.state)
        assertTrue(full.waiting > 0, "nothing lost while Drive is full")
        phone.drive.fullQuota = false
        repeat(3) { phone.client.faults += FakeDrive.Fault.Answer { DriveError.RateLimited(null) } }
        assertEquals(DriveState.SYNCED, phone.syncNow().state, "rate limits are retried")
        assertEquals(3, phone.pauses.size)
        assertTrue(phone.pauses[0] in 1_000..2_000 && phone.pauses[1] in 2_000..3_000 && phone.pauses[2] in 4_000..5_000, "exponential, with jitter: ${phone.pauses}")
        phone.pauses.clear()
        phone.client.faults += FakeDrive.Fault.Answer { DriveError.RateLimited(20_000) }
        phone.syncNow()
        assertEquals(listOf(20_000L), phone.pauses, "Retry-After is respected")
        repeat(10) { phone.client.faults += FakeDrive.Fault.Answer { DriveError.ServerError(503) } }
        assertEquals(DriveState.BUSY, phone.syncNow().state, "after several tries: try again later")
        phone.client.faults.clear()
        assertEquals(DriveState.SYNCED, phone.syncNow().state)
        assertEquals(0, phone.waiting())
    }

    @Test fun anUploadCutOffEitherSideIsSavedOnce() = runBlocking<Unit> {
        for (fault in listOf(FakeDrive.Fault.CutBefore, FakeDrive.Fault.CutAfter, FakeDrive.Fault.Kill)) {
            val (phone, tablet) = devices(2)
            phone.repo.saveHabit(habit("water"), emptyList(), emptyList(), now())
            settle(listOf(phone, tablet))
            phone.repo.addEntry(entry("cut", "water", now()))
            phone.client.createFaults += fault
            runCatching { phone.syncNow() } // a killed app's sync never returns
            assertEquals(1, phone.waiting(), "$fault: the log still waits")
            settle(listOf(phone, tablet))
            assertEquals(1, liveLogs(tablet, "water").size, "$fault: saved once")
            assertSame(listOf(phone, tablet), "$fault")
            checkChains(phone.drive, "$fault")
        }
    }

    @Test fun aDamagedFileIsHealed() = runBlocking<Unit> {
        val (phone, tablet) = devices(2)
        phone.repo.saveHabit(habit("water"), emptyList(), emptyList(), now())
        settle(listOf(phone, tablet))
        phone.repo.addEntry(entry("x", "water", now()))
        phone.client.createFaults += FakeDrive.Fault.StoreDamaged
        val status = phone.syncNow()
        assertEquals(DriveState.PROBLEM, status.state)
        assertEquals("checksum:2026", status.problem)
        assertEquals(1, status.waiting, "not confirmed")
        // The tablet meets the damaged version first: it reads what it can and goes on.
        tablet.syncNow()
        settle(listOf(phone, tablet))
        assertEquals(1, liveLogs(tablet, "water").size)
        assertSame(listOf(phone, tablet), "damaged")
    }

    @Test fun aFileFromANewerAppIsNeverWrittenOver() = runBlocking<Unit> {
        val (phone, tablet) = devices(2)
        phone.repo.saveHabit(habit("water"), emptyList(), emptyList(), now())
        settle(listOf(phone, tablet))
        // A newer app saves the base file in a layout this one can't read.
        val head = DriveSync.Listing(phone.drive.versions()).canonical(DriveStore.BASE)!!
        val newer = Zip.write(listOf(Zip.Entry(DriveSnapshot.MANIFEST, """{"kind":"often-enough-drive","format":2}""".encodeToByteArray())), now())
        val next = phone.client.generateIds(1).single()
        phone.client.create(head.next, "often-enough-base-future", head.file.properties + mapOf("seq" to "${head.seq + 1}", "next" to next, "prev" to head.id, "fmt" to "2"), newer)
        tablet.repo.saveSetting("week_start", "3")
        val status = tablet.syncNow()
        assertEquals(DriveState.UPDATE_NEEDED, status.state)
        assertEquals(1, status.waiting, "kept until the app can write the file whole")
        assertEquals(null, phone.drive.files[next], "nothing saved after the newer version")
    }

    // MARK: Status and cost

    @Test fun eachDeviceSeesTheOthersLastCheckIn() = runBlocking<Unit> {
        val drive = FakeDrive()
        val phone = Device("Pixel 8", drive).also(Device::connect)
        val tablet = Device("Galaxy Tab", drive).also(Device::connect)
        phone.repo.saveHabit(habit("water"), emptyList(), emptyList(), now())
        phone.syncNow()
        val at = now()
        tablet.syncNow()
        clockNow += 60_000
        val status = phone.syncNow()
        val other = status.devices.single { !it.thisDevice }
        assertEquals("Galaxy Tab", other.name)
        assertEquals(at, other.lastCheckIn)
        assertNotNull(status.devices.single { it.thisDevice }.lastSent)
    }

    @Test fun aRoundWithNothingToDoIsOneCall() = runBlocking<Unit> {
        val (phone, tablet) = devices(2)
        phone.repo.saveHabit(habit("water"), emptyList(), emptyList(), now())
        repeat(20) { phone.repo.addEntry(entry("e$it", "water", now())) }
        settle(listOf(phone, tablet))
        clockNow += 60_000
        val before = tablet.client.callsMade
        assertEquals(DriveState.SYNCED, tablet.syncNow().state)
        assertEquals(1, tablet.client.callsMade - before, "one list call, nothing downloaded, nothing written")
        clockNow += DriveSync.CHECK_IN_EVERY
        val again = tablet.client.callsMade
        tablet.syncNow()
        assertEquals(2, tablet.client.callsMade - again, "a list and the device's check-in, every 15 minutes")
        println("drive idle round: 1 call (2 once every ${DriveSync.CHECK_IN_EVERY / 60_000} minutes)")
    }

    @Test fun logsGoToTheirYearsFile() = runBlocking<Unit> {
        val (phone, tablet) = devices(2)
        phone.repo.saveHabit(habit("water"), emptyList(), emptyList(), now())
        phone.repo.addEntry(entry("old", "water", now(), day = "2024-12-31"))
        phone.repo.addEntry(entry("new", "water", now(), day = "2026-01-01"))
        settle(listOf(phone, tablet))
        assertEquals(setOf("base", "2024", "2026"), phone.drive.versions().map { it.properties["chain"] }.toSet())
        // A new log this year saves only this year's file.
        val before = phone.drive.versions().map { it.id }.toSet()
        phone.repo.addEntry(entry("newer", "water", now(), day = "2026-01-02"))
        phone.syncNow()
        val added = phone.drive.versions().filter { it.id !in before }
        assertEquals(listOf("2026"), added.map { it.properties["chain"] })
    }

    // MARK: Thousands of seeded runs

    /**
     * One seeded run: 2–4 devices with clocks up to a day apart; random logs (around New Year, so two year files),
     * undos, renames, colours, settings, the same tap on two devices, a timer stopped on two devices; random offline
     * spells and months away; list lag; uploads cut off before and after Drive kept them; files stored damaged; rate
     * limits and server errors; the app killed mid-call; reinstalls; forgotten "seen" marks (downloads repeated); and
     * devices saving at the same moment, interleaved call by call.
     */
    private fun randomRun(seed: Int, steps: Int) {
        val random = Random(seed)
        val drive = FakeDrive(Random(seed))
        val n = random.nextInt(2, 5)
        val ds = List(n) { Device("d$it", drive, skew = random.nextLong(-86_400_000, 86_400_000), seed = seed * 7 + it).also(Device::connect) }
        val ops = mutableListOf<Op>()
        val maybeLost = mutableSetOf<String>()
        val habits = listOf("h1", "h2", "h3")
        runBlocking { habits.forEach { ds[0].repo.saveHabit(habit(it), emptyList(), emptyList(), now()) } }
        ds[0].collect(ops)
        ds[0].syncNow()
        val days = listOf("2025-12-30", "2025-12-31", "2026-01-01", "2026-01-02")
        var reinstalls = 0

        fun checkDeletesStay(why: String) = ds.forEach { d ->
            val records = d.records()
            for (key in d.everDeleted) assertTrue(records[key]?.isDeleted != false, "seed $seed $why: ${d.name}: $key came back")
            records.filterValues { it.isDeleted }.keys.forEach { d.everDeleted += it }
        }

        repeat(steps) { step ->
            clockNow += if (random.nextInt(50) == 0) 90L * 86_400_000 else random.nextLong(1, 600_000) // sometimes months pass
            drive.tick++
            val d = ds.random(random)
            runBlocking {
                when (random.nextInt(24)) {
                    0, 1, 2, 3, 4 -> d.repo.addEntry(entry("${d.name}-$step", habits.random(random), now(), day = days.random(random), value = random.nextInt(1, 4).toDouble()))
                    5 -> d.live().entries.randomOrNull(random)?.let { d.repo.removeEntry(it.id, now()) }
                    6 -> d.live().habits.randomOrNull(random)?.let { d.repo.saveHabit(it.copy(name = "${d.name} $step"), emptyList(), emptyList(), now()) }
                    7 -> d.live().habits.randomOrNull(random)?.let { d.repo.saveHabit(it.copy(color = listOf("red", "teal", "blue").random(random)), emptyList(), emptyList(), now()) }
                    8 -> d.repo.saveSetting(listOf("week_start", "daynote.2026-01-01", "skip.h1").random(random), "v$step")
                    9 -> {
                        // The same tap reaching two devices.
                        val tap = entry("tap-$step", habits.random(random), now(), day = days.random(random))
                        d.repo.addEntry(tap)
                        val other = ds.random(random)
                        other.repo.addEntry(tap)
                        other.collect(ops)
                    }
                    10 -> {
                        // One timer stopped on two devices.
                        val h = habits.random(random)
                        val start = now() - 600_000
                        val id = TimerStop.entryId(h, start)
                        d.repo.finishTimer(entry(id, h, now(), value = 10.0, source = "timer", day = "2026-01-01"), "timer.$h")
                        val other = ds.random(random)
                        other.repo.finishTimer(entry(id, h, now() + 1, value = 11.0, source = "timer", day = "2026-01-01"), "timer.$h")
                        other.collect(ops)
                    }
                    11, 12 -> d.client.offline = !d.client.offline
                    13 -> if (random.nextInt(4) == 0 && reinstalls < 2) {
                        reinstalls++
                        maybeLost += d.reinstall()
                    }
                    14 -> when (random.nextInt(7)) {
                        0 -> d.client.createFaults += FakeDrive.Fault.CutBefore
                        1 -> d.client.createFaults += FakeDrive.Fault.CutAfter
                        2 -> d.client.createFaults += FakeDrive.Fault.StoreDamaged
                        3 -> d.client.createFaults += FakeDrive.Fault.Kill
                        4 -> d.client.faults += FakeDrive.Fault.Kill
                        5 -> d.client.faults += FakeDrive.Fault.Answer { DriveError.RateLimited(null) }
                        else -> d.client.faults += FakeDrive.Fault.Answer { DriveError.ServerError(503) }
                    }
                    15 -> d.client.listLag = random.nextLong(0, 4)
                    16 -> d.repo.drive.forget() // what it merged is forgotten: every newest version comes again
                    else -> {
                        // Some devices sync at the same moment.
                        val group = ds.filter { random.nextBoolean() }.ifEmpty { listOf(d) }
                        drive.turns = Turns(Random(seed * 1_000 + step))
                        val results = drive.turns!!.all(group.map { g -> suspend { g.sync.syncNow() } })
                        drive.turns = null
                        results.forEach { r -> r.exceptionOrNull()?.let { if (it !is FakeDrive.Killed) throw it } }
                        results.mapNotNull { it.getOrNull() }.forEach { s -> assertTrue(s.problem?.startsWith("shrink") != true, "seed $seed: never-shrink fired wrongly") }
                        checkDeletesStay("step $step")
                    }
                }
                Unit
            }
            d.collect(ops)
        }

        // Back online, no more faults: everyone syncs until settled.
        ds.forEach { it.client.offline = false; it.client.faults.clear(); it.client.createFaults.clear(); it.client.listLag = 0 }
        drive.tick += 100
        settle(ds)
        assertSame(ds, "seed $seed")
        checkDeletesStay("end")
        checkChains(drive, "seed $seed")

        // Identical to merging every change, in any order.
        val final = ds.first().records()
        val all = ops.shuffled(random)
        val full = mergeAll(all)
        if (maybeLost.isEmpty()) {
            assertEquals(full.keys, final.keys, "seed $seed: the same records")
            for ((key, record) in full) assertEquals(normal(record), normal(final.getValue(key)), "seed $seed: $key")
        } else {
            // A reinstall loses only what that device hadn't sent yet.
            val kept = mergeAll(all.filter { it.id !in maybeLost })
            for ((key, record) in kept) {
                val have = final[key] ?: error("seed $seed: $key lost")
                assertEquals(normal(have), normal(SyncRules.mergeRecord(have, record)), "seed $seed: $key lost a change")
            }
            assertTrue(full.keys.containsAll(final.keys), "seed $seed: a record nobody made")
        }
        // Each timer stopped is one log; each tap is one log.
        val logs = ds.first().live().entries
        assertEquals(logs.map { it.id }.toSet().size, logs.size)
    }

    private fun mergeAll(ops: List<Op>): Map<String, SyncRecord> {
        val merged = mutableMapOf<String, SyncRecord>()
        for (op in ops) {
            if (op.table == "setting" && SyncCodec.isLocalSetting(op.row)) continue
            val key = "${op.table}:${op.row}"
            merged[key] = SyncRules.merge(merged[key], op)
        }
        return merged
    }

    /** Numbers as the database keeps them (1 and 1.0 are the same value). */
    private fun normal(record: SyncRecord) = record.fields.mapValues { (_, v) -> (v as? JsonPrimitive)?.let { p -> if (p.isString) p.content else p.content.toDoubleOrNull()?.toString() ?: p.content } } to record.clocks

    /**
     * The version chain's safety, from every version ever saved: each was saved after a version its writer had
     * downloaded or saved itself, and holds everything the version before it held (merging that one in changes nothing).
     */
    private fun checkChains(drive: FakeDrive, why: String) {
        val known = mutableMapOf<String, MutableSet<String>>()
        for (event in drive.log) {
            when (event) {
                is FakeDrive.Event.Downloaded -> known.getOrPut(event.by) { mutableSetOf() } += event.id
                is FakeDrive.Event.Created -> {
                    if (event.prev.isNotEmpty()) {
                        assertTrue(event.prev in known[event.by].orEmpty(), "$why: ${event.by} saved ${event.id} after ${event.prev} without merging it")
                    }
                    known.getOrPut(event.by) { mutableSetOf() } += event.id
                }
                is FakeDrive.Event.Conflict -> Unit
            }
        }
        for ((id, stored) in drive.history) {
            val prev = stored.file.properties["prev"].orEmpty()
            val before = drive.history[prev] ?: continue
            val after = runCatching { DriveSnapshot.read(stored.content) }.getOrNull() ?: continue
            val earlier = runCatching { DriveSnapshot.read(before.content) }.getOrNull() ?: continue
            val rows = after.rows.associate { "${it.table}:${it.row}" to it.record }
            for (row in earlier.rows) {
                val now = rows["${row.table}:${row.row}"] ?: error("$why: $id dropped ${row.table}:${row.row} that $prev held")
                // Holds it: merging the older version's record changes nothing (a delete can carry an older stamp and still win).
                assertEquals(now, SyncRules.mergeRecord(now, row.record), "$why: $id lacks part of ${row.row} that $prev held")
            }
        }
    }

    private val seeds = System.getenv("DRIVE_SEEDS")?.toIntOrNull() ?: 150

    @Test fun thousandsOfRandomRunsConverge() {
        val started = System.nanoTime()
        repeat(seeds) { randomRun(it, steps = 60) }
        println("drive property test: $seeds seeded runs (2–4 devices, 60 steps) converged in ${(System.nanoTime() - started) / 1_000_000} ms")
    }
}
