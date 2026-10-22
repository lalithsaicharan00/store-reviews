package com.oftenenough.app

import android.content.Intent
import android.net.Uri
import androidx.test.core.app.ActivityScenario
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.platform.app.InstrumentationRegistry
import app.habits.core.RestoreMode
import com.oftenenough.app.app.AppGraph
import com.oftenenough.app.app.MainActivity
import com.oftenenough.app.app.TestLaunch
import java.io.File
import kotlinx.coroutines.runBlocking
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNotNull
import org.junit.Assert.assertNull
import org.junit.Assert.assertTrue
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith

/**
 * People's data is never lost (Rulebook D): a backup file comes back whole, a restore can be undone, Merge doubles
 * nothing, an empty file is never passed off as a restore (D5), and what a run of taps showed is what was saved, in
 * order (S7). On the emulator, against the real database code; a test launch's own in-memory data (D8).
 */
@RunWith(AndroidJUnit4::class)
class DataSafetyTest {
    private var scenario: ActivityScenario<MainActivity>? = null
    private val store get() = AppGraph.store
    private val backup get() = AppGraph.backup
    private val context get() = ApplicationProvider.getApplicationContext<android.content.Context>()

    @Before fun launch() {
        scenario = ActivityScenario.launch(Intent(context, MainActivity::class.java)
            .putExtra(TestLaunch.UITEST, true).putExtra(TestLaunch.CLOCK_HOUR, 10).putExtra(TestLaunch.DEMO, "today"))
        val end = System.currentTimeMillis() + 15_000
        while (System.currentTimeMillis() < end && onMain { !store.isLoaded || store.habits.none { it.name == "Water" } }) Thread.sleep(50)
        runBlocking { store.flush() }
    }

    @After fun close() { scenario?.close() }

    private fun <T> onMain(block: () -> T): T {
        var result: T? = null
        InstrumentationRegistry.getInstrumentation().runOnMainSync { result = block() }
        @Suppress("UNCHECKED_CAST") return result as T
    }

    /** Everything a person would notice: each habit with its goal and how many logs it has, and each note. */
    private fun everything(): String = onMain {
        store.habits.sortedBy { it.name }.joinToString("\n") { h ->
            "${h.name}|${h.kind}|${h.goal}|${h.frequency}|${h.parts}|${h.archived}|${store.entries(h.id).size}|" +
                store.entries(h.id).sumOf { it.value } + "|" + store.notes(h).joinToString(",") { "${it.first}:${it.second}" }
        }
    }

    private fun file(name: String) = File(context.cacheDir, name).also { it.delete() }

    @Test fun aBackupFileComesBackWholeAndTheRestoreCanBeUndone() = runBlocking {
        onMain { store.setNote("Felt good today", store.habits.first { it.name == "Water" }, store.today()) }
        store.flush()
        val before = everything()
        val habits = onMain { store.habits.size }
        assertTrue("the demo has habits", habits > 5)

        val uri = Uri.fromFile(file("round-trip.zip"))
        assertTrue("the file is written, read back and its checksum matches", backup.saveFile(uri))

        backup.eraseThisPhone()
        assertEquals(0, onMain { store.habits.size })

        val pending = backup.check(uri)
        assertNotNull("the file opens", pending)
        assertNull("the file is fine", pending!!.check.problem)
        assertEquals(habits, pending.check.preview!!.fileHabits)
        assertEquals(0, pending.check.preview!!.phoneHabits)

        val changes = backup.restore(pending, RestoreMode.REPLACE)
        assertEquals(habits, changes.habitsAdded)
        assertEquals("every habit, log and note is back exactly", before, everything())

        // Undo puts the phone back exactly as it was just before the restore: empty.
        assertTrue(backup.undoRestore())
        assertEquals(0, onMain { store.habits.size })
    }

