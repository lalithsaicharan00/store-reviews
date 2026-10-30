package com.oftenenough.app

import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.ReminderTime
import com.oftenenough.app.ui.settings.hasReminders
import com.oftenenough.app.ui.settings.maker
import java.util.Locale
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Before
import org.junit.Test

/** Keep reminders coming's words (5.8.1, A40): who has reminders, and each phone maker's lead and steps. */
class ReminderWordsTest {
    @Before fun english() = Locale.setDefault(Locale.US)

    private fun habit(times: List<Pair<Int, Int>>, alert: String = "notification", again: Int? = null, remind: Boolean = true) =
        Habit(name = "Water", symbol = "drop.fill", color = HabitColor.BLUE, kind = HabitKind.Check,
            reminders = times.map { (h, m) -> ReminderTime(hour = h, minute = m) }, alert = alert, followUpMinutes = again, remind = remind)

    @Test fun whoHasReminders() {
        assertTrue(hasReminders(habit(listOf(8 to 0))))
        assertFalse(hasReminders(habit(emptyList())))
        assertFalse(hasReminders(habit(listOf(8 to 0), remind = false)))
    }

    @Test fun leadsByMaker() {
        assertTrue(maker("samsung").lead.startsWith("Samsung puts apps to sleep"))
        assertTrue(maker("Xiaomi").lead.startsWith("Xiaomi stops apps"))
        assertEquals(maker("Xiaomi").lead, maker("POCO").lead)
        assertTrue(maker("vivo").lead.startsWith("vivo stops apps"))
        assertTrue(maker("Google").lead.startsWith("Your phone can put apps to sleep"))
    }

    @Test fun stepsByMaker() {
        assertEquals(listOf("Set battery to Unrestricted", "Keep it out of sleeping apps"), maker("samsung").steps.map { it.title })
        assertEquals(listOf("Turn on Autostart", "Set Battery saver to No restrictions"), maker("redmi").steps.map { it.title })
        assertEquals(listOf("Allow background activity", "Allow auto launch"), maker("OnePlus").steps.map { it.title })
        assertEquals(listOf("Allow high background power use", "Turn on Autostart"), maker("iQOO").steps.map { it.title })
        assertEquals(listOf("Manage App launch yourself, all three on"), maker("HONOR").steps.map { it.title })
        assertEquals(listOf("Set battery to Unrestricted"), maker("Google").steps.map { it.title })
    }
}
