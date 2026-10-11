package app.habits.core

import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertTrue
import kotlinx.coroutines.runBlocking

/**
 * Size and time for Google Drive sync with an extreme account (about 25,000 logs a year; 15 years when
 * `DRIVE_EXTREME_YEARS=15`, as the Drive workflow runs it): bytes per year file, the first upload, a new device's first
 * download, a save after one new log, and an ordinary round with nothing to send (it runs about once a minute).
 */
class DriveScaleTest {
    private val years = System.getenv("DRIVE_EXTREME_YEARS")?.toIntOrNull() ?: 2
    private val perYear = 25_000

    private fun ms(start: Long) = (System.nanoTime() - start) / 1_000_000

    @Test fun anExtremeAccount() = runBlocking<Unit> {
        var now = 1_790_000_000_000L
        val drive = FakeDrive()
        val phone = HabitRepository.openInMemory { now }
        val habits = List(12) { i ->
            HabitRecord("h$i", "Habit $i", "star", "blue", "amount", "glasses", 1.0, "anytime", 8.0, "day", null, "daily", null, null,
                false, null, i, 1_000, 1_000, null, null)
        }
        val firstYear = 2027 - years
        val entries = (0 until years).flatMap { y ->
            List(perYear) { i ->
                val day = "${firstYear + y}-${(i % 12 + 1).toString().padStart(2, '0')}-${(i % 28 + 1).toString().padStart(2, '0')}"
                EntryRecord("e$y-$i", "h${i % 12}", null, day, 1.0, now - i, "Europe/London", null, null, "today")
            }
        }
        var t = System.nanoTime()
        phone.importAll(Snapshot(habits, emptyList(), emptyList(), entries, emptyList()))
        println("drive scale: ${entries.size} logs over $years years imported in ${ms(t)} ms")

        val phoneSync = DriveSync(phone, drive.client("phone"), "Pixel 8", "android", clock = { now }, pause = {})
        t = System.nanoTime()
        phoneSync.connect("gdrive:extreme")
        println("drive scale: connect (every row queued) ${ms(t)} ms")
        t = System.nanoTime()
        val first = phoneSync.syncNow()
        val firstMs = ms(t)
        assertEquals(DriveState.SYNCED, first.state, first.problem ?: "")
        assertEquals(0, first.waiting)
        val sizes = drive.versions().associate { it.properties.getValue("chain") to it.size }
        println("drive scale: first upload of ${sizes.size} files, ${drive.totalBytes() / 1024} KB in all, in $firstMs ms")
        println("drive scale: bytes per file: " + sizes.toSortedMap().entries.joinToString { "${it.key} ${it.value / 1024} KB" })

        // A new phone: downloads and merges everything.
        val fresh = HabitRepository.openInMemory { now }
        val freshSync = DriveSync(fresh, drive.client("fresh"), "Pixel 9", "android", clock = { now }, pause = {})
        freshSync.connect("gdrive:extreme")
        t = System.nanoTime()
        val came = freshSync.syncNow(allowUpload = false)
        println("drive scale: a new device's first download and merge: ${ms(t)} ms (${came.state})")
        assertEquals(entries.size, fresh.load().entries.size)

        // One more log: only this year's file is saved again.
        now += 60_000
        phone.addEntry(EntryRecord("one-more", "h0", null, "2026-10-11", 1.0, now, "Europe/London", null, null, "today"))
        val calls = drive.calls
        t = System.nanoTime()
        phoneSync.syncNow()
        println("drive scale: a save after one new log: ${ms(t)} ms, ${drive.calls - calls} calls, ${drive.versions("2026").maxOf { it.size } / 1024} KB sent")

        // The other device takes it in.
        t = System.nanoTime()
        freshSync.syncNow()
        println("drive scale: the other device takes in this year's file: ${ms(t)} ms")

        // Nothing to do: the round that runs about once a minute.
        now += 60_000
        val idleCalls = drive.calls
        t = System.nanoTime()
        val idle = freshSync.syncNow()
        val idleMs = ms(t)
        println("drive scale: an idle round: $idleMs ms, ${drive.calls - idleCalls} call(s)")
        assertEquals(DriveState.SYNCED, idle.state)
        assertEquals(1, drive.calls - idleCalls)
        assertTrue(idleMs < 1_000, "an idle round stays cheap ($idleMs ms)")
        phone.close(); fresh.close()
    }
}
