package com.oftenenough.app

import android.content.Intent
import androidx.test.core.app.ActivityScenario
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.platform.app.InstrumentationRegistry
import com.oftenenough.app.app.AppGraph
import com.oftenenough.app.app.MainActivity
import com.oftenenough.app.app.TestLaunch
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.widgets.WidgetAction
import com.oftenenough.app.data.widgets.WidgetItem
import com.oftenenough.app.data.widgets.WidgetItems
import com.oftenenough.app.data.widgets.WidgetSnapshot
import kotlinx.coroutines.runBlocking
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNotNull
import org.junit.Assert.assertTrue
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith

/**
 * The widgets' data, against a real store on the emulator (LOCKED: widget taps): the snapshot is the app's own (U26),
 * each ✓ and + card carries the card as it will be after a tap (W3), and a tap is saved once however often it's sent
 * (W4). A test launch's own in-memory data (D8) at 10:30 (T11).
 */
@RunWith(AndroidJUnit4::class)
class WidgetDataTest {
    private var scenario: ActivityScenario<MainActivity>? = null
    private val store get() = AppGraph.store

    @Before fun launch() {
        scenario = ActivityScenario.launch(Intent(ApplicationProvider.getApplicationContext(), MainActivity::class.java)
            .putExtra(TestLaunch.UITEST, true).putExtra(TestLaunch.CLOCK_HOUR, 10).putExtra(TestLaunch.DEMO, "today"))
        val end = System.currentTimeMillis() + 15_000
        while (System.currentTimeMillis() < end && onMain { !store.isLoaded || store.habits.none { it.name == "Water" } }) Thread.sleep(50)
    }

    @After fun close() { scenario?.close() }

    private fun <T> onMain(block: () -> T): T {
        var result: T? = null
        InstrumentationRegistry.getInstrumentation().runOnMainSync { result = block() }
        @Suppress("UNCHECKED_CAST") return result as T
    }

    private fun habit(name: String): Habit = onMain { store.habits.first { it.name == name } }
    private fun snapshot(): WidgetSnapshot = onMain { WidgetItems.snapshot(store, store.clock(), sinkDone = true, timerOpensScreen = true) }
    private fun item(name: String, s: WidgetSnapshot = snapshot()): WidgetItem = s.frames[0].items.first { it.id == habit(name).id }
    private fun flush() = runBlocking { store.flush() }

    @Test fun theSnapshotAgreesWithToday() {
        val s = snapshot()
        assertEquals(7, s.frames.size)
        val water = item("Water", s)
        assertEquals("3 of 8 glasses", water.line)
        assertEquals(WidgetAction.ADD, water.action)
        assertEquals("+1", water.actionText)
        // Today's own list, in Today's order: habits never hold a task (U26).
        val habits = s.frames[0].list("habits", onMain { store.clock() })
        assertTrue(habits.isNotEmpty())
        assertTrue(habits.none { it.isTask })
        // A week goal says its week, as Today's row does.
        assertEquals("2 of 3 this week", item("Call family", s).line)
    }

    @Test fun aPlusCardCarriesFiveTapsAhead() {
        var card: WidgetItem? = item("Water")
        val lines = ArrayList<String>()
        while (card != null) { lines += card.line; card = card.after?.firstOrNull() }
        assertEquals(listOf("3 of 8 glasses", "4 of 8 glasses", "5 of 8 glasses", "6 of 8 glasses", "7 of 8 glasses", "8 of 8 glasses"), lines)
        // The card that meets the goal is the finished one: filled, and done.
        var last = item("Water"); repeat(5) { last = last.after!!.first() }
        assertTrue(last.done)
    }

    @Test fun aCheckCardCarriesItsFlippedDay() {
        val meds = item("Meds")
        assertEquals(WidgetAction.CHECK, meds.action)
        assertTrue("the demo has Meds ticked today", meds.done)
        val after = meds.after!!.first()
        assertFalse(after.done)
        assertEquals(meds.token, after.token)
    }

    @Test fun aPlusTapIsSavedOnceHoweverOftenItIsSent() {
        val water = habit("Water")
        val day = onMain { store.today() }
        val before = onMain { store.entries(water.id, day).size }
        onMain { store.saveWidgetTap(water.id, day, "add", "tap-1", store.clock()) }
        onMain { store.saveWidgetTap(water.id, day, "add", "tap-1", store.clock()) }
        onMain { store.saveWidgetTap(water.id, day, "add", "tap-2", store.clock()) }
        flush()
        assertEquals(before + 2, onMain { store.entries(water.id, day).size })
        assertEquals("5 of 8 glasses", item("Water").line)
    }

    @Test fun aCheckIsSavedAsTheStateItSetNeverAFlip() {
        val meds = habit("Meds")
        val day = onMain { store.today() }
        // Ticked already: "check" twice changes nothing; "uncheck" twice unticks once.
        onMain { store.saveWidgetTap(meds.id, day, "check", "c1", store.clock()) }
        onMain { store.saveWidgetTap(meds.id, day, "check", "c2", store.clock()) }
        assertTrue(onMain { store.isTicked(meds, day) })
        onMain { store.saveWidgetTap(meds.id, day, "uncheck", "u1", store.clock()) }
        onMain { store.saveWidgetTap(meds.id, day, "uncheck", "u2", store.clock()) }
        flush()
        assertFalse(onMain { store.isTicked(meds, day) })
        assertEquals(0, onMain { store.entries(meds.id, day).size })
    }

    @Test fun aTimerStartsAndStopsAsTheStateItSet() {
        val read = habit("Read")
        val day = onMain { store.today() }
        onMain { store.saveWidgetTap(read.id, day, "start", "s1", store.clock()) }
        onMain { store.saveWidgetTap(read.id, day, "start", "s2", store.clock()) }
        assertTrue(onMain { store.timers.containsKey(read.id) })
        assertEquals(WidgetAction.TIMER_PAUSE, item("Read").action)
        assertNotNull(item("Read").timerClock)
        onMain { store.saveWidgetTap(read.id, day, "stop", "p1", store.clock()) }
        onMain { store.saveWidgetTap(read.id, day, "stop", "p2", store.clock()) }
        flush()
        assertFalse(onMain { store.timers.containsKey(read.id) })
        assertEquals(WidgetAction.TIMER_START, item("Read").action)
    }

    @Test fun aQuitHabitsBestCountsTheRunGoingOn() {
        // Alcohol's current run is its longest: the widget says so, as Today's row does (U26).
        val alcohol = item("Alcohol")
        assertEquals("Best 47 days", alcohol.quitBestText)
        assertEquals("slip/" + habit("Alcohol").id, alcohol.route)
        assertEquals(WidgetAction.OPEN, alcohol.action)
    }

    @Test fun namesAreLeftOutWhenHidden() {
        val hidden = snapshot().withoutNames()
        assertTrue(hidden.frames.all { f -> f.items.all { it.name.isEmpty() && (it.after?.all { a -> a.name.isEmpty() } ?: true) } })
        assertTrue(hidden.choices.none { it.name == "Water" })
        // Every card, count and button stays.
        assertEquals(snapshot().frames[0].items.size, hidden.frames[0].items.size)
    }
}
