package com.oftenenough.app

import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.ReminderTime
import com.oftenenough.app.ui.settings.hasReminders
import com.oftenenough.app.ui.settings.keepLead
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
        assertEquals(listOf("Set battery to Unrestricted"), maker("samsung").steps.map { it.title })
        assertEquals(listOf("Set battery to Unrestricted", "Turn on Autostart"), maker("redmi").steps.map { it.title })
        // HyperOS 2 has no Autostart in App info: the line names the list Open settings opens (Xiaomi 14, 3 Nov 2026).
        assertEquals("Background autostart › Often Enough", maker("redmi").steps.last().path)
        assertEquals(listOf("Set battery to Unrestricted", "Allow background activity", "Allow auto launch"), maker("OnePlus").steps.map { it.title })
        assertEquals(listOf("Set battery to Unrestricted", "Allow high background power use", "Turn on Autostart"), maker("iQOO").steps.map { it.title })
        assertEquals(listOf("Set battery to Unrestricted", "Manage App launch yourself, all three on"), maker("HONOR").steps.map { it.title })
        assertEquals(listOf("Set battery to Unrestricted"), maker("Google").steps.map { it.title })
        // A109: only Unrestricted can be read, so only it can be shown done.
        for (name in listOf("samsung", "redmi", "OnePlus", "iQOO", "HONOR", "Google"))
            assertEquals(listOf("Set battery to Unrestricted"), maker(name).steps.filter { it.checked != null }.map { it.title })
    }

    /** The lead says what's left (Figma's Today, flows 38 and 39; A109: only steps the app can read count). */
    @Test fun leadFollowsWhatsLeft() {
        val samsung = maker("samsung")
        val xiaomi = maker("xiaomi")
        assertEquals(samsung.lead, keepLead(samsung, notifications = true, exact = true, stepsLeft = 1))
        assertEquals("All set. Reminders will come on time.", keepLead(samsung, true, true, 0))
        assertEquals("Battery is Unrestricted. Also do the step below, if you haven’t: your phone doesn’t let the app check it.", keepLead(xiaomi, true, true, 0))
        assertEquals("All set. Reminders will come on time.", keepLead(maker("Google"), true, true, 0))
        assertEquals("Reminders may come late. Android sends them on time only when Alarms & reminders is allowed. It’s Android’s setting, not the app’s.",
            keepLead(maker("Google"), true, exact = false, stepsLeft = 0))
    }
}
