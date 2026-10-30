package com.oftenenough.app

import android.content.Intent
import android.os.Handler
import android.os.Looper
import android.util.Log
import android.view.FrameMetrics
import androidx.metrics.performance.JankStats
import androidx.test.core.app.ActivityScenario
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.platform.app.InstrumentationRegistry
import androidx.test.uiautomator.By
import androidx.test.uiautomator.Direction
import androidx.test.uiautomator.UiDevice
import androidx.test.uiautomator.Until
import com.oftenenough.app.app.AppGraph
import com.oftenenough.app.app.MainActivity
import com.oftenenough.app.app.TestLaunch
import java.io.File
import org.junit.After
import org.junit.Assert.assertTrue
import org.junit.Assert.fail
import org.junit.Test
import org.junit.runner.RunWith

/**
 * Speed, measured, never judged by eye (Rulebook S2): the frames Android itself drew (JankStats and FrameMetrics) while
 * each screen is scrolled or tapped by real system touches (UI Automator), with 30 habits and two years of history,
 * beside a control (the static Settings page scrolled the same way in the same run).
 *
 * No Compose test rule here: it drives frames and touches from the test's own clock, and every frame then carried
 * 100–250 ms of waiting that wasn't the app's (found 13 Oct 2026: frames with 0 ms of layout and 10 ms of draw read as
 * 200 ms). The numbers go to the log ("Speed: …") and to files/speed.txt. An emulator isn't a phone: the phone has the
 * final word (T5).
 */
@RunWith(AndroidJUnit4::class)
class SpeedTest {
    private var scenario: ActivityScenario<MainActivity>? = null
    private val device: UiDevice = UiDevice.getInstance(InstrumentationRegistry.getInstrumentation())
    private val frames = ArrayList<Long>()
    private val work = ArrayList<Double>()
    @Volatile private var recording = false
    private val results = ArrayList<String>()

    @After fun close() { scenario?.close() }

    private fun waitFor(tag: String, timeout: Long = 90_000) {
        if (!device.wait(Until.hasObject(By.res(tag)), timeout)) fail("Waited for $tag; ${TestDevice.state()}")
    }

    private fun tap(tag: String) { waitFor(tag); device.findObject(By.res(tag)).click() }
    /** Opens the menu and waits for it to stop sliding before tapping an item (a tap on a moving row lands elsewhere). */
    private fun menu(item: String) { tap("menu-button"); waitFor("menu-$item"); settle(); tap("menu-$item") }
    private fun settle() { device.waitForIdle(2_000); Thread.sleep(400) }

    class Stats(val name: String, val ms: List<Double>, val work: List<Double>) {
        private fun at(list: List<Double>, share: Double) = if (list.isEmpty()) 0.0 else list[((list.size - 1) * share).toInt()]
        val max get() = ms.lastOrNull() ?: 0.0
        val workMax get() = work.lastOrNull() ?: 0.0
        fun line() = "Speed: %-26s frames %4d  p50 %5.1f  p95 %5.1f  max %6.1f ms  >=32 ms %3d  >=100 ms %2d   app's own work: p95 %5.1f  max %6.1f ms"
            .format(name, ms.size, at(ms, 0.5), at(ms, 0.95), max, ms.count { it >= 32 }, ms.count { it >= 100 }, at(work, 0.95), workMax)
    }

    /** Records the frames drawn while [action] runs, and reports them under [name]. */
    private fun measure(name: String, action: () -> Unit): Stats {
        settle()
        synchronized(frames) { frames.clear(); work.clear() }
        recording = true
        action()
        settle()
        // A frame is reported after it ends: long enough for a slow one to arrive (a 709 ms frame was missed at 400 ms).
        Thread.sleep(1_200)
        recording = false
        val stats = synchronized(frames) { Stats(name, frames.map { it / 1_000_000.0 }.sorted(), work.sorted()) }
        results += stats.line()
        Log.i("Speed", stats.line())
        return stats
    }

    private fun scroll(tag: String, times: Int = 3) {
        repeat(times) { device.findObject(By.res(tag))?.scroll(Direction.DOWN, 0.8f, 6_000) }
        repeat(times) { device.findObject(By.res(tag))?.scroll(Direction.UP, 0.8f, 6_000) }
    }

    @Test fun twoYearsOfHistoryStaySmooth() {
        TestDevice.clear()
        scenario = ActivityScenario.launch(Intent(ApplicationProvider.getApplicationContext(), MainActivity::class.java)
            .putExtra(TestLaunch.UITEST, true).putExtra(TestLaunch.CLOCK_HOUR, 10).putExtra(TestLaunch.DEMO, "many"))
        scenario!!.onActivity { activity ->
            JankStats.createAndTrack(activity.window) { frame -> if (recording) synchronized(frames) { frames += frame.frameDurationUiNanos } }
            // The app's own share of each frame: input, animation, layout and measure, and draw (not the wait before it).
            activity.window.addOnFrameMetricsAvailableListener({ _, m, _ ->
                if (recording) synchronized(frames) {
                    work += (m.getMetric(FrameMetrics.INPUT_HANDLING_DURATION) + m.getMetric(FrameMetrics.ANIMATION_DURATION) +
                        m.getMetric(FrameMetrics.LAYOUT_MEASURE_DURATION) + m.getMetric(FrameMetrics.DRAW_DURATION)) / 1_000_000.0
                }
            }, Handler(Looper.getMainLooper()))
        }
        waitFor("row-Read")
        val sizes = "Speed: ${AppGraph.store.habits.size} habits, ${AppGraph.store.entryCount} logs"
        Log.i("Speed", sizes); results += sizes

        // The control: a static page scrolled the same way in the same run (S2).
        menu("settings"); waitFor("settings-list")
        val control = measure("control: Settings scroll") { scroll("settings-list") }
        device.pressBack(); device.wait(Until.gone(By.res("settings-list")), 10_000); waitFor("today-list")

        val today = measure("Today scroll") { scroll("today-list") }
        val day = measure("open Day details") { tap("row-Read"); waitFor("day-details") }
        // Today is behind the sheet all along: wait for the sheet itself to go before the next tap.
        device.pressBack(); device.wait(Until.gone(By.res("day-details")), 10_000); settle()

        // Progress is the Habits tab (A54): Week, then Week to Year, then Year; back on Week for the habit's own page.
        menu("habits"); waitFor("habits-list")
        val week = measure("Habits Week scroll") { scroll("habits-list") }
        val toYear = measure("Habits: Week to Year") { tap("habits-range-2") }
        val year = measure("Habits Year scroll") { scroll("habits-list") }
        tap("habits-range-0"); settle()
        val open = measure("open Habit details") { tap("habits-row-Water"); waitFor("habit-details") }
        val history = measure("Habit History scroll") { scroll("habit-details-list") }
        tap("habit-tab-progress")
        val habitProgress = measure("Habit Progress scroll") { scroll("habit-details-list") }

        val all = listOf(control, today, day, week, toYear, year, open, history, habitProgress)
        val text = results.joinToString("\n")
        File(ApplicationProvider.getApplicationContext<android.content.Context>().getExternalFilesDir(null), "speed.txt").writeText(text)
        // Every scenario drew frames (the probe saw the moment it measures, T12), and nothing froze for a second.
        for (s in all) assertTrue("${s.name} drew no frames", s.ms.isNotEmpty())
        assertTrue("a frame took over a second:\n$text", all.all { it.max < 1_000 })
    }
}