    /**
     * **Every backup says who made it, and the Plus flag unlocks nothing** (the new Figma file's note under flow 2;
     * Rulebook D16; the user, 22 Oct 2026: "nothing unlocks a Plus on device"). A file made on a phone that had Plus
     * says so when it is read back, and reading it leaves this phone's own Plus exactly as it was.
     */
    @Test fun aBackupRecordsWhoMadeItAndItsPlusFlagUnlocksNothing() = runBlocking {
        onMain { store.isPlus = true }
        val uri = Uri.fromFile(file("made-with-plus.zip"))
        assertTrue(backup.saveFile(uri))

        // This phone has no purchase: the free plan, whatever the file says.
        onMain { store.isPlus = false }
        val preview = backup.check(uri)!!.check.preview!!
        assertTrue("the file says it was made with Plus", preview.plus)
        assertEquals("and on Android", "android", preview.platform)
        assertTrue("and names the device", preview.deviceName.isNotEmpty())

        backup.restore(backup.check(uri)!!, RestoreMode.REPLACE)
        assertFalse("restoring a Plus backup never turns Plus on", AppGraph.hasPlus)
        assertFalse("nor the store's own free-plan limit", onMain { store.isPlus })
    }

    /** A file made without Plus says so too, so the restore screens never ask for Plus when they needn't. */
    @Test fun aBackupMadeOnTheFreePlanSaysSo() = runBlocking {
        onMain { store.isPlus = false }
        val uri = Uri.fromFile(file("made-free.zip"))
        assertTrue(backup.saveFile(uri))
        assertFalse(backup.check(uri)!!.check.preview!!.plus)
    }

    /** Every file a person gets is named the one way every app opens (D5). */
    @Test fun aBackupFileIsNamedTheSameOnEveryDevice() {
        val name = backup.fileName()
        assertTrue("named \"Often Enough backup …\"; got $name", name.startsWith("Often Enough backup "))
        assertTrue("and is a zip; got $name", name.endsWith(".zip"))
    }

    @Test fun mergeBringsBackWhatIsMissingAndDoublesNothing() = runBlocking {
        val before = everything()
        val uri = Uri.fromFile(file("merge.zip"))
        assertTrue(backup.saveFile(uri))

        // Restoring a file of what's already here changes nothing, either way.
        val same = backup.check(uri)!!
        assertTrue("Merge of the same data changes nothing", same.check.preview!!.merge.changesNothing)

        // A log made since the file was saved is kept by Merge, and nothing in the file is added a second time.
        val water = onMain { store.habits.first { it.name == "Water" } }
        val day = onMain { store.today() }
        onMain { store.increment(water, day) }
        store.flush()
        val withOneMore = everything()
        backup.restore(backup.check(uri)!!, RestoreMode.MERGE)
        assertEquals("Merge keeps what's newer here and adds no copy of anything", withOneMore, everything())
        assertTrue(before != withOneMore)
    }

    @Test fun anEmptyBackupIsNeverShownAsARestore() = runBlocking {
        backup.eraseThisPhone()
        val uri = Uri.fromFile(file("empty.zip"))
        assertTrue(backup.saveFile(uri))
        val pending = backup.check(uri)!!
        // Nothing in it: the screen says so instead of "Restored" (D5).
        assertEquals(0, pending.check.preview?.fileHabits ?: 0)
        assertTrue(pending.check.problem != null || pending.check.preview!!.replace.changesNothing)
    }

    @Test fun aFileThatIsNotABackupIsRefusedAndChangesNothing() = runBlocking {
        val before = everything()
        val bad = file("not-a-backup.zip").also { it.writeText("this is not a backup") }
        val pending = backup.check(Uri.fromFile(bad))
        assertTrue("a broken file is named as one", pending == null || pending.check.problem != null)
        assertEquals(before, everything())
    }

    @Test fun whatARunOfTapsShowedIsWhatWasSaved() = runBlocking {
        val water = onMain { store.habits.first { it.name == "Water" } }
        val day = onMain { store.today() }
        val before = onMain { store.entries(water.id, day).size }
        // 40 quick taps: each shows at once (S7); every one is written, in order.
        onMain { repeat(40) { store.increment(water, day) } }
        assertEquals("every tap shows before any write finishes", before + 40, onMain { store.entries(water.id, day).size })
        store.flush()
        val shown = everything()
        // Read everything again from the database: the same.
        onMain { store.reloadAfterSync() }
        store.flush()
        assertEquals(shown, everything())
        assertEquals(before + 40, onMain { store.entries(water.id, day).size })
    }
}
