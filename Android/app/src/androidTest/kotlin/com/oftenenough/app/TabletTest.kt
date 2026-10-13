package com.oftenenough.app

import android.content.Intent
import androidx.test.core.app.ActivityScenario
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.platform.app.InstrumentationRegistry
import androidx.test.uiautomator.By
import androidx.test.uiautomator.UiDevice
import androidx.test.uiautomator.Until
import com.oftenenough.app.app.MainActivity
import com.oftenenough.app.app.TestLaunch
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNotNull
import org.junit.Assert.assertTrue
import org.junit.Assert.fail
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith

/**
 * Tablets and unfolded foldables (A11 D9; the iPad's decisions): from 840 dp wide the menu is a sidebar that stays, with
 * how many are left beside Today, and the page beside it is the phone's own column, centred. The test gives the
 * emulator a tablet's display (1280 × 800 dp) for its own run and always puts it back (T20: checked on a real size, not
 * by arithmetic). The phone's layout is every other test.
 */
@RunWith(AndroidJUnit4::class)
class TabletTest {
    private val device: UiDevice = UiDevice.getInstance(InstrumentationRegistry.getInstrumentation())
    private var scenario: ActivityScenario<MainActivity>? = null

    @Before fun tabletDisplay() {
        device.executeShellCommand("wm size 2560x1600")
        device.executeShellCommand("wm density 320")
        Thread.sleep(2_000)
        TestDevice.clear()
        scenario = ActivityScenario.launch(Intent(ApplicationProvider.getApplicationContext(), MainActivity::class.java)
            .putExtra(TestLaunch.UITEST, true).putExtra(TestLaunch.CLOCK_HOUR, 10).putExtra(TestLaunch.DEMO, "today"))
        if (!device.wait(Until.hasObject(By.res("row-Read")), 30_000)) fail("the demo on Today; ${TestDevice.state()}")
    }

    @After fun phoneDisplay() {
        scenario?.close()
        device.executeShellCommand("wm size reset")
        device.executeShellCommand("wm density reset")
        Thread.sleep(1_000)
    }

    /** What's on screen, on one line (T14). */
    private fun screen(): String = runCatching {
        // A row can go while it's being read (the quit clocks tick): skip it.
        device.findObjects(By.pkg("com.oftenenough.app")).mapNotNull { o -> runCatching { o.text ?: o.contentDescription }.getOrNull() }
            .filter { it.isNotBlank() }.distinct().joinToString(" | ").take(1500)
    }.getOrDefault("(couldn't read the screen)")

    private fun waitFor(tag: String) = assertTrue("Waited for $tag; on screen: ${screen()}", device.wait(Until.hasObject(By.res(tag)), 15_000))

    @Test fun theMenuIsASidebarWithWhatIsLeftBesideToday() {
        waitFor("menu-sidebar")
        // No menu button: there's nothing to open.
        assertFalse("a menu button beside a sidebar; on screen: ${screen()}", device.hasObject(By.res("menu-button")))
        val today = device.findObject(By.res("menu-today"))
        assertNotNull(today)
        assertTrue("Today says how many are left; it says: ${today.children.mapNotNull { it.text }}", today.findObject(By.textContains("left")) != null)
        // Today's column is the phone's, centred beside the sidebar: never stretched across the screen.
        val list = device.findObject(By.res("today-list")).visibleBounds
        val sidebar = device.findObject(By.res("menu-sidebar")).visibleBounds
        val density = 320 / 160f
        assertTrue("Today's column is ${list.width() / density} dp wide", list.width() / density <= 721)
        assertTrue("the column starts after the sidebar", list.left >= sidebar.right)
    }

    @Test fun aSidebarChoiceReplacesThePageAndNeverPilesUp() {
        waitFor("menu-sidebar")
        device.findObject(By.res("menu-progress")).click()
        waitFor("progress-list")
        assertTrue("the sidebar stays beside Progress", device.hasObject(By.res("menu-sidebar")))
        device.findObject(By.res("menu-habits")).click()
        waitFor("habits-list")
        assertFalse("Progress is gone from under Habits", device.hasObject(By.res("progress-list")))
        // One step back is Today, however many pages were chosen.
        device.pressBack()
        waitFor("today-list")
        assertEquals(true, device.hasObject(By.res("row-Read")))
    }

    @Test fun dayDetailsOpensOverTheColumn() {
        device.findObject(By.res("row-Read")).click()
        waitFor("day-details")
        // A sheet at its own width in the middle, not stretched across a tablet (Material's 640 dp).
        val sheet = device.findObject(By.res("day-details")).visibleBounds
        assertTrue("Day details is ${sheet.width() / 2f} dp wide", sheet.width() / 2f <= 641)
        device.pressBack()
        assertTrue(device.wait(Until.gone(By.res("day-details")), 10_000))
        waitFor("menu-sidebar")
    }
}
