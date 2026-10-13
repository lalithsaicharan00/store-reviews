package com.oftenenough.app

import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.ReminderTime
import com.oftenenough.app.ui.settings.hasReminders
import com.oftenenough.app.ui.settings.missedReason
import com.oftenenough.app.ui.settings.reminderLine
import java.util.Locale
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Before
import org.junit.Test

/** ≡ › Reminders' lines, as the Android design shows them (§15). */
class ReminderWordsTest {
    @Before fun english() = Locale.setDefault(Locale.US)

    private fun habit(times: List<Pair<Int, Int>>, alert: String = "notification", again: Int? = null, remind: Boolean = true) =
        Habit(name = "Water", symbol = "drop.fill", color = HabitColor.BLUE, kind = HabitKind.Check,
            reminders = times.map { (h, m) -> ReminderTime(hour = h, minute = m) }, alert = alert, followUpMinutes = again, remind = remind)

    @Test fun lines() {
        assertEquals("8:00 AM · 2:00 PM · Notification", reminderLine(habit(listOf(14 to 0, 8 to 0))))
        assertEquals("8:00 AM · Alarm · Again every 15 min", reminderLine(habit(listOf(8 to 0), "alarm", 15)))
    }

    @Test fun whoHasReminders() {
        assertTrue(hasReminders(habit(listOf(8 to 0))))
        assertFalse(hasReminders(habit(emptyList())))
        assertFalse(hasReminders(habit(listOf(8 to 0), remind = false)))
    }

    @Test fun reasonsByMaker() {
        assertTrue(missedReason("samsung").startsWith("Samsung phones put apps to sleep"))
        assertTrue(missedReason("Xiaomi").startsWith("Xiaomi phones"))
        assertTrue(missedReason("Google").startsWith("This phone stopped Often Enough"))
    }
}
