package com.oftenenough.app

import com.oftenenough.app.data.Format
import com.oftenenough.app.data.Frequency
import com.oftenenough.app.data.GoalPeriod
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.data.HabitCopy
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.goalLine
import java.util.Locale
import org.junit.Assert.assertEquals
import org.junit.Before
import org.junit.Test

/** The iPhone's words, case for case (iOS/Habits/Model/CopyCheckCases.swift and Words.swift). */
class WordsTest {
    @Before fun english() = Locale.setDefault(Locale.US)

    private fun habit(kind: HabitKind, goal: Double = 1.0, f: Frequency = Frequency.Daily, atMost: Boolean = false, name: String = "Read") =
        Habit(name = name, symbol = "book.fill", color = HabitColor.BLUE, kind = kind, goal = goal, frequency = f, atMost = atMost)

    @Test fun numbers() {
        assertEquals("8", Format.amount(8.0))
        assertEquals("2.5", Format.amount(2.5))
        assertEquals("0.25", Format.amount(0.25))
        assertEquals("1k", Format.amount(1000.0))
        assertEquals("5.2k", Format.amount(5200.0))
        assertEquals("10,000", HabitCopy.number(10_000.0))
        assertEquals("45 min", Format.minutes(45.0))
        assertEquals("1 h", Format.minutes(60.0))
        assertEquals("1 h 25 min", Format.minutes(85.0))
        assertEquals("7:42", Format.clock(7.7))
        assertEquals("1:07:42", Format.clock(67.7))
    }

    @Test fun units() {
        assertEquals("1 glass", HabitCopy.amount(1.0, "glasses"))
        assertEquals("8 glasses", HabitCopy.amount(8.0, "glasses"))
        assertEquals("2,000 ml", HabitCopy.amount(2000.0, "ml"))
        assertEquals("$100", HabitCopy.amount(100.0, "$"))
        assertEquals("1 chapter", HabitCopy.amount(1.0, "chapters"))
        assertEquals("1 story", HabitCopy.amount(1.0, "stories"))
    }

    @Test fun days() {
        assertEquals("every day", HabitCopy.dayText((1..7).toSet(), 1))
        assertEquals("on weekdays", HabitCopy.dayText(setOf(2, 3, 4, 5, 6), 1))
        assertEquals("on weekends", HabitCopy.dayText(setOf(1, 7), 1))
        assertEquals("every day except Sunday", HabitCopy.dayText(setOf(2, 3, 4, 5, 6, 7), 1))
        assertEquals("every Sunday to Thursday", HabitCopy.dayText(setOf(1, 2, 3, 4, 5), 1))
        assertEquals("every Monday and Wednesday", HabitCopy.dayText(setOf(2, 4), 1))
        assertEquals("every Saturday to Monday", HabitCopy.dayText(setOf(7, 1, 2), 1))
        assertEquals("on the 1st and 15th of every month", HabitCopy.monthDates(setOf(1, 15)))
        assertEquals("on the last day of every month", HabitCopy.monthDates(setOf(31)))
    }

    @Test fun plans() {
        assertEquals("Read 2 chapters a week", HabitCopy.sentence(habit(HabitKind.Amount("chapters", 1.0), 2.0, Frequency.PerWeek(2)), 1))
        assertEquals("twice a day", HabitCopy.plan(habit(HabitKind.Check, 2.0), 1))
        assertEquals("3 times a week", HabitCopy.plan(habit(HabitKind.Check, 1.0, Frequency.PerWeek(3)), 1))
        assertEquals("5 km on 3 days a week", HabitCopy.plan(habit(HabitKind.Amount("km", 5.0), 5.0, Frequency.Flexible(GoalPeriod.WEEK, 3)), 1))
        // A name that only repeats the unit is left out, as on the iPhone (HabitCopy.namesUnit).
        assertEquals("At most 3 coffees a day", HabitCopy.sentence(habit(HabitKind.Amount("coffees", 1.0), 3.0, atMost = true, name = "Coffee"), 1))
        assertEquals("Afternoon coffee: at most 3 coffees a day", HabitCopy.sentence(habit(HabitKind.Amount("coffees", 1.0), 3.0, atMost = true, name = "Afternoon coffee"), 1))
        assertEquals("100 push-ups a day", HabitCopy.sentence(habit(HabitKind.Amount("push-ups", 10.0), 100.0, name = "Push-ups"), 1).replaceFirstChar { it.lowercase() })
    }

    @Test fun rowLines() {
        assertEquals("3/8 glasses", goalLine(habit(HabitKind.Amount("glasses", 1.0), 8.0), 3.0, 8.0))
        assertEquals("12 min/20 min", goalLine(habit(HabitKind.Duration, 20.0), 12.4, 20.0))
        assertEquals("7:42/20 min", goalLine(habit(HabitKind.Duration, 20.0), 7.7, 20.0, running = true))
        assertEquals("1/2 cups max", goalLine(habit(HabitKind.Amount("cups", 1.0), 2.0, atMost = true), 1.0, 2.0))
        assertEquals("2/3 this week", goalLine(habit(HabitKind.Check, 1.0, Frequency.PerWeek(3)), 2.0, 3.0))
        assertEquals("1/3 times", goalLine(habit(HabitKind.Check, 3.0), 1.0, 3.0))
        assertEquals("1/4 steps", goalLine(habit(HabitKind.Checklist, 1.0), 1.0, 4.0))
    }
}
