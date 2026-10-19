package com.oftenenough.app

import com.oftenenough.app.data.DayWords
import com.oftenenough.app.data.Frequency
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.ReminderTime
import com.oftenenough.app.data.Step
import com.oftenenough.app.data.habitPlanLine
import java.util.Locale
import org.junit.Assert.assertEquals
import org.junit.Before
import org.junit.Test

/** The Habits page's line under each name (Figma 2106:2, frame 1.7): goal, then How often, then the first reminder. */
class HabitListWordsTest {
    @Before fun english() { Locale.setDefault(Locale.US); DayWords.is24Hour = false }

    private fun h(kind: HabitKind, goal: Double = 1.0, frequency: Frequency = Frequency.Daily, atMost: Boolean = false, reminder: Int? = null, steps: Int = 0) =
        Habit(name = "x", symbol = "star.fill", color = HabitColor.BLUE, kind = kind, goal = goal, frequency = frequency, atMost = atMost,
            steps = (1..steps).map { Step(name = "s$it") }, reminders = listOfNotNull(reminder?.let { ReminderTime(hour = it / 60, minute = it % 60) }),
            remind = reminder != null)

    private fun line(habit: Habit) = habitPlanLine(habit, weekStart = 1)

    @Test fun everyKindOfRow() {
        assertEquals("Every day · 8:00 AM", line(h(HabitKind.Check, reminder = 8 * 60)))
        assertEquals("8 glasses · Every day", line(h(HabitKind.Amount("glasses", 1.0), 8.0)))
        assertEquals("20 min · Every day", line(h(HabitKind.Duration, 20.0)))
        assertEquals("1 hour · Mon, Wed, Fri", line(h(HabitKind.Duration, 60.0, Frequency.Weekdays(setOf(2, 4, 6)))))
        assertEquals("4 steps · Every day", line(h(HabitKind.Checklist, steps = 4)))
        assertEquals("5 times a day", line(h(HabitKind.Check, 5.0)))
        assertEquals("3 times a week", line(h(HabitKind.Check, 3.0, Frequency.PerWeek(3))))
        assertEquals("300 push-ups a week", line(h(HabitKind.Amount("push-ups", 20.0), 300.0, Frequency.PerWeek(1))))
        assertEquals("2 times a month", line(h(HabitKind.Check, 2.0, Frequency.PerMonth(2))))
        assertEquals("Every 3 days", line(h(HabitKind.Check, frequency = Frequency.EveryNDays(3))))
        assertEquals("Quit", line(h(HabitKind.Quit)))
        assertEquals("At most 2 cups a day", line(h(HabitKind.Amount("cups", 1.0), 2.0, atMost = true)))
        assertEquals("At most 30 min a day", line(h(HabitKind.Duration, 30.0, atMost = true)))
        assertEquals("Every day · 10:30 PM", line(h(HabitKind.Check, reminder = 22 * 60 + 30)))
    }
}
