package com.oftenenough.app

import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.ui.habit.PauseLength
import com.oftenenough.app.ui.habit.pauseBack
import com.oftenenough.app.ui.habit.pauseSummary
import java.time.LocalDate
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNull
import org.junit.Test

/** Pause's lengths and the sentence said before Pause is tapped, as the iPhone's PauseSheet says them. */
class PauseWordsTest {
    private val today = LocalDate.of(2026, 10, 13).toEpochDay().toInt() // Tue 13 Oct
    private fun habit(kind: HabitKind = HabitKind.Check, name: String = "Gym") = Habit(name = name, symbol = "dumbbell", color = HabitColor.BLUE, kind = kind)

    @Test fun lengths() {
        assertEquals(today + 7, pauseBack(PauseLength.WEEK, today, 0))
        assertEquals(today + 14, pauseBack(PauseLength.TWO_WEEKS, today, 0))
        assertEquals(today + 3, pauseBack(PauseLength.DATE, today, today + 3))
        // A chosen date is never before the day after the pause starts.
        assertEquals(today + 1, pauseBack(PauseLength.DATE, today, today - 5))
        assertNull(pauseBack(PauseLength.OPEN, today, today + 3))
    }

    @Test fun oneHabit() {
        assertEquals("Gym leaves Today until Tue, 20 Oct. Your streak stays, and reminders stop.", pauseSummary(listOf(habit()), today, today + 7, today))
        assertEquals("Gym leaves Today until you turn it back on. Your streak stays, and reminders stop.", pauseSummary(listOf(habit()), today, null, today))
        assertEquals("From Thu, 15 Oct, Gym leaves Today until Thu, 22 Oct. Your streak stays, and reminders stop.",
            pauseSummary(listOf(habit()), today + 2, today + 9, today))
        assertEquals("Gym leaves Today until Tue, 20 Oct. Your streak stays, and reminders stop. Days from Sun, 11 Oct count as paused.",
            pauseSummary(listOf(habit()), today - 2, today + 7, today))
    }

    @Test fun aQuitHabitEndsItsRunAndKeepsIt() {
        assertEquals("Smoking's current run ends now and is kept as a run, not a slip. A new run starts when it comes back on Tue, 20 Oct.",
            pauseSummary(listOf(habit(HabitKind.Quit, "Smoking")), today, today + 7, today))
    }

    @Test fun severalHabits() {
        assertEquals("2 habits leave Today until you turn them back on. Streaks stay, and reminders stop. A quit habit's current run ends now and is kept; a new run starts when it's back.",
            pauseSummary(listOf(habit(), habit(HabitKind.Quit, "Smoking")), today, null, today))
    }
}
