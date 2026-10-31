package com.oftenenough.app

import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.ui.habit.PauseLength
import com.oftenenough.app.ui.habit.pauseBack
import com.oftenenough.app.ui.habit.pausedWords
import java.time.LocalDate
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNull
import org.junit.Test

/** Pause's lengths and the snackbar once it's paused (Figma's Pause sheet; Today, flow 14). */
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

    @Test fun pausedSays() {
        assertEquals("Gym paused until Tue, 20 Oct", pausedWords(listOf(habit()), today + 7))
        assertEquals("Gym paused", pausedWords(listOf(habit()), null))
        assertEquals("2 habits paused until Tue, 27 Oct", pausedWords(listOf(habit(), habit(HabitKind.Quit, "Smoking")), today + 14))
    }
}
