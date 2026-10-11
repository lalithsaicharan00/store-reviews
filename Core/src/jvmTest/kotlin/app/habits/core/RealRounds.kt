package app.habits.core

import app.habits.sync.SyncRecord
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.async
import kotlinx.coroutines.awaitAll
import kotlinx.coroutines.coroutineScope

/**
 * Full sync rounds on the real Google Drive (stage 2, check 2): three devices, each its own database, its own HTTP
 * client and its own access token, through [DriveSync] exactly as the apps will run it. Scenarios: offline then sync,
 * saves at the same moment, an upload cut off before and after Drive kept it, a reinstall, the brake, two year files,
 * and many devices on one file. After each, every device must hold the same records, and the folder is printed.
 */
class RealRounds {
    /** The real Drive with a switch for "offline", uploads cut off on purpose, and every call counted. */
    class Faulty(private val inner: DriveApi) : DriveApi {
        var offline = false
        var cutBefore = 0
        var cutAfter = 0
        val calls = mutableMapOf<String, Int>()
        var conflicts = 0

        private fun count(name: String) {
            synchronized(calls) { calls[name] = (calls[name] ?: 0) + 1 }
            if (offline) throw DriveError.Offline()
        }

        override suspend fun list() = count("list").let { inner.list() }
        override suspend fun get(id: String) = count("get").let { inner.get(id) }
        override suspend fun generateIds(count: Int) = count("generateIds").let { inner.generateIds(count) }
        override suspend fun create(id: String, name: String, properties: Map<String, String>, content: ByteArray): DriveFile {
            count("create")
            if (cutBefore > 0) { cutBefore--; throw DriveError.Offline() }
            val file = try { inner.create(id, name, properties, content) } catch (e: DriveError.Conflict) { conflicts++; throw e }
            if (cutAfter > 0) { cutAfter--; throw DriveError.Offline() }
            return file
        }
        override suspend fun updateProperties(id: String, properties: Map<String, String>) = count("update").let { inner.updateProperties(id, properties) }
        override suspend fun download(id: String) = count("download").let { inner.download(id) }
        override suspend fun delete(id: String) = count("delete").let { inner.delete(id) }
        override suspend fun quota() = count("quota").let { inner.quota() }
        fun total() = synchronized(calls) { calls.values.sum() }
    }

    inner class Device(val name: String) {
        val drive = Faulty(RealDrive.drive())
        var repo = HabitRepository.openInMemory()
        var sync = DriveSync(repo, drive, name, "android")
        suspend fun connect() = sync.connect("gdrive:real-test")
        suspend fun syncNow(allowUpload: Boolean = true) = sync.syncNow(allowUpload)
        suspend fun records(): Map<String, SyncRecord> = repo.drive.allRecords()
        suspend fun logs(habit: String) = repo.load().entries.count { it.habitId == habit && it.deletedAt == null }
        suspend fun reinstall() {
            repo.eraseAllData()
            sync = DriveSync(repo, drive, name, "android")
            connect()
        }
    }

    private val failures = mutableListOf<String>()

    private fun check(ok: Boolean, what: String) {
        println(if (ok) "  ok: $what" else "  FAILED: $what")
        if (!ok) failures += what
    }

    private fun habit(id: String, name: String = "Water") = HabitRecord(
        id, name, "drop.fill", "blue", "amount", "glasses", 1.0, "anytime", 8.0, "day", null, "daily", null, null, false, null, 0,
        1_000, 1_000, null, null,
    )

    private fun entry(id: String, habit: String, day: String = "2026-10-11") =
        EntryRecord(id, habit, null, day, 1.0, System.currentTimeMillis(), "Europe/London", null, null, "today")

    private suspend fun settle(devices: List<Device>) {
        repeat(10) {
            for (d in devices) {
                val s = d.syncNow()
                if (s.state == DriveState.HELD) d.sync.applyHeldDeletes()
                if (s.state == DriveState.DELETES_WAITING) d.sync.sendWaitingDeletes()
            }
            if (devices.all { it.repo.cloud.counts().waitingOps == 0 }) {
                devices.forEach { it.syncNow() }
                return
            }
        }
        failures += "never settled"
    }

    private suspend fun same(devices: List<Device>, what: String) {
        val first = devices.first().records()
        check(devices.all { it.records() == first }, "$what: all ${devices.size} devices hold the same ${first.size} records")
    }

    private suspend fun timed(what: String, block: suspend () -> Unit) {
        val t = System.nanoTime()
        block()
        println("  time: $what ${(System.nanoTime() - t) / 1_000_000} ms")
    }

