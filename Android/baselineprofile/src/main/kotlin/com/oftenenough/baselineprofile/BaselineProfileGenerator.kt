package com.oftenenough.baselineprofile

import android.content.Intent
import androidx.benchmark.macro.junit4.BaselineProfileRule
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.uiautomator.By
import androidx.test.uiautomator.Direction
import androidx.test.uiautomator.UiDevice
import androidx.test.uiautomator.Until
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

/**
 * Walks what people do most, on a test launch's demo (D8: an in-memory database), so that code is compiled ahead of time
 * on install: opening the app, Today and its Day details, a day back and forward, the menu, Habits & Tasks, a habit's
 * page, New habit and its pages, Settings, the routine player. A step that can't be found is left out, never a failure:
 * a shorter walk only makes a smaller profile.
 */
@RunWith(AndroidJUnit4::class)
class BaselineProfileGenerator {
    @get:Rule val rule = BaselineProfileRule()

    @Test fun generate() = rule.collect(packageName = "com.oftenenough.app", includeInStartupProfile = true) {
        pressHome()
        startActivityAndWait(Intent().apply {
            setClassName("com.oftenenough.app", "com.oftenenough.app.app.MainActivity")
            putExtra("uitest", true)
            putExtra("clockHour", 10)
            putExtra("demo", "design")
            putExtra("plus", true)
        })
        val walk = Walk(device)
        walk.today()
        walk.habits()
        walk.newHabit()
        walk.settings()
        walk.routine()
    }

    private class Walk(private val device: UiDevice) {
        private fun settle() { device.waitForIdle(1_500); Thread.sleep(500) }
        private fun tag(name: String) = device.wait(Until.findObject(By.res(name)), 4_000)
        private fun tap(name: String): Boolean {
            val found = tag(name) ?: return false
            found.click(); settle()
            return true
        }
        private fun tapText(text: String): Boolean {
            val found = device.wait(Until.findObject(By.text(text)), 4_000) ?: return false
            found.click(); settle()
            return true
        }
        private fun openMenuAndPick(item: String): Boolean {
            val menu = device.wait(Until.findObject(By.desc("Menu")), 4_000) ?: return false
            menu.click(); settle()
            return tap("menu-$item")
        }
        private fun scroll(name: String) {
            repeat(2) { device.findObject(By.res(name))?.fling(Direction.DOWN); Thread.sleep(600) }
            repeat(2) { device.findObject(By.res(name))?.fling(Direction.UP); Thread.sleep(600) }
        }
        private fun back() { device.pressBack(); settle() }

        fun today() {
            tag("today-list")
            scroll("today-list")
            if (tap("row-Meds")) { tag("day-details"); tap("day-close") }
            tap("day-previous"); tap("day-previous"); tap("day-next"); tap("day-next")
            device.findObject(By.desc("Fold Morning"))?.click(); settle()
            device.findObject(By.desc("Open Morning"))?.click(); settle()
        }

        fun habits() {
            if (!openMenuAndPick("habits")) return
            scroll("habits-list")
            tap("habits-range-1"); scroll("habits-list")
            tap("habits-range-2"); scroll("habits-list")
            tap("habits-range-0")
            tap("habits-tab-tasks"); tap("habits-tab-habits")
            device.findObject(By.res("habits-list"))?.fling(Direction.UP); settle()
            if (tapText("Meds")) {
                tag("habit-details-list")
                scroll("habit-details-list")
                tap("habit-tab-history")
                scroll("habit-details-list")
                back()
            }
            openMenuAndPick("today")
        }

        fun newHabit() {
            if (!tap("new-habit")) return
            tapText("Build or maintain")
            tapText("Track an amount")
            device.pressBack(); settle() // the keyboard
            tapText("How often"); back()
            tapText("Reminders"); back()
            back(); tap("discard")
            repeat(2) { if (device.hasObject(By.res("today-list"))) return@repeat; back() }
        }

        fun settings() {
            if (!openMenuAndPick("settings")) return
            device.findObject(By.res("settings-list"))?.fling(Direction.DOWN); settle()
            device.findObject(By.res("settings-list"))?.fling(Direction.UP); settle()
            if (tapText("Theme")) back()
            openMenuAndPick("today")
        }

        fun routine() {
            val start = device.wait(Until.findObject(By.desc("Start Morning")), 4_000) ?: return
            start.click(); settle()
            tag("routine-player")
            val x = device.displayWidth
            val y = device.displayHeight / 2
            repeat(2) { device.swipe(x * 8 / 10, y, x * 2 / 10, y, 20); settle() }
            back()
        }
    }
}
