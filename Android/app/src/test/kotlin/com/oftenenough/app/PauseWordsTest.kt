package com.oftenenough.app

import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.ui.habit.PauseLength
import com.oftenenough.app.ui.habit.pauseBack
import com.oftenenough.app.ui.habit.pauseSheetWords
import java.time.LocalDate
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNull
import org.junit.Test

/** Pause's lengths and the sentence the sheet says before Pause is tapped (Figma 2.3, Day details flow 36). */
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
        assertEquals("While Gym is paused, it's off Today and sends no reminders. Paused days never break a streak.",
            pauseSheetWords(listOf(habit())))
    }

    @Test fun aQuitHabitSaysWhatHappensToItsRun() {
        assertEquals("Pausing ends your current run of 19 days. It stays in your history, and a new run starts when you resume. " +
            "While it's paused, Smoking is off Today.",
            pauseSheetWords(listOf(habit(HabitKind.Quit, "Smoking")), 19))
    }

    @Test fun severalHabits() {
        assertEquals("While they're paused, Gym and Read are off Today and send no reminders. Paused days never break a streak.",
            pauseSheetWords(listOf(habit(), habit(name = "Read"))))
    }
}