    suspend fun all(): Int {
        val admin = RealDrive.drive()
        RealDrive.clean(admin)
        val (phone, tablet, mac) = listOf(Device("Pixel 8"), Device("Galaxy Tab"), Device("MacBook"))
        val devices = listOf(phone, tablet, mac)
        devices.forEach { it.connect() }

        println("SCENARIO 1: a habit and logs on the phone reach the others")
        phone.repo.saveHabit(habit("water"), emptyList(), emptyList(), System.currentTimeMillis())
        repeat(3) { phone.repo.addEntry(entry("p$it", "water")) }
        timed("the phone's first save") { phone.syncNow() }
        timed("the tablet's first download") { tablet.syncNow() }
        mac.syncNow()
        check(tablet.logs("water") == 3 && mac.logs("water") == 3, "3 logs everywhere")
        same(devices, "scenario 1")
        RealDrive.show(admin, "after scenario 1")

        println("SCENARIO 2: the phone offline logs 2, the tablet logs 1")
        phone.drive.offline = true
        phone.repo.addEntry(entry("off1", "water")); phone.repo.addEntry(entry("off2", "water"))
        check(phone.syncNow().state == DriveState.OFFLINE, "the phone says offline, 2 waiting")
        tablet.repo.addEntry(entry("t1", "water"))
        tablet.syncNow()
        phone.drive.offline = false
        settle(devices)
        check(devices.all { it.logs("water") == 6 }, "3 + 2 + 1 = 6 logs everywhere")
        same(devices, "scenario 2")

        println("SCENARIO 3: all three save at the same moment (repeated 10 times)")
        var conflicts = 0
        repeat(10) { r ->
            devices.forEachIndexed { i, d -> d.repo.addEntry(entry("race$r-$i", "water")) }
            val before = devices.sumOf { it.drive.conflicts }
            coroutineScope { devices.map { d -> async(Dispatchers.IO) { d.syncNow() } }.awaitAll() }
            conflicts += devices.sumOf { it.drive.conflicts } - before
            settle(devices)
        }
        println("  409s met and handled: $conflicts")
        check(devices.all { it.logs("water") == 36 }, "every log of every race kept (36)")
        same(devices, "scenario 3")
        RealDrive.show(admin, "after the races")

        println("SCENARIO 4: an upload cut off before, then after, Drive kept it")
        phone.repo.addEntry(entry("cut1", "water"))
        phone.drive.cutBefore = 1
        phone.syncNow()
        check(phone.repo.cloud.counts().waitingOps == 1, "cut before: the log still waits")
        phone.repo.addEntry(entry("cut2", "water"))
        phone.drive.cutAfter = 1
        phone.syncNow()
        check(phone.repo.cloud.counts().waitingOps == 2, "cut after: not confirmed, both still wait")
        settle(devices)
        check(devices.all { it.logs("water") == 38 }, "each saved once (38)")
        same(devices, "scenario 4")

        println("SCENARIO 5: the Mac is reinstalled")
        mac.reinstall()
        val created = mac.drive.calls["create"] ?: 0
        timed("the reinstalled Mac's download") { mac.syncNow(allowUpload = false) }
        check((mac.drive.calls["create"] ?: 0) == created, "nothing sent before its welcome is finished")
        check(mac.logs("water") == 38, "everything came back")
        settle(devices)
        same(devices, "scenario 5")

        println("SCENARIO 6: logs in two years, and many deletes at once (the brake)")
        phone.repo.addEntry(entry("old", "water", day = "2025-12-31"))
        repeat(40) { tablet.repo.addEntry(entry("bulk$it", "water")) }
        settle(devices)
        repeat(40) { tablet.repo.removeEntry("bulk$it", System.currentTimeMillis()) }
        check(tablet.syncNow().state == DriveState.DELETES_WAITING, "40 deletes at once wait on the tablet")
        tablet.sync.sendWaitingDeletes()
        val held = phone.syncNow()
        check(held.state == DriveState.HELD && held.heldDeletes == 40, "the phone holds them (${held.state}, ${held.heldDeletes})")
        phone.sync.applyHeldDeletes()
        settle(devices)
        check(devices.all { it.logs("water") == 39 }, "38 + the old one, the 40 deleted")
        same(devices, "scenario 6")
        RealDrive.show(admin, "after two years and the brake")

        println("SCENARIO 7: six devices on one file at once")
        val many = devices + List(3) { Device("Extra $it").also { it.connect() } }
        many.drop(3).forEach { it.syncNow() }
        many.forEachIndexed { i, d -> d.repo.addEntry(entry("many-$i", "water")) }
        val before = many.sumOf { it.drive.conflicts }
        coroutineScope { many.map { d -> async(Dispatchers.IO) { d.syncNow() } }.awaitAll() }
        println("  409s: ${many.sumOf { it.drive.conflicts } - before}")
        settle(many)
        check(many.all { it.logs("water") == 45 }, "all six logs kept (45)")
        same(many, "scenario 7")

        println("COST: an idle round")
        val idle = tablet.drive.total()
        val t = System.nanoTime()
        tablet.syncNow()
        println("  idle round: ${tablet.drive.total() - idle} call(s), ${(System.nanoTime() - t) / 1_000_000} ms")
        println("  calls per device: " + many.joinToString { "${it.name} ${it.drive.calls}" })
        RealDrive.show(admin, "at the end")
        RealDrive.clean(admin)
        println(if (failures.isEmpty()) "ROUNDS: all checks passed" else "ROUNDS: ${failures.size} FAILED: $failures")
        return if (failures.isEmpty()) 0 else 1
    }
}
